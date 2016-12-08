#!/bin/bash

QUALITY=/home/clifford/Development/FirstEditImprovement/quality
ME=glassman


cd ~/.purple/logs/irc/${ME}@irc.oftc.net/\#osm-bot.chat
CURRENT=`(ls -t | head -1)`

grep "United States of America" $CURRENT|grep "just started editing" >> ${QUALITY}/tmp_user.txt

while read line
do
	usr=`echo $line |sed -e '/.*osmbot.test. /s///' -e '/ just started.*/s///' -e 's/[\/&]/\\&/g'`
	user=`echo ${usr} | sed -e 's/[\$\^\&]/\\\&/g'`
	
	if ! grep -q ${user} ${QUALITY}/new_user.txt
	then
		changeset=`echo $line | sed -e '/.*changeset /s///' -e s/^http...osm.org.changeset.//`
		echo ${usr} >> ${QUALITY}/new_user.txt
		echo ${changeset} >> ${QUALITY}/changeset.txt
	fi
done <${QUALITY}/tmp_user.txt


if test -e ${QUALITY}/tmp_user.txt; then
	rm ${QUALITY}/tmp_user.txt
fi
