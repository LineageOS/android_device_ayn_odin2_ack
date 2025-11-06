#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit some common lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_tv.mk)

# Inherit device configuration for odin2_ack.
$(call inherit-product, device/ayn/odin2_ack/full_odin2_ack.mk)

# Boot Animation
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH  := 1080

PRODUCT_NAME := lineage_odin2_ack
