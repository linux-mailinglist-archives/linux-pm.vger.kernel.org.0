Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483B1455292
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 03:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241558AbhKRCXM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 21:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242492AbhKRCXJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 21:23:09 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D89C061570
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:20:09 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bu18so18297442lfb.0
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RTCwYoReSIxdfChw8M+tf14CrRHRRZkyAoA8XAE749E=;
        b=uou9ALJJgDypTwJx+3lLWehttK8A4g3dB+wGd2dC2Q7qfuUpdGqhqShwBjT4u6tG1C
         TjNge4l1f1jVfFpgI3VhdGiHDdkBUh/pkqGExMl8yE80O9QUCAWarlR0psEF0lZZnNQ2
         zdaB+wclTZsyXXNJ0Yayqqkj4Mus1NIQgAAktuhDGKQH8tiu9ju70fiR/3nQhFwVs5u8
         ONZXdSMAP8WZYVtCBQ7O2+Tn+s/4mU/l28CnNxgbpDa6JIf2W2AtT6WKKDQCWOlML5Np
         MlC++ULv2SlQ7DiP7jf3OVqee3nSug703+bcr0hmHEOhnM+nItFf7xGe2gRcvo2mSufI
         kw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RTCwYoReSIxdfChw8M+tf14CrRHRRZkyAoA8XAE749E=;
        b=71H/rfwkS4oWKPehTbuKlRlTZ0kuTNYLVYlaO043otoUoGVU6dc36YRvpq6zBsSZ/p
         p0BK9EObXKd0k1l+4AR7dMpRGH/ASqQRZVB8cWRTbBc7cYBJCR7IsfWqQjsx6+tCFGH0
         Db+D2flRgk1mgtExoZlEEuu7l708UY+P2gy1Vs/SoLRclu+aP1Sp7zb2GgKXxijTTJ5b
         R0kelFtywMcFX1dOBIHNO14Ss5QgUCoqYnOQ3GDhozKbnGC+1uTdkcFN6Zpo01PtJFLS
         GlpACrZRFgsC9BJdYy8Avj2o78baaSRQA+xIxskuHGJvsAvcs1KPAItPm9N2HYSIXiz6
         2JWg==
X-Gm-Message-State: AOAM530qhHa5JWUZ+F6i3a90nWok1DMzllj/SM3mrjXd5NUYgjI7Nr2S
        B8wn77qIk4JzDMgxC5w8/ZPYXw==
X-Google-Smtp-Source: ABdhPJwb0ff86QKToEZgw8Yi50GgFqrKTDh2iO1Xjb+tLzfqdtZvUTJyFKQhqeppeXtgf9scgnt+Ng==
X-Received: by 2002:a2e:b4a6:: with SMTP id q6mr12665814ljm.7.1637202007984;
        Wed, 17 Nov 2021 18:20:07 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id j19sm165321lfe.120.2021.11.17.18.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 18:20:07 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 05/16] power: supply: ab8500: Use only one battery type
Date:   Thu, 18 Nov 2021 03:17:41 +0100
Message-Id: <20211118021752.2262818-6-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118021752.2262818-1-linus.walleij@linaro.org>
References: <20211118021752.2262818-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The code was going through hoops and loops to detect what
battery is connected and check the resistance for this battery
etc.

Skip this trouble: we will support one battery (currently
"unknown") then we will find the connected battery in the
device tree using a compatible string. The battery resistance
may be used to double-check that the right battery is
connected.

Convert the array of battery types into one battery type so
we can next move over the properties of this one type into
the standard struct power_supply_battery_info.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500-bm.h       |   4 -
 drivers/power/supply/ab8500_bmdata.c   | 203 ++++---------------------
 drivers/power/supply/ab8500_btemp.c    |  61 ++++----
 drivers/power/supply/ab8500_chargalg.c |  51 +++----
 drivers/power/supply/ab8500_fg.c       |  17 ++-
 5 files changed, 85 insertions(+), 251 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index 36bc28f1604f..9c96722f33d6 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -475,8 +475,6 @@ struct ab8500_bm_charger_parameters {
  * @enable_overshoot	flag to enable VBAT overshoot control
  * @auto_trig		flag to enable auto adc trigger
  * @fg_res		resistance of FG resistor in 0.1mOhm
- * @n_btypes		number of elements in array bat_type
- * @batt_id		index of the identified battery in array bat_type
  * @interval_charging	charge alg cycle period time when charging (sec)
  * @interval_not_charging charge alg cycle period time when not charging (sec)
  * @temp_hysteresis	temperature hysteresis
@@ -503,8 +501,6 @@ struct ab8500_bm_data {
 	bool auto_trig;
 	enum ab8500_adc_therm adc_therm;
 	int fg_res;
-	int n_btypes;
-	int batt_id;
 	int interval_charging;
 	int interval_not_charging;
 	int temp_hysteresis;
diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index bd651602fd69..17c9b8700883 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -16,94 +16,6 @@
 /* Default: temperature hysteresis */
 #define AB8500_TEMP_HYSTERESIS	3
 
-/*
- * These are the defined batteries that uses a NTC and ID resistor placed
- * inside of the battery pack.
- * Note that the res_to_temp table must be strictly sorted by falling resistance
- * values to work.
- */
-const struct ab8500_res_to_temp ab8500_temp_tbl_a_thermistor[] = {
-	{-5, 53407},
-	{ 0, 48594},
-	{ 5, 43804},
-	{10, 39188},
-	{15, 34870},
-	{20, 30933},
-	{25, 27422},
-	{30, 24347},
-	{35, 21694},
-	{40, 19431},
-	{45, 17517},
-	{50, 15908},
-	{55, 14561},
-	{60, 13437},
-	{65, 12500},
-};
-
-const struct ab8500_res_to_temp ab8500_temp_tbl_b_thermistor[] = {
-	{-5, 200000},
-	{ 0, 159024},
-	{ 5, 151921},
-	{10, 144300},
-	{15, 136424},
-	{20, 128565},
-	{25, 120978},
-	{30, 113875},
-	{35, 107397},
-	{40, 101629},
-	{45,  96592},
-	{50,  92253},
-	{55,  88569},
-	{60,  85461},
-	{65,  82869},
-};
-
-static const struct ab8500_v_to_cap cap_tbl_a_thermistor[] = {
-	{4171,	100},
-	{4114,	 95},
-	{4009,	 83},
-	{3947,	 74},
-	{3907,	 67},
-	{3863,	 59},
-	{3830,	 56},
-	{3813,	 53},
-	{3791,	 46},
-	{3771,	 33},
-	{3754,	 25},
-	{3735,	 20},
-	{3717,	 17},
-	{3681,	 13},
-	{3664,	  8},
-	{3651,	  6},
-	{3635,	  5},
-	{3560,	  3},
-	{3408,    1},
-	{3247,	  0},
-};
-
-static const struct ab8500_v_to_cap cap_tbl_b_thermistor[] = {
-	{4161,	100},
-	{4124,	 98},
-	{4044,	 90},
-	{4003,	 85},
-	{3966,	 80},
-	{3933,	 75},
-	{3888,	 67},
-	{3849,	 60},
-	{3813,	 55},
-	{3787,	 47},
-	{3772,	 30},
-	{3751,	 25},
-	{3718,	 20},
-	{3681,	 16},
-	{3660,	 14},
-	{3589,	 10},
-	{3546,	  7},
-	{3495,	  4},
-	{3404,	  2},
-	{3250,	  0},
-};
-
 static const struct ab8500_v_to_cap cap_tbl[] = {
 	{4186,	100},
 	{4163,	 99},
@@ -167,90 +79,33 @@ static const struct batres_vs_temp temp_to_batres_tbl_thermistor[] = {
 	{-20, 595},
 };
 
-static struct ab8500_battery_type bat_type_thermistor[] = {
-	[BATTERY_UNKNOWN] = {
-		/* First element always represent the UNKNOWN battery */
-		.name = POWER_SUPPLY_TECHNOLOGY_UNKNOWN,
-		.resis_high = 0,
-		.resis_low = 0,
-		.battery_resistance = 300,
-		.charge_full_design = 612,
-		.nominal_voltage = 3700,
-		.termination_vol = 4050,
-		.termination_curr = 200,
-		.recharge_cap = 95,
-		.normal_cur_lvl = 400,
-		.normal_vol_lvl = 4100,
-		.maint_a_cur_lvl = 400,
-		.maint_a_vol_lvl = 4050,
-		.maint_a_chg_timer_h = 60,
-		.maint_b_cur_lvl = 400,
-		.maint_b_vol_lvl = 4000,
-		.maint_b_chg_timer_h = 200,
-		.low_high_cur_lvl = 300,
-		.low_high_vol_lvl = 4000,
-		.n_temp_tbl_elements = ARRAY_SIZE(temp_tbl),
-		.r_to_t_tbl = temp_tbl,
-		.n_v_cap_tbl_elements = ARRAY_SIZE(cap_tbl),
-		.v_to_cap_tbl = cap_tbl,
-		.n_batres_tbl_elements = ARRAY_SIZE(temp_to_batres_tbl_thermistor),
-		.batres_tbl = temp_to_batres_tbl_thermistor,
-	},
-	{
-		.name = POWER_SUPPLY_TECHNOLOGY_LIPO,
-		.resis_high = 53407,
-		.resis_low = 12500,
-		.battery_resistance = 300,
-		.charge_full_design = 900,
-		.nominal_voltage = 3600,
-		.termination_vol = 4150,
-		.termination_curr = 80,
-		.recharge_cap = 95,
-		.normal_cur_lvl = 700,
-		.normal_vol_lvl = 4200,
-		.maint_a_cur_lvl = 600,
-		.maint_a_vol_lvl = 4150,
-		.maint_a_chg_timer_h = 60,
-		.maint_b_cur_lvl = 600,
-		.maint_b_vol_lvl = 4100,
-		.maint_b_chg_timer_h = 200,
-		.low_high_cur_lvl = 300,
-		.low_high_vol_lvl = 4000,
-		.n_temp_tbl_elements = ARRAY_SIZE(ab8500_temp_tbl_a_thermistor),
-		.r_to_t_tbl = ab8500_temp_tbl_a_thermistor,
-		.n_v_cap_tbl_elements = ARRAY_SIZE(cap_tbl_a_thermistor),
-		.v_to_cap_tbl = cap_tbl_a_thermistor,
-		.n_batres_tbl_elements = ARRAY_SIZE(temp_to_batres_tbl_thermistor),
-		.batres_tbl = temp_to_batres_tbl_thermistor,
-
-	},
-	{
-		.name = POWER_SUPPLY_TECHNOLOGY_LIPO,
-		.resis_high = 200000,
-		.resis_low = 82869,
-		.battery_resistance = 300,
-		.charge_full_design = 900,
-		.nominal_voltage = 3600,
-		.termination_vol = 4150,
-		.termination_curr = 80,
-		.recharge_cap = 95,
-		.normal_cur_lvl = 700,
-		.normal_vol_lvl = 4200,
-		.maint_a_cur_lvl = 600,
-		.maint_a_vol_lvl = 4150,
-		.maint_a_chg_timer_h = 60,
-		.maint_b_cur_lvl = 600,
-		.maint_b_vol_lvl = 4100,
-		.maint_b_chg_timer_h = 200,
-		.low_high_cur_lvl = 300,
-		.low_high_vol_lvl = 4000,
-		.n_temp_tbl_elements = ARRAY_SIZE(ab8500_temp_tbl_b_thermistor),
-		.r_to_t_tbl = ab8500_temp_tbl_b_thermistor,
-		.n_v_cap_tbl_elements = ARRAY_SIZE(cap_tbl_b_thermistor),
-		.v_to_cap_tbl = cap_tbl_b_thermistor,
-		.n_batres_tbl_elements = ARRAY_SIZE(temp_to_batres_tbl_thermistor),
-		.batres_tbl = temp_to_batres_tbl_thermistor,
-	},
+/* Default battery type for reference designs is the unknown type */
+static struct ab8500_battery_type bat_type_thermistor_unknown = {
+	.name = POWER_SUPPLY_TECHNOLOGY_UNKNOWN,
+	.resis_high = 0,
+	.resis_low = 0,
+	.battery_resistance = 300,
+	.charge_full_design = 612,
+	.nominal_voltage = 3700,
+	.termination_vol = 4050,
+	.termination_curr = 200,
+	.recharge_cap = 95,
+	.normal_cur_lvl = 400,
+	.normal_vol_lvl = 4100,
+	.maint_a_cur_lvl = 400,
+	.maint_a_vol_lvl = 4050,
+	.maint_a_chg_timer_h = 60,
+	.maint_b_cur_lvl = 400,
+	.maint_b_vol_lvl = 4000,
+	.maint_b_chg_timer_h = 200,
+	.low_high_cur_lvl = 300,
+	.low_high_vol_lvl = 4000,
+	.n_temp_tbl_elements = ARRAY_SIZE(temp_tbl),
+	.r_to_t_tbl = temp_tbl,
+	.n_v_cap_tbl_elements = ARRAY_SIZE(cap_tbl),
+	.v_to_cap_tbl = cap_tbl,
+	.n_batres_tbl_elements = ARRAY_SIZE(temp_to_batres_tbl_thermistor),
+	.batres_tbl = temp_to_batres_tbl_thermistor,
 };
 
 static const struct ab8500_bm_capacity_levels cap_levels = {
@@ -312,9 +167,7 @@ struct ab8500_bm_data ab8500_bm_data = {
 	.enable_overshoot       = false,
 	.fg_res                 = 100,
 	.cap_levels             = &cap_levels,
-	.bat_type               = bat_type_thermistor,
-	.n_btypes               = ARRAY_SIZE(bat_type_thermistor),
-	.batt_id                = 0,
+	.bat_type               = &bat_type_thermistor_unknown,
 	.interval_charging      = 5,
 	.interval_not_charging  = 120,
 	.gnd_lift_resistance    = 34,
diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index b6c9111d77d7..fbb58074efab 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -454,12 +454,9 @@ static int ab8500_btemp_measure_temp(struct ab8500_btemp *di)
 	int temp, ret;
 	static int prev;
 	int rbat, rntc, vntc;
-	u8 id;
 
-	id = di->bm->batt_id;
-
-	if (di->bm->adc_therm == AB8500_ADC_THERM_BATCTRL &&
-			id != BATTERY_UNKNOWN) {
+	if ((di->bm->adc_therm == AB8500_ADC_THERM_BATCTRL) &&
+	    (di->bm->bat_type->name == POWER_SUPPLY_TECHNOLOGY_UNKNOWN)) {
 
 		rbat = ab8500_btemp_get_batctrl_res(di);
 		if (rbat < 0) {
@@ -473,8 +470,8 @@ static int ab8500_btemp_measure_temp(struct ab8500_btemp *di)
 		}
 
 		temp = ab8500_btemp_res_to_temp(di,
-			di->bm->bat_type[id].r_to_t_tbl,
-			di->bm->bat_type[id].n_temp_tbl_elements, rbat);
+			di->bm->bat_type->r_to_t_tbl,
+			di->bm->bat_type->n_temp_tbl_elements, rbat);
 	} else {
 		ret = iio_read_channel_processed(di->btemp_ball, &vntc);
 		if (ret < 0) {
@@ -490,8 +487,8 @@ static int ab8500_btemp_measure_temp(struct ab8500_btemp *di)
 		rntc = 230000 * vntc / (VTVOUT_V - vntc);
 
 		temp = ab8500_btemp_res_to_temp(di,
-			di->bm->bat_type[id].r_to_t_tbl,
-			di->bm->bat_type[id].n_temp_tbl_elements, rntc);
+			di->bm->bat_type->r_to_t_tbl,
+			di->bm->bat_type->n_temp_tbl_elements, rntc);
 		prev = temp;
 	}
 	dev_dbg(di->dev, "Battery temperature is %d\n", temp);
@@ -512,7 +509,6 @@ static int ab8500_btemp_id(struct ab8500_btemp *di)
 	u8 i;
 
 	di->curr_source = BTEMP_BATCTRL_CURR_SRC_7UA;
-	di->bm->batt_id = BATTERY_UNKNOWN;
 
 	res =  ab8500_btemp_get_batctrl_res(di);
 	if (res < 0) {
@@ -520,40 +516,37 @@ static int ab8500_btemp_id(struct ab8500_btemp *di)
 		return -ENXIO;
 	}
 
-	/* BATTERY_UNKNOWN is defined on position 0, skip it! */
-	for (i = BATTERY_UNKNOWN + 1; i < di->bm->n_btypes; i++) {
-		if ((res <= di->bm->bat_type[i].resis_high) &&
-			(res >= di->bm->bat_type[i].resis_low)) {
-			dev_dbg(di->dev, "Battery detected on %s"
-				" low %d < res %d < high: %d"
-				" index: %d\n",
-				di->bm->adc_therm == AB8500_ADC_THERM_BATCTRL ?
-				"BATCTRL" : "BATTEMP",
-				di->bm->bat_type[i].resis_low, res,
-				di->bm->bat_type[i].resis_high, i);
-
-			di->bm->batt_id = i;
-			break;
-		}
-	}
-
-	if (di->bm->batt_id == BATTERY_UNKNOWN) {
+	if ((res <= di->bm->bat_type->resis_high) &&
+	    (res >= di->bm->bat_type->resis_low)) {
+		dev_info(di->dev, "Battery detected on %s"
+			 " low %d < res %d < high: %d"
+			 " index: %d\n",
+			 di->bm->adc_therm == AB8500_ADC_THERM_BATCTRL ?
+			 "BATCTRL" : "BATTEMP",
+			 di->bm->bat_type->resis_low, res,
+			 di->bm->bat_type->resis_high, i);
+	} else {
 		dev_warn(di->dev, "Battery identified as unknown"
-			", resistance %d Ohm\n", res);
+			 ", resistance %d Ohm\n", res);
 		return -ENXIO;
 	}
 
 	/*
 	 * We only have to change current source if the
-	 * detected type is Type 1.
+	 * detected type is Type 1 (LIPO) resis_high = 53407, resis_low = 12500
+	 * if someone hacks this in.
+	 *
+	 * FIXME: make sure this is done automatically for the batteries
+	 * that need it.
 	 */
-	if (di->bm->adc_therm == AB8500_ADC_THERM_BATCTRL &&
-	    di->bm->batt_id == 1) {
+	if ((di->bm->adc_therm == AB8500_ADC_THERM_BATCTRL) &&
+	    (di->bm->bat_type->name == POWER_SUPPLY_TECHNOLOGY_LIPO) &&
+	    (res <= 53407) && (res >= 12500)) {
 		dev_dbg(di->dev, "Set BATCTRL current source to 20uA\n");
 		di->curr_source = BTEMP_BATCTRL_CURR_SRC_20UA;
 	}
 
-	return di->bm->batt_id;
+	return 0;
 }
 
 /**
@@ -814,7 +807,7 @@ static int ab8500_btemp_get_property(struct power_supply *psy,
 			val->intval = 1;
 		break;
 	case POWER_SUPPLY_PROP_TECHNOLOGY:
-		val->intval = di->bm->bat_type[di->bm->batt_id].name;
+		val->intval = di->bm->bat_type->name;
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
 		val->intval = ab8500_btemp_get_temp(di);
diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index 9196434393e8..a5ccfb0aa9f4 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -356,13 +356,13 @@ static int ab8500_chargalg_check_charger_enable(struct ab8500_chargalg *di)
 
 	if (di->chg_info.charger_type & USB_CHG) {
 		return di->usb_chg->ops.check_enable(di->usb_chg,
-			di->bm->bat_type[di->bm->batt_id].normal_vol_lvl,
-			di->bm->bat_type[di->bm->batt_id].normal_cur_lvl);
+			di->bm->bat_type->normal_vol_lvl,
+			di->bm->bat_type->normal_cur_lvl);
 	} else if ((di->chg_info.charger_type & AC_CHG) &&
 		   !(di->ac_chg->external)) {
 		return di->ac_chg->ops.check_enable(di->ac_chg,
-			di->bm->bat_type[di->bm->batt_id].normal_vol_lvl,
-			di->bm->bat_type[di->bm->batt_id].normal_cur_lvl);
+			di->bm->bat_type->normal_vol_lvl,
+			di->bm->bat_type->normal_cur_lvl);
 	}
 	return 0;
 }
@@ -793,10 +793,10 @@ static void ab8500_chargalg_end_of_charge(struct ab8500_chargalg *di)
 	if (di->charge_status == POWER_SUPPLY_STATUS_CHARGING &&
 		di->charge_state == STATE_NORMAL &&
 		!di->maintenance_chg && (di->batt_data.volt >=
-		di->bm->bat_type[di->bm->batt_id].termination_vol ||
+		di->bm->bat_type->termination_vol ||
 		di->events.usb_cv_active || di->events.ac_cv_active) &&
 		di->batt_data.avg_curr <
-		di->bm->bat_type[di->bm->batt_id].termination_curr &&
+		di->bm->bat_type->termination_curr &&
 		di->batt_data.avg_curr > 0) {
 		if (++di->eoc_cnt >= EOC_COND_CNT) {
 			di->eoc_cnt = 0;
@@ -819,9 +819,9 @@ static void ab8500_chargalg_end_of_charge(struct ab8500_chargalg *di)
 static void init_maxim_chg_curr(struct ab8500_chargalg *di)
 {
 	di->ccm.original_iset =
-		di->bm->bat_type[di->bm->batt_id].normal_cur_lvl;
+		di->bm->bat_type->normal_cur_lvl;
 	di->ccm.current_iset =
-		di->bm->bat_type[di->bm->batt_id].normal_cur_lvl;
+		di->bm->bat_type->normal_cur_lvl;
 	di->ccm.test_delta_i = di->bm->maxi->charger_curr_step;
 	di->ccm.max_current = di->bm->maxi->chg_curr;
 	di->ccm.condition_cnt = di->bm->maxi->wait_cycles;
@@ -924,7 +924,7 @@ static void handle_maxim_chg_curr(struct ab8500_chargalg *di)
 		break;
 	case MAXIM_RET_IBAT_TOO_HIGH:
 		result = ab8500_chargalg_update_chg_curr(di,
-			di->bm->bat_type[di->bm->batt_id].normal_cur_lvl);
+			di->bm->bat_type->normal_cur_lvl);
 		if (result)
 			dev_err(di->dev, "failed to set chg curr\n");
 		break;
@@ -1505,13 +1505,12 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 		if (di->curr_status.curr_step == CHARGALG_CURR_STEP_LOW)
 			ab8500_chargalg_stop_charging(di);
 		else {
-			curr_step_lvl = di->bm->bat_type[
-				di->bm->batt_id].normal_cur_lvl
+			curr_step_lvl = di->bm->bat_type->normal_cur_lvl
 				* di->curr_status.curr_step
 				/ CHARGALG_CURR_STEP_HIGH;
 			ab8500_chargalg_start_charging(di,
-				di->bm->bat_type[di->bm->batt_id]
-				.normal_vol_lvl, curr_step_lvl);
+				di->bm->bat_type->normal_vol_lvl,
+				curr_step_lvl);
 		}
 
 		ab8500_chargalg_state_to(di, STATE_NORMAL);
@@ -1546,20 +1545,17 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 
 	case STATE_WAIT_FOR_RECHARGE:
 		if (di->batt_data.percent <=
-		    di->bm->bat_type[di->bm->batt_id].recharge_cap)
+		    di->bm->bat_type->recharge_cap)
 			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
 		break;
 
 	case STATE_MAINTENANCE_A_INIT:
 		ab8500_chargalg_stop_safety_timer(di);
 		ab8500_chargalg_start_maintenance_timer(di,
-			di->bm->bat_type[
-				di->bm->batt_id].maint_a_chg_timer_h);
+			di->bm->bat_type->maint_a_chg_timer_h);
 		ab8500_chargalg_start_charging(di,
-			di->bm->bat_type[
-				di->bm->batt_id].maint_a_vol_lvl,
-			di->bm->bat_type[
-				di->bm->batt_id].maint_a_cur_lvl);
+			di->bm->bat_type->maint_a_vol_lvl,
+			di->bm->bat_type->maint_a_cur_lvl);
 		ab8500_chargalg_state_to(di, STATE_MAINTENANCE_A);
 		power_supply_changed(di->chargalg_psy);
 		fallthrough;
@@ -1573,13 +1569,10 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 
 	case STATE_MAINTENANCE_B_INIT:
 		ab8500_chargalg_start_maintenance_timer(di,
-			di->bm->bat_type[
-				di->bm->batt_id].maint_b_chg_timer_h);
+			di->bm->bat_type->maint_b_chg_timer_h);
 		ab8500_chargalg_start_charging(di,
-			di->bm->bat_type[
-				di->bm->batt_id].maint_b_vol_lvl,
-			di->bm->bat_type[
-				di->bm->batt_id].maint_b_cur_lvl);
+			di->bm->bat_type->maint_b_vol_lvl,
+			di->bm->bat_type->maint_b_cur_lvl);
 		ab8500_chargalg_state_to(di, STATE_MAINTENANCE_B);
 		power_supply_changed(di->chargalg_psy);
 		fallthrough;
@@ -1593,10 +1586,8 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 
 	case STATE_TEMP_LOWHIGH_INIT:
 		ab8500_chargalg_start_charging(di,
-			di->bm->bat_type[
-				di->bm->batt_id].low_high_vol_lvl,
-			di->bm->bat_type[
-				di->bm->batt_id].low_high_cur_lvl);
+			di->bm->bat_type->low_high_vol_lvl,
+			di->bm->bat_type->low_high_cur_lvl);
 		ab8500_chargalg_stop_maintenance_timer(di);
 		di->charge_status = POWER_SUPPLY_STATUS_CHARGING;
 		ab8500_chargalg_state_to(di, STATE_TEMP_LOWHIGH);
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 05fe9724ba50..2013db0118ee 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -857,8 +857,8 @@ static int ab8500_fg_volt_to_capacity(struct ab8500_fg *di, int voltage)
 	const struct ab8500_v_to_cap *tbl;
 	int cap = 0;
 
-	tbl = di->bm->bat_type[di->bm->batt_id].v_to_cap_tbl;
-	tbl_size = di->bm->bat_type[di->bm->batt_id].n_v_cap_tbl_elements;
+	tbl = di->bm->bat_type->v_to_cap_tbl;
+	tbl_size = di->bm->bat_type->n_v_cap_tbl_elements;
 
 	for (i = 0; i < tbl_size; ++i) {
 		if (voltage > tbl[i].voltage)
@@ -910,8 +910,8 @@ static int ab8500_fg_battery_resistance(struct ab8500_fg *di)
 	const struct batres_vs_temp *tbl;
 	int resist = 0;
 
-	tbl = di->bm->bat_type[di->bm->batt_id].batres_tbl;
-	tbl_size = di->bm->bat_type[di->bm->batt_id].n_batres_tbl_elements;
+	tbl = di->bm->bat_type->batres_tbl;
+	tbl_size = di->bm->bat_type->n_batres_tbl_elements;
 
 	for (i = 0; i < tbl_size; ++i) {
 		if (di->bat_temp / 10 > tbl[i].temp)
@@ -2234,10 +2234,11 @@ static int ab8500_fg_get_ext_psy_data(struct device *dev, void *data)
 			switch (ext->desc->type) {
 			case POWER_SUPPLY_TYPE_BATTERY:
 				if (!di->flags.batt_id_received &&
-				    di->bm->batt_id != BATTERY_UNKNOWN) {
+				    (di->bm->bat_type->name !=
+				     POWER_SUPPLY_TECHNOLOGY_UNKNOWN)) {
 					const struct ab8500_battery_type *b;
 
-					b = &(di->bm->bat_type[di->bm->batt_id]);
+					b = di->bm->bat_type;
 
 					di->flags.batt_id_received = true;
 
@@ -3078,11 +3079,11 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	psy_cfg.drv_data = di;
 
 	di->bat_cap.max_mah_design = MILLI_TO_MICRO *
-		di->bm->bat_type[di->bm->batt_id].charge_full_design;
+		di->bm->bat_type->charge_full_design;
 
 	di->bat_cap.max_mah = di->bat_cap.max_mah_design;
 
-	di->vbat_nom = di->bm->bat_type[di->bm->batt_id].nominal_voltage;
+	di->vbat_nom = di->bm->bat_type->nominal_voltage;
 
 	di->init_capacity = true;
 
-- 
2.31.1

