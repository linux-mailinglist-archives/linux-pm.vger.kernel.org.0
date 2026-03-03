Return-Path: <linux-pm+bounces-43514-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKtzBz4Bp2k7bgAAu9opvQ
	(envelope-from <linux-pm+bounces-43514-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 16:41:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B60FF1F2D4D
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 16:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C65DC31CEC52
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 15:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9914963D0;
	Tue,  3 Mar 2026 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="vIk6CawK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F238549551E
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772552006; cv=none; b=Qo+4HnarnAV8pP15J/wi6I70sxO9KA30jZ8Lrtd6HTulJauDgUIlze00MemFRGtHxMh2zu6HZk/sKpwLlLoToG3gxp9sfJn5HCdj3GnCQwQ/fAK/Ch8gfX8qV7ELzAsXUCZSomCGHW4Q0VWKbZgSUE3e+ny5vBvXLVHo8xmdXPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772552006; c=relaxed/simple;
	bh=iH5mpCf1lNBTH6mjGzgCdLsQQcgDZGR7r/s9cFLXbD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ez+SLAaZnTpj4g6+KTRZx0lkGAYeysXpZEwiKstQGc7Yn1RhDMEg+/mcIghUJTyBdTmnd7+bnCWjnxML5ZU5GtLZ7aRy/o9hoZrqJRb3mB4Pm1NoW3TzRWUMUN/PmUqDZE5dNBCPidIyS9l7EokvyEuNEEtH4gkimU03XEV/DKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=vIk6CawK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439bcec8613so1393743f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 07:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1772552003; x=1773156803; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0cRGptLewZHd2CZtw6bpbZKdXjz61WL20vAMVdyWWU=;
        b=vIk6CawKtirR22ttrbQrVJ+vLO4d85c/j1tg5tW+HNP3aSrG3hCTf0wuqL2M9WOFRa
         DLBO0RXgIQKNMdnfKZyKi7bioVXpeiZqCydXGSe7dCJ1IKEEc8icrJnsVIm6Oa3xBW1z
         Txu7E6LZoSgcdaHOEt+kd9FoEqLNIOqGMJM0wbb2rewfSEtQ0Sl3VsmHUySMmSR0Zcrl
         16XJ/WbSGiUyJB5L1NEbYaTf1qsrK+H4tzU6Iu449x4PfHivGkiylhQWMV/8sbtaLNDc
         rB434QUXJPmDq/S6/MUvPDeYuqotJhDGLyLKlhTkAoYw3C6AH5mk0nIROc0RUPn+c/YZ
         7C0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772552003; x=1773156803;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T0cRGptLewZHd2CZtw6bpbZKdXjz61WL20vAMVdyWWU=;
        b=pZ+PcHy4JaK8WdQojg46KTo0ZVFCb8U1786s9EfgC7+KYKH9QtIcrYuXaS3jFFa4S3
         O34uaN3wfrCTH6S01B/fQDh8YHqVLvvOlJXSzvMxQpb5Y/zZfrXpoxznplyWeXLIuCrz
         l5qVyW9Cjg0QelnazhyWulQaxR8gF0GGsIwKPjm8JaC2ct/ioPJxiL8sYqArZQQrRzKb
         Rfq6oNZqh85r6cwG4ojNwvelVvV4hFdb8atilhxmJEa/voxK3/C9K/RJ3JOWnIx3LkZs
         xGPDeB/xyxU55CHSI1XxJtnBD5t4uYDA++GKqUWM6fFQEx5E8SPQVEl/L6X9XpPGDbNK
         xNyA==
X-Forwarded-Encrypted: i=1; AJvYcCVYUpssKltNgVZugk7FIPNMnvvHN8WoKRZpNDaSEDhK8iKZg4yMu+eL9WiuWMY7R+dtrOQCjp2w8w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw63RNHQ95ie4HA/vM+03K2U3h5cdrSszPxyBLpFx39v4YNzBVg
	KtT7GAHqKMhO0qr8DqIz3GC21NtaLFVBhVoIOTXoY5taed5unXRDx8iNG3EH6oRxBeo=
X-Gm-Gg: ATEYQzweGaNosDUyEhW7hvHRUcATxuIIQ5uFcgAO2zYr9qUfoXCMrAgtOo3GE4TrOaL
	rZbyDds9o02seugHiu+WGfEVO5yKfldqjyyB8myalnjitQm/OionKvGE9HuMAoB/VKfB7JOg8H8
	149b36eAI1MpY9o5fLsT8kIf+oSnFJvBuUxEjpDfcxO6cjZKKDjmyuwz3Mgv7ugZDzjpOQydV2k
	z2GWWkR4ZzngWAMq0s7VJEeyZBF8Qu30/fdKzWDRFQdtW3Mn5fMVj8yVertQnHHjzTToS09Gz/A
	HuEc913SGRdjp7rGkY7NNsGiF7/tfIs1xsTFtZwc962rSdP/nEcARGifEe8w4KqIyo3A18rEruy
	EGN2+X+T/AbE4q0+ZZ+GodENClnXCZV4sW6UX3JH7LIDUbjWxAWYVH11MGOTIjxMoP40dycpayz
	Yc9ICfOOtrRyAm9nnW24LKRwPf+oihwAtnRnz6WTCnF2s/dP3HnEuZ4fmiVoBStWbPfnXesv2gw
	Bw=
X-Received: by 2002:a05:6000:184a:b0:439:bdba:56c9 with SMTP id ffacd0b85a97d-439bdba5734mr9542710f8f.2.1772552003293;
        Tue, 03 Mar 2026 07:33:23 -0800 (PST)
Received: from alchark-surface.localdomain (bba-94-59-44-101.alshamil.net.ae. [94.59.44.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b55d15besm19799447f8f.30.2026.03.03.07.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 07:33:23 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 03 Mar 2026 19:32:55 +0400
Subject: [PATCH 10/11] regulator: bq257xx: Add support for BQ25792
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-bq25792-v1-10-e6e5e0033458@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4990; i=alchark@flipper.net;
 h=from:subject:message-id; bh=iH5mpCf1lNBTH6mjGzgCdLsQQcgDZGR7r/s9cFLXbD4=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQu+6+edvD78jerm593h24XUxXreONoMjmJrdJY3O+Oc
 5LrtmtJHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oaGOsY4RAxenAEx1mwQjw+Y5qza1duqEL2Vz4mmSdGlsPaqxuejfj7/lJm7OzRxXrjAyTLoyW+h
 lXGQ8n83rd3/eN151E5OfeWXC9Pojfp3sl7Un8AEA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Rspamd-Queue-Id: B60FF1F2D4D
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
	TAGGED_FROM(0.00)[bounces-43514-lists,linux-pm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flipper.net:dkim,flipper.net:email,flipper.net:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add support for TI BQ25792, an integrated battery charger and buck/boost
regulator. This enables VBUS output from the charger's boost converter
for use in USB OTG applications, supporting 2.8-22V output at up to 3.32A
with 10mV and 40mA resolution.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/regulator/bq257xx-regulator.c | 98 ++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/bq257xx-regulator.c b/drivers/regulator/bq257xx-regulator.c
index 0bb58ab4b8d4..61911ac8613a 100644
--- a/drivers/regulator/bq257xx-regulator.c
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -31,6 +31,32 @@ static int bq25703_vbus_get_cur_limit(struct regulator_dev *rdev)
 	return FIELD_GET(BQ25703_OTG_CUR_MASK, reg) * BQ25703_OTG_CUR_STEP_UA;
 }
 
+static int bq25792_vbus_get_cur_limit(struct regulator_dev *rdev)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	int ret;
+	unsigned int reg;
+
+	ret = regmap_read(regmap, BQ25792_REG0D_IOTG_REGULATION, &reg);
+	if (ret)
+		return ret;
+	return FIELD_GET(BQ25792_REG0D_IOTG_MASK, reg) * BQ25792_OTG_CUR_STEP_UA;
+}
+
+static int bq25792_vbus_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	__be16 reg;
+	int ret;
+
+	ret = regmap_raw_read(regmap, BQ25792_REG0B_VOTG_REGULATION,
+			      &reg, sizeof(reg));
+	if (ret)
+		return ret;
+
+	return FIELD_GET(BQ25792_REG0B_VOTG_MASK, be16_to_cpu(reg));
+}
+
 /*
  * Check if the minimum current and maximum current requested are
  * sane values, then set the register accordingly.
@@ -54,6 +80,37 @@ static int bq25703_vbus_set_cur_limit(struct regulator_dev *rdev,
 			    FIELD_PREP(BQ25703_OTG_CUR_MASK, reg));
 }
 
+static int bq25792_vbus_set_cur_limit(struct regulator_dev *rdev,
+				      int min_uA, int max_uA)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	unsigned int reg;
+
+	if ((min_uA > BQ25792_OTG_CUR_MAX_UA) ||
+	    (max_uA < BQ25792_OTG_CUR_MIN_UA))
+		return -EINVAL;
+
+	reg = (max_uA / BQ25792_OTG_CUR_STEP_UA);
+
+	/* Catch rounding errors since our step is 40000uA. */
+	if ((reg * BQ25792_OTG_CUR_STEP_UA) < min_uA)
+		return -EINVAL;
+
+	return regmap_write(regmap, BQ25792_REG0D_IOTG_REGULATION,
+			    FIELD_PREP(BQ25792_REG0D_IOTG_MASK, reg));
+}
+
+static int bq25792_vbus_set_voltage_sel(struct regulator_dev *rdev,
+					unsigned int sel)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	__be16 reg;
+
+	reg = cpu_to_be16(FIELD_PREP(BQ25792_REG0B_VOTG_MASK, sel));
+	return regmap_raw_write(regmap, BQ25792_REG0B_VOTG_REGULATION,
+				&reg, sizeof(reg));
+}
+
 static int bq25703_vbus_enable(struct regulator_dev *rdev)
 {
 	struct bq257xx_reg_data *pdata = rdev_get_drvdata(rdev);
@@ -101,6 +158,34 @@ static const struct regulator_desc bq25703_vbus_desc = {
 	.vsel_mask = BQ25703_OTG_VOLT_MASK,
 };
 
+static const struct regulator_ops bq25792_vbus_ops = {
+	/* No GPIO for enabling the OTG regulator */
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear,
+	.get_voltage_sel = bq25792_vbus_get_voltage_sel,
+	.set_voltage_sel = bq25792_vbus_set_voltage_sel,
+	.get_current_limit = bq25792_vbus_get_cur_limit,
+	.set_current_limit = bq25792_vbus_set_cur_limit,
+};
+
+static const struct regulator_desc bq25792_vbus_desc = {
+	.name = "vbus",
+	.of_match = of_match_ptr("vbus"),
+	.regulators_node = of_match_ptr("regulators"),
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+	.ops = &bq25792_vbus_ops,
+	.min_uV = BQ25792_OTG_VOLT_MIN_UV,
+	.uV_step = BQ25792_OTG_VOLT_STEP_UV,
+	.n_voltages = BQ25792_OTG_VOLT_NUM_VOLT,
+	.enable_mask = BQ25792_REG12_EN_OTG,
+	.enable_reg = BQ25792_REG12_CHARGER_CONTROL_3,
+	.enable_val = BQ25792_REG12_EN_OTG,
+	.disable_val = 0,
+};
+
 /* Get optional GPIO for OTG regulator enable. */
 static void bq257xx_reg_dt_parse_gpio(struct platform_device *pdev)
 {
@@ -141,6 +226,7 @@ static void bq257xx_reg_dt_parse_gpio(struct platform_device *pdev)
 static int bq257xx_regulator_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct bq257xx_plat *plat = dev_get_platdata(dev);
 	struct bq257xx_reg_data *pdata;
 	struct device_node *np = dev->of_node;
 	struct regulator_config cfg = {};
@@ -153,7 +239,17 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
 	if (!pdata)
 		return -ENOMEM;
 
-	pdata->desc = bq25703_vbus_desc;
+	switch (plat->type) {
+	case BQ25703A:
+		pdata->desc = bq25703_vbus_desc;
+		break;
+	case BQ25792:
+		pdata->desc = bq25792_vbus_desc;
+		break;
+	default:
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "Unsupported device type\n");
+	}
 
 	platform_set_drvdata(pdev, pdata);
 	bq257xx_reg_dt_parse_gpio(pdev);

-- 
2.52.0


