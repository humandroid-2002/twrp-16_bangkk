#!/system/bin/sh
#
# OrangeFox Recovery Project
# Load kernel modules from /odm/lib/modules
#

MODDIR="/lib/modules"
LOG="/tmp/recovery.log"
LOADED="/tmp/odm_modules_loaded"
FAILED="/tmp/odm_modules_failed"

log() {
    echo "[odm-modules] $*" >> "$LOG"
}

# Cerca un modulo e restituisce il suo percorso relativo a MODDIR.
find_module() {
    name="$1"

    # Rimuove eventuali spazi iniziali/finali e CR.
    name=$(echo "$name" | tr -d '\r')

    [ -z "$name" ] && return 1

    case "$name" in
        /*)
            case "$name" in
                "$MODDIR"/*) name="${name#"$MODDIR"/}" ;;
                *) return 1 ;;
            esac
            ;;
    esac

    if [ -f "$MODDIR/$name" ]; then
        echo "$name"
        return 0
    fi

    case "$name" in
        *.ko) base="${name##*/}" ;;
        *)    base="${name##*/}.ko" ;;
    esac

    # Cerca anche nei sottodirettori.
    find "$MODDIR" -type f -name "$base" 2>/dev/null |
        sed "s#^$MODDIR/##" |
        head -n 1
}

# Carica un modulo e tutte le sue dipendenze prima di esso.
load_module() {
    rel="$1"
    [ -z "$rel" ] && return 1

    path="$MODDIR/$rel"
    [ -f "$path" ] || {
        log "ERRORE: modulo non trovato: $rel"
        echo "$rel" >> "$FAILED"
        return 1
    }

    # Evita di caricare due volte lo stesso file.
    grep -Fqx "$rel" "$LOADED" 2>/dev/null && return 0

    # Se è già caricato nel kernel, non usare nuovamente insmod.
    modname="${rel##*/}"
    modname="${modname%.ko}"
    modname=$(echo "$modname" | tr '-' '_')

    if grep -q "^${modname} " /proc/modules 2>/dev/null; then
        log "Gia' caricato: $rel"
        echo "$rel" >> "$LOADED"
        return 0
    fi

    # Legge le dipendenze da modules.dep.
    if [ -f "$MODDIR/modules.dep" ]; then
        deps=$(awk -v target="$rel" '
            {
                file = $1
                sub(/:$/, "", file)
                if (file == target) {
                    for (i = 2; i <= NF; i++)
                        print $i
                    exit
                }
            }
        ' "$MODDIR/modules.dep")

        for dep in $deps; do
            load_module "$dep" || {
                log "ERRORE: dipendenza $dep non caricata per $rel"
                echo "$rel" >> "$FAILED"
                return 1
            }
        done
    fi

    log "Caricamento: $rel"
    if insmod "$path" >> "$LOG" 2>&1; then
        echo "$rel" >> "$LOADED"
        log "OK: $rel"
        return 0
    else
        log "ERRORE insmod: $rel"
        echo "$rel" >> "$FAILED"
        return 1
    fi
}

main() {
    if [ ! -d "$MODDIR" ]; then
        log "ERRORE: directory inesistente: $MODDIR"
        return 1
    fi

    : > "$LOADED"
    : > "$FAILED"

    log "Inizio caricamento da $MODDIR"

    if [ -f "$MODDIR/modules.load" ]; then
        log "Uso modules.load"

        while IFS= read -r module || [ -n "$module" ]; do
            module=$(echo "$module" | tr -d '\r')

            # Ignora righe vuote e commenti.
            case "$module" in
                ""|\#*) continue ;;
            esac

            rel=$(find_module "$module")
            if [ -z "$rel" ]; then
                log "ERRORE: modulo in modules.load non trovato: $module"
                echo "$module" >> "$FAILED"
                continue
            fi

            load_module "$rel"
        done < "$MODDIR/modules.load"

    elif [ -f "$MODDIR/modules.dep" ]; then
        log "modules.load assente: uso modules.dep"

        while IFS= read -r line || [ -n "$line" ]; do
            rel="${line%%:*}"
            [ -z "$rel" ] && continue
            load_module "$rel"
        done < "$MODDIR/modules.dep"

    else
        log "ERRORE: modules.load e modules.dep assenti"
        return 1
    fi

    if [ -s "$FAILED" ]; then
        log "Completato con errori. Vedere $FAILED"
    else
        log "Caricamento completato senza errori registrati"
    fi

    return 0
}
setprop post.decrypt.modules true
main
exit $?
