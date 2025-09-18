Return-Path: <linux-pm+bounces-34987-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F08EB8628E
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 19:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7DB1CC135B
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 17:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1D731A816;
	Thu, 18 Sep 2025 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muTFnNk/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B7A31A077
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215223; cv=none; b=Gm2rd6djxjlsST4kUr3UolA1c9g9BOZcmSftH8HajO1+1RGzq22shT3xHRU5QJDaj2mSZpJR11kN0ZMVCFEDBFidjgvvfvpQjfq8UuIbVeUqvvJvUcZOdsungClhVC67f3KbOLFbIlRvbxQ0COxpRHOLsVHAOS7DXcruLuwPX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215223; c=relaxed/simple;
	bh=2j0Z44ZuInJmH1epmNVJSQbicoshH78O9ODW3KemRu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tb3r+DA+rKY0iBFG41XEpzk+WUp+hItX4j/5QbBGT5sMMYmYGATQByyWL1wzXIN6AdIOc0VPSt0tUFB071NYNdvcHbWeDNi5PowSHOK5nhgMkOL4BqsSpW7WapyeeUaUi+GvEninY9trQcpN/FCwOEpSfuWV+RJltKq7OJMZ7YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muTFnNk/; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b079c13240eso213120566b.1
        for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 10:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758215220; x=1758820020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZREYZDUdZq758mUlZEILRmYEno001nFmKaO1knNtmM=;
        b=muTFnNk/MpactNhA1EPArSVisW/N6U+I8D+xDUXzDoqWaGC5HFvfJhnoR16CSvIl2r
         5RQRT7wqz207htV38pGr7s12YBue2Ow3oy8+LSrXbxbP1a+wAtdJ8PINawLuDCE6zeiS
         hP8Vf8tk9cBr5ChduAIX/1f3b/WGOnsQGd/1EOAhu+sqJGiRntdYVKEO+osSNKsxL6yb
         KN+UX3X8ZOFm3XNZqFMta3zIya3rzm3PHdiGf0q7ZDgYhi1JTSQj1a193902IT3CWXvk
         jDVREoCoNloiNDsFi8v23qdBUeybZSVZi2OIDl/UW52JNu9xPHHGdMBLQF9At6/Gga2S
         sxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758215220; x=1758820020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZREYZDUdZq758mUlZEILRmYEno001nFmKaO1knNtmM=;
        b=YJszPp4G+gsr5QPnMor2bbNUDaS1leUmIWBfTMVlU4DMe/v2Zrwj6ld5/Zpb0dXnJN
         N6k9GeKJ9egYVejQw2X2NfkhHSS+x1bG2JzjwNr0znT7WEY1sCMKueNOuNot87A4/heV
         SozPRocSO2kpKy2oEN3VSTHoEWt2M5hrSIAPGhTO+eLdTsufd+ORYfrLGVkD65lPqlFj
         LTZJxM4A/n8DaYCmjZLT/a34LBsUcpxPTnKNZwpy1oMNZnspXI9Bkq8E/OuW9m9H11fF
         n+eTBnStxmJb4drJD0+R+r39cXKNstdwy+dTCxGTOlXCs9HhewTOjn3rVf2F2na+Iym1
         RfHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLE8VCFm4zJnx9jrOJXqagVvmvE/EUavShSIaZVEeB6PZFzKiwfzXvVPbTvCi1X0AsgmV7W/6grQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlII43063EWi2+pCq+C1i/HgZr1wc03i7HstcuO3BQaEHGst7B
	8xEZl/YnqPnJSqIOCme9rNP9lpF2//WkxeZ1gQnExx4UYh88pVPbNzSQ
X-Gm-Gg: ASbGncu7Xn91dNSCJqV+mb2fkU6sO7sf5Tsz7s5oRsCRssANN4aOTvwnSLBKYhTAcL7
	hGRhVLUnqiEsLmAGETLyDEbrRoI/dliAGl+kGwjlUoAG2rKaHIgaIggEl/F5en7tHmGBCnB9TDQ
	GnN6Wbc3U9aSrlXnXLqmJ6nRjwezNdOgvOmqhCfNtwqIkIuXd5ZfD0mlx+LyDeruIqMRxOXSKxN
	in+P3W0RVryDACr+vj7TUO+QRahmYtaVA09kI9jI1G6Uy71B6dTLJk2NLukFIqSGho83EfT1j9P
	NjEVA/Dr5FzThdocVN6huOAyEwMU402E9blZkwA5nrWGJc6bAJFoFPmQswCBds3jYES3BCqodVb
	l2G+IFOnBGsckQXng06EBFWZ2tSFpAyVirxoPjvU=
X-Google-Smtp-Source: AGHT+IHJaYAosIIgzo9wihFAu8HxJKZvFancA9c5JtlSdI6Jj/MWkdQceshUZ3VqvRkTQp7YqCTWJw==
X-Received: by 2002:a17:907:3f28:b0:b04:82bc:1dd2 with SMTP id a640c23a62f3a-b1bb25530d3mr752928366b.29.1758215219623;
        Thu, 18 Sep 2025 10:06:59 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b1fd271f895sm225845366b.97.2025.09.18.10.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 10:06:59 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 18 Sep 2025 20:06:53 +0300
Subject: [PATCH v4 9/9] power: supply: max77705_charger: implement aicl
 feature
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-max77705_77976_charger_improvement-v4-9-11ec9188f489@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758215207; l=4185;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=2j0Z44ZuInJmH1epmNVJSQbicoshH78O9ODW3KemRu4=;
 b=fmL6X3MR1TCWT473mDn6c2k63zhOYbh49PlNdB88/4vGEAtaqPJdKBuUG2pnz3aeETzSKTiYc
 5G6bBnTQoaXBvtthLBVnVVi7aOPLjv8HMlCXQ+T+1F0NDsO4xrSdQxz
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Adaptive input current allows charger to reduce it's current
consumption, when source is not able to provide enough power.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v4:
- fix intendation
- use IRQF_TRIGGER_NONE, because this is not physical irq
- use dev_err_probe instead of pr_err
- remove excessive chgin irq request
- remove pr_infos
---
 drivers/power/supply/max77705_charger.c | 58 +++++++++++++++++++++++++++++++++
 include/linux/power/max77705_charger.h  |  5 +++
 2 files changed, 63 insertions(+)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index 8032dfa0c9a2..168a67819a51 100644
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
@@ -445,6 +455,38 @@ static const struct power_supply_desc max77705_charger_psy_desc = {
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
+		err = regmap_field_write(chg->rfield[MAX77705_CHG_CHGIN_LIM], regval);
+		if (err < 0)
+			return;
+
+		queue_delayed_work(chg->wqueue, &chg->aicl_work,
+		     msecs_to_jiffies(AICL_WORK_DELAY));
+	} else {
+		enable_irq(chg->aicl_irq);
+		chg->is_aicl_irq_disabled = false;
+	}
+}
+
 static void max77705_chgin_isr_work(struct work_struct *work)
 {
 	struct max77705_charger_data *chg =
@@ -617,6 +659,12 @@ static int max77705_charger_probe(struct i2c_client *i2c)
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
@@ -632,6 +680,16 @@ static int max77705_charger_probe(struct i2c_client *i2c)
 		goto destroy_wq;
 	}
 
+	chg->aicl_irq = regmap_irq_get_virq(irq_data, MAX77705_AICL_I);
+	ret = devm_request_threaded_irq(dev, chg->aicl_irq,
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
index 6653abfdf747..92fef95e4ac4 100644
--- a/include/linux/power/max77705_charger.h
+++ b/include/linux/power/max77705_charger.h
@@ -123,6 +123,8 @@
 #define MAX77705_DISABLE_SKIP		1
 #define MAX77705_AUTO_SKIP		0
 
+#define AICL_WORK_DELAY		100
+
 /* uA */
 #define MAX77705_CURRENT_CHGIN_STEP	25000
 #define MAX77705_CURRENT_CHG_STEP	50000
@@ -185,7 +187,10 @@ struct max77705_charger_data {
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


