# Discord Stack

Discord's backend stack relies heavily on Elixir (running on the BEAM virtual machine) for its core real-time communication and chat infrastructure. Elixir's exceptional concurrency, distribution, and fault-tolerance enable Discord to handle millions of concurrent users efficiently. Engineers have highlighted that the platform's scale wouldn't be feasible without Elixir and the Erlang VM.
Rust integrates selectively for performance-critical components. Discord uses Rustler (a library bridging Elixir and Rust via Native Implemented Functions or NIFs) to accelerate specific data structures and operations. For instance, they implemented a high-performance SortedSet in Rust to manage large sorted sets in guilds, boosting speed without increasing memory usage. Rust isn't the primary language—Elixir dominates the core—but it enhances bottlenecks. Recent updates (as of 2024–2025) confirm ongoing use of Elixir, Rust, Python, TypeScript, and some C/C++ in a polyglot setup.
Other Key Parts of the Stack

Primary Languages — Elixir (real-time/chat), Rust (optimizations), Python (older/monolithic API services), Go (previously, largely replaced by Rust in some areas).
Database — Cassandra (for storing trillions of messages, scaled for high write throughput), PostgreSQL (for certain data).
Storage/Caching — Distributed systems with custom scaling.
Frontend/Client — React (with TypeScript), Electron for desktop.
Voice — Custom stack with WebRTC, Rust, and Elixir components.
Infrastructure — Microservices architecture, running on cloud providers.

Queuing Solution
Discord leverages Elixir's built-in actor model and lightweight process mailboxes for message queuing in real-time systems. The BEAM VM's native message passing handles massive concurrency without external queues for core chat. No public details confirm third-party tools like Kafka, RabbitMQ, or Redis queues—Elixir/OTP's capabilities manage this internally, similar to WhatsApp's approach.
Caching Solution
Discord employs distributed caching, likely including Redis (common in similar stacks for in-memory caching, session management, and temporary data). Details remain limited, but engineering discussions and scale requirements point to Redis or similar for distributed in-memory needs. In-memory structures from Elixir (like ETS tables) handle local caching, with custom distributed solutions for global scale.
Discord's stack prioritizes Elixir's strengths for real-time features while incorporating Rust for targeted performance gains, keeping the system lean and scalable. Information is based on public engineering blogs and talks up to 2025, as internal details are not fully disclosed.
