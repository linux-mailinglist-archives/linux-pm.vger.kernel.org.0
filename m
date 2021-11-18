Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9207745529C
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 03:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241589AbhKRCXh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 21:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242501AbhKRCXd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 21:23:33 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825A5C061764
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:20:32 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b1so17825633lfs.13
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xBgzA3ht73l6japkeYYBDH9TpjheShCwlXX6OzJoFMM=;
        b=AIjI0bQIWRb97nmX3ZWmvIRk/gU8fmCj6HsajEa8F92V5qKceOvKEZmliK70ADO9se
         hWHwNlfg7/xhIDpDrglC1jqtPHHOA9w7sriZb4O+VIQLyClhiRhGM7p2/AgpAtEx1ZXK
         W2Rq5njKYtKLWoYpEDy39k/8IvFfpUozKuAgu++T1RQypQO3Ku1VyLu6NqhO5SZ7g4XT
         dMqPwR8m81RJ702LPhEuZb8bGTUmtyztLNvs50YXQsuVfvshIiS+MCmxRfpSbg3kSGTM
         vsipP9P98DI6aqIXWrwOIMZVkwkTHk2wPP8MOGsD2RX6MXyijTTq8g5z6tD2bKmpG3eA
         ofLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xBgzA3ht73l6japkeYYBDH9TpjheShCwlXX6OzJoFMM=;
        b=HYSth0CDZ59PKyTzNZGf9uXJO5W08ASdhcq8zm9Qvd7xXdTHPZvuiOsHneRhgrT27l
         v2mVMCZgbtvUPyD0qmHSU50J3H/ycZTHMjEazkx+qsm66knOfaMM9Hmzj+rpGcx267OM
         ZoBPNvqRVIt48+5dDV1SS4oSWw5By8ittrT/qrBx1E+JhvIz1b5WCOrkn0CuNquv2IpL
         xj2GphpRJuFxW9+sdj0+BMZv74RiwbH2pUw67zWfmtp82cTq+lnvNH0ItJAvajablN67
         lWykHA1SIzCCo6e3eaKA/FcgF8N2rDTCfppefL9Hq6nuG7+1AUfkg+szmSeHuKBFL/C6
         bkmQ==
X-Gm-Message-State: AOAM5310xMwpLH3JbZHvLx+Ennn09GkvTylOXa2+x6wrx7Sx0MXJPyLL
        ZUqAzhh4HPydQKJ9kP/IHAxEtQ==
X-Google-Smtp-Source: ABdhPJyPCmefvWaH8hsX/BEvUaJz0jhPIb9evDw/SfW5JqdjIUJmqpboFUoY0VgEKElQtgt1Fv48Mg==
X-Received: by 2002:a05:6512:15a7:: with SMTP id bp39mr20486163lfb.145.1637202030879;
        Wed, 17 Nov 2021 18:20:30 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id j19sm165321lfe.120.2021.11.17.18.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 18:20:29 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 15/16] power: supply: ab8500: Standardize temp res lookup
Date:   Thu, 18 Nov 2021 03:17:51 +0100
Message-Id: <20211118021752.2262818-16-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118021752.2262818-1-linus.walleij@linaro.org>
References: <20211118021752.2262818-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The lookup from battery temperature to internal resistance was
using its own format. Rewrite this to use the table inside
struct power_supply_battery_info:s resist_table.

The supplied resistance table has to be rewritten to express
the resistance in percent of the factory resistance as a
side effect.

We can then rely on the library function
power_supply_temp2resist_simple() to interpolate the internal
resistance percent from the temperature.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500-bm.h     | 15 ---------
 drivers/power/supply/ab8500_bmdata.c | 31 +++++++++++-------
 drivers/power/supply/ab8500_fg.c     | 47 +++++++++++-----------------
 3 files changed, 38 insertions(+), 55 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index 56bf70bc673a..fd85b54d5ec5 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -379,8 +379,6 @@ struct ab8500_maxim_parameters {
  * @r_to_t_tbl:			table containing resistance to temp points
  * @n_v_cap_tbl_elements:	number of elements in v_to_cap_tbl
  * @v_to_cap_tbl:		Voltage to capacity (in %) table
- * @n_batres_tbl_elements	number of elements in the batres_tbl
- * @batres_tbl			battery internal resistance vs temperature table
  */
 struct ab8500_battery_type {
 	int resis_high;
@@ -397,8 +395,6 @@ struct ab8500_battery_type {
 	const struct ab8500_res_to_temp *r_to_t_tbl;
 	int n_v_cap_tbl_elements;
 	const struct ab8500_v_to_cap *v_to_cap_tbl;
-	int n_batres_tbl_elements;
-	const struct batres_vs_temp *batres_tbl;
 };
 
 /**
@@ -502,17 +498,6 @@ struct res_to_temp {
 	int resist;
 };
 
-/**
- * struct batres_vs_temp - defines one point in a temp vs battery internal
- * resistance curve.
- * @temp:			battery pack temperature in Celsius
- * @resist:			battery internal reistance in mOhm
- */
-struct batres_vs_temp {
-	int temp;
-	int resist;
-};
-
 /* Forward declaration */
 struct ab8500_fg;
 
diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index a41b9f3a88cb..8d85fcf4abe7 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -67,16 +67,17 @@ static const struct ab8500_res_to_temp temp_tbl[] = {
 
 /*
  * Note that the batres_vs_temp table must be strictly sorted by falling
- * temperature values to work.
+ * temperature values to work. Factory resistance is 300 mOhm and the
+ * resistance values to the right are percentages of 300 mOhm.
  */
-static const struct batres_vs_temp temp_to_batres_tbl_thermistor[] = {
-	{ 40, 120},
-	{ 30, 135},
-	{ 20, 165},
-	{ 10, 230},
-	{ 00, 325},
-	{-10, 445},
-	{-20, 595},
+static struct power_supply_resistance_temp_table temp_to_batres_tbl_thermistor[] = {
+	{ .temp = 40, .resistance = 40 /* 120 mOhm */ },
+	{ .temp = 30, .resistance = 45 /* 135 mOhm */ },
+	{ .temp = 20, .resistance = 55 /* 165 mOhm */ },
+	{ .temp = 10, .resistance = 77 /* 230 mOhm */ },
+	{ .temp = 00, .resistance = 108 /* 325 mOhm */ },
+	{ .temp = -10, .resistance = 158 /* 445 mOhm */ },
+	{ .temp = -20, .resistance = 198 /* 595 mOhm */ },
 };
 
 /* Default battery type for reference designs is the unknown type */
@@ -95,8 +96,6 @@ static struct ab8500_battery_type bat_type_thermistor_unknown = {
 	.r_to_t_tbl = temp_tbl,
 	.n_v_cap_tbl_elements = ARRAY_SIZE(cap_tbl),
 	.v_to_cap_tbl = cap_tbl,
-	.n_batres_tbl_elements = ARRAY_SIZE(temp_to_batres_tbl_thermistor),
-	.batres_tbl = temp_to_batres_tbl_thermistor,
 };
 
 static const struct ab8500_bm_capacity_levels cap_levels = {
@@ -209,8 +208,16 @@ int ab8500_bm_of_probe(struct power_supply *psy,
 		/* Charging stops when we drop below this current */
 		bi->charge_term_current_ua = 200000;
 
-	if (bi->factory_internal_resistance_uohm < 0)
+	/*
+	 * Internal resistance and factory resistance are tightly coupled
+	 * so both MUST be defined or we fall back to defaults.
+	 */
+	if ((bi->factory_internal_resistance_uohm < 0) ||
+	    !bi->resist_table) {
 		bi->factory_internal_resistance_uohm = 300000;
+		bi->resist_table = temp_to_batres_tbl_thermistor;
+		bi->resist_table_size = ARRAY_SIZE(temp_to_batres_tbl_thermistor);
+	}
 
 	if (bi->temp_min == INT_MIN)
 		bi->temp_min = AB8500_TEMP_UNDER;
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index daa008138b05..96bb81e539f0 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -901,44 +901,35 @@ static int ab8500_fg_uncomp_volt_to_capacity(struct ab8500_fg *di)
  * @di:		pointer to the ab8500_fg structure
  *
  * Returns battery inner resistance added with the fuel gauge resistor value
- * to get the total resistance in the whole link from gnd to bat+ node.
+ * to get the total resistance in the whole link from gnd to bat+ node
+ * in milliohm.
  */
 static int ab8500_fg_battery_resistance(struct ab8500_fg *di)
 {
-	int i, tbl_size;
-	const struct batres_vs_temp *tbl;
-	int resist = 0;
-
-	tbl = di->bm->bat_type->batres_tbl;
-	tbl_size = di->bm->bat_type->n_batres_tbl_elements;
-
-	for (i = 0; i < tbl_size; ++i) {
-		if (di->bat_temp / 10 > tbl[i].temp)
-			break;
-	}
+	struct power_supply_battery_info *bi = &di->bm->bi;
+	int resistance_percent = 0;
+	int resistance;
 
-	if ((i > 0) && (i < tbl_size)) {
-		resist = fixp_linear_interpolate(
-			tbl[i].temp,
-			tbl[i].resist,
-			tbl[i-1].temp,
-			tbl[i-1].resist,
-			di->bat_temp / 10);
-	} else if (i == 0) {
-		resist = tbl[0].resist;
-	} else {
-		resist = tbl[tbl_size - 1].resist;
-	}
+	resistance_percent = power_supply_temp2resist_simple(bi->resist_table,
+						 bi->resist_table_size,
+						 di->bat_temp / 10);
+	/*
+	 * We get a percentage of factory resistance here so first get
+	 * the factory resistance in milliohms then calculate how much
+	 * resistance we have at this temperature.
+	 */
+	resistance = (bi->factory_internal_resistance_uohm / 1000);
+	resistance = resistance * resistance_percent / 100;
 
 	dev_dbg(di->dev, "%s Temp: %d battery internal resistance: %d"
 	    " fg resistance %d, total: %d (mOhm)\n",
-		__func__, di->bat_temp, resist, di->bm->fg_res / 10,
-		(di->bm->fg_res / 10) + resist);
+		__func__, di->bat_temp, resistance, di->bm->fg_res / 10,
+		(di->bm->fg_res / 10) + resistance);
 
 	/* fg_res variable is in 0.1mOhm */
-	resist += di->bm->fg_res / 10;
+	resistance += di->bm->fg_res / 10;
 
-	return resist;
+	return resistance;
 }
 
 /**
-- 
2.31.1

