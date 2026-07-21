# TWRP device tree for Bangkk sm6375 series

## Supported devices
sm6375 serie
## Build it yourself?

```
mkdir twrp && cd twrp
repo init --depth=1 -u https://github.com/TWRP-Test/platform_manifest_twrp_aosp.git -b twrp-16.0
repo sync
```

```
. build/envsetup.sh
lunch twrp_bangkk-bp2a-eng
mka bootimage
```

If there is no error, boot.img will be found in out/target/product/bangkk/boot.img  


## Features
Works:
- [X] ADB
- [X] Display
- [X] Decryption
- [X] Fasbootd
- [X] Flashing
- [X] MTP
- [X] Sideload
- [X] Touch
- [X] USB OTG
- [X] Vibrator

## To use it:

```
fastboot boot boot.img
or to make permanent
fastboot boot boot.img 
from recovery flash current twrp 
reboot to recovery
```
