#! /bin/sh

# Start couchdb
# exec /docker-entrypoint.sh "$@"
# exec /opt/couchdb/bin/couchdb
exec /docker-entrypoint.sh /opt/couchdb/bin/couchdb

# Wait for CouchDB
until nc -z -v -w30 localhost 5984
do
  echo 'Waiting for CouchDB...'
  sleep 1
done
echo "CouchDB is up and running"


curl -X PUT 'http://admin:pass@localhost:5984/{_users,_replicator,_global_changes,_metadata,admins}'

curl -X PUT http://admin:pass@localhost:5986/_config/chttpd/require_valid_user \
  -d '"true"' -H "Content-Type: application/json"

curl -X POST http://admin:pass@localhost:5984/_users \
  -H "Content-Type: application/json" \
  -d '{"_id": "org.couchdb.user:admin", "name": "admin", "password":"pass", "type":"user", "roles":[]}'

curl -X PUT http://admin:pass@localhost:5986/_config/httpd/WWW-Authenticate \
  -d '"Basic realm=\"administrator\""' -H "Content-Type: application/json"

curl -X PUT --data '"4294967296"' http://admin:pass@localhost:5986/_config/httpd/max_http_request_size
