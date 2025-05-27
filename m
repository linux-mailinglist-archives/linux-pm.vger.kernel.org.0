Return-Path: <linux-pm+bounces-27696-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B4FAC5C7E
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 23:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7598B4A6E0E
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 21:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B9E215767;
	Tue, 27 May 2025 21:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qip/s355"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F003E214814;
	Tue, 27 May 2025 21:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748382794; cv=none; b=VaXCejLjrfbqAVaRn/AxPKXG2vQYCp1u9WqIYTEgWvnf9OP5O/kUNtVte49TkgCALJa1GfZzuGMuDiJcZ08VmoEqFNCDtkZoK8IVW6GnxKraueEAEd+CIFc3PgPyfYN1a1r+owJ43SLvuDbSy6mMMokVlOF1LLyGsKcoGmHzHck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748382794; c=relaxed/simple;
	bh=NFoge0TAAOxil832I375a1uGhWyZY9zmeg3YifnMATo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUbVuMXu4+ncPuYuUOzRfeIbp+y6SCej9UzourKpwUsMWaMY/clfetUJe5lZJMUtDqRh/SvNY+Gk2cLOeNchjVM9vQpu9wR4dh9tZ24hfarGPAGoFzVeYUU5Buvl2jTulgwRV9cTPbVX7DeldBtwqc4lE+cHSpIiuiV22nCVVrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qip/s355; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d0618746bso31650795e9.2;
        Tue, 27 May 2025 14:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748382789; x=1748987589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3KjsrRqkqh+4w7zYTnKXGm12Hu5UeqaTDd57FU942h0=;
        b=Qip/s355T8YW4P6VV5SW9B1+loTY1o3JvA8jh/039Wd719Eb1xWvITAt+AkNZXDxEd
         rEp8Ht85Y8O/stl5jKy8tvq1P5QA+0HOqDiVYlP1joAUP+921OJD3LuJU507rIDc90SE
         BHjM7AlDMkw34ansiyq7Q7LGLGxiWsdsaffgbm2eCJc5f33N4eSA+ZM5StfKE7t5YkQA
         elWZyxykY6wGM4YWe7OKJQTe4ca8fq+ZnJPwNnY3w7cUKYcXhG+J9uNEiK7uuPK1rLaP
         PsJsd+f6yOx2h2B5qm/28ajiphaozu1P1UfeMBL0DTPivALGibT+Y6YHib94NhTQLCxe
         BSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748382789; x=1748987589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KjsrRqkqh+4w7zYTnKXGm12Hu5UeqaTDd57FU942h0=;
        b=gU6nsgnSF8JtnOdM4fd5CNV6oTVh7NuDqUVWYmSciFL7EkxSyHIsmazly+a23LXDTC
         DCbWF7TZE2cw3nCjuI1Ea+NnKJvkHxz/Hfva3hyRcYVBiwNSfuPPIkBYacbNI5CJVgYk
         xCuii2M/K5N3qFjGGk5vdsi35aWiOPtCKiaWLJpwkZJ74ANOMKRiFFACjPRlYA6hlMNw
         yeyis9JOMcS/w1ZHyYEFVLu0MNDLEgkh5OTWzJcrAB8RgHw++EvfF4Z2TNqBvm9GLsyh
         IcogkU/RkEsRu2/1cR4Ao3eIeBNgmetwIJF/xfa8OJ9JjOQDha3wtvWNamGMwte/J7rj
         V6WA==
X-Forwarded-Encrypted: i=1; AJvYcCUXIMfJoP7xoWzhu4lbZUY1U5AhDP+3DJn5uDVLanfpvPYdvgiNUa3wSVnqU3f/HMXeBdtiHBLymZw8lyut@vger.kernel.org, AJvYcCVITq/KjwFC6AiekVsAqu9HJ5UvlSUNx5Dso5M1BTjAhfaz9N/XwQQo1TjFMNIYu1nia88V+VsOmOo=@vger.kernel.org, AJvYcCVYhecKOM7afFKJyCpaNl6PG77cz9Y3wxswJcgJ4kNEZerUJIlnYsfcP/JJZ/E9ckd1JpczSb5DCidE@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/v/dLNXzV7Sb7uwrsDJGU02SyGIgppJMKGW5hbmGqvs6JvPLh
	DppwZN+2gc6tYQMlZYDyzS2FcDAAewInvdM6LAl20l1l8R2WFLa7mPvD
X-Gm-Gg: ASbGncs0CkNVvc90YN7plGQrVl17/x22OOwSueeiUrwEOo7zyJK/1WYV/8MWUcpLYOW
	Gt3H3cBteP2RO9iI2AIvBGHbUTRNYR5vA7wEC1zOs0BViGu8QJ6gWGqXeEBcaijpJt4EedDV5Ec
	RR+kJHGXhoO6+Emo8IpRhGpWkaQWQAmtXzpznD4YaOA4bXbhoNF6JB0fwShYEjXJmOaD0ZQNa9C
	YFsF/z6a82CVM+gFZxaRKfB7Gib09JU5iTjtmJPgmFmBQqLLGH8eZN1xVogwp2qwhEqR7cMWQiq
	0XHvTgUvXoMn1tw5bJReqzIxX6zSWTU35AUvcX+hI1Mg3Ie4G+BUFpEynObY7AXBLug1U+6zPYv
	qv80XfsPihN3GRzfSMT7AuO8jpzSCYF8=
X-Google-Smtp-Source: AGHT+IH9rVnmfkUcHSNbUn8fV7xapZ6bFvwLY0rRLSokxz8DMe3pEERywRLtY4xhJGcv6ctBs7lJug==
X-Received: by 2002:a05:600c:5395:b0:43d:9d5:474d with SMTP id 5b1f17b1804b1-44c90a7d192mr136136705e9.0.1748382789005;
        Tue, 27 May 2025 14:53:09 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a4e8b8dcdasm206656f8f.11.2025.05.27.14.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 14:53:08 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] thermal: airoha: Convert to regmap API
Date: Tue, 27 May 2025 23:52:35 +0200
Message-ID: <20250527215241.25767-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250527215241.25767-1-ansuelsmth@gmail.com>
References: <20250527215241.25767-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In preparation for support of Airoha AN7583, convert the driver to
regmap API. This is needed as Airoha AN7583 will be based on syscon
regmap.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/thermal/airoha_thermal.c | 72 +++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index 9a7a702a17de..04bda890dbb1 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -194,7 +194,7 @@
 #define AIROHA_MAX_SAMPLES			6
 
 struct airoha_thermal_priv {
-	void __iomem *base;
+	struct regmap *map;
 	struct regmap *chip_scu;
 	struct resource scu_adc_res;
 
@@ -265,8 +265,8 @@ static int airoha_thermal_set_trips(struct thermal_zone_device *tz, int low,
 			       RAW_TO_TEMP(priv, FIELD_MAX(EN7581_DOUT_TADC_MASK)));
 
 		/* We offset the high temp of 1°C to trigger correct event */
-		writel(TEMP_TO_RAW(priv, high) >> 4,
-		       priv->base + EN7581_TEMPOFFSETH);
+		regmap_write(priv->map, EN7581_TEMPOFFSETH,
+			     TEMP_TO_RAW(priv, high) >> 4);
 
 		enable_monitor = true;
 	}
@@ -277,15 +277,15 @@ static int airoha_thermal_set_trips(struct thermal_zone_device *tz, int low,
 			      RAW_TO_TEMP(priv, FIELD_MAX(EN7581_DOUT_TADC_MASK)));
 
 		/* We offset the low temp of 1°C to trigger correct event */
-		writel(TEMP_TO_RAW(priv, low) >> 4,
-		       priv->base + EN7581_TEMPOFFSETL);
+		regmap_write(priv->map, EN7581_TEMPOFFSETL,
+			     TEMP_TO_RAW(priv, high) >> 4);
 
 		enable_monitor = true;
 	}
 
 	/* Enable sensor 0 monitor after trip are set */
 	if (enable_monitor)
-		writel(EN7581_SENSE0_EN, priv->base + EN7581_TEMPMONCTL0);
+		regmap_write(priv->map, EN7581_TEMPMONCTL0, EN7581_SENSE0_EN);
 
 	return 0;
 }
@@ -302,7 +302,7 @@ static irqreturn_t airoha_thermal_irq(int irq, void *data)
 	bool update = false;
 	u32 status;
 
-	status = readl(priv->base + EN7581_TEMPMONINTSTS);
+	regmap_read(priv->map, EN7581_TEMPMONINTSTS, &status);
 	switch (status & (EN7581_HOFSINTSTS0 | EN7581_LOFSINTSTS0)) {
 	case EN7581_HOFSINTSTS0:
 		event = THERMAL_TRIP_VIOLATED;
@@ -318,7 +318,7 @@ static irqreturn_t airoha_thermal_irq(int irq, void *data)
 	}
 
 	/* Reset Interrupt */
-	writel(status, priv->base + EN7581_TEMPMONINTSTS);
+	regmap_write(priv->map, EN7581_TEMPMONINTSTS, status);
 
 	if (update)
 		thermal_zone_device_update(priv->tz, event);
@@ -336,11 +336,11 @@ static void airoha_thermal_setup_adc_val(struct device *dev,
 	/* sleep 10 ms for ADC to enable */
 	usleep_range(10 * USEC_PER_MSEC, 11 * USEC_PER_MSEC);
 
-	efuse_calib_info = readl(priv->base + EN7581_EFUSE_TEMP_OFFSET_REG);
+	regmap_read(priv->map, EN7581_EFUSE_TEMP_OFFSET_REG, &efuse_calib_info);
 	if (efuse_calib_info) {
 		priv->default_offset = FIELD_GET(EN7581_EFUSE_TEMP_OFFSET, efuse_calib_info);
 		/* Different slope are applied if the sensor is used for CPU or for package */
-		cpu_sensor = readl(priv->base + EN7581_EFUSE_TEMP_CPU_SENSOR_REG);
+		regmap_read(priv->map, EN7581_EFUSE_TEMP_CPU_SENSOR_REG, &cpu_sensor);
 		if (cpu_sensor) {
 			priv->default_slope = EN7581_SLOPE_X100_DIO_DEFAULT;
 			priv->init_temp = EN7581_INIT_TEMP_FTK_X10;
@@ -359,8 +359,8 @@ static void airoha_thermal_setup_adc_val(struct device *dev,
 static void airoha_thermal_setup_monitor(struct airoha_thermal_priv *priv)
 {
 	/* Set measure mode */
-	writel(FIELD_PREP(EN7581_MSRCTL0, EN7581_MSRCTL_6SAMPLE_MAX_MIX_AVG4),
-	       priv->base + EN7581_TEMPMSRCTL0);
+	regmap_write(priv->map, EN7581_TEMPMSRCTL0,
+		     FIELD_PREP(EN7581_MSRCTL0, EN7581_MSRCTL_6SAMPLE_MAX_MIX_AVG4));
 
 	/*
 	 * Configure ADC valid reading addr
@@ -375,15 +375,15 @@ static void airoha_thermal_setup_monitor(struct airoha_thermal_priv *priv)
 	 * We set valid instead of volt as we don't enable valid/volt
 	 * split reading and AHB read valid addr in such case.
 	 */
-	writel(priv->scu_adc_res.start + EN7581_DOUT_TADC,
-	       priv->base + EN7581_TEMPADCVALIDADDR);
+	regmap_write(priv->map, EN7581_TEMPADCVALIDADDR,
+		     priv->scu_adc_res.start + EN7581_DOUT_TADC);
 
 	/*
 	 * Configure valid bit on a fake value of bit 16. The ADC outputs
 	 * max of 2 bytes for voltage.
 	 */
-	writel(FIELD_PREP(EN7581_ADV_RD_VALID_POS, 16),
-	       priv->base + EN7581_TEMPADCVALIDMASK);
+	regmap_write(priv->map, EN7581_TEMPADCVALIDMASK,
+		     FIELD_PREP(EN7581_ADV_RD_VALID_POS, 16));
 
 	/*
 	 * AHB supports max 12 bytes for ADC voltage. Shift the read
@@ -391,40 +391,52 @@ static void airoha_thermal_setup_monitor(struct airoha_thermal_priv *priv)
 	 * in the order of half a °C and is acceptable in the context
 	 * of triggering interrupt in critical condition.
 	 */
-	writel(FIELD_PREP(EN7581_ADC_VOLTAGE_SHIFT, 4),
-	       priv->base + EN7581_TEMPADCVOLTAGESHIFT);
+	regmap_write(priv->map, EN7581_TEMPADCVOLTAGESHIFT,
+		     FIELD_PREP(EN7581_ADC_VOLTAGE_SHIFT, 4));
 
 	/* BUS clock is 300MHz counting unit is 3 * 68.64 * 256 = 52.715us */
-	writel(FIELD_PREP(EN7581_PERIOD_UNIT, 3),
-	       priv->base + EN7581_TEMPMONCTL1);
+	regmap_write(priv->map, EN7581_TEMPMONCTL1,
+		     FIELD_PREP(EN7581_PERIOD_UNIT, 3));
 
 	/*
 	 * filt interval is 1 * 52.715us = 52.715us,
 	 * sen interval is 379 * 52.715us = 19.97ms
 	 */
-	writel(FIELD_PREP(EN7581_FILT_INTERVAL, 1) |
-	       FIELD_PREP(EN7581_FILT_INTERVAL, 379),
-	       priv->base + EN7581_TEMPMONCTL2);
+	regmap_write(priv->map, EN7581_TEMPMONCTL2,
+		     FIELD_PREP(EN7581_FILT_INTERVAL, 1) |
+		     FIELD_PREP(EN7581_FILT_INTERVAL, 379));
 
 	/* AHB poll is set to 146 * 68.64 = 10.02us */
-	writel(FIELD_PREP(EN7581_ADC_POLL_INTVL, 146),
-	       priv->base + EN7581_TEMPAHBPOLL);
+	regmap_write(priv->map, EN7581_TEMPAHBPOLL,
+		     FIELD_PREP(EN7581_ADC_POLL_INTVL, 146));
 }
 
+static const struct regmap_config airoha_thermal_regmap_config = {
+	.reg_bits		= 32,
+	.reg_stride		= 4,
+	.val_bits		= 32,
+};
+
 static int airoha_thermal_probe(struct platform_device *pdev)
 {
 	struct airoha_thermal_priv *priv;
 	struct device_node *chip_scu_np;
 	struct device *dev = &pdev->dev;
+	void __iomem *base;
 	int irq, ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	priv->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv->map = devm_regmap_init_mmio(dev, base,
+					  &airoha_thermal_regmap_config);
+	if (IS_ERR(priv->map))
+		return PTR_ERR(priv->map);
 
 	chip_scu_np = of_parse_phandle(dev->of_node, "airoha,chip-scu", 0);
 	if (!chip_scu_np)
@@ -462,8 +474,8 @@ static int airoha_thermal_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 
 	/* Enable LOW and HIGH interrupt */
-	writel(EN7581_HOFSINTEN0 | EN7581_LOFSINTEN0,
-	       priv->base + EN7581_TEMPMONINT);
+	regmap_write(priv->map, EN7581_TEMPMONINT,
+		     EN7581_HOFSINTEN0 | EN7581_LOFSINTEN0);
 
 	return 0;
 }
-- 
2.48.1


