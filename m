Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E637C457F2A
	for <lists+linux-pm@lfdr.de>; Sat, 20 Nov 2021 16:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbhKTP7Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 Nov 2021 10:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237588AbhKTP7P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 Nov 2021 10:59:15 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF4AC061574
        for <linux-pm@vger.kernel.org>; Sat, 20 Nov 2021 07:56:10 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id u3so58004063lfl.2
        for <linux-pm@vger.kernel.org>; Sat, 20 Nov 2021 07:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IOCu9stbMrC9hAiOLoP2SE4kZSPw9OX4hkSSCVl9Ya0=;
        b=ezgHUtMmkLE+2cbEHyT6HBrteZwi9A7vcA5Bu1q68fnBaEQJ5LYT3g+qh+ODpOxMVH
         IUfEityO+g5e7iqq/jD68fl1Qiez3Ndv37IBA0EauHDFIRNOCrXPkhzyTbyChNLYLWQQ
         acwX/0G5SrU+yNOBSV/TTrja6oM+Aokzj1P8AxqOndGbeWmqLxzj2gIsTqH67QuUIQcq
         Xm0LPeXy5s1UqZC5DFEjHKnpvttyCp64bg+4RfURDNnLduBsAXjoDYHv70TUv+Df8LRi
         Id5quVsZ65i3CUylmszS8DAdFIJf6La0tPe6rG30lrbVjJesV+AfhMUK+XM+zLpRCmjY
         N2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IOCu9stbMrC9hAiOLoP2SE4kZSPw9OX4hkSSCVl9Ya0=;
        b=qdjpdZVbnrU8QL85EEZfcSDFsy3mf7ki86VFmOMT17DwZv1xPIaoT23LFUsWmWIZBe
         mnFWp+whfZgDboPWp+5e8N0nLjodz0SokXVH/R/8o8johlCn+lpByGRSDxetkQm/T1es
         rjbXLNgRVx0hTSBxSLpn9GKoADhQbr7FnjlktfO3h7tBNghndNxTrEDCHzGvpNdAuay3
         dQQ1YhlYdThFO2BcwV5G6ayxvljkJha7hpQEAUhcK3UaySd/GRBkpAlXO/xDXlDJGXuq
         cdO3XFS5whYwBE27wbDqkc9GvZTTiUn26oMHjbcE5MY4+85MAYsoAVMypCRnG/N0lzOb
         Ml5g==
X-Gm-Message-State: AOAM530iVFywI3JHzk63Ce10yeCdHNlrB8sw819p8VlVtfoLvNchAYgN
        uVI9VBVScIrQBBomhKwYjDG3xg==
X-Google-Smtp-Source: ABdhPJy4plqSsYr8RbBek4NhkHYSIHANmDknqYcfC2WB1qaji0K+JrfQl1Inz+PU2JizKQByxECSHA==
X-Received: by 2002:a05:6512:3084:: with SMTP id z4mr42064741lfd.583.1637423769048;
        Sat, 20 Nov 2021 07:56:09 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id t12sm280922ljg.63.2021.11.20.07.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 07:56:08 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 14/16] power: supply: ab8500: Standardize CV voltage
Date:   Sat, 20 Nov 2021 16:53:24 +0100
Message-Id: <20211120155326.2891664-15-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211120155326.2891664-1-linus.walleij@linaro.org>
References: <20211120155326.2891664-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The voltage used in the constant voltage phase of the charging
exist in struct power_supply_battery_info as
constant_charge_voltage_max_uv.

Switch the custom property normal_vol_lvl to this and
consequentially change everything that relates to this value
over to using microvolts rather than millivolts so
we align internal representation of current with the
power core. Prefix every variable we change with *_uv
to indicate the unit everywhere but also to make sure
we do not miss any outlier.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebase on the other patches
---
 drivers/power/supply/ab8500-bm.h       |  10 +-
 drivers/power/supply/ab8500-chargalg.h |   4 +-
 drivers/power/supply/ab8500_bmdata.c   |   8 +-
 drivers/power/supply/ab8500_chargalg.c |  62 +++----
 drivers/power/supply/ab8500_charger.c  | 218 +++++++++++++------------
 5 files changed, 152 insertions(+), 150 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index c8841567dfee..febf2dea853b 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -367,7 +367,6 @@ struct ab8500_maxim_parameters {
  * struct ab8500_battery_type - different batteries supported
  * @resis_high:			battery upper resistance limit
  * @resis_low:			battery lower resistance limit
- * @normal_vol_lvl:		charger voltage in normal state in mV
  * @maint_a_cur_lvl:		charger current in maintenance A state in mA
  * @maint_a_vol_lvl:		charger voltage in maintenance A state in mV
  * @maint_a_chg_timer_h:	charge time in maintenance A state
@@ -386,7 +385,6 @@ struct ab8500_maxim_parameters {
 struct ab8500_battery_type {
 	int resis_high;
 	int resis_low;
-	int normal_vol_lvl;
 	int maint_a_cur_lvl;
 	int maint_a_vol_lvl;
 	int maint_a_chg_timer_h;
@@ -421,15 +419,15 @@ struct ab8500_bm_capacity_levels {
 
 /**
  * struct ab8500_bm_charger_parameters - Charger specific parameters
- * @usb_volt_max:	maximum allowed USB charger voltage in mV
+ * @usb_volt_max_uv:	maximum allowed USB charger voltage in uV
  * @usb_curr_max_ua:	maximum allowed USB charger current in uA
- * @ac_volt_max:	maximum allowed AC charger voltage in mV
+ * @ac_volt_max_uv:	maximum allowed AC charger voltage in uV
  * @ac_curr_max_ua:	maximum allowed AC charger current in uA
  */
 struct ab8500_bm_charger_parameters {
-	int usb_volt_max;
+	int usb_volt_max_uv;
 	int usb_curr_max_ua;
-	int ac_volt_max;
+	int ac_volt_max_uv;
 	int ac_curr_max_ua;
 };
 
diff --git a/drivers/power/supply/ab8500-chargalg.h b/drivers/power/supply/ab8500-chargalg.h
index 8094a3c2bd3a..f47a0061c36a 100644
--- a/drivers/power/supply/ab8500-chargalg.h
+++ b/drivers/power/supply/ab8500-chargalg.h
@@ -31,7 +31,7 @@ struct ux500_charger_ops {
  * struct ux500_charger - power supply ux500 charger sub class
  * @psy			power supply base class
  * @ops			ux500 charger operations
- * @max_out_volt	maximum output charger voltage in mV
+ * @max_out_volt_uv	maximum output charger voltage in uV
  * @max_out_curr_ua	maximum output charger current in uA
  * @enabled		indicates if this charger is used or not
  * @external		external charger unit (pm2xxx)
@@ -39,7 +39,7 @@ struct ux500_charger_ops {
 struct ux500_charger {
 	struct power_supply *psy;
 	struct ux500_charger_ops ops;
-	int max_out_volt;
+	int max_out_volt_uv;
 	int max_out_curr_ua;
 	int wdt_refresh;
 	bool enabled;
diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index e9bbb7517e04..ce0a5fcb3177 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -83,7 +83,6 @@ static const struct batres_vs_temp temp_to_batres_tbl_thermistor[] = {
 static struct ab8500_battery_type bat_type_thermistor_unknown = {
 	.resis_high = 0,
 	.resis_low = 0,
-	.normal_vol_lvl = 4100,
 	.maint_a_cur_lvl = 400,
 	.maint_a_vol_lvl = 4050,
 	.maint_a_chg_timer_h = 60,
@@ -138,9 +137,9 @@ static const struct ab8500_maxim_parameters ab8500_maxi_params = {
 };
 
 static const struct ab8500_bm_charger_parameters chg = {
-	.usb_volt_max		= 5500,
+	.usb_volt_max_uv	= 5500000,
 	.usb_curr_max_ua	= 1500000,
-	.ac_volt_max		= 7500,
+	.ac_volt_max_uv		= 7500000,
 	.ac_curr_max_ua		= 1500000,
 };
 
@@ -203,6 +202,9 @@ int ab8500_bm_of_probe(struct power_supply *psy,
 	if (bi->constant_charge_current_max_ua < 0)
 		bi->constant_charge_current_max_ua = 400000;
 
+	if (bi->constant_charge_voltage_max_uv < 0)
+		bi->constant_charge_voltage_max_uv = 4100000;
+
 	if (bi->charge_term_current_ua)
 		/* Charging stops when we drop below this current */
 		bi->charge_term_current_ua = 200000;
diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index 8ad3924ee496..86d740ce3a63 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -70,13 +70,13 @@ struct ab8500_chargalg_charger_info {
 	enum ab8500_chargers charger_type;
 	bool usb_chg_ok;
 	bool ac_chg_ok;
-	int usb_volt;
+	int usb_volt_uv;
 	int usb_curr_ua;
-	int ac_volt;
+	int ac_volt_uv;
 	int ac_curr_ua;
-	int usb_vset;
+	int usb_vset_uv;
 	int usb_iset_ua;
-	int ac_vset;
+	int ac_vset_uv;
 	int ac_iset_ua;
 };
 
@@ -365,12 +365,12 @@ static int ab8500_chargalg_check_charger_enable(struct ab8500_chargalg *di)
 
 	if (di->chg_info.charger_type & USB_CHG) {
 		return di->usb_chg->ops.check_enable(di->usb_chg,
-			di->bm->bat_type->normal_vol_lvl,
+			bi->constant_charge_voltage_max_uv,
 			bi->constant_charge_current_max_ua);
 	} else if ((di->chg_info.charger_type & AC_CHG) &&
 		   !(di->ac_chg->external)) {
 		return di->ac_chg->ops.check_enable(di->ac_chg,
-			di->bm->bat_type->normal_vol_lvl,
+			bi->constant_charge_voltage_max_uv,
 			bi->constant_charge_current_max_ua);
 	}
 	return 0;
@@ -546,14 +546,14 @@ static int ab8500_chargalg_kick_watchdog(struct ab8500_chargalg *di)
  * ab8500_chargalg_ac_en() - Turn on/off the AC charger
  * @di:		pointer to the ab8500_chargalg structure
  * @enable:	charger on/off
- * @vset:	requested charger output voltage
+ * @vset_uv:	requested charger output voltage in microvolt
  * @iset_ua:	requested charger output current in microampere
  *
  * The AC charger will be turned on/off with the requested charge voltage and
  * current
  */
 static int ab8500_chargalg_ac_en(struct ab8500_chargalg *di, int enable,
-	int vset, int iset_ua)
+	int vset_uv, int iset_ua)
 {
 	static int ab8500_chargalg_ex_ac_enable_toggle;
 
@@ -561,13 +561,13 @@ static int ab8500_chargalg_ac_en(struct ab8500_chargalg *di, int enable,
 		return -ENXIO;
 
 	/* Select maximum of what both the charger and the battery supports */
-	if (di->ac_chg->max_out_volt)
-		vset = min(vset, di->ac_chg->max_out_volt);
+	if (di->ac_chg->max_out_volt_uv)
+		vset_uv = min(vset_uv, di->ac_chg->max_out_volt_uv);
 	if (di->ac_chg->max_out_curr_ua)
 		iset_ua = min(iset_ua, di->ac_chg->max_out_curr_ua);
 
 	di->chg_info.ac_iset_ua = iset_ua;
-	di->chg_info.ac_vset = vset;
+	di->chg_info.ac_vset_uv = vset_uv;
 
 	/* Enable external charger */
 	if (enable && di->ac_chg->external &&
@@ -577,35 +577,35 @@ static int ab8500_chargalg_ac_en(struct ab8500_chargalg *di, int enable,
 		ab8500_chargalg_ex_ac_enable_toggle++;
 	}
 
-	return di->ac_chg->ops.enable(di->ac_chg, enable, vset, iset_ua);
+	return di->ac_chg->ops.enable(di->ac_chg, enable, vset_uv, iset_ua);
 }
 
 /**
  * ab8500_chargalg_usb_en() - Turn on/off the USB charger
  * @di:		pointer to the ab8500_chargalg structure
  * @enable:	charger on/off
- * @vset:	requested charger output voltage
+ * @vset_uv:	requested charger output voltage in microvolt
  * @iset_ua:	requested charger output current in microampere
  *
  * The USB charger will be turned on/off with the requested charge voltage and
  * current
  */
 static int ab8500_chargalg_usb_en(struct ab8500_chargalg *di, int enable,
-	int vset, int iset_ua)
+	int vset_uv, int iset_ua)
 {
 	if (!di->usb_chg || !di->usb_chg->ops.enable)
 		return -ENXIO;
 
 	/* Select maximum of what both the charger and the battery supports */
-	if (di->usb_chg->max_out_volt)
-		vset = min(vset, di->usb_chg->max_out_volt);
+	if (di->usb_chg->max_out_volt_uv)
+		vset_uv = min(vset_uv, di->usb_chg->max_out_volt_uv);
 	if (di->usb_chg->max_out_curr_ua)
 		iset_ua = min(iset_ua, di->usb_chg->max_out_curr_ua);
 
 	di->chg_info.usb_iset_ua = iset_ua;
-	di->chg_info.usb_vset = vset;
+	di->chg_info.usb_vset_uv = vset_uv;
 
-	return di->usb_chg->ops.enable(di->usb_chg, enable, vset, iset_ua);
+	return di->usb_chg->ops.enable(di->usb_chg, enable, vset_uv, iset_ua);
 }
 
 /**
@@ -692,28 +692,28 @@ static void ab8500_chargalg_hold_charging(struct ab8500_chargalg *di)
 /**
  * ab8500_chargalg_start_charging() - Start the charger
  * @di:		pointer to the ab8500_chargalg structure
- * @vset:	requested charger output voltage
+ * @vset_uv:	requested charger output voltage in microvolt
  * @iset_ua:	requested charger output current in microampere
  *
  * A charger will be enabled depending on the requested charger type that was
  * detected previously.
  */
 static void ab8500_chargalg_start_charging(struct ab8500_chargalg *di,
-	int vset, int iset_ua)
+	int vset_uv, int iset_ua)
 {
 	switch (di->chg_info.charger_type) {
 	case AC_CHG:
 		dev_dbg(di->dev,
-			"AC parameters: Vset %d, Ich %d\n", vset, iset_ua);
+			"AC parameters: Vset %d, Ich %d\n", vset_uv, iset_ua);
 		ab8500_chargalg_usb_en(di, false, 0, 0);
-		ab8500_chargalg_ac_en(di, true, vset, iset_ua);
+		ab8500_chargalg_ac_en(di, true, vset_uv, iset_ua);
 		break;
 
 	case USB_CHG:
 		dev_dbg(di->dev,
-			"USB parameters: Vset %d, Ich %d\n", vset, iset_ua);
+			"USB parameters: Vset %d, Ich %d\n", vset_uv, iset_ua);
 		ab8500_chargalg_ac_en(di, false, 0, 0);
-		ab8500_chargalg_usb_en(di, true, vset, iset_ua);
+		ab8500_chargalg_usb_en(di, true, vset_uv, iset_ua);
 		break;
 
 	default:
@@ -777,12 +777,12 @@ static void ab8500_chargalg_check_temp(struct ab8500_chargalg *di)
  */
 static void ab8500_chargalg_check_charger_voltage(struct ab8500_chargalg *di)
 {
-	if (di->chg_info.usb_volt > di->bm->chg_params->usb_volt_max)
+	if (di->chg_info.usb_volt_uv > di->bm->chg_params->usb_volt_max_uv)
 		di->chg_info.usb_chg_ok = false;
 	else
 		di->chg_info.usb_chg_ok = true;
 
-	if (di->chg_info.ac_volt > di->bm->chg_params->ac_volt_max)
+	if (di->chg_info.ac_volt_uv > di->bm->chg_params->ac_volt_max_uv)
 		di->chg_info.ac_chg_ok = false;
 	else
 		di->chg_info.ac_chg_ok = true;
@@ -1173,10 +1173,10 @@ static int ab8500_chargalg_get_ext_psy_data(struct device *dev, void *data)
 				di->batt_data.volt_uv = ret.intval;
 				break;
 			case POWER_SUPPLY_TYPE_MAINS:
-				di->chg_info.ac_volt = ret.intval / 1000;
+				di->chg_info.ac_volt_uv = ret.intval;
 				break;
 			case POWER_SUPPLY_TYPE_USB:
-				di->chg_info.usb_volt = ret.intval / 1000;
+				di->chg_info.usb_volt_uv = ret.intval;
 				break;
 			default:
 				break;
@@ -1423,9 +1423,9 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 		di->events.usb_cv_active,
 		di->chg_info.ac_curr_ua,
 		di->chg_info.usb_curr_ua,
-		di->chg_info.ac_vset,
+		di->chg_info.ac_vset_uv,
 		di->chg_info.ac_iset_ua,
-		di->chg_info.usb_vset,
+		di->chg_info.usb_vset_uv,
 		di->chg_info.usb_iset_ua);
 
 	switch (di->charge_state) {
@@ -1518,7 +1518,7 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 				* di->curr_status.curr_step_ua
 				/ CHARGALG_CURR_STEP_HIGH_UA;
 			ab8500_chargalg_start_charging(di,
-				di->bm->bat_type->normal_vol_lvl,
+				bi->constant_charge_voltage_max_uv,
 				curr_step_lvl_ua);
 		}
 
diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index e66091f3f606..db7457064a17 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -183,7 +183,7 @@ struct ab8500_charger_interrupts {
 struct ab8500_charger_info {
 	int charger_connected;
 	int charger_online;
-	int charger_voltage;
+	int charger_voltage_uv;
 	int cv_active;
 	bool wd_expired;
 	int charger_current_ua;
@@ -479,7 +479,7 @@ static void ab8500_charger_set_usb_connected(struct ab8500_charger *di,
  * ab8500_charger_get_ac_voltage() - get ac charger voltage
  * @di:		pointer to the ab8500_charger structure
  *
- * Returns ac charger voltage (on success)
+ * Returns ac charger voltage in microvolt (on success)
  */
 static int ab8500_charger_get_ac_voltage(struct ab8500_charger *di)
 {
@@ -493,7 +493,8 @@ static int ab8500_charger_get_ac_voltage(struct ab8500_charger *di)
 	} else {
 		vch = 0;
 	}
-	return vch;
+	/* Convert to microvolt, IIO returns millivolt */
+	return vch * 1000;
 }
 
 /**
@@ -530,7 +531,7 @@ static int ab8500_charger_ac_cv(struct ab8500_charger *di)
  * @di:		pointer to the ab8500_charger structure
  *
  * This function returns the vbus voltage.
- * Returns vbus voltage (on success)
+ * Returns vbus voltage in microvolt (on success)
  */
 static int ab8500_charger_get_vbus_voltage(struct ab8500_charger *di)
 {
@@ -544,7 +545,8 @@ static int ab8500_charger_get_vbus_voltage(struct ab8500_charger *di)
 	} else {
 		vch = 0;
 	}
-	return vch;
+	/* Convert to microvolt, IIO returns millivolt */
+	return vch * 1000;
 }
 
 /**
@@ -923,105 +925,105 @@ static int ab8500_charger_detect_usb_type(struct ab8500_charger *di)
 
 /*
  * This array maps the raw hex value to charger voltage used by the AB8500
- * Values taken from the UM0836
+ * Values taken from the UM0836, in microvolt.
  */
 static int ab8500_charger_voltage_map[] = {
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
-	3875 ,
-	3900 ,
-	3925 ,
-	3950 ,
-	3975 ,
-	4000 ,
-	4025 ,
-	4050 ,
-	4060 ,
-	4070 ,
-	4080 ,
-	4090 ,
-	4100 ,
-	4110 ,
-	4120 ,
-	4130 ,
-	4140 ,
-	4150 ,
-	4160 ,
-	4170 ,
-	4180 ,
-	4190 ,
-	4200 ,
-	4210 ,
-	4220 ,
-	4230 ,
-	4240 ,
-	4250 ,
-	4260 ,
-	4270 ,
-	4280 ,
-	4290 ,
-	4300 ,
-	4310 ,
-	4320 ,
-	4330 ,
-	4340 ,
-	4350 ,
-	4360 ,
-	4370 ,
-	4380 ,
-	4390 ,
-	4400 ,
-	4410 ,
-	4420 ,
-	4430 ,
-	4440 ,
-	4450 ,
-	4460 ,
-	4470 ,
-	4480 ,
-	4490 ,
-	4500 ,
-	4510 ,
-	4520 ,
-	4530 ,
-	4540 ,
-	4550 ,
-	4560 ,
-	4570 ,
-	4580 ,
-	4590 ,
-	4600 ,
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
+	3875000,
+	3900000,
+	3925000,
+	3950000,
+	3975000,
+	4000000,
+	4025000,
+	4050000,
+	4060000,
+	4070000,
+	4080000,
+	4090000,
+	4100000,
+	4110000,
+	4120000,
+	4130000,
+	4140000,
+	4150000,
+	4160000,
+	4170000,
+	4180000,
+	4190000,
+	4200000,
+	4210000,
+	4220000,
+	4230000,
+	4240000,
+	4250000,
+	4260000,
+	4270000,
+	4280000,
+	4290000,
+	4300000,
+	4310000,
+	4320000,
+	4330000,
+	4340000,
+	4350000,
+	4360000,
+	4370000,
+	4380000,
+	4390000,
+	4400000,
+	4410000,
+	4420000,
+	4430000,
+	4440000,
+	4450000,
+	4460000,
+	4470000,
+	4480000,
+	4490000,
+	4500000,
+	4510000,
+	4520000,
+	4530000,
+	4540000,
+	4550000,
+	4560000,
+	4570000,
+	4580000,
+	4590000,
+	4600000,
 };
 
-static int ab8500_voltage_to_regval(int voltage)
+static int ab8500_voltage_to_regval(int voltage_uv)
 {
 	int i;
 
 	/* Special case for voltage below 3.5V */
-	if (voltage < ab8500_charger_voltage_map[0])
+	if (voltage_uv < ab8500_charger_voltage_map[0])
 		return LOW_VOLT_REG;
 
 	for (i = 1; i < ARRAY_SIZE(ab8500_charger_voltage_map); i++) {
-		if (voltage < ab8500_charger_voltage_map[i])
+		if (voltage_uv < ab8500_charger_voltage_map[i])
 			return i - 1;
 	}
 
 	/* If not last element, return error */
 	i = ARRAY_SIZE(ab8500_charger_voltage_map) - 1;
-	if (voltage == ab8500_charger_voltage_map[i])
+	if (voltage_uv == ab8500_charger_voltage_map[i])
 		return i;
 	else
 		return -1;
@@ -1382,14 +1384,14 @@ static int ab8500_charger_led_en(struct ab8500_charger *di, int on)
  * ab8500_charger_ac_en() - enable or disable ac charging
  * @di:		pointer to the ab8500_charger structure
  * @enable:	enable/disable flag
- * @vset:	charging voltage
+ * @vset_uv:	charging voltage in microvolt
  * @iset_ua:	charging current in microampere
  *
  * Enable/Disable AC/Mains charging and turns on/off the charging led
  * respectively.
  **/
 static int ab8500_charger_ac_en(struct ux500_charger *charger,
-	int enable, int vset, int iset_ua)
+	int enable, int vset_uv, int iset_ua)
 {
 	int ret;
 	int volt_index;
@@ -1407,7 +1409,7 @@ static int ab8500_charger_ac_en(struct ux500_charger *charger,
 		}
 
 		/* Enable AC charging */
-		dev_dbg(di->dev, "Enable AC: %dmV %duA\n", vset, iset_ua);
+		dev_dbg(di->dev, "Enable AC: %duV %duA\n", vset_uv, iset_ua);
 
 		/*
 		 * Due to a bug in AB8500, BTEMP_HIGH/LOW interrupts
@@ -1429,7 +1431,7 @@ static int ab8500_charger_ac_en(struct ux500_charger *charger,
 		}
 
 		/* Check if the requested voltage or current is valid */
-		volt_index = ab8500_voltage_to_regval(vset);
+		volt_index = ab8500_voltage_to_regval(vset_uv);
 		curr_index = ab8500_current_to_regval(di, iset_ua);
 		input_curr_index = ab8500_current_to_regval(di,
 			di->bm->chg_params->ac_curr_max_ua);
@@ -1559,14 +1561,14 @@ static int ab8500_charger_ac_en(struct ux500_charger *charger,
  * ab8500_charger_usb_en() - enable usb charging
  * @di:		pointer to the ab8500_charger structure
  * @enable:	enable/disable flag
- * @vset:	charging voltage
+ * @vset_uv:	charging voltage in microvolt
  * @ich_out_ua:	charger output current in microampere
  *
  * Enable/Disable USB charging and turns on/off the charging led respectively.
  * Returns error code in case of failure else 0(on success)
  */
 static int ab8500_charger_usb_en(struct ux500_charger *charger,
-	int enable, int vset, int ich_out_ua)
+	int enable, int vset_uv, int ich_out_ua)
 {
 	int ret;
 	int volt_index;
@@ -1602,10 +1604,10 @@ static int ab8500_charger_usb_en(struct ux500_charger *charger,
 		}
 
 		/* Enable USB charging */
-		dev_dbg(di->dev, "Enable USB: %d mV %d uA\n", vset, ich_out_ua);
+		dev_dbg(di->dev, "Enable USB: %d uV %d uA\n", vset_uv, ich_out_ua);
 
 		/* Check if the requested voltage or current is valid */
-		volt_index = ab8500_voltage_to_regval(vset);
+		volt_index = ab8500_voltage_to_regval(vset_uv);
 		curr_index = ab8500_current_to_regval(di, ich_out_ua);
 		if (volt_index < 0 || curr_index < 0) {
 			dev_err(di->dev,
@@ -1740,14 +1742,14 @@ static int ab8500_external_charger_prepare(struct notifier_block *charger_nb,
 /**
  * ab8500_charger_usb_check_enable() - enable usb charging
  * @charger:	pointer to the ux500_charger structure
- * @vset:	charging voltage
+ * @vset_uv:	charging voltage in microvolt
  * @iset_ua:	charger output current in microampere
  *
  * Check if the VBUS charger has been disconnected and reconnected without
  * AB8500 rising an interrupt. Returns 0 on success.
  */
 static int ab8500_charger_usb_check_enable(struct ux500_charger *charger,
-	int vset, int iset_ua)
+	int vset_uv, int iset_ua)
 {
 	u8 usbch_ctrl1 = 0;
 	int ret = 0;
@@ -1776,7 +1778,7 @@ static int ab8500_charger_usb_check_enable(struct ux500_charger *charger,
 			return ret;
 		}
 
-		ret = ab8500_charger_usb_en(&di->usb_chg, true, vset, iset_ua);
+		ret = ab8500_charger_usb_en(&di->usb_chg, true, vset_uv, iset_ua);
 		if (ret < 0) {
 			dev_err(di->dev, "Failed to enable VBUS charger %d\n",
 					__LINE__);
@@ -1789,14 +1791,14 @@ static int ab8500_charger_usb_check_enable(struct ux500_charger *charger,
 /**
  * ab8500_charger_ac_check_enable() - enable usb charging
  * @charger:	pointer to the ux500_charger structure
- * @vset:	charging voltage
+ * @vset_uv:	charging voltage in microvolt
  * @iset_ua:	charger output current in micrompere
  *
  * Check if the AC charger has been disconnected and reconnected without
  * AB8500 rising an interrupt. Returns 0 on success.
  */
 static int ab8500_charger_ac_check_enable(struct ux500_charger *charger,
-	int vset, int iset_ua)
+	int vset_uv, int iset_ua)
 {
 	u8 mainch_ctrl1 = 0;
 	int ret = 0;
@@ -1826,7 +1828,7 @@ static int ab8500_charger_ac_check_enable(struct ux500_charger *charger,
 			return ret;
 		}
 
-		ret = ab8500_charger_ac_en(&di->usb_chg, true, vset, iset_ua);
+		ret = ab8500_charger_ac_en(&di->usb_chg, true, vset_uv, iset_ua);
 		if (ret < 0) {
 			dev_err(di->dev, "failed to enable AC charger %d\n",
 				__LINE__);
@@ -2941,9 +2943,9 @@ static int ab8500_charger_ac_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 		ret = ab8500_charger_get_ac_voltage(di);
 		if (ret >= 0)
-			di->ac.charger_voltage = ret;
+			di->ac.charger_voltage_uv = ret;
 		/* On error, use previous value */
-		val->intval = di->ac.charger_voltage * 1000;
+		val->intval = di->ac.charger_voltage_uv;
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
 		/*
@@ -3010,8 +3012,8 @@ static int ab8500_charger_usb_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 		ret = ab8500_charger_get_vbus_voltage(di);
 		if (ret >= 0)
-			di->usb.charger_voltage = ret;
-		val->intval = di->usb.charger_voltage * 1000;
+			di->usb.charger_voltage_uv = ret;
+		val->intval = di->usb.charger_voltage_uv;
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
 		/*
@@ -3521,7 +3523,7 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	di->ac_chg.ops.check_enable = &ab8500_charger_ac_check_enable;
 	di->ac_chg.ops.kick_wd = &ab8500_charger_watchdog_kick;
 	di->ac_chg.ops.update_curr = &ab8500_charger_update_charger_current;
-	di->ac_chg.max_out_volt = ab8500_charger_voltage_map[
+	di->ac_chg.max_out_volt_uv = ab8500_charger_voltage_map[
 		ARRAY_SIZE(ab8500_charger_voltage_map) - 1];
 	di->ac_chg.max_out_curr_ua =
 		ab8500_charge_output_curr_map[ARRAY_SIZE(ab8500_charge_output_curr_map) - 1];
@@ -3542,7 +3544,7 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	di->usb_chg.ops.check_enable = &ab8500_charger_usb_check_enable;
 	di->usb_chg.ops.kick_wd = &ab8500_charger_watchdog_kick;
 	di->usb_chg.ops.update_curr = &ab8500_charger_update_charger_current;
-	di->usb_chg.max_out_volt = ab8500_charger_voltage_map[
+	di->usb_chg.max_out_volt_uv = ab8500_charger_voltage_map[
 		ARRAY_SIZE(ab8500_charger_voltage_map) - 1];
 	di->usb_chg.max_out_curr_ua =
 		ab8500_charge_output_curr_map[ARRAY_SIZE(ab8500_charge_output_curr_map) - 1];
-- 
2.31.1

