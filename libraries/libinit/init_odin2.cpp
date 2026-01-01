/*
 * SPDX-FileCopyrightText: The LineageOS Project
 * SPDX-License-Identifier: Apache-2.0
 */

#include <android-base/logging.h>
#include <android-base/properties.h>
#include <libinit_utils.h>
#include <unordered_map>

using android::base::GetProperty;

struct odin2_device {
    std::string device;
    std::string name;
    std::string model;
} typedef odin2_device;

//        hardware         device   name           model
static std::unordered_map<std::string, odin2_device> kOdin2Devices = {
        { "odin2",       { "odin2", "odin2",       "Odin 2"        }},
        { "odin2mini",   { "odin2", "odin2mini",   "Odin 2 Mini"   }},
        { "odin2portal", { "odin2", "odin2portal", "Odin 2 Portal" }},
        { "thor",        { "odin2", "thor",        "Thor"          }},
        { "rp6",         { "odin2", "rp6",         "Pocket 6"      }},
};

static void set_properties(odin2_device *chosen_device)
{
    property_override("ro.product.name",   chosen_device->name);
    property_override("ro.build.product",  chosen_device->device);
    property_override("ro.product.device", chosen_device->device);
    property_override("ro.product.model",  chosen_device->model);

    for (std::string partition :
         { "bootimage", "odm", "product", "system", "system_ext", "system_dlkm", "vendor_dlkm" }) {
        property_override("ro.product." + partition + ".name",   chosen_device->name);
        property_override("ro.product." + partition + ".device", chosen_device->device);
        property_override("ro.product." + partition + ".model",  chosen_device->model);
    }
}

void vendor_load_properties()
{
    std::string hardware = GetProperty("ro.hardware", "");
    if (hardware.empty()) {
        LOG(ERROR) << "odin2_init: could not detect hardware, aborting";
        return;
    }

    const auto& it = kOdin2Devices.find(hardware);
    if (hardware.empty()) {
        LOG(ERROR) << "odin2_init: could not detect model, aborting";
        return;
    }

    set_properties(&it->second);
}
