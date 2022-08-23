Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5215459E702
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 18:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244639AbiHWQWa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 12:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244650AbiHWQWC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 12:22:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091D7333D74
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 05:42:40 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:42:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661258558;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3KK1L5CoiujgW7FRP+H5PVkW4nCiNtLxCeiyyDWKDys=;
        b=SWMJjgj5+mFzDegSTD1FglHw5lBscWwGXKfhqpo1e3xfN7NDRx1vhtDpkDpV3eR1bshQS0
        1LjhHoHHgS+izgaG/9FGlR6w8SM6y4yvVs9i9Di/QZwoIPRj5uvgpIBEbY84VCYXtl9VPY
        nSzf69DGNoR99a6k0sxTRAl1TbqC6jMMt6ZQyo5Td9X2ov6ZyRmlEqBr9Qpqrf8PzLWtw5
        T9cwH8PPRbUEpbOIUpkE0/e6e/hrf56Z6UPfRm3NCsA0uTYlxVKJ8OzRkHHayCCOCmuzcm
        hDt+wlhlUDtuuXrSgUaVCOU/FFfoB32quAJH2TXBXE+kF4mLUuxNpnLkaCspMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661258558;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3KK1L5CoiujgW7FRP+H5PVkW4nCiNtLxCeiyyDWKDys=;
        b=wYRbiIeybR0otTLBSuMw0V4TFVt/01YquUep7zQeajjHatr9IJ5HIdBZiyyAjA2iIKA/fn
        pxc5evZgJz2GaLDQ==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] Revert "mlxsw: core: Add the hottest thermal
 zone detection"
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20220817153040.2464245-1-daniel.lezcano@linaro.org>
References: <20220817153040.2464245-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <166125855725.401.3474590525627956835.tip-bot2@tip-bot2>
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

Commit-ID:     06f36055121769b9eb9b7d28c7499d1cc8269dc3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//06f36055121769b9eb9b7d28c7499d1cc8269dc3
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Wed, 17 Aug 2022 17:30:40 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 17 Aug 2022 20:32:27 +02:00

Revert "mlxsw: core: Add the hottest thermal zone detection"

This reverts commit 2dc2f760052da4925482ecdcdc5c94d4a599153c and
commit 6f73862fabd93213de157d9cc6ef76084311c628.

As discussed in the thread:

https://lore.kernel.org/all/f3c62ebe-7d59-c537-a010-bff366c8aeba@linaro.org/

the feature provided by commits 2dc2f760052da and 6f73862fabd93 is
actually already handled by the thermal framework via the cooling
device state aggregation, thus all this code is pointless.

The revert conflicts with the following changes:
 - 7f4957be0d5b8: thermal: Use mode helpers in drivers
 - 6a79507cfe94c: mlxsw: core: Extend thermal module with per QSFP module thermal zones

These conflicts were fixed and the resulting changes are in this patch.

Both reverts are in the same change as requested by Ido Schimmel:

https://lore.kernel.org/all/Yvz7+RUsmVco3Xpj@shredder/

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Vadim Pasternak <vadimp@nvidia.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/r/20220817153040.2464245-1-daniel.lezcano@linaro.org
---
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c | 77 +-------------
 1 file changed, 2 insertions(+), 75 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index 3548fe1..987fe5c 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -21,7 +21,6 @@
 #define MLXSW_THERMAL_ASIC_TEMP_HOT	105000	/* 105C */
 #define MLXSW_THERMAL_HYSTERESIS_TEMP	5000	/* 5C */
 #define MLXSW_THERMAL_MODULE_TEMP_SHIFT	(MLXSW_THERMAL_HYSTERESIS_TEMP * 2)
-#define MLXSW_THERMAL_TEMP_SCORE_MAX	GENMASK(31, 0)
 #define MLXSW_THERMAL_MAX_STATE	10
 #define MLXSW_THERMAL_MIN_STATE	2
 #define MLXSW_THERMAL_MAX_DUTY	255
@@ -101,8 +100,6 @@ struct mlxsw_thermal {
 	struct thermal_cooling_device *cdevs[MLXSW_MFCR_PWMS_MAX];
 	u8 cooling_levels[MLXSW_THERMAL_MAX_STATE + 1];
 	struct mlxsw_thermal_trip trips[MLXSW_THERMAL_NUM_TRIPS];
-	unsigned int tz_highest_score;
-	struct thermal_zone_device *tz_highest_dev;
 	struct mlxsw_thermal_area line_cards[];
 };
 
@@ -193,34 +190,6 @@ mlxsw_thermal_module_trips_update(struct device *dev, struct mlxsw_core *core,
 	return 0;
 }
 
-static void mlxsw_thermal_tz_score_update(struct mlxsw_thermal *thermal,
-					  struct thermal_zone_device *tzdev,
-					  struct mlxsw_thermal_trip *trips,
-					  int temp)
-{
-	struct mlxsw_thermal_trip *trip = trips;
-	unsigned int score, delta, i, shift = 1;
-
-	/* Calculate thermal zone score, if temperature is above the hot
-	 * threshold score is set to MLXSW_THERMAL_TEMP_SCORE_MAX.
-	 */
-	score = MLXSW_THERMAL_TEMP_SCORE_MAX;
-	for (i = MLXSW_THERMAL_TEMP_TRIP_NORM; i < MLXSW_THERMAL_NUM_TRIPS;
-	     i++, trip++) {
-		if (temp < trip->temp) {
-			delta = DIV_ROUND_CLOSEST(temp, trip->temp - temp);
-			score = delta * shift;
-			break;
-		}
-		shift *= 256;
-	}
-
-	if (score > thermal->tz_highest_score) {
-		thermal->tz_highest_score = score;
-		thermal->tz_highest_dev = tzdev;
-	}
-}
-
 static int mlxsw_thermal_bind(struct thermal_zone_device *tzdev,
 			      struct thermal_cooling_device *cdev)
 {
@@ -286,9 +255,6 @@ static int mlxsw_thermal_get_temp(struct thermal_zone_device *tzdev,
 		return err;
 	}
 	mlxsw_reg_mtmp_unpack(mtmp_pl, &temp, NULL, NULL, NULL, NULL);
-	if (temp > 0)
-		mlxsw_thermal_tz_score_update(thermal, tzdev, thermal->trips,
-					      temp);
 
 	*p_temp = temp;
 	return 0;
@@ -349,21 +315,6 @@ static int mlxsw_thermal_set_trip_hyst(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
-static int mlxsw_thermal_trend_get(struct thermal_zone_device *tzdev,
-				   int trip, enum thermal_trend *trend)
-{
-	struct mlxsw_thermal *thermal = tzdev->devdata;
-
-	if (trip < 0 || trip >= MLXSW_THERMAL_NUM_TRIPS)
-		return -EINVAL;
-
-	if (tzdev == thermal->tz_highest_dev)
-		return 1;
-
-	*trend = THERMAL_TREND_STABLE;
-	return 0;
-}
-
 static struct thermal_zone_params mlxsw_thermal_params = {
 	.no_hwmon = true,
 };
@@ -377,7 +328,6 @@ static struct thermal_zone_device_ops mlxsw_thermal_ops = {
 	.set_trip_temp	= mlxsw_thermal_set_trip_temp,
 	.get_trip_hyst	= mlxsw_thermal_get_trip_hyst,
 	.set_trip_hyst	= mlxsw_thermal_set_trip_hyst,
-	.get_trend	= mlxsw_thermal_trend_get,
 };
 
 static int mlxsw_thermal_module_bind(struct thermal_zone_device *tzdev,
@@ -463,7 +413,6 @@ static int mlxsw_thermal_module_temp_get(struct thermal_zone_device *tzdev,
 	int temp, crit_temp, emerg_temp;
 	struct device *dev;
 	u16 sensor_index;
-	int err;
 
 	dev = thermal->bus_info->dev;
 	sensor_index = MLXSW_REG_MTMP_MODULE_INDEX_MIN + tz->module;
@@ -479,10 +428,8 @@ static int mlxsw_thermal_module_temp_get(struct thermal_zone_device *tzdev,
 		return 0;
 
 	/* Update trip points. */
-	err = mlxsw_thermal_module_trips_update(dev, thermal->core, tz,
-						crit_temp, emerg_temp);
-	if (!err && temp > 0)
-		mlxsw_thermal_tz_score_update(thermal, tzdev, tz->trips, temp);
+	mlxsw_thermal_module_trips_update(dev, thermal->core, tz,
+					  crit_temp, emerg_temp);
 
 	return 0;
 }
@@ -546,22 +493,6 @@ mlxsw_thermal_module_trip_hyst_set(struct thermal_zone_device *tzdev, int trip,
 	return 0;
 }
 
-static int mlxsw_thermal_module_trend_get(struct thermal_zone_device *tzdev,
-					  int trip, enum thermal_trend *trend)
-{
-	struct mlxsw_thermal_module *tz = tzdev->devdata;
-	struct mlxsw_thermal *thermal = tz->parent;
-
-	if (trip < 0 || trip >= MLXSW_THERMAL_NUM_TRIPS)
-		return -EINVAL;
-
-	if (tzdev == thermal->tz_highest_dev)
-		return 1;
-
-	*trend = THERMAL_TREND_STABLE;
-	return 0;
-}
-
 static struct thermal_zone_device_ops mlxsw_thermal_module_ops = {
 	.bind		= mlxsw_thermal_module_bind,
 	.unbind		= mlxsw_thermal_module_unbind,
@@ -571,7 +502,6 @@ static struct thermal_zone_device_ops mlxsw_thermal_module_ops = {
 	.set_trip_temp	= mlxsw_thermal_module_trip_temp_set,
 	.get_trip_hyst	= mlxsw_thermal_module_trip_hyst_get,
 	.set_trip_hyst	= mlxsw_thermal_module_trip_hyst_set,
-	.get_trend	= mlxsw_thermal_module_trend_get,
 };
 
 static int mlxsw_thermal_gearbox_temp_get(struct thermal_zone_device *tzdev,
@@ -592,8 +522,6 @@ static int mlxsw_thermal_gearbox_temp_get(struct thermal_zone_device *tzdev,
 		return err;
 
 	mlxsw_reg_mtmp_unpack(mtmp_pl, &temp, NULL, NULL, NULL, NULL);
-	if (temp > 0)
-		mlxsw_thermal_tz_score_update(thermal, tzdev, tz->trips, temp);
 
 	*p_temp = temp;
 	return 0;
@@ -608,7 +536,6 @@ static struct thermal_zone_device_ops mlxsw_thermal_gearbox_ops = {
 	.set_trip_temp	= mlxsw_thermal_module_trip_temp_set,
 	.get_trip_hyst	= mlxsw_thermal_module_trip_hyst_get,
 	.set_trip_hyst	= mlxsw_thermal_module_trip_hyst_set,
-	.get_trend	= mlxsw_thermal_module_trend_get,
 };
 
 static int mlxsw_thermal_get_max_state(struct thermal_cooling_device *cdev,
