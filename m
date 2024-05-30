Return-Path: <linux-pm+bounces-8412-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F998D47AA
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 10:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E073282A44
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 08:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECE217C7DB;
	Thu, 30 May 2024 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvaHsGpN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5083DAC1E;
	Thu, 30 May 2024 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059396; cv=none; b=A+iq+yKMnhXkGRJIzkP1fWhIh9iQx3CFiumGv6waLvDvMJ5imb1buWmDc1RWVuBBFd9In3cAUtaP2WeBVpR+QSScjNbHqnK21ovMzm9MSFOcpGuIm0bn1/28FX5ta6VhHfhv+pO0BwRpd4/aJ5GbFh+kTGzPBUISzoFfH+iC6oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059396; c=relaxed/simple;
	bh=8GrD+7N4WIECelsMnMsq1oOIcn8b/3kdBSwFTiT2G4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=elTlJ/9iMR7eQTPhmFsgIiLtWl4qImq4rHFylsQASle6J+UxsPiB9y/wSnBDidrSa30MqB4UXIRudlmC7F5TXkrVyMj/vx8l3RNf7bvy8Wp1dnH343Oej48T17J2x72Ooj+zBZiAfJHj9pVGxEq1hYnKfvvRq9LDByXjAwsIyKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvaHsGpN; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a667e104375so19044966b.1;
        Thu, 30 May 2024 01:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717059393; x=1717664193; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LsEhPfZvH2P+EpSo/CYGNbfVPmcN+fNIAQrFOTA/UcQ=;
        b=UvaHsGpNpYN4hTSJE3zUv0WWiyFfbI9JpeoFGD+30R9X/+QaYklGTqZzF750G48hOG
         otK66K6K4XPmQD7Ftkti/p+omXGkRoyny6YmuPUO0PJi6+NqmHdo5YU6BTQUH7YUTB41
         dI+p+9Zrw1O7G9FQQdVS0x2HG/VPC+X+hSG3km5wJIZKNxO7/lnf7ZPuP2NETzGW8RgQ
         Q04JSECSo/G6kLOuHwOm6llAWGnJkysxluf/QdWYeSCTwbgLTqduZmnZPJw2hg9If7Mi
         Nt0leYf8LS58onx/FBFdut1rjTlneqCcZBECWQyaiPgRgWntVfRHPh3BcwjJLsvQ6C0S
         P9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717059393; x=1717664193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsEhPfZvH2P+EpSo/CYGNbfVPmcN+fNIAQrFOTA/UcQ=;
        b=KOtp3GVu/FFbsEDPdJwup4lPVZz84r2IuRXw574hnvDDMGGHkWmrqQ6ShYHjI6CcVs
         7RMGwgusGuSRBwcnTF/OF4rGgr/RqbWhIGHc54xNCUEzz5xqmt55ZzutXvWfjTpicZjj
         zAUuWowb4eXoKZ+g4D+Ix2lbkLSJlqgYIbFlGF8qHEAnKs9EOV1uktmJ94NlnsnDVTaf
         kMvH62hcpCqdMbvYW+qNKWqd38V6tgO5ld5cnMZ+DlwP9yWqJkdOUTiv93/oQOWjNTk8
         OkRXKU5ZBvMQOOduh8o3T3cgX2sBe0kCYM5oDW8c5r9pdoc0yFNiizprodO8vb1wNSu3
         E1zw==
X-Forwarded-Encrypted: i=1; AJvYcCWGOO4woMbybOdkh4xxjBPzfJNZeghKS3xCsTs6ns/4Xj1EnKegPMbMYZl0gYFGTn8T0XjCgkqmgpOfGz5GB23rCCkZxqYM4EjSDKoGrw1/5tfTyLpNgwaltixBPywTyMTPeLi+SyxbQTY569ola60UY2pc4f68F4Gj6ZoR6M1KHb5S+izWoO7Fbw2RVQLmUbynxUq+dklKHLvnPwNtei0JbYxH0x8=
X-Gm-Message-State: AOJu0YwVFTnbvfGfS0vazzYoQwVloaUopG7/GX98YrtN579/9N/WlEOu
	ZuMkBMqomKh2hDRzmVrI0dIJgRmh/jwLZ5oximwKT3wtqUZtzKoz
X-Google-Smtp-Source: AGHT+IGy1UxJBC3mlOkSAXe0pOgPmMNf33MPiINsk2Yc1DhhEYI1xxBd9KGGHgstBwfP54lhtkFN2g==
X-Received: by 2002:a17:906:b49:b0:a65:1322:7a50 with SMTP id a640c23a62f3a-a65e8d3697fmr93332566b.9.1717059392542;
        Thu, 30 May 2024 01:56:32 -0700 (PDT)
Received: from hex.my.domain (83.8.128.191.ipv4.supernova.orange.pl. [83.8.128.191])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc500a1sm798430166b.125.2024.05.30.01.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:56:32 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Thu, 30 May 2024 10:55:55 +0200
Subject: [PATCH RFC 05/11] power: supply: max77693: Expose
 INPUT_CURRENT_LIMIT and CURRENT_MAX
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-max77693-charger-extcon-v1-5-dc2a9e5bdf30@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717059384; l=3592;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=8GrD+7N4WIECelsMnMsq1oOIcn8b/3kdBSwFTiT2G4s=;
 b=ud87G1rB7IwJbUdifMoM61jeuoLZFMLcCeL8B+hk4HIHdhOhuibHT3a/ZGXSAduo063J7b0Ro
 VAw73uJI42YCzPX5EUaqQxsaOcV1p/fgEQgMkNjYBd6jUQMzRv6wmK2
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

There are two charger current limit registers:

- Fast charge current limit (which controls current going from the
  charger to the battery);
- CHGIN input current limit (which controls current going into the
  charger through the cable, and is managed by the CHARGER regulator).

Add the necessary functions to retrieve the CHGIN input limit (from CHARGER
regulator) and maximum fast charge current values, and expose them as power
supply properties.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 drivers/power/supply/max77693_charger.c | 52 +++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index 2001e12c9f7d..894c35b750b3 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -9,6 +9,7 @@
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/mfd/max77693.h>
 #include <linux/mfd/max77693-common.h>
 #include <linux/mfd/max77693-private.h>
@@ -21,6 +22,7 @@ struct max77693_charger {
 	struct device		*dev;
 	struct max77693_dev	*max77693;
 	struct power_supply	*charger;
+	struct regulator	*regu;
 
 	u32 constant_volt;
 	u32 min_system_volt;
@@ -197,12 +199,51 @@ static int max77693_get_online(struct regmap *regmap, int *val)
 	return 0;
 }
 
+/*
+ * There are *two* current limit registers:
+ * - CHGIN limit, which limits the input current from the external charger;
+ * - Fast charge current limit, which limits the current going to the battery.
+ */
+
+static int max77693_get_input_current_limit(struct max77693_charger *chg,
+					    int *val)
+{
+	int ret;
+
+	ret = regulator_get_current_limit(chg->regu);
+	if (ret < 0)
+		return ret;
+
+	*val = ret;
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
+	*val = (data * 333 / 10) * 1000; /* 3 steps/0.1A */
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
+	POWER_SUPPLY_PROP_CURRENT_MAX,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
@@ -231,6 +272,12 @@ static int max77693_charger_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_ONLINE:
 		ret = max77693_get_online(regmap, &val->intval);
 		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = max77693_get_input_current_limit(chg, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		ret = max77693_get_fast_charge_current(regmap, &val->intval);
+		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = max77693_charger_model;
 		break;
@@ -680,6 +727,11 @@ static int max77693_charger_probe(struct platform_device *pdev)
 	chg->dev = &pdev->dev;
 	chg->max77693 = max77693;
 
+	chg->regu = devm_regulator_get(chg->dev, "CHARGER");
+	if (IS_ERR(chg->regu))
+		return dev_err_probe(&pdev->dev, PTR_ERR(chg->regu),
+				     "failed to get charger regulator\n");
+
 	ret = max77693_dt_init(&pdev->dev, chg);
 	if (ret)
 		return ret;

-- 
2.45.1


