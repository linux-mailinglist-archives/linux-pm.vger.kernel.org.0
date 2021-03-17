Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EA733F092
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 13:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhCQMjp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 08:39:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49800 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhCQMjM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 08:39:12 -0400
Date:   Wed, 17 Mar 2021 12:39:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615984750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EvKRxpylsbV6pW8Ij/vqbTCwIgPsYldPXdcGC0MGmcg=;
        b=plOrjRSlDD1JvmUGE09xi29UHoG4rreacQ7B+lYZLmSuVxZMcZetq7TAVgLSw17z2CM2F6
        DT4xBu2laHmrsZqqicmY90pPPEdA2lyJV2GAbgFsLZERzYyeYNKbl9NV61QD9sR32goITu
        5Xti22sTg5tKgUCL6gq1pysC0apDHvre6wLsTkLHZzjuAvGIeqGclPESKzm5bWtswQ+7Ec
        QLjREILHb3E0JYrMKtlma5gSEjDa0YbFKOuQr35/U9r1wPYSw1uCZmjLb0OoEqIQhejDTk
        t4Rmj6qVl2CWdsYmzIv/zl2ctR8VOKN2A+KiBhuqFcu2pAkWFWf6VLpH8aWtuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615984750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EvKRxpylsbV6pW8Ij/vqbTCwIgPsYldPXdcGC0MGmcg=;
        b=uHoV5HaB7VAdk7aVRnxgmYCfI5U3srmCct41ejX7fquIMS6fNy8EHWmz5azMQyuHNw64HZ
        15r5JlMhkXSDHcCQ==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/cpuidle_cooling: Use device
 name instead of auto-numbering
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20210314111333.16551-4-daniel.lezcano@linaro.org>
References: <20210314111333.16551-4-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <161598475024.398.17059616703344728737.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     6fd1b186d900acf4cef9d3c23ec2839022a46345
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//6fd1b186d900acf4cef9d3c23ec2839022a46345
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Sun, 14 Mar 2021 12:13:32 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 15 Mar 2021 04:47:04 +01:00

thermal/drivers/cpuidle_cooling: Use device name instead of auto-numbering

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
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://lore.kernel.org/r/20210314111333.16551-4-daniel.lezcano@linaro.org
---
 drivers/thermal/cpuidle_cooling.c | 33 ++++++++++++++----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
index 7ecab4b..f329761 100644
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
