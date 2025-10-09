#!/usr/bin/env bash
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

DATASET="${1:?Usage: $0 <dataset>}"

BASE_URL=https://opentdatach.github.io/data

# STEP 1 - Rehydrate everything from the previous site EXCEPT $DATASET/*
curl -fsL -o /tmp/manifest.txt $BASE_URL/__manifest.txt 2>/dev/null || : > /tmp/manifest.txt

echo "reading $BASE_URL/__manifest.txt ..."
if [ -s /tmp/manifest.txt ]; then
  while IFS= read -r rel_path; do
    [ -z "$rel_path" ] && continue
    [ "$rel_path" = "__manifest.txt" ] && continue
    [ "$rel_path" = ".nojekyll" ] && continue

    if [[ $rel_path == $DATASET/* ]]; then
        echo "-> ignore ... $rel_path"
        continue
    fi

    mkdir -p $DIR/site/$(dirname "$rel_path")
    curl -fL $BASE_URL/$rel_path -o $DIR/site/$rel_path || true

    echo "-> re-download ... $rel_path"
  done < /tmp/manifest.txt
fi

# STEP 2 - Rebuild manifest & disable Jekyll
touch $DIR/site/.nojekyll

if find . -printf '' >/dev/null 2>&1; then
  # GNU find
  ( cd "$DIR/site" && find . -type f -printf '%P\n' \
      | grep -Ev '^(__manifest\.txt|\.nojekyll)$' \
      | sort > __manifest.txt )
else
  # BSD/macOS find
  ( cd "$DIR/site" && find . -type f \
      ! -name '__manifest.txt' ! -name '.nojekyll' \
      | sed 's|^\./||' | sort > __manifest.txt )
fi
