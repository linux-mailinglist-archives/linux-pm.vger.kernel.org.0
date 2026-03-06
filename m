Return-Path: <linux-pm+bounces-43837-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOR+HKfpqmmOYAEAu9opvQ
	(envelope-from <linux-pm+bounces-43837-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 15:50:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE62122310F
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 15:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32849319B4F1
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 14:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F36839890F;
	Fri,  6 Mar 2026 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="1UiaYzMc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077273B3BE1
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807619; cv=none; b=dMiKtaaKsPJ46CrQT/BDwjpMBzpfetuksuxc6F1fDxdCfAOXQ8EV0YbFPLcVt1/o2GtstM9HiSoDUMJyAcQgGjrD0h3VfwN+UVqEIAOfNVSNYB7pA7y4JnPIKmxfa1pP9IprC9gFFGj5xkCqJV7cgGlmkE32c09tHsTypZkyjYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807619; c=relaxed/simple;
	bh=nOduz00h5fpXPu+UdGV0hj0gdsgtcCrHjSqgzrZqdz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J+DRJHDidCtBrShAi7Hp8etLHM82Q5WiqfrMR7nq8w2OtBFL5wGsGRTq2vmcdzTy6Zan7ea84oVh+nNI+XIz9Hcke9rvP9QPUnKnEN6Byhg7oRpV8KGi2tbjso9CEFGdN7qshjazHcgVBXTvmF4tJk4rfMezuDkyXua9DWGaSvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=1UiaYzMc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48370174e18so56591015e9.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 06:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1772807614; x=1773412414; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmALN9MGA9u53yKJNFJzqfov+Z/gHizGgvZq4z1BuiI=;
        b=1UiaYzMcSfP7ZBvCg7SonG1dAPs/eUonkzG2pTOrqqPWkfOT/Vp3q5QNrnex01K16Z
         yhMfw3zG37QlUbBUbHi9AFKisnnQxbGbxLTyxtB+O4k9yO6ufPR1O8vHj/zeVnfXQIAl
         Ef+JACheewOfyMREaTpcnAp1mE6Ciw8Hemg+tiPD1xO7/v1g+nvdFKHNd2/2EJROe+FT
         0pulxZ4G2t9Y5RWhhTtSq6gduMN0xCyGbZjgBGUnjVj6j4EXApMJGAajb6ESb8pXseZo
         0MxbPTLSnyQUQG6nY5jNpbEQnXNP8gsreq7LqnIZRZakTgvkkq+g1kLIuUdkkC8Zfrj7
         wQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807614; x=1773412414;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JmALN9MGA9u53yKJNFJzqfov+Z/gHizGgvZq4z1BuiI=;
        b=gnYp5f4MBKFZ4dSDKHH7+EDD4gdWnlp/xoFzEyvxR0iotI8/NYe4zRZ6nY2ACtxzrN
         VSA7HefsP8nA8A1Imt0bwb8doABT7eqwUlXDPprWfhySYZK3fnyUsmg8YLwYlVjmd7VD
         uAhpRL+X3AoSlFti9ltsB+0yIQj6Rg43xnRM5z4YZgK3XebYC1C2S/CPUDJ7wRNMrAyM
         MdSTWLwd5MMgTeJAyzXUBe6DP1k7acf5Pl5I3dBL89dmVQYclzJ4cLet+WvWo0zioZ+U
         nGOAvQLMkQ0m1ob2N09BMbz8pajxZomFhgpuy1XJtJjwtEQr5gO296Wct0YF0hVNHERz
         0q0w==
X-Forwarded-Encrypted: i=1; AJvYcCXWtQ6vKunvdPe2tj3JjqtxZhXUtkiwErZj1xZFPB0i0sf+Nfn/s2+VhZ5jOvGgdsuxqF+Fl2n3pw==@vger.kernel.org
X-Gm-Message-State: AOJu0YygXrV53ZFrskFspFBsfMEAvdYwyAkMeFBapF0FVKUaGMCNctOa
	CsuxXvspA5Nzul+JHx9LVJHfDJEif4v8Izg0z5UXVuHC+x9LpH5tcu78Wkdxdk8Bngc=
X-Gm-Gg: ATEYQzw+VNtv2tAuIqqRcP0ikLE3T7yf/KYoNr72t6HRVkw4b8zmBr6jQbaRAPtnbWH
	5fB81tiRg49skEtacyc8SpabTZ/zSiVqXGQwxeo6/CeYxAvS2Qof6BVr1Yp8cpI9QAKGWZDjz8H
	UsNaj2BGDlxIvwMtXWXY+e+ufQ4qO2NVMQRb0EFnlbIRbWGV6o90v1WEyWh59HHNcrDwX0NwNpi
	FALecYC0yVDPxuW0fWEtLsDCywk0M/ztVM9oaML5BfeINW2Qi3QGEmkjuF0I19KmueRn2AxUYYU
	JBoYa/QeiJ5X8h2iuDKau/C0bm7261dz9k/7CwlaDxev+CsC9DJ0E3ZoFQ8x3w8JNnu1aFFVuGT
	a8qFiGnUitCFYu5DMd8FwFsYCpHFPBapfRShyMcHe1WaabyT0tyKdbFTQSkRo8bv1S1AhVg1VIM
	juUmP1SctB9+bMD5DKvMzKaAJxZ3PPfJy4xO7PzceUeGTO815YpFYnr/nsDk0ADdsJyZRfLiAgv
	NOubpqFO+TbLOIl
X-Received: by 2002:a05:600c:a12:b0:483:badb:618f with SMTP id 5b1f17b1804b1-48526966b07mr36088075e9.25.1772807614272;
        Fri, 06 Mar 2026 06:33:34 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8daf2sm4635281f8f.2.2026.03.06.06.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:33:34 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 06 Mar 2026 18:33:09 +0400
Subject: [PATCH v2 09/11] mfd: bq257xx: Add BQ25792 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-bq25792-v2-9-6595249d6e6f@flipper.net>
References: <20260306-bq25792-v2-0-6595249d6e6f@flipper.net>
In-Reply-To: <20260306-bq25792-v2-0-6595249d6e6f@flipper.net>
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
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSuerrkmEWz3uHz3x89CT288I7OxrbKz8/u7XiSZuT8Y
 IFYVcKMio6JLAxiXAyWYoosc78tsZ1qxDdrl4fHV5g5rEwgQ6RFGhiAgIWBLzcxr9RIx0jPVNtQ
 z9BQx1jHiIGLUwCm+vwdhv9ptpcDpPuMQpbb3ndoNTknnZ8gkRxx8HOB09Pe1Iu2iUGMDKc4Ny3
 irH194P6pgyyWEi3hnj+b7VvN3RhS2g6cO7r9MBcA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Rspamd-Queue-Id: DE62122310F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43837-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,hotmail.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[flipper.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,flipper.net:dkim,flipper.net:email,flipper.net:mid]
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


