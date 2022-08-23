Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D536259E6F0
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 18:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244211AbiHWQWF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 12:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239399AbiHWQVe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 12:21:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D45333D7A
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 05:42:43 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:42:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661258561;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pIX8FtSeuGoqLSDrhmYYZlFHssUz7RqSKU3G1q2u1GY=;
        b=GMT1A1jMrdIjl94ipWQ8oQw0KmIkvPOdhRb2rYdJ7lulnwgJTI2TdQ7e34apgNAB0oew94
        s+cjWMyAuMa29LPfozyHZkdLjG397E3+dzX19jq5UqS1m/GPQTJActT/+HkEGY6G249JAP
        mt8dbR4zf74yhCuz8PYPPbk0Txau7Dcexiuz5Kz//GqIXgzVUiAZ4eUOua/zg+T8DSqBIS
        hU22LksyhPz2tVXhP2gkDglOo/4Gqyb2r0VrWPPaGp4gRxf+8VCJ1/7mtYnFcLeQoxJOby
        fFp05EktgeoWVCiBOrrgunEPn5I13lfDTbC/FSAeocDG2mPXafLmqz/z38EWZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661258561;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pIX8FtSeuGoqLSDrhmYYZlFHssUz7RqSKU3G1q2u1GY=;
        b=er7PsOJ0c6qSJSkNB4Lu6TSS5fNFNrf7JtoOe4XP4+0Bp9YpLP4E0s53YjnkayfVt0GbfR
        ouKgvAaXLPI0joBg==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Move the thermal zone lock out
 of the governors
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20220805153834.2510142-4-daniel.lezcano@linaro.org>
References: <20220805153834.2510142-4-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <166125856064.401.5950148854184715977.tip-bot2@tip-bot2>
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

Commit-ID:     670a5e356cb6dfc61b87b599eba483af6a3a99ad
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//670a5e356cb6dfc61b87b599eba483af6a3a99ad
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Fri, 05 Aug 2022 17:38:33 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 17 Aug 2022 14:09:39 +02:00

thermal/core: Move the thermal zone lock out of the governors

All the governors throttling ops are taking/releasing the lock at the
beginning and the end of the function.

We can move the mutex to the throttling call site instead.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20220805153834.2510142-4-daniel.lezcano@linaro.org
---
 drivers/thermal/gov_bang_bang.c       |  4 +---
 drivers/thermal/gov_fair_share.c      |  4 +---
 drivers/thermal/gov_power_allocator.c | 16 ++++++----------
 drivers/thermal/gov_step_wise.c       |  4 +---
 drivers/thermal/thermal_core.c        |  2 ++
 5 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index f0bff2e..a08bbe3 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -96,15 +96,13 @@ static int bang_bang_control(struct thermal_zone_device *tz, int trip)
 {
 	struct thermal_instance *instance;
 
-	mutex_lock(&tz->lock);
+	lockdep_assert_held(&tz->lock);
 
 	thermal_zone_trip_update(tz, trip);
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
 		thermal_cdev_update(instance->cdev);
 
-	mutex_unlock(&tz->lock);
-
 	return 0;
 }
 
diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
index 5d5ddd6..a4ee466 100644
--- a/drivers/thermal/gov_fair_share.c
+++ b/drivers/thermal/gov_fair_share.c
@@ -82,7 +82,7 @@ static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
 	int total_instance = 0;
 	int cur_trip_level = get_trip_level(tz);
 
-	mutex_lock(&tz->lock);
+	lockdep_assert_held(&tz->lock);
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		if (instance->trip != trip)
@@ -112,8 +112,6 @@ static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
 		mutex_unlock(&cdev->lock);
 	}
 
-	mutex_unlock(&tz->lock);
-
 	return 0;
 }
 
diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index d3aca23..2d1aeab 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -697,19 +697,19 @@ static void power_allocator_unbind(struct thermal_zone_device *tz)
 
 static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 {
-	int ret = 0;
+	int ret;
 	int switch_on_temp, control_temp;
 	struct power_allocator_params *params = tz->governor_data;
 	bool update;
 
-	mutex_lock(&tz->lock);
+	lockdep_assert_held(&tz->lock);
 
 	/*
 	 * We get called for every trip point but we only need to do
 	 * our calculations once
 	 */
 	if (trip != params->trip_max_desired_temperature)
-		goto out;
+		return 0;
 
 	ret = tz->ops->get_trip_temp(tz, params->trip_switch_on,
 				     &switch_on_temp);
@@ -718,7 +718,7 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 		tz->passive = 0;
 		reset_pid_controller(params);
 		allow_maximum_power(tz, update);
-		goto out;
+		return 0;
 	}
 
 	tz->passive = 1;
@@ -729,14 +729,10 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 		dev_warn(&tz->device,
 			 "Failed to get the maximum desired temperature: %d\n",
 			 ret);
-		goto out;
+		return ret;
 	}
 
-	ret = allocate_power(tz, control_temp);
-
-	mutex_unlock(&tz->lock);
-out:
-	return ret;
+	return allocate_power(tz, control_temp);
 }
 
 static struct thermal_governor thermal_gov_power_allocator = {
diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index 597a0eb..cdd3354 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -160,15 +160,13 @@ static int step_wise_throttle(struct thermal_zone_device *tz, int trip)
 {
 	struct thermal_instance *instance;
 
-	mutex_lock(&tz->lock);
+	lockdep_assert_held(&tz->lock);
 
 	thermal_zone_trip_update(tz, trip);
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
 		thermal_cdev_update(instance->cdev);
 
-	mutex_unlock(&tz->lock);
-
 	return 0;
 }
 
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 5408e92..fcac28d 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -311,8 +311,10 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
 
 static void handle_non_critical_trips(struct thermal_zone_device *tz, int trip)
 {
+	mutex_lock(&tz->lock);
 	tz->governor ? tz->governor->throttle(tz, trip) :
 		       def_governor->throttle(tz, trip);
+	mutex_unlock(&tz->lock);
 }
 
 void thermal_zone_device_critical(struct thermal_zone_device *tz)
