Return-Path: <linux-pm+bounces-43507-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCCMEcUBp2k7bgAAu9opvQ
	(envelope-from <linux-pm+bounces-43507-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 16:44:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 404451F2DB6
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 16:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F43730581AC
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 15:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C13492520;
	Tue,  3 Mar 2026 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="gDZUH6xn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37FD49219A
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772551988; cv=none; b=p55uYqg4f/BLNDJKRpZktgzlqjtJhMN3FDrZEIF6uln6xmM2zcwZjM/8e7NAi4Z2eVbz+xnVEJllL7RXU/ilyUVhxxJWw4bsH7LkzFv+VrqnatM6eEDx4GYyUNRPeovTN1DRuMEC6qABhm6ZY57C0z4addv2BgKreqWOsSjbHys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772551988; c=relaxed/simple;
	bh=ZNpu1+QLWxDyG8uNZKHnXwGDlRkKFAgQ4JrcxwH4TZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SAR+Is5sR6X8VtHZv48kpKZ/jKtljd1U6ShVt7fGmTbwpUUfa0b+01oMEZxlZubTSnGO1eJwXLwSvADmRm5Uvin/zdm3tj4BjXLO4veObsCBB2xdTpFz0WdQnbsSQeNGgcNDLX1segVFrdY/AaLRscRp6DeqpdBtsTvz4viimUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=gDZUH6xn; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4806bf39419so50078635e9.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 07:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1772551985; x=1773156785; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLnt0eflN8lFiwNCVheUlKB9RjgppzFmTMI48rlcPq0=;
        b=gDZUH6xnJnMVraydxDq+OROEvC3FUg/U1K2AxIP4AYhL1bwajLJ+qqcQfUD1RdWt8k
         tvy7Y32oxd9AF5rF+w8KD67C4XAlSQfl2n8Dh1YrXtXxUYwnwi9aTgZQAvSdZUNZt9gr
         J2Ysq+0+8U65bJcULh6NoNvfDXrDACVEw/Y/GvFOxWgbU4wYFRetnWYCTOS6KWP2qG0w
         FG6Rkd2mM70QJC4NKBtbE3qa0Zkmo/n5387S2ypUWnIcKX6Qb/Xq/AZ2K6OzCltTXPiV
         c/NFVrV7D5E4WX89dtn+kuOb8ZBMWXnPVWW8czX8dC/ODz6NRiOEHTdK2SKYPZ3BXYfL
         0dKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772551985; x=1773156785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eLnt0eflN8lFiwNCVheUlKB9RjgppzFmTMI48rlcPq0=;
        b=JeK6JvPpeRPhQnMvhr+iOR6cSOh2f0bTgVCMZNCz6QrYrJmRLbbu342MleyVOVsf20
         fQcPmQa/g76sz/EQc6vhPmJ3lM3Bl0ns0OhnqimsdDlZiALQWDorPevaw3ThL/RweDOa
         lpJuo15WHIk/548RRi77soudA531F7EvwqJ5AKSfdU1Pse98uNybmjAqWtfMUVY6pIvl
         1v9M/5rm/aonPJjy23tQrAXN7wOPw8eWfjpIrhTpe805vBUzZAVORwTLCs7YTTqVN7Wb
         87nlFmoJGS7P4JQNtxYVepbtkXW3h1NzsMcXl896l0pTKmUzdBi5ziKZcUi2YglrS0bp
         qs5g==
X-Forwarded-Encrypted: i=1; AJvYcCV5jmN24tllsxw8kIw1ZoB+dOULY7bnRuXdHIV0sfYAQPHk7kt4DOR1hK3PH1ItrPCJeVTmuf0D5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCMDJ75mChDAknSDYjOYCBx1MXxKRPvKfSQo39sAHRc98sIabc
	/wn6aAKI5jOAfm7Orx6Kmh7UJSAJHuBCVqteVBkD3JDbcvJOS9heW7eckR16UVooWkM=
X-Gm-Gg: ATEYQzxrOrWKorKjlkkEdxnidM9QHdYvWrG1kGGrvUcOwEuvwOaOfZZaVFAv9CnvMJn
	J4butoUZSoEv+0q455gl5qiHDkvgRKCwAjQ38O81KbSzCNAxlD2DAD4Pl3Z+ZrGWq7mrd5gq+fY
	u7t/quNvtncfmDbVwHBQ1sVMS45pE/QMFhmG67oK/y+oHjSLIR9c0Q5iJbCtHhChN7aVovOfpGA
	VjGNrPuWhrr9ZkCulbBwDfRWZyPei6gzPK5wcW/po1TwBxLpGOQwL71uvEvDcIbkqZiCUlcs9k8
	fBR2IiP/ga42PHN1dpiOuLKBg40Cp2anbCt2Fu1Ouj42TQELEHxwX5MdIYR8nTKoc2j86ooZZvk
	L8ohqCJm0+ekKF9ksxhIG8uTinsYOSv8kaXFlcdOPNplmI6Tj/8yw5ltjImhuaX124dr5dn06ND
	lqn5Dkg3+Op+VyzGVQvEY5PkAkFxkVv2mOKecXpBpyu2fTX1U2DdzNqIbbGNlkkKYp7TZ+4dtFF
	bE=
X-Received: by 2002:a05:6000:228a:b0:439:b556:fa4a with SMTP id ffacd0b85a97d-439c1144015mr5476802f8f.31.1772551985166;
        Tue, 03 Mar 2026 07:33:05 -0800 (PST)
Received: from alchark-surface.localdomain (bba-94-59-44-101.alshamil.net.ae. [94.59.44.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b55d15besm19799447f8f.30.2026.03.03.07.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 07:33:04 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 03 Mar 2026 19:32:48 +0400
Subject: [PATCH 03/11] regulator: bq257xx: Drop the regulator_dev from the
 driver data
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-bq25792-v1-3-e6e5e0033458@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1549; i=alchark@flipper.net;
 h=from:subject:message-id; bh=ZNpu1+QLWxDyG8uNZKHnXwGDlRkKFAgQ4JrcxwH4TZY=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQu+6/2PiNJhmNqyJP9Ww5NPzmrUO3UYatycT+vSg01C
 WnlSCOhjoksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0FDHWMeIgYtTAKZaw5Hhv5MRx0rWQj7dB/cWxNucuSVZalV2kZnpdIHyL5uYd2kdExkZjritVn8
 4jWEx96ZTBnfPzTMX/ym988iG/ge51480x6iYcAEA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Rspamd-Queue-Id: 404451F2DB6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43507-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,hotmail.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[flipper.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flipper.net:dkim,flipper.net:email,flipper.net:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

The field was not used anywhere in the driver, so just drop it. This helps
further slim down the platform data structure.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/regulator/bq257xx-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/bq257xx-regulator.c b/drivers/regulator/bq257xx-regulator.c
index 812938e565e3..674dae6109e9 100644
--- a/drivers/regulator/bq257xx-regulator.c
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -15,7 +15,6 @@
 #include <linux/regulator/of_regulator.h>
 
 struct bq257xx_reg_data {
-	struct regulator_dev *bq257xx_reg;
 	struct gpio_desc *otg_en_gpio;
 	struct regulator_desc desc;
 };
@@ -139,6 +138,7 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
 	struct bq257xx_reg_data *pdata;
 	struct device_node *np = dev->of_node;
 	struct regulator_config cfg = {};
+	struct regulator_dev *rdev;
 
 	pdev->dev.of_node = pdev->dev.parent->of_node;
 	pdev->dev.of_node_reused = true;
@@ -159,9 +159,9 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
 	if (!cfg.regmap)
 		return -ENODEV;
 
-	pdata->bq257xx_reg = devm_regulator_register(dev, &pdata->desc, &cfg);
-	if (IS_ERR(pdata->bq257xx_reg)) {
-		return dev_err_probe(&pdev->dev, PTR_ERR(pdata->bq257xx_reg),
+	rdev = devm_regulator_register(dev, &pdata->desc, &cfg);
+	if (IS_ERR(rdev)) {
+		return dev_err_probe(&pdev->dev, PTR_ERR(rdev),
 				     "error registering bq257xx regulator");
 	}
 

-- 
2.52.0


