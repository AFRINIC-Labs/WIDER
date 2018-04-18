#!/bin/bash

DIR=/home/wider/scrapewider/nro/data/
URL=https://www.nro.net/wp-content/uploads/apnic-uploads/delegated-extended
DATE=`date +%Y-%m-%d`
NEWFILE=delegated-$DATE
cd $DIR
wget $URL

echo 'rir,cc,type,number,prefix_len,alloc_date,status' > $DIR$NEWFILE
cat delegated-extended | tail -n +5 | csvcut -d "|" -C 8,9 >> $DIR$NEWFILE 

rm delegated-extended

csvsql -v --db postgresql://wider:'passwd'@localhost:5432/wider --tables nro_allocation $NEWFILE --insert --overwrite --no-create
