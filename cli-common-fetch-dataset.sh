#!/usr/bin/env bash
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source $DIR/cli-common.sh
source $DIR/.venv/bin/activate

DATASET="${1:?Usage: $0 <dataset>}"
PREFIX="${2:-}"

fetch_sh=(python3 $REPO_PATH/tools/ckan-utils/fetch_package_cli.py --package_id $DATASET)

if [ -n "$PREFIX" ]; then
  fetch_sh+=(--resource_title "$PREFIX" --partial_match)
fi

echo "Running: ${fetch_sh[*]}"

# run it 
"${fetch_sh[@]}"

if [ -n "$PREFIX" ]; then
  latest_file_pattern="${PREFIX}*"
else
  latest_file_pattern="*"
fi

if stat --version >/dev/null 2>&1; then
  # Linux / GNU stat
  stat_cmd="stat -c '%Y %n'"
else
  # macOS / BSD stat
  stat_cmd="stat -f '%m %N'"
fi

latest_file="$(
  find $REPO_PATH/data/opentransportdata.swiss/$DATASET -type f -name "$latest_file_pattern" -exec bash -c "$stat_cmd \"\$1\"" _ {} \; \
    | sort -nr | head -n1 | cut -d ' ' -f2-
)"

if [[ -z "$latest_file" || ! -f "$latest_file" ]]; then
  echo "ERROR: no file found for package '$DATASET', prefix '$PREFIX'" >&2
  exit 1
fi

file_dst_folder="$DIR/site/$DATASET"
mkdir -p $file_dst_folder

if [ -n "$PREFIX" ]; then
  file_dst_extension="${latest_file##*.}"
  file_dst_path="$file_dst_folder/${PREFIX}_LATEST.$file_dst_extension"
else
  file_dst_file=$(basename "$latest_file")
  file_dst_path="$file_dst_folder/$file_dst_file"
fi

cp $latest_file $file_dst_path

echo "copied $latest_file"
echo "    to $file_dst_path"
