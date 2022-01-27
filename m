Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6723949D75E
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jan 2022 02:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbiA0BOy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jan 2022 20:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiA0BOy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jan 2022 20:14:54 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B736BC06161C
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 17:14:53 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id j14so2020408lja.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 17:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FHqs4T2rMtDB+Y+pEEDFoSETpDqVbGr13PTAvmfS35Q=;
        b=XxXOsbWao60A2+uc6rC667EvAF/Px3ZiXRQSVnGpaex6R7M1tTGO+Zw35lyviLv81c
         SOP1O0w53SIQLCwC5Idu+HKPBGG7B+SA4xrVxDga6a/BssYSCYpzgD2sL5DKvf/p2JAB
         0BeKb1ABaPD1qgK4SLPaDGGxwbPkDrBEJINHDjqsoxmzxys2Xmzqf5EobtKCHQtRlVsf
         6mimjVp20phIXyeInLXDHGkauVJz2FIX4yCdSwwdXtRqwZUwRuA6z+S/EmtU4TzRHYL8
         qK0o7zK2DFS79xK29UyV+dyBKoF+fV3vgOIr1TG8EK4YaqB+AZaKlPA5SYbprjRS2jj+
         94ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FHqs4T2rMtDB+Y+pEEDFoSETpDqVbGr13PTAvmfS35Q=;
        b=pmYXfU+MzPPFRk5lPRdfgol+B94Z9FOLvkkgByCtAuhjJ2LqOVGtssBlA+GHVHyEeK
         om5X0+pMs0mDI0oQWUknSn/v+t0j6985p88DRYsy9vphhXoO7eb4NEaMAVgmAd0kX9ji
         rvrdDl7s+/BoiWDgeqh9hC/c3jiwsgkXmSwOvEF6wjWRXWYqBSjMpmbbe48QM00OCQDc
         Su5Xn6aQA6WaHoDhIRhDTpNCzAGJx1b/HLLneHYRBfqdoU8JlrhIMxL+DtKi0Rl9GoYX
         TFxwtaj0G7eyJEznvJc6Z+n5DN3DCvRvsF0q4T2xanGjFgl4cAIIp/UIoo/mF0qgg9xN
         Ukfw==
X-Gm-Message-State: AOAM530L2JyVXltkaTJ4PSNS/5FkJJW+Stb/H80JbRGrTJK9m1ZaJKoq
        RHCFWoD4bRptzq9DIJRcQ3pAdw==
X-Google-Smtp-Source: ABdhPJxa8O6ThfFwp7xhgfrFgYJJBCpRiR2i0VVkpBOTxnd6eVBMMSgQmElQAeHIe2W6WALu4ijP0Q==
X-Received: by 2002:a2e:b0cc:: with SMTP id g12mr1273945ljl.21.1643246092016;
        Wed, 26 Jan 2022 17:14:52 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id u14sm1028337lji.40.2022.01.26.17.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 17:14:51 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 03/11] power: supply: ab8500: Integrate thermal zone
Date:   Thu, 27 Jan 2022 02:12:28 +0100
Message-Id: <20220127011236.332687-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127011236.332687-1-linus.walleij@linaro.org>
References: <20220127011236.332687-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Instead of providing our own homebrewn thermal measurement
code for an NTC and passing tables, we put the NTC thermistor
into the device tree, create a passive thermal zone, and poll
this thermal zone for the temperature.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/Kconfig         |   2 +
 drivers/power/supply/ab8500-bm.h     |  33 ---------
 drivers/power/supply/ab8500_bmdata.c |  24 -------
 drivers/power/supply/ab8500_btemp.c  | 103 ++++++---------------------
 4 files changed, 24 insertions(+), 138 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index b366e2fd8e97..6815e5a4c0bd 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -728,6 +728,8 @@ config BATTERY_GAUGE_LTC2941
 config AB8500_BM
 	bool "AB8500 Battery Management Driver"
 	depends on AB8500_CORE && AB8500_GPADC && (IIO = y) && OF
+	select THERMAL
+	select THERMAL_OF
 	help
 	  Say Y to include support for AB8500 battery management.
 
diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index 3bc6fd9337d2..6efd5174dbce 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -260,18 +260,6 @@ enum bup_vch_sel {
 #define BUS_PP_PRECHG_CURRENT_MASK		0x0E
 #define BUS_POWER_PATH_PRECHG_ENA		0x01
 
-/**
- * struct ab8500_res_to_temp - defines one point in a temp to res curve. To
- * be used in battery packs that combines the identification resistor with a
- * NTC resistor.
- * @temp:			battery pack temperature in Celsius
- * @resist:			NTC resistor net total resistance
- */
-struct ab8500_res_to_temp {
-	int temp;
-	int resist;
-};
-
 /* Forward declaration */
 struct ab8500_fg;
 
@@ -351,8 +339,6 @@ struct ab8500_maxim_parameters {
  * @maint_b_chg_timer_h:	charge time in maintenance B state
  * @low_high_cur_lvl:		charger current in temp low/high state in mA
  * @low_high_vol_lvl:		charger voltage in temp low/high state in mV'
- * @n_r_t_tbl_elements:		number of elements in r_to_t_tbl
- * @r_to_t_tbl:			table containing resistance to temp points
  */
 struct ab8500_battery_type {
 	int resis_high;
@@ -365,8 +351,6 @@ struct ab8500_battery_type {
 	int maint_b_chg_timer_h;
 	int low_high_cur_lvl;
 	int low_high_vol_lvl;
-	int n_temp_tbl_elements;
-	const struct ab8500_res_to_temp *r_to_t_tbl;
 };
 
 /**
@@ -449,23 +433,6 @@ struct ab8500_bm_data {
 	const struct ab8500_fg_parameters *fg_params;
 };
 
-enum {
-	NTC_EXTERNAL = 0,
-	NTC_INTERNAL,
-};
-
-/**
- * struct res_to_temp - defines one point in a temp to res curve. To
- * be used in battery packs that combines the identification resistor with a
- * NTC resistor.
- * @temp:			battery pack temperature in Celsius
- * @resist:			NTC resistor net total resistance
- */
-struct res_to_temp {
-	int temp;
-	int resist;
-};
-
 /* Forward declaration */
 struct ab8500_fg;
 
diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index 62b63f0437dd..d8fc72be0f0e 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -43,28 +43,6 @@ static struct power_supply_battery_ocv_table ocv_cap_tbl[] = {
 	{ .ocv = 3094000, .capacity = 0},
 };
 
-/*
- * Note that the res_to_temp table must be strictly sorted by falling
- * resistance values to work.
- */
-static const struct ab8500_res_to_temp temp_tbl[] = {
-	{-5, 214834},
-	{ 0, 162943},
-	{ 5, 124820},
-	{10,  96520},
-	{15,  75306},
-	{20,  59254},
-	{25,  47000},
-	{30,  37566},
-	{35,  30245},
-	{40,  24520},
-	{45,  20010},
-	{50,  16432},
-	{55,  13576},
-	{60,  11280},
-	{65,   9425},
-};
-
 /*
  * Note that the batres_vs_temp table must be strictly sorted by falling
  * temperature values to work. Factory resistance is 300 mOhm and the
@@ -92,8 +70,6 @@ static struct ab8500_battery_type bat_type_thermistor_unknown = {
 	.maint_b_chg_timer_h = 200,
 	.low_high_cur_lvl = 300,
 	.low_high_vol_lvl = 4000,
-	.n_temp_tbl_elements = ARRAY_SIZE(temp_tbl),
-	.r_to_t_tbl = temp_tbl,
 };
 
 static const struct ab8500_bm_capacity_levels cap_levels = {
diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index a5ca09124c93..2a6fc151210c 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -26,13 +26,12 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ab8500.h>
+#include <linux/thermal.h>
 #include <linux/iio/consumer.h>
 #include <linux/fixp-arith.h>
 
 #include "ab8500-bm.h"
 
-#define VTVOUT_V			1800
-
 #define BTEMP_THERMAL_LOW_LIMIT		-10
 #define BTEMP_THERMAL_MED_LIMIT		0
 #define BTEMP_THERMAL_HIGH_LIMIT_52	52
@@ -82,7 +81,7 @@ struct ab8500_btemp_ranges {
  * @bat_temp:		Dispatched battery temperature in degree Celsius
  * @prev_bat_temp	Last measured battery temperature in degree Celsius
  * @parent:		Pointer to the struct ab8500
- * @adc_btemp_ball:	ADC channel for the battery ball temperature
+ * @tz:			Thermal zone for the battery
  * @adc_bat_ctrl:	ADC channel for the battery control
  * @fg:			Pointer to the struct fg
  * @bm:           	Platform specific battery management information
@@ -100,7 +99,7 @@ struct ab8500_btemp {
 	int bat_temp;
 	int prev_bat_temp;
 	struct ab8500 *parent;
-	struct iio_channel *btemp_ball;
+	struct thermal_zone_device *tz;
 	struct iio_channel *bat_ctrl;
 	struct ab8500_fg *fg;
 	struct ab8500_bm_data *bm;
@@ -228,76 +227,6 @@ static int ab8500_btemp_get_batctrl_res(struct ab8500_btemp *di)
 	return res;
 }
 
-/**
- * ab8500_btemp_res_to_temp() - resistance to temperature
- * @di:		pointer to the ab8500_btemp structure
- * @tbl:	pointer to the resiatance to temperature table
- * @tbl_size:	size of the resistance to temperature table
- * @res:	resistance to calculate the temperature from
- *
- * This function returns the battery temperature in degrees Celsius
- * based on the NTC resistance.
- */
-static int ab8500_btemp_res_to_temp(struct ab8500_btemp *di,
-	const struct ab8500_res_to_temp *tbl, int tbl_size, int res)
-{
-	int i;
-	/*
-	 * Calculate the formula for the straight line
-	 * Simple interpolation if we are within
-	 * the resistance table limits, extrapolate
-	 * if resistance is outside the limits.
-	 */
-	if (res > tbl[0].resist)
-		i = 0;
-	else if (res <= tbl[tbl_size - 1].resist)
-		i = tbl_size - 2;
-	else {
-		i = 0;
-		while (!(res <= tbl[i].resist &&
-			res > tbl[i + 1].resist))
-			i++;
-	}
-
-	return fixp_linear_interpolate(tbl[i].resist, tbl[i].temp,
-				       tbl[i + 1].resist, tbl[i + 1].temp,
-				       res);
-}
-
-/**
- * ab8500_btemp_measure_temp() - measure battery temperature
- * @di:		pointer to the ab8500_btemp structure
- *
- * Returns battery temperature (on success) else the previous temperature
- */
-static int ab8500_btemp_measure_temp(struct ab8500_btemp *di)
-{
-	int temp, ret;
-	static int prev;
-	int rntc, vntc;
-
-	ret = iio_read_channel_processed(di->btemp_ball, &vntc);
-	if (ret < 0) {
-		dev_err(di->dev,
-			"%s ADC conversion failed,"
-			" using previous value\n", __func__);
-		return prev;
-	}
-	/*
-	 * The PCB NTC is sourced from VTVOUT via a 230kOhm
-	 * resistor.
-	 */
-	rntc = 230000 * vntc / (VTVOUT_V - vntc);
-
-	temp = ab8500_btemp_res_to_temp(di,
-		di->bm->bat_type->r_to_t_tbl,
-		di->bm->bat_type->n_temp_tbl_elements, rntc);
-	prev = temp;
-
-	dev_dbg(di->dev, "Battery temperature is %d\n", temp);
-	return temp;
-}
-
 /**
  * ab8500_btemp_id() - Identify the connected battery
  * @di:		pointer to the ab8500_btemp structure
@@ -347,6 +276,9 @@ static void ab8500_btemp_periodic_work(struct work_struct *work)
 	int bat_temp;
 	struct ab8500_btemp *di = container_of(work,
 		struct ab8500_btemp, btemp_periodic_work.work);
+	/* Assume 25 degrees celsius as start temperature */
+	static int prev = 25;
+	int ret;
 
 	if (!di->initialized) {
 		/* Identify the battery */
@@ -354,7 +286,17 @@ static void ab8500_btemp_periodic_work(struct work_struct *work)
 			dev_warn(di->dev, "failed to identify the battery\n");
 	}
 
-	bat_temp = ab8500_btemp_measure_temp(di);
+	/* Failover if a reading is erroneous, use last meausurement */
+	ret = thermal_zone_get_temp(di->tz, &bat_temp);
+	if (ret) {
+		dev_err(di->dev, "error reading temperature\n");
+		bat_temp = prev;
+	} else {
+		/* Convert from millicentigrades to centigrades */
+		bat_temp /= 1000;
+		prev = bat_temp;
+	}
+
 	/*
 	 * Filter battery temperature.
 	 * Allow direct updates on temperature only if two samples result in
@@ -783,12 +725,11 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
 	di->dev = dev;
 	di->parent = dev_get_drvdata(pdev->dev.parent);
 
-	/* Get ADC channels */
-	di->btemp_ball = devm_iio_channel_get(dev, "btemp_ball");
-	if (IS_ERR(di->btemp_ball)) {
-		ret = dev_err_probe(dev, PTR_ERR(di->btemp_ball),
-				    "failed to get BTEMP BALL ADC channel\n");
-		return ret;
+	/* Get thermal zone and ADC */
+	di->tz = thermal_zone_get_zone_by_name("battery-thermal");
+	if (IS_ERR(di->tz)) {
+		return dev_err_probe(dev, PTR_ERR(di->tz),
+				     "failed to get battery thermal zone\n");
 	}
 	di->bat_ctrl = devm_iio_channel_get(dev, "bat_ctrl");
 	if (IS_ERR(di->bat_ctrl)) {
-- 
2.34.1

