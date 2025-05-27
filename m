Return-Path: <linux-pm+bounces-27699-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7681AC5C89
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 23:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42144A738D
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 21:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E8F21883E;
	Tue, 27 May 2025 21:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeMQqt9i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E233021885D;
	Tue, 27 May 2025 21:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748382800; cv=none; b=Ha04q7YVIk7MtG/VyVU8FfANPMKVFTRYZ6y66VTUZPeaU/12VDChNWLloUZYyU9FyY5drRSJX5m03FTXOQ9I/7X2TPaiHbB6rG+lSXQE97ocDqD1Cxb7ZP337RqsQFBQ8aHD80VoGYiKuJY8sDLYxExJDqC98Xnvf3YyHyyyR9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748382800; c=relaxed/simple;
	bh=zmNS/g/uQIEqjg8pv8e9ZCmB4hQz9Fpeoy2dOjmOTf0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imPs4HwQs+AuT7peCcFtpxmnCE8mMD3J08/evq7x46Urxx9q7MUpoDoUR+gS9nFnjzFnZQKeXquJ+DysB5uuDMDWfAW8AMedp/jHNslOmV15FVZK2kwkIhr1eF6zHmTQMXvzv9jWBPCXMkDBywv+IgPnTInu4peXWN6oQO+R91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeMQqt9i; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf680d351so1955395e9.0;
        Tue, 27 May 2025 14:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748382794; x=1748987594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gq4Q+VNy6npC1ksfAe5OpC6UqFwfJyc/g1FQnGCBY/w=;
        b=HeMQqt9iti7KNNeoSsXhrB9lh1VE8L8DcE5uKZblgI4Nvt2Cgsp9WVqs6RsuWpCP4x
         G2tcHNBuuHVS4lfWih4Plr8XEOU3whagD/5XHjTqjee8gr2VxMuvdLZRxtWlvqGP5/MD
         6taGYxy/3aQiL1l3fuejwiML8VMag1nAOIoog03xGWTRSICxR8NCZqBw1mqpimEHuVda
         UNAm8AzMREdrIx8x7ZhB33DixuScYidjfMwgmNpJ0DeuRvLu1UfNOt3GPeFhN87HSJ1a
         qbAVAfHxPrcBdP3l7M6B4Mn/JT6PH6c6uSOK98qH9pO3V9Q83uhnInlts2v4FGRtHd/g
         OS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748382794; x=1748987594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gq4Q+VNy6npC1ksfAe5OpC6UqFwfJyc/g1FQnGCBY/w=;
        b=UnLTAUfdUfXGjKwHPozvsT8MsxsvgERWq7i2eNxYDs5T+nakTpFWaMCB/iuOdT6nfF
         ig377kYjSuNrvHonaBbv3NqnRKSkx0iq8YoOFEWkO7Fwdw96lXyyTgLHzajDlHP9KRQq
         geJWRoDfgJIgUVGrVy8KTODLiuSNj+YhX6NH8casMfZnERDjGMCPEPa4ZJGr8DXKkjFy
         RYErCTNlKTLfbMj1QnkJ1yLQBPIOeFWNxK8hTMYd6jxXiIRErGRgEaIFf0kwGH895t7D
         M5Ga3eWFOwIBJA+3p1F9vaKHkWR41PseDey/rpAbgYfVUSKte0f2dPPM2fH/KFZoTr6r
         8TzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXK4i17YeBOqHHRwhLhbAs6eLJ7Epsqq0C0KQvxE2cB2SlouMMyMvM57zxzE7Rq/xDJlPVn6evUbw=@vger.kernel.org, AJvYcCVvOgVqPStKBksI/96d04HIdBdKKBZq1+sZUP/pn3JE0xVsrEWTY7Yhv5ZLX5RweYOX2IO66X8cDfNO@vger.kernel.org, AJvYcCWckJ0ib1FZd793J8VLDv7MH66MldVR/r4KHZfQYdsCMUMIR1Z9P9aNYaAfrTU7SsYex+0/KoXVlqOw9HrV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/zltN+0v1+hx8WwKnNpH3EF+k6ODIiBdH8RRA38FCVk4sObBZ
	hWplYDzQnw2X8JigK4jDhoJf51BkNGhjI6iNIlJ0p6idMCYHYyidq4MNlhjf3A==
X-Gm-Gg: ASbGncsqMAiIH2ils2DS2Kz78w8YKZCrJ7FScbZZgcDKVdFy4d0HJgD736a5SAgCIDT
	Yok4YnPSJTeKbs9w+eO12b0mqz5c7CzmcwICmVjHpabUS7AuI6J4GfNNjLePPLYs/Uy5ZbFcLTx
	4sShfWu1GYrd7YVK26FRKjuwUrMpepnKmkQtgnmEA3FpBP+RTOETGhKmT2rigrgM5TlM53iNuDe
	0ove9o7kLG/am48G3pImhgNMpZq3DTseNFrJIdEIvJMx1XC4SsfQngckEj5TTcko/BzQ7oy/lEw
	YO+AMWQf8jPqx8N+WsECUzmOfQx3yvlXp0cnUI6mZ1JpQy372s79HgO1eQ3glQSGGWtbrZt3gk3
	NxYJot0P/EcXk2G7JMZyT
X-Google-Smtp-Source: AGHT+IHL/zXQxdrX/xfFoSnEBrs97F+A5I3OaSukghEzTxZ95IFMQvVQRnrHOcpwVxdVHqvUd3ByPQ==
X-Received: by 2002:a05:6000:230b:b0:3a4:d045:6462 with SMTP id ffacd0b85a97d-3a4e5e9cbddmr2459193f8f.14.1748382793993;
        Tue, 27 May 2025 14:53:13 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a4e8b8dcdasm206656f8f.11.2025.05.27.14.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 14:53:13 -0700 (PDT)
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
Subject: [PATCH v2 5/5] thermal/drivers: airoha: Add support for AN7583 Thermal Sensor
Date: Tue, 27 May 2025 23:52:39 +0200
Message-ID: <20250527215241.25767-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250527215241.25767-1-ansuelsmth@gmail.com>
References: <20250527215241.25767-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Airoha AN7583 Thermal driver. This apply similar logic
on how to read the temperature but totally drop support for the
PTP_THERMAL subsystem. PTP_THERMAL subsystem was a way to trigger trip
point from hardware by configuring how to read the temperature
internally.

This subsystem has been totally removed from Airoha AN7583 permitting
only to read the temperature.

The SoC support up to 3 sensor but the original driver always read the
BGA sensor hence it's currently implemented reading only this specific
sensor. Reference and values for the other 2 sensor are defined for
further implementation if confirmed working.

set_thermal_mux() is extended to also address muxing the sensor as
AN7583 use a different way to read the temperature from 3 different
diode. The EN7581 code is updated to account for these changes.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/thermal/airoha_thermal.c | 158 ++++++++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index 4c973cce106a..e71548f9cee1 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -18,6 +18,12 @@
 #define EN7581_DOUT_TADC			0x2f8
 #define   EN7581_DOUT_TADC_MASK			GENMASK(15, 0)
 
+#define AN7583_MUX_SENSOR			0x2a0
+#define   AN7583_LOAD_ADJ			GENMASK(3, 2)
+#define AN7583_MUX_TADC				0x2e4
+#define   AN7583_MUX_TADC_MASK			GENMASK(3, 1)
+#define AN7583_DOUT_TADC			0x2f0
+
 /* PTP_THERMAL regs */
 #define EN7581_TEMPMONCTL0			0x800
 #define   EN7581_SENSE3_EN			BIT(3)
@@ -181,6 +187,11 @@
 #define EN7581_SCU_THERMAL_PROTECT_KEY		0x12
 #define EN7581_SCU_THERMAL_MUX_DIODE1		0x7
 
+#define AN7583_SCU_THERMAL_PROTECT_KEY		0x80
+#define AN7583_NUM_SENSOR			3
+
+#define AIROHA_THERMAL_NO_MUX_SENSOR		-1
+
 /* Convert temp to raw value as read from ADC	((((temp / 100) - init) * slope) / 1000) + offset */
 #define TEMP_TO_RAW(priv, temp)			((((((temp) / 100) - (priv)->init_temp) * \
 						  (priv)->default_slope) / 1000) + \
@@ -193,8 +204,39 @@
 
 #define AIROHA_MAX_SAMPLES			6
 
+/*
+ * AN7583 supports all these ADC mux but the original driver
+ * always checked temp with the AN7583_BGP_TEMP_SENSOR.
+ * Assume using the other sensor temperature is invalid and
+ * always read from AN7583_BGP_TEMP_SENSOR.
+ *
+ * On top of this it's defined that AN7583 supports 3
+ * sensor: AN7583_BGP_TEMP_SENSOR, AN7583_GBE_TEMP_SENSOR,
+ * AN7583_CPU_TEMP_SENSOR.
+ *
+ * Provide the ADC mux for reference.
+ */
+enum an7583_thermal_adc_mux {
+	AN7583_BGP_TEMP_SENSOR,
+	AN7583_PAD_AVS,
+	AN7583_CORE_POWER,
+	AN7583_AVSDAC_OUT,
+	AN7583_VCM,
+	AN7583_GBE_TEMP_SENSOR,
+	AN7583_CPU_TEMP_SENSOR,
+
+	AN7583_ADC_MUX_MAX,
+};
+
+enum an7583_thermal_diode_mux {
+	AN7583_D0_TADC,
+	AN7583_ZERO_TADC,
+	AN7583_D1_TADC,
+};
+
 enum airoha_thermal_chip_scu_field {
 	AIROHA_THERMAL_DOUT_TADC,
+	AIROHA_THERMAL_MUX_SENSOR,
 	AIROHA_THERMAL_MUX_TADC,
 
 	/* keep last */
@@ -208,6 +250,7 @@ struct airoha_thermal_priv {
 	struct resource scu_adc_res;
 
 	u32 pllrg_protect;
+	int current_adc;
 
 	struct thermal_zone_device *tz;
 	int init_temp;
@@ -224,6 +267,24 @@ struct airoha_thermal_soc_data {
 	int (*post_probe)(struct platform_device *pdev);
 };
 
+static const unsigned int an7583_thermal_coeff[AN7583_ADC_MUX_MAX] = {
+	[AN7583_BGP_TEMP_SENSOR] = 973,
+	[AN7583_GBE_TEMP_SENSOR] = 995,
+	[AN7583_CPU_TEMP_SENSOR] = 1035,
+};
+
+static const unsigned int an7583_thermal_slope[AN7583_ADC_MUX_MAX] = {
+	[AN7583_BGP_TEMP_SENSOR] = 7440,
+	[AN7583_GBE_TEMP_SENSOR] = 7620,
+	[AN7583_CPU_TEMP_SENSOR] = 8390,
+};
+
+static const unsigned int an7583_thermal_offset[AN7583_ADC_MUX_MAX] = {
+	[AN7583_BGP_TEMP_SENSOR] = 294,
+	[AN7583_GBE_TEMP_SENSOR] = 298,
+	[AN7583_CPU_TEMP_SENSOR] = 344,
+};
+
 static int airoha_get_thermal_ADC(struct airoha_thermal_priv *priv)
 {
 	u32 val;
@@ -234,7 +295,7 @@ static int airoha_get_thermal_ADC(struct airoha_thermal_priv *priv)
 }
 
 static void airoha_set_thermal_mux(struct airoha_thermal_priv *priv,
-				   int tdac_idx)
+				   int tdac_idx, int sensor_idx)
 {
 	u32 pllrg;
 
@@ -245,9 +306,20 @@ static void airoha_set_thermal_mux(struct airoha_thermal_priv *priv,
 	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT,
 		     priv->pllrg_protect);
 
+	/*
+	 * Configure Thermal Sensor mux to sensor_idx.
+	 * (if not supported, sensor_idx is AIROHA_THERMAL_NO_MUX_SENSOR)
+	 */
+	if (sensor_idx != AIROHA_THERMAL_NO_MUX_SENSOR)
+		regmap_field_write(priv->chip_scu_fields[AIROHA_THERMAL_MUX_SENSOR],
+				   sensor_idx);
+
 	/* Configure Thermal ADC mux to tdac_idx */
-	regmap_field_write(priv->chip_scu_fields[AIROHA_THERMAL_MUX_TADC],
-			   tdac_idx);
+	if (priv->current_adc != tdac_idx) {
+		regmap_field_write(priv->chip_scu_fields[AIROHA_THERMAL_MUX_TADC],
+				   tdac_idx);
+		priv->current_adc = tdac_idx;
+	}
 
 	/* Sleep 10 ms for Thermal ADC to enable */
 	usleep_range(10 * USEC_PER_MSEC, 11 * USEC_PER_MSEC);
@@ -360,7 +432,8 @@ static void en7581_thermal_setup_adc_val(struct device *dev,
 	u32 efuse_calib_info, cpu_sensor;
 
 	/* Setup Thermal Sensor to ADC mode and setup the mux to DIODE1 */
-	airoha_set_thermal_mux(priv, EN7581_SCU_THERMAL_MUX_DIODE1);
+	airoha_set_thermal_mux(priv, EN7581_SCU_THERMAL_MUX_DIODE1,
+			       AIROHA_THERMAL_NO_MUX_SENSOR);
 
 	regmap_read(priv->map, EN7581_EFUSE_TEMP_OFFSET_REG, &efuse_calib_info);
 	if (efuse_calib_info) {
@@ -476,6 +549,10 @@ static int en7581_thermal_probe(struct platform_device *pdev,
 	for (i = 0; i < AIROHA_THERMAL_FIELD_MAX; i++) {
 		struct regmap_field *field;
 
+		/* Skip registering MUX_SENSOR field as not supported */
+		if (i == AIROHA_THERMAL_MUX_SENSOR)
+			continue;
+
 		field = devm_regmap_field_alloc(dev, priv->chip_scu,
 						en7581_chip_scu_fields[i]);
 		if (IS_ERR(field))
@@ -516,6 +593,71 @@ static int en7581_thermal_post_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int an7583_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct airoha_thermal_priv *priv = thermal_zone_device_priv(tz);
+	int sensor_idx;
+	int delta_diode, delta_gain;
+	int coeff, slope, offset;
+
+	int diode_zero, diode_d0, diode_d1;
+
+	/* Always read sensor AN7583_BGP_TEMP_SENSOR */
+	sensor_idx = AN7583_BGP_TEMP_SENSOR;
+
+	coeff = an7583_thermal_coeff[sensor_idx];
+	slope = an7583_thermal_slope[sensor_idx];
+	offset = an7583_thermal_offset[sensor_idx];
+
+	airoha_set_thermal_mux(priv, sensor_idx, AN7583_ZERO_TADC);
+	diode_zero = airoha_get_thermal_ADC(priv);
+	airoha_set_thermal_mux(priv, sensor_idx, AN7583_D0_TADC);
+	diode_d0 = airoha_get_thermal_ADC(priv);
+	airoha_set_thermal_mux(priv, sensor_idx, AN7583_D1_TADC);
+	diode_d1 = airoha_get_thermal_ADC(priv);
+
+	delta_diode = diode_d1 - diode_d0;
+	delta_gain = (delta_diode * coeff) / 100 + (diode_zero - diode_d1);
+	*temp = (slope * delta_diode * 10) / delta_gain - offset * 10;
+	*temp *= 100;
+
+	return 0;
+}
+
+static const struct thermal_zone_device_ops an7583_tz_ops = {
+	.get_temp = an7583_thermal_get_temp,
+};
+
+static const struct reg_field an7583_chip_scu_fields[AIROHA_THERMAL_FIELD_MAX] = {
+	[AIROHA_THERMAL_DOUT_TADC] = REG_FIELD(AN7583_DOUT_TADC, 0, 31),
+	[AIROHA_THERMAL_MUX_TADC] = REG_FIELD(AN7583_MUX_TADC, 1, 3),
+	[AIROHA_THERMAL_MUX_SENSOR] = REG_FIELD(AN7583_MUX_SENSOR, 2, 3),
+};
+
+static int an7583_thermal_probe(struct platform_device *pdev,
+				struct airoha_thermal_priv *priv)
+{
+	struct device *dev = &pdev->dev;
+	int i;
+
+	priv->chip_scu = device_node_to_regmap(dev->parent->of_node);
+	if (IS_ERR(priv->map))
+		return PTR_ERR(priv->map);
+
+	for (i = 0; i < AIROHA_THERMAL_FIELD_MAX; i++) {
+		struct regmap_field *field;
+
+		field = devm_regmap_field_alloc(dev, priv->chip_scu,
+						an7583_chip_scu_fields[i]);
+		if (IS_ERR(field))
+			return PTR_ERR(field);
+
+		priv->chip_scu_fields[i] = field;
+	}
+
+	return 0;
+}
+
 static int airoha_thermal_probe(struct platform_device *pdev)
 {
 	const struct airoha_thermal_soc_data *soc_data;
@@ -530,6 +672,7 @@ static int airoha_thermal_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->pllrg_protect = soc_data->pllrg_protect;
+	priv->current_adc = -1;
 
 	if (!soc_data->probe)
 		return -EINVAL;
@@ -558,8 +701,15 @@ static const struct airoha_thermal_soc_data en7581_data = {
 	.post_probe = &en7581_thermal_post_probe,
 };
 
+static const struct airoha_thermal_soc_data an7583_data = {
+	.pllrg_protect = AN7583_SCU_THERMAL_PROTECT_KEY,
+	.thdev_ops = &an7583_tz_ops,
+	.probe = &an7583_thermal_probe,
+};
+
 static const struct of_device_id airoha_thermal_match[] = {
 	{ .compatible = "airoha,en7581-thermal", .data = &en7581_data },
+	{ .compatible = "airoha,an7583-thermal", .data = &an7583_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, airoha_thermal_match);
-- 
2.48.1


