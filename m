Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC36455294
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 03:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242495AbhKRCXV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 21:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242500AbhKRCXN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 21:23:13 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DE1C061570
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:20:14 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bi37so18050222lfb.5
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tYK5uoy8GHHO0OljX1X+VuD+Rv00GwqfTZX0VCYWrrQ=;
        b=qg3y3xPH9unsP7I15/V2JYXcZo7bwZyjcpCchpkkbPr+LeXgG5n/9oZbiRjPpQ9lys
         dZOax1IHBtnAeIcozwZFkGinAKUD0crpgC+WP7bEECqpt8fqZj4jbChTfX6yBV+MOIM2
         BgpyTF+a+qQGvmogPTbKL5dInnHsODQxdItmSoq4Nu1FuSG0Wwc0+q1M9ZDEDyejrvl7
         O81rRWxGkbnITFlXsoknh6cNmWerddSYwCgO56apP4XVQnzRhonth9KUzx2oHoLTvbU3
         9w/jW+DtFDT6m3ZOG33LgQSPutirDXfWSHS37N3sEzOwM/JChW4DOs37vECzqxDWIUO8
         miJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tYK5uoy8GHHO0OljX1X+VuD+Rv00GwqfTZX0VCYWrrQ=;
        b=n0s/pJhPLCVKKPNr4Qf1tiLBHHDdyiV4ymwD2EoGc4DiNHDLoN1rru31gnykQwKjcO
         Ll9jY5stXlCdWvzwkkg9d3PI0ftumMBgpLKJfQBw4z43tDUQF24qe0xY5TLNTQvoGBCv
         jRCxnsBs1nN6olZF+ZtPlfbCKzpZ5T9sbnAnlqfKgd252qf19ZcKhYlxiV5akgfKeXvM
         wU7iPeTaXrGlP3xsSUoEXwbZdxUJhd0UJG9vAIyPY5S0iwTl/qu0ApVeb/ik/AbrTIiH
         vxYfC54ECUNuv4tZV9py6/sPuWHHYIGnGw48hukGsVdX/AaHLG/NN7l6XfOplYE5g+4h
         PMgw==
X-Gm-Message-State: AOAM5310sFVd7MmavO/GkzlNOsi6HT7DwnUAL9OIYCcSS9j2ZR5s5dRg
        TqY0RYfI8FV+gRtHDzhlRfNVcA==
X-Google-Smtp-Source: ABdhPJxEh7XaC53Z34G3ER4omfS9DihjBWGSAi6zjpOzM/mcVOxPKS8VfGl/XoWGN5FsK9H4nEIgEQ==
X-Received: by 2002:a05:6512:3763:: with SMTP id z3mr19705228lft.315.1637202012689;
        Wed, 17 Nov 2021 18:20:12 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id j19sm165321lfe.120.2021.11.17.18.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 18:20:11 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 07/16] power: supply: ab8500: Standardize technology
Date:   Thu, 18 Nov 2021 03:17:43 +0100
Message-Id: <20211118021752.2262818-8-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118021752.2262818-1-linus.walleij@linaro.org>
References: <20211118021752.2262818-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The AB8500 custom battery type can be replaced by the
corresponding struct power_supply_battery_info field.

Remove the struct member and amend the code to use the
standard property.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500-bm.h     | 2 --
 drivers/power/supply/ab8500_bmdata.c | 1 -
 drivers/power/supply/ab8500_btemp.c  | 6 +++---
 drivers/power/supply/ab8500_fg.c     | 2 +-
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index 79c00808a372..66fd6568942c 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -372,7 +372,6 @@ struct ab8500_maxim_parameters {
 
 /**
  * struct ab8500_battery_type - different batteries supported
- * @name:			battery technology
  * @resis_high:			battery upper resistance limit
  * @resis_low:			battery lower resistance limit
  * @nominal_voltage:		Nominal voltage of the battery in mV
@@ -400,7 +399,6 @@ struct ab8500_maxim_parameters {
  * @batres_tbl			battery internal resistance vs temperature table
  */
 struct ab8500_battery_type {
-	int name;
 	int resis_high;
 	int resis_low;
 	int nominal_voltage;
diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index 6e876ba03956..a5e655d0761a 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -81,7 +81,6 @@ static const struct batres_vs_temp temp_to_batres_tbl_thermistor[] = {
 
 /* Default battery type for reference designs is the unknown type */
 static struct ab8500_battery_type bat_type_thermistor_unknown = {
-	.name = POWER_SUPPLY_TECHNOLOGY_UNKNOWN,
 	.resis_high = 0,
 	.resis_low = 0,
 	.battery_resistance = 300,
diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index fbb58074efab..20253b8a7fe9 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -456,7 +456,7 @@ static int ab8500_btemp_measure_temp(struct ab8500_btemp *di)
 	int rbat, rntc, vntc;
 
 	if ((di->bm->adc_therm == AB8500_ADC_THERM_BATCTRL) &&
-	    (di->bm->bat_type->name == POWER_SUPPLY_TECHNOLOGY_UNKNOWN)) {
+	    (di->bm->bi.technology == POWER_SUPPLY_TECHNOLOGY_UNKNOWN)) {
 
 		rbat = ab8500_btemp_get_batctrl_res(di);
 		if (rbat < 0) {
@@ -540,7 +540,7 @@ static int ab8500_btemp_id(struct ab8500_btemp *di)
 	 * that need it.
 	 */
 	if ((di->bm->adc_therm == AB8500_ADC_THERM_BATCTRL) &&
-	    (di->bm->bat_type->name == POWER_SUPPLY_TECHNOLOGY_LIPO) &&
+	    (di->bm->bi.technology == POWER_SUPPLY_TECHNOLOGY_LIPO) &&
 	    (res <= 53407) && (res >= 12500)) {
 		dev_dbg(di->dev, "Set BATCTRL current source to 20uA\n");
 		di->curr_source = BTEMP_BATCTRL_CURR_SRC_20UA;
@@ -807,7 +807,7 @@ static int ab8500_btemp_get_property(struct power_supply *psy,
 			val->intval = 1;
 		break;
 	case POWER_SUPPLY_PROP_TECHNOLOGY:
-		val->intval = di->bm->bat_type->name;
+		val->intval = di->bm->bi.technology;
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
 		val->intval = ab8500_btemp_get_temp(di);
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 4f8b3a76c565..c6237c4f4721 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2233,7 +2233,7 @@ static int ab8500_fg_get_ext_psy_data(struct device *dev, void *data)
 			switch (ext->desc->type) {
 			case POWER_SUPPLY_TYPE_BATTERY:
 				if (!di->flags.batt_id_received &&
-				    (di->bm->bat_type->name !=
+				    (di->bm->bi.technology !=
 				     POWER_SUPPLY_TECHNOLOGY_UNKNOWN)) {
 					const struct ab8500_battery_type *b;
 
-- 
2.31.1

