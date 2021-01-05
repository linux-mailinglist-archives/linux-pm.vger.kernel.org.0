Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9E22EB322
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 20:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbhAETCJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jan 2021 14:02:09 -0500
Received: from foss.arm.com ([217.140.110.172]:59300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730759AbhAETCJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 Jan 2021 14:02:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4046B1FB;
        Tue,  5 Jan 2021 11:01:23 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.0.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9F4BC3F719;
        Tue,  5 Jan 2021 11:01:21 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com
Subject: [PATCH] thermal: power allocator: Add control for non-power actor devices
Date:   Tue,  5 Jan 2021 19:01:07 +0000
Message-Id: <20210105190107.30479-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cooling devices which are used in IPA should provide power mapping
functions. The callback functions are used for power estimation and state
setting. When these functions are missing IPA ignores such cooling devices
and does not limit their performance. It could happen that the platform
configuration is missing these functions in example when the Energy Model
was not setup properly (missing DT entry 'dynamic-power-coefficient').

The patch adds basic control over these devices' performance. It
manages to throttle them to stay safe and not overheat. It also adds a
warning during the binding phase, so it can be captured during testing.

The patch covers also a corner case when all of the cooling devices are
non-power actors.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 71 +++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 7a4170a0b51f..bcd1d524a1ba 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -276,6 +276,33 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 	return power_range;
 }
 
+/**
+ * control_non_power_actor() - control performance of a cooling device which
+ *				is not a power actor
+ * @instance:   thermal instance to update
+ * @throttle:	boolean flag indicating the action
+ *
+ * Set the min/max performance point for a given cooling device, with respect
+ * to limits. It is needed only for devices which are not power actors and
+ * don't provide the power mapping functions. These devices will be capped
+ * more strictly to provide safe conditions and not overheat them.
+ */
+static void control_non_power_actor(struct thermal_instance *instance,
+				    bool throttle)
+{
+	struct thermal_cooling_device *cdev = instance->cdev;
+
+	if (throttle)
+		instance->target = instance->upper;
+	else
+		instance->target = instance->lower;
+
+	mutex_lock(&cdev->lock);
+	cdev->updated = false;
+	mutex_unlock(&cdev->lock);
+	thermal_cdev_update(cdev);
+}
+
 /**
  * power_actor_set_power() - limit the maximum power a cooling device consumes
  * @cdev:	pointer to &thermal_cooling_device
@@ -405,7 +432,7 @@ static int allocate_power(struct thermal_zone_device *tz,
 
 	if (!num_actors) {
 		ret = -ENODEV;
-		goto unlock;
+		goto safety_throttling;
 	}
 
 	/*
@@ -495,6 +522,16 @@ static int allocate_power(struct thermal_zone_device *tz,
 				      control_temp - tz->temperature);
 
 	kfree(req_power);
+
+safety_throttling:
+	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+		if (instance->trip != trip_max_desired_temperature)
+			continue;
+
+		if (!cdev_is_power_actor(instance->cdev))
+			control_non_power_actor(instance, true);
+	}
+
 unlock:
 	mutex_unlock(&tz->lock);
 
@@ -576,9 +613,13 @@ static void allow_maximum_power(struct thermal_zone_device *tz)
 
 	mutex_lock(&tz->lock);
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if ((instance->trip != params->trip_max_desired_temperature) ||
-		    (!cdev_is_power_actor(instance->cdev)))
+		if (instance->trip != params->trip_max_desired_temperature)
+			continue;
+
+		if (!cdev_is_power_actor(instance->cdev)) {
+			control_non_power_actor(instance, false);
 			continue;
+		}
 
 		instance->target = 0;
 		mutex_lock(&instance->cdev->lock);
@@ -589,6 +630,28 @@ static void allow_maximum_power(struct thermal_zone_device *tz)
 	mutex_unlock(&tz->lock);
 }
 
+/**
+ * check_power_actors() - Check all cooling devices and warn when they are
+ *			not power actors
+ * @tz:		thermal zone to operate on
+ *
+ * Check all cooling devices in the @tz and warn when they are not power
+ * actors. These cooling devices will be throttled aggressively because they
+ * miss needed callbacks. The warning would help to investigate the issue,
+ * which could be e.g. lack of Energy Model for a given device.
+ */
+static void check_power_actors(struct thermal_zone_device *tz)
+{
+	struct thermal_instance *instance;
+
+	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+		if (!cdev_is_power_actor(instance->cdev)) {
+			dev_warn(&tz->device, "power_allocator: %s is not a power actor\n",
+				 instance->cdev->type);
+		}
+	}
+}
+
 /**
  * power_allocator_bind() - bind the power_allocator governor to a thermal zone
  * @tz:	thermal zone to bind it to
@@ -637,6 +700,8 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 
 	tz->governor_data = params;
 
+	check_power_actors(tz);
+
 	return 0;
 
 free_params:
-- 
2.17.1

