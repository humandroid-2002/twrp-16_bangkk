#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/motorola/bangkk
# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

# Update engine
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

# Boot control
PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-impl-qti.recovery \
    bootctrl.holi.recovery

PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

TARGET_RECOVERY_DEVICE_MODULES += \
    libion \
    libxml2 \
    vendor.display.config@2.0
    
PRODUCT_SHIPPING_API_LEVEL := 30
PRODUCT_TARGET_VNDK_VERSION := 30

# QCOM Decrypt
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# Keystore2
PRODUCT_PACKAGES += \
    android.system.keystore2

PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)
