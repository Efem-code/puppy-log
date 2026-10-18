#!/usr/bin/env bash
# Publish the public Puppy Log to GitHub Pages. Rebuild it first from Oscar's code:
#   python3 ../oscar/make_public.py && ./deploy.sh
# The BUILD stamp in sw.js is what makes an update reach installed phones.
set -euo pipefail
cd "$(dirname "$0")"
for f in *.js; do node --check "$f" || { echo "Syntax error in $f — not deploying"; exit 1; }; done
STAMP="$(date +%Y%m%d-%H%M%S)"
sed -i '' "s/^const BUILD = '.*';/const BUILD = '$STAMP';/" sw.js
git add -A
git diff --cached --quiet || git commit -qm "Deploy $STAMP"
git push -q origin main
echo "build $STAMP pushed → https://efem-code.github.io/puppy-log/ (GitHub takes a minute or two)"
