#!/bin/bash

# collects mailserver stats using the modified pflogsumm
# version that should be located ./pflogsumm/pflogsumm.pl by default
# this version has two new cmdline params which allow to defined
# the length of the output of bounce and deferral messages
# and sends them to the admins email address, defined below
#
# contact author: larry@gettingmoney.at
#
#
# you can run this script in a regular cronjob like this:
# 0 07,11,12,13,14,15,17,19,23,02 * * * /absolute/path/to/send-postfix-stats.sh 2> /dev/null

# #########################
# DEFINE YOUR CONSTATS HERE
# #########################

#make sure to use absolute paths for your pflogsumm.pl, temp directory and mail.log files

#path of mail log 
MAILLOG_FILE='/absolute/path/to/mail.log'
#path to pflogsumm script
PFLOGSUMM_PATH='/absolute/path/to/pflogsumm.pl'
#temporary output
TEMPORARY_LOG_FILE='/tmp/mailstats.txt'
#email of recpipient
EMAIL_RCPT='recipient@address.smth'
#email of sender
EMAIL_SENDER='your-sender@address.smth'
#email subject
EMAIL_SUBJECT='[POSTFIX] MTA statistics'


#read mail.log and output stats to temp dir
perl $PFLOGSUMM_PATH  --detail 0 --deferral_detail 100 --deferral_detail_length 700 --bounce_detail 100 --bounce_detail_length 700 -d today $MAILLOG_FILE > $TEMPORARY_LOG_FILE

#debug output
#cat $TEMPORARY_LOG_FILE

#send the log to the admin email
mail -s "$EMAIL_SUBJECT" $EMAIL_RCPT -aFrom:$EMAIL_SENDER < $TEMPORARY_LOG_FILE

#clean up your mess
rm $TEMPORARY_LOG_FILE
