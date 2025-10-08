DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

PACKAGE_ID=occupancy-forecast-json-dataset
PACKAGE_PATH=$DIR/openTdataCH--showcases/data/opentransportdata.swiss/$PACKAGE_ID

python3 $DIR/openTdataCH--showcases/tools/ckan-utils/fetch_package_cli.py --package_id $PACKAGE_ID
done

find $DIR/openTdataCH--showcases/data -type d | while read d; do
    echo "--- $d ---"
    ls -al "$d"
done
