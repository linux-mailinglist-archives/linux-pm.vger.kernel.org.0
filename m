Return-Path: <linux-pm+bounces-34501-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF81BB53ADA
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 19:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1A01C24E9F
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 17:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D70D3680BC;
	Thu, 11 Sep 2025 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVQKHh+K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3922536299F
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757613443; cv=none; b=IVEdKxVhXVJO2laTJVvlEythmS/ZpzRnpMp3hXDCKUGQ1g9nDxcSkxaPDermXJdLAVghgXCybmLGXzymmvOOiEarTJNNe0+++uTdtYbPz+yRFwEOsmgl5seJjGqpDnjaa/YOVqPjXxXR3EjtTHn0JCH40bsxEQpR2V3r5jYDGbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757613443; c=relaxed/simple;
	bh=HOFral57BQL8UYkTuj9H3P5RIa5oSgklRaCCxDv4muA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pFvsECrp8RxuOaxDMkeosbtmFSu9fF7M5G1RD+8huyVtwlTgsuUH4QQJozR7DVLqNEhK30ErjD0hhzeNwRFAMhLTPaQa+ZmuwoblSaKysh0ZLXQzcZNWh5PyOIASZs1Mkp7EdfZUYCCRr7j1+G4pdIMEFpJcSU/Ye8cw79Y2Vs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVQKHh+K; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b042eb09948so220970766b.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 10:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757613438; x=1758218238; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ct1QxM5jLU79bjOOr6iNioQP9jRwP1CqDRkzzfxBLo=;
        b=gVQKHh+KSrwN480ef6w8jOVOGfp1mgh1r6QSQ/+aa80aahwMrMHlSqCGyf07w3hmzU
         lui1/C5ncdmFRUHscBuIcA9OcPQ/ki3J0rjg8Kjx7o9xMvMUGU93LnamOxjxKFDDpNc+
         Xv/pViDhPc3fc40qTbhl+RdWVwd6PUJmSUVaEDgOvoQ3+ARI9IYlomVkrii/3p7GGRQL
         vQKnHDdZndARN2xt/972ZnR4Qsd08LBlP0hh4o9JVlbduMKyEJV/pdnXSZXpKvKR8ze6
         b69584GGQJCr6r/soDvOVEOfX812rJp2fBFTlrIjHmFo6dd+iVmKmxu8UXrLnA7aD4pq
         3oKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757613438; x=1758218238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ct1QxM5jLU79bjOOr6iNioQP9jRwP1CqDRkzzfxBLo=;
        b=ZddajMec2Gc1pFrfjeT7h2j7UnrNY8TKlOW5Ub2U4jGTnYK9AqDt5cgzAINBXj3jYh
         pmAoVND8wRlw/yCGNBHw9FOeT+BcArc5x1VxC/9ML552fsrKCBcHkNgDFaQ4qcYEuQ47
         /73SpJxzvBOZcLRzv+v5EATTJIUYyMBb7CxoNlD6rdtzQT7j91hsNX/VGUocNSFz/jUg
         dfiJgaZTBM6xRb0wpFDQAQdWTWBwQpRzE77RBjyY33dcFV3Nn4q4BdAs6EyTvQtreg5U
         cKUCOQ8a97A3kdmGJcGw+LFuiCsSsISdL2I7ivGMTtvQjrbMeqD/GN9JwunO+S3nsqja
         4HXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhyDajwECmD7jlFaWAJEv4JjdU4S3tboqXi4xJBQW/teON92cBB8ylK/zyI8w/orR7O4EixgkhfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzuhoSu2rOCOQuFypnGdc6X/doLyYukvYZxt3kTdW7su/h+pBj
	RzpLv/nDq0gE2GnCv69JYDHmJLW+QYaZcItDCNR/U6LeTQhwX88BAmIY1VL0ZQ==
X-Gm-Gg: ASbGncu5p7QlmAZ/OlK6KwhdQHLEkGslV/r0Z0dG+oxORBJ+V3lUKvheVx0BldytBVj
	XkDkwWl6sQiQNQmg5DAgoCfxVZ95Mg7ZdcPovVAcI2czygXoURgdOyiJLn6v/CIj1mN7M2TEofC
	DjVfA+oGrRTNLW/iKN5FCmG6pX/AS2UtOVTaL6GWmkuov8b470mPMIESSgygBrTnt9gKbAOccOP
	2Zzj0ALrog1PFDPBU4mfc2EuZr33rPfbizjufonxjPC+W6XxEVBcKZ2aqqdlY7DvzdbC5/rd2Qq
	1bn6bBSdtJyYjjxlxgr+NSYgEL3JvbY5S2woRqESV1i2VtCIzYCXoBDpfP2BkfGRpMSAax20mtr
	ltNFFUbcj2RJ5GgIK75ks
X-Google-Smtp-Source: AGHT+IEHQVpkWBC6pm/Vi3j3JbNAq8z1jQ10jnzlee4RvupHLJfqOIx/TplcXsBXKw7RR/7qDFKyBA==
X-Received: by 2002:a17:907:7ba1:b0:b04:1a1c:cb5b with SMTP id a640c23a62f3a-b07c353e303mr3739266b.7.1757613438097;
        Thu, 11 Sep 2025 10:57:18 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b07b312845esm171377166b.26.2025.09.11.10.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 10:57:17 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 11 Sep 2025 20:57:10 +0300
Subject: [PATCH v3 2/9] power: supply: max77705_charger: refactoring:
 rename charger to chg
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-max77705_77976_charger_improvement-v3-2-35203686fa29@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757613433; l=9595;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=HOFral57BQL8UYkTuj9H3P5RIa5oSgklRaCCxDv4muA=;
 b=wTTOLZLMF1IRP98JIMy+SUS3xQC+nO/abtaMtN1f50uhDdSSganPD/SQb9Ah8Pp9/+SFw8V51
 3XCMSUWRTs4DddrgJ2k8c8Bp5/fKgCUZV1AB9D0egZv0alNcPF9xWhg
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


