#!/system/bin/sh
#
# OrangeFox Recovery - bangkk
# Copy vendor kernel modules to /odm/lib/modules
#

SRC="/vendor/lib/modules"
DST="/tmp/lib/modules"
LOG="/tmp/cpko.log"
PROP="post.decrypt.modules"

twrp mount vendor

log() {
    echo "[OF-MODULES] $*" >> "$LOG"
}

fail() {
    log "ERRORE: $*"
    echo "[OF-MODULES] ERRORE: $*" > /dev/kmsg 2>/dev/null
    exit 1
}

log "========== INIZIO COPIA MODULI =========="

# 1. Verifica sorgente; prova a montare vendor se necessario.
if [ ! -d "$SRC" ]; then
    log "Directory sorgente assente; provo mount vendor"
    mount vendor >> "$LOG" 2>&1
fi

[ -d "$SRC" ] || fail "Sorgente non disponibile: $SRC"

# Verifica che la sorgente non sia vuota.
FIRST_FILE=$(find "$SRC" -type f 2>/dev/null | head -n 1)
[ -n "$FIRST_FILE" ] || fail "Nessun file trovato in $SRC"

# 2. Prepara la destinazione.
mkdir -p "$DST" || fail "Impossibile creare $DST"

# Verifica che la destinazione sia scrivibile.
TESTFILE="$DST/.of_write_test"
if ! touch "$TESTFILE" 2>>"$LOG"; then
    fail "Destinazione non scrivibile: $DST"
fi
rm -f "$TESTFILE"

# 3. Copia tutto, inclusi sottodirectory, .ko e modules.*.
log "Copio $SRC/. -> $DST/"

if cp -a "$SRC/." "$DST/" >> "$LOG" 2>&1; then
    log "cp -a completato"
else
    fail "cp -a fallito; controllare $LOG"
fi

# 4. Verifica i file fondamentali, se presenti nella sorgente.
for name in modules.load modules.dep modules.alias modules.softdep wlan.ko; do
    if [ -f "$SRC/$name" ]; then
        [ -f "$DST/$name" ] ||
            fail "File mancante dopo la copia: $name"

        src_size=$(wc -c < "$SRC/$name" | tr -d ' ')
        dst_size=$(wc -c < "$DST/$name" | tr -d ' ')

        [ "$src_size" = "$dst_size" ] ||
            fail "Dimensione errata per $name ($src_size != $dst_size)"

        log "Verificato: $name ($dst_size byte)"
    fi
done

# 5. Verifica che il modulo WLAN sia disponibile.
if [ -f "$SRC/wlan.ko" ] && [ ! -s "$DST/wlan.ko" ]; then
    fail "wlan.ko assente o vuoto nella destinazione"
fi

# 6. Conta i moduli copiati.
COUNT=$(find "$DST" -type f -name '*.ko' 2>/dev/null | wc -l | tr -d ' ')
log "Moduli .ko presenti nella destinazione: $COUNT"

[ "$COUNT" -gt 0 ] || fail "Nessun modulo .ko nella destinazione"

# 7. Attiva il trigger .rc soltanto dopo la copia riuscita.
log "Copia completata; imposto $PROP=true"
setprop "$PROP" true

# Verifica la proprietà.
VALUE=$(getprop "$PROP")
[ "$VALUE" = "true" ] ||
    fail "Impossibile impostare la proprietà $PROP"

log "Proprieta' verificata: $PROP=$VALUE"
log "========== COPIA MODULI COMPLETATA =========="
umount /vendor
setprop twrp.modules.loaded true
resetprop twrp.modules.loaded true
setprop twrp.cpko true
mount /mnt/vendor/persist
mount /mnt/product/persist
exit 0
