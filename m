Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6287C459881
	for <lists+linux-pm@lfdr.de>; Tue, 23 Nov 2021 00:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhKVXrM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Nov 2021 18:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhKVXrM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Nov 2021 18:47:12 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64E8C061714
        for <linux-pm@vger.kernel.org>; Mon, 22 Nov 2021 15:44:04 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id z8so7275016ljz.9
        for <linux-pm@vger.kernel.org>; Mon, 22 Nov 2021 15:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j3L8AKPmKrW1qhMXXFj7BV+nAdWI7YI0GdN2N1YN5R8=;
        b=JCR2PQ0oPUzShAhUzo6pCqyQwm5aNn34tTpMWsthX6jCMFFEiB1X7vC6CtSqBMRWJL
         ELnBEdHcPhcLJGoIQUX8dciVdHyCDZm03I2bwoBQUT+dCMKnNpid95sGlmjL0CWDpNXL
         NfzILg7nW/uslJHlIqS9oLPX9GnOg2AnTflcIHSH+UreKiZ/DB9NTk1LJHJE3wwQxhU/
         bSNr7jyxdzBJ0NrwjxhERQ9Mu5BX0x0SbSZNLw1N9SJ00W9cwTyq5nRC4BWm+qDZVrla
         PwqiGSniAD0kXLN2yqHEq4iOtXgoQSerSbZ6+p9UY4rXVPlXxnqJtGWMnr7Gb1MZQMNk
         qyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j3L8AKPmKrW1qhMXXFj7BV+nAdWI7YI0GdN2N1YN5R8=;
        b=klJlvEhwWJPqWxpUo53BIsxcBs181kOW1X5SsnORoXgck6uuMcg5MfzTSn9gdOTdOm
         JtFi76JxSDqn0CuBP20dDzVPEdLRCscVxRMUEurhf+IVDpLpxtp+jF9xXV+HDCNmyF7l
         DzFBpEFB6rdO8FT4fSfqzEAqQtRtXdZ/H4Mx1LMJX4E/0mczbudjllt22r90S6MN0OS1
         NoxnRydEna9jOFF7PMD+WU/qqidB8ci2OKkwx1TwgDifnglL+QMEFLvoo8Dw9O1IS/3U
         XCcKSY2KxOxD9y8Ff8YePMa06c1eIGHCcfTm51gIN/vaAinD3iBycFYnPlgoNhckyMT6
         PLkA==
X-Gm-Message-State: AOAM5309JhhI5RqC1Oin8DVfRsc1Q8ExQjthM9hC6ZqgI+31aDbYnScd
        qvs9AbgwyO0bhcNqq8/Z2lRByemAYwKe2g==
X-Google-Smtp-Source: ABdhPJwxe2P8ijdDKGI5I2YwGtJXsWYEosAry7Kn2VLHDOJXjYN2pBKnJymT4xQUEjO7YZQJ6fN7uw==
X-Received: by 2002:a2e:9708:: with SMTP id r8mr300465lji.36.1637624642423;
        Mon, 22 Nov 2021 15:44:02 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id b26sm1109311lff.148.2021.11.22.15.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 15:44:01 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2] power: supply: ab8500: Standardize NTC battery temp
Date:   Tue, 23 Nov 2021 00:41:40 +0100
Message-Id: <20211122234141.3356340-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211122234141.3356340-1-linus.walleij@linaro.org>
References: <20211122234141.3356340-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Several batteries monitor the temperature of the battery using
an NTC resistor. Add an NTC resistor resistance to temperature
look-up table to struct power_supply_battery_info and use this
in the AB8500 battery temperature driver to look up the battery
temperature.

Add a helper function in the power supply core:
power_supply_ntc_resist2temp_simple(), which can use the
NTC resistance table to look up and interpolate a temperature
from the table.

Fix up some of the confusing wording on the temperature to
internal resistance table, and clarify what each resistance
table is for.

The AB8500 default NTC resistor is 47KOhm at 25 degrees
Celsius and serves as a good example of how this usually works.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500-bm.h         | 16 --------
 drivers/power/supply/ab8500_bmdata.c     | 41 ++++++++++---------
 drivers/power/supply/ab8500_btemp.c      | 45 ++------------------
 drivers/power/supply/power_supply_core.c | 52 ++++++++++++++++++++++++
 include/linux/power_supply.h             | 34 ++++++++++++++++
 5 files changed, 111 insertions(+), 77 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index 57e1a8e27e51..90397f2a731f 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -272,18 +272,6 @@ enum ab8500_adc_therm {
 	AB8500_ADC_THERM_BATTEMP,
 };
 
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
 
@@ -363,8 +351,6 @@ struct ab8500_maxim_parameters {
  * @maint_b_chg_timer_h:	charge time in maintenance B state
  * @low_high_cur_lvl:		charger current in temp low/high state in mA
  * @low_high_vol_lvl:		charger voltage in temp low/high state in mV'
- * @n_r_t_tbl_elements:		number of elements in r_to_t_tbl
- * @r_to_t_tbl:			table containing resistance to temp points
  */
 struct ab8500_battery_type {
 	int resis_high;
@@ -377,8 +363,6 @@ struct ab8500_battery_type {
 	int maint_b_chg_timer_h;
 	int low_high_cur_lvl;
 	int low_high_vol_lvl;
-	int n_temp_tbl_elements;
-	const struct ab8500_res_to_temp *r_to_t_tbl;
 };
 
 /**
diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index 62953f9cb85a..aba459393ee6 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -44,25 +44,25 @@ static struct power_supply_battery_ocv_table ocv_cap_tbl[] = {
 };
 
 /*
- * Note that the res_to_temp table must be strictly sorted by falling
+ * Note that the ntc_res_to_temp_tbl table must be strictly sorted by falling
  * resistance values to work.
  */
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
+static struct power_supply_ntc_resistance_temp_table ntc_res_to_temp_tbl[] = {
+	{ .resistance_ohm = 214834, .temp = -5},
+	{ .resistance_ohm = 162943, .temp = 0},
+	{ .resistance_ohm = 124820, .temp = 5},
+	{ .resistance_ohm = 96520, .temp = 10},
+	{ .resistance_ohm = 75306, .temp = 15},
+	{ .resistance_ohm = 59254, .temp = 20},
+	{ .resistance_ohm = 47000, .temp = 25},
+	{ .resistance_ohm = 37566, .temp = 30},
+	{ .resistance_ohm = 30245, .temp = 35},
+	{ .resistance_ohm = 24520, .temp = 40},
+	{ .resistance_ohm = 20010, .temp = 45},
+	{ .resistance_ohm = 16432, .temp = 50},
+	{ .resistance_ohm = 13576, .temp = 55},
+	{ .resistance_ohm = 11280, .temp = 60},
+	{ .resistance_ohm = 9425, .temp = 65},
 };
 
 /*
@@ -92,8 +92,6 @@ static struct ab8500_battery_type bat_type_thermistor_unknown = {
 	.maint_b_chg_timer_h = 200,
 	.low_high_cur_lvl = 300,
 	.low_high_vol_lvl = 4000,
-	.n_temp_tbl_elements = ARRAY_SIZE(temp_tbl),
-	.r_to_t_tbl = temp_tbl,
 };
 
 static const struct ab8500_bm_capacity_levels cap_levels = {
@@ -217,6 +215,11 @@ int ab8500_bm_of_probe(struct power_supply *psy,
 		bi->resist_table_size = ARRAY_SIZE(temp_to_batres_tbl_thermistor);
 	}
 
+	if (!bi->ntc_resist_table) {
+		bi->ntc_resist_table = ntc_res_to_temp_tbl;
+		bi->ntc_resist_table_size = ARRAY_SIZE(ntc_res_to_temp_tbl);
+	}
+
 	if (!bi->ocv_table[0]) {
 		/* Default capacity table at say 25 degrees Celsius */
 		bi->ocv_temp[0] = 25;
diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 20253b8a7fe9..79528c18618d 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -407,42 +407,6 @@ static int ab8500_btemp_get_batctrl_res(struct ab8500_btemp *di)
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
 /**
  * ab8500_btemp_measure_temp() - measure battery temperature
  * @di:		pointer to the ab8500_btemp structure
@@ -451,6 +415,7 @@ static int ab8500_btemp_res_to_temp(struct ab8500_btemp *di,
  */
 static int ab8500_btemp_measure_temp(struct ab8500_btemp *di)
 {
+	struct power_supply_battery_info *bi = &di->bm->bi;
 	int temp, ret;
 	static int prev;
 	int rbat, rntc, vntc;
@@ -469,9 +434,7 @@ static int ab8500_btemp_measure_temp(struct ab8500_btemp *di)
 			return BTEMP_THERMAL_LOW_LIMIT;
 		}
 
-		temp = ab8500_btemp_res_to_temp(di,
-			di->bm->bat_type->r_to_t_tbl,
-			di->bm->bat_type->n_temp_tbl_elements, rbat);
+		temp = power_supply_ntc_resist2temp_simple(bi, rbat);
 	} else {
 		ret = iio_read_channel_processed(di->btemp_ball, &vntc);
 		if (ret < 0) {
@@ -486,9 +449,7 @@ static int ab8500_btemp_measure_temp(struct ab8500_btemp *di)
 		 */
 		rntc = 230000 * vntc / (VTVOUT_V - vntc);
 
-		temp = ab8500_btemp_res_to_temp(di,
-			di->bm->bat_type->r_to_t_tbl,
-			di->bm->bat_type->n_temp_tbl_elements, rntc);
+		temp = power_supply_ntc_resist2temp_simple(bi, rntc);
 		prev = temp;
 	}
 	dev_dbg(di->dev, "Battery temperature is %d\n", temp);
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 2723d7d0ced3..a870c3fe032c 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -589,6 +589,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	info->temp_max                       = INT_MAX;
 	info->factory_internal_resistance_uohm  = -EINVAL;
 	info->resist_table = NULL;
+	info->ntc_resist_table = NULL;
 
 	for (index = 0; index < POWER_SUPPLY_OCV_TEMP_MAX; index++) {
 		info->ocv_table[index]       = NULL;
@@ -806,6 +807,57 @@ int power_supply_temp2resist_simple(struct power_supply_resistance_temp_table *t
 }
 EXPORT_SYMBOL_GPL(power_supply_temp2resist_simple);
 
+/**
+ * power_supply_ntc_resist2temp_simple() - find the battery temperature
+ * @info: battery information
+ * @resistance_ohm: Current NTC resistance value in microohm
+ *
+ * This helper function is used to look up battery internal temperature
+ * according to current NTC resistance value from one NTC resistance table.
+ * The NTC resistance table must be ordered descending by resistance:
+ * largest resistance with lowest temperature first, lowest resistance with
+ * highest temperature last. The function will interpolate to find the
+ * corresponding temperature.
+ *
+ * Return: the battery temperature.
+ */
+int power_supply_ntc_resist2temp_simple(struct power_supply_battery_info *info,
+					int resistance_ohm)
+{
+	struct power_supply_ntc_resistance_temp_table *table;
+	int i, high, low;
+	int table_len;
+
+	table = info->ntc_resist_table;
+	table_len = info->ntc_resist_table_size;
+
+	if (!table || !table_len) {
+		pr_err("Empty battery NTC resistance table, assume 25 degrees\n");
+		return 25;
+	}
+	if (!resistance_ohm)
+		pr_info("Battery NTC resistance 0, this is unlikely\n");
+
+	/* Break loop at table_len - 1 because that is the highest index */
+	for (i = 0; i < table_len - 1; i++)
+		if (resistance_ohm > table[i].resistance_ohm)
+			break;
+
+	/* The library function will deal with high == low */
+	if ((i == 0) || (i == (table_len - 1)))
+		high = i;
+	else
+		high = i - 1;
+	low = i;
+
+	return fixp_linear_interpolate(table[low].resistance_ohm,
+				       table[low].temp,
+				       table[high].resistance_ohm,
+				       table[high].temp,
+				       resistance_ohm);
+}
+EXPORT_SYMBOL_GPL(power_supply_ntc_resist2temp_simple);
+
 /**
  * power_supply_ocv2cap_simple() - find the battery capacity
  * @table: Pointer to battery OCV lookup table
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index b5079109ac00..a0da806185b5 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -335,11 +335,29 @@ struct power_supply_battery_ocv_table {
 	int capacity;	/* percent */
 };
 
+/**
+ * struct power_supply_resistance_temp_table - correlate temperature to resistance
+ * @temp: the internal temperature of the battery in degrees Celsius
+ * @resistance: the percentage of the factory internal resistance at this
+ *   temperature, usually nomimal factory resistance is 100 percent at 25
+ *   degrees Celsius, lower at higher temperature and higher at lower
+ *   temperature.
+ */
 struct power_supply_resistance_temp_table {
 	int temp;	/* celsius */
 	int resistance;	/* internal resistance percent */
 };
 
+/**
+ * struct power_supply_ntc_resistance_temp_table - correlate NTC to temp
+ * @resistance: the NTC resistance in ohm
+ * @temp: the corresponding temperature in degrees Celsius
+ */
+struct power_supply_ntc_resistance_temp_table {
+	int resistance_ohm;
+	int temp;
+};
+
 #define POWER_SUPPLY_OCV_TEMP_MAX 20
 
 /**
@@ -426,6 +444,18 @@ struct power_supply_resistance_temp_table {
  *   by temperature: highest temperature with lowest resistance first, lowest
  *   temperature with highest resistance last.
  * @resist_table_size: the number of items in the resist_table.
+ * @ntc_resist_table: this is a table that correlates a resistance of a negative
+ *   temperature coefficient (NTC) resistor to an internal temperature of a
+ *   battery. This can be achieved by a separate thermistor to
+ *   supply voltage on a third terminal on a battery which is the most
+ *   reliable. An external thermistor can also be used sometimes. Knowing the
+ *   temperature of the battery is usually necessary to perform a lookup in the
+ *   resist_table to determine the internal resistance of the battery, and
+ *   to find the right ocv_table to determine the capacity of the battery.
+ *   The NTC resistance table must be ordered descending by resistance:
+ *   largest resistance with lowest temperature first, lowest resistance with
+ *   highest temperature last.
+ * @ntc_resist_table_size: the number of items in the ntc_resist_table.
  *
  * This is the recommended struct to manage static battery parameters,
  * populated by power_supply_get_battery_info(). Most platform drivers should
@@ -546,6 +576,8 @@ struct power_supply_battery_info {
 	int ocv_table_size[POWER_SUPPLY_OCV_TEMP_MAX];
 	struct power_supply_resistance_temp_table *resist_table;
 	int resist_table_size;
+	struct power_supply_ntc_resistance_temp_table *ntc_resist_table;
+	int ntc_resist_table_size;
 };
 
 extern struct atomic_notifier_head power_supply_notifier;
@@ -587,6 +619,8 @@ extern int power_supply_batinfo_ocv2cap(struct power_supply_battery_info *info,
 extern int
 power_supply_temp2resist_simple(struct power_supply_resistance_temp_table *table,
 				int table_len, int temp);
+extern int power_supply_ntc_resist2temp_simple(struct power_supply_battery_info *info,
+					       int resistance_ohm);
 extern void power_supply_changed(struct power_supply *psy);
 extern int power_supply_am_i_supplied(struct power_supply *psy);
 extern int power_supply_set_input_current_limit_from_supplier(
-- 
2.31.1

