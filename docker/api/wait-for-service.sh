#! /bin/sh

# Wait for CouchDB
until nc -z -v -w30 couchdb 5984
do
  echo 'Waiting for CouchDB...'
  sleep 1
done
echo "CouchDB is up and running"
