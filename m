Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D963BD799
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 15:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhGFNVd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jul 2021 09:21:33 -0400
Received: from foss.arm.com ([217.140.110.172]:42182 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231843AbhGFNVa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Jul 2021 09:21:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EB341FB;
        Tue,  6 Jul 2021 06:18:52 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.7.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D91383F73B;
        Tue,  6 Jul 2021 06:18:49 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        Chris.Redpath@arm.com, Beata.Michalska@arm.com,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, amit.kachhap@gmail.com
Subject: [RFC PATCH v2 5/6] thermal/core/power allocator: Prepare power actors and calm down when not used
Date:   Tue,  6 Jul 2021 14:18:27 +0100
Message-Id: <20210706131828.22309-6-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210706131828.22309-1-lukasz.luba@arm.com>
References: <20210706131828.22309-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cooling devices in thermal zone can support an interface for
preparation to work with thermal governor. They should be properly setup
before the first throttling happens, which means the internal power
tracking mechanism should be ready. When the IPA is not used or thermal
zone is disabled the power tracking can be stopped. Thus, add the code
which handles cooling device proper setup for the operation with IPA.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 71 +++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 13e375751d22..678fb544c8af 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -53,6 +53,8 @@ static inline s64 div_frac(s64 x, s64 y)
  * struct power_allocator_params - parameters for the power allocator governor
  * @allocated_tzp:	whether we have allocated tzp for this thermal zone and
  *			it needs to be freed on unbind
+ * @actors_ready:	set to 1 when power actors are properly setup or set to
+ *			-EINVAL when there were errors during preparation
  * @err_integral:	accumulated error in the PID controller.
  * @prev_err:	error in the previous iteration of the PID controller.
  *		Used to calculate the derivative term.
@@ -68,6 +70,7 @@ static inline s64 div_frac(s64 x, s64 y)
  */
 struct power_allocator_params {
 	bool allocated_tzp;
+	int actors_ready;
 	s64 err_integral;
 	s32 prev_err;
 	int trip_switch_on;
@@ -693,9 +696,20 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 static void power_allocator_unbind(struct thermal_zone_device *tz)
 {
 	struct power_allocator_params *params = tz->governor_data;
+	struct thermal_instance *instance;
 
 	dev_dbg(&tz->device, "Unbinding from thermal zone %d\n", tz->id);
 
+	/* Calm down cooling devices and stop monitoring mechanims */
+	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+		struct thermal_cooling_device *cdev = instance->cdev;
+
+		if (!cdev_is_power_actor(cdev))
+			continue;
+		if (cdev->ops->change_governor)
+			cdev->ops->change_governor(cdev, false);
+	}
+
 	if (params->allocated_tzp) {
 		kfree(tz->tzp);
 		tz->tzp = NULL;
@@ -705,6 +719,51 @@ static void power_allocator_unbind(struct thermal_zone_device *tz)
 	tz->governor_data = NULL;
 }
 
+static int prepare_power_actors(struct thermal_zone_device *tz)
+{
+	struct power_allocator_params *params = tz->governor_data;
+	struct thermal_instance *instance;
+	int ret;
+
+	if (params->actors_ready > 0)
+		return 0;
+
+	if (params->actors_ready < 0)
+		return -EINVAL;
+
+	mutex_lock(&tz->lock);
+
+	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+		struct thermal_cooling_device *cdev = instance->cdev;
+
+		if (!cdev_is_power_actor(cdev))
+			continue;
+		if (cdev->ops->change_governor) {
+			ret = cdev->ops->change_governor(cdev, true);
+			if (ret)
+				goto clean_up;
+		}
+	}
+
+	mutex_unlock(&tz->lock);
+	params->actors_ready = 1;
+	return 0;
+
+clean_up:
+	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+		struct thermal_cooling_device *cdev = instance->cdev;
+
+		if (!cdev_is_power_actor(cdev))
+			continue;
+		if (cdev->ops->change_governor)
+			cdev->ops->change_governor(cdev, false);
+	}
+
+	mutex_unlock(&tz->lock);
+	params->actors_ready = -EINVAL;
+	return -EINVAL;
+}
+
 static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 {
 	int ret;
@@ -719,6 +778,18 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
 	if (trip != params->trip_max_desired_temperature)
 		return 0;
 
+	/*
+	 * If we are called for the first time (e.g. after enabling thermal
+	 * zone), setup properly power actors
+	 */
+	ret = prepare_power_actors(tz);
+	if (ret) {
+		dev_warn_once(&tz->device,
+			      "Failed to setup IPA power actors: %d\n",
+			      ret);
+		return ret;
+	}
+
 	ret = tz->ops->get_trip_temp(tz, params->trip_switch_on,
 				     &switch_on_temp);
 	if (!ret && (tz->temperature < switch_on_temp)) {
-- 
2.17.1

