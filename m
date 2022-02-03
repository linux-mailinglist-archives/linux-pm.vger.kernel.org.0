Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AC84A89F1
	for <lists+linux-pm@lfdr.de>; Thu,  3 Feb 2022 18:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239366AbiBCR0E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Feb 2022 12:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbiBCR0C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Feb 2022 12:26:02 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118E7C06173E
        for <linux-pm@vger.kernel.org>; Thu,  3 Feb 2022 09:26:02 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id u6so7403590lfm.10
        for <linux-pm@vger.kernel.org>; Thu, 03 Feb 2022 09:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=la/Vq1pcCPvdkDgZ0E4wwUPucNWPuf/fhnfFhRCR+hs=;
        b=z4jnPTLDoOBqaeaI1CUNRaP/gtk9yVlpVaEODeJzCin2E02ZltRrDa93d5SCJ+NdO8
         kC3gN0RXSG+iiDC80np2NOOeJ06jECeG/jm+mFhvDQW/+BJmtfP7xTOznPAGP9lNiG2v
         91DISZ9RAoyqQQY5wpvjOXXuFynWEsQ+4PdY3wBOXJUDlGcmZ9iBRiR37Y6LD5vsrEt0
         5+sbBFmKrykOaP7gGFXMmKl8p4axTNu2nfTb2MqDOXn5J4w4nPTR3Pkfnf0rAWwYWNxP
         iG8NG2RnwDKdTsHgqpVd+QZzBUZAGOb2Yoh8Ap8fQo0apKA9rtHP27JXctObYjXVoXK0
         NZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=la/Vq1pcCPvdkDgZ0E4wwUPucNWPuf/fhnfFhRCR+hs=;
        b=j6DxIhRb00x6XC3gzm5IulxvS8Gx264OUSsy0aTplOHfr43JoTK428HUskEEB+l+BP
         ftxjFLjNSC/RtRbH0512mYPLvc12B7lwDXdi07OB2s/vaU870mWHsOcMfoqHrpFcl8G6
         eIuqZ7KZFRurUXpqD5Q8fcen5hhSKLNOGHeuWdtk+qtpFNGnCJkw7VEM6Nxbp6sqVg9o
         etxVFcawAPN3tILvy32yA7+enj+r2OFUoJ5/A8fXDEljHrpMsXzlKhWwEHlMID0Ue7Gw
         jJDU+zas/LtCyFW9ABhny11wCOP9eMzJYs9wy3CVVcbSyhZNV7c48s82QSDR13VHVl29
         NFRA==
X-Gm-Message-State: AOAM530KW8NDQI4a9WkTUP7cVLPnMjhbR8mfgvVGyahslCN0JQ4qiOBe
        OPEnQVw++/rkon+Nr9IiK3/6vGOW152KMA==
X-Google-Smtp-Source: ABdhPJxKv603566gu+TMyM0Q2j2Fdg4Nw49CYXv9v4a3rtD77rcSlBL1qhCsyjmX2Hf0zPtlrflF9g==
X-Received: by 2002:a05:6512:39c2:: with SMTP id k2mr27393699lfu.53.1643909160321;
        Thu, 03 Feb 2022 09:26:00 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id b13sm1640699lff.240.2022.02.03.09.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 09:25:59 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/6] power: supply: ab8500: Standardize BTI resistance
Date:   Thu,  3 Feb 2022 18:16:30 +0100
Message-Id: <20220203171633.183828-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203171633.183828-1-linus.walleij@linaro.org>
References: <20220203171633.183828-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Battery Type Indicator (BTI) resistor is a resistor mounted
between a special terminal on the battery and ground. By sending
a fixed current (such as 7mA) through this resistor and measuring
the voltage over it, the resistance can be determined, and this
verifies the battery type.

Typical side view of the battery:

  o     o     o
 GND   BTI   +3.8V

Typical example of the electrical layout:

  +3.8 V   BTI
    |       |
    | +     |
 _______   [ ] 7kOhm
   ___      |
    |       |
    |       |
   GND     GND

By verifying this resistance before attempting to charge the
battery we add an additional level of security.

In some systems this is used for plug-and-play of batteries with
different capacity. In other cases, this is merely used to verify
that the right type of battery is connected, if several batteries
have the same physical shape and can be plugged into the same
slot. Sometimes this is just a surplus security mechanism.

Nokia and Samsung among many other vendors are known to use these
BTI resistors.

Add the BTI properties to struct power_supply_battery_info and
switch the AB8500 charger code over to using it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500-bm.h         | 12 -----------
 drivers/power/supply/ab8500_bmdata.c     | 14 ++++++-------
 drivers/power/supply/ab8500_btemp.c      | 14 ++++++-------
 drivers/power/supply/ab8500_fg.c         |  4 ----
 drivers/power/supply/power_supply_core.c | 26 +++++++++++++++++++++++-
 include/linux/power_supply.h             | 13 ++++++++++++
 6 files changed, 51 insertions(+), 32 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index 91ef9d4a5222..180a016b3662 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -327,16 +327,6 @@ struct ab8500_maxim_parameters {
 	int charger_curr_step_ua;
 };
 
-/**
- * struct ab8500_battery_type - different batteries supported
- * @resis_high:			battery upper resistance limit
- * @resis_low:			battery lower resistance limit
- */
-struct ab8500_battery_type {
-	int resis_high;
-	int resis_low;
-};
-
 /**
  * struct ab8500_bm_capacity_levels - ab8500 capacity level data
  * @critical:		critical capacity level in percent
@@ -387,7 +377,6 @@ struct ab8500_bm_charger_parameters {
  * @temp_hysteresis	temperature hysteresis
  * @maxi		maximization parameters
  * @cap_levels		capacity in percent for the different capacity levels
- * @bat_type		table of supported battery types
  * @chg_params		charger parameters
  * @fg_params		fuel gauge parameters
  */
@@ -410,7 +399,6 @@ struct ab8500_bm_data {
 	int temp_hysteresis;
 	const struct ab8500_maxim_parameters *maxi;
 	const struct ab8500_bm_capacity_levels *cap_levels;
-	struct ab8500_battery_type *bat_type;
 	const struct ab8500_bm_charger_parameters *chg_params;
 	const struct ab8500_fg_parameters *fg_params;
 };
diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index c878dc6e4197..c2587948b880 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -73,12 +73,6 @@ struct power_supply_maintenance_charge_table maint_charge_table[] = {
 	}
 };
 
-/* Default battery type for reference designs is the unknown type */
-static struct ab8500_battery_type bat_type_thermistor_unknown = {
-	.resis_high = 0,
-	.resis_low = 0,
-};
-
 static const struct ab8500_bm_capacity_levels cap_levels = {
 	.critical	= 2,
 	.low		= 10,
@@ -136,7 +130,6 @@ struct ab8500_bm_data ab8500_bm_data = {
 	.enable_overshoot       = false,
 	.fg_res                 = 100,
 	.cap_levels             = &cap_levels,
-	.bat_type               = &bat_type_thermistor_unknown,
 	.interval_charging      = 5,
 	.interval_not_charging  = 120,
 	.maxi                   = &ab8500_maxi_params,
@@ -208,6 +201,13 @@ int ab8500_bm_of_probe(struct power_supply *psy,
 		bi->resist_table_size = ARRAY_SIZE(temp_to_batres_tbl_thermistor);
 	}
 
+	/* The default battery is emulated by a resistor at 7K */
+	if (bi->bti_resistance_ohm < 0 ||
+	    bi->bti_resistance_tolerance < 0) {
+		bi->bti_resistance_ohm = 7000;
+		bi->bti_resistance_tolerance = 20;
+	}
+
 	if (!bi->ocv_table[0]) {
 		/* Default capacity table at say 25 degrees Celsius */
 		bi->ocv_temp[0] = 25;
diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 2a6fc151210c..b7e842dff567 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -237,8 +237,8 @@ static int ab8500_btemp_get_batctrl_res(struct ab8500_btemp *di)
  */
 static int ab8500_btemp_id(struct ab8500_btemp *di)
 {
+	struct power_supply_battery_info *bi = di->bm->bi;
 	int res;
-	u8 i;
 
 	di->curr_source = BTEMP_BATCTRL_CURR_SRC_7UA;
 
@@ -248,13 +248,11 @@ static int ab8500_btemp_id(struct ab8500_btemp *di)
 		return -ENXIO;
 	}
 
-	if ((res <= di->bm->bat_type->resis_high) &&
-	    (res >= di->bm->bat_type->resis_low)) {
-		dev_info(di->dev, "Battery detected on BATTEMP"
-			 " low %d < res %d < high: %d"
-			 " index: %d\n",
-			 di->bm->bat_type->resis_low, res,
-			 di->bm->bat_type->resis_high, i);
+	if (power_supply_battery_bti_in_range(bi, res)) {
+		dev_info(di->dev, "Battery detected on BATCTRL (pin C3)"
+			 " resistance %d Ohm = %d Ohm +/- %d%%\n",
+			 res, bi->bti_resistance_ohm,
+			 bi->bti_resistance_tolerance);
 	} else {
 		dev_warn(di->dev, "Battery identified as unknown"
 			 ", resistance %d Ohm\n", res);
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 6436861db016..39c7e6b0be52 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2241,10 +2241,6 @@ static int ab8500_fg_get_ext_psy_data(struct device *dev, void *data)
 				if (!di->flags.batt_id_received &&
 				    (bi && (bi->technology !=
 					    POWER_SUPPLY_TECHNOLOGY_UNKNOWN))) {
-					const struct ab8500_battery_type *b;
-
-					b = di->bm->bat_type;
-
 					di->flags.batt_id_received = true;
 
 					di->bat_cap.max_mah_design =
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 01f9898ab548..33fe355428cc 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -600,7 +600,9 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	info->temp_min                       = INT_MIN;
 	info->temp_max                       = INT_MAX;
 	info->factory_internal_resistance_uohm  = -EINVAL;
-	info->resist_table = NULL;
+	info->resist_table                   = NULL;
+	info->bti_resistance_ohm             = -EINVAL;
+	info->bti_resistance_tolerance       = -EINVAL;
 
 	for (index = 0; index < POWER_SUPPLY_OCV_TEMP_MAX; index++) {
 		info->ocv_table[index]       = NULL;
@@ -913,6 +915,28 @@ int power_supply_batinfo_ocv2cap(struct power_supply_battery_info *info,
 }
 EXPORT_SYMBOL_GPL(power_supply_batinfo_ocv2cap);
 
+bool power_supply_battery_bti_in_range(struct power_supply_battery_info *info,
+				       int resistance)
+{
+	int low, high;
+
+	/* Nothing like this can be checked */
+	if (info->bti_resistance_ohm <= 0)
+		return false;
+
+	/* This will be extremely strict and unlikely to work */
+	if (info->bti_resistance_tolerance <= 0)
+		return (info->bti_resistance_ohm == resistance);
+
+	low = info->bti_resistance_ohm -
+		(info->bti_resistance_ohm * info->bti_resistance_tolerance) / 100;
+	high = info->bti_resistance_ohm +
+		(info->bti_resistance_ohm * info->bti_resistance_tolerance) / 100;
+
+	return ((resistance >= low) && (resistance <= high));
+}
+EXPORT_SYMBOL_GPL(power_supply_battery_bti_in_range);
+
 int power_supply_get_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val)
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 5a059c013c12..72dc2dfc13a7 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -492,6 +492,14 @@ struct power_supply_maintenance_charge_table {
  *   by temperature: highest temperature with lowest resistance first, lowest
  *   temperature with highest resistance last.
  * @resist_table_size: the number of items in the resist_table.
+ * @bti_resistance_ohm: The Battery Type Indicator (BIT) nominal resistance
+ *   in ohms for this battery, if an identification resistor is mounted
+ *   between a third battery terminal and ground. This scheme is used by a lot
+ *   of mobile device batteries.
+ * @bti_resistance_tolerance: The tolerance in percent of the BTI resistance,
+ *   for example 10 for +/- 10%, if the bti_resistance is set to 7000 and the
+ *   tolerance is 10% we will detect a proper battery if the BTI resistance
+ *   is between 6300 and 7700 Ohm.
  *
  * This is the recommended struct to manage static battery parameters,
  * populated by power_supply_get_battery_info(). Most platform drivers should
@@ -616,6 +624,8 @@ struct power_supply_battery_info {
 	int ocv_table_size[POWER_SUPPLY_OCV_TEMP_MAX];
 	struct power_supply_resistance_temp_table *resist_table;
 	int resist_table_size;
+	int bti_resistance_ohm;
+	int bti_resistance_tolerance;
 };
 
 extern struct atomic_notifier_head power_supply_notifier;
@@ -659,6 +669,8 @@ power_supply_temp2resist_simple(struct power_supply_resistance_temp_table *table
 				int table_len, int temp);
 extern struct power_supply_maintenance_charge_table *
 power_supply_get_maintenance_charging_setting(struct power_supply_battery_info *info, int index);
+extern bool power_supply_battery_bti_in_range(struct power_supply_battery_info *info,
+					      int resistance);
 extern void power_supply_changed(struct power_supply *psy);
 extern int power_supply_am_i_supplied(struct power_supply *psy);
 extern int power_supply_set_input_current_limit_from_supplier(
@@ -675,6 +687,7 @@ power_supply_supports_maintenance_charging(struct power_supply_battery_info *inf
 	return (mt != NULL);
 }
 
+
 #ifdef CONFIG_POWER_SUPPLY
 extern int power_supply_is_system_supplied(void);
 #else
-- 
2.34.1

