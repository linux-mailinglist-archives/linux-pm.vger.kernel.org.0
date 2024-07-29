Return-Path: <linux-pm+bounces-11574-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB4493FCA8
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 19:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584D81F212BC
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 17:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD20187568;
	Mon, 29 Jul 2024 17:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8HhJ/rb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA1E186E57;
	Mon, 29 Jul 2024 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722275276; cv=none; b=BZhKN037YHOexJWa+gEr8IrQonFbQIRLozXDmXJmRxEl6Cbk8VHRqwm0d85x5g+hXAEtgEh/Vr7o1Fno/SjKq7PurnDePIbaPAjYDCaOu0LA99OeAl2ZPawaY909OAbM6JgBt7h8YRIBF4zc3KQ6g1vQR3pn00Q2EXmHivJz6FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722275276; c=relaxed/simple;
	bh=64p2zb/TO0sOXA+lVtMC+Y+6Z6xHMlhCGgkfq2NJimA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uM42/FXXXkezqP9Wn/YRsFqS0V9M/81LbKaSbt24Fwa1mALm6kJeESv4mF3E9k5qRQmQaG9MIljQx8rJ2Wepm1NoSA0DNrRbQikJ/4f/DZ958xOSJhNypRTBHaszuqueuRSHsnIYonmsbIDnwtvUkOTJ/Iwo/oueKXCqjhVZaiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8HhJ/rb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso19608215e9.0;
        Mon, 29 Jul 2024 10:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722275273; x=1722880073; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V78HK7/KjvVm6vb5sHb4eAgphXUZC6leMWsDQBJkLes=;
        b=P8HhJ/rbb/L1HQ/DocgEVv0XVljCmcrK+qKu9bvNWOVQaddtEBYrXMtJ7U8NZYP6Mr
         OEiT8nynx7pQZgY3TSdzm6nY5rhoPqaLX215K/3wF280/9WRK+6uPHXIhwNhjplfLiSR
         cZ0cTWLW3HArZbcPLGxnAxXVgezEpmYxfzL+2pah6c6+AD4cnuR9S3m1OM0PM7dkuBqT
         pXc9i+xlqN9qstrKWLOw7sQUqEiOjYAesQ9aaguYCbS5PCUJU3Y6LS4hFbQE/zXju1nH
         EKjptM7A11aPjQ4FV2G29y4GkMWZMODyYjp1hUy51t6ZyS9eK82Nn53Yb0ayPQGLXWxq
         1Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722275273; x=1722880073;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V78HK7/KjvVm6vb5sHb4eAgphXUZC6leMWsDQBJkLes=;
        b=Y/r2xVC8st3DpYCY05+m8mzQqQBxn948dD8I5Fl/si8e7F6hRjNsl9a84bSAM9h5Fp
         MYT4BcoCdfC45oOV48Azm0nZGZLtAx9W8qZ4u46a0lJVIhHOm08EM4jsdSCLOHww8QDQ
         HRuKvLLya9Ck32OqPY3xolid4UKwI+6SKv2bf/eS3R0btlOIBqSyXfH3s4XoMWm8iAlE
         5f3VwGlzx6I2aBqk7TZg4OkiaWKvLM1lom2NhltHgz6v5T+EqDr8Br9oOxILXElWm1jJ
         4tw9x+9s73MnvOlXSw6rupjD+pTnwfNeJEdTuXjxM/RtFGVOcDSXCYg7/UiOYmqLgGD8
         3joQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTL2rag+7/Q6FAjvlchCmWgbRxEQyxo//BhcXrTN49mjOPetL2RyX6zc+ehEkSYhXncl7e5H62HwkLmLCZiTmTQ/yzoimJYPDHVqs7Nr6j3qzwmHS32kVcl1ZIF+4j5jPK+pAoc9apwNoMytS9I9c7pPkfpYaqWWV3k5/oqxVV3ad1zJi9abpOGCkG9c80iv2W1JC/mTiKF/ljYOrMP2WpnI7ut4s=
X-Gm-Message-State: AOJu0Yzf57webDq/6J+m3CmBhPA10lprACi+M4/3X6sMElvCwiM6zZ4R
	HG8p96f0wpmD+v/8axSZ5IuzGDY+Z/F5UvJUFLHr371bzP0UGlX1
X-Google-Smtp-Source: AGHT+IEzVP76gvohlXqS0k65XYNrnFnMn8umFHlR6ZRiwhlX5TiYE3+UjMPQEbMDs5Lg4ZBPFvjCvw==
X-Received: by 2002:a05:600c:444d:b0:426:65bf:5cc2 with SMTP id 5b1f17b1804b1-42811d83c38mr55420585e9.1.1722275272600;
        Mon, 29 Jul 2024 10:47:52 -0700 (PDT)
Received: from tablet.my.domain ([37.30.0.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fc8a7sm12716550f8f.59.2024.07.29.10.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 10:47:52 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 29 Jul 2024 19:47:37 +0200
Subject: [PATCH v3 03/10] power: supply: max77693: Expose input current
 limit and CC current properties
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-max77693-charger-extcon-v3-3-02315a6869d4@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4220;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=64p2zb/TO0sOXA+lVtMC+Y+6Z6xHMlhCGgkfq2NJimA=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmp9W+FIRTZ3IhbI66s8PrQ4IXSptDHnNOxsMyV
 WSLOBGxHBOJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZqfVvgAKCRCzu/ihE6BR
 aHZMD/9gIYbg0pjl+8dd0ysmLc8mn2G6E4B0A6WBIyXtqxy+os7tJFlstZV0b5U4PjpH5vc0Bhr
 XTn3vMyF57qrKl2l9GUdF8EuCLT3nzORYFY48FpzDF52LYbv0ILSHQbtLm9AqimfiXO1kLyDGM3
 DRX5Sip3GNeTtx2c1jJ2gT5GvqhaZMbq4HcLdZoIka/dcf18KYp2SfxouD+KZMNJ1mFS46wsl+Y
 1b+BW8eYRA7nk+961BeltF2Nc1R1tpvXYEIL8HfwS8mliQg4qHVc5+gd11RRtF340N3SCqINLF6
 hn+4uHnwqe+o5ZNOymmWAwn1YIVdE+FykoSw2Mi+8SN/ObmY0CcEpL7klcNarlv/mDbAvE3maEy
 8C7uJTZi52qFMX6U24DZvAfirl8QJQUXQT93UTNXwxiVsW/mcZ0E/WNurBi6FYP8Rwx3C9vxGS6
 wHcPGV3uAAQDT0X2w0xB3eql53cMg4Tiu6iIM7f5cBO5nlCnr/j6LydNDqh89NJ6lmJNJSVDJ6u
 nEwWI49+yFtJP3pfPqrGyV1EIrqEGH62my6BDszcGPL1sI/1yWc0HSNqHUFW5SQH0n/qPmauXYr
 phj9eYaxa0v0+figTaItoGzJIV5nktYGzh2zVEqjRtfGpe7gE7Vii5biPuDKwY9I7bE7WSkOhUY
 k5vLYrei31ScZ1A==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

There are two charger current limit registers:

- Fast charge current limit (which controls current going from the
  charger to the battery);
- CHGIN input current limit (which controls current going into the
  charger through the cable).

Add the necessary functions to retrieve the CHGIN input limit (from CHARGER
regulator) and maximum fast charge current values, and expose them as power
supply properties.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v3:
- Dropped CHARGER reg reference in favor of managing the registers
  directly
- Changed to use CONSTANT_CHARGE_CURRENT_MAX instead of CURRENT_MAX
  for fast charge/CC current property

Changes in v2:
- Adapted to both current limits being managed in the CHARGER regulator
---
 drivers/power/supply/max77693_charger.c | 52 +++++++++++++++++++++++++++++++++
 include/linux/mfd/max77693-private.h    |  5 ++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index 2001e12c9f7d..4caac142c428 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -197,12 +197,58 @@ static int max77693_get_online(struct regmap *regmap, int *val)
 	return 0;
 }
 
+/*
+ * There are *two* current limit registers:
+ * - CHGIN limit, which limits the input current from the external charger;
+ * - Fast charge current limit, which limits the current going to the battery.
+ */
+
+static int max77693_get_input_current_limit(struct regmap *regmap, int *val)
+{
+	unsigned int data;
+	int ret;
+
+	ret = regmap_read(regmap, MAX77693_CHG_REG_CHG_CNFG_09, &data);
+	if (ret < 0)
+		return ret;
+
+	data &= CHG_CNFG_09_CHGIN_ILIM_MASK;
+	data >>= CHG_CNFG_09_CHGIN_ILIM_SHIFT;
+
+	if (data <= 0x03)
+		/* The first four values (0x00..0x03) are 60mA */
+		*val = 60000;
+	else
+		*val = data * 20000; /* 20mA steps */
+
+	return 0;
+}
+
+static int max77693_get_fast_charge_current(struct regmap *regmap, int *val)
+{
+	unsigned int data;
+	int ret;
+
+	ret = regmap_read(regmap, MAX77693_CHG_REG_CHG_CNFG_02, &data);
+	if (ret < 0)
+		return ret;
+
+	data &= CHG_CNFG_02_CC_MASK;
+	data >>= CHG_CNFG_02_CC_SHIFT;
+
+	*val = data * 33300; /* 33.3mA steps */
+
+	return 0;
+}
+
 static enum power_supply_property max77693_charger_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
@@ -231,6 +277,12 @@ static int max77693_charger_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_ONLINE:
 		ret = max77693_get_online(regmap, &val->intval);
 		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = max77693_get_input_current_limit(regmap, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		ret = max77693_get_fast_charge_current(regmap, &val->intval);
+		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = max77693_charger_model;
 		break;
diff --git a/include/linux/mfd/max77693-private.h b/include/linux/mfd/max77693-private.h
index 54444ff2a5de..20c5e02ed9da 100644
--- a/include/linux/mfd/max77693-private.h
+++ b/include/linux/mfd/max77693-private.h
@@ -217,6 +217,10 @@ enum max77693_charger_battery_state {
 #define CHG_CNFG_01_CHGRSTRT_MASK	(0x3 << CHG_CNFG_01_CHGRSTRT_SHIFT)
 #define CHG_CNFG_01_PQEN_MAKS		BIT(CHG_CNFG_01_PQEN_SHIFT)
 
+/* MAX77693_CHG_REG_CHG_CNFG_02 register */
+#define CHG_CNFG_02_CC_SHIFT		0
+#define CHG_CNFG_02_CC_MASK		0x3F
+
 /* MAX77693_CHG_REG_CHG_CNFG_03 register */
 #define CHG_CNFG_03_TOITH_SHIFT		0
 #define CHG_CNFG_03_TOTIME_SHIFT	3
@@ -244,6 +248,7 @@ enum max77693_charger_battery_state {
 #define CHG_CNFG_12_VCHGINREG_MASK	(0x3 << CHG_CNFG_12_VCHGINREG_SHIFT)
 
 /* MAX77693 CHG_CNFG_09 Register */
+#define CHG_CNFG_09_CHGIN_ILIM_SHIFT	0
 #define CHG_CNFG_09_CHGIN_ILIM_MASK	0x7F
 
 /* MAX77693 CHG_CTRL Register */

-- 
2.45.2


