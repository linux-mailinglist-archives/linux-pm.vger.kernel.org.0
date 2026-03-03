Return-Path: <linux-pm+bounces-43513-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKSGKjoBp2k7bgAAu9opvQ
	(envelope-from <linux-pm+bounces-43513-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 16:41:46 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4EA1F2D36
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 16:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65FD631CE24B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 15:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D78D495535;
	Tue,  3 Mar 2026 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="44dszUL9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF8E4963B9
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772552005; cv=none; b=GDndNgeM2LBKkp8ft2SCQ3RkqrSQGULbLzEEuCVvx4o8LTRZK/W3Jzr8UzHU9ggzjFYQgU7q3pycPojVjBcQq/WRAraNbDzox9VNo0zL0MFnOia0DgmoMiDR6hC7aJL4r+ygrkJGpIWF7R08VMKjd5ZWpin8+UhSMXt3ECvEIoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772552005; c=relaxed/simple;
	bh=nOduz00h5fpXPu+UdGV0hj0gdsgtcCrHjSqgzrZqdz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nE96agH5gXkgS4e5Ohdb6cZGnfXEg9fWvvoahzutnllAQmtxktYUr24moz8XjpHEmUeLUftOa0lqs22Sp48lDs9hPLga9JmMGT1fFez+ZAIjIkIfU8M75yM61t5Rpxwro0ovTcK0TyCTa4do8JXiw5CucT8BJLtT3ltEE16VAw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=44dszUL9; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439ac15f35fso2944201f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 07:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1772552001; x=1773156801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmALN9MGA9u53yKJNFJzqfov+Z/gHizGgvZq4z1BuiI=;
        b=44dszUL9u+oFMtHALp6GvHxQz68juzr6w4w/wrPxz/9E10QBACG/y1C2h+pfHMRsDA
         K+g9Ns8C+lK1MNZzNrnzZO/zyBLmuRCsDdW3qgEMkn+QcXxn4CtcOXz/YLt3L/agzxO7
         QztN6u7ODc8D2p7KOo5bw+eYzAxMXJGoOhNaOXXOpZ3aut/FC+mt99Ud5Cf3yenClwdT
         p6geCdPwoqs2LJ7Mz2AwIO6FGVxA6DV2RH8RcS30Fhu+8u267BFAp+9YPIWCdV0hRUtH
         En5EdVxMmWjCfmEISYXRGPNFm97YG8+x6oC4WYVvBoQ5siRpZsmITw+R5L8UoFqW6sVX
         8nPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772552001; x=1773156801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JmALN9MGA9u53yKJNFJzqfov+Z/gHizGgvZq4z1BuiI=;
        b=O13KsCh+HwEGXihoxo6xamwQqS1cBrzEtQtnAt27DeN9oDpLf9guCid35c5Ej7QYGc
         xWaubyRuRghEnnylvX/Bkw44uXr1tEhJ/J/pCoqzBEADdkzJj/Aq8y7DDUDY/ZAdz+Tf
         uBVJ57bIM3d43v48dR3EseJb/jZxvOZlvj9fL8oDvKQiDJWFU6BKZhQUhBfyrs+KV55O
         9CbglcOVkEbt0CrFiPmI8HRMwCPC6+AmIh/YXIcCHQ9K0OKuK0bjeglxC9EgUlLKWcga
         iKXgpsFPWM3MYlzEXAxpnqHRMiSBLoDFkWfVKOaBlHrj1zBwNv0Oc0fdXH3lGNGKbs7w
         rsJg==
X-Forwarded-Encrypted: i=1; AJvYcCUNZ4wm2yJZGGtGfa4d8ZLZYgG8kAw1C9Eo1r5fshqdRvuVgzYHxpAWk/+hS5JBLFJL9fKAHN+egQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuSUdkQTMEtZ+H7zvrmLbPUiwqOzsLlnTzt/vVtmBPh2gE0uPN
	aGmz+bl028zxFQJUiTfYIvbIy1GARn3zjS4K4SKjLiQFMbX5sIVW0bAkpW9To+xCDzk=
X-Gm-Gg: ATEYQzy4k1FbDSXSN6fHWvdJYr9sHe+fsVsqJlYPjYQfT73HKkwQ2D6t2t4/U4ftpDq
	pPLFgHj7wHnSJ/qOrNsrNapLsj04cx0d3dKQu6tb8T5GWprGnuiOLVujN7pruJSnoizDGkisE22
	G2OYAG413OOceA32s6MeiDHCXS9+B6YuQHd2GQJM7titxosszbyYE3kYOkQ6HzKkX0n8XSGkd2N
	R4knogWpqztVW0RXLt+bNbL4zhjXheOMHkn84zhMITB9b1s0JAdiB9BNiUUhq4194wlflBnFSYW
	2Wy9C1QH/9L4o8cMbAGo0OEu+bNm+Pwoxyb/pTjlGpODG47vvqt/WBeh3dlwz62kThdiuajrbXC
	NZInouzrKlEx5QfVkINWSKh9ZAZZ1Aif59AvkGyHCKLixACmKH19I+RIyOE9ccxGvqMslI/bG/5
	SADKIIjepxew9HAv2RwlGripv5QVJP+i63h5++pTG5Ij7BjjypFg9S88w+5LAUMjN2wKUw09vAu
	ws=
X-Received: by 2002:a05:6000:4305:b0:439:bcdb:95af with SMTP id ffacd0b85a97d-439bcdba1f4mr9925056f8f.0.1772552000789;
        Tue, 03 Mar 2026 07:33:20 -0800 (PST)
Received: from alchark-surface.localdomain (bba-94-59-44-101.alshamil.net.ae. [94.59.44.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b55d15besm19799447f8f.30.2026.03.03.07.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 07:33:20 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 03 Mar 2026 19:32:54 +0400
Subject: [PATCH 09/11] mfd: bq257xx: Add BQ25792 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-bq25792-v1-9-e6e5e0033458@flipper.net>
References: <20260303-bq25792-v1-0-e6e5e0033458@flipper.net>
In-Reply-To: <20260303-bq25792-v1-0-e6e5e0033458@flipper.net>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=19885; i=alchark@flipper.net;
 h=from:subject:message-id; bh=nOduz00h5fpXPu+UdGV0hj0gdsgtcCrHjSqgzrZqdz4=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQu+6+2v/W0HXv5q9tOX6TnHp92pf231YEQ61OP5hu84
 CiXEjbm7ZjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DA11jHWMGLg4BWCq1Rcy/FNlaWG8uiXrSJarVLxgrBJ/xckPW8L/ucb1fzA49Sto5jxGhi0nOC8
 o2701cv1086Zu76N6N6c54YfvTz+c39/xR0jPjhsA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Rspamd-Queue-Id: 0F4EA1F2D36
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43513-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,hotmail.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[flipper.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flipper.net:dkim,flipper.net:email,flipper.net:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add register definitions and a new 'type' enum to be passed in MFD
platform data to support the BQ25792, which is a newer variant of the
BQ257xx family.

BQ25792 shares similar logic of operation with the already supported
BQ25703A but has a completely different register map and different
electrical constraints.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/mfd/bq257xx.c       |  60 ++++++-
 include/linux/mfd/bq257xx.h | 417 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 472 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/bq257xx.c b/drivers/mfd/bq257xx.c
index e9d49dac0a16..a6776c8c94f2 100644
--- a/drivers/mfd/bq257xx.c
+++ b/drivers/mfd/bq257xx.c
@@ -10,6 +10,11 @@
 #include <linux/mfd/core.h>
 #include <linux/regmap.h>
 
+struct bq257xx_match_data {
+	const struct bq257xx_plat plat;
+	const struct regmap_config *regmap_config;
+};
+
 static const struct regmap_range bq25703_readonly_reg_ranges[] = {
 	regmap_reg_range(BQ25703_CHARGER_STATUS, BQ25703_MANUFACT_DEV_ID),
 };
@@ -39,13 +44,56 @@ static const struct regmap_config bq25703_regmap_config = {
 	.val_format_endian = REGMAP_ENDIAN_LITTLE,
 };
 
-static const struct mfd_cell cells[] = {
-	MFD_CELL_NAME("bq257xx-regulator"),
-	MFD_CELL_NAME("bq257xx-charger"),
+static const struct bq257xx_match_data bq25703a_match_data = {
+	.plat = { .type = BQ25703A },
+	.regmap_config = &bq25703_regmap_config,
+};
+
+static const struct regmap_range bq25792_writeable_reg_ranges[] = {
+	regmap_reg_range(BQ25792_REG00_MIN_SYS_VOLTAGE,
+			 BQ25792_REG18_NTC_CONTROL_1),
+	regmap_reg_range(BQ25792_REG28_CHARGER_MASK_0,
+			 BQ25792_REG30_ADC_FUNCTION_DISABLE_1),
+};
+
+static const struct regmap_access_table bq25792_writeable_regs = {
+	.yes_ranges = bq25792_writeable_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(bq25792_writeable_reg_ranges),
+};
+
+static const struct regmap_range bq25792_volatile_reg_ranges[] = {
+	regmap_reg_range(BQ25792_REG19_ICO_CURRENT_LIMIT,
+			 BQ25792_REG27_FAULT_FLAG_1),
+	regmap_reg_range(BQ25792_REG31_IBUS_ADC,
+			 BQ25792_REG47_DPDM_DRIVER),
+};
+
+static const struct regmap_access_table bq25792_volatile_regs = {
+	.yes_ranges = bq25792_volatile_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(bq25792_volatile_reg_ranges),
+};
+
+static const struct regmap_config bq25792_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = BQ25792_REG48_PART_INFORMATION,
+	.cache_type = REGCACHE_MAPLE,
+	.wr_table = &bq25792_writeable_regs,
+	.volatile_table = &bq25792_volatile_regs,
+};
+
+static const struct bq257xx_match_data bq25792_match_data = {
+	.plat = { .type = BQ25792 },
+	.regmap_config = &bq25792_regmap_config,
 };
 
 static int bq257xx_probe(struct i2c_client *client)
 {
+	const struct bq257xx_match_data *md = device_get_match_data(&client->dev);
+	const struct mfd_cell cells[] = {
+		MFD_CELL_BASIC("bq257xx-regulator", NULL, &md->plat, sizeof(md->plat), 0),
+		MFD_CELL_BASIC("bq257xx-charger", NULL, &md->plat, sizeof(md->plat), 0),
+	};
 	struct bq257xx_device *ddata;
 	int ret;
 
@@ -55,7 +103,7 @@ static int bq257xx_probe(struct i2c_client *client)
 
 	ddata->client = client;
 
-	ddata->regmap = devm_regmap_init_i2c(client, &bq25703_regmap_config);
+	ddata->regmap = devm_regmap_init_i2c(client, md->regmap_config);
 	if (IS_ERR(ddata->regmap)) {
 		return dev_err_probe(&client->dev, PTR_ERR(ddata->regmap),
 				     "Failed to allocate register map\n");
@@ -74,12 +122,14 @@ static int bq257xx_probe(struct i2c_client *client)
 
 static const struct i2c_device_id bq257xx_i2c_ids[] = {
 	{ "bq25703a" },
+	{ "bq25792" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, bq257xx_i2c_ids);
 
 static const struct of_device_id bq257xx_of_match[] = {
-	{ .compatible = "ti,bq25703a" },
+	{ .compatible = "ti,bq25703a", .data = &bq25703a_match_data },
+	{ .compatible = "ti,bq25792", .data = &bq25792_match_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, bq257xx_of_match);
diff --git a/include/linux/mfd/bq257xx.h b/include/linux/mfd/bq257xx.h
index 1d6ddc7fb09f..b2e38a4a4738 100644
--- a/include/linux/mfd/bq257xx.h
+++ b/include/linux/mfd/bq257xx.h
@@ -98,7 +98,424 @@
 
 #define BQ25703_EN_OTG_MASK			BIT(12)
 
+#define BQ25792_REG00_MIN_SYS_VOLTAGE		0x00
+#define BQ25792_REG01_CHARGE_VOLTAGE_LIMIT	0x01
+#define BQ25792_REG03_CHARGE_CURRENT_LIMIT	0x03
+#define BQ25792_REG05_INPUT_VOLTAGE_LIMIT	0x05
+#define BQ25792_REG06_INPUT_CURRENT_LIMIT	0x06
+#define BQ25792_REG08_PRECHARGE_CONTROL		0x08
+#define BQ25792_REG09_TERMINATION_CONTROL	0x09
+#define BQ25792_REG0A_RECHARGE_CONTROL		0x0a
+#define BQ25792_REG0B_VOTG_REGULATION		0x0b
+#define BQ25792_REG0D_IOTG_REGULATION		0x0d
+#define BQ25792_REG0E_TIMER_CONTROL		0x0e
+#define BQ25792_REG0F_CHARGER_CONTROL_0		0x0f
+#define BQ25792_REG10_CHARGER_CONTROL_1		0x10
+#define BQ25792_REG11_CHARGER_CONTROL_2		0x11
+#define BQ25792_REG12_CHARGER_CONTROL_3		0x12
+#define BQ25792_REG13_CHARGER_CONTROL_4		0x13
+#define BQ25792_REG14_CHARGER_CONTROL_5		0x14
+/* REG15 reserved */
+#define BQ25792_REG16_TEMPERATURE_CONTROL	0x16
+#define BQ25792_REG17_NTC_CONTROL_0		0x17
+#define BQ25792_REG18_NTC_CONTROL_1		0x18
+#define BQ25792_REG19_ICO_CURRENT_LIMIT		0x19
+#define BQ25792_REG1B_CHARGER_STATUS_0		0x1b
+#define BQ25792_REG1C_CHARGER_STATUS_1		0x1c
+#define BQ25792_REG1D_CHARGER_STATUS_2		0x1d
+#define BQ25792_REG1E_CHARGER_STATUS_3		0x1e
+#define BQ25792_REG1F_CHARGER_STATUS_4		0x1f
+#define BQ25792_REG20_FAULT_STATUS_0		0x20
+#define BQ25792_REG21_FAULT_STATUS_1		0x21
+#define BQ25792_REG22_CHARGER_FLAG_0		0x22
+#define BQ25792_REG23_CHARGER_FLAG_1		0x23
+#define BQ25792_REG24_CHARGER_FLAG_2		0x24
+#define BQ25792_REG25_CHARGER_FLAG_3		0x25
+#define BQ25792_REG26_FAULT_FLAG_0		0x26
+#define BQ25792_REG27_FAULT_FLAG_1		0x27
+#define BQ25792_REG28_CHARGER_MASK_0		0x28
+#define BQ25792_REG29_CHARGER_MASK_1		0x29
+#define BQ25792_REG2A_CHARGER_MASK_2		0x2a
+#define BQ25792_REG2B_CHARGER_MASK_3		0x2b
+#define BQ25792_REG2C_FAULT_MASK_0		0x2c
+#define BQ25792_REG2D_FAULT_MASK_1		0x2d
+#define BQ25792_REG2E_ADC_CONTROL		0x2e
+#define BQ25792_REG2F_ADC_FUNCTION_DISABLE_0	0x2f
+#define BQ25792_REG30_ADC_FUNCTION_DISABLE_1	0x30
+#define BQ25792_REG31_IBUS_ADC			0x31
+#define BQ25792_REG33_IBAT_ADC			0x33
+#define BQ25792_REG35_VBUS_ADC			0x35
+#define BQ25792_REG37_VAC1_ADC			0x37
+#define BQ25792_REG39_VAC2_ADC			0x39
+#define BQ25792_REG3B_VBAT_ADC			0x3b
+#define BQ25792_REG3D_VSYS_ADC			0x3d
+#define BQ25792_REG3F_TS_ADC			0x3f
+#define BQ25792_REG41_TDIE_ADC			0x41
+#define BQ25792_REG43_DP_ADC			0x43
+#define BQ25792_REG45_DM_ADC			0x45
+#define BQ25792_REG47_DPDM_DRIVER		0x47
+#define BQ25792_REG48_PART_INFORMATION		0x48
+
+/* Minimal System Voltage */
+#define BQ25792_REG00_VSYSMIN_MASK		GENMASK(5, 0)
+
+#define BQ25792_MINVSYS_MIN_UV			2500000
+#define BQ25792_MINVSYS_STEP_UV			250000
+#define BQ25792_MINVSYS_MAX_UV			16000000
+
+/* Charge Voltage Limit */
+#define BQ25792_REG01_VREG_MASK			GENMASK(10, 0)
+
+#define BQ25792_VBATREG_MIN_UV			3000000
+#define BQ25792_VBATREG_STEP_UV			10000
+#define BQ25792_VBATREG_MAX_UV			18800000
+
+/* Charge Current Limit */
+#define BQ25792_REG03_ICHG_MASK			GENMASK(8, 0)
+
+#define BQ25792_ICHG_MIN_UA			50000
+#define BQ25792_ICHG_STEP_UA			10000
+#define BQ25792_ICHG_MAX_UA			5000000
+
+/* Input Voltage Limit */
+#define BQ25792_REG05_VINDPM_MASK		GENMASK(7, 0)
+
+/* Input Current Limit */
+#define BQ25792_REG06_IINDPM_MASK		GENMASK(8, 0)
+#define BQ25792_IINDPM_DEFAULT_UA		3000000
+#define BQ25792_IINDPM_STEP_UA			10000
+#define BQ25792_IINDPM_MIN_UA			100000
+#define BQ25792_IINDPM_MAX_UA			3300000
+
+/* Precharge Control */
+#define BQ25792_REG08_VBAT_LOWV_MASK		GENMASK(7, 6)
+#define BQ25792_REG08_IPRECHG_MASK		GENMASK(5, 0)
+
+/* Termination Control */
+#define BQ25792_REG09_REG_RST			BIT(6)
+#define BQ25792_REG09_ITERM_MASK		GENMASK(4, 0)
+
+/* Re-charge Control */
+#define BQ25792_REG0A_CELL_MASK			GENMASK(7, 6)
+#define BQ25792_REG0A_TRECHG_MASK		GENMASK(5, 4)
+#define BQ25792_REG0A_VRECHG_MASK		GENMASK(3, 0)
+
+/* VOTG regulation */
+#define BQ25792_REG0B_VOTG_MASK			GENMASK(10, 0)
+
+#define BQ25792_OTG_VOLT_MIN_UV			2800000
+#define BQ25792_OTG_VOLT_STEP_UV		10000
+#define BQ25792_OTG_VOLT_MAX_UV			22000000
+#define BQ25792_OTG_VOLT_NUM_VOLT		((BQ25792_OTG_VOLT_MAX_UV \
+						  - BQ25792_OTG_VOLT_MIN_UV) \
+						  / BQ25792_OTG_VOLT_STEP_UV + 1)
+
+/* IOTG regulation */
+#define BQ25792_REG0D_PRECHG_TMR		BIT(7)
+#define BQ25792_REG0D_IOTG_MASK			GENMASK(6, 0)
+
+#define BQ25792_OTG_CUR_MIN_UA		120000
+#define BQ25792_OTG_CUR_STEP_UA		40000
+#define BQ25792_OTG_CUR_MAX_UA		3320000
+
+/* Timer Control */
+#define BQ25792_REG0E_TOPOFF_TMR_MASK		GENMASK(7, 6)
+#define BQ25792_REG0E_EN_TRICHG_TMR		BIT(5)
+#define BQ25792_REG0E_EN_PRECHG_TMR		BIT(4)
+#define BQ25792_REG0E_EN_CHG_TMR		BIT(3)
+#define BQ25792_REG0E_CHG_TMR_MASK		GENMASK(2, 1)
+#define BQ25792_REG0E_TMR2X_EN			BIT(0)
+
+/* Charger Control 0 */
+#define BQ25792_REG0F_EN_AUTO_IBATDIS		BIT(7)
+#define BQ25792_REG0F_FORCE_IBATDIS		BIT(6)
+#define BQ25792_REG0F_EN_CHG			BIT(5)
+#define BQ25792_REG0F_EN_ICO			BIT(4)
+#define BQ25792_REG0F_FORCE_ICO			BIT(3)
+#define BQ25792_REG0F_EN_HIZ			BIT(2)
+#define BQ25792_REG0F_EN_TERM			BIT(1)
+/* bit0 reserved */
+
+/* Charger Control 1 */
+#define BQ25792_REG10_VAC_OVP_MASK		GENMASK(5, 4)
+#define BQ25792_REG10_WD_RST			BIT(3)
+#define BQ25792_REG10_WATCHDOG_MASK		GENMASK(2, 0)
+
+/* Charger Control 2 */
+#define BQ25792_REG11_FORCE_INDET		BIT(7)
+#define BQ25792_REG11_AUTO_INDET_EN		BIT(6)
+#define BQ25792_REG11_EN_12V			BIT(5)
+#define BQ25792_REG11_EN_9V			BIT(4)
+#define BQ25792_REG11_HVDCP_EN			BIT(3)
+#define BQ25792_REG11_SDRV_CTRL_MASK		GENMASK(2, 1)
+#define BQ25792_REG11_SDRV_DLY			BIT(0)
+
+/* Charger Control 3 */
+#define BQ25792_REG12_DIS_ACDRV			BIT(7)
+#define BQ25792_REG12_EN_OTG			BIT(6)
+#define BQ25792_REG12_PFM_OTG_DIS		BIT(5)
+#define BQ25792_REG12_PFM_FWD_DIS		BIT(4)
+#define BQ25792_REG12_WKUP_DLY			BIT(3)
+#define BQ25792_REG12_DIS_LDO			BIT(2)
+#define BQ25792_REG12_DIS_OTG_OOA		BIT(1)
+#define BQ25792_REG12_DIS_FWD_OOA		BIT(0)
+
+/* Charger Control 4 */
+#define BQ25792_REG13_EN_ACDRV2			BIT(7)
+#define BQ25792_REG13_EN_ACDRV1			BIT(6)
+#define BQ25792_REG13_PWM_FREQ			BIT(5)
+#define BQ25792_REG13_DIS_STAT			BIT(4)
+#define BQ25792_REG13_DIS_VSYS_SHORT		BIT(3)
+#define BQ25792_REG13_DIS_VOTG_UVP		BIT(2)
+#define BQ25792_REG13_FORCE_VINDPM_DET		BIT(1)
+#define BQ25792_REG13_EN_IBUS_OCP		BIT(0)
+
+/* Charger Control 5 */
+#define BQ25792_REG14_SFET_PRESENT		BIT(7)
+/* bit6 reserved */
+#define BQ25792_REG14_EN_IBAT			BIT(5)
+#define BQ25792_REG14_IBAT_REG_MASK		GENMASK(4, 3)
+#define BQ25792_REG14_EN_IINDPM			BIT(2)
+#define BQ25792_REG14_EN_EXTILIM		BIT(1)
+#define BQ25792_REG14_EN_BATOC			BIT(0)
+
+#define BQ25792_IBAT_3A				FIELD_PREP(BQ25792_REG14_IBAT_REG_MASK, 0)
+#define BQ25792_IBAT_4A				FIELD_PREP(BQ25792_REG14_IBAT_REG_MASK, 1)
+#define BQ25792_IBAT_5A				FIELD_PREP(BQ25792_REG14_IBAT_REG_MASK, 2)
+#define BQ25792_IBAT_UNLIM			FIELD_PREP(BQ25792_REG14_IBAT_REG_MASK, 3)
+
+/* Temperature Control */
+#define BQ25792_REG16_TREG_MASK			GENMASK(7, 6)
+#define BQ25792_REG16_TSHUT_MASK		GENMASK(5, 4)
+#define BQ25792_REG16_VBUS_PD_EN		BIT(3)
+#define BQ25792_REG16_VAC1_PD_EN		BIT(2)
+#define BQ25792_REG16_VAC2_PD_EN		BIT(1)
+
+/* NTC Control 0 */
+#define BQ25792_REG17_JEITA_VSET_MASK		GENMASK(7, 5)
+#define BQ25792_REG17_JEITA_ISETH_MASK		GENMASK(4, 3)
+#define BQ25792_REG17_JEITA_ISETC_MASK		GENMASK(2, 1)
+
+/* NTC Control 1 */
+#define BQ25792_REG18_TS_COOL_MASK		GENMASK(7, 6)
+#define BQ25792_REG18_TS_WARM_MASK		GENMASK(5, 4)
+#define BQ25792_REG18_BHOT_MASK			GENMASK(3, 2)
+#define BQ25792_REG18_BCOLD			BIT(1)
+#define BQ25792_REG18_TS_IGNORE			BIT(0)
+
+/* ICO Current Limit */
+#define BQ25792_REG19_ICO_ILIM_MASK		GENMASK(8, 0)
+
+/* Charger Status 0 */
+#define BQ25792_REG1B_IINDPM_STAT		BIT(7)
+#define BQ25792_REG1B_VINDPM_STAT		BIT(6)
+#define BQ25792_REG1B_WD_STAT			BIT(5)
+#define BQ25792_REG1B_POORSRC_STAT		BIT(4)
+#define BQ25792_REG1B_PG_STAT			BIT(3)
+#define BQ25792_REG1B_AC2_PRESENT_STAT		BIT(2)
+#define BQ25792_REG1B_AC1_PRESENT_STAT		BIT(1)
+#define BQ25792_REG1B_VBUS_PRESENT_STAT		BIT(0)
+
+/* Charger Status 1 */
+#define BQ25792_REG1C_CHG_STAT_MASK		GENMASK(7, 5)
+#define BQ25792_REG1C_VBUS_STAT_MASK		GENMASK(4, 1)
+#define BQ25792_REG1C_BC12_DONE_STAT		BIT(0)
+
+/* Charger Status 2 */
+#define BQ25792_REG1D_ICO_STAT_MASK		GENMASK(7, 6)
+#define BQ25792_REG1D_TREG_STAT			BIT(2)
+#define BQ25792_REG1D_DPDM_STAT			BIT(1)
+#define BQ25792_REG1D_VBAT_PRESENT_STAT		BIT(0)
+
+/* Charger Status 3 */
+#define BQ25792_REG1E_ACRB2_STAT		BIT(7)
+#define BQ25792_REG1E_ACRB1_STAT		BIT(6)
+#define BQ25792_REG1E_ADC_DONE_STAT		BIT(5)
+#define BQ25792_REG1E_VSYS_STAT			BIT(4)
+#define BQ25792_REG1E_CHG_TMR_STAT		BIT(3)
+#define BQ25792_REG1E_TRICHG_TMR_STAT		BIT(2)
+#define BQ25792_REG1E_PRECHG_TMR_STAT		BIT(1)
+
+/* Charger Status 4 */
+#define BQ25792_REG1F_VBATOTG_LOW_STAT		BIT(4)
+#define BQ25792_REG1F_TS_COLD_STAT		BIT(3)
+#define BQ25792_REG1F_TS_COOL_STAT		BIT(2)
+#define BQ25792_REG1F_TS_WARM_STAT		BIT(1)
+#define BQ25792_REG1F_TS_HOT_STAT		BIT(0)
+
+/* FAULT Status 0 */
+#define BQ25792_REG20_IBAT_REG_STAT		BIT(7)
+#define BQ25792_REG20_VBUS_OVP_STAT		BIT(6)
+#define BQ25792_REG20_VBAT_OVP_STAT		BIT(5)
+#define BQ25792_REG20_IBUS_OCP_STAT		BIT(4)
+#define BQ25792_REG20_IBAT_OCP_STAT		BIT(3)
+#define BQ25792_REG20_CONV_OCP_STAT		BIT(2)
+#define BQ25792_REG20_VAC2_OVP_STAT		BIT(1)
+#define BQ25792_REG20_VAC1_OVP_STAT		BIT(0)
+
+#define BQ25792_REG20_OVERVOLTAGE_MASK		(BQ25792_REG20_VBUS_OVP_STAT | \
+						 BQ25792_REG20_VBAT_OVP_STAT | \
+						 BQ25792_REG20_VAC2_OVP_STAT | \
+						 BQ25792_REG20_VAC1_OVP_STAT)
+#define BQ25792_REG20_OVERCURRENT_MASK		(BQ25792_REG20_IBUS_OCP_STAT | \
+						 BQ25792_REG20_IBAT_OCP_STAT | \
+						 BQ25792_REG20_CONV_OCP_STAT)
+
+/* FAULT Status 1 */
+#define BQ25792_REG21_VSYS_SHORT_STAT		BIT(7)
+#define BQ25792_REG21_VSYS_OVP_STAT		BIT(6)
+#define BQ25792_REG21_OTG_OVP_STAT		BIT(5)
+#define BQ25792_REG21_OTG_UVP_STAT		BIT(4)
+#define BQ25792_REG21_TSHUT_STAT		BIT(2)
+
+
+/* Charger Flag 0 */
+#define BQ25792_REG22_IINDPM_FLAG		BIT(7)
+#define BQ25792_REG22_VINDPM_FLAG		BIT(6)
+#define BQ25792_REG22_WD_FLAG			BIT(5)
+#define BQ25792_REG22_POORSRC_FLAG		BIT(4)
+#define BQ25792_REG22_PG_FLAG			BIT(3)
+#define BQ25792_REG22_AC2_PRESENT_FLAG		BIT(2)
+#define BQ25792_REG22_AC1_PRESENT_FLAG		BIT(1)
+#define BQ25792_REG22_VBUS_PRESENT_FLAG		BIT(0)
+
+/* Charger Flag 1 */
+#define BQ25792_REG23_CHG_FLAG			BIT(7)
+#define BQ25792_REG23_ICO_FLAG			BIT(6)
+#define BQ25792_REG23_VBUS_FLAG			BIT(4)
+#define BQ25792_REG23_TREG_FLAG			BIT(2)
+#define BQ25792_REG23_VBAT_PRESENT_FLAG		BIT(1)
+#define BQ25792_REG23_BC12_DONE_FLAG		BIT(0)
+
+/* Charger Flag 2 */
+#define BQ25792_REG24_DPDM_DONE_FLAG		BIT(6)
+#define BQ25792_REG24_ADC_DONE_FLAG		BIT(5)
+#define BQ25792_REG24_VSYS_FLAG			BIT(4)
+#define BQ25792_REG24_CHG_TMR_FLAG		BIT(3)
+#define BQ25792_REG24_TRICHG_TMR_FLAG		BIT(2)
+#define BQ25792_REG24_PRECHG_TMR_FLAG		BIT(1)
+#define BQ25792_REG24_TOPOFF_TMR_FLAG		BIT(0)
+
+/* Charger Flag 3 */
+#define BQ25792_REG25_VBATOTG_LOW_FLAG		BIT(4)
+#define BQ25792_REG25_TS_COLD_FLAG		BIT(3)
+#define BQ25792_REG25_TS_COOL_FLAG		BIT(2)
+#define BQ25792_REG25_TS_WARM_FLAG		BIT(1)
+#define BQ25792_REG25_TS_HOT_FLAG		BIT(0)
+
+/* FAULT Flag 0 */
+#define BQ25792_REG26_IBAT_REG_FLAG		BIT(7)
+#define BQ25792_REG26_VBUS_OVP_FLAG		BIT(6)
+#define BQ25792_REG26_VBAT_OVP_FLAG		BIT(5)
+#define BQ25792_REG26_IBUS_OCP_FLAG		BIT(4)
+#define BQ25792_REG26_IBAT_OCP_FLAG		BIT(3)
+#define BQ25792_REG26_CONV_OCP_FLAG		BIT(2)
+#define BQ25792_REG26_VAC2_OVP_FLAG		BIT(1)
+#define BQ25792_REG26_VAC1_OVP_FLAG		BIT(0)
+
+/* FAULT Flag 1 */
+#define BQ25792_REG27_VSYS_SHORT_FLAG		BIT(7)
+#define BQ25792_REG27_VSYS_OVP_FLAG		BIT(6)
+#define BQ25792_REG27_OTG_OVP_FLAG		BIT(5)
+#define BQ25792_REG27_OTG_UVP_FLAG		BIT(4)
+#define BQ25792_REG27_TSHUT_FLAG		BIT(2)
+
+/* Charger Mask 0 */
+#define BQ25792_REG28_IINDPM_MASK		BIT(7)
+#define BQ25792_REG28_VINDPM_MASK		BIT(6)
+#define BQ25792_REG28_WD_MASK			BIT(5)
+#define BQ25792_REG28_POORSRC_MASK		BIT(4)
+#define BQ25792_REG28_PG_MASK			BIT(3)
+#define BQ25792_REG28_AC2_PRESENT_MASK		BIT(2)
+#define BQ25792_REG28_AC1_PRESENT_MASK		BIT(1)
+#define BQ25792_REG28_VBUS_PRESENT_MASK		BIT(0)
+
+/* Charger Mask 1 */
+#define BQ25792_REG29_CHG_MASK			BIT(7)
+#define BQ25792_REG29_ICO_MASK			BIT(6)
+#define BQ25792_REG29_VBUS_MASK			BIT(4)
+#define BQ25792_REG29_TREG_MASK			BIT(2)
+#define BQ25792_REG29_VBAT_PRESENT_MASK		BIT(1)
+#define BQ25792_REG29_BC12_DONE_MASK		BIT(0)
+
+/* Charger Mask 2 */
+#define BQ25792_REG2A_DPDM_DONE_MASK		BIT(6)
+#define BQ25792_REG2A_ADC_DONE_MASK		BIT(5)
+#define BQ25792_REG2A_VSYS_MASK			BIT(4)
+#define BQ25792_REG2A_CHG_TMR_MASK		BIT(3)
+#define BQ25792_REG2A_TRICHG_TMR_MASK		BIT(2)
+#define BQ25792_REG2A_PRECHG_TMR_MASK		BIT(1)
+#define BQ25792_REG2A_TOPOFF_TMR_MASK		BIT(0)
+
+/* Charger Mask 3 */
+#define BQ25792_REG2B_VBATOTG_LOW_MASK		BIT(4)
+#define BQ25792_REG2B_TS_COLD_MASK		BIT(3)
+#define BQ25792_REG2B_TS_COOL_MASK		BIT(2)
+#define BQ25792_REG2B_TS_WARM_MASK		BIT(1)
+#define BQ25792_REG2B_TS_HOT_MASK		BIT(0)
+
+/* FAULT Mask 0 */
+#define BQ25792_REG2C_IBAT_REG_MASK		BIT(7)
+#define BQ25792_REG2C_VBUS_OVP_MASK		BIT(6)
+#define BQ25792_REG2C_VBAT_OVP_MASK		BIT(5)
+#define BQ25792_REG2C_IBUS_OCP_MASK		BIT(4)
+#define BQ25792_REG2C_IBAT_OCP_MASK		BIT(3)
+#define BQ25792_REG2C_CONV_OCP_MASK		BIT(2)
+#define BQ25792_REG2C_VAC2_OVP_MASK		BIT(1)
+#define BQ25792_REG2C_VAC1_OVP_MASK		BIT(0)
+
+/* FAULT Mask 1 */
+#define BQ25792_REG2D_VSYS_SHORT_MASK		BIT(7)
+#define BQ25792_REG2D_VSYS_OVP_MASK		BIT(6)
+#define BQ25792_REG2D_OTG_OVP_MASK		BIT(5)
+#define BQ25792_REG2D_OTG_UVP_MASK		BIT(4)
+#define BQ25792_REG2D_TSHUT_MASK		BIT(2)
+
+/* ADC Control */
+#define BQ25792_REG2E_ADC_EN			BIT(7)
+#define BQ25792_REG2E_ADC_RATE			BIT(6)
+#define BQ25792_REG2E_ADC_SAMPLE_MASK		GENMASK(5, 4)
+#define BQ25792_REG2E_ADC_AVG			BIT(3)
+#define BQ25792_REG2E_ADC_AVG_INIT		BIT(2)
+
+/* ADC Function Disable 0 */
+#define BQ25792_REG2F_IBUS_ADC_DIS		BIT(7)
+#define BQ25792_REG2F_IBAT_ADC_DIS		BIT(6)
+#define BQ25792_REG2F_VBUS_ADC_DIS		BIT(5)
+#define BQ25792_REG2F_VBAT_ADC_DIS		BIT(4)
+#define BQ25792_REG2F_VSYS_ADC_DIS		BIT(3)
+#define BQ25792_REG2F_TS_ADC_DIS		BIT(2)
+#define BQ25792_REG2F_TDIE_ADC_DIS		BIT(1)
+
+/* ADC Function Disable 1 */
+#define BQ25792_REG30_DP_ADC_DIS		BIT(7)
+#define BQ25792_REG30_DM_ADC_DIS		BIT(6)
+#define BQ25792_REG30_VAC2_ADC_DIS		BIT(5)
+#define BQ25792_REG30_VAC1_ADC_DIS		BIT(4)
+
+/* 0x31-0x45: ADC result registers (16-bit, RO): single full-width field */
+
+#define BQ25792_ADCVSYSVBAT_STEP_UV		1000
+#define BQ25792_ADCIBAT_STEP_UA			1000
+
+/* DPDM Driver */
+#define BQ25792_REG47_DPLUS_DAC_MASK		GENMASK(7, 5)
+#define BQ25792_REG47_DMINUS_DAC_MASK		GENMASK(4, 2)
+
+/* Part Information */
+#define BQ25792_REG48_PN_MASK			GENMASK(5, 3)
+#define BQ25792_REG48_DEV_REV_MASK		GENMASK(2, 0)
+
 struct bq257xx_device {
 	struct i2c_client *client;
 	struct regmap *regmap;
 };
+
+enum bq257xx_type {
+	BQ25703A,
+	BQ25792,
+};
+
+struct bq257xx_plat {
+	enum bq257xx_type type;
+};

-- 
2.52.0


