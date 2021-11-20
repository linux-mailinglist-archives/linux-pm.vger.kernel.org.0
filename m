Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5A2457F23
	for <lists+linux-pm@lfdr.de>; Sat, 20 Nov 2021 16:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbhKTP66 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 Nov 2021 10:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhKTP66 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 Nov 2021 10:58:58 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC566C061574
        for <linux-pm@vger.kernel.org>; Sat, 20 Nov 2021 07:55:54 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id u3so58002121lfl.2
        for <linux-pm@vger.kernel.org>; Sat, 20 Nov 2021 07:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VBjsQBi3+AjmTuQQrzwVcZUwTOPxgiZyhr3/GbSGylQ=;
        b=yo+2o7FPAquBpgeFl/sOR8xLY8X67TXWcXsUbipTw3DDhej5izVNSOlUCgqJAWTxAs
         O27/kyVjm9sg43oVE4P+2t6Sw2K48HCTD9eNK01iaCrP/RElrWmAnyTmWJAfGTTPOGyt
         bzfQYbjdV2nNA8jbTSaNqGENFHwAUizRX1omWr+MbvAwL7mkOW2XFVr6/4UYcP5hgJ8w
         PuTHTduR/bPuKaVyYl94JfMAbkagdkRAE/XuSdf/V3PI3c25+SlFfqC0RyhOt9KoloAK
         PBUW/NO8snrmmtR4aw35PHGlZUYAar9l/dxF7obQZGHjTMRbJEJGeydZIW19Jqpma4sP
         qing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VBjsQBi3+AjmTuQQrzwVcZUwTOPxgiZyhr3/GbSGylQ=;
        b=ZaJ2omo9kZ3Z7mwy3UdfxoOsA4YNiQajzx9Q0HR0I1/EUBXKQYTeNq2cW98TrS+yLw
         cDXyesaryELORAYeGWOxixLEkkzs8Egr46G+XhZgPBLWfR6uDTgcN78OE7yWB/i+tfOh
         7iKkNKpkpzrkvejTY5voSy3meEmWpGg8aCX7CnWTKb6bb3tiT4iD/6iRLIyLypsrm6zF
         OclQzIS0loRAzNeDjHhqrdWyGbTAFokU2gmBgeRG1ZTiFSjDBi5RWmlzjbdcRMBekCgD
         l8ceOtmOOjoqzSyFY7nmW7pTTz95q1HmQkyxKJkdifj1nCVLsjjf1cqu3bWSKU2w0tZB
         RSsw==
X-Gm-Message-State: AOAM53356JNsHItK7Fh0NgFFSS7OSiIyWn5xbsU/yLYpTfSJcTExqFrG
        +Twrq6TOavnrhDRyKoDoPS0/Og==
X-Google-Smtp-Source: ABdhPJwUTKW4n4Rbx/esXVZ8M5NF73zdU8GNrYQ5ttfOORCR/CNNFvnS17wZ49Q2FrDwRhPsw/0QPg==
X-Received: by 2002:a2e:2410:: with SMTP id k16mr35882742ljk.441.1637423753297;
        Sat, 20 Nov 2021 07:55:53 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id t12sm280922ljg.63.2021.11.20.07.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 07:55:52 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 07/16] power: supply: ab8500: Standardize technology
Date:   Sat, 20 Nov 2021 16:53:17 +0100
Message-Id: <20211120155326.2891664-8-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211120155326.2891664-1-linus.walleij@linaro.org>
References: <20211120155326.2891664-1-linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- Rebase on the other patches
---
 drivers/power/supply/ab8500-bm.h     | 2 --
 drivers/power/supply/ab8500_bmdata.c | 1 -
 drivers/power/supply/ab8500_btemp.c  | 6 +++---
 drivers/power/supply/ab8500_fg.c     | 2 +-
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index a5cae9288274..750d1a962f39 100644
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
index 2d328d3007a9..44d7c568949f 100644
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

