DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

python3 $DIR/openTdataCH--showcases/tools/ckan-utils/fetch_package_cli.py --package_id occupancy-forecast-json-dataset
find $DIR/openTdataCH--showcases/tools/ckan-utils/data -type d | while read d; do
    echo "--- $d ---"
    ls -al "$d"
done