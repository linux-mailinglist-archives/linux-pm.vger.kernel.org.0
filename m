Return-Path: <linux-pm+bounces-34293-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D733BB5053A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 20:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8BAD7B59BE
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 18:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7087D35E4E3;
	Tue,  9 Sep 2025 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfTme+7o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3253570CB;
	Tue,  9 Sep 2025 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442578; cv=none; b=WIFDuYJ3IjvOdJJVcgLMEhXsdHfPrnHYtagYtDJNy1pBLYCQn358bpG6gXlE6pjfORKZOJ9RwlfBQjLyLiPX5DAEGgIvEysccI4oLhjGBc4tj5hZmQPp7uj7mAU3wLIjGZAFS+3nzrh7Dhrigo6djhn0x9cGd19D1XYvHZLrAJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442578; c=relaxed/simple;
	bh=HOFral57BQL8UYkTuj9H3P5RIa5oSgklRaCCxDv4muA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DGbyL4UYJaX/px2aYkTWWz4AT63IxvSoLooiVTgG3xORd6U7X8TmhadfIlWZhJ8GH2gyr82x2mW+hWNcw3LyxKB/hcTGeTOf6BN1u6dUzgQWMCyYKVguNqzi+meYBbr1yoGQqsEyiCeb9yh6Ju59lywl9GKoBb5zt/ml01UZQHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfTme+7o; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b0411b83aafso981757666b.1;
        Tue, 09 Sep 2025 11:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757442575; x=1758047375; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ct1QxM5jLU79bjOOr6iNioQP9jRwP1CqDRkzzfxBLo=;
        b=MfTme+7o2woXcLNl0wUfTF7IaeFgzt8SfRNMDWhWOONPuqKCUjdjngh82NL1ezxFPL
         rfnhhaxlgKU7qQd0h6DChfMH/Sjp1kaDXId9ZN97R6NnH5vIGxrT6LRgxYzGpaynNvBD
         0gsmpCnpC+gjBRqIpPQGmuHCjjdhs8btjoK/LppW1BbduxLZg5Y4kfcUMfknbKumu98C
         313CuS+g/1ZyfAtiODQL4XVONV5OndpdbMc0V+rJeRlLZM1sK9hbDcHmrOr4Bj3nA6ln
         1KpY3Amc5vBmg0iQI5THOPHSzyCXSw5uuWIFSulxjYPzffXbP5e6NyOAvIrl2y2NGvGE
         pEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757442575; x=1758047375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ct1QxM5jLU79bjOOr6iNioQP9jRwP1CqDRkzzfxBLo=;
        b=On3WgMAbnETj8x7bIr8+YCyC6vb1gYy5z21+1uop+Hd3R+Krc+M0DKk4Um2zPyuvHO
         hEZo1ED+bPl2yhkGxSvWA+YcfWnNA2aLTWUx1SRRTuWgu6NHzsSPavPQitVvI+rlHjtp
         OT8O1tHTNpz9ByFiur8aQmA+HDljf6GRA0svfvcsQlTnWAQhV1Bzofv6NcjN/djSCWEo
         xjHgfsNMR6a0xwLXwSehGMtlU+Cix9VRjsNiKuqCPGa8R7daT3iYkvkjVvZ66MmWkRTQ
         bVBz24UbH0yOoRkshek8StDfY+a1Dx0/9YQDHEldpxAyA8YE4NPl85EkO+UDU5dkCz5G
         ICUA==
X-Forwarded-Encrypted: i=1; AJvYcCXQVttngjLhCzBjUhFZTBdlSKCPOPNQFoNLpMqr2aa5iPiuEDcciEIB3mvBoAN09afVs/HJ63S/Kaw=@vger.kernel.org, AJvYcCXfrTa/YrJ/oIw1EgpoBA1WTXoMgMRYmCKp5enGoIfbnUJCZQp4fFOg596L8lmc1wq2nlXNazDw/bn5XiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZjCejWJNx5C/pZaEme2oIoy4cGFNNwQePCRZ5Shhs+shhWJs+
	zxwd6I9LSZldn/ZCbaz57BRi3ie6bDV++fxkI4pj1itVsKmWZBYLUS6vCYKYPw==
X-Gm-Gg: ASbGncsXC3GWNryurCAtuHS/KlOPxJGbr1pkGDVVtrOoO2F+WYe9UyBBXd6E6h0iJzf
	UjtwNxysLEQjqDGR3r/zdJpZwArzZk7Ol4VJYUcd0jW848myl/nJG94bNezGwddjNY5k1vZ4K9i
	SSFVHdWVR7T1MfrWlQgT71Wcz7DV/fJ2ihXipNsm6i6XslMhzJjiFc+jz/V6/oqxOhc8EdvAydF
	S1G5ZABbtESz9howSOn2PqgHAjHxmbz7D/lNaiwg+PHgJrYtpgx8rWujTOhrxz23SVv3P5oAoGz
	I19tP5YE+ldTIPtERKEUQFn8BscJ/AWmUyGf9LP7Ttgch66d0xzeEiLDj7bm9y7mKn9/v+BEDca
	8eRjotiIJWbDEhHKdahgD
X-Google-Smtp-Source: AGHT+IHMGNHvSbK+x/7x0YYCoQpMgoP6CimabLDSImCOZneHKgrbZZPeF0+KylEbZY1SMKVh1XIkxQ==
X-Received: by 2002:a17:906:6a1e:b0:b04:616c:d746 with SMTP id a640c23a62f3a-b04b14aca68mr1451126466b.25.1757442574656;
        Tue, 09 Sep 2025 11:29:34 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b07833ebe61sm30520666b.89.2025.09.09.11.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:29:34 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 09 Sep 2025 21:29:12 +0300
Subject: [PATCH v2 2/9] power: supply: max77705_charger: refactoring:
 rename charger to chg
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-max77705_77976_charger_improvement-v2-2-a8d2fba47159@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757442571; l=9595;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=HOFral57BQL8UYkTuj9H3P5RIa5oSgklRaCCxDv4muA=;
 b=XecssOczPL5wU3AGGY21NHxSxMjC4mAWphl4ArXs4tmVrstti7qKXT9H228YNXWLvSJCmiilV
 iVkPXK7ezP0BTY05K/bu30Dt0ul4dQtLk2OUOn7pv51Ur3fq89ReJ+S
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Rename struct max77705_charger_data variable to chg for consistency.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/power/supply/max77705_charger.c | 80 ++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index 3b75c82b9b9e..7855f890e0a9 100644
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


