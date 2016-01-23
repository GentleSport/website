# database connection parameters
DBHOST=website_db_1
DBUSER=dbadmin
DBPASS=gentlesport
DBROOTPASS=gentlesport
DBNAME=gs
DBPORT=3306

# database dump parameters
LOCATION=$(pwd);
DUMP_FOLDER="backup_db"
STRUCTURE_FILE=$DUMP_FOLDER"/_structure.sql"
DUMP_FILE=$DUMP_FOLDER"/_data.sql"

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
        -R | --root-password )DBROOTPASS=$2
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

if [ -d $DUMP_FOLDER_DEFAULT ]; then 

cd $DUMP_FILE

    mysql -h $DBHOST -u root -p$DBROOTPASS -P $DBPORT -e 'DROP DATABASE IF EXISTS '$DBNAME';'

    mysql -h $DBHOST -u root -p$DBROOTPASS -P $DBPORT -e 'CREATE DATABASE '$DBNAME' CHARACTER SET utf8;'

    mysql -h $DBHOST -u root -p$DBROOTPASS -P $DBPORT $DBNAME < ./$STRUCTURE_FILE

    mysql -h $DBHOST -u root -p$DBROOTPASS -P $DBPORT $DBNAME < ./$DUMP_FILE

    mysql -h $DBHOST -u root -p$DBROOTPASS -P $DBPORT -e "GRANT ALL PRIVILEGES ON $DBNAME.* TO '$DBUSER'@'%' IDENTIFIED BY '$DBPASS';FLUSH PRIVILEGES;"

fi