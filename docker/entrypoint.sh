#!/bin/sh

set -eu

data_path="${SUB_STORE_DATA_BASE_PATH:-/opt/app/data}"
frontend_backend_path="${SUB_STORE_FRONTEND_BACKEND_PATH:-/sub-store}"

case "$frontend_backend_path" in
    /*) ;;
    *)
        echo "SUB_STORE_FRONTEND_BACKEND_PATH must start with /" >&2
        exit 1
        ;;
esac

path_without_slash="${frontend_backend_path#/}"
case "$path_without_slash" in
    ''|*[!A-Za-z0-9._-]*)
        echo "SUB_STORE_FRONTEND_BACKEND_PATH only supports letters, numbers, ., - and _ after the leading /" >&2
        exit 1
        ;;
esac

frontend_backend_path_length=${#frontend_backend_path}
if [ "$frontend_backend_path_length" -lt 2 ] || [ "$frontend_backend_path_length" -gt 64 ]; then
    echo "SUB_STORE_FRONTEND_BACKEND_PATH length must be between 2 and 64" >&2
    exit 1
fi

frontend_path="${SUB_STORE_FRONTEND_PATH:-/opt/sub-store/frontend}"
if [ -d "$frontend_path" ]; then
    find "$frontend_path" -type f -name '*.js' -exec \
        sed -i "s#__SUB_STORE_FRONTEND_BACKEND_PATH__#${frontend_backend_path}#g" {} +
fi

mkdir -p "$data_path"
chown -R substore:substore "$data_path"

exec su-exec substore:substore "$@"
