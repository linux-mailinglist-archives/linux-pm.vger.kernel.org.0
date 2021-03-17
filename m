Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEA633F094
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 13:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhCQMjo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 08:39:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49820 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhCQMjM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 08:39:12 -0400
Date:   Wed, 17 Mar 2021 12:39:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615984751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7oedCVEHaNVDFWFftVkOqJCJZ5Ekw7XUBUBHUCbacv8=;
        b=KXkkkREoAMeAlChbfq7SVGKs2xxnkXv8Um3O84SsMEFtUowoBuZ3CZpToHvWT1l4W8HLGb
        t2BZ93VadasF/QwbL5ZNtScaAxp5vti0ZQyWUmx8ykWx7npkKb7hFY9fOkXATfoOVH9DL5
        4AMi2sJio4BirA/AW/MtAJ5uDTmzBNnD+xUy+Er6958hZ57pmIzv+1f9NGz+TKe+B+TQMt
        wFpn1SM35cAOHEx0gL2M20xXVB79B3YmW8SZ4ckyATsk0mzGkK8UEKXd46rgGq0rVIF0BC
        Gsv/wo3xArYngWGY0SpLk9P5ukLV71uZp7fXumIeqH+1ITjv66iGMX78KVF3RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615984751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7oedCVEHaNVDFWFftVkOqJCJZ5Ekw7XUBUBHUCbacv8=;
        b=XKp0VWwedUClQM6zZYVIWbSWjjnGa3ZjhlZG7jrwWpiYYtqLBlasbgUQlA/MTSaOadkJJH
        lAgIfWRzVMj1ToBA==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/cpufreq_cooling: Use device
 name instead of auto-numbering
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20210314111333.16551-2-daniel.lezcano@linaro.org>
References: <20210314111333.16551-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <161598475101.398.13649064038057189472.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     ef37d1f9acb57b7a5993e93ae582ba5f4108919e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//ef37d1f9acb57b7a5993e93ae582ba5f4108919e
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Sun, 14 Mar 2021 12:13:30 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 15 Mar 2021 04:46:54 +01:00

thermal/drivers/cpufreq_cooling: Use device name instead of auto-numbering

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
Link: https://lore.kernel.org/r/20210314111333.16551-2-daniel.lezcano@linaro.org
---
 drivers/thermal/cpufreq_cooling.c | 34 ++++++++++--------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 10af334..3f5f1dc 100644
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
