Return-Path: <linux-pm+bounces-33472-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE31DB3CF4C
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 22:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352AF1B24397
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 20:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAC02DAFA4;
	Sat, 30 Aug 2025 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqJ+Lmeq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5430774BE1;
	Sat, 30 Aug 2025 20:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756586729; cv=none; b=IGcNgT8Cryxk2qomNsnRP2hRszwr/0/9tyNFhNDJg8zZ98qyAmuN5B15zGGb/3RNX/Qb0flGLr4ff6GdTxosLCZ0FCilPY/wDyN0/ZgtfCnmTwZ7IDfjmpf0pg09Ap3wj216fzjmasLQRXaj0DD0n7N2OcQPnNdpdIb495UU+ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756586729; c=relaxed/simple;
	bh=HOFral57BQL8UYkTuj9H3P5RIa5oSgklRaCCxDv4muA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yp3dPFrpzlKhOyAzG4rV+ArbsyH++o1eiTl20Gd4n6R7eySGZIAI2kTrbQsOddqRgtxKsdJd9TacMlh+TLFKuo07lNtFc/rfWvsa+StHfHs8sovor28MQawTflnok4/qFTT60Wl1dFsKN1mKr6vvtQjej29TuQgZP68MsZJmxnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqJ+Lmeq; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61cb4370e7bso4760520a12.3;
        Sat, 30 Aug 2025 13:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756586726; x=1757191526; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ct1QxM5jLU79bjOOr6iNioQP9jRwP1CqDRkzzfxBLo=;
        b=ZqJ+LmeqMBZZV+3x5nA6OY88TaoWBUlRnu40YOO3PHX8t+wr6tQQ7a8O7liX4vkO9H
         3O9RvmtRm3tUjuezdAsdC5r9xHnAA6jOo39loTF2L2BYuEC2+vwqYGAljCZNjjQLwIUX
         SPbFs/E9d3iJREG2OeUOcC5BQOFT4oqd8FH2YXk9VTqFSI3MR2cxDy95fD3ReUeizuRd
         oPLwHYLTURRAV94UpyG0XOnBcldMJNVlF3wuGcRdsDGMng9RFCIpPfiJ9rpM06TFZbTA
         onuYLX4ILCjb+0PUhw1SIhzmrtZ2tYvRS7SlbAzXLwHXTxUpmxz7Gl5OvcmkcZ3wV06g
         N96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756586726; x=1757191526;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ct1QxM5jLU79bjOOr6iNioQP9jRwP1CqDRkzzfxBLo=;
        b=sB19Uwr6UkPw/s5Fq/0hqhTZBc9usYCJpKpnZix0uS18V6rXwMFy4fpnPnZoFR9gwW
         D+9e0PL9D4b54SVP60yMcj/TKt+JeOCtQIGojUohLXPLH/yKpYbEKUQmbYUUGEffKhQt
         LczUWIfHpZ+b55trHujLBTAVyeu+bwI5VHx/s6VUmq7mmowiqqI+WHaHbfTP0nPQp6yr
         aRPS2neBORAxA6B3yNl45BsbKUdo7Nn0P0h0CVIHtXV52knlLfx+OEU06E6kECAxa39F
         fq5J7aMxZfL3yufQLlwrVp/EtsYo8FsWD9GMpnlQsu/Tp0VCyCAtf+u3h1ADcKfWeI8T
         +1IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaMW1N7srR2v4yFOK4vJYSEjgmVw+Jm43RygK6z40D4Lg9ULFm+WUAvEYlBbwU1RlTFf1o+eLpFS93p8U=@vger.kernel.org, AJvYcCXhv3RfBYcpDRNx9x89xLrIX8c5d5vqs/Ebs0bXZRpd85+aT9Wv0AivckRYf57iwiiHTO1M6UoeivA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtLXyrIQJaSSBaYrI+nL3vtM9OB2cAkpveUtiqRE4MVLddR6Ir
	bqdqerosl/deO4m+YnrYr+DyTdEDMYm4DgXSdK7Xs1DxSyIDiyPOlB8m
X-Gm-Gg: ASbGncushcZ6jj2gpOmAkAZnhUCrNj/RSHioVaOGUY0o3UtQjHtzja0gbtSs3FoEOwp
	tDmdmd7FbOjGaTOpe1FcaRSxkXBCoylKr05QiwE5OZxJLduxZZzQcdp+vj735U4DzpMH1PWdYEE
	R6IOeLR34c9tvImaol3wcQPLdNajUTMEVDD+PRdjRY1UWT0vykh9HghIFuxNnjwiBxMG+9h1NDv
	C7aMYJzqqis6qY9Z3whQvVaLIrmL9YBcW1GQjtRxXV0E9gV+p3q8I/d1x7N5qjzBd16AKgRQAj/
	blp0P7dWMVD63LeK9qHyCIDOFz7OJPH36Y2TD8vhBEbKuUbaL0WgcIWXTb4EDO8kCqT6i2AK0fR
	JPmNl8tLGCOE3ThbycWQb
X-Google-Smtp-Source: AGHT+IEQRyppa0QSBTQh0CeerNcczwcEPlPK/lBjlkglQelkcWfT6C9l2x6in5SD/WajZ68Szzr99g==
X-Received: by 2002:a05:6402:1d52:b0:61c:b8af:f7a with SMTP id 4fb4d7f45d1cf-61d26ec2b87mr2540179a12.34.1756586725573;
        Sat, 30 Aug 2025 13:45:25 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc52ade4sm4066630a12.45.2025.08.30.13.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 13:45:25 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Sat, 30 Aug 2025 23:45:15 +0300
Subject: [PATCH 2/9] power: supply: max77705_charger: refactoring: rename
 charger to chg
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-max77705_77976_charger_improvement-v1-2-e976db3fd432@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756586721; l=9595;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=HOFral57BQL8UYkTuj9H3P5RIa5oSgklRaCCxDv4muA=;
 b=XE3RU4/PIIfJARxmFZwN5DajvTyDB0oBjPYR5EAAPejjT4hD3fivgtXjO5I4Vd3zI21lO2iC0
 hS+BZD3OQ+pC/wTxFgHU9vpzFskgMqxe/ovlMfK86UdWOQMEquEibwH
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


