#!/bin/sh

URLS=/tmp/urls.txt
if [ ! -f $URLS ]
then
    curl http://s3.amazonaws.com/alexa-static/top-1m.csv.zip > top-1m.csv.zip
    unzip -p top-1m.csv.zip | awk -F',' '{print $2}' > $URLS
    rm top-1m.csv.zip
fi
DIR=`./downloadr.py create`
cat $URLS | xargs -I{} -n 1 -P64 ./downloadr.py download {} $DIR
