#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/motorola/bangkk

# Build rules
ALLOW_MISSING_DEPENDENCIES                      := true
BUILD_BROKEN_DUP_RULES                          := true
BUILD_BROKEN_USES_NETWORK                       := true
BUILD_BROKEN_MISSING_REQUIRED_MODULES           := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES    := true


BUILD_BROKEN_NINJA_USES_ENV_VARS    += RTIC_MPGEN
BUILD_BROKEN_PLUGIN_VALIDATION      := soong-libaosprecovery_defaults soong-libguitwrp_defaults soong-libminuitwrp_defaults soong-vold_defaults

# A/B
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_boot

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := kryo300

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a75

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := bangkk
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true

# Display
TARGET_SCREEN_DENSITY := 400

# Kernel
BOARD_BOOTIMG_HEADER_VERSION := 3
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
BOARD_KERNEL_CMDLINE += firmware_class.path=/vendor/firmware_mnt/image
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_PAGESIZE := 4096
TARGET_KERNEL_CONFIG := bangkk_defconfig
TARGET_KERNEL_SOURCE := kernel/motorola/bangkk
TW_LOAD_VENDOR_BOOT_MODULES := true
TW_LOAD_PREBUILT_MODULES_AT_FIRST := true
BOARD_RECOVERY_RAMDISK_KERNEL_MODULES := \
    $(wildcard device/motorola/bangkk/prebuilt/vendor/lib/modules/1.1/*.ko)
TW_LOAD_VENDOR_MODULES := "adsp_loader_dlkm.ko apr_dlkm.ko aw87xxx_dlkm.ko aw882xx_acf.ko aw882xx_k419.ko awinic_sar.ko bolero_cdc_dlkm.ko bq25980_mmi_iio.ko bt_fm_slim.ko btpower.ko camera.ko cci_intf.ko exfat.ko fm_ctrl.ko focaltech_v3.ko goodix_brl_mmi.ko ldo_vibrator_mmi.ko lzo.ko lzo_compress.ko lzo_decompress.ko lzo-rle.ko machine_dlkm.ko mbhc_dlkm.ko mmi_annotate.ko mmi_info.ko mmi_parallel_charger_iio.ko mmi_relay.ko mmi-smbcharger-iio.ko mmi_sys_temp.ko native_dlkm.ko pinctrl_lpi_dlkm.ko platform_dlkm.ko q6_dlkm.ko q6_notifier_dlkm.ko q6_pdr_dlkm.ko qpnp_adaptive_charge.ko rbs_fod_mmi.ko rdbg.ko rmnet_core.ko rmnet_ctl.ko rmnet_offload.ko rmnet_shs.ko rx_macro_dlkm.ko sec_nfc.ko sensors_class.ko snd_event_dlkm.ko stub_dlkm.ko swr_ctrl_dlkm.ko swr_dlkm.ko sx937x_sar.ko touchscreen_mmi.ko tx_macro_dlkm.ko utags.ko va_macro_dlkm.ko wcd937x_dlkm.ko wcd937x_slave_dlkm.ko wcd938x_dlkm.ko wcd938x_slave_dlkm.ko wcd9xxx_dlkm.ko wcd_core_dlkm.ko wlan.ko wsa881x_analog_dlkm.ko zram.ko"
# Kernel - prebuilt
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
endif

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 100663296
BOARD_SYSTEMIMAGE_JOURNAL_SIZE := 0
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM := system
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR := vendor
TREBLE_PARTITIONS := vendor
BOARD_SUPER_PARTITION_SIZE := 9126805504 # TODO: Fix hardcoded value
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext product vendor odm
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 9122611200 # TODO: Fix hardcoded value
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED  := true
BOARD_USES_METADATA_PARTITION := true
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery.fstab
BOARD_ROOT_EXTRA_SYMLINKS := \
    /vendor/fsg:/fsg
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

#Crypto
FIXED_DECRYPT := true
TW_INCLUDE_CRYPTO := $(FIXED_DECRYPT)
TW_INCLUDE_CRYPTO_FBE := $(FIXED_DECRYPT)
TW_INCLUDE_FBE_METADATA_DECRYPT := $(FIXED_DECRYPT)
BOARD_USES_QCOM_FBE_DECRYPTION := $(FIXED_DECRYPT)

# Platform
BOARD_USES_RECOVERY_AS_BOOT := true
TARGET_BOARD_PLATFORM := holi
TARGET_SUPPORTS_64_BIT_APPS := true
BUILD_BROKEN_DUP_RULES := true
ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TW_INCLUDE_FASTBOOTD       := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_SUPPRESS_SECURE_ERASE := true
RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libxml2.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so

# Verified Boot
BOARD_AVB_ENABLE := true

# Hack: prevent anti rollback
PLATFORM_VERSION                := 99.87.36
PLATFORM_VERSION_LAST_STABLE    := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH         := 2099-12-31
VENDOR_SECURITY_PATCH           := $(PLATFORM_SECURITY_PATCH)
BOOT_SECURITY_PATCH             := $(PLATFORM_SECURITY_PATCH)

TW_DEVICE_VERSION := bangkk

# TWRP Configuration
TW_THEME                    := portrait_hdpi
TW_EXTRA_LANGUAGES          := false
TW_NO_SCREEN_BLANK          := true
TW_INPUT_BLACKLIST          := "hbtp_vm"
TW_BRIGHTNESS_PATH          := "/sys/class/backlight/panel0-backlight/brightness"
TW_CUSTOM_CPU_TEMP_PATH     := "/sys/class/thermal/thermal_zone28/temp" # CPU-0-0-USR
TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file
TW_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_DEFAULT_TIME_ZONE        := UTC+1
TW_DEFAULT_TIME_ZONE_GUISEL := Europe/Rome
TW_DEFAULT_TIME_ZONE_GUIOFFSET := 60
TW_DEFAULT_TIME_ZONE_GUIDST := 60
TW_MAX_BRIGHTNESS           := 4095
TW_DEFAULT_BRIGHTNESS       := 3048
TW_FRAMERATE                := 120
TW_CUSTOM_BATTERY_POS       := 810
TW_CUSTOM_CLOCK_POS         := 50
TW_CUSTOM_CPU_POS           := 280
TW_STATUS_ICONS_ALIGN       := center
TW_HAS_FLASHLIGHT           := false
RECOVERY_SDCARD_ON_DATA     := true
TARGET_USES_MKE2FS          := true
TW_ENABLE_FS_COMPRESSION    := true
TW_INCLUDE_FUSE_EXFAT       := true
TW_EXCLUDE_APEX             := true
TW_EXCLUDE_TWRPAPP          := true
TW_BACKUP_EXCLUSIONS        := /data/fonts

# Battery
TW_USE_LEGACY_BATTERY_SERVICES := true
TARGET_RECOVERY_QCOM_RTC_FIX := true

#tools
TW_INCLUDE_FB2PNG := true
TW_USE_TOOLBOX := true
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_LIBRESETPROP := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_FUSE_NTFS := true
TW_INCLUDE_NTFS_3G := true
TW_INCLUDE_LPDUMP := true
TW_INCLUDE_LPTOOLS := true
TW_INCLUDE_7ZA := true
TW_INCLUDE_ZSTD := true
TW_USE_DMCTL := true

# Debug
TARGET_USES_LOGD                := true
TWRP_INCLUDE_LOGCAT             := true
TARGET_RECOVERY_DEVICE_MODULES  += debuggerd
TARGET_RECOVERY_DEVICE_MODULES  += strace
RECOVERY_BINARY_SOURCE_FILES    += $(TARGET_OUT_EXECUTABLES)/debuggerd
RECOVERY_BINARY_SOURCE_FILES    += $(TARGET_OUT_EXECUTABLES)/strace

FIXED_HAPTICS := true

ifeq ($(FIXED_HAPTICS),true)
   TW_SUPPORT_INPUT_AIDL_HAPTICS := true
   TW_SUPPORT_INPUT_AIDL_HAPTICS_FQNAME := "IVibrator/default"
   TW_SUPPORT_INPUT_AIDL_HAPTICS_FIX_OFF := true
else
   TW_NO_HAPTICS := true
endif
