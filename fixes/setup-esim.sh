#!/bin/bash

echo "Setting up eSim libraries for the first time..."

# Define target directory
TARGET="$HOME/.local/kicad/6.0"

# Flag file to prevent re-running setup
FLAG="$TARGET/.esim_kicad_setup_done"

# Check if setup already done
if [ -f "$FLAG" ]; then
    echo "eSim libraries already set up."
    exit 0
fi

# Create target directory if it doesn't exist
mkdir -p "$TARGET"

# ------------------------------------------------------------
# FIX: Updated path due to repository restructuring
# Original path used in script:
#   /3rdparty/template/sym-lib-table  (invalid)
# Actual location in repository:
#   library/kicadLibrary/template/sym-lib-table
#
# This fix ensures correct file resolution relative to script.
# ------------------------------------------------------------

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

cp "$BASE_DIR/library/kicadLibrary/template/sym-lib-table" "$TARGET/"

# Mark setup as completed
touch "$FLAG"

echo "eSim libraries setup completed."
