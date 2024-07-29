Return-Path: <linux-pm+bounces-11575-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A11D93FCAB
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 19:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 811E91C221F3
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 17:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17528187861;
	Mon, 29 Jul 2024 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJPKEBOO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBA0187552;
	Mon, 29 Jul 2024 17:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722275278; cv=none; b=f5EUB1lLBOIDQ/3Cw4VSJMkVKN0RJz4VBUzmmcP9FUAkOQND6sFwmEArkLPWxU1Nx1YQ9o7zMlXfKSkfP5gF6YqcTQi+vi/U7LP4IveoVWTHy6l5LCqFsfHiYch/e6ifIoC/ULTfNyxi1T4d/NDaTA4o4UdL88DJrFScPj4S99c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722275278; c=relaxed/simple;
	bh=ugq53xLBW+pgJurSinC5JizQ+Kguu470RHyzKlOfZec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DJUN/y9P5WCD5wFbzF5IO/MAnhpDd9kPtCxc0At0eN1W6TebBZpFcMovRQQZwsCLr3BqwkyVMoHFCGDaec6m6H/znf0Y+MkiAP5WAommdgG0PD5mIq8sKCFElFHUC3ZjJSV7yyxPUsGmwNLX+g5ZKQ0b7TjR1WL5pE4afWLQI/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJPKEBOO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3685a5e7d3cso1802453f8f.1;
        Mon, 29 Jul 2024 10:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722275275; x=1722880075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GkU9a6/40Cq2sewbpThfjNNBiDffMX2eljgdYf4VDTE=;
        b=eJPKEBOOTN5l5Uien7scGUh0kKx8wkyYDx8VM/t3OswWyfMfJQBOftABDveoL33Xb4
         X0UQM4rEBjgViA0+HdBS39sEbOW9/LGZSt6hHldXi06beOEl7WfMpE0/Mv2O2DvXIImu
         GWIVOd+Ri1GWLuMK8QgDr1++3t6+tEnrXaQNw+lZo1VqcV4QjJVaqURpk/WGSQDCFEfD
         hOSS1RPZW4UK1VsjwEWzp/U8us4sPCnjr7ZdxYe2vAVulbzujLM2vI547z4RePpMADYJ
         zt9fxGn+YjxQQnJQIYqd/sqJcqbijn89xb2aHtN79xBn9O/4ARNAuHAeCNVQBNDGf1tJ
         8fIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722275275; x=1722880075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkU9a6/40Cq2sewbpThfjNNBiDffMX2eljgdYf4VDTE=;
        b=sq5LOQOj++hd06EcMI35dKgaxYX07tVza61RWetagho33k3ntGjPYUakmlZzHY5ukB
         F9zs8W0DAbLPBTOX9CtTt7NMYVxBtfmyvS7mZ4mm1ovVMJpJWCPM4ocmqJKrto8zzhkW
         tGi2n+loA7qYaIkM33REENVaK6s2nm/OEWWxgjTA2waaIXQdQkiz3eXTHtAdGhBynMCO
         wtlRJH7Szo0Qb15apVOrKyOSOw3rYL2+VOgbiQ+z+PtiVQMyTIVu6y3cwdcFH7yB76te
         MpA6kxv7KyuFPyGr8McsQN+8fcKf0p7Xb3jVD/yCOz+dxcb0iBG1glCgr1+mXnXm1mY/
         bp0w==
X-Forwarded-Encrypted: i=1; AJvYcCUBkzRo0XT1KglHObwueOdjD2lhuuE3yXxu2f/J8S05CN3Z6kUhaHlb78JMgYxCYChg3NP8SbrnTodWvbfYD/yTeG3N6tnyVkeFNCy7rlz7VGhjNrXNTtYvwkq/Ozv5dWLc7MUiHnDsx4WV+006n4XvRws53UWhekAwBcGHVpLNKpyZgesIG47Ml3fjED4rOdlfeYeVJPRR+lKRceTmK+vMyMRJGyQ=
X-Gm-Message-State: AOJu0Yx82bYA0kyUf8pOJCiVkOxf841VEoCYF2+awAAtykNKWFxuo+WA
	T6HExbdqKpORoS+T4jo5hVBGcyjcoR8dmL9kX+ZmgGNOasCRRzpX
X-Google-Smtp-Source: AGHT+IFR0TVKExWXma+/RVH2Y8BefejhPHw2MxvPw1w+jlu3FgBtpwoZt/l3seNE2pZrcGq+PbICBQ==
X-Received: by 2002:adf:eb92:0:b0:368:3789:1a2 with SMTP id ffacd0b85a97d-36b5d0c4142mr5560839f8f.21.1722275274418;
        Mon, 29 Jul 2024 10:47:54 -0700 (PDT)
Received: from tablet.my.domain ([37.30.0.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fc8a7sm12716550f8f.59.2024.07.29.10.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 10:47:54 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 29 Jul 2024 19:47:38 +0200
Subject: [PATCH v3 04/10] power: supply: max77693: Set charge current
 limits during init
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-max77693-charger-extcon-v3-4-02315a6869d4@gmail.com>
References: <20240729-max77693-charger-extcon-v3-0-02315a6869d4@gmail.com>
In-Reply-To: <20240729-max77693-charger-extcon-v3-0-02315a6869d4@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, Henrik Grimler <henrik@grimler.se>, 
 Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>, 
 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6537;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=ugq53xLBW+pgJurSinC5JizQ+Kguu470RHyzKlOfZec=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmp9W+wto0WFuOBsXjfJOILo5Flv86sexqYSEUb
 w5DvgRtowmJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZqfVvgAKCRCzu/ihE6BR
 aBmqEACd4IsWbI8B7tt1kvV+vx5DFYZVlNL7uNDruuLy06xhk4KcIhXkRKxWtpqw2UkRUgG7LOk
 o3vdAA+uNfNhwKsOgPB+XPXbDI8vU96wE+UZYtU5VT/fUyUYeSJ3UveBB4AfDS2j6boQQD2ZRkL
 lyJI7lcH6kLG9qZpbeZBDSLmhvhZAwBYty3uTZSh/UZguJcEghFLsl0QEIGiKdOoV2jIu45AIg4
 A6sG7gZzwQDQYBMDod7qk/hJiLjo0l7th5yJRDP/io2thKkICtXkBm9QMXOd9GbA9UanD7CJQea
 aiyaouFJ9zQECJUcau3WTglJBKXZKvTadBUpHmaVwnSLt+hLnG9mEJWssQMtnG4ZdczdREwjQjj
 1aiqfL36LhLXusta28qkxvDNlxEUarXienld3b2l0V8lHfXFLIRiLe8d6kbxFeVWw3iWyovR4Cc
 Jl1IT9A/Z+BbimsqT0MsTsfajRJWP+zyg/4aj1WPiziVYg/bWLp5OfKkQiu6DUDNUyGmxVHAJRL
 7RCYyt0LTcK+UgIuA1/lZbvKSsKzrryDilD9tdjImWjyj25L5N37UEdCgEAM8Mp11pfcXuxDtOF
 PrtdPfAt9bllG/J7Kc4Bs5J353wH045gbzuCgtKEmUtFhwJ2bQkJ2QmNYfNrgmg2loazprzKQp7
 knyPhu1gI8meZAg==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

There are two charger current limit registers:

- Fast charge current limit (which controls current going from the
  charger to the battery);
- CHGIN input current limit (which controls current going into the
  charger through the cable).

Add functions for setting both of the values, and set them to a
safe default value of 500mA at initialization.

The value for the fast charge current limit can be modified by setting
the constant-charge-current-max-ua DT property of the battery node
specified in the monitored-battery charger DT property; the CHGIN input
current limit will be set up later in the charger detection mechanism
(in the future, the INPUT_CURRENT_LIMIT property could also be made
writeable for userspace control of the current limit, while keeping
the actual current limit from the charger to the battery intact
so that users don't accidentally blow up their batteries with a bad
value).

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v3:
- Dropped CHARGER reg in favor of managing the registers directly

Changes in v2:
- Squashed mfd include register additions into this commit
- Changed from custom fast charge current property to monitored-battery
  (devm_power_supply_register call has been moved up as it is needed by
  the DT init function now)
- Changed to adapt to both current limit values being managed by the
  CHARGER regulator
---
 drivers/power/supply/max77693_charger.c | 82 ++++++++++++++++++++++++++++-----
 include/linux/mfd/max77693-private.h    |  2 +
 2 files changed, 73 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index 4caac142c428..17975ec69a6a 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -26,6 +26,7 @@ struct max77693_charger {
 	u32 min_system_volt;
 	u32 thermal_regulation_temp;
 	u32 batttery_overcurrent;
+	u32 fast_charge_current;
 	u32 charge_input_threshold_volt;
 };
 
@@ -596,6 +597,48 @@ static int max77693_set_batttery_overcurrent(struct max77693_charger *chg,
 			CHG_CNFG_12_B2SOVRC_MASK, data);
 }
 
+static int max77693_set_input_current_limit(struct max77693_charger *chg,
+		unsigned int uamp)
+{
+	unsigned int data;
+
+	if (uamp < 60000 || uamp > 2540000) {
+		dev_err(chg->dev, "Wrong value for input current limit");
+		return -EINVAL;
+	};
+
+	data = uamp / 20000; /* 20mA steps */
+
+	data <<= CHG_CNFG_09_CHGIN_ILIM_SHIFT;
+
+	dev_dbg(chg->dev, "Input current limit: %u (0x%x)\n", uamp, data);
+
+	return regmap_update_bits(chg->max77693->regmap,
+			MAX77693_CHG_REG_CHG_CNFG_09,
+			CHG_CNFG_09_CHGIN_ILIM_MASK, data);
+}
+
+static int max77693_set_fast_charge_current(struct max77693_charger *chg,
+		unsigned int uamp)
+{
+	unsigned int data;
+
+	if (uamp > 2100000) {
+		dev_err(chg->dev, "Wrong value for fast charge current\n");
+		return -EINVAL;
+	}
+
+	data = uamp / 33300; /* 0.1A/3 steps */
+
+	data <<= CHG_CNFG_02_CC_SHIFT;
+
+	dev_dbg(chg->dev, "Fast charge current: %u (0x%x)\n", uamp, data);
+
+	return regmap_update_bits(chg->max77693->regmap,
+			MAX77693_CHG_REG_CHG_CNFG_02,
+			CHG_CNFG_02_CC_MASK, data);
+}
+
 static int max77693_set_charge_input_threshold_volt(struct max77693_charger *chg,
 		unsigned int uvolt)
 {
@@ -673,6 +716,15 @@ static int max77693_reg_init(struct max77693_charger *chg)
 	if (ret)
 		return ret;
 
+	ret = max77693_set_fast_charge_current(chg, chg->fast_charge_current);
+	if (ret)
+		return ret;
+
+	ret = max77693_set_input_current_limit(chg,
+				DEFAULT_FAST_CHARGE_CURRENT);
+	if (ret)
+		return ret;
+
 	return max77693_set_charge_input_threshold_volt(chg,
 			chg->charge_input_threshold_volt);
 }
@@ -681,6 +733,7 @@ static int max77693_reg_init(struct max77693_charger *chg)
 static int max77693_dt_init(struct device *dev, struct max77693_charger *chg)
 {
 	struct device_node *np = dev->of_node;
+	struct power_supply_battery_info *battery_info;
 
 	if (!np) {
 		dev_err(dev, "no charger OF node\n");
@@ -708,11 +761,20 @@ static int max77693_dt_init(struct device *dev, struct max77693_charger *chg)
 		chg->charge_input_threshold_volt =
 			DEFAULT_CHARGER_INPUT_THRESHOLD_VOLT;
 
+	if (power_supply_get_battery_info(chg->charger, &battery_info) ||
+			!battery_info->constant_charge_current_max_ua)
+		chg->fast_charge_current = DEFAULT_FAST_CHARGE_CURRENT;
+	else
+		chg->fast_charge_current =
+			battery_info->constant_charge_current_max_ua;
+
 	return 0;
 }
 #else /* CONFIG_OF */
 static int max77693_dt_init(struct device *dev, struct max77693_charger *chg)
 {
+	chg->fast_charge_current = DEFAULT_FAST_CHARGE_CURRENT;
+
 	return 0;
 }
 #endif /* CONFIG_OF */
@@ -732,6 +794,15 @@ static int max77693_charger_probe(struct platform_device *pdev)
 	chg->dev = &pdev->dev;
 	chg->max77693 = max77693;
 
+	psy_cfg.drv_data = chg;
+
+	chg->charger = devm_power_supply_register(&pdev->dev,
+						  &max77693_charger_desc,
+						  &psy_cfg);
+	if (IS_ERR(chg->charger))
+		return dev_err_probe(&pdev->dev, PTR_ERR(chg->charger),
+				     "failed: power supply register\n");
+
 	ret = max77693_dt_init(&pdev->dev, chg);
 	if (ret)
 		return ret;
@@ -740,8 +811,6 @@ static int max77693_charger_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	psy_cfg.drv_data = chg;
-
 	ret = device_create_file(&pdev->dev, &dev_attr_fast_charge_timer);
 	if (ret) {
 		dev_err(&pdev->dev, "failed: create fast charge timer sysfs entry\n");
@@ -761,15 +830,6 @@ static int max77693_charger_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	chg->charger = devm_power_supply_register(&pdev->dev,
-						  &max77693_charger_desc,
-						  &psy_cfg);
-	if (IS_ERR(chg->charger)) {
-		dev_err(&pdev->dev, "failed: power supply register\n");
-		ret = PTR_ERR(chg->charger);
-		goto err;
-	}
-
 	return 0;
 
 err:
diff --git a/include/linux/mfd/max77693-private.h b/include/linux/mfd/max77693-private.h
index 20c5e02ed9da..0819cf0a4f5f 100644
--- a/include/linux/mfd/max77693-private.h
+++ b/include/linux/mfd/max77693-private.h
@@ -145,6 +145,8 @@ enum max77693_pmic_reg {
 #define DEFAULT_THERMAL_REGULATION_TEMP		100
 /* microamps */
 #define DEFAULT_BATTERY_OVERCURRENT		3500000
+/* microamps */
+#define DEFAULT_FAST_CHARGE_CURRENT		500000
 /* microvolts */
 #define DEFAULT_CHARGER_INPUT_THRESHOLD_VOLT	4300000
 

-- 
2.45.2


