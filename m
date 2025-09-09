Return-Path: <linux-pm+bounces-34295-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52813B5053E
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 20:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30AD47B5FBD
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 18:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE21362068;
	Tue,  9 Sep 2025 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMNCqBUx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C68A35E4F4;
	Tue,  9 Sep 2025 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442580; cv=none; b=oqZ/IfwvjTJrobotNO3W++gAuQQXfuDlJROjpDO8jZ4O4kHA3K1gt3w7jrUra+4h8zukhsm6ULrbrVyPiSZccxpL8bFAeTkKbyUFkr3Hb9ZzATsDKcoxzTUdODH6unpwjtj6+UHCqp0NRdAY3Ufij/6sJC2LAMf2+1HOagtHSMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442580; c=relaxed/simple;
	bh=bGDCk3kzbdsUZZQhl6KUQ8bvyiKh/w2K/fZ43Aq2I4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I4Mttck+O9qWKfCdd1YN1VorzIeuyo9+YGbQlxR7Au7vWrIjJeIxw+kN5h67t4EoTn1tMPuopGaMW7WbprnD4Ik/3e/WczqCXx7eTdKbXDbqM2zjVKYOowl5uQqtHGhxgM6BMs6zKk1Nfynu6bCHi8VeZjNpWRCrv8C6SqnyiaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMNCqBUx; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b02c719a117so1058845266b.1;
        Tue, 09 Sep 2025 11:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757442577; x=1758047377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=75UGwiqWwN4s+IR/YJTkSJX8KNi4Qm/u3Bm/PVxwIIg=;
        b=OMNCqBUxa8Iz46Hzp1mIL6kMksExEBpY9C4rank2Hrb+Qhgfu7qfQVGZ68+ala4Q9v
         VHRE0grPR+BXxUZHk4lHDaALVoVgfQ7AeCqQKIQEa6HHHyQzjKiUuwf9oSsA1ltK/tNm
         pN0iQ53jkk3NgX92bw1M6hJKtervVpk983m8OyvBKL0osKHFefSFs9QZdwlHwvH0zbNc
         BcLPqaUL2y+3VbLuUvDPVYKALiEj3//Sk/0+S11zpvlBD32sNRe1ilJ4uYy1O1GjMsmL
         EUpHdPC0FvNI+/IvLUjDlSD50iy+ZxJY1wzNHuDS7OZ56IjYsog/DEiJjQoP3nQLkhlA
         jRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757442577; x=1758047377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75UGwiqWwN4s+IR/YJTkSJX8KNi4Qm/u3Bm/PVxwIIg=;
        b=dzdIXYbRVb1VGVrsDF3ByBWnllH1JN5WlmrXBDhwLo5Jb5WIjNUr1upevIYjYfqUDy
         2KySNZmd+jNDASicFfo81BEQzITMpZY1iI4CLVc+M0bVMm18oTx621XlsYDK3Ao7yXRz
         CkpBnlmR4whjhtPBY2zRzi2TNunSvhaAHuDpqKcIn6uErrqrjXqH8wzqRK73HCZIXc2V
         JxmhFjz5Qg0M6RYbWze4i5iV4ouSFBgvkgGJ27hjVqyI6ScM+jBRVqBk4f+NdejbEaAf
         RfZb/6OCBpOYFGJhDDB3kDi9n6IPrfdR42Hz7T+YDubmR9CfskCmgldm3JuWff1Zo0Rk
         /4Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUesBm6XtemUogEzkwAVMcBTKqgNZS9j2aQkR8cFdKZZqADbpgOE2Qu6P/ZBmcZrXnzM5EbB9pZJf4=@vger.kernel.org, AJvYcCXApLcJG3l+U1N5X6c6ijxpgVYDZj8VQt7peYnegQmta9RyxQW/YdbjejZ9DYGiB8i8OaSPpTBzEWVSZuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI6Us7VBS2zOSOVgNrpKIWBrRGS0h/Ry2/3hkUDTPuYz0cLih+
	zGoWU1T0BM33xNrKit22sifLM2O+DFwW35MUpGDrMwu9P7ZVRk4Js+gI
X-Gm-Gg: ASbGncsk1EcuMuNpKOYmKOY9TXX538siDmkApTGuwsDBSx5d6ZYu1RZv8PFwNVPU7Ob
	dpLYK47TTfsZox2TlIkji+gET6mtPudhHgen+7xJRpAkgRkyQ9IZA9m3/yBPPOrLSIVWdz/byS9
	kJL+BESzu59HUJAW9zZaW1hZ79ZrOYeIDFR2862JAqvLNbHPp0NPpoLIeGHWnMGl1sY8HWgtPHp
	hlOzn8QjjHjRgGcST/cC5rqHDajYdYLLpgMv3OZvXh1/53cQho2FZU4ChNSQc3K5hsqXpa3cdYo
	7lJ3BIo1G2Xg0BiH9cEQ5tfrH16avnZuWKLa9cob1QgBBcTx7AU8dLr94z8EuOydnEOorzYAupC
	SKUfCJnMQ3pCPAzzGbdJM
X-Google-Smtp-Source: AGHT+IEdHmeSp/6VMMApWO57l8FhzV+WxGnVL1/dpTYl9aD3cquzcIQmXOcll6firvjO4tpMXbtfLQ==
X-Received: by 2002:a17:907:6eaa:b0:af9:24e7:1c85 with SMTP id a640c23a62f3a-b04b172fe37mr1262061566b.55.1757442576819;
        Tue, 09 Sep 2025 11:29:36 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b07833ebe61sm30520666b.89.2025.09.09.11.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:29:36 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 09 Sep 2025 21:29:14 +0300
Subject: [PATCH v2 4/9] power: supply: max77705_charger: return error when
 config fails
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-max77705_77976_charger_improvement-v2-4-a8d2fba47159@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757442571; l=5448;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=bGDCk3kzbdsUZZQhl6KUQ8bvyiKh/w2K/fZ43Aq2I4Q=;
 b=ZPrHCQP3nIttZzTw5ojt/2Gxu/vr/2L2kqqzl5W4Lo5EU7Tp2IsMzhjh1v2tia+X8AmjP3aw8
 P6tU56600q2BEWsqNzSYSftKE3mhZrBWe7WCBPNtfjS8SHiR28UkOQH
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


