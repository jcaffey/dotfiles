### 1. How Feature Flags Allow API Versions to Share Code
Feature flags (also called feature toggles) are runtime configuration switches that control the behavior of code without requiring deployments or restarts. They enable a single, shared codebase to support multiple API versions by dynamically enabling or disabling features, code paths, or behaviors based on the requested version. This avoids duplicating entire codebases, reducing maintenance overhead and bugs from divergent implementations.

Here's how it works in practice:
- **Implementation**: When a request comes in, the API inspects the version indicator (e.g., from the URL path like `/v1/` or a header like `API-Version: 2`). Based on this, it sets flags that dictate which logic to execute. For example:
  - In a shared service layer, you might have code like:
    ```python
    if feature_flag('v2_new_auth_enabled', version=request_version):
        # Use new OAuth2 flow for v2
        authenticate_with_oauth2()
    else:
        # Fallback to basic auth for v1
        authenticate_with_basic()
    ```
  - Flags can be managed via tools like LaunchDarkly, Split.io, or even simple config files/databases. They often support targeting by user, version, or environment.
- **Benefits for Shared Code**:
  - **Backward Compatibility**: v1 continues using old logic via flags set to "off" for new features, while v2 enables them.
  - **Gradual Rollouts**: Test v2 features in production by flipping flags for a subset of traffic (e.g., 10% canary release).
  - **Code Reuse**: Core business logic (e.g., data processing, validations) remains shared; only version-specific divergences are flagged.
  - **Cleanup**: Once v1 is deprecated, remove the flag and old code paths during refactoring.
- **Drawbacks and Best Practices**: Flags can add complexity if overused (leading to "flag debt"), so use them sparingly for breaking changes. Combine with modular design (e.g., strategy patterns or plugins) for cleaner code. Always include automated tests that simulate different versions/flags.

This approach is common in companies like Netflix or Google, where APIs evolve rapidly without forking code.

### 2. Best Strategy for Moving from API v1 to v2 (Code Duplication, Shared Database, Multiple Databases)
No, completely duplicating the codebase for v1 and making changes only to v2 is generally **not the best strategy**. It leads to "code rot," where bugs fixed in v2 aren't backported to v1, security patches are missed, and maintenance costs double. Instead, aim for a shared codebase with strategic separation for version-specific parts. Since your APIs share the same database, that's a common setup, but handle schema changes carefully to avoid breaking v1.

#### Codebase Strategy
- **Preferred Approach: Shared Code with Abstractions**:
  - Use feature flags (as in #1) for runtime divergence.
  - Employ design patterns like the Strategy or Adapter pattern: Define interfaces for version-specific behaviors (e.g., `IVersionedSerializer`) and implement v1/v2 variants that plug into shared core logic.
  - Branch in version routers: At the entry point (e.g., in an API gateway or controller), route to versioned handlers that call shared services.
  - Versioned Endpoints in Monorepo: Keep everything in one repo, with folders like `/src/v1/` for v1-specific routes and `/src/shared/` for common logic. Tools like Git submodules or monorepos (e.g., via Bazel or Nx) help manage this.
  - If duplication is unavoidable (e.g., massive rewrites), use a "strangler pattern": Gradually replace v1 pieces with v2 equivalents in the shared code, migrating endpoints one by one.
- **When to Duplicate**: Only for short-term forks during major overhauls, then merge back. Long-term duplication is a last resort for legacy systems.

#### Database Strategies (Since They Share One Now)
Sharing a database is fine and efficient, but breaking changes (e.g., schema alterations in v2) require planning:
- **Shared Database with Schema Versioning**:
  - Use database migrations (e.g., via Alembic for SQLAlchemy or Flyway) that apply changes compatibly: Add new columns/tables without removing old ones initially.
  - Employ views or stored procedures as abstractions: v1 queries old views; v2 uses new ones.
  - Data mapping layers: In code, transform data between v1/v2 formats (e.g., v2 might denormalize for performance).
- **Strategies for Multiple Databases**:
  - **If Needed**: Separate DBs when v2 requires a fundamentally different schema (e.g., switching from relational to NoSQL) or for isolation (e.g., compliance reasons). This allows independent evolution but introduces complexity.
    - **Replication/Sync**: Use tools like AWS DMS, Debezium, or Kafka to sync data between DBs in real-time or batch.
    - **Read Replicas**: v1 reads from a replica of the main DB; v2 writes/reads from the primary with new schema.
    - **Database per Version**: Rare, but useful for microservices. Migrate data gradually via ETL jobs (e.g., Apache Airflow).
  - **Pros of Multiple DBs**: Independent scaling, easier deprecation (drop v1 DB), reduced risk of v2 changes breaking v1.
  - **Cons**: Data consistency challenges, higher costs, duplication of data.
  - **Hybrid**: Start shared, then fork DB for v2 if changes are too invasive, with a migration period.

Monitor DB usage per version (e.g., via query tags) to plan migrations. Always provide data migration scripts/guides for clients.

### 3. Handling Clusters for API v1 and v2 (Same ECS Cluster or Separate?)
Whether to host API v1 and v2 in the same Amazon ECS (Elastic Container Service) cluster or separate them depends on your scale, operational needs, and deprecation timeline. Separation is often better for long-term maintainability, especially since you want to monitor and kill v1 independently.

- **Separate ECS Clusters**:
  - **Recommended for Your Scenario**: Yes, if v1 and v2 have different resource needs, deployment cadences, or if v1's end-of-life is foreseeable (e.g., 1-2 years). This allows:
    - **Independent Monitoring**: Use AWS CloudWatch or Prometheus to track metrics (e.g., CPU, traffic, errors) per cluster/version. Easily spot v1's declining usage before decommissioning.
    - **Isolated Scaling/Deployments**: Scale v2 aggressively without affecting v1. Deploy v2 updates without risking v1 downtime.
    - **Easier Deprecation**: When v1 reaches EOL, shut down its cluster entirely—no shared resources to untangle.
    - **Security/Compliance**: Apply version-specific policies (e.g., v2 gets newer TLS configs).
  - **Implementation**: Route traffic via an API gateway (e.g., AWS API Gateway) or load balancer that directs `/v1/` to cluster A and `/v2/` to cluster B. Use ECS services/tasks per version.
  - **Drawbacks**: Higher operational overhead (more clusters to manage) and costs (though minimal at small scale).

- **Same ECS Cluster**:
  - Viable if versions are similar in behavior and you want simplicity. Run v1 and v2 as separate ECS services/tasks within one cluster.
    - **Monitoring**: Tag resources/logs by version (e.g., via ECS task definitions) for segmented metrics.
    - **Decommissioning**: Scale v1 tasks to zero and remove them, but the cluster persists for v2.
  - **Pros**: Shared resources (e.g., networking, autoscaling groups) reduce costs/setup. Easier for small teams.
  - **When to Choose**: If versions share a lot of infrastructure and v1 won't linger forever.

Hybrid: Start in the same cluster, then split if v2 grows. Use blue-green deployments for zero-downtime switches. Regardless, integrate with CI/CD (e.g., AWS CodePipeline) for version-specific pipelines.

### 4. Other Considerations for API Versioning
Versioning is indeed complex—it's about balancing innovation, stability, and user experience. Here are key additional factors:

- **Deprecation and Communication**: Set clear policies (e.g., support v1 for 12-24 months post-v2 launch). Announce via changelogs (e.g., on GitHub or a status page), emails, in-app notifications, and API response headers (e.g., `X-Deprecated: true`). Provide migration guides, tools (e.g., v1-to-v2 converters), and sunset dates.
- **Testing and Quality**: Maintain end-to-end tests for all versions. Use contract testing (e.g., Pact) to ensure v2 doesn't break client expectations. Load test separately if traffic patterns differ.
- **Performance and Scaling**: v2 might introduce inefficiencies (e.g., new features increase latency)—monitor with tools like New Relic. Cache version-specific responses if using CDNs.
- **Security**: Audit for version-specific vulnerabilities (e.g., v1 might have outdated auth). Use rate limiting per version to prevent abuse.
- **Client-Side Impact**: Encourage clients to pin versions but provide upgrade paths. Support "latest" aliases cautiously.
- **Documentation**: Use tools like Swagger/OpenAPI for versioned docs. Generate them automatically from code.
- **Cost Management**: Track infrastructure costs per version; older ones might waste resources on low traffic.
- **Team and Process**: Involve product/eng teams in versioning decisions. Adopt semantic versioning (SemVer) for clarity (e.g., major versions for breaks).
- **Alternatives to Versioning**: Design for extensibility (e.g., optional params) to minimize new versions. Consider "versionless" APIs with strict backward compatibility, like GraphQL's schema evolution.

If your setup is large-scale, look into books like "Building Evolutionary Architectures" or case studies from Stripe/GitHub for inspiration. Start small, iterate based on user feedback.
