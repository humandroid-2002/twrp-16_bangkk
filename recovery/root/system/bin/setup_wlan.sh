#!/system/bin/sh
#
# OrangeFox Recovery - bangkk
# Load copied kernel modules in modules.load order.
# Does not copy files or set twrp.modules.loaded.
#

DST="/tmp/lib/modules"
LOG="/tmp/insmod.log"

log() {
    echo "[SETUP-WLAN] $*" >> "$LOG"
}

is_loaded() {
    wanted=$(basename "$1" .ko | tr '-' '_')
    awk -v wanted="$wanted" '
        {
            name = $1
            gsub(/-/, "_", name)
            if (name == wanted)
                found = 1
        }
        END { exit !found }
    ' /proc/modules
}

[ -d "$DST" ] || {
    log "ERRORE: directory assente: $DST"
    exit 1
}

[ -s "$DST/wlan.ko" ] || {
    log "ERRORE: wlan.ko assente"
    exit 1
}

log "========== INIZIO CARICAMENTO =========="

OK=0
SKIPPED=0
FAILED=0

for module in \
    wcd9xxx_dlkm.ko \
    aw882xx_acf.ko \
    wsa881x_analog_dlkm.ko \
    btpower.ko \
    q6_pdr_dlkm.ko \
    machine_dlkm.ko \
    zram.ko \
    swr_ctrl_dlkm.ko \
    wcd938x_slave_dlkm.ko \
    q6_notifier_dlkm.ko \
    wcd_core_dlkm.ko \
    wcd937x_slave_dlkm.ko \
    wcd937x_dlkm.ko \
    rx_macro_dlkm.ko \
    platform_dlkm.ko \
    lzo_decompress.ko \
    camera.ko \
    sec_nfc.ko \
    pinctrl_lpi_dlkm.ko \
    wcd938x_dlkm.ko \
    stub_dlkm.ko \
    bt_fm_slim.ko \
    aw87xxx_dlkm.ko \
    adsp_loader_dlkm.ko \
    mbhc_dlkm.ko \
    va_macro_dlkm.ko \
    native_dlkm.ko \
    snd_event_dlkm.ko \
    rdbg.ko \
    lzo-rle.ko \
    bolero_cdc_dlkm.ko \
    q6_dlkm.ko \
    lzo.ko \
    aw882xx_k419.ko \
    lzo_compress.ko \
    apr_dlkm.ko \
    swr_dlkm.ko \
    tx_macro_dlkm.ko \
    wlan.ko \
    rmnet_core.ko \
    rmnet_ctl.ko \
    rmnet_offload.ko \
    rmnet_shs.ko \
    utags.ko \
    mmi_relay.ko \
    mmi_info.ko \
    mmi_annotate.ko \
    sensors_class.ko \
    exfat.ko \
    qpnp_adaptive_charge.ko \
    rbs_fod_mmi.ko \
    sx937x_sar.ko \
    awinic_sar.ko \
    mmi_sys_temp.ko \
    ldo_vibrator_mmi.ko \
    touchscreen_mmi.ko \
    focaltech_v3.ko \
    goodix_brl_mmi.ko \
    cci_intf.ko \
    bq25980_mmi_iio.ko \
    mmi-smbcharger-iio.ko \
    mmi_parallel_charger_iio.ko \
    fm_ctrl.ko
do
    path="$DST/$module"

    if [ ! -s "$path" ]; then
        log "ASSENTE: $module"
        FAILED=$((FAILED + 1))
        continue
    fi

    if is_loaded "$module"; then
        log "GIA' CARICATO: $module"
        SKIPPED=$((SKIPPED + 1))
        continue
    fi

    log "INSmod: $module"

    if insmod "$path" >> "$LOG" 2>&1; then
        log "OK: $module"
        OK=$((OK + 1))
    else
        log "ERRORE: $module"
        FAILED=$((FAILED + 1))
    fi
done

log "Risultato: caricati=$OK gia_presenti=$SKIPPED errori=$FAILED"

# Non attivare post.decrypt.modules se WLAN non risulta caricato.
if ! is_loaded wlan.ko; then
    log "ERRORE: wlan non risulta caricato; proprietà non impostata"
    exit 1
fi

log "VERIFICATO: wlan presente in /proc/modules"

# Imposta post.decrypt.modules soltanto dopo la verifica WLAN.
log "Imposto post.decrypt.modules=true tramite resetprop"
resetprop post.decrypt.modules true

VALUE=$(getprop post.decrypt.modules)
if [ "$VALUE" != "true" ]; then
    log "ERRORE: post.decrypt.modules non impostata"
    exit 1
fi

log "Proprieta' verificata: post.decrypt.modules=$VALUE"
log "========== FINE CARICAMENTO =========="

exit 0
