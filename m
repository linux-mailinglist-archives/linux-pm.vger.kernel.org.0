Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43C3455296
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 03:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242533AbhKRCXX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 21:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242509AbhKRCXQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 21:23:16 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734CDC061570
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:20:16 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id y26so17979843lfa.11
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+4vZ1TRJjmkdD5N7MxsfN+lyXT9NBEi/c6RfzKXpo24=;
        b=JeQppe+3qFh9A4rj0y3/3GD557D9pZvGi6t9fL6QndJlnGxRkiZKiplxlmR1aCKDet
         f1cuz2UEJfm2toouULBk2juOuL29ON8xo7Q8gl+rIulsrWv7i5TRu/vmLZVSffHVXnKU
         nlz6YhPsUr5N/AavcBV/yDUERmZiB3H818Tkqja309Q3CwpAVJUEr5dPqHf/CovzrjcJ
         a2YsbPIpWbFX++c/C4J6sjqMNWQ6aNCIAZUjrxTOukjMG+e+cEXaVm/DChWzHF2OlGqp
         ylbwb/Je8zCA+/tZnrPFU8ffkzNEy/ZMeFmAo1aQ7KC9xh/Scdt1XW9ty8SQMDcrbwVe
         /utw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+4vZ1TRJjmkdD5N7MxsfN+lyXT9NBEi/c6RfzKXpo24=;
        b=I5MBALvVihiEnP3Voz2NTlsstgPCskA0cfgYTeeTekxWPnI8Rnbcc5WSGS6EnlHThZ
         C2Kcd6QqPpvGP0wKQG/A26RWjpAxEpGKYIVaMNDfrcxPqKvdgooxImz/JMrqOlW2vePb
         xJKxkZlVdF0PrsczbKvC+kcDiPbGHPapKdDIoDs1k7deGngC0HaooPUYNfkunhF2SAnL
         zmr7WUVc7NLxwyzA0dAvIaWL55qXNDBnbekATF6GR/OKmToy38fcA6OedQWb+5BGLDyE
         xW61R3g1htfgKK7/9UMe3z3rl2IT9KZ4j3Qk9M10lmsGr9UtvSsC2edRVr53BOfIRNxt
         acdw==
X-Gm-Message-State: AOAM533WHvM6y7mSD8Tmpyw0wlB+akW5rKjoTXQFqgozS+gDM8QywAw0
        s5yCVYXUgelzq/DFOpC/Ru/81w==
X-Google-Smtp-Source: ABdhPJz3m9bSXjP1i3uoIN6SssTFRxSFYLR0FRnEV6lCmBSZQEWgsW785RaRIV8LFiV/nCnEcNv7Hg==
X-Received: by 2002:a05:6512:a91:: with SMTP id m17mr19989320lfu.690.1637202014597;
        Wed, 17 Nov 2021 18:20:14 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id j19sm165321lfe.120.2021.11.17.18.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 18:20:13 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 08/16] power: supply: ab8500: Standardize voltages
Date:   Thu, 18 Nov 2021 03:17:44 +0100
Message-Id: <20211118021752.2262818-9-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118021752.2262818-1-linus.walleij@linaro.org>
References: <20211118021752.2262818-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The nominal voltage in this charge driver corresponds to
both the voltage_min_design_uv and voltage_max_design_uv
of struct power_supply_battery_info so assign both if this
is undefined.

The overcharge max voltage (when the charger should cut off)
is migrated at the same time so we move both voltages to
struct power_supply_battery_info.

Adjust the code to deal directly with the microvolt values
instead of converting them to millivolts.

Add *_uv suffixes for clarity and to make sure we have
changed all code sites using this member.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500-bm.h       |  4 ----
 drivers/power/supply/ab8500_bmdata.c   | 17 +++++++++++++++--
 drivers/power/supply/ab8500_chargalg.c | 10 +++++-----
 drivers/power/supply/ab8500_fg.c       | 21 +++++++++++++--------
 4 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index 66fd6568942c..233fa86f9b2f 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -374,8 +374,6 @@ struct ab8500_maxim_parameters {
  * struct ab8500_battery_type - different batteries supported
  * @resis_high:			battery upper resistance limit
  * @resis_low:			battery lower resistance limit
- * @nominal_voltage:		Nominal voltage of the battery in mV
- * @termination_vol:		max voltage upto which battery can be charged
  * @termination_curr		battery charging termination current in mA
  * @recharge_cap		battery capacity limit that will trigger a new
  *				full charging cycle in the case where maintenan-
@@ -401,8 +399,6 @@ struct ab8500_maxim_parameters {
 struct ab8500_battery_type {
 	int resis_high;
 	int resis_low;
-	int nominal_voltage;
-	int termination_vol;
 	int termination_curr;
 	int recharge_cap;
 	int normal_cur_lvl;
diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index a5e655d0761a..17df619cdf36 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -84,8 +84,6 @@ static struct ab8500_battery_type bat_type_thermistor_unknown = {
 	.resis_high = 0,
 	.resis_low = 0,
 	.battery_resistance = 300,
-	.nominal_voltage = 3700,
-	.termination_vol = 4050,
 	.termination_curr = 200,
 	.recharge_cap = 95,
 	.normal_cur_lvl = 400,
@@ -191,6 +189,21 @@ int ab8500_bm_of_probe(struct power_supply *psy,
 	if (bi->charge_full_design_uah < 0)
 		/* The default capacity is 612 mAh for unknown batteries */
 		bi->charge_full_design_uah = 612000;
+
+	/*
+	 * All of these voltages need to be specified or we will simply
+	 * fall back to safe defaults.
+	 */
+	if ((bi->voltage_min_design_uv < 0) ||
+	    (bi->voltage_max_design_uv < 0) ||
+	    (bi->overvoltage_limit_uv < 0)) {
+		/* Nominal voltage is 3.7V for unknown batteries */
+		bi->voltage_min_design_uv = 3700000;
+		bi->voltage_max_design_uv = 3700000;
+		/* Termination voltage (overcharge limit) 4.05V */
+		bi->overvoltage_limit_uv = 4050000;
+	}
+
 	if (bi->temp_min == INT_MIN)
 		bi->temp_min = AB8500_TEMP_UNDER;
 	if (bi->temp_max == INT_MAX)
diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index a5ccfb0aa9f4..dd9cad63e37e 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -86,7 +86,7 @@ struct ab8500_chargalg_current_step_status {
 
 struct ab8500_chargalg_battery_data {
 	int temp;
-	int volt;
+	int volt_uv;
 	int avg_curr;
 	int inst_curr;
 	int percent;
@@ -792,8 +792,8 @@ static void ab8500_chargalg_end_of_charge(struct ab8500_chargalg *di)
 {
 	if (di->charge_status == POWER_SUPPLY_STATUS_CHARGING &&
 		di->charge_state == STATE_NORMAL &&
-		!di->maintenance_chg && (di->batt_data.volt >=
-		di->bm->bat_type->termination_vol ||
+		!di->maintenance_chg && (di->batt_data.volt_uv >=
+		di->bm->bi.overvoltage_limit_uv ||
 		di->events.usb_cv_active || di->events.ac_cv_active) &&
 		di->batt_data.avg_curr <
 		di->bm->bat_type->termination_curr &&
@@ -1160,7 +1160,7 @@ static int ab8500_chargalg_get_ext_psy_data(struct device *dev, void *data)
 		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 			switch (ext->desc->type) {
 			case POWER_SUPPLY_TYPE_BATTERY:
-				di->batt_data.volt = ret.intval / 1000;
+				di->batt_data.volt_uv = ret.intval;
 				break;
 			case POWER_SUPPLY_TYPE_MAINS:
 				di->chg_info.ac_volt = ret.intval / 1000;
@@ -1397,7 +1397,7 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 		"State %s Active_chg %d Chg_status %d AC %d USB %d "
 		"AC_online %d USB_online %d AC_CV %d USB_CV %d AC_I %d "
 		"USB_I %d AC_Vset %d AC_Iset %d USB_Vset %d USB_Iset %d\n",
-		di->batt_data.volt,
+		di->batt_data.volt_uv,
 		di->batt_data.avg_curr,
 		di->batt_data.inst_curr,
 		di->batt_data.temp,
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index c6237c4f4721..ab6141faa798 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -157,7 +157,7 @@ struct inst_curr_result_list {
  * @node:		a list of AB8500 FGs, hence prepared for reentrance
  * @irq			holds the CCEOC interrupt number
  * @vbat:		Battery voltage in mV
- * @vbat_nom:		Nominal battery voltage in mV
+ * @vbat_nom_uv:	Nominal battery voltage in uV
  * @inst_curr:		Instantenous battery current in mA
  * @avg_curr:		Average battery current in mA
  * @bat_temp		battery temperature
@@ -199,7 +199,7 @@ struct ab8500_fg {
 	struct list_head node;
 	int irq;
 	int vbat;
-	int vbat_nom;
+	int vbat_nom_uv;
 	int inst_curr;
 	int avg_curr;
 	int bat_temp;
@@ -1013,11 +1013,16 @@ static int ab8500_fg_convert_mah_to_uwh(struct ab8500_fg *di, int cap_mah)
 	u64 div_res;
 	u32 div_rem;
 
-	div_res = ((u64) cap_mah) * ((u64) di->vbat_nom);
-	div_rem = do_div(div_res, 1000);
+	/*
+	 * Capacity is in milli ampere hours (10^-3)Ah
+	 * Nominal voltage is in microvolts (10^-6)V
+	 * divide by 1000000 after multiplication to get to mWh
+	 */
+	div_res = ((u64) cap_mah) * ((u64) di->vbat_nom_uv);
+	div_rem = do_div(div_res, 1000000);
 
 	/* Make sure to round upwards if necessary */
-	if (div_rem >= 1000 / 2)
+	if (div_rem >= 1000000 / 2)
 		div_res++;
 
 	return (int) div_res;
@@ -2247,7 +2252,8 @@ static int ab8500_fg_get_ext_psy_data(struct device *dev, void *data)
 					di->bat_cap.max_mah =
 						di->bat_cap.max_mah_design;
 
-					di->vbat_nom = b->nominal_voltage;
+					di->vbat_nom_uv =
+						di->bm->bi.voltage_max_design_uv;
 				}
 
 				if (ret.intval)
@@ -3078,8 +3084,7 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 
 	di->bat_cap.max_mah_design = di->bm->bi.charge_full_design_uah;
 	di->bat_cap.max_mah = di->bat_cap.max_mah_design;
-
-	di->vbat_nom = di->bm->bat_type->nominal_voltage;
+	di->vbat_nom_uv = di->bm->bi.voltage_max_design_uv;
 
 	di->init_capacity = true;
 
-- 
2.31.1

