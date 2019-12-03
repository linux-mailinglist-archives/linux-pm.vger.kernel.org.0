Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD3C10FAD8
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 10:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLCJhS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 04:37:18 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35719 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfLCJhR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 04:37:17 -0500
Received: by mail-wm1-f68.google.com with SMTP id u8so2677101wmu.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2019 01:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IggfPB+tjS7935yy1bgS/bcntfnQ1JptbLU3i0UsIps=;
        b=ycM6jNT5oat58eevSo1aLTeLS/H7yKuoFkvX3QQYu8yed18QLxFFAZZWszYH/wG4bI
         S+HLymrWtT1UcBKQSjdrCfkiN0MJaKGTCTJ5YWRiUBJ/QAe70A4hErXdinr7QjNEQ9hK
         jsM5cSjY5T9P/6rPoJD+fLYax3vLOkiEIFj+SRTZA6pOwIHT57ptKictaMEeh2q3nyJh
         9uxerGTXmloR44A/snT+0AUAgS/T8zUPKq74t/ejzEMv4aZLIUuID3YMb0OTd14/MEDK
         gvVFvn96b5LYUcvK3a1AKEuNEZSLEi3w0UT+m6/H5j2jKKcodck6KqXmJNGORDYn85ci
         SNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IggfPB+tjS7935yy1bgS/bcntfnQ1JptbLU3i0UsIps=;
        b=FxmGva03SJ8VFssjFiXDuQQXhgo1Encnfn44UQjgGwEvPDAwOUC3zCxjMxFJ1qLJ+w
         h2+zyz2aYYytKFv+EKPL55Bew4RX6G2iTrl+WivuFBbZBwj3by7hufTOrZmOcsEshQpd
         v6f3QItHJwUm7edvZ+BRxWCSgmnA2t157Jw28qUrhqNGDB4WILJ5PiT2pr5Jw4D1hcUT
         87BEtYa01g8xo5Y733Eb0Ug4YOqjS8+O52oQMAMzf/fx1KiRVBom5KOh9ATfg8rSv4/Q
         47zdBzBJoMjiuc8SSn4r2fkdsqdZOJgLDgwBxA5D+/Y9uEaSyFkkjRzyIoZqW5gFqLIL
         p4Vg==
X-Gm-Message-State: APjAAAXTL+3I1iYMvcOpVbpSZNGyWxH8YgVy5TBagAZ1H8kwfwFZavc6
        d5fhVUNQzXU8AbpOofOF8zaQZg==
X-Google-Smtp-Source: APXvYqz4YaVESUOlP6+tPyglnFe2+m/Syk+cFE2fo7MsdJPB6fkL+ysEMxTA1lzuBTavMkxDqqJXOA==
X-Received: by 2002:a7b:c5d0:: with SMTP id n16mr34490278wmk.78.1575365833778;
        Tue, 03 Dec 2019 01:37:13 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:8196:cbcc:fb2c:4975])
        by smtp.gmail.com with ESMTPSA id w13sm2935751wru.38.2019.12.03.01.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 01:37:13 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     viresh.kumar@linaro.org, rui.zhang@intel.com
Cc:     rjw@rjwysocki.net, edubezval@gmail.com, linux-pm@vger.kernel.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/4] thermal/drivers/cpu_cooling: Introduce the cpu idle cooling driver
Date:   Tue,  3 Dec 2019 10:37:03 +0100
Message-Id: <20191203093704.7037-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203093704.7037-1-daniel.lezcano@linaro.org>
References: <20191203093704.7037-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpu idle cooling device offers a new method to cool down a CPU by
injecting idle cycles at runtime.

It has some similarities with the intel power clamp driver but it is
actually designed to be more generic and relying on the idle injection
powercap framework.

The idle injection cycle is fixed while the running cycle is variable. That
allows to have control on the device reactivity for the user experience.

An idle state powering down the CPU or the cluster will allow to drop
the static leakage, thus restoring the heat capacity of the SoC. It
can be set with a trip point between the hot and the critical points,
giving the opportunity to prevent a hard reset of the system when the
cpufreq cooling fails to cool down the CPU.

With more sophisticated boards having a per core sensor, the idle
cooling device allows to cool down a single core without throttling
the compute capacity of several cpus belonging to the same clock line,
so it could be used in collaboration with the cpufreq cooling device.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 V3:
   - Add missing parameter documentation (Viresh Kumar)
   - Fixed function description (Viresh Kumar)
   - Add entry in MAINTAINER file
 V2:
   - Remove idle_duration_us field and use idle_inject API instead (Viresh Kumar)
   - Fixed function definition wheh CPU_IDLE_COOLING is not set
   - Inverted the initialization in the init function (Viresh Kumar)
---
 MAINTAINERS                       |   3 +
 drivers/thermal/Kconfig           |   7 +
 drivers/thermal/Makefile          |   1 +
 drivers/thermal/cpuidle_cooling.c | 234 ++++++++++++++++++++++++++++++
 include/linux/cpu_cooling.h       |  22 +++
 5 files changed, 267 insertions(+)
 create mode 100644 drivers/thermal/cpuidle_cooling.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c570f0204b48..d2e92a0360f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16187,12 +16187,15 @@ F:	Documentation/devicetree/bindings/thermal/
 
 THERMAL/CPU_COOLING
 M:	Amit Daniel Kachhap <amit.kachhap@gmail.com>
+M:	Daniel Lezcano <daniel.lezcano@linaro.org>
 M:	Viresh Kumar <viresh.kumar@linaro.org>
 M:	Javi Merino <javi.merino@kernel.org>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	Documentation/driver-api/thermal/cpu-cooling-api.rst
+F:	Documentation/driver-api/thermal/cpu-idle-cooling.rst
 F:	drivers/thermal/cpu_cooling.c
+F:	drivers/thermal/cpuidle_cooling.c
 F:	include/linux/cpu_cooling.h
 
 THINKPAD ACPI EXTRAS DRIVER
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 4e3ee036938b..4ee9953ba5ce 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -169,6 +169,13 @@ config CPU_FREQ_THERMAL
 	  This will be useful for platforms using the generic thermal interface
 	  and not the ACPI interface.
 
+config CPU_IDLE_THERMAL
+	bool "CPU idle cooling device"
+	depends on IDLE_INJECT
+	help
+	  This implements the CPU cooling mechanism through
+	  idle injection. This will throttle the CPU by injecting
+	  idle cycle.
 endif
 
 config CLOCK_THERMAL
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index d3b01cc96981..9c8aa2d4bd28 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -20,6 +20,7 @@ thermal_sys-$(CONFIG_THERMAL_GOV_POWER_ALLOCATOR)	+= power_allocator.o
 
 # cpufreq cooling
 thermal_sys-$(CONFIG_CPU_FREQ_THERMAL)	+= cpu_cooling.o
+thermal_sys-$(CONFIG_CPU_IDLE_THERMAL)	+= cpuidle_cooling.o
 
 # clock cooling
 thermal_sys-$(CONFIG_CLOCK_THERMAL)	+= clock_cooling.o
diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
new file mode 100644
index 000000000000..7d91a1b298d4
--- /dev/null
+++ b/drivers/thermal/cpuidle_cooling.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2019 Linaro Limited.
+ *
+ *  Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ */
+#include <linux/cpu_cooling.h>
+#include <linux/cpuidle.h>
+#include <linux/err.h>
+#include <linux/idle_inject.h>
+#include <linux/idr.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+
+/**
+ * struct cpuidle_cooling_device - data for the idle cooling device
+ * @ii_dev: an atomic to keep track of the last task exiting the idle cycle
+ * @state: an normalized integer giving the state of the cooling device
+ */
+struct cpuidle_cooling_device {
+	struct idle_inject_device *ii_dev;
+	unsigned long state;
+};
+
+static DEFINE_IDA(cpuidle_ida);
+
+/**
+ * cpuidle_cooling_runtime - Running time computation
+ * @idle_duration_us: the idle cooling device
+ * @state: a percentile based number
+ *
+ * The running duration is computed from the idle injection duration
+ * which is fixed. If we reach 100% of idle injection ratio, that
+ * means the running duration is zero. If we have a 50% ratio
+ * injection, that means we have equal duration for idle and for
+ * running duration.
+ *
+ * The formula is deduced as the following:
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
+ * Returns an unsigned int for an usec based runtime duration.
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
+ * The function always gives 100 as the injection ratio is percentile
+ * based for consistency accros different platforms.
+ *
+ * The function can not fail, it always returns zero.
+ */
+static int cpuidle_cooling_get_max_state(struct thermal_cooling_device *cdev,
+					 unsigned long *state)
+{
+	/*
+	 * Depending on the configuration or the hardware, the running
+	 * cycle and the idle cycle could be different. We want unify
+	 * that to an 0..100 interval, so the set state interface will
+	 * be the same whatever the platform is.
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
+ * The function just copy the state value from the private thermal
+ * cooling device structure, the mapping is 1 <-> 1.
+ *
+ * The function can not fail, it always returns zero.
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
+ * The function can not fail, it always returns zero.
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
+	if (current_state == 0 && state > 0) {
+		idle_inject_start(ii_dev);
+	} else if (current_state > 0 && !state)  {
+		idle_inject_stop(ii_dev);
+	}
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
+/**
+ * cpuidle_of_cooling_register - Idle cooling device initialization function
+ * @drv: a cpuidle driver structure pointer
+ * @np: a node pointer to a device tree cooling device node
+ *
+ * This function is in charge of creating a cooling device per cpuidle
+ * driver and register it to thermal framework.
+ *
+ * Returns a valid pointer to a thermal cooling device or a PTR_ERR
+ * corresponding to the error detected in the underlying subsystems.
+ */
+struct thermal_cooling_device *
+__init cpuidle_of_cooling_register(struct device_node *np,
+				   struct cpuidle_driver *drv)
+{
+	struct idle_inject_device *ii_dev;
+	struct cpuidle_cooling_device *idle_cdev;
+	struct thermal_cooling_device *cdev;
+	char dev_name[THERMAL_NAME_LENGTH];
+	int id, ret;
+
+	idle_cdev = kzalloc(sizeof(*idle_cdev), GFP_KERNEL);
+	if (!idle_cdev) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	id = ida_simple_get(&cpuidle_ida, 0, 0, GFP_KERNEL);
+	if (id < 0) {
+		ret = id;
+		goto out_kfree;
+	}
+
+	ii_dev = idle_inject_register(drv->cpumask);
+	if (IS_ERR(ii_dev)) {
+		ret = PTR_ERR(ii_dev);
+		goto out_id;
+	}
+
+	idle_inject_set_duration(ii_dev, 0, TICK_USEC);
+	
+	idle_cdev->ii_dev = ii_dev;
+
+	snprintf(dev_name, sizeof(dev_name), "thermal-idle-%d", id);
+
+	cdev = thermal_of_cooling_device_register(np, dev_name, idle_cdev,
+						  &cpuidle_cooling_ops);
+	if (IS_ERR(cdev)) {
+		ret = PTR_ERR(cdev);
+		goto out_unregister;
+	}
+
+	return cdev;
+
+out_unregister:
+	idle_inject_unregister(ii_dev);
+out_id:
+	ida_simple_remove(&cpuidle_ida, id);
+out_kfree:
+	kfree(idle_cdev);
+out:
+	return ERR_PTR(ret);
+}
+
+/**
+ * cpuidle_cooling_register - Idle cooling device initialization function
+ * @drv: a cpuidle driver structure pointer
+ *
+ * This function is in charge of creating a cooling device per cpuidle
+ * driver and register it to thermal framework.
+ *
+ * Returns a valid pointer to a thermal cooling device, a PTR_ERR
+ * corresponding to the error detected in the underlying subsystems.
+ */
+struct thermal_cooling_device *
+__init cpuidle_cooling_register(struct cpuidle_driver *drv)
+{
+	return cpuidle_of_cooling_register(NULL, drv);
+}
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index 3cdd85f987d7..da0970183d1f 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -60,4 +60,26 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 }
 #endif /* CONFIG_CPU_FREQ_THERMAL */
 
+struct cpuidle_driver;
+
+#ifdef CONFIG_CPU_IDLE_THERMAL
+extern struct thermal_cooling_device *
+__init cpuidle_cooling_register(struct cpuidle_driver *drv);
+extern struct thermal_cooling_device *
+__init cpuidle_of_cooling_register(struct device_node *np,
+				   struct cpuidle_driver *drv);
+#else /* CONFIG_CPU_IDLE_THERMAL */
+static inline struct thermal_cooling_device *
+__init cpuidle_cooling_register(struct cpuidle_driver *drv)
+{
+	return ERR_PTR(-EINVAL);
+}
+static inline struct thermal_cooling_device *
+__init cpuidle_of_cooling_register(struct device_node *np,
+				   struct cpuidle_driver *drv)
+{
+	return ERR_PTR(-EINVAL);
+}
+#endif /* CONFIG_CPU_IDLE_THERMAL */
+
 #endif /* __CPU_COOLING_H__ */
-- 
2.17.1

