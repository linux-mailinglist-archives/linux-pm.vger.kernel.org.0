Return-Path: <linux-pm+bounces-43506-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DvDIf8Ap2k7bgAAu9opvQ
	(envelope-from <linux-pm+bounces-43506-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 16:40:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C381F2D0B
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 16:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CAC0319539E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 15:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44D44921B8;
	Tue,  3 Mar 2026 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="L3Gr6aU/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6999F492187
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772551985; cv=none; b=pCOJMrZMN890PCuc5ys2oSYlkU4PsNCYShKWRppGWmtvbg19YXidPzyVR6oBreMfZ1F992Yj9v/84r9SrDGPgjrBJqr07ZjxCz0ll+h9nMijlKueBfeyK03z7sfRoO5uLPBNU0l1w1pU9rrjMpIdjwvDDvRAx/I4XrsjCYYGZ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772551985; c=relaxed/simple;
	bh=6WH6bA59l7A4239NaRyToL++eIBKP9VFtNt1SDkD3qc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uWYGyA3eXzPOJwWfSBz8iSRaqhrtmr6ieE6Kcew7yVcHrSXOgViKXOQe47B/T17yA5EVPoaHKbCGQ2AoKwjOUsTXN/Unc2FNoLoX+QUL/4guhPYLcVcPdwlRxXTiQ1uIDm42yRIW9gLR2gI625HhwtIpsZZwnyEZLZVvnISANKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=L3Gr6aU/; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439c5b40f60so68461f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 07:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1772551983; x=1773156783; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kv9yW7nD0xBquE/Q0Gt4SkecfyIoKpDK3EsDR/0rlXU=;
        b=L3Gr6aU/zWJEBAPbbwYqeSGnyqvie0VG4BKb7K7n6ymJXpiB8830xMpKpOphfH8SB8
         sw4jzb7kzW7maHOwKuS9DRoFSE3npLbO/OBrTGLf+lTlyO94v/wEkiMVEBzh3toM8Ak+
         fZweulPqgOLqA1moGTMH0wWRMSwB1OgnkYNX2EN5ZjOkdNg+IJR5UzKhra4+4J9caZl0
         /gv159f5o/KZO0zH/neDj+/96HBkIxLrTskdTV3lunzbKFMQSyp9AmKOC3vMSChEMFF1
         KjDJi456g8fx8cgTxHAWm+j4rrO+ZhOsXdQ4uPleQhEEnj+5n83I7s6ckMSD9etg+m83
         y0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772551983; x=1773156783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kv9yW7nD0xBquE/Q0Gt4SkecfyIoKpDK3EsDR/0rlXU=;
        b=wYiabahc504L2HCxwLtIMf0/CIkk9kj7fX7sZzfU+YzLRdORS5gAxEfi1s3PUIhvic
         yhQq8MvQKQ86/z1lGyg5P5Abd7GN36R4m88hkIrMwp/+cJtZpNfxLxMgn8+GpweNAPt3
         9Ty6P0CN8Q/E5gXXbMSEY8jPKcozJF67F4yI0xsLnYF8mTNfQ36lBogzf+XIrO4OZNG5
         KzKrMgEQoc9ALJ3tovP9DC793jjWaNwtx4Y7pd0A9DecyOM+E8KFCCRdAXlsVqIE/d+z
         LkJs0+fj7ioaOE9CbbArVbbzntlhx/Dlh4N35c5tuLOPzXB1YtgTNHMrJtwjKZd0VsOm
         lcIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5lBD6SccQIR/IDgl9TzbH17VGyEhYp+ec36QK9bBLKa588jiBawVPX07fGTOcvux+Dgfdoq1yHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDpKNBwNI97u+KfAPHicNPyfhm508xJAIoTl1GLlYxBVoF9DMJ
	vK1lPkrfiwuTV49W2Ojv4CB5UcI6K3tBsxjEBXVn7qnZwpgEaURIQMzY6HmamJTo0UY=
X-Gm-Gg: ATEYQzyqqXti8kMgAqM83TFrB29RguGwA6Vp91RD8U1hxioHYhDW89v0yJwwMoQ9LgJ
	/+gpbw9bkFhszhljI13oziEevMYcsu0LslTpGerTyrOjTLZBg96Ep7uRY0F/4mbFgim71raPecT
	KDy933UobtQsFtC72f0nifqapiKdzY+EB6ThSgdXDH5uaGQwUpvjnGhC09ob8siW2cvd6GTreE6
	Ha6nQWhniLGZTNJIN09E3nfBugmbvhP6V9rx5ehYo8sKMaLWTm0ORNHlr2u8NS+HXhBHaXutsDz
	eGWsxMi5ngVetHVpPE5A0wbvgidHcjTCLJVdDYi/g8VbG/SP2u2zpnhrN68PG39yZLMv2bz7An/
	ybYUPxM2EbR/C3adyQgnyAX/VrouPAjJfj0YJlTx4XzeWzWGSEtyUQPf28Wq977E+Y04ZkjlbH4
	FEVgejCpSqobT2wftBtLLKfN2jtpMS38ikZjA51ow56gl3I8W6MmDjcEXjWQ62PMH9NVJfTF/mn
	6k=
X-Received: by 2002:a05:6000:1ac6:b0:439:c018:60ec with SMTP id ffacd0b85a97d-439c0186392mr5466091f8f.30.1772551982660;
        Tue, 03 Mar 2026 07:33:02 -0800 (PST)
Received: from alchark-surface.localdomain (bba-94-59-44-101.alshamil.net.ae. [94.59.44.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b55d15besm19799447f8f.30.2026.03.03.07.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 07:33:02 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 03 Mar 2026 19:32:47 +0400
Subject: [PATCH 02/11] regulator: bq257xx: Remove reference to the parent
 MFD's dev
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-bq25792-v1-2-e6e5e0033458@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2662; i=alchark@flipper.net;
 h=from:subject:message-id; bh=6WH6bA59l7A4239NaRyToL++eIBKP9VFtNt1SDkD3qc=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQu+6+WIdXV+OiN0n+2M+GHjx94k862dPbeT8vUOnL8f
 x+RdSgI6ZjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DA11jHWMGLg4BWCq76cwMsy/eSrWYlucRUNOx9//O5N2e2V8Pzzn3cK3lS+XPFFJkjzM8D8gf1b
 Nc8lHS32+7m3ocTO/eSfve5DAPWWXwtaCCqNlOVwA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Rspamd-Queue-Id: E3C381F2D0B
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
	TAGGED_FROM(0.00)[bounces-43506-lists,linux-pm=lfdr.de];
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


