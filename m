Return-Path: <linux-pm+bounces-33476-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B45B3CF53
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 22:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C53B2041C3
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 20:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452262E8886;
	Sat, 30 Aug 2025 20:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOn55qsC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BCF2AE77;
	Sat, 30 Aug 2025 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756586733; cv=none; b=MPA/xlxYZeW4iKSNrK28oiDW3Vpwslne1j1hi2Wwo485vtemb1rDE5EmBpNOd3H54gdeHfHiOFW46Y7UQWggtGf/SQHmDGjGKtcJyJBlO8q+9S2DcpPmLxZif0bt23+32IA7TSwHndLbba+qSISV/uu6jIP3VzxGo+d5ddxO//s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756586733; c=relaxed/simple;
	bh=4dm9H6pyN/TKQPdas0ArDRI6cymWMVAe+RQOCBAJh38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bdsgUyMWF9uyW7vX7HihgwulR4lSUDWWfOM68AgV5jXzz5XjAhoyVkZO0BAAbOdHPbQsv1n3sUlYfOJoSlNll1f8ncYpA8S05RrfJ8/cRFAWVvHaERvoCzK35gKDxqgwe0N/BULgWY0+I9ou7JYUItLzD0WCJN8tRxz8JKohcVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOn55qsC; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso5456378a12.0;
        Sat, 30 Aug 2025 13:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756586730; x=1757191530; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Db6AT8kHn31VXiGQka5XN8BI1pokFRZDewTGHxSayoo=;
        b=OOn55qsCDeOzqn5U2ZxklPfcHHFgIABtuaKNVUtQDOljXl5vs4aiLAvj4sCie8f/ui
         L6pPdjvd0gVB5UwQddg7ePZtYG8ayNiLfAc44uRKjh/mFvmkyIPcmOtmRqvkWOtdnSTW
         mpDnA8nlZ3bOGQxm/AWQRoe4klFDcwPV1X8nem6ySN7VV9pJ6XhV6vOwRLRl4Js888FS
         zmCaiqqMsdvSytNdmpdpiw3EOlVC0McJZjrYYfANqQK1cwAq9lJIOYoICdbaF6hdI0CG
         Ru7KN5d9rg9BSSBTCd/wqI4ZIfOZq5jrOqEGysM/xPnmHQH5fiuSgwEGJrDe2Zn9F55o
         zoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756586730; x=1757191530;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Db6AT8kHn31VXiGQka5XN8BI1pokFRZDewTGHxSayoo=;
        b=WkD/dJ+CL9L1QrzkPnyHAnY/QYanKrhQNUK0nyzoF2fFcp9gW32PaXVcrAX4TGN69I
         8d9Vs76sBZlTSg4Y0LZyZTGKZRrk67c8qjNdbUJxhiq1GQTePl3aiSz4nlVcAiTjOQfE
         IVO9TDycR7wRlrJ47yvImbzMcutLGcwKmrLbkzZcZgbQxzcap6ayfCzk6E9FQxR5lqPH
         /B0HzNH4YDk9Hyqqyqda0HdOzxauBY45RINAiMspqRfQwM7S8ZEcqP3NahKTfCTEzvxt
         FVjp9g8frTwMi3fRZD10Sy78jcjjxrnDHDdutJ+gaeTYXsQuDj0z5w2oyG4hm2rA/0ct
         CMrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHRkQOtTf6/kG7ZPj1f9SDJooSUSinY0nfvqte4JvqS6U0lpUE+pqd2/Xu1XLaPd6OvX2952gipv0=@vger.kernel.org, AJvYcCUnvEvhnKz9sUEeecVg2+OTBs8nCfNH+pBHLxYGs4n7aDESIazeaLEc4X6pLriJut7nwOUv4QlTaaeyXhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOgVBQDnF/xuWjT+lPfvZglVR2BWiK6SjSkG4Ge6lTgzPFhT58
	3KMa0+8MfoDR/EImSNHirOtGtGXtSoPQy3LHF5eYSHBFIJvLt/6sAl7o
X-Gm-Gg: ASbGnct+uS+vPe2hcvQEvn3LEsOh1YRznH9/i4XkOhu7jRdsY+A0byvDQGRqyfw865f
	M4AjtKxYqHkEK/n345ernwgkZExE1Qo4L8a+dS5Oj9a2q61nM6RyA+b7aL9jpHKjQwNnz25wmx9
	grSaoDVDnVsaW4VH7zjXHFFjmd5CzJQzSy9ol/ByDtvzohxU34W1srJRv1Y7Oznm8pXedHvFSIq
	Vci0f2RyTm58jJ0qjQwv1VPzUAqRbD9+h7yFXZtb39Lxzsiud+pndSxOpzh4QXw/HRXbTN+G3jb
	eW9JtvUA+GKDkqXK4lrNAAfhxDSeyGTvxpTa5C2uzpsev9UTndjjOIITSQfRT+Wo7wBnYYbllbZ
	W8VUCQBhsANg7RZ5gfPtE
X-Google-Smtp-Source: AGHT+IE2v0gpK7tYc4MLx8KmlAoqHHLHkCA7poMV7nlhWn8iTJW89x2UyI8Y/kXXSZTK4P3VSO5YAA==
X-Received: by 2002:a05:6402:e83:b0:61c:c02a:a018 with SMTP id 4fb4d7f45d1cf-61d26ec8f52mr2512057a12.32.1756586729611;
        Sat, 30 Aug 2025 13:45:29 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc52ade4sm4066630a12.45.2025.08.30.13.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 13:45:29 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Sat, 30 Aug 2025 23:45:18 +0300
Subject: [PATCH 5/9] power: supply: max77705_charger: add writable
 properties
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-max77705_77976_charger_improvement-v1-5-e976db3fd432@gmail.com>
References: <20250830-max77705_77976_charger_improvement-v1-0-e976db3fd432@gmail.com>
In-Reply-To: <20250830-max77705_77976_charger_improvement-v1-0-e976db3fd432@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756586721; l=2821;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=4dm9H6pyN/TKQPdas0ArDRI6cymWMVAe+RQOCBAJh38=;
 b=1SaX/LfBcEA0vkaDhn5flydfeik1qno+rdwPugoIrmJ5kVBgMJfZKY8DH/6TmGoNrezXf9puk
 bVkez8yL2l8DiutO7ovdsbMB4oQETEohUQHQPZkfWlLLmZmVmYULryR
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add INPUT_CURRENT_LIMIT, CONSTANT_CHARGE_CURRENT properties as writeable
to be able to control input power consumption and charging speed.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/power/supply/max77705_charger.c | 54 +++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index 1cd122e96953..de2184327ff8 100644
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
+	struct max77705_charger_data *charger = power_supply_get_drvdata(psy);
+	int err = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		err = max77705_set_integer(charger, MAX77705_CHG_CC_LIM,
+					   MAX77705_CURRENT_CHGIN_MIN,
+					   MAX77705_CURRENT_CHGIN_MAX,
+					   MAX77705_CURRENT_CHG_STEP,
+					   val->intval);
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		err = max77705_set_integer(charger, MAX77705_CHG_CHGIN_LIM,
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


