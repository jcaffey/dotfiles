use std::thread;
use std::time::Duration;

fn main() {
    // TODO: try `cargo add daemonize` for a cross platform launchd/systemd solution
    println!("My daemon started!");

    loop {
        println!("Daemon running... Current time: {}", chrono::Utc::now());
        thread::sleep(Duration::from_secs(10));
    }
}
