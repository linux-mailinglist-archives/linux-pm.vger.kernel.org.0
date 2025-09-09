Return-Path: <linux-pm+bounces-34292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0762AB50538
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 20:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567F85E6D5C
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 18:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9F335CECA;
	Tue,  9 Sep 2025 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNTCGVf+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C932FB606;
	Tue,  9 Sep 2025 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442577; cv=none; b=rymlQbJWtGb0tuDJcRM1OgmYWHFJKzgxARTrN0P3B/yN3kmOHiowA6TPXozOdgZfOLE+clN1jRXu64E7z2sKFS4P+1dxRDF930dK1/cGc09T3KYHl+vRlWd4QDAxQw+iUKHEIaiIznk+/J5rymWKVy5jWHCUmK6Ym+E4nfdGO9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442577; c=relaxed/simple;
	bh=0oqeEqIjS3+OtMIvtyosNybEOk1gpo3FJfz9EF2M1t0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q+AYRL7rjOJA2edpdzbmkMlM0SA9+RK6bxnCE7/EXyE/2gBu6CrlxUxKAPgHP9b8yaHvCRHmEPVrwmg8wdv6rer0TWvfXF0C0E802M7dY4bklyvD45X6o9RsEWntJKs5D5Y8JxCCPfq/c69BZftuERlDE8gUChRLU9bcDFXZIyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNTCGVf+; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b04163fe08dso1013457566b.3;
        Tue, 09 Sep 2025 11:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757442574; x=1758047374; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+OT8QGzf3PZ88uIRwWvPBWTj8UBsZ2B/sy/goy6AP/4=;
        b=aNTCGVf+nQTo+8gdRS8fFsnygx1s9OI7p8jJAXioJoCwlypYq2MIXKmPI/3QUgR95V
         FuwMyZ3iiJnGssAfCWD7+zOSsWKNtMkjMgI6ZdahSRoZWiMf6AQWBJ83phKoc/bBIBiN
         N7+0Arsb7bELUoZ/4x8HoRlK65c1/Wq/qCvbD+r7W40/74eaKQYn8WsyM8EupvZQnXWF
         u/k3zj0LBvJuq+fPRxwNwtQEPL1bNCwefW7EDZJa7Xk6X6YtYUNoHJDe72JHM+KEVUkC
         NOf8gUWETpHMbnWXW9UgSwGIlo7+BMnAphZ66suNYusECP8Ij5ADyKCmywY4yKIbHsI7
         uveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757442574; x=1758047374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OT8QGzf3PZ88uIRwWvPBWTj8UBsZ2B/sy/goy6AP/4=;
        b=tJzBVwk/AXxFHsE1JL5m2Kkz5haDLVyk59lpyI9Uldpbm2JJuK+i2YWHw3ZPZ799fe
         +U7cijyBp7pre5MUQVMNfUsQ1YQjgrVW2KQgRPcNqQsDgfVYs17afWtIziDttjRUVxvq
         hbzqPmsJZkvmechCo8XVL7yFpeBK1i54DdLFUAd3yT8tXuROS5XZqfPm3IMGTrz5XjcN
         vXPp2vU+eOqMqql5fd8Td+xSkKNOjdygqDJA1KlrTkmlVZuFCG8rlgrwfoPH821dCvVd
         W8l9qB7kegKvzMnc9kHou6zLlEmDkqd9QE/QQCrPVnCdKxs2TbtehoO5D+0xRV+gr6rM
         MNdA==
X-Forwarded-Encrypted: i=1; AJvYcCUXLthND9un/QvMKYNHxccJtALoasyEYQ2/mDmSH4rkakYiVTGfuU8gUkg8Ibk7I+a6jn3+mGVkxpeLYqQ=@vger.kernel.org, AJvYcCUmqnkLC/bWEpqz4gG3mbOn9K8h62Nb9ZvJyI/U9pKSVBQSDKDf+pMh4ih6D4Tgax5YeJMZqDtCsBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzadWvtNE8jh7ciEH5rT1ysgbZOHfNFhV7qm9+2OIlbdthEwJdf
	0PeWdhDA4yK1xzUgf0XQs/WvEwfEWWUltHCBMGLTEWg5IBJrWB7EJhHo
X-Gm-Gg: ASbGncvQbQu8KZhK5cClHb4NYXLzWsFlLCalRSYrDPE/iJcjtP7BWiKmsUEqg1C4kXQ
	tspyPvp890aj9GApduZBVdmuGtgrOzVbb5wc4L/NoAg2YUZFfLog/r+rPfz071bh+h1YK/DwCGd
	vaJ9QG2hJatNpaEM7HTHy5iH/Foa+V4/Ee88AsQO6B1UorucNVROr3BR0tC0b1197zscVCdDCx4
	dsQflGUU0kfY/qfQbxp6AQOK0u3yjY6CIZT1dxEr3uNW8S918yTcZh+GqCDHsP4K1k7zzWEdC3c
	ldi789kSBi5plIDso9/Ub6pdm3zvk1EoBXgca+5HiQvtecf4MVV/saKGIvBjnc5xIEVsBtaaUDF
	A29de5hEq0WaM04cOOHtO
X-Google-Smtp-Source: AGHT+IFRAbRow4lOMs4Ehuu/UgINhiCSN+sh8cpsV2JCi+ta/AVq5sL3KfgFdHtUmVgPk0T3xQknfA==
X-Received: by 2002:a17:907:7e82:b0:afe:8f0b:6c64 with SMTP id a640c23a62f3a-b04b13c891bmr1288367366b.4.1757442573607;
        Tue, 09 Sep 2025 11:29:33 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b07833ebe61sm30520666b.89.2025.09.09.11.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:29:33 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 09 Sep 2025 21:29:11 +0300
Subject: [PATCH v2 1/9] power: supply: max77705_charger: move active
 discharge setting to mfd parent
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-max77705_77976_charger_improvement-v2-1-a8d2fba47159@gmail.com>
References: <20250909-max77705_77976_charger_improvement-v2-0-a8d2fba47159@gmail.com>
In-Reply-To: <20250909-max77705_77976_charger_improvement-v2-0-a8d2fba47159@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757442571; l=1767;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=0oqeEqIjS3+OtMIvtyosNybEOk1gpo3FJfz9EF2M1t0=;
 b=EphA8uU9TdYUxH1+TdcxyfqWePF4k1Thh0P/lJbWlek+viArct4J+NKPRN5Ey8QbNWrfBPLaF
 qSpHG4vTrIQCdO8CvWJ1kJBWfwFsqtrex+qRo64uoISYKeUtLaL2Dn4
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


