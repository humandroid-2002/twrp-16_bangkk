#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/motorola/bangkk

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-impl-qti.recovery \
    bootctrl.holi

# Recovery
TARGET_RECOVERY_DEVICE_MODULES += \
    libion \
    libxml2

# Decrypt
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe \
    android.system.keystore2

# Product
PRODUCT_SHIPPING_API_LEVEL     := 30
PRODUCT_TARGET_VNDK_VERSION    := 30
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Copy for recovery prebuilt kernel modules 2026-07-17
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)
