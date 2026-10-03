#!/bin/bash
# Builds brand/ from the RUNNING OpenSign web container: copies of the three scripts that carry the product name, with
# BRAND_NAME in its place, and an index.html with the operator's title/favicon/manifest, the font CDN link removed and a
# link to this source offer. The reverse proxy (see Caddyfile) serves these in place of the originals.
# Re-run after any OpenSign image change (file names carry hashes).
# Licence: AGPL-3.0 (this is a modification of OpenSign, https://github.com/OpenSignLabs/OpenSign).
set -euo pipefail
: "${BRAND_NAME:?set BRAND_NAME}"
C="${WEB_CONTAINER:-opensign-web}"
SRC_URL="${SRC_URL:-https://github.com/Tyr1-Dev/rvr-opensign-branding}"
B=brand; mkdir -p $B/assets; find $B/assets -mindepth 1 -delete
for pat in 'main-*.js' 'utils-*.js' 'GuestLogin-*.js'; do
  f=$(docker exec "$C" sh -c "cd build/assets && ls $pat" | head -1)
  docker exec "$C" cat build/assets/$f | sed "s/OpenSign™/${BRAND_NAME}/g" > $B/assets/$f
  echo "  $f: $(grep -c 'OpenSign™' $B/assets/$f || true) left"
done
docker exec "$C" cat build/index.html \
 | sed -e "s#<title>[^<]*</title>#<title>${BRAND_NAME} - Secure signing</title>#" \
       -e "s#content=\"The fastest way to sign PDFs & request signatures from others\"#content=\"Secure document signing for ${BRAND_NAME} clients\"#" \
       -e 's#<meta name="theme-color" content="\#000000" />#<meta name="theme-color" content="\#25314a" /><link rel="icon" href="/favicon.ico" /><link rel="manifest" href="/manifest.json" />#' \
       -e '\#cdn.opensignlabs.com/fonts.css#d' \
       -e "s#</body>#<a href=\"${SRC_URL}\" target=\"_blank\" rel=\"noopener\" style=\"position:fixed;bottom:4px;right:8px;font:11px Arial,sans-serif;color:\#8a94a6;z-index:9999;text-decoration:none\">Source code (AGPL)</a></body>#" \
       > $B/index.html
echo "  index.html built; put your own logo.jpg, favicon.ico and manifest.json in $B/"
