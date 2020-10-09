Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FFE288A28
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 15:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387889AbgJIN7H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Oct 2020 09:59:07 -0400
Received: from foss.arm.com ([217.140.110.172]:51832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387861AbgJIN7G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Oct 2020 09:59:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B00C011B3;
        Fri,  9 Oct 2020 06:59:05 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.51.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CD8EF3F70D;
        Fri,  9 Oct 2020 06:59:03 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org,
        Dietmar.Eggemann@arm.com, lukasz.luba@arm.com,
        ionela.voinescu@arm.com
Subject: [PATCH v3 2/2] thermal: power allocator: change how estimation code is called
Date:   Fri,  9 Oct 2020 14:58:50 +0100
Message-Id: <20201009135850.14727-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201009135850.14727-1-lukasz.luba@arm.com>
References: <20201009135850.14727-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The sustainable power value might come from the Device Tree or can be
estimated in run time. There is no need to estimate every time when the
governor is called and temperature is high. Instead, store the estimated
value and make it available via standard sysfs interface so it can be
checked from the user-space. Re-invoke the estimation only in case the
sustainable power was set to 0. Apart from that the PID coefficients
are not going to be force updated thus can better handle sysfs settings.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---

v3:
- changed estimate_pid_constants to estimate_tzp_constants and related comments
- estimate the PID coefficients always together with sust. power
- added print indicating that we are estimating sust. power and PID const.
- don't use local variable 'sustainable_power'


 drivers/thermal/gov_power_allocator.c | 65 ++++++++++++---------------
 1 file changed, 29 insertions(+), 36 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index aa35aa6c561c..e92a8d3ca5d4 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -96,6 +96,9 @@ static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
 		if (instance->trip != params->trip_max_desired_temperature)
 			continue;
 
+		if (!cdev_is_power_actor(cdev))
+			continue;
+
 		if (cdev->ops->state2power(cdev, tz, instance->upper,
 					   &min_power))
 			continue;
@@ -107,40 +110,37 @@ static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
 }
 
 /**
- * estimate_pid_constants() - Estimate the constants for the PID controller
+ * estimate_tzp_constants() - Estimate sustainable power and PID constants
  * @tz:		thermal zone for which to estimate the constants
- * @sustainable_power:	sustainable power for the thermal zone
  * @trip_switch_on:	trip point number for the switch on temperature
  * @control_temp:	target temperature for the power allocator governor
- * @force:	whether to force the update of the constants
  *
- * This function is used to update the estimation of the PID
- * controller constants in struct thermal_zone_parameters.
- * Sustainable power is provided in case it was estimated.  The
- * estimated sustainable_power should not be stored in the
- * thermal_zone_parameters so it has to be passed explicitly to this
- * function.
- *
- * If @force is not set, the values in the thermal zone's parameters
- * are preserved if they are not zero.  If @force is set, the values
- * in thermal zone's parameters are overwritten.
+ * This function is used to estimate the sustainable power and PID controller
+ * constants in struct thermal_zone_parameters. These estimations will then be
+ * available in the sysfs.
  */
-static void estimate_pid_constants(struct thermal_zone_device *tz,
-				   u32 sustainable_power, int trip_switch_on,
-				   int control_temp, bool force)
+static void estimate_tzp_constants(struct thermal_zone_device *tz,
+				   int trip_switch_on, int control_temp)
 {
-	int ret;
-	int switch_on_temp;
 	u32 temperature_threshold;
+	int switch_on_temp;
+	bool force = false;
+	int ret;
 	s32 k_i;
 
+	if (!tz->tzp->sustainable_power) {
+		tz->tzp->sustainable_power = estimate_sustainable_power(tz);
+		force = true;
+		dev_info(&tz->device, "power_allocator: estimating sust. power and PID constants\n");
+	}
+
 	ret = tz->ops->get_trip_temp(tz, trip_switch_on, &switch_on_temp);
 	if (ret)
 		switch_on_temp = 0;
 
 	temperature_threshold = control_temp - switch_on_temp;
 	/*
-	 * estimate_pid_constants() tries to find appropriate default
+	 * estimate_tzp_constants() tries to find appropriate default
 	 * values for thermal zones that don't provide them. If a
 	 * system integrator has configured a thermal zone with two
 	 * passive trip points at the same temperature, that person
@@ -151,11 +151,11 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
 		return;
 
 	if (!tz->tzp->k_po || force)
-		tz->tzp->k_po = int_to_frac(sustainable_power) /
+		tz->tzp->k_po = int_to_frac(tz->tzp->sustainable_power) /
 			temperature_threshold;
 
 	if (!tz->tzp->k_pu || force)
-		tz->tzp->k_pu = int_to_frac(2 * sustainable_power) /
+		tz->tzp->k_pu = int_to_frac(2 * tz->tzp->sustainable_power) /
 			temperature_threshold;
 
 	if (!tz->tzp->k_i || force) {
@@ -193,19 +193,13 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 {
 	s64 p, i, d, power_range;
 	s32 err, max_power_frac;
-	u32 sustainable_power;
 	struct power_allocator_params *params = tz->governor_data;
 
 	max_power_frac = int_to_frac(max_allocatable_power);
 
-	if (tz->tzp->sustainable_power) {
-		sustainable_power = tz->tzp->sustainable_power;
-	} else {
-		sustainable_power = estimate_sustainable_power(tz);
-		estimate_pid_constants(tz, sustainable_power,
-				       params->trip_switch_on, control_temp,
-				       true);
-	}
+	if (!tz->tzp->sustainable_power)
+		estimate_tzp_constants(tz, params->trip_switch_on,
+				       control_temp);
 
 	err = control_temp - tz->temperature;
 	err = int_to_frac(err);
@@ -244,7 +238,7 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 	power_range = p + i + d;
 
 	/* feed-forward the known sustainable dissipatable power */
-	power_range = sustainable_power + frac_to_int(power_range);
+	power_range = tz->tzp->sustainable_power + frac_to_int(power_range);
 
 	power_range = clamp(power_range, (s64)0, (s64)max_allocatable_power);
 
@@ -603,20 +597,19 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 
 	get_governor_trips(tz, params);
 
+	tz->governor_data = params;
+
 	if (tz->trips > 0) {
 		ret = tz->ops->get_trip_temp(tz,
 					params->trip_max_desired_temperature,
 					&control_temp);
 		if (!ret)
-			estimate_pid_constants(tz, tz->tzp->sustainable_power,
-					       params->trip_switch_on,
-					       control_temp, false);
+			estimate_tzp_constants(tz, params->trip_switch_on,
+					       control_temp);
 	}
 
 	reset_pid_controller(params);
 
-	tz->governor_data = params;
-
 	return 0;
 
 free_params:
-- 
2.17.1

