Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB2A333BBB
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 12:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhCJLqm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Mar 2021 06:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhCJLqX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Mar 2021 06:46:23 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFFEC061760
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 03:46:22 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id u187so6896611wmg.4
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 03:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lski913ktSP8z+F8LEUqQKTYxY9cEhVj/daGsVMQLcc=;
        b=DJn2FKek4IRBjH/67DixsRaeG489z6IfxHRlZ/37cV7Aw5ODxrQZhVye3Of2PiWRZG
         WN2bSPgs/hKnC6/xBvb44kJgJLN7/5sQpwC+6ZdQLCp8rAMdhbJnK41DoXdXDDZ3K1AS
         8cA2OYNV9Iz/SW7EjMPjYF/wwnmcoqBDgHgiK8RnIxfy+4Qc9Mc6FZw90u2R5Q0FtHKC
         ju3odNJCgk/3W2fxN6dciBDOJFkxiVczUwEqfmfL7uH8lcp1y94hHDoGGuttHUYZYRtE
         y5bi+XFbk0sFK5RRmKhS7tZd8GyVjsuxxKgBz0900EP+AQLF+zfmTYfW5P9qO0BvyFM9
         iB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lski913ktSP8z+F8LEUqQKTYxY9cEhVj/daGsVMQLcc=;
        b=i/IDM45A9KCTMRUO2MsD9XjFqVTr8RucbeXPDnD4JIk2o7thlNnlndZG+AhSs6tEP9
         KxyZDWP3rIkvsBw0osu3ncR3Rulm+xvwtN92HV72MLcloA6aVeXTJazujFH9NBYO/Gsj
         WqsEDlS76unNJIOXb74vjtzKR1dT0WJCbIYcfu///OuaBceNrRzWI1jYyrC2BXHgfi/k
         n/PJFDOZlWbNrzs03PYwNMch+ouCjwsbxKLl4FYJLk/jz+WtSvP2GeED5z9IgeeaFu/P
         cXbFAeEHP1+BBmZHi3CjV9U4/xYjY1oE6r3qIGcBYG/saMvfEc5vEwRufXqXIiU06oWI
         GVKQ==
X-Gm-Message-State: AOAM533Q3juGBhi7AJ3ZSWt8oFPdMPoIO2x5gkkwEKalxcg4CoC6rgag
        S0+wh/YyYbDjmfBpYeiGNSzQwA==
X-Google-Smtp-Source: ABdhPJyOzgKdQ4Hvlw3FCV0HGHOP8E7m7AWzRtKuY77ah19CyGdOSkUjI/PdMFQauGYZjoz8RubfSg==
X-Received: by 2002:a05:600c:290b:: with SMTP id i11mr2995379wmd.129.1615376781251;
        Wed, 10 Mar 2021 03:46:21 -0800 (PST)
Received: from localhost.localdomain ([82.142.0.212])
        by smtp.gmail.com with ESMTPSA id h10sm30368165wrp.22.2021.03.10.03.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 03:46:20 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amitk@kernel.org, linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] thermal/drivers/cpufreq_cooling: Use device name instead of auto-numbering
Date:   Wed, 10 Mar 2021 12:45:58 +0100
Message-Id: <20210310114600.27178-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
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
patch removes the 'thermal prefix and changes the number by the device
name. So the naming above becomes:

 cpufreq-cpu0
 cpufreq-cpu4
 etc ...

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/cpufreq_cooling.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 10af3341e5ea..cf0332bbdcd3 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -13,6 +13,7 @@
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpu_cooling.h>
+#include <linux/device.h>
 #include <linux/energy_model.h>
 #include <linux/err.h>
 #include <linux/export.h>
@@ -50,8 +51,6 @@ struct time_in_idle {
 
 /**
  * struct cpufreq_cooling_device - data for cooling device with cpufreq
- * @id: unique integer value corresponding to each cpufreq_cooling_device
- *	registered.
  * @last_load: load measured by the latest call to cpufreq_get_requested_power()
  * @cpufreq_state: integer value representing the current state of cpufreq
  *	cooling	devices.
@@ -69,7 +68,6 @@ struct time_in_idle {
  * cpufreq_cooling_device.
  */
 struct cpufreq_cooling_device {
-	int id;
 	u32 last_load;
 	unsigned int cpufreq_state;
 	unsigned int max_level;
@@ -82,7 +80,6 @@ struct cpufreq_cooling_device {
 	struct freq_qos_request qos_req;
 };
 
-static DEFINE_IDA(cpufreq_ida);
 static DEFINE_MUTEX(cooling_list_lock);
 static LIST_HEAD(cpufreq_cdev_list);
 
@@ -528,11 +525,11 @@ __cpufreq_cooling_register(struct device_node *np,
 {
 	struct thermal_cooling_device *cdev;
 	struct cpufreq_cooling_device *cpufreq_cdev;
-	char dev_name[THERMAL_NAME_LENGTH];
 	unsigned int i;
 	struct device *dev;
 	int ret;
 	struct thermal_cooling_device_ops *cooling_ops;
+	char name[THERMAL_NAME_LENGTH];
 
 	dev = get_cpu_device(policy->cpu);
 	if (unlikely(!dev)) {
@@ -567,16 +564,6 @@ __cpufreq_cooling_register(struct device_node *np,
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
@@ -591,7 +578,7 @@ __cpufreq_cooling_register(struct device_node *np,
 		pr_err("%s: unsorted frequency tables are not supported\n",
 		       __func__);
 		cdev = ERR_PTR(-EINVAL);
-		goto remove_ida;
+		goto free_idle_time;
 	}
 
 	ret = freq_qos_add_request(&policy->constraints,
@@ -601,10 +588,12 @@ __cpufreq_cooling_register(struct device_node *np,
 		pr_err("%s: Failed to add freq constraint (%d)\n", __func__,
 		       ret);
 		cdev = ERR_PTR(ret);
-		goto remove_ida;
+		goto free_idle_time;
 	}
 
-	cdev = thermal_of_cooling_device_register(np, dev_name, cpufreq_cdev,
+	snprintf(name, sizeof(name), "cpufreq-%s", dev_name(dev));
+
+	cdev = thermal_of_cooling_device_register(np, name, cpufreq_cdev,
 						  cooling_ops);
 	if (IS_ERR(cdev))
 		goto remove_qos_req;
@@ -617,8 +606,6 @@ __cpufreq_cooling_register(struct device_node *np,
 
 remove_qos_req:
 	freq_qos_remove_request(&cpufreq_cdev->qos_req);
-remove_ida:
-	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
 free_idle_time:
 	free_idle_time(cpufreq_cdev);
 free_cdev:
@@ -712,7 +699,6 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 
 	thermal_cooling_device_unregister(cdev);
 	freq_qos_remove_request(&cpufreq_cdev->qos_req);
-	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
 	free_idle_time(cpufreq_cdev);
 	kfree(cpufreq_cdev);
 }
-- 
2.17.1

