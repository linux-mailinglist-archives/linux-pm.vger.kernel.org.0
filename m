Return-Path: <linux-pm+bounces-33477-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABE0B3CF56
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 22:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF6C34E23B6
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 20:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629652E8B86;
	Sat, 30 Aug 2025 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmGMQi6a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF8C2E88A1;
	Sat, 30 Aug 2025 20:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756586735; cv=none; b=jld0gTR0FoaD5Hyg0IrqiwR8QFKt5Vs69vz+QS1AhYQvUrOP80aL9lHuOnnRJylhm93tgMTZmBDkEJRks17wH9leplwmBgM5N/fZwFaGPZTA3Lyhl2Cm3ewi1R8MbbwPENt6Xg+q752gXxIa2TJ54+DZ/l92LU3kd/ZTMj5X7ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756586735; c=relaxed/simple;
	bh=qL3ZSipERey4NoCLgTbU79RMORcnpfoRjIAATnOpcf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HvT4KXFWspMmrOnvwca5nhGf9C1G93cfSjKQYgsjz9+/s4IQ5qTzYM7nN6+s3ByDCCNCz+RRWbvw76+x/lovNgw2o8e97tg2URS8DUIoP20nJ6daDnTc/u7R/C4Ki5r6UCx+SCJkKWF2p1Ixqsyczu6oaXMlvGHWonuRAzsbYHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmGMQi6a; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7ae31caso593984466b.3;
        Sat, 30 Aug 2025 13:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756586731; x=1757191531; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J9oPXDxDztkt2wKDii5YBhYWKt30/7ueii2AEtKAIno=;
        b=YmGMQi6a/zdBoLtmSHetlpQ+Vpxvs7a1IoMVVNy7aB2QfvqHWDYVeaXzPOukK3TaiZ
         kD440BaUKPqjS3wM4DK0xoY/rAbxBQrhicvdJhr35Zf/9KsJi2PGCA4pg9hTdajms6eH
         GjjUqTl6jwfkh29sHDxg2G9hREb6Agm7Xp+hkHSf8uea/9jUv182B9Cu2dXln2G/z4Lh
         kfU5r9N3opcR55lAYeOjjhYPnGMBAot2hM6OtEI/LwWgAMp6Ru6y+c39/6kao9FnDk/0
         xeRnhOFlJyEU4Uj8oplhZ2TG1+iZxR4DePk070rD+h/6M6ewfK/8iJYYTCpmhlBoV9Zp
         OICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756586731; x=1757191531;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9oPXDxDztkt2wKDii5YBhYWKt30/7ueii2AEtKAIno=;
        b=MJ6tPCvHcqS+YqfnldjNuRriqY+F8PG7xDDXKGyY906oaSRONCv8vWWjrjilaPCq+B
         GXRctMYzKrjLRHyrukJJ+LS8/sVvuo1Vy3AZO6xScrksMlnKBjMvgnYT19OhdT4eO4sz
         NMgrICnuEFGR7UhC1HKazGrSzuQLbxoDJJ5XAtWj6q+io/I2jkiUM/v4WmW1cEtoPsNn
         vG4nInA1HUGzBsloP75GA+ORLIM5yynHHxg/mmGxCGfX4rervcWAz3GyZ4eQ6aFS3lVp
         RDHKNDVsK4CsId3ud/QMb1EV8M5dV6YLqEfNAy9Xx5GrP5gcb7g0S42wR9EMa5/DJw40
         2kBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3c+Dntfzjh3N/VTCX4n3fHglQOBTwwh6Y0bZkwWNlyK6B27FueGf7Gy8L+DJK3KQjz72EU+PZEzdmwOg=@vger.kernel.org, AJvYcCV3eRVfxsjOw8+a1B01m37Hx+Tu78wOO5EVx4DhQVweZjcysdGjnr5YDLYBeWDbbQMS//0ZvGlD73Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAXjkkImQV7/temGfEjjc+oyhXHJT2rW85FvxNdQ9PuT5JbX8B
	ybM3t9/ze4kYouVy1fgRfbSlUzhCkVEAa9d4FGzIGJD6QxlK+eem4h9xcjr+0A==
X-Gm-Gg: ASbGncttkRmbjlgnTwDTS/4oKIBjmIMPlldnRLNCtss8usEkUsosz8O/HnKUYi4P30h
	0oxBsOs4rNAxCEdmKvaIWdPLdC1BLW8Htvsw+Ma8hsHmqGTOfPP6dEOfKf3+zc//Zb7NTV0Ds88
	8CkQ+QP1ETFgiRx0lv3ZcSBD00rweZE6wtKNvANa7nR0MaY+AskrlXGSwflFYohfXBmRPvNvHlr
	pT+x1TxjvULf3a1Bx4fA6dh4GdSgFLtEEjTeqblPDQklJkAHeCKvsD3FyPN8KU0p45NvaQm5192
	ipn4bmDuEXTGddRl/h6FTZ3/qU8ASYkXxaKWnuvKmdwrL1X7eBbp8dJqcv+wG5sPd9KFuR/QVSg
	Kq5opmGexR3f4X3VchXsUWNRBg7DxjbM=
X-Google-Smtp-Source: AGHT+IFIDhNRhxBPDeEmI6G63VHRlPS9dVsLEwgzC+3qSuA/VbWECuOqDfBSFtXubhfcyNiCcnsauw==
X-Received: by 2002:a17:907:94c8:b0:af9:706d:1e3e with SMTP id a640c23a62f3a-b01d8a267f0mr265483366b.2.1756586730664;
        Sat, 30 Aug 2025 13:45:30 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc52ade4sm4066630a12.45.2025.08.30.13.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 13:45:30 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Sat, 30 Aug 2025 23:45:19 +0300
Subject: [PATCH 6/9] power: supply: max77705_charger: rework interrupts
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-max77705_77976_charger_improvement-v1-6-e976db3fd432@gmail.com>
References: <20250830-max77705_77976_charger_improvement-v1-0-e976db3fd432@gmail.com>
In-Reply-To: <20250830-max77705_77976_charger_improvement-v1-0-e976db3fd432@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756586721; l=2452;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=qL3ZSipERey4NoCLgTbU79RMORcnpfoRjIAATnOpcf8=;
 b=aNWLnyVh3hKio/qBOYHpieGdSRDqqboqdLHVSsMxjUd4flh8kK5AcnRMuHP4jD1nQBA7cm0Kg
 ZgRhE+JnNsvAGc4jBf/l5J7238ftj1rDCg7xtkUvqoqxfE4FGfqbXbf
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
index de2184327ff8..a1b04ec8921e 100644
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


