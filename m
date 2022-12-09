Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1D064853E
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiLIP1K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiLIP0l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F558F72E
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:34 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599590;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dp0IgTHU1/Nqiv7WkUClZ1tkE8VAhxSxkZeRSoFB4XQ=;
        b=SCNfrXiexcUz2AA6VPduWpGRkHrJYPeWtkgdpfc4t6qxX8J65zpoxd0oiPHTjPT/a46kOr
        iFRMaMoy9N+ctG9XbXw19mGbsxATPWDDjrQf/uTet2AWqgjxKvvlZmGrdX15PLNbos+svi
        KTfIqUwHWQzMEvQSIxjjOUyaTrTZqWxZXwLASUX4O3Uh1O/+OBtaN4G7Dd5UlEYYymF4Wa
        gKomjQ7V0xWoXKrgZOCnyxfLTA6TnIlT7UNWIFkodvjdrISD+fIy7lnPgMh23uqHBVrdTe
        RQWTmjxTu9660V/A1Ul7/XxamvoE9oEruGpmGbXHTXYnPmPU1ZEzfN5O7ioQxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599590;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dp0IgTHU1/Nqiv7WkUClZ1tkE8VAhxSxkZeRSoFB4XQ=;
        b=/y1Bglf0+a2aruw7sMZqEvpZkF3Ep8m9WTbfR4P5uniBb2GbnNPEwv0Zc5KU/tpLY5Jg/I
        YOG5j0SwOrxtXvCw==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/mellanox: Use generic
 thermal_zone_get_trip() function
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vadim Pasternak <vadimp@nvidia.com>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20221014073253.3719911-2-daniel.lezcano@linaro.org>
References: <20221014073253.3719911-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <167059959053.4906.16285134162838835042.tip-bot2@tip-bot2>
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

Commit-ID:     c147694778b1aa7e3faed10b61256fe03e605f3b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//c147694778b1aa7e3faed10b61256fe03e605f3b
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Fri, 14 Oct 2022 09:32:51 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:43 +01:00

thermal/drivers/mellanox: Use generic thermal_zone_get_trip() function

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Vadim Pasternak <vadimp@nvidia.com>
Link: https://lore.kernel.org/r/20221014073253.3719911-2-daniel.lezcano@linaro.org
---
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c | 209 ++----------
 1 file changed, 48 insertions(+), 161 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index 987fe5c..c5240d3 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -36,33 +36,39 @@ enum mlxsw_thermal_trips {
 	MLXSW_THERMAL_TEMP_TRIP_HOT,
 };
 
-struct mlxsw_thermal_trip {
-	int	type;
-	int	temp;
-	int	hyst;
+struct mlxsw_cooling_states {
 	int	min_state;
 	int	max_state;
 };
 
-static const struct mlxsw_thermal_trip default_thermal_trips[] = {
+static const struct thermal_trip default_thermal_trips[] = {
 	{	/* In range - 0-40% PWM */
 		.type		= THERMAL_TRIP_ACTIVE,
-		.temp		= MLXSW_THERMAL_ASIC_TEMP_NORM,
-		.hyst		= MLXSW_THERMAL_HYSTERESIS_TEMP,
-		.min_state	= 0,
-		.max_state	= (4 * MLXSW_THERMAL_MAX_STATE) / 10,
+		.temperature	= MLXSW_THERMAL_ASIC_TEMP_NORM,
+		.hysteresis	= MLXSW_THERMAL_HYSTERESIS_TEMP,
 	},
 	{
 		/* In range - 40-100% PWM */
 		.type		= THERMAL_TRIP_ACTIVE,
-		.temp		= MLXSW_THERMAL_ASIC_TEMP_HIGH,
-		.hyst		= MLXSW_THERMAL_HYSTERESIS_TEMP,
-		.min_state	= (4 * MLXSW_THERMAL_MAX_STATE) / 10,
-		.max_state	= MLXSW_THERMAL_MAX_STATE,
+		.temperature	= MLXSW_THERMAL_ASIC_TEMP_HIGH,
+		.hysteresis	= MLXSW_THERMAL_HYSTERESIS_TEMP,
 	},
 	{	/* Warning */
 		.type		= THERMAL_TRIP_HOT,
-		.temp		= MLXSW_THERMAL_ASIC_TEMP_HOT,
+		.temperature	= MLXSW_THERMAL_ASIC_TEMP_HOT,
+	},
+};
+
+static const struct mlxsw_cooling_states default_cooling_states[] = {
+	{
+		.min_state	= 0,
+		.max_state	= (4 * MLXSW_THERMAL_MAX_STATE) / 10,
+	},
+	{
+		.min_state	= (4 * MLXSW_THERMAL_MAX_STATE) / 10,
+		.max_state	= MLXSW_THERMAL_MAX_STATE,
+	},
+	{
 		.min_state	= MLXSW_THERMAL_MAX_STATE,
 		.max_state	= MLXSW_THERMAL_MAX_STATE,
 	},
@@ -78,7 +84,8 @@ struct mlxsw_thermal;
 struct mlxsw_thermal_module {
 	struct mlxsw_thermal *parent;
 	struct thermal_zone_device *tzdev;
-	struct mlxsw_thermal_trip trips[MLXSW_THERMAL_NUM_TRIPS];
+	struct thermal_trip trips[MLXSW_THERMAL_NUM_TRIPS];
+	struct mlxsw_cooling_states cooling_states[MLXSW_THERMAL_NUM_TRIPS];
 	int module; /* Module or gearbox number */
 	u8 slot_index;
 };
@@ -99,7 +106,8 @@ struct mlxsw_thermal {
 	int polling_delay;
 	struct thermal_cooling_device *cdevs[MLXSW_MFCR_PWMS_MAX];
 	u8 cooling_levels[MLXSW_THERMAL_MAX_STATE + 1];
-	struct mlxsw_thermal_trip trips[MLXSW_THERMAL_NUM_TRIPS];
+	struct thermal_trip trips[MLXSW_THERMAL_NUM_TRIPS];
+	struct mlxsw_cooling_states cooling_states[MLXSW_THERMAL_NUM_TRIPS];
 	struct mlxsw_thermal_area line_cards[];
 };
 
@@ -136,9 +144,9 @@ static int mlxsw_get_cooling_device_idx(struct mlxsw_thermal *thermal,
 static void
 mlxsw_thermal_module_trips_reset(struct mlxsw_thermal_module *tz)
 {
-	tz->trips[MLXSW_THERMAL_TEMP_TRIP_NORM].temp = 0;
-	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HIGH].temp = 0;
-	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HOT].temp = 0;
+	tz->trips[MLXSW_THERMAL_TEMP_TRIP_NORM].temperature = 0;
+	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HIGH].temperature = 0;
+	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HOT].temperature = 0;
 }
 
 static int
@@ -180,12 +188,12 @@ mlxsw_thermal_module_trips_update(struct device *dev, struct mlxsw_core *core,
 	 * by subtracting double hysteresis value.
 	 */
 	if (crit_temp >= MLXSW_THERMAL_MODULE_TEMP_SHIFT)
-		tz->trips[MLXSW_THERMAL_TEMP_TRIP_NORM].temp = crit_temp -
+		tz->trips[MLXSW_THERMAL_TEMP_TRIP_NORM].temperature = crit_temp -
 					MLXSW_THERMAL_MODULE_TEMP_SHIFT;
 	else
-		tz->trips[MLXSW_THERMAL_TEMP_TRIP_NORM].temp = crit_temp;
-	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HIGH].temp = crit_temp;
-	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HOT].temp = emerg_temp;
+		tz->trips[MLXSW_THERMAL_TEMP_TRIP_NORM].temperature = crit_temp;
+	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HIGH].temperature = crit_temp;
+	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HOT].temperature = emerg_temp;
 
 	return 0;
 }
@@ -202,11 +210,11 @@ static int mlxsw_thermal_bind(struct thermal_zone_device *tzdev,
 		return 0;
 
 	for (i = 0; i < MLXSW_THERMAL_NUM_TRIPS; i++) {
-		const struct mlxsw_thermal_trip *trip = &thermal->trips[i];
+		const struct mlxsw_cooling_states *state = &thermal->cooling_states[i];
 
 		err = thermal_zone_bind_cooling_device(tzdev, i, cdev,
-						       trip->max_state,
-						       trip->min_state,
+						       state->max_state,
+						       state->min_state,
 						       THERMAL_WEIGHT_DEFAULT);
 		if (err < 0) {
 			dev_err(dev, "Failed to bind cooling device to trip %d\n", i);
@@ -260,61 +268,6 @@ static int mlxsw_thermal_get_temp(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
-static int mlxsw_thermal_get_trip_type(struct thermal_zone_device *tzdev,
-				       int trip,
-				       enum thermal_trip_type *p_type)
-{
-	struct mlxsw_thermal *thermal = tzdev->devdata;
-
-	if (trip < 0 || trip >= MLXSW_THERMAL_NUM_TRIPS)
-		return -EINVAL;
-
-	*p_type = thermal->trips[trip].type;
-	return 0;
-}
-
-static int mlxsw_thermal_get_trip_temp(struct thermal_zone_device *tzdev,
-				       int trip, int *p_temp)
-{
-	struct mlxsw_thermal *thermal = tzdev->devdata;
-
-	if (trip < 0 || trip >= MLXSW_THERMAL_NUM_TRIPS)
-		return -EINVAL;
-
-	*p_temp = thermal->trips[trip].temp;
-	return 0;
-}
-
-static int mlxsw_thermal_set_trip_temp(struct thermal_zone_device *tzdev,
-				       int trip, int temp)
-{
-	struct mlxsw_thermal *thermal = tzdev->devdata;
-
-	if (trip < 0 || trip >= MLXSW_THERMAL_NUM_TRIPS)
-		return -EINVAL;
-
-	thermal->trips[trip].temp = temp;
-	return 0;
-}
-
-static int mlxsw_thermal_get_trip_hyst(struct thermal_zone_device *tzdev,
-				       int trip, int *p_hyst)
-{
-	struct mlxsw_thermal *thermal = tzdev->devdata;
-
-	*p_hyst = thermal->trips[trip].hyst;
-	return 0;
-}
-
-static int mlxsw_thermal_set_trip_hyst(struct thermal_zone_device *tzdev,
-				       int trip, int hyst)
-{
-	struct mlxsw_thermal *thermal = tzdev->devdata;
-
-	thermal->trips[trip].hyst = hyst;
-	return 0;
-}
-
 static struct thermal_zone_params mlxsw_thermal_params = {
 	.no_hwmon = true,
 };
@@ -323,11 +276,6 @@ static struct thermal_zone_device_ops mlxsw_thermal_ops = {
 	.bind = mlxsw_thermal_bind,
 	.unbind = mlxsw_thermal_unbind,
 	.get_temp = mlxsw_thermal_get_temp,
-	.get_trip_type	= mlxsw_thermal_get_trip_type,
-	.get_trip_temp	= mlxsw_thermal_get_trip_temp,
-	.set_trip_temp	= mlxsw_thermal_set_trip_temp,
-	.get_trip_hyst	= mlxsw_thermal_get_trip_hyst,
-	.set_trip_hyst	= mlxsw_thermal_set_trip_hyst,
 };
 
 static int mlxsw_thermal_module_bind(struct thermal_zone_device *tzdev,
@@ -342,11 +290,11 @@ static int mlxsw_thermal_module_bind(struct thermal_zone_device *tzdev,
 		return 0;
 
 	for (i = 0; i < MLXSW_THERMAL_NUM_TRIPS; i++) {
-		const struct mlxsw_thermal_trip *trip = &tz->trips[i];
+		const struct mlxsw_cooling_states *state = &tz->cooling_states[i];
 
 		err = thermal_zone_bind_cooling_device(tzdev, i, cdev,
-						       trip->max_state,
-						       trip->min_state,
+						       state->max_state,
+						       state->min_state,
 						       THERMAL_WEIGHT_DEFAULT);
 		if (err < 0)
 			goto err_thermal_zone_bind_cooling_device;
@@ -434,74 +382,10 @@ static int mlxsw_thermal_module_temp_get(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
-static int
-mlxsw_thermal_module_trip_type_get(struct thermal_zone_device *tzdev, int trip,
-				   enum thermal_trip_type *p_type)
-{
-	struct mlxsw_thermal_module *tz = tzdev->devdata;
-
-	if (trip < 0 || trip >= MLXSW_THERMAL_NUM_TRIPS)
-		return -EINVAL;
-
-	*p_type = tz->trips[trip].type;
-	return 0;
-}
-
-static int
-mlxsw_thermal_module_trip_temp_get(struct thermal_zone_device *tzdev,
-				   int trip, int *p_temp)
-{
-	struct mlxsw_thermal_module *tz = tzdev->devdata;
-
-	if (trip < 0 || trip >= MLXSW_THERMAL_NUM_TRIPS)
-		return -EINVAL;
-
-	*p_temp = tz->trips[trip].temp;
-	return 0;
-}
-
-static int
-mlxsw_thermal_module_trip_temp_set(struct thermal_zone_device *tzdev,
-				   int trip, int temp)
-{
-	struct mlxsw_thermal_module *tz = tzdev->devdata;
-
-	if (trip < 0 || trip >= MLXSW_THERMAL_NUM_TRIPS)
-		return -EINVAL;
-
-	tz->trips[trip].temp = temp;
-	return 0;
-}
-
-static int
-mlxsw_thermal_module_trip_hyst_get(struct thermal_zone_device *tzdev, int trip,
-				   int *p_hyst)
-{
-	struct mlxsw_thermal_module *tz = tzdev->devdata;
-
-	*p_hyst = tz->trips[trip].hyst;
-	return 0;
-}
-
-static int
-mlxsw_thermal_module_trip_hyst_set(struct thermal_zone_device *tzdev, int trip,
-				   int hyst)
-{
-	struct mlxsw_thermal_module *tz = tzdev->devdata;
-
-	tz->trips[trip].hyst = hyst;
-	return 0;
-}
-
 static struct thermal_zone_device_ops mlxsw_thermal_module_ops = {
 	.bind		= mlxsw_thermal_module_bind,
 	.unbind		= mlxsw_thermal_module_unbind,
 	.get_temp	= mlxsw_thermal_module_temp_get,
-	.get_trip_type	= mlxsw_thermal_module_trip_type_get,
-	.get_trip_temp	= mlxsw_thermal_module_trip_temp_get,
-	.set_trip_temp	= mlxsw_thermal_module_trip_temp_set,
-	.get_trip_hyst	= mlxsw_thermal_module_trip_hyst_get,
-	.set_trip_hyst	= mlxsw_thermal_module_trip_hyst_set,
 };
 
 static int mlxsw_thermal_gearbox_temp_get(struct thermal_zone_device *tzdev,
@@ -531,11 +415,6 @@ static struct thermal_zone_device_ops mlxsw_thermal_gearbox_ops = {
 	.bind		= mlxsw_thermal_module_bind,
 	.unbind		= mlxsw_thermal_module_unbind,
 	.get_temp	= mlxsw_thermal_gearbox_temp_get,
-	.get_trip_type	= mlxsw_thermal_module_trip_type_get,
-	.get_trip_temp	= mlxsw_thermal_module_trip_temp_get,
-	.set_trip_temp	= mlxsw_thermal_module_trip_temp_set,
-	.get_trip_hyst	= mlxsw_thermal_module_trip_hyst_get,
-	.set_trip_hyst	= mlxsw_thermal_module_trip_hyst_set,
 };
 
 static int mlxsw_thermal_get_max_state(struct thermal_cooling_device *cdev,
@@ -617,7 +496,8 @@ mlxsw_thermal_module_tz_init(struct mlxsw_thermal_module *module_tz)
 	else
 		snprintf(tz_name, sizeof(tz_name), "mlxsw-module%d",
 			 module_tz->module + 1);
-	module_tz->tzdev = thermal_zone_device_register(tz_name,
+	module_tz->tzdev = thermal_zone_device_register_with_trips(tz_name,
+							module_tz->trips,
 							MLXSW_THERMAL_NUM_TRIPS,
 							MLXSW_THERMAL_TRIP_MASK,
 							module_tz,
@@ -661,6 +541,8 @@ mlxsw_thermal_module_init(struct device *dev, struct mlxsw_core *core,
 	module_tz->parent = thermal;
 	memcpy(module_tz->trips, default_thermal_trips,
 	       sizeof(thermal->trips));
+	memcpy(module_tz->cooling_states, default_cooling_states,
+	       sizeof(thermal->cooling_states));
 	/* Initialize all trip point. */
 	mlxsw_thermal_module_trips_reset(module_tz);
 	/* Read module temperature and thresholds. */
@@ -756,7 +638,8 @@ mlxsw_thermal_gearbox_tz_init(struct mlxsw_thermal_module *gearbox_tz)
 	else
 		snprintf(tz_name, sizeof(tz_name), "mlxsw-gearbox%d",
 			 gearbox_tz->module + 1);
-	gearbox_tz->tzdev = thermal_zone_device_register(tz_name,
+	gearbox_tz->tzdev = thermal_zone_device_register_with_trips(tz_name,
+						gearbox_tz->trips,
 						MLXSW_THERMAL_NUM_TRIPS,
 						MLXSW_THERMAL_TRIP_MASK,
 						gearbox_tz,
@@ -813,6 +696,8 @@ mlxsw_thermal_gearboxes_init(struct device *dev, struct mlxsw_core *core,
 		gearbox_tz = &area->tz_gearbox_arr[i];
 		memcpy(gearbox_tz->trips, default_thermal_trips,
 		       sizeof(thermal->trips));
+		memcpy(gearbox_tz->cooling_states, default_cooling_states,
+		       sizeof(thermal->cooling_states));
 		gearbox_tz->module = i;
 		gearbox_tz->parent = thermal;
 		gearbox_tz->slot_index = area->slot_index;
@@ -928,6 +813,7 @@ int mlxsw_thermal_init(struct mlxsw_core *core,
 	thermal->core = core;
 	thermal->bus_info = bus_info;
 	memcpy(thermal->trips, default_thermal_trips, sizeof(thermal->trips));
+	memcpy(thermal->cooling_states, default_cooling_states, sizeof(thermal->cooling_states));
 	thermal->line_cards[0].slot_index = 0;
 
 	err = mlxsw_reg_query(thermal->core, MLXSW_REG(mfcr), mfcr_pl);
@@ -981,7 +867,8 @@ int mlxsw_thermal_init(struct mlxsw_core *core,
 				 MLXSW_THERMAL_SLOW_POLL_INT :
 				 MLXSW_THERMAL_POLL_INT;
 
-	thermal->tzdev = thermal_zone_device_register("mlxsw",
+	thermal->tzdev = thermal_zone_device_register_with_trips("mlxsw",
+						      thermal->trips,
 						      MLXSW_THERMAL_NUM_TRIPS,
 						      MLXSW_THERMAL_TRIP_MASK,
 						      thermal,
