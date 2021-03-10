Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93094333BBA
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 12:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhCJLqn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Mar 2021 06:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhCJLqZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Mar 2021 06:46:25 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DCAC06174A
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 03:46:25 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j2so22951611wrx.9
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 03:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LvlruMaCLBIyF4bqWN8JBBR1UbyF6IvONx4LBcx3yHE=;
        b=pNawfMqaAG/zuHUmVubbWIU6RERPhmUscbJ7tzU6EaRl3Pm3U4PK2ZY/XwvPdAckBb
         8dywq6SltsGp7ya34cWvnM1wG9Th5sLJWMDrXia1Z8tgAo+iT7w3KDLwkWVu9e46JQUP
         i7VKQWAn3pOw/lTdUqNCwwcDUBM0fTbMSt2rDYwwahGBE8nIbh/dwiR7qLox8frshMnQ
         TpMVNc+79/Qy5Bjh/k71lvk/dMv9+s2GU20gDKueU+ru8VyKZmPbg9zTOIRoenJ4HO0f
         dXcqPfRU4RRmq7z1HUv3WYGYltjc5f1f6zFV8j5P5lEERSslB/ZtV8e+Qd1JnoXcNOTS
         hj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LvlruMaCLBIyF4bqWN8JBBR1UbyF6IvONx4LBcx3yHE=;
        b=sn1E5PwTEEyLwjmY8twNmg3rQej0WB1pXNlCa2muWQki5+msTKW0VdAKHFLL+fg0dk
         /iz+k4BxQGTIf+Mv63LfHWVoYcq1JyDGdBTcki3mmbPE3wSfyczkhIxs24Cp5vWq9A29
         5JdeoHJN85S0KZ27IYX+BO1r0YlgB4aTnI+jucDDx3lrsRco0OMvkjxIO1yG6YcMp7pk
         4AkMYxYN9h0BBl6D5VIUheFPi1QT/uUDQwMWlsX47z4CKx3S1ioKSkcJn7jVNNjHqBRF
         zj/sFAGpfTjug9248UP2Ta+jap8Q7ZX7tZPWyCu3RAWqKh4i4YcVfRvBoWJQoy61ucKy
         Zh4w==
X-Gm-Message-State: AOAM532aSBhkR7O+8t2g6HmP8x3oLZcx+BZyywOQ9rFuhSNUYT2L680/
        IAk/xrqKhNixBwg7FHN+uEBuhA==
X-Google-Smtp-Source: ABdhPJxVk/OwZANT/24F9BZUPSimf4ICwwnh+EBRhteoqtZ7OaMR4FqRgNXRlhokWxVAIJAncZHIeA==
X-Received: by 2002:a05:6000:c7:: with SMTP id q7mr3148842wrx.356.1615376783902;
        Wed, 10 Mar 2021 03:46:23 -0800 (PST)
Received: from localhost.localdomain ([82.142.0.212])
        by smtp.gmail.com with ESMTPSA id h10sm30368165wrp.22.2021.03.10.03.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 03:46:23 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amitk@kernel.org, linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] thermal/drivers/cpuidle_cooling: Use device name instead of auto-numbering
Date:   Wed, 10 Mar 2021 12:46:00 +0100
Message-Id: <20210310114600.27178-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210310114600.27178-1-daniel.lezcano@linaro.org>
References: <20210310114600.27178-1-daniel.lezcano@linaro.org>
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
---
 drivers/thermal/cpuidle_cooling.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
index 7ecab4b16b29..8bc0a9b46358 100644
--- a/drivers/thermal/cpuidle_cooling.c
+++ b/drivers/thermal/cpuidle_cooling.c
@@ -9,6 +9,7 @@
 
 #include <linux/cpu_cooling.h>
 #include <linux/cpuidle.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/idle_inject.h>
 #include <linux/idr.h>
@@ -26,8 +27,6 @@ struct cpuidle_cooling_device {
 	unsigned long state;
 };
 
-static DEFINE_IDA(cpuidle_ida);
-
 /**
  * cpuidle_cooling_runtime - Running time computation
  * @idle_duration_us: CPU idle time to inject in microseconds
@@ -174,10 +173,11 @@ static int __cpuidle_cooling_register(struct device_node *np,
 	struct idle_inject_device *ii_dev;
 	struct cpuidle_cooling_device *idle_cdev;
 	struct thermal_cooling_device *cdev;
+	struct device *dev;
 	unsigned int idle_duration_us = TICK_USEC;
 	unsigned int latency_us = UINT_MAX;
-	char dev_name[THERMAL_NAME_LENGTH];
-	int id, ret;
+	char name[THERMAL_NAME_LENGTH];
+	int ret;
 
 	idle_cdev = kzalloc(sizeof(*idle_cdev), GFP_KERNEL);
 	if (!idle_cdev) {
@@ -185,16 +185,10 @@ static int __cpuidle_cooling_register(struct device_node *np,
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
@@ -205,9 +199,11 @@ static int __cpuidle_cooling_register(struct device_node *np,
 
 	idle_cdev->ii_dev = ii_dev;
 
-	snprintf(dev_name, sizeof(dev_name), "thermal-idle-%d", id);
+	dev = get_cpu_device(cpumask_first(drv->cpumask));
+
+	snprintf(name, sizeof(name), "idle-%s", dev_name(dev));
 
-	cdev = thermal_of_cooling_device_register(np, dev_name, idle_cdev,
+	cdev = thermal_of_cooling_device_register(np, name, idle_cdev,
 						  &cpuidle_cooling_ops);
 	if (IS_ERR(cdev)) {
 		ret = PTR_ERR(cdev);
@@ -215,14 +211,12 @@ static int __cpuidle_cooling_register(struct device_node *np,
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

