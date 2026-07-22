## This device tree may be used as a base for other Motorola devices sharing the same SoC,changes are required.
			
			
			
# TWRP device tree for Bangkk sm6375 series

## Features
Works:
- [X] ADB
- [X] Display
- [X] Decryption!
- [X] Fasbootd
- [X] Flashing
- [X] MTP
- [X] Sideload
- [X] Touch
- [X] USB OTG
- [X] Vibrator
- [ ] WLAN (if I ever feel like it)
##
## Build it yourself?

### Prerequisites

- Kernel and modules must come from the same ROM (LineageOS recommended) to match vermagic.

### Kernel

This tree uses a prebuilt kernel extracted from LineageOS. To extract your own:

```bash
adb pull /dev/block/bootdevice/by-name/boot_a boot.img
unpackbootimg --boot_img boot.img --out unpacked
gzip -9 -k unpacked/kernel
cp unpacked/kernel.gz device/motorola/bangkk/prebuilt/kernel
```

### Modules

Extract from a running LineageOS 23 device:

```bash
adb pull /vendor/lib/modules/ modules/
```

Place the `.ko` files in `recovery/root/vendor/lib/modules/1.1/`.

### Touch Firmware

Extract from a running LineageOS device:

```bash
adb pull /vendor/firmware/ firmware/
```

Place the files in `recovery/root/vendor/firmware/`.

### GitHub Actions

The easiest way to build is via GitHub Actions:

1. Fork any action twrp builder
2. Go to Actions > "Build TWRP for Moto G84" > Run workflow
3. Download the `boot.img` artifact when the build completes

### Local Build

```bash
mkdir ~/twrp && cd ~/twrp
repo init --depth=1 -u https://github.com/TWRP-Test/platform_manifest_twrp_aosp.git -b twrp-16.0
repo sync -c -j$(nproc) --force-sync --no-clone-bundle --no-tags
# Copy device tree to device/motorola/bangkk/
source build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
lunch twrp_bangkk-bp2a-eng
mka bootimage -j$(nproc)
```

Output: `out/target/product/bangkk/boot.img`

## Installation

> **Important:** Since this device uses recovery-as-boot, TWRP is flashed to the boot partition, not recovery.

1. Boot into bootloader: `adb reboot bootloader`
2. Temporarily boot TWRP: `fastboot boot boot.img`
3. Inside TWRP: Install > flash current (makes TWRP permanent)
4. Inside TWRP: Install > Magisk.apk (installs root)
5. Reboot to system
6. Open Magisk app > Direct Install > Reboot

Do **not** attempt to patch `boot.img` with Magisk before flashing. Install Magisk from within TWRP.

## Credits

- [TeamWin](https://github.com/TeamWin) - TWRP device tree generator
- [LineageOS](https://github.com/LineageOS) - Kernel and modules
