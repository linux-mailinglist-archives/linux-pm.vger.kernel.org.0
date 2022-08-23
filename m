Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ED159E70F
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 18:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244646AbiHWQWb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 12:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244679AbiHWQWC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 12:22:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB78F275B80
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 05:42:42 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:42:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661258560;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SwlENea/t/mLJA2Zswq086k1bORiPm4WzOY7HLes/KM=;
        b=n/c6IqUbsthuQfpkXY2FNFdjieSVwypzpzEVQf3Hp8p6gFC0BQq6yU1jv9J+SAgYg+68K7
        6/RStWi3GsF8l7Qx5w86g+cz1qHw+pMJkeA+SLLcoS+rNFMQz9loVgoAooFPNIiqJPbfIq
        JGPYqqaM2z+i0/fyFLMmW315FXZl//+0oC+OxgC+EQp8Ys7r6G1V+oDepnp70p63JE+5oo
        YXV3YtxKifzpda5tUDIQQdubcNvfd1DsWnLn9QiHUV1La7t1BMGCnLJRToMdt14vbN/O1X
        6Ian3CppXnA1XRC2I/Ly89e3PgOrzptHKxysmtD49c9/q0Puf4P5v8qlSDa44Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661258560;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SwlENea/t/mLJA2Zswq086k1bORiPm4WzOY7HLes/KM=;
        b=cKcw3xjhIjzz2n7+Ukt6m3ZxRAn3RNDHp1Fjk8fo558X8QtosX5YP9XcD9C+pTO2sFZbk1
        XCqTv1NC3iQOLzDA==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Move the mutex inside the
 thermal_zone_device_update() function
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20220805153834.2510142-5-daniel.lezcano@linaro.org>
References: <20220805153834.2510142-5-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <166125855959.401.11652268728471574501.tip-bot2@tip-bot2>
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

Commit-ID:     a930da9bf583b2add01fb0e086913664dadaffd0
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//a930da9bf583b2add01fb0e086913664dadaffd0
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Fri, 05 Aug 2022 17:38:34 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 17 Aug 2022 14:09:39 +02:00

thermal/core: Move the mutex inside the thermal_zone_device_update() function

All the different calls inside the thermal_zone_device_update()
function take the mutex.

The previous changes move the mutex out of the different functions,
like the throttling ops. Now that the mutexes are all at the same
level in the call stack for the thermal_zone_device_update() function,
they can be moved inside this one.

That has the benefit of:

1. Simplify the code by not having a plethora of places where the lock is taken

2. Probably closes more race windows because releasing the lock from
one line to another can give the opportunity to the thermal zone to change
its state in the meantime. For example, the thermal zone can be
enabled right after checking it is disabled.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20220805153834.2510142-5-daniel.lezcano@linaro.org
---
 drivers/thermal/thermal_core.c    | 32 ++++---------
 drivers/thermal/thermal_core.h    |  2 +-
 drivers/thermal/thermal_helpers.c | 73 +++++++++++++++++-------------
 drivers/thermal/thermal_sysfs.c   |  6 +-
 4 files changed, 61 insertions(+), 52 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index fcac28d..4812170 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -297,24 +297,18 @@ static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 
 static void monitor_thermal_zone(struct thermal_zone_device *tz)
 {
-	mutex_lock(&tz->lock);
-
 	if (tz->mode != THERMAL_DEVICE_ENABLED)
 		thermal_zone_device_set_polling(tz, 0);
 	else if (tz->passive)
 		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
 	else if (tz->polling_delay_jiffies)
 		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
-
-	mutex_unlock(&tz->lock);
 }
 
 static void handle_non_critical_trips(struct thermal_zone_device *tz, int trip)
 {
-	mutex_lock(&tz->lock);
 	tz->governor ? tz->governor->throttle(tz, trip) :
 		       def_governor->throttle(tz, trip);
-	mutex_unlock(&tz->lock);
 }
 
 void thermal_zone_device_critical(struct thermal_zone_device *tz)
@@ -382,7 +376,7 @@ static void update_temperature(struct thermal_zone_device *tz)
 {
 	int temp, ret;
 
-	ret = thermal_zone_get_temp(tz, &temp);
+	ret = __thermal_zone_get_temp(tz, &temp);
 	if (ret) {
 		if (ret != -EAGAIN)
 			dev_warn(&tz->device,
@@ -391,10 +385,8 @@ static void update_temperature(struct thermal_zone_device *tz)
 		return;
 	}
 
-	mutex_lock(&tz->lock);
 	tz->last_temperature = tz->temperature;
 	tz->temperature = temp;
-	mutex_unlock(&tz->lock);
 
 	trace_thermal_temperature(tz);
 
@@ -457,15 +449,9 @@ EXPORT_SYMBOL_GPL(thermal_zone_device_disable);
 
 int thermal_zone_device_is_enabled(struct thermal_zone_device *tz)
 {
-	enum thermal_device_mode mode;
-
-	mutex_lock(&tz->lock);
-
-	mode = tz->mode;
+	lockdep_assert_held(&tz->lock);
 
-	mutex_unlock(&tz->lock);
-
-	return mode == THERMAL_DEVICE_ENABLED;
+	return tz->mode == THERMAL_DEVICE_ENABLED;
 }
 
 void thermal_zone_device_update(struct thermal_zone_device *tz,
@@ -473,9 +459,6 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 {
 	int count;
 
-	if (!thermal_zone_device_is_enabled(tz))
-		return;
-
 	if (atomic_read(&in_suspend))
 		return;
 
@@ -483,9 +466,14 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 		      "'get_temp' ops set\n", __func__))
 		return;
 
+	mutex_lock(&tz->lock);
+
+	if (!thermal_zone_device_is_enabled(tz))
+		goto out;
+
 	update_temperature(tz);
 
-	thermal_zone_set_trips(tz);
+	__thermal_zone_set_trips(tz);
 
 	tz->notify_event = event;
 
@@ -493,6 +481,8 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 		handle_thermal_trip(tz, count);
 
 	monitor_thermal_zone(tz);
+out:
+	mutex_unlock(&tz->lock);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
 
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 2241d2d..1571917 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -112,6 +112,8 @@ int thermal_build_list_of_policies(char *buf);
 
 /* Helpers */
 void thermal_zone_set_trips(struct thermal_zone_device *tz);
+void __thermal_zone_set_trips(struct thermal_zone_device *tz);
+int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 
 /* sysfs I/F */
 int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 690890f..c65cdce 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -64,27 +64,17 @@ get_thermal_instance(struct thermal_zone_device *tz,
 }
 EXPORT_SYMBOL(get_thermal_instance);
 
-/**
- * thermal_zone_get_temp() - returns the temperature of a thermal zone
- * @tz: a valid pointer to a struct thermal_zone_device
- * @temp: a valid pointer to where to store the resulting temperature.
- *
- * When a valid thermal zone reference is passed, it will fetch its
- * temperature and fill @temp.
- *
- * Return: On success returns 0, an error code otherwise
- */
-int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
+int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	int ret = -EINVAL;
 	int count;
 	int crit_temp = INT_MAX;
 	enum thermal_trip_type type;
 
-	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
-		goto exit;
+	lockdep_assert_held(&tz->lock);
 
-	mutex_lock(&tz->lock);
+	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
+		return -EINVAL;
 
 	ret = tz->ops->get_temp(tz, temp);
 
@@ -107,35 +97,42 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 			*temp = tz->emul_temperature;
 	}
 
-	mutex_unlock(&tz->lock);
-exit:
 	return ret;
 }
-EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
 
 /**
- * thermal_zone_set_trips - Computes the next trip points for the driver
- * @tz: a pointer to a thermal zone device structure
+ * thermal_zone_get_temp() - returns the temperature of a thermal zone
+ * @tz: a valid pointer to a struct thermal_zone_device
+ * @temp: a valid pointer to where to store the resulting temperature.
  *
- * The function computes the next temperature boundaries by browsing
- * the trip points. The result is the closer low and high trip points
- * to the current temperature. These values are passed to the backend
- * driver to let it set its own notification mechanism (usually an
- * interrupt).
+ * When a valid thermal zone reference is passed, it will fetch its
+ * temperature and fill @temp.
  *
- * It does not return a value
+ * Return: On success returns 0, an error code otherwise
  */
-void thermal_zone_set_trips(struct thermal_zone_device *tz)
+int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	int ret;
+
+	mutex_lock(&tz->lock);
+	ret = __thermal_zone_get_temp(tz, temp);
+	mutex_unlock(&tz->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
+
+void __thermal_zone_set_trips(struct thermal_zone_device *tz)
 {
 	int low = -INT_MAX;
 	int high = INT_MAX;
 	int trip_temp, hysteresis;
 	int i, ret;
 
-	mutex_lock(&tz->lock);
+	lockdep_assert_held(&tz->lock);
 
 	if (!tz->ops->set_trips || !tz->ops->get_trip_hyst)
-		goto exit;
+		return;
 
 	for (i = 0; i < tz->num_trips; i++) {
 		int trip_low;
@@ -154,7 +151,7 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
 
 	/* No need to change trip points */
 	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
-		goto exit;
+		return;
 
 	tz->prev_low_trip = low;
 	tz->prev_high_trip = high;
@@ -169,8 +166,24 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
 	ret = tz->ops->set_trips(tz, low, high);
 	if (ret)
 		dev_err(&tz->device, "Failed to set trips: %d\n", ret);
+}
 
-exit:
+/**
+ * thermal_zone_set_trips - Computes the next trip points for the driver
+ * @tz: a pointer to a thermal zone device structure
+ *
+ * The function computes the next temperature boundaries by browsing
+ * the trip points. The result is the closer low and high trip points
+ * to the current temperature. These values are passed to the backend
+ * driver to let it set its own notification mechanism (usually an
+ * interrupt).
+ *
+ * It does not return a value
+ */
+void thermal_zone_set_trips(struct thermal_zone_device *tz)
+{
+	mutex_lock(&tz->lock);
+	__thermal_zone_set_trips(tz);
 	mutex_unlock(&tz->lock);
 }
 
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 0f82010..78c5841 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -49,7 +49,11 @@ static ssize_t
 mode_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	int enabled = thermal_zone_device_is_enabled(tz);
+	int enabled;
+
+	mutex_lock(&tz->lock);
+	enabled = thermal_zone_device_is_enabled(tz);
+	mutex_unlock(&tz->lock);
 
 	return sprintf(buf, "%s\n", enabled ? "enabled" : "disabled");
 }
