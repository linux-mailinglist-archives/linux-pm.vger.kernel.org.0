Return-Path: <linux-pm+bounces-11107-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CA9931511
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 14:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FDDC28194B
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 12:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCE418EFC8;
	Mon, 15 Jul 2024 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vm34n+iL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506F018EA81;
	Mon, 15 Jul 2024 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721048124; cv=none; b=p/EXkjwrKN/UZtbR23P7XX6GDTQPVJ1in2x5/GWNdgPlAfBbs3VXdnzFvsVPlyTJIdS9mZtUjA0JwX8+JCH024SsRo++HERZBLYdTnKZZ3ZqVuJxAuc4KC+nZ1ofXta1o4Z4xaAlFDwjduzVcIgYZ8DDMU7c0SsII8YS4RP9zOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721048124; c=relaxed/simple;
	bh=d9xJyVGdkLb6jVsuC/vB8diOax6NmCIBMwGr2E4GxCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rYikyN4/9oulxTKZCaE3tbzOADuriSNBv7kJ/+wbmklKVmAWwZ0jfmAqPEgovR9HLWMhZEr9xEtP/7ZOgpKT6IIIjrUl6TVM3ASl6eW3d04R7CfbUcfar+QdOufJPPKQ7rC0pGL4X9XeQfvYIrTu9mI+LZyBAJ/Un7COL7dLNFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vm34n+iL; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57cf8880f95so5285481a12.3;
        Mon, 15 Jul 2024 05:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721048121; x=1721652921; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JepbQc7AbCsn4MwQCws5rv8exDXvYLKDGPZlZpP5vYA=;
        b=Vm34n+iLhRLTODsfg4t6kHbpNY0KoLH6IWJwb2adkCkJMfrpSoTaxp8OMNB/z35uav
         S8wp0bNgsPDSXu5RvGnDyrkQv6ZRGujdTike7L+bhpxSTOFYanc9ddidKzvNQU54hJof
         HyYO3TyiaR5V3KaxJbB4a4/MBGXGpPrKPzKTRkjXgtx+3v8DYE0HaN9jslsX8FH5+8I8
         gwE69pArcMy+6ShnwxLot6HRVDRpFB2EfK3DayI7bz8DAc1D0npCZtsBvHntyR3LN1m5
         daS79VkhxhlRE6agOdq3nGDBVW3eMQW2WRq02fglV7LxrrEomp4BMUcyqsWjlkMw+QlE
         oxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721048121; x=1721652921;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JepbQc7AbCsn4MwQCws5rv8exDXvYLKDGPZlZpP5vYA=;
        b=Cd7eaOka7hof3W9thO/at53ga5BRS4mfkpdfaK38tGpAd6gqlofFwsUwwlOudgOQvS
         kQCEVk9wqczp4oggRdZ+ctg9QiPhTquRtJvyi2suWgujjrYoI3u/hPwzosbDVWOe3lvG
         Gv+pfUdKqihHw7arWOdk1NimLU0dZukU+bPqoXPFL2AP/ho4ruR1DRc2NByM0U/rmKL6
         ieRh3qMbswgRO5vjM3z/yae6hyUMLHaYEpnS2iqyo1psqLURjLcfBY5BdE1hF++JB3bT
         HknINxYzPJAR5nVNnhi80NYD2uwE5NWPgZYqkW9SvkVqNep3zDRZ5XE9oCN5HhLeCMP7
         yzUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHIaLiC5RRH1vUtYV1hQsoV9dF5yNvDeVj/jvLmVtA2LoWdvqHVycQ4WeouHs1iXT5jVR6+78nWeaSK4CFMg3vUFXTp7QkyeZTZ+OBsCezEyK8WVZNagBnuQJ68C2TsKqCtYQHHBIhPn1xB/x7TKoO/I8j/7a1duAKRUwmlFs4IY7FOIo5wVHAQexQpGS+qf2veIyELcMHoaHQ3vUel580mi30Amg=
X-Gm-Message-State: AOJu0Yy3m2mrlyfjlWrTPzNnEWvYo/obg3CvNcpnXjqznfP9BDJt4xEH
	2pgK10ybdFmSuD3HcvA5SJiO4WJqeot/1m3ajslRv5Vg199Jaxt216icDyht
X-Google-Smtp-Source: AGHT+IGIWouH56vOf6Qbnawj6h4Sop+wyVlJV9Nl0ERoET1sC3NknxcHB6X4S/u+v6iC8pqN/5i91w==
X-Received: by 2002:a05:6402:33d5:b0:57d:3ea:3862 with SMTP id 4fb4d7f45d1cf-594bc7c9133mr12051429a12.27.1721048120664;
        Mon, 15 Jul 2024 05:55:20 -0700 (PDT)
Received: from tablet.my.domain (ip-37-248-157-210.multi.internet.cyfrowypolsat.pl. [37.248.157.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b26f62165sm3333307a12.87.2024.07.15.05.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 05:55:20 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 15 Jul 2024 14:55:07 +0200
Subject: [PATCH v2 5/9] power: supply: max77693: Set charge current limits
 during init
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-max77693-charger-extcon-v2-5-0838ffbb18c3@gmail.com>
References: <20240715-max77693-charger-extcon-v2-0-0838ffbb18c3@gmail.com>
In-Reply-To: <20240715-max77693-charger-extcon-v2-0-0838ffbb18c3@gmail.com>
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
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5592;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=d9xJyVGdkLb6jVsuC/vB8diOax6NmCIBMwGr2E4GxCQ=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmlRwpgRncJxk6pRZ/FjwXbwkFvP4KP7Pdm10nk
 WTNeVQukMmJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZpUcKQAKCRCzu/ihE6BR
 aJB9D/wNFjY5v1IfChoZvKH+jUttjJ1AP8mE9CbHD9JEEL+mBrKMZzcDzm5hh18kwNHEpOKEu/1
 E5vzCjNch4L//UPyRl3e6pYWXEfmpfiEz9d85F5sMq4zNvFw02YzjbMimMtUuNlV1ctR/Nu1Gei
 gwynsEPFtPbuJVB4VBspHyG280xHQiIDMubg23rmqBu+UTTz5ZyhzVJ15ZqjQbygADxSny7Nimf
 yLZJWa4dio75WN9sFk2nJKySk763gEjB02GKTtduYdHqWzx3bPBjJ5s3uw3x1R8NenUAOtl0pS1
 5lRqtvlgOcfphmt5XRAECMMV5pm8k8ogFQsyRs/HiXHbPynIlLVdo6W4b78whASSgmvUyH2UHZj
 f8sQgNF/NVycHx5ZIBMM+TDrzIDv5VjYKec2XIAmzCdZELUP6zHUgcIzbYy5r2AdQ+nZSeOsrhc
 vWDvHgheH5ALFtSMOOdD41DlAi/HTSnMRzO3p8HNj3Ql0umti3IVq2OFtsO692CjGI1L59ADR8T
 T78fqI+g67R91MPQwbkiXHWM9XiwzuLC2qo9KXxMVRho/2ziVM1szI/A7BJBtA6P9XB84G4grNr
 s04avBsVnfKSlN6AUk6D7gQJSZ32lblxr9Ej6tyVtG9rxAaztiZVkyF2Ig5KqLtX6eLmM/iTG3A
 uuZlAiTByDE3fcQ==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

There are two charger current limit registers:

- Fast charge current limit (which controls current going from the
  charger to the battery);
- CHGIN input current limit (which controls current going into the
  charger through the cable).

Add a function for setting both of the values, and set them to a
safe default value of 500mA at initialization.

The default value for the fast charge current limit can be modified
by setting the constant-charge-current-max-ua DT property of the
battery node specified in the monitored-battery charger DT property.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v2:
- Squashed mfd include register additions into this commit
- Changed from custom fast charge current property to monitored-battery
  (devm_power_supply_register call has been moved up as it is needed by
  the DT init function now)
- Changed to adapt to both current limit values being managed by the
  CHARGER regulator
---
 drivers/power/supply/max77693_charger.c | 43 ++++++++++++++++++++++++---------
 include/linux/mfd/max77693-private.h    |  6 +++++
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index 0d53f61d58ba..0ddaa03669a2 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -28,6 +28,7 @@ struct max77693_charger {
 	u32 min_system_volt;
 	u32 thermal_regulation_temp;
 	u32 batttery_overcurrent;
+	u32 fast_charge_current;
 	u32 charge_input_threshold_volt;
 };
 
@@ -570,6 +571,14 @@ static int max77693_set_batttery_overcurrent(struct max77693_charger *chg,
 			CHG_CNFG_12_B2SOVRC_MASK, data);
 }
 
+static int max77693_set_current_limit(struct max77693_charger *chg,
+		unsigned int uamp)
+{
+	dev_dbg(chg->dev, "Current limit: %u\n", uamp);
+
+	return regulator_set_current_limit(chg->regu, (int)uamp, (int)uamp);
+}
+
 static int max77693_set_charge_input_threshold_volt(struct max77693_charger *chg,
 		unsigned int uvolt)
 {
@@ -647,6 +656,10 @@ static int max77693_reg_init(struct max77693_charger *chg)
 	if (ret)
 		return ret;
 
+	ret = max77693_set_current_limit(chg, DEFAULT_FAST_CHARGE_CURRENT);
+	if (ret)
+		return ret;
+
 	return max77693_set_charge_input_threshold_volt(chg,
 			chg->charge_input_threshold_volt);
 }
@@ -654,6 +667,7 @@ static int max77693_reg_init(struct max77693_charger *chg)
 #ifdef CONFIG_OF
 static int max77693_dt_init(struct device *dev, struct max77693_charger *chg)
 {
+	struct power_supply_battery_info *battery_info;
 	struct device_node *np = dev->of_node;
 
 	if (!np) {
@@ -682,11 +696,20 @@ static int max77693_dt_init(struct device *dev, struct max77693_charger *chg)
 		chg->charge_input_threshold_volt =
 			DEFAULT_CHARGER_INPUT_THRESHOLD_VOLT;
 
+	if (power_supply_get_battery_info(chg->charger, &battery_info) ||
+				!battery_info->constant_charge_current_max_ua)
+		chg->fast_charge_current = DEFAULT_FAST_CHARGE_CURRENT;
+	else
+		chg->fast_charge_current = \
+				battery_info->constant_charge_current_max_ua;
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
@@ -712,6 +735,15 @@ static int max77693_charger_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(chg->regu),
 				     "failed to get charger regulator\n");
 
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
@@ -720,8 +752,6 @@ static int max77693_charger_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	psy_cfg.drv_data = chg;
-
 	ret = device_create_file(&pdev->dev, &dev_attr_fast_charge_timer);
 	if (ret) {
 		dev_err(&pdev->dev, "failed: create fast charge timer sysfs entry\n");
@@ -741,15 +771,6 @@ static int max77693_charger_probe(struct platform_device *pdev)
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
index 54444ff2a5de..4570646e2f33 100644
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
 
@@ -217,6 +219,10 @@ enum max77693_charger_battery_state {
 #define CHG_CNFG_01_CHGRSTRT_MASK	(0x3 << CHG_CNFG_01_CHGRSTRT_SHIFT)
 #define CHG_CNFG_01_PQEN_MAKS		BIT(CHG_CNFG_01_PQEN_SHIFT)
 
+/* MAX77693_CHG_REG_CHG_CNFG_02 register */
+#define CHG_CNFG_02_CC_SHIFT		0
+#define CHG_CNFG_02_CC_MASK		0x3F
+
 /* MAX77693_CHG_REG_CHG_CNFG_03 register */
 #define CHG_CNFG_03_TOITH_SHIFT		0
 #define CHG_CNFG_03_TOTIME_SHIFT	3

-- 
2.45.2


