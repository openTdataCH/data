#!/usr/bin/env bash
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source $DIR/cli-common.sh
source $DIR/.venv/bin/activate

PACKAGE_ID=occupancy-forecast-json-dataset
PACKAGE_PATH=$REPO_PATH/data/opentransportdata.swiss/$PACKAGE_ID

python3 $REPO_PATH/tools/ckan-utils/fetch_package_cli.py --package_id $PACKAGE_ID

# Process only today and next 3 days
for i in {0..3}; do
    if date --version >/dev/null 2>&1; then
        # GNU date
        date=$(date -d "+$i days" +%Y-%m-%d)
    else
        # BSD/macOS date
        date=$(date -v+"${i}"d +%Y-%m-%d)
    fi

    # Check if directory exists
    # ./data/opentransportdata.swiss/occupancy-forecast-json-dataset/occupancyforecastjson/2025-11-16
    if [ -d "$PACKAGE_PATH/occupancyforecastjson/$date" ]; then
        mkdir -p "$DIR/site/$PACKAGE_ID/$date"
        cp "$PACKAGE_PATH/occupancyforecastjson/$date/"*.json "$DIR/site/$PACKAGE_ID/$date/."
    fi
done

# find $DIR/site -type d | while read d; do
#     echo "--- $d ---"
#     ls -al "$d"
# done
