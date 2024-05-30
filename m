Return-Path: <linux-pm+bounces-8413-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D79C08D47AE
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 10:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E431C202DC
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 08:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5E617D35F;
	Thu, 30 May 2024 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpgO9AIO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFB117C7CD;
	Thu, 30 May 2024 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059397; cv=none; b=Wyuir1Grk7NbAxz6/Dj203n+yVWYkSjGdoTwQX93dQKWflWk9VYu/uRqGnDRiZjXLzcXv9pyNtE6aEdUGzALTwIAE8v5xiF9ED0w1JtB5Ld73gJIJxZ8/qasPRz99ugiMuSLM8xI2QwE5o6379SO3o3dC1JJZ2S2eGxB9iS8mI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059397; c=relaxed/simple;
	bh=C8RQpwCwOR+YYCuseUykropyLMG3kS1Is6uGMemnREw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cBuQl949zfP734vHBJ76HbkIDqgggE2QSC1V6T8TLvlhtqxvPRTTA04WmTkItTMH77uFryzIK+zYzp/EwRP5wpnlizvxt26jaiVgtBpe2VSqVNXKPy9vrXZtmstCMIbj7aQSLUXm/cveL/VuXyxwrz1hegueKwQT91LaYDAtvAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpgO9AIO; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52b7ebb2668so466264e87.2;
        Thu, 30 May 2024 01:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717059394; x=1717664194; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7RjpzD6bfEzWTvpqtXGEvDLHQS6WjNKNOtNtOUf/g0k=;
        b=GpgO9AIOEBDl9h70EV6beLFPGNbx9IKkS1cGFUs6t2L/4Nf6+VailHqTwIHaMt6nc0
         SMmthAEkPBIKhk1x+2gkioIgGXkWh9wJz4seY9RrMIy0uIzk+vSdVOAWBZG2FpWQqz01
         BKQLXTLHM44ASTAnTX6vr0OsejpCRROAjRJvrrhrbzR7kFgkYpLPtOfNmIqYuEB6fqJi
         96T0Kirip5/EOu8gkPTgceAKbvGc0GMLp0CVFHAZj01SVjpQ32FgtIjAfAZs+Q13Iqe9
         xkdx/r/TAe++FSHbK2Zks54fVby3lUYUhMs10XWFucAMTz/13wkUpsCaWZ3ypzDyBW8D
         8j8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717059394; x=1717664194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RjpzD6bfEzWTvpqtXGEvDLHQS6WjNKNOtNtOUf/g0k=;
        b=hG0MfMWXwCvZebpx2OW/QN1vDV/My6TwCE9B07LtaAji7iVK0JoBur14349bG8tJtx
         rPQ2zPXQXPLPb2Fy9tZeDf19A19InGkEQ8ZAkXQv4Cf6DOQP1v5yfVc3HDvmedLAJ+LO
         ADQZp+yUkSks2/mxrMFb//R4US9YRRcTuylMAVlVtGdtgMRenHuPRvi4Us9u98/GYitH
         FaiqcsaYqPzX8NdVjognSBkYEPRo28u7apv0F6utzz86Tm09wmiRF0v0oGzEy6OEvnAG
         yJCduQGeuCEEkKZSqZJXBG/PVDnY//zl18ao+7M1tofw6OO1h8McRxgPMaLFaDKfAVls
         nKxw==
X-Forwarded-Encrypted: i=1; AJvYcCVfnGJG0c9ARaD+4syJR4TyHzyaxBmmvADfYvV/Go+ts4EbweUP4CirbMZc2mKznDxQOFzoqBUlt4+/Clh/bNh0A6ERVDrakQqmEkyu5LIFOQzcFREYRbYwwGEfyR59JCglM3Sr/7JtNzeBQCXB8O9i+fCxf9a1bNl0rtOL7VC0J7ce22CDnSY1PPqjfCNOXlZKfNcRcr1M+r4KgY4AhTBEcrV640E=
X-Gm-Message-State: AOJu0YwUx8WCy+dRotLcH3iiDjjBmns3ZbROevZxQ6uYzKvKfiekivtC
	eoH//wsdDAzu76l262thss2Y0mbi5tA5CN9BSFB1H7/m4sz/qp95nI7zyg==
X-Google-Smtp-Source: AGHT+IHwPpyulXExjGnPKagykwpS32TIBll7xV05JGGq+Yi/BHyTXoe0cwkmsoRZnXimftPoX515uA==
X-Received: by 2002:a05:6512:1183:b0:52a:de09:283a with SMTP id 2adb3069b0e04-52b7d43b001mr1194683e87.37.1717059393912;
        Thu, 30 May 2024 01:56:33 -0700 (PDT)
Received: from hex.my.domain (83.8.128.191.ipv4.supernova.orange.pl. [83.8.128.191])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc500a1sm798430166b.125.2024.05.30.01.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:56:33 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Thu, 30 May 2024 10:55:56 +0200
Subject: [PATCH RFC 06/11] power: supply: max77693: Set charge current
 limits during init
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-max77693-charger-extcon-v1-6-dc2a9e5bdf30@gmail.com>
References: <20240530-max77693-charger-extcon-v1-0-dc2a9e5bdf30@gmail.com>
In-Reply-To: <20240530-max77693-charger-extcon-v1-0-dc2a9e5bdf30@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717059384; l=3318;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=C8RQpwCwOR+YYCuseUykropyLMG3kS1Is6uGMemnREw=;
 b=ot9Ju3EGJBen9DJEc/vVfO7LgQgKOaa5PtRG8GPVMQY6vN+iI9zaPuXzBkUtX4sQCTlX+dRwl
 K0xAp8pivroAnNNGQt/G9m+i0vfmTOy0gZ4h89eqN2J3XET461eIXRg
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

There are two charger current limit registers:

- Fast charge current limit (which controls current going from the
  charger to the battery);
- CHGIN input current limit (which controls current going into the
  charger through the cable, and is managed by the CHARGER regulator).

Add functions for setting both of the values, and set them to a
safe default value of 500mA at initialization.

The default value for the fast charge current limit can be modified
by setting the maxim,fast-charge-current-microamp DT property; the
CHGIN input current limit will be set up later in the charger detection
mechanism.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 drivers/power/supply/max77693_charger.c | 45 +++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index 894c35b750b3..d59b1524b0a4 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -28,6 +28,7 @@ struct max77693_charger {
 	u32 min_system_volt;
 	u32 thermal_regulation_temp;
 	u32 batttery_overcurrent;
+	u32 fast_charge_current;
 	u32 charge_input_threshold_volt;
 };
 
@@ -591,6 +592,35 @@ static int max77693_set_batttery_overcurrent(struct max77693_charger *chg,
 			CHG_CNFG_12_B2SOVRC_MASK, data);
 }
 
+static int max77693_set_input_current_limit(struct max77693_charger *chg,
+		unsigned int uamp)
+{
+	dev_dbg(chg->dev, "CHGIN input current limit: %u\n", uamp);
+
+	return regulator_set_current_limit(chg->regu, (int)uamp, (int)uamp);
+}
+
+static int max77693_set_fast_charge_current(struct max77693_charger *chg,
+		unsigned int uamp)
+{
+	unsigned int data;
+
+	data = (uamp / 1000) * 10 / 333; /* 0.1A/3 steps */
+
+	if (data > CHG_CNFG_02_CC_MASK) {
+		dev_err(chg->dev, "Wrong value for fast charge current\n");
+		return -EINVAL;
+	}
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
@@ -668,6 +698,15 @@ static int max77693_reg_init(struct max77693_charger *chg)
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
@@ -703,11 +742,17 @@ static int max77693_dt_init(struct device *dev, struct max77693_charger *chg)
 		chg->charge_input_threshold_volt =
 			DEFAULT_CHARGER_INPUT_THRESHOLD_VOLT;
 
+	if (of_property_read_u32(np, "maxim,fast-charge-current-microamp",
+			&chg->fast_charge_current))
+		chg->fast_charge_current = DEFAULT_FAST_CHARGE_CURRENT;
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

-- 
2.45.1


