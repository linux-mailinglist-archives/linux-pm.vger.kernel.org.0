Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41F54A89EE
	for <lists+linux-pm@lfdr.de>; Thu,  3 Feb 2022 18:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbiBCR0B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Feb 2022 12:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352818AbiBCR0B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Feb 2022 12:26:01 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48FBC06173E
        for <linux-pm@vger.kernel.org>; Thu,  3 Feb 2022 09:26:00 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b9so7460886lfq.6
        for <linux-pm@vger.kernel.org>; Thu, 03 Feb 2022 09:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QWWivEGpheIH4Ih0CbNW/ntIZOo4pfukguKKZNB2+CY=;
        b=KwoCRQJlqJ70AFhvU/s00LdllxtbdCTgtv74kJ8E7R6oMLsKk8AAYqIoKez6oqkeCT
         5BdT4Kr46wygO3voVVJVQte/TP2E3zN0U8/+4HG7oYLyBU0vwxNZxZijg3lMGUwCR1H9
         36rME4oN72Mj8EKAOLywCRIj6OpboFBDgnEox6jUxI/D7UwUwYWkZernV6GbNqkl1a4+
         +o3v8FVb0QIdtV9JaCydnQ9Cm6F2ZFdPLyD+mN/JzPszdEEAoAJEJlx5ovGviT0ykWRo
         5XPLnA4xx0WE7akUuCME9mnGtc0r6SXmiYybvRtShyC8HlMgKpnGn7KGy34pogMFnow1
         yJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QWWivEGpheIH4Ih0CbNW/ntIZOo4pfukguKKZNB2+CY=;
        b=ogEnkJOBU7D0cr2zWbo7Em+4JbFcHh0hpVBNP/OKZJqXTl10+XHes+ABYklgpJ91N1
         2GvoXLqC6d+Z2ehceTv1au8AcUkgv01W4fkVju8gBN/22CHqvZ5Oq6kvWhLiuRcpPmz5
         tBK/98MVx5+DaJoTItrrKYiAVHeBRZ4AzvDV+7fs1JvWqzZuRQMGD+1VFVia2aqScOIs
         wiQZYhUEIRaanlopYl99JWpWRbDSn16d+vdXobKmt5InAro7o9mYJ0ihKUFe+HCwGqjx
         rY/tyy/al/KFj/pbPrf5VOmA4wYVjgakh316cyaGp4g4nhvcsIofNE2Xt81xLsa0E+BN
         wGBA==
X-Gm-Message-State: AOAM531cslRcTkRmlYXxThzTYesD1l4CO+tkbpD0f8I1kehenJQ7aKez
        qYpC4Tv52nC9gc18L3YOdb51UA==
X-Google-Smtp-Source: ABdhPJzpY4ahh1pHb6IO0atmsoqAUTA+ScX7m9hLOShWP54vmzcM3DEuEKmDo0nJJfezSFe15jDXIA==
X-Received: by 2002:a05:6512:e87:: with SMTP id bi7mr28333182lfb.550.1643909159013;
        Thu, 03 Feb 2022 09:25:59 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id b13sm1640699lff.240.2022.02.03.09.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 09:25:58 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/6] power: supply: ab8500: Standardize alert mode charging
Date:   Thu,  3 Feb 2022 18:16:29 +0100
Message-Id: <20220203171633.183828-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203171633.183828-1-linus.walleij@linaro.org>
References: <20220203171633.183828-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500-bm.h         |  4 ----
 drivers/power/supply/ab8500_bmdata.c     |  9 +++++++--
 drivers/power/supply/ab8500_chargalg.c   |  4 ++--
 drivers/power/supply/power_supply_core.c |  2 ++
 include/linux/power_supply.h             | 10 ++++++++++
 5 files changed, 21 insertions(+), 8 deletions(-)

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
index c104afe83b4b..c878dc6e4197 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -77,8 +77,6 @@ struct power_supply_maintenance_charge_table maint_charge_table[] = {
 static struct ab8500_battery_type bat_type_thermistor_unknown = {
 	.resis_high = 0,
 	.resis_low = 0,
-	.low_high_cur_lvl = 300,
-	.low_high_vol_lvl = 4000,
 };
 
 static const struct ab8500_bm_capacity_levels cap_levels = {
@@ -192,6 +190,13 @@ int ab8500_bm_of_probe(struct power_supply *psy,
 		bi->maintenance_charge_size = ARRAY_SIZE(maint_charge_table);
 	}
 
+	if (bi->alert_temp_charge_current_ua < 0 ||
+	    bi->alert_temp_charge_voltage_uv < 0)
+	{
+		bi->alert_temp_charge_current_ua = 300000;
+		bi->alert_temp_charge_voltage_uv = 4000000;
+	}
+
 	/*
 	 * Internal resistance and factory resistance are tightly coupled
 	 * so both MUST be defined or we fall back to defaults.
diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index 6054996b6260..01fd2ef6e6b5 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -1511,8 +1511,8 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 
 	case STATE_TEMP_LOWHIGH_INIT:
 		ab8500_chargalg_start_charging(di,
-			di->bm->bat_type->low_high_vol_lvl,
-			di->bm->bat_type->low_high_cur_lvl);
+			bi->alert_temp_charge_voltage_uv,
+			bi->alert_temp_charge_current_ua);
 		ab8500_chargalg_stop_maintenance_timer(di);
 		di->charge_status = POWER_SUPPLY_STATUS_CHARGING;
 		ab8500_chargalg_state_to(di, STATE_TEMP_LOWHIGH);
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 6568939e4518..01f9898ab548 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -591,6 +591,8 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	info->charge_restart_voltage_uv      = -EINVAL;
 	info->overvoltage_limit_uv           = -EINVAL;
 	info->maintenance_charge             = NULL;
+	info->alert_temp_charge_current_ua   = -EINVAL;
+	info->alert_temp_charge_voltage_uv   = -EINVAL;
 	info->temp_ambient_alert_min         = INT_MIN;
 	info->temp_ambient_alert_max         = INT_MAX;
 	info->temp_alert_min                 = INT_MIN;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index b998fc4c87ae..5a059c013c12 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -443,6 +443,14 @@ struct power_supply_maintenance_charge_table {
  *   after the main CC/CV charging phase is complete.
  * @maintenance_charge_size: the number of maintenance charging settings in
  *   maintenance_charge.
+ * @alert_temp_charge_current_ua: The charging current to use if the battery
+ *   enters alert temperatures. I.e. if the internal temperature is between
+ *   temp_alert_min and temp_min or temp_alert_max and temp_max. No matter
+ *   the charging phase, this and alert_temp_charge_voltage_uv will be
+ *   applied under alert temperature conditions, usually lowering the charging
+ *   current as an evasive manouver.
+ * @alert_temp_charge_voltage_uv: Same as alert_temp_charge_current_ua, but
+ *   for the charging voltage.
  * @factory_internal_resistance_uohm: the internal resistance of the battery
  *   at fabrication time, expressed in microohms. This resistance will vary
  *   depending on the lifetime and charge of the battery, so this is just a
@@ -594,6 +602,8 @@ struct power_supply_battery_info {
 	int constant_charge_voltage_max_uv;
 	struct power_supply_maintenance_charge_table *maintenance_charge;
 	int maintenance_charge_size;
+	int alert_temp_charge_current_ua;
+	int alert_temp_charge_voltage_uv;
 	int factory_internal_resistance_uohm;
 	int ocv_temp[POWER_SUPPLY_OCV_TEMP_MAX];
 	int temp_ambient_alert_min;
-- 
2.34.1

