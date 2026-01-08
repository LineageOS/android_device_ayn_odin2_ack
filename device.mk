#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

TARGET_MODELS ?= odin2 odin2mini odin2portal thor rp6

TARGET_HAS_VIBRATOR := false

AB_OTA_UPDATER := true

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += device/ayn/odin2_ack

include device/ayn/qcs8550-ack/qcs8550.mk

# Properties
TARGET_VENDOR_PROP += device/ayn/odin2_ack/properties/vendor.prop

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

# Init related
PRODUCT_COPY_FILES += \
    $(foreach model,$(TARGET_MODELS),device/ayn/odin2_ack/init/fstab.odin2:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.$(model)) \
    $(foreach model,$(TARGET_MODELS),device/ayn/odin2_ack/init/fstab.odin2:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.$(model)) \
    $(foreach model,$(TARGET_MODELS),device/ayn/odin2_ack/init/init.$(model).rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(model).rc) \
    $(foreach model,$(TARGET_MODELS),device/ayn/odin2_ack/init/init.recovery.$(model).rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.$(model).rc) \
    device/ayn/odin2_ack/init/init.odin2_common.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.odin2_common.rc \
    device/ayn/odin2_ack/init/init.recovery.odin2_common.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.odin2_common.rc

# Audio
PRODUCT_SOONG_NAMESPACES += \
    hardware/qcom/audioreach-topology
PRODUCT_PACKAGES += \
    qcom-sm8550-odin2-topology

ifeq ($(TARGET_AUDIO_HAL),baylibre)
PRODUCT_COPY_FILES += \
    device/ayn/odin2_ack/audio/mixer_controls.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_controls.xml
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.audio.primary.card_name=AYNOdin2
endif

# Bluetooth
PRODUCT_PACKAGES += \
    bdaddr

# GMS
PRODUCT_GMS_CLIENTID_BASE ?= android-uct

# Firmware
$(call soong_config_set_bool,linux_firmware_mainline,use_product_specific_ath_board2,true)
PRODUCT_PACKAGES += \
    qcom-sm8550-ayn

# Key layouts
PRODUCT_PACKAGES += \
    idc_data_odin2 \
    keylayout_data_odin2

# SKU Specific Configs
PRODUCT_COPY_FILES += \
    device/ayn/odin2_ack/display/device_state_configuration_thor.xml:$(TARGET_COPY_OUT_VENDOR)/etc/displayconfig/device_state_configuration_thor.xml \
    device/ayn/odin2_ack/display/display_id_4630946441858561536.xml:$(TARGET_COPY_OUT_VENDOR)/etc/displayconfig/display_id_4630946441858561536.xml \
    device/ayn/odin2_ack/display/display_id_4630946482288157957.xml:$(TARGET_COPY_OUT_VENDOR)/etc/displayconfig/display_id_4630946482288157957.xml \
    device/ayn/odin2_ack/display/display_layout_configuration_thor.xml:$(TARGET_COPY_OUT_VENDOR)/etc/displayconfig/display_layout_configuration_thor.xml \
    device/ayn/odin2_ack/display/display_settings.xml:$(TARGET_COPY_OUT_VENDOR)/etc/displayconfig/display_settings.xml \
    device/ayn/odin2_ack/init/displayconfig.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/displayconfig.rc
PRODUCT_PACKAGES += \
    device_state_symlink \
    display_layout_symlink \
    ThorOverlay \
    ThorSettingsOverlay \
    ThorOverlayATV

# Unified device support
$(call soong_config_set,libinit,vendor_init_lib,//device/ayn/odin2_ack:init_odin2)
PRODUCT_VENDOR_PROPERTY_BLACKLIST := \
    ro.product.vendor.device \
    ro.product.vendor.model \
    ro.product.vendor.name
PRODUCT_COPY_FILES += \
    $(foreach model,$(TARGET_MODELS),device/ayn/odin2_ack/properties/$(model).prop:$(TARGET_COPY_OUT_VENDOR)/etc/props/$(model).prop) \

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
