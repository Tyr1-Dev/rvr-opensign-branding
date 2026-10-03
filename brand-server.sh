#!/bin/bash
# Sets OpenSign's product name constant (Utils.js: appName) to BRAND_NAME. Mount overrides/Utils.js over
# /usr/src/app/Utils.js in the server container. Re-run after any OpenSign image change.
# Licence: AGPL-3.0 (this is a modification of OpenSign, https://github.com/OpenSignLabs/OpenSign).
set -euo pipefail
: "${BRAND_NAME:?set BRAND_NAME, e.g. BRAND_NAME='Example Ltd'}"
IMG="${IMG:-opensign/opensignserver@sha256:cadfcaaa20bf40272aed43c91314362c1dac034b2a4651f50e5288d01c2b434d}"
mkdir -p overrides
docker run --rm --entrypoint cat "$IMG" /usr/src/app/Utils.js > overrides/Utils.orig.js
grep -q "export const appName = 'OpenSign™';" overrides/Utils.orig.js || { echo "anchor missing - OpenSign changed Utils.js"; exit 1; }
sed "s/export const appName = 'OpenSign™';/export const appName = '${BRAND_NAME}';/" overrides/Utils.orig.js > overrides/Utils.js
diff overrides/Utils.orig.js overrides/Utils.js || true
