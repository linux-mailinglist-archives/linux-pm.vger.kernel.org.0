Return-Path: <linux-pm+bounces-34980-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E493B8626A
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 19:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217B65602AC
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 17:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031B3315D5D;
	Thu, 18 Sep 2025 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVUyHkgD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD032F7ADC
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215214; cv=none; b=nBCpY9YU16AxJCqKdhH0nwF2zs4A8UlaMAtexb3O+DNNoyClhPlmYnHJTzRntfUXC55M3iuqJaa+TwarbgLIgj4AFvxSE/4DcxIAyva6/0xbY8rXl3nEgpRgeC7xyQYgQoZbne1jagu0CfgoIN/dU1geIdfF2FrFCaISYsgyhK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215214; c=relaxed/simple;
	bh=ud3n6D1ohJwT1gs/SFf/aPQf961smhUDzNFZvPxvybE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=giq5O1whf0Eriwu0BW5DyM9eSHv9tZyVDOr7zRw+kt2uUdI/sAi0yNzY/y8HwDYNeBhuoPhckoFDFfhTsS63m0MAZOUYSL29W1kUYq5LWFOpwEJnqvNXD/P6RxlS5hYx+qyR0qUFkZzUjMuS52sVsAO++n3iBVZoZSVppL/8LQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVUyHkgD; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b07c2908f3eso189136266b.1
        for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 10:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758215211; x=1758820011; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fWsr8e6vH5fTx87zU6KQFrQxbge8SZ8hqdc98Y5sKN8=;
        b=SVUyHkgDWrqeqGGKODHFjA3Mo4WTAT+aR0DQu2P9//8WWpMY1QBEQV1r/tEfdcskEs
         Ok12q8+mW7UQZ33R+jODIC1HlGbQ8+3ync8P7BjnLMHf0F0Eu8Zr20qxlETEEraDo/l+
         RC3Z4JCovMxSYMerxGwdh0KfJJ5c6oPw+88tjaTJhZPN0yXneKCZMUYkIzi0CNBAwVK7
         TTziVP9b8RHnPPiknkwtDLcf8cLoc1t/6fQjHvcFYUPCkZ89zX5qocND969n1K+Wjj53
         T1H9Ucjrj8aZCPxKv9WPbZuyCUDWWvX0VmbBWMsl7Gkn0O8SPf4DnFTTn1S3RsPhhqCX
         Pq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758215211; x=1758820011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWsr8e6vH5fTx87zU6KQFrQxbge8SZ8hqdc98Y5sKN8=;
        b=HGG/+ac10TZw8cJOb7t3hFlW/cIHN/5icdNnJLhjc0cg+znZPFHkOn9Cmtd54eFR6j
         LlC4AgyDRkRQQY/smqVARzpv3uG1NtxrILK9ZM7dct6PVKYprhOSQUmYDrDWKxGytbrm
         Gkg8AA7sXf8W4GGfZw4E5+E4xSq3TR0RLXHCJ7jk4dmSAGAsa/UFSGxRV0f8TDrQG4Z7
         X7hJjnWaG4HVJfiBE1aaZCEfXuqwoqdmpyuIC7YuA/pr4Dk9xrc07r295QpUkNCnBiYm
         aV/Q+1c340t4JTXKVbszhyc5jRFNvGDHxtKTPCbh34ZhlEClKE/LMSwXvEdf3Y56rut3
         50UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzjWAObZOxdJbA2Pm8ZrVK3ZSd/85yTQllH6zCJQltcGvMSQPtEb3Zl4SnQTLAWmyQd+LXfDdUwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPoOasPG7tImzT61mOTQkzzOUA0rBWmCHMwZuuKI0Sty3gLKhB
	XMW9DsNleMshWxwdrFeFlIqB7hLbgqMmeWmXxsyg39Drlzunlmgj0gwc
X-Gm-Gg: ASbGncucxKygoQ3HXt8PJ23RJAoszDznysRyUNQYcxYWaYVkEez2+WJ3d0A1ohGIoHq
	10FiuVhDhpolo/938Tk3puXAH6rA28AMo1YgI3lrdsRp2QG/BISdFm6X2fZEU3OtTJ4zJ5fvyRl
	4G0zeM/tECohpB03bD04tq8X+ipmSMVyN0ikKWs2QugZcwjFDs2uZQJ9hKKdXojgcLj0KouHK09
	MgSTToHr+Ylvq8oU3vru3Lv6P81yvezXh/BjGUMjnvyhNwgwJDzd7NLG18WFSfKGzMt22ucuyjj
	4D0R3bnpN9sctK62VyjU/iJeno7/FvSYJLmMGvoGSD1JKrBZ5JkiAAohvQuLvNZ8wYYTc8/YvGi
	5oLx5eCq0UEDC2BYNw3CyLzZ3bChjLS0X6EJcvQo=
X-Google-Smtp-Source: AGHT+IFO7H/oRfjej8T/40hL+S0Y+BHvYcFJrb/QGkPp33/o3RN4Yit5ipR+4qxch1bmEHnpcoSsKw==
X-Received: by 2002:a17:906:6a1e:b0:afe:ffb6:bfaf with SMTP id a640c23a62f3a-b1bb50c4058mr788419966b.3.1758215211237;
        Thu, 18 Sep 2025 10:06:51 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b1fd271f895sm225845366b.97.2025.09.18.10.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 10:06:50 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 18 Sep 2025 20:06:46 +0300
Subject: [PATCH v4 2/9] mfd: max77705: max77705_charger: move active
 discharge setting to mfd parent
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-max77705_77976_charger_improvement-v4-2-11ec9188f489@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758215207; l=1975;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=ud3n6D1ohJwT1gs/SFf/aPQf961smhUDzNFZvPxvybE=;
 b=xypHKca0j5M1syTuCeKPcjcuJZoX++iQSgCUF6/BcZw/D1MOYGtqeSQwA84yTFR2PQXqNZ7Eo
 q96B/Xz4Zg2AvK3XUE+S1xsKrR7DOO/5fw4tZ8H5AOjjyKUjVv1+Piq
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Active discharge setting is a part of MFD top level i2c device, hence
cannot be controlled by charger. Writing to MAX77705_PMIC_REG_MAINCTRL1
register from charger driver is a mistake.

Move active discharge setting to MFD parent driver.

Fixes: a6a494c8e3ce ("power: supply: max77705: Add charger driver for Maxim 77705")
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
Acked-by: Lee Jones <lee@kernel.org>
---
Changes in v4:
- commit msg: remove blank line between tags
- commit msg: change prefix in summary to mfd: max77705
- add Acked-by: Lee Jones <lee@kernel.org> tag
---
 drivers/mfd/max77705.c                  | 3 +++
 drivers/power/supply/max77705_charger.c | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/max77705.c b/drivers/mfd/max77705.c
index 6b263bacb8c2..ff07d0e0d5f8 100644
--- a/drivers/mfd/max77705.c
+++ b/drivers/mfd/max77705.c
@@ -108,6 +108,9 @@ static int max77705_i2c_probe(struct i2c_client *i2c)
 	if (pmic_rev != MAX77705_PASS3)
 		return dev_err_probe(dev, -ENODEV, "Rev.0x%x is not tested\n", pmic_rev);
 
+	/* Active Discharge Enable */
+	regmap_update_bits(max77705->regmap, MAX77705_PMIC_REG_MAINCTRL1, 1, 1);
+
 	ret = devm_regmap_add_irq_chip(dev, max77705->regmap,
 					i2c->irq,
 					IRQF_ONESHOT | IRQF_SHARED, 0,
diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index 59090703cc7a..b8f648dd4d63 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -487,9 +487,6 @@ static void max77705_charger_initialize(struct max77705_charger_data *chg)
 	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_00,
 				MAX77705_WDTEN_MASK, 0);
 
-	/* Active Discharge Enable */
-	regmap_update_bits(regmap, MAX77705_PMIC_REG_MAINCTRL1, 1, 1);
-
 	/* VBYPSET=5.0V */
 	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_11, MAX77705_VBYPSET_MASK, 0);
 

-- 
2.39.5


