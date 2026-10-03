# OpenSign - name and logo changes (source offer under the AGPL-3.0)

This repository is the source offer required by the GNU Affero General Public License v3 for a modified
installation of **OpenSign** (https://github.com/OpenSignLabs/OpenSign, AGPL-3.0).

## What is modified

Nothing in OpenSign's logic is changed. The only modifications are cosmetic, and all of them are in this repository:

| Where | Change | File here |
|---|---|---|
| Server, `Utils.js` | The product name constant `appName` (used as the sender name and subject of the one-time-code email) is set to the operator's name | `brand-server.sh` |
| Web app, three built scripts (`main-*.js`, `utils-*.js`, `GuestLogin-*.js`) | The text `OpenSign™` is replaced with the operator's name (this includes the text stamped on signed PDFs) | `brand-web.sh` |
| Web app, `index.html` | Page title, description and theme colour; favicon and manifest links; the OpenSign font CDN link removed; a link to this source offer | `brand-web.sh` |
| Reverse proxy | Serves the modified copies above in place of the originals; the logo image is swapped | `Caddyfile` |

## Unmodified upstream images

The modifications are applied to these exact upstream images (pinned by digest):

- `opensign/opensignserver@sha256:cadfcaaa20bf40272aed43c91314362c1dac034b2a4651f50e5288d01c2b434d`
- `opensign/opensign@sha256:0ebc230eed21ced0d321a0df887c1a48e9f4bd423c2454fe865a262aec49f99a`

Their complete source is OpenSign's public repository at the matching release.

## How to reproduce

Set `BRAND_NAME` (and put your own `logo.jpg` / `favicon.ico` in `brand/`), then run `brand-server.sh` before starting
the server and `brand-web.sh` once the web container is running. The scripts take the original files from the running
images and print what they changed.

## Names and logos are not licensed here

The AGPL covers the software. It does **not** grant any right to use anyone's name, logo or trademarks. No operator's
name or logo is included in this repository - the scripts use a placeholder (`BRAND_NAME`). "OpenSign" is a trademark
of its owners.

## Licence

AGPL-3.0 - see `LICENSE`.
