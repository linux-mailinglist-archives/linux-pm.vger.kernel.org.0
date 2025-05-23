Return-Path: <linux-pm+bounces-27607-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E458AC29C3
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 20:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270A01BA6C13
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 18:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383A329B8CC;
	Fri, 23 May 2025 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmtkKzVG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6AA29AAF0;
	Fri, 23 May 2025 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748025017; cv=none; b=UQ7Xvvz4x9MLHW8atzNP08k3sONPO2ggTRe+4phMrcN79wIIMqpypoFkiOxWBmSwLZun8bbAjYBWelVHsL7fhbwZYbfv432WVcQwaSJ1ZJLEoL0iGAdmv6tQ5pXI4XNofLGsUUyjYrJyEgSDcfxVYxEuBhZavcyFRalk1jIUCzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748025017; c=relaxed/simple;
	bh=ekBKR7Lv9oRac0ZLGP9CYgwGxje7bKMozV4NKyoCQ8Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUV4GT9wjoVX/tSnQQH8gRZ71XYraMrYSfATtHnswhiiVUnSxtaWo19j+uL+BQsLrwSMfJV66BSu8ZIJjaQwguUb3k9RCeue8OuymoRmgVj4lBSsoXNEGJlwtxguDPQAr21Q0dwhBxHJwNPJRGOx7vNjpu4gLd1LsTa2NSjku3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmtkKzVG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a4c4e6a0ccso140394f8f.3;
        Fri, 23 May 2025 11:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748025013; x=1748629813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQ8QlcBdWd0Fx5MdvLJdxsCqqhtJN4mycD+l4My2cUw=;
        b=bmtkKzVG2W649Mj23WAxm7v1tDsDOFN5B8ss0+zP0m13DeLVrW5syU6si3oIh8bNV0
         PXCfCP9CrGhORTx9KbGY2kDAKkOHdOg2InMNMgAy5ShtHAI1GWDxR1My6zZ3qK/bugwA
         q3pKZGVjheeoDrMUhvpJmPSQ1REHAxyGGkaSXEmGHqD8Ztb6nxoGriyeQ4AH7ZoCy1pz
         BBMkuqTEmX80CypiMZOxkVQxFv0Pu/Q9bRxk8iKfZU26GtuAx6NFkZLYA4XGtYQKucMt
         GTwNn5+CnFE1fs/gi9lWd3a5l/83Tvj0I2X7xp3wuDFRahiSQl9utwmlfXy1kblg/Nbe
         MhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748025013; x=1748629813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQ8QlcBdWd0Fx5MdvLJdxsCqqhtJN4mycD+l4My2cUw=;
        b=aKwrJjh4dXmM+k/aJM23doJNph4bmG7FmD5/vt2r+1fwcsU7AHYLg/2JKxElAs5YNw
         IDdreG2Hlnn6l9SEkNIaKPOV0bjXy3nn/uzoZSZD9Ml3hdpYDY8koxdDvbmSWRFE2IGj
         L4LB76JJJVtefCaL4CYm95AQQ+pf53xrqUj/b54Y1iHx0BoHVdlr5XLqszrlRd0L/hXn
         BdF4XoQzRgb9GKMGyh+zDqZj78ECEY7sv/WUorDXqTcJ5sy8KF2VtGj9J0p68YhTiCdO
         t5053rQELgxDO62ZUzFHlYK7cl8C/bMbD6S0XYHPR6hxMbMPPGYHgjbLCv4/dClXTYqm
         dySg==
X-Forwarded-Encrypted: i=1; AJvYcCUS5tE2q8UKzRbbCtzH7jF1GCNJv1tV13Nic8TLT5tm42ejdMbmG5/XpNEi7JbKnRTHvD2omu42Fq8=@vger.kernel.org, AJvYcCV5e0TMeg86nKEjk6Nrzqgdomtg7WTzaEwI1lmIE7MFncFZ14gamIKHZjTTzemEU4P75j7oeQn8j+wn@vger.kernel.org, AJvYcCVGnFmqp4lFbGLJa1pIlCMMzctONxl1O8JmfMFWMGuXcYFUNvb77ty26lqsKIIxL+8YrDaa+9ntNtdp1Ub0@vger.kernel.org
X-Gm-Message-State: AOJu0YypNuWvvMMLrqxsZ2fqh2kbL1pAVIQcwdMDc1Uk20IRQmNBZGBO
	KtJVQPSSHrLWDP+249ptip+7FqL0gs/pK/Gd5dza61g2jcwgwluGoCv3
X-Gm-Gg: ASbGncu8dDAI5X4V4CFaMjmPHyDwCRgXEwF/wz3TJjPDpxDlRSMhELhK/gsyopLhmB0
	GRrXLTm3tZ/mLHOA3b5A+jhRUp3nf0i49kvR8cjD3ltojyIySANFQWQoslqv+BzmG6JlDp/SrbV
	27oUJIk1tDtddr35hmA2avInxPgUdTU1ze1AWgrvnWzES2AlL/Ywco18s6I2NdT4T5owTZNuyVD
	mg4nQL60GURJZGgJMf6CSi5CqnS0fgQK53SqwsuvtrBRMielCwpYyloaqDMdC0OUeXuolU0EmYV
	xc7SNAZq5J+IVK6lR6xAEH3mofru2uW1ZFeESesPe4uZT5rnNjLXDUZdsElhcaTFV8scPiz+p+r
	b5JuoA/AiyXdVt00nTOr0
X-Google-Smtp-Source: AGHT+IGqlNjS3/yy5PC/pt+Pz4dbb96NoJVachaflRhm85TFP1ul3ISSryCigPrr0pO/3y09S+cMkQ==
X-Received: by 2002:a05:6000:2283:b0:3a3:f692:c4ae with SMTP id ffacd0b85a97d-3a4cb454b8dmr240921f8f.18.1748025013326;
        Fri, 23 May 2025 11:30:13 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d2d1sm28180695f8f.19.2025.05.23.11.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 11:30:13 -0700 (PDT)
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
Subject: [PATCH 3/5] thermal/drivers: airoha: Generalize get_thermal_ADC and set_mux function
Date: Fri, 23 May 2025 20:29:31 +0200
Message-ID: <20250523182939.30489-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250523182939.30489-1-ansuelsmth@gmail.com>
References: <20250523182939.30489-1-ansuelsmth@gmail.com>
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
index 9bfa59b97032..4c973cce106a 100644
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
2.48.1


