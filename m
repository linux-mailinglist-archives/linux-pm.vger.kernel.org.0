Return-Path: <linux-pm+bounces-29392-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221D0AE4AE1
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 18:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDAAC179923
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 16:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D947E2BDC3F;
	Mon, 23 Jun 2025 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTdoJYUX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110B82BDC2E;
	Mon, 23 Jun 2025 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695899; cv=none; b=gVvmKl48PnjKoovZEju2GqTE5J268CCPQBIiLm/yjRLEn21jgZQXd/eCHc/xDsVdY+Q3s3Gai9Nzm5a7dSpKrcY+tP1RUdGbucd5oJ4GGcCcABCi5qXNBaIXamQ5ZlkTv0c/iGbYf+C75Pn+RZGTHNYP7NMu1YL9IzkY50NT5s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695899; c=relaxed/simple;
	bh=Mdk7K5PAingZoH1jC5RtW78HJUAbyvJ5t1SpqtsZsJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkSFdG+woT0Bp0M5mmOun5pi4jT8gVdhmwez6wGN/WXSMd09vmFBs6ZPys8AChn7NopKeoFYnzoPwBx9HQUTG7Ik7wYK5yCMsJAqWfglP/VG/TmzejH3DD7b54I33tRck+cxMESOB5YWJf8FU4nRLP4jp9bdmqzn8x3+rCGbW6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTdoJYUX; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-40a4bf1ebb7so2868539b6e.0;
        Mon, 23 Jun 2025 09:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750695897; x=1751300697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bE/VSQwUqsUSgxDurcv65dzlzK9yg98M1pQULytqQNc=;
        b=FTdoJYUXUJshU+irP03EstWWjphXXuYBqoaf/veLDqSCah+xlb51Zpc+DuiNeQHkwd
         adLqQbSxRu54eD3zpzHC6Le+8MRFR84WfcJqGWOI91pJPbMaPmmyVmmIsn/wwH1ak2+v
         6Og70JSKHHVqsdNCbA301E6Nc7Sdszt08dzw62CELyV8HiyjkSiUPDqwYK51m41HigL7
         s0zleJaFsMZIYw0l88lDvDacl0UbfI2jwoETEx+wmdcuUgX2iqdjBgOfDBp5g983xKXs
         G3ztL4nzSA9NXY+aDesu8YjqJ8zR6smzy+Vra16YZPAp88EaeMVqZIn4lnbpMpR/qX5G
         ORPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750695897; x=1751300697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bE/VSQwUqsUSgxDurcv65dzlzK9yg98M1pQULytqQNc=;
        b=hteVpQtwILwR4SWD/u6NYH/a9+0BtGEr+QF8FhKcRjX452wAPWsF8oeF7RtphEro/z
         wqdvetrTLHgWAej7cskom8uqGbm1IB/CqoaoDRIBiUxjU3nh+0fdXNqiSIE17kzAsDT5
         suFh51rB4HtrabvK1z07vE42OA40McyGVFlU/d8HWydti8/S3PGKONSPA+9I2GEf5Vc2
         WjGdG2TahA07aWz536vtamXjW/T45965kb4vq1fSnmc/7MnAy5q1Q5nqjSZVJLYaw31y
         YMD1gWeZQhimAkGj3sJcPdwWjCJN6EPb6SB3htM5wRDj9wuXRk3dmlltb6m1OAoZfplp
         c1kQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/rs4ez+jD0FArG/WnrEwHHk9tfQv7hg/ljfp7eUAedyGK53nZagiEffsCnZj+7NDV/q10yIjZAa2p@vger.kernel.org
X-Gm-Message-State: AOJu0YzPXnFpMJoKVqBJ7Ib+UlY9ARWIUgkDiR8PEHxSWYQ+nLqPl6ZH
	J+CvWzwwzzR15WELIUlOaNcWx96Xz6Gg2+O6ZQwNFT0f45yo0J26NkxFGjnCnA==
X-Gm-Gg: ASbGncvvK8/9+m5+kIBDQRr7YjJRXSATXIdSz2b4j33Gzg2H/O77YB7Ck3X1/TSnk38
	0Dshl9TP/n/+dXq2BX1oGr9y4jgDnhtGbCOcjVKRMpZByJAsuLvBcl4av2HcWyoI9QBgUk6Xjre
	JxDHxharQjj7zzTLt3+6GGslDrXvBfHM5Rnv2UpLZUkiXY8+yogEyuAlOR9v2RLypFoCtgUXXZo
	h+3hcosZKWWlDGwr1iGh7fYhaZhGCdt44snvLHCgzhF6roVPOOSpsrMD4ny0+QGfdiZI+lU3y5c
	QUiKvCrCX6pfVWwbBX4uODk0OBAHxgDjJtIWY9l/eiRqGVPxl/+w+k0facg+4xqeqa2cO0a+hrW
	cdRCNHQ==
X-Google-Smtp-Source: AGHT+IEyNlYYYEw0jtUMR828uFlRRvNG1fa3ZJD1W0IvhRnecGbB83rA3AV2U09osMRUnWxUZ2z0rQ==
X-Received: by 2002:a05:6808:2201:b0:3fa:3a0:137b with SMTP id 5614622812f47-40ac7006f6cmr9213109b6e.29.1750695896783;
        Mon, 23 Jun 2025 09:24:56 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:61a2:e42d:d809:3616])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40ac6ced44esm1427308b6e.24.2025.06.23.09.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 09:24:56 -0700 (PDT)
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
Subject: [PATCH V3 4/5] regulator: bq257xx: Add bq257xx boost regulator driver
Date: Mon, 23 Jun 2025 11:22:22 -0500
Message-ID: <20250623162223.184304-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623162223.184304-1-macroalpha82@gmail.com>
References: <20250623162223.184304-1-macroalpha82@gmail.com>
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
---
 drivers/regulator/Kconfig             |   8 ++
 drivers/regulator/Makefile            |   1 +
 drivers/regulator/bq257xx-regulator.c | 189 ++++++++++++++++++++++++++
 3 files changed, 198 insertions(+)
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
index 000000000000..cae08fbba9f8
--- /dev/null
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0
+/* BQ257XX Battery Charger Driver
+ * Copyright (C) 2024 Chris Morgan <macromorgan@hotmail.com>
+ * Based off of BQ256XX Battery Charger driver and
+ * RK808 Regulator driver.
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
+	.name = "usb_otg_vbus",
+	.of_match = of_match_ptr("usb-otg-vbus"),
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


