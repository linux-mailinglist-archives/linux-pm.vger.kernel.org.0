Return-Path: <linux-pm+bounces-33859-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AACB44244
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 18:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 892AB4E24E4
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 16:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BF72F8BC1;
	Thu,  4 Sep 2025 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnI8KoGf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB5E23D7FF;
	Thu,  4 Sep 2025 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002094; cv=none; b=VTnGWsmdeaPT7jqvWunAIxHLtUOXZJWuJRmBo+jjhQHW+Uuo1vUCRkyT/5FbJi0eS+KbAFaQTcHBjtBFg5JoM0xG8sOakeqkRcnPR5f0Azex7B8eBn6NQn2KDqkgFFtTAJPhnRXA+cYZSf37Uz1FGZ69ArcKrYR/D8iwsNfHHx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002094; c=relaxed/simple;
	bh=C2XbOt+bbxFBfga2SOyKxbgTvmtcRNqwWaRpQkDVNNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2umDJbDbwb+tlzn8v0XGQaMcQaC1WoEwUDCHhHV+L+EBI4Zd8XDj8/vwrzF3Mhb/9muvxNlen3DfNW1cHPmWRtP6CpU0El/0mEFjwUQIKa3pjrYOYa/PUbLjt2mHHZtpb+9x00tVC/DCN2ieTtxBuRxbqeoGdggsYAvnZHIdD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnI8KoGf; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-30cce50dfb4so1092331fac.0;
        Thu, 04 Sep 2025 09:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757002092; x=1757606892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhOBetcxOKcSAIgI9DIpO35A+MFd+EkUvgQtB6ffZw0=;
        b=EnI8KoGfe2sjysL+6DrEaGfWPqp4sQGkkijq493kWZuGEopr1O/7r8kOb8x2RGuYHJ
         3N/NQC0pO83E6Hqy8afIfcWk4z1LMf2IY3oBsPXqff3cZWw5N3bYdQ0jOdosiYW4wl8m
         bjURZADmNFfBQji3wXX6UtpYAUj/jzlTQ7KAHst95ft9vF7UHf5ullU3Ze7S9FGv6PAR
         Nxexivv3Lhf4GPUwjlyVw1G4QISo19nuezpTM2vS5GRamYOylw7nPVBv6OV1eUBF8kyf
         WWEO0FILysvI4vQxsAQMxiK1hhoLFAP35tDn7grYG5EiR2MXIBKdR+PBFvrZHK2jS2rg
         mFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757002092; x=1757606892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhOBetcxOKcSAIgI9DIpO35A+MFd+EkUvgQtB6ffZw0=;
        b=pFPVLGH+igvoIzUm1HaQIO/FMKqED4tIYvh3AlV5zA9ZyHMUi6euksXuMXSgwiXGp7
         INpe6JPQ1D32TSHUC16NOG8v6qO9DqZ/V7JA6PaDcFel6QaI9VKx9LJGTtiOztjWDU7e
         bTQ2+l5NGjyO4KzgbMX1iXIa9eus11/7EtFPvXRtIHqRi1C68RxXpNddLCtwHGKKhRid
         BPNiAawyTifZQREgV8egGv8Opy54nnyulLo8GUq4ksbSwmrsk1GbqlviCt77eEScjT2W
         rM4rnbzBvmXuUmcfSlHr2Ax9xXKGTSHpFnkmPWMQVKll2SPqqK13y9DGbzWR2Ic6x9Aw
         +Ffg==
X-Forwarded-Encrypted: i=1; AJvYcCULjzjY/pA6YLtVL6GLPPwd3+4OinCZgacJxY1UZ8dw0ZgUixQEd5L//oVLa5aT3fXZd5a7AmGqNx7x@vger.kernel.org
X-Gm-Message-State: AOJu0YyI0/63DfsGWUCfXg7wCetYepjXnLjcyPrMwWOhceckMKUECqsB
	W/65YH26LAK13UbFRM+vgJKAmUkaiu7CgnciQgVqDK6x4uLaz52FROC1
X-Gm-Gg: ASbGncuOOZoUm17M448mMUUxBufUh3QfK2e/UkBp73QOfBpdsWPfr8koHjqAhScAABL
	YHKvm6FIzsc60fr7vcAw8AkvjfY2e/AAYCfvePXV8dNMllQxn2dfs1xOIrm1zBcMhao3Hi9lEhg
	zS2dSdMs25n8ziveYKjdV2MB1xYH70/kL4sevBMMyLCR9vWR+ts9V/+/k/X9uDI6A1+pxsWyn30
	K62lpsHsRwYBwQIGdXqAurffefDbFK3EoPwrjzoemuw0EknGzRGwo6u25vBYkuNY5Kyw7wl9Ou0
	sfsjnYs6VxoG9qX3GEFt5E6oX/G9pn47GpCLcWwlqrVHw832hxnO4ZBnn6vtM9Lz4jv+ELvFHVj
	KGAt9NAsT/ra8noR1PqmPdXxexJ7O3g+V2PePZXCBjg==
X-Google-Smtp-Source: AGHT+IFhh49r5hBjfa8WGRyWEsQzLAhA6RXFI8keVI01Ag+BHPTusB0a/vNmHmlsortVxrz0qEOe+w==
X-Received: by 2002:a05:6870:b00a:b0:31d:7214:a48a with SMTP id 586e51a60fabf-31d7214cb5dmr2638639fac.44.1757002091800;
        Thu, 04 Sep 2025 09:08:11 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:c51e:64e3:dc5d:9652])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-319b5fcbf6asm2437593fac.20.2025.09.04.09.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:08:11 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	broonie@kernel.org,
	lee@kernel.org,
	lgirdwood@gmail.com,
	sre@kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v8 4/5] regulator: bq257xx: Add bq257xx boost regulator driver
Date: Thu,  4 Sep 2025 11:05:29 -0500
Message-ID: <20250904160530.66178-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904160530.66178-1-macroalpha82@gmail.com>
References: <20250904160530.66178-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the boost regulator found in the Texas Instruments
BQ25703. The boost regulator is capable of outputting between 4.48
and 20.8 volts and between 0 and 6.35 amps.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig             |   8 ++
 drivers/regulator/Makefile            |   1 +
 drivers/regulator/bq257xx-regulator.c | 186 ++++++++++++++++++++++++++
 3 files changed, 195 insertions(+)
 create mode 100644 drivers/regulator/bq257xx-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index eaa6df1c9f80..60b14472c599 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -297,6 +297,14 @@ config REGULATOR_BD96801
 	  This driver can also be built as a module. If so, the module
 	  will be called bd96801-regulator.
 
+config REGULATOR_BQ257XX
+	tristate "TI BQ257XX regulator family"
+	depends on MFD_BQ257XX
+	depends on GPIOLIB || COMPILE_TEST
+	help
+	  Say Y to enable support for the boost regulator function of
+	  the BQ257XX family of charger circuits.
+
 config REGULATOR_CPCAP
 	tristate "Motorola CPCAP regulator"
 	depends on MFD_CPCAP
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index be98b29d6675..e9ab5945b3c8 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_REGULATOR_BD71828) += bd71828-regulator.o
 obj-$(CONFIG_REGULATOR_BD718XX) += bd718x7-regulator.o
 obj-$(CONFIG_REGULATOR_BD9571MWV) += bd9571mwv-regulator.o
 obj-$(CONFIG_REGULATOR_BD957XMUF) += bd9576-regulator.o
+obj-$(CONFIG_REGULATOR_BQ257XX) += bq257xx-regulator.o
 obj-$(CONFIG_REGULATOR_DA903X)	+= da903x-regulator.o
 obj-$(CONFIG_REGULATOR_BD96801) += bd96801-regulator.o
 obj-$(CONFIG_REGULATOR_DA9052)	+= da9052-regulator.o
diff --git a/drivers/regulator/bq257xx-regulator.c b/drivers/regulator/bq257xx-regulator.c
new file mode 100644
index 000000000000..fc1ccede4468
--- /dev/null
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BQ257XX Battery Charger Driver
+ * Copyright (C) 2025 Chris Morgan <macromorgan@hotmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/mfd/bq257xx.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+struct bq257xx_reg_data {
+	struct bq257xx_device *bq;
+	struct regulator_dev *bq257xx_reg;
+	struct gpio_desc *otg_en_gpio;
+	struct regulator_desc desc;
+};
+
+static int bq25703_vbus_get_cur_limit(struct regulator_dev *rdev)
+{
+	struct bq257xx_reg_data *pdata = rdev_get_drvdata(rdev);
+	int ret;
+	unsigned int reg;
+
+	ret = regmap_read(pdata->bq->regmap, BQ25703_OTG_CURRENT, &reg);
+	if (ret)
+		return ret;
+	return FIELD_GET(BQ25703_OTG_CUR_MASK, reg) * BQ25703_OTG_CUR_STEP_UA;
+}
+
+/*
+ * Check if the minimum current and maximum current requested are
+ * sane values, then set the register accordingly.
+ */
+static int bq25703_vbus_set_cur_limit(struct regulator_dev *rdev,
+				      int min_uA, int max_uA)
+{
+	struct bq257xx_reg_data *pdata = rdev_get_drvdata(rdev);
+	unsigned int reg;
+
+	if ((min_uA > BQ25703_OTG_CUR_MAX_UA) || (max_uA < 0))
+		return -EINVAL;
+
+	reg = (max_uA / BQ25703_OTG_CUR_STEP_UA);
+
+	/* Catch rounding errors since our step is 50000uA. */
+	if ((reg * BQ25703_OTG_CUR_STEP_UA) < min_uA)
+		return -EINVAL;
+
+	return regmap_write(pdata->bq->regmap, BQ25703_OTG_CURRENT,
+			    FIELD_PREP(BQ25703_OTG_CUR_MASK, reg));
+}
+
+static int bq25703_vbus_enable(struct regulator_dev *rdev)
+{
+	struct bq257xx_reg_data *pdata = rdev_get_drvdata(rdev);
+
+	if (pdata->otg_en_gpio)
+		gpiod_set_value_cansleep(pdata->otg_en_gpio, 1);
+	return regulator_enable_regmap(rdev);
+}
+
+static int bq25703_vbus_disable(struct regulator_dev *rdev)
+{
+	struct bq257xx_reg_data *pdata = rdev_get_drvdata(rdev);
+
+	if (pdata->otg_en_gpio)
+		gpiod_set_value_cansleep(pdata->otg_en_gpio, 0);
+	return regulator_disable_regmap(rdev);
+}
+
+static const struct regulator_ops bq25703_vbus_ops = {
+	.enable = bq25703_vbus_enable,
+	.disable = bq25703_vbus_disable,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_current_limit = bq25703_vbus_get_cur_limit,
+	.set_current_limit = bq25703_vbus_set_cur_limit,
+};
+
+static const struct regulator_desc bq25703_vbus_desc = {
+	.name = "vbus",
+	.of_match = of_match_ptr("vbus"),
+	.regulators_node = of_match_ptr("regulators"),
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+	.ops = &bq25703_vbus_ops,
+	.min_uV = BQ25703_OTG_VOLT_MIN_UV,
+	.uV_step = BQ25703_OTG_VOLT_STEP_UV,
+	.n_voltages = BQ25703_OTG_VOLT_NUM_VOLT,
+	.enable_mask = BQ25703_EN_OTG_MASK,
+	.enable_reg = BQ25703_CHARGE_OPTION_3,
+	.enable_val = BQ25703_EN_OTG_MASK,
+	.disable_val = 0,
+	.vsel_reg = BQ25703_OTG_VOLT,
+	.vsel_mask = BQ25703_OTG_VOLT_MASK,
+};
+
+/* Get optional GPIO for OTG regulator enable. */
+static void bq257xx_reg_dt_parse_gpio(struct platform_device *pdev)
+{
+	struct device_node *child, *subchild;
+	struct bq257xx_reg_data *pdata = platform_get_drvdata(pdev);
+
+	child = of_get_child_by_name(pdev->dev.of_node,
+				     pdata->desc.regulators_node);
+	if (!child)
+		return;
+
+	subchild = of_get_child_by_name(child, pdata->desc.of_match);
+	if (!subchild)
+		return;
+
+	of_node_put(child);
+
+	pdata->otg_en_gpio = devm_fwnode_gpiod_get_index(&pdev->dev,
+							 of_fwnode_handle(subchild),
+							 "enable", 0,
+							 GPIOD_OUT_LOW,
+							 pdata->desc.of_match);
+
+	of_node_put(subchild);
+
+	if (IS_ERR(pdata->otg_en_gpio)) {
+		dev_err(&pdev->dev, "Error getting enable gpio: %ld\n",
+			PTR_ERR(pdata->otg_en_gpio));
+		return;
+	}
+}
+
+static int bq257xx_regulator_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct bq257xx_device *bq = dev_get_drvdata(pdev->dev.parent);
+	struct bq257xx_reg_data *pdata;
+	struct device_node *np = dev->of_node;
+	struct regulator_config cfg = {};
+
+	pdev->dev.of_node = pdev->dev.parent->of_node;
+	pdev->dev.of_node_reused = true;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(struct bq257xx_reg_data), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	pdata->bq = bq;
+	pdata->desc = bq25703_vbus_desc;
+
+	platform_set_drvdata(pdev, pdata);
+	bq257xx_reg_dt_parse_gpio(pdev);
+
+	cfg.dev = &pdev->dev;
+	cfg.driver_data = pdata;
+	cfg.of_node = np;
+	cfg.regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!cfg.regmap)
+		return -ENODEV;
+
+	pdata->bq257xx_reg = devm_regulator_register(dev, &pdata->desc, &cfg);
+	if (IS_ERR(pdata->bq257xx_reg)) {
+		return dev_err_probe(&pdev->dev, PTR_ERR(pdata->bq257xx_reg),
+				     "error registering bq257xx regulator");
+	}
+
+	return 0;
+}
+
+static struct platform_driver bq257xx_reg_driver = {
+	.driver = {
+		.name = "bq257xx-regulator",
+	},
+	.probe = bq257xx_regulator_probe,
+};
+
+module_platform_driver(bq257xx_reg_driver);
+
+MODULE_DESCRIPTION("bq257xx regulator driver");
+MODULE_AUTHOR("Chris Morgan <macromorgan@hotmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.43.0


