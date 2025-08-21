Return-Path: <linux-pm+bounces-32817-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335BEB30009
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 18:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77E335A6585
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 16:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4EA2DEA6A;
	Thu, 21 Aug 2025 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgOB8Ffu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47082D8774;
	Thu, 21 Aug 2025 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793634; cv=none; b=on1HHYO/voC9WtFbP7pY5dpnGc9WczzWkqrySyboyNFuUKEoJT/EzAAA4wAmA5W9K2pfht7gxT1JkvBKeT+TW51khPflMwW44EWWrenGRlMOXCA4i8nGTjvAT1WxnhJJg0TqF/mXNOBFBuzvPsUIO4DfoKasiTaeRtyD321D6pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793634; c=relaxed/simple;
	bh=7HHxSdmTPKD6fAdNxOP8X7Q3JOi3Xy5T2Iy4h5d7zVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmswywFcnIJOvjaOT+kn89ff5F6oUxsmtmHnHKy8DRKUx6IpI8oELWIQgeI9I9atdfWILpP1zddCb7dIwcxRl/kSinVHcGVfyPnr1/5a8VEEBCA82rGDmyH6Icu3AEkcb0JhPLXPosWhG1Dc3UV1WwcD0wtbKLDJAeUxZ4+7bZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgOB8Ffu; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-74382002fa6so547896a34.3;
        Thu, 21 Aug 2025 09:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755793632; x=1756398432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/rFn2c3NXu2TjccETbNdw3sNYkjsFtzaF7CowUSmWE=;
        b=CgOB8FfuaixL8GRM0cceUakSCnQI0G/jVJIbHWbHlPl/1apnCM8oxYDU1AVTVFeRJk
         fLLKYygJ/JCe13pQToeyJh+qdGyG+0ugV5elLMsdHxbi2hg9vBIACiLXxux2cmU4haAw
         odeo+yIQPqCzyZd4omHjCG3MdBTun3On5JkByDszCMBq9sLayh/Z7+Il7LVDt2aJryQv
         aVCaWu1U+Z7vt4SV1G51lRkFME3uzzw+aMIc+IJmslk46BW2aaHxwolib2yO6hgK3ccL
         BGOU+sI0XxIusajVcUPV2quYpJoYQXjtw/T/21w0EBHqt/QGY4tR7ttRkzsweU18UB63
         npew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755793632; x=1756398432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/rFn2c3NXu2TjccETbNdw3sNYkjsFtzaF7CowUSmWE=;
        b=uDq9ckwvTdCGa5qIPzfnNP/CdMuQU/Zdxe4hPzpFSfUJw98L/BMzDKMQpNy1nBle8r
         L414q53GlTz1zMe+MKrXtFVi5PqFhBgBchTYf3OmA+8VLZq0e1lHZz7yNY4deKjm8JAb
         fg92O5Jy+no8U9CZwvSIpXXfM/0wIuBl295fbfN0wtGQIFrZk0D73wvBVy2ANfJ4iHgA
         z+NJZ7lpHN+JEiqyttwLBaZ0hOdMwTrmDrMCYxT9Uq7I/9D+z4BW6CF+BVRVaNoKzB0R
         VdfSNBr3YkGJ+pLbU9YBT6ei7l/YmZku4UTR0MMl1DBLyvKVw45CGH4TQROS98ormUYz
         I4lg==
X-Forwarded-Encrypted: i=1; AJvYcCVmtVT0SRa5K7n2LBJfoHLg8q8o7i25bkwA0OE0dYy+ra0TeuJnAhLjv5iUrjwp9MU8UcbNJ8Vab5J+@vger.kernel.org
X-Gm-Message-State: AOJu0YxB0WcuHcLkeW2WDyQpLwd/suDCiO4qR2lrLZ+3ulhzDOfa4SVS
	X/+BUVzR7XhpE9PD++VEW4J+SXyu9Cz31wZw79WyITZYV40sSw/whI5H
X-Gm-Gg: ASbGncveUQ+e+o6dp6RUbCLlgc36SiKa3+PSDgOavoa8rDljFjSCe5rtE1GwcGjdTVR
	FD0AWLn0JY/PHgbyJgQudQQ/wPwpt5fRC7sh696KIWXhKA4/shvynZ+cOWZjtGxZX+ZQBCH+UM0
	ycXr9MhaFxh4Q+v984/b+aa2AEGCRhQKbKeF/epbwCM+kreo4sEQp9CutqZrXzGQX/GgWS/Kgzd
	h4hWDDzv1zi2njrNvJYmRhSFJlCocVbYCja9Hiz+TqbyA1SIv3CaP71eisPaSmoBsbVtEVQkwxm
	Bd0sITgQDO7ElONzqmA7Cql8cfNBRq6CH7MNh+jBGPE4Ltwzrp7sRMkiy+3Ry1qtILMvzwAEDpP
	TDCc+BvcdSm33GbyIiqLP//ybpZ3ERXNt8bHASCkhzg==
X-Google-Smtp-Source: AGHT+IH+d7BDDdB+ARnb385fVJm7QIVlU0oA3Wk5TCMaxe0YF0m7CJofgu0qYcYgr2FQ+vWXUX4Wzg==
X-Received: by 2002:a05:6830:378f:b0:744:f08e:4d2a with SMTP id 46e09a7af769-74500aa6495mr47659a34.29.1755793631856;
        Thu, 21 Aug 2025 09:27:11 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:b19a:18c8:26b9:21c7])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61bec14b3cesm1674706eaf.27.2025.08.21.09.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 09:27:11 -0700 (PDT)
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
Subject: [PATCH V7 2/5] mfd: bq257xx: Add support for BQ25703A core driver
Date: Thu, 21 Aug 2025 11:24:45 -0500
Message-ID: <20250821162448.117621-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821162448.117621-1-macroalpha82@gmail.com>
References: <20250821162448.117621-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

The Texas Instruments BQ25703A is an integrated charger manager and
boost converter.

The MFD driver initalizes the device for the regulator driver
and power supply driver.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/mfd/Kconfig         |  11 ++++
 drivers/mfd/Makefile        |   1 +
 drivers/mfd/bq257xx.c       |  97 +++++++++++++++++++++++++++++++++
 include/linux/mfd/bq257xx.h | 104 ++++++++++++++++++++++++++++++++++++
 4 files changed, 213 insertions(+)
 create mode 100644 drivers/mfd/bq257xx.c
 create mode 100644 include/linux/mfd/bq257xx.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 425c5fba6cb1..768417c97339 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1641,6 +1641,17 @@ config MFD_TI_LMU
 	  LM36274.  It consists of backlight, LED and regulator driver.
 	  It provides consistent device controls for lighting functions.
 
+config MFD_BQ257XX
+	tristate "TI BQ257XX Buck/Boost Charge Controller"
+	depends on I2C
+	select MFD_CORE
+	select REGMAP_I2C
+	help
+	  Support Texas Instruments BQ25703 Buck/Boost converter with
+	  charge controller. It consists of regulators that provide
+	  system voltage and OTG voltage, and a charger manager for
+	  batteries containing one or more cells.
+
 config MFD_OMAP_USB_HOST
 	bool "TI OMAP USBHS core and TLL driver"
 	depends on USB_EHCI_HCD_OMAP || USB_OHCI_HCD_OMAP3
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index f7bdedd5a66d..3d700374a42d 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_MFD_SM501)		+= sm501.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
 obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
 obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
+obj-$(CONFIG_MFD_BQ257XX)	+= bq257xx.o
 obj-$(CONFIG_MFD_CGBC)		+= cgbc-core.o
 obj-$(CONFIG_MFD_CROS_EC_DEV)	+= cros_ec_dev.o
 obj-$(CONFIG_MFD_CS42L43)	+= cs42l43.o
diff --git a/drivers/mfd/bq257xx.c b/drivers/mfd/bq257xx.c
new file mode 100644
index 000000000000..ac4485a2cc60
--- /dev/null
+++ b/drivers/mfd/bq257xx.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BQ257XX Core Driver
+ * Copyright (C) 2025 Chris Morgan <macromorgan@hotmail.com>
+ */
+
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/mfd/bq257xx.h>
+#include <linux/mfd/core.h>
+#include <linux/regmap.h>
+
+static const struct regmap_range bq25703_readonly_reg_ranges[] = {
+	regmap_reg_range(BQ25703_CHARGER_STATUS, BQ25703_MANUFACT_DEV_ID),
+};
+
+static const struct regmap_access_table bq25703_writeable_regs = {
+	.no_ranges = bq25703_readonly_reg_ranges,
+	.n_no_ranges = ARRAY_SIZE(bq25703_readonly_reg_ranges),
+};
+
+static const struct regmap_range bq25703_volatile_reg_ranges[] = {
+	regmap_reg_range(BQ25703_CHARGE_OPTION_0, BQ25703_IIN_HOST),
+	regmap_reg_range(BQ25703_CHARGER_STATUS, BQ25703_ADC_OPTION),
+};
+
+static const struct regmap_access_table bq25703_volatile_regs = {
+	.yes_ranges = bq25703_volatile_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(bq25703_volatile_reg_ranges),
+};
+
+static const struct regmap_config bq25703_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = BQ25703_ADC_OPTION,
+	.cache_type = REGCACHE_RBTREE,
+	.wr_table = &bq25703_writeable_regs,
+	.volatile_table = &bq25703_volatile_regs,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+};
+
+static int bq257xx_probe(struct i2c_client *client)
+{
+	struct bq257xx_device *ddata;
+	static const struct mfd_cell cells[] = {
+		MFD_CELL_NAME("bq257xx-regulator"),
+		MFD_CELL_NAME("bq257xx-charger"),
+	};
+	int ret;
+
+	ddata = devm_kzalloc(&client->dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	ddata->client = client;
+	ddata->regmap = devm_regmap_init_i2c(client, &bq25703_regmap_config);
+	if (IS_ERR(ddata->regmap)) {
+		return dev_err_probe(&client->dev, PTR_ERR(ddata->regmap),
+				     "Failed to allocate register map\n");
+	}
+
+	i2c_set_clientdata(client, ddata);
+
+	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO,
+				   cells, ARRAY_SIZE(cells), NULL, 0, NULL);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to register child devices\n");
+
+	return ret;
+}
+
+static const struct i2c_device_id bq257xx_i2c_ids[] = {
+	{ "bq25703a" },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, bq257xx_i2c_ids);
+
+static const struct of_device_id bq257xx_of_match[] = {
+	{ .compatible = "ti,bq25703a" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, bq257xx_of_match);
+
+static struct i2c_driver bq257xx_driver = {
+	.driver = {
+		.name = "bq257xx",
+		.of_match_table = bq257xx_of_match,
+	},
+	.probe = bq257xx_probe,
+	.id_table = bq257xx_i2c_ids,
+};
+module_i2c_driver(bq257xx_driver);
+
+MODULE_DESCRIPTION("bq257xx buck/boost/charger driver");
+MODULE_AUTHOR("Chris Morgan <macromorgan@hotmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/bq257xx.h b/include/linux/mfd/bq257xx.h
new file mode 100644
index 000000000000..1d6ddc7fb09f
--- /dev/null
+++ b/include/linux/mfd/bq257xx.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Register definitions for TI BQ257XX
+ * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#define BQ25703_CHARGE_OPTION_0			0x00
+#define BQ25703_CHARGE_CURRENT			0x02
+#define BQ25703_MAX_CHARGE_VOLT			0x04
+#define BQ25703_OTG_VOLT			0x06
+#define BQ25703_OTG_CURRENT			0x08
+#define BQ25703_INPUT_VOLTAGE			0x0a
+#define BQ25703_MIN_VSYS			0x0c
+#define BQ25703_IIN_HOST			0x0e
+#define BQ25703_CHARGER_STATUS			0x20
+#define BQ25703_PROCHOT_STATUS			0x22
+#define BQ25703_IIN_DPM				0x24
+#define BQ25703_ADCIBAT_CHG			0x28
+#define BQ25703_ADCIINCMPIN			0x2a
+#define BQ25703_ADCVSYSVBAT			0x2c
+#define BQ25703_MANUFACT_DEV_ID			0x2e
+#define BQ25703_CHARGE_OPTION_1			0x30
+#define BQ25703_CHARGE_OPTION_2			0x32
+#define BQ25703_CHARGE_OPTION_3			0x34
+#define BQ25703_ADC_OPTION			0x3a
+
+#define BQ25703_EN_LWPWR			BIT(15)
+#define BQ25703_WDTMR_ADJ_MASK			GENMASK(14, 13)
+#define BQ25703_WDTMR_DISABLE			0
+#define BQ25703_WDTMR_5_SEC			1
+#define BQ25703_WDTMR_88_SEC			2
+#define BQ25703_WDTMR_175_SEC			3
+
+#define BQ25703_ICHG_MASK			GENMASK(12, 6)
+#define BQ25703_ICHG_STEP_UA			64000
+#define BQ25703_ICHG_MIN_UA			64000
+#define BQ25703_ICHG_MAX_UA			8128000
+
+#define BQ25703_MAX_CHARGE_VOLT_MASK		GENMASK(15, 4)
+#define BQ25703_VBATREG_STEP_UV			16000
+#define BQ25703_VBATREG_MIN_UV			1024000
+#define BQ25703_VBATREG_MAX_UV			19200000
+
+#define BQ25703_OTG_VOLT_MASK			GENMASK(13, 6)
+#define BQ25703_OTG_VOLT_STEP_UV		64000
+#define BQ25703_OTG_VOLT_MIN_UV			4480000
+#define BQ25703_OTG_VOLT_MAX_UV			20800000
+#define BQ25703_OTG_VOLT_NUM_VOLT		256
+
+#define BQ25703_OTG_CUR_MASK			GENMASK(14, 8)
+#define BQ25703_OTG_CUR_STEP_UA			50000
+#define BQ25703_OTG_CUR_MAX_UA			6350000
+
+#define BQ25703_MINVSYS_MASK			GENMASK(13, 8)
+#define BQ25703_MINVSYS_STEP_UV			256000
+#define BQ25703_MINVSYS_MIN_UV			1024000
+#define BQ25703_MINVSYS_MAX_UV			16128000
+
+#define BQ25703_STS_AC_STAT			BIT(15)
+#define BQ25703_STS_IN_FCHRG			BIT(10)
+#define BQ25703_STS_IN_PCHRG			BIT(9)
+#define BQ25703_STS_FAULT_ACOV			BIT(7)
+#define BQ25703_STS_FAULT_BATOC			BIT(6)
+#define BQ25703_STS_FAULT_ACOC			BIT(5)
+
+#define BQ25703_IINDPM_MASK			GENMASK(14, 8)
+#define BQ25703_IINDPM_STEP_UA			50000
+#define BQ25703_IINDPM_MIN_UA			50000
+#define BQ25703_IINDPM_MAX_UA			6400000
+#define BQ25703_IINDPM_DEFAULT_UA		3300000
+#define BQ25703_IINDPM_OFFSET_UA		50000
+
+#define BQ25703_ADCIBAT_DISCHG_MASK		GENMASK(6, 0)
+#define BQ25703_ADCIBAT_CHG_MASK		GENMASK(14, 8)
+#define BQ25703_ADCIBAT_CHG_STEP_UA		64000
+#define BQ25703_ADCIBAT_DIS_STEP_UA		256000
+
+#define BQ25703_ADCIIN				GENMASK(15, 8)
+#define BQ25703_ADCIINCMPIN_STEP		50000
+
+#define BQ25703_ADCVSYS_MASK			GENMASK(15, 8)
+#define BQ25703_ADCVBAT_MASK			GENMASK(7, 0)
+#define BQ25703_ADCVSYSVBAT_OFFSET_UV		2880000
+#define BQ25703_ADCVSYSVBAT_STEP		64000
+
+#define BQ25703_ADC_CH_MASK			GENMASK(7, 0)
+#define BQ25703_ADC_CONV_EN			BIT(15)
+#define BQ25703_ADC_START			BIT(14)
+#define BQ25703_ADC_FULL_SCALE			BIT(13)
+#define BQ25703_ADC_CMPIN_EN			BIT(7)
+#define BQ25703_ADC_VBUS_EN			BIT(6)
+#define BQ25703_ADC_PSYS_EN			BIT(5)
+#define BQ25703_ADC_IIN_EN			BIT(4)
+#define BQ25703_ADC_IDCHG_EN			BIT(3)
+#define BQ25703_ADC_ICHG_EN			BIT(2)
+#define BQ25703_ADC_VSYS_EN			BIT(1)
+#define BQ25703_ADC_VBAT_EN			BIT(0)
+
+#define BQ25703_EN_OTG_MASK			BIT(12)
+
+struct bq257xx_device {
+	struct i2c_client *client;
+	struct regmap *regmap;
+};
-- 
2.43.0


