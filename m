Return-Path: <linux-pm+bounces-13373-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8C09693C7
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 08:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A97C01C22C2C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 06:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5ED1CFEDF;
	Tue,  3 Sep 2024 06:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hN4MpzgD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2619E2E3EB;
	Tue,  3 Sep 2024 06:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345344; cv=none; b=PrEQUiGw01ki1tKeVNRVFPjgjb7qMGXI6fPGrKDhkwdwbJY5caaMhZlr6UabzEVSSgvR98mujO/i+aUoFL9fOaeXkT/yVZdIOA0AsdvNzQs6zNUeuky7YmyReETSNUz6oz3GVOHcnt8AaK7AB4jUa9g2Hx6RgdYaKAbNzurBq0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345344; c=relaxed/simple;
	bh=EcoB/KgEWRNLgA0aNtfshNiJziojP2yxA5h3J2Agpg0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YL+hp7J49c1cRX/X+4NJ9X9BMBmuSDg47NBcwQlMT87Njl/t49pazMqcg4TVmMdkGz2yl/n1y7LIG70MU3LDPSHN1ZpQp/Y7jr1VlHjEZKcQoq5kqM19tlvOYZYE4pFZMExu0nd55G4f5N4ax97iJ7SZdgRwpFQrU7wcUUQteF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hN4MpzgD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428e0d18666so41868715e9.3;
        Mon, 02 Sep 2024 23:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725345340; x=1725950140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ELfVzerh8nu3RqiZQrZMdHbwltUBSoGHPsMIy08MHkw=;
        b=hN4MpzgDS1xd/81hkEOHsimE86uL1lciLO/5SQxFNOF0Aek3H6VsCrLo26Zp2exntr
         T8thkqpbILBo9CFinRMhGWyFlXydZmRtAphDYSCsqFUc0tZOJeD+b6ZIjUo4DofK6/xl
         d2g998J5XQUCOFpfVDjfSPyllSUO4c6Q9/IFeZaNADJoEfTxMwqDJ44oMJoXOzwpozi7
         zIXkLtGutCMWy3JuhzYvBUPN/7F5Z4bl1VHfSekG1lv0nZv319VokXRnQKp/szcoBbro
         3E9Nw5If6HTUhyDEHMXI7Zsdhn+LBh9GBqcS0SmO5yMQK4edZT2h8uwG1IyZZ/8713vB
         WMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725345340; x=1725950140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ELfVzerh8nu3RqiZQrZMdHbwltUBSoGHPsMIy08MHkw=;
        b=Pu2V0XSRjeAPn02SRqvwFhtHWApjZGMvFyeBt/Ky1rqhaIff29GG+RXxClns6Z00dF
         EwtEA+HXlmO+9hk7XuobLzwt6sw/JuBfzeqVyHW4VC/JdZqOEuAeMX1EK7SDFRHgasLo
         9Thw6Nrtp0UXhRAUsmMUFSrUjs16yMnE+MwvNqZ379uMvCFGZ06Bsb243DQRdZdtEWqA
         2rldlqkdagNM84Ayn9N5BU0rbRzglfOONNbys/O608mW9qXFaFprjYizDig9YRifR9VC
         rmfM0fjspcjzWu0Hw5Rz11mZvSrqTx3N9QTwJAXdEK4gWN3tbQ48Rg4fvPRRfQn0wQWR
         LFNw==
X-Forwarded-Encrypted: i=1; AJvYcCUheUSPXsPjuKoPe3QnXQxgTrv8D2h5FpmaWj0cDpukm/QqVw8a3UO2eIw7oHAH8NsHOjiSEPfTL3GrddQ=@vger.kernel.org, AJvYcCWINwheX4sk7RisxVtH//lSe2Mqj6ZeLA6LX4VRz9w/mTGFxkPjPx3BLYEKXMtF4GLRQWQj0NMwi4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY7ZiS8tl6qBSfpc7dFAfx99/+agOjFs2eLmQYKVvs16B3ygQo
	Nz2ceZSrDsldv0pL3GbbVvajGRHIIp4DYsAPckWJPF6mG8Ga48Qh
X-Google-Smtp-Source: AGHT+IFGh/1/tw88mLsaOeXF65oNv7oWznJVC5LBzrGt+st5RQX51qudkn1E9FU6otMNl/LK7+HWdQ==
X-Received: by 2002:a05:600c:3b0c:b0:426:65bf:5cc2 with SMTP id 5b1f17b1804b1-42bbb10cd56mr75173645e9.1.1725345339776;
        Mon, 02 Sep 2024 23:35:39 -0700 (PDT)
Received: from debian.fritz.box ([2a00:79c0:634:9a00:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df936dsm159066775e9.28.2024.09.02.23.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 23:35:39 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: [PATCH v3] power: supply: max1720x: add read support for nvmem
Date: Tue,  3 Sep 2024 08:35:26 +0200
Message-Id: <20240903063526.222890-1-dima.fedrau@gmail.com>
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

Changes in V2:
  - remove function max1720x_remove and use devm_add_action_or_reset() to
    unregister info->ancillary to avoid race condition during module remove

Changes in V3:
  - fix build errors discovered by kernel test robot, add missing header
    linux/nvmem-provider.h
  - remove i2c_unregister_device calls from error handling code, let
    devm_add_action_or_reset handle it

---
 drivers/power/supply/max1720x_battery.c | 210 ++++++++++++++++++++++--
 1 file changed, 197 insertions(+), 13 deletions(-)

diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supply/max1720x_battery.c
index edc262f0a62f..3e84e70340e4 100644
--- a/drivers/power/supply/max1720x_battery.c
+++ b/drivers/power/supply/max1720x_battery.c
@@ -10,13 +10,16 @@
 #include <linux/bitfield.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/nvmem-provider.h>
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
 
 #include <asm/unaligned.h>
 
 /* Nonvolatile registers */
+#define MAX1720X_NXTABLE0		0x80
 #define MAX1720X_NRSENSE		0xCF	/* RSense in 10^-5 Ohm */
+#define MAX1720X_NDEVICE_NAME4		0xDF
 
 /* ModelGauge m5 */
 #define MAX172XX_STATUS			0x00	/* Status */
@@ -46,6 +49,8 @@ static const char *const max17205_model = "MAX17205";
 
 struct max1720x_device_info {
 	struct regmap *regmap;
+	struct regmap *regmap_nv;
+	struct i2c_client *ancillary;
 	int rsense;
 };
 
@@ -106,6 +111,134 @@ static const struct regmap_config max1720x_regmap_cfg = {
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
@@ -249,30 +382,81 @@ static int max1720x_battery_get_property(struct power_supply *psy,
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
+static void max1720x_unregister_ancillary(void *data)
+{
+	struct max1720x_device_info *info = data;
+
+	i2c_unregister_device(info->ancillary);
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
+	ret = devm_add_action_or_reset(dev, max1720x_unregister_ancillary, info);
+	if (ret) {
+		i2c_unregister_device(info->ancillary);
+		dev_err(dev, "Failed to add unregister callback\n");
 		return ret;
+	}
+
+	info->regmap_nv = devm_regmap_init_i2c(info->ancillary,
+					       &max1720x_nvmem_regmap_cfg);
+	if (IS_ERR(info->regmap_nv)) {
+		dev_err(dev, "regmap initialization of nvmem failed\n");
+		return PTR_ERR(info->regmap_nv);
+	}
+
+	ret = regmap_read(info->regmap_nv, MAX1720X_NRSENSE, &val);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read sense resistor value\n");
+		return ret;
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
+		return PTR_ERR(nvmem);
+	}
+
 	return 0;
 }
 
@@ -299,15 +483,15 @@ static int max1720x_probe(struct i2c_client *client)
 
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
 	if (IS_ERR(bat))
-- 
2.39.2


