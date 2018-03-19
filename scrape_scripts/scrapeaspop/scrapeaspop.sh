#!/bin/sh
#
# 2018-01-15 - new script to scrape https://stats.labs.apnic.net/aspop/
#
# set base
base="/home/wider/scrapeaspop"

# set date variable
date=`date +%y%m%d`

# make sure output directory exists
mkdir -p $base/output

# make sure csvout directory exists
mkdir -p $base/csvout

# make sure jsonout directory exists
mkdir -p $base/jsonout

# run ruby script to extract XPath from source
$base/scrapeaspop.rb > $base/output/output1.txt

# extract lines we want
/usr/bin/awk '/arrayToDataTable\(\[/,/\]\)\;/ { print }' $base/output/output1.txt > $base/output/output2.txt

# remove first and last lines
/bin/sed '1d;$d' $base/output/output2.txt > $base/output/output3.txt

# remove whitespace at start of line
/bin/sed 's/^ *//' $base/output/output3.txt > $base/output/output4.txt

# remove comma at end of line
/bin/sed 's/,$//' $base/output/output4.txt > $base/output/output5.txt

# remove "[" at start of line
/bin/sed 's/^.\{1\}//' $base/output/output5.txt > $base/output/output6.txt

# remove "]" at end of line
/bin/sed 's/.$//' $base/output/output6.txt > $base/output/output7.txt

# remove html tags
/bin/sed 's/<[^>]\+>//g' $base/output/output7.txt > $base/output/output8.txt

# remove single quotes from first line of file
/bin/sed -e "1 s/'//g" $base/output/output8.txt > $base/output/output9.txt

# change ", " to "," on first line of file
/bin/sed -e '1 s/, /,/g' $base/output/output9.txt > $base/output/output10.txt

# copy output10.txt to CSV file we want to use
/bin/cp $base/output/output10.txt $base/csvout/aspop.$date.csv

# turn CSV file into json using node.js tool csv2json
# installed via npm to /usr/local/bin/csv2json
/usr/local/bin/csv2json $base/csvout/aspop.$date.csv $base/jsonout/aspop.$date.json

# optional extras, can comment out to remove
#
# 1. save all ASNs to a file
#/usr/bin/csvtool col 2 $base/output/output10.txt |/bin/sed -n '1!p' |/usr/bin/sort -V |/usr/bin/uniq > $base/ASN.txt

# 2. save all Country Codes to a file
#/usr/bin/csvtool col 4 $base/output/output10.txt |/bin/sed -n '1!p' |/usr/bin/sort |/usr/bin/uniq > $base/CC.txt

