Return-Path: <linux-pm+bounces-18227-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C4D9DC124
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 10:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED032B21375
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 09:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31236189F3B;
	Fri, 29 Nov 2024 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMKZLjJ/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F62D184542;
	Fri, 29 Nov 2024 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732871415; cv=none; b=OCfdDre5S/l6kfMA1di3vyaCRWcHXSuv98jDuIssW1gc1FKabvTrxvZ8ENMl8XlOukv86f+fcX7NPHNQ1XCVQV+PpAmG2ItXAhNo4RkSrOM++ivYLkqgJUKmU/g9+hi9QlpoPcdT51At8K3YuxlxKXRnaQp3HwmTQ0SEZhpOCCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732871415; c=relaxed/simple;
	bh=Xoh0dNQvawf15vqypI6tnCITiCXreyWsfUHe7gs4T+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ackqSbELSSLnScMFcllv2VFw8C9nMm37QtApR+gu5fEcvsWCIssPfzkSLp4UI89SMMkSUR8lVVJk8MGVNRTMyc2TM3iXzHWdYcUbz8UA8f5RBSDcRMlJ+Vj8Bva9aYlMimu1xnnEypeH1hTmoR0/1n0/8OnCzKW6GvrrugOQIMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMKZLjJ/; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa51b8c5f4dso214379266b.2;
        Fri, 29 Nov 2024 01:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732871411; x=1733476211; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7qffHUQjyaEfcz46tUr2RiKjchrW1y0UWEygxoizXJc=;
        b=kMKZLjJ/YUaZMYv/YZMFszXwnCEk8kz2xQ1QC17tbeCnN23zveHBD5Smlj3tk9o3hI
         XkGewzQwDalAxVjDTH2gI7uNoMW3c+5DINhah7UuL8iH2Hk4dLCywoiMzOA2gGbT9Kvj
         0sn7vI96KEirhsykyoQpfPk6IoUGz4YrlvFQ+v6AEWTxEkwuUDf3DmDJY28IrrDhHrZQ
         NMO6JZg3q8IK9ka01DflNdkZ980H5aPs+vI6VnniFR2A7EPWD9GABlnb/ItZeclvwk8X
         LVei5N670OjVO9RPCl6PQpKa5CkFHoxGMe+Hwz9ORQ3Wlod6cKrQZL3xX+zYNctlqO7n
         0njQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732871411; x=1733476211;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qffHUQjyaEfcz46tUr2RiKjchrW1y0UWEygxoizXJc=;
        b=QlQvq3SQVwx6vbsCF5/Fn/wHbm4Azrv838yOTRtDongUiH6zESSlJlT9SC0BwPwx+c
         AQW/3GQukaBiBIR6Gn0qyfoHsivrzKlAe1eskjULCw9L57NJueRhdtlnTrRvL74gTYTY
         Qc6F4smV1+eh4j2e4b9Kr7yjZTTBhXLVyUJmCOgPtmSNUTzO/MJQQMs/P/4HLRqiHEme
         IKxopXYFsOWqXbVH9dLScG80aogZ+gS7EHtcCRMZ5TRZfjhTJBDuVTAH20z4TMGlv5qz
         zC9XPUELS1X/ooY2qhT3mfmPFRmmICWh6GOKc9dOI16VZzZvW2kj3+dJbGYHTzPbNgJi
         OrGg==
X-Forwarded-Encrypted: i=1; AJvYcCUbQyC08tp9JiQO0+GfJHFW6UTw5eMCpumlui+kC5Rs0AnrSc3XsxMW7VJ3Y8/XQ0TcqEhzldDhgYiW3ncsgg==@vger.kernel.org, AJvYcCW7Y5/zG9DqxDDnKPVb8PDfN1nHKvbr6JzxjdqdpmQCtMEv1sDF955QecdCNT1l9euRgVGQUdZDXAWbOw7X@vger.kernel.org, AJvYcCXAL68yu2DZ8MzjuXaZC2qqPe35+G7s36ivCVkSa0rn68SFhongv9bYpbV6ZMlFeLmdmKsV7zBM7lvf@vger.kernel.org, AJvYcCXusXRRfwbKe6igWPziFAkCdAkMRAR1gJG9Fko/XmvPD9VQ5DE9rV/O/eWtXd/4vD5rSuRWbC2D/8dQN8fxqwHZ55I=@vger.kernel.org
X-Gm-Message-State: AOJu0YybEzhG9SLXkkezbXzlz740A12WRTIj4KvBhrqBAqfTcJfUM3jT
	rJi+elgcBExjUlaZMxb2KRkIV5eBzJv2ATbJkKRHAcBVIdGMwPhI
X-Gm-Gg: ASbGncvtYa9buG6PttrSBoLFt17Yz1hsfCyMIUfBtVqXRRqcZw+Fnjgts2PrJ7y6Wii
	p/TK4uUnArbi48rmCNS9o4v53iSNFB9UFKz2j+0Sy7Zvnu+aMNBRPl1wS+FryDjqRjQpSZarkTn
	ixS2h+DhNhQvGv8HX6VNQ6F6QkV9OHV2lrLcoQWG+pQY4T4d0yzYOWYo3NnF2TmzZTWbso1BdJf
	dNhKWKDs7LhB1iYFYtN2598xvQHWZXMf+ZRDFgyoYXO1X43
X-Google-Smtp-Source: AGHT+IF+8+7FD9JQHKcuuWDIftygodt95fHqaAV5VkuYytwoGIvRmqVc52WAavSmAZ/di3Xb4CIspA==
X-Received: by 2002:a17:906:2189:b0:a99:4e35:9a25 with SMTP id a640c23a62f3a-aa5810295damr813757766b.44.1732871410553;
        Fri, 29 Nov 2024 01:10:10 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa5999032c1sm152775766b.133.2024.11.29.01.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 01:10:10 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 29 Nov 2024 12:09:54 +0300
Subject: [PATCH v4 2/2] power: supply: max17042: add platform driver
 variant
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-b4-max17042-v4-2-87c6d99b3d3d@gmail.com>
References: <20241108-b4-max17042-v4-0-87c6d99b3d3d@gmail.com>
In-Reply-To: <20241108-b4-max17042-v4-0-87c6d99b3d3d@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732871405; l=7965;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=Xoh0dNQvawf15vqypI6tnCITiCXreyWsfUHe7gs4T+I=;
 b=2kmNGWiDEP+cyNDTfytwY6c+N/rqi8tH2ZqGbskBd8Cx+UwTEPNv4T8pD/mWaNOpfxQBMEwPG
 Y84fW5qRo/qBq1P7HqBlnLmNaIdph/ff0iEFrgAxVxh0aEiUT+EK0dX
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Maxim PMICs may include fuel gauge with additional features, which is
out of single Linux power supply driver scope.

For example, in max77705 PMIC fuelgauge has additional registers,
like IIN_REG, VSYS_REG, ISYS_REG. Those needed to measure PMIC input
current, system voltage and current respectively. Those measurements
cannot be bound to any of fuelgauge properties.

The solution here add and option to use max17042 driver as a MFD
sub device, thus allowing any additional functionality be implemented as
another sub device. This will help to reduce code duplication in MFD
fuel gauge drivers.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v4:
- rename module_init and module_exit fuctions
- rework max17042_init
- assign chip_type in probe function
- pass i2c_client as pointer on pointer, to use same pointer created in
  MFD. This allows devm_regmap_init_i2c to cleanup gracefully.

Changes in v3:
- pass dev pointer in max17042_probe
- remove prints
---
 drivers/power/supply/max17042_battery.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 92 insertions(+), 24 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 99bf6915aa23..6a1bfc4a7b13 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -16,6 +16,7 @@
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/mod_devicetable.h>
 #include <linux/power_supply.h>
@@ -1029,14 +1030,12 @@ static const struct power_supply_desc max17042_no_current_sense_psy_desc = {
 	.num_properties	= ARRAY_SIZE(max17042_battery_props) - 2,
 };
 
-static int max17042_probe(struct i2c_client *client)
+static int max17042_probe(struct i2c_client *client, struct device *dev,
+			  enum max170xx_chip_type chip_type)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct i2c_adapter *adapter = client->adapter;
 	const struct power_supply_desc *max17042_desc = &max17042_psy_desc;
 	struct power_supply_config psy_cfg = {};
-	const struct acpi_device_id *acpi_id = NULL;
-	struct device *dev = &client->dev;
 	struct max17042_chip *chip;
 	int ret;
 	int i;
@@ -1045,33 +1044,25 @@ static int max17042_probe(struct i2c_client *client)
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA))
 		return -EIO;
 
-	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
 	chip->client = client;
-	if (id) {
-		chip->chip_type = id->driver_data;
-	} else {
-		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
-		if (!acpi_id)
-			return -ENODEV;
-
-		chip->chip_type = acpi_id->driver_data;
-	}
+	chip->chip_type = chip_type;
 	chip->regmap = devm_regmap_init_i2c(client, &max17042_regmap_config);
 	if (IS_ERR(chip->regmap)) {
-		dev_err(&client->dev, "Failed to initialize regmap\n");
+		dev_err(dev, "Failed to initialize regmap\n");
 		return -EINVAL;
 	}
 
 	chip->pdata = max17042_get_pdata(chip);
 	if (!chip->pdata) {
-		dev_err(&client->dev, "no platform data provided\n");
+		dev_err(dev, "no platform data provided\n");
 		return -EINVAL;
 	}
 
-	i2c_set_clientdata(client, chip);
+	dev_set_drvdata(dev, chip);
 	psy_cfg.drv_data = chip;
 	psy_cfg.of_node = dev->of_node;
 
@@ -1095,17 +1086,17 @@ static int max17042_probe(struct i2c_client *client)
 		regmap_write(chip->regmap, MAX17042_LearnCFG, 0x0007);
 	}
 
-	chip->battery = devm_power_supply_register(&client->dev, max17042_desc,
+	chip->battery = devm_power_supply_register(dev, max17042_desc,
 						   &psy_cfg);
 	if (IS_ERR(chip->battery)) {
-		dev_err(&client->dev, "failed: power supply register\n");
+		dev_err(dev, "failed: power supply register\n");
 		return PTR_ERR(chip->battery);
 	}
 
 	if (client->irq) {
 		unsigned int flags = IRQF_ONESHOT | IRQF_SHARED | IRQF_PROBE_SHARED;
 
-		ret = devm_request_threaded_irq(&client->dev, client->irq,
+		ret = devm_request_threaded_irq(dev, client->irq,
 						NULL,
 						max17042_thread_handler, flags,
 						chip->battery->desc->name,
@@ -1118,7 +1109,7 @@ static int max17042_probe(struct i2c_client *client)
 		} else {
 			client->irq = 0;
 			if (ret != -EBUSY)
-				dev_err(&client->dev, "Failed to get IRQ\n");
+				dev_err(dev, "Failed to get IRQ\n");
 		}
 	}
 	/* Not able to update the charge threshold when exceeded? -> disable */
@@ -1127,7 +1118,7 @@ static int max17042_probe(struct i2c_client *client)
 
 	regmap_read(chip->regmap, MAX17042_STATUS, &val);
 	if (val & STATUS_POR_BIT) {
-		ret = devm_work_autocancel(&client->dev, &chip->work,
+		ret = devm_work_autocancel(dev, &chip->work,
 					   max17042_init_worker);
 		if (ret)
 			return ret;
@@ -1139,6 +1130,38 @@ static int max17042_probe(struct i2c_client *client)
 	return 0;
 }
 
+static int max17042_i2c_probe(struct i2c_client *client)
+{
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	const struct acpi_device_id *acpi_id = NULL;
+	struct device *dev = &client->dev;
+	enum max170xx_chip_type chip_type;
+
+	if (id) {
+		chip_type = id->driver_data;
+	} else {
+		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
+		if (!acpi_id)
+			return -ENODEV;
+
+		chip_type = acpi_id->driver_data;
+	}
+
+	return max17042_probe(client, dev, chip_type);
+}
+
+static int max17042_platform_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct i2c_client **i2c = dev_get_platdata(dev);
+	const struct platform_device_id *id = platform_get_device_id(pdev);
+
+	if (!i2c)
+		return -EINVAL;
+
+	return max17042_probe(*i2c, dev, id->driver_data);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int max17042_suspend(struct device *dev)
 {
@@ -1204,6 +1227,16 @@ static const struct i2c_device_id max17042_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, max17042_id);
 
+static const struct platform_device_id max17042_platform_id[] = {
+	{ "max17042", MAXIM_DEVICE_TYPE_MAX17042 },
+	{ "max17047", MAXIM_DEVICE_TYPE_MAX17047 },
+	{ "max17050", MAXIM_DEVICE_TYPE_MAX17050 },
+	{ "max17055", MAXIM_DEVICE_TYPE_MAX17055 },
+	{ "max77849-battery", MAXIM_DEVICE_TYPE_MAX17047 },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, max17042_platform_id);
+
 static struct i2c_driver max17042_i2c_driver = {
 	.driver	= {
 		.name	= "max17042",
@@ -1211,10 +1244,45 @@ static struct i2c_driver max17042_i2c_driver = {
 		.of_match_table = of_match_ptr(max17042_dt_match),
 		.pm	= &max17042_pm_ops,
 	},
-	.probe		= max17042_probe,
+	.probe		= max17042_i2c_probe,
 	.id_table	= max17042_id,
 };
-module_i2c_driver(max17042_i2c_driver);
+
+static struct platform_driver max17042_platform_driver = {
+	.driver	= {
+		.name	= "max17042",
+		.acpi_match_table = ACPI_PTR(max17042_acpi_match),
+		.of_match_table = of_match_ptr(max17042_dt_match),
+		.pm	= &max17042_pm_ops,
+	},
+	.probe		= max17042_platform_probe,
+	.id_table	= max17042_platform_id,
+};
+
+static int __init max17042_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&max17042_platform_driver);
+	if (ret)
+		return ret;
+
+	ret = i2c_add_driver(&max17042_i2c_driver);
+	if (ret) {
+		platform_driver_unregister(&max17042_platform_driver);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(max17042_init);
+
+static void __exit max17042_exit(void)
+{
+	i2c_del_driver(&max17042_i2c_driver);
+	platform_driver_unregister(&max17042_platform_driver);
+}
+module_exit(max17042_exit);
 
 MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
 MODULE_DESCRIPTION("MAX17042 Fuel Gauge");

-- 
2.39.5


