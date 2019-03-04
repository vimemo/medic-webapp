#! /bin/sh

curl -X PUT 'http://admin:pass@localhost:5984/{_users,_replicator,_global_changes,_metadata,admins}'

curl -X PUT http://admin:pass@localhost:5986/_config/chttpd/require_valid_user \
  -d '"true"' -H "Content-Type: application/json"

curl -X POST http://admin:pass@localhost:5984/_users \
  -H "Content-Type: application/json" \
  -d '{"_id": "org.couchdb.user:admin", "name": "admin", "password":"pass", "type":"user", "roles":[]}'

curl -X PUT http://admin:pass@localhost:5986/_config/httpd/WWW-Authenticate \
  -d '"Basic realm=\"administrator\""' -H "Content-Type: application/json"

curl -X PUT --data '"4294967296"' http://admin:pass@localhost:5986/_config/httpd/max_http_request_size



curl -X PUT http://localhost:5986/_config/admins/admin -d '"pass"'


curl -X POST -H "Content-Type: application/json" http://admin:password@127.0.0.1:5984/_cluster_setup -d '{"action": "enable_cluster", "bind_address":"0.0.0.0", "username": "admin", "password":"pass"}'


curl -X POST -H "Content-Type: application/json" http://admin:password@127.0.0.1:5984/_cluster_setup -d '{"action": "enable_cluster", "bind_address":"0.0.0.0", "username": "admin", "password":"password", "port": 15984, "remote_node": "<remote-node-ip>", "remote_current_user": "<remote-node-username>", "remote_current_password": "<remote-node-password>" }'
curl -X POST -H "Content-Type: application/json" http://admin:password@127.0.0.1:5984/_cluster_setup -d '{"action": "add_node", "host":"<remote-node-ip>", "port": "<remote-node-port>", "username": "garren", "password":"password"}' -H "Content-Type: application/json"
