Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF32339438
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 18:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhCLRDi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 12:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbhCLRDc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 12:03:32 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993E9C061763
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 09:03:31 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c76-20020a1c9a4f0000b029010c94499aedso16227062wme.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 09:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s7fCt8jAahXLsklhkFc/v9K2fCeNdzwdfE44cqbig58=;
        b=X0lBMvAlM/aI9s6P8gpDF/A2H6hRtLmQX0fu6RSroOLDo+GfgC5JMl46hETKXvJ+9E
         JfSuZ+xVrLucKcrdR6RseL/Hpv7SMTiseGuTidEInW56e1miGmBEWBWLRtQ/1DL07r7w
         MFWp1EtKUFh+jWd6/bg3j2hUlW1PZipr6ikhhpomDNbI5+mr84zY5Hb8J8Li4bMNYqxx
         i3dYvIQeXJrm20peNAiseQaBbaeTdEcR4NrqMLbKx+KETP7W1u7zxwnZ67IcWEIzy2aD
         5Sr3+pBRXt5BtK8VoumFQi2vULgDs0C8pSrEXAi7b9Z1paRxQo9g3ym9bY89DcUWxgMe
         HYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s7fCt8jAahXLsklhkFc/v9K2fCeNdzwdfE44cqbig58=;
        b=oktgeqx2W0XJt640KRYuLURP8voeXuZQRgWT0EfQGpPJw7CSbP9Yigk/Saf/BCtJCz
         ZXZ115hLf4UdAnSmOpInfFZWfnkBqdiYEBXuPrVKmpJhFdvoko7VdvRudEtFf1oFpYGE
         xJesJA1z3UVQQqnqfu2Rz6qU09prqMXmNj377w0CH2m8rD4MCa+iizLbkz/hrQZzp3rj
         0xT0cIGE5OhtFxzgd0ySvsz0WhY4/xnonqLRfFyIFq9EPgZth50y+ieVjUm5M9cOFy2W
         I/1yzmzfx9aMS/iCHtbDPmOq+XO/8UVB2ZaX3j8QHo+b8LEtzK+MIeTeQi754Hn1chMn
         bdCg==
X-Gm-Message-State: AOAM533pDCJEa/wK8CuL9j5KoD+RqXJ4fi0ldYNliNwAalR1g4YMwRS/
        5VErk5glLyAC1tMenc21luTHmeib06emHQ==
X-Google-Smtp-Source: ABdhPJypFvYqCkonVq+396IfmkPJ+afGI1syn30KATEJwBQ++/NZnoeLMzqs2Lwy5fh32LRMs4BarQ==
X-Received: by 2002:a1c:1fc6:: with SMTP id f189mr14152756wmf.68.1615568610171;
        Fri, 12 Mar 2021 09:03:30 -0800 (PST)
Received: from localhost.localdomain ([82.142.0.212])
        by smtp.gmail.com with ESMTPSA id 1sm2854681wmj.2.2021.03.12.09.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 09:03:29 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 2/5] thermal/drivers/cpufreq_cooling: Use device name instead of auto-numbering
Date:   Fri, 12 Mar 2021 18:03:13 +0100
Message-Id: <20210312170316.3138-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210312170316.3138-1-daniel.lezcano@linaro.org>
References: <20210312170316.3138-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the naming of a cooling device is just a cooling technique
followed by a number. When there are multiple cooling devices using
the same technique, it is impossible to clearly identify the related
device as this one is just a number.

For instance:

 thermal-cpufreq-0
 thermal-cpufreq-1
 etc ...

The 'thermal' prefix is redundant with the subsystem namespace. This
patch removes the 'thermal' prefix and changes the number by the device
name. So the naming above becomes:

 cpufreq-cpu0
 cpufreq-cpu4
 etc ...

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
V2:
  - Use kasprintf() instead of fixed array length on the stack
  - Fixed typo in the log
  - Removed idr.h inclusion
---
 drivers/thermal/cpufreq_cooling.c | 34 +++++++++++--------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 10af3341e5ea..3f5f1dce1320 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -13,10 +13,10 @@
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpu_cooling.h>
+#include <linux/device.h>
 #include <linux/energy_model.h>
 #include <linux/err.h>
 #include <linux/export.h>
-#include <linux/idr.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
@@ -50,8 +50,6 @@ struct time_in_idle {
 
 /**
  * struct cpufreq_cooling_device - data for cooling device with cpufreq
- * @id: unique integer value corresponding to each cpufreq_cooling_device
- *	registered.
  * @last_load: load measured by the latest call to cpufreq_get_requested_power()
  * @cpufreq_state: integer value representing the current state of cpufreq
  *	cooling	devices.
@@ -69,7 +67,6 @@ struct time_in_idle {
  * cpufreq_cooling_device.
  */
 struct cpufreq_cooling_device {
-	int id;
 	u32 last_load;
 	unsigned int cpufreq_state;
 	unsigned int max_level;
@@ -82,7 +79,6 @@ struct cpufreq_cooling_device {
 	struct freq_qos_request qos_req;
 };
 
-static DEFINE_IDA(cpufreq_ida);
 static DEFINE_MUTEX(cooling_list_lock);
 static LIST_HEAD(cpufreq_cdev_list);
 
@@ -528,11 +524,11 @@ __cpufreq_cooling_register(struct device_node *np,
 {
 	struct thermal_cooling_device *cdev;
 	struct cpufreq_cooling_device *cpufreq_cdev;
-	char dev_name[THERMAL_NAME_LENGTH];
 	unsigned int i;
 	struct device *dev;
 	int ret;
 	struct thermal_cooling_device_ops *cooling_ops;
+	char *name;
 
 	dev = get_cpu_device(policy->cpu);
 	if (unlikely(!dev)) {
@@ -567,16 +563,6 @@ __cpufreq_cooling_register(struct device_node *np,
 	/* max_level is an index, not a counter */
 	cpufreq_cdev->max_level = i - 1;
 
-	ret = ida_simple_get(&cpufreq_ida, 0, 0, GFP_KERNEL);
-	if (ret < 0) {
-		cdev = ERR_PTR(ret);
-		goto free_idle_time;
-	}
-	cpufreq_cdev->id = ret;
-
-	snprintf(dev_name, sizeof(dev_name), "thermal-cpufreq-%d",
-		 cpufreq_cdev->id);
-
 	cooling_ops = &cpufreq_cooling_ops;
 
 #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
@@ -591,7 +577,7 @@ __cpufreq_cooling_register(struct device_node *np,
 		pr_err("%s: unsorted frequency tables are not supported\n",
 		       __func__);
 		cdev = ERR_PTR(-EINVAL);
-		goto remove_ida;
+		goto free_idle_time;
 	}
 
 	ret = freq_qos_add_request(&policy->constraints,
@@ -601,11 +587,18 @@ __cpufreq_cooling_register(struct device_node *np,
 		pr_err("%s: Failed to add freq constraint (%d)\n", __func__,
 		       ret);
 		cdev = ERR_PTR(ret);
-		goto remove_ida;
+		goto free_idle_time;
 	}
 
-	cdev = thermal_of_cooling_device_register(np, dev_name, cpufreq_cdev,
+	cdev = ERR_PTR(-ENOMEM);
+	name = kasprintf(GFP_KERNEL, "cpufreq-%s", dev_name(dev));
+	if (!name)
+		goto remove_qos_req;
+
+	cdev = thermal_of_cooling_device_register(np, name, cpufreq_cdev,
 						  cooling_ops);
+	kfree(name);
+
 	if (IS_ERR(cdev))
 		goto remove_qos_req;
 
@@ -617,8 +610,6 @@ __cpufreq_cooling_register(struct device_node *np,
 
 remove_qos_req:
 	freq_qos_remove_request(&cpufreq_cdev->qos_req);
-remove_ida:
-	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
 free_idle_time:
 	free_idle_time(cpufreq_cdev);
 free_cdev:
@@ -712,7 +703,6 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 
 	thermal_cooling_device_unregister(cdev);
 	freq_qos_remove_request(&cpufreq_cdev->qos_req);
-	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
 	free_idle_time(cpufreq_cdev);
 	kfree(cpufreq_cdev);
 }
-- 
2.17.1

