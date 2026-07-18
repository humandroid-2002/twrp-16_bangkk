#!/system/bin/sh

MODULES_DIR="/vendor/lib/modules/1.1"
FW_DIR="/vendor/firmware"

while [ ! -d /vendor/lib/modules ]; do
    sleep 1
done

# Carica i moduli necessari
for mod in \
    mmi_annotate \
    mmi_info \
    mmi_relay \
    mmi_sys_temp \
    touchscreen_mmi \
    goodix_brl_mmi \
    focaltech_v3 \
    sensors_class \
    qpnp_adaptive_charge \
    q6_pdr_dlkm \
    q6_notifier_dlkm \
    adsp_loader_dlkm \
    snd_event_dlkm
do
    if ! lsmod | grep -q "^$mod"; then
        if [ -f "$MODULES_DIR/$mod.ko" ]; then
            insmod "$MODULES_DIR/$mod.ko"
            echo "Loaded $mod" >> /tmp/recovery.log
        fi
    fi
done

# Verifica firmware
[ -d "$FW_DIR" ] && echo "Firmware present" >> /tmp/recovery.log

exit 0
