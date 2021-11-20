Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F11457F1D
	for <lists+linux-pm@lfdr.de>; Sat, 20 Nov 2021 16:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbhKTP6q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 Nov 2021 10:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhKTP6p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 Nov 2021 10:58:45 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2250CC061574
        for <linux-pm@vger.kernel.org>; Sat, 20 Nov 2021 07:55:42 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bi37so58087681lfb.5
        for <linux-pm@vger.kernel.org>; Sat, 20 Nov 2021 07:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D2GTtbjcLUB/BC3rkCC+Rd9tlCgmELQk0duzAnRd7Ew=;
        b=oTka/HLy1VMvlgl/u0OiERdGxuxzh6dQ59ffznXBc/vQOElctXKplGk/1O9ueGtGNm
         fN2vhvGZXYvoaveudcNR2MuNJ7ggvH95tD9EihaB9dm5VsCA6XeBCjytj7xhSXp88mIS
         wVxH4vMvFcQWXWHO5N6LSvpnjb/JvPcdd23Iyti2kzWbiBqJRJ4fdqY7euOmDfK//JG7
         MA3lg188ECQs1P2LThZFT7lCPW75/+VtSrWHgmn6uIdlNCIDeqDHT9w9eiQ9bhfSLkBA
         25EFmTuUoLYVv80/xJPcvhTpB5CF2C5vUSkWS+Gv/AZYWu5xoh6iohY+hlMP3REzGoIJ
         LYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D2GTtbjcLUB/BC3rkCC+Rd9tlCgmELQk0duzAnRd7Ew=;
        b=cj7H56kbDnhxdWNGGDympRa/4kIZNcvPUT91wrHe6z9xT9947l7tfEraKBUXUVSuvN
         9EV4mVIz1yGzX4uAEBDV76nn0FWNjSBJsjOoDZ7n4R/x5SnSk6JbAyi/dnns+I5z7BZL
         EXgPzusjrI0EyABKo3ROyIE7BVCsNod8oGBkHjEBd3sKDAvexS9nHkkYiG971BB0ZgoY
         wE/1J+f34tDdlT51RyFQeK+HP1glUfHS+sU7ZnjlRzaedS2zKDey9XemLoxXI6GJS7nQ
         Sf06TQjAcz/iajGrSm9E1vg5F8a5OINEHck0guMmzQcqBF+fw9BkYoibVoWKmZF8jDpB
         NSXg==
X-Gm-Message-State: AOAM5308R0eiNN499nEUXfpRdpX3d9Iqso7bxpJPZev8tfVhaPkc3qlO
        DrfN9XE9Oa2h5FEefniy+TjtHA==
X-Google-Smtp-Source: ABdhPJzxca5Tfogsl6GHMOTFeAPBk9WYSCP4W3RKQ58BIF3ppPmnoJevAdtUgr6X+qsdXFHHMsidug==
X-Received: by 2002:a05:6512:398b:: with SMTP id j11mr42926596lfu.461.1637423740506;
        Sat, 20 Nov 2021 07:55:40 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id t12sm280922ljg.63.2021.11.20.07.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 07:55:39 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 01/16] power: supply: ab8500: Use core battery parser
Date:   Sat, 20 Nov 2021 16:53:11 +0100
Message-Id: <20211120155326.2891664-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211120155326.2891664-1-linus.walleij@linaro.org>
References: <20211120155326.2891664-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This deploys the core battery DT parser to read the basic properties
of the battery. We only use very little of it as we start out, but
we will improve as we go along.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Issue power_supply_put_battery_info() after use.
- Use devm_err_probe() when calling the set-up code.
---
 drivers/power/supply/ab8500-bm.h      |  3 +--
 drivers/power/supply/ab8500_bmdata.c  | 31 +++++++++++----------------
 drivers/power/supply/ab8500_charger.c | 16 +++++++++-----
 3 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index d11405b7ee1a..33c7e15f5d96 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -570,8 +570,7 @@ int ab8500_fg_inst_curr_start(struct ab8500_fg *di);
 int ab8500_fg_inst_curr_finalize(struct ab8500_fg *di, int *res);
 int ab8500_fg_inst_curr_started(struct ab8500_fg *di);
 int ab8500_fg_inst_curr_done(struct ab8500_fg *di);
-int ab8500_bm_of_probe(struct device *dev,
-		       struct device_node *np,
+int ab8500_bm_of_probe(struct power_supply *psy,
 		       struct ab8500_bm_data *bm);
 
 extern struct platform_driver ab8500_fg_driver;
diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index bfc1245d7912..a515dfad4c3f 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -488,29 +488,22 @@ struct ab8500_bm_data ab8500_bm_data = {
         .n_chg_in_curr          = ARRAY_SIZE(ab8500_charge_input_curr_map),
 };
 
-int ab8500_bm_of_probe(struct device *dev,
-		       struct device_node *np,
+int ab8500_bm_of_probe(struct power_supply *psy,
 		       struct ab8500_bm_data *bm)
 {
 	const struct batres_vs_temp *tmp_batres_tbl;
-	struct device_node *battery_node;
-	const char *btech;
+	struct power_supply_battery_info info;
+	struct device *dev = &psy->dev;
+	int ret;
 	int i;
 
-	battery_node = of_parse_phandle(np, "monitored-battery", 0);
-	if (!battery_node) {
-		dev_err(dev, "battery node or reference missing\n");
-		return -EINVAL;
+	ret = power_supply_get_battery_info(psy, &info);
+	if (ret) {
+		dev_err(dev, "cannot retrieve battery info\n");
+		return ret;
 	}
 
-	btech = of_get_property(battery_node, "stericsson,battery-type", NULL);
-	if (!btech) {
-		dev_warn(dev, "missing property battery-name/type\n");
-		of_node_put(battery_node);
-		return -EINVAL;
-	}
-
-	if (strncmp(btech, "LION", 4) == 0) {
+	if (info.technology == POWER_SUPPLY_TECHNOLOGY_LION) {
 		bm->no_maintenance  = true;
 		bm->chg_unknown_bat = true;
 		bm->bat_type[BATTERY_UNKNOWN].charge_full_design = 2600;
@@ -520,8 +513,8 @@ int ab8500_bm_of_probe(struct device *dev,
 		bm->bat_type[BATTERY_UNKNOWN].normal_vol_lvl     = 4200;
 	}
 
-	if (of_property_read_bool(battery_node, "thermistor-on-batctrl")) {
-		if (strncmp(btech, "LION", 4) == 0)
+	if (of_property_read_bool(psy->of_node, "thermistor-on-batctrl")) {
+		if (info.technology == POWER_SUPPLY_TECHNOLOGY_LION)
 			tmp_batres_tbl = temp_to_batres_tbl_9100;
 		else
 			tmp_batres_tbl = temp_to_batres_tbl_thermistor;
@@ -536,7 +529,7 @@ int ab8500_bm_of_probe(struct device *dev,
 	for (i = 0; i < bm->n_btypes; ++i)
 		bm->bat_type[i].batres_tbl = tmp_batres_tbl;
 
-	of_node_put(battery_node);
+	power_supply_put_battery_info(psy, &info);
 
 	return 0;
 }
diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 15eadaf46f14..59ca9c0b8012 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3413,11 +3413,6 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 
 	di->bm = &ab8500_bm_data;
 
-	ret = ab8500_bm_of_probe(dev, np, di->bm);
-	if (ret) {
-		dev_err(dev, "failed to get battery information\n");
-		return ret;
-	}
 	di->autopower_cfg = of_property_read_bool(np, "autopower_cfg");
 
 	/* get parent data */
@@ -3490,9 +3485,11 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	di->invalid_charger_detect_state = 0;
 
 	/* AC and USB supply config */
+	ac_psy_cfg.of_node = np;
 	ac_psy_cfg.supplied_to = supply_interface;
 	ac_psy_cfg.num_supplicants = ARRAY_SIZE(supply_interface);
 	ac_psy_cfg.drv_data = &di->ac_chg;
+	usb_psy_cfg.of_node = np;
 	usb_psy_cfg.supplied_to = supply_interface;
 	usb_psy_cfg.num_supplicants = ARRAY_SIZE(supply_interface);
 	usb_psy_cfg.drv_data = &di->usb_chg;
@@ -3610,6 +3607,15 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 		return PTR_ERR(di->usb_chg.psy);
 	}
 
+	/*
+	 * Check what battery we have, since we always have the USB
+	 * psy, use that as a handle.
+	 */
+	ret = ab8500_bm_of_probe(di->usb_chg.psy, di->bm);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to get battery information\n");
+
 	/* Identify the connected charger types during startup */
 	charger_status = ab8500_charger_detect_chargers(di, true);
 	if (charger_status & AC_PW_CONN) {
-- 
2.31.1

