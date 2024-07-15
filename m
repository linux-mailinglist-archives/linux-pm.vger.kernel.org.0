Return-Path: <linux-pm+bounces-11109-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD49B93151A
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 14:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7536E28382A
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 12:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC2418F2E3;
	Mon, 15 Jul 2024 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZA8KbwE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F7518F2C7;
	Mon, 15 Jul 2024 12:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721048128; cv=none; b=jeT8siUtvWvNIJb7hluiXFeQnJ9yzz0Xm4c1U5uMlKB87Kj5wfEirG4YBNMqQ6oWeUXGALxtWxLDeFnq8auamkmOQbJtZy9IxkuKJmm392mqnNahJXDa9sqF2hRntlfZsbVYoEJqAh75I0C/v3WF7O/fJK2FBKbawiAuB2GkuNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721048128; c=relaxed/simple;
	bh=EXZReySANjkAeBrLFiKGCwE8yARrL34C4+BpkRUqMJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XSGbP8Lp6hHytNVIjVVGdZd1NmB46AEXoGmvSXadbSz6c9q8scoYr+biZjvhRwWM5ENvB4YgC07dA1Y8y3on3+sA3atjwrW8w0uJEAf1wiIGazXpzrw21q5ZZz8rozEHX0EaEOdekUK5C9PYiNzlPscsgKCOeVcUf2pkref6ZCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZA8KbwE; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-585e774fd3dso5507157a12.0;
        Mon, 15 Jul 2024 05:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721048125; x=1721652925; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yplmBPab31T+ENfBznOyfetvZRWw0PUytsuLn61zZ54=;
        b=hZA8KbwE0uPXkDMRhZ+SqOZ9We/9+eJbC1aRgLBWPU/Ip4palY8LdG5xRSVe10JMvk
         AaSLBIxrVJzXbYiddadn8nk1HJSI2KeQ7xdP37XE6sTYpwDe9rYO0Lo4JcVMr6AyWt6J
         IH+RKgP3ZxeE8BdBn6p/6jQ1rehNZQMKbNr7mbMltEZ6tCkWXcW/D4rjLEO3fFekCVe5
         1iUIH3OrTC6CP1rJwGGlpzOFB/qGLyPFajEthYNKAHzZudsvhZ05FSAdZ3Ba3XQfNqjq
         GvPSfFaMvtoMQG/4xsLm7sXismKsMG0g1/uSwvdEs5AMvMmHdnDoNeNuC7z47atiHHau
         OQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721048125; x=1721652925;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yplmBPab31T+ENfBznOyfetvZRWw0PUytsuLn61zZ54=;
        b=CrpfdfFJGGBE9/36uUiVaNQl2KPhsvqB5RzSFvs2DYthL8tT/azajt/jBcsGtLUQxd
         trpsObqXq8CrWfLVUxd0qKD673x4WRw9J0/D3vR9fJKGeKRGVrDM5BlEEgmGWFN38ZIb
         xBE4wEjtrDncwzVJ2KmtIJ7HM3bc42t/4OQW3CG4O5eJMY69OzA/k/bFitb2ykMvZPCN
         t961bf5mdZdnUeyLMDiOcmGYUBgoTX7ZrsCB6RMP1cCOjDHAnKsFIfw2572y5V3VJ0a/
         y/Vof0AGhqgE1lqrX+fNPrSlyFIJQFH3IkKpEaY0G37eXah/Q82+ea0DXLctCKUrvQRz
         kazg==
X-Forwarded-Encrypted: i=1; AJvYcCU5pB6gse0JLP+5r5yj4NZPNg764V6na35SN153W8bEZMXZmpsa+0Rou5IcLeNNuVPkNY6xZEKGyd7YOPt3hXbaMKIh9fe6o0US3gjdI4n+eZakeWIg0QWce8DxoMWjFGwPqq5n1lT2S3L+tTlkr0jyIY+8GEXDk8w5/1wDVSopIZKz1leQh8xzI9N96XV01/VN5IrDy4t1xN7Dv9AbfspUGJI/+KA=
X-Gm-Message-State: AOJu0YzfwfBis4JxTesSirQMTVdv9T72FXIlYwaGOJqa6jaHhvQFxwIK
	y8vOVhfaIE/XIVP7hd0H3gOKuFlrNyxaRFtYxJA5WmNNTHl85IF5l62uxZwg
X-Google-Smtp-Source: AGHT+IEi0rB6grzKm+6JFok97+M2O9K/mc/iV01iqXjDpsx+NrTD6Yh0aFRRjs4CR0X9xR4LS9ghuw==
X-Received: by 2002:a05:6402:11cb:b0:58e:4088:ed2 with SMTP id 4fb4d7f45d1cf-594baf8d6e7mr14449097a12.16.1721048125174;
        Mon, 15 Jul 2024 05:55:25 -0700 (PDT)
Received: from tablet.my.domain (ip-37-248-157-210.multi.internet.cyfrowypolsat.pl. [37.248.157.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b26f62165sm3333307a12.87.2024.07.15.05.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 05:55:24 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 15 Jul 2024 14:55:09 +0200
Subject: [PATCH v2 7/9] power: supply: max77693: Add support for detecting
 and enabling OTG
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-max77693-charger-extcon-v2-7-0838ffbb18c3@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6011;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=EXZReySANjkAeBrLFiKGCwE8yARrL34C4+BpkRUqMJU=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmlRwqLWuWZaYoe183l0Kev4lM9FuRl+x8JjYe9
 DhmziyLvsyJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZpUcKgAKCRCzu/ihE6BR
 aFqqD/9k+4cgfR7QbdCgxHMiTAdYZ6yaMlYJNKYairM6DJecVzZQ9oSl9CvPMC3Y+Mj7V+yDDM1
 8uPupF/FP1Ske93xmu36wjbQsAc+6HsqG5Y49oq4pphAO6OKKmJLIlRMoxut9Y4S6cAob1K2l8j
 e3HKLdOgDxsMS3141wj9AgOxNOtbAzdcxrbpxng59RY3AKGSQU2vvIEvs1OiSvHezgrNZhQWBYa
 LuuUrGDZsYRChOMDovahmJ0FncmO2GSJSJ1pAbGmkyXJ03q/3a6EN0sEF0sZeHw464raM7I8mMI
 5CxZbw7kbrvlZmUZrOfM60EIflph3OADafH1lL1vkV7KsKfLJNES2M4qjJwKNuOy60yKzr7fkz8
 FD2tp8AvXjQGRbOhSougbNWjMrCkDhXJ0/dEGlZtgWJCrUetds8gOdU9lUXPq8SdZIk7YMoXjJP
 d9PL6RZ4r+pgDshMGQ6DJ+yCOQ5nuK+rEygkf32lW7PvdJ0B9Qj1lufEAJk9xUX1yeOdB5+RkCI
 223MTVODK1YqRC5CVqnYKpGEGB6ATxrElIV7VzWZBKo4/s8L6K/O16q1K7bezshjOCkEtxd9bp0
 6Mge3bn1D0xnpkJ5jQBXodYbxSsXbfyzqoCDT+diuZGwPqjudw1W/DfiznkMpdZnoPYdBkRZFYU
 I7W0r/aPUFzncuQ==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Building upon the newly added extcon detection support, add detection
for USB OTG cables (EXTCON_USB_HOST type), and enable/disable the OTG
bits as needed.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v2:
- Added CHGIN OTG current limit value
- Squashed MFD header register changes into this commit
---
 drivers/power/supply/max77693_charger.c | 103 +++++++++++++++++++++++++++-----
 include/linux/mfd/max77693-private.h    |   5 ++
 2 files changed, 94 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index 2dc273dd96ee..34d68b1050d4 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -669,6 +669,16 @@ static int max77693_reg_init(struct max77693_charger *chg)
 	if (ret)
 		return ret;
 
+	/* Set OTG current limit to 900 mA */
+	data = (0x1 << CHG_CNFG_02_OTG_ILIM_SHIFT);
+	ret = regmap_update_bits(chg->max77693->regmap,
+				MAX77693_CHG_REG_CHG_CNFG_02,
+				CHG_CNFG_02_OTG_ILIM_MASK, data);
+	if (ret) {
+		dev_err(chg->dev, "Error setting OTG current limit: %d\n", ret);
+		return ret;
+	}
+
 	return max77693_set_charge_input_threshold_volt(chg,
 			chg->charge_input_threshold_volt);
 }
@@ -690,11 +700,42 @@ static int max77693_set_charging(struct max77693_charger *chg, bool enable)
 	return ret;
 }
 
+static int max77693_set_otg(struct max77693_charger *chg, bool enable)
+{
+	struct regmap *regmap = chg->max77693->regmap;
+	unsigned int data;
+	bool is_enabled;
+	int ret;
+
+	ret = regmap_read(regmap, MAX77693_CHG_REG_CHG_CNFG_00, &data);
+	if (ret)
+		return ret;
+
+	is_enabled = !!(data & CHG_CNFG_00_OTG_MASK);
+
+	if (enable && !is_enabled) {
+		/* OTG on, boost on, DIS_MUIC_CTRL on */
+		data |= CHG_CNFG_00_OTG_MASK | CHG_CNFG_00_BOOST_MASK \
+				| CHG_CNFG_00_DIS_MUIC_CTRL_MASK;
+
+	} else if (!enable && is_enabled) {
+		/* OTG off, boost off, DIS_MUIC_CTRL off */
+		data &= ~(CHG_CNFG_00_OTG_MASK | CHG_CNFG_00_BOOST_MASK \
+				| CHG_CNFG_00_DIS_MUIC_CTRL_MASK);
+	}
+
+	return regmap_write(chg->max77693->regmap,
+			MAX77693_CHG_REG_CHG_CNFG_00,
+			data);
+}
+
 static void max77693_charger_extcon_work(struct work_struct *work)
 {
 	struct max77693_charger *chg = container_of(work, struct max77693_charger,
 						  cable.work);
 	struct extcon_dev *edev = chg->cable.edev;
+	bool set_charging, set_otg;
+	unsigned int current_limit;
 	int connector, state;
 	int ret;
 
@@ -707,31 +748,61 @@ static void max77693_charger_extcon_work(struct work_struct *work)
 
 	switch (connector) {
 	case EXTCON_CHG_USB_SDP:
-	case EXTCON_CHG_USB_DCP:
 	case EXTCON_CHG_USB_CDP:
+	case EXTCON_CHG_USB_SLOW:
+		current_limit = 500000; /* 500 mA */
+		set_charging = true;
+		set_otg = false;
+
+		dev_info(chg->dev, "slow charging. connector type: %d\n",
+			 connector);
+		break;
+	case EXTCON_CHG_USB_DCP:
 	case EXTCON_CHG_USB_ACA:
 	case EXTCON_CHG_USB_FAST:
-	case EXTCON_CHG_USB_SLOW:
 	case EXTCON_CHG_USB_PD:
-		ret = max77693_set_charging(chg, true);
-		if (ret) {
-			dev_err(chg->dev, "failed to enable charging\n");
-			break;
-		}
-		dev_info(chg->dev, "charging. connector type: %d\n",
+		current_limit = chg->fast_charge_current;
+		set_charging = true;
+		set_otg = false;
+
+		dev_info(chg->dev, "fast charging. connector type: %d\n",
+			 connector);
+		break;
+	case EXTCON_USB_HOST:
+		current_limit = 500000; /* 500 mA */
+		set_charging = false;
+		set_otg = true;
+
+		dev_info(chg->dev, "USB host. connector type: %d\n",
 			 connector);
 		break;
 	default:
-		ret = max77693_set_charging(chg, false);
-		if (ret) {
-			dev_err(chg->dev, "failed to disable charging\n");
-			break;
-		}
-		dev_info(chg->dev, "charging. connector type: %d\n",
+		current_limit = 500000; /* 500 mA */
+		set_charging = false;
+		set_otg = false;
+
+		dev_info(chg->dev, "disconnected. connector type: %d\n",
 			 connector);
 		break;
 	}
 
+	ret = max77693_set_current_limit(chg, current_limit);
+	if (ret) {
+		dev_err(chg->dev, "failed to set current limit (%d)\n", ret);
+		goto out;
+	}
+
+	ret = max77693_set_charging(chg, set_charging);
+	if (ret) {
+		dev_err(chg->dev, "failed to set charging (%d)\n", ret);
+		goto out;
+	}
+
+	ret = max77693_set_otg(chg, set_otg);
+	if (ret)
+		dev_err(chg->dev, "failed to set OTG (%d)\n", ret);
+
+out:
 	power_supply_changed(chg->charger);
 }
 
@@ -793,6 +864,10 @@ static int max77693_dt_init(struct device *dev, struct max77693_charger *chg)
 			&chg->batttery_overcurrent))
 		chg->batttery_overcurrent = DEFAULT_BATTERY_OVERCURRENT;
 
+	if (of_property_read_u32(np, "maxim,fast-charge-current-microamp",
+			&chg->fast_charge_current))
+		chg->fast_charge_current = DEFAULT_FAST_CHARGE_CURRENT;
+
 	if (of_property_read_u32(np, "maxim,charge-input-threshold-microvolt",
 			&chg->charge_input_threshold_volt))
 		chg->charge_input_threshold_volt =
diff --git a/include/linux/mfd/max77693-private.h b/include/linux/mfd/max77693-private.h
index 4570646e2f33..313fcc3173f9 100644
--- a/include/linux/mfd/max77693-private.h
+++ b/include/linux/mfd/max77693-private.h
@@ -209,7 +209,10 @@ enum max77693_charger_battery_state {
 
 /* MAX77693 CHG_CNFG_00 register */
 #define CHG_CNFG_00_CHG_MASK		0x1
+#define CHG_CNFG_00_OTG_MASK		0x2
 #define CHG_CNFG_00_BUCK_MASK		0x4
+#define CHG_CNFG_00_BOOST_MASK		0x8
+#define CHG_CNFG_00_DIS_MUIC_CTRL_MASK	0x20
 
 /* MAX77693_CHG_REG_CHG_CNFG_01 register */
 #define CHG_CNFG_01_FCHGTIME_SHIFT	0
@@ -222,6 +225,8 @@ enum max77693_charger_battery_state {
 /* MAX77693_CHG_REG_CHG_CNFG_02 register */
 #define CHG_CNFG_02_CC_SHIFT		0
 #define CHG_CNFG_02_CC_MASK		0x3F
+#define CHG_CNFG_02_OTG_ILIM_SHIFT	7
+#define CHG_CNFG_02_OTG_ILIM_MASK	0x80
 
 /* MAX77693_CHG_REG_CHG_CNFG_03 register */
 #define CHG_CNFG_03_TOITH_SHIFT		0

-- 
2.45.2


