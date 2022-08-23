Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7235959E6F2
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 18:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244242AbiHWQWG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 12:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244282AbiHWQVr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 12:21:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C23D16D2C0
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 05:42:44 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:42:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661258562;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uic2sp9J+qtXoN1jxxFMCQQjH50umFN8mhMohUXlXuk=;
        b=swC91L3ZWY9zjc//u6DUcyUNzVZiDKDRIzmVhIaY8aJ0hdl9xkvFR2sQDecW7+r80RCqRh
        u/7LApKtJLJlMCnx3MoGHZ0PxHN4tOisz0LDl0DQpeni23i+SxNye8coYM37nUA/BIUQ2c
        NOguqIyPhxjh8UJs6LJsuTF2MFnG4KTC7hTea8m7ra6CU3f3d94BLoyx9NRig5Hc5Jqr59
        +Dg2tYAQVy/ZxqjQ6Xu2XzyvLzLPSHPQLGhto/nVpZGrVvI9/s95CwAa04VowmSVWMqZuR
        zx1akQG050dnzuwZGajXXV0Dpbb1kpSTDthWivDSenW+hIDzq/xtl1fJTB2M8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661258562;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uic2sp9J+qtXoN1jxxFMCQQjH50umFN8mhMohUXlXuk=;
        b=GoreZYC+jbRgfQDPBinIidSNuhrRMH7h2fAZckikMTsCrtjaR6sJtQt60iUItCgojTMWN9
        OBGZVdOeO9oQs2BQ==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/governors: Group the thermal zone
 lock inside the throttle function
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20220805153834.2510142-3-daniel.lezcano@linaro.org>
References: <20220805153834.2510142-3-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <166125856173.401.8816264388586306209.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     63561fe36b094729d3d4d274bafaa030b39e89f6
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//63561fe36b094729d3d4d274bafaa030b39e89f6
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Fri, 05 Aug 2022 17:38:32 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 17 Aug 2022 14:09:39 +02:00

thermal/governors: Group the thermal zone lock inside the throttle function

The thermal zone lock is taken in the different places in the
throttling path.

At the first glance it does not hurt to move them at the beginning and
the end of the 'throttle' function. That will allow a consolidation of
the lock in the next following changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20220805153834.2510142-3-daniel.lezcano@linaro.org
---
 drivers/thermal/gov_bang_bang.c       |  8 +-----
 drivers/thermal/gov_fair_share.c      |  1 +-
 drivers/thermal/gov_power_allocator.c | 34 +++++++++++---------------
 drivers/thermal/gov_step_wise.c       |  8 +-----
 4 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index 991a1c5..f0bff2e 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -31,8 +31,6 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 				trip, trip_temp, tz->temperature,
 				trip_hyst);
 
-	mutex_lock(&tz->lock);
-
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		if (instance->trip != trip)
 			continue;
@@ -65,8 +63,6 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 		instance->cdev->updated = false; /* cdev needs update */
 		mutex_unlock(&instance->cdev->lock);
 	}
-
-	mutex_unlock(&tz->lock);
 }
 
 /**
@@ -100,10 +96,10 @@ static int bang_bang_control(struct thermal_zone_device *tz, int trip)
 {
 	struct thermal_instance *instance;
 
-	thermal_zone_trip_update(tz, trip);
-
 	mutex_lock(&tz->lock);
 
+	thermal_zone_trip_update(tz, trip);
+
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
 		thermal_cdev_update(instance->cdev);
 
diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
index 6a2abcf..5d5ddd6 100644
--- a/drivers/thermal/gov_fair_share.c
+++ b/drivers/thermal/gov_fair_share.c
@@ -113,6 +113,7 @@ static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
 	}
 
 	mutex_unlock(&tz->lock);
+
 	return 0;
 }
 
diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 1d50524..d3aca23 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -392,8 +392,6 @@ static int allocate_power(struct thermal_zone_device *tz,
 	int i, num_actors, total_weight, ret = 0;
 	int trip_max_desired_temperature = params->trip_max_desired_temperature;
 
-	mutex_lock(&tz->lock);
-
 	num_actors = 0;
 	total_weight = 0;
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
@@ -404,10 +402,8 @@ static int allocate_power(struct thermal_zone_device *tz,
 		}
 	}
 
-	if (!num_actors) {
-		ret = -ENODEV;
-		goto unlock;
-	}
+	if (!num_actors)
+		return -ENODEV;
 
 	/*
 	 * We need to allocate five arrays of the same size:
@@ -421,10 +417,8 @@ static int allocate_power(struct thermal_zone_device *tz,
 	BUILD_BUG_ON(sizeof(*req_power) != sizeof(*extra_actor_power));
 	BUILD_BUG_ON(sizeof(*req_power) != sizeof(*weighted_req_power));
 	req_power = kcalloc(num_actors * 5, sizeof(*req_power), GFP_KERNEL);
-	if (!req_power) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
+	if (!req_power)
+		return -ENOMEM;
 
 	max_power = &req_power[num_actors];
 	granted_power = &req_power[2 * num_actors];
@@ -496,8 +490,6 @@ static int allocate_power(struct thermal_zone_device *tz,
 				      control_temp - tz->temperature);
 
 	kfree(req_power);
-unlock:
-	mutex_unlock(&tz->lock);
 
 	return ret;
 }
@@ -576,7 +568,6 @@ static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
 	struct power_allocator_params *params = tz->governor_data;
 	u32 req_power;
 
-	mutex_lock(&tz->lock);
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		struct thermal_cooling_device *cdev = instance->cdev;
 
@@ -598,7 +589,6 @@ static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
 
 		mutex_unlock(&instance->cdev->lock);
 	}
-	mutex_unlock(&tz->lock);
 }
 
 /**
@@ -707,17 +697,19 @@ static void power_allocator_unbind(struct thermal_zone_device *tz)
 
 static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 {
-	int ret;
+	int ret = 0;
 	int switch_on_temp, control_temp;
 	struct power_allocator_params *params = tz->governor_data;
 	bool update;
 
+	mutex_lock(&tz->lock);
+
 	/*
 	 * We get called for every trip point but we only need to do
 	 * our calculations once
 	 */
 	if (trip != params->trip_max_desired_temperature)
-		return 0;
+		goto out;
 
 	ret = tz->ops->get_trip_temp(tz, params->trip_switch_on,
 				     &switch_on_temp);
@@ -726,7 +718,7 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 		tz->passive = 0;
 		reset_pid_controller(params);
 		allow_maximum_power(tz, update);
-		return 0;
+		goto out;
 	}
 
 	tz->passive = 1;
@@ -737,10 +729,14 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 		dev_warn(&tz->device,
 			 "Failed to get the maximum desired temperature: %d\n",
 			 ret);
-		return ret;
+		goto out;
 	}
 
-	return allocate_power(tz, control_temp);
+	ret = allocate_power(tz, control_temp);
+
+	mutex_unlock(&tz->lock);
+out:
+	return ret;
 }
 
 static struct thermal_governor thermal_gov_power_allocator = {
diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index 9729b46..597a0eb 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -117,8 +117,6 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 	dev_dbg(&tz->device, "Trip%d[type=%d,temp=%d]:trend=%d,throttle=%d\n",
 				trip, trip_type, trip_temp, trend, throttle);
 
-	mutex_lock(&tz->lock);
-
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		if (instance->trip != trip)
 			continue;
@@ -145,8 +143,6 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 		instance->cdev->updated = false; /* cdev needs update */
 		mutex_unlock(&instance->cdev->lock);
 	}
-
-	mutex_unlock(&tz->lock);
 }
 
 /**
@@ -164,10 +160,10 @@ static int step_wise_throttle(struct thermal_zone_device *tz, int trip)
 {
 	struct thermal_instance *instance;
 
-	thermal_zone_trip_update(tz, trip);
-
 	mutex_lock(&tz->lock);
 
+	thermal_zone_trip_update(tz, trip);
+
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
 		thermal_cdev_update(instance->cdev);
 
