#!/bin/sh

set -eu

data_path="${SUB_STORE_DATA_BASE_PATH:-/opt/app/data}"
mkdir -p "$data_path"
chown -R substore:substore "$data_path"

exec su-exec substore:substore "$@"

