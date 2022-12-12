# Required Arguments
# Note, SOOS_CLIENT_ID and SOOS_API_KEY can be set below or be defined as Environment variables.
# You can get the values for SOOS_CLIENT_ID and SOOS_API_KEY from the SOOS Application
SOOS_CLIENT_ID="99551c39759db321b04cae8b0a52ef3705288ddbe00765f40018d2a664b3987f"
SOOS_API_KEY="MDljZGJlMjQtNjJiOC00Y2JhLWE2ZmQtMTdhMGJmYTVhYjIx"
SOURCE_CODE_PATH="/Users/jgomez/Desktop/PythonScript"
SOOS_PROJECT_NAME="Python Test on Mac"

# Optional Arguments
SOOS_MODE="run_and_wait"
SOOS_ON_FAILURE="fail_the_build"
SOOS_DIRS_TO_EXCLUDE="soos"
SOOS_FILES_TO_EXCLUDE=""
SOOS_ANALYSIS_RESULT_MAX_WAIT=300
SOOS_ANALYSIS_RESULT_POLLING_INTERVAL=10
SOOS_API_BASE_URL="https://qa-api.soos.io/api/"
SOOS_LATEST_REPO="https://raw.githubusercontent.com/soos-io/soos-ci-analysis-python/release-1.5.5/src/cli"

# Build Specific Arguments
SOOS_COMMIT_HASH=""                # ENTER COMMIT HASH HERE IF KNOWN
SOOS_BRANCH_NAME=""                # ENTER BRANCH NAME HERE IF KNOWN
SOOS_BRANCH_URI=""                 # ENTER BRANCH URI HERE IF KNOWN
SOOS_BUILD_VERSION=""              # ENTER BUILD VERSION HERE IF KNOWN
SOOS_BUILD_URI=""                  # ENTER BUILD URI HERE IF KNOWN

# **************************** Modify Above Only ***************#
WORKING_DIR="${SOURCE_CODE_PATH}/soos"
WORKSPACE="${WORKING_DIR}/workspace"
SCRIPT_FILE_NAME="soos.py"
REQUIREMENTS_FILE_NAME="requirements.txt"

echo ""
echo "Setting Up Workspace..."
mkdir -p "${WORKSPACE}"

cd ${WORKING_DIR}

echo ""
echo "Downloading..."
curl -s $SOOS_LATEST_REPO | grep "browser_download_url" | cut -d '"' -f 4 | xargs -n 1 curl -LO

echo ""
echo "Setting Up Environment..."
python3 -m venv ./
source bin/activate

echo ""
echo "Installing Packages..."
pip3 install -r "${WORKING_DIR}/${REQUIREMENTS_FILE_NAME}"

echo ""
echo "Running Scan..."
python3 "${WORKING_DIR}/${SCRIPT_FILE_NAME}" \
  -m="${SOOS_MODE}" \
  -of="${SOOS_ON_FAILURE}" \
  -dte="${SOOS_DIRS_TO_EXCLUDE}" \
  -fte="${SOOS_FILES_TO_EXCLUDE}" \
  -wd="${WORKING_DIR}" \
  -armw=${SOOS_ANALYSIS_RESULT_MAX_WAIT} \
  -arpi=${SOOS_ANALYSIS_RESULT_POLLING_INTERVAL} \
  -buri="${SOOS_API_BASE_URL}" \
  -scp="${SOURCE_CODE_PATH}" \
  -pn="${SOOS_PROJECT_NAME}" \
  -ch="${SOOS_COMMIT_HASH}" \
  -bn="${SOOS_BRANCH_NAME}" \
  -bruri="${SOOS_BRANCH_URI}" \
  -bldver="${SOOS_BUILD_VERSION}" \
  -blduri="${SOOS_BUILD_URI}" \
  -cid="${SOOS_CLIENT_ID}" \
  -akey="${SOOS_API_KEY}"