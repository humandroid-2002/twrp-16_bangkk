#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Omni stuff.
$(call inherit-product, vendor/omni/config/common.mk)

# Inherit from bangkk device
$(call inherit-product, device/motorola/bangkk/device.mk)

PRODUCT_DEVICE := bangkk
PRODUCT_NAME := omni_bangkk
PRODUCT_BRAND := motorola
PRODUCT_MODEL := Holi for arm64
PRODUCT_MANUFACTURER := motorola

PRODUCT_GMS_CLIENTID_BASE := android-motorola

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="bangkk_g-user 11 V1TCS35H.88-16-6 9ef38 release-keys"

BUILD_FINGERPRINT := motorola/bangkk_g/bangkk:11/V1TCS35H.88-16-6/9ef38:user/release-keys
