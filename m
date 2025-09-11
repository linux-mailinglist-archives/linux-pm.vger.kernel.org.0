Return-Path: <linux-pm+bounces-34503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF9BB53ADC
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 19:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77FB41C24E11
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 17:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6CB369353;
	Thu, 11 Sep 2025 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3rkvLP5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEFC368087
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757613444; cv=none; b=V2mO+NaTX0yI5CTR4n2bIganJXT6wj6JQIMA4AXKvFOe+Yl3t1r3d6wulP6+nKS5ks/9Kxa9KrSmEs8bF0lwPgXw7pXnz0cyZcRAoeAUdUvb0DqBP/MRuL3OfSU3hzxX5YyLQgGB2oli4p4N/m1Ltjow+Tb1iToBjVn4hM69RTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757613444; c=relaxed/simple;
	bh=bGDCk3kzbdsUZZQhl6KUQ8bvyiKh/w2K/fZ43Aq2I4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DjZ9gH5FOehLnJoumAIHCx/LOPHuEFeNQ7tUowN+3RVFYNDoTU5QWHOON4rnKfkCBofyDJ5xsYxsn18GbF5GKeIwZRAbtQvs6ZQTrWz3sjcAkYJW92QQtPpeE2qC305jYsdsG2SIiHSTF8yivj62n5Mv+QwaKBDLWaiEOjVNyrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3rkvLP5; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b04ba3de760so140429066b.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 10:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757613440; x=1758218240; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=75UGwiqWwN4s+IR/YJTkSJX8KNi4Qm/u3Bm/PVxwIIg=;
        b=Q3rkvLP5Z56wQ57d8nr7qAikUz9ZfwcUHDXn6QMTuntv4agbn9dDDD4ym2ebrb8L7N
         ysw/ojo2yYxmPu8xK1dOLtniiRF9lkH4cfECuVQL1QbSCBLxGChS67K08oIEzpq+me5H
         9JiP+eO4Pnil757C1wdN7CAG//ixrxHLEIcb43KQtuvVQZetxge3A0hwcT1pOifNRS5w
         XC3OlJMeclfpRdpD+JTgrG0ngVJ4ooaVDb1CfOfdPKw/NOe8CY9LczOt2gdCwrR5x5ji
         C8km8XAPgMp8LXPvwSeNQ5bESAbD3A0y9Gim+1HBvmDAZ7UCNGKOiIliptOnkpuIM7b8
         f/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757613440; x=1758218240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75UGwiqWwN4s+IR/YJTkSJX8KNi4Qm/u3Bm/PVxwIIg=;
        b=RFQutZsnpSr+q+zjqh5+w5qyVqrwpobXvHeFToG+F9a5oIXhy/tgvbhbQkDR7ob4ya
         gy+1oAxEXBp0ujeQvZ4W30Rl6UYZOebV/ljHRHYjOJoKXoO8W2rD7lr7ou1zw7XiA5Cg
         m6drjrYwRiRbh8rV/qDc6BRouwSCzLUpWxzc1cRK9gcjq+Nh6jiU/ZUJjFG8CFvCm7Gh
         oA5yjNueUP4dSK7FwscpaCCi3ogI+CtzFuU64gktJtwUkmiGTcl834qltWczmjjKAnZd
         1czsX40Cm6BJVu/AyZ4jZo8oRJd0n73EJQJ+JFZ9EoaCBn/G4Wm2WzjuLLT7Og2oye9B
         3Yfw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ+mVZ8oFUFxCfO8p81xDqSsp6ZtqhXHyKL0IrvASxaUy8aT9YyMOwfl5rs3zcINchUxvTPd6IRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRn2baoXBzXJjrcHxTR1Xoy9o+r5Z/d4FbCM0cw/32hDBiw9Vv
	Vnyhcx8bHTJ11f3bdCwlZzYwoIyjtC7sHVpXJupRJH1FBNrjTD86AKYsRskEcg==
X-Gm-Gg: ASbGncuTqujpaff2X0cmo/uM8cvM9qEwYXe908//BY9yOPSvfPdo9U0Xq/xhRhtyjAU
	1n+IEdkWaWqp7+WkJcddGmkWrt5pt211VYIy3j3AVe8YLw49koT9JgJyuRmgCeJJPzEI9EV5l/S
	Ft+291j0oghnhFgfVQWKzHfvmUk8Ig0lPCo2bo30NPfxEEaxKNkfk/ZbljtWDS8eeTjgT7HZ/Ke
	2Iss+tEeyQ++DwBrBNFGE+YfSPODUQTWjPiO0bDnYRorOF1OH1O8/pZwePNCWsf2YVQ/hdprV1o
	PELB8jJkTyi8yofhhef0TZ5t7kVV0fkiJ917LQDKr2Sy5id6zboWkYoG9KfDOdPkSAXoUlo76bL
	SNwSL7InL19XVhvxRL42Djx+sDoHwwn8=
X-Google-Smtp-Source: AGHT+IGJ2XzztvFArmmP+iZSRugLXIzd8nb1EBBVPy1fU6A5CkgagAnr4W0Bj0t3vUvlTkshyQbwYA==
X-Received: by 2002:a17:906:d550:b0:b04:241c:e70e with SMTP id a640c23a62f3a-b07c3579f57mr3633166b.19.1757613440346;
        Thu, 11 Sep 2025 10:57:20 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b07b312845esm171377166b.26.2025.09.11.10.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 10:57:19 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 11 Sep 2025 20:57:12 +0300
Subject: [PATCH v3 4/9] power: supply: max77705_charger: return error when
 config fails
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-max77705_77976_charger_improvement-v3-4-35203686fa29@gmail.com>
References: <20250911-max77705_77976_charger_improvement-v3-0-35203686fa29@gmail.com>
In-Reply-To: <20250911-max77705_77976_charger_improvement-v3-0-35203686fa29@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757613434; l=5448;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=bGDCk3kzbdsUZZQhl6KUQ8bvyiKh/w2K/fZ43Aq2I4Q=;
 b=D+/3fvB5uoQs9xNixQFgd+Wd1JX953EkDMibli/iPi2sVOeJG3cX5bV40g7uiTyEgf1AU5OUR
 5WB9O7W9KNpDCyfia1h466fPqB/r4jtZ74NjiIAJFX7HhX6pnZJ+fKc
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Handle error, returned from register writes in init function.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/power/supply/max77705_charger.c | 90 +++++++++++++++++++++++++--------
 1 file changed, 70 insertions(+), 20 deletions(-)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index 2d2201a6ba68..93d055458849 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -400,43 +400,72 @@ static void max77705_chgin_isr_work(struct work_struct *work)
 	power_supply_changed(chg->psy_chg);
 }
 
-static void max77705_charger_initialize(struct max77705_charger_data *chg)
+static int max77705_charger_initialize(struct max77705_charger_data *chg)
 {
 	struct power_supply_battery_info *info;
 	struct regmap *regmap = chg->regmap;
+	int err;
 
-	if (power_supply_get_battery_info(chg->psy_chg, &info) < 0)
-		return;
+	err = power_supply_get_battery_info(chg->psy_chg, &info);
+	if (err)
+		return dev_err_probe(chg->dev, err, "error on getting battery info");
 
 	chg->bat_info = info;
 
 	/* unlock charger setting protect */
 	/* slowest LX slope */
-	regmap_field_write(chg->rfield[MAX77705_CHGPROT], MAX77705_CHGPROT_UNLOCKED);
-	regmap_field_write(chg->rfield[MAX77705_LX_SLOPE], MAX77705_SLOWEST_LX_SLOPE);
+	err = regmap_field_write(chg->rfield[MAX77705_CHGPROT], MAX77705_CHGPROT_UNLOCKED);
+	if (err)
+		goto err;
+
+	err = regmap_field_write(chg->rfield[MAX77705_LX_SLOPE], MAX77705_SLOWEST_LX_SLOPE);
+	if (err)
+		goto err;
 
 	/* fast charge timer disable */
 	/* restart threshold disable */
 	/* pre-qual charge disable */
-	regmap_field_write(chg->rfield[MAX77705_FCHGTIME], MAX77705_FCHGTIME_DISABLE);
-	regmap_field_write(chg->rfield[MAX77705_CHG_RSTRT], MAX77705_CHG_RSTRT_DISABLE);
-	regmap_field_write(chg->rfield[MAX77705_CHG_PQEN], MAX77705_CHG_PQEN_DISABLE);
+	err = regmap_field_write(chg->rfield[MAX77705_FCHGTIME], MAX77705_FCHGTIME_DISABLE);
+	if (err)
+		goto err;
+
+	err = regmap_field_write(chg->rfield[MAX77705_CHG_RSTRT], MAX77705_CHG_RSTRT_DISABLE);
+	if (err)
+		goto err;
 
-	regmap_field_write(chg->rfield[MAX77705_MODE],
+	err = regmap_field_write(chg->rfield[MAX77705_CHG_PQEN], MAX77705_CHG_PQEN_DISABLE);
+	if (err)
+		goto err;
+
+	err = regmap_field_write(chg->rfield[MAX77705_MODE],
 			MAX77705_CHG_MASK | MAX77705_BUCK_MASK);
+	if (err)
+		goto err;
 
 	/* charge current 450mA(default) */
 	/* otg current limit 900mA */
-	regmap_field_write(chg->rfield[MAX77705_OTG_ILIM], MAX77705_OTG_ILIM_900);
+	err = regmap_field_write(chg->rfield[MAX77705_OTG_ILIM], MAX77705_OTG_ILIM_900);
+	if (err)
+		goto err;
 
 	/* BAT to SYS OCP 4.80A */
-	regmap_field_write(chg->rfield[MAX77705_REG_B2SOVRC], MAX77705_B2SOVRC_4_8A);
+	err = regmap_field_write(chg->rfield[MAX77705_REG_B2SOVRC], MAX77705_B2SOVRC_4_8A);
+	if (err)
+		goto err;
 
 	/* top off current 150mA */
 	/* top off timer 30min */
-	regmap_field_write(chg->rfield[MAX77705_TO], MAX77705_TO_ITH_150MA);
-	regmap_field_write(chg->rfield[MAX77705_TO_TIME], MAX77705_TO_TIME_30M);
-	regmap_field_write(chg->rfield[MAX77705_SYS_TRACK], MAX77705_SYS_TRACK_DISABLE);
+	err = regmap_field_write(chg->rfield[MAX77705_TO], MAX77705_TO_ITH_150MA);
+	if (err)
+		goto err;
+
+	err = regmap_field_write(chg->rfield[MAX77705_TO_TIME], MAX77705_TO_TIME_30M);
+	if (err)
+		goto err;
+
+	err = regmap_field_write(chg->rfield[MAX77705_SYS_TRACK], MAX77705_SYS_TRACK_DISABLE);
+	if (err)
+		goto err;
 
 	/* cv voltage 4.2V or 4.35V */
 	/* MINVSYS 3.6V(default) */
@@ -447,21 +476,38 @@ static void max77705_charger_initialize(struct max77705_charger_data *chg)
 		max77705_set_float_voltage(chg, info->voltage_max_design_uv);
 	}
 
-	regmap_field_write(chg->rfield[MAX77705_VCHGIN], MAX77705_VCHGIN_4_5);
-	regmap_field_write(chg->rfield[MAX77705_WCIN], MAX77705_WCIN_4_5);
+	err = regmap_field_write(chg->rfield[MAX77705_VCHGIN], MAX77705_VCHGIN_4_5);
+	if (err)
+		goto err;
+
+	err = regmap_field_write(chg->rfield[MAX77705_WCIN], MAX77705_WCIN_4_5);
+	if (err)
+		goto err;
 
 	/* Watchdog timer */
 	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_00,
 				MAX77705_WDTEN_MASK, 0);
 
 	/* VBYPSET=5.0V */
-	regmap_field_write(chg->rfield[MAX77705_VBYPSET], 0);
+	err = regmap_field_write(chg->rfield[MAX77705_VBYPSET], 0);
+	if (err)
+		goto err;
 
 	/* Switching Frequency : 1.5MHz */
-	regmap_field_write(chg->rfield[MAX77705_REG_FSW], MAX77705_CHG_FSW_1_5MHz);
+	err = regmap_field_write(chg->rfield[MAX77705_REG_FSW], MAX77705_CHG_FSW_1_5MHz);
+	if (err)
+		goto err;
 
 	/* Auto skip mode */
-	regmap_field_write(chg->rfield[MAX77705_REG_DISKIP], MAX77705_AUTO_SKIP);
+	err = regmap_field_write(chg->rfield[MAX77705_REG_DISKIP], MAX77705_AUTO_SKIP);
+	if (err)
+		goto err;
+
+	return 0;
+
+err:
+	return dev_err_probe(chg->dev, err, "error while configuring");
+
 }
 
 static int max77705_charger_probe(struct i2c_client *i2c)
@@ -524,7 +570,11 @@ static int max77705_charger_probe(struct i2c_client *i2c)
 		goto destroy_wq;
 	}
 
-	max77705_charger_initialize(chg);
+	ret = max77705_charger_initialize(chg);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to initialize charger IC\n");
+		goto destroy_wq;
+	}
 
 	ret = max77705_charger_enable(chg);
 	if (ret) {

-- 
2.39.5


