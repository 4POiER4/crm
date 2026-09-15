#!/bin/sh
set -eu

STATE_DIR="/app/data/wrangler"
SCHEMA_MARKER="/app/data/.schema-v1"
WRANGLER="/app/node_modules/wrangler/bin/wrangler.js"
CONFIG="/app/dist/server/wrangler.json"

mkdir -p "$STATE_DIR"

if [ ! -f "$SCHEMA_MARKER" ]; then
  node --import /app/scripts/sites-env.mjs "$WRANGLER" d1 execute DB \
    --local \
    --config "$CONFIG" \
    --persist-to "$STATE_DIR" \
    --file /app/drizzle/0000_medical_bug.sql
  touch "$SCHEMA_MARKER"
fi

exec node --import /app/scripts/sites-env.mjs "$WRANGLER" dev \
  --local \
  --config "$CONFIG" \
  --persist-to "$STATE_DIR" \
  --ip 0.0.0.0 \
  --port "${PORT:-8787}" \
  --inspector-port 0 \
  --var LOCAL_DEMO_AUTH:true
