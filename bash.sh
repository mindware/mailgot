#!/usr/bin/expect #Where the script should be run from.

spawn telnet localhost 2525
set timeout 1
expect "220 hello"
send "MAIL FROM: me@me.com\n"
expect "220 OK"
send "RCPT TO: you@you.com\n"
expect "220 OK"
send "DATA\n"
expect "354 Enter message, ending with \".\" on a line by itself"
interact
#send "Subject: Progress is great!\n"
#send "Did you know we found a great site called http://www.thoughtware.tv
#It was originally inspired by http://www.purenova.com. Check them out!\n"
#send ".\n"
#send "QUIT\n"
