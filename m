Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083B233A478
	for <lists+linux-pm@lfdr.de>; Sun, 14 Mar 2021 12:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbhCNLOQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 14 Mar 2021 07:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbhCNLOA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 14 Mar 2021 07:14:00 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C288CC061762
        for <linux-pm@vger.kernel.org>; Sun, 14 Mar 2021 04:13:59 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo17727278wmq.4
        for <linux-pm@vger.kernel.org>; Sun, 14 Mar 2021 04:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DuYOMewCZUtcJ4+tVTYyeku7t/eSId6NRi7iq7c/+IU=;
        b=X9StidufVkJ+3sDek2S0nGNm62UHGOd9Vt7j3iEksR5/6KMbqZyNiY7mxArpsZxp6R
         Wk8o5FNiXf8SK3lqCjWn7woo1N/zjL9z6ZZ6RZGmCY4nKK7C9HfrQ4l21m2D8pe2WFGc
         dMFYeAsnQs2M16lfrih7gD708+5PIvMEEz88v/MyggdO3tHmiCYNlVuc6f5Y7hOn3myE
         hR++jfeKoyQpP8rF0sHfrJFbREu13qSQsAq9pfsnZcxH34Q68RS7YfI2y2BSgeCBJH2p
         vzC1MlmVWbSnPU/9y7/9WbQx11Xh9KnWdcrBvnD4RIvpI0ARhIXkbbx5htFEvUspB6mW
         oY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DuYOMewCZUtcJ4+tVTYyeku7t/eSId6NRi7iq7c/+IU=;
        b=mrspjnOKOJ43eJ93U1gk5Pjnnl8nCoDyZhB8o4xFxgZjvB6rpIW0gSpuw+KiBhwa0d
         F21Nx8tGovmf6eltIa4QYUgXCNfPBncIVyrLbYJ010YvR2Bs+O32I4+wDUlaSUDDSSHQ
         W3ZIlS1rJaCescTYUEa0GgwuHybLrMuXv5U95fALnQf/nRk3VS4pmcNpPr+hHXWYryxr
         hvvTWcuHan8gyLzJU4+SqDvdtUw4M7MEx2tnAiltl/1QvOJml1V6D/npGdiKw+uFdDiZ
         v3mvsM64JEDTQIBsVnZ9LuVvuwnmh0wM22v5ot7dc3spL1EXFsYnQ2pP5hcJOlb3Dsp5
         p8tA==
X-Gm-Message-State: AOAM530DQ6g9TCrNARSKJobSmKvN83pLMrKllB8BqnJZAnlU040cIRX5
        YwafalRCUw5jB+6tf+SG3HWhZg==
X-Google-Smtp-Source: ABdhPJxUIAlZcruUVkoM0WT+mHR1G/YYA+CJTe4p8HzcLSUmPx0kKEg9rbKPj/4rWBNvoA5a3xzxlw==
X-Received: by 2002:a05:600c:2254:: with SMTP id a20mr22407030wmm.115.1615720438410;
        Sun, 14 Mar 2021 04:13:58 -0700 (PDT)
Received: from localhost.localdomain ([82.142.0.212])
        by smtp.gmail.com with ESMTPSA id i8sm16828330wry.90.2021.03.14.04.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 04:13:58 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v3 4/5] thermal/drivers/cpuidle_cooling: Use device name instead of auto-numbering
Date:   Sun, 14 Mar 2021 12:13:32 +0100
Message-Id: <20210314111333.16551-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210314111333.16551-1-daniel.lezcano@linaro.org>
References: <20210314111333.16551-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the naming of a cooling device is just a cooling technique
followed by a number. When there are multiple cooling devices using
the same technique, it is impossible to clearly identify the related
device as this one is just a number.

For instance:

 thermal-idle-0
 thermal-idle-1
 thermal-idle-2
 thermal-idle-3
 etc ...

The 'thermal' prefix is redundant with the subsystem namespace. This
patch removes the 'thermal prefix and changes the number by the device
name. So the naming above becomes:

 idle-cpu0
 idle-cpu1
 idle-cpu2
 idle-cpu3
 etc ...

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
V2:
  - Removed idr.h header
  - Used kasprintf instead of fixed buffer length on the stack
  - Fixed typo in the log
---
 drivers/thermal/cpuidle_cooling.c | 33 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
index 7ecab4b16b29..f32976163bad 100644
--- a/drivers/thermal/cpuidle_cooling.c
+++ b/drivers/thermal/cpuidle_cooling.c
@@ -9,9 +9,9 @@
 
 #include <linux/cpu_cooling.h>
 #include <linux/cpuidle.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/idle_inject.h>
-#include <linux/idr.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/thermal.h>
@@ -26,8 +26,6 @@ struct cpuidle_cooling_device {
 	unsigned long state;
 };
 
-static DEFINE_IDA(cpuidle_ida);
-
 /**
  * cpuidle_cooling_runtime - Running time computation
  * @idle_duration_us: CPU idle time to inject in microseconds
@@ -174,10 +172,11 @@ static int __cpuidle_cooling_register(struct device_node *np,
 	struct idle_inject_device *ii_dev;
 	struct cpuidle_cooling_device *idle_cdev;
 	struct thermal_cooling_device *cdev;
+	struct device *dev;
 	unsigned int idle_duration_us = TICK_USEC;
 	unsigned int latency_us = UINT_MAX;
-	char dev_name[THERMAL_NAME_LENGTH];
-	int id, ret;
+	char *name;
+	int ret;
 
 	idle_cdev = kzalloc(sizeof(*idle_cdev), GFP_KERNEL);
 	if (!idle_cdev) {
@@ -185,16 +184,10 @@ static int __cpuidle_cooling_register(struct device_node *np,
 		goto out;
 	}
 
-	id = ida_simple_get(&cpuidle_ida, 0, 0, GFP_KERNEL);
-	if (id < 0) {
-		ret = id;
-		goto out_kfree;
-	}
-
 	ii_dev = idle_inject_register(drv->cpumask);
 	if (!ii_dev) {
 		ret = -EINVAL;
-		goto out_id;
+		goto out_kfree;
 	}
 
 	of_property_read_u32(np, "duration-us", &idle_duration_us);
@@ -205,24 +198,30 @@ static int __cpuidle_cooling_register(struct device_node *np,
 
 	idle_cdev->ii_dev = ii_dev;
 
-	snprintf(dev_name, sizeof(dev_name), "thermal-idle-%d", id);
+	dev = get_cpu_device(cpumask_first(drv->cpumask));
 
-	cdev = thermal_of_cooling_device_register(np, dev_name, idle_cdev,
+	name = kasprintf(GFP_KERNEL, "idle-%s", dev_name(dev));
+	if (!name) {
+		ret = -ENOMEM;
+		goto out_unregister;
+	}
+
+	cdev = thermal_of_cooling_device_register(np, name, idle_cdev,
 						  &cpuidle_cooling_ops);
+	kfree(name);
+
 	if (IS_ERR(cdev)) {
 		ret = PTR_ERR(cdev);
 		goto out_unregister;
 	}
 
 	pr_debug("%s: Idle injection set with idle duration=%u, latency=%u\n",
-		 dev_name, idle_duration_us, latency_us);
+		 name, idle_duration_us, latency_us);
 
 	return 0;
 
 out_unregister:
 	idle_inject_unregister(ii_dev);
-out_id:
-	ida_simple_remove(&cpuidle_ida, id);
 out_kfree:
 	kfree(idle_cdev);
 out:
-- 
2.17.1

