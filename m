Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120A05FE99C
	for <lists+linux-pm@lfdr.de>; Fri, 14 Oct 2022 09:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJNHdR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Oct 2022 03:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiJNHdP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Oct 2022 03:33:15 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1985A1B8654
        for <linux-pm@vger.kernel.org>; Fri, 14 Oct 2022 00:33:14 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l32so2584599wms.2
        for <linux-pm@vger.kernel.org>; Fri, 14 Oct 2022 00:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lu7OnC5QoNnsZv1mkvWVBWm6k6o6Wf6fZ8wtEd3eTD4=;
        b=GsCGh/sCIBRCZOFrLbBdUst6l1jn0P59V3smFbobcddHSm0M2c1sTn5NADfRfX7WA+
         2D16i5Ypu/KgaLB6IjflJJWyfJpNciDnrJfTe0pBOrlCp/vCoKVoRHE0jjMhwHVXmoaM
         Ulhi9RxczthN9EcjyU015/0cPv3VB9YB7il3J24ISwRaE1NdNNCZev13B/Tp7FgGzMZM
         /O3NLHiO73GY0QqatVAquXeAJyYq99edsbD20MHBo4oLISWCZkK+tWNO2ocywMOWaVxr
         oze14cXbvgNo252fZ+nD9NLVGBpnZqEC+KWOEApAdNQcxbNUS7Whs58v5NlUWOOra/56
         nSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lu7OnC5QoNnsZv1mkvWVBWm6k6o6Wf6fZ8wtEd3eTD4=;
        b=DABDAu/HvYnrajugbQcmyDkE+J0E7D4Tl91QhhVukY0AhOdqEAp1Cerejzu69vhII9
         slLJxNDZmbk+Js4ksXTMpyncBvp1Hjjwz/R14rXURa8y/zH+hnY1HMjKkqZfcU2bQ7JG
         3CduKwcGeAUJJ9v0EEBsqFJignRyDPlhtawYjUhaw48Z0jrKpFT/iSVs3153T2PTLX4Z
         wz75jgvmyVBM/Svre3teWS+faHrdQd4onmB8O7lH0Mf6vPzgvZWWZqP58XXoN4r/bTxC
         CUCw2BgAhA/urHqbrRL/0awKfl801Cij5N2wMXA/wGueKdyJ6oHMCqrF/p7/jMpDkS+0
         wjPA==
X-Gm-Message-State: ACrzQf1cbf/mU35o6PMn2b82KkVwZlCWbQoA4unUL9qMeZ1Gsne4YSqX
        jr87MhXZQc5mzbbNmEt4d8843w==
X-Google-Smtp-Source: AMsMyM5WTYdBAgXXV9D24CSK0Vl+FrByu3trqXnVzaNiFNiRyGUnbw4GCxphi9Ob1cXKNHhjjS5U7w==
X-Received: by 2002:a05:600c:35c9:b0:3c6:de85:cd38 with SMTP id r9-20020a05600c35c900b003c6de85cd38mr5023235wmq.48.1665732792151;
        Fri, 14 Oct 2022 00:33:12 -0700 (PDT)
Received: from mai.. ([2a05:6e02:1041:c10:b460:17f0:186d:9d2e])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b003a682354f63sm898148wmo.11.2022.10.14.00.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 00:33:11 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org (open list:MELLANOX ETHERNET SWITCH DRIVERS)
Subject: [PATCH 2/2] thermal/drivers/mellanox: Use generic thermal_zone_get_trip() function
Date:   Fri, 14 Oct 2022 09:32:51 +0200
Message-Id: <20221014073253.3719911-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221014073253.3719911-1-daniel.lezcano@linaro.org>
References: <20221014073253.3719911-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../ethernet/mellanox/mlxsw/core_thermal.c    | 209 ++++--------------
 1 file changed, 48 insertions(+), 161 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index 987fe5c9d5a3..c5240d38c9db 100644
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
-- 
2.34.1

