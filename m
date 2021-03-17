Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DA433F093
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 13:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhCQMjo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 08:39:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49810 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhCQMjM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 08:39:12 -0400
Date:   Wed, 17 Mar 2021 12:39:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615984751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/nXVCK4lkMG32zSwmYag11FHgT5YSDn3tiO99pn4X8I=;
        b=bNFvLeR4VQqKFbkIRV7U1+uoimZoM8yrr8RJcr6HT8adIyjNhzfB8BN28ul/HTA7kLCFBW
        SVFv3psu/5NiHCk28h1rJkhleRJJ7L5MPJJz/oE+gdYCv/7VF3YkTzoVPNlVb4WegruzIg
        k8Q9tJ+13Bvh9kIDd18fqhXValccW9H3OjvXVv/jdFVYxieJDrih7KOMXlZGC2mrwzH+Iq
        i7Qa9xTb+FvulBIDebXsyu3WbQQKGb1GZxVJbLrcU0nKIhCS939DbP4pLKZM1eP/9vr/Tc
        7w62UH33zmA0CRJEoxsB/bHst4Lp+4lr7WxwHioUi8+almJO7YhqENpEhXgTXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615984751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/nXVCK4lkMG32zSwmYag11FHgT5YSDn3tiO99pn4X8I=;
        b=e0O/CAI/8exu8ipUmj6gGjscrMWn37nzyjq6xwI0QWEQbIB7j4hywjGqbBioGXOlgsx5uR
        seWc7TEzweJiBuAQ==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/devfreq_cooling: Use device
 name instead of auto-numbering
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20210314111333.16551-3-daniel.lezcano@linaro.org>
References: <20210314111333.16551-3-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <161598475061.398.6383831511357038724.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     f8d354e821b268c23a6cd548b7154e55c3954496
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//f8d354e821b268c23a6cd548b7154e55c3954496
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Sun, 14 Mar 2021 12:13:31 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 15 Mar 2021 04:47:04 +01:00

thermal/drivers/devfreq_cooling: Use device name instead of auto-numbering

Currently the naming of a cooling device is just a cooling technique
followed by a number. When there are multiple cooling devices using
the same technique, it is impossible to clearly identify the related
device as this one is just a number.

For instance:

 thermal-devfreq-0
 thermal-devfreq-1
 etc ...

The 'thermal' prefix is redundant with the subsystem namespace. This
patch removes the 'thermal' prefix and changes the number by the device
name. So the naming above becomes:

 devfreq-5000000.gpu
 devfreq-1d84000.ufshc
 etc ...

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lore.kernel.org/r/20210314111333.16551-3-daniel.lezcano@linaro.org
---
 drivers/thermal/devfreq_cooling.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index fed3121..fb250ac 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -14,7 +14,6 @@
 #include <linux/devfreq_cooling.h>
 #include <linux/energy_model.h>
 #include <linux/export.h>
-#include <linux/idr.h>
 #include <linux/slab.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_qos.h>
@@ -25,11 +24,8 @@
 #define HZ_PER_KHZ		1000
 #define SCALE_ERROR_MITIGATION	100
 
-static DEFINE_IDA(devfreq_ida);
-
 /**
  * struct devfreq_cooling_device - Devfreq cooling device
- * @id:		unique integer value corresponding to each
  *		devfreq_cooling_device registered.
  * @cdev:	Pointer to associated thermal cooling device.
  * @devfreq:	Pointer to associated devfreq device.
@@ -51,7 +47,6 @@ static DEFINE_IDA(devfreq_ida);
  * @em_pd:		Energy Model for the associated Devfreq device
  */
 struct devfreq_cooling_device {
-	int id;
 	struct thermal_cooling_device *cdev;
 	struct devfreq *devfreq;
 	unsigned long cooling_state;
@@ -363,7 +358,7 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 	struct thermal_cooling_device *cdev;
 	struct device *dev = df->dev.parent;
 	struct devfreq_cooling_device *dfc;
-	char dev_name[THERMAL_NAME_LENGTH];
+	char *name;
 	int err, num_opps;
 
 	dfc = kzalloc(sizeof(*dfc), GFP_KERNEL);
@@ -407,30 +402,27 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 	if (err < 0)
 		goto free_table;
 
-	err = ida_simple_get(&devfreq_ida, 0, 0, GFP_KERNEL);
-	if (err < 0)
+	cdev = ERR_PTR(-ENOMEM);
+	name = kasprintf(GFP_KERNEL, "devfreq-%s", dev_name(dev));
+	if (!name)
 		goto remove_qos_req;
 
-	dfc->id = err;
-
-	snprintf(dev_name, sizeof(dev_name), "thermal-devfreq-%d", dfc->id);
-
-	cdev = thermal_of_cooling_device_register(np, dev_name, dfc,
+	cdev = thermal_of_cooling_device_register(np, name, dfc,
 						  &devfreq_cooling_ops);
+	kfree(name);
+
 	if (IS_ERR(cdev)) {
 		err = PTR_ERR(cdev);
 		dev_err(dev,
 			"Failed to register devfreq cooling device (%d)\n",
 			err);
-		goto release_ida;
+		goto remove_qos_req;
 	}
 
 	dfc->cdev = cdev;
 
 	return cdev;
 
-release_ida:
-	ida_simple_remove(&devfreq_ida, dfc->id);
 remove_qos_req:
 	dev_pm_qos_remove_request(&dfc->req_max_freq);
 free_table:
@@ -527,7 +519,6 @@ void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
 	dev = dfc->devfreq->dev.parent;
 
 	thermal_cooling_device_unregister(dfc->cdev);
-	ida_simple_remove(&devfreq_ida, dfc->id);
 	dev_pm_qos_remove_request(&dfc->req_max_freq);
 
 	em_dev_unregister_perf_domain(dev);
