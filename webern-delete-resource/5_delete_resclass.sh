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


get_api_token() {
    local host="$1"
    local user="$2"
    local password="$3"
    response=$(
        curl --request POST "${host}/v2/authentication" \
        --header 'Content-Type: application/json' \
        --data-raw "{\"email\": \"${user}\", \"password\": \"${password}\"}" \
    )
    echo "$response" | jq -r '.token'  # -r: write resulting string to stdout instead of formatting it with double quotes
    # bash functions don't return, instead they write to stdout
}

token=$(get_api_token "$HOST" "$USER" "$PASSWORD")

if [[ "$HOST" == "http://0.0.0.0:3333" ]]; then
    webern_prefix="http://0.0.0.0:3333/ontology/0806/webern-onto/v2#"
elif [[ "$HOST" == "https://api.dasch.swiss" ]]; then
    webern_prefix="http://api.dasch.swiss/ontology/0806/webern-onto/v2#"
else
    echo "Unknown host: $HOST"
    exit 1
fi


payload=$(cat <<EOF 
{
    "@id" : "http://rdfh.ch/0806/eD83lLUSSYCbEOb5B5cknQ",
    "@type" : "webern:test_institution",
    "knora-api:lastModificationDate" : {
        "@type" : "xsd:dateTimeStamp",
        "@value" : "2024-12-17T12:51:05.494259988Z"
    },
    "@context" : {
        "rdf" : "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        "knora-api" : "http://api.knora.org/ontology/knora-api/v2#",
        "rdfs" : "http://www.w3.org/2000/01/rdf-schema#",
        "xsd" : "http://www.w3.org/2001/XMLSchema#",
        "webern": "$webern_prefix"
    }
}
EOF
)


curl --request POST "${HOST}/v2/resources/erase" \
    --header 'Content-Type: application/json' \
    --header "Authorization: Bearer ${token}" \
    --data-raw "${payload}"
