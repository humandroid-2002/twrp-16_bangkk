#!/system/bin/sh

MODULES_DIR="/vendor/lib/modules/1.1"
FW_DIR="/vendor/firmware"

# Aspetta che vendor sia montato
while [ ! -d "$MODULES_DIR" ]; do
    sleep 1
done

log() {
    echo "$1" >> /tmp/recovery.log
}

load_mod() {
    local mod="$1"
    local path="$MODULES_DIR/$mod.ko"

    if [ -f "$path" ]; then
        if ! grep -q "^$mod " /proc/modules 2>/dev/null; then
            if insmod "$path"; then
                log "Loaded $mod"
            else
                log "Failed to load $mod"
            fi
        else
            log "Already loaded: $mod"
        fi
    else
        log "Missing file for module: $mod"
    fi
}

for mod in \
    lzo_decompress \
    lzo_compress \
    lzo \
    lzo-rle
do
    load_mod "$mod"
done

for mod in \
    sensors_class \
    mmi_annotate \
    mmi_relay \
    mmi_info \
    touchscreen_mmi \
    focaltech_v3 \
    goodix_brl_mmi \
    sx937x_sar \
    awinic_sar \
    rbs_fod_mmi \
    mmi_sys_temp
do
    load_mod "$mod"
done

for mod in \
    q6_pdr_dlkm \
    snd_event_dlkm \
    q6_notifier_dlkm \
    apr_dlkm \
    q6_dlkm \
    swr_dlkm \
    wcd_core_dlkm \
    wcd9xxx_dlkm \
    mbhc_dlkm \
    bolero_cdc_dlkm \
    aw87xxx_dlkm \
    wcd937x_dlkm \
    wcd938x_dlkm \
    wcd937x_slave_dlkm \
    wcd938x_slave_dlkm \
    wsa881x_analog_dlkm \
    aw882xx_acf \
    aw882xx_k419 \
    swr_ctrl_dlkm \
    rx_macro_dlkm \
    tx_macro_dlkm \
    va_macro_dlkm \
    machine_dlkm \
    platform_dlkm \
    native_dlkm \
    adsp_loader_dlkm \
    pinctrl_lpi_dlkm
do
    load_mod "$mod"
done

for mod in \
    camera \
    cci_intf
do
    load_mod "$mod"
done

for mod in \
    rmnet_ctl \
    rmnet_core \
    rmnet_offload \
    rmnet_shs
do
    load_mod "$mod"
done

for mod in \
    btpower \
    bt_fm_slim
do
    load_mod "$mod"
done

for mod in \
    bq25980_mmi_iio \
    mmi_parallel_charger_iio \
    mmi-smbcharger-iio \
    qpnp_adaptive_charge \
    ldo_vibrator_mmi \
    stub_dlkm \
    utags \
    rdbg
do
    load_mod "$mod"
done

for mod in \
    wlan \
    zram \
    exfat \
    sec_nfc
do
    load_mod "$mod"
done

# Firmware check
if [ -d "$FW_DIR" ]; then
    log "Firmware presente"
fi

mkdir /firmware
SLOT=$(getprop ro.boot.slot_suffix)
mount /dev/block/bootdevice/by-name/modem$SLOT /firmware -O ro
echo "1" > /proc/sys/kernel/firmware_config/force_sysfs_fallback
echo "1" > /sys/kernel/boot_adsp/boot

sleep 5

# Mount RW
mount -o rw /system_root
mount -o rw /system_ext
mount -o rw /system
mount -o rw /product
mount -o rw /vendor

# Verifica moduli caricati
MODULES_OK=1

for mod in \
    lzo_decompress \
    lzo_compress \
    lzo \
    lzo-rle \
    sensors_class \
    mmi_annotate \
    mmi_relay \
    mmi_info \
    touchscreen_mmi \
    focaltech_v3 \
    goodix_brl_mmi \
    sx937x_sar \
    awinic_sar \
    rbs_fod_mmi \
    mmi_sys_temp \
    q6_pdr_dlkm \
    snd_event_dlkm \
    q6_notifier_dlkm \
    apr_dlkm \
    q6_dlkm \
    swr_dlkm \
    wcd_core_dlkm \
    wcd9xxx_dlkm \
    mbhc_dlkm \
    bolero_cdc_dlkm \
    aw87xxx_dlkm \
    wcd937x_dlkm \
    wcd938x_dlkm \
    wcd937x_slave_dlkm \
    wcd938x_slave_dlkm \
    wsa881x_analog_dlkm \
    aw882xx_acf \
    aw882xx_k419 \
    swr_ctrl_dlkm \
    rx_macro_dlkm \
    tx_macro_dlkm \
    va_macro_dlkm \
    machine_dlkm \
    platform_dlkm \
    native_dlkm \
    adsp_loader_dlkm \
    pinctrl_lpi_dlkm \
    camera \
    cci_intf \
    rmnet_ctl \
    rmnet_core \
    rmnet_offload \
    rmnet_shs \
    btpower \
    bt_fm_slim \
    bq25980_mmi_iio \
    mmi_parallel_charger_iio \
    mmi-smbcharger-iio \
    qpnp_adaptive_charge \
    ldo_vibrator_mmi \
    stub_dlkm \
    utags \
    rdbg \
    wlan \
    zram \
    exfat \
    sec_nfc
do
    if [ ! -d "/sys/module/$mod" ]; then
        log "Module missing: $mod"
        MODULES_OK=0
    fi
done

if [ "$MODULES_OK" -eq 1 ]; then
    setprop twrp.modules.loaded true
    log "All modules loaded successfully."
else
    setprop twrp.modules.loaded true
    log "Some modules failed to load."
fi

exit 0
