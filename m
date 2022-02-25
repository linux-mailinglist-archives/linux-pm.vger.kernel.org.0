Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1571C4C5219
	for <lists+linux-pm@lfdr.de>; Sat, 26 Feb 2022 00:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239458AbiBYXbK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Feb 2022 18:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbiBYXbG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Feb 2022 18:31:06 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B2519F473
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 15:30:31 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id o6so9423549ljp.3
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 15:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gORRKkd56nVlZ1cfz7qEp6vIkxxD3KbRh4C514IVtu0=;
        b=NQ9VpbGJ6QQrJGgru63SQc7fE8AfyroO/UwUDQ53ptdzkQguMguGYQybJVXvkDbqP2
         KLiK0+lLErkjgula/IL8Y4KXM/Fs0WlJKHQxmpqWVi0846wNGR7eMkCrTriCVVkMGsuu
         Qf95TCBJHh/OcEA01FELA2dddeDJppsymE1pOXSHdVoDUOEHZF+gEcj+EYBqkrsWVjZA
         GH8oaiO18TQL9VbXFZczq00poGwSyvD61dgW4Z0/em9bYDmIeW8TG+GsAgDgFEa/0CxP
         h4GCCwC6tsc7tS+Xf5GaNecfhdRrB/iV0FOeshF4ivAQWOeddckO6bUB05BM2gr9s+31
         iwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gORRKkd56nVlZ1cfz7qEp6vIkxxD3KbRh4C514IVtu0=;
        b=Yw8YGwrP176ryheTf2GCQiOFxjSEQyAZ/+KEMcfhp8l1TvWw9thCefFbZrTNeakEGx
         TtmMjPhD22xPnPab2vXQVlFchObnh3ctdcXixEdpDruoJp+ymUfkLrRHrmkeKsTu9OHl
         9YbiZ0LivV2mlT6D8pofiNsBsePU1FwaBgkuOOqyWf4zqZWf0gZuJwOYhT0x24GxvtuF
         iKzPGKw80ZdVKa05FXXyyW9fIqOumAVQGK7NlA1LIK7mXkNFiecxrn3bIfObwf/LkV2D
         LiofxpIU5lOMpWmxO4zubdq0mPpZaAPpcugM1tez2eH+e2C202OTOkT2vv10A1Yi3Iuy
         yxKQ==
X-Gm-Message-State: AOAM530nQswXzvS9Qxusc8/OJxQeDEv7nMuDW2d0e/1buqnrPz7XeTM9
        PxYB4IwnDCaVHWdPXDpMP907PA==
X-Google-Smtp-Source: ABdhPJyAn6xl7sDqnfTIhDB1L7u4SIu3ARo579+94q/hSD29FTVK5C+uTIhIELV7KYXU1T7tu7Uqbg==
X-Received: by 2002:a2e:bc17:0:b0:246:32b7:464 with SMTP id b23-20020a2ebc17000000b0024632b70464mr6665359ljf.506.1645831830222;
        Fri, 25 Feb 2022 15:30:30 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id u9-20020ac251c9000000b00443dc755dfdsm313524lfm.215.2022.02.25.15.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 15:30:29 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/6 v4] power: supply: ab8500: Standardize BTI resistance
Date:   Sat, 26 Feb 2022 00:27:57 +0100
Message-Id: <20220225232800.2021909-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220225232800.2021909-1-linus.walleij@linaro.org>
References: <20220225232800.2021909-1-linus.walleij@linaro.org>
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
ChangeLog v3->v4:
- Rebased on Sebastians linux-power-supply tree.
ChangeLog v2->v3:
- No changes
ChangeLog v1->v2:
- No changes
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
index bf0b74773eee..3e6ea22372b2 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -73,12 +73,6 @@ static struct power_supply_maintenance_charge_table ab8500_maint_charg_table[] =
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
@@ -214,6 +207,13 @@ int ab8500_bm_of_probe(struct power_supply *psy,
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
index 0227e800c58d..f2ff3103e0d0 100644
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
index e3d6d3ff492a..3d5047d3fe99 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -607,7 +607,9 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	info->temp_min                       = INT_MIN;
 	info->temp_max                       = INT_MAX;
 	info->factory_internal_resistance_uohm  = -EINVAL;
-	info->resist_table = NULL;
+	info->resist_table                   = NULL;
+	info->bti_resistance_ohm             = -EINVAL;
+	info->bti_resistance_tolerance       = -EINVAL;
 
 	for (index = 0; index < POWER_SUPPLY_OCV_TEMP_MAX; index++) {
 		info->ocv_table[index]       = NULL;
@@ -938,6 +940,28 @@ int power_supply_batinfo_ocv2cap(struct power_supply_battery_info *info,
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
index f8601598d3d3..7fdc03cf2285 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -498,6 +498,14 @@ struct power_supply_maintenance_charge_table {
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
@@ -624,6 +632,8 @@ struct power_supply_battery_info {
 	int ocv_table_size[POWER_SUPPLY_OCV_TEMP_MAX];
 	struct power_supply_resistance_temp_table *resist_table;
 	int resist_table_size;
+	int bti_resistance_ohm;
+	int bti_resistance_tolerance;
 };
 
 extern struct atomic_notifier_head power_supply_notifier;
@@ -667,6 +677,8 @@ power_supply_temp2resist_simple(struct power_supply_resistance_temp_table *table
 				int table_len, int temp);
 extern struct power_supply_maintenance_charge_table *
 power_supply_get_maintenance_charging_setting(struct power_supply_battery_info *info, int index);
+extern bool power_supply_battery_bti_in_range(struct power_supply_battery_info *info,
+					      int resistance);
 extern void power_supply_changed(struct power_supply *psy);
 extern int power_supply_am_i_supplied(struct power_supply *psy);
 int power_supply_get_property_from_supplier(struct power_supply *psy,
@@ -684,6 +696,7 @@ power_supply_supports_maintenance_charging(struct power_supply_battery_info *inf
 	return (mt != NULL);
 }
 
+
 #ifdef CONFIG_POWER_SUPPLY
 extern int power_supply_is_system_supplied(void);
 #else
-- 
2.34.1

