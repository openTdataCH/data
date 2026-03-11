#!/usr/bin/env bash
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source $DIR/cli-common.sh

REPO_URL=https://github.com/openTdataCH/showcases.git
REPO_BRANCH=develop

# STEP 1 - clone showcases repo
rm -rf $REPO_PATH
git clone --depth 1 --branch $REPO_BRANCH $REPO_URL $REPO_PATH
# git -C external log -1 --pretty='format:%h %ad %s' --date=iso

echo "Setup tools/ckan-utils"
# ckan-utils
cd $REPO_PATH/tools/ckan-utils
python3 -m venv ./.venv
source ./.venv/bin/activate
python3 -m pip install --upgrade pip
python3 -m pip install --requirement ./requirements.txt

