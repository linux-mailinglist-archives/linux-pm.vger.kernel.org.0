Return-Path: <linux-pm+bounces-11214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B753934257
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 20:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5231C20F99
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 18:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A563318308C;
	Wed, 17 Jul 2024 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm4ZBqVS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970CA7470;
	Wed, 17 Jul 2024 18:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721241527; cv=none; b=reTAw2S9boS5zqWxx0962yZBswYdAfm8ZSgJYvVsEHg/u8jR4rQVH0bCZNGMdHS+wYsaUzgpS4/v1LDJ9QAWbDvMZiAuA6P92Ni0eY0ZkBrzJL8RYhQrw86Ofzz9pAPneYx1x87NBFJ6FaXsWjlrp5wQ1Dr8vzjvKHM2Iz7Vg98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721241527; c=relaxed/simple;
	bh=AAa73a/eG+UaWwZDFBzfK0+VZSC5kbpy6wM/aZhzZFA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q7NZp/CYJ+oOdMjTB+V8275Tk3xgCDNPgXn1SpYL9rGcwzUAEjsNgXsxdcUPxqGWZ2gG9BVj2T+6nAhmqy+GTxuIcNfj+A7cga/hJs074OYliLYJ58PeQGBKVZmWnZ2cTaWq/icjSMJ6lI1rDDIXb+rrZ9UhOAT3D0SX4m8aE3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jm4ZBqVS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4266edee10cso46795045e9.2;
        Wed, 17 Jul 2024 11:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721241524; x=1721846324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z02OmqBH2AOV7DXRhymRPFF4DbUX9AbFtyHlhhA0S9w=;
        b=jm4ZBqVSRBuxw3grny5bRUIpJLgfgJz+4pXgKPPnn9IS2QshkACkC3YpEg1BSx72ir
         A7MczOXZUJAhO7iwQiLkgWFDU8VUxCJnp1W8zjlyHBIb4Hy2uQksY9muM27Hk18F3wWd
         rUc3cuZMi/LHAwPk811HO0OwV/zGsZB8PGjaPt+NPy3xi0WBbY77mvGiN7sgTNN+cCdB
         d0UMrGqOCR+DbgW+XBq6FsTA9KgvjzfrbRUdK0T27UJa74fImTL1oE7dpYJ3BhbHJEPq
         aLuIlIhndb7bAbxTw3PLmWpIXSD11J/ZrrZ+b6tkmdUWhqu0K8xqakOEEu0i0EhcJ3xv
         QDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721241524; x=1721846324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z02OmqBH2AOV7DXRhymRPFF4DbUX9AbFtyHlhhA0S9w=;
        b=wxQOtY0flAJuPI+UwXx80OqQxPEWpO+/KD0czeiJAtCdojk23tmd47PtqfZIfsy2gu
         2IqPqJfYAPhrKZuBeOa7+SzUESMCddq+G86lhpZ1C01/S+8ksqvav8dNyWfNyOE319ns
         lEOwYRY8LfxYYOMMP7FLBzb0xGhAKcCZ2aHW/F3XYYJZYdDB2KMuphUMuSx5VLTj0hoi
         ifT82IPlP7uCOb40aqKz1kBkgMwRbd4PsgxD+PUxY0A7GmHSe8vf5onzdio79XUwIS2z
         Q2SZ9PMIzkIPyhyWBXUQk08uMNkxXIX0aN8Iy8s8ZmQqDogDDp/+qAhUpp/2hxtJDImO
         aEdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+OeHhUsRixTDAoUfHQtbzyg8NHfjCVuWZByZuECftClRQp/dkbt/WEgxRuIxLle60dL6MpKWZqE6kXD264xO13RRSERMp7DgJyi29qJgLdXzq7dxa1L4I+AUdriA1xixm6qAxNRM=
X-Gm-Message-State: AOJu0Yz2yzJOY1/mw8/PBoFgrnytZpRuG6OFBKC+P1xE4wUVyaEENwPj
	IjmzLIG8Zl6rLbl1fxC4UKFHiQxQEhSSNWdiorULcTKgMg8G2bwx
X-Google-Smtp-Source: AGHT+IH2p351gsJBbp6H2aT85s4kpqpH/OJLGXRdO4FFjs0hhwLEOULtcMrdhvyeCoHVLc3Hlw+Pmg==
X-Received: by 2002:a05:600c:3592:b0:426:5216:3247 with SMTP id 5b1f17b1804b1-427c2ca22b9mr19603155e9.6.1721241523359;
        Wed, 17 Jul 2024 11:38:43 -0700 (PDT)
Received: from debian.fritz.box ([2a00:79c0:641:6d00:224:9bff:fe22:6dd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c7805253sm7188535e9.32.2024.07.17.11.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 11:38:42 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: [PATCH] power: supply: max1720x: add read support for nvmem
Date: Wed, 17 Jul 2024 20:37:57 +0200
Message-Id: <20240717183757.3948-1-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ModelGauge m5 and device configuration values are stored in nonvolatile
memory to prevent data loss if the IC loses power. Add read support for
the nonvolatile memory on MAX1720X devices.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---

Based on:
479b6d04964b "power: supply: add support for MAX1720x standalone fuel gauge"
in branch for-next

---
 drivers/power/supply/max1720x_battery.c | 215 ++++++++++++++++++++++--
 1 file changed, 200 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supply/max1720x_battery.c
index edc262f0a62f..175f36e83b85 100644
--- a/drivers/power/supply/max1720x_battery.c
+++ b/drivers/power/supply/max1720x_battery.c
@@ -16,7 +16,9 @@
 #include <asm/unaligned.h>
 
 /* Nonvolatile registers */
+#define MAX1720X_NXTABLE0		0x80
 #define MAX1720X_NRSENSE		0xCF	/* RSense in 10^-5 Ohm */
+#define MAX1720X_NDEVICE_NAME4		0xDF
 
 /* ModelGauge m5 */
 #define MAX172XX_STATUS			0x00	/* Status */
@@ -46,6 +48,8 @@ static const char *const max17205_model = "MAX17205";
 
 struct max1720x_device_info {
 	struct regmap *regmap;
+	struct regmap *regmap_nv;
+	struct i2c_client *ancillary;
 	int rsense;
 };
 
@@ -106,6 +110,134 @@ static const struct regmap_config max1720x_regmap_cfg = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
+static const struct regmap_range max1720x_nvmem_allow[] = {
+	regmap_reg_range(MAX1720X_NXTABLE0, MAX1720X_NDEVICE_NAME4),
+};
+
+static const struct regmap_range max1720x_nvmem_deny[] = {
+	regmap_reg_range(0x00, 0x7F),
+	regmap_reg_range(0xE0, 0xFF),
+};
+
+static const struct regmap_access_table max1720x_nvmem_regs = {
+	.yes_ranges	= max1720x_nvmem_allow,
+	.n_yes_ranges	= ARRAY_SIZE(max1720x_nvmem_allow),
+	.no_ranges	= max1720x_nvmem_deny,
+	.n_no_ranges	= ARRAY_SIZE(max1720x_nvmem_deny),
+};
+
+static const struct regmap_config max1720x_nvmem_regmap_cfg = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = MAX1720X_NDEVICE_NAME4,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+	.rd_table = &max1720x_nvmem_regs,
+};
+
+static const struct nvmem_cell_info max1720x_nvmem_cells[] = {
+	{ .name = "nXTable0",  .offset = 0,  .bytes = 2, },
+	{ .name = "nXTable1",  .offset = 2,  .bytes = 2, },
+	{ .name = "nXTable2",  .offset = 4,  .bytes = 2, },
+	{ .name = "nXTable3",  .offset = 6,  .bytes = 2, },
+	{ .name = "nXTable4",  .offset = 8,  .bytes = 2, },
+	{ .name = "nXTable5",  .offset = 10, .bytes = 2, },
+	{ .name = "nXTable6",  .offset = 12, .bytes = 2, },
+	{ .name = "nXTable7",  .offset = 14, .bytes = 2, },
+	{ .name = "nXTable8",  .offset = 16, .bytes = 2, },
+	{ .name = "nXTable9",  .offset = 18, .bytes = 2, },
+	{ .name = "nXTable10", .offset = 20, .bytes = 2, },
+	{ .name = "nXTable11", .offset = 22, .bytes = 2, },
+	{ .name = "nUser18C",  .offset = 24, .bytes = 2, },
+	{ .name = "nUser18D",  .offset = 26, .bytes = 2, },
+	{ .name = "nODSCTh",   .offset = 28, .bytes = 2, },
+	{ .name = "nODSCCfg",  .offset = 30, .bytes = 2, },
+
+	{ .name = "nOCVTable0",  .offset = 32, .bytes = 2, },
+	{ .name = "nOCVTable1",  .offset = 34, .bytes = 2, },
+	{ .name = "nOCVTable2",  .offset = 36, .bytes = 2, },
+	{ .name = "nOCVTable3",  .offset = 38, .bytes = 2, },
+	{ .name = "nOCVTable4",  .offset = 40, .bytes = 2, },
+	{ .name = "nOCVTable5",  .offset = 42, .bytes = 2, },
+	{ .name = "nOCVTable6",  .offset = 44, .bytes = 2, },
+	{ .name = "nOCVTable7",  .offset = 46, .bytes = 2, },
+	{ .name = "nOCVTable8",  .offset = 48, .bytes = 2, },
+	{ .name = "nOCVTable9",  .offset = 50, .bytes = 2, },
+	{ .name = "nOCVTable10", .offset = 52, .bytes = 2, },
+	{ .name = "nOCVTable11", .offset = 54, .bytes = 2, },
+	{ .name = "nIChgTerm",   .offset = 56, .bytes = 2, },
+	{ .name = "nFilterCfg",  .offset = 58, .bytes = 2, },
+	{ .name = "nVEmpty",     .offset = 60, .bytes = 2, },
+	{ .name = "nLearnCfg",   .offset = 62, .bytes = 2, },
+
+	{ .name = "nQRTable00",  .offset = 64, .bytes = 2, },
+	{ .name = "nQRTable10",  .offset = 66, .bytes = 2, },
+	{ .name = "nQRTable20",  .offset = 68, .bytes = 2, },
+	{ .name = "nQRTable30",  .offset = 70, .bytes = 2, },
+	{ .name = "nCycles",     .offset = 72, .bytes = 2, },
+	{ .name = "nFullCapNom", .offset = 74, .bytes = 2, },
+	{ .name = "nRComp0",     .offset = 76, .bytes = 2, },
+	{ .name = "nTempCo",     .offset = 78, .bytes = 2, },
+	{ .name = "nIAvgEmpty",  .offset = 80, .bytes = 2, },
+	{ .name = "nFullCapRep", .offset = 82, .bytes = 2, },
+	{ .name = "nVoltTemp",   .offset = 84, .bytes = 2, },
+	{ .name = "nMaxMinCurr", .offset = 86, .bytes = 2, },
+	{ .name = "nMaxMinVolt", .offset = 88, .bytes = 2, },
+	{ .name = "nMaxMinTemp", .offset = 90, .bytes = 2, },
+	{ .name = "nSOC",        .offset = 92, .bytes = 2, },
+	{ .name = "nTimerH",     .offset = 94, .bytes = 2, },
+
+	{ .name = "nConfig",    .offset = 96,  .bytes = 2, },
+	{ .name = "nRippleCfg", .offset = 98,  .bytes = 2, },
+	{ .name = "nMiscCfg",   .offset = 100, .bytes = 2, },
+	{ .name = "nDesignCap", .offset = 102, .bytes = 2, },
+	{ .name = "nHibCfg",    .offset = 104, .bytes = 2, },
+	{ .name = "nPackCfg",   .offset = 106, .bytes = 2, },
+	{ .name = "nRelaxCfg",  .offset = 108, .bytes = 2, },
+	{ .name = "nConvgCfg",  .offset = 110, .bytes = 2, },
+	{ .name = "nNVCfg0",    .offset = 112, .bytes = 2, },
+	{ .name = "nNVCfg1",    .offset = 114, .bytes = 2, },
+	{ .name = "nNVCfg2",    .offset = 116, .bytes = 2, },
+	{ .name = "nSBSCfg",    .offset = 118, .bytes = 2, },
+	{ .name = "nROMID0",    .offset = 120, .bytes = 2, },
+	{ .name = "nROMID1",    .offset = 122, .bytes = 2, },
+	{ .name = "nROMID2",    .offset = 124, .bytes = 2, },
+	{ .name = "nROMID3",    .offset = 126, .bytes = 2, },
+
+	{ .name = "nVAlrtTh",      .offset = 128, .bytes = 2, },
+	{ .name = "nTAlrtTh",      .offset = 130, .bytes = 2, },
+	{ .name = "nSAlrtTh",      .offset = 132, .bytes = 2, },
+	{ .name = "nIAlrtTh",      .offset = 134, .bytes = 2, },
+	{ .name = "nUser1C4",      .offset = 136, .bytes = 2, },
+	{ .name = "nUser1C5",      .offset = 138, .bytes = 2, },
+	{ .name = "nFullSOCThr",   .offset = 140, .bytes = 2, },
+	{ .name = "nTTFCfg",       .offset = 142, .bytes = 2, },
+	{ .name = "nCGain",        .offset = 144, .bytes = 2, },
+	{ .name = "nTCurve",       .offset = 146, .bytes = 2, },
+	{ .name = "nTGain",        .offset = 148, .bytes = 2, },
+	{ .name = "nTOff",         .offset = 150, .bytes = 2, },
+	{ .name = "nManfctrName0", .offset = 152, .bytes = 2, },
+	{ .name = "nManfctrName1", .offset = 154, .bytes = 2, },
+	{ .name = "nManfctrName2", .offset = 156, .bytes = 2, },
+	{ .name = "nRSense",       .offset = 158, .bytes = 2, },
+
+	{ .name = "nUser1D0",       .offset = 160, .bytes = 2, },
+	{ .name = "nUser1D1",       .offset = 162, .bytes = 2, },
+	{ .name = "nAgeFcCfg",      .offset = 164, .bytes = 2, },
+	{ .name = "nDesignVoltage", .offset = 166, .bytes = 2, },
+	{ .name = "nUser1D4",       .offset = 168, .bytes = 2, },
+	{ .name = "nRFastVShdn",    .offset = 170, .bytes = 2, },
+	{ .name = "nManfctrDate",   .offset = 172, .bytes = 2, },
+	{ .name = "nFirstUsed",     .offset = 174, .bytes = 2, },
+	{ .name = "nSerialNumber0", .offset = 176, .bytes = 2, },
+	{ .name = "nSerialNumber1", .offset = 178, .bytes = 2, },
+	{ .name = "nSerialNumber2", .offset = 180, .bytes = 2, },
+	{ .name = "nDeviceName0",   .offset = 182, .bytes = 2, },
+	{ .name = "nDeviceName1",   .offset = 184, .bytes = 2, },
+	{ .name = "nDeviceName2",   .offset = 186, .bytes = 2, },
+	{ .name = "nDeviceName3",   .offset = 188, .bytes = 2, },
+	{ .name = "nDeviceName4",   .offset = 190, .bytes = 2, },
+};
+
 static const enum power_supply_property max1720x_battery_props[] = {
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_CAPACITY,
@@ -249,31 +381,74 @@ static int max1720x_battery_get_property(struct power_supply *psy,
 	return ret;
 }
 
-static int max1720x_probe_sense_resistor(struct i2c_client *client,
-					 struct max1720x_device_info *info)
+static
+int max1720x_nvmem_reg_read(void *priv, unsigned int off, void *val, size_t len)
+{
+	struct max1720x_device_info *info = priv;
+	unsigned int reg = MAX1720X_NXTABLE0 + (off / 2);
+
+	return regmap_bulk_read(info->regmap_nv, reg, val, len / 2);
+}
+
+static int max1720x_probe_nvmem(struct i2c_client *client,
+				struct max1720x_device_info *info)
 {
 	struct device *dev = &client->dev;
-	struct i2c_client *ancillary;
+	struct nvmem_config nvmem_config = {
+		.dev = dev,
+		.name = "max1720x_nvmem",
+		.cells = max1720x_nvmem_cells,
+		.ncells = ARRAY_SIZE(max1720x_nvmem_cells),
+		.read_only = true,
+		.root_only = true,
+		.reg_read = max1720x_nvmem_reg_read,
+		.size = ARRAY_SIZE(max1720x_nvmem_cells) * 2,
+		.word_size = 2,
+		.stride = 2,
+		.priv = info,
+	};
+	struct nvmem_device *nvmem;
+	unsigned int val;
 	int ret;
 
-	ancillary = i2c_new_ancillary_device(client, "nvmem", 0xb);
-	if (IS_ERR(ancillary)) {
+	info->ancillary = i2c_new_ancillary_device(client, "nvmem", 0xb);
+	if (IS_ERR(info->ancillary)) {
 		dev_err(dev, "Failed to initialize ancillary i2c device\n");
-		return PTR_ERR(ancillary);
+		return PTR_ERR(info->ancillary);
 	}
 
-	ret = i2c_smbus_read_word_data(ancillary, MAX1720X_NRSENSE);
-	i2c_unregister_device(ancillary);
-	if (ret < 0)
-		return ret;
+	info->regmap_nv = devm_regmap_init_i2c(info->ancillary,
+					       &max1720x_nvmem_regmap_cfg);
+	if (IS_ERR(info->regmap_nv)) {
+		dev_err(dev, "regmap initialization of nvmem failed\n");
+		ret = PTR_ERR(info->regmap_nv);
+		goto err;
+	}
+
+	ret = regmap_read(info->regmap_nv, MAX1720X_NRSENSE, &val);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read sense resistor value\n");
+		goto err;
+	}
 
-	info->rsense = ret;
+	info->rsense = val;
 	if (!info->rsense) {
 		dev_warn(dev, "RSense not calibrated, set 10 mOhms!\n");
 		info->rsense = 1000; /* in regs in 10^-5 */
 	}
 
+	nvmem = devm_nvmem_register(dev, &nvmem_config);
+	if (IS_ERR(nvmem)) {
+		dev_err(dev, "Could not register nvmem!");
+		ret = PTR_ERR(nvmem);
+		goto err;
+	}
+
 	return 0;
+err:
+	i2c_unregister_device(info->ancillary);
+
+	return ret;
 }
 
 static const struct power_supply_desc max1720x_bat_desc = {
@@ -299,24 +474,33 @@ static int max1720x_probe(struct i2c_client *client)
 
 	psy_cfg.drv_data = info;
 	psy_cfg.fwnode = dev_fwnode(dev);
+	i2c_set_clientdata(client, info);
 	info->regmap = devm_regmap_init_i2c(client, &max1720x_regmap_cfg);
 	if (IS_ERR(info->regmap))
 		return dev_err_probe(dev, PTR_ERR(info->regmap),
 				     "regmap initialization failed\n");
 
-	ret = max1720x_probe_sense_resistor(client, info);
+	ret = max1720x_probe_nvmem(client, info);
 	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to read sense resistor value\n");
+		return dev_err_probe(dev, ret, "Failed to probe nvmem\n");
 
 	bat = devm_power_supply_register(dev, &max1720x_bat_desc, &psy_cfg);
-	if (IS_ERR(bat))
+	if (IS_ERR(bat)) {
+		i2c_unregister_device(info->ancillary);
 		return dev_err_probe(dev, PTR_ERR(bat),
 				     "Failed to register power supply\n");
+	}
 
 	return 0;
 }
 
+static void max1720x_remove(struct i2c_client *client)
+{
+	struct max1720x_device_info *info = i2c_get_clientdata(client);
+
+	i2c_unregister_device(info->ancillary);
+}
+
 static const struct of_device_id max1720x_of_match[] = {
 	{ .compatible = "maxim,max17201" },
 	{}
@@ -329,6 +513,7 @@ static struct i2c_driver max1720x_i2c_driver = {
 		.of_match_table = max1720x_of_match,
 	},
 	.probe = max1720x_probe,
+	.remove = max1720x_remove,
 };
 module_i2c_driver(max1720x_i2c_driver);
 
-- 
2.39.2


