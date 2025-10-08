#!/usr/bin/env bash
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

DATASET="${1:?Usage: $0 <dataset>}"

BASE_URL=https://opentdatach.github.io/data

rm -rf $DIR/site
mkdir -p $DIR/site

# STEP 1 - Rehydrate everything from the previous site EXCEPT $DATASET/*
curl -fsL -o /tmp/manifest.txt '$BASE_URL/__manifest.txt' 2>/dev/null || : > /tmp/manifest.txt
if [ -s /tmp/manifest.txt ]; then
  while IFS= read -r rel_path; do
    [ -z "$rel_path" ] && continue
    [ "$rel_path" = "__manifest.txt" ] && continue
    [ "$rel_path" = ".nojekyll" ] && continue

    if [[ $rel == $DATASET/* ]]; then
        continue
    fi

    mkdir -p "$DIR/site/$(dirname "$rel_path")"
    curl -fL "$BASE_URL/$rel_path" -o "$DIR/site/$rel_path" || true
  done < /tmp/manifest.txt
fi

# STEP 2 - Rebuild manifest & disable Jekyll
touch $DIR/site/.nojekyll
( cd $DIR/site && find . -type f -printf '%P\n' \
    | grep -Ev '^(__manifest\.txt|\.nojekyll)$' \
    | sort > __manifest.txt )

# DEBUG BELOW
find $DIR/site -type d | while read d; do
    echo "--- $d ---"
    ls -al "$d"
done
