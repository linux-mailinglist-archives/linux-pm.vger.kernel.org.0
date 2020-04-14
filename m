Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3298C1A84CE
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 18:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391566AbgDNQ1Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 12:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391543AbgDNQ1C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2020 12:27:02 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEEEC061A41
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2020 09:27:02 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y24so14714244wma.4
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2020 09:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2gAWHTXX9bF3sN9XblA+dduErzaItlbFPxUTg2AHv9w=;
        b=CmYy7Gx2MmdR2x17TXmgLS0eT5tWxyYZLoxFmNpc/yHtBfN43Gp3tg1TYDVkSiNSIj
         EHCGCprtq7HIgNsH9IjKb2sl0CQh6l0CbjJrM2jzD9V280pWcpsMp89EaGmwNQvZ9fCq
         9tgAOe3g1qM4o+xVG37exLEGdDuhKWbsMAxcZWIcTDhaj74KPXvDxwSN8ZyT4LHjC8G8
         pUD2WzH0XK3woSgM3oirkFtm1lGuffopvqSFRRL12ZFIymMX5qBX1uG3Fg5d6ZnYB05W
         rXqib2qozuoCplNAyOgIg1p2T6kD9cCTC9iRBYZX+SwYMhEUsHLQfUzqUcEmzfwVbXrl
         rZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2gAWHTXX9bF3sN9XblA+dduErzaItlbFPxUTg2AHv9w=;
        b=TXZKTIHL9AgBOwHGWXrzD+PHJz2yf16spFuMBYTulQiJBVd/0t6RgWorlFy/6030YB
         Jtd3wv0MjnJ6zWfIovVpbOvKVTH9PmZQXTZpfZ6p1vHJrBoAhKMUD9/Y/9NHP6VclJdS
         3Q9JlDg+A+WOjzYbjCTQ+2asFluOwYCumIskLfnhk7PflJ4/zha0pxW8sA/9EobQ6YAJ
         SMlldZIeasPCLBKl7X34mCC0riv2rD4R0bLS6dUJGtySa+JZZ9PmvSKzZ7S1cKLTKgqT
         /mtEx2BT1u9oh8lbWcksLukqvq6Y/4r4xB5K6ILxDXPbmdf4fHih4F6tQL25ML1HfZX2
         wPgQ==
X-Gm-Message-State: AGi0PuYrgk2KdU5qBGQ/fm3SgRzsLjpFHpi+BoF3LfXc/5B4UpzXgcql
        cdNOvoJbXOeaEixuUXPS+fGrww==
X-Google-Smtp-Source: APiQypLoZV+Qx2IOVwhXvr7vi6Y6ruM76qqk41hVywGCjcU1j2QxgX97HkH4IKDq6sYBUuKjbxSCVw==
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr655247wmk.36.1586881621026;
        Tue, 14 Apr 2020 09:27:01 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.gmail.com with ESMTPSA id s14sm20199388wme.33.2020.04.14.09.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:27:00 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        linux-pm@vger.kernel.org (open list:THERMAL/CPU_COOLING),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/4] thermal/drivers/cpuidle_cooling: Change the registration function
Date:   Tue, 14 Apr 2020 18:26:28 +0200
Message-Id: <20200414162634.1867-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200414162634.1867-1-daniel.lezcano@linaro.org>
References: <20200414162634.1867-1-daniel.lezcano@linaro.org>
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

