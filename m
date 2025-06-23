Return-Path: <linux-pm+bounces-29391-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C09AE4AE0
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 18:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD818179232
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 16:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D130C2BDC33;
	Mon, 23 Jun 2025 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3U7fKDV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BBE253F1B;
	Mon, 23 Jun 2025 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695898; cv=none; b=aYgVg4Wkw2QRuXg+NCTa3DbvsNhgsTTn8QBG1bLO2krz6NIJQAa80C3vNQD8kvUkSmtP+cZADArMlgy7ue+HMXp9eE/OwRZrWqx347jSk2KmwHAjw+6rLXGHX8aS2QiXGcpc0fBDmnBu0BPtSdaULGHObOd4t79IoH6/CiDNlnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695898; c=relaxed/simple;
	bh=+eezEszo803GeuExIGDpnHdLZr3dhhhUaw1Im1f7ILg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDcqvP37HK/N7KiCQZk3YNnvaDqijOFHRR/G4Gtexmwyf1dE6wcYlqeok4XqboICd0gkwFqhCt3P7Hoe760zZ1gcn25nZZ5zaPZLbOsc7I+nroZ8NH56X2dHf+OReqZktjUCQM3cGyvqMjZU2S/qAXaCoBbmYZ2noL/wDh+tCNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3U7fKDV; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-407a6c6a6d4so939584b6e.1;
        Mon, 23 Jun 2025 09:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750695896; x=1751300696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2nJMywOhw7Zd8eC2O3g7tAJAQSlLbrE7mdKTgKRmEc=;
        b=i3U7fKDVHIDPJ5jndxHZMTxwxS3SQhAG3Sg8jFhEG7cOxQkQTJzXCLv2SqYvNsI4r2
         O9/kbMWeE3zC8JNjWT865E2WLv7xdHxgD1/ORsk+2CqkNa4taoH/NCipVj9UUeST18In
         ZPFFNq6xxp9Uu6HF3T6WoVPiD6/IGfbhhHuURlBVlmQbcFm2mpzvmbJsdGLo+cX0i/Kf
         40BTsdqk42041g2vwwGujVKmVD1cLDzyUqZAUJGuueA+8W+6kjVi2jb9/ZjhpIsj9HkU
         0e+jmMDgUtJhQhU1k1gYzGOlRj8e7HPMsaFdnezLTWlNThYqm7iOACPKrEIvvC6knUTw
         Vikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750695896; x=1751300696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2nJMywOhw7Zd8eC2O3g7tAJAQSlLbrE7mdKTgKRmEc=;
        b=nS7Y+d2xcpqYmw3lcndae8sjDFI+kSZf460Ir7dx+F7gA27MYaGdAj9uTSnX1K1F5V
         YctLtwt1Q9Sro8uLaJuC5fquk4Ru6SlRJQ0j4NrRFpkaOl6o8OOflmL7yMdetXLvovN3
         onmvsmHoPN5CK2nvM5v3ooGszy3K2QhZwXU2ijBja1C0VGNrovPNMEE4teZipOx3Bf49
         5ZUapWMskqD6c+y02sOKH0r2XM7CSWlfH99OiYhen7AB458SCZ0o3uK2L9YePa+CfIiV
         mXj52gmw+uG5hWBOaAcbrS9SlVuEuoXAzbBO2/CKzlo2kDRK278X5mpw3Z53QsGmU9QF
         1Bkw==
X-Forwarded-Encrypted: i=1; AJvYcCV4Sql6zz5iKV61YRWjw42wkM/sExY6LPCDhtZtVXj2+Nt0V6dWgD+tISYjMweKxcRyUJ9H97C3Pl0R@vger.kernel.org
X-Gm-Message-State: AOJu0YxTeM+8iDjnaf8FMnqpPMHDrlbGbicB90ivzJqH0gscut++BBh2
	n5Zd1541MrjnxOQrAr2/z4UjMZwOiCbGDz2vCaYn9DZAuPS9ocVkCBauvLTRvA==
X-Gm-Gg: ASbGncuJd5khjG1ce+Mz9PxjB7YZoYGJvg9LLtfmURkW+q4HL46b1R3rzUIRTQ4bcOx
	En1aqL3dQ7oDjKGtGtvKezl4Ax44obg4GfNlRTI0pKg8AfNcK9C+/Dxs/rWDphEAD/+34LXl+hZ
	GuEl72POFiINw/Q1EzrZIuIhJhJMvIlsdH4OHZYw0zzm3OHjhYay4vo7mkS8uUhWHozZ44sZRKy
	4N5r4rAEt0AWtGipRHOcifYDJ6WiA8+xpVMXtSxtCoYfE4HYM9uDYEkFeS/sUiA+AinTfxlBP6Y
	d3p+fGtnnryFaQ+qY5OIqRRg51rT/Hx/y+wCzZIgcpeSDAxQwTYsnZjsI2fdfUZKvYdjiWuCiVW
	ohiJOoA==
X-Google-Smtp-Source: AGHT+IHNm3PA6LMiwTFwM8fT2V2lpXspStLdibiEEbd7PDxNkK85qmSDmseeLom6ONaWkXsBG/DcNw==
X-Received: by 2002:a05:6808:2384:b0:40a:59fd:1368 with SMTP id 5614622812f47-40ac6e43b41mr10501539b6e.4.1750695895476;
        Mon, 23 Jun 2025 09:24:55 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:61a2:e42d:d809:3616])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40ac6ced44esm1427308b6e.24.2025.06.23.09.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 09:24:55 -0700 (PDT)
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
Subject: [PATCH V3 2/5] mfd: bq257xx: Add support for BQ25703A core driver
Date: Mon, 23 Jun 2025 11:22:20 -0500
Message-ID: <20250623162223.184304-3-macroalpha82@gmail.com>
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

The Texas Instruments BQ25703A is an integrated charger manager and
boost converter.

The MFD driver initalizes the device for the regulator driver
and power supply driver.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/mfd/Kconfig         |  11 ++++
 drivers/mfd/Makefile        |   1 +
 drivers/mfd/bq257xx.c       | 104 ++++++++++++++++++++++++++++++++++
 include/linux/mfd/bq257xx.h | 108 ++++++++++++++++++++++++++++++++++++
 4 files changed, 224 insertions(+)
 create mode 100644 drivers/mfd/bq257xx.c
 create mode 100644 include/linux/mfd/bq257xx.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6fb3768e3d71..d8b39e8a8a17 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1585,6 +1585,17 @@ config MFD_TI_LMU
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
index 79495f9f3457..06da932cce5d 100644
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
index 000000000000..27fbb64110ed
--- /dev/null
+++ b/drivers/mfd/bq257xx.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BQ257XX Core Driver
+ * Copyright (C) 2024 Chris Morgan <macromorgan@hotmail.com>
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
+static const struct mfd_cell bq25703_cells[] = {
+	MFD_CELL_NAME("bq257xx-regulator"),
+	MFD_CELL_NAME("bq257xx-charger"),
+};
+
+static int bq257xx_probe(struct i2c_client *client)
+{
+	struct bq257xx_device *ddata;
+	const struct mfd_cell *cells;
+	int nr_cells;
+	int ret;
+
+	ddata = devm_kzalloc(&client->dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	ddata->client = client;
+
+	cells = bq25703_cells;
+	nr_cells = ARRAY_SIZE(bq25703_cells);
+	ddata->regmap = devm_regmap_init_i2c(client, &bq25703_regmap_config);
+	if (IS_ERR(ddata->regmap)) {
+		dev_err(&client->dev, "Failed to allocate register map\n");
+		return PTR_ERR(ddata->regmap);
+	}
+
+	i2c_set_clientdata(client, ddata);
+
+	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO,
+				   cells, nr_cells, NULL, 0, NULL);
+	if (ret) {
+		dev_err(&client->dev, "Failed to register child devices %d\n", ret);
+		return ret;
+	}
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
index 000000000000..153a96248f32
--- /dev/null
+++ b/include/linux/mfd/bq257xx.h
@@ -0,0 +1,108 @@
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
+enum bq257xx_id {
+	BQ25703A,
+};
+
+struct bq257xx_device {
+	struct i2c_client *client;
+	struct regmap *regmap;
+};
-- 
2.43.0


