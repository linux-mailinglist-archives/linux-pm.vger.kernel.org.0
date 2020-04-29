Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C761BD9C3
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 12:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgD2Kh0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 06:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgD2KhX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 06:37:23 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2BEC03C1AD
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 03:37:22 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y24so1449192wma.4
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 03:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4BErJC6KRfWCnz8NSAcoXYKXbe519BXyQZdFwm5qEVw=;
        b=B76HPlTbE1aslnZihHvt8BZAPlITr5vEUcoxHrGGrtvAS5JufG44R1UfmBCKk3SRDn
         L/rYH90jPU1MBkgIRkhBcpA9s0MpcMzPh4XiO0dULCaD088hQ3vrpxeithka+u9WYC8P
         EvGRQG7yy+eGzn3/cPNTpidIEuVstIH9+6n1l6GfBsK5+cf/PvrCzFPfNpR3esbVPeAD
         J+glQmzg7dIiNEQ96K2jpSeau4li4oflXbURaEWAh7+n0MULD3BJQLMwMfAYQzWHn0+1
         C4XiwNnzbxqUwcxLZqZ/go6jbCnBNcf8J44paoL+Zm3qLwRjku5Lj/0qMVVh+GJPY4Et
         uWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4BErJC6KRfWCnz8NSAcoXYKXbe519BXyQZdFwm5qEVw=;
        b=J8w8t4WrJYWP3GkAnBEV2FCQyIxeDbRk9lWas3NPw6XnW7WtazHI26TYgPaJSY/YL/
         VMMVJmTcN6MMl8odaQgGlK0jRco3JUDetinWKsf6sYHtarsOP6i31I2S/6euaTPHYGXk
         DtkXm98XLLWABVb9oGigPl7FiWhjjY4xy0Bw3lUzkgDvyJHvL0wrilXqSCg6qPzpm3CM
         BJFiaZZYqJcOiDpG09gOw7VBB2qTI4nbKw3TAj4G7kr6LJmu3TgbnnTGkjUHhy3Q4uky
         D6hZOqXbnKMrVckHcLRs8GMBCUqS6nu71OSvUG5iWaBSBL26AZvrj3h4QNwPtStl84qT
         ROpQ==
X-Gm-Message-State: AGi0PuZv00YBdtJVwZAX7De1Dnj6Ql+g5NoiSRk7UQ8ZkV1PH60mUAGr
        doXoECcMAVxPU+xN1IuLC55Dxw==
X-Google-Smtp-Source: APiQypKPk0a+LLJVix0A+G1VNn5pAbxm+0+ow7YRHU35c43wJNuqHfp+W4Y9oJo1+GmlYd4WQuZAVQ==
X-Received: by 2002:a1c:6344:: with SMTP id x65mr2551467wmb.56.1588156640594;
        Wed, 29 Apr 2020 03:37:20 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:d494:5741:b700:698f])
        by smtp.gmail.com with ESMTPSA id f23sm6899576wml.4.2020.04.29.03.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 03:37:20 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     lukasz.luba@arm.com, Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org (open list:THERMAL/CPU_COOLING),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 3/4] thermal/drivers/cpuidle_cooling: Change the registration function
Date:   Wed, 29 Apr 2020 12:36:41 +0200
Message-Id: <20200429103644.5492-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429103644.5492-1-daniel.lezcano@linaro.org>
References: <20200429103644.5492-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Today, there is no user for the cpuidle cooling device. The targetted
platform is ARM and ARM64.

The cpuidle and the cpufreq cooling device are based on the device tree.

As the cpuidle cooling device can have its own configuration depending
on the platform and the available idle states. The DT node description
will give the optional properties to set the cooling device up.

Do no longer rely on the CPU node which is prone to error and will
lead to a confusion in the DT because the cpufreq cooling device is
also using it. Let initialize the cpuidle cooling device with the DT
binding.

This was tested on:
 - hikey960
 - hikey6220
 - rock960
 - db845c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 - V4:
   - Changed message from pr_info to pr_debug
   - Fixed of properties to comply with the binding
   - Add a debug message int case the thermal-idle node is not found
   - Do not return an error as the caller won't care
---
 drivers/thermal/cpuidle_cooling.c | 63 +++++++++++++++++++++++++------
 include/linux/cpu_cooling.h       | 12 +-----
 2 files changed, 53 insertions(+), 22 deletions(-)

diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
index 0bb843246f59..78e3e8238116 100644
--- a/drivers/thermal/cpuidle_cooling.c
+++ b/drivers/thermal/cpuidle_cooling.c
@@ -5,11 +5,14 @@
  *  Author: Daniel Lezcano <daniel.lezcano@linaro.org>
  *
  */
+#define pr_fmt(fmt) "cpuidle cooling: " fmt
+
 #include <linux/cpu_cooling.h>
 #include <linux/cpuidle.h>
 #include <linux/err.h>
 #include <linux/idle_inject.h>
 #include <linux/idr.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/thermal.h>
 
@@ -154,22 +157,25 @@ static struct thermal_cooling_device_ops cpuidle_cooling_ops = {
 };
 
 /**
- * cpuidle_of_cooling_register - Idle cooling device initialization function
+ * __cpuidle_cooling_register: register the cooling device
  * @drv: a cpuidle driver structure pointer
- * @np: a node pointer to a device tree cooling device node
+ * @np: a device node structure pointer used for the thermal binding
  *
- * This function is in charge of creating a cooling device per cpuidle
- * driver and register it to thermal framework.
+ * This function is in charge of allocating the cpuidle cooling device
+ * structure, the idle injection, initialize them and register the
+ * cooling device to the thermal framework.
  *
- * Return: zero on success, or negative value corresponding to the
- * error detected in the underlying subsystems.
+ * Return: zero on success, a negative value returned by one of the
+ * underlying subsystem in case of error
  */
-int cpuidle_of_cooling_register(struct device_node *np,
-				struct cpuidle_driver *drv)
+static int __cpuidle_cooling_register(struct device_node *np,
+				      struct cpuidle_driver *drv)
 {
 	struct idle_inject_device *ii_dev;
 	struct cpuidle_cooling_device *idle_cdev;
 	struct thermal_cooling_device *cdev;
+	unsigned int idle_duration_us = TICK_USEC;
+	unsigned int latency_us = UINT_MAX;
 	char dev_name[THERMAL_NAME_LENGTH];
 	int id, ret;
 
@@ -191,7 +197,11 @@ int cpuidle_of_cooling_register(struct device_node *np,
 		goto out_id;
 	}
 
-	idle_inject_set_duration(ii_dev, TICK_USEC, TICK_USEC);
+	of_property_read_u32(np, "duration-us", &idle_duration_us);
+	of_property_read_u32(np, "exit-latency-us", &latency_us);
+
+	idle_inject_set_duration(ii_dev, TICK_USEC, idle_duration_us);
+	idle_inject_set_latency(ii_dev, latency_us);
 
 	idle_cdev->ii_dev = ii_dev;
 
@@ -204,6 +214,9 @@ int cpuidle_of_cooling_register(struct device_node *np,
 		goto out_unregister;
 	}
 
+	pr_debug("%s: Idle injection set with idle duration=%u, latency=%u\n",
+		 dev_name, idle_duration_us, latency_us);
+
 	return 0;
 
 out_unregister:
@@ -221,12 +234,38 @@ int cpuidle_of_cooling_register(struct device_node *np,
  * @drv: a cpuidle driver structure pointer
  *
  * This function is in charge of creating a cooling device per cpuidle
- * driver and register it to thermal framework.
+ * driver and register it to the thermal framework.
  *
  * Return: zero on success, or negative value corresponding to the
  * error detected in the underlying subsystems.
  */
-int cpuidle_cooling_register(struct cpuidle_driver *drv)
+void cpuidle_cooling_register(struct cpuidle_driver *drv)
 {
-	return cpuidle_of_cooling_register(NULL, drv);
+	struct device_node *cooling_node;
+	struct device_node *cpu_node;
+	int cpu, ret;
+
+	for_each_cpu(cpu, drv->cpumask) {
+
+		cpu_node = of_cpu_device_node_get(cpu);
+
+		cooling_node = of_get_child_by_name(cpu_node, "thermal-idle");
+
+		of_node_put(cpu_node);
+
+		if (!cooling_node) {
+			pr_debug("'thermal-idle' node not found for cpu%d\n", cpu);
+			continue;
+		}
+
+		ret = __cpuidle_cooling_register(cooling_node, drv);
+
+		of_node_put(cooling_node);
+
+		if (ret) {
+			pr_err("Failed to register the cpuidle cooling device" \
+			       "for cpu%d: %d\n", cpu, ret);
+			break;
+		}
+	}
 }
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index 65501d8f9778..a3bdc8a98f2c 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -63,18 +63,10 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 struct cpuidle_driver;
 
 #ifdef CONFIG_CPU_IDLE_THERMAL
-int cpuidle_cooling_register(struct cpuidle_driver *drv);
-int cpuidle_of_cooling_register(struct device_node *np,
-				struct cpuidle_driver *drv);
+void cpuidle_cooling_register(struct cpuidle_driver *drv);
 #else /* CONFIG_CPU_IDLE_THERMAL */
-static inline int cpuidle_cooling_register(struct cpuidle_driver *drv)
+static inline void cpuidle_cooling_register(struct cpuidle_driver *drv)
 {
-	return 0;
-}
-static inline int cpuidle_of_cooling_register(struct device_node *np,
-					      struct cpuidle_driver *drv)
-{
-	return 0;
 }
 #endif /* CONFIG_CPU_IDLE_THERMAL */
 
-- 
2.17.1

