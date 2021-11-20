Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EC6457F2C
	for <lists+linux-pm@lfdr.de>; Sat, 20 Nov 2021 16:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbhKTP7U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 Nov 2021 10:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237588AbhKTP7T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 Nov 2021 10:59:19 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD64C061574
        for <linux-pm@vger.kernel.org>; Sat, 20 Nov 2021 07:56:16 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id c32so58140865lfv.4
        for <linux-pm@vger.kernel.org>; Sat, 20 Nov 2021 07:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E/35VY9XNQxDBgwLOVtqYcp5O8lx4FikGBG0WAoUEw8=;
        b=rGcOroCJUhASZLsSNIeNUJiqKS4nXY6Co6o5Kp/TCaNld9AAwELV+ZtD9+Scy3tKc2
         qHxM7++NHxBmXgOG6KPgT8F5XOm4j93uvBTRUmdivkH9R47YK79WliTOonPiiBLAdjoZ
         VYrBW6jtt8WNKHJsJF91DEUJ57DwAt73mAwweBtCxulpfvBTEwaAj9Dj9WS5KYFomZ3F
         yhwS5++nnDbHQMvrx7C8BUiBMSx9Z+Z8TJCSzImCwbQsR/vtrsQgTi/VAMk7qY4NE9Wv
         ROGBnK7HU0ChSUS8JDsHT7ymXx519At6MLSiS8Dc5pUM7DcZ/K5cQ0VlzcktMhS+Eiu/
         ExSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E/35VY9XNQxDBgwLOVtqYcp5O8lx4FikGBG0WAoUEw8=;
        b=1tEwgME4BriN8L87qIf2jhsyJBpaVPs8hdvCWT8BlOykjPctHtzbMnBK/8hq4s+/y5
         jsbKQVBAmMMRd3eg6ci0zy2bSbk6kHBpTcde62XcFrhL3dtV9ObcLoAjXw02sNJu4WXg
         IeAiebns1LQze3X4aE6fusCdP/wumCLM2nThr01DGReUlNiRxam9bm0ErUBqzdsn8EoK
         oqtQ7miSHQDTIX54MkJ0XNisNKQOrejRxS68oPKMTQSyPZPMsyYos4RxsLYmOyiB3fVd
         kqTIIhnDYZlrmF2O8zn+r7jM4mCRFgGMbeGhZuSo80uLiLuqRR9LbQL1SWhQd4yJPPEt
         QDjA==
X-Gm-Message-State: AOAM532Z9JDHF5l6lfCPajHFhgKft1YvgUUD9fZmP2EnwvwwSZ3CTbJY
        I7XyFOE//mt0pWph51FC5jAk4A==
X-Google-Smtp-Source: ABdhPJxwJxWcBWNfturMPOeneiHuJBwYG7RG6UjbJ6RlTCXwh8AgYxCEQASPWDViQRfDCeGmZsW6kQ==
X-Received: by 2002:a2e:2a43:: with SMTP id q64mr35278527ljq.102.1637423774208;
        Sat, 20 Nov 2021 07:56:14 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id t12sm280922ljg.63.2021.11.20.07.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 07:56:13 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 16/16] power: supply: ab8500: Standardize capacity lookup
Date:   Sat, 20 Nov 2021 16:53:26 +0100
Message-Id: <20211120155326.2891664-17-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211120155326.2891664-1-linus.walleij@linaro.org>
References: <20211120155326.2891664-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The AB8500 charger only has one capacity table with
unspecified temperature, so we assume this capacity is given
for 20 degrees Celsius.

Convert this table to use the OCV (open circuit voltage)
tables in struct power_supply_battery_ocv_table.

In the process, convert the fuel gauge driver to use
microvolts and microamperes so we can use the same internals
as the power supply subsystem without having to multiply
and divide with 1000 in a few places.

Also convert high_curr_threshold and lowbat_threshold to
use microamperes and microvolts as these are closely
related to these changes.

Drop the unused overbat_threshold member in the custom
struct ab8500_fg_parameters.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebase on the other patches
---
 drivers/power/supply/ab8500-bm.h     |  30 +--
 drivers/power/supply/ab8500_bmdata.c |  63 +++---
 drivers/power/supply/ab8500_fg.c     | 286 +++++++++++++--------------
 3 files changed, 173 insertions(+), 206 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index af52539a7a7b..57e1a8e27e51 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -196,8 +196,8 @@ enum bup_vch_sel {
 #define BATT_OVV_TH_3P7			0x00
 #define BATT_OVV_TH_4P75		0x01
 
-/* A value to indicate over voltage */
-#define BATT_OVV_VALUE			4750
+/* A value to indicate over voltage (microvolts) */
+#define BATT_OVV_VALUE			4750000
 
 /* VBUS OVV constants */
 #define VBUS_OVV_SELECT_MASK		0x78
@@ -284,16 +284,6 @@ struct ab8500_res_to_temp {
 	int resist;
 };
 
-/**
- * struct ab8500_v_to_cap - Table for translating voltage to capacity
- * @voltage:		Voltage in mV
- * @capacity:		Capacity in percent
- */
-struct ab8500_v_to_cap {
-	int voltage;
-	int capacity;
-};
-
 /* Forward declaration */
 struct ab8500_fg;
 
@@ -307,10 +297,9 @@ struct ab8500_fg;
  * @init_total_time:		Total init time during startup
  * @high_curr_time:		Time current has to be high to go to recovery
  * @accu_charging:		FG accumulation time while charging
- * @accu_high_curr:		FG accumulation time in high current mode
- * @high_curr_threshold:	High current threshold, in mA
- * @lowbat_threshold:		Low battery threshold, in mV
- * @overbat_threshold:		Over battery threshold, in mV
+ * @accu_high_curr_ua:		FG accumulation time in high current mode
+ * @high_curr_threshold_ua:	High current threshold, in uA
+ * @lowbat_threshold_uv:	Low battery threshold, in uV
  * @battok_falling_th_sel0	Threshold in mV for battOk signal sel0
  *				Resolution in 50 mV step.
  * @battok_raising_th_sel1	Threshold in mV for battOk signal sel1
@@ -335,9 +324,8 @@ struct ab8500_fg_parameters {
 	int high_curr_time;
 	int accu_charging;
 	int accu_high_curr;
-	int high_curr_threshold;
-	int lowbat_threshold;
-	int overbat_threshold;
+	int high_curr_threshold_ua;
+	int lowbat_threshold_uv;
 	int battok_falling_th_sel0;
 	int battok_raising_th_sel1;
 	int user_cap_limit;
@@ -377,8 +365,6 @@ struct ab8500_maxim_parameters {
  * @low_high_vol_lvl:		charger voltage in temp low/high state in mV'
  * @n_r_t_tbl_elements:		number of elements in r_to_t_tbl
  * @r_to_t_tbl:			table containing resistance to temp points
- * @n_v_cap_tbl_elements:	number of elements in v_to_cap_tbl
- * @v_to_cap_tbl:		Voltage to capacity (in %) table
  */
 struct ab8500_battery_type {
 	int resis_high;
@@ -393,8 +379,6 @@ struct ab8500_battery_type {
 	int low_high_vol_lvl;
 	int n_temp_tbl_elements;
 	const struct ab8500_res_to_temp *r_to_t_tbl;
-	int n_v_cap_tbl_elements;
-	const struct ab8500_v_to_cap *v_to_cap_tbl;
 };
 
 /**
diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index 1175532fe017..62953f9cb85a 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -16,31 +16,31 @@
 /* Default: temperature hysteresis */
 #define AB8500_TEMP_HYSTERESIS	3
 
-static const struct ab8500_v_to_cap cap_tbl[] = {
-	{4186,	100},
-	{4163,	 99},
-	{4114,	 95},
-	{4068,	 90},
-	{3990,	 80},
-	{3926,	 70},
-	{3898,	 65},
-	{3866,	 60},
-	{3833,	 55},
-	{3812,	 50},
-	{3787,	 40},
-	{3768,	 30},
-	{3747,	 25},
-	{3730,	 20},
-	{3705,	 15},
-	{3699,	 14},
-	{3684,	 12},
-	{3672,	  9},
-	{3657,	  7},
-	{3638,	  6},
-	{3556,	  4},
-	{3424,	  2},
-	{3317,	  1},
-	{3094,	  0},
+static struct power_supply_battery_ocv_table ocv_cap_tbl[] = {
+	{ .ocv = 4186000, .capacity = 100},
+	{ .ocv = 4163000, .capacity = 99},
+	{ .ocv = 4114000, .capacity = 95},
+	{ .ocv = 4068000, .capacity = 90},
+	{ .ocv = 3990000, .capacity = 80},
+	{ .ocv = 3926000, .capacity = 70},
+	{ .ocv = 3898000, .capacity = 65},
+	{ .ocv = 3866000, .capacity = 60},
+	{ .ocv = 3833000, .capacity = 55},
+	{ .ocv = 3812000, .capacity = 50},
+	{ .ocv = 3787000, .capacity = 40},
+	{ .ocv = 3768000, .capacity = 30},
+	{ .ocv = 3747000, .capacity = 25},
+	{ .ocv = 3730000, .capacity = 20},
+	{ .ocv = 3705000, .capacity = 15},
+	{ .ocv = 3699000, .capacity = 14},
+	{ .ocv = 3684000, .capacity = 12},
+	{ .ocv = 3672000, .capacity = 9},
+	{ .ocv = 3657000, .capacity = 7},
+	{ .ocv = 3638000, .capacity = 6},
+	{ .ocv = 3556000, .capacity = 4},
+	{ .ocv = 3424000, .capacity = 2},
+	{ .ocv = 3317000, .capacity = 1},
+	{ .ocv = 3094000, .capacity = 0},
 };
 
 /*
@@ -94,8 +94,6 @@ static struct ab8500_battery_type bat_type_thermistor_unknown = {
 	.low_high_vol_lvl = 4000,
 	.n_temp_tbl_elements = ARRAY_SIZE(temp_tbl),
 	.r_to_t_tbl = temp_tbl,
-	.n_v_cap_tbl_elements = ARRAY_SIZE(cap_tbl),
-	.v_to_cap_tbl = cap_tbl,
 };
 
 static const struct ab8500_bm_capacity_levels cap_levels = {
@@ -115,8 +113,8 @@ static const struct ab8500_fg_parameters fg = {
 	.high_curr_time = 60,
 	.accu_charging = 30,
 	.accu_high_curr = 30,
-	.high_curr_threshold = 50,
-	.lowbat_threshold = 3100,
+	.high_curr_threshold_ua = 50000,
+	.lowbat_threshold_uv = 3100000,
 	.battok_falling_th_sel0 = 2860,
 	.battok_raising_th_sel1 = 2860,
 	.maint_thres = 95,
@@ -219,6 +217,13 @@ int ab8500_bm_of_probe(struct power_supply *psy,
 		bi->resist_table_size = ARRAY_SIZE(temp_to_batres_tbl_thermistor);
 	}
 
+	if (!bi->ocv_table[0]) {
+		/* Default capacity table at say 25 degrees Celsius */
+		bi->ocv_temp[0] = 25;
+		bi->ocv_table[0] = ocv_cap_tbl;
+		bi->ocv_table_size[0] = ARRAY_SIZE(ocv_cap_tbl);
+	}
+
 	if (bi->temp_min == INT_MIN)
 		bi->temp_min = AB8500_TEMP_UNDER;
 	if (bi->temp_max == INT_MAX)
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 96bb81e539f0..eb3e5c4ca44f 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -156,10 +156,10 @@ struct inst_curr_result_list {
  * @dev:		Pointer to the structure device
  * @node:		a list of AB8500 FGs, hence prepared for reentrance
  * @irq			holds the CCEOC interrupt number
- * @vbat:		Battery voltage in mV
+ * @vbat_uv:		Battery voltage in uV
  * @vbat_nom_uv:	Nominal battery voltage in uV
- * @inst_curr:		Instantenous battery current in mA
- * @avg_curr:		Average battery current in mA
+ * @inst_curr_ua:	Instantenous battery current in uA
+ * @avg_curr_ua:	Average battery current in uA
  * @bat_temp		battery temperature
  * @fg_samples:		Number of samples used in the FG accumulation
  * @accu_charge:	Accumulated charge from the last conversion
@@ -198,10 +198,10 @@ struct ab8500_fg {
 	struct device *dev;
 	struct list_head node;
 	int irq;
-	int vbat;
+	int vbat_uv;
 	int vbat_nom_uv;
-	int inst_curr;
-	int avg_curr;
+	int inst_curr_ua;
+	int avg_curr_ua;
 	int bat_temp;
 	int fg_samples;
 	int accu_charge;
@@ -265,84 +265,84 @@ static enum power_supply_property ab8500_fg_props[] = {
 
 /*
  * This array maps the raw hex value to lowbat voltage used by the AB8500
- * Values taken from the UM0836
+ * Values taken from the UM0836, in microvolts.
  */
 static int ab8500_fg_lowbat_voltage_map[] = {
-	2300 ,
-	2325 ,
-	2350 ,
-	2375 ,
-	2400 ,
-	2425 ,
-	2450 ,
-	2475 ,
-	2500 ,
-	2525 ,
-	2550 ,
-	2575 ,
-	2600 ,
-	2625 ,
-	2650 ,
-	2675 ,
-	2700 ,
-	2725 ,
-	2750 ,
-	2775 ,
-	2800 ,
-	2825 ,
-	2850 ,
-	2875 ,
-	2900 ,
-	2925 ,
-	2950 ,
-	2975 ,
-	3000 ,
-	3025 ,
-	3050 ,
-	3075 ,
-	3100 ,
-	3125 ,
-	3150 ,
-	3175 ,
-	3200 ,
-	3225 ,
-	3250 ,
-	3275 ,
-	3300 ,
-	3325 ,
-	3350 ,
-	3375 ,
-	3400 ,
-	3425 ,
-	3450 ,
-	3475 ,
-	3500 ,
-	3525 ,
-	3550 ,
-	3575 ,
-	3600 ,
-	3625 ,
-	3650 ,
-	3675 ,
-	3700 ,
-	3725 ,
-	3750 ,
-	3775 ,
-	3800 ,
-	3825 ,
-	3850 ,
-	3850 ,
+	2300000,
+	2325000,
+	2350000,
+	2375000,
+	2400000,
+	2425000,
+	2450000,
+	2475000,
+	2500000,
+	2525000,
+	2550000,
+	2575000,
+	2600000,
+	2625000,
+	2650000,
+	2675000,
+	2700000,
+	2725000,
+	2750000,
+	2775000,
+	2800000,
+	2825000,
+	2850000,
+	2875000,
+	2900000,
+	2925000,
+	2950000,
+	2975000,
+	3000000,
+	3025000,
+	3050000,
+	3075000,
+	3100000,
+	3125000,
+	3150000,
+	3175000,
+	3200000,
+	3225000,
+	3250000,
+	3275000,
+	3300000,
+	3325000,
+	3350000,
+	3375000,
+	3400000,
+	3425000,
+	3450000,
+	3475000,
+	3500000,
+	3525000,
+	3550000,
+	3575000,
+	3600000,
+	3625000,
+	3650000,
+	3675000,
+	3700000,
+	3725000,
+	3750000,
+	3775000,
+	3800000,
+	3825000,
+	3850000,
+	3850000,
 };
 
-static u8 ab8500_volt_to_regval(int voltage)
+static u8 ab8500_volt_to_regval(int voltage_uv)
 {
 	int i;
 
-	if (voltage < ab8500_fg_lowbat_voltage_map[0])
+	if (voltage_uv < ab8500_fg_lowbat_voltage_map[0])
 		return 0;
 
 	for (i = 0; i < ARRAY_SIZE(ab8500_fg_lowbat_voltage_map); i++) {
-		if (voltage < ab8500_fg_lowbat_voltage_map[i])
+		if (voltage_uv < ab8500_fg_lowbat_voltage_map[i])
 			return (u8) i - 1;
 	}
 
@@ -353,16 +353,16 @@ static u8 ab8500_volt_to_regval(int voltage)
 /**
  * ab8500_fg_is_low_curr() - Low or high current mode
  * @di:		pointer to the ab8500_fg structure
- * @curr:	the current to base or our decision on
+ * @curr_ua:	the current to base or our decision on in microampere
  *
  * Low current mode if the current consumption is below a certain threshold
  */
-static int ab8500_fg_is_low_curr(struct ab8500_fg *di, int curr)
+static int ab8500_fg_is_low_curr(struct ab8500_fg *di, int curr_ua)
 {
 	/*
 	 * We want to know if we're in low current mode
 	 */
-	if (curr > -di->bm->fg_params->high_curr_threshold)
+	if (curr_ua > -di->bm->fg_params->high_curr_threshold_ua)
 		return true;
 	else
 		return false;
@@ -600,13 +600,13 @@ int ab8500_fg_inst_curr_done(struct ab8500_fg *di)
 /**
  * ab8500_fg_inst_curr_finalize() - battery instantaneous current
  * @di:         pointer to the ab8500_fg structure
- * @res:	battery instantenous current(on success)
+ * @curr_ua:	battery instantenous current in microampere (on success)
  *
  * Returns 0 or an error code
  * Note: This is part "two" and has to be called at earliest 250 ms
  * after ab8500_fg_inst_curr_start()
  */
-int ab8500_fg_inst_curr_finalize(struct ab8500_fg *di, int *res)
+int ab8500_fg_inst_curr_finalize(struct ab8500_fg *di, int *curr_ua)
 {
 	u8 low, high;
 	int val;
@@ -662,14 +662,13 @@ int ab8500_fg_inst_curr_finalize(struct ab8500_fg *di, int *res)
 	/*
 	 * Convert to unit value in mA
 	 * Full scale input voltage is
-	 * 63.160mV => LSB = 63.160mV/(4096*res) = 1.542mA
+	 * 63.160mV => LSB = 63.160mV/(4096*res) = 1.542.000 uA
 	 * Given a 250ms conversion cycle time the LSB corresponds
 	 * to 107.1 nAh. Convert to current by dividing by the conversion
 	 * time in hours (250ms = 1 / (3600 * 4)h)
 	 * 107.1nAh assumes 10mOhm, but fg_res is in 0.1mOhm
 	 */
-	val = (val * QLSB_NANO_AMP_HOURS_X10 * 36 * 4) /
-		(1000 * di->bm->fg_res);
+	val = (val * QLSB_NANO_AMP_HOURS_X10 * 36 * 4) / di->bm->fg_res;
 
 	if (di->turn_off_fg) {
 		dev_dbg(di->dev, "%s Disable FG\n", __func__);
@@ -687,7 +686,7 @@ int ab8500_fg_inst_curr_finalize(struct ab8500_fg *di, int *res)
 			goto fail;
 	}
 	mutex_unlock(&di->cc_lock);
-	(*res) = val;
+	*curr_ua = val;
 
 	return 0;
 fail:
@@ -698,15 +697,15 @@ int ab8500_fg_inst_curr_finalize(struct ab8500_fg *di, int *res)
 /**
  * ab8500_fg_inst_curr_blocking() - battery instantaneous current
  * @di:         pointer to the ab8500_fg structure
- * @res:	battery instantenous current(on success)
  *
- * Returns 0 else error code
+ * Returns battery instantenous current in microampere (on success)
+ * else error code
  */
 int ab8500_fg_inst_curr_blocking(struct ab8500_fg *di)
 {
 	int ret;
 	unsigned long timeout;
-	int res = 0;
+	int curr_ua = 0;
 
 	ret = ab8500_fg_inst_curr_start(di);
 	if (ret) {
@@ -729,14 +728,14 @@ int ab8500_fg_inst_curr_blocking(struct ab8500_fg *di)
 		}
 	}
 
-	ret = ab8500_fg_inst_curr_finalize(di, &res);
+	ret = ab8500_fg_inst_curr_finalize(di, &curr_ua);
 	if (ret) {
 		dev_err(di->dev, "Failed to finalize fg_inst\n");
 		return 0;
 	}
 
-	dev_dbg(di->dev, "%s instant current: %d", __func__, res);
-	return res;
+	dev_dbg(di->dev, "%s instant current: %d uA", __func__, curr_ua);
+	return curr_ua;
 fail:
 	disable_irq(di->irq);
 	mutex_unlock(&di->cc_lock);
@@ -796,13 +795,12 @@ static void ab8500_fg_acc_cur_work(struct work_struct *work)
 		(100 * di->bm->fg_res);
 
 	/*
-	 * Convert to unit value in mA
+	 * Convert to unit value in uA
 	 * by dividing by the conversion
 	 * time in hours (= samples / (3600 * 4)h)
-	 * and multiply with 1000
 	 */
-	di->avg_curr = (val * QLSB_NANO_AMP_HOURS_X10 * 36) /
-		(1000 * di->bm->fg_res * (di->fg_samples / 4));
+	di->avg_curr_ua = (val * QLSB_NANO_AMP_HOURS_X10 * 36) /
+		(di->bm->fg_res * (di->fg_samples / 4));
 
 	di->flags.conv_done = true;
 
@@ -824,7 +822,7 @@ static void ab8500_fg_acc_cur_work(struct work_struct *work)
  * ab8500_fg_bat_voltage() - get battery voltage
  * @di:		pointer to the ab8500_fg structure
  *
- * Returns battery voltage(on success) else error code
+ * Returns battery voltage in microvolts (on success) else error code
  */
 static int ab8500_fg_bat_voltage(struct ab8500_fg *di)
 {
@@ -839,6 +837,8 @@ static int ab8500_fg_bat_voltage(struct ab8500_fg *di)
 		return prev;
 	}
 
+	/* IIO returns millivolts but we want microvolts */
+	vbat *= 1000;
 	prev = vbat;
 	return vbat;
 }
@@ -846,41 +846,16 @@ static int ab8500_fg_bat_voltage(struct ab8500_fg *di)
 /**
  * ab8500_fg_volt_to_capacity() - Voltage based capacity
  * @di:		pointer to the ab8500_fg structure
- * @voltage:	The voltage to convert to a capacity
+ * @voltage_uv:	The voltage to convert to a capacity in microvolt
  *
  * Returns battery capacity in per mille based on voltage
  */
-static int ab8500_fg_volt_to_capacity(struct ab8500_fg *di, int voltage)
+static int ab8500_fg_volt_to_capacity(struct ab8500_fg *di, int voltage_uv)
 {
-	int i, tbl_size;
-	const struct ab8500_v_to_cap *tbl;
-	int cap = 0;
-
-	tbl = di->bm->bat_type->v_to_cap_tbl;
-	tbl_size = di->bm->bat_type->n_v_cap_tbl_elements;
-
-	for (i = 0; i < tbl_size; ++i) {
-		if (voltage > tbl[i].voltage)
-			break;
-	}
-
-	if ((i > 0) && (i < tbl_size)) {
-		cap = fixp_linear_interpolate(
-			tbl[i].voltage,
-			tbl[i].capacity * 10,
-			tbl[i-1].voltage,
-			tbl[i-1].capacity * 10,
-			voltage);
-	} else if (i == 0) {
-		cap = 1000;
-	} else {
-		cap = 0;
-	}
-
-	dev_dbg(di->dev, "%s Vbat: %d, Cap: %d per mille",
-		__func__, voltage, cap);
+	struct power_supply_battery_info *bi = &di->bm->bi;
 
-	return cap;
+	/* Multiply by 10 because the capacity is tracked in per mille */
+	return power_supply_batinfo_ocv2cap(bi, voltage_uv, di->bat_temp) *  10;
 }
 
 /**
@@ -892,8 +867,8 @@ static int ab8500_fg_volt_to_capacity(struct ab8500_fg *di, int voltage)
  */
 static int ab8500_fg_uncomp_volt_to_capacity(struct ab8500_fg *di)
 {
-	di->vbat = ab8500_fg_bat_voltage(di);
-	return ab8500_fg_volt_to_capacity(di, di->vbat);
+	di->vbat_uv = ab8500_fg_bat_voltage(di);
+	return ab8500_fg_volt_to_capacity(di, di->vbat_uv);
 }
 
 /**
@@ -941,31 +916,34 @@ static int ab8500_fg_battery_resistance(struct ab8500_fg *di)
  */
 static int ab8500_fg_load_comp_volt_to_capacity(struct ab8500_fg *di)
 {
-	int vbat_comp, res;
+	int vbat_comp_uv, res;
 	int i = 0;
-	int vbat = 0;
+	int vbat_uv = 0;
 
 	ab8500_fg_inst_curr_start(di);
 
 	do {
-		vbat += ab8500_fg_bat_voltage(di);
+		vbat_uv += ab8500_fg_bat_voltage(di);
 		i++;
 		usleep_range(5000, 6000);
 	} while (!ab8500_fg_inst_curr_done(di));
 
-	ab8500_fg_inst_curr_finalize(di, &di->inst_curr);
+	ab8500_fg_inst_curr_finalize(di, &di->inst_curr_ua);
 
-	di->vbat = vbat / i;
+	di->vbat_uv = vbat_uv / i;
 	res = ab8500_fg_battery_resistance(di);
 
-	/* Use Ohms law to get the load compensated voltage */
-	vbat_comp = di->vbat - (di->inst_curr * res) / 1000;
+	/*
+	 * Use Ohms law to get the load compensated voltage.
+	 * Divide by 1000 to get from milliohms to ohms.
+	 */
+	vbat_comp_uv = di->vbat_uv - (di->inst_curr_ua * res) / 1000;
 
-	dev_dbg(di->dev, "%s Measured Vbat: %dmV,Compensated Vbat %dmV, "
-		"R: %dmOhm, Current: %dmA Vbat Samples: %d\n",
-		__func__, di->vbat, vbat_comp, res, di->inst_curr, i);
+	dev_dbg(di->dev, "%s Measured Vbat: %d uV,Compensated Vbat %d uV, "
+		"R: %d mOhm, Current: %d uA Vbat Samples: %d\n",
+		__func__, di->vbat_uv, vbat_comp_uv, res, di->inst_curr_ua, i);
 
-	return ab8500_fg_volt_to_capacity(di, vbat_comp);
+	return ab8500_fg_volt_to_capacity(di, vbat_comp_uv);
 }
 
 /**
@@ -1052,8 +1030,8 @@ static int ab8500_fg_calc_cap_charging(struct ab8500_fg *di)
 		ab8500_fg_convert_mah_to_permille(di, di->bat_cap.mah);
 
 	/* We need to update battery voltage and inst current when charging */
-	di->vbat = ab8500_fg_bat_voltage(di);
-	di->inst_curr = ab8500_fg_inst_curr_blocking(di);
+	di->vbat_uv = ab8500_fg_bat_voltage(di);
+	di->inst_curr_ua = ab8500_fg_inst_curr_blocking(di);
 
 	return di->bat_cap.mah;
 }
@@ -1580,9 +1558,9 @@ static void ab8500_fg_algorithm_discharging(struct ab8500_fg *di)
 		 * RECOVERY_SLEEP if time left.
 		 * If high, go to READOUT
 		 */
-		di->inst_curr = ab8500_fg_inst_curr_blocking(di);
+		di->inst_curr_ua = ab8500_fg_inst_curr_blocking(di);
 
-		if (ab8500_fg_is_low_curr(di, di->inst_curr)) {
+		if (ab8500_fg_is_low_curr(di, di->inst_curr_ua)) {
 			if (di->recovery_cnt >
 				di->bm->fg_params->recovery_total_time) {
 				di->fg_samples = SEC_TO_SAMPLE(
@@ -1615,9 +1593,9 @@ static void ab8500_fg_algorithm_discharging(struct ab8500_fg *di)
 		break;
 
 	case AB8500_FG_DISCHARGE_READOUT:
-		di->inst_curr = ab8500_fg_inst_curr_blocking(di);
+		di->inst_curr_ua = ab8500_fg_inst_curr_blocking(di);
 
-		if (ab8500_fg_is_low_curr(di, di->inst_curr)) {
+		if (ab8500_fg_is_low_curr(di, di->inst_curr_ua)) {
 			/* Detect mode change */
 			if (di->high_curr_mode) {
 				di->high_curr_mode = false;
@@ -1763,9 +1741,9 @@ static void ab8500_fg_algorithm(struct ab8500_fg *di)
 		di->bat_cap.prev_mah,
 		di->bat_cap.prev_percent,
 		di->bat_cap.prev_level,
-		di->vbat,
-		di->inst_curr,
-		di->avg_curr,
+		di->vbat_uv,
+		di->inst_curr_ua,
+		di->avg_curr_ua,
 		di->accu_charge,
 		di->flags.charging,
 		di->charge_state,
@@ -1858,15 +1836,15 @@ static void ab8500_fg_check_hw_failure_work(struct work_struct *work)
  */
 static void ab8500_fg_low_bat_work(struct work_struct *work)
 {
-	int vbat;
+	int vbat_uv;
 
 	struct ab8500_fg *di = container_of(work, struct ab8500_fg,
 		fg_low_bat_work.work);
 
-	vbat = ab8500_fg_bat_voltage(di);
+	vbat_uv = ab8500_fg_bat_voltage(di);
 
 	/* Check if LOW_BAT still fulfilled */
-	if (vbat < di->bm->fg_params->lowbat_threshold) {
+	if (vbat_uv < di->bm->fg_params->lowbat_threshold_uv) {
 		/* Is it time to shut down? */
 		if (di->low_bat_cnt < 1) {
 			di->flags.low_bat = true;
@@ -2096,15 +2074,15 @@ static int ab8500_fg_get_property(struct power_supply *psy,
 	switch (psp) {
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 		if (di->flags.bat_ovv)
-			val->intval = BATT_OVV_VALUE * 1000;
+			val->intval = BATT_OVV_VALUE;
 		else
-			val->intval = di->vbat * 1000;
+			val->intval = di->vbat_uv;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		val->intval = di->inst_curr * 1000;
+		val->intval = di->inst_curr_ua;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_AVG:
-		val->intval = di->avg_curr * 1000;
+		val->intval = di->avg_curr_ua;
 		break;
 	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
 		val->intval = ab8500_fg_convert_mah_to_uwh(di,
@@ -2310,7 +2288,7 @@ static int ab8500_fg_init_hw_registers(struct ab8500_fg *di)
 		AB8500_SYS_CTRL2_BLOCK,
 		AB8500_LOW_BAT_REG,
 		ab8500_volt_to_regval(
-			di->bm->fg_params->lowbat_threshold) << 1 |
+			di->bm->fg_params->lowbat_threshold_uv) << 1 |
 		LOW_BAT_ENABLE);
 	if (ret) {
 		dev_err(di->dev, "%s write failed\n", __func__);
-- 
2.31.1

