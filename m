Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7191F3F578D
	for <lists+linux-pm@lfdr.de>; Tue, 24 Aug 2021 07:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhHXFSU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Aug 2021 01:18:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:55331 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229955AbhHXFST (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Aug 2021 01:18:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="278249116"
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="278249116"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 22:17:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="515282858"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga004.fm.intel.com with ESMTP; 23 Aug 2021 22:17:35 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        lenb@kernel.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC PATCH 3/3] thermal/drivers/cpuidle_cooling: cpuidle cooling driver for non DT/ARM
Date:   Mon, 23 Aug 2021 22:17:31 -0700
Message-Id: <20210824051731.2495462-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210824051731.2495462-1-srinivas.pandruvada@linux.intel.com>
References: <20210824051731.2495462-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This driver has same functionality as existing cpuidle_cooling driver.
This uses idle injection to cool a CPU. This driver reuses all the code
from the existing driver, except the DT specific function.

Each CPU is registered as a cooling device, with type = idle-x, where
x is the cpu number.

It registers two module parameters:
idle_duration_us : To change default idle duration
idle_latency_us : To change default latency

The meaning of these parameters is same as in the existing code. It is
described in the header of file drivers/powercap/idle_inject.c.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/Kconfig                   |  12 ++
 drivers/thermal/Makefile                  |   2 +
 drivers/thermal/cpuidle_cooling_generic.c | 155 ++++++++++++++++++++++
 3 files changed, 169 insertions(+)
 create mode 100644 drivers/thermal/cpuidle_cooling_generic.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 3d669a1774d3..3efe3df75337 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -193,6 +193,18 @@ config CPU_IDLE_THERMAL
 	  idle cycle.
 endif
 
+config CPU_IDLE_THERMAL_GENERIC
+	tristate "CPU idle cooling device"
+	depends on !CPU_THERMAL
+	select CPU_IDLE_THERMAL_CORE
+	help
+	  This implements the CPU cooling mechanism through
+	  idle injection. This will throttle the CPU by injecting
+	  idle cycle.
+
+	  This driver can also be built as a module. If so, the module will
+          be called cpuidle_cooling_generic.
+
 config DEVFREQ_THERMAL
 	bool "Generic device cooling support"
 	depends on PM_DEVFREQ
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 769d025beb11..c6dce523ab2b 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -26,6 +26,8 @@ thermal_sys-$(CONFIG_CPU_FREQ_THERMAL)	+= cpufreq_cooling.o
 thermal_sys-$(CONFIG_CPU_IDLE_THERMAL_CORE)	+= cpuidle_cooling_core.o
 thermal_sys-$(CONFIG_CPU_IDLE_THERMAL)	+= cpuidle_cooling.o
 
+obj-$(CONFIG_CPU_IDLE_THERMAL_GENERIC) += cpuidle_cooling_generic.o
+
 # devfreq cooling
 thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
 
diff --git a/drivers/thermal/cpuidle_cooling_generic.c b/drivers/thermal/cpuidle_cooling_generic.c
new file mode 100644
index 000000000000..adb33dfba2e7
--- /dev/null
+++ b/drivers/thermal/cpuidle_cooling_generic.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic cpu idle cooling driver
+ * Copyright (c) 2021, Intel Corporation.
+ * All rights reserved.
+ *
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/cpufeature.h>
+#include <linux/cpuhotplug.h>
+#include <linux/idle_inject.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+#include <linux/topology.h>
+
+#include "cpuidle_cooling_core.h"
+
+#define IDLE_DURATION   10000
+#define IDLE_LATENCY    5000
+
+static int idle_duration_us = IDLE_DURATION;
+static int idle_latency_us = IDLE_LATENCY;
+
+module_param(idle_duration_us, int, 0644);
+MODULE_PARM_DESC(idle_duration_us,
+		 "Idle duration in us.");
+
+module_param(idle_latency_us, int, 0644);
+MODULE_PARM_DESC(idle_latency_us,
+		 "Idle latency in us.");
+
+struct cpuidle_cooling {
+	struct thermal_cooling_device *cdev;
+	struct idle_inject_device *ii_dev;
+	struct cpuidle_cooling_device *idle_cdev;
+};
+static DEFINE_PER_CPU(struct cpuidle_cooling, cooling_devs);
+static cpumask_t cpuidle_cpu_mask;
+
+static int cpuidle_cooling_register(int cpu)
+{
+	struct cpuidle_cooling *cooling_dev = &per_cpu(cooling_devs, cpu);
+	struct cpuidle_cooling_device *idle_cdev;
+	struct thermal_cooling_device *cdev;
+	struct idle_inject_device *ii_dev;
+	char *name;
+	int ret;
+
+	if (cpumask_test_cpu(cpu, &cpuidle_cpu_mask))
+		return 0;
+
+	idle_cdev = kzalloc(sizeof(*idle_cdev), GFP_KERNEL);
+	if (!idle_cdev) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ii_dev = idle_inject_register((struct cpumask *)cpumask_of(cpu));
+	if (!ii_dev) {
+		pr_err("idle_inject_register failed for cpu:%d\n", cpu);
+		ret = -EINVAL;
+		goto out_kfree;
+	}
+
+	idle_inject_set_duration(ii_dev, TICK_USEC, idle_duration_us);
+	idle_inject_set_latency(ii_dev, idle_latency_us);
+
+	idle_cdev->ii_dev = ii_dev;
+
+	name = kasprintf(GFP_KERNEL, "idle-%d", cpu);
+	if (!name) {
+		ret = -ENOMEM;
+		goto out_unregister;
+	}
+
+	cdev = thermal_cooling_device_register(name, idle_cdev,
+					       cpuidle_cooling_get_ops());
+	if (IS_ERR(cdev)) {
+		ret = PTR_ERR(cdev);
+		goto out_kfree_name;
+	}
+
+	pr_debug("%s: Idle injection set with idle duration=%u, latency=%u\n",
+		 name, idle_duration_us, idle_latency_us);
+
+	kfree(name);
+
+	cooling_dev->cdev = cdev;
+	cooling_dev->ii_dev = ii_dev;
+	cooling_dev->idle_cdev = idle_cdev;
+	cpumask_set_cpu(cpu, &cpuidle_cpu_mask);
+
+	return 0;
+
+out_kfree_name:
+	kfree(name);
+out_unregister:
+	idle_inject_unregister(ii_dev);
+out_kfree:
+	kfree(idle_cdev);
+out:
+	return ret;
+}
+
+static void cpuidle_cooling_unregister(int cpu)
+{
+	struct cpuidle_cooling *cooling_dev = &per_cpu(cooling_devs, cpu);
+
+	thermal_cooling_device_unregister(cooling_dev->cdev);
+	idle_inject_unregister(cooling_dev->ii_dev);
+	kfree(cooling_dev->idle_cdev);
+}
+
+static int cpuidle_cooling_cpu_online(unsigned int cpu)
+{
+	cpuidle_cooling_register(cpu);
+
+	return 0;
+}
+
+static enum cpuhp_state cpuidle_cooling_hp_state __read_mostly;
+
+static int __init cpuidle_cooling_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+				"thermal/cpuidle_cooling:online",
+				cpuidle_cooling_cpu_online, NULL);
+	if (ret < 0)
+		return ret;
+
+	cpuidle_cooling_hp_state = ret;
+
+	return 0;
+}
+module_init(cpuidle_cooling_init)
+
+static void __exit cpuidle_cooling_exit(void)
+{
+	int i;
+
+	cpuhp_remove_state(cpuidle_cooling_hp_state);
+
+	for_each_cpu(i,	&cpuidle_cpu_mask) {
+		cpuidle_cooling_unregister(i);
+	}
+}
+module_exit(cpuidle_cooling_exit)
+
+MODULE_LICENSE("GPL v2");
-- 
2.30.2

