Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA777AA587
	for <lists+linux-pm@lfdr.de>; Fri, 22 Sep 2023 01:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjIUXUV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Sep 2023 19:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjIUXUU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Sep 2023 19:20:20 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAA2AF6BB;
        Thu, 21 Sep 2023 11:07:28 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 4759fab77295fb91; Thu, 21 Sep 2023 20:07:26 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 4C8CC664EBE;
        Thu, 21 Sep 2023 20:07:26 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 07/13] thermal: gov_power_allocator: Use trip pointers instead of trip indices
Date:   Thu, 21 Sep 2023 19:55:26 +0200
Message-ID: <2590280.Lt9SDvczpP@kreacher>
In-Reply-To: <1957441.PYKUYFuaPT@kreacher>
References: <1957441.PYKUYFuaPT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudekiedguddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhn
 thgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Eliminate the __thermal_zone_get_trip() usage that adds unnecessary
overhead (due to pointless bounds checking and copying of trip point
data) from the power allocator thermal governor and generally make it
use trip pointers instead of trip indices where applicable.

The general functionality is not expected to be changed.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_power_allocator.c |  102 ++++++++++++----------------------
 1 file changed, 38 insertions(+), 64 deletions(-)

Index: linux-pm/drivers/thermal/gov_power_allocator.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_power_allocator.c
+++ linux-pm/drivers/thermal/gov_power_allocator.c
@@ -16,8 +16,6 @@
 
 #include "thermal_core.h"
 
-#define INVALID_TRIP -1
-
 #define FRAC_BITS 10
 #define int_to_frac(x) ((x) << FRAC_BITS)
 #define frac_to_int(x) ((x) >> FRAC_BITS)
@@ -55,23 +53,23 @@ static inline s64 div_frac(s64 x, s64 y)
  * @err_integral:	accumulated error in the PID controller.
  * @prev_err:	error in the previous iteration of the PID controller.
  *		Used to calculate the derivative term.
+ * @sustainable_power:	Sustainable power (heat) that this thermal zone can
+ *			dissipate
  * @trip_switch_on:	first passive trip point of the thermal zone.  The
  *			governor switches on when this trip point is crossed.
  *			If the thermal zone only has one passive trip point,
- *			@trip_switch_on should be INVALID_TRIP.
+ *			@trip_switch_on should be NULL.
  * @trip_max_desired_temperature:	last passive trip point of the thermal
  *					zone.  The temperature we are
  *					controlling for.
- * @sustainable_power:	Sustainable power (heat) that this thermal zone can
- *			dissipate
  */
 struct power_allocator_params {
 	bool allocated_tzp;
 	s64 err_integral;
 	s32 prev_err;
-	int trip_switch_on;
-	int trip_max_desired_temperature;
 	u32 sustainable_power;
+	const struct thermal_trip *trip_switch_on;
+	const struct thermal_trip *trip_max_desired_temperature;
 };
 
 /**
@@ -90,14 +88,12 @@ static u32 estimate_sustainable_power(st
 	u32 sustainable_power = 0;
 	struct thermal_instance *instance;
 	struct power_allocator_params *params = tz->governor_data;
-	const struct thermal_trip *trip_max_desired_temperature =
-			&tz->trips[params->trip_max_desired_temperature];
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		struct thermal_cooling_device *cdev = instance->cdev;
 		u32 min_power;
 
-		if (instance->trip != trip_max_desired_temperature)
+		if (instance->trip != params->trip_max_desired_temperature)
 			continue;
 
 		if (!cdev_is_power_actor(cdev))
@@ -116,24 +112,23 @@ static u32 estimate_sustainable_power(st
  * estimate_pid_constants() - Estimate the constants for the PID controller
  * @tz:		thermal zone for which to estimate the constants
  * @sustainable_power:	sustainable power for the thermal zone
- * @trip_switch_on:	trip point number for the switch on temperature
+ * @trip_switch_on:	trip point for the switch on temperature
  * @control_temp:	target temperature for the power allocator governor
  *
  * This function is used to update the estimation of the PID
  * controller constants in struct thermal_zone_parameters.
  */
 static void estimate_pid_constants(struct thermal_zone_device *tz,
-				   u32 sustainable_power, int trip_switch_on,
+				   u32 sustainable_power,
+				   const struct thermal_trip *trip_switch_on,
 				   int control_temp)
 {
-	struct thermal_trip trip;
 	u32 temperature_threshold = control_temp;
 	int ret;
 	s32 k_i;
 
-	ret = __thermal_zone_get_trip(tz, trip_switch_on, &trip);
-	if (!ret)
-		temperature_threshold -= trip.temperature;
+	if (trip_switch_on)
+		temperature_threshold -= trip_switch_on->temperature;
 
 	/*
 	 * estimate_pid_constants() tries to find appropriate default
@@ -386,7 +381,7 @@ static int allocate_power(struct thermal
 	struct thermal_instance *instance;
 	struct power_allocator_params *params = tz->governor_data;
 	const struct thermal_trip *trip_max_desired_temperature =
-			&tz->trips[params->trip_max_desired_temperature];
+					params->trip_max_desired_temperature;
 	u32 *req_power, *max_power, *granted_power, *extra_actor_power;
 	u32 *weighted_req_power;
 	u32 total_req_power, max_allocatable_power, total_weighted_req_power;
@@ -513,46 +508,35 @@ static int allocate_power(struct thermal
 static void get_governor_trips(struct thermal_zone_device *tz,
 			       struct power_allocator_params *params)
 {
-	int i, last_active, last_passive;
-	bool found_first_passive;
-
-	found_first_passive = false;
-	last_active = INVALID_TRIP;
-	last_passive = INVALID_TRIP;
+	const struct thermal_trip *last_active = NULL:
+	const struct thermal_trip *last_passive = NULL;
+	bool found_first_passive = false;
+	int i;
 
 	for (i = 0; i < tz->num_trips; i++) {
-		struct thermal_trip trip;
-		int ret;
+		const struct thermal_trip *trip = &tz->trips[i];
 
-		ret = __thermal_zone_get_trip(tz, i, &trip);
-		if (ret) {
-			dev_warn(&tz->device,
-				 "Failed to get trip point %d type: %d\n", i,
-				 ret);
-			continue;
-		}
-
-		if (trip.type == THERMAL_TRIP_PASSIVE) {
+		if (trip->type == THERMAL_TRIP_PASSIVE) {
 			if (!found_first_passive) {
-				params->trip_switch_on = i;
+				params->trip_switch_on = trip;
 				found_first_passive = true;
 			} else  {
-				last_passive = i;
+				last_passive = trip;
 			}
-		} else if (trip.type == THERMAL_TRIP_ACTIVE) {
-			last_active = i;
+		} else if (trip->type == THERMAL_TRIP_ACTIVE) {
+			last_active = trip;
 		} else {
 			break;
 		}
 	}
 
-	if (last_passive != INVALID_TRIP) {
+	if (last_passive) {
 		params->trip_max_desired_temperature = last_passive;
 	} else if (found_first_passive) {
 		params->trip_max_desired_temperature = params->trip_switch_on;
-		params->trip_switch_on = INVALID_TRIP;
+		params->trip_switch_on = NULL;
 	} else {
-		params->trip_switch_on = INVALID_TRIP;
+		params->trip_switch_on = NULL;
 		params->trip_max_desired_temperature = last_active;
 	}
 }
@@ -567,14 +551,12 @@ static void allow_maximum_power(struct t
 {
 	struct thermal_instance *instance;
 	struct power_allocator_params *params = tz->governor_data;
-	const struct thermal_trip *trip_max_desired_temperature =
-			&tz->trips[params->trip_max_desired_temperature];
 	u32 req_power;
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		struct thermal_cooling_device *cdev = instance->cdev;
 
-		if ((instance->trip != trip_max_desired_temperature) ||
+		if (instance->trip != params->trip_max_desired_temperature ||
 		    (!cdev_is_power_actor(instance->cdev)))
 			continue;
 
@@ -636,7 +618,6 @@ static int power_allocator_bind(struct t
 {
 	int ret;
 	struct power_allocator_params *params;
-	struct thermal_trip trip;
 
 	ret = check_power_actors(tz);
 	if (ret)
@@ -662,12 +643,13 @@ static int power_allocator_bind(struct t
 	get_governor_trips(tz, params);
 
 	if (tz->num_trips > 0) {
-		ret = __thermal_zone_get_trip(tz, params->trip_max_desired_temperature,
-					      &trip);
-		if (!ret)
+		const struct thermal_trip *trip;
+
+		trip = params->trip_max_desired_temperature;
+		if (trip)
 			estimate_pid_constants(tz, tz->tzp->sustainable_power,
 					       params->trip_switch_on,
-					       trip.temperature);
+					       trip->temperature);
 	}
 
 	reset_pid_controller(params);
@@ -697,11 +679,10 @@ static void power_allocator_unbind(struc
 	tz->governor_data = NULL;
 }
 
-static int power_allocator_throttle(struct thermal_zone_device *tz, int trip_id)
+static int power_allocator_throttle(struct thermal_zone_device *tz, int trip_index)
 {
 	struct power_allocator_params *params = tz->governor_data;
-	struct thermal_trip trip;
-	int ret;
+	const struct thermal_trip *trip = &tz->trips[trip_index];
 	bool update;
 
 	lockdep_assert_held(&tz->lock);
@@ -710,12 +691,12 @@ static int power_allocator_throttle(stru
 	 * We get called for every trip point but we only need to do
 	 * our calculations once
 	 */
-	if (trip_id != params->trip_max_desired_temperature)
+	if (trip != params->trip_max_desired_temperature)
 		return 0;
 
-	ret = __thermal_zone_get_trip(tz, params->trip_switch_on, &trip);
-	if (!ret && (tz->temperature < trip.temperature)) {
-		update = (tz->last_temperature >= trip.temperature);
+	trip = params->trip_switch_on;
+	if (trip && tz->temperature < trip->temperature) {
+		update = tz->last_temperature >= trip->temperature;
 		tz->passive = 0;
 		reset_pid_controller(params);
 		allow_maximum_power(tz, update);
@@ -724,14 +705,7 @@ static int power_allocator_throttle(stru
 
 	tz->passive = 1;
 
-	ret = __thermal_zone_get_trip(tz, params->trip_max_desired_temperature, &trip);
-	if (ret) {
-		dev_warn(&tz->device, "Failed to get the maximum desired temperature: %d\n",
-			 ret);
-		return ret;
-	}
-
-	return allocate_power(tz, trip.temperature);
+	return allocate_power(tz, params->trip_max_desired_temperature->temperature);
 }
 
 static struct thermal_governor thermal_gov_power_allocator = {



