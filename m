Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9C6457F24
	for <lists+linux-pm@lfdr.de>; Sat, 20 Nov 2021 16:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbhKTP7B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 Nov 2021 10:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhKTP7B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 Nov 2021 10:59:01 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C77C061574
        for <linux-pm@vger.kernel.org>; Sat, 20 Nov 2021 07:55:56 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bi37so58089478lfb.5
        for <linux-pm@vger.kernel.org>; Sat, 20 Nov 2021 07:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D+LWRAsb90F/38G8MwciuT1xHvwsIeNsyxBDxrulc1A=;
        b=VPt9YujO40ZRMSyHKbitWwEpRWK+V/8296ZJT3CA2DSPBVV7F1iYoTyxp3fJoeFpBO
         rhSVzGc4i4T6N2aKNdeHTPx03Y5xLxB26Et+mGmfIhY8BDJOCYG3rFclxIzKnzJUPeRz
         mttAgtw6G7Wxe4tjel/otaSR2LOkS4OFXrkWnmmNY9Wa7F7cJZSq6ZYX6jAxyte81Cf+
         8yIrT9DHt8fiRuXLR3BMicwscgAMJ3pV0gwv29u1lgGzPoEaUiotkTSY2+mMpMLZ6Sgp
         asg3A+DLFf2i14Nw7ASY38eFIw4Uc+rPBTAvP5EIXSGNrFKg1bbdjBfKbkx/ZhZySQ99
         lUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D+LWRAsb90F/38G8MwciuT1xHvwsIeNsyxBDxrulc1A=;
        b=Z+c1xaWY7P2KYOae1vRvZOBsIS5wmh4L6C5Qq8SYPTYzkeYUG/pKDbZJMRMAXbiJ9c
         48Uwd57lBgFqupGmnVanW5CSMb6qwccLhhpMH9litVR4mGqNokcpLJEqYDwLdREWL6pf
         jecDqXFP8q6c6AfI+5smWadcdO4z3CwHCH0pC0Fyi0HQEQeG9trL6jFYZ5LQN8ntsJ/J
         XjOT6pQ29eZEgvGQECoHOm7RT+uMRJUP//dOZV3WdA1e00nrBMouRPF87rXU9u9yI88U
         THsn2A8AwqlxW3+yIZE/WBN8pFlk0SoPML+Z+xMiPC+VZ/EZu6rUUHebgM4DGNmyihMl
         Ngpg==
X-Gm-Message-State: AOAM532ZXjOKM9p4lJiU7OX1nHB0i0PZYKiJ8FrCLpUt6ErdZu/8giFH
        eQhN9d6tCumZnCTEYauDq/85+tgIhUVkgA==
X-Google-Smtp-Source: ABdhPJw3rTI7hQpZbjiiMR4izC83jbRdjf4gJRiUkwDWlC2YwP+6xvaJhJC4SKJ4Gh51YLSyDq2/Fw==
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr34522071ljp.362.1637423755246;
        Sat, 20 Nov 2021 07:55:55 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id t12sm280922ljg.63.2021.11.20.07.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 07:55:54 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 08/16] power: supply: ab8500: Standardize voltages
Date:   Sat, 20 Nov 2021 16:53:18 +0100
Message-Id: <20211120155326.2891664-9-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211120155326.2891664-1-linus.walleij@linaro.org>
References: <20211120155326.2891664-1-linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- Rebase on the other patches
---
 drivers/power/supply/ab8500-bm.h       |  4 ----
 drivers/power/supply/ab8500_bmdata.c   | 17 +++++++++++++++--
 drivers/power/supply/ab8500_chargalg.c | 10 +++++-----
 drivers/power/supply/ab8500_fg.c       | 21 +++++++++++++--------
 4 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index 750d1a962f39..b21d3a99471f 100644
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
index 44d7c568949f..684cefccebd1 100644
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

