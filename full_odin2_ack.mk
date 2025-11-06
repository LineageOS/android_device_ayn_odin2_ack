#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, device/google/atv/products/atv_base.mk)
$(call inherit-product, device/ayn/odin2_ack/device.mk)

# Set those variables here to overwrite the inherited values.
PRODUCT_NAME := full_odin2_ack
PRODUCT_DEVICE := odin2_ack
PRODUCT_BRAND := qti
PRODUCT_MANUFACTURER := AYN
PRODUCT_MODEL := Odin2
