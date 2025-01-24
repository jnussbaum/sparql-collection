# Erase webern class

Goal: Erase the following from the webern project on Prod:

- resource "Kolisch-Quartett" (<https://app.dasch.swiss/resource/0806/eD83lLUSSYCbEOb5B5cknQ>)
- its resource class "[TEST] Institution" (<https://app.dasch.swiss/project/ot7I2nU-SdeXIf17LX_h3g/ontology/webern-onto/test_institution>)
- controlled vocabulary "test (institution_type)" (<https://app.dasch.swiss/project/ot7I2nU-SdeXIf17LX_h3g/list/iY_Hki-MSi2rjKsvG6z7YA>)

Steps to analyse on localhost:

- `./1_extract-webern-from-prod.sh $DB_PASSWORD`
- `./2_reload-local-webern.sh`
- SPARQL Notebook: connect with localhost
- run the queries of `3_webern-analysis.sparqlbook`
- run the queries of `4_webern-tidyup.sparqlbook`
- `./5_delete_resclass.sh "http://0.0.0.0:3333" "$DASCH_MAIL" "$PROD_PW"`

Steps on Prod (only do that once you're sure!):

- SPARQL Notebook: connect with prod
- run the queries of `4_webern-tidyup.sparqlbook`
- `./5_delete_resclass.sh https://api.dasch.swiss $DASCH_EMAIL $PROD_PW`
