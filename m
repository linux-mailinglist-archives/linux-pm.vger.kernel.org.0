Return-Path: <linux-pm+bounces-17288-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DB29C3464
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2024 20:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7251C21397
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2024 19:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9156155C9E;
	Sun, 10 Nov 2024 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHhaP79e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073BD155325;
	Sun, 10 Nov 2024 19:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731266674; cv=none; b=DcRXwB2DqZ3RsppWsmy8UAdhXNqTZzQyEwMog12054AXMlLyaJh63sGDJQUlcbjFLDcMtdRQumLER6nRkXKRtHKDBa2vpxo7WgWdRYDO1HwU9LHhBdfkVSiSp34DXoANFVfOP3fYLTK7z9H+bCAtv64gdoeN3k6QsweIw1z3d7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731266674; c=relaxed/simple;
	bh=U4A1URsY+DSB9fqZhsXbXU4iN6/BssEpg8gHHdYuWhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FLKgIbDMwqElIM9F+DdU7hg8Ey95jNficMLrl7yBaLTZedAhtdgBhIow3w/X6uIgubFH5OdPFUBc+RGJDJV8PgJ6yXB5Rj5W4E3A75LXPoFXwKAzwgUeMpbJuxNOaR1CnUarUEEpddcVgFxB3aUqQDaHI1/pkG5IgWKE/NQIu8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHhaP79e; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a99f646ff1bso595165166b.2;
        Sun, 10 Nov 2024 11:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731266671; x=1731871471; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzjTpF4vcCvC+88m4NTYCvpBKv5iwpeXsY67V7asRZs=;
        b=HHhaP79eLvp/+H5nqvVLvH8kqt2mE0wHRClVRnaVTd/z9Fdvb1rz3Yqb02z5QpOXGj
         oHOFWYvKcEhkCdxy3GYYHdrnfw495Dm6erxdXKbmFpU9Cm7UooNdIpXOTzltt9T5Oo66
         /3zfpl9lBnKDlxftfYz6qG5FewNOaaPr15b/qq9+3KAwg/abff/kiFdH8xCdfBWNhuEW
         eKDbpR9sd7wzUDu4wSqlcNSZz1HShIZHVf2vz2NuaZrNzxGVhXaWGjLcvjd7XX7F0xbI
         vaQBg+wT1HuGTPAYGls/j+0crGD/MTSGEF4KouKp7U2DeXXZDkDTA3Hr1oBjwbBveViN
         EAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731266671; x=1731871471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzjTpF4vcCvC+88m4NTYCvpBKv5iwpeXsY67V7asRZs=;
        b=KJMSEP5dHxwdBZ0BIrLDIc3BCCLRFAvqxuN9/8V3RE240s/Ct0pT3EoE/EwukROk9q
         /3xaTy9C6g4DazNAa+mLbmK8GW7S/eMq+aV/luZnG/EeTgMK2ZzA97vee8JvHabDmsCu
         YZpSYJocx3KENQY8hpqLrSFYr5EScErnM0O4Gc2yglfBN3DfPmPTcZAX40G15LtleFdj
         akBLZ7dVxcrltjDT3agQD1UBc8cnhUgBWLNWzZvTP31kW1dFmYobcfqQ2OiP1QTAOPo0
         yxLg6qzF9QO6muo7f54lb8xG5xgFUxYls7tYSJ57u22pRjy5XkNyCkNLjRYvpWdRH3Lf
         Ta+w==
X-Forwarded-Encrypted: i=1; AJvYcCUBTtS6yKf68j85YvNLhGYMOlssBXpKE6Hr5ijwv8CQF+o/ObpnPluylc5+mM+RPEvdL7DjozCTH9YC7RNq@vger.kernel.org, AJvYcCWPjQbRWeMsjbZbxF0j1Ugt375ITSfo3z9KGwD3/hx98dreKHf0Co5nmBdSO7YRmtcvDN+JLHcjql4j@vger.kernel.org, AJvYcCWZ4ZpB46gBzHiuHMrR90HCsJJnMV3Zo1tTzBmAELFcvM2wwmP+MqAvmDnapa0tcx+6D6qR3kTpGueNy9FID3qrcys=@vger.kernel.org, AJvYcCXlO/hMZiWJVYpLkvZiwiychsh7ZhEjk7QdfYE9b7bnptUO0wYZGrZwgTnMLstdYlM/l9RhyVmpXhuBDYMK3g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7unFqiPFS8pHrjVLXb5KZ4kz7Ud+NZGBr08JTUKWdhGTBBJxb
	MmKmiaDPabIVZnwwi9jtLWWwfQY1xMN4lbxcpsqRKG1KeIpSHoWI
X-Google-Smtp-Source: AGHT+IFHsrzKAH1JXGqmrjEG47YYUuWxOy0DeShOLNpqUqSJjuxWTT1PZUGZb3HouVX3vdnd7BOhRw==
X-Received: by 2002:a17:907:7f28:b0:a9a:5cf8:9e40 with SMTP id a640c23a62f3a-a9eeff10a14mr923178466b.24.1731266670951;
        Sun, 10 Nov 2024 11:24:30 -0800 (PST)
Received: from [127.0.1.1] (leased-line-46-53-189-50.telecom.by. [46.53.189.50])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9ee0e0fabesm502497666b.174.2024.11.10.11.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 11:24:29 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Sun, 10 Nov 2024 22:24:16 +0300
Subject: [PATCH v2 2/2] power: supply: max17042: add platform driver
 variant
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-b4-max17042-v2-2-f058f7a16bab@gmail.com>
References: <20241108-b4-max17042-v2-0-f058f7a16bab@gmail.com>
In-Reply-To: <20241108-b4-max17042-v2-0-f058f7a16bab@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731266662; l=5546;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=U4A1URsY+DSB9fqZhsXbXU4iN6/BssEpg8gHHdYuWhI=;
 b=swSnXIKrCHvZ5yseK48cwBu0mSP/TUGzwXb8VhRn0lHC1PwRDPUPLDuPb9x3Y5JunOH2lOS9s
 2asjCJJ555aCA3CYUHrWF0g0UhPt+3BUGGw3zNgbvGaWX3mirK5TGs9
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
 drivers/power/supply/max17042_battery.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 83 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 99bf6915aa23..e78c177802db 100644
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
@@ -1029,13 +1030,12 @@ static const struct power_supply_desc max17042_no_current_sense_psy_desc = {
 	.num_properties	= ARRAY_SIZE(max17042_battery_props) - 2,
 };
 
-static int max17042_probe(struct i2c_client *client)
+static int max17042_probe(struct i2c_client *client, enum max170xx_chip_type chip_type)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	pr_info("do probe!\n");
 	struct i2c_adapter *adapter = client->adapter;
 	const struct power_supply_desc *max17042_desc = &max17042_psy_desc;
 	struct power_supply_config psy_cfg = {};
-	const struct acpi_device_id *acpi_id = NULL;
 	struct device *dev = &client->dev;
 	struct max17042_chip *chip;
 	int ret;
@@ -1050,15 +1050,6 @@ static int max17042_probe(struct i2c_client *client)
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
 	chip->regmap = devm_regmap_init_i2c(client, &max17042_regmap_config);
 	if (IS_ERR(chip->regmap)) {
 		dev_err(&client->dev, "Failed to initialize regmap\n");
@@ -1139,6 +1130,40 @@ static int max17042_probe(struct i2c_client *client)
 	return 0;
 }
 
+static int max17042_i2c_probe(struct i2c_client *client)
+{
+	pr_info("i2c probe!\n");
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
+	return max17042_probe(client, chip_type);
+}
+
+
+static int max17042_platform_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct i2c_client *i2c = dev_get_platdata(dev);
+	const struct platform_device_id *id = platform_get_device_id(pdev);
+
+	if (!i2c)
+		return -EINVAL;
+
+	return max17042_probe(i2c, id->driver_data);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int max17042_suspend(struct device *dev)
 {
@@ -1204,6 +1229,16 @@ static const struct i2c_device_id max17042_id[] = {
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
@@ -1211,10 +1246,44 @@ static struct i2c_driver max17042_i2c_driver = {
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
+static int __init __driver_max17042_platform_init(void)
+{
+	int ret = 0;
+
+	ret = platform_driver_register(&max17042_platform_driver);
+
+	if (ret) {
+		platform_driver_unregister(&max17042_platform_driver);
+		return ret;
+	}
+
+	ret = i2c_add_driver(&max17042_i2c_driver);
+
+	return ret;
+}
+module_init(__driver_max17042_platform_init);
+
+static void __exit __driver_max17042_platform_exit(void)
+{
+	i2c_del_driver(&max17042_i2c_driver);
+	platform_driver_unregister(&max17042_platform_driver);
+}
+module_exit(__driver_max17042_platform_exit);
 
 MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
 MODULE_DESCRIPTION("MAX17042 Fuel Gauge");

-- 
2.39.2


