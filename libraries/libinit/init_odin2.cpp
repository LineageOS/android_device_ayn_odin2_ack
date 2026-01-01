/*
   Copyright (c) 2013, The Linux Foundation. All rights reserved.
   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are
   met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of The Linux Foundation nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.
   THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
   ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
   BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
   BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
   WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
   OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
   IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>
#include <android-base/properties.h>
#include <android-base/logging.h>

struct odin2_device {
    std::string device;
    std::string name;
    std::string hardware;
    std::string model;
} typedef odin2_device;

static void property_override(char const prop[], char const value[])
{
    prop_info *pi;

    pi = (prop_info*) __system_property_find(prop);
    if (pi)
        __system_property_update(pi, value, strlen(value));
    else
        __system_property_add(prop, strlen(prop), value, strlen(value));
}

static std::string property_get(std::string key)
{
    return android::base::GetProperty(key, "");
}

static void property_set(std::string key, std::string value)
{
    property_override(key.c_str(), value.c_str());
}

static void set_properties(odin2_device *chosen_device)
{
    property_set("ro.product.name",   chosen_device->name);
    property_set("ro.build.product",  chosen_device->device);
    property_set("ro.product.device", chosen_device->device);
    property_set("ro.product.model",  chosen_device->model);

    property_set("ro.product.bootimage.name",   chosen_device->name);
    property_set("ro.product.bootimage.device", chosen_device->device);
    property_set("ro.product.bootimage.model",  chosen_device->model);

    property_set("ro.product.system.name",   chosen_device->name);
    property_set("ro.product.system.device", chosen_device->device);
    property_set("ro.product.system.model",  chosen_device->model);

    property_set("ro.product.odm.name",   chosen_device->name);
    property_set("ro.product.odm.device", chosen_device->device);
    property_set("ro.product.odm.model",  chosen_device->model);

    property_set("ro.product.product.name",   chosen_device->name);
    property_set("ro.product.product.device", chosen_device->device);
    property_set("ro.product.product.model",  chosen_device->model);

    property_set("ro.product.system_ext.name",   chosen_device->name);
    property_set("ro.product.system_ext.device", chosen_device->device);
    property_set("ro.product.system_ext.model",  chosen_device->model);

    property_set("ro.product.system_dlkm.name",   chosen_device->name);
    property_set("ro.product.system_dlkm.device", chosen_device->device);
    property_set("ro.product.system_dlkm.model",  chosen_device->model);

    property_set("ro.product.vendor_dlkm.name",   chosen_device->name);
    property_set("ro.product.vendor_dlkm.device", chosen_device->device);
    property_set("ro.product.vendor_dlkm.model",  chosen_device->model);
}

void vendor_load_properties()
{
    odin2_device *chosen_device;
    bool device_found = false;
    std::string hardware = property_get("ro.hardware");

    //            device   name           hardware       model
    std::vector<odin2_device> devices = {
		{ "odin2", "odin2",       "odin2",       "Odin 2"        },
		{ "odin2", "odin2mini",   "odin2mini",   "Odin 2 Mini"   },
		{ "odin2", "odin2portal", "odin2portal", "Odin 2 Portal" },
		{ "odin2", "thor",        "thor",        "Thor"          },
	};

    for (auto & device : devices) {
        if (!device.hardware.compare(hardware)) {
            chosen_device = &device;
            device_found = true;
            break;
        }
    }

    if (!device_found) {
        LOG(ERROR) << "odin2_init: could not detect model, aborting";
        return;
    }

    set_properties(chosen_device);
}
