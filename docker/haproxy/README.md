# haproxy
Captures and logs couchdb requests

## Log format (haproxy.cfg)

```

log-format "%ci,%ST,%[capture.req.method],%[capture.req.uri],%[capture.req.hdr(1)],%[capture.req.hdr(2)],%[capture.req.hdr(0)],%B,%Tr,%[capture.res.hdr(0)]"

```

### CSV order

| client ip | http status | http method |  uri | service | user | req body | bytes read | response time | response header Content-Length |


#### CSV values

| column  | value |
| service | http request header 'X-Medic-Service'  (api, sentinel, etc) |
| user    | username from cookie when provided or http request header 'X-Medic-User'  |

All options at the end of this page: [haproxy configuration](https://cbonte.github.io/haproxy-dconv/1.8/configuration.html)


#### Samples

haproxy    | Oct 23 11:38:43 108731aa155b haproxy[22]: 172.27.0.1,200,GET,/medic/_design/medic/translations/messages-fr.properties,api,-,-,75883,18,75579
haproxy    | Oct 23 11:38:49 108731aa155b haproxy[22]: 172.27.0.1,201,PUT,/medic-sentinel/appcache-info,sentinel,sentinel,{"_id":"appcache-info","_rev":"4-29e77d6d61f814a479df82ac6db20dbd","type":"info","doc_id":"appcache","initial_replication_date":"unknown","latest_replication_date":"2018-10-23T11:38:49.282Z","transitions":{}},441,8,76
haproxy    | Oct 23 11:38:49 108731aa155b haproxy[22]: 172.27.0.1,201,PUT,/medic-sentinel/_local/sentinel-meta-data,sentinel,sentinel,{"_id":"_local/sentinel-meta-data","_rev":"0-29","processed_seq":"114-g1AAAAIjeJyV0EsKwjAQBuBolbpRvIG6cN-mJZOs7E00NSml1GShe72J3kRvojepeRSEgtBu_oFh5oOZGiE0KwOB5korLWSmdKnPl9q0xxzlq6ZpqjLgy5NphBHjBGTRHf6znq9N5rtWCJ3AjjSmIPoKmRX2rTByggCcUIj7CgcrXFth4a-IMOGU9RTUxCS6mWKQu1WmTpGiAGB8kPLwyvN3TRLLI9B0kPLyytsqG6dgTFmSwiDl4xX3l61TCI8IAOnuVF-fZKcG"},427,5,58
