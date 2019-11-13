Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5CCFAC29
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 09:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfKMIlA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 03:41:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40062 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfKMIk6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 03:40:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id f3so996535wmc.5
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 00:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zp55sUzE/6lRk6a8ivnPTNcYxH9H+Lr3SiBACXS3e9U=;
        b=Tia/8E42XjbaQKn88fLe4L7drwoSdKwJdVXHfuantIzq2ohNNGYPjBoF6VaRmZla3U
         Ur4l6+lOwcfxvlzWDCqcrt/E93LHFOQKVdSvDElAiUsQbOlJtbWJSKiSiEsCN1asxt3d
         tUFT+sxPpQVKpBPgVeLSZ9P7D2HLLUJ66ZG45z5tA5KHo99a0iCP049Sr39z7haVCXg9
         mCXwZezoZsXlOm6zq0iwZ/6n+lQxsETMwl/jFVKH8wDZefYkyW0Q7OaxdFjFe48QD2dY
         0YL9MtZZX1+fzBsDFiwAHF6fayksdeR/ah5GCoc9PVWndfa0pXLqafipXyHOc0LUlVF9
         9DWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zp55sUzE/6lRk6a8ivnPTNcYxH9H+Lr3SiBACXS3e9U=;
        b=OqUaRZOz+m1qCFDjXVzBRXGvjF+uD0/NNFcy3eA/v4bIM9jDmZRU2yDG1Kr3i7SmzA
         TIWcbnRn3ibKRGV0MyRa7jeSmpUnR2utWqgSeW9lfp76D+h1ONlwMK4EvHuEfYrIFVSi
         HmNroGwAEwrAIkV5hTjGywNqlv8yPIRUA5xH/iA3bKSDOPA9f1ac6WKGL+4ENOVvPZ7o
         zVJKtaLlzURUrMNiOOndI0nBph6ChxpTpKkoZCywmbBAMNgcHQ6pZhK2ftan25XYy0nN
         kfAIwfSkM48gQyLhjcEK0i/g2uvb/vCt18srJCD0mHR7qxRqtScRJvnF0Uv0eAiF1Hmc
         3KdQ==
X-Gm-Message-State: APjAAAVuzsiJhnSNbkKpNCNAIJwfnCP7ECoKXJ8Y2fZByB9FtE0eQoyb
        gxptY1r6yzszAELDkrbB/5imXA==
X-Google-Smtp-Source: APXvYqxy0Nu4iDJ1TERfnDLyecI5kRzzX3Fq81GFUXHoLdj5SoG8ZZgzgn0kLmkX/wK+bE7cwUOEng==
X-Received: by 2002:a1c:99cb:: with SMTP id b194mr1722398wme.100.1573634456103;
        Wed, 13 Nov 2019 00:40:56 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:8174:caa5:2144:f60])
        by smtp.gmail.com with ESMTPSA id h205sm1667499wmf.35.2019.11.13.00.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 00:40:55 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net, edubezval@gmail.com, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] thermal/drivers/cpu_cooling: Introduce the cpu idle cooling driver
Date:   Wed, 13 Nov 2019 09:40:42 +0100
Message-Id: <20191113084042.5707-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191113084042.5707-1-daniel.lezcano@linaro.org>
References: <20191113084042.5707-1-daniel.lezcano@linaro.org>
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
---
 drivers/thermal/Kconfig           |   7 +
 drivers/thermal/Makefile          |   1 +
 drivers/thermal/cpuidle_cooling.c | 233 ++++++++++++++++++++++++++++++
 include/linux/cpu_cooling.h       |  22 +++
 4 files changed, 263 insertions(+)
 create mode 100644 drivers/thermal/cpuidle_cooling.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 2b82c4861091..00d69906c508 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -168,6 +168,13 @@ config CPU_FREQ_THERMAL
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
index 000000000000..6e911fa87c47
--- /dev/null
+++ b/drivers/thermal/cpuidle_cooling.c
@@ -0,0 +1,233 @@
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
+ * @idle_duration_us: an integer defining the duration of the idle injection
+ * @state: an normalized integer giving the state of the cooling device
+ */
+struct cpuidle_cooling_device {
+	struct idle_inject_device *ii_dev;
+	unsigned int idle_duration_us;
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
+	unsigned int runtime_us;
+
+	idle_cdev->state = state;
+
+	runtime_us = cpuidle_cooling_runtime(idle_cdev->idle_duration_us,
+					     state);
+
+	idle_inject_set_duration(ii_dev, runtime_us,
+				 idle_cdev->idle_duration_us);
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
+ *
+ * This function is in charge of creating a cooling device per cpuidle
+ * driver and register it to thermal framework.
+ *
+ * Returns a valid pointer to a thermal cooling device, a PTR_ERR
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
+	ii_dev = idle_inject_register(drv->cpumask);
+	if (IS_ERR(ii_dev)) {
+		ret = PTR_ERR(ii_dev);
+		goto out;
+	}
+
+	idle_cdev = kzalloc(sizeof(*idle_cdev), GFP_KERNEL);
+	if (!idle_cdev) {
+		ret = -ENOMEM;
+		goto out_unregister;
+	}
+
+	id = ida_simple_get(&cpuidle_ida, 0, 0, GFP_KERNEL);
+	if (id < 0) {
+		ret = id;
+		goto out_kfree;
+	}
+
+	idle_cdev->ii_dev = ii_dev;
+	idle_cdev->idle_duration_us = TICK_USEC;
+
+	snprintf(dev_name, sizeof(dev_name), "thermal-idle-%d", id);
+
+	cdev = thermal_of_cooling_device_register(np, dev_name, idle_cdev,
+						  &cpuidle_cooling_ops);
+	if (IS_ERR(cdev)) {
+		ret = PTR_ERR(cdev);
+		goto out_id;
+	}
+
+	return cdev;
+out_id:
+	ida_simple_remove(&cpuidle_ida, id);
+out_kfree:
+	kfree(idle_cdev);
+out_unregister:
+	idle_inject_unregister(ii_dev);
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
index 3cdd85f987d7..7873ac2f740b 100644
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
+extern struct thermal_cooling_device *
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

