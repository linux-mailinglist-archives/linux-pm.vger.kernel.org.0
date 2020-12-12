Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5202D861A
	for <lists+linux-pm@lfdr.de>; Sat, 12 Dec 2020 11:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438855AbgLLK6F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Dec 2020 05:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438848AbgLLK6D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Dec 2020 05:58:03 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBCCC0613D6
        for <linux-pm@vger.kernel.org>; Sat, 12 Dec 2020 02:57:22 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id m19so17994709lfb.1
        for <linux-pm@vger.kernel.org>; Sat, 12 Dec 2020 02:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X8VThf45bOLdUfUXFvslCbuQWhXnY7v/1IVWJ78UmWc=;
        b=ne3thSHBZBhX1g1mHi0LhgwhidmJx7TsLVTJ7y6e7x9g0FgZ+ne2qrc4G7yIT25R15
         6HhVjm2sJiZrz20ziTN4nqNU18iuHihwVX5TKQ178wBA0tvKozjRdjq8A0tlBWTLxcSc
         N8a54K+ZTDSaMgN0BXTKlAPbFh4oJC3L61mzeyiZ+FFHSgA/oG94Vo6eCxflE5sWfAZI
         7V/bhW77f8vwHSeVGFeQtWccpf+HacfOa818zqdZUSwRBqZ1G1FC7uXfgrCtQz8oRifK
         4SBIteoJXROU/mAE7ftSpbijVh8vwCQrQRxT9bQqm887aWwxE4WSSZJGYxbLGlgnWhE6
         oZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X8VThf45bOLdUfUXFvslCbuQWhXnY7v/1IVWJ78UmWc=;
        b=KN0hDTaoHBJQmO2sBlNvcnEnMTxh4z/cOnf6yFSbUx5bXmQql+CtPWxSoQ0e+mAP7C
         u4E2gwQQMuJcOnTzgohPRn3i1EPNbofYuDHPfXqDOePwLOZoNqRi+zBi6c7xvy5RzPzb
         7CXJPmcY+A2wdzZNZAaGRBEweGt41towHLCh0HPJS0dY9dMTdjo9v6Ak7Ux+Q9RwUJpL
         HmH3unt3csBqiJIJBTaxIRce/66fEtMoaVh2e/jby2LbvustxQoKbwmK7yxpiT0PAd5l
         SMe8VaEI5fTnq2MNQciWJUX+bF4W/Zxixp7sDAXoCsUjJ2yVS5K+42V8kYzBGxALXngY
         nv/w==
X-Gm-Message-State: AOAM531PKxIDO91dBc7I30JjCjvoyxfzgnQ5zgLCDAbTonI1j2n2YFna
        eCQ96KHGDSky+yBnOslAB35kyA==
X-Google-Smtp-Source: ABdhPJwsnSIm5faOVz+o+LFKWRWqc6KG5+Hs2H6dxw0Rc+pGrH7DZ06IL6xsgEWm7DFf3Z9GtLNUfw==
X-Received: by 2002:a2e:7803:: with SMTP id t3mr4611043ljc.213.1607770640749;
        Sat, 12 Dec 2020 02:57:20 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id j2sm490674lfe.213.2020.12.12.02.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 02:57:20 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/5] power: supply: ab8500: Use local helper
Date:   Sat, 12 Dec 2020 11:57:08 +0100
Message-Id: <20201212105712.2727842-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201212105712.2727842-1-linus.walleij@linaro.org>
References: <20201212105712.2727842-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use a local "dev" helper variable to make the probe()
code easier to read in the ab8500 subdrivers.

Drop out-of-memory messages as these should come from the
slab core.

Cc: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_btemp.c   | 37 +++++++++---------
 drivers/power/supply/ab8500_charger.c | 55 +++++++++++++--------------
 drivers/power/supply/ab8500_fg.c      | 39 +++++++++----------
 3 files changed, 64 insertions(+), 67 deletions(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 909f0242bacb..06b4247ebc45 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -999,47 +999,46 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct abx500_bm_data *plat = pdev->dev.platform_data;
 	struct power_supply_config psy_cfg = {};
+	struct device *dev = &pdev->dev;
 	struct ab8500_btemp *di;
 	int irq, i, ret = 0;
 	u8 val;
 
-	di = devm_kzalloc(&pdev->dev, sizeof(*di), GFP_KERNEL);
-	if (!di) {
-		dev_err(&pdev->dev, "%s no mem for ab8500_btemp\n", __func__);
+	di = devm_kzalloc(dev, sizeof(*di), GFP_KERNEL);
+	if (!di)
 		return -ENOMEM;
-	}
 
 	if (!plat) {
-		dev_err(&pdev->dev, "no battery management data supplied\n");
+		dev_err(dev, "no battery management data supplied\n");
 		return -EINVAL;
 	}
 	di->bm = plat;
 
 	if (np) {
-		ret = ab8500_bm_of_probe(&pdev->dev, np, di->bm);
+		ret = ab8500_bm_of_probe(dev, np, di->bm);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to get battery information\n");
+			dev_err(dev, "failed to get battery information\n");
 			return ret;
 		}
 	}
 
 	/* get parent data */
-	di->dev = &pdev->dev;
+	di->dev = dev;
 	di->parent = dev_get_drvdata(pdev->dev.parent);
 
 	/* Get ADC channels */
-	di->btemp_ball = devm_iio_channel_get(&pdev->dev, "btemp_ball");
+	di->btemp_ball = devm_iio_channel_get(dev, "btemp_ball");
 	if (IS_ERR(di->btemp_ball)) {
 		if (PTR_ERR(di->btemp_ball) == -ENODEV)
 			return -EPROBE_DEFER;
-		dev_err(&pdev->dev, "failed to get BTEMP BALL ADC channel\n");
+		dev_err(dev, "failed to get BTEMP BALL ADC channel\n");
 		return PTR_ERR(di->btemp_ball);
 	}
-	di->bat_ctrl = devm_iio_channel_get(&pdev->dev, "bat_ctrl");
+	di->bat_ctrl = devm_iio_channel_get(dev, "bat_ctrl");
 	if (IS_ERR(di->bat_ctrl)) {
 		if (PTR_ERR(di->bat_ctrl) == -ENODEV)
 			return -EPROBE_DEFER;
-		dev_err(&pdev->dev, "failed to get BAT CTRL ADC channel\n");
+		dev_err(dev, "failed to get BAT CTRL ADC channel\n");
 		return PTR_ERR(di->bat_ctrl);
 	}
 
@@ -1053,7 +1052,7 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
 	di->btemp_wq =
 		alloc_workqueue("ab8500_btemp_wq", WQ_MEM_RECLAIM, 0);
 	if (di->btemp_wq == NULL) {
-		dev_err(di->dev, "failed to create work queue\n");
+		dev_err(dev, "failed to create work queue\n");
 		return -ENOMEM;
 	}
 
@@ -1065,10 +1064,10 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
 	di->btemp_ranges.btemp_low_limit = BTEMP_THERMAL_LOW_LIMIT;
 	di->btemp_ranges.btemp_med_limit = BTEMP_THERMAL_MED_LIMIT;
 
-	ret = abx500_get_register_interruptible(di->dev, AB8500_CHARGER,
+	ret = abx500_get_register_interruptible(dev, AB8500_CHARGER,
 		AB8500_BTEMP_HIGH_TH, &val);
 	if (ret < 0) {
-		dev_err(di->dev, "%s ab8500 read failed\n", __func__);
+		dev_err(dev, "%s ab8500 read failed\n", __func__);
 		goto free_btemp_wq;
 	}
 	switch (val) {
@@ -1088,10 +1087,10 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
 	}
 
 	/* Register BTEMP power supply class */
-	di->btemp_psy = power_supply_register(di->dev, &ab8500_btemp_desc,
+	di->btemp_psy = power_supply_register(dev, &ab8500_btemp_desc,
 					      &psy_cfg);
 	if (IS_ERR(di->btemp_psy)) {
-		dev_err(di->dev, "failed to register BTEMP psy\n");
+		dev_err(dev, "failed to register BTEMP psy\n");
 		ret = PTR_ERR(di->btemp_psy);
 		goto free_btemp_wq;
 	}
@@ -1109,11 +1108,11 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
 			ab8500_btemp_irq[i].name, di);
 
 		if (ret) {
-			dev_err(di->dev, "failed to request %s IRQ %d: %d\n"
+			dev_err(dev, "failed to request %s IRQ %d: %d\n"
 				, ab8500_btemp_irq[i].name, irq, ret);
 			goto free_irq;
 		}
-		dev_dbg(di->dev, "Requested %s IRQ %d: %d\n",
+		dev_dbg(dev, "Requested %s IRQ %d: %d\n",
 			ab8500_btemp_irq[i].name, irq, ret);
 	}
 
diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index db65be026920..7e28ac1b171b 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3354,23 +3354,22 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	struct power_supply_config ac_psy_cfg = {}, usb_psy_cfg = {};
 	struct ab8500_charger *di;
 	int irq, i, charger_status, ret = 0, ch_stat;
+	struct device *dev = &pdev->dev;
 
-	di = devm_kzalloc(&pdev->dev, sizeof(*di), GFP_KERNEL);
-	if (!di) {
-		dev_err(&pdev->dev, "%s no mem for ab8500_charger\n", __func__);
+	di = devm_kzalloc(dev, sizeof(*di), GFP_KERNEL);
+	if (!di)
 		return -ENOMEM;
-	}
 
 	if (!plat) {
-		dev_err(&pdev->dev, "no battery management data supplied\n");
+		dev_err(dev, "no battery management data supplied\n");
 		return -EINVAL;
 	}
 	di->bm = plat;
 
 	if (np) {
-		ret = ab8500_bm_of_probe(&pdev->dev, np, di->bm);
+		ret = ab8500_bm_of_probe(dev, np, di->bm);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to get battery information\n");
+			dev_err(dev, "failed to get battery information\n");
 			return ret;
 		}
 		di->autopower_cfg = of_property_read_bool(np, "autopower_cfg");
@@ -3378,39 +3377,39 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 		di->autopower_cfg = false;
 
 	/* get parent data */
-	di->dev = &pdev->dev;
+	di->dev = dev;
 	di->parent = dev_get_drvdata(pdev->dev.parent);
 
 	/* Get ADC channels */
-	di->adc_main_charger_v = devm_iio_channel_get(&pdev->dev,
+	di->adc_main_charger_v = devm_iio_channel_get(dev,
 						      "main_charger_v");
 	if (IS_ERR(di->adc_main_charger_v)) {
 		if (PTR_ERR(di->adc_main_charger_v) == -ENODEV)
 			return -EPROBE_DEFER;
-		dev_err(&pdev->dev, "failed to get ADC main charger voltage\n");
+		dev_err(dev, "failed to get ADC main charger voltage\n");
 		return PTR_ERR(di->adc_main_charger_v);
 	}
-	di->adc_main_charger_c = devm_iio_channel_get(&pdev->dev,
+	di->adc_main_charger_c = devm_iio_channel_get(dev,
 						      "main_charger_c");
 	if (IS_ERR(di->adc_main_charger_c)) {
 		if (PTR_ERR(di->adc_main_charger_c) == -ENODEV)
 			return -EPROBE_DEFER;
-		dev_err(&pdev->dev, "failed to get ADC main charger current\n");
+		dev_err(dev, "failed to get ADC main charger current\n");
 		return PTR_ERR(di->adc_main_charger_c);
 	}
-	di->adc_vbus_v = devm_iio_channel_get(&pdev->dev, "vbus_v");
+	di->adc_vbus_v = devm_iio_channel_get(dev, "vbus_v");
 	if (IS_ERR(di->adc_vbus_v)) {
 		if (PTR_ERR(di->adc_vbus_v) == -ENODEV)
 			return -EPROBE_DEFER;
-		dev_err(&pdev->dev, "failed to get ADC USB charger voltage\n");
+		dev_err(dev, "failed to get ADC USB charger voltage\n");
 		return PTR_ERR(di->adc_vbus_v);
 	}
-	di->adc_usb_charger_c = devm_iio_channel_get(&pdev->dev,
+	di->adc_usb_charger_c = devm_iio_channel_get(dev,
 						     "usb_charger_c");
 	if (IS_ERR(di->adc_usb_charger_c)) {
 		if (PTR_ERR(di->adc_usb_charger_c) == -ENODEV)
 			return -EPROBE_DEFER;
-		dev_err(&pdev->dev, "failed to get ADC USB charger current\n");
+		dev_err(dev, "failed to get ADC USB charger current\n");
 		return PTR_ERR(di->adc_usb_charger_c);
 	}
 
@@ -3467,7 +3466,7 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	di->charger_wq = alloc_ordered_workqueue("ab8500_charger_wq",
 						 WQ_MEM_RECLAIM);
 	if (di->charger_wq == NULL) {
-		dev_err(di->dev, "failed to create work queue\n");
+		dev_err(dev, "failed to create work queue\n");
 		return -ENOMEM;
 	}
 
@@ -3526,10 +3525,10 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	 * is a charger connected to avoid erroneous BTEMP_HIGH/LOW
 	 * interrupts during charging
 	 */
-	di->regu = devm_regulator_get(di->dev, "vddadc");
+	di->regu = devm_regulator_get(dev, "vddadc");
 	if (IS_ERR(di->regu)) {
 		ret = PTR_ERR(di->regu);
-		dev_err(di->dev, "failed to get vddadc regulator\n");
+		dev_err(dev, "failed to get vddadc regulator\n");
 		goto free_charger_wq;
 	}
 
@@ -3537,17 +3536,17 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	/* Initialize OVV, and other registers */
 	ret = ab8500_charger_init_hw_registers(di);
 	if (ret) {
-		dev_err(di->dev, "failed to initialize ABB registers\n");
+		dev_err(dev, "failed to initialize ABB registers\n");
 		goto free_charger_wq;
 	}
 
 	/* Register AC charger class */
 	if (di->ac_chg.enabled) {
-		di->ac_chg.psy = power_supply_register(di->dev,
+		di->ac_chg.psy = power_supply_register(dev,
 						       &ab8500_ac_chg_desc,
 						       &ac_psy_cfg);
 		if (IS_ERR(di->ac_chg.psy)) {
-			dev_err(di->dev, "failed to register AC charger\n");
+			dev_err(dev, "failed to register AC charger\n");
 			ret = PTR_ERR(di->ac_chg.psy);
 			goto free_charger_wq;
 		}
@@ -3555,11 +3554,11 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 
 	/* Register USB charger class */
 	if (di->usb_chg.enabled) {
-		di->usb_chg.psy = power_supply_register(di->dev,
+		di->usb_chg.psy = power_supply_register(dev,
 							&ab8500_usb_chg_desc,
 							&usb_psy_cfg);
 		if (IS_ERR(di->usb_chg.psy)) {
-			dev_err(di->dev, "failed to register USB charger\n");
+			dev_err(dev, "failed to register USB charger\n");
 			ret = PTR_ERR(di->usb_chg.psy);
 			goto free_ac;
 		}
@@ -3567,14 +3566,14 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 
 	di->usb_phy = usb_get_phy(USB_PHY_TYPE_USB2);
 	if (IS_ERR_OR_NULL(di->usb_phy)) {
-		dev_err(di->dev, "failed to get usb transceiver\n");
+		dev_err(dev, "failed to get usb transceiver\n");
 		ret = -EINVAL;
 		goto free_usb;
 	}
 	di->nb.notifier_call = ab8500_charger_usb_notifier_call;
 	ret = usb_register_notifier(di->usb_phy, &di->nb);
 	if (ret) {
-		dev_err(di->dev, "failed to register usb notifier\n");
+		dev_err(dev, "failed to register usb notifier\n");
 		goto put_usb_phy;
 	}
 
@@ -3607,11 +3606,11 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 			ab8500_charger_irq[i].name, di);
 
 		if (ret != 0) {
-			dev_err(di->dev, "failed to request %s IRQ %d: %d\n"
+			dev_err(dev, "failed to request %s IRQ %d: %d\n"
 				, ab8500_charger_irq[i].name, irq, ret);
 			goto free_irq;
 		}
-		dev_dbg(di->dev, "Requested %s IRQ %d: %d\n",
+		dev_dbg(dev, "Requested %s IRQ %d: %d\n",
 			ab8500_charger_irq[i].name, irq, ret);
 	}
 
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 592a73d4dde6..56997353c175 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3037,26 +3037,25 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct abx500_bm_data *plat = pdev->dev.platform_data;
 	struct power_supply_config psy_cfg = {};
+	struct device *dev = &pdev->dev;
 	struct ab8500_fg *di;
 	int i, irq;
 	int ret = 0;
 
-	di = devm_kzalloc(&pdev->dev, sizeof(*di), GFP_KERNEL);
-	if (!di) {
-		dev_err(&pdev->dev, "%s no mem for ab8500_fg\n", __func__);
+	di = devm_kzalloc(dev, sizeof(*di), GFP_KERNEL);
+	if (!di)
 		return -ENOMEM;
-	}
 
 	if (!plat) {
-		dev_err(&pdev->dev, "no battery management data supplied\n");
+		dev_err(dev, "no battery management data supplied\n");
 		return -EINVAL;
 	}
 	di->bm = plat;
 
 	if (np) {
-		ret = ab8500_bm_of_probe(&pdev->dev, np, di->bm);
+		ret = ab8500_bm_of_probe(dev, np, di->bm);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to get battery information\n");
+			dev_err(dev, "failed to get battery information\n");
 			return ret;
 		}
 	}
@@ -3064,14 +3063,14 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	mutex_init(&di->cc_lock);
 
 	/* get parent data */
-	di->dev = &pdev->dev;
+	di->dev = dev;
 	di->parent = dev_get_drvdata(pdev->dev.parent);
 
-	di->main_bat_v = devm_iio_channel_get(&pdev->dev, "main_bat_v");
+	di->main_bat_v = devm_iio_channel_get(dev, "main_bat_v");
 	if (IS_ERR(di->main_bat_v)) {
 		if (PTR_ERR(di->main_bat_v) == -ENODEV)
 			return -EPROBE_DEFER;
-		dev_err(&pdev->dev, "failed to get main battery ADC channel\n");
+		dev_err(dev, "failed to get main battery ADC channel\n");
 		return PTR_ERR(di->main_bat_v);
 	}
 
@@ -3094,7 +3093,7 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	/* Create a work queue for running the FG algorithm */
 	di->fg_wq = alloc_ordered_workqueue("ab8500_fg_wq", WQ_MEM_RECLAIM);
 	if (di->fg_wq == NULL) {
-		dev_err(di->dev, "failed to create work queue\n");
+		dev_err(dev, "failed to create work queue\n");
 		return -ENOMEM;
 	}
 
@@ -3129,7 +3128,7 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	/* Initialize OVV, and other registers */
 	ret = ab8500_fg_init_hw_registers(di);
 	if (ret) {
-		dev_err(di->dev, "failed to initialize registers\n");
+		dev_err(dev, "failed to initialize registers\n");
 		goto free_inst_curr_wq;
 	}
 
@@ -3138,9 +3137,9 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	di->flags.batt_id_received = false;
 
 	/* Register FG power supply class */
-	di->fg_psy = power_supply_register(di->dev, &ab8500_fg_desc, &psy_cfg);
+	di->fg_psy = power_supply_register(dev, &ab8500_fg_desc, &psy_cfg);
 	if (IS_ERR(di->fg_psy)) {
-		dev_err(di->dev, "failed to register FG psy\n");
+		dev_err(dev, "failed to register FG psy\n");
 		ret = PTR_ERR(di->fg_psy);
 		goto free_inst_curr_wq;
 	}
@@ -3168,11 +3167,11 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 				  ab8500_fg_irq_th[i].name, di);
 
 		if (ret != 0) {
-			dev_err(di->dev, "failed to request %s IRQ %d: %d\n",
+			dev_err(dev, "failed to request %s IRQ %d: %d\n",
 				ab8500_fg_irq_th[i].name, irq, ret);
 			goto free_irq_th;
 		}
-		dev_dbg(di->dev, "Requested %s IRQ %d: %d\n",
+		dev_dbg(dev, "Requested %s IRQ %d: %d\n",
 			ab8500_fg_irq_th[i].name, irq, ret);
 	}
 
@@ -3188,11 +3187,11 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 			ab8500_fg_irq_bh[0].name, di);
 
 	if (ret != 0) {
-		dev_err(di->dev, "failed to request %s IRQ %d: %d\n",
+		dev_err(dev, "failed to request %s IRQ %d: %d\n",
 			ab8500_fg_irq_bh[0].name, irq, ret);
 		goto free_irq_th;
 	}
-	dev_dbg(di->dev, "Requested %s IRQ %d: %d\n",
+	dev_dbg(dev, "Requested %s IRQ %d: %d\n",
 		ab8500_fg_irq_bh[0].name, irq, ret);
 
 	di->irq = platform_get_irq_byname(pdev, "CCEOC");
@@ -3203,13 +3202,13 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 
 	ret = ab8500_fg_sysfs_init(di);
 	if (ret) {
-		dev_err(di->dev, "failed to create sysfs entry\n");
+		dev_err(dev, "failed to create sysfs entry\n");
 		goto free_irq;
 	}
 
 	ret = ab8500_fg_sysfs_psy_create_attrs(di);
 	if (ret) {
-		dev_err(di->dev, "failed to create FG psy\n");
+		dev_err(dev, "failed to create FG psy\n");
 		ab8500_fg_sysfs_exit(di);
 		goto free_irq;
 	}
-- 
2.26.2

