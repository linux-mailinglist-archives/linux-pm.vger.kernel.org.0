Return-Path: <linux-pm+bounces-34985-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14942B8628B
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 19:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C170256271C
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 17:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEBA31960C;
	Thu, 18 Sep 2025 17:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePNcaYi0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906573191DD
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215220; cv=none; b=tMe1AZEWUt2Zs79aF4k6Q8yAtOt7QUCjokNl6gyFd5UANsNGzdIZBYyEVpjTkTYbhQJVM/x5Zulucr2hJhmvFvvY1xqYBJhhb49hPshD5byofxcmGRfxvm5AmLohgngDUmD4RmwHZR3tqiFPns/4fCe45EQLubArNTwe9FE9QEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215220; c=relaxed/simple;
	bh=p0Y001LouGzRYgngGf5yjavclhIzGKKVPJlTdhfMZA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HE1LsfFv786pRlv+ftJERU7l9m73UFwTdBxajoDuK8tYDRQpclabzQyqbc2w08SzsCfZHmzE+bmDl8vPjid95VVChjqEmplq3bWP8oI0aB24Dt708m7/5eD9NlntPjuEnxS6dU7ZBjPNSEO+RdvnRRggMSHqPccgOMdYFIO84P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePNcaYi0; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b07e3a77b72so331694266b.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 10:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758215217; x=1758820017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/IIuik5CE+0p4i4XUTzTjvbxx21RfH5UCzEfl75uMA=;
        b=ePNcaYi0NYXJ594ciXRztGPdQJvh5G9RM0wTpkWOqYoHF2880HuUNKLN/rVBc3PcfD
         VvigLkzwZ1k+jOVEfO0xh/NJ79nNZfXPzIT4lPH/NH1GGo/qencca1OhlLoB8fmQVPwI
         /Hylgcl4ebdxjhy3rRSAILmC6uR/KEN8uubdnp0H+re/wOxoDJQ4RV1BVOXNCTj9LuT4
         ldBw70i76Zpnpy3pO+42Rcmnf5oMcoTS/QbyFU67W59TiV+XvrcdaD32orQ9D6hEnDLN
         vBenGSoueXZ000MZ3NeWuhNsqTXX6DqQ8f05MTaXVrN74XuQHJ/jhzTmwdbxxXSTMOu7
         HEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758215217; x=1758820017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/IIuik5CE+0p4i4XUTzTjvbxx21RfH5UCzEfl75uMA=;
        b=F/JRQ9InNW/fPltsT8JlkACTxmuRZf6aaUaQeKNbbhZhp7Bj5t5KNAi2WjK1+2dIkn
         Hy+Av/vCx6xp14dCJVlMvC+KPQUbUyDzP0spKfNO6q/TYd8BZtCPdnaI2KEkgVnGjXHa
         p5SEtquoOgGd9nT8X6vMrLkSn5fhHf2SDMJsXF+mMZ0R9YVHmj3hEISq/Unrh99bxbNb
         QOSKyW8VlxQ7T5M3TXvTMXbt4MfELdG1LHXCyovG/7c49VMrvPl4ISPku2GiYBmieQPX
         mFQSw5IJzwuzEDzt44+JkM/dIC5pQlV+TrRIoOtWl0LmQ7/IPm0Z29ILUE+rscXum6Sm
         5oWg==
X-Forwarded-Encrypted: i=1; AJvYcCUNP9hk6s/S2ds+5q9l3X6UexEeABlSaQzwE/CQM7me8LS016xFG247g7BtjeKcn/TgKmuS1e/a5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPf7JdOsCdHH6tZ16WpyNVmSAjDVQbTdliZlVwUSwNVegY0W/0
	/C8BOwbfZEAQyif4vaIMHfYg55yhwVSyYN7mL6FDqzbNLWaLLfILW71t
X-Gm-Gg: ASbGncvgnOTLT6jQcIEkojO8YMlDBvO4Ii5A9+QGNrAshTdKJ2d7h0P57RevglL0wEG
	1jhaCGtjnUOTzJ1pju8l9gThrHh6LRAUWID/XlmxSjxy9T39hnY92RR1h+b6FYyZcZS9ItF8hBJ
	RH+Dgph4aLl5PCf2zCiAj9wcCa5CUaxa3cUFuL1kOPluLPWXEFPxmKJbS4+0FueU6Rz1ko78Rvv
	F61HY0FrVdY67VxzFP0VjTsoalSADkGLwP8f0Xt5vzLCT3eOe0kub5plgyXlAmNeSXdUNzhBVkv
	KLUzoNG97JlS82Wdf08N1eZpduGSqtkdWY9XN7U0sdbyora467f0IL9TRBMNIyfxv0F/69WOUru
	3Q/Di+bkoBodbHJvXU1lCS2spkBN9KDtqAJ/YBoA=
X-Google-Smtp-Source: AGHT+IFJXGsnfRuXnGhNyUp+s17bIwH2J9IJyICxXejXnotTF3zx54YprzQcXlmTDWODob125Eq0YQ==
X-Received: by 2002:a17:907:6ea5:b0:b04:2dd0:98 with SMTP id a640c23a62f3a-b1faa41447amr487140366b.12.1758215216824;
        Thu, 18 Sep 2025 10:06:56 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b1fd271f895sm225845366b.97.2025.09.18.10.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 10:06:56 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 18 Sep 2025 20:06:51 +0300
Subject: [PATCH v4 7/9] power: supply: max77705_charger: rework interrupts
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-max77705_77976_charger_improvement-v4-7-11ec9188f489@gmail.com>
References: <20250918-max77705_77976_charger_improvement-v4-0-11ec9188f489@gmail.com>
In-Reply-To: <20250918-max77705_77976_charger_improvement-v4-0-11ec9188f489@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758215207; l=3015;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=p0Y001LouGzRYgngGf5yjavclhIzGKKVPJlTdhfMZA8=;
 b=kJ8QFTSv9rLZNHYA6EG0iVEYoNxQCaZcTUPSXBqboxBpRWBLw6i2RPDq64r+FWBOvjL87ZKaV
 b6k/tDBpI3YDnCZiOnlWXTDimwI6jeyX8WHFHmU9SyOhmK4sBi8Z5d5
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Current implementation uses handle_post_irq to actually handle chgin
irq. This is not how things are meant to work in regmap-irq.

Remove handle_post_irq, and request a threaded interrupt for chgin.

Fixes: a6a494c8e3ce ("power: supply: max77705: Add charger driver for Maxim 77705")
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes to v4:
- remove IRQF_SHARED flag, because interrupt is no longer shared
- use IRQF_TRIGGER_NONE, because this is not physical irq
- fix intendation
- replace pr_err with dev_err_probe
- commit msg: remove blank line

Changes to v3:
- move irq initialization after workqueue and charger initialization
---
 drivers/power/supply/max77705_charger.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index 3062411dcb45..5c8e46627cb0 100644
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
 
@@ -608,7 +601,7 @@ static int max77705_charger_probe(struct i2c_client *i2c)
 
 	max77705_charger_irq_chip.irq_drv_data = chg;
 	ret = devm_regmap_add_irq_chip(chg->dev, chg->regmap, i2c->irq,
-					IRQF_ONESHOT | IRQF_SHARED, 0,
+					IRQF_ONESHOT, 0,
 					&max77705_charger_irq_chip,
 					&irq_data);
 	if (ret)
@@ -630,6 +623,15 @@ static int max77705_charger_probe(struct i2c_client *i2c)
 		goto destroy_wq;
 	}
 
+	ret = devm_request_threaded_irq(dev, regmap_irq_get_virq(irq_data, MAX77705_CHGIN_I),
+					NULL, max77705_chgin_irq,
+					IRQF_TRIGGER_NONE,
+					"chgin-irq", chg);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to Request chgin IRQ\n");
+		goto destroy_wq;
+	}
+
 	ret = max77705_charger_enable(chg);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to enable charge\n");

-- 
2.39.5


