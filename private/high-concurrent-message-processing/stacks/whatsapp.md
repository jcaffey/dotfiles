# WhatsApp

Operating System — FreeBSD (chosen for stability and handling high loads).
Protocol — A highly modified/customized version of XMPP (Extensible Messaging and Presence Protocol) for message delivery.
Web Server — Yaws (an Erlang-based web server) in earlier iterations.
Other Languages/Tools — Some PHP historically; modern real-time features (e.g., WhatsApp Web) use WebSockets.
Database — Not extensively detailed publicly, but likely custom storage solutions built on Erlang's Mnesia or other distributed stores for chat history and metadata.

Queuing Solution
WhatsApp relies heavily on Erlang's built-in actor model and message queues. Each Erlang process has its own mailbox (queue) for messages, which is lightweight and highly efficient for concurrency. They have mentioned internal queuing systems in talks about RPC and request dispatching. There is no evidence of external tools like RabbitMQ, Kafka, or similar—Erlang/OTP's native capabilities handle queuing reliably at scale without third-party dependencies.
Caching Solution
Public information on WhatsApp's caching is limited, as they use custom, in-house solutions optimized for their Erlang architecture. They likely leverage:

Erlang's ETS (Erlang Term Storage) tables for in-memory caching.
Distributed caching via built-in tools.

No mentions of external caches like Redis or Memcached appear in engineering talks or analyses.
Overall, WhatsApp's stack emphasizes simplicity, reliability, and leveraging Erlang/OTP's strengths to minimize dependencies—this is a key reason they scaled so efficiently. Details can evolve internally at Meta, but public engineering insights (up to 2025) consistently highlight Erlang as the cornerstone.
