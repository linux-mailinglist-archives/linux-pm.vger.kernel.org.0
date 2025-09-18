Return-Path: <linux-pm+bounces-34984-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BA5B86276
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 19:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EED9A7A3915
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 17:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B635E3195F5;
	Thu, 18 Sep 2025 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXkpIgGe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B76F2F7ADC
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215219; cv=none; b=JXCx9hxATzENG/TdU2WwdSJrOrNRD97WtECgA0hoDIpcZUFRRmTXT4HjGc4t1iRvVJdFoSDmNo52wXh4EL23z7EAE51DQX9koErLGI6iYy5uXRJ+SF9R3PgiwiDDf2rkRK5GDfoMgFx9Nbuwisppkk5c1nceWfnMG4XzCjzop8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215219; c=relaxed/simple;
	bh=rM2VMTtuLx1OO1I64a08oL67vd4wqDtZKMaT66QU+PI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eQiPtaeDZXH0LPB2usjRu3U7U+do8nATG2wVw31lNAYh8eAQP8ZoQVOzvDBaCX3VdUKyMIZxibUa22ZbsjALgGFs0YjnEVIl8Shl1e+lQhorr3gKnom0eVLzMWksYiPCligvIh9VNB1zC5PMxDS+/xdKCQul7tduBtTS6s0Bqbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXkpIgGe; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b042cc3954fso237262066b.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 10:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758215216; x=1758820016; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXZgdW7hQ554+RKU1mAft1z+jxi0i6oZRz2REy9LKZ4=;
        b=SXkpIgGeYGVdsymu5G9k+Zrg6FA5Pe63uSI5mXm+RjjrcshKUz6Y0gSz43mb4gDNDG
         wfpPLF1ycAKKZIb5aUm8NTwRO7iEJeCvM8g9iSDF56yVDiBpTdGNw98D4JPHI38Z5JkG
         8iWlL8ZffcgjVKeMsOIer31EJCgDNwEy7QBbnJcMNL/y4lJPlbleWdqlZQwM5D3zi9o+
         5iJYYBmJ1YeJ3v2rt6i35QxvLQ53eN5miElhZdkqUVEBEKZBthThY29cPjCGnPv2cv87
         3Xq5MrrO8JntjR7YM/TpSqR63xKWXq8qTRRSDlg5rCxCDbRfOd4d+kktbhvF80svPnYl
         UaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758215216; x=1758820016;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXZgdW7hQ554+RKU1mAft1z+jxi0i6oZRz2REy9LKZ4=;
        b=k3ec5yQ3bGPwqpCUmrDdqBotkU3eiMo4zjItMJb9i0JucV9PwRv1LdnFgOUpqPYm6e
         B9fn+hOW81ZBlkk80vEecQBXHyqDDu/3KsVmS2For3/AebAalv83f36F8okKF7B+KDh7
         wIdDiPMNhSYQI1CZZtqDp9n4C9g62KPRXFLFZ7EwLMikb6hGi+cdLq14nWii9ZVZewSG
         A/lXvj42+7cf1h1YibjTEXnJ6YFyyteKZEuR2eWRuLynEcj9NlFhr1f/WtEOACRFlCHc
         cmuwbTQBQZTwgzyvAIYnW2gSvwzW/jqMc/ayEcWupv6HsZECyPloXsZVzqj+FZO4rn+G
         bcDA==
X-Forwarded-Encrypted: i=1; AJvYcCWU9izKdIMyaL7WBFpd7xS1iVzdoAb2rggSys/IBGDsWbLIpv/wd/D55ywP24397zdoQ3k+vteoCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIk2T2Z8mBkI+a3KjJgvOOAZYcLNbCsM1g8b9PaeADM55kNHWI
	e7b1AdvkthBQ5taDDPRh6xqVvHb8XAIWGr0pfEhJMNR5ZFsbcqYmBT7MEnOi2w==
X-Gm-Gg: ASbGncuHgM3s4oSmwDlJrBGkgMGA429lcJucNHRZn1HrO31Z5vwS3xTW8VY2zP6kOcN
	7wTNRAAXqcKwK/0bysX6Cy/RrM7t3qVg2Frenn2qkTVBvujiVJ3gQqrZuXdR3boAcVnYatq9j24
	jrUZHZLYMM5ctukA6HeKvKXKKEgy6pVQXpFWlK6isfCLZhD4g5yDE4lPFv3ob8yGLZjyYpBc+Ek
	DpF1e38RD6ROA7S1QLeqLNdzjUpyIT4VWTASHMa6omTrBZuA9rZ38N8+UF1mpPTl4R+B9tRsxwz
	yMqm82abgcqG+nGllzIhTacAaPqhmy69x3NQSKFVF+TDzIvNykmM180rBQnaehuBTxCt5N0oq4v
	U8giVdV+w9dFcCBbP5SECiHOqWDPqRfof5xR+0aU=
X-Google-Smtp-Source: AGHT+IHrbzoMMur97LcHmJe0+ZRAgMCELVdzpEsjqR7ceMXQb2WtpqZ350/W8AW36R2xjU50raoeRg==
X-Received: by 2002:a17:907:6ea9:b0:b17:ec4a:4f2f with SMTP id a640c23a62f3a-b1bb2261b11mr840490366b.27.1758215215744;
        Thu, 18 Sep 2025 10:06:55 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b1fd271f895sm225845366b.97.2025.09.18.10.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 10:06:55 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 18 Sep 2025 20:06:50 +0300
Subject: [PATCH v4 6/9] power: supply: max77705_charger: add writable
 properties
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-max77705_77976_charger_improvement-v4-6-11ec9188f489@gmail.com>
References: <20250918-max77705_77976_charger_improvement-v4-0-11ec9188f489@gmail.com>
In-Reply-To: <20250918-max77705_77976_charger_improvement-v4-0-11ec9188f489@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758215207; l=2911;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=rM2VMTtuLx1OO1I64a08oL67vd4wqDtZKMaT66QU+PI=;
 b=pB9WMpdk3DeUxhkHdOrXbuBcKcWjrHr/CcSt/zb6DWEH/wn3J1q4vYzXDuMEP93pitkPR2Qrv
 ytEDfuoqn2pAB4PC8v0IBR4iL63Z7thpOMWpeer6kpK1QR3q1WZ0hh6
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add INPUT_CURRENT_LIMIT, CONSTANT_CHARGE_CURRENT properties as writeable
to be able to control input power consumption and charging speed.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v4:
- use 'chg' var name for driver private data, like in the rest of the
  driver
---
 drivers/power/supply/max77705_charger.c | 54 +++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index 23c643a307bd..3062411dcb45 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -105,6 +105,17 @@ static int max77705_get_online(struct regmap *regmap, int *val)
 	return 0;
 }
 
+static int max77705_set_integer(struct max77705_charger_data *chg, enum max77705_field_idx fidx,
+				unsigned int clamp_min, unsigned int clamp_max,
+				unsigned int div, int val)
+{
+	unsigned int regval;
+
+	regval = clamp_val(val, clamp_min, clamp_max) / div;
+
+	return regmap_field_write(chg->rfield[fidx], regval);
+}
+
 static int max77705_check_battery(struct max77705_charger_data *chg, int *val)
 {
 	unsigned int reg_data;
@@ -384,12 +395,55 @@ static int max77705_chg_get_property(struct power_supply *psy,
 	return 0;
 }
 
+static int max77705_set_property(struct power_supply *psy,
+				 enum power_supply_property psp,
+				 const union power_supply_propval *val)
+{
+	struct max77705_charger_data *chg = power_supply_get_drvdata(psy);
+	int err = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		err = max77705_set_integer(chg, MAX77705_CHG_CC_LIM,
+					   MAX77705_CURRENT_CHGIN_MIN,
+					   MAX77705_CURRENT_CHGIN_MAX,
+					   MAX77705_CURRENT_CHG_STEP,
+					   val->intval);
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		err = max77705_set_integer(chg, MAX77705_CHG_CHGIN_LIM,
+					   MAX77705_CURRENT_CHGIN_MIN,
+					   MAX77705_CURRENT_CHGIN_MAX,
+					   MAX77705_CURRENT_CHGIN_STEP,
+					   val->intval);
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	return err;
+};
+
+static int max77705_property_is_writeable(struct power_supply *psy,
+					  enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static const struct power_supply_desc max77705_charger_psy_desc = {
 	.name = "max77705-charger",
 	.type		= POWER_SUPPLY_TYPE_USB,
 	.properties = max77705_charger_props,
+	.property_is_writeable	= max77705_property_is_writeable,
 	.num_properties = ARRAY_SIZE(max77705_charger_props),
 	.get_property = max77705_chg_get_property,
+	.set_property		= max77705_set_property,
 };
 
 static void max77705_chgin_isr_work(struct work_struct *work)

-- 
2.39.5


