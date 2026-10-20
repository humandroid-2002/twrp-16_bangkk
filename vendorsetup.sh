#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

export USE_CCACHE=1
export CCACHE_EXEC="/usr/bin/ccache"
export CCACHE_MAXSIZE="50G"
export CCACHE_DIR="/mnt/ccache"

# Warn if CCACHE_DIR is an invalid directory
if [ "$USE_CCACHE" = "1" ] && [ ! -d "${CCACHE_DIR}" ]; then
    echo "CCACHE Directory/Partition is not mounted at \"${CCACHE_DIR}\""
    echo "Please edit the CCACHE_DIR build variable or mount the directory."
fi
export ALLOW_MISSING_DEPENDENCIES=true

