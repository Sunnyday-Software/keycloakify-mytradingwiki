#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC_JAR="${ROOT_DIR}/dist_keycloak/keycloak-theme-for-kc-all-other-versions.jar"
DEST_JAR="${ROOT_DIR}/../solutions-dreamlab-trademind-backend/keycloak/keycloak-theme/keycloak-theme-for-kc-all-other-versions.jar"

if [[ ! -f "${SRC_JAR}" ]]; then
  echo "Source theme JAR not found: ${SRC_JAR}" >&2
  exit 1
fi

mkdir -p "$(dirname "${DEST_JAR}")"
cp -f "${SRC_JAR}" "${DEST_JAR}"
echo "Theme deployed to backend: ${DEST_JAR}"
