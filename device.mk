#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

AB_OTA_UPDATER := true

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += device/ayn/odin2_ack

include device/ayn/qcs8550-ack/qcs8550.mk

PRODUCT_CHARACTERISTICS   := tv
PRODUCT_AAPT_PREBUILT_DPI := xxhdpi xhdpi hdpi mdpi hdpi tvdpi
PRODUCT_AAPT_PREF_CONFIG  := xhdpi

# Inherit from vendor blobs
$(call inherit-product, vendor/ayn/odin2_ack/odin2_ack-vendor.mk)

PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Enforce generic ramdisk allow list
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

# Audio
PRODUCT_SOONG_NAMESPACES += \
    hardware/qcom/audioreach-topology
PRODUCT_PACKAGES += \
    qcom-sm8550-odin2-tplg

# Updater
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)
AB_OTA_PARTITIONS += \
    boot \
    init_boot \
    odm \
    product \
    recovery \
    system \
    system_dlkm \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_boot \
    vendor_dlkm
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true
AB_OTA_POSTINSTALL_CONFIG += \
    FILESYSTEM_TYPE_product=ext4 \
    POSTINSTALL_PATH_product=bin/ayn_bootloader_payload_updater \
    RUN_POSTINSTALL_product=true
PRODUCT_PACKAGES += \
    ayn_bootloader_payload_updater \
    checkpoint_gc
