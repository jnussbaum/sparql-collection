#!/opt/homebrew/bin/bash

# execute this script with 
# chmod +x ./path/to/script.sh
# ./path/to/script.sh

# e: exit on error
# u: treat unset variables as error
# o pipefail: if one command in a pipe fails, let the pipe fail
set -euo pipefail

# debugging mode: print every command before execution
set -x

HOST=$1
USER=$2
PASSWORD=$3

curl --request POST "${HOST}/v2/resources/erase" \
    --header 'Content-Type: application/json' \
    -u "${USER}:${PASSWORD}" \
    --data-raw '{
        "@id" : "http://rdfh.ch/0806/eD83lLUSSYCbEOb5B5cknQ",
        "@type" : "webern-onto:test_institution",
        "knora-api:lastModificationDate" : {
            "@type" : "xsd:dateTimeStamp",
            "@value" : "2024-12-17T12:51:05.494259988Z"
        },
        "@context" : {
            "rdf" : "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
            "knora-api" : "http://api.knora.org/ontology/knora-api/v2#",
            "rdfs" : "http://www.w3.org/2000/01/rdf-schema#",
            "xsd" : "http://www.w3.org/2001/XMLSchema#",
            "anything" : "http://0.0.0.0:3333/ontology/0001/anything/v2#"
        }
    }'
