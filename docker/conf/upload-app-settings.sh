.put({
  method: 'PUT',
  url: `${couchUrl}/_design/medic/_rewrite/update_settings/medic?replace=1`,
  headers: { 'Content-Type':'application/json' },
  body: fs.read(`${projectDir}/app_settings.json`),
})


curl -X PUT http://admin:pass@localhost:5988/medic/medic-webapp/
