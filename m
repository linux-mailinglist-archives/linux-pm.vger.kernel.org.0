Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3088645529A
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 03:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242492AbhKRCX2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 21:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241550AbhKRCX1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 21:23:27 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A34C061764
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:20:28 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id k37so18187204lfv.3
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=laseDBS2IGIUV3COgCz0VIMY2aMcVPIjjni2hHzcWtQ=;
        b=hEIY6EwRmqECckyn3UF+vPAW6VfoDNta73qeT2KzeHFDSIUxBlNF4GnjGYImJyQhyE
         VB9TIvuHZURbej5OjTCL5mxwxj1O0m07GjCwRYNWmyKdgKsUqa0lYYciSjSyD1z/lHdy
         i8+0qaWL0faC9aoJl1V5IUeJx0PAQk7fC8MCa4ilj0mszR7ePG5KI4sTLGZznw6r/IV1
         Hu0YmzS90fc5IQ9LtkB+x9oQgKoXiQ7CPtkFX1fZrQT9qf8TqvX7+jekFuz29kvlQAO0
         7KNc0yu/vt16anXbN4kqEof4lj5RLcv7cKXHBm6UEsezGipRcE9J7IyH4ez7BnT0oBoO
         5jUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=laseDBS2IGIUV3COgCz0VIMY2aMcVPIjjni2hHzcWtQ=;
        b=SLCrHQFrdRTR6DkrEEMPFKVgtEDccecvj9h49t/AItUhMIuZPYM9J6QXMW6bhrytxh
         bSKghelhRLx0sobrE+d1Qmw7j8+5NG859uQjqQrx8yu6mcF0QZAUWNpbv6sMnCGc1kqM
         Hi3Q5k5R+7byKAVFIagWoVQ0+Ua5/a5ezZNP9YM9yF2klUl4fIgjoGuSS5oBJ8hxJidi
         okAMDtrW+ujLVAKDme0S+o63COsaelSk5YYnWQT3RqKDNPZ9obqizisMBCPJc3u66kxr
         T8Tha4hUKnvWwPHE22pIhYE0OFATI/64ep1F2Svv/lwoYjLJYSXiaDa3K4jOzRvNTa8S
         hZjA==
X-Gm-Message-State: AOAM531KryG8kFTPQ+rCdQXTuunSWYeyzFhnBPX6txLB/2z1zjYzpou9
        iVWQESRVGT5HBbtVT3da6aoU1lVOsobYqA==
X-Google-Smtp-Source: ABdhPJyDYPFYPhoeabN3hOqQs5iG559ivFGd0xRYpGwSTECBC+TpxcJX5gTaa1iMsPjUVcsoyz+DPA==
X-Received: by 2002:a19:c352:: with SMTP id t79mr20574599lff.251.1637202025912;
        Wed, 17 Nov 2021 18:20:25 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id j19sm165321lfe.120.2021.11.17.18.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 18:20:25 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 13/16] power: supply: ab8500: Standardize CC current
Date:   Thu, 18 Nov 2021 03:17:49 +0100
Message-Id: <20211118021752.2262818-14-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118021752.2262818-1-linus.walleij@linaro.org>
References: <20211118021752.2262818-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The current used in the constant current phase of the charging
exist in struct power_supply_battery_info as
constant_charge_current_max_ua.

Switch the custom property max_out_curr to this and
consequentally change everything that relates to this value
over to using microamperes rather than milliamperes so
we align internal representation of current with the
power core. Prefix every variable we change with *_ua
to indicate the unit everywhere but also to make sure
we do not miss any outlier.

Drop some duplicate unused defines in a header.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500-bm.h       |  25 +-
 drivers/power/supply/ab8500-chargalg.h |   4 +-
 drivers/power/supply/ab8500_bmdata.c   |  12 +-
 drivers/power/supply/ab8500_chargalg.c | 194 ++++++++--------
 drivers/power/supply/ab8500_charger.c  | 301 +++++++++++++------------
 5 files changed, 270 insertions(+), 266 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index 5f515d2a2260..e015bb6e7684 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -160,13 +160,6 @@
 #define BTEMP_HIGH_TH_57_1		0x02
 #define BTEMP_HIGH_TH_62		0x03
 
-/* current is mA */
-#define USB_0P1A			100
-#define USB_0P2A			200
-#define USB_0P3A			300
-#define USB_0P4A			400
-#define USB_0P5A			500
-
 #define LOW_BAT_3P1V			0x20
 #define LOW_BAT_2P3V			0x00
 #define LOW_BAT_RESET			0x01
@@ -359,22 +352,21 @@ struct ab8500_fg_parameters {
 /**
  * struct ab8500_charger_maximization - struct used by the board config.
  * @use_maxi:		Enable maximization for this battery type
- * @maxi_chg_curr:	Maximum charger current allowed
+ * @maxi_chg_curr_ua:	Maximum charger current allowed in microampere
  * @maxi_wait_cycles:	cycles to wait before setting charger current
- * @charger_curr_step	delta between two charger current settings (mA)
+ * @charger_curr_step_ua: delta between two charger current settings (uA)
  */
 struct ab8500_maxim_parameters {
 	bool ena_maxi;
-	int chg_curr;
+	int chg_curr_ua;
 	int wait_cycles;
-	int charger_curr_step;
+	int charger_curr_step_ua;
 };
 
 /**
  * struct ab8500_battery_type - different batteries supported
  * @resis_high:			battery upper resistance limit
  * @resis_low:			battery lower resistance limit
- * @normal_cur_lvl:		charger current in normal state in mA
  * @normal_vol_lvl:		charger voltage in normal state in mV
  * @maint_a_cur_lvl:		charger current in maintenance A state in mA
  * @maint_a_vol_lvl:		charger voltage in maintenance A state in mV
@@ -394,7 +386,6 @@ struct ab8500_maxim_parameters {
 struct ab8500_battery_type {
 	int resis_high;
 	int resis_low;
-	int normal_cur_lvl;
 	int normal_vol_lvl;
 	int maint_a_cur_lvl;
 	int maint_a_vol_lvl;
@@ -431,15 +422,15 @@ struct ab8500_bm_capacity_levels {
 /**
  * struct ab8500_bm_charger_parameters - Charger specific parameters
  * @usb_volt_max:	maximum allowed USB charger voltage in mV
- * @usb_curr_max:	maximum allowed USB charger current in mA
+ * @usb_curr_max_ua:	maximum allowed USB charger current in uA
  * @ac_volt_max:	maximum allowed AC charger voltage in mV
- * @ac_curr_max:	maximum allowed AC charger current in mA
+ * @ac_curr_max_ua:	maximum allowed AC charger current in uA
  */
 struct ab8500_bm_charger_parameters {
 	int usb_volt_max;
-	int usb_curr_max;
+	int usb_curr_max_ua;
 	int ac_volt_max;
-	int ac_curr_max;
+	int ac_curr_max_ua;
 };
 
 /**
diff --git a/drivers/power/supply/ab8500-chargalg.h b/drivers/power/supply/ab8500-chargalg.h
index 07e6ff50084f..8094a3c2bd3a 100644
--- a/drivers/power/supply/ab8500-chargalg.h
+++ b/drivers/power/supply/ab8500-chargalg.h
@@ -32,7 +32,7 @@ struct ux500_charger_ops {
  * @psy			power supply base class
  * @ops			ux500 charger operations
  * @max_out_volt	maximum output charger voltage in mV
- * @max_out_curr	maximum output charger current in mA
+ * @max_out_curr_ua	maximum output charger current in uA
  * @enabled		indicates if this charger is used or not
  * @external		external charger unit (pm2xxx)
  */
@@ -40,7 +40,7 @@ struct ux500_charger {
 	struct power_supply *psy;
 	struct ux500_charger_ops ops;
 	int max_out_volt;
-	int max_out_curr;
+	int max_out_curr_ua;
 	int wdt_refresh;
 	bool enabled;
 	bool external;
diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index 18d83a0e5a7d..ff17fc4593cc 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -83,7 +83,6 @@ static const struct batres_vs_temp temp_to_batres_tbl_thermistor[] = {
 static struct ab8500_battery_type bat_type_thermistor_unknown = {
 	.resis_high = 0,
 	.resis_low = 0,
-	.normal_cur_lvl = 400,
 	.normal_vol_lvl = 4100,
 	.maint_a_cur_lvl = 400,
 	.maint_a_vol_lvl = 4050,
@@ -133,16 +132,16 @@ static const struct ab8500_fg_parameters fg = {
 
 static const struct ab8500_maxim_parameters ab8500_maxi_params = {
 	.ena_maxi = true,
-	.chg_curr = 910,
+	.chg_curr_ua = 910000,
 	.wait_cycles = 10,
-	.charger_curr_step = 100,
+	.charger_curr_step_ua = 100000,
 };
 
 static const struct ab8500_bm_charger_parameters chg = {
 	.usb_volt_max		= 5500,
-	.usb_curr_max		= 1500,
+	.usb_curr_max_ua	= 1500000,
 	.ac_volt_max		= 7500,
-	.ac_curr_max		= 1500,
+	.ac_curr_max_ua		= 1500000,
 };
 
 /* This is referenced directly in the charger code */
@@ -201,6 +200,9 @@ int ab8500_bm_of_probe(struct power_supply *psy,
 		bi->overvoltage_limit_uv = 4050000;
 	}
 
+	if (bi->constant_charge_current_max_ua < 0)
+		bi->constant_charge_current_max_ua = 400000;
+
 	if (bi->charge_term_current_ua)
 		/* Charging stops when we drop below this current */
 		bi->charge_term_current_ua = 200000;
diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index 90974a8887cd..8ad3924ee496 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -46,8 +46,8 @@
 /* Five minutes expressed in seconds */
 #define FIVE_MINUTES_IN_SECONDS        300
 
-#define CHARGALG_CURR_STEP_LOW		0
-#define CHARGALG_CURR_STEP_HIGH	100
+#define CHARGALG_CURR_STEP_LOW_UA	0
+#define CHARGALG_CURR_STEP_HIGH_UA	100000
 
 /*
  * This is the battery capacity limit that will trigger a new
@@ -71,13 +71,13 @@ struct ab8500_chargalg_charger_info {
 	bool usb_chg_ok;
 	bool ac_chg_ok;
 	int usb_volt;
-	int usb_curr;
+	int usb_curr_ua;
 	int ac_volt;
-	int ac_curr;
+	int ac_curr_ua;
 	int usb_vset;
-	int usb_iset;
+	int usb_iset_ua;
 	int ac_vset;
-	int ac_iset;
+	int ac_iset_ua;
 };
 
 struct ab8500_chargalg_suspension_status {
@@ -88,14 +88,14 @@ struct ab8500_chargalg_suspension_status {
 
 struct ab8500_chargalg_current_step_status {
 	bool curr_step_change;
-	int curr_step;
+	int curr_step_ua;
 };
 
 struct ab8500_chargalg_battery_data {
 	int temp;
 	int volt_uv;
 	int avg_curr_ua;
-	int inst_curr;
+	int inst_curr_ua;
 	int percent;
 };
 
@@ -184,13 +184,13 @@ struct ab8500_chargalg_events {
 
 /**
  * struct ab8500_charge_curr_maximization - Charger maximization parameters
- * @original_iset:	the non optimized/maximised charger current
- * @current_iset:	the charging current used at this moment
- * @test_delta_i:	the delta between the current we want to charge and the
+ * @original_iset_ua:	the non optimized/maximised charger current
+ * @current_iset_ua:	the charging current used at this moment
+ * @test_delta_i_ua:	the delta between the current we want to charge and the
 			current that is really going into the battery
  * @condition_cnt:	number of iterations needed before a new charger current
 			is set
- * @max_current:	maximum charger current
+ * @max_current_ua:	maximum charger current
  * @wait_cnt:		to avoid too fast current step down in case of charger
  *			voltage collapse, we insert this delay between step
  *			down
@@ -198,11 +198,11 @@ struct ab8500_chargalg_events {
 			increased
  */
 struct ab8500_charge_curr_maximization {
-	int original_iset;
-	int current_iset;
-	int test_delta_i;
+	int original_iset_ua;
+	int current_iset_ua;
+	int test_delta_i_ua;
 	int condition_cnt;
-	int max_current;
+	int max_current_ua;
 	int wait_cnt;
 	u8 level;
 };
@@ -352,6 +352,8 @@ static void ab8500_chargalg_state_to(struct ab8500_chargalg *di,
 
 static int ab8500_chargalg_check_charger_enable(struct ab8500_chargalg *di)
 {
+	struct power_supply_battery_info *bi = &di->bm->bi;
+
 	switch (di->charge_state) {
 	case STATE_NORMAL:
 	case STATE_MAINTENANCE_A:
@@ -364,12 +366,12 @@ static int ab8500_chargalg_check_charger_enable(struct ab8500_chargalg *di)
 	if (di->chg_info.charger_type & USB_CHG) {
 		return di->usb_chg->ops.check_enable(di->usb_chg,
 			di->bm->bat_type->normal_vol_lvl,
-			di->bm->bat_type->normal_cur_lvl);
+			bi->constant_charge_current_max_ua);
 	} else if ((di->chg_info.charger_type & AC_CHG) &&
 		   !(di->ac_chg->external)) {
 		return di->ac_chg->ops.check_enable(di->ac_chg,
 			di->bm->bat_type->normal_vol_lvl,
-			di->bm->bat_type->normal_cur_lvl);
+			bi->constant_charge_current_max_ua);
 	}
 	return 0;
 }
@@ -545,13 +547,13 @@ static int ab8500_chargalg_kick_watchdog(struct ab8500_chargalg *di)
  * @di:		pointer to the ab8500_chargalg structure
  * @enable:	charger on/off
  * @vset:	requested charger output voltage
- * @iset:	requested charger output current
+ * @iset_ua:	requested charger output current in microampere
  *
  * The AC charger will be turned on/off with the requested charge voltage and
  * current
  */
 static int ab8500_chargalg_ac_en(struct ab8500_chargalg *di, int enable,
-	int vset, int iset)
+	int vset, int iset_ua)
 {
 	static int ab8500_chargalg_ex_ac_enable_toggle;
 
@@ -561,10 +563,10 @@ static int ab8500_chargalg_ac_en(struct ab8500_chargalg *di, int enable,
 	/* Select maximum of what both the charger and the battery supports */
 	if (di->ac_chg->max_out_volt)
 		vset = min(vset, di->ac_chg->max_out_volt);
-	if (di->ac_chg->max_out_curr)
-		iset = min(iset, di->ac_chg->max_out_curr);
+	if (di->ac_chg->max_out_curr_ua)
+		iset_ua = min(iset_ua, di->ac_chg->max_out_curr_ua);
 
-	di->chg_info.ac_iset = iset;
+	di->chg_info.ac_iset_ua = iset_ua;
 	di->chg_info.ac_vset = vset;
 
 	/* Enable external charger */
@@ -575,7 +577,7 @@ static int ab8500_chargalg_ac_en(struct ab8500_chargalg *di, int enable,
 		ab8500_chargalg_ex_ac_enable_toggle++;
 	}
 
-	return di->ac_chg->ops.enable(di->ac_chg, enable, vset, iset);
+	return di->ac_chg->ops.enable(di->ac_chg, enable, vset, iset_ua);
 }
 
 /**
@@ -583,13 +585,13 @@ static int ab8500_chargalg_ac_en(struct ab8500_chargalg *di, int enable,
  * @di:		pointer to the ab8500_chargalg structure
  * @enable:	charger on/off
  * @vset:	requested charger output voltage
- * @iset:	requested charger output current
+ * @iset_ua:	requested charger output current in microampere
  *
  * The USB charger will be turned on/off with the requested charge voltage and
  * current
  */
 static int ab8500_chargalg_usb_en(struct ab8500_chargalg *di, int enable,
-	int vset, int iset)
+	int vset, int iset_ua)
 {
 	if (!di->usb_chg || !di->usb_chg->ops.enable)
 		return -ENXIO;
@@ -597,25 +599,25 @@ static int ab8500_chargalg_usb_en(struct ab8500_chargalg *di, int enable,
 	/* Select maximum of what both the charger and the battery supports */
 	if (di->usb_chg->max_out_volt)
 		vset = min(vset, di->usb_chg->max_out_volt);
-	if (di->usb_chg->max_out_curr)
-		iset = min(iset, di->usb_chg->max_out_curr);
+	if (di->usb_chg->max_out_curr_ua)
+		iset_ua = min(iset_ua, di->usb_chg->max_out_curr_ua);
 
-	di->chg_info.usb_iset = iset;
+	di->chg_info.usb_iset_ua = iset_ua;
 	di->chg_info.usb_vset = vset;
 
-	return di->usb_chg->ops.enable(di->usb_chg, enable, vset, iset);
+	return di->usb_chg->ops.enable(di->usb_chg, enable, vset, iset_ua);
 }
 
 /**
  * ab8500_chargalg_update_chg_curr() - Update charger current
  * @di:		pointer to the ab8500_chargalg structure
- * @iset:	requested charger output current
+ * @iset_ua:	requested charger output current in microampere
  *
  * The charger output current will be updated for the charger
  * that is currently in use
  */
 static int ab8500_chargalg_update_chg_curr(struct ab8500_chargalg *di,
-		int iset)
+		int iset_ua)
 {
 	/* Check if charger exists and update current if charging */
 	if (di->ac_chg && di->ac_chg->ops.update_curr &&
@@ -624,24 +626,24 @@ static int ab8500_chargalg_update_chg_curr(struct ab8500_chargalg *di,
 		 * Select maximum of what both the charger
 		 * and the battery supports
 		 */
-		if (di->ac_chg->max_out_curr)
-			iset = min(iset, di->ac_chg->max_out_curr);
+		if (di->ac_chg->max_out_curr_ua)
+			iset_ua = min(iset_ua, di->ac_chg->max_out_curr_ua);
 
-		di->chg_info.ac_iset = iset;
+		di->chg_info.ac_iset_ua = iset_ua;
 
-		return di->ac_chg->ops.update_curr(di->ac_chg, iset);
+		return di->ac_chg->ops.update_curr(di->ac_chg, iset_ua);
 	} else if (di->usb_chg && di->usb_chg->ops.update_curr &&
 			di->chg_info.charger_type & USB_CHG) {
 		/*
 		 * Select maximum of what both the charger
 		 * and the battery supports
 		 */
-		if (di->usb_chg->max_out_curr)
-			iset = min(iset, di->usb_chg->max_out_curr);
+		if (di->usb_chg->max_out_curr_ua)
+			iset_ua = min(iset_ua, di->usb_chg->max_out_curr_ua);
 
-		di->chg_info.usb_iset = iset;
+		di->chg_info.usb_iset_ua = iset_ua;
 
-		return di->usb_chg->ops.update_curr(di->usb_chg, iset);
+		return di->usb_chg->ops.update_curr(di->usb_chg, iset_ua);
 	}
 
 	return -ENXIO;
@@ -691,27 +693,27 @@ static void ab8500_chargalg_hold_charging(struct ab8500_chargalg *di)
  * ab8500_chargalg_start_charging() - Start the charger
  * @di:		pointer to the ab8500_chargalg structure
  * @vset:	requested charger output voltage
- * @iset:	requested charger output current
+ * @iset_ua:	requested charger output current in microampere
  *
  * A charger will be enabled depending on the requested charger type that was
  * detected previously.
  */
 static void ab8500_chargalg_start_charging(struct ab8500_chargalg *di,
-	int vset, int iset)
+	int vset, int iset_ua)
 {
 	switch (di->chg_info.charger_type) {
 	case AC_CHG:
 		dev_dbg(di->dev,
-			"AC parameters: Vset %d, Ich %d\n", vset, iset);
+			"AC parameters: Vset %d, Ich %d\n", vset, iset_ua);
 		ab8500_chargalg_usb_en(di, false, 0, 0);
-		ab8500_chargalg_ac_en(di, true, vset, iset);
+		ab8500_chargalg_ac_en(di, true, vset, iset_ua);
 		break;
 
 	case USB_CHG:
 		dev_dbg(di->dev,
-			"USB parameters: Vset %d, Ich %d\n", vset, iset);
+			"USB parameters: Vset %d, Ich %d\n", vset, iset_ua);
 		ab8500_chargalg_ac_en(di, false, 0, 0);
-		ab8500_chargalg_usb_en(di, true, vset, iset);
+		ab8500_chargalg_usb_en(di, true, vset, iset_ua);
 		break;
 
 	default:
@@ -825,12 +827,12 @@ static void ab8500_chargalg_end_of_charge(struct ab8500_chargalg *di)
 
 static void init_maxim_chg_curr(struct ab8500_chargalg *di)
 {
-	di->ccm.original_iset =
-		di->bm->bat_type->normal_cur_lvl;
-	di->ccm.current_iset =
-		di->bm->bat_type->normal_cur_lvl;
-	di->ccm.test_delta_i = di->bm->maxi->charger_curr_step;
-	di->ccm.max_current = di->bm->maxi->chg_curr;
+	struct power_supply_battery_info *bi = &di->bm->bi;
+
+	di->ccm.original_iset_ua = bi->constant_charge_current_max_ua;
+	di->ccm.current_iset_ua = bi->constant_charge_current_max_ua;
+	di->ccm.test_delta_i_ua = di->bm->maxi->charger_curr_step_ua;
+	di->ccm.max_current_ua = di->bm->maxi->chg_curr_ua;
 	di->ccm.condition_cnt = di->bm->maxi->wait_cycles;
 	di->ccm.level = 0;
 }
@@ -846,12 +848,12 @@ static void init_maxim_chg_curr(struct ab8500_chargalg *di)
  */
 static enum maxim_ret ab8500_chargalg_chg_curr_maxim(struct ab8500_chargalg *di)
 {
-	int delta_i;
+	int delta_i_ua;
 
 	if (!di->bm->maxi->ena_maxi)
 		return MAXIM_RET_NOACTION;
 
-	delta_i = di->ccm.original_iset - di->batt_data.inst_curr;
+	delta_i_ua = di->ccm.original_iset_ua - di->batt_data.inst_curr_ua;
 
 	if (di->events.vbus_collapsed) {
 		dev_dbg(di->dev, "Charger voltage has collapsed %d\n",
@@ -860,9 +862,9 @@ static enum maxim_ret ab8500_chargalg_chg_curr_maxim(struct ab8500_chargalg *di)
 			dev_dbg(di->dev, "lowering current\n");
 			di->ccm.wait_cnt++;
 			di->ccm.condition_cnt = di->bm->maxi->wait_cycles;
-			di->ccm.max_current =
-				di->ccm.current_iset - di->ccm.test_delta_i;
-			di->ccm.current_iset = di->ccm.max_current;
+			di->ccm.max_current_ua =
+				di->ccm.current_iset_ua - di->ccm.test_delta_i_ua;
+			di->ccm.current_iset_ua = di->ccm.max_current_ua;
 			di->ccm.level--;
 			return MAXIM_RET_CHANGE;
 		} else {
@@ -875,36 +877,36 @@ static enum maxim_ret ab8500_chargalg_chg_curr_maxim(struct ab8500_chargalg *di)
 
 	di->ccm.wait_cnt = 0;
 
-	if (di->batt_data.inst_curr > di->ccm.original_iset) {
-		dev_dbg(di->dev, " Maximization Ibat (%dmA) too high"
-			" (limit %dmA) (current iset: %dmA)!\n",
-			di->batt_data.inst_curr, di->ccm.original_iset,
-			di->ccm.current_iset);
+	if (di->batt_data.inst_curr_ua > di->ccm.original_iset_ua) {
+		dev_dbg(di->dev, " Maximization Ibat (%duA) too high"
+			" (limit %duA) (current iset: %duA)!\n",
+			di->batt_data.inst_curr_ua, di->ccm.original_iset_ua,
+			di->ccm.current_iset_ua);
 
-		if (di->ccm.current_iset == di->ccm.original_iset)
+		if (di->ccm.current_iset_ua == di->ccm.original_iset_ua)
 			return MAXIM_RET_NOACTION;
 
 		di->ccm.condition_cnt = di->bm->maxi->wait_cycles;
-		di->ccm.current_iset = di->ccm.original_iset;
+		di->ccm.current_iset_ua = di->ccm.original_iset_ua;
 		di->ccm.level = 0;
 
 		return MAXIM_RET_IBAT_TOO_HIGH;
 	}
 
-	if (delta_i > di->ccm.test_delta_i &&
-		(di->ccm.current_iset + di->ccm.test_delta_i) <
-		di->ccm.max_current) {
+	if (delta_i_ua > di->ccm.test_delta_i_ua &&
+		(di->ccm.current_iset_ua + di->ccm.test_delta_i_ua) <
+		di->ccm.max_current_ua) {
 		if (di->ccm.condition_cnt-- == 0) {
 			/* Increse the iset with cco.test_delta_i */
 			di->ccm.condition_cnt = di->bm->maxi->wait_cycles;
-			di->ccm.current_iset += di->ccm.test_delta_i;
+			di->ccm.current_iset_ua += di->ccm.test_delta_i_ua;
 			di->ccm.level++;
 			dev_dbg(di->dev, " Maximization needed, increase"
-				" with %d mA to %dmA (Optimal ibat: %d)"
+				" with %d uA to %duA (Optimal ibat: %d uA)"
 				" Level %d\n",
-				di->ccm.test_delta_i,
-				di->ccm.current_iset,
-				di->ccm.original_iset,
+				di->ccm.test_delta_i_ua,
+				di->ccm.current_iset_ua,
+				di->ccm.original_iset_ua,
 				di->ccm.level);
 			return MAXIM_RET_CHANGE;
 		} else {
@@ -918,6 +920,7 @@ static enum maxim_ret ab8500_chargalg_chg_curr_maxim(struct ab8500_chargalg *di)
 
 static void handle_maxim_chg_curr(struct ab8500_chargalg *di)
 {
+	struct power_supply_battery_info *bi = &di->bm->bi;
 	enum maxim_ret ret;
 	int result;
 
@@ -925,13 +928,13 @@ static void handle_maxim_chg_curr(struct ab8500_chargalg *di)
 	switch (ret) {
 	case MAXIM_RET_CHANGE:
 		result = ab8500_chargalg_update_chg_curr(di,
-			di->ccm.current_iset);
+			di->ccm.current_iset_ua);
 		if (result)
 			dev_err(di->dev, "failed to set chg curr\n");
 		break;
 	case MAXIM_RET_IBAT_TOO_HIGH:
 		result = ab8500_chargalg_update_chg_curr(di,
-			di->bm->bat_type->normal_cur_lvl);
+			bi->constant_charge_current_max_ua);
 		if (result)
 			dev_err(di->dev, "failed to set chg curr\n");
 		break;
@@ -1226,15 +1229,13 @@ static int ab8500_chargalg_get_ext_psy_data(struct device *dev, void *data)
 		case POWER_SUPPLY_PROP_CURRENT_NOW:
 			switch (ext->desc->type) {
 			case POWER_SUPPLY_TYPE_MAINS:
-					di->chg_info.ac_curr =
-						ret.intval / 1000;
-					break;
+				di->chg_info.ac_curr_ua = ret.intval;
+				break;
 			case POWER_SUPPLY_TYPE_USB:
-					di->chg_info.usb_curr =
-						ret.intval / 1000;
+				di->chg_info.usb_curr_ua = ret.intval;
 				break;
 			case POWER_SUPPLY_TYPE_BATTERY:
-				di->batt_data.inst_curr = ret.intval / 1000;
+				di->batt_data.inst_curr_ua = ret.intval;
 				break;
 			default:
 				break;
@@ -1298,9 +1299,10 @@ static void ab8500_chargalg_external_power_changed(struct power_supply *psy)
  */
 static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 {
+	struct power_supply_battery_info *bi = &di->bm->bi;
 	int charger_status;
 	int ret;
-	int curr_step_lvl;
+	int curr_step_lvl_ua;
 
 	/* Collect data from all power_supply class devices */
 	class_for_each_device(power_supply_class, NULL,
@@ -1406,7 +1408,7 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 		"USB_I %d AC_Vset %d AC_Iset %d USB_Vset %d USB_Iset %d\n",
 		di->batt_data.volt_uv,
 		di->batt_data.avg_curr_ua,
-		di->batt_data.inst_curr,
+		di->batt_data.inst_curr_ua,
 		di->batt_data.temp,
 		di->batt_data.percent,
 		di->maintenance_chg,
@@ -1419,12 +1421,12 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 		di->chg_info.online_chg & USB_CHG,
 		di->events.ac_cv_active,
 		di->events.usb_cv_active,
-		di->chg_info.ac_curr,
-		di->chg_info.usb_curr,
+		di->chg_info.ac_curr_ua,
+		di->chg_info.usb_curr_ua,
 		di->chg_info.ac_vset,
-		di->chg_info.ac_iset,
+		di->chg_info.ac_iset_ua,
 		di->chg_info.usb_vset,
-		di->chg_info.usb_iset);
+		di->chg_info.usb_iset_ua);
 
 	switch (di->charge_state) {
 	case STATE_HANDHELD_INIT:
@@ -1509,15 +1511,15 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 		break;
 
 	case STATE_NORMAL_INIT:
-		if (di->curr_status.curr_step == CHARGALG_CURR_STEP_LOW)
+		if (di->curr_status.curr_step_ua == CHARGALG_CURR_STEP_LOW_UA)
 			ab8500_chargalg_stop_charging(di);
 		else {
-			curr_step_lvl = di->bm->bat_type->normal_cur_lvl
-				* di->curr_status.curr_step
-				/ CHARGALG_CURR_STEP_HIGH;
+			curr_step_lvl_ua = bi->constant_charge_current_max_ua
+				* di->curr_status.curr_step_ua
+				/ CHARGALG_CURR_STEP_HIGH_UA;
 			ab8500_chargalg_start_charging(di,
 				di->bm->bat_type->normal_vol_lvl,
-				curr_step_lvl);
+				curr_step_lvl_ua);
 		}
 
 		ab8500_chargalg_state_to(di, STATE_NORMAL);
@@ -1743,7 +1745,7 @@ static int ab8500_chargalg_get_property(struct power_supply *psy,
 static ssize_t ab8500_chargalg_curr_step_show(struct ab8500_chargalg *di,
 					      char *buf)
 {
-	return sprintf(buf, "%d\n", di->curr_status.curr_step);
+	return sprintf(buf, "%d\n", di->curr_status.curr_step_ua);
 }
 
 static ssize_t ab8500_chargalg_curr_step_store(struct ab8500_chargalg *di,
@@ -1756,9 +1758,9 @@ static ssize_t ab8500_chargalg_curr_step_store(struct ab8500_chargalg *di,
 	if (ret < 0)
 		return ret;
 
-	di->curr_status.curr_step = param;
-	if (di->curr_status.curr_step >= CHARGALG_CURR_STEP_LOW &&
-		di->curr_status.curr_step <= CHARGALG_CURR_STEP_HIGH) {
+	di->curr_status.curr_step_ua = param;
+	if (di->curr_status.curr_step_ua >= CHARGALG_CURR_STEP_LOW_UA &&
+		di->curr_status.curr_step_ua <= CHARGALG_CURR_STEP_HIGH_UA) {
 		di->curr_status.curr_step_change = true;
 		queue_work(di->chargalg_wq, &di->chargalg_work);
 	} else
@@ -2055,7 +2057,7 @@ static int ab8500_chargalg_probe(struct platform_device *pdev)
 		dev_err(di->dev, "failed to create sysfs entry\n");
 		return ret;
 	}
-	di->curr_status.curr_step = CHARGALG_CURR_STEP_HIGH;
+	di->curr_status.curr_step_ua = CHARGALG_CURR_STEP_HIGH_UA;
 
 	dev_info(di->dev, "probe success\n");
 	return component_add(dev, &ab8500_chargalg_component_ops);
diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 86f237dea44d..a2b1c991b570 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -145,23 +145,23 @@ enum ab8500_usb_state {
 	AB8500_BM_USB_STATE_MAX,
 };
 
-/* VBUS input current limits supported in AB8500 in mA */
-#define USB_CH_IP_CUR_LVL_0P05		50
-#define USB_CH_IP_CUR_LVL_0P09		98
-#define USB_CH_IP_CUR_LVL_0P19		193
-#define USB_CH_IP_CUR_LVL_0P29		290
-#define USB_CH_IP_CUR_LVL_0P38		380
-#define USB_CH_IP_CUR_LVL_0P45		450
-#define USB_CH_IP_CUR_LVL_0P5		500
-#define USB_CH_IP_CUR_LVL_0P6		600
-#define USB_CH_IP_CUR_LVL_0P7		700
-#define USB_CH_IP_CUR_LVL_0P8		800
-#define USB_CH_IP_CUR_LVL_0P9		900
-#define USB_CH_IP_CUR_LVL_1P0		1000
-#define USB_CH_IP_CUR_LVL_1P1		1100
-#define USB_CH_IP_CUR_LVL_1P3		1300
-#define USB_CH_IP_CUR_LVL_1P4		1400
-#define USB_CH_IP_CUR_LVL_1P5		1500
+/* VBUS input current limits supported in AB8500 in uA */
+#define USB_CH_IP_CUR_LVL_0P05		50000
+#define USB_CH_IP_CUR_LVL_0P09		98000
+#define USB_CH_IP_CUR_LVL_0P19		193000
+#define USB_CH_IP_CUR_LVL_0P29		290000
+#define USB_CH_IP_CUR_LVL_0P38		380000
+#define USB_CH_IP_CUR_LVL_0P45		450000
+#define USB_CH_IP_CUR_LVL_0P5		500000
+#define USB_CH_IP_CUR_LVL_0P6		600000
+#define USB_CH_IP_CUR_LVL_0P7		700000
+#define USB_CH_IP_CUR_LVL_0P8		800000
+#define USB_CH_IP_CUR_LVL_0P9		900000
+#define USB_CH_IP_CUR_LVL_1P0		1000000
+#define USB_CH_IP_CUR_LVL_1P1		1100000
+#define USB_CH_IP_CUR_LVL_1P3		1300000
+#define USB_CH_IP_CUR_LVL_1P4		1400000
+#define USB_CH_IP_CUR_LVL_1P5		1500000
 
 #define VBAT_TRESH_IP_CUR_RED		3800
 
@@ -186,7 +186,7 @@ struct ab8500_charger_info {
 	int charger_voltage;
 	int cv_active;
 	bool wd_expired;
-	int charger_current;
+	int charger_current_ua;
 };
 
 struct ab8500_charger_event_flags {
@@ -201,17 +201,17 @@ struct ab8500_charger_event_flags {
 };
 
 struct ab8500_charger_usb_state {
-	int usb_current;
-	int usb_current_tmp;
+	int usb_current_ua;
+	int usb_current_tmp_ua;
 	enum ab8500_usb_state state;
 	enum ab8500_usb_state state_tmp;
 	spinlock_t usb_lock;
 };
 
 struct ab8500_charger_max_usb_in_curr {
-	int usb_type_max;
-	int set_max;
-	int calculated_max;
+	int usb_type_max_ua;
+	int set_max_ua;
+	int calculated_max_ua;
 };
 
 /**
@@ -552,7 +552,7 @@ static int ab8500_charger_get_vbus_voltage(struct ab8500_charger *di)
  * @di:		pointer to the ab8500_charger structure
  *
  * This function returns the usb charger current.
- * Returns usb current (on success) and error code on failure
+ * Returns usb current in microamperes (on success) and error code on failure
  */
 static int ab8500_charger_get_usb_current(struct ab8500_charger *di)
 {
@@ -566,7 +566,8 @@ static int ab8500_charger_get_usb_current(struct ab8500_charger *di)
 	} else {
 		ich = 0;
 	}
-	return ich;
+	/* Return microamperes */
+	return ich * 1000;
 }
 
 /**
@@ -574,7 +575,7 @@ static int ab8500_charger_get_usb_current(struct ab8500_charger *di)
  * @di:		pointer to the ab8500_charger structure
  *
  * This function returns the ac charger current.
- * Returns ac current (on success) and error code on failure.
+ * Returns ac current in microamperes (on success) and error code on failure.
  */
 static int ab8500_charger_get_ac_current(struct ab8500_charger *di)
 {
@@ -588,7 +589,8 @@ static int ab8500_charger_get_ac_current(struct ab8500_charger *di)
 	} else {
 		ich = 0;
 	}
-	return ich;
+	/* Return microamperes */
+	return ich * 1000;
 }
 
 /**
@@ -711,19 +713,19 @@ static int ab8500_charger_max_usb_curr(struct ab8500_charger *di,
 	case USB_STAT_STD_HOST_C_S:
 		dev_dbg(di->dev, "USB Type - Standard host is "
 			"detected through USB driver\n");
-		di->max_usb_in_curr.usb_type_max = USB_CH_IP_CUR_LVL_0P5;
+		di->max_usb_in_curr.usb_type_max_ua = USB_CH_IP_CUR_LVL_0P5;
 		di->is_aca_rid = 0;
 		break;
 	case USB_STAT_HOST_CHG_HS_CHIRP:
-		di->max_usb_in_curr.usb_type_max = USB_CH_IP_CUR_LVL_0P5;
+		di->max_usb_in_curr.usb_type_max_ua = USB_CH_IP_CUR_LVL_0P5;
 		di->is_aca_rid = 0;
 		break;
 	case USB_STAT_HOST_CHG_HS:
-		di->max_usb_in_curr.usb_type_max = USB_CH_IP_CUR_LVL_0P5;
+		di->max_usb_in_curr.usb_type_max_ua = USB_CH_IP_CUR_LVL_0P5;
 		di->is_aca_rid = 0;
 		break;
 	case USB_STAT_ACA_RID_C_HS:
-		di->max_usb_in_curr.usb_type_max = USB_CH_IP_CUR_LVL_0P9;
+		di->max_usb_in_curr.usb_type_max_ua = USB_CH_IP_CUR_LVL_0P9;
 		di->is_aca_rid = 0;
 		break;
 	case USB_STAT_ACA_RID_A:
@@ -732,7 +734,7 @@ static int ab8500_charger_max_usb_curr(struct ab8500_charger *di,
 		 * can consume (900mA). Closest level is 500mA
 		 */
 		dev_dbg(di->dev, "USB_STAT_ACA_RID_A detected\n");
-		di->max_usb_in_curr.usb_type_max = USB_CH_IP_CUR_LVL_0P5;
+		di->max_usb_in_curr.usb_type_max_ua = USB_CH_IP_CUR_LVL_0P5;
 		di->is_aca_rid = 1;
 		break;
 	case USB_STAT_ACA_RID_B:
@@ -740,36 +742,36 @@ static int ab8500_charger_max_usb_curr(struct ab8500_charger *di,
 		 * Dedicated charger level minus 120mA (20mA for ACA and
 		 * 100mA for potential accessory). Closest level is 1300mA
 		 */
-		di->max_usb_in_curr.usb_type_max = USB_CH_IP_CUR_LVL_1P3;
+		di->max_usb_in_curr.usb_type_max_ua = USB_CH_IP_CUR_LVL_1P3;
 		dev_dbg(di->dev, "USB Type - 0x%02x MaxCurr: %d", link_status,
-				di->max_usb_in_curr.usb_type_max);
+				di->max_usb_in_curr.usb_type_max_ua);
 		di->is_aca_rid = 1;
 		break;
 	case USB_STAT_HOST_CHG_NM:
-		di->max_usb_in_curr.usb_type_max = USB_CH_IP_CUR_LVL_0P5;
+		di->max_usb_in_curr.usb_type_max_ua = USB_CH_IP_CUR_LVL_0P5;
 		di->is_aca_rid = 0;
 		break;
 	case USB_STAT_DEDICATED_CHG:
-		di->max_usb_in_curr.usb_type_max = USB_CH_IP_CUR_LVL_1P5;
+		di->max_usb_in_curr.usb_type_max_ua = USB_CH_IP_CUR_LVL_1P5;
 		di->is_aca_rid = 0;
 		break;
 	case USB_STAT_ACA_RID_C_HS_CHIRP:
 	case USB_STAT_ACA_RID_C_NM:
-		di->max_usb_in_curr.usb_type_max = USB_CH_IP_CUR_LVL_1P5;
+		di->max_usb_in_curr.usb_type_max_ua = USB_CH_IP_CUR_LVL_1P5;
 		di->is_aca_rid = 1;
 		break;
 	case USB_STAT_NOT_CONFIGURED:
 		if (di->vbus_detected) {
 			di->usb_device_is_unrecognised = true;
 			dev_dbg(di->dev, "USB Type - Legacy charger.\n");
-			di->max_usb_in_curr.usb_type_max =
+			di->max_usb_in_curr.usb_type_max_ua =
 						USB_CH_IP_CUR_LVL_1P5;
 			break;
 		}
 		fallthrough;
 	case USB_STAT_HM_IDGND:
 		dev_err(di->dev, "USB Type - Charging not allowed\n");
-		di->max_usb_in_curr.usb_type_max = USB_CH_IP_CUR_LVL_0P05;
+		di->max_usb_in_curr.usb_type_max_ua = USB_CH_IP_CUR_LVL_0P05;
 		ret = -ENXIO;
 		break;
 	case USB_STAT_RESERVED:
@@ -781,11 +783,11 @@ static int ab8500_charger_max_usb_curr(struct ab8500_charger *di,
 			break;
 		} else {
 			dev_dbg(di->dev, "USB Type - Charging not allowed\n");
-			di->max_usb_in_curr.usb_type_max =
+			di->max_usb_in_curr.usb_type_max_ua =
 						USB_CH_IP_CUR_LVL_0P05;
 			dev_dbg(di->dev, "USB Type - 0x%02x MaxCurr: %d",
 				link_status,
-				di->max_usb_in_curr.usb_type_max);
+				di->max_usb_in_curr.usb_type_max_ua);
 			ret = -ENXIO;
 			break;
 		}
@@ -793,25 +795,25 @@ static int ab8500_charger_max_usb_curr(struct ab8500_charger *di,
 	case USB_STAT_CARKIT_2:
 	case USB_STAT_ACA_DOCK_CHARGER:
 	case USB_STAT_CHARGER_LINE_1:
-		di->max_usb_in_curr.usb_type_max = USB_CH_IP_CUR_LVL_0P5;
+		di->max_usb_in_curr.usb_type_max_ua = USB_CH_IP_CUR_LVL_0P5;
 		dev_dbg(di->dev, "USB Type - 0x%02x MaxCurr: %d", link_status,
-				di->max_usb_in_curr.usb_type_max);
+				di->max_usb_in_curr.usb_type_max_ua);
 		break;
 	case USB_STAT_NOT_VALID_LINK:
 		dev_err(di->dev, "USB Type invalid - try charging anyway\n");
-		di->max_usb_in_curr.usb_type_max = USB_CH_IP_CUR_LVL_0P5;
+		di->max_usb_in_curr.usb_type_max_ua = USB_CH_IP_CUR_LVL_0P5;
 		break;
 
 	default:
 		dev_err(di->dev, "USB Type - Unknown\n");
-		di->max_usb_in_curr.usb_type_max = USB_CH_IP_CUR_LVL_0P05;
+		di->max_usb_in_curr.usb_type_max_ua = USB_CH_IP_CUR_LVL_0P05;
 		ret = -ENXIO;
 		break;
 	}
 
-	di->max_usb_in_curr.set_max = di->max_usb_in_curr.usb_type_max;
+	di->max_usb_in_curr.set_max_ua = di->max_usb_in_curr.usb_type_max_ua;
 	dev_dbg(di->dev, "USB Type - 0x%02x MaxCurr: %d",
-		link_status, di->max_usb_in_curr.set_max);
+		link_status, di->max_usb_in_curr.set_max_ua);
 
 	return ret;
 }
@@ -1027,51 +1029,51 @@ static int ab8500_voltage_to_regval(int voltage)
 
 /* This array maps the raw register value to charger input current */
 static int ab8500_charge_input_curr_map[] = {
-	50, 98, 193, 290, 380, 450, 500, 600,
-	700, 800, 900, 1000, 1100, 1300, 1400, 1500,
+	50000, 98000, 193000, 290000, 380000, 450000, 500000, 600000,
+	700000, 800000, 900000, 1000000, 1100000, 1300000, 1400000, 1500000,
 };
 
 /* This array maps the raw register value to charger output current */
 static int ab8500_charge_output_curr_map[] = {
-	100, 200, 300, 400, 500, 600, 700, 800,
-	900, 1000, 1100, 1200, 1300, 1400, 1500, 1500,
+	100000, 200000, 300000, 400000, 500000, 600000, 700000, 800000,
+	900000, 1000000, 1100000, 1200000, 1300000, 1400000, 1500000, 1500000,
 };
 
-static int ab8500_current_to_regval(struct ab8500_charger *di, int curr)
+static int ab8500_current_to_regval(struct ab8500_charger *di, int curr_ua)
 {
 	int i;
 
-	if (curr < ab8500_charge_output_curr_map[0])
+	if (curr_ua < ab8500_charge_output_curr_map[0])
 		return 0;
 
 	for (i = 0; i < ARRAY_SIZE(ab8500_charge_output_curr_map); i++) {
-		if (curr < ab8500_charge_output_curr_map[i])
+		if (curr_ua < ab8500_charge_output_curr_map[i])
 			return i - 1;
 	}
 
 	/* If not last element, return error */
 	i =  ARRAY_SIZE(ab8500_charge_output_curr_map) - 1;
-	if (curr == ab8500_charge_output_curr_map[i])
+	if (curr_ua == ab8500_charge_output_curr_map[i])
 		return i;
 	else
 		return -1;
 }
 
-static int ab8500_vbus_in_curr_to_regval(struct ab8500_charger *di, int curr)
+static int ab8500_vbus_in_curr_to_regval(struct ab8500_charger *di, int curr_ua)
 {
 	int i;
 
-	if (curr < ab8500_charge_input_curr_map[0])
+	if (curr_ua < ab8500_charge_input_curr_map[0])
 		return 0;
 
 	for (i = 0; i < ARRAY_SIZE(ab8500_charge_input_curr_map); i++) {
-		if (curr < ab8500_charge_input_curr_map[i])
+		if (curr_ua < ab8500_charge_input_curr_map[i])
 			return i - 1;
 	}
 
 	/* If not last element, return error */
 	i =  ARRAY_SIZE(ab8500_charge_input_curr_map) - 1;
-	if (curr == ab8500_charge_input_curr_map[i])
+	if (curr_ua == ab8500_charge_input_curr_map[i])
 		return i;
 	else
 		return -1;
@@ -1082,35 +1084,35 @@ static int ab8500_vbus_in_curr_to_regval(struct ab8500_charger *di, int curr)
  * @di:		pointer to the ab8500_charger structre
  *
  * The usb stack provides the maximum current that can be drawn from
- * the standard usb host. This will be in mA.
- * This function converts current in mA to a value that can be written
+ * the standard usb host. This will be in uA.
+ * This function converts current in uA to a value that can be written
  * to the register. Returns -1 if charging is not allowed
  */
 static int ab8500_charger_get_usb_cur(struct ab8500_charger *di)
 {
 	int ret = 0;
-	switch (di->usb_state.usb_current) {
-	case 100:
-		di->max_usb_in_curr.usb_type_max = USB_CH_IP_CUR_LVL_0P09;
+	switch (di->usb_state.usb_current_ua) {
+	case 100000:
+		di->max_usb_in_curr.usb_type_max_ua = USB_CH_IP_CUR_LVL_0P09;
 		break;
-	case 200:
-		di->max_usb_in_curr.usb_type_max = USB_CH_IP_CUR_LVL_0P19;
+	case 200000:
+		di->max_usb_in_curr.usb_type_max_ua = USB_CH_IP_CUR_LVL_0P19;
 		break;
-	case 300:
-		di->max_usb_in_curr.usb_type_max = USB_CH_IP_CUR_LVL_0P29;
+	case 300000:
+		di->max_usb_in_curr.usb_type_max_ua = USB_CH_IP_CUR_LVL_0P29;
 		break;
-	case 400:
-		di->max_usb_in_curr.usb_type_max = USB_CH_IP_CUR_LVL_0P38;
+	case 400000:
+		di->max_usb_in_curr.usb_type_max_ua = USB_CH_IP_CUR_LVL_0P38;
 		break;
-	case 500:
-		di->max_usb_in_curr.usb_type_max = USB_CH_IP_CUR_LVL_0P5;
+	case 500000:
+		di->max_usb_in_curr.usb_type_max_ua = USB_CH_IP_CUR_LVL_0P5;
 		break;
 	default:
-		di->max_usb_in_curr.usb_type_max = USB_CH_IP_CUR_LVL_0P05;
+		di->max_usb_in_curr.usb_type_max_ua = USB_CH_IP_CUR_LVL_0P05;
 		ret = -EPERM;
 		break;
 	}
-	di->max_usb_in_curr.set_max = di->max_usb_in_curr.usb_type_max;
+	di->max_usb_in_curr.set_max_ua = di->max_usb_in_curr.usb_type_max_ua;
 	return ret;
 }
 
@@ -1135,7 +1137,7 @@ static bool ab8500_charger_check_continue_stepping(struct ab8500_charger *di,
 /**
  * ab8500_charger_set_current() - set charger current
  * @di:		pointer to the ab8500_charger structure
- * @ich:	charger current, in mA
+ * @ich_ua:	charger current, in uA
  * @reg:	select what charger register to set
  *
  * Set charger current.
@@ -1146,7 +1148,7 @@ static bool ab8500_charger_check_continue_stepping(struct ab8500_charger *di,
  * Returns error code in case of failure else 0(on success)
  */
 static int ab8500_charger_set_current(struct ab8500_charger *di,
-	int ich, int reg)
+	int ich_ua, int reg)
 {
 	int ret = 0;
 	int curr_index, prev_curr_index, shift_value, i;
@@ -1167,7 +1169,7 @@ static int ab8500_charger_set_current(struct ab8500_charger *di,
 	case AB8500_MCH_IPT_CURLVL_REG:
 		shift_value = MAIN_CH_INPUT_CURR_SHIFT;
 		prev_curr_index = (reg_value >> shift_value);
-		curr_index = ab8500_current_to_regval(di, ich);
+		curr_index = ab8500_current_to_regval(di, ich_ua);
 		step_udelay = STEP_UDELAY;
 		if (!di->ac.charger_connected)
 			no_stepping = true;
@@ -1175,7 +1177,7 @@ static int ab8500_charger_set_current(struct ab8500_charger *di,
 	case AB8500_USBCH_IPT_CRNTLVL_REG:
 		shift_value = VBUS_IN_CURR_LIM_SHIFT;
 		prev_curr_index = (reg_value >> shift_value);
-		curr_index = ab8500_vbus_in_curr_to_regval(di, ich);
+		curr_index = ab8500_vbus_in_curr_to_regval(di, ich_ua);
 		step_udelay = STEP_UDELAY * 100;
 
 		if (!di->usb.charger_connected)
@@ -1184,7 +1186,7 @@ static int ab8500_charger_set_current(struct ab8500_charger *di,
 	case AB8500_CH_OPT_CRNTLVL_REG:
 		shift_value = 0;
 		prev_curr_index = (reg_value >> shift_value);
-		curr_index = ab8500_current_to_regval(di, ich);
+		curr_index = ab8500_current_to_regval(di, ich_ua);
 		step_udelay = STEP_UDELAY;
 		if (curr_index && (curr_index - prev_curr_index) > 1)
 			step_udelay *= 100;
@@ -1213,8 +1215,8 @@ static int ab8500_charger_set_current(struct ab8500_charger *di,
 		goto exit_set_current;
 	}
 
-	dev_dbg(di->dev, "%s set charger current: %d mA for reg: 0x%02x\n",
-		__func__, ich, reg);
+	dev_dbg(di->dev, "%s set charger current: %d uA for reg: 0x%02x\n",
+		__func__, ich_ua, reg);
 
 	if (no_stepping) {
 		ret = abx500_set_register_interruptible(di->dev, AB8500_CHARGER,
@@ -1261,31 +1263,31 @@ static int ab8500_charger_set_current(struct ab8500_charger *di,
 /**
  * ab8500_charger_set_vbus_in_curr() - set VBUS input current limit
  * @di:		pointer to the ab8500_charger structure
- * @ich_in:	charger input current limit
+ * @ich_in_ua:	charger input current limit in microampere
  *
  * Sets the current that can be drawn from the USB host
  * Returns error code in case of failure else 0(on success)
  */
 static int ab8500_charger_set_vbus_in_curr(struct ab8500_charger *di,
-		int ich_in)
+		int ich_in_ua)
 {
 	int min_value;
 	int ret;
 
 	/* We should always use to lowest current limit */
-	min_value = min(di->bm->chg_params->usb_curr_max, ich_in);
-	if (di->max_usb_in_curr.set_max > 0)
-		min_value = min(di->max_usb_in_curr.set_max, min_value);
+	min_value = min(di->bm->chg_params->usb_curr_max_ua, ich_in_ua);
+	if (di->max_usb_in_curr.set_max_ua > 0)
+		min_value = min(di->max_usb_in_curr.set_max_ua, min_value);
 
-	if (di->usb_state.usb_current >= 0)
-		min_value = min(di->usb_state.usb_current, min_value);
+	if (di->usb_state.usb_current_ua >= 0)
+		min_value = min(di->usb_state.usb_current_ua, min_value);
 
 	switch (min_value) {
-	case 100:
+	case 100000:
 		if (di->vbat < VBAT_TRESH_IP_CUR_RED)
 			min_value = USB_CH_IP_CUR_LVL_0P05;
 		break;
-	case 500:
+	case 500000:
 		if (di->vbat < VBAT_TRESH_IP_CUR_RED)
 			min_value = USB_CH_IP_CUR_LVL_0P45;
 		break;
@@ -1293,7 +1295,7 @@ static int ab8500_charger_set_vbus_in_curr(struct ab8500_charger *di,
 		break;
 	}
 
-	dev_info(di->dev, "VBUS input current limit set to %d mA\n", min_value);
+	dev_info(di->dev, "VBUS input current limit set to %d uA\n", min_value);
 
 	mutex_lock(&di->usb_ipt_crnt_lock);
 	ret = ab8500_charger_set_current(di, min_value,
@@ -1306,30 +1308,30 @@ static int ab8500_charger_set_vbus_in_curr(struct ab8500_charger *di,
 /**
  * ab8500_charger_set_main_in_curr() - set main charger input current
  * @di:		pointer to the ab8500_charger structure
- * @ich_in:	input charger current, in mA
+ * @ich_in_ua:	input charger current, in uA
  *
  * Set main charger input current.
  * Returns error code in case of failure else 0(on success)
  */
 static int ab8500_charger_set_main_in_curr(struct ab8500_charger *di,
-	int ich_in)
+	int ich_in_ua)
 {
-	return ab8500_charger_set_current(di, ich_in,
+	return ab8500_charger_set_current(di, ich_in_ua,
 		AB8500_MCH_IPT_CURLVL_REG);
 }
 
 /**
  * ab8500_charger_set_output_curr() - set charger output current
  * @di:		pointer to the ab8500_charger structure
- * @ich_out:	output charger current, in mA
+ * @ich_out_ua:	output charger current, in uA
  *
  * Set charger output current.
  * Returns error code in case of failure else 0(on success)
  */
 static int ab8500_charger_set_output_curr(struct ab8500_charger *di,
-	int ich_out)
+	int ich_out_ua)
 {
-	return ab8500_charger_set_current(di, ich_out,
+	return ab8500_charger_set_current(di, ich_out_ua,
 		AB8500_CH_OPT_CRNTLVL_REG);
 }
 
@@ -1381,13 +1383,13 @@ static int ab8500_charger_led_en(struct ab8500_charger *di, int on)
  * @di:		pointer to the ab8500_charger structure
  * @enable:	enable/disable flag
  * @vset:	charging voltage
- * @iset:	charging current
+ * @iset_ua:	charging current in microampere
  *
  * Enable/Disable AC/Mains charging and turns on/off the charging led
  * respectively.
  **/
 static int ab8500_charger_ac_en(struct ux500_charger *charger,
-	int enable, int vset, int iset)
+	int enable, int vset, int iset_ua)
 {
 	int ret;
 	int volt_index;
@@ -1405,7 +1407,7 @@ static int ab8500_charger_ac_en(struct ux500_charger *charger,
 		}
 
 		/* Enable AC charging */
-		dev_dbg(di->dev, "Enable AC: %dmV %dmA\n", vset, iset);
+		dev_dbg(di->dev, "Enable AC: %dmV %duA\n", vset, iset_ua);
 
 		/*
 		 * Due to a bug in AB8500, BTEMP_HIGH/LOW interrupts
@@ -1428,9 +1430,9 @@ static int ab8500_charger_ac_en(struct ux500_charger *charger,
 
 		/* Check if the requested voltage or current is valid */
 		volt_index = ab8500_voltage_to_regval(vset);
-		curr_index = ab8500_current_to_regval(di, iset);
+		curr_index = ab8500_current_to_regval(di, iset_ua);
 		input_curr_index = ab8500_current_to_regval(di,
-			di->bm->chg_params->ac_curr_max);
+			di->bm->chg_params->ac_curr_max_ua);
 		if (volt_index < 0 || curr_index < 0 || input_curr_index < 0) {
 			dev_err(di->dev,
 				"Charger voltage or current too high, "
@@ -1447,14 +1449,14 @@ static int ab8500_charger_ac_en(struct ux500_charger *charger,
 		}
 		/* MainChInputCurr: current that can be drawn from the charger*/
 		ret = ab8500_charger_set_main_in_curr(di,
-			di->bm->chg_params->ac_curr_max);
+			di->bm->chg_params->ac_curr_max_ua);
 		if (ret) {
 			dev_err(di->dev, "%s Failed to set MainChInputCurr\n",
 				__func__);
 			return ret;
 		}
 		/* ChOutputCurentLevel: protected output current */
-		ret = ab8500_charger_set_output_curr(di, iset);
+		ret = ab8500_charger_set_output_curr(di, iset_ua);
 		if (ret) {
 			dev_err(di->dev, "%s "
 				"Failed to set ChOutputCurentLevel\n",
@@ -1558,13 +1560,13 @@ static int ab8500_charger_ac_en(struct ux500_charger *charger,
  * @di:		pointer to the ab8500_charger structure
  * @enable:	enable/disable flag
  * @vset:	charging voltage
- * @ich_out:	charger output current
+ * @ich_out_ua:	charger output current in microampere
  *
  * Enable/Disable USB charging and turns on/off the charging led respectively.
  * Returns error code in case of failure else 0(on success)
  */
 static int ab8500_charger_usb_en(struct ux500_charger *charger,
-	int enable, int vset, int ich_out)
+	int enable, int vset, int ich_out_ua)
 {
 	int ret;
 	int volt_index;
@@ -1600,11 +1602,11 @@ static int ab8500_charger_usb_en(struct ux500_charger *charger,
 		}
 
 		/* Enable USB charging */
-		dev_dbg(di->dev, "Enable USB: %dmV %dmA\n", vset, ich_out);
+		dev_dbg(di->dev, "Enable USB: %d mV %d uA\n", vset, ich_out_ua);
 
 		/* Check if the requested voltage or current is valid */
 		volt_index = ab8500_voltage_to_regval(vset);
-		curr_index = ab8500_current_to_regval(di, ich_out);
+		curr_index = ab8500_current_to_regval(di, ich_out_ua);
 		if (volt_index < 0 || curr_index < 0) {
 			dev_err(di->dev,
 				"Charger voltage or current too high, "
@@ -1645,14 +1647,14 @@ static int ab8500_charger_usb_en(struct ux500_charger *charger,
 
 		/* USBChInputCurr: current that can be drawn from the usb */
 		ret = ab8500_charger_set_vbus_in_curr(di,
-					di->max_usb_in_curr.usb_type_max);
+					di->max_usb_in_curr.usb_type_max_ua);
 		if (ret) {
 			dev_err(di->dev, "setting USBChInputCurr failed\n");
 			return ret;
 		}
 
 		/* ChOutputCurentLevel: protected output current */
-		ret = ab8500_charger_set_output_curr(di, ich_out);
+		ret = ab8500_charger_set_output_curr(di, ich_out_ua);
 		if (ret) {
 			dev_err(di->dev, "%s "
 				"Failed to set ChOutputCurentLevel\n",
@@ -1739,13 +1741,13 @@ static int ab8500_external_charger_prepare(struct notifier_block *charger_nb,
  * ab8500_charger_usb_check_enable() - enable usb charging
  * @charger:	pointer to the ux500_charger structure
  * @vset:	charging voltage
- * @iset:	charger output current
+ * @iset_ua:	charger output current in microampere
  *
  * Check if the VBUS charger has been disconnected and reconnected without
  * AB8500 rising an interrupt. Returns 0 on success.
  */
 static int ab8500_charger_usb_check_enable(struct ux500_charger *charger,
-	int vset, int iset)
+	int vset, int iset_ua)
 {
 	u8 usbch_ctrl1 = 0;
 	int ret = 0;
@@ -1774,7 +1776,7 @@ static int ab8500_charger_usb_check_enable(struct ux500_charger *charger,
 			return ret;
 		}
 
-		ret = ab8500_charger_usb_en(&di->usb_chg, true, vset, iset);
+		ret = ab8500_charger_usb_en(&di->usb_chg, true, vset, iset_ua);
 		if (ret < 0) {
 			dev_err(di->dev, "Failed to enable VBUS charger %d\n",
 					__LINE__);
@@ -1788,13 +1790,13 @@ static int ab8500_charger_usb_check_enable(struct ux500_charger *charger,
  * ab8500_charger_ac_check_enable() - enable usb charging
  * @charger:	pointer to the ux500_charger structure
  * @vset:	charging voltage
- * @iset:	charger output current
+ * @iset_ua:	charger output current in micrompere
  *
  * Check if the AC charger has been disconnected and reconnected without
  * AB8500 rising an interrupt. Returns 0 on success.
  */
 static int ab8500_charger_ac_check_enable(struct ux500_charger *charger,
-	int vset, int iset)
+	int vset, int iset_ua)
 {
 	u8 mainch_ctrl1 = 0;
 	int ret = 0;
@@ -1824,7 +1826,7 @@ static int ab8500_charger_ac_check_enable(struct ux500_charger *charger,
 			return ret;
 		}
 
-		ret = ab8500_charger_ac_en(&di->usb_chg, true, vset, iset);
+		ret = ab8500_charger_ac_en(&di->usb_chg, true, vset, iset_ua);
 		if (ret < 0) {
 			dev_err(di->dev, "failed to enable AC charger %d\n",
 				__LINE__);
@@ -1863,13 +1865,14 @@ static int ab8500_charger_watchdog_kick(struct ux500_charger *charger)
 
 /**
  * ab8500_charger_update_charger_current() - update charger current
- * @di:		pointer to the ab8500_charger structure
+ * @charger:		pointer to the ab8500_charger structure
+ * @ich_out_ua:		desired output current in microampere
  *
  * Update the charger output current for the specified charger
  * Returns error code in case of failure else 0(on success)
  */
 static int ab8500_charger_update_charger_current(struct ux500_charger *charger,
-		int ich_out)
+		int ich_out_ua)
 {
 	int ret;
 	struct ab8500_charger *di;
@@ -1881,7 +1884,7 @@ static int ab8500_charger_update_charger_current(struct ux500_charger *charger,
 	else
 		return -ENXIO;
 
-	ret = ab8500_charger_set_output_curr(di, ich_out);
+	ret = ab8500_charger_set_output_curr(di, ich_out_ua);
 	if (ret) {
 		dev_err(di->dev, "%s "
 			"Failed to set ChOutputCurentLevel\n",
@@ -1973,10 +1976,10 @@ static void ab8500_charger_check_vbat_work(struct work_struct *work)
 		di->vbat > VBAT_TRESH_IP_CUR_RED))) {
 
 		dev_dbg(di->dev, "Vbat did cross threshold, curr: %d, new: %d,"
-			" old: %d\n", di->max_usb_in_curr.usb_type_max,
+			" old: %d\n", di->max_usb_in_curr.usb_type_max_ua,
 			di->vbat, di->old_vbat);
 		ab8500_charger_set_vbus_in_curr(di,
-					di->max_usb_in_curr.usb_type_max);
+					di->max_usb_in_curr.usb_type_max_ua);
 		power_supply_changed(di->usb_chg.psy);
 	}
 
@@ -2257,7 +2260,7 @@ static void ab8500_charger_usb_link_attach_work(struct work_struct *work)
 	/* Update maximum input current if USB enumeration is not detected */
 	if (!di->usb.charger_online) {
 		ret = ab8500_charger_set_vbus_in_curr(di,
-					di->max_usb_in_curr.usb_type_max);
+					di->max_usb_in_curr.usb_type_max_ua);
 		if (ret)
 			return;
 	}
@@ -2419,11 +2422,11 @@ static void ab8500_charger_usb_state_changed_work(struct work_struct *work)
 
 	spin_lock_irqsave(&di->usb_state.usb_lock, flags);
 	di->usb_state.state = di->usb_state.state_tmp;
-	di->usb_state.usb_current = di->usb_state.usb_current_tmp;
+	di->usb_state.usb_current_ua = di->usb_state.usb_current_tmp_ua;
 	spin_unlock_irqrestore(&di->usb_state.usb_lock, flags);
 
-	dev_dbg(di->dev, "%s USB state: 0x%02x mA: %d\n",
-		__func__, di->usb_state.state, di->usb_state.usb_current);
+	dev_dbg(di->dev, "%s USB state: 0x%02x uA: %d\n",
+		__func__, di->usb_state.state, di->usb_state.usb_current_ua);
 
 	switch (di->usb_state.state) {
 	case AB8500_BM_USB_STATE_RESET_HS:
@@ -2449,7 +2452,7 @@ static void ab8500_charger_usb_state_changed_work(struct work_struct *work)
 		if (!ab8500_charger_get_usb_cur(di)) {
 			/* Update maximum input current */
 			ret = ab8500_charger_set_vbus_in_curr(di,
-					di->max_usb_in_curr.usb_type_max);
+					di->max_usb_in_curr.usb_type_max_ua);
 			if (ret)
 				return;
 
@@ -2669,7 +2672,7 @@ static void ab8500_charger_vbus_drop_end_work(struct work_struct *work)
 {
 	struct ab8500_charger *di = container_of(work,
 		struct ab8500_charger, vbus_drop_end_work.work);
-	int ret, curr;
+	int ret, curr_ua;
 	u8 reg_value;
 
 	di->flags.vbus_drop_end = false;
@@ -2685,30 +2688,30 @@ static void ab8500_charger_vbus_drop_end_work(struct work_struct *work)
 		return;
 	}
 
-	curr = ab8500_charge_input_curr_map[
+	curr_ua = ab8500_charge_input_curr_map[
 		reg_value >> AUTO_VBUS_IN_CURR_LIM_SHIFT];
 
-	if (di->max_usb_in_curr.calculated_max != curr) {
+	if (di->max_usb_in_curr.calculated_max_ua != curr_ua) {
 		/* USB source is collapsing */
-		di->max_usb_in_curr.calculated_max = curr;
+		di->max_usb_in_curr.calculated_max_ua = curr_ua;
 		dev_dbg(di->dev,
-			 "VBUS input current limiting to %d mA\n",
-			 di->max_usb_in_curr.calculated_max);
+			 "VBUS input current limiting to %d uA\n",
+			 di->max_usb_in_curr.calculated_max_ua);
 	} else {
 		/*
 		 * USB source can not give more than this amount.
 		 * Taking more will collapse the source.
 		 */
-		di->max_usb_in_curr.set_max =
-			di->max_usb_in_curr.calculated_max;
+		di->max_usb_in_curr.set_max_ua =
+			di->max_usb_in_curr.calculated_max_ua;
 		dev_dbg(di->dev,
-			 "VBUS input current limited to %d mA\n",
-			 di->max_usb_in_curr.set_max);
+			 "VBUS input current limited to %d uA\n",
+			 di->max_usb_in_curr.set_max_ua);
 	}
 
 	if (di->usb.charger_connected)
 		ab8500_charger_set_vbus_in_curr(di,
-					di->max_usb_in_curr.usb_type_max);
+					di->max_usb_in_curr.usb_type_max_ua);
 }
 
 /**
@@ -2953,8 +2956,8 @@ static int ab8500_charger_ac_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		ret = ab8500_charger_get_ac_current(di);
 		if (ret >= 0)
-			di->ac.charger_current = ret;
-		val->intval = di->ac.charger_current * 1000;
+			di->ac.charger_current_ua = ret;
+		val->intval = di->ac.charger_current_ua;
 		break;
 	default:
 		return -EINVAL;
@@ -3021,8 +3024,8 @@ static int ab8500_charger_usb_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		ret = ab8500_charger_get_usb_current(di);
 		if (ret >= 0)
-			di->usb.charger_current = ret;
-		val->intval = di->usb.charger_current * 1000;
+			di->usb.charger_current_ua = ret;
+		val->intval = di->usb.charger_current_ua;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_AVG:
 		/*
@@ -3198,6 +3201,11 @@ static int ab8500_charger_usb_notifier_call(struct notifier_block *nb,
 	struct ab8500_charger *di =
 		container_of(nb, struct ab8500_charger, nb);
 	enum ab8500_usb_state bm_usb_state;
+	/*
+	 * FIXME: it appears the AB8500 PHY never sends what it should here.
+	 * Fix the PHY driver to properly notify the desired current.
+	 * Also broadcast microampere and not milliampere.
+	 */
 	unsigned mA = *((unsigned *)power);
 
 	if (event != USB_EVENT_VBUS) {
@@ -3208,7 +3216,7 @@ static int ab8500_charger_usb_notifier_call(struct notifier_block *nb,
 	/* TODO: State is fabricate  here. See if charger really needs USB
 	 * state or if mA is enough
 	 */
-	if ((di->usb_state.usb_current == 2) && (mA > 2))
+	if ((di->usb_state.usb_current_ua == 2000) && (mA > 2))
 		bm_usb_state = AB8500_BM_USB_STATE_RESUME;
 	else if (mA == 0)
 		bm_usb_state = AB8500_BM_USB_STATE_RESET_HS;
@@ -3224,7 +3232,8 @@ static int ab8500_charger_usb_notifier_call(struct notifier_block *nb,
 
 	spin_lock(&di->usb_state.usb_lock);
 	di->usb_state.state_tmp = bm_usb_state;
-	di->usb_state.usb_current_tmp = mA;
+	/* FIXME: broadcast ua instead, see above */
+	di->usb_state.usb_current_tmp_ua = mA * 1000;
 	spin_unlock(&di->usb_state.usb_lock);
 
 	/*
@@ -3514,7 +3523,7 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	di->ac_chg.ops.update_curr = &ab8500_charger_update_charger_current;
 	di->ac_chg.max_out_volt = ab8500_charger_voltage_map[
 		ARRAY_SIZE(ab8500_charger_voltage_map) - 1];
-	di->ac_chg.max_out_curr =
+	di->ac_chg.max_out_curr_ua =
 		ab8500_charge_output_curr_map[ARRAY_SIZE(ab8500_charge_output_curr_map) - 1];
 	di->ac_chg.wdt_refresh = CHG_WD_INTERVAL;
 	/*
@@ -3535,11 +3544,11 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	di->usb_chg.ops.update_curr = &ab8500_charger_update_charger_current;
 	di->usb_chg.max_out_volt = ab8500_charger_voltage_map[
 		ARRAY_SIZE(ab8500_charger_voltage_map) - 1];
-	di->usb_chg.max_out_curr =
+	di->usb_chg.max_out_curr_ua =
 		ab8500_charge_output_curr_map[ARRAY_SIZE(ab8500_charge_output_curr_map) - 1];
 	di->usb_chg.wdt_refresh = CHG_WD_INTERVAL;
 	di->usb_chg.external = false;
-	di->usb_state.usb_current = -1;
+	di->usb_state.usb_current_ua = -1;
 
 	mutex_init(&di->charger_attached_mutex);
 
-- 
2.31.1

