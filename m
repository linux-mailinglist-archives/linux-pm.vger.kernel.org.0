Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAB1648576
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiLIP1z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiLIP0t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B868DBD3
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:44 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599600;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=flN3puxFpj+neSb19yLBPa0dEzS6JbTQyxyn+HHGJWo=;
        b=F+XtP0cf4o0dGI0oYZMO5OB+34expHZyrwg/GUYW672Mw4K9i9i1Ckdul/511bi9ItotLB
        OaG/F+bybCZOqSTiquzqHBx4sPozVShwmGGgrEVhKyvx5VMPdrCrTSVxyMkxPEp00m1xBo
        g1/s/YVvgiP2d4BIM3zpEw8/J2ddn+HR+APw6hGInkXxNnRQKMYRJq8O01dImkbM726CYM
        S6+RKlWV3qvp3w7P+bGSfQTH/EwYAK6gFYyo0TxQT37EvhLCmqIF1uJOiWsLBLKBnY4JVo
        YB0t1r/wo5s7vcRqt5HRh0kNzR+ipTJWnLuB1bz12yHrz3nwSirjGt4xYO4rTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599600;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=flN3puxFpj+neSb19yLBPa0dEzS6JbTQyxyn+HHGJWo=;
        b=qof0Nz/ehOdENv0cm17/6ohlfYcm7l5mrATvqV/weUGG/wIuXZtzcdsfX0P4Jk2ktrXeKW
        xl9msH9WnTQjTQBQ==
From:   "thermal-bot for Viresh Kumar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: Validate new state in cur_state_store()
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
MIME-Version: 1.0
Message-ID: <167059959990.4906.11138425865236211429.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     c408b3d1d9bbc7de5fb0304fea424ef2539da616
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//c408b3d1d9bbc7de5fb0304fea424ef2539da616
Author:        Viresh Kumar <viresh.kumar@linaro.org>
AuthorDate:    Mon, 17 Oct 2022 15:33:01 +05:30
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Tue, 25 Oct 2022 18:58:11 +02:00

thermal: Validate new state in cur_state_store()

In cur_state_store(), the new state of the cooling device is received
from user-space and is not validated by the thermal core but the same is
left for the individual drivers to take care of. Apart from duplicating
the code it leaves possibility for introducing bugs where a driver may
not do it right.

Lets make the thermal core check the new state itself and store the max
value in the cooling device structure.

Link: https://lore.kernel.org/all/Y0ltRJRjO7AkawvE@kili/
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_fair_share.c |  6 +-----
 drivers/thermal/thermal_core.c   | 15 +++++++--------
 drivers/thermal/thermal_sysfs.c  | 11 +++++------
 include/linux/thermal.h          |  1 +
 4 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
index a4ee466..1cfeac1 100644
--- a/drivers/thermal/gov_fair_share.c
+++ b/drivers/thermal/gov_fair_share.c
@@ -49,11 +49,7 @@ static int get_trip_level(struct thermal_zone_device *tz)
 static long get_target_state(struct thermal_zone_device *tz,
 		struct thermal_cooling_device *cdev, int percentage, int level)
 {
-	unsigned long max_state;
-
-	cdev->ops->get_max_state(cdev, &max_state);
-
-	return (long)(percentage * level * max_state) / (100 * tz->num_trips);
+	return (long)(percentage * level * cdev->max_state) / (100 * tz->num_trips);
 }
 
 /**
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 117eeaf..08de593 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -603,8 +603,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	struct thermal_instance *pos;
 	struct thermal_zone_device *pos1;
 	struct thermal_cooling_device *pos2;
-	unsigned long max_state;
-	int result, ret;
+	int result;
 
 	if (trip >= tz->num_trips || trip < 0)
 		return -EINVAL;
@@ -621,15 +620,11 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	if (tz != pos1 || cdev != pos2)
 		return -EINVAL;
 
-	ret = cdev->ops->get_max_state(cdev, &max_state);
-	if (ret)
-		return ret;
-
 	/* lower default 0, upper default max_state */
 	lower = lower == THERMAL_NO_LIMIT ? 0 : lower;
-	upper = upper == THERMAL_NO_LIMIT ? max_state : upper;
+	upper = upper == THERMAL_NO_LIMIT ? cdev->max_state : upper;
 
-	if (lower > upper || upper > max_state)
+	if (lower > upper || upper > cdev->max_state)
 		return -EINVAL;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
@@ -900,6 +895,10 @@ __thermal_cooling_device_register(struct device_node *np,
 	cdev->updated = false;
 	cdev->device.class = &thermal_class;
 	cdev->devdata = devdata;
+
+	if (cdev->ops->get_max_state(cdev, &cdev->max_state))
+		goto out_kfree_type;
+
 	thermal_cooling_device_setup_sysfs(cdev);
 	ret = device_register(&cdev->device);
 	if (ret)
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index ec495c7..bd75961 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -589,13 +589,8 @@ static ssize_t max_state_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
 	struct thermal_cooling_device *cdev = to_cooling_device(dev);
-	unsigned long state;
-	int ret;
 
-	ret = cdev->ops->get_max_state(cdev, &state);
-	if (ret)
-		return ret;
-	return sprintf(buf, "%ld\n", state);
+	return sprintf(buf, "%ld\n", cdev->max_state);
 }
 
 static ssize_t cur_state_show(struct device *dev, struct device_attribute *attr,
@@ -625,6 +620,10 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
 	if ((long)state < 0)
 		return -EINVAL;
 
+	/* Requested state should be less than max_state + 1 */
+	if (state > cdev->max_state)
+		return -EINVAL;
+
 	mutex_lock(&cdev->lock);
 
 	result = cdev->ops->set_cur_state(cdev, state);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 9ecc128..5e09360 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -100,6 +100,7 @@ struct thermal_cooling_device_ops {
 struct thermal_cooling_device {
 	int id;
 	char *type;
+	unsigned long max_state;
 	struct device device;
 	struct device_node *np;
 	void *devdata;
