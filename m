Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C345D457F1F
	for <lists+linux-pm@lfdr.de>; Sat, 20 Nov 2021 16:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbhKTP6v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 Nov 2021 10:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhKTP6u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 Nov 2021 10:58:50 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACE0C061574
        for <linux-pm@vger.kernel.org>; Sat, 20 Nov 2021 07:55:46 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b40so58204934lfv.10
        for <linux-pm@vger.kernel.org>; Sat, 20 Nov 2021 07:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lO2GuLt3DdDJ4wv71iPoyrqonXMLK5fmNIVTy8GjvhY=;
        b=JYtSqIgVCGDG4mRF4xwybZncCimjqUhQZGmwlu56l95SuTrsfxbXtvi+iu/mpvyrcc
         XakOU5C8qPLzjPVfEUPEt1JDM6jutoIJLDbH3N/aDz2lwT/foRvx9IeVL34y8vm1y2Ni
         xuVYp9q4QKjWW1h4iztLx7Oc7ZPbXXTzI1+8Qm1zlm30sAXlgyLMOFA81Ic20JomraTQ
         qmdILT8PtTyY5d2tGGU+LwqF+GC0x7RXqy0W2jH5kR/n2vsGMFhIXCMOXiEFxW3nP1OE
         grKojhyd0Ewa/IssHcVp5YOdyLowJr/XtHmVW+1dgbOBKuVRucvS+cTwDyd/FI22v28o
         zwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lO2GuLt3DdDJ4wv71iPoyrqonXMLK5fmNIVTy8GjvhY=;
        b=rA6nCZ3XQH+TenzV3M50RxyJNGCmsW7+4qSzXuRCactu2yG05WVY3GVTITIivhrXpP
         gFCyvofCf9iRMJs0yXMefTqJjH33CNnNzWmfA+GJYjHw1UvJWrOdozEo3s5CV2qx/zLd
         ayDXLdVyz2LVjrYFk4SbdszjfcvcVPwv9qQBCzaxkr4eYO8B0epHwUT8WHrdP6gNCmnh
         VK3HykRN1Gk40kYfTQbTq/614U5fOdaLtrYm04fFe77TtJ2ccf5NFYFKkdUaGFwWGDdB
         102DPCXXgus3hUFeoC850UsEs0UzaWZudDPDoyxwMQrxxpw4TwIhidbGaT7ek5YIgddI
         e/mw==
X-Gm-Message-State: AOAM530rtW8fNXXn92BOZ4UWYT4K2XH6EHN1LuHj0G6dIL9JIubf99jh
        R8wNTPY3vH81aIc3OccUfy3Yc4SsIyMTAg==
X-Google-Smtp-Source: ABdhPJzI9YEXk/tM2Quoyua3L4tpC8Kyjqhwj2wzw3r/sTwbF95q7JUw1fL4W+hWl9h3OQbwD2CjbQ==
X-Received: by 2002:a2e:5d7:: with SMTP id 206mr35569587ljf.133.1637423745178;
        Sat, 20 Nov 2021 07:55:45 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id t12sm280922ljg.63.2021.11.20.07.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 07:55:44 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 03/16] power: supply: ab8500: Standardize operating temperature
Date:   Sat, 20 Nov 2021 16:53:13 +0100
Message-Id: <20211120155326.2891664-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211120155326.2891664-1-linus.walleij@linaro.org>
References: <20211120155326.2891664-1-linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- Account for introducing power_supply_put_battery_info()
  with a second remove() callback into bmdata.
---
 drivers/power/supply/ab8500-bm.h       | 12 +++----
 drivers/power/supply/ab8500_bmdata.c   | 43 +++++++++++++++++++-------
 drivers/power/supply/ab8500_chargalg.c | 20 ++++++------
 drivers/power/supply/ab8500_charger.c  |  1 +
 4 files changed, 48 insertions(+), 28 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index bcb054810290..fe783610bc54 100644
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
@@ -564,6 +558,8 @@ int ab8500_fg_inst_curr_started(struct ab8500_fg *di);
 int ab8500_fg_inst_curr_done(struct ab8500_fg *di);
 int ab8500_bm_of_probe(struct power_supply *psy,
 		       struct ab8500_bm_data *bm);
+void ab8500_bm_of_remove(struct power_supply *psy,
+			 struct ab8500_bm_data *bm);
 
 extern struct platform_driver ab8500_fg_driver;
 extern struct platform_driver ab8500_btemp_driver;
diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index 6f6865c46926..41561b6adfd3 100644
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
@@ -507,7 +524,11 @@ int ab8500_bm_of_probe(struct power_supply *psy,
 	for (i = 0; i < bm->n_btypes; ++i)
 		bm->bat_type[i].batres_tbl = tmp_batres_tbl;
 
-	power_supply_put_battery_info(psy, &info);
-
 	return 0;
 }
+
+void ab8500_bm_of_remove(struct power_supply *psy,
+			 struct ab8500_bm_data *bm)
+{
+	power_supply_put_battery_info(psy, &bm->bi);
+}
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
diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 32c2046ea6bb..7a151cd97399 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3709,6 +3709,7 @@ static int ab8500_charger_remove(struct platform_device *pdev)
 	component_master_del(&pdev->dev, &ab8500_charger_comp_ops);
 
 	usb_unregister_notifier(di->usb_phy, &di->nb);
+	ab8500_bm_of_remove(di->usb_chg.psy, di->bm);
 	usb_put_phy(di->usb_phy);
 	if (!di->ac_chg.enabled)
 		blocking_notifier_chain_unregister(
-- 
2.31.1

