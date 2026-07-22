#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/motorola/bangkk

# A/B
PRODUCT_USE_DYNAMIC_PARTITIONS := true
TARGET_ENFORCE_AB_OTA_PARTITION_LIST := true
TARGET_OTA_ASSERT_DEVICE := bangkk,bangkk_retcn,bangkk_reteu,bangkk_retus,bangkk_retla

AB_OTA_POSTINSTALL_CONFIG += \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    RUN_POSTINSTALL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    RUN_POSTINSTALL_vendor=true

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

# Update engine
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service \
    vendor_kernel_prebuilts

PRODUCT_PACKAGES += \
    bootctrl.holi

PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# Keystore
PRODUCT_PACKAGES += \
    android.system.keystore2

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

PRODUCT_EXTRA_RECOVERY_KEYS += \
    $(LOCAL_PATH)/security/ota

PRODUCT_PACKAGES += \
    bangkk_modules

PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)
