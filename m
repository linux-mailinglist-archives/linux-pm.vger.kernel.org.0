Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6833C733A
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jul 2021 17:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237097AbhGMPcN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jul 2021 11:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237095AbhGMPcM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jul 2021 11:32:12 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24716C0613E9
        for <linux-pm@vger.kernel.org>; Tue, 13 Jul 2021 08:29:22 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id n14so50964187lfu.8
        for <linux-pm@vger.kernel.org>; Tue, 13 Jul 2021 08:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LmxdaGsAsudey2ufxDHAxSAjpnXiJVfRjociqDoVWnE=;
        b=jfJyLn0LdyUPw477v1S6i453LdyNff1v3+fvnTRFIXA+iK/FXsJuRI24VDSHxLqMsm
         AUsPJqVN8l9oB5WlIlV5kL1Vos+LB5wsaDDmcHDtROCmBm6y4EEREKo0FPsL5Gv2zuWJ
         X5C4fpH3R0BXRN3kxSYphACThVvzw5xmzWYpBoCpukvclk2HqBbEsY0+rYcNqyf0Xb78
         CqNoHEs+jXvaPC2QQkcItdNoqmtYNDWj1wOLmJmEJKaXR8Qc440l8xldM2c+cV1KClYS
         sN+0bcBoChv+cj7qzX07dz8LKqbOpXiWYmQUxEDGmCeYCvWJxnrIeirM6IMYp4vuI4Yv
         TbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LmxdaGsAsudey2ufxDHAxSAjpnXiJVfRjociqDoVWnE=;
        b=OQe8saytha2+nj/DLnWJhgpsBv5rRPQuz6ujtx8XcOYOVO7fZrHnn2crXkHRN6jPA0
         IAIGtCxWc52av/OwW3V9OySdur4EGhY36SIsAd9OeAJyVbd7S9y0b5XxovmBDolMI8r3
         8NE2rlBpOhX7dUys7CR8WYNy4EFmDgc1QRaGcvxxa0nyRGPmqOvSXx1rL6VV66U6iXqY
         uhOupM5MwkS4KFUIgN8jOBPrzsLlyabwPVq7Kc5GgVDRVNf8dBX1Rgsj6Ghxajzo9XqL
         bfi1+FM/xdA+A0On3Qi/Nh09K8thVjkM6tEwvuCE0L0kYkGHGEZ9Q7rMDH1V0pSg0Y7d
         r9Ig==
X-Gm-Message-State: AOAM530oJGiE9D0K1HsB0UeWJnLAo3FEYAWQNTPcJBM88za7SYCERTxG
        Qs9TJi+qF1T98eoJ61jVwXMovA==
X-Google-Smtp-Source: ABdhPJweaLq4K395iqxvdo1xZlv2Q+gySebwCzGqzrQhDfKgSS+Xc3laOXZ+KPptqC803hmoklcSsQ==
X-Received: by 2002:a19:e04a:: with SMTP id g10mr4011103lfj.561.1626190159552;
        Tue, 13 Jul 2021 08:29:19 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id d8sm827395ljg.86.2021.07.13.08.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 08:29:19 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/5] power: supply: ab8500: Drop abx500 concept
Date:   Tue, 13 Jul 2021 17:27:07 +0200
Message-Id: <20210713152709.871833-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210713152709.871833-1-linus.walleij@linaro.org>
References: <20210713152709.871833-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Drop the entire idea with abx500 being abstract and different from ab8500
in the AB8500 charging drivers. This rids the two identical definitions
of a slew of structs in ab8500-bm.h and makes things less confusion and
easier to understand.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500-bm.h       | 217 ++++---------------------
 drivers/power/supply/ab8500_bmdata.c   |  32 ++--
 drivers/power/supply/ab8500_btemp.c    |  16 +-
 drivers/power/supply/ab8500_chargalg.c |   2 +-
 drivers/power/supply/ab8500_charger.c  |   2 +-
 drivers/power/supply/ab8500_fg.c       |   6 +-
 6 files changed, 61 insertions(+), 214 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index 4e417fbae60c..d11405b7ee1a 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -269,43 +269,43 @@ enum bup_vch_sel {
 
 /*
  * ADC for the battery thermistor.
- * When using the ABx500_ADC_THERM_BATCTRL the battery ID resistor is combined
+ * When using the AB8500_ADC_THERM_BATCTRL the battery ID resistor is combined
  * with a NTC resistor to both identify the battery and to measure its
  * temperature. Different phone manufactures uses different techniques to both
  * identify the battery and to read its temperature.
  */
-enum abx500_adc_therm {
-	ABx500_ADC_THERM_BATCTRL,
-	ABx500_ADC_THERM_BATTEMP,
+enum ab8500_adc_therm {
+	AB8500_ADC_THERM_BATCTRL,
+	AB8500_ADC_THERM_BATTEMP,
 };
 
 /**
- * struct abx500_res_to_temp - defines one point in a temp to res curve. To
+ * struct ab8500_res_to_temp - defines one point in a temp to res curve. To
  * be used in battery packs that combines the identification resistor with a
  * NTC resistor.
  * @temp:			battery pack temperature in Celsius
  * @resist:			NTC resistor net total resistance
  */
-struct abx500_res_to_temp {
+struct ab8500_res_to_temp {
 	int temp;
 	int resist;
 };
 
 /**
- * struct abx500_v_to_cap - Table for translating voltage to capacity
+ * struct ab8500_v_to_cap - Table for translating voltage to capacity
  * @voltage:		Voltage in mV
  * @capacity:		Capacity in percent
  */
-struct abx500_v_to_cap {
+struct ab8500_v_to_cap {
 	int voltage;
 	int capacity;
 };
 
 /* Forward declaration */
-struct abx500_fg;
+struct ab8500_fg;
 
 /**
- * struct abx500_fg_parameters - Fuel gauge algorithm parameters, in seconds
+ * struct ab8500_fg_parameters - Fuel gauge algorithm parameters, in seconds
  * if not specified
  * @recovery_sleep_timer:	Time between measurements while recovering
  * @recovery_total_time:	Total recovery time
@@ -333,7 +333,7 @@ struct abx500_fg;
  * @pcut_max_restart:		Max number of restarts
  * @pcut_debounce_time:		Sets battery debounce time
  */
-struct abx500_fg_parameters {
+struct ab8500_fg_parameters {
 	int recovery_sleep_timer;
 	int recovery_total_time;
 	int init_timer;
@@ -357,13 +357,13 @@ struct abx500_fg_parameters {
 };
 
 /**
- * struct abx500_charger_maximization - struct used by the board config.
+ * struct ab8500_charger_maximization - struct used by the board config.
  * @use_maxi:		Enable maximization for this battery type
  * @maxi_chg_curr:	Maximum charger current allowed
  * @maxi_wait_cycles:	cycles to wait before setting charger current
  * @charger_curr_step	delta between two charger current settings (mA)
  */
-struct abx500_maxim_parameters {
+struct ab8500_maxim_parameters {
 	bool ena_maxi;
 	int chg_curr;
 	int wait_cycles;
@@ -371,7 +371,7 @@ struct abx500_maxim_parameters {
 };
 
 /**
- * struct abx500_battery_type - different batteries supported
+ * struct ab8500_battery_type - different batteries supported
  * @name:			battery technology
  * @resis_high:			battery upper resistance limit
  * @resis_low:			battery lower resistance limit
@@ -400,7 +400,7 @@ struct abx500_maxim_parameters {
  * @n_batres_tbl_elements	number of elements in the batres_tbl
  * @batres_tbl			battery internal resistance vs temperature table
  */
-struct abx500_battery_type {
+struct ab8500_battery_type {
 	int name;
 	int resis_high;
 	int resis_low;
@@ -421,22 +421,22 @@ struct abx500_battery_type {
 	int low_high_vol_lvl;
 	int battery_resistance;
 	int n_temp_tbl_elements;
-	const struct abx500_res_to_temp *r_to_t_tbl;
+	const struct ab8500_res_to_temp *r_to_t_tbl;
 	int n_v_cap_tbl_elements;
-	const struct abx500_v_to_cap *v_to_cap_tbl;
+	const struct ab8500_v_to_cap *v_to_cap_tbl;
 	int n_batres_tbl_elements;
 	const struct batres_vs_temp *batres_tbl;
 };
 
 /**
- * struct abx500_bm_capacity_levels - abx500 capacity level data
+ * struct ab8500_bm_capacity_levels - ab8500 capacity level data
  * @critical:		critical capacity level in percent
  * @low:		low capacity level in percent
  * @normal:		normal capacity level in percent
  * @high:		high capacity level in percent
  * @full:		full capacity level in percent
  */
-struct abx500_bm_capacity_levels {
+struct ab8500_bm_capacity_levels {
 	int critical;
 	int low;
 	int normal;
@@ -445,13 +445,13 @@ struct abx500_bm_capacity_levels {
 };
 
 /**
- * struct abx500_bm_charger_parameters - Charger specific parameters
+ * struct ab8500_bm_charger_parameters - Charger specific parameters
  * @usb_volt_max:	maximum allowed USB charger voltage in mV
  * @usb_curr_max:	maximum allowed USB charger current in mA
  * @ac_volt_max:	maximum allowed AC charger voltage in mV
  * @ac_curr_max:	maximum allowed AC charger current in mA
  */
-struct abx500_bm_charger_parameters {
+struct ab8500_bm_charger_parameters {
 	int usb_volt_max;
 	int usb_curr_max;
 	int ac_volt_max;
@@ -459,7 +459,7 @@ struct abx500_bm_charger_parameters {
 };
 
 /**
- * struct abx500_bm_data - abx500 battery management data
+ * struct ab8500_bm_data - ab8500 battery management data
  * @temp_under		under this temp, charging is stopped
  * @temp_low		between this temp and temp_under charging is reduced
  * @temp_high		between this temp and temp_over charging is reduced
@@ -473,7 +473,7 @@ struct abx500_bm_charger_parameters {
  * @bkup_bat_i		current which we charge the backup battery with
  * @no_maintenance	indicates that maintenance charging is disabled
  * @capacity_scaling    indicates whether capacity scaling is to be used
- * @abx500_adc_therm	placement of thermistor, batctrl or battemp adc
+ * @ab8500_adc_therm	placement of thermistor, batctrl or battemp adc
  * @chg_unknown_bat	flag to enable charging of unknown batteries
  * @enable_overshoot	flag to enable VBAT overshoot control
  * @auto_trig		flag to enable auto adc trigger
@@ -494,7 +494,7 @@ struct abx500_bm_charger_parameters {
  * @chg_params		charger parameters
  * @fg_params		fuel gauge parameters
  */
-struct abx500_bm_data {
+struct ab8500_bm_data {
 	int temp_under;
 	int temp_low;
 	int temp_high;
@@ -511,7 +511,7 @@ struct abx500_bm_data {
 	bool chg_unknown_bat;
 	bool enable_overshoot;
 	bool auto_trig;
-	enum abx500_adc_therm adc_therm;
+	enum ab8500_adc_therm adc_therm;
 	int fg_res;
 	int n_btypes;
 	int batt_id;
@@ -523,11 +523,11 @@ struct abx500_bm_data {
 	int n_chg_in_curr;
 	int *chg_output_curr;
 	int *chg_input_curr;
-	const struct abx500_maxim_parameters *maxi;
-	const struct abx500_bm_capacity_levels *cap_levels;
-	struct abx500_battery_type *bat_type;
-	const struct abx500_bm_charger_parameters *chg_params;
-	const struct abx500_fg_parameters *fg_params;
+	const struct ab8500_maxim_parameters *maxi;
+	const struct ab8500_bm_capacity_levels *cap_levels;
+	struct ab8500_battery_type *bat_type;
+	const struct ab8500_bm_charger_parameters *chg_params;
+	const struct ab8500_fg_parameters *fg_params;
 };
 
 enum {
@@ -561,160 +561,7 @@ struct batres_vs_temp {
 /* Forward declaration */
 struct ab8500_fg;
 
-/**
- * struct ab8500_fg_parameters - Fuel gauge algorithm parameters, in seconds
- * if not specified
- * @recovery_sleep_timer:	Time between measurements while recovering
- * @recovery_total_time:	Total recovery time
- * @init_timer:			Measurement interval during startup
- * @init_discard_time:		Time we discard voltage measurement at startup
- * @init_total_time:		Total init time during startup
- * @high_curr_time:		Time current has to be high to go to recovery
- * @accu_charging:		FG accumulation time while charging
- * @accu_high_curr:		FG accumulation time in high current mode
- * @high_curr_threshold:	High current threshold, in mA
- * @lowbat_threshold:		Low battery threshold, in mV
- * @battok_falling_th_sel0	Threshold in mV for battOk signal sel0
- *				Resolution in 50 mV step.
- * @battok_raising_th_sel1	Threshold in mV for battOk signal sel1
- *				Resolution in 50 mV step.
- * @user_cap_limit		Capacity reported from user must be within this
- *				limit to be considered as sane, in percentage
- *				points.
- * @maint_thres			This is the threshold where we stop reporting
- *				battery full while in maintenance, in per cent
- * @pcut_enable:			Enable power cut feature in ab8505
- * @pcut_max_time:		Max time threshold
- * @pcut_flag_time:		Flagtime threshold
- * @pcut_max_restart:		Max number of restarts
- * @pcut_debunce_time:	Sets battery debounce time
- */
-struct ab8500_fg_parameters {
-	int recovery_sleep_timer;
-	int recovery_total_time;
-	int init_timer;
-	int init_discard_time;
-	int init_total_time;
-	int high_curr_time;
-	int accu_charging;
-	int accu_high_curr;
-	int high_curr_threshold;
-	int lowbat_threshold;
-	int battok_falling_th_sel0;
-	int battok_raising_th_sel1;
-	int user_cap_limit;
-	int maint_thres;
-	bool pcut_enable;
-	u8 pcut_max_time;
-	u8 pcut_flag_time;
-	u8 pcut_max_restart;
-	u8 pcut_debunce_time;
-};
-
-/**
- * struct ab8500_charger_maximization - struct used by the board config.
- * @use_maxi:		Enable maximization for this battery type
- * @maxi_chg_curr:	Maximum charger current allowed
- * @maxi_wait_cycles:	cycles to wait before setting charger current
- * @charger_curr_step	delta between two charger current settings (mA)
- */
-struct ab8500_maxim_parameters {
-	bool ena_maxi;
-	int chg_curr;
-	int wait_cycles;
-	int charger_curr_step;
-};
-
-/**
- * struct ab8500_bm_capacity_levels - ab8500 capacity level data
- * @critical:		critical capacity level in percent
- * @low:		low capacity level in percent
- * @normal:		normal capacity level in percent
- * @high:		high capacity level in percent
- * @full:		full capacity level in percent
- */
-struct ab8500_bm_capacity_levels {
-	int critical;
-	int low;
-	int normal;
-	int high;
-	int full;
-};
-
-/**
- * struct ab8500_bm_charger_parameters - Charger specific parameters
- * @usb_volt_max:	maximum allowed USB charger voltage in mV
- * @usb_curr_max:	maximum allowed USB charger current in mA
- * @ac_volt_max:	maximum allowed AC charger voltage in mV
- * @ac_curr_max:	maximum allowed AC charger current in mA
- */
-struct ab8500_bm_charger_parameters {
-	int usb_volt_max;
-	int usb_curr_max;
-	int ac_volt_max;
-	int ac_curr_max;
-};
-
-/**
- * struct ab8500_bm_data - ab8500 battery management data
- * @temp_under		under this temp, charging is stopped
- * @temp_low		between this temp and temp_under charging is reduced
- * @temp_high		between this temp and temp_over charging is reduced
- * @temp_over		over this temp, charging is stopped
- * @temp_interval_chg	temperature measurement interval in s when charging
- * @temp_interval_nochg	temperature measurement interval in s when not charging
- * @main_safety_tmr_h	safety timer for main charger
- * @usb_safety_tmr_h	safety timer for usb charger
- * @bkup_bat_v		voltage which we charge the backup battery with
- * @bkup_bat_i		current which we charge the backup battery with
- * @no_maintenance	indicates that maintenance charging is disabled
- * @capacity_scaling    indicates whether capacity scaling is to be used
- * @adc_therm		placement of thermistor, batctrl or battemp adc
- * @chg_unknown_bat	flag to enable charging of unknown batteries
- * @enable_overshoot	flag to enable VBAT overshoot control
- * @fg_res		resistance of FG resistor in 0.1mOhm
- * @n_btypes		number of elements in array bat_type
- * @batt_id		index of the identified battery in array bat_type
- * @interval_charging	charge alg cycle period time when charging (sec)
- * @interval_not_charging charge alg cycle period time when not charging (sec)
- * @temp_hysteresis	temperature hysteresis
- * @gnd_lift_resistance	Battery ground to phone ground resistance (mOhm)
- * @maxi:		maximization parameters
- * @cap_levels		capacity in percent for the different capacity levels
- * @bat_type		table of supported battery types
- * @chg_params		charger parameters
- * @fg_params		fuel gauge parameters
- */
-struct ab8500_bm_data {
-	int temp_under;
-	int temp_low;
-	int temp_high;
-	int temp_over;
-	int temp_interval_chg;
-	int temp_interval_nochg;
-	int main_safety_tmr_h;
-	int usb_safety_tmr_h;
-	int bkup_bat_v;
-	int bkup_bat_i;
-	bool no_maintenance;
-	bool capacity_scaling;
-	bool chg_unknown_bat;
-	bool enable_overshoot;
-	enum abx500_adc_therm adc_therm;
-	int fg_res;
-	int n_btypes;
-	int batt_id;
-	int interval_charging;
-	int interval_not_charging;
-	int temp_hysteresis;
-	int gnd_lift_resistance;
-	const struct ab8500_maxim_parameters *maxi;
-	const struct ab8500_bm_capacity_levels *cap_levels;
-	const struct ab8500_bm_charger_parameters *chg_params;
-	const struct ab8500_fg_parameters *fg_params;
-};
-
-extern struct abx500_bm_data ab8500_bm_data;
+extern struct ab8500_bm_data ab8500_bm_data;
 
 void ab8500_charger_usb_state_changed(u8 bm_usb_state, u16 mA);
 struct ab8500_fg *ab8500_fg_get(void);
@@ -725,7 +572,7 @@ int ab8500_fg_inst_curr_started(struct ab8500_fg *di);
 int ab8500_fg_inst_curr_done(struct ab8500_fg *di);
 int ab8500_bm_of_probe(struct device *dev,
 		       struct device_node *np,
-		       struct abx500_bm_data *bm);
+		       struct ab8500_bm_data *bm);
 
 extern struct platform_driver ab8500_fg_driver;
 extern struct platform_driver ab8500_btemp_driver;
diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index c2b8c0bb77e2..f705c19ef359 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -13,7 +13,7 @@
  * Note that the res_to_temp table must be strictly sorted by falling resistance
  * values to work.
  */
-const struct abx500_res_to_temp ab8500_temp_tbl_a_thermistor[] = {
+const struct ab8500_res_to_temp ab8500_temp_tbl_a_thermistor[] = {
 	{-5, 53407},
 	{ 0, 48594},
 	{ 5, 43804},
@@ -35,7 +35,7 @@ EXPORT_SYMBOL(ab8500_temp_tbl_a_thermistor);
 const int ab8500_temp_tbl_a_size = ARRAY_SIZE(ab8500_temp_tbl_a_thermistor);
 EXPORT_SYMBOL(ab8500_temp_tbl_a_size);
 
-const struct abx500_res_to_temp ab8500_temp_tbl_b_thermistor[] = {
+const struct ab8500_res_to_temp ab8500_temp_tbl_b_thermistor[] = {
 	{-5, 200000},
 	{ 0, 159024},
 	{ 5, 151921},
@@ -57,7 +57,7 @@ EXPORT_SYMBOL(ab8500_temp_tbl_b_thermistor);
 const int ab8500_temp_tbl_b_size = ARRAY_SIZE(ab8500_temp_tbl_b_thermistor);
 EXPORT_SYMBOL(ab8500_temp_tbl_b_size);
 
-static const struct abx500_v_to_cap cap_tbl_a_thermistor[] = {
+static const struct ab8500_v_to_cap cap_tbl_a_thermistor[] = {
 	{4171,	100},
 	{4114,	 95},
 	{4009,	 83},
@@ -80,7 +80,7 @@ static const struct abx500_v_to_cap cap_tbl_a_thermistor[] = {
 	{3247,	  0},
 };
 
-static const struct abx500_v_to_cap cap_tbl_b_thermistor[] = {
+static const struct ab8500_v_to_cap cap_tbl_b_thermistor[] = {
 	{4161,	100},
 	{4124,	 98},
 	{4044,	 90},
@@ -103,7 +103,7 @@ static const struct abx500_v_to_cap cap_tbl_b_thermistor[] = {
 	{3250,	  0},
 };
 
-static const struct abx500_v_to_cap cap_tbl[] = {
+static const struct ab8500_v_to_cap cap_tbl[] = {
 	{4186,	100},
 	{4163,	 99},
 	{4114,	 95},
@@ -134,7 +134,7 @@ static const struct abx500_v_to_cap cap_tbl[] = {
  * Note that the res_to_temp table must be strictly sorted by falling
  * resistance values to work.
  */
-static const struct abx500_res_to_temp temp_tbl[] = {
+static const struct ab8500_res_to_temp temp_tbl[] = {
 	{-5, 214834},
 	{ 0, 162943},
 	{ 5, 124820},
@@ -191,7 +191,7 @@ static const struct batres_vs_temp temp_to_batres_tbl_9100[] = {
 	{-20, 180},
 };
 
-static struct abx500_battery_type bat_type_thermistor[] = {
+static struct ab8500_battery_type bat_type_thermistor[] = {
 	[BATTERY_UNKNOWN] = {
 		/* First element always represent the UNKNOWN battery */
 		.name = POWER_SUPPLY_TECHNOLOGY_UNKNOWN,
@@ -277,7 +277,7 @@ static struct abx500_battery_type bat_type_thermistor[] = {
 	},
 };
 
-static struct abx500_battery_type bat_type_ext_thermistor[] = {
+static struct ab8500_battery_type bat_type_ext_thermistor[] = {
 	[BATTERY_UNKNOWN] = {
 		/* First element always represent the UNKNOWN battery */
 		.name = POWER_SUPPLY_TECHNOLOGY_UNKNOWN,
@@ -394,7 +394,7 @@ static struct abx500_battery_type bat_type_ext_thermistor[] = {
 	},
 };
 
-static const struct abx500_bm_capacity_levels cap_levels = {
+static const struct ab8500_bm_capacity_levels cap_levels = {
 	.critical	= 2,
 	.low		= 10,
 	.normal		= 70,
@@ -402,7 +402,7 @@ static const struct abx500_bm_capacity_levels cap_levels = {
 	.full		= 100,
 };
 
-static const struct abx500_fg_parameters fg = {
+static const struct ab8500_fg_parameters fg = {
 	.recovery_sleep_timer = 10,
 	.recovery_total_time = 100,
 	.init_timer = 1,
@@ -424,14 +424,14 @@ static const struct abx500_fg_parameters fg = {
 	.pcut_debounce_time = 2,
 };
 
-static const struct abx500_maxim_parameters ab8500_maxi_params = {
+static const struct ab8500_maxim_parameters ab8500_maxi_params = {
 	.ena_maxi = true,
 	.chg_curr = 910,
 	.wait_cycles = 10,
 	.charger_curr_step = 100,
 };
 
-static const struct abx500_bm_charger_parameters chg = {
+static const struct ab8500_bm_charger_parameters chg = {
 	.usb_volt_max		= 5500,
 	.usb_curr_max		= 1500,
 	.ac_volt_max		= 7500,
@@ -456,7 +456,7 @@ static int ab8500_charge_input_curr_map[] = {
         700,    800,    900,    1000,   1100,   1300,   1400,   1500,
 };
 
-struct abx500_bm_data ab8500_bm_data = {
+struct ab8500_bm_data ab8500_bm_data = {
 	.temp_under             = 3,
 	.temp_low               = 8,
 	.temp_high              = 43,
@@ -469,7 +469,7 @@ struct abx500_bm_data ab8500_bm_data = {
 	.bkup_bat_i             = BUP_ICH_SEL_150UA,
 	.no_maintenance         = false,
 	.capacity_scaling       = false,
-	.adc_therm              = ABx500_ADC_THERM_BATCTRL,
+	.adc_therm              = AB8500_ADC_THERM_BATCTRL,
 	.chg_unknown_bat        = false,
 	.enable_overshoot       = false,
 	.fg_res                 = 100,
@@ -492,7 +492,7 @@ struct abx500_bm_data ab8500_bm_data = {
 
 int ab8500_bm_of_probe(struct device *dev,
 		       struct device_node *np,
-		       struct abx500_bm_data *bm)
+		       struct ab8500_bm_data *bm)
 {
 	const struct batres_vs_temp *tmp_batres_tbl;
 	struct device_node *battery_node;
@@ -531,7 +531,7 @@ int ab8500_bm_of_probe(struct device *dev,
 	} else {
 		bm->n_btypes   = 4;
 		bm->bat_type   = bat_type_ext_thermistor;
-		bm->adc_therm  = ABx500_ADC_THERM_BATTEMP;
+		bm->adc_therm  = AB8500_ADC_THERM_BATTEMP;
 		tmp_batres_tbl = temp_to_batres_tbl_ext_thermistor;
 	}
 
diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 24958b935d39..b6c9111d77d7 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -103,7 +103,7 @@ struct ab8500_btemp {
 	struct iio_channel *btemp_ball;
 	struct iio_channel *bat_ctrl;
 	struct ab8500_fg *fg;
-	struct abx500_bm_data *bm;
+	struct ab8500_bm_data *bm;
 	struct power_supply *btemp_psy;
 	struct ab8500_btemp_events events;
 	struct ab8500_btemp_ranges btemp_ranges;
@@ -145,7 +145,7 @@ static int ab8500_btemp_batctrl_volt_to_res(struct ab8500_btemp *di,
 		return (450000 * (v_batctrl)) / (1800 - v_batctrl);
 	}
 
-	if (di->bm->adc_therm == ABx500_ADC_THERM_BATCTRL) {
+	if (di->bm->adc_therm == AB8500_ADC_THERM_BATCTRL) {
 		/*
 		 * If the battery has internal NTC, we use the current
 		 * source to calculate the resistance.
@@ -207,7 +207,7 @@ static int ab8500_btemp_curr_source_enable(struct ab8500_btemp *di,
 		return 0;
 
 	/* Only do this for batteries with internal NTC */
-	if (di->bm->adc_therm == ABx500_ADC_THERM_BATCTRL && enable) {
+	if (di->bm->adc_therm == AB8500_ADC_THERM_BATCTRL && enable) {
 
 		if (di->curr_source == BTEMP_BATCTRL_CURR_SRC_7UA)
 			curr = BAT_CTRL_7U_ENA;
@@ -240,7 +240,7 @@ static int ab8500_btemp_curr_source_enable(struct ab8500_btemp *di,
 				__func__);
 			goto disable_curr_source;
 		}
-	} else if (di->bm->adc_therm == ABx500_ADC_THERM_BATCTRL && !enable) {
+	} else if (di->bm->adc_therm == AB8500_ADC_THERM_BATCTRL && !enable) {
 		dev_dbg(di->dev, "Disable BATCTRL curr source\n");
 
 		/* Write 0 to the curr bits */
@@ -418,7 +418,7 @@ static int ab8500_btemp_get_batctrl_res(struct ab8500_btemp *di)
  * based on the NTC resistance.
  */
 static int ab8500_btemp_res_to_temp(struct ab8500_btemp *di,
-	const struct abx500_res_to_temp *tbl, int tbl_size, int res)
+	const struct ab8500_res_to_temp *tbl, int tbl_size, int res)
 {
 	int i;
 	/*
@@ -458,7 +458,7 @@ static int ab8500_btemp_measure_temp(struct ab8500_btemp *di)
 
 	id = di->bm->batt_id;
 
-	if (di->bm->adc_therm == ABx500_ADC_THERM_BATCTRL &&
+	if (di->bm->adc_therm == AB8500_ADC_THERM_BATCTRL &&
 			id != BATTERY_UNKNOWN) {
 
 		rbat = ab8500_btemp_get_batctrl_res(di);
@@ -527,7 +527,7 @@ static int ab8500_btemp_id(struct ab8500_btemp *di)
 			dev_dbg(di->dev, "Battery detected on %s"
 				" low %d < res %d < high: %d"
 				" index: %d\n",
-				di->bm->adc_therm == ABx500_ADC_THERM_BATCTRL ?
+				di->bm->adc_therm == AB8500_ADC_THERM_BATCTRL ?
 				"BATCTRL" : "BATTEMP",
 				di->bm->bat_type[i].resis_low, res,
 				di->bm->bat_type[i].resis_high, i);
@@ -547,7 +547,7 @@ static int ab8500_btemp_id(struct ab8500_btemp *di)
 	 * We only have to change current source if the
 	 * detected type is Type 1.
 	 */
-	if (di->bm->adc_therm == ABx500_ADC_THERM_BATCTRL &&
+	if (di->bm->adc_therm == AB8500_ADC_THERM_BATCTRL &&
 	    di->bm->batt_id == 1) {
 		dev_dbg(di->dev, "Set BATCTRL current source to 20uA\n");
 		di->curr_source = BTEMP_BATCTRL_CURR_SRC_20UA;
diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index b0bbb1c4b83a..8dd66eb18fd5 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -249,7 +249,7 @@ struct ab8500_chargalg {
 	struct ab8500_chargalg_suspension_status susp_status;
 	struct ab8500 *parent;
 	struct ab8500_chargalg_current_step_status curr_status;
-	struct abx500_bm_data *bm;
+	struct ab8500_bm_data *bm;
 	struct power_supply *chargalg_psy;
 	struct ux500_charger *ac_chg;
 	struct ux500_charger *usb_chg;
diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index e0d3d6bd8b8c..15eadaf46f14 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -292,7 +292,7 @@ struct ab8500_charger {
 	struct iio_channel *adc_main_charger_c;
 	struct iio_channel *adc_vbus_v;
 	struct iio_channel *adc_usb_charger_c;
-	struct abx500_bm_data *bm;
+	struct ab8500_bm_data *bm;
 	struct ab8500_charger_event_flags flags;
 	struct ab8500_charger_usb_state usb_state;
 	struct ab8500_charger_max_usb_in_curr max_usb_in_curr;
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index bdbf3f13bee0..21bb2fd6725b 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -225,7 +225,7 @@ struct ab8500_fg {
 	struct ab8500_fg_avg_cap avg_cap;
 	struct ab8500 *parent;
 	struct iio_channel *main_bat_v;
-	struct abx500_bm_data *bm;
+	struct ab8500_bm_data *bm;
 	struct power_supply *fg_psy;
 	struct workqueue_struct *fg_wq;
 	struct delayed_work fg_periodic_work;
@@ -854,7 +854,7 @@ static int ab8500_fg_bat_voltage(struct ab8500_fg *di)
 static int ab8500_fg_volt_to_capacity(struct ab8500_fg *di, int voltage)
 {
 	int i, tbl_size;
-	const struct abx500_v_to_cap *tbl;
+	const struct ab8500_v_to_cap *tbl;
 	int cap = 0;
 
 	tbl = di->bm->bat_type[di->bm->batt_id].v_to_cap_tbl;
@@ -2233,7 +2233,7 @@ static int ab8500_fg_get_ext_psy_data(struct device *dev, void *data)
 			case POWER_SUPPLY_TYPE_BATTERY:
 				if (!di->flags.batt_id_received &&
 				    di->bm->batt_id != BATTERY_UNKNOWN) {
-					const struct abx500_battery_type *b;
+					const struct ab8500_battery_type *b;
 
 					b = &(di->bm->bat_type[di->bm->batt_id]);
 
-- 
2.31.1

