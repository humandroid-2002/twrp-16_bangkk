#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

clone_if_missing() {
    local REPO="$1"
    local BRANCH="$2"
    local DEST="$3"

    if [ ! -d "$DEST/.git" ]; then
        echo "Cloning $DEST..."
        mkdir -p "$(dirname "$DEST")"
        git clone --depth=1 -b "$BRANCH" "$REPO" "$DEST"
    fi
}

# Required repositories
clone_if_missing https://github.com/LineageOS/android_hardware_qcom_bootctrl.git lineage-19.1-caf hardware/qcom-caf/bootctrl
clone_if_missing https://gitlab.com/inferno0230/clang-r487747c.git thirteen prebuilts/clang/host/linux-x86/clang-r487747c
clone_if_missing https://github.com/LineageOS/android_kernel_motorola_sm6375.git lineage-23.2 kernel/motorola/sm6375

export LC_ALL="C"
export ALLOW_MISSING_DEPENDENCIES=true
