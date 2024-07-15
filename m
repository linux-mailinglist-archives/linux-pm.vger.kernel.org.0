Return-Path: <linux-pm+bounces-11106-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA5193150D
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 14:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF321F217CD
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 12:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4257618EA7D;
	Mon, 15 Jul 2024 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKRKnbLj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB0118EA61;
	Mon, 15 Jul 2024 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721048122; cv=none; b=jq3Bxsghai4A1eB0Y5njKK5Wtg/whYPcYbh3dik40yo0uOmgq2qFuEouf6XVBtdpipWZZU22tOBWJT+GVVu+VwbJz3PY1yTN2ENmZoC6iUAuMr/wRGw4xUKzQzRApaUeaZ61HMCyd4hPYrzHLBg4koCderfsniWtZLJ6jZrYI/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721048122; c=relaxed/simple;
	bh=1lV+PvQs9RkMQaB50b7Zw5vUCqbzy36VnOEmeBWappo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bm0VOlTymBnKCJ/843mLG5UPRKJqoDQ1Jms18GSvLWvAzC6OTFZzAVSKIvdiPvzGnzOACQ99XRzjvTAMGA7UMoEntWcncElJI2PXI9ua9OgHklVreXvDhM4HcmZlwvRwfCeLvvDgBvs4XE8/3D6BSqbhQYk0hwwjJZN1F9s3QJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKRKnbLj; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58b0beaf703so5331768a12.2;
        Mon, 15 Jul 2024 05:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721048119; x=1721652919; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2dnrbGKaoLS2/r35L01fJO0wiCmLb/VBCvJttZm/KZE=;
        b=UKRKnbLjXkcxRAt+6NRFNQCv/XcxAbsdqgEb4IyDHkqtMRvGWHl+gGRCwQ7giaSDO4
         vFkFSoXweb6QoQ7uEnFXDSerVDuVpodG5vew8pC5u13/ulNSSBFsHWO29idLbNGU9ihr
         JRfM/TTMjKCJJyhTnPBFzsRkZ8u6+P3fzWe5cwKsfek5t7Y70Ba/VFtYLw137OsDqDog
         F9PEEZpAyLlFCrNFfc4PyuVeQZJJfLaW8XaDhI+wPLydvcdXPB+d6/lWTLBo3tMIFR89
         HkF4oKOdrq60RRWXg9Uemhe7I7fsBuR14iFBef1PKI1HNZ05xqkU4Fmdj+SwaUdN+l/0
         ahwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721048119; x=1721652919;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dnrbGKaoLS2/r35L01fJO0wiCmLb/VBCvJttZm/KZE=;
        b=ZDo91c2oev4kovXj26HUdIA0AGAvh6yVdRykPaByjOJI3IR2mB7EQhLLzBvPL5ZrI0
         3XhL13sOKInNzWncyqPnMq1MS1IEMxmQCL+g/+aVK0Hywzz2TdVtkJAKwlmQVFiqbwUf
         5dvO3arc9A1dzhwTdlSBzknM5Wra2q8Zoa+fDq++U1nhQUlWmNXCkLMMwFfupBBYhWNX
         THoWsoJ/NpTI/hh4bAp80p9yuoVqY7gm6TXgs7wMsCmbpvUtT1ViTiXky49pNG378/8O
         lqMSJNwcbEPuz2AUN11HYZhOupnQ+QByicre9pki0k/nx3VyZrKr0VLM7/N9RL1iZ3TM
         ETLw==
X-Forwarded-Encrypted: i=1; AJvYcCVzkHo5as5LSeotUZBOs0NZAsygHb4RCNOrqcwWWAx7mMbCNp6z83Reo+ggX45XFhwSlpJMV56XATQeUJnY7ro6hgqQeYuxevCtDNWKpKlOOntOrbOM/xLdxMXNvaveq1Bq7YdsCiLCMHoFDmmk9beIjARz1bZxSI8FtxZHXLwCKJraxoiqiQo8KAcmRxXr4Ax1iaTC21NeiSRNcJsNsOtpyge+Myc=
X-Gm-Message-State: AOJu0YxkPi9oaULnM4tgteiMuEygBaQqatVC60oYcQ01/7EIKXq48mLr
	kkfeQAba3QfoJMj50lFnH/xXFarFKPJu2pifCdfS1jkBEEoU4EzTrNu42JMm
X-Google-Smtp-Source: AGHT+IGKYmXJeIOPB/b6vl4yOzL3ahdkEu80vW0kNZgFlL4bFu7UcYPpvXzfkUGFqZN0xjUW9B6bFA==
X-Received: by 2002:a50:bb04:0:b0:59e:65d1:a573 with SMTP id 4fb4d7f45d1cf-59e65d1a75fmr199688a12.21.1721048118746;
        Mon, 15 Jul 2024 05:55:18 -0700 (PDT)
Received: from tablet.my.domain (ip-37-248-157-210.multi.internet.cyfrowypolsat.pl. [37.248.157.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b26f62165sm3333307a12.87.2024.07.15.05.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 05:55:18 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 15 Jul 2024 14:55:06 +0200
Subject: [PATCH v2 4/9] power: supply: max77693: Expose CURRENT_MAX
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-max77693-charger-extcon-v2-4-0838ffbb18c3@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3161;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=1lV+PvQs9RkMQaB50b7Zw5vUCqbzy36VnOEmeBWappo=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmlRwpt1JLmGw3JWwB62NBhkT4suEV7QjKcBC3M
 zVBlzxGAFmJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZpUcKQAKCRCzu/ihE6BR
 aLeJD/9Ef/NUzUm3MsA+/2pPGkUkhL4zfMZx//VessDpHA5cioDs6pX5hk4kbkfKTFwVBiGE9+l
 EtoTOt7Jjqigf63T6WidXghkyjcY7IZ2KIL8Qr6ZhuJESM0BWmoafPQNmwHO8w0euZHLDknW0T5
 M1inRVJynstVx/a1k2yM1peHB/oijHfPRKINmUFleDSURUVhxH0nBmj8eQ5YjV/CwA9p07EZ7MX
 cG9e8pl1Er379lWOc4NcT88omRw/aFz/znEfmJ8i+/lCm8rJV4LYdTes9Nx3/T+PTzrL9xj3y5s
 abiRw7f9JpQuuDJr3NVzIc0OxMEUPMFFIY7+ao8O7rmHE1A5bpzED45+VBiDCe1+ydTN9uOQO6f
 w+mt8u2Hx73aQjfQRymE710Uer8XBajg9hZTt3I27sb+3U8OL0n/+sJeRcOrf/w59rnrsx5j1xf
 OX1zwrxS5WkHkiaO5cMMcCkTazQmGAoG6/15v4ioJSP60+5fnQCGbkWLRT9EZJ435HWc1GFZWD6
 JjhE2KqJ1NV2wzBfyDJxn4IbO0ymKzLikJ1i0lE0oXVHSy1j1Hvp/UVGTgy8kbonCtg4FS+Jzr7
 WrLCMN9+Eol+lAmkfVn4DW0fTNicVqY0dnMcCbKs+QkQ6VUICLKz5mj8N4CbH1uC9wU3dXksxAp
 UnGHu9AqNxsyt7A==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

There are two charger current limit registers:

- Fast charge current limit (which controls current going from the
  charger to the battery);
- CHGIN input current limit (which controls current going into the
  charger through the cable).

Both of them are aggregated in the CHARGER regulator. Add a property
that allows for reading the current limit from userspace.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v2:
- Adapted to both current limits being managed in the CHARGER regulator
---
 drivers/power/supply/max77693_charger.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index 2001e12c9f7d..0d53f61d58ba 100644
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
@@ -197,12 +199,33 @@ static int max77693_get_online(struct regmap *regmap, int *val)
 	return 0;
 }
 
+/*
+ * There are *two* current limit registers:
+ * - CHGIN limit, which limits the input current from the external charger;
+ * - Fast charge current limit, which limits the current going to the battery.
+ * Both are managed by the CHARGER regulator.
+ */
+
+static int max77693_get_current_limit(struct max77693_charger *chg, int *val)
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
 static enum power_supply_property max77693_charger_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
@@ -231,6 +254,9 @@ static int max77693_charger_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_ONLINE:
 		ret = max77693_get_online(regmap, &val->intval);
 		break;
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		ret = max77693_get_current_limit(chg, &val->intval);
+		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = max77693_charger_model;
 		break;
@@ -680,6 +706,12 @@ static int max77693_charger_probe(struct platform_device *pdev)
 	chg->dev = &pdev->dev;
 	chg->max77693 = max77693;
 
+	/* This gets the CHARGER regulator from the parent MAX77693 device */
+	chg->regu = devm_regulator_get(chg->dev, "CHARGER");
+	if (IS_ERR(chg->regu))
+		return dev_err_probe(&pdev->dev, PTR_ERR(chg->regu),
+				     "failed to get charger regulator\n");
+
 	ret = max77693_dt_init(&pdev->dev, chg);
 	if (ret)
 		return ret;

-- 
2.45.2


