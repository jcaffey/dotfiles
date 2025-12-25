# In Erlang (and by extension Elixir, which runs on the BEAM VM), **temporary storage** typically refers to in-memory mechanisms for holding data that doesn't need to persist across node restarts or process lifetimes. These are fast, non-persistent options suited for caching, session data, short-lived state, or performance optimizations.

### Primary Option: ETS (Erlang Term Storage)
ETS is the go-to built-in solution for efficient, temporary in-memory storage of Erlang terms (any data type).

- **Key Features**:
  - High-performance key-value store with constant-time access (O(1) for most operations; logarithmic for `ordered_set`).
  - Tables can store tuples or arbitrary terms, supporting types like `set`, `ordered_set`, `bag`, and `duplicate_bag`.
  - Shared across processes (unlike process-specific state), with configurable access: `public` (all read/write), `protected` (owner writes, all read—common for caches), or `private`.
  - No automatic garbage collection per process; tables persist until explicitly deleted or the owning process dies (unless using `heir` option for handover).
  - Optimized for concurrency (e.g., `read_concurrency` and `write_concurrency` options).

- **Use Cases for Temporary Storage**:
  - Caching frequently accessed data (e.g., lookup tables, session info).
  - Real-time data in high-concurrency systems (e.g., Discord uses ETS extensively for presence, guilds, etc.).
  - Temporary results or intermediate computations shared between processes.

- **Example**:
  ```erlang
  Tab = ets:new(temp_cache, [set, protected, {read_concurrency, true}]),
  ets:insert(Tab, {key, value}),
  [{key, Value}] = ets:lookup(Tab, key).
  ```

- **Limitations**:
  - Purely in-memory: Data is lost on node crash/restart.
  - Memory-bound (limited by available RAM; no disk spillover).

ETS is ideal for most temporary needs due to its speed and flexibility.

### Other Options
- **Process Dictionary**:
  - Each Erlang process has a private key-value store (accessed via `put/2`, `get/1`, `get_keys/0`, etc.).
  - Truly temporary: Cleared when the process dies; garbage-collected with the process.
  - Fast and mutable, useful for per-process metadata (e.g., request context, debugging info) or avoiding passing data in recursive loops.
  - **Caveats**: Often discouraged for general use as it introduces hidden state (harder to reason about/test), breaks referential transparency, and can lead to bugs in distributed/hot-code scenarios. Use sparingly—prefer explicit state in GenServer loops or ETS.

- **Persistent_term (for semi-temporary global data)**:
  - Global key-value store for immutable terms (introduced in OTP 21+).
  - Extremely fast reads (optimized for configuration/constants accessed frequently).
  - Not truly temporary: Survives process deaths but is node-wide and requires explicit updates (expensive writes trigger global GC).
  - Best for read-heavy, rarely changing data (e.g., app config), not dynamic temporary storage.

- **Process Heap/State**:
  - Standard way: Hold data in a GenServer/GenStateMachine's state record.
  - Temporary (lost on process crash unless supervised/restarted with init recovery).
  - Explicit and functional-style—preferred over process dictionary for most state.

### When to Choose What
- **High-concurrency/shared temporary data**: ETS (e.g., caches in web apps or real-time systems).
- **Per-process private temp data**: Process state or (rarely) dictionary.
- **Global read-only config**: persistent_term.
- For disk-backed or persistent needs: Use DETS (disk ETS, limited/slower) or Mnesia (distributed DB on ETS/DETS).

ETS is the cornerstone for scalable temporary storage in Erlang systems, powering everything from small caches to massive real-time apps. If your data outgrows memory or needs persistence, layer on Mnesia or external stores.
