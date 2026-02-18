#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ASSETS_DIR="${ROOT_DIR}/../mytradingwiki-assets/assets"
EMAIL_RESOURCES_DIR="${ROOT_DIR}/src/email/resources"
EMAIL_TEMPLATE="${ROOT_DIR}/src/email/html/template.ftl"
SHARED_STYLES_DIR="${ROOT_DIR}/shared/styles"

SRC_LOGO_PNG="${ASSETS_DIR}/mtw-logo-email.png"
DEST_LOGO_PNG="${EMAIL_RESOURCES_DIR}/mtw-logo-email.png"
LEGACY_SVG="${EMAIL_RESOURCES_DIR}/mytradingwiki.svg"

if [[ ! -f "${SRC_LOGO_PNG}" ]]; then
  echo "Logo not found: ${SRC_LOGO_PNG}" >&2
  exit 1
fi

mkdir -p "${EMAIL_RESOURCES_DIR}"
cp -f "${SRC_LOGO_PNG}" "${DEST_LOGO_PNG}"
echo "Email logo synced: ${DEST_LOGO_PNG}"

if [[ -f "${LEGACY_SVG}" ]]; then
  rm -f "${LEGACY_SVG}"
  echo "Removed legacy SVG: ${LEGACY_SVG}"
fi

ROOT_DIR="${ROOT_DIR}" python3 - <<'PY'
import os
import re
from pathlib import Path

root = Path(os.environ["ROOT_DIR"]).resolve()
template_path = root / "src" / "email" / "html" / "template.ftl"
shared_styles_dir = root / "shared" / "styles"

prefixes = ["mtw-email-"]

def extract_rules(text: str) -> list[str]:
    rules = []
    i = 0
    while True:
        m = re.search(r'([^{]+)\{', text[i:])
        if not m:
            break
        selector = m.group(1)
        start = i + m.start()
        brace_start = i + m.end() - 1
        depth = 1
        j = brace_start + 1
        while j < len(text) and depth > 0:
            if text[j] == "{":
                depth += 1
            elif text[j] == "}":
                depth -= 1
            j += 1
        block = text[start:j].strip()
        if any(f".{p}" in selector for p in prefixes):
            rules.append(block)
        i = j
    return rules

rules = []
for path in shared_styles_dir.rglob("*.css"):
    text = path.read_text(encoding="utf-8")
    rules.extend(extract_rules(text))

rules_blob = "\n\n".join(rules).strip()
start_marker = "/* email:shared:start */"
end_marker = "/* email:shared:end */"

template = template_path.read_text(encoding="utf-8")
start_idx = template.find(start_marker)
end_idx = template.find(end_marker)
if start_idx == -1 or end_idx == -1 or end_idx < start_idx:
    raise SystemExit("Markers not found in template.ftl")

replacement = f"{start_marker}\n"
if rules_blob:
    replacement += rules_blob + "\n"
replacement += f"{end_marker}"

new_template = template[:start_idx] + replacement + template[end_idx + len(end_marker):]

template_path.write_text(new_template, encoding="utf-8")
print(f"Email shared styles injected: {len(rules)} rules from {shared_styles_dir}")
PY
