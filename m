Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14254C5217
	for <lists+linux-pm@lfdr.de>; Sat, 26 Feb 2022 00:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiBYXbL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Feb 2022 18:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239336AbiBYXbH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Feb 2022 18:31:07 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6909019F46C
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 15:30:33 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id u11so9427676lju.4
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 15:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uRYL5qnIiMzP7BZ/K3ui2HkKddDsnn1d6EQhsmYHaiA=;
        b=WqadAUSSFuXFp8kCenPmSduX0AywHe5n6eyxXO0QgACaWP/Fg82H2QMcHVBfoTGAxY
         MoZxUZq9X5z2mbVeatZpTutI+snle4qfQgA2YqxJ2LLXchR/DypgU6A1TIblz68FS83k
         X7erPESZR8wO0J6cfIGnOvpvVEOpFBE0PdMl3ZTWxc+6vtxsT0IxAxygmYzDN4rJm+6a
         /SpT9oWKYXbNxrV83no1uGKUl0HNa9hpFW2J2BWSLZ0IehWvvxY9uzUqAp+Iic2rjf6n
         ZP28L8BxmHqBbJOnYYMumx4MhbfUnVH9iAdpIXszGU1N9HHdqXajiduNqi2vsLVwBK8r
         8zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uRYL5qnIiMzP7BZ/K3ui2HkKddDsnn1d6EQhsmYHaiA=;
        b=OauuI5PUrWOmWBAIT0RSjFpuQ8oB6lOPHTIiqLKzWvB+LUGlWtHjDWTaeQdd0uYNks
         Xwd1v9sStSfUv/3IJWeG9bT4O6eE/0wGc8y7arrhLpSnsz3z+ZM/t60uRNiutnBl1hpq
         DJzz4Y9G2BeodSizQBMVuwWIkjPwmOXRXoD19mhSylAaixiK9SIX94wMIixJ6rCSVsFo
         hQ8+CsaP0T8wuzMuQp8e3RGgUxFQjsN8INTAQ/oIJTlr3RROv2JKzJ/7FOr0rbXTGYEi
         XUJPwbcglaS2ee9g7cpD/HPSoiyouGthme0DeNgHkpiJd1VJAytMpa/SNM7jNjLldcSY
         EZSQ==
X-Gm-Message-State: AOAM531rZdrGhmqjyhbGvIdAxFwgupgoaxylhAIhNt1EcyKF6jGs5UMW
        PAFgygpVU73QAORW78qgXW6Ud45D2NU8Z4ha
X-Google-Smtp-Source: ABdhPJwXXi/HxRzu/2Dsd4ctVn88xqPfnM8Pd3ZWTKz4uIaAcZIrh3VgRa9Xj67C2nungJdAJTU0Gw==
X-Received: by 2002:a2e:a36c:0:b0:246:4680:e55a with SMTP id i12-20020a2ea36c000000b002464680e55amr6811653ljn.451.1645831831688;
        Fri, 25 Feb 2022 15:30:31 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id u9-20020ac251c9000000b00443dc755dfdsm313524lfm.215.2022.02.25.15.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 15:30:31 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/6 v4] power: supply: Support VBAT-to-Ri lookup tables
Date:   Sat, 26 Feb 2022 00:27:58 +0100
Message-Id: <20220225232800.2021909-5-linus.walleij@linaro.org>
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

In Samsung devices, the method used to compensate for temperature,
age, load etc is by way of VBAT to Ri tables, which correlates the
battery voltage under load (VBAT) to an internal resistance (Ri).

Using this Ri and a measurement of the current out of the battery
(IBAT) the open circuit voltage (OCV) can be calculated as:

  OCV = VBAT - (Ri * IBAT)

The details are described in comments to struct
power_supply_battery_info in the commit.

Since not all batteries supply this VBAT-to-Ri data, the fallback
method to use the temperature-to-Ri lookup table can also be used
as a fallback.

Add two helper functions to check if we have the tables needed for
using power_supply_vbat2ri() or power_supply_temp2resist_simple()
respectively, so capacity estimation code can choose which one
to employ.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Rebase on Sebastians linux-power-supply tree.
ChangeLog v2->v3:
- No changes
ChangeLog v1->v2:
- No changes
---
 drivers/power/supply/power_supply_core.c |  67 +++++++++++++-
 include/linux/power_supply.h             | 113 ++++++++++++++++++++++-
 2 files changed, 177 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 3d5047d3fe99..fb0b3870566e 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -814,7 +814,7 @@ EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
 
 /**
  * power_supply_temp2resist_simple() - find the battery internal resistance
- * percent
+ * percent from temperature
  * @table: Pointer to battery resistance temperature table
  * @table_len: The table length
  * @temp: Current temperature
@@ -851,6 +851,71 @@ int power_supply_temp2resist_simple(struct power_supply_resistance_temp_table *t
 }
 EXPORT_SYMBOL_GPL(power_supply_temp2resist_simple);
 
+/**
+ * power_supply_vbat2ri() - find the battery internal resistance
+ * from the battery voltage
+ * @info: The battery information container
+ * @table: Pointer to battery resistance temperature table
+ * @vbat_uv: The battery voltage in microvolt
+ * @charging: If we are charging (true) or not (false)
+ *
+ * This helper function is used to look up battery internal resistance
+ * according to current battery voltage. Depending on whether the battery
+ * is currently charging or not, different resistance will be returned.
+ *
+ * Returns the internal resistance in microohm or negative error code.
+ */
+int power_supply_vbat2ri(struct power_supply_battery_info *info,
+			 int vbat_uv, bool charging)
+{
+	struct power_supply_vbat_ri_table *vbat2ri;
+	int table_len;
+	int i, high, low;
+
+	/*
+	 * If we are charging, and the battery supplies a separate table
+	 * for this state, we use that in order to compensate for the
+	 * charging voltage. Otherwise we use the main table.
+	 */
+	if (charging && info->vbat2ri_charging) {
+		vbat2ri = info->vbat2ri_charging;
+		table_len = info->vbat2ri_charging_size;
+	} else {
+		vbat2ri = info->vbat2ri_discharging;
+		table_len = info->vbat2ri_discharging_size;
+	}
+
+	/*
+	 * If no tables are specified, or if we are above the highest voltage in
+	 * the voltage table, just return the factory specified internal resistance.
+	 */
+	if (!vbat2ri || (table_len <= 0) || (vbat_uv > vbat2ri[0].vbat_uv)) {
+		if (charging && (info->factory_internal_resistance_charging_uohm > 0))
+			return info->factory_internal_resistance_charging_uohm;
+		else
+			return info->factory_internal_resistance_uohm;
+	}
+
+	/* Break loop at table_len - 1 because that is the highest index */
+	for (i = 0; i < table_len - 1; i++)
+		if (vbat_uv > vbat2ri[i].vbat_uv)
+			break;
+
+	/* The library function will deal with high == low */
+	if ((i == 0) || (i == (table_len - 1)))
+		high = i;
+	else
+		high = i - 1;
+	low = i;
+
+	return fixp_linear_interpolate(vbat2ri[low].vbat_uv,
+				       vbat2ri[low].ri_uohm,
+				       vbat2ri[high].vbat_uv,
+				       vbat2ri[high].ri_uohm,
+				       vbat_uv);
+}
+EXPORT_SYMBOL_GPL(power_supply_vbat2ri);
+
 struct power_supply_maintenance_charge_table *
 power_supply_get_maintenance_charging_setting(struct power_supply_battery_info *info,
 					      int index)
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 7fdc03cf2285..cb380c1d9459 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -349,6 +349,11 @@ struct power_supply_resistance_temp_table {
 	int resistance;	/* internal resistance percent */
 };
 
+struct power_supply_vbat_ri_table {
+	int vbat_uv;	/* Battery voltage in microvolt */
+	int ri_uohm;	/* Internal resistance in microohm */
+};
+
 /**
  * struct power_supply_maintenance_charge_table - setting for maintenace charging
  * @charge_current_max_ua: maintenance charging current that is used to keep
@@ -460,7 +465,14 @@ struct power_supply_maintenance_charge_table {
  * @factory_internal_resistance_uohm: the internal resistance of the battery
  *   at fabrication time, expressed in microohms. This resistance will vary
  *   depending on the lifetime and charge of the battery, so this is just a
- *   nominal ballpark figure.
+ *   nominal ballpark figure. This internal resistance is given for the state
+ *   when the battery is discharging.
+ * @factory_internal_resistance_charging_uohm: the internal resistance of the
+ *   battery at fabrication time while charging, expressed in microohms.
+ *   The charging process will affect the internal resistance of the battery
+ *   so this value provides a better resistance under these circumstances.
+ *   This resistance will vary depending on the lifetime and charge of the
+ *   battery, so this is just a nominal ballpark figure.
  * @ocv_temp: array indicating the open circuit voltage (OCV) capacity
  *   temperature indices. This is an array of temperatures in degrees Celsius
  *   indicating which capacity table to use for a certain temperature, since
@@ -498,6 +510,21 @@ struct power_supply_maintenance_charge_table {
  *   by temperature: highest temperature with lowest resistance first, lowest
  *   temperature with highest resistance last.
  * @resist_table_size: the number of items in the resist_table.
+ * @vbat2ri_discharging: this is a table that correlates Battery voltage (VBAT)
+ *   to internal resistance (Ri). The resistance is given in microohm for the
+ *   corresponding voltage in microvolts. The internal resistance is used to
+ *   determine the open circuit voltage so that we can determine the capacity
+ *   of the battery. These voltages to resistance tables apply when the battery
+ *   is discharging. The table must be ordered descending by voltage: highest
+ *   voltage first.
+ * @vbat2ri_discharging_size: the number of items in the vbat2ri_discharging
+ *   table.
+ * @vbat2ri_charging: same function as vbat2ri_discharging but for the state
+ *   when the battery is charging. Being under charge changes the battery's
+ *   internal resistance characteristics so a separate table is needed.*
+ *   The table must be ordered descending by voltage: highest voltage first.
+ * @vbat2ri_charging_size: the number of items in the vbat2ri_charging
+ *   table.
  * @bti_resistance_ohm: The Battery Type Indicator (BIT) nominal resistance
  *   in ohms for this battery, if an identification resistor is mounted
  *   between a third battery terminal and ground. This scheme is used by a lot
@@ -512,7 +539,9 @@ struct power_supply_maintenance_charge_table {
  * use these for consistency.
  *
  * Its field names must correspond to elements in enum power_supply_property.
- * The default field value is -EINVAL.
+ * The default field value is -EINVAL or NULL for pointers.
+ *
+ * CC/CV CHARGING:
  *
  * The charging parameters here assume a CC/CV charging scheme. This method
  * is most common with Lithium Ion batteries (other methods are possible) and
@@ -597,6 +626,66 @@ struct power_supply_maintenance_charge_table {
  * Overcharging Lithium Ion cells can be DANGEROUS and lead to fire or
  * explosions.
  *
+ * DETERMINING BATTERY CAPACITY:
+ *
+ * Several members of the struct deal with trying to determine the remaining
+ * capacity in the battery, usually as a percentage of charge. In practice
+ * many chargers uses a so-called fuel gauge or coloumb counter that measure
+ * how much charge goes into the battery and how much goes out (+/- leak
+ * consumption). This does not help if we do not know how much capacity the
+ * battery has to begin with, such as when it is first used or was taken out
+ * and charged in a separate charger. Therefore many capacity algorithms use
+ * the open circuit voltage with a look-up table to determine the rough
+ * capacity of the battery. The open circuit voltage can be conceptualized
+ * with an ideal voltage source (V) in series with an internal resistance (Ri)
+ * like this:
+ *
+ *      +-------> IBAT >----------------+
+ *      |                    ^          |
+ *     [ ] Ri                |          |
+ *      |                    | VBAT     |
+ *      o <----------        |          |
+ *     +|           ^        |         [ ] Rload
+ *    .---.         |        |          |
+ *    | V |         | OCV    |          |
+ *    '---'         |        |          |
+ *      |           |        |          |
+ *  GND +-------------------------------+
+ *
+ * If we disconnect the load (here simplified as a fixed resistance Rload)
+ * and measure VBAT with a infinite impedance voltage meter we will get
+ * VBAT = OCV and this assumption is sometimes made even under load, assuming
+ * Rload is insignificant. However this will be of dubious quality because the
+ * load is rarely that small and Ri is strongly nonlinear depending on
+ * temperature and how much capacity is left in the battery due to the
+ * chemistry involved.
+ *
+ * In many practical applications we cannot just disconnect the battery from
+ * the load, so instead we often try to measure the instantaneous IBAT (the
+ * current out from the battery), estimate the Ri and thus calculate the
+ * voltage drop over Ri and compensate like this:
+ *
+ *   OCV = VBAT - (IBAT * Ri)
+ *
+ * The tables vbat2ri_discharging and vbat2ri_charging are used to determine
+ * (by interpolation) the Ri from the VBAT under load. These curves are highly
+ * nonlinear and may need many datapoints but can be found in datasheets for
+ * some batteries. This gives the compensated open circuit voltage (OCV) for
+ * the battery even under load. Using this method will also compensate for
+ * temperature changes in the environment: this will also make the internal
+ * resistance change, and it will affect the VBAT under load, so correlating
+ * VBAT to Ri takes both remaining capacity and temperature into consideration.
+ *
+ * Alternatively a manufacturer can specify how the capacity of the battery
+ * is dependent on the battery temperature which is the main factor affecting
+ * Ri. As we know all checmical reactions are faster when it is warm and slower
+ * when it is cold. You can put in 1500mAh and only get 800mAh out before the
+ * voltage drops too low for example. This effect is also highly nonlinear and
+ * the purpose of the table resist_table: this will take a temperature and
+ * tell us how big percentage of Ri the specified temperature correlates to.
+ * Usually we have 100% of the factory_internal_resistance_uohm at 25 degrees
+ * Celsius.
+ *
  * The power supply class itself doesn't use this struct as of now.
  */
 
@@ -621,6 +710,7 @@ struct power_supply_battery_info {
 	int alert_high_temp_charge_current_ua;
 	int alert_high_temp_charge_voltage_uv;
 	int factory_internal_resistance_uohm;
+	int factory_internal_resistance_charging_uohm;
 	int ocv_temp[POWER_SUPPLY_OCV_TEMP_MAX];
 	int temp_ambient_alert_min;
 	int temp_ambient_alert_max;
@@ -632,6 +722,10 @@ struct power_supply_battery_info {
 	int ocv_table_size[POWER_SUPPLY_OCV_TEMP_MAX];
 	struct power_supply_resistance_temp_table *resist_table;
 	int resist_table_size;
+	struct power_supply_vbat_ri_table *vbat2ri_discharging;
+	int vbat2ri_discharging_size;
+	struct power_supply_vbat_ri_table *vbat2ri_charging;
+	int vbat2ri_charging_size;
 	int bti_resistance_ohm;
 	int bti_resistance_tolerance;
 };
@@ -675,6 +769,8 @@ extern int power_supply_batinfo_ocv2cap(struct power_supply_battery_info *info,
 extern int
 power_supply_temp2resist_simple(struct power_supply_resistance_temp_table *table,
 				int table_len, int temp);
+extern int power_supply_vbat2ri(struct power_supply_battery_info *info,
+				int vbat_uv, bool charging);
 extern struct power_supply_maintenance_charge_table *
 power_supply_get_maintenance_charging_setting(struct power_supply_battery_info *info, int index);
 extern bool power_supply_battery_bti_in_range(struct power_supply_battery_info *info,
@@ -696,6 +792,19 @@ power_supply_supports_maintenance_charging(struct power_supply_battery_info *inf
 	return (mt != NULL);
 }
 
+static inline bool
+power_supply_supports_vbat2ri(struct power_supply_battery_info *info)
+{
+	return ((info->vbat2ri_discharging != NULL) &&
+		info->vbat2ri_discharging_size > 0);
+}
+
+static inline bool
+power_supply_supports_temp2ri(struct power_supply_battery_info *info)
+{
+	return ((info->resist_table != NULL) &&
+		info->resist_table_size > 0);
+}
 
 #ifdef CONFIG_POWER_SUPPLY
 extern int power_supply_is_system_supplied(void);
-- 
2.34.1

