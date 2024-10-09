# Collection of SPARQL queries

This repo contains SPARQL queries that can be executed within VS Code,
using the [`zazuko.sparql-notebook`](https://marketplace.visualstudio.com/items?itemName=Zazuko.sparql-notebook) extension.
Most of these queries were written to be executed against Apache Jena Fuseki endpoints
of servers running the [DSP](https://docs.dasch.swiss/latest/) software stack.

Before running the queries, you have to connect to a SPARQL endpoint,
e.g. `https://db.stage.dasch.swiss/dsp-repo/query`.
This can be done in the "SPARQL Notebook" tab in VS Code.

SPARQL queries may also be sent via HTTP, for example like this:

```bash
curl --request POST http://localhost:3030/knora-test/update \
--header 'Authorization: Basic <<token>>' \
--header 'Content-Type: application/sparql-update' \
--data 'DROP GRAPH <http://www.knora.org/data/080E/LIMC>'
```
