lofi_mailstat
sends mailserver status reports by mail


collects mailserver stats using the modified pflogsumm
version that should be located ./pflogsumm/pflogsumm.pl by default
this version has two new cmdline params which allow to defined
the length of the output of bounce and deferral messages
and sends them to the admins email address, defined below

contact author: larry@gettingmoney.at

you can run this script in a regular cronjob like this:
0 07,11,12,13,14,15,17,19,23,02 * * * /absolute/path/to/send-postfix-stats.sh 2> /dev/null
