Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72724C3A31
	for <lists+linux-pm@lfdr.de>; Fri, 25 Feb 2022 01:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiBYAP7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 19:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiBYAP6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 19:15:58 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7E22692FC
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 16:15:27 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id b9so6656903lfv.7
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 16:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jhZqumWiQOsDPbjWa5PcQ3R6sfjJQUAoD7px6LyGo7E=;
        b=I5fo2iBhhNkRtYGtltOXJ1VXosu3TxzNwKMBD37Bmk1Fn0XS8hOVnCwJ0rq66hXqm7
         04/l+1yu2YNyKHPEwIYcV2iY9Qf3sZyTTbrLryWUQJMGo5KmC9W6WwJ9/REuPWnCxLLb
         nVWxGBNRkhw7dsm9bhv6MKHM28voBc/31pfWvbQ1IAcQ8aq/9lCz4SoEExKQL8CLohD3
         gSyRV9iZXGFft6yD2REW3dG7YmPflqIwTzzz7DJtgS0RumcUGrhDglpvUhgwNB/4FIAW
         QSNUO4Lp7sT/hzcNwrCpZasWmfBV4d4Ead8XWBjcjf4Ud6VkhfHsmSrdq6sw9Bxq3Bfa
         GZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jhZqumWiQOsDPbjWa5PcQ3R6sfjJQUAoD7px6LyGo7E=;
        b=bBEWUFrarW+r/BLqrpSKvhStp+pSCnQgdVKQU/JOKG7vJvpeKnmZd/OvGbKoqqFx1o
         Hpgh6JBvWjLPTlDxsv0ITMiuUEeXHdC7cEo5zSkrRvysSQzfkn+KDuhKLrurTFjAdoqq
         zsVwuTkHY5SIEVsDMFUYZ7Ekjtj2ukEUYjBH0fg1WFrvyn4K51KF1w/MPlKcwS+vGj73
         i61TnLJLrVyb/D5CQGIFHzTqeqVUrTinteNDbq91TsPefrhHnmiN6g6/cd8EIDPui7UN
         A6hm4vxJ0v7BEV/PSOgyd5CuMnmBxI8GVQWpsJ5RaYFukNlTuW+tuWc2KHxzVpbE8bUU
         C6Sg==
X-Gm-Message-State: AOAM533kDa0hUyHElstlEWNL6H8mLKar5ZFzvxuBpf/bIP0m13jPZRFk
        hjXjzEHlSdFhkPhv4zKd5zsWEz3FXv4sgQKo
X-Google-Smtp-Source: ABdhPJzZOsPJk1ufHStFNSXeF3IqsrXuqPIhrmACVH5eT0OEnqSWgGr4NLD/sN5+uv3fr5acTps/5g==
X-Received: by 2002:ac2:5fe1:0:b0:443:4e28:7ccb with SMTP id s1-20020ac25fe1000000b004434e287ccbmr3289133lfg.30.1645748125498;
        Thu, 24 Feb 2022 16:15:25 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id 16-20020ac25f10000000b00443890bd84asm55859lfq.114.2022.02.24.16.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:15:25 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/6 v3] power: supply: ab8500: Standardize alert mode charging
Date:   Fri, 25 Feb 2022 01:13:10 +0100
Message-Id: <20220225001314.1881549-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220225001314.1881549-1-linus.walleij@linaro.org>
References: <20220225001314.1881549-1-linus.walleij@linaro.org>
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

The AB8500 code is using a special current and voltage setting
when the battery is in "alert mode", i.e. when it is starting
to go outside normal operating conditions so it is too
cold or too hot. This makes sense as a way for the charging
algorithm to deal with hostile environments.

Add the needed members to the struct power_supply_battery_info,
and switch the AB8500 charging code over to using this.

Reviewed-by: Matti Vaittineen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Collect Matti's Review tag
ChangeLog v1->v2:
- Split the combined alert temperature state current and
  voltage into two: one for low temperature and one for high
  temperature.
- Augment the AB8500 charging algorithm to keep track of if
  the battery got too cold or too warm
- Utilize the different voltages in the AB8500 driver.
---
 drivers/power/supply/ab8500-bm.h         |  4 --
 drivers/power/supply/ab8500_bmdata.c     | 15 +++++++-
 drivers/power/supply/ab8500_chargalg.c   | 48 ++++++++++++++++--------
 drivers/power/supply/power_supply_core.c |  4 ++
 include/linux/power_supply.h             | 17 +++++++++
 5 files changed, 66 insertions(+), 22 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index 4d74d21cf1eb..91ef9d4a5222 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -331,14 +331,10 @@ struct ab8500_maxim_parameters {
  * struct ab8500_battery_type - different batteries supported
  * @resis_high:			battery upper resistance limit
  * @resis_low:			battery lower resistance limit
- * @low_high_cur_lvl:		charger current in temp low/high state in mA
- * @low_high_vol_lvl:		charger voltage in temp low/high state in mV'
  */
 struct ab8500_battery_type {
 	int resis_high;
 	int resis_low;
-	int low_high_cur_lvl;
-	int low_high_vol_lvl;
 };
 
 /**
diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index 66a454942c7c..bf0b74773eee 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -77,8 +77,6 @@ static struct power_supply_maintenance_charge_table ab8500_maint_charg_table[] =
 static struct ab8500_battery_type bat_type_thermistor_unknown = {
 	.resis_high = 0,
 	.resis_low = 0,
-	.low_high_cur_lvl = 300,
-	.low_high_vol_lvl = 4000,
 };
 
 static const struct ab8500_bm_capacity_levels cap_levels = {
@@ -192,6 +190,19 @@ int ab8500_bm_of_probe(struct power_supply *psy,
 		bi->maintenance_charge_size = ARRAY_SIZE(ab8500_maint_charg_table);
 	}
 
+	if (bi->alert_low_temp_charge_current_ua < 0 ||
+	    bi->alert_low_temp_charge_voltage_uv < 0)
+	{
+		bi->alert_low_temp_charge_current_ua = 300000;
+		bi->alert_low_temp_charge_voltage_uv = 4000000;
+	}
+	if (bi->alert_high_temp_charge_current_ua < 0 ||
+	    bi->alert_high_temp_charge_voltage_uv < 0)
+	{
+		bi->alert_high_temp_charge_current_ua = 300000;
+		bi->alert_high_temp_charge_voltage_uv = 4000000;
+	}
+
 	/*
 	 * Internal resistance and factory resistance are tightly coupled
 	 * so both MUST be defined or we fall back to defaults.
diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index 6054996b6260..c9c7f7028af6 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -149,7 +149,8 @@ struct ab8500_chargalg_events {
 	bool batt_ovv;
 	bool batt_rem;
 	bool btemp_underover;
-	bool btemp_lowhigh;
+	bool btemp_low;
+	bool btemp_high;
 	bool main_thermal_prot;
 	bool usb_thermal_prot;
 	bool main_ovv;
@@ -684,26 +685,31 @@ static void ab8500_chargalg_check_temp(struct ab8500_chargalg *di)
 		di->batt_data.temp < (bi->temp_alert_max - di->t_hyst_norm)) {
 		/* Temp OK! */
 		di->events.btemp_underover = false;
-		di->events.btemp_lowhigh = false;
+		di->events.btemp_low = false;
+		di->events.btemp_high = false;
 		di->t_hyst_norm = 0;
 		di->t_hyst_lowhigh = 0;
 	} else {
-		if (((di->batt_data.temp >= bi->temp_alert_max) &&
-			(di->batt_data.temp <
-				(bi->temp_max - di->t_hyst_lowhigh))) ||
-			((di->batt_data.temp >
-				(bi->temp_min + di->t_hyst_lowhigh)) &&
-			(di->batt_data.temp <= bi->temp_alert_min))) {
-			/* TEMP minor!!!!! */
+		if ((di->batt_data.temp >= bi->temp_alert_max) &&
+		    (di->batt_data.temp < (bi->temp_max - di->t_hyst_lowhigh))) {
+			/* Alert zone for high temperature */
 			di->events.btemp_underover = false;
-			di->events.btemp_lowhigh = true;
+			di->events.btemp_high = true;
+			di->t_hyst_norm = di->bm->temp_hysteresis;
+			di->t_hyst_lowhigh = 0;
+		} else if ((di->batt_data.temp > (bi->temp_min + di->t_hyst_lowhigh)) &&
+			   (di->batt_data.temp <= bi->temp_alert_min)) {
+			/* Alert zone for low temperature */
+			di->events.btemp_underover = false;
+			di->events.btemp_low = true;
 			di->t_hyst_norm = di->bm->temp_hysteresis;
 			di->t_hyst_lowhigh = 0;
 		} else if (di->batt_data.temp <= bi->temp_min ||
 			di->batt_data.temp >= bi->temp_max) {
 			/* TEMP major!!!!! */
 			di->events.btemp_underover = true;
-			di->events.btemp_lowhigh = false;
+			di->events.btemp_low = false;
+			di->events.btemp_high = false;
 			di->t_hyst_norm = 0;
 			di->t_hyst_lowhigh = di->bm->temp_hysteresis;
 		} else {
@@ -1313,7 +1319,7 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 			ab8500_chargalg_state_to(di, STATE_WD_EXPIRED_INIT);
 	}
 	/* Battery temp high/low */
-	else if (di->events.btemp_lowhigh) {
+	else if (di->events.btemp_low || di->events.btemp_high) {
 		if (di->charge_state != STATE_TEMP_LOWHIGH)
 			ab8500_chargalg_state_to(di, STATE_TEMP_LOWHIGH_INIT);
 	}
@@ -1510,9 +1516,19 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 		break;
 
 	case STATE_TEMP_LOWHIGH_INIT:
-		ab8500_chargalg_start_charging(di,
-			di->bm->bat_type->low_high_vol_lvl,
-			di->bm->bat_type->low_high_cur_lvl);
+		if (di->events.btemp_low) {
+			ab8500_chargalg_start_charging(di,
+				       bi->alert_low_temp_charge_voltage_uv,
+				       bi->alert_low_temp_charge_current_ua);
+		} else if (di->events.btemp_high) {
+			ab8500_chargalg_start_charging(di,
+				       bi->alert_high_temp_charge_voltage_uv,
+				       bi->alert_high_temp_charge_current_ua);
+		} else {
+			dev_err(di->dev, "neither low or high temp event occured\n");
+			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
+			break;
+		}
 		ab8500_chargalg_stop_maintenance_timer(di);
 		di->charge_status = POWER_SUPPLY_STATUS_CHARGING;
 		ab8500_chargalg_state_to(di, STATE_TEMP_LOWHIGH);
@@ -1520,7 +1536,7 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 		fallthrough;
 
 	case STATE_TEMP_LOWHIGH:
-		if (!di->events.btemp_lowhigh)
+		if (!di->events.btemp_low && !di->events.btemp_high)
 			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
 		break;
 
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 6568939e4518..5d7d15860529 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -591,6 +591,10 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	info->charge_restart_voltage_uv      = -EINVAL;
 	info->overvoltage_limit_uv           = -EINVAL;
 	info->maintenance_charge             = NULL;
+	info->alert_low_temp_charge_current_ua = -EINVAL;
+	info->alert_low_temp_charge_voltage_uv = -EINVAL;
+	info->alert_high_temp_charge_current_ua = -EINVAL;
+	info->alert_high_temp_charge_voltage_uv = -EINVAL;
 	info->temp_ambient_alert_min         = INT_MIN;
 	info->temp_ambient_alert_max         = INT_MAX;
 	info->temp_alert_min                 = INT_MIN;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index b998fc4c87ae..42a47d7aa3fd 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -443,6 +443,19 @@ struct power_supply_maintenance_charge_table {
  *   after the main CC/CV charging phase is complete.
  * @maintenance_charge_size: the number of maintenance charging settings in
  *   maintenance_charge.
+ * @alert_low_temp_charge_current_ua: The charging current to use if the battery
+ *   enters low alert temperature, i.e. if the internal temperature is between
+ *   temp_alert_min and temp_min. No matter the charging phase, this
+ *   and alert_high_temp_charge_voltage_uv will be applied.
+ * @alert_low_temp_charge_voltage_uv: Same as alert_low_temp_charge_current_ua,
+ *   but for the charging voltage.
+ * @alert_high_temp_charge_current_ua: The charging current to use if the
+ *   battery enters high alert temperature, i.e. if the internal temperature is
+ *   between temp_alert_max and temp_max. No matter the charging phase, this
+ *   and alert_high_temp_charge_voltage_uv will be applied, usually lowering
+ *   the charging current as an evasive manouver.
+ * @alert_high_temp_charge_voltage_uv: Same as
+ *   alert_high_temp_charge_current_ua, but for the charging voltage.
  * @factory_internal_resistance_uohm: the internal resistance of the battery
  *   at fabrication time, expressed in microohms. This resistance will vary
  *   depending on the lifetime and charge of the battery, so this is just a
@@ -594,6 +607,10 @@ struct power_supply_battery_info {
 	int constant_charge_voltage_max_uv;
 	struct power_supply_maintenance_charge_table *maintenance_charge;
 	int maintenance_charge_size;
+	int alert_low_temp_charge_current_ua;
+	int alert_low_temp_charge_voltage_uv;
+	int alert_high_temp_charge_current_ua;
+	int alert_high_temp_charge_voltage_uv;
 	int factory_internal_resistance_uohm;
 	int ocv_temp[POWER_SUPPLY_OCV_TEMP_MAX];
 	int temp_ambient_alert_min;
-- 
2.34.1

