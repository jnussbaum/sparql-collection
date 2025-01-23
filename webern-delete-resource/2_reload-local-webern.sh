#!/usr/bin/env bash

# execute this script with 
# chmod +x ./path/to/script.sh
# ./path/to/script.sh

# e: exit on error
# u: treat unset variables as error
# o pipefail: if one command in a pipe fails, let the pipe fail
set -euo pipefail

# debugging mode: print every command before execution
set -x

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# restart the stack
uvx dsp-tools stop-stack
uvx dsp-tools start-stack --no-prune

# load the necessary data into the stack
curl --request PUT \
http://localhost:3030/knora-test/data?graph=http%3A%2F%2Fwww.knora.org%2Fdata%2Fadmin \
--header 'Content-Type: text/turtle;encoding=UTF-8' \
-u "admin:test" \
-T "$SCRIPT_DIR/knora-admin-data.ttl"

curl --request PUT \
http://localhost:3030/knora-test/data?graph=http%3A%2F%2Fwww.knora.org%2Fontology%2F0806%2Fwebern-onto \
--header 'Content-Type: text/turtle;encoding=UTF-8' \
-u "admin:test" \
-T "$SCRIPT_DIR/webern-onto.ttl"

curl --request PUT \
http://localhost:3030/knora-test/data?graph=http%3A%2F%2Fwww.knora.org%2Fdata%2F0806%2Fwebern \
--header 'Content-Type: text/turtle;encoding=UTF-8' \
-u "admin:test" \
-T "$SCRIPT_DIR/webern-data.ttl"


# restart the api container
docker stop start-stack-api-1
docker start start-stack-api-1
