#!/system/bin/sh

MODDIR=/vendor/lib/modules/1.1
LOG=/tmp/bangkk_modules.log

echo "Loading bangkk modules" > $LOG

while read mod
do
    [ -z "$mod" ] && continue

    echo "Loading $mod" >> $LOG

    modprobe -d /vendor -S 1.1 $mod 2>>$LOG

done < $MODDIR/modules.load
