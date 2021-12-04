Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF4F46842D
	for <lists+linux-pm@lfdr.de>; Sat,  4 Dec 2021 11:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344249AbhLDKt0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Dec 2021 05:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240516AbhLDKt0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Dec 2021 05:49:26 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9875C061751
        for <linux-pm@vger.kernel.org>; Sat,  4 Dec 2021 02:46:00 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id n12so12834068lfe.1
        for <linux-pm@vger.kernel.org>; Sat, 04 Dec 2021 02:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Sr55T3HpZONHX9rpPyK1jOY5rCKaAiVA4FngUN+gR8=;
        b=bpUX8GSx3uVR+bzK51GUzbg947eNZYm/iKxVgZaJ7KxYQMLOgPkEwoqtFhxZZ+jhLA
         aLq7ZjHjHeVTkYxXwGmDA4dvxZybM3UbnmMdmoUKY/XXF6p8YFvy2tVG2DQZcipoYaF/
         DBLL4gmUnZ7O6q5y5ZSMsc3lNZ4G2YiAlwtiWHp/XBZwo7R9qijiCvKSXj47YNSuus8t
         ApZa9Lg/gPBjAKfbD0R8tDmUH146+xC0ilrsIfRNByAw+Yq4ySG7U7E9TNRWKC1osYaD
         f3jJK6mm0oNoYl7O+OuJdHdpgnoyBDJL9+9wj/9gWJooGpQwmC05NsTGwVQ/tAKYuvuO
         HVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Sr55T3HpZONHX9rpPyK1jOY5rCKaAiVA4FngUN+gR8=;
        b=QE7VBmRF2ZpdgEPXlkCzNTLceaDKu17EZPgLbFIc/wXO6pDoGjY7bz0ykAQBi4o8gi
         0Cg2q8rNrAf2MjC3Xz9JAXpUyBzX69ClHJEOxBGFYdULU3ElQ70oCQ3l3Br8tHiT0yOu
         DDLK+338QUtRoLFQYPW6wNKKYkJ5c/IvqBkTk62FFMMOh7pCoYCiOkEvmxHYxK7WCdli
         GUX48Bo3M1oFWLw7JhSseVWpCg4coqX3EJJQFNj/RtpuaBYB/49C5RXTlLfP7GT20ER/
         XR0m+6ZDPgmgpmdKTn6qTy9re+ROsO6235zMPxsdhVGkT8CbJpFBVN1hmL2r3w8CPArZ
         B0oQ==
X-Gm-Message-State: AOAM533M9m5ix/nvMmQRDOqVzcLz3j/b2xitL65TCKwT7fjSXezmFmlZ
        bLBk/I3OHuflDD27ilcpYVttDA==
X-Google-Smtp-Source: ABdhPJybqG7ggfF9uX5aBxtQ3EYdg7MACVXuxPX9B0JzEnAS0H4ofs4h4kaXw0AWerdWrUnly6nqjg==
X-Received: by 2002:a05:6512:2033:: with SMTP id s19mr23464865lfs.290.1638614758731;
        Sat, 04 Dec 2021 02:45:58 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id l22sm719469lfc.307.2021.12.04.02.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 02:45:57 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] power: supply_core: Pass pointer to battery info
Date:   Sat,  4 Dec 2021 11:43:54 +0100
Message-Id: <20211204104354.4077269-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The function to retrieve battery info (from the device tree) assumes
we have a static info struct that gets populated by calling into
power_supply_get_battery_info().

This is awkward since I want to support tables of static battery
info by just assigning a pointer to all info based on e.g. a
compatible value in the device tree.

We also have a mixture of static and dynamically allocated
variables here.

Bite the bullet and let power_supply_get_battery_info() allocate
also the memory used for the very top level
struct power_supply_battery_info container. Pass pointers
around and lifecycle this with the psy device just like the
stuff we allocate inside it.

Change all current users over.

In the bd99954 charger driver we need to stop issuing
power_supply_put_battery_info() at the end of the probe since
the struct continues to be used after probe().

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500-bm.h         |  2 +-
 drivers/power/supply/ab8500_bmdata.c     |  7 +++--
 drivers/power/supply/ab8500_btemp.c      | 10 +++++--
 drivers/power/supply/ab8500_chargalg.c   | 16 +++++------
 drivers/power/supply/ab8500_fg.c         | 18 ++++++------
 drivers/power/supply/axp20x_battery.c    |  6 ++--
 drivers/power/supply/bd99954-charger.c   | 24 ++++++++--------
 drivers/power/supply/bq24190_charger.c   |  6 ++--
 drivers/power/supply/bq2515x_charger.c   |  8 +++---
 drivers/power/supply/bq256xx_charger.c   | 24 ++++++++--------
 drivers/power/supply/bq25980_charger.c   |  6 ++--
 drivers/power/supply/bq27xxx_battery.c   | 36 ++++++++++++------------
 drivers/power/supply/cw2015_battery.c    | 19 ++++++++-----
 drivers/power/supply/ingenic-battery.c   | 14 ++++-----
 drivers/power/supply/power_supply_core.c | 15 ++++++++--
 drivers/power/supply/sc2731_charger.c    |  8 +++---
 drivers/power/supply/sc27xx_fuel_gauge.c | 22 +++++++--------
 drivers/power/supply/smb347-charger.c    | 34 +++++++++++-----------
 include/linux/power_supply.h             |  2 +-
 19 files changed, 150 insertions(+), 127 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index 57e1a8e27e51..56a5aaf9a27a 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -439,7 +439,7 @@ struct ab8500_bm_charger_parameters {
  * @fg_params		fuel gauge parameters
  */
 struct ab8500_bm_data {
-	struct power_supply_battery_info bi;
+	struct power_supply_battery_info *bi;
 	int temp_now;
 	int temp_interval_chg;
 	int temp_interval_nochg;
diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index 62953f9cb85a..7ae95f537580 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -167,15 +167,16 @@ struct ab8500_bm_data ab8500_bm_data = {
 int ab8500_bm_of_probe(struct power_supply *psy,
 		       struct ab8500_bm_data *bm)
 {
-	struct power_supply_battery_info *bi = &bm->bi;
+	struct power_supply_battery_info *bi;
 	struct device *dev = &psy->dev;
 	int ret;
 
-	ret = power_supply_get_battery_info(psy, bi);
+	ret = power_supply_get_battery_info(psy, &bm->bi);
 	if (ret) {
 		dev_err(dev, "cannot retrieve battery info\n");
 		return ret;
 	}
+	bi = bm->bi;
 
 	/* Fill in defaults for any data missing from the device tree */
 	if (bi->charge_full_design_uah < 0)
@@ -240,5 +241,5 @@ int ab8500_bm_of_probe(struct power_supply *psy,
 void ab8500_bm_of_remove(struct power_supply *psy,
 			 struct ab8500_bm_data *bm)
 {
-	power_supply_put_battery_info(psy, &bm->bi);
+	power_supply_put_battery_info(psy, bm->bi);
 }
diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 20253b8a7fe9..cc33c5187fbb 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -451,12 +451,13 @@ static int ab8500_btemp_res_to_temp(struct ab8500_btemp *di,
  */
 static int ab8500_btemp_measure_temp(struct ab8500_btemp *di)
 {
+	struct power_supply_battery_info *bi = di->bm->bi;
 	int temp, ret;
 	static int prev;
 	int rbat, rntc, vntc;
 
 	if ((di->bm->adc_therm == AB8500_ADC_THERM_BATCTRL) &&
-	    (di->bm->bi.technology == POWER_SUPPLY_TECHNOLOGY_UNKNOWN)) {
+	    (bi && (bi->technology == POWER_SUPPLY_TECHNOLOGY_UNKNOWN))) {
 
 		rbat = ab8500_btemp_get_batctrl_res(di);
 		if (rbat < 0) {
@@ -540,7 +541,7 @@ static int ab8500_btemp_id(struct ab8500_btemp *di)
 	 * that need it.
 	 */
 	if ((di->bm->adc_therm == AB8500_ADC_THERM_BATCTRL) &&
-	    (di->bm->bi.technology == POWER_SUPPLY_TECHNOLOGY_LIPO) &&
+	    (di->bm->bi && (di->bm->bi->technology == POWER_SUPPLY_TECHNOLOGY_LIPO)) &&
 	    (res <= 53407) && (res >= 12500)) {
 		dev_dbg(di->dev, "Set BATCTRL current source to 20uA\n");
 		di->curr_source = BTEMP_BATCTRL_CURR_SRC_20UA;
@@ -807,7 +808,10 @@ static int ab8500_btemp_get_property(struct power_supply *psy,
 			val->intval = 1;
 		break;
 	case POWER_SUPPLY_PROP_TECHNOLOGY:
-		val->intval = di->bm->bi.technology;
+		if (di->bm->bi)
+			val->intval = di->bm->bi->technology;
+		else
+			val->intval = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
 		val->intval = ab8500_btemp_get_temp(di);
diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index 86d740ce3a63..c4a2fe07126c 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -352,7 +352,7 @@ static void ab8500_chargalg_state_to(struct ab8500_chargalg *di,
 
 static int ab8500_chargalg_check_charger_enable(struct ab8500_chargalg *di)
 {
-	struct power_supply_battery_info *bi = &di->bm->bi;
+	struct power_supply_battery_info *bi = di->bm->bi;
 
 	switch (di->charge_state) {
 	case STATE_NORMAL:
@@ -731,7 +731,7 @@ static void ab8500_chargalg_start_charging(struct ab8500_chargalg *di,
  */
 static void ab8500_chargalg_check_temp(struct ab8500_chargalg *di)
 {
-	struct power_supply_battery_info *bi = &di->bm->bi;
+	struct power_supply_battery_info *bi = di->bm->bi;
 
 	if (di->batt_data.temp > (bi->temp_alert_min + di->t_hyst_norm) &&
 		di->batt_data.temp < (bi->temp_alert_max - di->t_hyst_norm)) {
@@ -802,10 +802,10 @@ static void ab8500_chargalg_end_of_charge(struct ab8500_chargalg *di)
 	if (di->charge_status == POWER_SUPPLY_STATUS_CHARGING &&
 		di->charge_state == STATE_NORMAL &&
 		!di->maintenance_chg && (di->batt_data.volt_uv >=
-		di->bm->bi.overvoltage_limit_uv ||
+		di->bm->bi->overvoltage_limit_uv ||
 		di->events.usb_cv_active || di->events.ac_cv_active) &&
 		di->batt_data.avg_curr_ua <
-		di->bm->bi.charge_term_current_ua &&
+		di->bm->bi->charge_term_current_ua &&
 		di->batt_data.avg_curr_ua > 0) {
 		if (++di->eoc_cnt >= EOC_COND_CNT) {
 			di->eoc_cnt = 0;
@@ -827,7 +827,7 @@ static void ab8500_chargalg_end_of_charge(struct ab8500_chargalg *di)
 
 static void init_maxim_chg_curr(struct ab8500_chargalg *di)
 {
-	struct power_supply_battery_info *bi = &di->bm->bi;
+	struct power_supply_battery_info *bi = di->bm->bi;
 
 	di->ccm.original_iset_ua = bi->constant_charge_current_max_ua;
 	di->ccm.current_iset_ua = bi->constant_charge_current_max_ua;
@@ -920,7 +920,7 @@ static enum maxim_ret ab8500_chargalg_chg_curr_maxim(struct ab8500_chargalg *di)
 
 static void handle_maxim_chg_curr(struct ab8500_chargalg *di)
 {
-	struct power_supply_battery_info *bi = &di->bm->bi;
+	struct power_supply_battery_info *bi = di->bm->bi;
 	enum maxim_ret ret;
 	int result;
 
@@ -1299,7 +1299,7 @@ static void ab8500_chargalg_external_power_changed(struct power_supply *psy)
  */
 static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 {
-	struct power_supply_battery_info *bi = &di->bm->bi;
+	struct power_supply_battery_info *bi = di->bm->bi;
 	int charger_status;
 	int ret;
 	int curr_step_lvl_ua;
@@ -1723,7 +1723,7 @@ static int ab8500_chargalg_get_property(struct power_supply *psy,
 		if (di->events.batt_ovv) {
 			val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
 		} else if (di->events.btemp_underover) {
-			if (di->batt_data.temp <= di->bm->bi.temp_min)
+			if (di->batt_data.temp <= di->bm->bi->temp_min)
 				val->intval = POWER_SUPPLY_HEALTH_COLD;
 			else
 				val->intval = POWER_SUPPLY_HEALTH_OVERHEAT;
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index eb3e5c4ca44f..b0919a6a6587 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -852,7 +852,7 @@ static int ab8500_fg_bat_voltage(struct ab8500_fg *di)
  */
 static int ab8500_fg_volt_to_capacity(struct ab8500_fg *di, int voltage_uv)
 {
-	struct power_supply_battery_info *bi = &di->bm->bi;
+	struct power_supply_battery_info *bi = di->bm->bi;
 
 	/* Multiply by 10 because the capacity is tracked in per mille */
 	return power_supply_batinfo_ocv2cap(bi, voltage_uv, di->bat_temp) *  10;
@@ -881,7 +881,7 @@ static int ab8500_fg_uncomp_volt_to_capacity(struct ab8500_fg *di)
  */
 static int ab8500_fg_battery_resistance(struct ab8500_fg *di)
 {
-	struct power_supply_battery_info *bi = &di->bm->bi;
+	struct power_supply_battery_info *bi = di->bm->bi;
 	int resistance_percent = 0;
 	int resistance;
 
@@ -2140,11 +2140,13 @@ static int ab8500_fg_get_ext_psy_data(struct device *dev, void *data)
 	struct power_supply *ext = dev_get_drvdata(dev);
 	const char **supplicants = (const char **)ext->supplied_to;
 	struct ab8500_fg *di;
+	struct power_supply_battery_info *bi;
 	union power_supply_propval ret;
 	int j;
 
 	psy = (struct power_supply *)data;
 	di = power_supply_get_drvdata(psy);
+	bi = di->bm->bi;
 
 	/*
 	 * For all psy where the name of your driver
@@ -2207,8 +2209,8 @@ static int ab8500_fg_get_ext_psy_data(struct device *dev, void *data)
 			switch (ext->desc->type) {
 			case POWER_SUPPLY_TYPE_BATTERY:
 				if (!di->flags.batt_id_received &&
-				    (di->bm->bi.technology !=
-				     POWER_SUPPLY_TECHNOLOGY_UNKNOWN)) {
+				    (bi && (bi->technology !=
+					    POWER_SUPPLY_TECHNOLOGY_UNKNOWN))) {
 					const struct ab8500_battery_type *b;
 
 					b = di->bm->bat_type;
@@ -2216,13 +2218,13 @@ static int ab8500_fg_get_ext_psy_data(struct device *dev, void *data)
 					di->flags.batt_id_received = true;
 
 					di->bat_cap.max_mah_design =
-						di->bm->bi.charge_full_design_uah;
+						di->bm->bi->charge_full_design_uah;
 
 					di->bat_cap.max_mah =
 						di->bat_cap.max_mah_design;
 
 					di->vbat_nom_uv =
-						di->bm->bi.voltage_max_design_uv;
+						di->bm->bi->voltage_max_design_uv;
 				}
 
 				if (ret.intval)
@@ -2992,9 +2994,9 @@ static int ab8500_fg_bind(struct device *dev, struct device *master,
 		return -ENOMEM;
 	}
 
-	di->bat_cap.max_mah_design = di->bm->bi.charge_full_design_uah;
+	di->bat_cap.max_mah_design = di->bm->bi->charge_full_design_uah;
 	di->bat_cap.max_mah = di->bat_cap.max_mah_design;
-	di->vbat_nom_uv = di->bm->bi.voltage_max_design_uv;
+	di->vbat_nom_uv = di->bm->bi->voltage_max_design_uv;
 
 	/* Start the coulomb counter */
 	ab8500_fg_coulomb_counter(di, true);
diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 18a9db0df4b1..5d197141f476 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -561,7 +561,7 @@ static int axp20x_power_probe(struct platform_device *pdev)
 {
 	struct axp20x_batt_ps *axp20x_batt;
 	struct power_supply_config psy_cfg = {};
-	struct power_supply_battery_info info;
+	struct power_supply_battery_info *info;
 	struct device *dev = &pdev->dev;
 
 	if (!of_device_is_available(pdev->dev.of_node))
@@ -615,8 +615,8 @@ static int axp20x_power_probe(struct platform_device *pdev)
 	}
 
 	if (!power_supply_get_battery_info(axp20x_batt->batt, &info)) {
-		int vmin = info.voltage_min_design_uv;
-		int ccc = info.constant_charge_current_max_ua;
+		int vmin = info->voltage_min_design_uv;
+		int ccc = info->constant_charge_current_max_ua;
 
 		if (vmin > 0 && axp20x_set_voltage_min_design(axp20x_batt,
 							      vmin))
diff --git a/drivers/power/supply/bd99954-charger.c b/drivers/power/supply/bd99954-charger.c
index ffd8bfa08179..c22d0c804fd6 100644
--- a/drivers/power/supply/bd99954-charger.c
+++ b/drivers/power/supply/bd99954-charger.c
@@ -882,7 +882,7 @@ struct dt_init {
 static int bd9995x_fw_probe(struct bd9995x_device *bd)
 {
 	int ret;
-	struct power_supply_battery_info info;
+	struct power_supply_battery_info *info;
 	u32 property;
 	int i;
 	int regval;
@@ -891,49 +891,41 @@ static int bd9995x_fw_probe(struct bd9995x_device *bd)
 	struct battery_init battery_inits[] = {
 		{
 			.name = "trickle-charging current",
-			.info_data = &info.tricklecharge_current_ua,
 			.range = &charging_current_ranges[0],
 			.ranges = 2,
 			.data = &init->itrich_set,
 		}, {
 			.name = "pre-charging current",
-			.info_data = &info.precharge_current_ua,
 			.range = &charging_current_ranges[0],
 			.ranges = 2,
 			.data = &init->iprech_set,
 		}, {
 			.name = "pre-to-trickle charge voltage threshold",
-			.info_data = &info.precharge_voltage_max_uv,
 			.range = &trickle_to_pre_threshold_ranges[0],
 			.ranges = 2,
 			.data = &init->vprechg_th_set,
 		}, {
 			.name = "charging termination current",
-			.info_data = &info.charge_term_current_ua,
 			.range = &charging_current_ranges[0],
 			.ranges = 2,
 			.data = &init->iterm_set,
 		}, {
 			.name = "charging re-start voltage",
-			.info_data = &info.charge_restart_voltage_uv,
 			.range = &charge_voltage_regulation_ranges[0],
 			.ranges = 2,
 			.data = &init->vrechg_set,
 		}, {
 			.name = "battery overvoltage limit",
-			.info_data = &info.overvoltage_limit_uv,
 			.range = &charge_voltage_regulation_ranges[0],
 			.ranges = 2,
 			.data = &init->vbatovp_set,
 		}, {
 			.name = "fast-charging max current",
-			.info_data = &info.constant_charge_current_max_ua,
 			.range = &fast_charge_current_ranges[0],
 			.ranges = 1,
 			.data = &init->ichg_set,
 		}, {
 			.name = "fast-charging voltage",
-			.info_data = &info.constant_charge_voltage_max_uv,
 			.range = &charge_voltage_regulation_ranges[0],
 			.ranges = 2,
 			.data = &init->vfastchg_reg_set1,
@@ -966,6 +958,16 @@ static int bd9995x_fw_probe(struct bd9995x_device *bd)
 	if (ret < 0)
 		return ret;
 
+	/* Put pointers to the generic battery info */
+	battery_inits[0].info_data = &info->tricklecharge_current_ua;
+	battery_inits[1].info_data = &info->precharge_current_ua;
+	battery_inits[2].info_data = &info->precharge_voltage_max_uv;
+	battery_inits[3].info_data = &info->charge_term_current_ua;
+	battery_inits[4].info_data = &info->charge_restart_voltage_uv;
+	battery_inits[5].info_data = &info->overvoltage_limit_uv;
+	battery_inits[6].info_data = &info->constant_charge_current_max_ua;
+	battery_inits[7].info_data = &info->constant_charge_voltage_max_uv;
+
 	for (i = 0; i < ARRAY_SIZE(battery_inits); i++) {
 		int val = *battery_inits[i].info_data;
 		const struct linear_range *range = battery_inits[i].range;
@@ -980,7 +982,7 @@ static int bd9995x_fw_probe(struct bd9995x_device *bd)
 			dev_err(bd->dev, "Unsupported value for %s\n",
 				battery_inits[i].name);
 
-			power_supply_put_battery_info(bd->charger, &info);
+			power_supply_put_battery_info(bd->charger, info);
 			return -EINVAL;
 		}
 		if (!found) {
@@ -991,8 +993,6 @@ static int bd9995x_fw_probe(struct bd9995x_device *bd)
 		*(battery_inits[i].data) = regval;
 	}
 
-	power_supply_put_battery_info(bd->charger, &info);
-
 	for (i = 0; i < ARRAY_SIZE(props); i++) {
 		ret = device_property_read_u32(bd->dev, props[i].prop,
 					       &property);
diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 35ff0c8fe96f..06c34b09349c 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1670,7 +1670,7 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
 static int bq24190_get_config(struct bq24190_dev_info *bdi)
 {
 	const char * const s = "ti,system-minimum-microvolt";
-	struct power_supply_battery_info info = {};
+	struct power_supply_battery_info *info;
 	int v;
 
 	if (device_property_read_u32(bdi->dev, s, &v) == 0) {
@@ -1684,7 +1684,7 @@ static int bq24190_get_config(struct bq24190_dev_info *bdi)
 
 	if (bdi->dev->of_node &&
 	    !power_supply_get_battery_info(bdi->charger, &info)) {
-		v = info.precharge_current_ua / 1000;
+		v = info->precharge_current_ua / 1000;
 		if (v >= BQ24190_REG_PCTCC_IPRECHG_MIN
 		 && v <= BQ24190_REG_PCTCC_IPRECHG_MAX)
 			bdi->iprechg = v;
@@ -1692,7 +1692,7 @@ static int bq24190_get_config(struct bq24190_dev_info *bdi)
 			dev_warn(bdi->dev, "invalid value for battery:precharge-current-microamp: %d\n",
 				 v);
 
-		v = info.charge_term_current_ua / 1000;
+		v = info->charge_term_current_ua / 1000;
 		if (v >= BQ24190_REG_PCTCC_ITERM_MIN
 		 && v <= BQ24190_REG_PCTCC_ITERM_MAX)
 			bdi->iterm = v;
diff --git a/drivers/power/supply/bq2515x_charger.c b/drivers/power/supply/bq2515x_charger.c
index 374b112f712a..4f76ad9c2f18 100644
--- a/drivers/power/supply/bq2515x_charger.c
+++ b/drivers/power/supply/bq2515x_charger.c
@@ -945,7 +945,7 @@ static int bq2515x_power_supply_register(struct bq2515x_device *bq2515x,
 static int bq2515x_hw_init(struct bq2515x_device *bq2515x)
 {
 	int ret;
-	struct power_supply_battery_info bat_info = { };
+	struct power_supply_battery_info *bat_info;
 
 	ret = bq2515x_disable_watchdog_timers(bq2515x);
 	if (ret)
@@ -969,13 +969,13 @@ static int bq2515x_hw_init(struct bq2515x_device *bq2515x)
 
 	} else {
 		bq2515x->init_data.ichg =
-				bat_info.constant_charge_current_max_ua;
+				bat_info->constant_charge_current_max_ua;
 
 		bq2515x->init_data.vbatreg =
-				bat_info.constant_charge_voltage_max_uv;
+				bat_info->constant_charge_voltage_max_uv;
 
 		bq2515x->init_data.iprechg =
-				bat_info.precharge_current_ua;
+				bat_info->precharge_current_ua;
 	}
 
 	ret = bq2515x_set_const_charge_current(bq2515x,
diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index f501ecd49202..b274942dc46a 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -1504,7 +1504,7 @@ static int bq256xx_power_supply_init(struct bq256xx_device *bq,
 
 static int bq256xx_hw_init(struct bq256xx_device *bq)
 {
-	struct power_supply_battery_info bat_info = { };
+	struct power_supply_battery_info *bat_info;
 	int wd_reg_val = BQ256XX_WATCHDOG_DIS;
 	int ret = 0;
 	int i;
@@ -1526,16 +1526,16 @@ static int bq256xx_hw_init(struct bq256xx_device *bq)
 	if (ret) {
 		dev_warn(bq->dev, "battery info missing, default values will be applied\n");
 
-		bat_info.constant_charge_current_max_ua =
+		bat_info->constant_charge_current_max_ua =
 				bq->chip_info->bq256xx_def_ichg;
 
-		bat_info.constant_charge_voltage_max_uv =
+		bat_info->constant_charge_voltage_max_uv =
 				bq->chip_info->bq256xx_def_vbatreg;
 
-		bat_info.precharge_current_ua =
+		bat_info->precharge_current_ua =
 				bq->chip_info->bq256xx_def_iprechg;
 
-		bat_info.charge_term_current_ua =
+		bat_info->charge_term_current_ua =
 				bq->chip_info->bq256xx_def_iterm;
 
 		bq->init_data.ichg_max =
@@ -1545,10 +1545,10 @@ static int bq256xx_hw_init(struct bq256xx_device *bq)
 				bq->chip_info->bq256xx_max_vbatreg;
 	} else {
 		bq->init_data.ichg_max =
-			bat_info.constant_charge_current_max_ua;
+			bat_info->constant_charge_current_max_ua;
 
 		bq->init_data.vbatreg_max =
-			bat_info.constant_charge_voltage_max_uv;
+			bat_info->constant_charge_voltage_max_uv;
 	}
 
 	ret = bq->chip_info->bq256xx_set_vindpm(bq, bq->init_data.vindpm);
@@ -1560,26 +1560,26 @@ static int bq256xx_hw_init(struct bq256xx_device *bq)
 		return ret;
 
 	ret = bq->chip_info->bq256xx_set_ichg(bq,
-				bat_info.constant_charge_current_max_ua);
+				bat_info->constant_charge_current_max_ua);
 	if (ret)
 		return ret;
 
 	ret = bq->chip_info->bq256xx_set_iprechg(bq,
-				bat_info.precharge_current_ua);
+				bat_info->precharge_current_ua);
 	if (ret)
 		return ret;
 
 	ret = bq->chip_info->bq256xx_set_vbatreg(bq,
-				bat_info.constant_charge_voltage_max_uv);
+				bat_info->constant_charge_voltage_max_uv);
 	if (ret)
 		return ret;
 
 	ret = bq->chip_info->bq256xx_set_iterm(bq,
-				bat_info.charge_term_current_ua);
+				bat_info->charge_term_current_ua);
 	if (ret)
 		return ret;
 
-	power_supply_put_battery_info(bq->charger, &bat_info);
+	power_supply_put_battery_info(bq->charger, bat_info);
 
 	return 0;
 }
diff --git a/drivers/power/supply/bq25980_charger.c b/drivers/power/supply/bq25980_charger.c
index 0008c229fd9c..9daa6d14db4d 100644
--- a/drivers/power/supply/bq25980_charger.c
+++ b/drivers/power/supply/bq25980_charger.c
@@ -1079,7 +1079,7 @@ static int bq25980_power_supply_init(struct bq25980_device *bq,
 
 static int bq25980_hw_init(struct bq25980_device *bq)
 {
-	struct power_supply_battery_info bat_info = { };
+	struct power_supply_battery_info *bat_info;
 	int wd_reg_val = BQ25980_WATCHDOG_DIS;
 	int wd_max_val = BQ25980_NUM_WD_VAL - 1;
 	int ret = 0;
@@ -1112,8 +1112,8 @@ static int bq25980_hw_init(struct bq25980_device *bq)
 		return -EINVAL;
 	}
 
-	bq->init_data.ichg_max = bat_info.constant_charge_current_max_ua;
-	bq->init_data.vreg_max = bat_info.constant_charge_voltage_max_uv;
+	bq->init_data.ichg_max = bat_info->constant_charge_current_max_ua;
+	bq->init_data.vreg_max = bat_info->constant_charge_voltage_max_uv;
 
 	if (bq->state.bypass) {
 		ret = regmap_update_bits(bq->regmap, BQ25980_CHRGR_CTRL_2,
diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 7e5e24b585d8..877ea8525adc 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1474,7 +1474,7 @@ static void bq27xxx_battery_set_config(struct bq27xxx_device_info *di,
 
 static void bq27xxx_battery_settings(struct bq27xxx_device_info *di)
 {
-	struct power_supply_battery_info info = {};
+	struct power_supply_battery_info *info;
 	unsigned int min, max;
 
 	if (power_supply_get_battery_info(di->bat, &info) < 0)
@@ -1485,42 +1485,42 @@ static void bq27xxx_battery_settings(struct bq27xxx_device_info *di)
 		return;
 	}
 
-	if (info.energy_full_design_uwh != info.charge_full_design_uah) {
-		if (info.energy_full_design_uwh == -EINVAL)
+	if (info->energy_full_design_uwh != info->charge_full_design_uah) {
+		if (info->energy_full_design_uwh == -EINVAL)
 			dev_warn(di->dev, "missing battery:energy-full-design-microwatt-hours\n");
-		else if (info.charge_full_design_uah == -EINVAL)
+		else if (info->charge_full_design_uah == -EINVAL)
 			dev_warn(di->dev, "missing battery:charge-full-design-microamp-hours\n");
 	}
 
 	/* assume min == 0 */
 	max = di->dm_regs[BQ27XXX_DM_DESIGN_ENERGY].max;
-	if (info.energy_full_design_uwh > max * 1000) {
+	if (info->energy_full_design_uwh > max * 1000) {
 		dev_err(di->dev, "invalid battery:energy-full-design-microwatt-hours %d\n",
-			info.energy_full_design_uwh);
-		info.energy_full_design_uwh = -EINVAL;
+			info->energy_full_design_uwh);
+		info->energy_full_design_uwh = -EINVAL;
 	}
 
 	/* assume min == 0 */
 	max = di->dm_regs[BQ27XXX_DM_DESIGN_CAPACITY].max;
-	if (info.charge_full_design_uah > max * 1000) {
+	if (info->charge_full_design_uah > max * 1000) {
 		dev_err(di->dev, "invalid battery:charge-full-design-microamp-hours %d\n",
-			info.charge_full_design_uah);
-		info.charge_full_design_uah = -EINVAL;
+			info->charge_full_design_uah);
+		info->charge_full_design_uah = -EINVAL;
 	}
 
 	min = di->dm_regs[BQ27XXX_DM_TERMINATE_VOLTAGE].min;
 	max = di->dm_regs[BQ27XXX_DM_TERMINATE_VOLTAGE].max;
-	if ((info.voltage_min_design_uv < min * 1000 ||
-	     info.voltage_min_design_uv > max * 1000) &&
-	     info.voltage_min_design_uv != -EINVAL) {
+	if ((info->voltage_min_design_uv < min * 1000 ||
+	     info->voltage_min_design_uv > max * 1000) &&
+	     info->voltage_min_design_uv != -EINVAL) {
 		dev_err(di->dev, "invalid battery:voltage-min-design-microvolt %d\n",
-			info.voltage_min_design_uv);
-		info.voltage_min_design_uv = -EINVAL;
+			info->voltage_min_design_uv);
+		info->voltage_min_design_uv = -EINVAL;
 	}
 
-	if ((info.energy_full_design_uwh != -EINVAL &&
-	     info.charge_full_design_uah != -EINVAL) ||
-	     info.voltage_min_design_uv  != -EINVAL)
+	if ((info->energy_full_design_uwh != -EINVAL &&
+	     info->charge_full_design_uah != -EINVAL) ||
+	     info->voltage_min_design_uv  != -EINVAL)
 		bq27xxx_battery_set_config(di, &info);
 }
 
diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index 091868e9e9e8..1c42a66dd025 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -61,7 +61,7 @@ struct cw_battery {
 	struct delayed_work battery_delay_work;
 	struct regmap *regmap;
 	struct power_supply *rk_bat;
-	struct power_supply_battery_info battery;
+	struct power_supply_battery_info *battery;
 	u8 *bat_profile;
 
 	bool charger_attached;
@@ -505,22 +505,22 @@ static int cw_battery_get_property(struct power_supply *psy,
 
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
-		if (cw_bat->battery.charge_full_design_uah > 0)
-			val->intval = cw_bat->battery.charge_full_design_uah;
+		if (cw_bat->battery->charge_full_design_uah > 0)
+			val->intval = cw_bat->battery->charge_full_design_uah;
 		else
 			val->intval = 0;
 		break;
 
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
-		val->intval = cw_bat->battery.charge_full_design_uah;
+		val->intval = cw_bat->battery->charge_full_design_uah;
 		val->intval = val->intval * cw_bat->soc / 100;
 		break;
 
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		if (cw_battery_valid_time_to_empty(cw_bat) &&
-		    cw_bat->battery.charge_full_design_uah > 0) {
+		    cw_bat->battery->charge_full_design_uah > 0) {
 			/* calculate remaining capacity */
-			val->intval = cw_bat->battery.charge_full_design_uah;
+			val->intval = cw_bat->battery->charge_full_design_uah;
 			val->intval = val->intval * cw_bat->soc / 100;
 
 			/* estimate current based on time to empty */
@@ -687,6 +687,11 @@ static int cw_bat_probe(struct i2c_client *client)
 
 	ret = power_supply_get_battery_info(cw_bat->rk_bat, &cw_bat->battery);
 	if (ret) {
+		/* Allocate an empty battery */
+		cw_bat->battery = devm_kzalloc(&client->dev, sizeof(cw->battery),
+					       GFP_KERNEL);
+		if (!cw_bat->battery)
+			return -ENOMEM;
 		dev_warn(cw_bat->dev,
 			 "No monitored battery, some properties will be missing\n");
 	}
@@ -724,7 +729,7 @@ static int cw_bat_remove(struct i2c_client *client)
 	struct cw_battery *cw_bat = i2c_get_clientdata(client);
 
 	cancel_delayed_work_sync(&cw_bat->battery_delay_work);
-	power_supply_put_battery_info(cw_bat->rk_bat, &cw_bat->battery);
+	power_supply_put_battery_info(cw_bat->rk_bat, cw_bat->battery);
 	return 0;
 }
 
diff --git a/drivers/power/supply/ingenic-battery.c b/drivers/power/supply/ingenic-battery.c
index 8b18219ebe90..2e7fdfde47ec 100644
--- a/drivers/power/supply/ingenic-battery.c
+++ b/drivers/power/supply/ingenic-battery.c
@@ -18,7 +18,7 @@ struct ingenic_battery {
 	struct iio_channel *channel;
 	struct power_supply_desc desc;
 	struct power_supply *battery;
-	struct power_supply_battery_info info;
+	struct power_supply_battery_info *info;
 };
 
 static int ingenic_battery_get_property(struct power_supply *psy,
@@ -26,7 +26,7 @@ static int ingenic_battery_get_property(struct power_supply *psy,
 					union power_supply_propval *val)
 {
 	struct ingenic_battery *bat = power_supply_get_drvdata(psy);
-	struct power_supply_battery_info *info = &bat->info;
+	struct power_supply_battery_info *info = bat->info;
 	int ret;
 
 	switch (psp) {
@@ -80,7 +80,7 @@ static int ingenic_battery_set_scale(struct ingenic_battery *bat)
 	if (ret != IIO_AVAIL_LIST || scale_type != IIO_VAL_FRACTIONAL_LOG2)
 		return -EINVAL;
 
-	max_mV = bat->info.voltage_max_design_uv / 1000;
+	max_mV = bat->info->voltage_max_design_uv / 1000;
 
 	for (i = 0; i < scale_len; i += 2) {
 		u64 scale_mV = (max_raw * scale_raw[i]) >> scale_raw[i + 1];
@@ -156,13 +156,13 @@ static int ingenic_battery_probe(struct platform_device *pdev)
 		dev_err(dev, "Unable to get battery info: %d\n", ret);
 		return ret;
 	}
-	if (bat->info.voltage_min_design_uv < 0) {
+	if (bat->info->voltage_min_design_uv < 0) {
 		dev_err(dev, "Unable to get voltage min design\n");
-		return bat->info.voltage_min_design_uv;
+		return bat->info->voltage_min_design_uv;
 	}
-	if (bat->info.voltage_max_design_uv < 0) {
+	if (bat->info->voltage_max_design_uv < 0) {
 		dev_err(dev, "Unable to get voltage max design\n");
-		return bat->info.voltage_max_design_uv;
+		return bat->info->voltage_max_design_uv;
 	}
 
 	return ingenic_battery_set_scale(bat);
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 2723d7d0ced3..879fac182f28 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -564,14 +564,19 @@ EXPORT_SYMBOL_GPL(devm_power_supply_get_by_phandle);
 #endif /* CONFIG_OF */
 
 int power_supply_get_battery_info(struct power_supply *psy,
-				  struct power_supply_battery_info *info)
+				  struct power_supply_battery_info **info_out)
 {
 	struct power_supply_resistance_temp_table *resist_table;
+	struct power_supply_battery_info *info;
 	struct device_node *battery_np;
 	const char *value;
 	int err, len, index;
 	const __be32 *list;
 
+	info = devm_kmalloc(&psy->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
 	info->technology                     = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
 	info->energy_full_design_uwh         = -EINVAL;
 	info->charge_full_design_uah         = -EINVAL;
@@ -728,7 +733,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 
 	list = of_get_property(battery_np, "resistance-temp-table", &len);
 	if (!list || !len)
-		goto out_put_node;
+		goto out_ret_pointer;
 
 	info->resist_table_size = len / (2 * sizeof(__be32));
 	resist_table = info->resist_table = devm_kcalloc(&psy->dev,
@@ -746,6 +751,10 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		resist_table[index].resistance = be32_to_cpu(*list++);
 	}
 
+out_ret_pointer:
+	/* Finally return the whole thing */
+	*info_out = info;
+
 out_put_node:
 	of_node_put(battery_np);
 	return err;
@@ -764,6 +773,8 @@ void power_supply_put_battery_info(struct power_supply *psy,
 
 	if (info->resist_table)
 		devm_kfree(&psy->dev, info->resist_table);
+
+	devm_kfree(&psy->dev, info);
 }
 EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
 
diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supply/sc2731_charger.c
index 288b79836c13..9ac17cf7a126 100644
--- a/drivers/power/supply/sc2731_charger.c
+++ b/drivers/power/supply/sc2731_charger.c
@@ -368,7 +368,7 @@ static int sc2731_charger_usb_change(struct notifier_block *nb,
 
 static int sc2731_charger_hw_init(struct sc2731_charger_info *info)
 {
-	struct power_supply_battery_info bat_info = { };
+	struct power_supply_battery_info *bat_info;
 	u32 term_currrent, term_voltage, cur_val, vol_val;
 	int ret;
 
@@ -390,7 +390,7 @@ static int sc2731_charger_hw_init(struct sc2731_charger_info *info)
 		cur_val = 0x2;
 		vol_val = 0x1;
 	} else {
-		term_currrent = bat_info.charge_term_current_ua / 1000;
+		term_currrent = bat_info->charge_term_current_ua / 1000;
 
 		if (term_currrent <= 90)
 			cur_val = 0;
@@ -399,7 +399,7 @@ static int sc2731_charger_hw_init(struct sc2731_charger_info *info)
 		else
 			cur_val = ((term_currrent - 90) / 25) + 1;
 
-		term_voltage = bat_info.constant_charge_voltage_max_uv / 1000;
+		term_voltage = bat_info->constant_charge_voltage_max_uv / 1000;
 
 		if (term_voltage > 4500)
 			term_voltage = 4500;
@@ -409,7 +409,7 @@ static int sc2731_charger_hw_init(struct sc2731_charger_info *info)
 		else
 			vol_val = 0;
 
-		power_supply_put_battery_info(info->psy_usb, &bat_info);
+		power_supply_put_battery_info(info->psy_usb, bat_info);
 	}
 
 	/* Set charge termination current */
diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index ae45069bd5e1..632977f84b95 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -998,7 +998,7 @@ static int sc27xx_fgu_calibration(struct sc27xx_fgu_data *data)
 
 static int sc27xx_fgu_hw_init(struct sc27xx_fgu_data *data)
 {
-	struct power_supply_battery_info info = { };
+	struct power_supply_battery_info *info;
 	struct power_supply_battery_ocv_table *table;
 	int ret, delta_clbcnt, alarm_adc;
 
@@ -1008,16 +1008,16 @@ static int sc27xx_fgu_hw_init(struct sc27xx_fgu_data *data)
 		return ret;
 	}
 
-	data->total_cap = info.charge_full_design_uah / 1000;
-	data->max_volt = info.constant_charge_voltage_max_uv / 1000;
-	data->internal_resist = info.factory_internal_resistance_uohm / 1000;
-	data->min_volt = info.voltage_min_design_uv;
+	data->total_cap = info->charge_full_design_uah / 1000;
+	data->max_volt = info->constant_charge_voltage_max_uv / 1000;
+	data->internal_resist = info->factory_internal_resistance_uohm / 1000;
+	data->min_volt = info->voltage_min_design_uv;
 
 	/*
 	 * For SC27XX fuel gauge device, we only use one ocv-capacity
 	 * table in normal temperature 20 Celsius.
 	 */
-	table = power_supply_find_ocv2cap_table(&info, 20, &data->table_len);
+	table = power_supply_find_ocv2cap_table(info, 20, &data->table_len);
 	if (!table)
 		return -EINVAL;
 
@@ -1025,7 +1025,7 @@ static int sc27xx_fgu_hw_init(struct sc27xx_fgu_data *data)
 				       data->table_len * sizeof(*table),
 				       GFP_KERNEL);
 	if (!data->cap_table) {
-		power_supply_put_battery_info(data->battery, &info);
+		power_supply_put_battery_info(data->battery, info);
 		return -ENOMEM;
 	}
 
@@ -1035,19 +1035,19 @@ static int sc27xx_fgu_hw_init(struct sc27xx_fgu_data *data)
 	if (!data->alarm_cap)
 		data->alarm_cap += 1;
 
-	data->resist_table_len = info.resist_table_size;
+	data->resist_table_len = info->resist_table_size;
 	if (data->resist_table_len > 0) {
-		data->resist_table = devm_kmemdup(data->dev, info.resist_table,
+		data->resist_table = devm_kmemdup(data->dev, info->resist_table,
 						  data->resist_table_len *
 						  sizeof(struct power_supply_resistance_temp_table),
 						  GFP_KERNEL);
 		if (!data->resist_table) {
-			power_supply_put_battery_info(data->battery, &info);
+			power_supply_put_battery_info(data->battery, info);
 			return -ENOMEM;
 		}
 	}
 
-	power_supply_put_battery_info(data->battery, &info);
+	power_supply_put_battery_info(data->battery, info);
 
 	ret = sc27xx_fgu_calibration(data);
 	if (ret)
diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index 753944e774c4..d56e469043bb 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -1281,7 +1281,7 @@ static void smb347_dt_parse_dev_info(struct smb347_charger *smb)
 
 static int smb347_get_battery_info(struct smb347_charger *smb)
 {
-	struct power_supply_battery_info info = {};
+	struct power_supply_battery_info *info;
 	struct power_supply *supply;
 	int err;
 
@@ -1296,29 +1296,29 @@ static int smb347_get_battery_info(struct smb347_charger *smb)
 	if (err)
 		return err;
 
-	if (info.constant_charge_current_max_ua != -EINVAL)
-		smb->max_charge_current = info.constant_charge_current_max_ua;
+	if (info->constant_charge_current_max_ua != -EINVAL)
+		smb->max_charge_current = info->constant_charge_current_max_ua;
 
-	if (info.constant_charge_voltage_max_uv != -EINVAL)
-		smb->max_charge_voltage = info.constant_charge_voltage_max_uv;
+	if (info->constant_charge_voltage_max_uv != -EINVAL)
+		smb->max_charge_voltage = info->constant_charge_voltage_max_uv;
 
-	if (info.precharge_current_ua != -EINVAL)
-		smb->pre_charge_current = info.precharge_current_ua;
+	if (info->precharge_current_ua != -EINVAL)
+		smb->pre_charge_current = info->precharge_current_ua;
 
-	if (info.charge_term_current_ua != -EINVAL)
-		smb->termination_current = info.charge_term_current_ua;
+	if (info->charge_term_current_ua != -EINVAL)
+		smb->termination_current = info->charge_term_current_ua;
 
-	if (info.temp_alert_min != INT_MIN)
-		smb->soft_cold_temp_limit = info.temp_alert_min;
+	if (info->temp_alert_min != INT_MIN)
+		smb->soft_cold_temp_limit = info->temp_alert_min;
 
-	if (info.temp_alert_max != INT_MAX)
-		smb->soft_hot_temp_limit = info.temp_alert_max;
+	if (info->temp_alert_max != INT_MAX)
+		smb->soft_hot_temp_limit = info->temp_alert_max;
 
-	if (info.temp_min != INT_MIN)
-		smb->hard_cold_temp_limit = info.temp_min;
+	if (info->temp_min != INT_MIN)
+		smb->hard_cold_temp_limit = info->temp_min;
 
-	if (info.temp_max != INT_MAX)
-		smb->hard_hot_temp_limit = info.temp_max;
+	if (info->temp_max != INT_MAX)
+		smb->hard_hot_temp_limit = info->temp_max;
 
 	/* Suspend when battery temperature is outside hard limits */
 	if (smb->hard_cold_temp_limit != SMB3XX_TEMP_USE_DEFAULT ||
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index b5079109ac00..f8e318440e26 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -574,7 +574,7 @@ devm_power_supply_get_by_phandle(struct device *dev, const char *property)
 #endif /* CONFIG_OF */
 
 extern int power_supply_get_battery_info(struct power_supply *psy,
-					 struct power_supply_battery_info *info);
+					 struct power_supply_battery_info **info_out);
 extern void power_supply_put_battery_info(struct power_supply *psy,
 					  struct power_supply_battery_info *info);
 extern int power_supply_ocv2cap_simple(struct power_supply_battery_ocv_table *table,
-- 
2.31.1

