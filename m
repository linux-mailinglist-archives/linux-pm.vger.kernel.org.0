Return-Path: <linux-pm+bounces-12324-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 276DE9543E0
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0481C20D56
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 08:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B23813EFF3;
	Fri, 16 Aug 2024 08:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PG7XcH5d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F30213DBB1;
	Fri, 16 Aug 2024 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796365; cv=none; b=e2+h+oObXcvLGh4XILxYwICXa52kGbEC1M+mZ5tahDW54rvhEPhrQcL4FbF8nhi/YAzMqlAcoRRwIB9EeDzAKpVKFpNvVlpKnBNg3WCSOGxQ52g5cEJOgKAS/M+hgI/NCYCWJXU8QZBq9RKZ/RdYaKTPL50lHTV4obSa9RXlzZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796365; c=relaxed/simple;
	bh=O9gPJjPhBFB6wY6JOoyF2PfCabTLSsjOOHWK2XU8fpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sVlHx0FZ2KWwSPM4fkRmNoysIlDX3U04Pb/zVX2sLZc/LegOvuINMDXAXoatDSVCaHlzgbJl6rWUQFhFTOU1agB8JWVJjL+w3BnMQC6fSRJ17uYfe6zd7u+t5CNjuZUxj9x04yHp0xZmq7gIy4mLlO8ABPp3MMCWxry5D5CfazI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PG7XcH5d; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428e0d18666so11793255e9.3;
        Fri, 16 Aug 2024 01:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723796361; x=1724401161; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1WWrU/IhZI7ilrsVlKcVr6cPaQA4CGMInWjIGFs7Ke0=;
        b=PG7XcH5dd2B98567UnHWklcI/mLghguwjBhj+CgsbBBNMU4QY08sSndclwQ8NLz9p+
         M4l7PUaImETd6SM16y7cWDGWwfUfqIjGG6B33fgo6GskC/vF5qQ13E1y244Ei7aL2kGP
         xmn+aqSjqkZ9DYGPAWQgl0qu7D3EZwFOMz11kNY9bVZFqIS6U/+h5+LUDcFeHo3sbGhi
         efBZXyNikJ8mbbpG+CSRIuOQlgOxCB6uHVrgMeCd6amSZLV2rj4c3Lqdk5xa3T9jzCZS
         Yx7AY+AUKAQKcsVpnLJ/TZk9USYkEyn326p1h3R9vPd9eYW6itTyRAbdyMfoqP1K4KiK
         tE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796361; x=1724401161;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WWrU/IhZI7ilrsVlKcVr6cPaQA4CGMInWjIGFs7Ke0=;
        b=KDDYhpAZmp0MguTkWNU23eABR9D7eo2dOy7Xb4mjvZW0Lbp23KysK1QW/KiohIdGdT
         TU96FmPyAAoKiNbspy8TOvDEK1pqqKD6f3ur0mB/Ri9ia+KbvfwWM/0xHhaaF5/0EzOR
         lRnOsZdNxocAtXSbf2pOKtjgDEFCJhlyuTRmrZm7URXLpWUnhfCUJX26ef6pFKa17Nmy
         QMj7/uLrXwbh06IwGkoiad3S9awNzwdINJKn0Kl5ivUZ8K+g+D2ftk2ejP/aspSzbd+o
         jOrJ5Q55K8Ohu0Wz5wfIKqrQ+8Le0ua2wxc2NY8Ih81FswGLu0w4s1QYwx0mYSUqP2a5
         hFUg==
X-Forwarded-Encrypted: i=1; AJvYcCWVaPleLy9uhxN+yBMlDC6+HN1xv7mKiOg6DPevU91Q8VeyMaylqSZhdI45Zzzhig7sd3rYAL1Y7u1b3LrV708dEqKKSA0zfkFqY/yaW4PgwLyuusbZmCSnO+b09E2We7NUHMz9BkW54ipOgy/R6dddztcylhg+erHyxPdPDYxylpQXePIivyPOdudSbOSQSL5dISiTIxgiWDs0CbrCvfDfzZbrf4c=
X-Gm-Message-State: AOJu0YycLkXKW/cYQxilrPWkIGHdx1NlvKRLwkuh5dB5t1Xdx2jypmLA
	T2qVMu9Cohh8AQi8IX9emjrMcCBLLV6PBNJapJ2VSlqHismEaSJR
X-Google-Smtp-Source: AGHT+IHZEwmPcEwGMYSPrvNQrSpzwEB8NrVEx6QaPgbgtcHMLWLLrST5VTOPheD4XXDO21urabek5w==
X-Received: by 2002:a05:600c:314d:b0:428:18d9:9963 with SMTP id 5b1f17b1804b1-429ed7af165mr13909755e9.22.1723796361274;
        Fri, 16 Aug 2024 01:19:21 -0700 (PDT)
Received: from tablet.my.domain ([37.30.8.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded35991sm69732645e9.21.2024.08.16.01.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:19:20 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Fri, 16 Aug 2024 10:19:10 +0200
Subject: [PATCH v4 04/10] power: supply: max77693: Set charge current
 limits during init
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-max77693-charger-extcon-v4-4-050a0a9bfea0@gmail.com>
References: <20240816-max77693-charger-extcon-v4-0-050a0a9bfea0@gmail.com>
In-Reply-To: <20240816-max77693-charger-extcon-v4-0-050a0a9bfea0@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6622;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=O9gPJjPhBFB6wY6JOoyF2PfCabTLSsjOOHWK2XU8fpA=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmvwt+rPUakPqDDCGIs8ZJ8QcWzhNDAs+vmcxAP
 svzhcZgo0aJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZr8LfgAKCRCzu/ihE6BR
 aJ5hD/90NIWNX1ccu43LK3y/OwbWeDT2FKDFRk0LhT0wgPl4V2Lr0nyP7zAhA8w9SMPIM2SlAuC
 Ohz0ZumUfuzpgKC2UUaVYqMlTy5tPb4L6f8fzOw9e6z4FUq3Q6/xwWE+FKxmD1UvcauB0S5+hYr
 L4sZrrk5mo30hYsEmOLPuv92T2zuHx0q3iEuKj2JVusmj+nGZuVuiEXBVKhCJ3yiVfF79Ve3dm5
 oPGt3mFDOW0oBCahx9RlWn0NsNVOpvA+eMED+3/go/3CeV44YzAUxSqXR+7rNfVF7w8SzXVpBq+
 7K/e2NHi/zlpbSzOt0MsZkCgpUK9uvauQm9oP+Q6WEqUIa6IxfRPl/ExjdEbjzAN5ZfGlCrDc0v
 l/hcWCNcIgxRYVIlwAUe6dhiCbNWf4F0XZvTzqBOKwxC28U4liQ8SEmhqUo5k5tDIbDxglFcLWC
 JUkFllKmOOKtg8OBTtR8iBxJ1D/Rl3a0qCMQHXhgximy0dcjVU23fDCrm5037eUHT44XbWGnjBk
 3VWiMKZsGJ9XrVDnXFdG41zMMr4FcWPIeXOssy4fKmD/NBj/Er8qbrJof8YZfDfZ43/TBbvBZGe
 c7CGJSsY8D0Hm7ALYiZ3za25VacFBiPmkVDStIWRusQIFnESxAWqluQxm4KaTC0tNcD675L3I/v
 vTbVtWc3xC+Tr/w==
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

Acked-by: Lee Jones <lee@kernel.org>
Tested-by: Henrik Grimler <henrik@grimler.se>
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
2.46.0


