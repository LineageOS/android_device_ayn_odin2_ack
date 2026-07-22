#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

ifneq ($(filter odin2_ack odin2_tab_ack, $(TARGET_DEVICE)),)
MKDTBOIMG := $(HOST_OUT_EXECUTABLES)/mkdtboimg$(HOST_EXECUTABLE_SUFFIX)
BUILT_TARGET_FILES_ZIPROOT := $(call intermediates-dir-for,PACKAGING,target_files)/$(TARGET_PRODUCT)-target_files

# 1: Device variant
# 2: ODM
define postinstall_dtbo_rule
$(TARGET_OUT_PRODUCT_ETC)/firmware/${1}_dtbo.img: $(PRODUCT_OUT)/kernel $(MKDTBOIMG) $(AVBTOOL) $(productimage_intermediates)/file_list.txt
	$(MKDTBOIMG) create $(TARGET_OUT_PRODUCT_ETC)/firmware/${1}_dtbo.img --page_size=$(BOARD_KERNEL_PAGESIZE) $(abspath $(KERNEL_OUT))/qcs8550-${2}-${1}.dtbo
	$(AVBTOOL) add_hash_footer --image $(TARGET_OUT_PRODUCT_ETC)/firmware/${1}_dtbo.img $(call get-partition-size-argument,$(BOARD_${1}_DTBOIMG_PARTITION_SIZE)) --partition_name dtbo
	$(hide) grep etc/firmware/${1}_dtbo.img $(productimage_intermediates)/file_list.txt > /dev/null 2>&1 || echo etc/firmware/${1}_dtbo.img >> $(productimage_intermediates)/file_list.txt

$(TARGET_OUT_PRODUCT_EXECUTABLES)/ayn_bootloader_payload_updater: $(TARGET_OUT_PRODUCT_ETC)/firmware/${1}_dtbo.img

.PHONY: $(1)_dtboimage
$(1)_dtboimage: $(TARGET_OUT_PRODUCT_ETC)/firmware/${1}_dtbo.img

$(BUILT_TARGET_FILES_ZIPROOT).zip: $(BUILT_TARGET_FILES_ZIPROOT)/IMAGES/${1}_dtbo.img

$(BUILT_TARGET_FILES_ZIPROOT)/IMAGES/${1}_dtbo.img: $(BUILT_TARGET_FILES_ZIPROOT).zip.list $(TARGET_OUT_PRODUCT_ETC)/firmware/${1}_dtbo.img
	@mkdir -p $(BUILT_TARGET_FILES_ZIPROOT)/IMAGES
	@cp $(TARGET_OUT_PRODUCT_ETC)/firmware/${1}_dtbo.img $(BUILT_TARGET_FILES_ZIPROOT)/IMAGES/${1}_dtbo.img
	@grep $(BUILT_TARGET_FILES_ZIPROOT)/IMAGES/${1}_dtbo.img $(BUILT_TARGET_FILES_ZIPROOT).zip.list > /dev/null 2>&1 || echo $(BUILT_TARGET_FILES_ZIPROOT)/IMAGES/${1}_dtbo.img >> $(BUILT_TARGET_FILES_ZIPROOT).zip.list
endef

$(eval $(call postinstall_dtbo_rule,odin2,ayntec))
$(eval $(call postinstall_dtbo_rule,odin2mini,ayntec))
$(eval $(call postinstall_dtbo_rule,odin2portal,ayntec))
$(eval $(call postinstall_dtbo_rule,thor,ayntec))
$(eval $(call postinstall_dtbo_rule,nova,retroidpocket))
$(eval $(call postinstall_dtbo_rule,rp6,retroidpocket))
endif
