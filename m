Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00DA42C219B
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 10:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbgKXJgr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 04:36:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42012 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731419AbgKXJgp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 04:36:45 -0500
Date:   Tue, 24 Nov 2020 09:36:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606210604;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tMm0mPKjlAtftC+p9/E/fI1CxV3Gyh/83fub4zeLyYg=;
        b=QVyQy7WcFxX0wprn18AknqKZSr+miAUNhoOjk46WTIK91dgLkXEnkrL4M+dD6qaHiBzFQ3
        ZNUfl75MMDuNAr6FUwDJPX8HwAVU53mjU6Al76Gq5LsoWIoUO1OPv8nwiDAf+/cw49RLa+
        iYWuxzhKqYnE2qodztCcyeys9/6NlCuAb68L7NPZ98k0vXkom4VXefId96aTmJpYspREKa
        l0xbcPOWN2jCI3qEPHy0f7PJkG8HA+S08Uzxvk3N5xkGKVZ50Guaess9N0oGXn5k/q3OXQ
        ju7YCG6CMN5R7GqtAMGTT2/IJnact+NT51MKNEcD/QqznyhIx1WdPnuesSwDIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606210604;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tMm0mPKjlAtftC+p9/E/fI1CxV3Gyh/83fub4zeLyYg=;
        b=1Qd9yiiY5+Ox5uXIsxza62r4sUGk2v7hMQfS0kOwUjAeAP3YuZe/kvCanw0t22/ty7BJK3
        IzvSc5SgZcw+qHDw==
From:   "thermal-bot for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: core: Move power_actor_set_power into IPA
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201015112441.4056-5-lukasz.luba@arm.com>
References: <20201015112441.4056-5-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <160621060347.11115.7900113051506397394.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     345a8af7ea63ac75a9000159d6298769d3d50f91
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//345a8af7ea63ac75a9000159d6298769d3d50f91
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Thu, 15 Oct 2020 12:24:41 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 27 Oct 2020 09:44:32 +01:00

thermal: core: Move power_actor_set_power into IPA

Since the power actor section has one function power_actor_set_power()
move it into Intelligent Power Allocation (IPA). There is no other user
of that helper function. It would also allow to remove the check of
cdev_is_power_actor() because the code which calls it in IPA already does
the needed check. Make the function static since only IPA use it.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201015112441.4056-5-lukasz.luba@arm.com
---
 drivers/thermal/gov_power_allocator.c | 32 ++++++++++++++++++++-
 drivers/thermal/thermal_core.c        | 41 +--------------------------
 drivers/thermal/thermal_core.h        |  2 +-
 3 files changed, 32 insertions(+), 43 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index eb8c9af..b29e21c 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -255,6 +255,38 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 }
 
 /**
+ * power_actor_set_power() - limit the maximum power a cooling device consumes
+ * @cdev:	pointer to &thermal_cooling_device
+ * @instance:	thermal instance to update
+ * @power:	the power in milliwatts
+ *
+ * Set the cooling device to consume at most @power milliwatts. The limit is
+ * expected to be a cap at the maximum power consumption.
+ *
+ * Return: 0 on success, -EINVAL if the cooling device does not
+ * implement the power actor API or -E* for other failures.
+ */
+static int
+power_actor_set_power(struct thermal_cooling_device *cdev,
+		      struct thermal_instance *instance, u32 power)
+{
+	unsigned long state;
+	int ret;
+
+	ret = cdev->ops->power2state(cdev, power, &state);
+	if (ret)
+		return ret;
+
+	instance->target = clamp_val(state, instance->lower, instance->upper);
+	mutex_lock(&cdev->lock);
+	cdev->updated = false;
+	mutex_unlock(&cdev->lock);
+	thermal_cdev_update(cdev);
+
+	return 0;
+}
+
+/**
  * divvy_up_power() - divvy the allocated power between the actors
  * @req_power:	each actor's requested power
  * @max_power:	each actor's maximum available power
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d5540bf..96349ba 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -593,47 +593,6 @@ static void thermal_zone_device_check(struct work_struct *work)
 	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 }
 
-/*
- * Power actor section: interface to power actors to estimate power
- *
- * Set of functions used to interact to cooling devices that know
- * how to estimate their devices power consumption.
- */
-
-/**
- * power_actor_set_power() - limit the maximum power a cooling device consumes
- * @cdev:	pointer to &thermal_cooling_device
- * @instance:	thermal instance to update
- * @power:	the power in milliwatts
- *
- * Set the cooling device to consume at most @power milliwatts. The limit is
- * expected to be a cap at the maximum power consumption.
- *
- * Return: 0 on success, -EINVAL if the cooling device does not
- * implement the power actor API or -E* for other failures.
- */
-int power_actor_set_power(struct thermal_cooling_device *cdev,
-			  struct thermal_instance *instance, u32 power)
-{
-	unsigned long state;
-	int ret;
-
-	if (!cdev_is_power_actor(cdev))
-		return -EINVAL;
-
-	ret = cdev->ops->power2state(cdev, power, &state);
-	if (ret)
-		return ret;
-
-	instance->target = clamp_val(state, instance->lower, instance->upper);
-	mutex_lock(&cdev->lock);
-	cdev->updated = false;
-	mutex_unlock(&cdev->lock);
-	thermal_cdev_update(cdev);
-
-	return 0;
-}
-
 void thermal_zone_device_rebind_exception(struct thermal_zone_device *tz,
 					  const char *cdev_type, size_t size)
 {
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 416cdb1..8df600f 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -65,8 +65,6 @@ static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
 		cdev->ops->power2state;
 }
 
-int power_actor_set_power(struct thermal_cooling_device *cdev,
-			  struct thermal_instance *ti, u32 power);
 /**
  * struct thermal_trip - representation of a point in temperature domain
  * @np: pointer to struct device_node that this trip point was created from
