Return-Path: <linux-pm+bounces-31295-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1966FB0E22C
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 18:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0983B3F51
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 16:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D42827F00E;
	Tue, 22 Jul 2025 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5ST498W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B02527E04B;
	Tue, 22 Jul 2025 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753203042; cv=none; b=dt2bW1CU0Vhv/keyiLO8LyJA9RmSGPMh72kPJbVbK6RI+xQrqb1B4du2rv3hZS72p3GBgU5nhBQhZfO6qstLAiYzfxOgm6KHFY4s8CRRtUw1ZQ9u7/ca37hwBC9qvHXROcBLlMLaI/0xiEPfPQOdYF9H4r2OUWdjImSS7zO3VHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753203042; c=relaxed/simple;
	bh=lC2Vzzh31PTWE+egMmmZMcTnSlQ4w85D6Fhw2GFGh20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwKHd7F5lLmc9KyoIrHiaxBtP0SL6Gtnkezhqi9A6i2miXWIBSy6GP2cmzzOj06Xym8LHT/O8q/zWsoHnpmn1WWSMM2kU27GfP8UBizffNYiX4r80zkZStvGr1n1lzaas1ExeCPQJeTgP3+n02WPFGr+bZCKWpFd1QM+wwE85cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5ST498W; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-73e88bc3891so2308868a34.0;
        Tue, 22 Jul 2025 09:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753203038; x=1753807838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZPBTfZOXzPS61MdSL5Ixc/F2sG8SHfu/6B3T/XWesM=;
        b=S5ST498WnaRUEUnoMwY4nhiYFdqJbO4Z3mEJ5xXsBZDSxchThJZZxjzCYsnbHGOMFf
         Fz9RjhtUr16bgPPncyCgShQ62djCyTP3LqPL29Yr2ik6Ayv3Ja+6heIE3Y47X1LRfNTK
         v0kHzcGQoX4iWwNV0Bv2XWleLJmm7/4C5npcTD/bINYyq2jHCuploQL++VS13LoEf52G
         hC9axXbv62Kn8ehClEvFjKbdJnDL/1ERp0+fdxyU5O6B078gWSRA176xuzfkNr44ixto
         d7KDJaqh5acAhqsk+gecWWLQKinNCrutn40nn7M58ZpJHqzUKJkmANGjM69otyZOEHox
         +bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753203038; x=1753807838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZPBTfZOXzPS61MdSL5Ixc/F2sG8SHfu/6B3T/XWesM=;
        b=F5COSW0lxX+k1PgiNsXcf+jhOwt9iaXdgp1DVGGO84j6NMSfeu/jcpBEjNsZqhmhrN
         crZ3PubZVle+GGtXCA0HHreWDbQWFxs4EnzZi6Hn8XH2PR/v5Koxf5exv4TTiqfFPlM+
         kuhCYBJec7Q4tJtLoL/I1ne6+kn0qu6PW0chxhd9CexAmneI7K5Lku5i5JyWrlF9PH67
         YU25PoO59tN7VdypqUa6wXP4eQlm8rzigXjkZKiNLlIeJC/Q54yiEjFblq9O7Ws4+bBr
         IKQTx5TUjqh+Cyda39RPMbhEXAQtuaHxG4Z1YvN/7NsgFdgKKOMc2jn3Mml5gs4GYVmt
         J/MQ==
X-Forwarded-Encrypted: i=1; AJvYcCV36rW4talKDEwrc09c1xAnLBLGkp9rJbDK4Blsw3SUCOxKLI31mU2VlvwQoAiwSUs9hrjuCt2hZrfS@vger.kernel.org
X-Gm-Message-State: AOJu0YyWdyItr4+grYaUxURF67e2/FbN7BnxEVyxQ3+bt6+u4OUdVp4N
	r8H3hE+yWlcGwXnZ3k3724+YecaNNeDTD/6n6sO8AapnFStqkXCIKz30orUK5g==
X-Gm-Gg: ASbGncuJrW19Ct1R6DuGIt3gKYpQhy4azz5QGimIXkrDq+oLR8NnjYoUHJl+2tadvnV
	W4mALafDJPAcTMtZ8kkhAviWVBpgu/CsTRl+nqMvvmiJZzZURh4UnvpfRjgaNf3BEEVekElT1RM
	BwQKVgWnR90n0aDiR/WixBszAoKrvhGZdV1aYYTrS/+ZJfoJ9wsn5rW2NCNKMoR9qkk1I+WY1Cz
	PJrLAfju1/FmuBEY2AhrdQj81ehuSbgELxP8hEVowf/3geOni0GQQwDdK/d4bJdtrTgIB7go9gc
	Ui1I56u2fkFY40CpFWPYvM0ZJb9GOzetUu/SrMhjlivo2NnLDg0lcv2dkADu2j/xQJ148Lw0z/D
	9lMQOZGQ4+Ybxh+GjmN6zz1I07TKFHvrE/URE7guEMA==
X-Google-Smtp-Source: AGHT+IEgvrgxjlE/55SYTjjQ9QES3i6DWHTQF6YsPlWQpeIgRk9NdDIjYpYOcCPb3afDoaphQMVGWw==
X-Received: by 2002:a05:6808:17a2:b0:406:67b7:8b62 with SMTP id 5614622812f47-41e4748ed00mr14283959b6e.38.1753203038299;
        Tue, 22 Jul 2025 09:50:38 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:a130:f3a0:d203:abc8])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41fd59531d8sm2935217b6e.42.2025.07.22.09.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 09:50:37 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-pm@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	sre@kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lee@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v5 4/5] regulator: bq257xx: Add bq257xx boost regulator driver
Date: Tue, 22 Jul 2025 11:48:11 -0500
Message-ID: <20250722164813.2110874-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722164813.2110874-1-macroalpha82@gmail.com>
References: <20250722164813.2110874-1-macroalpha82@gmail.com>
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
 drivers/regulator/bq257xx-regulator.c | 188 ++++++++++++++++++++++++++
 3 files changed, 197 insertions(+)
 create mode 100644 drivers/regulator/bq257xx-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 6d8988387da4..53cd33afe6d5 100644
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
index c0bc7a0f4e67..d6024189a248 100644
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
index 000000000000..26e1e07a4a71
--- /dev/null
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -0,0 +1,188 @@
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
+	if (IS_ERR_OR_NULL(pdata->otg_en_gpio)) {
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
+	struct regulator_init_data *init_data;
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
+	cfg.init_data = init_data;
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


