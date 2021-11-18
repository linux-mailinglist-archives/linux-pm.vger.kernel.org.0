Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4343445528F
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 03:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242450AbhKRCXH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 21:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239811AbhKRCXE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 21:23:04 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F09FC061570
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:20:05 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b1so17820407lfs.13
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W5jAcQ6nyZV6u4Lu1u9FXPSWCE9PAnr97jNCaPUqlNk=;
        b=lX+l+kAM9fLP95Z+6ZXFlF24jT/bu+15RScSZ01YbLXqLk3Aj7KDXib0B8Kzd9fbIW
         hJic4myXnbnjNsDHaS0ctKIn2dZmp1iTxvWM2d2w4eDMeegIKOjUXDdx+UyulLQba2Wq
         0l7cfewrbBvLkmFXsQpDuv8jvsPwsjJURrQr0RpNZ8ql6JaxxFkefNhj/TsnNii+1mKB
         U/XkTqajrq97qQXq2wDbvtjMQvIV6nsse+QN9q4tfKRN5uoNVLWUR4c/Bwm1c/nSTl93
         TkkiVaovTJCD4dliIqXAwczWug1DqV/+t+HB1te3C9bmktmGqth52kGKw2Z9Afr0i98l
         lvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W5jAcQ6nyZV6u4Lu1u9FXPSWCE9PAnr97jNCaPUqlNk=;
        b=ZwK6lhuhYlcKQfhhM3WzyU3hRIsmV5jj2jBC1t+xKsPQLXK4UTSjnNCbMSuTK1laVT
         iP/cRwx/UChl4e8GeoTgMuk0/pX4B1uPE9MOufqlAmfar39mNxNEEp5XzKp9BO5rcjDL
         bEiiOFqCAWMRA8pFEIl2RWyYvlj7dtMdiF2Uin2t3bvZhyfew8wDKIpK8P1oaO5v0car
         K5tDfPyxuIM952XNJ5At9Sq1f5Wyqu6eM+PylXrlIGtI6RHs6+jQvNFkL5vKrdYxNjH+
         UYTY+l5OlNTBtYqYGzSfyLGU9ABV6eBsD84bmu0f+VOQmLsoJ7iusUyn+YvXq/qJd1O6
         Rw5g==
X-Gm-Message-State: AOAM533Wj6wuswdUNJlLMRjhzj9GI1E2WQgnKvLqnV0Wg/IjUqGF/Eka
        2G2BtZIYn6pz6YOfEvs+X/CGFw==
X-Google-Smtp-Source: ABdhPJy7kvJj4xjCvqqqOoXLRpzARhH0kzqwT6rWuolonIVKYMA6mnozJFaeLpIpvEbUsdLejGZF3w==
X-Received: by 2002:a2e:b8cc:: with SMTP id s12mr12987255ljp.489.1637202003209;
        Wed, 17 Nov 2021 18:20:03 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id j19sm165321lfe.120.2021.11.17.18.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 18:20:02 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 03/16] power: supply: ab8500: Standardize operating temperature
Date:   Thu, 18 Nov 2021 03:17:39 +0100
Message-Id: <20211118021752.2262818-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118021752.2262818-1-linus.walleij@linaro.org>
References: <20211118021752.2262818-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Instead of storing the temperature limits in our custom
struct struct ab8500_bm_data, make struct power_supply_battery_info
a member of this and store the min and max temperatures inside
that struct as the temp_min/temp_max and
temp_alert_min/temp_alert_max respectively.

The values can be assigned from the device tree, but if
not present will be set to the same defaults as are currently
in the code.

This way we start to move over to using
struct power_supply_battery_info and make it possible to move
the data over to the device tree and we will move piece by
piece toward using the standard info struct.

Temperature hysteresis is currently not supported by the
standard struct but we move the assignment here as well so
that we have all parameterization in one spot.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500-bm.h       | 10 ++------
 drivers/power/supply/ab8500_bmdata.c   | 35 +++++++++++++++++++-------
 drivers/power/supply/ab8500_chargalg.c | 20 ++++++++-------
 3 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index bcb054810290..36bc28f1604f 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -460,10 +460,7 @@ struct ab8500_bm_charger_parameters {
 
 /**
  * struct ab8500_bm_data - ab8500 battery management data
- * @temp_under		under this temp, charging is stopped
- * @temp_low		between this temp and temp_under charging is reduced
- * @temp_high		between this temp and temp_over charging is reduced
- * @temp_over		over this temp, charging is stopped
+ * @bi			battery info from device tree
  * @temp_now		present battery temperature
  * @temp_interval_chg	temperature measurement interval in s when charging
  * @temp_interval_nochg	temperature measurement interval in s when not charging
@@ -491,10 +488,7 @@ struct ab8500_bm_charger_parameters {
  * @fg_params		fuel gauge parameters
  */
 struct ab8500_bm_data {
-	int temp_under;
-	int temp_low;
-	int temp_high;
-	int temp_over;
+	struct power_supply_battery_info bi;
 	int temp_now;
 	int temp_interval_chg;
 	int temp_interval_nochg;
diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index b86a88f4f4d2..4ad4a66e7e37 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -5,6 +5,17 @@
 
 #include "ab8500-bm.h"
 
+/* Default: under this temperature, charging is stopped */
+#define AB8500_TEMP_UNDER	3
+/* Default: between this temp and AB8500_TEMP_UNDER charging is reduced */
+#define AB8500_TEMP_LOW		8
+/* Default: between this temp and AB8500_TEMP_OVER charging is reduced */
+#define AB8500_TEMP_HIGH	43
+/* Default: over this temp, charging is stopped */
+#define AB8500_TEMP_OVER	48
+/* Default: temperature hysteresis */
+#define AB8500_TEMP_HYSTERESIS	3
+
 /*
  * These are the defined batteries that uses a NTC and ID resistor placed
  * inside of the battery pack.
@@ -437,10 +448,6 @@ static const struct ab8500_bm_charger_parameters chg = {
 };
 
 struct ab8500_bm_data ab8500_bm_data = {
-	.temp_under             = 3,
-	.temp_low               = 8,
-	.temp_high              = 43,
-	.temp_over              = 48,
 	.main_safety_tmr_h      = 4,
 	.temp_interval_chg      = 20,
 	.temp_interval_nochg    = 120,
@@ -459,7 +466,6 @@ struct ab8500_bm_data ab8500_bm_data = {
 	.batt_id                = 0,
 	.interval_charging      = 5,
 	.interval_not_charging  = 120,
-	.temp_hysteresis        = 3,
 	.gnd_lift_resistance    = 34,
 	.maxi                   = &ab8500_maxi_params,
 	.chg_params             = &chg,
@@ -470,18 +476,29 @@ int ab8500_bm_of_probe(struct power_supply *psy,
 		       struct ab8500_bm_data *bm)
 {
 	const struct batres_vs_temp *tmp_batres_tbl;
-	struct power_supply_battery_info info;
+	struct power_supply_battery_info *bi = &bm->bi;
 	struct device *dev = &psy->dev;
 	int ret;
 	int i;
 
-	ret = power_supply_get_battery_info(psy, &info);
+	ret = power_supply_get_battery_info(psy, bi);
 	if (ret) {
 		dev_err(dev, "cannot retrieve battery info\n");
 		return ret;
 	}
 
-	if (info.technology == POWER_SUPPLY_TECHNOLOGY_LION) {
+	if (bi->temp_min == INT_MIN)
+		bi->temp_min = AB8500_TEMP_UNDER;
+	if (bi->temp_max == INT_MAX)
+		bi->temp_max = AB8500_TEMP_OVER;
+	if (bi->temp_alert_min == INT_MIN)
+		bi->temp_alert_min = AB8500_TEMP_LOW;
+	if (bi->temp_alert_max == INT_MAX)
+		bi->temp_alert_max = AB8500_TEMP_HIGH;
+	bm->temp_hysteresis = AB8500_TEMP_HYSTERESIS;
+
+
+	if (bi->technology == POWER_SUPPLY_TECHNOLOGY_LION) {
 		bm->no_maintenance  = true;
 		bm->chg_unknown_bat = true;
 		bm->bat_type[BATTERY_UNKNOWN].charge_full_design = 2600;
@@ -492,7 +509,7 @@ int ab8500_bm_of_probe(struct power_supply *psy,
 	}
 
 	if (of_property_read_bool(psy->of_node, "thermistor-on-batctrl")) {
-		if (info.technology == POWER_SUPPLY_TECHNOLOGY_LION)
+		if (bi->technology == POWER_SUPPLY_TECHNOLOGY_LION)
 			tmp_batres_tbl = temp_to_batres_tbl_9100;
 		else
 			tmp_batres_tbl = temp_to_batres_tbl_thermistor;
diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index ff4b26b1ceca..9196434393e8 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -722,27 +722,29 @@ static void ab8500_chargalg_start_charging(struct ab8500_chargalg *di,
  */
 static void ab8500_chargalg_check_temp(struct ab8500_chargalg *di)
 {
-	if (di->batt_data.temp > (di->bm->temp_low + di->t_hyst_norm) &&
-		di->batt_data.temp < (di->bm->temp_high - di->t_hyst_norm)) {
+	struct power_supply_battery_info *bi = &di->bm->bi;
+
+	if (di->batt_data.temp > (bi->temp_alert_min + di->t_hyst_norm) &&
+		di->batt_data.temp < (bi->temp_alert_max - di->t_hyst_norm)) {
 		/* Temp OK! */
 		di->events.btemp_underover = false;
 		di->events.btemp_lowhigh = false;
 		di->t_hyst_norm = 0;
 		di->t_hyst_lowhigh = 0;
 	} else {
-		if (((di->batt_data.temp >= di->bm->temp_high) &&
+		if (((di->batt_data.temp >= bi->temp_alert_max) &&
 			(di->batt_data.temp <
-				(di->bm->temp_over - di->t_hyst_lowhigh))) ||
+				(bi->temp_max - di->t_hyst_lowhigh))) ||
 			((di->batt_data.temp >
-				(di->bm->temp_under + di->t_hyst_lowhigh)) &&
-			(di->batt_data.temp <= di->bm->temp_low))) {
+				(bi->temp_min + di->t_hyst_lowhigh)) &&
+			(di->batt_data.temp <= bi->temp_alert_min))) {
 			/* TEMP minor!!!!! */
 			di->events.btemp_underover = false;
 			di->events.btemp_lowhigh = true;
 			di->t_hyst_norm = di->bm->temp_hysteresis;
 			di->t_hyst_lowhigh = 0;
-		} else if (di->batt_data.temp <= di->bm->temp_under ||
-			di->batt_data.temp >= di->bm->temp_over) {
+		} else if (di->batt_data.temp <= bi->temp_min ||
+			di->batt_data.temp >= bi->temp_max) {
 			/* TEMP major!!!!! */
 			di->events.btemp_underover = true;
 			di->events.btemp_lowhigh = false;
@@ -1722,7 +1724,7 @@ static int ab8500_chargalg_get_property(struct power_supply *psy,
 		if (di->events.batt_ovv) {
 			val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
 		} else if (di->events.btemp_underover) {
-			if (di->batt_data.temp <= di->bm->temp_under)
+			if (di->batt_data.temp <= di->bm->bi.temp_min)
 				val->intval = POWER_SUPPLY_HEALTH_COLD;
 			else
 				val->intval = POWER_SUPPLY_HEALTH_OVERHEAT;
-- 
2.31.1

