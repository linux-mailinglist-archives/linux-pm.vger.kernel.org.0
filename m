Return-Path: <linux-pm+bounces-34299-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A397B50547
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 20:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47ED6189115F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 18:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BE2369967;
	Tue,  9 Sep 2025 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9oORpCN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE973629BB;
	Tue,  9 Sep 2025 18:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442584; cv=none; b=WuoaTFnH9/eO7Loe3I1NwM/PmD3gF1TFi12aj0v2IiLNlLHMoqEGcCvLNva+SanVFqv2KekX9dEjnj6iSFrENkU/T/f17U/DvOAUXTHqRx7CqWiFsiGT2DgJ0xMtKEhBedL5NXotTwiUvGP1iJmVBE5Hg19IuBvFoU58/pqf4Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442584; c=relaxed/simple;
	bh=DI89OEaeQO2Ax2mjgXQ6n2DEPtUU4EgqsXq7FYtg+Yo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EllUWKQqUZF+1ChtK/poP4pm1u1MYnLpL3Int0MPW8IE8E5oK/3F3XP5QL4NFfIMkWwC+w3PVAj5ICMf6q4+hxWOayvUE/7Yy91mmSpBVkahrCQcUZXP+rgPEvKmySYX0KniDT8fVen7eCjx8Z8mSqNKvlrr//azLxSvcZA2zsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9oORpCN; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-625e1ef08eeso6595904a12.1;
        Tue, 09 Sep 2025 11:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757442581; x=1758047381; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqusoFaR1+X46SqAnhbzqdvVKYcZDv7k26kqGeVPkoo=;
        b=c9oORpCNypaYROnzR9R7/XuonNQbfjPQoPJg/SrDARBFgcbOUMy9Y4O6CSCl/4USlk
         HOlJBpcvQU7BYFc1YFveiiJioEcWh6gTg2IRmng1Y8I3EoYeffGwj+TO3gxE2SF+bYJM
         hgENemvdQUIhxs68EPhoBudURoyLKp5kstq5lXK9HzzdscPf7wuL+SxLi2rkCebLVbwA
         4g5dU+CQCipE5sxDOngU7iHNqvooOmxDUkhsz+BXdv+XdF2vXJFT7wE+P744i1GULzOa
         ToLw6kjH7fMVOLl8qE0TKNe5jA2AK3hiioY2BFxj/1rYWW5y43Zf0MAm5YEtRm/iRjUw
         eiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757442581; x=1758047381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqusoFaR1+X46SqAnhbzqdvVKYcZDv7k26kqGeVPkoo=;
        b=Xz2gr3Vil0TAb6Wloaq9ya28mkf3ZTnVhEcil40Kjc5/Z1Z0aYWtJa67/5kmBoZeLz
         W5mX738vIjqtT3TXq7vsMSHYAh09OtM73a24tAIP/AsBqTeDv1YDMkLakT/G31qCIFDm
         BfcVrYbOhBSAJpH4prfOjWogo8P6fVKChcc6Jj3o2//kXICUCvNzDmEyz8yds7J7m2RE
         hSH+QphudljI+ADdpOaISydMia8+8BPR/lJ4c99WKtFGT3J//l9hgs7Jp+OXI9nCibtM
         kjUuKMnTZGf1VJUc9r+0X5yk4Yppb6Ym2uw7wka1BE6aMgit57a+YloDVUqzSwRWAGIy
         HJpA==
X-Forwarded-Encrypted: i=1; AJvYcCWgouy8soO8fdCLYZ+TK0T8Posl8ZUANhvlJSC9ptVa8zFQiah+odkHqMYKlHCsp5djaBRNsVTgRxVYppI=@vger.kernel.org, AJvYcCXVPQbaF82RSUhW8l4sVhFY01hGThqFF/RIYkf9eSl0C5jYUTHqlklibdwFltaaTKsoErhWKVZKv88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfzCVRdntdbeK77PU2FOb7GqzyeU2cn0ijXzhPGMLRcbBgPfFR
	vKxg6aj+N7QtfqXINb6jNMeeFd3+smvwDtm1qoOreg1UpvmP7wZLlyB3
X-Gm-Gg: ASbGnctqRoUz1brbKpwcHismN0VBJ2hN+eqvfZdAAR3CxS1lLN5KwORf6jLFlPMUMx/
	7++WKtl4bkYio7QevNTNTUV85O2WW08h3xoeOiHgLEGKxphSF4odEM09XaKcUW9gt6aztDobaHr
	R7pJeR+UeaZHxwalU2sOzzluakO3BnZfK9bOP+0lO6RgqJX6bKPrngKz9wK7eMB9L7gULfBSnY9
	YuyH4WBt1247QVr1jkp7QTdcZ4oiUl0LIxN2VC98XKQs4pTOYDBQLCOoMcUENjh9jGfFLvd5kvI
	CPgI7moL5qf+tT9OiH7PhEuMlSx9WJckJL3Gsk7RWHk9NTU0igrUxt99u03u7weXc9KRJmwNFGb
	ptphhFo68PvhPoZoUt7CIOEANy3pTfPQ=
X-Google-Smtp-Source: AGHT+IHqj87fhG0faYrydCcuDhxJ4Gtd4NAnDznIL7cpMQMhIlwdMQj3njNw+QGSvkseg7wOlQTYhQ==
X-Received: by 2002:a17:907:72d2:b0:b04:3c93:21f9 with SMTP id a640c23a62f3a-b04b14acc20mr1286961866b.24.1757442580997;
        Tue, 09 Sep 2025 11:29:40 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b07833ebe61sm30520666b.89.2025.09.09.11.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:29:40 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 09 Sep 2025 21:29:18 +0300
Subject: [PATCH v2 8/9] power: supply: max77705_charger: implement aicl
 feature
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-max77705_77976_charger_improvement-v2-8-a8d2fba47159@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757442571; l=4101;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=DI89OEaeQO2Ax2mjgXQ6n2DEPtUU4EgqsXq7FYtg+Yo=;
 b=5Sh33ed53S9yhlY7mgPv5neQdmnO5CVz0RYK9lN33f8At3BIXC+/NBJ+UJIybCzjjwFBAsgE6
 6VbCJq3cdT5CRDFahwNruZ9ATZmHphD5ss2ia7jU8lxF1X+BklAukHa
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
index f381ece5502b..c5d08524fa9d 100644
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


