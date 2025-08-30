Return-Path: <linux-pm+bounces-33475-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BB6B3CF52
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 22:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020312042ED
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 20:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB172E7F17;
	Sat, 30 Aug 2025 20:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZU+bppD4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B458F2E718F;
	Sat, 30 Aug 2025 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756586732; cv=none; b=ATErXf5fMIx/MbAjMSOUNMxy03uF6agoJMQPjl8g1Em1QLerYts7AVWxkWakHOiXWsEfrBqxG7d+qMJP4rb4wMzePMM6PvRLY5WHMmJTZ9tYJb6DCEoRu+FAT0k6Obt2XrHKd2C8bZHGG7H1cvotHUU4U85cY4ZGsjpCKJRF5sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756586732; c=relaxed/simple;
	bh=KKiS1ZgRCTnr87a7VYEVPso4g12AaC92xEizHhtRToU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f5hbFXO4GqV05aSZjjaObLNHEHR/AyA7llT9StuCDeO9T+L57CI/BuLw6NGzD/+OwdVZTtwGUnzxAHWHnp0jc2gCywvPTh7nDwd4ioE29Ss99ehKqaSDy6vtVEm4Zt1qYSUJV/0iPLlvUN3qclTJyBljNaM9O9aOf/dzWQWtn3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZU+bppD4; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61d7b2ec241so72154a12.0;
        Sat, 30 Aug 2025 13:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756586729; x=1757191529; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7G/WcmK/lPWjxGHmTKrTvdykDvjBtKudXySNTrnZA1s=;
        b=ZU+bppD4cQw1UQIQBtEfarPycWxoZj6AeOwDVjKd1IDe962WxcuiVxqOWoyHNSrhqz
         cuHo27Luf0rGHsMyn57d96UKY+2jbwN4smEmPPZ9iIP4hyBSmHnnwz7mrWBI7vxfLl8l
         UmCQE5JHyGHOCbtAwMeXQgSETDpGk60rUWd5Y8lNCClxEwIeytiO2BBJFsxbtjT7COtX
         gw9Kpdi023QKJ9PpWj73plh1JeaM8/DnenBC/j9NyzdTNYC+GispBj9WZKnKRIwo+d5L
         byZaqKOnNTYU8T0qr5OaS8Zh54R4s5bxG3rUw+2ut4usR1JwMkugkgU2+cDIiOvLQAkM
         tdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756586729; x=1757191529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7G/WcmK/lPWjxGHmTKrTvdykDvjBtKudXySNTrnZA1s=;
        b=oTWdL8binoz3ZLj1AP8qxPaX809Wi8gkPAAcSCw4yanqrFdrs7KQsE07enIk3pQ/v0
         1KqRNH5bQG1Qnd2LbAzomWfb7hz830BPfPceXrMDfoGBXwL4CDcnBIqWI++DSRlDqxrM
         ZdnzhVXDpH1UfH5rur2Noy55XO1cgBshDeRtx3ZBkAtDRmA2c9gTVcUOO+8O6E3zzkab
         W0iiunlkrbxEQxojmFpxkx2ujHg86I0SOs0XajEJ7Rvsl9DcPj/5+gke8/W5Hs5K51pA
         qs8vpmXIqeqPwY6fZWBEYP1FvKvTqgiPHROYUjtscVEvUfYdR5HrZ/hYRkQF+ssG5Bzk
         gD6g==
X-Forwarded-Encrypted: i=1; AJvYcCVgrq4w9hv3PghbrI4XTOoTND2KIGaR9untrMKQ5+Cl2IHZClxs0saQ9Db3A8HaSMNOOK5vyjgMerg9/7s=@vger.kernel.org, AJvYcCX3nQHmjPYMtYR3oNzOyt50UDxJe0OXdgMNWvf+sjtTJ014yyybmiow4yXls38hekxLSRLxSsLXTwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Gyuz9ZNa63pp/qgr4NyX0qEZmb5+fJESQJYHHmVX+yo9+rSU
	qFovrphvszMPWcvRbaSMIuOECxrSKfso1R6Ds1U8AW3ScDKoNKWfbPyv
X-Gm-Gg: ASbGncuOtPjcEzivBuH9E3sHQHwmuqT9pMMjcTk4PNUENdfS1Cr2sv+6mfBfhNAdOF4
	PCyJRQVC5mPPaS54x/i9slUleoSa2CMqb9MoimXzCkd3cTDbxP5eSLBPq9sBYkc7e7nSvZd/DOo
	i+zxlyZDz2a/pqfT/fVKw8sW96ZvXVqbUmjcbvg4jy37h5gfTP7jbe/Q6myng/o5Jszp4pn2RcG
	Zq0H0PHqw0ReLFo71SASsXBj3j9Cj8SQZovFQ26bhV0ZI/Elxr7qX7QWPJx1JBdV5ig2gCUv/5E
	nl5B7W8Wc2DcdbcYebga3zXpMKQ8o/COU8/4/6M/co2U+KB71SMcgnDgxcfMeAJXAqx9S60RPm+
	aZi2fpa+lepCHvNXpGno8jSR/pO9Il+o=
X-Google-Smtp-Source: AGHT+IHvQSgj3QE0hEe6qopBEf3Qr68ADfYAsXr/jvOnpNvPTJhX9STz2rkI6mKad2/JjMwA9zQiEA==
X-Received: by 2002:a05:6402:5189:b0:61c:35c0:87c6 with SMTP id 4fb4d7f45d1cf-61d26892f38mr2316307a12.12.1756586728533;
        Sat, 30 Aug 2025 13:45:28 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc52ade4sm4066630a12.45.2025.08.30.13.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 13:45:28 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Sat, 30 Aug 2025 23:45:17 +0300
Subject: [PATCH 4/9] power: supply: max77705_charger: return error when
 config fails
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-max77705_77976_charger_improvement-v1-4-e976db3fd432@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756586721; l=5440;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=KKiS1ZgRCTnr87a7VYEVPso4g12AaC92xEizHhtRToU=;
 b=pW4sgE0eqBX5p+mivQerCPqXLlFVjTyrnYY4vKwESBN/qEzeKpLjK+YgIaqnUpCxHXMf10cCN
 Yxo5lZeNyauBvBdHUi1FXC2H+YTwT8nP7Xlmk0e+Rqg8bJiRGuIYgXW
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Handle error, returned from register writes in init function.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/power/supply/max77705_charger.c | 90 +++++++++++++++++++++++++--------
 1 file changed, 70 insertions(+), 20 deletions(-)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index 29bb763e56be..1cd122e96953 100644
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
-	regmap_field_write(chg->rfield[MAX77705_CHGPROT], MAX77705_CHGPROT_MASK);
-	regmap_field_write(chg->rfield[MAX77705_LX_SLOPE], MAX77705_SLOWEST_LX_SLOPE);
+	err = regmap_field_write(chg->rfield[MAX77705_CHGPROT], MAX77705_CHGPROT_MASK);
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


