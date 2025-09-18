Return-Path: <linux-pm+bounces-34983-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BD9B8627F
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 19:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1957E29B6
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 17:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3FF3191C2;
	Thu, 18 Sep 2025 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EibF7KxY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6745B317701
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215218; cv=none; b=iKvptFhmC2fpNETEtHOh51jtwByqTc0DFx7hPZ51+TpQOU7lmZnNiYfiCnSjts08zbRQLWfw9GtwvxUoMCAVYn+SmFkFwjOah9HxttUTr+jN8QM/8Ig65Yfe7KeVDgZpraBKPaYRw+u8Qy8UGp9v03HAfFszmkZM/XW3ykBiYds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215218; c=relaxed/simple;
	bh=9bF4jHQg+lKxivFJXmJBwxTSnTVvmDzKxFzLgdySb40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gjlNy8jjGrbkQKtea5uDwZSX9+VUuuq3lOx4O7q/SOOSW+LZJMvc13nngCGbU3cj/4EZan6HWbPYB9HFmebci9D5Fhr0UInGl272X+xvWRSSj3P/FEOfKmsZLLdjdZhQIPEQMKP5qlG7Y/pOtgiDSIzU4gLWJq2H3XmgeNCzubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EibF7KxY; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b0787fa12e2so192623566b.2
        for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 10:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758215215; x=1758820015; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r2tEsyP+iygj2egzFvz4bKYsMR6EihtAp1HSImtRQx4=;
        b=EibF7KxYJE1KNBRmYccy+fewGJxlHhYJYpGZpVnH94V0CxlQ465BPzmAb5fBgut00T
         G1bnn31rNR1rgGxmvrd3XgYfhOiQdc8AMYZsNWUY1Y9NDrFl4hAYB25D7FPhIYM2gY5o
         bnS2GgdO1J8Mib60S36UWHu10lZcC0WKNecDZRPZ9jrvGgYO7qI2vkMIR1spmYHng9yL
         ijnR5bdUXtyNPbkEL3A/HH8IyMGOmMKNutS3LQV9nsXSNOy14nUehtL7/V0FalZ4lavO
         zuUXwjI6A3vvgINfD+C9Zk9ig8D5E3cpPXNbmQdKdMYZU1+zKfeqbqkE8zxVs8yB0ngT
         lGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758215215; x=1758820015;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2tEsyP+iygj2egzFvz4bKYsMR6EihtAp1HSImtRQx4=;
        b=bybKGRO3azA+N/Bk2JCQ03C4YzheUMX1PZ4ypovtP6YiXbAPtZrhPW8nKJN8E8UfCS
         tIhzpe8EZ1H3odQO/dbnmaiOFYVPRXuwc72mQ/uOiOdkacxlaQQUobYlS8Ku0ieWuvZe
         cpfI+ZbAIRaCDlVkYuLs5wXtTwVagkJnqh/fwSITk7zKUvnPx+8MKV7RiUoqwlGo+NJj
         LmeueSEt68H7nzpQFXpIr7FIOv6lyXDYfzNsdFfmtVi9velzToY4Nw5eeesNvGVeCXeb
         ezNU6PIHoNdGSt4KuJtnztF276lkMa5dFanniudyK9IE28h8m6Oc59WFXz/NDdBq29xk
         2mfg==
X-Forwarded-Encrypted: i=1; AJvYcCXZWUvfTVBVikf3GJdeaFUbgRbrI+JHpJIuNItF/oJPnh26pUn9riIbTmaW62HWIU1JFyj6Z0zS4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0HjJwCNJrTUfsXqomfNvw1cMkOlx8QzAUwIS4QLzo9W347oa7
	TBzSgUPx1zJWd1dWrXaWvj1vbWNWfmuDaknbU/CvT8+tN2dp6kvP/b00
X-Gm-Gg: ASbGncul627g7kmXJ8aKS9bdo09j/F3cvfSfPYhE832tVZymPHUENaikgmUT5wMwTgZ
	Ay0vNIJJu0bLTwRElv1B3V+As2g1DsOeweT98aXtmfDGogzPkzJaiWrUkHuGGVFxhEujbc0Zmp3
	E/EVJBXFtgkog1HbD1nKbPCkRb58ZS1QadtPSX4Vbm8joOvOdqbBNNy4iPVbVZPqgC/4++Twwbs
	5o0cFw0DgEysd1ug64Y/TaveyXYKia7PnmCIK9EJSVFqPPKtDQUoR7QxMv8hbHLFJTPCVEw2r1o
	Z/VRHRimB6/MBmTn1wWu/RGRJt0w4srUtOfczQdFwjdV4PNAE2rWeIeveHtHtdFF3nplCZNhvh3
	W8FKqahWjg3d1JgFngJ2vRba1xnyBwJv3x1iE380=
X-Google-Smtp-Source: AGHT+IFGi7Cu+9N7wK3GfO8a5CVp2HtPyS0xOXk5eyDGdkQAtqEJjjRjf8h2IeoDdHdHLj4kdG1Llg==
X-Received: by 2002:a17:906:4fc9:b0:b04:67f3:890f with SMTP id a640c23a62f3a-b1bb7d41a10mr719096966b.33.1758215214544;
        Thu, 18 Sep 2025 10:06:54 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b1fd271f895sm225845366b.97.2025.09.18.10.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 10:06:54 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 18 Sep 2025 20:06:49 +0300
Subject: [PATCH v4 5/9] power: supply: max77705_charger: return error when
 config fails
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-max77705_77976_charger_improvement-v4-5-11ec9188f489@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758215207; l=5448;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=9bF4jHQg+lKxivFJXmJBwxTSnTVvmDzKxFzLgdySb40=;
 b=PjF5Mu2/DzyIkWYeXkpf3Z5tcMhfw7f5vliJpO8ZAHw8RG7etXJVXGNXxA2KQINWINIZjrbsz
 1w5o+6m983bCe0qEnKDaZHugPXNlzsSi7oiyaK+td924u+PNW0XpH3P
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Handle error, returned from register writes in init function.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/power/supply/max77705_charger.c | 90 +++++++++++++++++++++++++--------
 1 file changed, 70 insertions(+), 20 deletions(-)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index 837e03bafcc6..23c643a307bd 100644
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


