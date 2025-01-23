#!/opt/homebrew/bin/bash

# execute this script with
# chmod +x ./path/to/script.sh
# ./path/to/script.sh ${DB_PASSWORD}

# e: exit on error
# u: treat unset variables as error
# o pipefail: if one command in a pipe fails, let the pipe fail
set -euo pipefail

# debugging mode: print every command before execution
set -x

DB_PASSWORD=$1
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

declare -A graphs
graphs["http%3A%2F%2Fwww.knora.org%2Fdata%2Fadmin"]="knora-admin-data.ttl"
graphs["http%3A%2F%2Fwww.knora.org%2Fontology%2F0806%2Fwebern-onto"]="webern-onto.ttl"
graphs["http%3A%2F%2Fwww.knora.org%2Fdata%2F0806%2Fwebern"]="webern-data.ttl"

for graph in "${!graphs[@]}"; do
    dest=${graphs[$graph]}
    curl "https://db.dasch.swiss/dsp-repo/data?graph=${graph}" \
        --header "Accept: text/turtle;encoding=UTF-8" \
        -u "admin:${DB_PASSWORD}" \
        > "$SCRIPT_DIR/$dest"
done
