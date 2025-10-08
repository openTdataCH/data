#!/usr/bin/env bash
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

REPO_PATH=$DIR/openTdataCH--showcases
# REPO_BRANCH=develop
# TODO - change to develop
REPO_BRANCH=feature/fix-fetch-atlas-package

# STEP 1 - clone showcases repo
rm -rf $REPO_PATH
git clone --depth 1 --branch $REPO_BRANCH https://github.com/openTdataCH/showcases.git $REPO_PATH
# git -C external log -1 --pretty='format:%h %ad %s' --date=iso

# STEP 2 - install Python

python3 -m venv $DIR/.venv
echo "$DIR/.venv/bin" >> $GITHUB_PATH # for future runs
source $DIR/.venv/bin/activate

python3 -m pip install --upgrade pip
python3 -m pip install --requirement $REPO_PATH/requirements.txt

# STEP 3 - create data folders
python3 $REPO_PATH/tools/scripts/setup.py
