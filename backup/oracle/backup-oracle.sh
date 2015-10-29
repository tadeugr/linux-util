#!/bin/bash

# Oracle backup script
#
# Run:
# /bin/sh backup-oracle.sh DB_USER DB_PWD DB_NAME > /var/log/backup-oracle.log 2>&1

########### START VARIABLES ###################

export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
DBUSER=$1
DBPASS=$2
DBNAME=$3
NOW=`date +%Y%m%d%H%M`
TEMPFILEPATH=/tmp
TEMPFILENAME=VIATRADE-$DBNAME-$DBUSER-$NOW.dmp
BKP_DST=/home/oracle/viatrade
BKPLOG=/var/log/backup-oracle.log
MAILADM=admin@mail.com
MAILSUBJECT="BACKUP ORALCE ERROR"

########### END VARIABLES ###################

########### INICIO FUNCOES ###################

my_echo(){
	echo "[ $(date +%d/%m/%Y) $(date +%H:%M) ] $MYECHO"
	echo ""
}

check_error(){
	if [ $? != 0 ];
	then
		MYECHO="ERROR: ABORTING"
		my_echo
		cat $BKPLOG | mail -s "$MAILSUBJECT" $MAILADM < $BKPLOG
		exit 1
	fi
}

########### FIM FUNCOES ######################

MYECHO="START remove old files"
my_echo

find $BKP_DST -name "*.gz" -ctime +5 -exec rm {} \;
check_error

MYECHO="END remove old files"
my_echo

MYECHO="START dump DB:$DBNAME USER:$DBUSER"
my_echo

$ORACLE_HOME/bin/exp $DBUSER/$DBPASS@$DBNAME file=$TEMPFILEPATH/$TEMPFILENAME owner=$DBUSER statistics=none
check_error

MYECHO="END dump DB:$DBNAME USER:$DBUSER"
my_echo

MYECHO="START tar DB:$DBNAME USER:$DBUSER"
my_echo

tar -czvf $BKP_DST/$TEMPFILENAME.tar.gz $TEMPFILEPATH/$TEMPFILENAME
check_error

MYECHO="END tar DB:$DBNAME USER:$DBUSER"
my_echo

MYECHO="START delete temp $TEMPFILEPATH/$TEMPFILENAME"
my_echo

if [ $? == 0 ];
then
	if [ -f $TEMPFILEPATH/$TEMPFILENAME ]; then
		rm -f $TEMPFILEPATH/$TEMPFILENAME
		check_error
	fi

fi

MYECHO="END delete temp $TEMPFILEPATH/$TEMPFILENAME"
my_echo

exit
