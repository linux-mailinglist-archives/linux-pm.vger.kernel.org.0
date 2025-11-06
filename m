Return-Path: <linux-pm+bounces-37573-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DCEC3DB8D
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 00:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2CF94E60DF
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 23:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBAB354ACA;
	Thu,  6 Nov 2025 22:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baOr273e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3F734FF7B
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 22:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469985; cv=none; b=F+oql9/NDeh3XZ3V/OoSGGcsHg3T/M35k8pPRtn4LY+C+kpAQpqiicEpdIjgrHIqGNnmGFAfFR1KGEL+Vvgwh6AzuHB0A6PRKf6sc/co+QhLeF0zissVH7seS8SFmgyxkmPAX8tL6G09tLPqVbLUC2Ir37q+w+CD2Nu723XUMuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469985; c=relaxed/simple;
	bh=ufIvFFHkbZ8SPrXnxKoHOjRLGsK5oIeuWrLoO3TsjPo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bk66oDTZIBabaQJXJCI+N3JqUgCik3+EReqUwJ3T/88iEuyEKRqd96TNKMjV4XOQVexkRxnm4LDslepbreBxpK0E28btzP2ueqlzma5OsQSGCeJnu+yOob0qhZnGKavNdjXQe9q58VDaCyHvAEEV2QrLqHbgqadG7zpxnTbTJko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baOr273e; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4710022571cso1177605e9.3
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 14:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762469981; x=1763074781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0nJS+a2wrY+OCu17/ASVfzPnVrSQorpggCTxleeXyA=;
        b=baOr273emL1VOWOYd5H2sLS5BkdoGrVcuq0yI/vbNulhl8W5DpxzvSlOhlgrtbYNIZ
         CCzYYtSCUTYNIP/5lyiSNTPvdHR3iN2bxaocUliaSwVCiuHdDPTVw2MrxftO3j5TiGHm
         jhU6sc2HJlJb9hLwRaDD8e/o4t/zv8zrwYRcA1NzjCqboo3QTayGef6qTRVuUYS/Vspl
         vCXGpF/Meg4W5RSfx3Nh+6YRWyK8waQNzjIDhiyYjfNsJ9kAT0Tj8r8eDM60ntW2BQzP
         3yGbymwXYlwiQAGmOlk/i3hsysW6xIw/5pjgu21gl+W/on/p7DPO8LlDd0A0t9d7Ylhb
         1mWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762469981; x=1763074781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E0nJS+a2wrY+OCu17/ASVfzPnVrSQorpggCTxleeXyA=;
        b=kGvp1FohQpEybAKahhZYfyNBmEg1lZ6et22yFyvbNV7BIQBtR8WDsqqHQFUe0irOGY
         86edwTHKBCunj1vGEsHZkjYdRsbEkq5l77rbiKpPnIPdaU8gzmvvzYu0hTVEWr80la1Q
         WW/qKZ+2wxnXUh1AmPZbyO7t09WVXeEjefhDsnmvMoVkijT6ovVK4vVswrXoOZx9t0VV
         yMJ7ARQm8mzjMcp/GPA8+qWOJX8ybjKFdsjsEtp/Sgs/OTPAWQMc9xSmZb+tZVnI4gmw
         72FdRpIVlQeiS86PTF7rqeODXXe7X2O5nfrIXTCH1G6vGzFf5GRwcs1eLmJ4xUG3LHwf
         +8og==
X-Forwarded-Encrypted: i=1; AJvYcCWMyqz2NURER8pUftJ67MYdC4uKupHRtqghKp1yzonOWUeJbcDpKQC/tC1VqY+gY5PzEbtpitCSxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrYDIo5L2+aPlddFEiXtmzoQA3GqEKIIH5Wws5AWp4c9NUrw+r
	5l+wvPqlan2XRNDQH9kEPTXU7zP28YWccLuS/rGEsALWsYgDKebFKNEu
X-Gm-Gg: ASbGncumN0zM2o+kOIKY8rbeNIvLVwYV2cw6b8/THS1NO9xgBNBTlj5PpvxjehJE04A
	dhFnWxmC5GINFArXuUJztfDxQ2darYA6YIS/EEP/jP5OyfY1UQ/SIabdPSR4W4YHwlI9AZ8UWqd
	EP+Nd+DETczIrZDljUGZqkkBMP60tpgF8Yu2xIqnDO/NzQpxg0YQ/0YsSbuQllR2ukXOYg3xFcb
	V6whlvD0KPFs81mWCvkxPAjAtgPOdbL+XoLp1uZKeQCwIY7wN/7gi2U2H0zLcJNAd/yLcvZUeeo
	Ak6fGIyA/BPvWK/QRME8iaqC+zrXqA/NErna3fsEzQSmTnq7ahiKe4YqvogFBxC+7SsMWyb5FLM
	igaNTMj7vOMnGj1PXN7N1kc05kjuKZZy8pb0IHV/xAFqm5pZ0c2usLyye+4DpCWf0e7FLQ4zNHj
	BJlXB/dvVC0IKJxkkSt8PZuobh9ZhTcQ==
X-Google-Smtp-Source: AGHT+IGP5v4e7GyVgRGWXfvWoW/ZVT1r9DKTfFFQz7PGqnWFrENBgTn+y3PnZMBKWoKvJ7AofF4Vhg==
X-Received: by 2002:a05:600c:46ce:b0:475:da13:257c with SMTP id 5b1f17b1804b1-4776bcc369emr7344765e9.27.1762469980616;
        Thu, 06 Nov 2025 14:59:40 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42ac6794f63sm1640000f8f.42.2025.11.06.14.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 14:59:40 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 3/5] thermal/drivers: airoha: Generalize get_thermal_ADC and set_mux function
Date: Thu,  6 Nov 2025 23:59:12 +0100
Message-ID: <20251106225929.1778398-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106225929.1778398-1-ansuelsmth@gmail.com>
References: <20251106225929.1778398-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for support of Airoha AN7583, generalize
get_thermal_ADC() and set_thermal_mux() with the use of reg_field API.

This is to account the same logic between the current supported SoC and
the new one but with different register address.

While at it also further improve some comments and move sleep inside the
set_thermal_mux function.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/thermal/airoha_thermal.c | 54 +++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index 864a01fd8fd8..a062922cb116 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -193,9 +193,18 @@
 
 #define AIROHA_MAX_SAMPLES			6
 
+enum airoha_thermal_chip_scu_field {
+	AIROHA_THERMAL_DOUT_TADC,
+	AIROHA_THERMAL_MUX_TADC,
+
+	/* keep last */
+	AIROHA_THERMAL_FIELD_MAX,
+};
+
 struct airoha_thermal_priv {
 	struct regmap *map;
 	struct regmap *chip_scu;
+	struct regmap_field *chip_scu_fields[AIROHA_THERMAL_FIELD_MAX];
 	struct resource scu_adc_res;
 
 	u32 pllrg_protect;
@@ -219,22 +228,29 @@ static int airoha_get_thermal_ADC(struct airoha_thermal_priv *priv)
 {
 	u32 val;
 
-	regmap_read(priv->chip_scu, EN7581_DOUT_TADC, &val);
-	return FIELD_GET(EN7581_DOUT_TADC_MASK, val);
+	regmap_field_read(priv->chip_scu_fields[AIROHA_THERMAL_DOUT_TADC],
+			  &val);
+	return val;
 }
 
-static void airoha_init_thermal_ADC_mode(struct airoha_thermal_priv *priv)
+static void airoha_set_thermal_mux(struct airoha_thermal_priv *priv,
+				   int tdac_idx)
 {
-	u32 adc_mux, pllrg;
+	u32 pllrg;
 
 	/* Save PLLRG current value */
 	regmap_read(priv->chip_scu, EN7581_PLLRG_PROTECT, &pllrg);
 
-	/* Give access to thermal regs */
+	/* Give access to Thermal regs */
 	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT,
 		     priv->pllrg_protect);
-	adc_mux = FIELD_PREP(EN7581_MUX_TADC, EN7581_SCU_THERMAL_MUX_DIODE1);
-	regmap_write(priv->chip_scu, EN7581_PWD_TADC, adc_mux);
+
+	/* Configure Thermal ADC mux to tdac_idx */
+	regmap_field_write(priv->chip_scu_fields[AIROHA_THERMAL_MUX_TADC],
+			   tdac_idx);
+
+	/* Sleep 10 ms for Thermal ADC to enable */
+	usleep_range(10 * USEC_PER_MSEC, 11 * USEC_PER_MSEC);
 
 	/* Restore PLLRG value on exit */
 	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT, pllrg);
@@ -343,10 +359,8 @@ static void en7581_thermal_setup_adc_val(struct device *dev,
 {
 	u32 efuse_calib_info, cpu_sensor;
 
-	/* Setup thermal sensor to ADC mode and setup the mux to DIODE1 */
-	airoha_init_thermal_ADC_mode(priv);
-	/* sleep 10 ms for ADC to enable */
-	usleep_range(10 * USEC_PER_MSEC, 11 * USEC_PER_MSEC);
+	/* Setup Thermal Sensor to ADC mode and setup the mux to DIODE1 */
+	airoha_set_thermal_mux(priv, EN7581_SCU_THERMAL_MUX_DIODE1);
 
 	regmap_read(priv->map, EN7581_EFUSE_TEMP_OFFSET_REG, &efuse_calib_info);
 	if (efuse_calib_info) {
@@ -429,13 +443,18 @@ static const struct regmap_config en7581_thermal_regmap_config = {
 	.val_bits		= 32,
 };
 
+static const struct reg_field en7581_chip_scu_fields[AIROHA_THERMAL_FIELD_MAX] = {
+	[AIROHA_THERMAL_DOUT_TADC] = REG_FIELD(EN7581_DOUT_TADC, 0, 15),
+	[AIROHA_THERMAL_MUX_TADC] = REG_FIELD(EN7581_PWD_TADC, 1, 3),
+};
+
 static int en7581_thermal_probe(struct platform_device *pdev,
 				struct airoha_thermal_priv *priv)
 {
 	struct device_node *chip_scu_np;
 	struct device *dev = &pdev->dev;
 	void __iomem *base;
-	int irq, ret;
+	int i, irq, ret;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -454,6 +473,17 @@ static int en7581_thermal_probe(struct platform_device *pdev,
 	if (IS_ERR(priv->chip_scu))
 		return PTR_ERR(priv->chip_scu);
 
+	for (i = 0; i < AIROHA_THERMAL_FIELD_MAX; i++) {
+		struct regmap_field *field;
+
+		field = devm_regmap_field_alloc(dev, priv->chip_scu,
+						en7581_chip_scu_fields[i]);
+		if (IS_ERR(field))
+			return PTR_ERR(field);
+
+		priv->chip_scu_fields[i] = field;
+	}
+
 	of_address_to_resource(chip_scu_np, 0, &priv->scu_adc_res);
 	of_node_put(chip_scu_np);
 
-- 
2.51.0


