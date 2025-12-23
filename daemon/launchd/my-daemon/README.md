= my daemon

example daemon in rust for macosx

== copy to a dir available via path

=== ++[++source,sh++]++

cargo build –release sudo cp target/release/my-daemon
/usr/local/bin/my-daemon —-

== launchd plist

launchd uses XML .plist files. You can place them in:

`~/Library/LaunchAgents/` → per-user, loads when user logs in
`/Library/LaunchDaemons/` → system-wide, loads at boot (requires root)
`/System/Library/LaunchDaemons/` → Apple’s own (don’t touch)

For a system daemon (runs at boot, no user needed), use
`/Library/LaunchDaemons/`

== copy plist

Copy plist to
`sudo cp ./com.mycompany.my-daemon.plist /Library/LaunchDaemons/`

== launchctl

=== Load the plist (makes launchd aware of it) NOTE: this will cause the
daemon to run on start up!

`sudo launchctl load /library/launchdaemons/com.mycompany.my-daemon.plist`

=== start it immediately (optional, since runatload is true)
`sudo launchctl start com.mycompany.my-daemon`

=== ++[++source,sh++]++

 ps aux ++|++ rg my-daemon jcaffey 73955 0.0 0.0 410065280 32 s004
S{plus} 7:43PM 0:00.00 rg my-daemon root 73919 0.0 0.0 410602816 2912 ??
Ss 7:42PM 0:00.01 /usr/local/bin/my-daemon —-

=== view logs

`tail -f /var/log/my-daemon.log`

=== manage

Load:
`sudo launchctl load /library/launchdaemons/com.mycompany.my-daemon.plist`

Start: `sudo launchctl start com.mycompany.my-daemon`

Stop: `sudo launchctl stop com.mycompany.my-daemon.plist`

Unload (disable): `sudo launchctl unload com.mycompany.my-daemon.plist`

Check status:
`sudo launchctl list {plus}{plus}++|++{plus}{plus} grep com.mycompany.my-daemon`

=== macos vs linux

++[++width="`100%`",cols="`27%,25%,48%`",options="`header`",++]++
++|++=== ++|++Feature ++|++Linux (systemd) ++|++macOS (launchd)
++|++Config file ++|++.service (INI-style) ++|++.plist (XML)

++|++Management tool ++|++systemctl ++|++launchctl

++|++Auto-start on boot ++|++systemctl enable ++|++Place in
/Library/LaunchDaemons/ ++{++plus} load

++|++Auto-restart on crash ++|++Restart=on-failure ++|++KeepAlive

++|++Logs ++|++journalctl -u service ++|++Files or log show ++|++===

=== cross platform daemon

See rust crate: https://crates.io/crates/daemonize++[++daemonize++]++

=== How the log works

stdout and stderr do not automatically go to /var/log/name-of-daemon.log
(or any log file) on macOS when using launchd. Launchd captures stdout
and stderr, but by default it sends them to the unified system log
(managed by Apple’s logd/asl system), not to a file on disk like
/var/log/my-daemon.log.

==== What Happens by Default

Any output your daemon prints to stdout or stderr is captured by
launchd. It is forwarded to the system log, where you can view it using:

[source,bash]
----
log show --predicate 'subsystem == "com.mycompany.my-daemon"' --last 1horBashlog stream --predicate 'subsystem == "com.mycompany.my-daemon"'
----

(The subsystem is usually derived from the plist Label.) Or view it in
the Console.app (search for your daemon’s label). The log files are
created in /var/log/ by launchd (specified by plist keys
`StandardOutPath` and `StandardErrorPath`)
