Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05286455290
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 03:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241556AbhKRCXI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 21:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241558AbhKRCXH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 21:23:07 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A68DC061764
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:20:07 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id c32so18130563lfv.4
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FGx8RfWOWMLiXdarIPjZSVIU9njZPRI9c50EcXVxfDM=;
        b=jt63639f+95GS0teYCAm+CZV6NHOciOqbSoTDJDSZGEMSzqZph0538wJQtMvQHd+Y4
         Gk0j54TL7agiEZV+urwZALwbEvCOjEzNOp9F2OqpG9hf7By8QPoPdNxoEkFOQdll+A1h
         7hVeopHynYdODTtHGrrNWS70P/WMjsKf3z4URiFdQcmqufeJLkT3xyz1IdE5HSaY/stM
         C0t7QIC3h9L4bgeRBFqqBzjP07abrEsGVUtSECN9Cu9cK4o+t+sCHVpwoadv8GBrFhci
         RmR0MHdmUlIKU3gD9zMO5WiXBIk9C93+G3bs+/swjrjgkqGAg9rmQlWs8jmualPs8xEC
         ygaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FGx8RfWOWMLiXdarIPjZSVIU9njZPRI9c50EcXVxfDM=;
        b=vVrHlTNo1ruOJdEuo+YoCiJZe4ltXO/QHV93J149Ek43zOwfdExuhR9zHldKMWeTXx
         x/WCSPaJ+y9ezCRctftv/u2nB8omc6vu9K3unuuPyUpNfhGFUPmqvkQAC7/UwEuiwFtx
         xx9Rlswybtyllgbr/Z/xI7IhztdrcUL2Yo9P4VlI6a1R47B6rLf6grjBcHI2TyBe9f4W
         fDDB0CzoNNvkXvVwU4UMzUUGVZojogV9mXIEaSrxPUZgHPtcWOgJHMKfR99doydkThFc
         yUIcX9IEi0SdMmbKwA+GZEYL78zJ9kbBWYM/z37ofPJ6A/qYt0IqPKJEMY4fk7QQFYzk
         GxOw==
X-Gm-Message-State: AOAM531AjOkc7QgpvjEtcUN5JgPNEcQHvl/px0gLaeTHNoSg5Y30S7QB
        1jBDOHUnUrkhQ1NfZM2vCMy4AQdnS9v5hA==
X-Google-Smtp-Source: ABdhPJyoGrzgj0eKVZwj6c+bBEJNIQUFGVCjBg3kUbecUbnieekq4NhMy3/7eRmrFEGtneye8Ri1VQ==
X-Received: by 2002:a2e:b5b7:: with SMTP id f23mr12324211ljn.244.1637202005425;
        Wed, 17 Nov 2021 18:20:05 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id j19sm165321lfe.120.2021.11.17.18.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 18:20:04 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 04/16] power: supply: ab8500: Drop unused battery types
Date:   Thu, 18 Nov 2021 03:17:40 +0100
Message-Id: <20211118021752.2262818-5-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118021752.2262818-1-linus.walleij@linaro.org>
References: <20211118021752.2262818-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The code tries to detect a lot of battery variants on the reference
designs, but we are not using the reference designs in practice, we
are using real products such as Samsung Phones.

The reference design with no battery plugged in will be detected as
a LIPO battery with a thermistor on the batctrl pin so we will
assume this and later on we can support other types through the
device tree if we want, just like the products do.

Drop the tables for external thermistor, only keep the internal
thermistor tables that we will use as default.

We can delete the assignment of the temperature to resistance table
since the default will be the only and correct option.

Also get rid of some unused variables and unused exports.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_bmdata.c | 180 +--------------------------
 1 file changed, 1 insertion(+), 179 deletions(-)

diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index 4ad4a66e7e37..bd651602fd69 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -39,10 +39,6 @@ const struct ab8500_res_to_temp ab8500_temp_tbl_a_thermistor[] = {
 	{60, 13437},
 	{65, 12500},
 };
-EXPORT_SYMBOL(ab8500_temp_tbl_a_thermistor);
-
-const int ab8500_temp_tbl_a_size = ARRAY_SIZE(ab8500_temp_tbl_a_thermistor);
-EXPORT_SYMBOL(ab8500_temp_tbl_a_size);
 
 const struct ab8500_res_to_temp ab8500_temp_tbl_b_thermistor[] = {
 	{-5, 200000},
@@ -61,10 +57,6 @@ const struct ab8500_res_to_temp ab8500_temp_tbl_b_thermistor[] = {
 	{60,  85461},
 	{65,  82869},
 };
-EXPORT_SYMBOL(ab8500_temp_tbl_b_thermistor);
-
-const int ab8500_temp_tbl_b_size = ARRAY_SIZE(ab8500_temp_tbl_b_thermistor);
-EXPORT_SYMBOL(ab8500_temp_tbl_b_size);
 
 static const struct ab8500_v_to_cap cap_tbl_a_thermistor[] = {
 	{4171,	100},
@@ -175,31 +167,6 @@ static const struct batres_vs_temp temp_to_batres_tbl_thermistor[] = {
 	{-20, 595},
 };
 
-/*
- * Note that the batres_vs_temp table must be strictly sorted by falling
- * temperature values to work.
- */
-static const struct batres_vs_temp temp_to_batres_tbl_ext_thermistor[] = {
-	{ 60, 300},
-	{ 30, 300},
-	{ 20, 300},
-	{ 10, 300},
-	{ 00, 300},
-	{-10, 300},
-	{-20, 300},
-};
-
-/* battery resistance table for LI ION 9100 battery */
-static const struct batres_vs_temp temp_to_batres_tbl_9100[] = {
-	{ 60, 180},
-	{ 30, 180},
-	{ 20, 180},
-	{ 10, 180},
-	{ 00, 180},
-	{-10, 180},
-	{-20, 180},
-};
-
 static struct ab8500_battery_type bat_type_thermistor[] = {
 	[BATTERY_UNKNOWN] = {
 		/* First element always represent the UNKNOWN battery */
@@ -286,123 +253,6 @@ static struct ab8500_battery_type bat_type_thermistor[] = {
 	},
 };
 
-static struct ab8500_battery_type bat_type_ext_thermistor[] = {
-	[BATTERY_UNKNOWN] = {
-		/* First element always represent the UNKNOWN battery */
-		.name = POWER_SUPPLY_TECHNOLOGY_UNKNOWN,
-		.resis_high = 0,
-		.resis_low = 0,
-		.battery_resistance = 300,
-		.charge_full_design = 612,
-		.nominal_voltage = 3700,
-		.termination_vol = 4050,
-		.termination_curr = 200,
-		.recharge_cap = 95,
-		.normal_cur_lvl = 400,
-		.normal_vol_lvl = 4100,
-		.maint_a_cur_lvl = 400,
-		.maint_a_vol_lvl = 4050,
-		.maint_a_chg_timer_h = 60,
-		.maint_b_cur_lvl = 400,
-		.maint_b_vol_lvl = 4000,
-		.maint_b_chg_timer_h = 200,
-		.low_high_cur_lvl = 300,
-		.low_high_vol_lvl = 4000,
-		.n_temp_tbl_elements = ARRAY_SIZE(temp_tbl),
-		.r_to_t_tbl = temp_tbl,
-		.n_v_cap_tbl_elements = ARRAY_SIZE(cap_tbl),
-		.v_to_cap_tbl = cap_tbl,
-		.n_batres_tbl_elements = ARRAY_SIZE(temp_to_batres_tbl_thermistor),
-		.batres_tbl = temp_to_batres_tbl_thermistor,
-	},
-/*
- * These are the batteries that doesn't have an internal NTC resistor to measure
- * its temperature. The temperature in this case is measure with a NTC placed
- * near the battery but on the PCB.
- */
-	{
-		.name = POWER_SUPPLY_TECHNOLOGY_LIPO,
-		.resis_high = 76000,
-		.resis_low = 53000,
-		.battery_resistance = 300,
-		.charge_full_design = 900,
-		.nominal_voltage = 3700,
-		.termination_vol = 4150,
-		.termination_curr = 100,
-		.recharge_cap = 95,
-		.normal_cur_lvl = 700,
-		.normal_vol_lvl = 4200,
-		.maint_a_cur_lvl = 600,
-		.maint_a_vol_lvl = 4150,
-		.maint_a_chg_timer_h = 60,
-		.maint_b_cur_lvl = 600,
-		.maint_b_vol_lvl = 4100,
-		.maint_b_chg_timer_h = 200,
-		.low_high_cur_lvl = 300,
-		.low_high_vol_lvl = 4000,
-		.n_temp_tbl_elements = ARRAY_SIZE(temp_tbl),
-		.r_to_t_tbl = temp_tbl,
-		.n_v_cap_tbl_elements = ARRAY_SIZE(cap_tbl),
-		.v_to_cap_tbl = cap_tbl,
-		.n_batres_tbl_elements = ARRAY_SIZE(temp_to_batres_tbl_thermistor),
-		.batres_tbl = temp_to_batres_tbl_thermistor,
-	},
-	{
-		.name = POWER_SUPPLY_TECHNOLOGY_LION,
-		.resis_high = 30000,
-		.resis_low = 10000,
-		.battery_resistance = 300,
-		.charge_full_design = 950,
-		.nominal_voltage = 3700,
-		.termination_vol = 4150,
-		.termination_curr = 100,
-		.recharge_cap = 95,
-		.normal_cur_lvl = 700,
-		.normal_vol_lvl = 4200,
-		.maint_a_cur_lvl = 600,
-		.maint_a_vol_lvl = 4150,
-		.maint_a_chg_timer_h = 60,
-		.maint_b_cur_lvl = 600,
-		.maint_b_vol_lvl = 4100,
-		.maint_b_chg_timer_h = 200,
-		.low_high_cur_lvl = 300,
-		.low_high_vol_lvl = 4000,
-		.n_temp_tbl_elements = ARRAY_SIZE(temp_tbl),
-		.r_to_t_tbl = temp_tbl,
-		.n_v_cap_tbl_elements = ARRAY_SIZE(cap_tbl),
-		.v_to_cap_tbl = cap_tbl,
-		.n_batres_tbl_elements = ARRAY_SIZE(temp_to_batres_tbl_thermistor),
-		.batres_tbl = temp_to_batres_tbl_thermistor,
-	},
-	{
-		.name = POWER_SUPPLY_TECHNOLOGY_LION,
-		.resis_high = 95000,
-		.resis_low = 76001,
-		.battery_resistance = 300,
-		.charge_full_design = 950,
-		.nominal_voltage = 3700,
-		.termination_vol = 4150,
-		.termination_curr = 100,
-		.recharge_cap = 95,
-		.normal_cur_lvl = 700,
-		.normal_vol_lvl = 4200,
-		.maint_a_cur_lvl = 600,
-		.maint_a_vol_lvl = 4150,
-		.maint_a_chg_timer_h = 60,
-		.maint_b_cur_lvl = 600,
-		.maint_b_vol_lvl = 4100,
-		.maint_b_chg_timer_h = 200,
-		.low_high_cur_lvl = 300,
-		.low_high_vol_lvl = 4000,
-		.n_temp_tbl_elements = ARRAY_SIZE(temp_tbl),
-		.r_to_t_tbl = temp_tbl,
-		.n_v_cap_tbl_elements = ARRAY_SIZE(cap_tbl),
-		.v_to_cap_tbl = cap_tbl,
-		.n_batres_tbl_elements = ARRAY_SIZE(temp_to_batres_tbl_thermistor),
-		.batres_tbl = temp_to_batres_tbl_thermistor,
-	},
-};
-
 static const struct ab8500_bm_capacity_levels cap_levels = {
 	.critical	= 2,
 	.low		= 10,
@@ -447,6 +297,7 @@ static const struct ab8500_bm_charger_parameters chg = {
 	.ac_curr_max		= 1500,
 };
 
+/* This is referenced directly in the charger code */
 struct ab8500_bm_data ab8500_bm_data = {
 	.main_safety_tmr_h      = 4,
 	.temp_interval_chg      = 20,
@@ -475,11 +326,9 @@ struct ab8500_bm_data ab8500_bm_data = {
 int ab8500_bm_of_probe(struct power_supply *psy,
 		       struct ab8500_bm_data *bm)
 {
-	const struct batres_vs_temp *tmp_batres_tbl;
 	struct power_supply_battery_info *bi = &bm->bi;
 	struct device *dev = &psy->dev;
 	int ret;
-	int i;
 
 	ret = power_supply_get_battery_info(psy, bi);
 	if (ret) {
@@ -497,32 +346,5 @@ int ab8500_bm_of_probe(struct power_supply *psy,
 		bi->temp_alert_max = AB8500_TEMP_HIGH;
 	bm->temp_hysteresis = AB8500_TEMP_HYSTERESIS;
 
-
-	if (bi->technology == POWER_SUPPLY_TECHNOLOGY_LION) {
-		bm->no_maintenance  = true;
-		bm->chg_unknown_bat = true;
-		bm->bat_type[BATTERY_UNKNOWN].charge_full_design = 2600;
-		bm->bat_type[BATTERY_UNKNOWN].termination_vol    = 4150;
-		bm->bat_type[BATTERY_UNKNOWN].recharge_cap       = 95;
-		bm->bat_type[BATTERY_UNKNOWN].normal_cur_lvl     = 520;
-		bm->bat_type[BATTERY_UNKNOWN].normal_vol_lvl     = 4200;
-	}
-
-	if (of_property_read_bool(psy->of_node, "thermistor-on-batctrl")) {
-		if (bi->technology == POWER_SUPPLY_TECHNOLOGY_LION)
-			tmp_batres_tbl = temp_to_batres_tbl_9100;
-		else
-			tmp_batres_tbl = temp_to_batres_tbl_thermistor;
-	} else {
-		bm->n_btypes   = 4;
-		bm->bat_type   = bat_type_ext_thermistor;
-		bm->adc_therm  = AB8500_ADC_THERM_BATTEMP;
-		tmp_batres_tbl = temp_to_batres_tbl_ext_thermistor;
-	}
-
-	/* select the battery resolution table */
-	for (i = 0; i < bm->n_btypes; ++i)
-		bm->bat_type[i].batres_tbl = tmp_batres_tbl;
-
 	return 0;
 }
-- 
2.31.1

