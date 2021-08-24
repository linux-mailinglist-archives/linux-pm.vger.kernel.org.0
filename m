Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7DC3F578C
	for <lists+linux-pm@lfdr.de>; Tue, 24 Aug 2021 07:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhHXFST (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Aug 2021 01:18:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:55331 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229901AbhHXFST (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Aug 2021 01:18:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="278249110"
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="278249110"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 22:17:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="515282846"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga004.fm.intel.com with ESMTP; 23 Aug 2021 22:17:34 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        lenb@kernel.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC PATCH 1/3] thermal/drivers/cpuidle_cooling: Reorganize cpuidle cooling driver
Date:   Mon, 23 Aug 2021 22:17:29 -0700
Message-Id: <20210824051731.2495462-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210824051731.2495462-1-srinivas.pandruvada@linux.intel.com>
References: <20210824051731.2495462-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Reorganize cpuidle cooling driver, so that it can be reused for non
DT/ARM implementations.

No functional changes are expected.

To reorganize:
- Split cpuidle cooling driver into two parts, one common and on DT
specific
- The common part is moved to cpuidle_cooling_core.c
- The DT specific part is left in cpuidle_cooling.c
- cpuidle_cooling_device structure is moved to a header file
- Created interface cpuidle_cooling_get_ops() to get cdev callbacks

While here, fixed some checkpatch warnings.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/Kconfig                |   6 +-
 drivers/thermal/Makefile               |   1 +
 drivers/thermal/cpuidle_cooling.c      | 141 +----------------------
 drivers/thermal/cpuidle_cooling_core.c | 148 +++++++++++++++++++++++++
 drivers/thermal/cpuidle_cooling_core.h |  24 ++++
 5 files changed, 180 insertions(+), 140 deletions(-)
 create mode 100644 drivers/thermal/cpuidle_cooling_core.c
 create mode 100644 drivers/thermal/cpuidle_cooling_core.h

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index d7f44deab5b1..3d669a1774d3 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -167,6 +167,10 @@ config CPU_THERMAL
 	  cooling device available, this option allows to use the CPU
 	  as a cooling device.
 
+config CPU_IDLE_THERMAL_CORE
+	bool
+	depends on IDLE_INJECT
+
 if CPU_THERMAL
 
 config CPU_FREQ_THERMAL
@@ -182,7 +186,7 @@ config CPU_FREQ_THERMAL
 
 config CPU_IDLE_THERMAL
 	bool "CPU idle cooling device"
-	depends on IDLE_INJECT
+	select CPU_IDLE_THERMAL_CORE
 	help
 	  This implements the CPU cooling mechanism through
 	  idle injection. This will throttle the CPU by injecting
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 82fc3e616e54..769d025beb11 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -23,6 +23,7 @@ thermal_sys-$(CONFIG_THERMAL_GOV_POWER_ALLOCATOR)	+= gov_power_allocator.o
 
 # cpufreq cooling
 thermal_sys-$(CONFIG_CPU_FREQ_THERMAL)	+= cpufreq_cooling.o
+thermal_sys-$(CONFIG_CPU_IDLE_THERMAL_CORE)	+= cpuidle_cooling_core.o
 thermal_sys-$(CONFIG_CPU_IDLE_THERMAL)	+= cpuidle_cooling.o
 
 # devfreq cooling
diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
index 4f41102e8b16..863c811e0d26 100644
--- a/drivers/thermal/cpuidle_cooling.c
+++ b/drivers/thermal/cpuidle_cooling.c
@@ -9,150 +9,13 @@
 
 #include <linux/cpu_cooling.h>
 #include <linux/cpuidle.h>
-#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/idle_inject.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/thermal.h>
 
-/**
- * struct cpuidle_cooling_device - data for the idle cooling device
- * @ii_dev: an atomic to keep track of the last task exiting the idle cycle
- * @state: a normalized integer giving the state of the cooling device
- */
-struct cpuidle_cooling_device {
-	struct idle_inject_device *ii_dev;
-	unsigned long state;
-};
-
-/**
- * cpuidle_cooling_runtime - Running time computation
- * @idle_duration_us: CPU idle time to inject in microseconds
- * @state: a percentile based number
- *
- * The running duration is computed from the idle injection duration
- * which is fixed. If we reach 100% of idle injection ratio, that
- * means the running duration is zero. If we have a 50% ratio
- * injection, that means we have equal duration for idle and for
- * running duration.
- *
- * The formula is deduced as follows:
- *
- *  running = idle x ((100 / ratio) - 1)
- *
- * For precision purpose for integer math, we use the following:
- *
- *  running = (idle x 100) / ratio - idle
- *
- * For example, if we have an injected duration of 50%, then we end up
- * with 10ms of idle injection and 10ms of running duration.
- *
- * Return: An unsigned int for a usec based runtime duration.
- */
-static unsigned int cpuidle_cooling_runtime(unsigned int idle_duration_us,
-					    unsigned long state)
-{
-	if (!state)
-		return 0;
-
-	return ((idle_duration_us * 100) / state) - idle_duration_us;
-}
-
-/**
- * cpuidle_cooling_get_max_state - Get the maximum state
- * @cdev  : the thermal cooling device
- * @state : a pointer to the state variable to be filled
- *
- * The function always returns 100 as the injection ratio. It is
- * percentile based for consistency accross different platforms.
- *
- * Return: The function can not fail, it is always zero
- */
-static int cpuidle_cooling_get_max_state(struct thermal_cooling_device *cdev,
-					 unsigned long *state)
-{
-	/*
-	 * Depending on the configuration or the hardware, the running
-	 * cycle and the idle cycle could be different. We want to
-	 * unify that to an 0..100 interval, so the set state
-	 * interface will be the same whatever the platform is.
-	 *
-	 * The state 100% will make the cluster 100% ... idle. A 0%
-	 * injection ratio means no idle injection at all and 50%
-	 * means for 10ms of idle injection, we have 10ms of running
-	 * time.
-	 */
-	*state = 100;
-
-	return 0;
-}
-
-/**
- * cpuidle_cooling_get_cur_state - Get the current cooling state
- * @cdev: the thermal cooling device
- * @state: a pointer to the state
- *
- * The function just copies  the state value from the private thermal
- * cooling device structure, the mapping is 1 <-> 1.
- *
- * Return: The function can not fail, it is always zero
- */
-static int cpuidle_cooling_get_cur_state(struct thermal_cooling_device *cdev,
-					 unsigned long *state)
-{
-	struct cpuidle_cooling_device *idle_cdev = cdev->devdata;
-
-	*state = idle_cdev->state;
-
-	return 0;
-}
-
-/**
- * cpuidle_cooling_set_cur_state - Set the current cooling state
- * @cdev: the thermal cooling device
- * @state: the target state
- *
- * The function checks first if we are initiating the mitigation which
- * in turn wakes up all the idle injection tasks belonging to the idle
- * cooling device. In any case, it updates the internal state for the
- * cooling device.
- *
- * Return: The function can not fail, it is always zero
- */
-static int cpuidle_cooling_set_cur_state(struct thermal_cooling_device *cdev,
-					 unsigned long state)
-{
-	struct cpuidle_cooling_device *idle_cdev = cdev->devdata;
-	struct idle_inject_device *ii_dev = idle_cdev->ii_dev;
-	unsigned long current_state = idle_cdev->state;
-	unsigned int runtime_us, idle_duration_us;
-
-	idle_cdev->state = state;
-
-	idle_inject_get_duration(ii_dev, &runtime_us, &idle_duration_us);
-
-	runtime_us = cpuidle_cooling_runtime(idle_duration_us, state);
-
-	idle_inject_set_duration(ii_dev, runtime_us, idle_duration_us);
-
-	if (current_state == 0 && state > 0) {
-		idle_inject_start(ii_dev);
-	} else if (current_state > 0 && !state)  {
-		idle_inject_stop(ii_dev);
-	}
-
-	return 0;
-}
-
-/**
- * cpuidle_cooling_ops - thermal cooling device ops
- */
-static struct thermal_cooling_device_ops cpuidle_cooling_ops = {
-	.get_max_state = cpuidle_cooling_get_max_state,
-	.get_cur_state = cpuidle_cooling_get_cur_state,
-	.set_cur_state = cpuidle_cooling_set_cur_state,
-};
+#include "cpuidle_cooling_core.h"
 
 /**
  * __cpuidle_cooling_register: register the cooling device
@@ -207,7 +70,7 @@ static int __cpuidle_cooling_register(struct device_node *np,
 	}
 
 	cdev = thermal_of_cooling_device_register(np, name, idle_cdev,
-						  &cpuidle_cooling_ops);
+						  cpuidle_cooling_get_ops());
 	if (IS_ERR(cdev)) {
 		ret = PTR_ERR(cdev);
 		goto out_kfree_name;
diff --git a/drivers/thermal/cpuidle_cooling_core.c b/drivers/thermal/cpuidle_cooling_core.c
new file mode 100644
index 000000000000..20bf02b4e168
--- /dev/null
+++ b/drivers/thermal/cpuidle_cooling_core.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2019 Linaro Limited.
+ *
+ *  Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ */
+#define pr_fmt(fmt) "cpuidle cooling: " fmt
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/idle_inject.h>
+#include <linux/thermal.h>
+
+#include "cpuidle_cooling_core.h"
+
+/**
+ * cpuidle_cooling_runtime - Running time computation
+ * @idle_duration_us: CPU idle time to inject in microseconds
+ * @state: a percentile based number
+ *
+ * The running duration is computed from the idle injection duration
+ * which is fixed. If we reach 100% of idle injection ratio, that
+ * means the running duration is zero. If we have a 50% ratio
+ * injection, that means we have equal duration for idle and for
+ * running duration.
+ *
+ * The formula is deduced as follows:
+ *
+ *  running = idle x ((100 / ratio) - 1)
+ *
+ * For precision purpose for integer math, we use the following:
+ *
+ *  running = (idle x 100) / ratio - idle
+ *
+ * For example, if we have an injected duration of 50%, then we end up
+ * with 10ms of idle injection and 10ms of running duration.
+ *
+ * Return: An unsigned int for a usec based runtime duration.
+ */
+static unsigned int cpuidle_cooling_runtime(unsigned int idle_duration_us,
+					    unsigned long state)
+{
+	if (!state)
+		return 0;
+
+	return ((idle_duration_us * 100) / state) - idle_duration_us;
+}
+
+/**
+ * cpuidle_cooling_get_max_state - Get the maximum state
+ * @cdev  : the thermal cooling device
+ * @state : a pointer to the state variable to be filled
+ *
+ * The function always returns 100 as the injection ratio. It is
+ * percentile based for consistency across different platforms.
+ *
+ * Return: The function can not fail, it is always zero
+ */
+static int cpuidle_cooling_get_max_state(struct thermal_cooling_device *cdev,
+					 unsigned long *state)
+{
+	/*
+	 * Depending on the configuration or the hardware, the running
+	 * cycle and the idle cycle could be different. We want to
+	 * unify that to an 0..100 interval, so the set state
+	 * interface will be the same whatever the platform is.
+	 *
+	 * The state 100% will make the cluster 100% ... idle. A 0%
+	 * injection ratio means no idle injection at all and 50%
+	 * means for 10ms of idle injection, we have 10ms of running
+	 * time.
+	 */
+	*state = 100;
+
+	return 0;
+}
+
+/**
+ * cpuidle_cooling_get_cur_state - Get the current cooling state
+ * @cdev: the thermal cooling device
+ * @state: a pointer to the state
+ *
+ * The function just copies  the state value from the private thermal
+ * cooling device structure, the mapping is 1 <-> 1.
+ *
+ * Return: The function can not fail, it is always zero
+ */
+static int cpuidle_cooling_get_cur_state(struct thermal_cooling_device *cdev,
+					 unsigned long *state)
+{
+	struct cpuidle_cooling_device *idle_cdev = cdev->devdata;
+
+	*state = idle_cdev->state;
+
+	return 0;
+}
+
+/**
+ * cpuidle_cooling_set_cur_state - Set the current cooling state
+ * @cdev: the thermal cooling device
+ * @state: the target state
+ *
+ * The function checks first if we are initiating the mitigation which
+ * in turn wakes up all the idle injection tasks belonging to the idle
+ * cooling device. In any case, it updates the internal state for the
+ * cooling device.
+ *
+ * Return: The function can not fail, it is always zero
+ */
+static int cpuidle_cooling_set_cur_state(struct thermal_cooling_device *cdev,
+					 unsigned long state)
+{
+	struct cpuidle_cooling_device *idle_cdev = cdev->devdata;
+	struct idle_inject_device *ii_dev = idle_cdev->ii_dev;
+	unsigned long current_state = idle_cdev->state;
+	unsigned int runtime_us, idle_duration_us;
+
+	idle_cdev->state = state;
+
+	idle_inject_get_duration(ii_dev, &runtime_us, &idle_duration_us);
+
+	runtime_us = cpuidle_cooling_runtime(idle_duration_us, state);
+
+	idle_inject_set_duration(ii_dev, runtime_us, idle_duration_us);
+
+	if (current_state == 0 && state > 0)
+		idle_inject_start(ii_dev);
+	else if (current_state > 0 && !state)
+		idle_inject_stop(ii_dev);
+
+	return 0;
+}
+
+/**
+ * cpuidle_cooling_ops - thermal cooling device ops
+ */
+static struct thermal_cooling_device_ops cpuidle_cooling_ops = {
+	.get_max_state = cpuidle_cooling_get_max_state,
+	.get_cur_state = cpuidle_cooling_get_cur_state,
+	.set_cur_state = cpuidle_cooling_set_cur_state,
+};
+
+struct thermal_cooling_device_ops *cpuidle_cooling_get_ops(void)
+{
+	return &cpuidle_cooling_ops;
+}
+EXPORT_SYMBOL_GPL(cpuidle_cooling_get_ops);
diff --git a/drivers/thermal/cpuidle_cooling_core.h b/drivers/thermal/cpuidle_cooling_core.h
new file mode 100644
index 000000000000..9b9701334a8c
--- /dev/null
+++ b/drivers/thermal/cpuidle_cooling_core.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ *  Copyright (C) 2019 Linaro Limited.
+ *
+ *  Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ */
+
+ #ifndef _CPUIDLE_COOLING_CORE_H
+ #define _CPUIDLE_COOLING_CORE_H
+
+/**
+ * struct cpuidle_cooling_device - data for the idle cooling device
+ * @ii_dev: an atomic to keep track of the last task exiting the idle cycle
+ * @state: a normalized integer giving the state of the cooling device
+ */
+struct cpuidle_cooling_device {
+	struct idle_inject_device *ii_dev;
+	unsigned long state;
+};
+
+struct thermal_cooling_device_ops *cpuidle_cooling_get_ops(void);
+
+#endif
-- 
2.30.2

