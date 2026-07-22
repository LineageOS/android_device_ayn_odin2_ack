#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

## Common
# LEDs
BOARD_VENDOR_KERNEL_MODULES_LOAD := \
    leds-group-multicolor \
    leds-htr3212

# Copy to boot
BOOT_KERNEL_MODULES := \
    display-connector.ko \
    lontium-lt8912b.ko \
    edt-ft5x06.ko

## Odin 2
# LEDs
BOARD_VENDOR_KERNEL_MODULES_LOAD += \
    leds-pwm-multicolor

# Copy to boot
BOOT_KERNEL_MODULES += \
    panel-synaptics-td4328.ko \
    pwm-sn3112.ko \
    pwm_bl.ko \
    rmi_core.ko \
    rmi_i2c.ko

## Odin 2 Mini
# Copy to boot
BOOT_KERNEL_MODULES += \
    panel-xiamen-xm91080.ko \
    odin2mini-backlight.ko \
    hynitron_cstxxx.ko

## Odin 2 Portal
# Copy to boot
BOOT_KERNEL_MODULES += \
    panel-chipone-icna35xx.ko

## Thor
# Copy to boot
BOOT_KERNEL_MODULES += \
    panel-chipwealth-ch13726a.ko

## Nova
# Copy to boot
BOOT_KERNEL_MODULES += \
    panel-ilitek-ili7836a.ko

## Retroid Pocket 6
# Copy to boot
BOOT_KERNEL_MODULES += \
    panel-visionox-vtdr6130.ko


# Load in first stage boot
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := \
    display-connector \
    lontium-lt8912b \
    panel-chipone-icna35xx \
    panel-chipwealth-ch13726a \
    panel-ilitek-ili7836a \
    panel-synaptics-td4328 \
    panel-visionox-vtdr6130 \
    panel-xiamen-xm91080 \
    pwm-sn3112 \
    pwm_bl \
    odin2mini-backlight \
    rmi_i2c \
    hynitron_cstxxx \
    edt-ft5x06
