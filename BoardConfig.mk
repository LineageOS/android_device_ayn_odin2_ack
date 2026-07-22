#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

BOARD_FLASH_BLOCK_SIZE                  := 262144
BOARD_BOOTIMAGE_PARTITION_SIZE          := 100663296
BOARD_nova_DTBOIMG_PARTITION_SIZE       := 12582912
BOARD_odin2_DTBOIMG_PARTITION_SIZE      := 12582912
BOARD_odin2mini_DTBOIMG_PARTITION_SIZE  := 12582912
BOARD_odin2portal_DTBOIMG_PARTITION_SIZE := 12582912
BOARD_thor_DTBOIMG_PARTITION_SIZE       := 20971520
BOARD_rp6_DTBOIMG_PARTITION_SIZE        := 12582912
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE    := 8388608
BOARD_RECOVERYIMAGE_PARTITION_SIZE      := 104857600
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE   := 100663296
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE         := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE     := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE      := ext4
BOARD_SYSTEM_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE  := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE      := ext4
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_ODM                     := odm
TARGET_COPY_OUT_PRODUCT                 := product
TARGET_COPY_OUT_SYSTEM_DLKM             := system_dlkm
TARGET_COPY_OUT_SYSTEM_EXT              := system_ext
TARGET_COPY_OUT_VENDOR                  := vendor
TARGET_COPY_OUT_VENDOR_DLKM             := vendor_dlkm
BOARD_BUILD_VENDOR_RAMDISK_IMAGE        := true
TARGET_USERIMAGES_USE_EXT4              := true
TARGET_USERIMAGES_USE_F2FS              := true

BOARD_AYN_DYNAMIC_PARTITIONS_PARTITION_LIST := odm product system system_dlkm system_ext vendor vendor_dlkm
BOARD_AYN_DYNAMIC_PARTITIONS_SIZE           := 5675380736
BOARD_SUPER_PARTITION_GROUPS                := ayn_dynamic_partitions
BOARD_SUPER_PARTITION_SIZE                  := 5679575040
-include vendor/lineage/config/BoardConfigReservedSize.mk

# Android Verified Boot
BOARD_AVB_ENABLE ?= true
ifeq ($(BOARD_AVB_ENABLE),true)
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS                += --flags 3
BOARD_AVB_ALGORITHM                             ?= SHA256_RSA4096
BOARD_AVB_KEY_PATH                              ?= external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM                    := $(BOARD_AVB_ALGORITHM)
BOARD_AVB_RECOVERY_KEY_PATH                     := $(BOARD_AVB_KEY_PATH)
BOARD_AVB_RECOVERY_ROLLBACK_INDEX               := 0
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION      := 1
BOARD_AVB_VBMETA_SYSTEM                         := product system system_ext
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM               := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH                := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX          := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2
BOARD_AVB_BOOT_ALGORITHM                        := $(BOARD_AVB_ALGORITHM)
BOARD_AVB_BOOT_KEY_PATH                         := $(BOARD_AVB_KEY_PATH)
BOARD_AVB_BOOT_ROLLBACK_INDEX                   := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION          := 3
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT          := true

BOARD_AVB_SYSTEM_ADD_HASHTREE_FOOTER_ARGS       += --hash_algorithm sha256
BOARD_AVB_SYSTEM_EXT_ADD_HASHTREE_FOOTER_ARGS   += --hash_algorithm sha256
BOARD_AVB_PRODUCT_ADD_HASHTREE_FOOTER_ARGS      += --hash_algorithm sha256

BOARD_AVB_SYSTEM_DLKM_ADD_HASHTREE_FOOTER_ARGS  += --hash_algorithm sha256
BOARD_AVB_VENDOR_ADD_HASHTREE_FOOTER_ARGS       += --hash_algorithm sha256
BOARD_AVB_ODM_ADD_HASHTREE_FOOTER_ARGS          += --hash_algorithm sha256
BOARD_AVB_VENDOR_DLKM_ADD_HASHTREE_FOOTER_ARGS  += --hash_algorithm sha256
endif

# Assert
TARGET_OTA_ASSERT_DEVICE := odin2

# Bluetooth
ifeq ($(PRODUCT_IS_ATV),true)
TARGET_VENDOR_PROP += device/ayn/odin2_ack/properties/bluetooth.prop
endif

# DTB
TARGET_DTB_LIST_WILDCARD := qcs8550-ayntec-common

# Kernel
include device/ayn/odin2_ack/modules.mk

# Metadata
BOARD_USES_METADATA_PARTITION := true

# Recovery
TARGET_RECOVERY_FSTAB := device/ayn/odin2_ack/init/fstab.odin2

# Sepolicy
BOARD_VENDOR_SEPOLICY_DIRS += \
    device/ayn/odin2_ack/sepolicy/vendor

include device/ayn/qcs8550-ack/BoardConfigCommon.mk
