Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6A228F0E0
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 13:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgJOLZi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 07:25:38 -0400
Received: from foss.arm.com ([217.140.110.172]:32830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728329AbgJOLZH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Oct 2020 07:25:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA2B813D5;
        Thu, 15 Oct 2020 04:25:06 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.48.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DAFFA3F66B;
        Thu, 15 Oct 2020 04:25:04 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org,
        Dietmar.Eggemann@arm.com, lukasz.luba@arm.com,
        michael.kao@mediatek.com, rui.zhang@intel.com
Subject: [PATCH v2 4/4] thermal: move power_actor_set_power into IPA
Date:   Thu, 15 Oct 2020 12:24:41 +0100
Message-Id: <20201015112441.4056-5-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015112441.4056-1-lukasz.luba@arm.com>
References: <20201015112441.4056-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since the power actor section has one function power_actor_set_power()
move it into Intelligent Power Allocation (IPA). There is no other user
of that helper function. It would also allow to remove the check of
cdev_is_power_actor() because the code which calls it in IPA already does
the needed check. Make the function static since only IPA use it.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 32 +++++++++++++++++++++
 drivers/thermal/thermal_core.c        | 41 ---------------------------
 drivers/thermal/thermal_core.h        |  2 --
 3 files changed, 32 insertions(+), 43 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index eb8c9afadf19..b29e21c56a4f 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -254,6 +254,38 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 	return power_range;
 }
 
+/**
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
 /**
  * divvy_up_power() - divvy the allocated power between the actors
  * @req_power:	each actor's requested power
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d5540bfeee5e..96349ba59725 100644
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
index 14f8a829a84a..fc887d6f23ff 100644
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
-- 
2.17.1

