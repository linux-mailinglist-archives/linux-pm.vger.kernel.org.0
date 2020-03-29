Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 543011970B2
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 00:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgC2WHP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 18:07:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38735 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729221AbgC2WHP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 18:07:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id f6so12792360wmj.3
        for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2020 15:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D5NWO+IUoIhwqTXjsgin0kU4/g2KEq9vhU/rf+OCJRE=;
        b=djA9o7R4SFARI6kpWiE6Tv1ZcX+9ah7u0FCxo204Tz1xKvYapnAqSNW7+e1rExw9hA
         cScGbDtfFFd3E+IaXNQ9xz5DlVgMaMolj6VfhBXVzgwBe6XPRUIWJJzvMl7qd57PeEsP
         9xREH0V1CnfkghpyvbQKn6eQLSoDWx3CHXiwSv8zU+DmkqCw3eUsJ1bW/lOphz8JHdYp
         Ff/ApIyeJsHWXWyUyjAupovAi9KcaJJjspk/Iu+J3ei9E6yz+ErHMtqGsEXxYT85qDLI
         cupuzz9bOUZiFlkSFUUl3nQHtEfS9OIUPSq09hhjtH5yXP9rOMl+XqXZvc00Yc4JA5mT
         YZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D5NWO+IUoIhwqTXjsgin0kU4/g2KEq9vhU/rf+OCJRE=;
        b=OiIqvYhkEC+ffYo+2QQ2gH6UD72sPFy6mDDpSX4MTcizDvoReJlsLCNl51wgSsXrX4
         97cjJJrzVDCZuC58GIXVc6JCtUNDZ3kks7g0XERfo+gvmcKjl0BGglc+nP5ewqWBB6aN
         sEAh0JMlEV2YcwapuUnaIPCK2dWv2ne+zJ0oqK4bIjajdLard1+ETi/SIKEiOBO3qILI
         ITsiiMaPXZET2zH88trksSQKfzQUtpV79r3wZGWuDDP86sWy46LUJ2C9wv6iOV2+j+l0
         nnIneugJvLhuKJIymOkd04leLTY6ajycvWoxwtjexOd+EdYB6io9V8APLVG5B/jY4jNh
         xNYQ==
X-Gm-Message-State: ANhLgQ37nv+rWmW9pUxT5GYhbCZaQkwysXYjbFPrBfW+TXQoGN2T7Jkz
        +1Uf/yhL6MTk8hvIAajgaUk5/Q==
X-Google-Smtp-Source: ADFU+vvzXFUCDyZcT3pEMMwt/ox+/SASrPq0wEB9fcW9K9j0slV/aodRKm5px9/UJgj9zV5CarULSA==
X-Received: by 2002:a1c:2007:: with SMTP id g7mr10098519wmg.70.1585519633758;
        Sun, 29 Mar 2020 15:07:13 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:78b1:4459:6959:42d0])
        by smtp.gmail.com with ESMTPSA id j188sm20026740wmj.36.2020.03.29.15.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 15:07:13 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, robh@kernel.org
Cc:     daniel.lezcano@linaro.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org (open list:THERMAL/CPU_COOLING),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/4] thermal/drivers/cpuidle_cooling: Change the registration function
Date:   Mon, 30 Mar 2020 00:03:19 +0200
Message-Id: <20200329220324.8785-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200329220324.8785-1-daniel.lezcano@linaro.org>
References: <20200329220324.8785-1-daniel.lezcano@linaro.org>
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

