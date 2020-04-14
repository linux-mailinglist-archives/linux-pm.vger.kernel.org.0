Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4481A8E3D
	for <lists+linux-pm@lfdr.de>; Wed, 15 Apr 2020 00:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634166AbgDNWJD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 18:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2634157AbgDNWJB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2020 18:09:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA5EC061A10
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2020 15:09:00 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y24so16207435wma.4
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2020 15:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2gAWHTXX9bF3sN9XblA+dduErzaItlbFPxUTg2AHv9w=;
        b=CeM/zs/UclThxyDL0iHjwTNNx8BhkPJ20N26rghrVb6K5+LCtGWb5MyTEpcd5rEu3E
         CjsI8KSkwYIQWPrq/HOTk+DGqsK5StvgJrn2YXO0W4wFG/IwyjNRpcFoGbVYhy5HR7KR
         +KauMyN+PYYV+jpDuZq3+A8+/LKf23wuLKoFrPZAv5IgX443ZelPT7+u+VFIV3lkhsOb
         s+PA2lmTX4OWgel7/vfshUk87fC4AzigbjZ2H+ZaLrm/foXHuGamGG7c+5MfhQXCnfg9
         9u5W0WXehBW+qkoic9fY3NhJ5lnFDi0uT/7j5BbbjkK1sfcd1I0Ds4vkJAN5ci+ZTNTv
         +Dtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2gAWHTXX9bF3sN9XblA+dduErzaItlbFPxUTg2AHv9w=;
        b=kMXCdDtUjdWwEO0Y0Eqh4o+x0I/mxgl7O1vNIj9CUteCbztl2gu0pk0lUycb3Jx86T
         H2QN/PEZWK6iXQxnFNdZrCukSyBHLlaHAsMgfksPC0gQuEObRFQobu3dig8axg3zbNuS
         5V4yHtCDRKFg250H1ixhC+TdoBLt7ogznkhTzDCaKIjESeoy6y94xOCojf4SQJbxAJzL
         wqvLsmtYF7Cw/q8cnIozgrbQLryULKrkKAb+bkbseUGtZsSoEi+aJ3jspmvzK3L7HtT4
         2qjHj7LrrNufGUBXL9LQ/OgN2gNNJNBDM2zhV26cTy97TjjgkUPQP/YqVcjFuPjmKKbn
         mJMA==
X-Gm-Message-State: AGi0PuYZ13Rdd3SIMuuRS/Ncm+rKEYdunI+8fVRg4uuTIaqmDROljmM7
        8dpdYiT6jBvTw8+I/TLWA1EHLA==
X-Google-Smtp-Source: APiQypKE+PiQzpQOD6XHn4FFGCkS3xwrkZsF4sltqgVV63EDuVSL7DA5q/T28tGOrQyTlevnqXAkhQ==
X-Received: by 2002:a1c:998b:: with SMTP id b133mr1885789wme.65.1586902139388;
        Tue, 14 Apr 2020 15:08:59 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.gmail.com with ESMTPSA id a7sm4099973wrs.61.2020.04.14.15.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 15:08:58 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        linux-pm@vger.kernel.org (open list:THERMAL/CPU_COOLING),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 3/4] thermal/drivers/cpuidle_cooling: Change the registration function
Date:   Wed, 15 Apr 2020 00:08:32 +0200
Message-Id: <20200414220837.9284-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200414220837.9284-1-daniel.lezcano@linaro.org>
References: <20200414220837.9284-1-daniel.lezcano@linaro.org>
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
 drivers/thermal/cpuidle_cooling.c | 58 +++++++++++++++++++++++++------
 include/linux/cpu_cooling.h       |  7 ----
 2 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
index 0bb843246f59..b2c81c427f05 100644
--- a/drivers/thermal/cpuidle_cooling.c
+++ b/drivers/thermal/cpuidle_cooling.c
@@ -10,6 +10,7 @@
 #include <linux/err.h>
 #include <linux/idle_inject.h>
 #include <linux/idr.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/thermal.h>
 
@@ -154,22 +155,25 @@ static struct thermal_cooling_device_ops cpuidle_cooling_ops = {
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
 
@@ -191,7 +195,11 @@ int cpuidle_of_cooling_register(struct device_node *np,
 		goto out_id;
 	}
 
-	idle_inject_set_duration(ii_dev, TICK_USEC, TICK_USEC);
+	of_property_read_u32(np, "duration", &idle_duration_us);
+	of_property_read_u32(np, "latency", &latency_us);
+
+	idle_inject_set_duration(ii_dev, TICK_USEC, idle_duration_us);
+	idle_inject_set_latency(ii_dev, latency_us);
 
 	idle_cdev->ii_dev = ii_dev;
 
@@ -204,6 +212,9 @@ int cpuidle_of_cooling_register(struct device_node *np,
 		goto out_unregister;
 	}
 
+	pr_info("%s: Idle injection set with idle duration=%u, latency=%u\n",
+		dev_name, idle_duration_us, latency_us);
+
 	return 0;
 
 out_unregister:
@@ -221,12 +232,37 @@ int cpuidle_of_cooling_register(struct device_node *np,
  * @drv: a cpuidle driver structure pointer
  *
  * This function is in charge of creating a cooling device per cpuidle
- * driver and register it to thermal framework.
+ * driver and register it to the thermal framework.
  *
  * Return: zero on success, or negative value corresponding to the
  * error detected in the underlying subsystems.
  */
 int cpuidle_cooling_register(struct cpuidle_driver *drv)
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
+		cooling_node = of_get_child_by_name(cpu_node, "idle-thermal");
+
+		of_node_put(cpu_node);
+
+		if (!cooling_node)
+			continue;
+
+		ret = __cpuidle_cooling_register(cooling_node, drv);
+
+		of_node_put(cooling_node);
+
+		if (ret)
+			return ret;
+
+		cooling_node = NULL;
+	}
+
+	return 0;
 }
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index 65501d8f9778..4d7b4a303327 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -64,18 +64,11 @@ struct cpuidle_driver;
 
 #ifdef CONFIG_CPU_IDLE_THERMAL
 int cpuidle_cooling_register(struct cpuidle_driver *drv);
-int cpuidle_of_cooling_register(struct device_node *np,
-				struct cpuidle_driver *drv);
 #else /* CONFIG_CPU_IDLE_THERMAL */
 static inline int cpuidle_cooling_register(struct cpuidle_driver *drv)
 {
 	return 0;
 }
-static inline int cpuidle_of_cooling_register(struct device_node *np,
-					      struct cpuidle_driver *drv)
-{
-	return 0;
-}
 #endif /* CONFIG_CPU_IDLE_THERMAL */
 
 #endif /* __CPU_COOLING_H__ */
-- 
2.17.1

