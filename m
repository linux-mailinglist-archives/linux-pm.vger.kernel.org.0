Return-Path: <linux-pm+bounces-35415-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872BABA11EF
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 21:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB391884FC1
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 19:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFAA31B11A;
	Thu, 25 Sep 2025 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/WzRnZU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E16323D7D8
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758827403; cv=none; b=W8/00AdtPlY7U0PNeHxcNOkR7/v8hyeSXK/dv5hkntA+EBWlV49XjsNShgkZscBCWvDvcbMIbNkU11J4LkHAQXGlzkb/mBw3RLWh0RYIpDyW0kH0IHV/KFMdbNr9ULu/sSufGoKrNmKKZ9gQzPO0pMrT1lfG975/1TduoXYoI1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758827403; c=relaxed/simple;
	bh=RxSCbZsSl6xhKEKTkRIwgi6x4A3W93x4IQZ53BMJA6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YuOBq6v7Fk0CwmTZ/DpB9w2MAoL9XkV7oj5cPC9lvuZrC6HHUJM/t+I1bt4imDwHs1h3F4H1wzcbUHyjBsPPmX1QgM4uEV5J1kbHpcBPBHad/+gjy6KjJ/6nQTJ8GcmHURvyxok1rXwPXG6atjPQMerQSwUK/kS6UjYxrnpud64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/WzRnZU; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62fa99bcfcdso2744778a12.0
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 12:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758827400; x=1759432200; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hXhMj6BrB8QKqvvK3wReW+Mmt5XbNJTRqjdCqe1E4g8=;
        b=Z/WzRnZUW55PkLI4LJ3dK5bGcZ2m06SLYbO8yFheQHE9FuNs7b71Qc68Y5f1ErnBOY
         P6Le14ANvodpcgV1A43ET08WvjgqEIgZFX4hKziTTx0WPxHdxv2r9KyqfMM19IFArhVv
         NhNX8zzJB7LKKzWix+BpBZILsWZ8YNN5m0Q7C8KV/MP4pvGLmeGDUrWaOsod+pfLaY8j
         mg6PeNWM/eh/6abUU4wXfKWrz/Doh8meQvMozZXdnLwWTdrmQZGEDbU1tbsb/QNGT3wY
         kAx/Rv0IYqildVx6/Qxq8tDXZM9S+59ZVvxwHR9sg0Z2Xh9O6eo/It18TwhzbEjn2vVB
         A8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758827400; x=1759432200;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXhMj6BrB8QKqvvK3wReW+Mmt5XbNJTRqjdCqe1E4g8=;
        b=Yq7F7lioDDKRKY4TgN6yc1kc+7RPBQoNfXhn5GJyLGTY8xlpWHutM9cLOefaefEkjf
         4b1+mdgvARYs0MJ147LqBVKCVlQxeq2B6vXuJ2yvQ171p1CIaty/qgwEwab45M19jWdM
         1t6bQC8yEcg320i2CZ4ht4tqkmPyndQ6J23YkX/SkeqZLa4jx8R6o+bJZFoR6VX6aMIt
         urfm9syCgZa3DnJfloWaKdjmkfc8Gd/rIHvuiWzeS+sx8R7GMT2tRx2m/HO1Wie1UPY9
         A4SKkAyMybc1ordd3Yyi+7lKNrd9nLdRwLFRrrnrZzp+7JQt/V6/D4XxxhmfxYAAfvIx
         UDCw==
X-Forwarded-Encrypted: i=1; AJvYcCVGFNPz7wAYeS2qQ1bczUrLpsBMr+05yvY1sMn1Gb7oXo9MUdmwfHuNG1XMqGdaYcOCgJH62lOlAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFEDDnfwpLiyFBo7CNoICXmpnIhmQdNggFjLB2tjt4G9BkZ4K2
	eBBVt5rehLmJvWx03gRFD/l4TYOrxRpvGGrriDC54MgAqgKVcXcjVn1h
X-Gm-Gg: ASbGnctEVRhtNAQY71i00hfBJk7CM2NJg6/gXY8hNsIfCKpLve08c8RPvWneRrn0xww
	ov32C9DK0oypotffEn8Swv8LB8/5wXoPXPVPuAP6SmOfDP980jWZRgzWX2IZbLHaYEITiTabRrO
	UeSvBt/XhnHLFA60yvXtcQ48YFMggVbFhslwcvXc3hFdXBIZdJYqcDecz3wuL+WenD/7UByqJNA
	VmXjTIpmCfJ++rWH9hSTbP5GeDGVJBymQogpmU/fs1ttKoQThmy7lmF6XrExqWh1BKk4z/GOuQz
	a2nNUo1N807aOtlSsfJBwxWkxhb626fAe7f1ms4B8u1iO8UX6DztfPLjMnp7VJh0O4hrOzq+jIE
	O6PHLrtHczjfWChJLZwXA
X-Google-Smtp-Source: AGHT+IF3BH7z6/M3diWlDJlUyEYvCxqBYRtFlr3TgPRDHhq1UQzDcB+vNbs1Upae3pmayNI9yibOAA==
X-Received: by 2002:aa7:dd5a:0:b0:62a:a4f0:7e4f with SMTP id 4fb4d7f45d1cf-6349fa95f85mr2971922a12.29.1758827399655;
        Thu, 25 Sep 2025 12:09:59 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-634a3b0595fsm1643501a12.52.2025.09.25.12.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 12:09:59 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 25 Sep 2025 22:09:56 +0300
Subject: [PATCH v6] power: supply: max77705_charger: implement aicl feature
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-max77705_77976_charger_improvement-v6-1-972c716c17d1@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIOT1WgC/5XQy07DMBAF0F+pvMbUz9hhxX8gFI2dcWOpeWCHU
 FT133FYQEQ3YXk946OruZKMKWImT4crSbjEHMehhOrhQHwHwwlpbEsmggnNrGS0h4sxhunGmNp
 UTVlKJ0xN7Kc0LtjjMFOUQXHjAoCuSIEcZKQuweC7lXLqmGdIb+cZfTccf8D37HwzjR9Fa/EcF
 0yf6+8pYYiX74ovryV3Mc9jGa2NF76+/qvcwimjWKatk6FVUjyfeojnRz/2ZOUX8UvWrN5FikK
 CbUVwoAzX9V9SbkjOd5GykFILJitbBRB3pNqSdhepCsk5+rJvg7J3pN6QYt8tNeUUwDHAYIX3a
 kvebrcvuCWyBV4CAAA=
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758827398; l=4784;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=RxSCbZsSl6xhKEKTkRIwgi6x4A3W93x4IQZ53BMJA6c=;
 b=BQuD9pc2jlapGmPlnZ2q4DA0pqyKLXvihdmyDATv21l73HD9GjJBwEjR/TBwCkIm8oVjMrEcn
 8/ABUl4nT2hBipjjmprugfBuoX5XQ+l35wZeWi21mfG9TolnVB7pF3j
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Adaptive input current allows charger to reduce it's current
consumption, when source is not able to provide enough power.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
This series consists of:
- max77705: interrupt handling fix
- max77705: make input current limit and charge current limit properties
  writable
- max77705: add adaptive input current limit feature
- max77705: switch to regfields
- max77705: refactoring
- max77976: change property for current charge limit value
---
Changes in v6:
- simplify aicl feature - remove aicl work
- rebase on latest linux-next
- Link to v5: https://lore.kernel.org/r/20250920-max77705_77976_charger_improvement-v5-1-aab0aef82cc4@gmail.com

Changes in v5:
- rebase on latest linux-next, dropping already applied patches
- optimize code to drop is_aicl_irq_disabled variable
- Link to v4: https://lore.kernel.org/r/20250918-max77705_77976_charger_improvement-v4-0-11ec9188f489@gmail.com

Changes in v4:
- fix commit message
- use IRQF_TRIGGER_NONE, because non physical irqs
- minor rename refactoring
- rebase on latest linux-next
- patch reorder: put fixes patch first
- aicl feature cleanup
- Link to v3: https://lore.kernel.org/r/20250911-max77705_77976_charger_improvement-v3-0-35203686fa29@gmail.com

Changes in v3:
- move interrupt request before interrupt handler work initialization
- Link to v2: https://lore.kernel.org/r/20250909-max77705_77976_charger_improvement-v2-0-a8d2fba47159@gmail.com

Changes in v2:
- fix charger register protection unlock
- Link to v1: https://lore.kernel.org/r/20250830-max77705_77976_charger_improvement-v1-0-e976db3fd432@gmail.com
---
Changes in v6:
- drop aicl work
- handle current decrease sequence in a loop

Changes in v5:
- add _MS suffix to AICL_WORK_DELAY
- optimize code to drop is_aicl_irq_disabled variable

Changes in v4:
- fix intendation
- use IRQF_TRIGGER_NONE, because this is not physical irq
- use dev_err_probe instead of pr_err
- remove excessive chgin irq request
- remove pr_infos
---
 drivers/power/supply/max77705_charger.c | 42 +++++++++++++++++++++++++++++++++
 include/linux/power/max77705_charger.h  |  2 ++
 2 files changed, 44 insertions(+)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index b1a227bf72e2..35cdb10a0e89 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -40,6 +40,39 @@ static enum power_supply_property max77705_charger_props[] = {
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 };
 
+static irqreturn_t max77705_aicl_irq(int irq, void *irq_drv_data)
+{
+	struct max77705_charger_data *chg = irq_drv_data;
+	unsigned int regval, irq_status;
+	int err;
+
+	err = regmap_read(chg->regmap, MAX77705_CHG_REG_INT_OK, &irq_status);
+	if (err < 0)
+		return IRQ_HANDLED;
+
+	// irq is fiered at the end of current decrease sequence too
+	// early check AICL_I bit to guard against that excess irq call
+	while (!(irq_status & BIT(MAX77705_AICL_I))) {
+		err = regmap_field_read(chg->rfield[MAX77705_CHG_CHGIN_LIM], &regval);
+		if (err < 0)
+			return IRQ_HANDLED;
+
+		regval--;
+
+		err = regmap_field_write(chg->rfield[MAX77705_CHG_CHGIN_LIM], regval);
+		if (err < 0)
+			return IRQ_HANDLED;
+
+		msleep(AICL_WORK_DELAY_MS);
+
+		err = regmap_read(chg->regmap, MAX77705_CHG_REG_INT_OK, &irq_status);
+		if (err < 0)
+			return IRQ_HANDLED;
+	}
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t max77705_chgin_irq(int irq, void *irq_drv_data)
 {
 	struct max77705_charger_data *chg = irq_drv_data;
@@ -632,6 +665,15 @@ static int max77705_charger_probe(struct i2c_client *i2c)
 		goto destroy_wq;
 	}
 
+	ret = devm_request_threaded_irq(dev, regmap_irq_get_virq(irq_data, MAX77705_AICL_I),
+					NULL, max77705_aicl_irq,
+					IRQF_TRIGGER_NONE,
+					"aicl-irq", chg);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to Request aicl IRQ\n");
+		goto destroy_wq;
+	}
+
 	ret = max77705_charger_enable(chg);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to enable charge\n");
diff --git a/include/linux/power/max77705_charger.h b/include/linux/power/max77705_charger.h
index 6653abfdf747..b3950ce0625e 100644
--- a/include/linux/power/max77705_charger.h
+++ b/include/linux/power/max77705_charger.h
@@ -123,6 +123,8 @@
 #define MAX77705_DISABLE_SKIP		1
 #define MAX77705_AUTO_SKIP		0
 
+#define AICL_WORK_DELAY_MS		100
+
 /* uA */
 #define MAX77705_CURRENT_CHGIN_STEP	25000
 #define MAX77705_CURRENT_CHG_STEP	50000

---
base-commit: 8e2755d7779a95dd61d8997ebce33ff8b1efd3fb
change-id: 20250830-max77705_77976_charger_improvement-e3f417bfaa56

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


