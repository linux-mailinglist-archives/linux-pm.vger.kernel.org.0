Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605194B38C0
	for <lists+linux-pm@lfdr.de>; Sun, 13 Feb 2022 01:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbiBMAKC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Feb 2022 19:10:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiBMAKB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Feb 2022 19:10:01 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8215FF3E
        for <linux-pm@vger.kernel.org>; Sat, 12 Feb 2022 16:09:56 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id c10so4725906ljr.9
        for <linux-pm@vger.kernel.org>; Sat, 12 Feb 2022 16:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oH/tMq7L/OsvHDpbHNtmdlbPvHB35ZJUR6sy0ukQHZ8=;
        b=Fg1H2j1Q1jH7doTae5TfBQIJWI8DdKSVPunynfcY+Uerp2+1xfA/vYDgqn1aN9eD68
         6LR7aOWFX3tf/CT34a+7rS8w1mPyHGyUw7LldgxEtLVsvu4s2isUGDTd1jmkJPTS9iWG
         bEqhf9p6TuzAKVos1+27DTbIJnuUxaqFf0IZsPdKYSBrmz6awY/rq2658dnpRRwFKvU2
         sSx9nKo9R0/35yr247GHMVjXDjFihlNtSJi7ipDvBWKYnCdt1p6DEqAICeejPZ5dfrWn
         rOFAm9YrdQBaN4L3U0c7ExKVHbx2IdWLoG3xMHAqx+F9FWDXH9bt+j3ADk0Zlu1fc9IK
         YWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oH/tMq7L/OsvHDpbHNtmdlbPvHB35ZJUR6sy0ukQHZ8=;
        b=p3myRhnSg3J6Aanycz0/EHe0LxFfem4i6VmWEf0hPIkh3YUu7ZD4NWJFSKX6vsgVOJ
         N13kQvMXY7TWS543eEwDjKKmJJw/s3qv3CMnz8Mv35cHIWQ7wPZvFxfbX/0FrQukBsKZ
         1KPoWzcFSBZCy5C2XISa36EnObWqChCkgoxoV19OZyFTRcbAGWLLr21koDAcU7uu6t/g
         qMQKM+LDZCNjHrZJCHFRJPxv+EMsUluA9hkXxA8xc5S84HsN9z1ti1jSBrfKViE+pMia
         pOSPlfHDLeoCCDrmiw8b6ETs2mznaCA5LoHE/3SoBttqhfxBRMRtax3pN1VP35w+qRZm
         5dnA==
X-Gm-Message-State: AOAM530rkiWWtlsCiq44+ph840Bc68bHAEsLqxp5Mj8qfxCyHs41IicT
        VwYJSKLLniHRlPy+EYrSr9OU6VnkgLfZNH93
X-Google-Smtp-Source: ABdhPJyYp/pByhpzaoTjmo2gqW7kaCuxVOTDNb4M6P7ioC+VV6x4SE/OHdxq2vXlBAJItB7xfsUiFw==
X-Received: by 2002:a2e:a546:: with SMTP id e6mr4704195ljn.98.1644710995258;
        Sat, 12 Feb 2022 16:09:55 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id g30sm382292lja.39.2022.02.12.16.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 16:09:54 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/6 v2] power: supply: ab8500: Standardize BTI resistance
Date:   Sun, 13 Feb 2022 01:07:00 +0100
Message-Id: <20220213000703.772673-4-linus.walleij@linaro.org>
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
index 5d7d15860529..cbe957088c56 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -602,7 +602,9 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	info->temp_min                       = INT_MIN;
 	info->temp_max                       = INT_MAX;
 	info->factory_internal_resistance_uohm  = -EINVAL;
-	info->resist_table = NULL;
+	info->resist_table                   = NULL;
+	info->bti_resistance_ohm             = -EINVAL;
+	info->bti_resistance_tolerance       = -EINVAL;
 
 	for (index = 0; index < POWER_SUPPLY_OCV_TEMP_MAX; index++) {
 		info->ocv_table[index]       = NULL;
@@ -915,6 +917,28 @@ int power_supply_batinfo_ocv2cap(struct power_supply_battery_info *info,
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
index 42a47d7aa3fd..ed206ac64122 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -497,6 +497,14 @@ struct power_supply_maintenance_charge_table {
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
@@ -623,6 +631,8 @@ struct power_supply_battery_info {
 	int ocv_table_size[POWER_SUPPLY_OCV_TEMP_MAX];
 	struct power_supply_resistance_temp_table *resist_table;
 	int resist_table_size;
+	int bti_resistance_ohm;
+	int bti_resistance_tolerance;
 };
 
 extern struct atomic_notifier_head power_supply_notifier;
@@ -666,6 +676,8 @@ power_supply_temp2resist_simple(struct power_supply_resistance_temp_table *table
 				int table_len, int temp);
 extern struct power_supply_maintenance_charge_table *
 power_supply_get_maintenance_charging_setting(struct power_supply_battery_info *info, int index);
+extern bool power_supply_battery_bti_in_range(struct power_supply_battery_info *info,
+					      int resistance);
 extern void power_supply_changed(struct power_supply *psy);
 extern int power_supply_am_i_supplied(struct power_supply *psy);
 extern int power_supply_set_input_current_limit_from_supplier(
@@ -682,6 +694,7 @@ power_supply_supports_maintenance_charging(struct power_supply_battery_info *inf
 	return (mt != NULL);
 }
 
+
 #ifdef CONFIG_POWER_SUPPLY
 extern int power_supply_is_system_supplied(void);
 #else
-- 
2.34.1

