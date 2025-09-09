Return-Path: <linux-pm+bounces-34294-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6873FB5053C
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 20:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0381892E53
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 18:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4B735FC33;
	Tue,  9 Sep 2025 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYDZ/Ipy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE7735CEDC;
	Tue,  9 Sep 2025 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442579; cv=none; b=jqiWwNanGnZWaJ80H98WwHS6v/bD6La2z+Ph0Jo3wB9LLiiF9UW2BedkBfhsZjxR8eBYPgMzhKVErpb38Q+Jm/1g8Hsi/+RPQGUfArzQOFcv+UptYXDKljOhLzs6vxQkMRrH+xirfJQ6xkBl6/EpJr79unc55eoWWzLlW9dQVAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442579; c=relaxed/simple;
	bh=xePguBSHxh+UFZ2zTk2qZNnczttKf6Og9jirSWtU4ao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nIY1FRp8BHKPlETirwUNXK0qVTpRU23cwjZ31vt6y3wzhv+8+SRUlTWkj3XtjIfTkVVxzwKodn/ednQEBCTVv1fMVYqTLCeIqowhfaHAesOsu3z5qgJqzn/kd8zfrodZfK4UenfL3EORRak8bQBSwbMFezqP+XGSvhtjhVnK3kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYDZ/Ipy; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b04ba58a84fso497824366b.2;
        Tue, 09 Sep 2025 11:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757442576; x=1758047376; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ua1+fF/75UzR8PkEev3BSJqkYEQqIfzh7nga0Yz7W58=;
        b=CYDZ/Ipy+u5jmR73UCARulkOyOINW/S7pBDKFoKpNnk5KbC9vToNbZIc/s3ROoVqyW
         hPtjU3C+cV9ANhNr1SgnSYPypJn4ni0HNdLJCu40qbbjU/4hJDYudgwv5/OlXOa2+oVZ
         wrG+8CmNiCrC0w/4hRicG6WozLnBX8pAVhjTSFMDCrIkuRROZauwWvkU2OEVqnsh7haf
         LLCAQnPzpx+00TitVWgaGjP/1DMBmS4FyP51z15TeYQs0eGhEZkz/sIjRr2SUTXj7c3w
         rq5NP/TFlyav5vZT3HxD3LAfKLA7q+ZBPk6r66PL+SL3+eYzH3eBZXiHIJTP/LQrjXmh
         x9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757442576; x=1758047376;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ua1+fF/75UzR8PkEev3BSJqkYEQqIfzh7nga0Yz7W58=;
        b=tubR48eEkDJThriju2CQBSUT9zXsaybSNoBydkrzkCEuWs7YFFM31V/upvq19+i02g
         hx8tXCLx2vUZaoKAk3FavI97kncE/BlpNs27oYNJH9ruxHg72ecNNpGPU8AXQM1E72/z
         qqxo6THcg3sfzTUGxm7EG9y7FCVhs7apuOfNq5ImP2dGChqp017AAyl5gD1QdU2BHST4
         ViGKv82NniRW4y8lsEXAclkNGopLM0IDtzIx2W9B0FJ2Nf4ipWP1JqTLKh6mbXHvBdFD
         5lY6Bng793WPlp5qhsqj9YdMgWiJXxVW5NuNdnY8Zdis+E/GEnKxLXwiztZ0Lk2AJ9D9
         +ARg==
X-Forwarded-Encrypted: i=1; AJvYcCVKlfpiUEMinLd0d82dJ2vWRJJ4uD465qk9Ek0MzDP6ser2DdcmMAXBhdnwF3Q/jmWL4wzNrEyNkaU=@vger.kernel.org, AJvYcCVyPjb+0DNo/rp+V2SNE3xXgOFv61irBiD2nRo5y7XUz20/iyupS7y1HL4y1t6OH0kUsBVjU2SKMfN+vrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1LpuaDseBESSNIaXvSIWPIun79tD04wQ/CPnXfLajeJNmnfqr
	Li0x7498mXzUtffj90z/jwUcgCnyL/F+/t3wNrA6Fbbjy0awAOGGpEgi
X-Gm-Gg: ASbGncsGJP7zjrp9qJOB1zlW0jYh2g7ZRZ6YaU1PySEX4lqsqY/H1ySLA8Tkvvgvf2R
	C4tBWMX2Oxh4g4aUthOJvuY6pKmAu3bQPdt6qIFgDIk4tLO7QaODdVd/LIbtgTxAZDUJPp26Fn1
	CnJy0v1DSrOuUPvnzS1a5xBVXqPEc1rdouVOirN8uYQqiIbvo+dlbdpZ0bkxLjGc9FhmUZH+/l/
	DP2X/9kWa4nOF1kTqo4SeFjy54fC4EjdLQwCO30fZqNWuKTE704ltCa4t+cIAJhXdCd2u9EvwrE
	t08272qumoqO5EMlfw7YH3xnDxgYsvw1PdxkbyDYvXUUehX4TRTgspHYHBfc1wmuK2LWoZ1ZKhR
	6GlrnmfXDDekHkfnzpWFIBizu2KdpGPJGCr0vDe6xPw==
X-Google-Smtp-Source: AGHT+IFdZcwSECgg3goUH52a0hSiSTRbwnIjETBP/q6zVrMFlqxnZfMRJzm6QdxqdIjMPsFEnyYqQw==
X-Received: by 2002:a17:907:3d06:b0:b04:3756:ad07 with SMTP id a640c23a62f3a-b04b16db227mr1092535166b.44.1757442575708;
        Tue, 09 Sep 2025 11:29:35 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b07833ebe61sm30520666b.89.2025.09.09.11.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:29:35 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 09 Sep 2025 21:29:13 +0300
Subject: [PATCH v2 3/9] power: supply: max77705_charger: use regfields for
 config registers
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-max77705_77976_charger_improvement-v2-3-a8d2fba47159@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757442571; l=16663;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=xePguBSHxh+UFZ2zTk2qZNnczttKf6Og9jirSWtU4ao=;
 b=wS29D9aiix7E7c6dAGCMn4IQyhHyVZY0TDqyd+L9D1zRLCSHQF/11MYsENrQbZqIn8+nMBv98
 2CAnvF8L3JxC3SvW7ZDhXFM/xFxF1RzEzNxrfwpY0vjQ7Y3jZQNPruL
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Using regfields allows to cleanup masks and register offset definition,
allowing to access register info by it's functional name.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes to v2:
- fix MAX77705_CHGPROT_UNLOCKED value: GENMASK(3, 2) -> 3, because it's
  now used in regfield
- remove MAX77705_CHGPROT_MASK because it's unused now
---
 drivers/power/supply/max77705_charger.c | 105 ++++++++++++--------------------
 include/linux/power/max77705_charger.h  | 102 ++++++++++++++++---------------
 2 files changed, 93 insertions(+), 114 deletions(-)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index 7855f890e0a9..2d2201a6ba68 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -74,8 +74,7 @@ static int max77705_charger_enable(struct max77705_charger_data *chg)
 {
 	int rv;
 
-	rv = regmap_update_bits(chg->regmap, MAX77705_CHG_REG_CNFG_09,
-				MAX77705_CHG_EN_MASK, MAX77705_CHG_EN_MASK);
+	rv = regmap_field_write(chg->rfield[MAX77705_CHG_EN], 1);
 	if (rv)
 		dev_err(chg->dev, "unable to enable the charger: %d\n", rv);
 
@@ -87,10 +86,7 @@ static void max77705_charger_disable(void *data)
 	struct max77705_charger_data *chg = data;
 	int rv;
 
-	rv = regmap_update_bits(chg->regmap,
-				MAX77705_CHG_REG_CNFG_09,
-				MAX77705_CHG_EN_MASK,
-				MAX77705_CHG_DISABLE);
+	rv = regmap_field_write(chg->rfield[MAX77705_CHG_EN], MAX77705_CHG_DISABLE);
 	if (rv)
 		dev_err(chg->dev, "unable to disable the charger: %d\n", rv);
 }
@@ -134,10 +130,10 @@ static int max77705_check_battery(struct max77705_charger_data *chg, int *val)
 static int max77705_get_charge_type(struct max77705_charger_data *chg, int *val)
 {
 	struct regmap *regmap = chg->regmap;
-	unsigned int reg_data;
+	unsigned int reg_data, chg_en;
 
-	regmap_read(regmap, MAX77705_CHG_REG_CNFG_09, &reg_data);
-	if (!MAX77705_CHARGER_CHG_CHARGING(reg_data)) {
+	regmap_field_read(chg->rfield[MAX77705_CHG_EN], &chg_en);
+	if (!chg_en) {
 		*val = POWER_SUPPLY_CHARGE_TYPE_NONE;
 		return 0;
 	}
@@ -162,10 +158,10 @@ static int max77705_get_charge_type(struct max77705_charger_data *chg, int *val)
 static int max77705_get_status(struct max77705_charger_data *chg, int *val)
 {
 	struct regmap *regmap = chg->regmap;
-	unsigned int reg_data;
+	unsigned int reg_data, chg_en;
 
-	regmap_read(regmap, MAX77705_CHG_REG_CNFG_09, &reg_data);
-	if (!MAX77705_CHARGER_CHG_CHARGING(reg_data)) {
+	regmap_field_read(chg->rfield[MAX77705_CHG_EN], &chg_en);
+	if (!chg_en) {
 		*val = POWER_SUPPLY_CHARGE_TYPE_NONE;
 		return 0;
 	}
@@ -295,16 +291,11 @@ static int max77705_get_input_current(struct max77705_charger_data *chg,
 {
 	unsigned int reg_data;
 	int get_current = 0;
-	struct regmap *regmap = chg->regmap;
 
-	regmap_read(regmap, MAX77705_CHG_REG_CNFG_09, &reg_data);
-
-	reg_data &= MAX77705_CHG_CHGIN_LIM_MASK;
+	regmap_field_read(chg->rfield[MAX77705_CHG_CHGIN_LIM], &reg_data);
 
 	if (reg_data <= 3)
 		get_current = MAX77705_CURRENT_CHGIN_MIN;
-	else if (reg_data >= MAX77705_CHG_CHGIN_LIM_MASK)
-		get_current = MAX77705_CURRENT_CHGIN_MAX;
 	else
 		get_current = (reg_data + 1) * MAX77705_CURRENT_CHGIN_STEP;
 
@@ -317,10 +308,8 @@ static int max77705_get_charge_current(struct max77705_charger_data *chg,
 					int *val)
 {
 	unsigned int reg_data;
-	struct regmap *regmap = chg->regmap;
 
-	regmap_read(regmap, MAX77705_CHG_REG_CNFG_02, &reg_data);
-	reg_data &= MAX77705_CHG_CC;
+	regmap_field_read(chg->rfield[MAX77705_CHG_CC_LIM], &reg_data);
 
 	*val = reg_data <= 0x2 ? MAX77705_CURRENT_CHGIN_MIN : reg_data * MAX77705_CURRENT_CHG_STEP;
 
@@ -332,7 +321,6 @@ static int max77705_set_float_voltage(struct max77705_charger_data *chg,
 {
 	int float_voltage_mv;
 	unsigned int reg_data = 0;
-	struct regmap *regmap = chg->regmap;
 
 	float_voltage_mv = float_voltage / 1000;
 	reg_data = float_voltage_mv <= 4000 ? 0x0 :
@@ -340,9 +328,7 @@ static int max77705_set_float_voltage(struct max77705_charger_data *chg,
 		(float_voltage_mv <= 4200) ? (float_voltage_mv - 4000) / 50 :
 		(((float_voltage_mv - 4200) / 10) + 0x04);
 
-	return regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_04,
-				MAX77705_CHG_CV_PRM_MASK,
-				(reg_data << MAX77705_CHG_CV_PRM_SHIFT));
+	return regmap_field_write(chg->rfield[MAX77705_CHG_CV_PRM], reg_data);
 }
 
 static int max77705_get_float_voltage(struct max77705_charger_data *chg,
@@ -350,10 +336,8 @@ static int max77705_get_float_voltage(struct max77705_charger_data *chg,
 {
 	unsigned int reg_data = 0;
 	int voltage_mv;
-	struct regmap *regmap = chg->regmap;
 
-	regmap_read(regmap, MAX77705_CHG_REG_CNFG_04, &reg_data);
-	reg_data &= MAX77705_CHG_PRM_MASK;
+	regmap_field_read(chg->rfield[MAX77705_CHG_CV_PRM], &reg_data);
 	voltage_mv = reg_data <= 0x04 ? reg_data * 50 + 4000 :
 					(reg_data - 4) * 10 + 4200;
 	*val = voltage_mv * 1000;
@@ -418,7 +402,6 @@ static void max77705_chgin_isr_work(struct work_struct *work)
 
 static void max77705_charger_initialize(struct max77705_charger_data *chg)
 {
-	u8 reg_data;
 	struct power_supply_battery_info *info;
 	struct regmap *regmap = chg->regmap;
 
@@ -429,45 +412,31 @@ static void max77705_charger_initialize(struct max77705_charger_data *chg)
 
 	/* unlock charger setting protect */
 	/* slowest LX slope */
-	reg_data = MAX77705_CHGPROT_MASK | MAX77705_SLOWEST_LX_SLOPE;
-	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_06, reg_data,
-						reg_data);
+	regmap_field_write(chg->rfield[MAX77705_CHGPROT], MAX77705_CHGPROT_UNLOCKED);
+	regmap_field_write(chg->rfield[MAX77705_LX_SLOPE], MAX77705_SLOWEST_LX_SLOPE);
 
 	/* fast charge timer disable */
 	/* restart threshold disable */
 	/* pre-qual charge disable */
-	reg_data = (MAX77705_FCHGTIME_DISABLE << MAX77705_FCHGTIME_SHIFT) |
-			(MAX77705_CHG_RSTRT_DISABLE << MAX77705_CHG_RSTRT_SHIFT) |
-			(MAX77705_CHG_PQEN_DISABLE << MAX77705_PQEN_SHIFT);
-	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_01,
-						(MAX77705_FCHGTIME_MASK |
-						MAX77705_CHG_RSTRT_MASK |
-						MAX77705_PQEN_MASK),
-						reg_data);
-
-	/* OTG off(UNO on), boost off */
-	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_00,
-				MAX77705_OTG_CTRL, 0);
+	regmap_field_write(chg->rfield[MAX77705_FCHGTIME], MAX77705_FCHGTIME_DISABLE);
+	regmap_field_write(chg->rfield[MAX77705_CHG_RSTRT], MAX77705_CHG_RSTRT_DISABLE);
+	regmap_field_write(chg->rfield[MAX77705_CHG_PQEN], MAX77705_CHG_PQEN_DISABLE);
+
+	regmap_field_write(chg->rfield[MAX77705_MODE],
+			MAX77705_CHG_MASK | MAX77705_BUCK_MASK);
 
 	/* charge current 450mA(default) */
 	/* otg current limit 900mA */
-	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_02,
-				MAX77705_OTG_ILIM_MASK,
-				MAX77705_OTG_ILIM_900 << MAX77705_OTG_ILIM_SHIFT);
+	regmap_field_write(chg->rfield[MAX77705_OTG_ILIM], MAX77705_OTG_ILIM_900);
 
 	/* BAT to SYS OCP 4.80A */
-	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_05,
-				MAX77705_REG_B2SOVRC_MASK,
-				MAX77705_B2SOVRC_4_8A << MAX77705_REG_B2SOVRC_SHIFT);
+	regmap_field_write(chg->rfield[MAX77705_REG_B2SOVRC], MAX77705_B2SOVRC_4_8A);
+
 	/* top off current 150mA */
 	/* top off timer 30min */
-	reg_data = (MAX77705_TO_ITH_150MA << MAX77705_TO_ITH_SHIFT) |
-			(MAX77705_TO_TIME_30M << MAX77705_TO_TIME_SHIFT) |
-			(MAX77705_SYS_TRACK_DISABLE << MAX77705_SYS_TRACK_DIS_SHIFT);
-	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_03,
-			   (MAX77705_TO_ITH_MASK |
-			   MAX77705_TO_TIME_MASK |
-			   MAX77705_SYS_TRACK_DIS_MASK), reg_data);
+	regmap_field_write(chg->rfield[MAX77705_TO], MAX77705_TO_ITH_150MA);
+	regmap_field_write(chg->rfield[MAX77705_TO_TIME], MAX77705_TO_TIME_30M);
+	regmap_field_write(chg->rfield[MAX77705_SYS_TRACK], MAX77705_SYS_TRACK_DISABLE);
 
 	/* cv voltage 4.2V or 4.35V */
 	/* MINVSYS 3.6V(default) */
@@ -478,25 +447,21 @@ static void max77705_charger_initialize(struct max77705_charger_data *chg)
 		max77705_set_float_voltage(chg, info->voltage_max_design_uv);
 	}
 
-	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_12,
-				MAX77705_VCHGIN_REG_MASK, MAX77705_VCHGIN_4_5);
-	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_12,
-				MAX77705_WCIN_REG_MASK, MAX77705_WCIN_4_5);
+	regmap_field_write(chg->rfield[MAX77705_VCHGIN], MAX77705_VCHGIN_4_5);
+	regmap_field_write(chg->rfield[MAX77705_WCIN], MAX77705_WCIN_4_5);
 
 	/* Watchdog timer */
 	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_00,
 				MAX77705_WDTEN_MASK, 0);
 
 	/* VBYPSET=5.0V */
-	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_11, MAX77705_VBYPSET_MASK, 0);
+	regmap_field_write(chg->rfield[MAX77705_VBYPSET], 0);
 
 	/* Switching Frequency : 1.5MHz */
-	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_08, MAX77705_REG_FSW_MASK,
-				(MAX77705_CHG_FSW_1_5MHz << MAX77705_REG_FSW_SHIFT));
+	regmap_field_write(chg->rfield[MAX77705_REG_FSW], MAX77705_CHG_FSW_1_5MHz);
 
 	/* Auto skip mode */
-	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_12, MAX77705_REG_DISKIP_MASK,
-				(MAX77705_AUTO_SKIP << MAX77705_REG_DISKIP_SHIFT));
+	regmap_field_write(chg->rfield[MAX77705_REG_DISKIP], MAX77705_AUTO_SKIP);
 }
 
 static int max77705_charger_probe(struct i2c_client *i2c)
@@ -520,6 +485,14 @@ static int max77705_charger_probe(struct i2c_client *i2c)
 	if (IS_ERR(chg->regmap))
 		return PTR_ERR(chg->regmap);
 
+	for (int i = 0; i < MAX77705_N_REGMAP_FIELDS; i++) {
+		chg->rfield[i] = devm_regmap_field_alloc(dev, chg->regmap,
+							 max77705_reg_field[i]);
+		if (IS_ERR(chg->rfield[i]))
+			return dev_err_probe(dev, PTR_ERR(chg->rfield[i]),
+					     "cannot allocate regmap field\n");
+	}
+
 	ret = regmap_update_bits(chg->regmap,
 				MAX77705_CHG_REG_INT_MASK,
 				MAX77705_CHGIN_IM, 0);
diff --git a/include/linux/power/max77705_charger.h b/include/linux/power/max77705_charger.h
index fdec9af9c541..a612795577b6 100644
--- a/include/linux/power/max77705_charger.h
+++ b/include/linux/power/max77705_charger.h
@@ -9,6 +9,8 @@
 #ifndef __MAX77705_CHARGER_H
 #define __MAX77705_CHARGER_H __FILE__
 
+#include <linux/regmap.h>
+
 /* MAX77705_CHG_REG_CHG_INT */
 #define MAX77705_BYP_I		BIT(0)
 #define MAX77705_INP_LIMIT_I	BIT(1)
@@ -63,7 +65,6 @@
 #define MAX77705_BUCK_SHIFT	2
 #define MAX77705_BOOST_SHIFT	3
 #define MAX77705_WDTEN_SHIFT	4
-#define MAX77705_MODE_MASK	GENMASK(3, 0)
 #define MAX77705_CHG_MASK	BIT(MAX77705_CHG_SHIFT)
 #define MAX77705_UNO_MASK	BIT(MAX77705_UNO_SHIFT)
 #define MAX77705_OTG_MASK	BIT(MAX77705_OTG_SHIFT)
@@ -74,34 +75,19 @@
 #define MAX77705_OTG_CTRL	(MAX77705_OTG_MASK | MAX77705_BOOST_MASK)
 
 /* MAX77705_CHG_REG_CNFG_01 */
-#define MAX77705_FCHGTIME_SHIFT		0
-#define MAX77705_FCHGTIME_MASK		GENMASK(2, 0)
-#define MAX77705_CHG_RSTRT_SHIFT	4
-#define MAX77705_CHG_RSTRT_MASK		GENMASK(5, 4)
 #define MAX77705_FCHGTIME_DISABLE	0
 #define MAX77705_CHG_RSTRT_DISABLE	0x3
 
-#define MAX77705_PQEN_SHIFT		7
-#define MAX77705_PQEN_MASK		BIT(7)
 #define MAX77705_CHG_PQEN_DISABLE	0
 #define MAX77705_CHG_PQEN_ENABLE	1
 
 /* MAX77705_CHG_REG_CNFG_02 */
-#define MAX77705_OTG_ILIM_SHIFT		6
-#define MAX77705_OTG_ILIM_MASK		GENMASK(7, 6)
 #define MAX77705_OTG_ILIM_500		0
 #define MAX77705_OTG_ILIM_900		1
 #define MAX77705_OTG_ILIM_1200		2
 #define MAX77705_OTG_ILIM_1500		3
-#define MAX77705_CHG_CC			GENMASK(5, 0)
 
 /* MAX77705_CHG_REG_CNFG_03 */
-#define MAX77705_TO_ITH_SHIFT		0
-#define MAX77705_TO_ITH_MASK		GENMASK(2, 0)
-#define MAX77705_TO_TIME_SHIFT		3
-#define MAX77705_TO_TIME_MASK		GENMASK(5, 3)
-#define MAX77705_SYS_TRACK_DIS_SHIFT	7
-#define MAX77705_SYS_TRACK_DIS_MASK	BIT(7)
 #define MAX77705_TO_ITH_150MA		0
 #define MAX77705_TO_TIME_30M		3
 #define MAX77705_SYS_TRACK_ENABLE	0
@@ -110,15 +96,8 @@
 /* MAX77705_CHG_REG_CNFG_04 */
 #define MAX77705_CHG_MINVSYS_SHIFT	6
 #define MAX77705_CHG_MINVSYS_MASK	GENMASK(7, 6)
-#define MAX77705_CHG_PRM_SHIFT		0
-#define MAX77705_CHG_PRM_MASK		GENMASK(5, 0)
-
-#define MAX77705_CHG_CV_PRM_SHIFT	0
-#define MAX77705_CHG_CV_PRM_MASK	GENMASK(5, 0)
 
 /* MAX77705_CHG_REG_CNFG_05 */
-#define MAX77705_REG_B2SOVRC_SHIFT	0
-#define MAX77705_REG_B2SOVRC_MASK	GENMASK(3, 0)
 #define MAX77705_B2SOVRC_DISABLE	0
 #define MAX77705_B2SOVRC_4_5A		6
 #define MAX77705_B2SOVRC_4_8A		8
@@ -128,9 +107,8 @@
 #define MAX77705_WDTCLR_SHIFT		0
 #define MAX77705_WDTCLR_MASK		GENMASK(1, 0)
 #define MAX77705_WDTCLR			1
-#define MAX77705_CHGPROT_MASK		GENMASK(3, 2)
-#define MAX77705_CHGPROT_UNLOCKED	GENMASK(3, 2)
-#define MAX77705_SLOWEST_LX_SLOPE	GENMASK(6, 5)
+#define MAX77705_CHGPROT_UNLOCKED	3
+#define MAX77705_SLOWEST_LX_SLOPE	3
 
 /* MAX77705_CHG_REG_CNFG_07 */
 #define MAX77705_CHG_FMBST		4
@@ -140,36 +118,14 @@
 #define MAX77705_REG_FGSRC_MASK		BIT(MAX77705_REG_FGSRC_SHIFT)
 
 /* MAX77705_CHG_REG_CNFG_08 */
-#define MAX77705_REG_FSW_SHIFT		0
-#define MAX77705_REG_FSW_MASK		GENMASK(1, 0)
 #define MAX77705_CHG_FSW_3MHz		0
 #define MAX77705_CHG_FSW_2MHz		1
 #define MAX77705_CHG_FSW_1_5MHz		2
 
 /* MAX77705_CHG_REG_CNFG_09 */
-#define MAX77705_CHG_CHGIN_LIM_MASK		GENMASK(6, 0)
-#define MAX77705_CHG_EN_MASK			BIT(7)
 #define MAX77705_CHG_DISABLE			0
-#define MAX77705_CHARGER_CHG_CHARGING(_reg) \
-				(((_reg) & MAX77705_CHG_EN_MASK) > 1)
-
-
-/* MAX77705_CHG_REG_CNFG_10 */
-#define MAX77705_CHG_WCIN_LIM		GENMASK(5, 0)
-
-/* MAX77705_CHG_REG_CNFG_11 */
-#define MAX77705_VBYPSET_SHIFT		0
-#define MAX77705_VBYPSET_MASK		GENMASK(6, 0)
 
 /* MAX77705_CHG_REG_CNFG_12 */
-#define MAX77705_CHGINSEL_SHIFT		5
-#define MAX77705_CHGINSEL_MASK		BIT(MAX77705_CHGINSEL_SHIFT)
-#define MAX77705_WCINSEL_SHIFT		6
-#define MAX77705_WCINSEL_MASK		BIT(MAX77705_WCINSEL_SHIFT)
-#define MAX77705_VCHGIN_REG_MASK	GENMASK(4, 3)
-#define MAX77705_WCIN_REG_MASK		GENMASK(2, 1)
-#define MAX77705_REG_DISKIP_SHIFT	0
-#define MAX77705_REG_DISKIP_MASK	BIT(MAX77705_REG_DISKIP_SHIFT)
 /* REG=4.5V, UVLO=4.7V */
 #define MAX77705_VCHGIN_4_5		0
 /* REG=4.5V, UVLO=4.7V */
@@ -183,9 +139,59 @@
 #define MAX77705_CURRENT_CHGIN_MIN	100000
 #define MAX77705_CURRENT_CHGIN_MAX	3200000
 
+enum max77705_field_idx {
+	MAX77705_CHGPROT,
+	MAX77705_CHG_EN,
+	MAX77705_CHG_CC_LIM,
+	MAX77705_CHG_CHGIN_LIM,
+	MAX77705_CHG_CV_PRM,
+	MAX77705_CHG_PQEN,
+	MAX77705_CHG_RSTRT,
+	MAX77705_CHG_WCIN,
+	MAX77705_FCHGTIME,
+	MAX77705_LX_SLOPE,
+	MAX77705_MODE,
+	MAX77705_OTG_ILIM,
+	MAX77705_REG_B2SOVRC,
+	MAX77705_REG_DISKIP,
+	MAX77705_REG_FSW,
+	MAX77705_SYS_TRACK,
+	MAX77705_TO,
+	MAX77705_TO_TIME,
+	MAX77705_VBYPSET,
+	MAX77705_VCHGIN,
+	MAX77705_WCIN,
+	MAX77705_N_REGMAP_FIELDS,
+};
+
+static const struct reg_field max77705_reg_field[MAX77705_N_REGMAP_FIELDS] = {
+	[MAX77705_MODE]			= REG_FIELD(MAX77705_CHG_REG_CNFG_00,   0, 3),
+	[MAX77705_FCHGTIME]		= REG_FIELD(MAX77705_CHG_REG_CNFG_01,   0, 2),
+	[MAX77705_CHG_RSTRT]		= REG_FIELD(MAX77705_CHG_REG_CNFG_01,   4, 5),
+	[MAX77705_CHG_PQEN]		= REG_FIELD(MAX77705_CHG_REG_CNFG_01,   7, 7),
+	[MAX77705_CHG_CC_LIM]		= REG_FIELD(MAX77705_CHG_REG_CNFG_02,   0, 5),
+	[MAX77705_OTG_ILIM]		= REG_FIELD(MAX77705_CHG_REG_CNFG_02,   6, 7),
+	[MAX77705_TO]			= REG_FIELD(MAX77705_CHG_REG_CNFG_03,   0, 2),
+	[MAX77705_TO_TIME]		= REG_FIELD(MAX77705_CHG_REG_CNFG_03,   3, 5),
+	[MAX77705_SYS_TRACK]		= REG_FIELD(MAX77705_CHG_REG_CNFG_03,   7, 7),
+	[MAX77705_CHG_CV_PRM]		= REG_FIELD(MAX77705_CHG_REG_CNFG_04,   0, 5),
+	[MAX77705_REG_B2SOVRC]		= REG_FIELD(MAX77705_CHG_REG_CNFG_05,   0, 3),
+	[MAX77705_CHGPROT]		= REG_FIELD(MAX77705_CHG_REG_CNFG_06,   2, 3),
+	[MAX77705_LX_SLOPE]		= REG_FIELD(MAX77705_CHG_REG_CNFG_06,   5, 6),
+	[MAX77705_REG_FSW]		= REG_FIELD(MAX77705_CHG_REG_CNFG_08,   0, 1),
+	[MAX77705_CHG_CHGIN_LIM]	= REG_FIELD(MAX77705_CHG_REG_CNFG_09,   0, 6),
+	[MAX77705_CHG_EN]		= REG_FIELD(MAX77705_CHG_REG_CNFG_09,   7, 7),
+	[MAX77705_CHG_WCIN]		= REG_FIELD(MAX77705_CHG_REG_CNFG_10,   0, 5),
+	[MAX77705_VBYPSET]		= REG_FIELD(MAX77705_CHG_REG_CNFG_11,   0, 6),
+	[MAX77705_REG_DISKIP]		= REG_FIELD(MAX77705_CHG_REG_CNFG_12,   0, 0),
+	[MAX77705_WCIN]			= REG_FIELD(MAX77705_CHG_REG_CNFG_12,   1, 2),
+	[MAX77705_VCHGIN]		= REG_FIELD(MAX77705_CHG_REG_CNFG_12,   3, 4),
+};
+
 struct max77705_charger_data {
 	struct device			*dev;
 	struct regmap		*regmap;
+	struct regmap_field	*rfield[MAX77705_N_REGMAP_FIELDS];
 	struct power_supply_battery_info *bat_info;
 	struct workqueue_struct *wqueue;
 	struct work_struct	chgin_work;

-- 
2.39.5


