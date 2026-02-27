Return-Path: <linux-pm+bounces-43289-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKrYIyFFoWkirwQAu9opvQ
	(envelope-from <linux-pm+bounces-43289-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 08:17:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E641B3BD6
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 08:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7426D3172541
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 07:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709563A0E85;
	Fri, 27 Feb 2026 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ghKYGctr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1F31B424F
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176518; cv=none; b=QEbV+CGlyQ6oSl2e3Qvrf1IWGHg5fKMOp7xHBZy2fHweS+leZSupG/t/VhliuOl7lSVGw0CxA4zRT297tKJ4F40KYsLYItebiFBonhz5oNtMk0trmuTORayQdRfak3qTTdH9J7whBdaNtnfxsOaKrqxMpfrkFHXfeT4+/J7hibE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176518; c=relaxed/simple;
	bh=fv/17d6jilgTODgpruVYpOT+gHVFDnCbMA/pv2NE/eM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ei6a2dGfMEWJigejPhQbGsuvQ/NDZxI/cdM2mlVKP3b6s4rwW/9RjjVv1nPA9CpifwRjX02e4n6xWylOOO47yUac0fJ2HUlpFQYYqU/o5S5ilxSiEZrDjmo10rGpGe3P9yccGoK+w618DNpgY+w8onCB8P6qxhAtu8r/bwsNWBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ghKYGctr; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b932fe2e1a7so241754066b.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 23:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772176514; x=1772781314; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VcFko9vHiFHIBVVslk4GTSxZFkyv6j0wJU+j7yMMfnE=;
        b=ghKYGctrtFaY4MWW1ANKPGcRHwnxBUaSU2Zn8jc0+wlzyhuZWyBGJhfo/LZ3yXRrh/
         WFVDcpkESfdQZHvoYuy07XLA7tOVCo0KafHt7KhII2FW4ufru6wthhzskI9eM8TIxHLY
         jURmwyuVUCxmPgovhzRbFd3agWT3O0Mj8XdDOkC6Rn2RoUzq3U+XBo7tfGNpOm5ZR9Xm
         7WvbuTEU/u+thjZUw/oQsd9QSP7P4ROTnochNNo73NI1W5uqTIcPQiMy884DO96QQ4oz
         +KYpIJW2g+BzgRmZ6gEo6sou5O+m/Rznzj1iXWu4JjM9qpcDxEHZiry5m2H8Spi6NSQr
         llcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772176514; x=1772781314;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VcFko9vHiFHIBVVslk4GTSxZFkyv6j0wJU+j7yMMfnE=;
        b=v3P5HP/PYDSTOT0wlZtpO5v8TUUc0mSN969NPUXRQaYQe7+l+O3Az7jFB/chfIYS8J
         6w4upxC/6IGzVUB2Jpx9P3iJ4L9SyJ2wb9jzS66wfDn4jABhVfMlObXTIx1yzh7KnqJm
         nBOCNdTlP3pH1NkdeRlW/73uyKfWLSskFXvSUdJF/45ZLJKfxVE+P/YV0TvBCjloVsAc
         UC1jMPEW4EyJJbXWqv10Fp9UTiUHEsWV9rsuk3O0QKvKI4UkCbuRUn3YctKQbeNFZVYT
         bw1wMg33MmLVnF2zlaA4Oh/u1APn2AfRZqYuygDF2tdNu379Y9bA5jJf5Fjh6c5REWaD
         VFKA==
X-Forwarded-Encrypted: i=1; AJvYcCWVACGgVs93OWjqRVtv2kelmj0cnFVB6y7+EA/ErpoQUPYR4E04o7FtH9WwUv3dTzj8zYNmOf9gcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGng0GuTH3YIwEjZiLXWZtvOxIjQU6f3c53RyGszR2juKgOP02
	iFb7PR6gl6c+1Gt5NEhB57GJWaS1vasFpcjHvX3x0IHz1jrru6p71FBVYyK7IiDqTC8=
X-Gm-Gg: ATEYQzxobf2kF3o4zuD6mj6xu5SaH8xn48ZPg9Hf72YmtczFwdhNk4OlDFH17NkFNHj
	2AIt5ffR4ZFxGFCiPBVD6Jxx9i6j7LJy/V3OU47b6FckWQAVvGtv8XADPBsxKCWmIw3Zk1tPqGh
	aSKeKWhvErp+uTkr6dmPlxPa+Bf7J/BEU0/evk0ldtoOsnt/k3gquGhbRSaTzbTU1PZYt/QQ5BQ
	xmSPzBFPFDvBf1eG/ecHlfW1luGiOXJVrdZpTZGMMagdYezrggiKMUNNVI8RHjd099mgVTUOKsu
	+E17dr1cO/viUhA1YKagYukCuQZUIrQjAk28LELXbgzJ1lj0Sxt3SRZ7s5JU/0G/jddFfBDiZSH
	ErgPgHC9C42xURklx2VzMqKa99sZQLOV3Kn0F+HcVtZPfg6pmj+CZeiEpM0JA8/xHmDoiza5FLi
	KCvXhlOPDp+qx77iwzXbjVcepsAtBmPBVxUbFmNi5zBUf9A0t4bIWmA6sN+oSiq48rG1hDxg3hF
	jrW86Ze5b6/iIKOBQ==
X-Received: by 2002:a17:906:f59a:b0:b8f:abff:9ce7 with SMTP id a640c23a62f3a-b93764f4640mr94258566b.32.1772176514119;
        Thu, 26 Feb 2026 23:15:14 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935aeee867sm124205066b.66.2026.02.26.23.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 23:15:13 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 27 Feb 2026 07:15:14 +0000
Subject: [PATCH v2 09/11] power: supply: max17042: initial support for
 Maxim MAX77759
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260227-max77759-fg-v2-9-e50be5f191f0@linaro.org>
References: <20260227-max77759-fg-v2-0-e50be5f191f0@linaro.org>
In-Reply-To: <20260227-max77759-fg-v2-0-e50be5f191f0@linaro.org>
To: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43289-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:mid,linaro.org:dkim,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6E641B3BD6
X-Rspamd-Action: no action

The Maxim MAX77759 is a companion PMIC intended for use in mobile
phones and tablets. It is used on Google Pixel 6 and 6 Pro (oriole and
raven). Amongst others, it contains a fuel gauge that is similar to the
ones supported by this driver.

The fuel gauge can measure battery charge and discharge current,
battery voltage, battery temperature, and the Type C connector's
temperature.

The MAX77759 incorporates the Maxim ModelGauge m5 algorithm. It, as
well as previous generations like m3 on max17047/max17050, requires
the host to save/restore some register values across power cycles to
maintain full accuracy. Extending the driver for such support is out of
scope in this initial commit.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v2: fix typo MAX77759_T_convert -> MAX77759_Tconvert
---
 drivers/power/supply/max17042_battery.c | 59 ++++++++++++++++++++++++++++++---
 include/linux/power/max17042_battery.h  | 24 ++++++++++++--
 2 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 823533ea5a17..44626abdab34 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -654,7 +654,8 @@ static void max17042_write_config_regs(struct max17042_chip *chip)
 	regmap_write(map, MAX17042_RelaxCFG, config->relax_cfg);
 	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17047 ||
 			chip->chip_type == MAXIM_DEVICE_TYPE_MAX17050 ||
-			chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055)
+			chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055 ||
+			chip->chip_type == MAXIM_DEVICE_TYPE_MAX77759)
 		regmap_write(map, MAX17047_FullSOCThr,
 						config->full_soc_thresh);
 }
@@ -791,7 +792,8 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
 
 	if ((chip->chip_type == MAXIM_DEVICE_TYPE_MAX17042) ||
 	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17047) ||
-	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17050)) {
+	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17050) ||
+	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX77759)) {
 		max17042_override_por(map, MAX17042_IAvg_empty, config->iavg_empty);
 		max17042_override_por(map, MAX17042_TempNom, config->temp_nom);
 		max17042_override_por(map, MAX17042_TempLim, config->temp_lim);
@@ -800,7 +802,8 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
 
 	if ((chip->chip_type == MAXIM_DEVICE_TYPE_MAX17047) ||
 	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17050) ||
-	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055)) {
+	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055) ||
+	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX77759)) {
 		max17042_override_por(map, MAX17047_V_empty, config->vempty);
 	}
 }
@@ -1023,6 +1026,45 @@ static const struct regmap_config max17042_regmap_config = {
 	.val_format_endian = REGMAP_ENDIAN_NATIVE,
 };
 
+static const struct regmap_range max77759_fg_registers[] = {
+	regmap_reg_range(MAX17042_STATUS, MAX77759_MixAtFull),
+	regmap_reg_range(MAX17042_VFSOC0Enable, MAX17042_VFSOC0Enable),
+	regmap_reg_range(MAX17042_MLOCKReg1, MAX17042_MLOCKReg2),
+	regmap_reg_range(MAX17042_MODELChrTbl, MAX17055_TimerH),
+	regmap_reg_range(MAX77759_IIn, MAX77759_IIn),
+	regmap_reg_range(MAX17055_AtQResidual, MAX17055_AtAvCap),
+	regmap_reg_range(MAX17042_OCVInternal, MAX17042_OCVInternal),
+	regmap_reg_range(MAX17042_VFSOC, MAX17042_VFSOC),
+};
+
+static const struct regmap_range max77759_fg_ro_registers[] = {
+	regmap_reg_range(MAX17042_FSTAT, MAX17042_FSTAT),
+	regmap_reg_range(MAX17042_OCVInternal, MAX17042_OCVInternal),
+	regmap_reg_range(MAX17042_VFSOC, MAX17042_VFSOC),
+};
+
+static const struct regmap_access_table max77759_fg_write_table = {
+	.yes_ranges = max77759_fg_registers,
+	.n_yes_ranges = ARRAY_SIZE(max77759_fg_registers),
+	.no_ranges = max77759_fg_ro_registers,
+	.n_no_ranges = ARRAY_SIZE(max77759_fg_ro_registers),
+};
+
+static const struct regmap_access_table max77759_fg_rd_table = {
+	.yes_ranges = max77759_fg_registers,
+	.n_yes_ranges = ARRAY_SIZE(max77759_fg_registers),
+};
+
+static const struct regmap_config max77759_fg_regmap_cfg = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = 0xff,
+	.wr_table = &max77759_fg_write_table,
+	.rd_table = &max77759_fg_rd_table,
+	.val_format_endian = REGMAP_ENDIAN_NATIVE,
+	.cache_type = REGCACHE_NONE,
+};
+
 static const struct power_supply_desc max17042_psy_desc = {
 	.name		= "max170xx_battery",
 	.type		= POWER_SUPPLY_TYPE_BATTERY,
@@ -1049,6 +1091,7 @@ static int max17042_probe(struct i2c_client *client, struct device *dev, int irq
 {
 	struct i2c_adapter *adapter = client->adapter;
 	const struct power_supply_desc *max17042_desc = &max17042_psy_desc;
+	const struct regmap_config *regmap_config;
 	struct power_supply_config psy_cfg = {};
 	struct max17042_chip *chip;
 	int ret;
@@ -1064,7 +1107,12 @@ static int max17042_probe(struct i2c_client *client, struct device *dev, int irq
 
 	chip->dev = dev;
 	chip->chip_type = chip_type;
-	chip->regmap = devm_regmap_init_i2c(client, &max17042_regmap_config);
+
+	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX77759)
+		regmap_config = &max77759_fg_regmap_cfg;
+	else
+		regmap_config = &max17042_regmap_config;
+	chip->regmap = devm_regmap_init_i2c(client, regmap_config);
 	if (IS_ERR(chip->regmap))
 		return dev_err_probe(dev, PTR_ERR(chip->regmap),
 				     "Failed to initialize regmap\n");
@@ -1245,6 +1293,8 @@ static const struct of_device_id max17042_dt_match[] __used = {
 		.data = (void *) MAXIM_DEVICE_TYPE_MAX17055 },
 	{ .compatible = "maxim,max77705-battery",
 		.data = (void *) MAXIM_DEVICE_TYPE_MAX17047 },
+	{ .compatible = "maxim,max77759-fg",
+		.data = (void *) MAXIM_DEVICE_TYPE_MAX77759 },
 	{ .compatible = "maxim,max77849-battery",
 		.data = (void *) MAXIM_DEVICE_TYPE_MAX17047 },
 	{ },
@@ -1257,6 +1307,7 @@ static const struct i2c_device_id max17042_id[] = {
 	{ "max17047", MAXIM_DEVICE_TYPE_MAX17047 },
 	{ "max17050", MAXIM_DEVICE_TYPE_MAX17050 },
 	{ "max17055", MAXIM_DEVICE_TYPE_MAX17055 },
+	{ "max77759-fg", MAXIM_DEVICE_TYPE_MAX77759 },
 	{ "max77849-battery", MAXIM_DEVICE_TYPE_MAX17047 },
 	{ }
 };
diff --git a/include/linux/power/max17042_battery.h b/include/linux/power/max17042_battery.h
index c417abd2ab70..05097f08ea36 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -105,7 +105,7 @@ enum max17042_register {
 
 	MAX17042_OCV		= 0xEE,
 
-	MAX17042_OCVInternal	= 0xFB,  /* MAX17055 VFOCV */
+	MAX17042_OCVInternal	= 0xFB, /* MAX17055/77759 VFOCV */
 
 	MAX17042_VFSOC		= 0xFF,
 };
@@ -156,7 +156,7 @@ enum max17055_register {
 	MAX17055_AtAvCap	= 0xDF,
 };
 
-/* Registers specific to max17047/50/55 */
+/* Registers specific to max17047/50/55/77759 */
 enum max17047_register {
 	MAX17047_QRTbl00	= 0x12,
 	MAX17047_FullSOCThr	= 0x13,
@@ -167,12 +167,32 @@ enum max17047_register {
 	MAX17047_QRTbl30	= 0x42,
 };
 
+enum max77759_register {
+	MAX77759_AvgTA0		= 0x26,
+	MAX77759_AtTTF		= 0x33,
+	MAX77759_Tconvert	= 0x34,
+	MAX77759_AvgCurrent0	= 0x3B,
+	MAX77759_THMHOT		= 0x40,
+	MAX77759_CTESample	= 0x41,
+	MAX77759_ISys		= 0x43,
+	MAX77759_AvgVCell0	= 0x44,
+	MAX77759_RlxSOC		= 0x47,
+	MAX77759_AvgISys	= 0x4B,
+	MAX77759_QH0		= 0x4C,
+	MAX77759_MixAtFull	= 0x4F,
+	MAX77759_VSys		= 0xB1,
+	MAX77759_TAlrtTh2	= 0xB2,
+	MAX77759_VByp		= 0xB3,
+	MAX77759_IIn		= 0xD0,
+};
+
 enum max170xx_chip_type {
 	MAXIM_DEVICE_TYPE_UNKNOWN	= 0,
 	MAXIM_DEVICE_TYPE_MAX17042,
 	MAXIM_DEVICE_TYPE_MAX17047,
 	MAXIM_DEVICE_TYPE_MAX17050,
 	MAXIM_DEVICE_TYPE_MAX17055,
+	MAXIM_DEVICE_TYPE_MAX77759,
 
 	MAXIM_DEVICE_TYPE_NUM
 };

-- 
2.53.0.473.g4a7958ca14-goog


