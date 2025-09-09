Return-Path: <linux-pm+bounces-34297-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F11AB50540
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 20:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 457235448AB
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 18:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A67F36299B;
	Tue,  9 Sep 2025 18:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBoghBsw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC50C2FB606;
	Tue,  9 Sep 2025 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442582; cv=none; b=NN17xccVEODDHCw8UUNcMUyauEiZzywX8BCzB37T8vId1GQqFkW98JnkGdTI1tVu3B+gk3fPU42pZY+cfQCJjfNw40Vgtd6vjc2AvDVsli/PxaLhtj05mWo1ivSMPqA7lYgFwXw5qIP1M1LMwCe26t67fa6KFdd4keqeQpXQ84I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442582; c=relaxed/simple;
	bh=AOZdHI28joffYImWPpnLzx5R7A6JCfptSZlkeOeIOYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QmAqOCWWOU/NluKu7ikAzZs5fVKyJZO65fT+NTQ/tzrSTTtgvxu27Jl0/IJB2osoKLCUhQqEHnmDFGqcxBJNVEXkjC8YagcN8daQdUdHKXaif+TDNTw0zaVd3WsgfNnwgvZAjShDcnuvAFWadQYPGUMMTRJZ9fJeBYkg7kQZD9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBoghBsw; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b00a9989633so249548166b.0;
        Tue, 09 Sep 2025 11:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757442579; x=1758047379; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzUQISPfSnlkW3kJz7YjgfNYemqJ20idPrIcwsmfNes=;
        b=HBoghBswzGd63tfRxmvQBEZKGcE35ysuDjmFadp0YistDkMFZ5XRgaGBDg6mRdx3gw
         xCGOP73Az2Ssslx2hS4aNh4qA9eTZI242gsHUALCZfgAywar1CVDKKMuzYBT3AklMUeq
         vmJKmlFOP2OKGwzkXS1OGH1R6LXR1sYd6fmvqjEW43WuKGI2+TN57qgpyLYWXyfZxtp2
         qsd58o89LJcVUuXoXgUEkIefX0ggiAm+3tZGgRnuIbj0nM2OCGm6Yu8bxJ6ObwX/4Ogc
         zjHsJgcISIC7pbfDkZXRNM35NzchEahfENxeESsfQ7GKo4a6R7vn7PaYt4zcN7F7n3Zi
         8cQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757442579; x=1758047379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzUQISPfSnlkW3kJz7YjgfNYemqJ20idPrIcwsmfNes=;
        b=IizSVCen6pZ2qAt60P0rOm5bhmU91iZ/TCBpSajp/r6lJFxrueIVy00A7G4cJo6wLG
         016m08J/F/0YcEkcnMJzLDJfU60dM1oTtLfV+5AIY40kdSeFdAdzybCzyjMzeX2PQvM9
         qRTc1JjBFfBkbLWbeT1bENmpDaoCV/7yX+OnplFAsmbUwiOQsx2DlbC6FfSVdNaZb+ak
         gBOdb2Vylo5Ehi9SEaypKKjjHYDAlxPBkt0Xe2kvJwqLDydixHumq02HTTLeAKsXLIna
         rcyrIElR1jzoHfxaZyf+TdYaqdORvRBUouQLlmwCXViL3QhX1+fQxInOKoPCQ3qbIvxh
         M1sg==
X-Forwarded-Encrypted: i=1; AJvYcCUnv+mmRKIbAItFcEZdAQKUHakztGHV0mum0c++dGNxuLr8odQv5h0doiIYDtAM5bdxs6NjYjzopvWEw3o=@vger.kernel.org, AJvYcCXtPqPK722yv8Zn3D5/ymckwAQzC2Db9k2sM5skFU1T61j21zahKQabdXfLPPW027lkzLP/i5KZIJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6R7qRVy5SUHen+ZN1BkH3nlZul7NzJrTbAj1Uxe3L6BaBfyqg
	P0eMLoXsHo6kCep8AqKohA2eeCi+rAXpGyJ+twUi67OwQTWk1iicweae
X-Gm-Gg: ASbGncv+QFoy2R95F0jz8uVxEcld2yjI/3Es9friiR5o3qUOMUgSySm7Ro9xdSvG376
	7pvG6jk4Ohh3YYaYpJmQoZet9fzCaMmF5dUZwNSdlN3q2g38n+bCXBCcEJwkIDvzKBqq4G+mhiN
	egJbLcbvXdGUFqxraDnnIOcLLFFjQ1eARSgNU9najCH/Tg4tzjzv9xLN/sfF8IS8/EJ5LyWpNCK
	VXIfFHzd7KDBJxhEj/y0X8IC1zJklcHqORHwaOHnLkn4Nca5dvSW+Y658PyktiJZMCm/vj0pUOY
	C5PPYguM+sjScFCkYPfEvZZoey4lbMOqc23/bvxbG75jiiEC+zCcf0D0kfFyKH7iw6hkYFZTrjA
	pDGIJwnWaU+Q+CsacfPCO5sbcQiujYYk=
X-Google-Smtp-Source: AGHT+IHQtkSFgpYIb6iSuxElFUCAOmSnPT66isQRP6YYymUqLVyiijDHJ/yH5TUXJNCdRGysLT9gkg==
X-Received: by 2002:a17:907:1c26:b0:b04:23e0:5c2b with SMTP id a640c23a62f3a-b0492e105e9mr1812319466b.0.1757442578918;
        Tue, 09 Sep 2025 11:29:38 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b07833ebe61sm30520666b.89.2025.09.09.11.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:29:38 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 09 Sep 2025 21:29:16 +0300
Subject: [PATCH v2 6/9] power: supply: max77705_charger: rework interrupts
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-max77705_77976_charger_improvement-v2-6-a8d2fba47159@gmail.com>
References: <20250909-max77705_77976_charger_improvement-v2-0-a8d2fba47159@gmail.com>
In-Reply-To: <20250909-max77705_77976_charger_improvement-v2-0-a8d2fba47159@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757442571; l=2452;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=AOZdHI28joffYImWPpnLzx5R7A6JCfptSZlkeOeIOYw=;
 b=DWmY9B7YzsPwPPQ/M7aqpAbYkjkWy5uklAWkZ+VBulSv+3ZTrTYzn9Tg/8o8S2srYf/nQLxAt
 v5DQaeMng69AU/n9HBZqbOmoxGIuYz0ywXdUAuY73Nt/8tkTbkO7rTN
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Current implementation uses handle_post_irq to actually handle chgin
irq. This is not how things are meant to work in regmap-irq.

Remove handle_post_irq, and request a threaded interrupt for chgin.

Fixes: a6a494c8e3ce ("power: supply: max77705: Add charger driver for Maxim 77705")

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/power/supply/max77705_charger.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index d6a3cd98c898..4e5219ffa87c 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -40,13 +40,13 @@ static enum power_supply_property max77705_charger_props[] = {
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 };
 
-static int max77705_chgin_irq(void *irq_drv_data)
+static irqreturn_t max77705_chgin_irq(int irq, void *irq_drv_data)
 {
 	struct max77705_charger_data *chg = irq_drv_data;
 
 	queue_work(chg->wqueue, &chg->chgin_work);
 
-	return 0;
+	return IRQ_HANDLED;
 }
 
 static const struct regmap_irq max77705_charger_irqs[] = {
@@ -64,7 +64,6 @@ static struct regmap_irq_chip max77705_charger_irq_chip = {
 	.name			= "max77705-charger",
 	.status_base		= MAX77705_CHG_REG_INT,
 	.mask_base		= MAX77705_CHG_REG_INT_MASK,
-	.handle_post_irq	= max77705_chgin_irq,
 	.num_regs		= 1,
 	.irqs			= max77705_charger_irqs,
 	.num_irqs		= ARRAY_SIZE(max77705_charger_irqs),
@@ -593,12 +592,6 @@ static int max77705_charger_probe(struct i2c_client *i2c)
 					     "cannot allocate regmap field\n");
 	}
 
-	ret = regmap_update_bits(chg->regmap,
-				MAX77705_CHG_REG_INT_MASK,
-				MAX77705_CHGIN_IM, 0);
-	if (ret)
-		return ret;
-
 	pscfg.fwnode = dev_fwnode(dev);
 	pscfg.drv_data = chg;
 
@@ -614,6 +607,15 @@ static int max77705_charger_probe(struct i2c_client *i2c)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to add irq chip\n");
 
+	ret = devm_request_threaded_irq(dev, regmap_irq_get_virq(irq_data, MAX77705_CHGIN_I),
+				 NULL, max77705_chgin_irq,
+				 IRQF_TRIGGER_HIGH,
+	"chgin-irq", chg);
+	if (ret) {
+		pr_err("%s: Failed to Request IRQ (%d)\n", __func__, ret);
+		return ret;
+	}
+
 	chg->wqueue = create_singlethread_workqueue(dev_name(dev));
 	if (!chg->wqueue)
 		return dev_err_probe(dev, -ENOMEM, "failed to create workqueue\n");

-- 
2.39.5


