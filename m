Return-Path: <linux-pm+bounces-43830-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBBzIfbmqmkTYAEAu9opvQ
	(envelope-from <linux-pm+bounces-43830-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 15:38:46 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF7C222D4E
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 15:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2600316AA1B
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 14:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9859234AAEA;
	Fri,  6 Mar 2026 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="37oNFRs0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0435E271A94
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807606; cv=none; b=RsALnMBVbO5uI8aUCbJnpOLbQLyn690o2yyKG8tEEJF24NIM9cqN9xCntb7l7E4WMoTDnJftTyU0P5L4mlgpNG7AyAgEUqasdO197O3kcr8VeDGjCozip8U9fN7s7VEr5T+D/dFeEVC74e/GZJIiTg/NIp0wrstpgYtcR6zmjAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807606; c=relaxed/simple;
	bh=6WH6bA59l7A4239NaRyToL++eIBKP9VFtNt1SDkD3qc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ehuux8Pq/4pBvoSs51BwdDjrAEfiHFqAQvqAPNSI4+aHtUHBtWCaCT0FPWaWECsvQlqDoEg4Rqmj/or4Aslm13cXyYE39PbmGGpPST6WdaOvoH//eUSwTR+YYvJwyXZDEsQ2IrqgwJHYmCp/oWt4FPTnOAT5gJ2KBVmJxTiXvMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=37oNFRs0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439c5b40f60so2756713f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 06:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1772807602; x=1773412402; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kv9yW7nD0xBquE/Q0Gt4SkecfyIoKpDK3EsDR/0rlXU=;
        b=37oNFRs0D4LPmJrJGNv8a4ymZXAsfdUyefr97juF5pdrCsadzKA1ry7xBCmQXwqL8O
         x67gND6cN6FPyC5YnxVka+9RKixb4bGRnwDRdY59ceBTRYpRakONEuevm8poGqgKwuTL
         YIpq7tCPubDqeazOWeXZbTm1C/pQpCSX9MkgNKpp+2o8G80+iSedySqaYw8I93D5KxjB
         kcypsoEyaUeipBHXUG4PTEU82tAbCTlbREZBIU48vjTAfOIZa2w0eetWo7mGu9XXLp2q
         FJoDoIBoJNIaKjcnUDg5+8u+t2AE/CuVj5BlTg5cO5XpABwDqqeL0C6WpojhSgjkCiIi
         LwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807602; x=1773412402;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kv9yW7nD0xBquE/Q0Gt4SkecfyIoKpDK3EsDR/0rlXU=;
        b=fFoqgeuUbByZliYzVXJAr5BOrh1ArkXMaQw7kZ/GMPagjLMT9DfQTN40DyCTZ+HPdb
         FRPVBM2JVHleV2XlM64wmXM/EhXKrDbPVENrfnCS6zANFga46+I3Qf9lc9IKeOWAs5ka
         8KkqLVadYVxoWqXMBiTfBcSKE6H2+Q+yckehb6tLaghOu4o65lLUWAVPQcHfMzJncJae
         Xok3ZIg3BHUoBA0eCjjvZ9KxXOmgRz6tTRbBI7hX8CY+rPfSha1l4k6sGDsiAS5SgF2l
         70B8VuUjNYltVB1yo6hgVPmmpvyYvO8aLmNu/BLSbzRkIagkGwjmlBOfKW2QUSCVeJV9
         9R+A==
X-Forwarded-Encrypted: i=1; AJvYcCWD4C203Ji23rd0d+jIFRhjreqGjCLjm0SgpEvmQFmDsY71gZfbySq/wol+7HZzknNWPFyFW2Wcrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhcW3qDYf5GaPdiWIWPEr7HtFAxi1gxctox1G40PrGUbeSe2Zj
	wn8TRzoqUY3kGfw6scVBk83hxeW76SYHtcbtmETkQnIQXgNB0vrsDarkw76iDZ+/oT/Aq1x8Y6C
	i6NY1
X-Gm-Gg: ATEYQzzJguc9mVoV1Z8ow8sJfQoKPJFmKIbrhfUB8WRUcH7GizcEe6aNhkdnvLIDnpn
	Ha0S8iVvOATNefcebdy6LvVzYP5ar5ff8Hh92dhM3KseJ8Gs3IOS+V7SVJxG/fnj20viAeuY4aI
	Xc4pVvtWNbF/GkxsnbLYVHSmPYw409Vt9kyAoVcQY2CwzyKholFskTzeo3ObKiixr5zg9GZadAu
	bzWWUMygiDCdVhW3Sl2Fes0i1fLqH//mvmmz+JjR7N50qiOtbPaD33KnYrCxCoAI8X6/KtigptU
	q/5gHA9PrZWTV4cpOB4+3XdmDhpV26JhNvRRPP4sKRT02SnOOPdXbnBzlc/tlJnWviyaVDmiSmN
	EltDrFGO3lIPlwuLw9p1OrDJf9qcKbFKE8fx/l9xYv7b1bY2RTlW/iozBS0vPLhSVSr6ndSrbuf
	rfO1ClmTmcHlOE2eVPU3GvvSKGkH4Iz8giAOFQZVYiXUKfj3EjHCnxPYhf9y1k2p0Z+ct+8zNnu
	LIBfw==
X-Received: by 2002:a05:6000:40cb:b0:439:bdba:56c9 with SMTP id ffacd0b85a97d-439da348351mr4423578f8f.2.1772807596136;
        Fri, 06 Mar 2026 06:33:16 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8daf2sm4635281f8f.2.2026.03.06.06.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:33:15 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 06 Mar 2026 18:33:02 +0400
Subject: [PATCH v2 02/11] regulator: bq257xx: Remove reference to the
 parent MFD's dev
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-bq25792-v2-2-6595249d6e6f@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2662; i=alchark@flipper.net;
 h=from:subject:message-id; bh=6WH6bA59l7A4239NaRyToL++eIBKP9VFtNt1SDkD3qc=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSuerrk2pUZe+4+m/S6YP9il6Wvi++qaNTKLlLrObCil
 uXfkkezzTsmsjCIcTFYiimyzP22xHaqEd+sXR4eX2HmsDKBDJEWaWAAAhYGvtzEvFIjHSM9U21D
 PUNDHWMdIwYuTgGY6oWeDP9TOZP37T4m5vS8PoZ34S5Pn3ruM5t4jxfEnOYwrrbj++7IyHDhfZ0
 Wa/vl35MdeYxCO+dOmbdR0+72W5XVnRN8N+xZY8MIAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Rspamd-Queue-Id: BCF7C222D4E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43830-lists,linux-pm=lfdr.de];
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

Drop the ->bq field from the platform data of the bq257xx regulator driver,
which was only used to get the regmap of the parent MFD device, and use the
regmap from the regulator_dev instead, slimming down the code a bit.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/regulator/bq257xx-regulator.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/bq257xx-regulator.c b/drivers/regulator/bq257xx-regulator.c
index dab8f1ab4450..812938e565e3 100644
--- a/drivers/regulator/bq257xx-regulator.c
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -15,7 +15,6 @@
 #include <linux/regulator/of_regulator.h>
 
 struct bq257xx_reg_data {
-	struct bq257xx_device *bq;
 	struct regulator_dev *bq257xx_reg;
 	struct gpio_desc *otg_en_gpio;
 	struct regulator_desc desc;
@@ -23,11 +22,11 @@ struct bq257xx_reg_data {
 
 static int bq25703_vbus_get_cur_limit(struct regulator_dev *rdev)
 {
-	struct bq257xx_reg_data *pdata = rdev_get_drvdata(rdev);
+	struct regmap *regmap = rdev_get_regmap(rdev);
 	int ret;
 	unsigned int reg;
 
-	ret = regmap_read(pdata->bq->regmap, BQ25703_OTG_CURRENT, &reg);
+	ret = regmap_read(regmap, BQ25703_OTG_CURRENT, &reg);
 	if (ret)
 		return ret;
 	return FIELD_GET(BQ25703_OTG_CUR_MASK, reg) * BQ25703_OTG_CUR_STEP_UA;
@@ -40,7 +39,7 @@ static int bq25703_vbus_get_cur_limit(struct regulator_dev *rdev)
 static int bq25703_vbus_set_cur_limit(struct regulator_dev *rdev,
 				      int min_uA, int max_uA)
 {
-	struct bq257xx_reg_data *pdata = rdev_get_drvdata(rdev);
+	struct regmap *regmap = rdev_get_regmap(rdev);
 	unsigned int reg;
 
 	if ((min_uA > BQ25703_OTG_CUR_MAX_UA) || (max_uA < 0))
@@ -52,7 +51,7 @@ static int bq25703_vbus_set_cur_limit(struct regulator_dev *rdev,
 	if ((reg * BQ25703_OTG_CUR_STEP_UA) < min_uA)
 		return -EINVAL;
 
-	return regmap_write(pdata->bq->regmap, BQ25703_OTG_CURRENT,
+	return regmap_write(regmap, BQ25703_OTG_CURRENT,
 			    FIELD_PREP(BQ25703_OTG_CUR_MASK, reg));
 }
 
@@ -137,7 +136,6 @@ static void bq257xx_reg_dt_parse_gpio(struct platform_device *pdev)
 static int bq257xx_regulator_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct bq257xx_device *bq = dev_get_drvdata(pdev->dev.parent);
 	struct bq257xx_reg_data *pdata;
 	struct device_node *np = dev->of_node;
 	struct regulator_config cfg = {};
@@ -149,7 +147,6 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
 	if (!pdata)
 		return -ENOMEM;
 
-	pdata->bq = bq;
 	pdata->desc = bq25703_vbus_desc;
 
 	platform_set_drvdata(pdev, pdata);

-- 
2.52.0


