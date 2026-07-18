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

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service \
    vendor_kernel_prebuilts

PRODUCT_PACKAGES += \
    bootctrl.holi

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

PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

TW_LOAD_VENDOR_BOOT_MODULES := true

PRODUCT_PACKAGES += \
    bangkk_modules

TW_LOAD_VENDOR_MODULES := "adsp_loader_dlkm.ko apr_dlkm.ko aw87xxx_dlkm.ko aw882xx_acf.ko aw882xx_k419.ko awinic_sar.ko bolero_cdc_dlkm.ko bq25980_mmi_iio.ko bt_fm_slim.ko btpower.ko camera.ko cci_intf.ko exfat.ko fm_ctrl.ko focaltech_v3.ko goodix_brl_mmi.ko ldo_vibrator_mmi.ko lzo.ko lzo_compress.ko lzo_decompress.ko lzo-rle.ko machine_dlkm.ko mbhc_dlkm.ko mmi_annotate.ko mmi_info.ko mmi_parallel_charger_iio.ko mmi_relay.ko mmi-smbcharger-iio.ko mmi_sys_temp.ko native_dlkm.ko pinctrl_lpi_dlkm.ko platform_dlkm.ko q6_dlkm.ko q6_notifier_dlkm.ko q6_pdr_dlkm.ko qpnp_adaptive_charge.ko rbs_fod_mmi.ko rdbg.ko rmnet_core.ko rmnet_ctl.ko rmnet_offload.ko rmnet_shs.ko rx_macro_dlkm.ko sec_nfc.ko sensors_class.ko snd_event_dlkm.ko stub_dlkm.ko swr_ctrl_dlkm.ko swr_dlkm.ko sx937x_sar.ko touchscreen_mmi.ko tx_macro_dlkm.ko utags.ko va_macro_dlkm.ko wcd937x_dlkm.ko wcd937x_slave_dlkm.ko wcd938x_dlkm.ko wcd938x_slave_dlkm.ko wcd9xxx_dlkm.ko wcd_core_dlkm.ko wlan.ko wsa881x_analog_dlkm.ko zram.ko"

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,device/motorola/bangkk/prebuilt/vendor/lib/modules/1.1,$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules)

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/prebuilt/vendor/lib/modules/1.1,$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1)
