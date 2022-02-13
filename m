Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC874B38BE
	for <lists+linux-pm@lfdr.de>; Sun, 13 Feb 2022 01:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiBMAKA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Feb 2022 19:10:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiBMAJ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Feb 2022 19:09:59 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5D95FF3E
        for <linux-pm@vger.kernel.org>; Sat, 12 Feb 2022 16:09:54 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id j7so6282829lfu.6
        for <linux-pm@vger.kernel.org>; Sat, 12 Feb 2022 16:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jINS9FIdxQ0cIVoOC+dPbFBSWaGlxBypL8/WkUNZ1Ek=;
        b=K1iQhmlX5UGDD7BVUiXXo+bDeW5oh8Ne1cnLkcbWJJ9ySbFiMoGuP1Lc9AYLLLeFlA
         MMT5zU8gcsK0BVyOGKNvkcBbhjWTcEbbzAgmlqAZMtTfifiIGOAqWZwnVVGRQnrQ58cr
         pgn0BLQYLUD1F2SOosym1WAqS5LRJUmWRcfD3KYhgmhrPE7gM7wAPLuuHc7iLUIaqjpm
         ++kGzy3y5mzrAaBXH1s2x/PPeSfH/OGTGwtExQWovzRzjlSl3SstrPMnRjH3YuvLYLHT
         eWUkjxRmugVIiXLZTWeL8epuyEBYBfPMvswQeSV8llG10taUe4fmu9BtKg+xpkYqlXPR
         eH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jINS9FIdxQ0cIVoOC+dPbFBSWaGlxBypL8/WkUNZ1Ek=;
        b=jH0wQiBQD8wEee2EKuCkZpAky43R+JslLzVZ2b6WnP6SbuDHfhuz3m89lekm2l2hi4
         te7axRTc1nLeaOiA7kFv1sN025hYaEu4yCoElg0cv0MvnB370naEquq3T0xHypUU4Uvl
         PLsE1XDXZRW9F4QdFP8A6012ErfmA9VIb87/amaYFJU5dtarvPl6lQDN+I7yUyTvSLW6
         3sdk6NL6SyTRXPZZaHgRfUjmAe4kxtI3PCq2fJC+fPnj8RD+8AU2BzBjCEJ1U/yE+kvR
         fULguA09cYRg+vad0aHOEQrHia9xCwKIp/Zc1DhV0G8tJlLSTp9OFnd2o9sfeKMUuGAO
         rErg==
X-Gm-Message-State: AOAM531McPbmW8ugX1uPLR+R/b+EAVAj1Ohh25OqM5ytE6qwRZHO7pSh
        KGllu7uE/abjCmq21nCTeki+qw==
X-Google-Smtp-Source: ABdhPJwj8Mi5GlbjY1fgzlvk3S2harOY2E9lBFWpha3KGdD8ORWUCjw6qtE7JdM3/ZNNpeVV55mMPw==
X-Received: by 2002:a05:6512:b8d:: with SMTP id b13mr5888955lfv.594.1644710992727;
        Sat, 12 Feb 2022 16:09:52 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id g30sm382292lja.39.2022.02.12.16.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 16:09:52 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/6 v2] power: supply: ab8500: Standardize maintenance charging
Date:   Sun, 13 Feb 2022 01:06:58 +0100
Message-Id: <20220213000703.772673-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220213000703.772673-1-linus.walleij@linaro.org>
References: <20220213000703.772673-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Maintenance charging is the phase of keeping up the charge
after the battery has charged fully using CC/CV charging.

This can be done in many successive phases and is usually
done with a slightly lower constant voltage than CV, and
a slightly lower allowed current.

Add an array of maintenance charging points each with a
current, voltage and safety timer, and add helper functions
to use these. Migrate the AB8500 code over.

This is used in several Samsung products using the AB8500
and these batteries and their complete parameters will
be added later as full examples, but the default battery
in the AB8500 code serves as a reasonable example so far.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rename default maintenance charge table ab8500_maint_charg_table
- Mark ab8500_maint_charg_table static
---
 drivers/power/supply/ab8500-bm.h         | 14 ------
 drivers/power/supply/ab8500_bmdata.c     | 27 +++++++---
 drivers/power/supply/ab8500_chargalg.c   | 41 +++++++++++----
 drivers/power/supply/power_supply_core.c | 11 ++++
 include/linux/power_supply.h             | 64 ++++++++++++++++++++++++
 5 files changed, 126 insertions(+), 31 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index 6efd5174dbce..4d74d21cf1eb 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -331,24 +331,12 @@ struct ab8500_maxim_parameters {
  * struct ab8500_battery_type - different batteries supported
  * @resis_high:			battery upper resistance limit
  * @resis_low:			battery lower resistance limit
- * @maint_a_cur_lvl:		charger current in maintenance A state in mA
- * @maint_a_vol_lvl:		charger voltage in maintenance A state in mV
- * @maint_a_chg_timer_h:	charge time in maintenance A state
- * @maint_b_cur_lvl:		charger current in maintenance B state in mA
- * @maint_b_vol_lvl:		charger voltage in maintenance B state in mV
- * @maint_b_chg_timer_h:	charge time in maintenance B state
  * @low_high_cur_lvl:		charger current in temp low/high state in mA
  * @low_high_vol_lvl:		charger voltage in temp low/high state in mV'
  */
 struct ab8500_battery_type {
 	int resis_high;
 	int resis_low;
-	int maint_a_cur_lvl;
-	int maint_a_vol_lvl;
-	int maint_a_chg_timer_h;
-	int maint_b_cur_lvl;
-	int maint_b_vol_lvl;
-	int maint_b_chg_timer_h;
 	int low_high_cur_lvl;
 	int low_high_vol_lvl;
 };
@@ -393,7 +381,6 @@ struct ab8500_bm_charger_parameters {
  * @usb_safety_tmr_h	safety timer for usb charger
  * @bkup_bat_v		voltage which we charge the backup battery with
  * @bkup_bat_i		current which we charge the backup battery with
- * @no_maintenance	indicates that maintenance charging is disabled
  * @capacity_scaling    indicates whether capacity scaling is to be used
  * @chg_unknown_bat	flag to enable charging of unknown batteries
  * @enable_overshoot	flag to enable VBAT overshoot control
@@ -417,7 +404,6 @@ struct ab8500_bm_data {
 	int usb_safety_tmr_h;
 	int bkup_bat_v;
 	int bkup_bat_i;
-	bool no_maintenance;
 	bool capacity_scaling;
 	bool chg_unknown_bat;
 	bool enable_overshoot;
diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index d8fc72be0f0e..66a454942c7c 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -58,16 +58,25 @@ static struct power_supply_resistance_temp_table temp_to_batres_tbl_thermistor[]
 	{ .temp = -20, .resistance = 198 /* 595 mOhm */ },
 };
 
+static struct power_supply_maintenance_charge_table ab8500_maint_charg_table[] = {
+	{
+		/* Maintenance charging phase A, 60 hours */
+		.charge_current_max_ua = 400000,
+		.charge_voltage_max_uv = 4050000,
+		.charge_safety_timer_minutes = 60*60,
+	},
+	{
+		/* Maintenance charging phase B, 200 hours */
+		.charge_current_max_ua = 400000,
+		.charge_voltage_max_uv = 4000000,
+		.charge_safety_timer_minutes = 200*60,
+	}
+};
+
 /* Default battery type for reference designs is the unknown type */
 static struct ab8500_battery_type bat_type_thermistor_unknown = {
 	.resis_high = 0,
 	.resis_low = 0,
-	.maint_a_cur_lvl = 400,
-	.maint_a_vol_lvl = 4050,
-	.maint_a_chg_timer_h = 60,
-	.maint_b_cur_lvl = 400,
-	.maint_b_vol_lvl = 4000,
-	.maint_b_chg_timer_h = 200,
 	.low_high_cur_lvl = 300,
 	.low_high_vol_lvl = 4000,
 };
@@ -124,7 +133,6 @@ struct ab8500_bm_data ab8500_bm_data = {
 	.usb_safety_tmr_h       = 4,
 	.bkup_bat_v             = BUP_VCH_SEL_2P6V,
 	.bkup_bat_i             = BUP_ICH_SEL_150UA,
-	.no_maintenance         = false,
 	.capacity_scaling       = false,
 	.chg_unknown_bat        = false,
 	.enable_overshoot       = false,
@@ -179,6 +187,11 @@ int ab8500_bm_of_probe(struct power_supply *psy,
 		/* Charging stops when we drop below this current */
 		bi->charge_term_current_ua = 200000;
 
+	if (!bi->maintenance_charge || !bi->maintenance_charge_size) {
+		bi->maintenance_charge = ab8500_maint_charg_table;
+		bi->maintenance_charge_size = ARRAY_SIZE(ab8500_maint_charg_table);
+	}
+
 	/*
 	 * Internal resistance and factory resistance are tightly coupled
 	 * so both MUST be defined or we fall back to defaults.
diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index b5a3096e78a1..6054996b6260 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -430,7 +430,7 @@ static void ab8500_chargalg_stop_safety_timer(struct ab8500_chargalg *di)
 /**
  * ab8500_chargalg_start_maintenance_timer() - Start charging maintenance timer
  * @di:		pointer to the ab8500_chargalg structure
- * @duration:	duration of ther maintenance timer in hours
+ * @duration:	duration of ther maintenance timer in minutes
  *
  * The maintenance timer is used to maintain the charge in the battery once
  * the battery is considered full. These timers are chosen to match the
@@ -439,9 +439,10 @@ static void ab8500_chargalg_stop_safety_timer(struct ab8500_chargalg *di)
 static void ab8500_chargalg_start_maintenance_timer(struct ab8500_chargalg *di,
 	int duration)
 {
+	/* Set a timer in minutes with a 30 second range */
 	hrtimer_set_expires_range(&di->maintenance_timer,
-		ktime_set(duration * ONE_HOUR_IN_SECONDS, 0),
-		ktime_set(FIVE_MINUTES_IN_SECONDS, 0));
+		ktime_set(duration * 60, 0),
+		ktime_set(30, 0));
 	di->events.maintenance_timer_expired = false;
 	hrtimer_start_expires(&di->maintenance_timer, HRTIMER_MODE_REL);
 }
@@ -1223,6 +1224,7 @@ static void ab8500_chargalg_external_power_changed(struct power_supply *psy)
 static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 {
 	struct power_supply_battery_info *bi = di->bm->bi;
+	struct power_supply_maintenance_charge_table *mt;
 	int charger_status;
 	int ret;
 
@@ -1433,7 +1435,12 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 		handle_maxim_chg_curr(di);
 		if (di->charge_status == POWER_SUPPLY_STATUS_FULL &&
 			di->maintenance_chg) {
-			if (di->bm->no_maintenance)
+			/*
+			 * The battery is fully charged, check if we support
+			 * maintenance charging else go back to waiting for
+			 * the recharge voltage limit.
+			 */
+			if (!power_supply_supports_maintenance_charging(bi))
 				ab8500_chargalg_state_to(di,
 					STATE_WAIT_FOR_RECHARGE_INIT);
 			else
@@ -1454,12 +1461,19 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 		break;
 
 	case STATE_MAINTENANCE_A_INIT:
+		mt = power_supply_get_maintenance_charging_setting(bi, 0);
+		if (!mt) {
+			/* No maintenance A state, go back to normal */
+			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
+			power_supply_changed(di->chargalg_psy);
+			break;
+		}
 		ab8500_chargalg_stop_safety_timer(di);
 		ab8500_chargalg_start_maintenance_timer(di,
-			di->bm->bat_type->maint_a_chg_timer_h);
+			mt->charge_safety_timer_minutes);
 		ab8500_chargalg_start_charging(di,
-			di->bm->bat_type->maint_a_vol_lvl,
-			di->bm->bat_type->maint_a_cur_lvl);
+			mt->charge_voltage_max_uv,
+			mt->charge_current_max_ua);
 		ab8500_chargalg_state_to(di, STATE_MAINTENANCE_A);
 		power_supply_changed(di->chargalg_psy);
 		fallthrough;
@@ -1472,11 +1486,18 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 		break;
 
 	case STATE_MAINTENANCE_B_INIT:
+		mt = power_supply_get_maintenance_charging_setting(bi, 1);
+		if (!mt) {
+			/* No maintenance B state, go back to normal */
+			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
+			power_supply_changed(di->chargalg_psy);
+			break;
+		}
 		ab8500_chargalg_start_maintenance_timer(di,
-			di->bm->bat_type->maint_b_chg_timer_h);
+			mt->charge_safety_timer_minutes);
 		ab8500_chargalg_start_charging(di,
-			di->bm->bat_type->maint_b_vol_lvl,
-			di->bm->bat_type->maint_b_cur_lvl);
+			mt->charge_voltage_max_uv,
+			mt->charge_current_max_ua);
 		ab8500_chargalg_state_to(di, STATE_MAINTENANCE_B);
 		power_supply_changed(di->chargalg_psy);
 		fallthrough;
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index ec838c9bcc0a..6568939e4518 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -590,6 +590,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	info->precharge_voltage_max_uv       = -EINVAL;
 	info->charge_restart_voltage_uv      = -EINVAL;
 	info->overvoltage_limit_uv           = -EINVAL;
+	info->maintenance_charge             = NULL;
 	info->temp_ambient_alert_min         = INT_MIN;
 	info->temp_ambient_alert_max         = INT_MAX;
 	info->temp_alert_min                 = INT_MIN;
@@ -821,6 +822,16 @@ int power_supply_temp2resist_simple(struct power_supply_resistance_temp_table *t
 }
 EXPORT_SYMBOL_GPL(power_supply_temp2resist_simple);
 
+struct power_supply_maintenance_charge_table *
+power_supply_get_maintenance_charging_setting(struct power_supply_battery_info *info,
+					      int index)
+{
+	if (index >= info->maintenance_charge_size)
+		return NULL;
+	return &info->maintenance_charge[index];
+}
+EXPORT_SYMBOL_GPL(power_supply_get_maintenance_charging_setting);
+
 /**
  * power_supply_ocv2cap_simple() - find the battery capacity
  * @table: Pointer to battery OCV lookup table
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index e218041cc000..b998fc4c87ae 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -348,6 +348,52 @@ struct power_supply_resistance_temp_table {
 	int resistance;	/* internal resistance percent */
 };
 
+/**
+ * struct power_supply_maintenance_charge_table - setting for maintenace charging
+ * @charge_current_max_ua: maintenance charging current that is used to keep
+ *   the charge of the battery full as current is consumed after full charging.
+ *   The corresponding charge_voltage_max_uv is used as a safeguard: when we
+ *   reach this voltage the maintenance charging current is turned off. It is
+ *   turned back on if we fall below this voltage.
+ * @charge_voltage_max_uv: maintenance charging voltage that is usually a bit
+ *   lower than the constant_charge_voltage_max_uv. We can apply this settings
+ *   charge_current_max_ua until we get back up to this voltage.
+ * @safety_timer_minutes: maintenance charging safety timer, with an expiry
+ *   time in minutes. We will only use maintenance charging in this setting
+ *   for a certain amount of time, then we will first move to the next
+ *   maintenance charge current and voltage pair in respective array and wait
+ *   for the next safety timer timeout, or, if we reached the last maintencance
+ *   charging setting, disable charging until we reach
+ *   charge_restart_voltage_uv and restart ordinary CC/CV charging from there.
+ *   These timers should be chosen to align with the typical discharge curve
+ *   for the battery.
+ *
+ * When the main CC/CV charging is complete the battery can optionally be
+ * maintenance charged at the voltages from this table: a table of settings is
+ * traversed using a slightly lower current and voltage than what is used for
+ * CC/CV charging. The maintenance charging will for safety reasons not go on
+ * indefinately: we lower the current and voltage with successive maintenance
+ * settings, then disable charging completely after we reach the last one,
+ * and after that we do not restart charging until we reach
+ * charge_restart_voltage_uv (see struct power_supply_battery_info) and restart
+ * ordinary CC/CV charging from there.
+ *
+ * As an example, a Samsung EB425161LA Lithium-Ion battery is CC/CV charged
+ * at 900mA to 4340mV, then maintenance charged at 600mA and 4150mV for
+ * 60 hours, then maintenance charged at 600mA and 4100mV for 200 hours.
+ * After this the charge cycle is restarted waiting for
+ * charge_restart_voltage_uv.
+ *
+ * For most mobile electronics this type of maintenance charging is enough for
+ * the user to disconnect the device and make use of it before both maintenance
+ * charging cycles are complete.
+ */
+struct power_supply_maintenance_charge_table {
+	int charge_current_max_ua;
+	int charge_voltage_max_uv;
+	int charge_safety_timer_minutes;
+};
+
 #define POWER_SUPPLY_OCV_TEMP_MAX 20
 
 /**
@@ -393,6 +439,10 @@ struct power_supply_resistance_temp_table {
  * @constant_charge_voltage_max_uv: voltage in microvolts signifying the end of
  *   the CC (constant current) charging phase and the beginning of the CV
  *   (constant voltage) charging phase.
+ * @maintenance_charge: an array of maintenance charging settings to be used
+ *   after the main CC/CV charging phase is complete.
+ * @maintenance_charge_size: the number of maintenance charging settings in
+ *   maintenance_charge.
  * @factory_internal_resistance_uohm: the internal resistance of the battery
  *   at fabrication time, expressed in microohms. This resistance will vary
  *   depending on the lifetime and charge of the battery, so this is just a
@@ -542,6 +592,8 @@ struct power_supply_battery_info {
 	int overvoltage_limit_uv;
 	int constant_charge_current_max_ua;
 	int constant_charge_voltage_max_uv;
+	struct power_supply_maintenance_charge_table *maintenance_charge;
+	int maintenance_charge_size;
 	int factory_internal_resistance_uohm;
 	int ocv_temp[POWER_SUPPLY_OCV_TEMP_MAX];
 	int temp_ambient_alert_min;
@@ -595,12 +647,24 @@ extern int power_supply_batinfo_ocv2cap(struct power_supply_battery_info *info,
 extern int
 power_supply_temp2resist_simple(struct power_supply_resistance_temp_table *table,
 				int table_len, int temp);
+extern struct power_supply_maintenance_charge_table *
+power_supply_get_maintenance_charging_setting(struct power_supply_battery_info *info, int index);
 extern void power_supply_changed(struct power_supply *psy);
 extern int power_supply_am_i_supplied(struct power_supply *psy);
 extern int power_supply_set_input_current_limit_from_supplier(
 					 struct power_supply *psy);
 extern int power_supply_set_battery_charged(struct power_supply *psy);
 
+static inline bool
+power_supply_supports_maintenance_charging(struct power_supply_battery_info *info)
+{
+	struct power_supply_maintenance_charge_table *mt;
+
+	mt = power_supply_get_maintenance_charging_setting(info, 0);
+
+	return (mt != NULL);
+}
+
 #ifdef CONFIG_POWER_SUPPLY
 extern int power_supply_is_system_supplied(void);
 #else
-- 
2.34.1

