Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC7F455297
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 03:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242530AbhKRCXY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 21:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242531AbhKRCXW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 21:23:22 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001C6C061570
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:20:22 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id l22so17866529lfg.7
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iZkBzt3OCa2/wdkm1AutmV7G/2eh4Kgn3EYGOFGI8+E=;
        b=nqtnNMPMvRy+WA0ZueVWJywl4Y4uoU/s/bhG0BX7CZaijrnXgtvJ2H8z5TgIik18cX
         c0GWQyS7LWoyGGeoNbDIxcPWWAYaP63ICHBCAs6DX8qQzHzImGo1ziU461F2ZoYw6DZi
         WqJD/qTlYhETGCYPgpOt4AYZwHmIeCUzwEj+WlR8KykFodOeV/ODy+Edmvu+7jr8B1pL
         SCvqrR2qCtzTdMs+CGJS+454NKrZsoiOMGMYgO7rKNwy1OdbIJmODymxQ5P9AjvzEylg
         z17y1TLQBhT7qMaDlzDIXhsyscEHzjtG5ezae/JsZZqRVqKgIKdO0ZMRLVMNtpDw/CYO
         zIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iZkBzt3OCa2/wdkm1AutmV7G/2eh4Kgn3EYGOFGI8+E=;
        b=DY2j/7TTwK7D2ALX4rGDAseOdEcahdrk98P2AQn9K5FWpulnPlEeiP9sM/SWxnt09h
         umhjjxqeuMCVUI6+oWCSDNuV2EEgj8mEjh67/dXi11ZQYuDDQwnwd5vce+Ke2Ku7PWnQ
         WVoc1Ziqsiua1EqgmQt8No6XSLKD6qowEn1kUIvoLBi67Bg0hio3RDSC8+p7rSn1AzrI
         QmBH6IGYlF2CmJdFKyuOV32wV2CYdrWSeBZi65tBxtrBNfn+2z0uonunAGmjSDbqlmac
         ERtYga0cSEFhjEk7LC3rHcsbbfDh9fgl9FynNp8TToRmUTXvNzxv61dmHr6rhwjGM57R
         oaqA==
X-Gm-Message-State: AOAM530wrlKUNpYAXB3HetgCeDcERCZkwBeq5df8WELbbLXUtiu2gfS0
        wijvgbgfqDe1VSLeSzjPx+z2rdcT/O14kw==
X-Google-Smtp-Source: ABdhPJxzBrxmoUP2dM6xgjU8PqbkJpWMR3jrwsU5H89NelGce3lNePthziKdc3rlyDchyrdyNMfeZQ==
X-Received: by 2002:ac2:46c8:: with SMTP id p8mr20144850lfo.174.1637202021376;
        Wed, 17 Nov 2021 18:20:21 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id j19sm165321lfe.120.2021.11.17.18.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 18:20:20 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 11/16] power: supply: ab8500: Standardize termination current
Date:   Thu, 18 Nov 2021 03:17:47 +0100
Message-Id: <20211118021752.2262818-12-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118021752.2262818-1-linus.walleij@linaro.org>
References: <20211118021752.2262818-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The AB8500 custom termination current can be replaced by the
corresponding struct power_supply_battery_info field.

Remove the struct member and amend the code to use the
standard property.

Add *_ua suffix for clarity and to make sure we have
changed all code sites using this member.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500-bm.h       |  2 --
 drivers/power/supply/ab8500_bmdata.c   |  5 ++++-
 drivers/power/supply/ab8500_chargalg.c | 12 ++++++------
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index e6c5c9f5d4c5..949e6d9f13c7 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -374,7 +374,6 @@ struct ab8500_maxim_parameters {
  * struct ab8500_battery_type - different batteries supported
  * @resis_high:			battery upper resistance limit
  * @resis_low:			battery lower resistance limit
- * @termination_curr		battery charging termination current in mA
  * @recharge_cap		battery capacity limit that will trigger a new
  *				full charging cycle in the case where maintenan-
  *				-ce charging has been disabled
@@ -398,7 +397,6 @@ struct ab8500_maxim_parameters {
 struct ab8500_battery_type {
 	int resis_high;
 	int resis_low;
-	int termination_curr;
 	int recharge_cap;
 	int normal_cur_lvl;
 	int normal_vol_lvl;
diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index 2532499afe5f..1e43c9f751e1 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -83,7 +83,6 @@ static const struct batres_vs_temp temp_to_batres_tbl_thermistor[] = {
 static struct ab8500_battery_type bat_type_thermistor_unknown = {
 	.resis_high = 0,
 	.resis_low = 0,
-	.termination_curr = 200,
 	.recharge_cap = 95,
 	.normal_cur_lvl = 400,
 	.normal_vol_lvl = 4100,
@@ -203,6 +202,10 @@ int ab8500_bm_of_probe(struct power_supply *psy,
 		bi->overvoltage_limit_uv = 4050000;
 	}
 
+	if (bi->charge_term_current_ua)
+		/* Charging stops when we drop below this current */
+		bi->charge_term_current_ua = 200000;
+
 	if (bi->factory_internal_resistance_uohm < 0)
 		bi->factory_internal_resistance_uohm = 300000;
 
diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index dd9cad63e37e..49e7167d0362 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -87,7 +87,7 @@ struct ab8500_chargalg_current_step_status {
 struct ab8500_chargalg_battery_data {
 	int temp;
 	int volt_uv;
-	int avg_curr;
+	int avg_curr_ua;
 	int inst_curr;
 	int percent;
 };
@@ -795,9 +795,9 @@ static void ab8500_chargalg_end_of_charge(struct ab8500_chargalg *di)
 		!di->maintenance_chg && (di->batt_data.volt_uv >=
 		di->bm->bi.overvoltage_limit_uv ||
 		di->events.usb_cv_active || di->events.ac_cv_active) &&
-		di->batt_data.avg_curr <
-		di->bm->bat_type->termination_curr &&
-		di->batt_data.avg_curr > 0) {
+		di->batt_data.avg_curr_ua <
+		di->bm->bi.charge_term_current_ua &&
+		di->batt_data.avg_curr_ua > 0) {
 		if (++di->eoc_cnt >= EOC_COND_CNT) {
 			di->eoc_cnt = 0;
 			di->charge_status = POWER_SUPPLY_STATUS_FULL;
@@ -1237,7 +1237,7 @@ static int ab8500_chargalg_get_ext_psy_data(struct device *dev, void *data)
 		case POWER_SUPPLY_PROP_CURRENT_AVG:
 			switch (ext->desc->type) {
 			case POWER_SUPPLY_TYPE_BATTERY:
-				di->batt_data.avg_curr = ret.intval / 1000;
+				di->batt_data.avg_curr_ua = ret.intval;
 				break;
 			case POWER_SUPPLY_TYPE_USB:
 				if (ret.intval)
@@ -1398,7 +1398,7 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 		"AC_online %d USB_online %d AC_CV %d USB_CV %d AC_I %d "
 		"USB_I %d AC_Vset %d AC_Iset %d USB_Vset %d USB_Iset %d\n",
 		di->batt_data.volt_uv,
-		di->batt_data.avg_curr,
+		di->batt_data.avg_curr_ua,
 		di->batt_data.inst_curr,
 		di->batt_data.temp,
 		di->batt_data.percent,
-- 
2.31.1

