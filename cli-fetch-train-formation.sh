#!/usr/bin/env bash
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

PACKAGE_ID=occupancy-forecast-json-dataset
PACKAGE_PATH=$DIR/openTdataCH--showcases/data/opentransportdata.swiss/$PACKAGE_ID

python3 $DIR/openTdataCH--showcases/tools/ckan-utils/fetch_package_cli.py --package_id $PACKAGE_ID

# Process only today and next 3 days
for i in {0..3}; do
    date=$(date -d "+$i days" +%Y-%m-%d)

    # Check if directory exists
    # ./data/opentransportdata.swiss/occupancy-forecast-json-dataset/occupancyforecastjson/2025-11-16
    if [ -d "$PACKAGE_PATH/occupancyforecastjson/$date" ]; then
        # Create operator directory
        mkdir -p "$DIR/dist/$PACKAGE_ID/$date"

        cp "$PACKAGE_PATH/occupancyforecastjson/$date/"*.json "$DIR/dist/$PACKAGE_ID/$date/."
    fi
done

find $DIR/dist -type d | while read d; do
    echo "--- $d ---"
    ls -al "$d"
done
