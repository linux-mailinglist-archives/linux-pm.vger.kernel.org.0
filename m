Return-Path: <linux-pm+bounces-12323-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B0D9543DD
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16E2F1F23C4A
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 08:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E5213D880;
	Fri, 16 Aug 2024 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2jLvzgi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8AE13B5B3;
	Fri, 16 Aug 2024 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796362; cv=none; b=Awt7Um2ncp2fTAYXDPgUu1w4XVPR84hEy6Fa6vBoUqxdRJWnvEC5Lo9aPJeBGiAic2cEVrAOVLaBrg2gnrCUAfPzoBicX8/JppX9ax9Ku5J+bITYFoilgXu64DxsPtRM8W7tuNDRBbyhDRB7XRXXSBrt4Lc06pu89wcJLqQfpho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796362; c=relaxed/simple;
	bh=9IYOJ5Si+LfLkVCi/KMBWfaO4SAQ49FCSsDSX2k02RU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GUcEF3UdI+lYbeu14mTS1jybYubgjgVDmspbaMZkC7EPVA2bCYKuoEpA+F1xrwKp3WOafjZYjFj5Ab2S+XrIQnCDvU2K0/3KJPyV8f0Ki3H1P6mMEZndA84uAQPE2jRMNt1wqrXydNFxo9ULzlhhR5+hiRkuXQqgOLVM2x5lVF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2jLvzgi; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428243f928cso12312855e9.3;
        Fri, 16 Aug 2024 01:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723796359; x=1724401159; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ATiloHsMDaf4CMk8cdUWOTXJanYqTe2+ZJJOm0eYxfI=;
        b=E2jLvzgiBUIGYc56aM9oJ8U0USO0B30xfOjacVzxFJL854sf/mr0rpDk20iyEQKPaW
         pp9uXmFSnVbM49m0UHrGrKfUh+S0RTcjxafVxcQvVI3l3ijVan1B/YiLUrnKkLUocqgc
         cL73XV8LLOPXLZM8fA5g8T5bu75WDzR3lChUv+VT0A9/EXVlZvgddlv+tWoMGQWL9oQ+
         OAlaL14DdI6QoNbp42jhzuhbl3YsDepTyrGZu6H8+mkzEC1hvQYbQaoeq9OdVjG3LTWk
         U7WZnGG23qLnpGMfF9yJ2Rm+xuNiFEzs2j4/nGbWQ/9LSjMDTpE6hGz/0jKxFUysiZ6B
         yBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796359; x=1724401159;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATiloHsMDaf4CMk8cdUWOTXJanYqTe2+ZJJOm0eYxfI=;
        b=uAbENiQKJNDv69/UgMsgPtIH0abD17q7JkyEgaKnIYh/jnO4Ra6w8OphsWekiasRUQ
         g/gjGOK5NOEk1QSGvrTnEZv9rRXtrV5s7u6EDZ4XE+vfE+/SuHyLHxbAh6tIPge7eo21
         2BRWsKBuP9lxGaZ2sK6g758cb2J+X83qtb1ptQcFGGZEITuiLrxYaXAbP64chTcFZjXZ
         pEAwPeQ1fw+qhUkTQVU6aBFVFiScoPqR7NENuar4lqqAfZyNNH7T9MEG8p1tTA7mRNOx
         ggTikK1Dx+5ptiXHfvFOm7paXH62nS3QPj9PmwStpbO0Sk5FO0rsmzWG7ONhsQ6IdHe5
         M5Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUEj9fkQYZdO0bgLdeHfh3aXxao1/9+ntL8JJYE8SleVOOUcqkgCHVnjprS9Ml1PF2uvIkgaHzoUiIPu0fayBg7A0J4hBnCHnZJigr01Vg8YsHG9cbxlVzqCwJ1tnvJllRjv4FdO2huX3Jxf5KuNmhARkd2HCiKMGHwceF0PoGNiK5p4mrdXuc76At5uqylrvwESiajhF+AP6M5osQMP3ZiFuHWv30=
X-Gm-Message-State: AOJu0YwUakQRFOflWgQ/si3L9c/1R6MxldWpdhB2ZSQQBDc/SK9aCgLA
	bD2KwtckWrPgpff4NbKwj+Wf5E+sD0XixteVRvWdzvurqWSxFedk
X-Google-Smtp-Source: AGHT+IFZVBfIxeRRQQdYKBVbIL/LlcK8Xckk0mrM3X9pjm13/8U5f09VuGWp1dTEiDNUiNzFSTW+1w==
X-Received: by 2002:a05:600c:5254:b0:426:622d:9e6b with SMTP id 5b1f17b1804b1-429ed7cce32mr12561705e9.23.1723796359212;
        Fri, 16 Aug 2024 01:19:19 -0700 (PDT)
Received: from tablet.my.domain ([37.30.8.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded35991sm69732645e9.21.2024.08.16.01.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:19:18 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Fri, 16 Aug 2024 10:19:09 +0200
Subject: [PATCH v4 03/10] power: supply: max77693: Expose input current
 limit and CC current properties
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-max77693-charger-extcon-v4-3-050a0a9bfea0@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4267;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=9IYOJ5Si+LfLkVCi/KMBWfaO4SAQ49FCSsDSX2k02RU=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmvwt+B9dItojtyq9JMOVXfTV0Y4E6HJELeVrGz
 5L6JIMqdPaJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZr8LfgAKCRCzu/ihE6BR
 aN/1D/44BbqpiUrmya2u3MQKsTMDcLUdMN1u7gjA0nVafkmQycc9654R/GBZ2Qc8fC6eLbFVvsB
 dhn7slD9g8dHpE4drqkTLFnceu70q519uo0ZXz/Jzv9EqYGOsHsGUjaqbolJeiWrYsqOlNxjV7X
 2QdHze/Szy+NbdYxDTKzc6osxPLV49CylDodw8SDt6+xUNZDSRmC591KLSBtKjcHQMIJ2W0nluG
 YI47KKnt2gIMlpv4DjM33BRKVSlC129QunHtWLyDkVLdVjyU/ZKE4BAbkKLegvrcxWaA2TwD+Ar
 KtHiMx80shyu0bytyFB9BomXdFkRcI+FnQh0EpbzaupxcUA9EuGgcXV0isZ58CZrtI4iNSI0355
 js19HfYVkZet2KcBO2+1eSZfC5V/5Tqk7xbbFisItCHDCmypocICWAOaVoXSHa1vCCIrMDbgz8V
 Mc4EVG61GuLi7dgDebwmagpTLDNrEuLnMf7X8iNiNEM5hFUdiuUn7YIOiR4lV/Csj9tfwJD/vmy
 8fnO89flT2asT+YGPp9K9piIEf51CD9Otv/e1ZreqjM/5VcQnK4chCWE/9z0L25aJTWqtLAOMXJ
 xP+kkoiYYQFENRzGThOaVu4gG24BnA4amHOmgOMhan8AlvzOBUaFsLgOpP4vnbnttdrjg/TNlAr
 ipZLSuvMlGMuL6w==
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

Tested-by: Henrik Grimler <henrik@grimler.se>
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
2.46.0


