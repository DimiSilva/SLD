#!/usr/bin/env bash
set -euo pipefail

if command -v uuidgen >/dev/null 2>&1; then
  uuidgen | tr '[:upper:]' '[:lower:]'
  exit 0
fi

if [[ -r /proc/sys/kernel/random/uuid ]]; then
  cat /proc/sys/kernel/random/uuid
  exit 0
fi

echo "erro: nao foi possivel gerar uuid" >&2
exit 1
