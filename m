Return-Path: <linux-pm+bounces-33479-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8BBB3CF5B
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 22:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AAC84E25B8
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 20:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA312E92DA;
	Sat, 30 Aug 2025 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6GNdgZR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5AB2E8E06;
	Sat, 30 Aug 2025 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756586739; cv=none; b=YnThbgYiGwlj6HgR5T7mDIUZ1AMIAaGrhTrWGuWKFo4nMEj3zwLdWM1IlK4H46WEg+hSnXl474iEe0evM0wwAkFIhpOK/v//jpLnOHoiZGUz61dDAtSqzJ6SqYgNfD6Fdt9ks/HR3yq2csP/cI0OyCdaz6vMx9rLnTLybF4uPog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756586739; c=relaxed/simple;
	bh=S8wA9UdQ5E5v3yPjedQZo8H7UmCEzzF2uKf/ng4Pfpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QWQEZRWEJK9ZK0Ow7r1awFKelkwp/yx/ajM2pbN9dJyxK5lLdmoZytf7U39x7GEZ4zarp9zv5YnAiM2/JU7lOdibfJ1k7mrV0zlAcdBZk+ZnBMAnYHdzeEI+IgMROSohNz3F9WPNM8uBy41+ujmlx8TNnLqJrqy534YTQSqdAUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6GNdgZR; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61cdab7eee8so4300654a12.0;
        Sat, 30 Aug 2025 13:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756586735; x=1757191535; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojj4EX9E9+QuXRFR8+Z8Pz59iiFPjmpbXvltYgmJi6E=;
        b=E6GNdgZRV3KFVhXa6/XG33xGIrEc9vqw14sb3SLDAtXMcq1cq0aHhn/V7GRAIjgYSv
         idf++tlDlxUuG0Od4Q4KQj78GP3osoBk1waP+STMTo6Vn1m8ihxXVgDeuGEAbRANa+tN
         dau6sjcayuHIsBIucJmrEIcjEYBSZq7rJo0wTxk46RWxylATe8cmWr4leNLxJxhNAwJz
         unwhgAiEAfarj1X9jlenvb8DHOhvt3EyrzxlhwyOVhaxfyQC7kSY1UbbehzTNsfQdla+
         8V8WlRQdXpIQkeqPv6PHztafJBAUdxVVocnSnHiaLe+b8+w/AdAJtmeO2f7yPLF8BRK+
         6r6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756586735; x=1757191535;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojj4EX9E9+QuXRFR8+Z8Pz59iiFPjmpbXvltYgmJi6E=;
        b=gV+6pfX7ezygEYhuIIvpp38igMigGYksV/ZlVLZ/J8bDrocrS4kPqOcTFOLud2hvOS
         CEVmdrvvbdXZOWFLVFtHfkDYS9AlU5qweMmkvHiTmfIez8pFsXo1YlNq47H4eQQlwO4q
         oZsBz6JuTEprbh3+89T6iVJOqVp251DoF8Sz+gwZ3CEWoAtW6lRnq7bYkcEXnplBoZHB
         7RJ50IO6vWB5KEUWT9lGZNDdu06nXi5uMffR4A08FLB0cQIdoZfhCzH+/FqkyE+cdMhh
         v0c/YhRypLyonqGDJyeRQnpPMhIqJY9wRP8rCA2enA7iYBH6SlKVWGZyUanvElsfSgH8
         rFNw==
X-Forwarded-Encrypted: i=1; AJvYcCWKO2mhBFOcOCt0NRcLImMHVJ3Q3fV0vRIyQkhC7j0AhxqjgtUbf0TCMCxW/YdZ8zrYQd1huAo9VQ21xLQ=@vger.kernel.org, AJvYcCWgdnDpAr5RQS8jGOdMFIqoVfPK7TliTyIzKWeb2Jog0nLkkEYdsfCpnMbQJQt6MtnwhD0nBYA+hjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJHx3elp2YqFXDs9ORLWZ5+6M/2ve5CanxMEFYtuv7pW6Q2ZVQ
	lPmpJlnPJD83deOmOqyZ4ZE9KS2qvZj/lNTAk+p+mPdXa+bu+ZgZNVsV
X-Gm-Gg: ASbGnctCYPAs0hrSS9fDp86+8fynyr3cc4/Ooh+GYc25bHiLkZr5G1kTmsNHnARV93J
	F8LIx6W9pNv2BBjkEOoZSCFZsB3fnAwbamNSci9VQCOlYuGs20JU7wseSb8px7wMkcAh/fIZy23
	Hw+hiFIi/DCsaoDGphH2fQdUwqQY3xQRLsx8L+frWC6kSFX+ZT2lP3WZx2dmqRbFOeid8gr5dI0
	Wb/z8PP4C+fdchMTwgZ1csw5ixX4mwiZleGAVS1RbWqds5/watMtbEBgF6Sk8otrkovVINzqq7L
	vBBFh5d/BbXhdmdlOprUGr0RLsMdDYPhbxIp5P4xinkTkSxh70ulwBqPTxHcjq1dUzUJjvB9rdY
	+DkVuumxXP3OInGQALzep
X-Google-Smtp-Source: AGHT+IFMB0KRIEjsGUMyDSx26lgjw4lMYDOCC+pvuKOzZnu8AUX6MDzMQQE9vlbLK1xIck4VdoAEhQ==
X-Received: by 2002:a05:6402:510d:b0:618:20c1:7e61 with SMTP id 4fb4d7f45d1cf-61d26da44c6mr2730232a12.27.1756586735373;
        Sat, 30 Aug 2025 13:45:35 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc52ade4sm4066630a12.45.2025.08.30.13.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 13:45:34 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Sat, 30 Aug 2025 23:45:21 +0300
Subject: [PATCH 8/9] power: supply: max77705_charger: implement aicl
 feature
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-max77705_77976_charger_improvement-v1-8-e976db3fd432@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756586721; l=4101;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=S8wA9UdQ5E5v3yPjedQZo8H7UmCEzzF2uKf/ng4Pfpc=;
 b=useLmRmUe3mcbezYRXXnUOe4QSOVjdUlVaZq2WIJr1yF9lI/e1Q0omlEcwnbRLTkIey2382T4
 wV5bHc+runmAm1Q73TUTf3FUlfGZdgGQqHHAdgIrNUtsP9N/0DtI455
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Adaptive input current allows charger to reduce it's current
consumption, when source is not able to provide enough power.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/power/supply/max77705_charger.c | 60 +++++++++++++++++++++++++++++++++
 include/linux/power/max77705_charger.h  |  5 +++
 2 files changed, 65 insertions(+)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index aa0ffa1fde39..a82e32483ae5 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -40,6 +40,16 @@ static enum power_supply_property max77705_charger_props[] = {
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 };
 
+static irqreturn_t max77705_aicl_irq(int irq, void *irq_drv_data)
+{
+	struct max77705_charger_data *chg = irq_drv_data;
+
+	queue_delayed_work(chg->wqueue, &chg->aicl_work,
+		     msecs_to_jiffies(AICL_WORK_DELAY));
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t max77705_chgin_irq(int irq, void *irq_drv_data)
 {
 	struct max77705_charger_data *chg = irq_drv_data;
@@ -445,6 +455,40 @@ static const struct power_supply_desc max77705_charger_psy_desc = {
 	.set_property		= max77705_set_property,
 };
 
+static void max77705_aicl_isr_work(struct work_struct *work)
+{
+	unsigned int regval, irq_status;
+	int err;
+	struct max77705_charger_data *chg =
+		container_of(work, struct max77705_charger_data, aicl_work.work);
+
+	regmap_read(chg->regmap, MAX77705_CHG_REG_INT_OK, &irq_status);
+	if (!chg->is_aicl_irq_disabled) {
+		disable_irq(chg->aicl_irq);
+		chg->is_aicl_irq_disabled = true;
+	}
+
+	if (!(irq_status & BIT(MAX77705_AICL_I))) {
+		err = regmap_field_read(chg->rfield[MAX77705_CHG_CHGIN_LIM], &regval);
+		if (err < 0)
+			return;
+
+		regval--;
+
+		pr_info("aicl call. regval: %d\n", regval);
+		err = regmap_field_write(chg->rfield[MAX77705_CHG_CHGIN_LIM], regval);
+		if (err < 0)
+			return;
+
+		queue_delayed_work(chg->wqueue, &chg->aicl_work,
+		     msecs_to_jiffies(AICL_WORK_DELAY));
+	} else {
+		pr_info("aicl finish\n");
+		enable_irq(chg->aicl_irq);
+		chg->is_aicl_irq_disabled = false;
+	}
+}
+
 static void max77705_chgin_isr_work(struct work_struct *work)
 {
 	struct max77705_charger_data *chg =
@@ -616,6 +660,16 @@ static int max77705_charger_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
+	chg->aicl_irq = regmap_irq_get_virq(irq_data, MAX77705_AICL_I);
+	ret = devm_request_threaded_irq(dev, chg->aicl_irq,
+				 NULL, max77705_aicl_irq,
+				 IRQF_TRIGGER_HIGH,
+	"aicl-irq", chg);
+	if (ret) {
+		pr_err("%s: Failed to Request IRQ (%d)\n", __func__, ret);
+		return ret;
+	}
+
 	chg->wqueue = create_singlethread_workqueue(dev_name(dev));
 	if (!chg->wqueue)
 		return dev_err_probe(dev, -ENOMEM, "failed to create workqueue\n");
@@ -626,6 +680,12 @@ static int max77705_charger_probe(struct i2c_client *i2c)
 		goto destroy_wq;
 	}
 
+	ret = devm_delayed_work_autocancel(dev, &chg->aicl_work, max77705_aicl_isr_work);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to initialize interrupt work\n");
+		goto destroy_wq;
+	}
+
 	ret = max77705_charger_initialize(chg);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to initialize charger IC\n");
diff --git a/include/linux/power/max77705_charger.h b/include/linux/power/max77705_charger.h
index df1d46ff9527..da048dda4e44 100644
--- a/include/linux/power/max77705_charger.h
+++ b/include/linux/power/max77705_charger.h
@@ -124,6 +124,8 @@
 #define MAX77705_DISABLE_SKIP		1
 #define MAX77705_AUTO_SKIP		0
 
+#define AICL_WORK_DELAY		100
+
 /* uA */
 #define MAX77705_CURRENT_CHGIN_STEP	25000
 #define MAX77705_CURRENT_CHG_STEP	50000
@@ -186,7 +188,10 @@ struct max77705_charger_data {
 	struct power_supply_battery_info *bat_info;
 	struct workqueue_struct *wqueue;
 	struct work_struct	chgin_work;
+	struct delayed_work	aicl_work;
 	struct power_supply	*psy_chg;
+	int			is_aicl_irq_disabled;
+	int			aicl_irq;
 };
 
 #endif /* __MAX77705_CHARGER_H */

-- 
2.39.5


