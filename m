Return-Path: <linux-pm+bounces-23702-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5DAA583EF
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 13:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1884169E06
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 12:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28FF1D6DB7;
	Sun,  9 Mar 2025 12:13:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7464A1D416E;
	Sun,  9 Mar 2025 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741522427; cv=none; b=rkCPSGM+wVFSmVINuh/pMukDyFL9r3fSXDEP4j/jCe8yLDYqQR2YfK6yf0mqeULswn7Y+uCxRRzHM3tO/3OZI69eQFqryp3Qzwte98kJRNryZBJ1SX7b7ZRsrgkcLA9nF31523xsOTRtb/YQdbb6Xb2RUchP8fx04a13/EwGLYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741522427; c=relaxed/simple;
	bh=cw7SeoyMQDtu8CnBEB/va5TGkcGMnC0Iuew4Ks9Valw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tuBycCmGGazcoU7C4Gycprqcu2f5Qt8lJ9Lh8JdZNT9OI5IiOX3+jsKZxzZnFBUT7Ew3Oqlc9XyLAPxCdeENNyB9u46lPj0XZsdbQwKCDAMcxMt7zyTdshr5G2urZOYr7ZMUF5J5p+9S2hgmpF6D8quukXDUn8THPJ7hQWpwENA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: P6XX9sBAQJS2LiIbBWS36Q==
X-CSE-MsgGUID: EbUUVbX5R4arqBnkrROXlA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 09 Mar 2025 21:13:39 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.42])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9BE95422041D;
	Sun,  9 Mar 2025 21:13:33 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: geert+renesas@glider.be,
	niklas.soderlund+renesas@ragnatech.se,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: magnus.damm@gmail.com,
	claudiu.beznea.uj@bp.renesas.com,
	devicetree@vger.kernel.org,
	john.madieu@gmail.com,
	rui.zhang@intel.com,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	biju.das.jz@bp.renesas.com,
	linux-pm@vger.kernel.org,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [RFC PATCH 1/3] thermal/cpuplog_cooling: Add CPU hotplug cooling driver
Date: Sun,  9 Mar 2025 13:13:21 +0100
Message-ID: <20250309121324.29633-2-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250309121324.29633-1-john.madieu.xa@bp.renesas.com>
References: <20250309121324.29633-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add thermal cooling mechanism that dynamically manages CPU online/offline
states to prevent overheating. It registers  per-CPU cooling devices that can
take CPUs offline when thermal thresholds are excee and that integrates with
the Linux thermal framework as a cooling devices.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/thermal/Kconfig           |  12 +
 drivers/thermal/Makefile          |   1 +
 drivers/thermal/cpuplug_cooling.c | 363 ++++++++++++++++++++++++++++++
 drivers/thermal/thermal_of.c      |   1 +
 drivers/thermal/thermal_trace.h   |   2 +
 drivers/thermal/thermal_trip.c    |   1 +
 include/uapi/linux/thermal.h      |   1 +
 7 files changed, 381 insertions(+)
 create mode 100644 drivers/thermal/cpuplug_cooling.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index d3f9686e26e7..6b0687f0d635 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -202,6 +202,18 @@ config CPU_IDLE_THERMAL
 	  This implements the CPU cooling mechanism through
 	  idle injection. This will throttle the CPU by injecting
 	  idle cycle.
+
+config CPU_HOTPLUG_THERMAL
+	bool "CPU hotplug cooling device"
+	depends on THERMAL
+	depends on HOTPLUG_CPU
+	help
+	  Enable this to manage platform thermals using CPU hotplug.
+	  This can offline CPUs when a temperature threshold is exceeded and
+	  bring them back online when it drops below the reset temperature.
+	  The boot CPU is never offlined.
+
+	  If in doubt, say N.
 endif
 
 config DEVFREQ_THERMAL
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 9abf43a74f2b..7b3648daabd2 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -28,6 +28,7 @@ thermal_sys-$(CONFIG_THERMAL_GOV_POWER_ALLOCATOR)	+= gov_power_allocator.o
 # cpufreq cooling
 thermal_sys-$(CONFIG_CPU_FREQ_THERMAL)	+= cpufreq_cooling.o
 thermal_sys-$(CONFIG_CPU_IDLE_THERMAL)	+= cpuidle_cooling.o
+thermal_sys-$(CONFIG_CPU_HOTPLUG_THERMAL)	+= cpuplug_cooling.o
 
 # devfreq cooling
 thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
diff --git a/drivers/thermal/cpuplug_cooling.c b/drivers/thermal/cpuplug_cooling.c
new file mode 100644
index 000000000000..1f62325f0665
--- /dev/null
+++ b/drivers/thermal/cpuplug_cooling.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CPU Hotplug Thermal Cooling Device
+ *
+ * Copyright (C) 2025 Renesas Electronics Corporation
+ */
+#define pr_fmt(fmt) "cpu-hotplug-thermal: " fmt
+
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+#include <linux/types.h>
+
+#define COOLING_DEVICE_NAME "cpu-hotplug"
+
+/* CPU Hotplug cooling device private data structure */
+struct cpu_hotplug_cooling_device {
+	struct thermal_cooling_device *cdev;
+	int cpu_id;
+	unsigned long cur_state;
+	bool cpu_online;
+	struct list_head node;
+};
+
+static LIST_HEAD(cooling_devices);
+static DEFINE_MUTEX(cooling_list_lock);
+
+/* Track which CPUs already have cooling devices */
+static DECLARE_BITMAP(cpu_cooling_registered, NR_CPUS);
+
+static inline bool is_boot_cpu(unsigned int cpu)
+{
+	return cpu == cpumask_first(cpu_online_mask);
+}
+
+static int cpu_hotplug_get_max_state(struct thermal_cooling_device *cdev,
+				     unsigned long *state)
+{
+	*state = 1; /* We only have two states: on/off */
+	return 0;
+}
+
+/* Get current cooling state */
+static int cpu_hotplug_get_cur_state(struct thermal_cooling_device *cdev,
+				     unsigned long *state)
+{
+	struct cpu_hotplug_cooling_device *hotplug_cdev = cdev->devdata;
+
+	*state = hotplug_cdev->cur_state;
+	return 0;
+}
+
+static int cpu_hotplug_set_cur_state(struct thermal_cooling_device *cdev,
+				     unsigned long state)
+{
+	struct cpu_hotplug_cooling_device *hotplug_cdev = cdev->devdata;
+	int cpu, ret = 0;
+
+	/* Only take action if state has changed */
+	if (hotplug_cdev->cur_state == state)
+		return 0;
+
+	/* Store the current state */
+	hotplug_cdev->cur_state = state;
+	cpu = hotplug_cdev->cpu_id;
+
+	/* Skip if it's the boot CPU */
+	if (is_boot_cpu(cpu))
+		return 0;
+
+	if (state == 0) {
+		/* Cooling off - bring CPU online if it's offline */
+		if (!cpu_online(cpu)) {
+			pr_info("CPU%d coming back online\n", cpu);
+			ret = add_cpu(cpu);
+			if (ret)
+				pr_err("Failed to bring CPU%d online: %d\n", cpu, ret);
+			else
+				hotplug_cdev->cpu_online = true;
+		}
+	} else {
+		/* Cooling on - take CPU offline if it's online */
+		if (cpu_online(cpu)) {
+			pr_info("CPU%d going offline due to overheating\n", cpu);
+			ret = remove_cpu(cpu);
+			if (ret)
+				pr_err("Failed to offline CPU%d: %d\n", cpu, ret);
+			else
+				hotplug_cdev->cpu_online = false;
+		}
+	}
+
+	return 0;
+}
+
+static const struct thermal_cooling_device_ops cpu_hotplug_cooling_ops = {
+	.get_max_state = cpu_hotplug_get_max_state,
+	.get_cur_state = cpu_hotplug_get_cur_state,
+	.set_cur_state = cpu_hotplug_set_cur_state,
+};
+
+static int register_cpu_hotplug_cooling(struct device_node *cpu_node,
+					int cpu_id)
+{
+	struct cpu_hotplug_cooling_device *hotplug_cdev;
+	struct thermal_cooling_device *cdev;
+	char cooling_name[32];
+
+	/* Check if we already registered this CPU */
+	if (test_bit(cpu_id, cpu_cooling_registered)) {
+		pr_info("Cooling device already registered for CPU%d\n", cpu_id);
+		return 0;
+	}
+
+	/* Skip the boot CPU */
+	if (is_boot_cpu(cpu_id)) {
+		pr_info("Skipping boot CPU%d for hotplug cooling\n", cpu_id);
+		return 0;
+	}
+
+	hotplug_cdev = kzalloc(sizeof(*hotplug_cdev), GFP_KERNEL);
+	if (!hotplug_cdev) {
+		pr_err("Failed to allocate memory for cooling device\n");
+		return -ENOMEM;
+	}
+
+	/* Initialize cooling device */
+	hotplug_cdev->cpu_id = cpu_id;
+	hotplug_cdev->cur_state = 0;
+	hotplug_cdev->cpu_online = cpu_online(cpu_id);
+
+	/* Unique cooling device name */
+	snprintf(cooling_name, sizeof(cooling_name), "%s-%d",
+		 COOLING_DEVICE_NAME, hotplug_cdev->cpu_id);
+
+	/* Register cooling device with a unique name - using CPU node */
+	cdev = thermal_of_cooling_device_register(
+		cpu_node, cooling_name, hotplug_cdev, &cpu_hotplug_cooling_ops);
+	if (IS_ERR(cdev)) {
+		pr_err("Failed to register %s: %ld\n", cooling_name,
+		       PTR_ERR(cdev));
+		kfree(hotplug_cdev);
+		return PTR_ERR(cdev);
+	}
+
+	hotplug_cdev->cdev = cdev;
+
+	/* Mark this CPU as having a registered cooling device */
+	set_bit(cpu_id, cpu_cooling_registered);
+
+	/* Add to our list for cleanup later */
+	mutex_lock(&cooling_list_lock);
+	list_add(&hotplug_cdev->node, &cooling_devices);
+	mutex_unlock(&cooling_list_lock);
+
+	pr_info("Successfully registered %s for CPU%d\n", cooling_name,
+		hotplug_cdev->cpu_id);
+
+	return 0;
+}
+
+/* Cleanup all cooling devices */
+static void cleanup_cooling_devices(void)
+{
+	struct cpu_hotplug_cooling_device *hotplug_cdev, *next;
+
+	mutex_lock(&cooling_list_lock);
+	list_for_each_entry_safe(hotplug_cdev, next, &cooling_devices, node) {
+		pr_info("Unregistering cooling device for CPU%d\n",
+			hotplug_cdev->cpu_id);
+
+		/* Clear the registration bit */
+		clear_bit(hotplug_cdev->cpu_id, cpu_cooling_registered);
+
+		/* Remove from list */
+		list_del(&hotplug_cdev->node);
+
+		/* Unregister cooling device */
+		thermal_cooling_device_unregister(hotplug_cdev->cdev);
+
+		/* Make sure CPU is back online */
+		if (!hotplug_cdev->cpu_online) {
+			int cpu = hotplug_cdev->cpu_id;
+			if (!is_boot_cpu(cpu) && !cpu_online(cpu)) {
+				pr_info("Bringing CPU%d back online during module unload\n", cpu);
+				if (add_cpu(cpu))
+					pr_err("Failed to bring CPU%d online\n", cpu);
+			}
+		}
+
+		/* Free memory */
+		kfree(hotplug_cdev);
+	}
+	mutex_unlock(&cooling_list_lock);
+}
+
+/* Check if a trip point is of type "plug" */
+static bool is_plug_trip_point(struct device_node *trip_node)
+{
+	const char *trip_type_str;
+
+	if (!trip_node) {
+		pr_err("Trip node is NULL\n");
+		return false;
+	}
+
+	if (of_property_read_string(trip_node, "type", &trip_type_str)) {
+		pr_err("Trip node missing 'type' property\n");
+		return false;
+	}
+
+	pr_info("Trip type: '%s'\n", trip_type_str);
+
+	if (strcmp(trip_type_str, "plug") != 0) {
+		pr_debug("Trip type is '%s', not 'plug' - skipping\n",
+			 trip_type_str);
+		return false;
+	}
+
+	return true;
+}
+
+/* Init function */
+static int __init cpu_hotplug_cooling_init(void)
+{
+	struct device_node *thermal_zones, *thermal_zone;
+	int ret = 0;
+	int count = 0;
+
+	bitmap_zero(cpu_cooling_registered, NR_CPUS);
+
+	thermal_zones = of_find_node_by_name(NULL, "thermal-zones");
+	if (!thermal_zones) {
+		pr_err("Missing thermal-zones node\n");
+		return -EINVAL;
+	}
+
+	/* Process each thermal zone */
+	for_each_child_of_node(thermal_zones, thermal_zone) {
+		struct device_node *trips, *trip;
+		struct device_node *maps, *map;
+		bool found_plug = false;
+
+		/* First find trips and get a specific plug trip */
+		trips = of_find_node_by_name(thermal_zone, "trips");
+		if (!trips)
+			continue;
+
+		/* Find the emergency trip with type="plug" */
+		for_each_child_of_node(trips, trip) {
+			if (is_plug_trip_point(trip)) {
+				found_plug = true;
+				break;
+			}
+		}
+
+		/* If we didn't find a plug trip, no need to process this zone */
+		if (!found_plug) {
+			of_node_put(trips);
+			continue;
+		}
+
+		maps = of_find_node_by_name(thermal_zone, "cooling-maps");
+		if (!maps) {
+			of_node_put(trip);
+			of_node_put(trips);
+			continue;
+		}
+
+		pr_info("Found 'plug' trip point, processing cooling devices\n");
+
+		/* Find the specific cooling map that references our plug trip */
+		for_each_child_of_node(maps, map) {
+			struct device_node *trip_ref;
+			struct of_phandle_args cooling_spec;
+			int idx = 0;
+
+			trip_ref = of_parse_phandle(map, "trip", 0);
+			if (!trip_ref || trip_ref != trip) {
+				if (trip_ref)
+					of_node_put(trip_ref);
+				continue;
+			}
+			of_node_put(trip_ref);
+
+			if (!of_find_property(map, "cooling-device", NULL)) {
+				pr_err("Missing cooling-device property\n");
+				continue;
+			}
+
+			/* Iterate through all cooling-device entries */
+			while (of_parse_phandle_with_args(
+				       map, "cooling-device",
+				       "#cooling-cells", idx++,
+				       &cooling_spec) == 0) {
+				struct device_node *cpu_node = cooling_spec.np;
+				int cpu;
+
+				if (!cpu_node) {
+					pr_err("CPU node at index %d is NULL\n",
+					       idx - 1);
+					continue;
+				}
+
+				cpu = of_cpu_node_to_id(cpu_node);
+				if (cpu < 0) {
+					pr_err("Failed to map CPU node %pOF to logical ID\n",
+					       cpu_node);
+					of_node_put(cpu_node);
+					continue;
+				}
+
+				if (cpu >= num_possible_cpus()) {
+					pr_err("Invalid CPU ID %d (max %d)\n",
+					       cpu, num_possible_cpus() - 1);
+					of_node_put(cpu_node);
+					continue;
+				}
+
+				pr_info("Processing cooling device for CPU%d\n", cpu);
+				ret = register_cpu_hotplug_cooling(cpu_node, cpu);
+				if (ret == 0)
+					count++;
+
+				of_node_put(cpu_node);
+			}
+			break; /* Only process the first map that references our trip */
+		}
+		of_node_put(maps);
+		of_node_put(trip);
+		of_node_put(trips);
+	}
+	of_node_put(thermal_zones);
+
+	if (count == 0) {
+		pr_err("No cooling devices registered\n");
+		return -ENODEV;
+	}
+
+	pr_info("CPU hotplug cooling driver initialized with %d devices\n", count);
+	return 0;
+}
+
+/* Exit function */
+static void __exit cpu_hotplug_cooling_exit(void)
+{
+	cleanup_cooling_devices();
+	pr_info("CPU hotplug cooling driver removed\n");
+}
+
+module_init(cpu_hotplug_cooling_init);
+module_exit(cpu_hotplug_cooling_exit);
+
+MODULE_AUTHOR("John Madieu <john.madieu.xa@bp.renesas.com>");
+MODULE_DESCRIPTION("CPU Hotplug Thermal Cooling Device");
+MODULE_LICENSE("GPL");
\ No newline at end of file
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 0eb92d57a1e2..41655af1e419 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -28,6 +28,7 @@ static const char * const trip_types[] = {
 	[THERMAL_TRIP_ACTIVE]	= "active",
 	[THERMAL_TRIP_PASSIVE]	= "passive",
 	[THERMAL_TRIP_HOT]	= "hot",
+	[THERMAL_TRIP_PLUG]	= "plug",
 	[THERMAL_TRIP_CRITICAL]	= "critical",
 };
 
diff --git a/drivers/thermal/thermal_trace.h b/drivers/thermal/thermal_trace.h
index df8f4edd6068..c26a3aa7de5f 100644
--- a/drivers/thermal/thermal_trace.h
+++ b/drivers/thermal/thermal_trace.h
@@ -12,6 +12,7 @@
 #include "thermal_core.h"
 
 TRACE_DEFINE_ENUM(THERMAL_TRIP_CRITICAL);
+TRACE_DEFINE_ENUM(THERMAL_TRIP_PLUG);
 TRACE_DEFINE_ENUM(THERMAL_TRIP_HOT);
 TRACE_DEFINE_ENUM(THERMAL_TRIP_PASSIVE);
 TRACE_DEFINE_ENUM(THERMAL_TRIP_ACTIVE);
@@ -19,6 +20,7 @@ TRACE_DEFINE_ENUM(THERMAL_TRIP_ACTIVE);
 #define show_tzt_type(type)					\
 	__print_symbolic(type,					\
 			 { THERMAL_TRIP_CRITICAL, "CRITICAL"},	\
+			 { THERMAL_TRIP_PLUG,     "PLUG"},	\
 			 { THERMAL_TRIP_HOT,      "HOT"},	\
 			 { THERMAL_TRIP_PASSIVE,  "PASSIVE"},	\
 			 { THERMAL_TRIP_ACTIVE,   "ACTIVE"})
diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
index 4b8238468b53..373f6aaaf0da 100644
--- a/drivers/thermal/thermal_trip.c
+++ b/drivers/thermal/thermal_trip.c
@@ -13,6 +13,7 @@ static const char *trip_type_names[] = {
 	[THERMAL_TRIP_ACTIVE] = "active",
 	[THERMAL_TRIP_PASSIVE] = "passive",
 	[THERMAL_TRIP_HOT] = "hot",
+	[THERMAL_TRIP_PLUG]	= "plug",
 	[THERMAL_TRIP_CRITICAL] = "critical",
 };
 
diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
index 46a2633d33aa..5f76360c6f69 100644
--- a/include/uapi/linux/thermal.h
+++ b/include/uapi/linux/thermal.h
@@ -15,6 +15,7 @@ enum thermal_trip_type {
 	THERMAL_TRIP_ACTIVE = 0,
 	THERMAL_TRIP_PASSIVE,
 	THERMAL_TRIP_HOT,
+	THERMAL_TRIP_PLUG,
 	THERMAL_TRIP_CRITICAL,
 };
 
-- 
2.25.1


