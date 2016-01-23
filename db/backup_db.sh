#!/bin/bash

# database connection parameters
DBHOST=192.168.99.100
DBUSER=dbadmin
DBPASS=gentlesport
DBNAME=gs
DBPORT=3306

DATA_FOLDER="backup_db_`date +%Y%m%d%H%M%S`"
DATA_FOLDER_DEFAULT="backup_db"
STRUCTURE_FILE=$DATA_FOLDER"/_structure.sql"
DATA_FILE=$DATA_FOLDER"/_data.sql"

while [ "$1" != "" ]; do
    case $1 in
        -h | --host )         DBHOST=$2
                              shift 2
                                ;;
        -p | --port )         DBPORT=$2
                              shift 2
                                ;;
        -d | --database )     DBNAME=$2
                              shift 2
                                ;;
        -P | --password )     DBPASS=$2
                              shift 2
                                ;;
        -U | --user )         DBUSER=$2
                              shift 2
                                ;;
        -f | --folder )       DATA_FOLDER=$2
                              shift 2
                                ;;
        * )                    break
                                ;;
    esac
done

echo "Backing up database $db from host $host"

# REMOVE OLD BACKUP FILES
mkdir $DATA_FOLDER
rm -rf $DATA_FOLDER_DEFAULT
ln -sf $DATA_FOLDER $DATA_FOLDER_DEFAULT

# dump structure
echo "Dumping database structure to $structfile"
mysqldump -h $DBHOST -u $DBUSER -p$DBPASS --routines --triggers --events --no-data $DBNAME > $STRUCTURE_FILE

# dump data
echo "Dumping database data to compressed $datafile"
mysqldump -h $DBHOST -u $DBUSER -p$DBPASS --skip-triggers --compact --no-create-info --single-transaction $DBNAME > $DATA_FILE

#echo "Use restore_database.sh to restore the dump to a new database instance"
echo "Done"

exit 0