Return-Path: <linux-pm+bounces-34981-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBA5B86270
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 19:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DCA77E2779
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 17:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FC3318131;
	Thu, 18 Sep 2025 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAUn69cg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40186314B97
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215216; cv=none; b=HmKi3nBYBBrDhOgYaBcZAdyj4vPDf1M9JHmEH+hNVpAEqgBtVgWBHmuJIqAYms7PdID0tkm7lVG192JrKjpJHAoQF4YbbU2O2I43BXhYcUiwA5bti1H1tXscxuqVyK/QpmddothDuHXyJEo5giuNtGndtG4pXMcNz3fJN+oVWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215216; c=relaxed/simple;
	bh=TwNup/iXllk/aE5uv69gK2pIQ5cN9oOrdUW6G6HU6cc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z3Bxz5Y0egaDM93gHcC6L+kfAXrVRCjC373MFy4sVCJaStVepYp/R9c1KZTvGiQFZW01Lxvq3YAPXr8dKD7Xw547HBImu8Ee44BQnptyYOz8GaCEOon+Ibbdn0hShSwEIot17OONJa4anBNI+rN/2BE9HmVfO0xwOidUvYlpTlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAUn69cg; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b042eb09948so222913966b.3
        for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 10:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758215212; x=1758820012; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhSbgW1VzSDstLgmluAXRQW27SnUfK5wIY0vgvmVoX0=;
        b=LAUn69cg9m09qz6np1dmatJTANUnYpkTu77CrenhgygsV9yfR6HSN7M2SB1pmFoADL
         u0m75Mx+SFd3kgZj0HyLUc4GBtruniPvFkdRBLgQC7qIjlw0z70LZrHxy67pkz17vlZF
         YAAcquYqUywVXPNNVUM9L8nw1v1ed/5HUsPpImbljqqC6sEyhxgf/bEIYHOrDFipbAP2
         bDlTl1fV0TzM3RzLg9cv9Kha0gkYTNjgJdk18eNQjo5TJM/ZTa5iK4jfHmI+9g4KcnAx
         agXLsKcU9sSpENG8GX2KRO5pGt+01K/a16OrsakRwcmikUbH595j+qenPO3/1SbY6eQc
         YWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758215212; x=1758820012;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KhSbgW1VzSDstLgmluAXRQW27SnUfK5wIY0vgvmVoX0=;
        b=fO9iQLF7VxtZShILkPw3KoiD4yJ5j3Gjn1ihO+VSptDWpqnvvLxANuDdfm0Q6+LnBi
         OCgeU9XiTEXeIPADMV8nA4kTCi7abz3VOoB1pwahtQjX7aI8uisb7JxocnmxN0bRQEgy
         QN/oUEpOPghbrdtH4etQTOXnrJHVi1tKESmg+hXF8rq2hP9n4eh9Z8uuiI7SfVzqi67a
         Anx+nBaCzuS5TyBP7fTI/4FGc7LOKXEMPvoYdIzbpGTFgGRRBPkRY7gG9RNj40dY0fR5
         l4w5U0/Fhnz3PeXHJgbBUgrg6ZXictOzV42/aIn/Uvw5X76n3SPP89dI7p3yCeEV7hHJ
         8ITg==
X-Forwarded-Encrypted: i=1; AJvYcCUPs0EiFc6mr6TgcopdM1UD6Pm1kvRj2eXASaIRp+cG24JDw9qu51siE0VU0i+6Rkr2jcR+NzIOrw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw58h2w4YOlPZiphdt5ii5BoD5WJJkulU2XxyYLcvl7FgN/x9l0
	uUtHS1fQ7PqLadkE1ceyEVgWiEMcvmZMRVY8Va6qZuiCnTaQrpL3Nb5p
X-Gm-Gg: ASbGnctyYo5kMf+5nNmscAnLWNzLTkXxMDhweYfkKEDnejZgNKd95vqwTwr0jHrr/hM
	zrdTwIzxVADeV227lBu640y3YtJsXvQrCf0rbfX+q26/D5wBFW/ZtN4vU7WdcPOIFbmae2JG+5+
	jBNwxMXPe6AsBy5fFXdLsLccRNv2+OKPV97HSSwAqpaFoBIvsetW/K8qCeag/NI1PP2BUO2RwEE
	+kD7YKWGZfAsZBBQh5Ishs7Vv2FSRtyUJy3fbMaHg4qQyjnLX8THAstAOo69vWvWb79UdrKk/H6
	tKI8cNQa0CY/t6jvz0QRZnbWAaVOyuLSKb7u4AeCDlK4etSfVl4g3ptbRqkGuxRuwlPLGGvljzQ
	64r1R1PGNT9ieWLHO/YuIOGlzeiRQzbCUUimYGis=
X-Google-Smtp-Source: AGHT+IGMIqmmahDrSSurUiUpvPRQxMFKw2WX3n1Z0JuBY3k7nA6zZulYxnHcrBYN4aN7g4LL44Za+A==
X-Received: by 2002:a17:906:6a1e:b0:afe:63ae:c337 with SMTP id a640c23a62f3a-b1bb935d71amr737301966b.57.1758215212299;
        Thu, 18 Sep 2025 10:06:52 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b1fd271f895sm225845366b.97.2025.09.18.10.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 10:06:51 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 18 Sep 2025 20:06:47 +0300
Subject: [PATCH v4 3/9] power: supply: max77705_charger: refactoring:
 rename charger to chg
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-max77705_77976_charger_improvement-v4-3-11ec9188f489@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758215207; l=9595;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=TwNup/iXllk/aE5uv69gK2pIQ5cN9oOrdUW6G6HU6cc=;
 b=79XePRo5PcCEdK+4YDYwzHy0/d3lVJ9QOsvtYJ7nyVti51jK//W2A1oQ31Pava7H0WQ25b5Do
 rXqbVwuZ6/BBkd0qWGhIBsd6QOx2qpOguLvjwmG+hBFGc1rmPC6v7mE
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Rename struct max77705_charger_data variable to chg for consistency.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/power/supply/max77705_charger.c | 80 ++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index b8f648dd4d63..883affd18c8d 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -42,9 +42,9 @@ static enum power_supply_property max77705_charger_props[] = {
 
 static int max77705_chgin_irq(void *irq_drv_data)
 {
-	struct max77705_charger_data *charger = irq_drv_data;
+	struct max77705_charger_data *chg = irq_drv_data;
 
-	queue_work(charger->wqueue, &charger->chgin_work);
+	queue_work(chg->wqueue, &chg->chgin_work);
 
 	return 0;
 }
@@ -109,19 +109,19 @@ static int max77705_get_online(struct regmap *regmap, int *val)
 	return 0;
 }
 
-static int max77705_check_battery(struct max77705_charger_data *charger, int *val)
+static int max77705_check_battery(struct max77705_charger_data *chg, int *val)
 {
 	unsigned int reg_data;
 	unsigned int reg_data2;
-	struct regmap *regmap = charger->regmap;
+	struct regmap *regmap = chg->regmap;
 
 	regmap_read(regmap, MAX77705_CHG_REG_INT_OK, &reg_data);
 
-	dev_dbg(charger->dev, "CHG_INT_OK(0x%x)\n", reg_data);
+	dev_dbg(chg->dev, "CHG_INT_OK(0x%x)\n", reg_data);
 
 	regmap_read(regmap, MAX77705_CHG_REG_DETAILS_00, &reg_data2);
 
-	dev_dbg(charger->dev, "CHG_DETAILS00(0x%x)\n", reg_data2);
+	dev_dbg(chg->dev, "CHG_DETAILS00(0x%x)\n", reg_data2);
 
 	if ((reg_data & MAX77705_BATP_OK) || !(reg_data2 & MAX77705_BATP_DTLS))
 		*val = true;
@@ -131,9 +131,9 @@ static int max77705_check_battery(struct max77705_charger_data *charger, int *va
 	return 0;
 }
 
-static int max77705_get_charge_type(struct max77705_charger_data *charger, int *val)
+static int max77705_get_charge_type(struct max77705_charger_data *chg, int *val)
 {
-	struct regmap *regmap = charger->regmap;
+	struct regmap *regmap = chg->regmap;
 	unsigned int reg_data;
 
 	regmap_read(regmap, MAX77705_CHG_REG_CNFG_09, &reg_data);
@@ -159,9 +159,9 @@ static int max77705_get_charge_type(struct max77705_charger_data *charger, int *
 	return 0;
 }
 
-static int max77705_get_status(struct max77705_charger_data *charger, int *val)
+static int max77705_get_status(struct max77705_charger_data *chg, int *val)
 {
-	struct regmap *regmap = charger->regmap;
+	struct regmap *regmap = chg->regmap;
 	unsigned int reg_data;
 
 	regmap_read(regmap, MAX77705_CHG_REG_CNFG_09, &reg_data);
@@ -234,10 +234,10 @@ static int max77705_get_vbus_state(struct regmap *regmap, int *value)
 	return 0;
 }
 
-static int max77705_get_battery_health(struct max77705_charger_data *charger,
+static int max77705_get_battery_health(struct max77705_charger_data *chg,
 					int *value)
 {
-	struct regmap *regmap = charger->regmap;
+	struct regmap *regmap = chg->regmap;
 	unsigned int bat_dtls;
 
 	regmap_read(regmap, MAX77705_CHG_REG_DETAILS_01, &bat_dtls);
@@ -245,16 +245,16 @@ static int max77705_get_battery_health(struct max77705_charger_data *charger,
 
 	switch (bat_dtls) {
 	case MAX77705_BATTERY_NOBAT:
-		dev_dbg(charger->dev, "%s: No battery and the charger is suspended\n",
+		dev_dbg(chg->dev, "%s: No battery and the chg is suspended\n",
 			__func__);
 		*value = POWER_SUPPLY_HEALTH_NO_BATTERY;
 		break;
 	case MAX77705_BATTERY_PREQUALIFICATION:
-		dev_dbg(charger->dev, "%s: battery is okay but its voltage is low(~VPQLB)\n",
+		dev_dbg(chg->dev, "%s: battery is okay but its voltage is low(~VPQLB)\n",
 			__func__);
 		break;
 	case MAX77705_BATTERY_DEAD:
-		dev_dbg(charger->dev, "%s: battery dead\n", __func__);
+		dev_dbg(chg->dev, "%s: battery dead\n", __func__);
 		*value = POWER_SUPPLY_HEALTH_DEAD;
 		break;
 	case MAX77705_BATTERY_GOOD:
@@ -262,11 +262,11 @@ static int max77705_get_battery_health(struct max77705_charger_data *charger,
 		*value = POWER_SUPPLY_HEALTH_GOOD;
 		break;
 	case MAX77705_BATTERY_OVERVOLTAGE:
-		dev_dbg(charger->dev, "%s: battery ovp\n", __func__);
+		dev_dbg(chg->dev, "%s: battery ovp\n", __func__);
 		*value = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
 		break;
 	default:
-		dev_dbg(charger->dev, "%s: battery unknown\n", __func__);
+		dev_dbg(chg->dev, "%s: battery unknown\n", __func__);
 		*value = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
 		break;
 	}
@@ -274,9 +274,9 @@ static int max77705_get_battery_health(struct max77705_charger_data *charger,
 	return 0;
 }
 
-static int max77705_get_health(struct max77705_charger_data *charger, int *val)
+static int max77705_get_health(struct max77705_charger_data *chg, int *val)
 {
-	struct regmap *regmap = charger->regmap;
+	struct regmap *regmap = chg->regmap;
 	int ret, is_online = 0;
 
 	ret = max77705_get_online(regmap, &is_online);
@@ -287,15 +287,15 @@ static int max77705_get_health(struct max77705_charger_data *charger, int *val)
 		if (ret || (*val != POWER_SUPPLY_HEALTH_GOOD))
 			return ret;
 	}
-	return max77705_get_battery_health(charger, val);
+	return max77705_get_battery_health(chg, val);
 }
 
-static int max77705_get_input_current(struct max77705_charger_data *charger,
+static int max77705_get_input_current(struct max77705_charger_data *chg,
 					int *val)
 {
 	unsigned int reg_data;
 	int get_current = 0;
-	struct regmap *regmap = charger->regmap;
+	struct regmap *regmap = chg->regmap;
 
 	regmap_read(regmap, MAX77705_CHG_REG_CNFG_09, &reg_data);
 
@@ -313,11 +313,11 @@ static int max77705_get_input_current(struct max77705_charger_data *charger,
 	return 0;
 }
 
-static int max77705_get_charge_current(struct max77705_charger_data *charger,
+static int max77705_get_charge_current(struct max77705_charger_data *chg,
 					int *val)
 {
 	unsigned int reg_data;
-	struct regmap *regmap = charger->regmap;
+	struct regmap *regmap = chg->regmap;
 
 	regmap_read(regmap, MAX77705_CHG_REG_CNFG_02, &reg_data);
 	reg_data &= MAX77705_CHG_CC;
@@ -327,12 +327,12 @@ static int max77705_get_charge_current(struct max77705_charger_data *charger,
 	return 0;
 }
 
-static int max77705_set_float_voltage(struct max77705_charger_data *charger,
+static int max77705_set_float_voltage(struct max77705_charger_data *chg,
 					int float_voltage)
 {
 	int float_voltage_mv;
 	unsigned int reg_data = 0;
-	struct regmap *regmap = charger->regmap;
+	struct regmap *regmap = chg->regmap;
 
 	float_voltage_mv = float_voltage / 1000;
 	reg_data = float_voltage_mv <= 4000 ? 0x0 :
@@ -345,12 +345,12 @@ static int max77705_set_float_voltage(struct max77705_charger_data *charger,
 				(reg_data << MAX77705_CHG_CV_PRM_SHIFT));
 }
 
-static int max77705_get_float_voltage(struct max77705_charger_data *charger,
+static int max77705_get_float_voltage(struct max77705_charger_data *chg,
 					int *val)
 {
 	unsigned int reg_data = 0;
 	int voltage_mv;
-	struct regmap *regmap = charger->regmap;
+	struct regmap *regmap = chg->regmap;
 
 	regmap_read(regmap, MAX77705_CHG_REG_CNFG_04, &reg_data);
 	reg_data &= MAX77705_CHG_PRM_MASK;
@@ -365,28 +365,28 @@ static int max77705_chg_get_property(struct power_supply *psy,
 					enum power_supply_property psp,
 					union power_supply_propval *val)
 {
-	struct max77705_charger_data *charger = power_supply_get_drvdata(psy);
-	struct regmap *regmap = charger->regmap;
+	struct max77705_charger_data *chg = power_supply_get_drvdata(psy);
+	struct regmap *regmap = chg->regmap;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
 		return max77705_get_online(regmap, &val->intval);
 	case POWER_SUPPLY_PROP_PRESENT:
-		return max77705_check_battery(charger, &val->intval);
+		return max77705_check_battery(chg, &val->intval);
 	case POWER_SUPPLY_PROP_STATUS:
-		return max77705_get_status(charger, &val->intval);
+		return max77705_get_status(chg, &val->intval);
 	case POWER_SUPPLY_PROP_CHARGE_TYPE:
-		return max77705_get_charge_type(charger, &val->intval);
+		return max77705_get_charge_type(chg, &val->intval);
 	case POWER_SUPPLY_PROP_HEALTH:
-		return max77705_get_health(charger, &val->intval);
+		return max77705_get_health(chg, &val->intval);
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
-		return max77705_get_input_current(charger, &val->intval);
+		return max77705_get_input_current(chg, &val->intval);
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
-		return max77705_get_charge_current(charger, &val->intval);
+		return max77705_get_charge_current(chg, &val->intval);
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
-		return max77705_get_float_voltage(charger, &val->intval);
+		return max77705_get_float_voltage(chg, &val->intval);
 	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
-		val->intval = charger->bat_info->voltage_max_design_uv;
+		val->intval = chg->bat_info->voltage_max_design_uv;
 		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = max77705_charger_model;
@@ -410,10 +410,10 @@ static const struct power_supply_desc max77705_charger_psy_desc = {
 
 static void max77705_chgin_isr_work(struct work_struct *work)
 {
-	struct max77705_charger_data *charger =
+	struct max77705_charger_data *chg =
 		container_of(work, struct max77705_charger_data, chgin_work);
 
-	power_supply_changed(charger->psy_chg);
+	power_supply_changed(chg->psy_chg);
 }
 
 static void max77705_charger_initialize(struct max77705_charger_data *chg)

-- 
2.39.5


