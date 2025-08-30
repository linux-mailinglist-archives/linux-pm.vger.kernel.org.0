Return-Path: <linux-pm+bounces-33471-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6342CB3CF4A
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 22:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B10A1B242A2
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 20:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0901FE44A;
	Sat, 30 Aug 2025 20:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIocmTUT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A47B2AE77;
	Sat, 30 Aug 2025 20:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756586728; cv=none; b=rR/zUMnLHBFM1g/SJFh00/jG5TG4A8mJ4OvwXOIo8Qzi2DJwr6IloVwjQyOfi1bI+dkKKbHp49nZSANWJFi+lXoNLIsY8U//17uRoKdFIA/vlWEtuqfnK1A3a/HFsQTivT4vUv62XdoBpVxbLWhQ1v8o/OlP6QbdURXNoQIs+yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756586728; c=relaxed/simple;
	bh=0oqeEqIjS3+OtMIvtyosNybEOk1gpo3FJfz9EF2M1t0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E46FSxe3yBbsZHk1bgLVeeF0Q4fkg/me/MOM+MdLT+XBEHhObUKn1b/nbe3RRAGo4Vu7mTvzdjUzYCxnmRYjFxNK6Is3V0kq9pMe12U+cEudWSDnnVeu9ZhRYXB+n5cgAlZuDClFsR+7F5t87wt6mxI3HJXPWA7W13eHTQ2hYco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIocmTUT; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6188b6f7f15so3452992a12.2;
        Sat, 30 Aug 2025 13:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756586725; x=1757191525; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+OT8QGzf3PZ88uIRwWvPBWTj8UBsZ2B/sy/goy6AP/4=;
        b=eIocmTUT8ZkbRQySKlBmMkwsrQ9NFJF4siEAHv4lwEUva323ojtwotMHDCGGSZ1EW7
         Ra2wGBFNw7TXupcZF/CBvELH2LOIYzHGbMZYOf6YcngaktUJkeHZqKRAufGeyrt+bJdN
         nU3t6lv527X1z9NRC/KVN8nzStZjqYS4BmY35GtkZpw9Z8D8DaJ+weKbVuTZGIkhkie7
         CSWlrN3fXSj//TNXFAUUuUI0OopdyRS+2C1e+pP4Rc8Y9BmiPfVMZI8p0jp07BVe1h9w
         QmzZnIslVwXlZJM6M9dIeM6b/eHTHFM0weMfiReO280TDnfcHKVE2oQTNC+HGDBdJZnD
         ziZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756586725; x=1757191525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OT8QGzf3PZ88uIRwWvPBWTj8UBsZ2B/sy/goy6AP/4=;
        b=DaxQnxUkLBTYM6VwKE5EFWeYNjn6jPyiEoNs4lkszOUY7oc6VB18iNfKH/9Vf5f254
         1sEMZTfpyhoWUS3l6M36B7XriBZ7M5u/S/KXISvLe99m9EiKF3RlFQNF2ou4hpvThlWX
         rP6P0Wz8zUxqHgPu1QVECVLHQZQxdKnwmenYqs9PZvvvPVMfC44bMjlYP9MZWxjW01uV
         eaOgPPNO1a27+QM5mawgBd+08o0cBBKylAETND2XQezVbjgsJt1ZZv+A2+YceJxfuMer
         9QwBQC0cHprgodvvwMjx9mYjJrIZRxeI13Td1Xq80+8O5gXqknQrvQ7gTnVr0fCTfIRw
         En2A==
X-Forwarded-Encrypted: i=1; AJvYcCWzSudB2Pnu5iYK6WjFNov/rYAq+AW7MU5YN/k4EvoVJpNd85NZNyhSNW8/0i2yaYaI+kgshWZZBZE=@vger.kernel.org, AJvYcCXg308B4KC+jhvSY+3MEj8i9Kge0sZNpCf/SQxHyWRhyscGRjWqN6NyAvwj/1+vg7I2JskIBba1k/AjwLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIS8ukr3N0WR19v57xucY0FlDBHuj7MvfmoEBw9sT1Xz24346i
	GAwEIMMD/BA2bwEPuMawyD+qP5ZfOxUx+OxIcFu42gSsM65IFIB6iBAa
X-Gm-Gg: ASbGncsRXLT24cSPvNoEXww5Wy41dqqOcvyDm973IXcjnnrU/3XjsAF6BTsVnUtFcaP
	CqTKqQKOV06fnI/zlH6jWwB+/NkDthV899RYYh93JnB3sl2OEjXqgi0ydPYpVXBMpnHGimsLRed
	O3+nmOUrrSPHuYFOGiTeYE77o/WPzeEGyYFHq/DQ4bt4Q7uzJhB2maN8ryTmZ093kvc1+syjf3S
	8b9DR7iGYCUDJBr1JlcXCFKzf/LqYM1Hhw+768mrLBWf6uLO5wIlqf67POP03FQBCYM9n+VLMbV
	gGH+5JFybUMPLJKM3havINJ0rtcDAtF9rR2V3wp7KAmOy1T2kcUFo8+g6qR/jXdat9Oz5nbaFwt
	C3cCX0fDj0wAt+tVAqMzPT2UssdmX+4c=
X-Google-Smtp-Source: AGHT+IHAqv/GT7/pawlzbjWrE+HOablGq165Qzr6HPOo3iQMAThPKQPpNlXpi7UmzyKa4WqP6rVgaQ==
X-Received: by 2002:a05:6402:5cb:b0:61a:1a57:31a with SMTP id 4fb4d7f45d1cf-61d2689316cmr2269651a12.14.1756586724504;
        Sat, 30 Aug 2025 13:45:24 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc52ade4sm4066630a12.45.2025.08.30.13.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 13:45:24 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Sat, 30 Aug 2025 23:45:14 +0300
Subject: [PATCH 1/9] power: supply: max77705_charger: move active discharge
 setting to mfd parent
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-max77705_77976_charger_improvement-v1-1-e976db3fd432@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756586721; l=1767;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=0oqeEqIjS3+OtMIvtyosNybEOk1gpo3FJfz9EF2M1t0=;
 b=56US90twcnleZmymZxonRD5YfMUAoFqPRf2D5R9IUSCwqV/29oO2NNVViutmNK/bRgHdQNDlc
 adHUabLC/NdDjZsTOCYMxBLiTYdPdwODfjGdryg8Oc+cMitwlzMHodL
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Active discharge setting is a part of MFD top level i2c device, hence
cannot be controlled by charger. Writing to MAX77705_PMIC_REG_MAINCTRL1
register from charger driver is a mistake.

Move active discharge setting to MFD parent driver.

Fixes: a6a494c8e3ce ("power: supply: max77705: Add charger driver for Maxim 77705")

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
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
index 329b430d0e50..3b75c82b9b9e 100644
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


