Return-Path: <linux-pm+bounces-27605-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16435AC29BE
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 20:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3E03B83AC
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 18:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CFC29ACE3;
	Fri, 23 May 2025 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbqTBxIC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4942D296D10;
	Fri, 23 May 2025 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748025015; cv=none; b=Bbp0LB9PqR9WqS+ImqtXQ68HRvOk8IBHulJNmL3nDZh2Mcj8h7/Etg2YADWYjoYJaAPF2eq246EGY6Enkm0PfxK6gA+Lg9HIhHdRHj2CwWuF3tVvIBlVqTK41w0nLvQt0Vg/gL2f4eEbcS74vqibEjYmqM0WkH6cwM2knRfZX+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748025015; c=relaxed/simple;
	bh=NFoge0TAAOxil832I375a1uGhWyZY9zmeg3YifnMATo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYEf8WKPOttI8wm6QfG/THLBeewWHJl5cO04t9c7yefqAy3aElq5SpV3HNxMMY7nXCIeI28f+ayrgnk0k3V1KyGS8h74bbjFpoLCQPS2DswRCODmlr2rsSFh7dBSsaqd4DUSe0SyfLOD9G3idy8uVXG/vD94us9hMF9N9nVypLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbqTBxIC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-442ec3ce724so769915e9.0;
        Fri, 23 May 2025 11:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748025011; x=1748629811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3KjsrRqkqh+4w7zYTnKXGm12Hu5UeqaTDd57FU942h0=;
        b=WbqTBxICrv9SpJbwWC5En1bJxZE57+Sca+M5+FzbgnFptPFjnFoBHoPtKljRMXAoLc
         UeqpWtW5oZbC0GVBNCOnIytiFPyHoLMJB0cTUnQXWUX7jWgnpqfK/jofQ1vq26d+Vutt
         YLv2988Fa8MWrhefH39BSt9h+pkVEbe5KjTyW70E6MuwU+XOf7M27TOdDeXr+Ud9D/Kn
         5E9BxB17Wu6R/uUuucSGuy/QXaGi0HQtY2yFovWY+lpyA5e98aqMHCyArtEUYQn6yCCw
         tcn/9+HzkcC7KtpCcdka7l74wlb9oKbQSrge4rvvT3OVgv1sl6ITjAVGTNwr9uiy2qDK
         TN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748025011; x=1748629811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KjsrRqkqh+4w7zYTnKXGm12Hu5UeqaTDd57FU942h0=;
        b=vzUwrpyTXtkQ+V9hJksHRsg0NVFKDsIpO/Nq1CRdy77Pf5JmT2ZXua5Rm+Ps1d0d4Z
         yDsVpy+t2bzAWHM3hd9V/wHRSwoj3T1LCLaDATFGp2req4U0+st/I2HtvDj5GoFNAcsH
         wnTI96mQwoI4Eapt7RpAR2jMDA5h5F+UlAvFkWLQFnPeBFgLs62IRmzTxeI3fTR75Le7
         ANUmgMsIzpZ/amQDsD7zOSGh4p/6BTIFvvNvDNL0rgNq8coI9Krhj0p4U/mN38adtd7X
         jICDEDwU8cRUC7KdgZfaq5OgRiQh/c/ER4v5b9IUtslUSqNBvcDgirLGmWI6GiOsaHZv
         ITqg==
X-Forwarded-Encrypted: i=1; AJvYcCW+Gj+2n5mB4ATrPs8UmFZ1j952A4HHNPMIycg2Ay6nR+SPEBvKncW7luNkqxvuRK5YRp7yL1Va3cdErA9Q@vger.kernel.org, AJvYcCW/fdBkW9k2agBmYkTRJI8jmMo3+jk/Xxf1234aA9OiDPvFJv5jkhHIyD3eEqaK4+ESG1SZaNVd2ig=@vger.kernel.org, AJvYcCWDrj1iBGKaSRpWjJCzQU/045aHy5gOkKA4l2mDagWQD9MHOkZhFeZJ1cnscaZtep1VSxgWOkG+Yiki@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4zoD1uG2q7hPhqeiwaMZGjM1Tvw/EyVDOsr/ROOzLngcwdm4F
	ORw9BnFG+P58A0j22OOR26Unq9lyv5HZnA1OEHpQUCf+02C0BdhUNy83c0DvmA==
X-Gm-Gg: ASbGnctfufcIyCfgCnc4oLx8QB6EIqatMtf7E187mV2pHw8d2AVsZYjm5OLgq5BSq9v
	B42hMycZJPyG99Y9xnaV4cRxT+HH5SoE7dwUmDWLGeru8WwMtGspnVRHSph5tQGEByuqjlFe1t3
	cSt/DFuYeV8VhSLKWhPUp9Rbm0O6Qe5WB8gePYFqsGe0g+3IjGEZOJR8u5E+GWJ/aopQhnRqBeW
	u/3I7cufrDGvuFS5tMUEkD6LHorqtvEgcIFFRuRjWmArr5zqBGg7ox2r6n07qAoyOA9L2KfIILn
	HTcvRZhnWSMrQ2SN64Sq6ybotoyaRbGs6e2SSPnF/qdZcLCbhjydapCL/92GKOEtxmkjHXFBBAS
	ZP2v2pys+177WcOFlVjJ/
X-Google-Smtp-Source: AGHT+IFo8PuFdgk+w6NWsh1CLxn0FAS77nlcKMO0nb/pSdkwAjMTSI07KjpWz5s3MTWiLdaw5CHpPg==
X-Received: by 2002:a05:6000:1ac9:b0:3a3:7077:ab99 with SMTP id ffacd0b85a97d-3a4cb48445amr375282f8f.45.1748025011162;
        Fri, 23 May 2025 11:30:11 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d2d1sm28180695f8f.19.2025.05.23.11.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 11:30:10 -0700 (PDT)
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
Subject: [PATCH 1/5] thermal: airoha: Convert to regmap API
Date: Fri, 23 May 2025 20:29:29 +0200
Message-ID: <20250523182939.30489-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250523182939.30489-1-ansuelsmth@gmail.com>
References: <20250523182939.30489-1-ansuelsmth@gmail.com>
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


