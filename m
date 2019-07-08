Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51DB561E6B
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 14:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfGHMc7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 08:32:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40007 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfGHMc7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jul 2019 08:32:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so7541014pfp.7;
        Mon, 08 Jul 2019 05:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=C46gDCEdVWA7PE5DmuJRnFXdq5VAUrqxIItEhNnGUCE=;
        b=phgfree2DeZ5s/cqczYCpHvxhnyT2Y0/aYepBWKg76sPL6H4DoF6PjeZGW3ER7n16+
         skQCXD7vF/NRCzECOyXGOp8Hsa8VEqVSqczaRLx+eJx5BfF5Ag7OpZLXUzbum3cM3mAi
         QoTxBc/kfPDPBhy4xE9QZUl7ikZo5ExOrvMPfZ/RxMJkyeW/cPl5USbhGBc1ubgyV+qI
         5BSAHkNPc5PYHEEIYPNbpA/svU3PDJgTuEtBICgxUf3JggPyDI9GzCQo2qP4VdDf7p7o
         Kue0AxMpI1W8w0ULHBxGjOWyLzwvngNZ30PBmcz23uGXGC46yfUaNPwuw7+o9XDuhfyU
         lJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C46gDCEdVWA7PE5DmuJRnFXdq5VAUrqxIItEhNnGUCE=;
        b=I6GrJBOAnmkYi87e5IgIhZQQslW99kyEuttYvWVYAh0h9dXBZ+XuSqaxlvtK2u/nWd
         fgMn56lz33h07tCX3I8ow/oDBVgNyUb3n0G4smoNOJMng7UY1BZ2MX3LRXItaXlBqgUt
         kyaCRn8G5v/x3RB34LmxyK0URp7EnA843eLr+vmmXUQdKXEbuF31FKbMLKHuloQJEhca
         o5CKveSEP7uhyo6QiRLLhevNlwqnFTou37+HOH6eKiAXAseDoIjvzwBTRFd0zYUJXZP1
         K5m2rjYN5scHzVTIuovX1ABfyRjHJQxnyRcabDvoBjemW5lK4HrKtMpGfYOH3cCPX5MS
         oGfA==
X-Gm-Message-State: APjAAAUWSrB1dMV0qzO9aq6mOwRIjQb3hKTbogtSQDkB/AVkViTw1OXK
        8lT2JXoHYEXnyUDLTpRvZ0kFo4xrtvI=
X-Google-Smtp-Source: APXvYqyuRcskUUW5YTcw79udTgLkJ/6QNlFR3T+5HznvVabkz4Vj34HXD9mk1YmTvs+tPSrnUo/uMw==
X-Received: by 2002:a65:6401:: with SMTP id a1mr23580780pgv.42.1562589177838;
        Mon, 08 Jul 2019 05:32:57 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id w3sm15929528pgl.31.2019.07.08.05.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 05:32:57 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 03/14] power: supply: sc27xx: Introduce local variable 'struct device *dev'
Date:   Mon,  8 Jul 2019 20:32:51 +0800
Message-Id: <20190708123251.11759-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce local variable 'struct device *dev' and use it instead of
dereferencing it repeatly.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/power/supply/sc27xx_fuel_gauge.c | 47 ++++++++++++++++----------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 24895cc3b41e..9c184d80088b 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -957,81 +957,82 @@ static int sc27xx_fgu_hw_init(struct sc27xx_fgu_data *data)
 
 static int sc27xx_fgu_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct power_supply_config fgu_cfg = { };
 	struct sc27xx_fgu_data *data;
 	int ret, irq;
 
-	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	data->regmap = dev_get_regmap(dev->parent, NULL);
 	if (!data->regmap) {
-		dev_err(&pdev->dev, "failed to get regmap\n");
+		dev_err(dev, "failed to get regmap\n");
 		return -ENODEV;
 	}
 
-	ret = device_property_read_u32(&pdev->dev, "reg", &data->base);
+	ret = device_property_read_u32(dev, "reg", &data->base);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to get fgu address\n");
+		dev_err(dev, "failed to get fgu address\n");
 		return ret;
 	}
 
-	data->channel = devm_iio_channel_get(&pdev->dev, "bat-temp");
+	data->channel = devm_iio_channel_get(dev, "bat-temp");
 	if (IS_ERR(data->channel)) {
-		dev_err(&pdev->dev, "failed to get IIO channel\n");
+		dev_err(dev, "failed to get IIO channel\n");
 		return PTR_ERR(data->channel);
 	}
 
-	data->charge_chan = devm_iio_channel_get(&pdev->dev, "charge-vol");
+	data->charge_chan = devm_iio_channel_get(dev, "charge-vol");
 	if (IS_ERR(data->charge_chan)) {
-		dev_err(&pdev->dev, "failed to get charge IIO channel\n");
+		dev_err(dev, "failed to get charge IIO channel\n");
 		return PTR_ERR(data->charge_chan);
 	}
 
-	data->gpiod = devm_gpiod_get(&pdev->dev, "bat-detect", GPIOD_IN);
+	data->gpiod = devm_gpiod_get(dev, "bat-detect", GPIOD_IN);
 	if (IS_ERR(data->gpiod)) {
-		dev_err(&pdev->dev, "failed to get battery detection GPIO\n");
+		dev_err(dev, "failed to get battery detection GPIO\n");
 		return PTR_ERR(data->gpiod);
 	}
 
 	ret = gpiod_get_value_cansleep(data->gpiod);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to get gpio state\n");
+		dev_err(dev, "failed to get gpio state\n");
 		return ret;
 	}
 
 	data->bat_present = !!ret;
 	mutex_init(&data->lock);
-	data->dev = &pdev->dev;
+	data->dev = dev;
 	platform_set_drvdata(pdev, data);
 
 	fgu_cfg.drv_data = data;
 	fgu_cfg.of_node = np;
-	data->battery = devm_power_supply_register(&pdev->dev, &sc27xx_fgu_desc,
+	data->battery = devm_power_supply_register(dev, &sc27xx_fgu_desc,
 						   &fgu_cfg);
 	if (IS_ERR(data->battery)) {
-		dev_err(&pdev->dev, "failed to register power supply\n");
+		dev_err(dev, "failed to register power supply\n");
 		return PTR_ERR(data->battery);
 	}
 
 	ret = sc27xx_fgu_hw_init(data);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to initialize fgu hardware\n");
+		dev_err(dev, "failed to initialize fgu hardware\n");
 		return ret;
 	}
 
-	ret = devm_add_action(&pdev->dev, sc27xx_fgu_disable, data);
+	ret = devm_add_action(dev, sc27xx_fgu_disable, data);
 	if (ret) {
 		sc27xx_fgu_disable(data);
-		dev_err(&pdev->dev, "failed to add fgu disable action\n");
+		dev_err(dev, "failed to add fgu disable action\n");
 		return ret;
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq resource specified\n");
+		dev_err(dev, "no irq resource specified\n");
 		return irq;
 	}
 
@@ -1046,17 +1047,17 @@ static int sc27xx_fgu_probe(struct platform_device *pdev)
 
 	irq = gpiod_to_irq(data->gpiod);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to translate GPIO to IRQ\n");
+		dev_err(dev, "failed to translate GPIO to IRQ\n");
 		return irq;
 	}
 
-	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+	ret = devm_request_threaded_irq(dev, irq, NULL,
 					sc27xx_fgu_bat_detection,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING |
 					IRQF_TRIGGER_FALLING,
 					pdev->name, data);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to request IRQ\n");
+		dev_err(dev, "failed to request IRQ\n");
 		return ret;
 	}
 
-- 
2.11.0

