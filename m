Return-Path: <linux-pm+bounces-27697-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52093AC5C7F
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 23:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E618E1BA46A4
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 21:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D52217659;
	Tue, 27 May 2025 21:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQhPU/Rb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D2F1F7580;
	Tue, 27 May 2025 21:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748382795; cv=none; b=P3uioyR7dWc9DTOKXWRdJf9PqQ/C3kwhBH/DcoxgAgKI3DoO+JLDobIytyBVdIe2FydxSy4sabyymktMLBTV7lFlhDwSS+In/tlwCHEDubh2RkH4CvKaJUP7tRR7s9hb0p5oEmD3GW10wFTfirmToScy0MXtXFekF9CY/F5e4c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748382795; c=relaxed/simple;
	bh=ekBKR7Lv9oRac0ZLGP9CYgwGxje7bKMozV4NKyoCQ8Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMHGgPAV2OZxOOZVWOvhPKPiJJNp2Qhvi95iS1I667HirX0m1gEmA3/ivKnpu8VtTbQMbWWg40Q2MbdvfG2II4dFUlyU37YB0BjNpsuhlTQnVIaEgrBMvD00UBQEVnHjmSgdS45BGLApd9FCEQbd2nBjPlCAIvLFllw8C83IBp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQhPU/Rb; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4dc0f164fso2160992f8f.3;
        Tue, 27 May 2025 14:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748382792; x=1748987592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQ8QlcBdWd0Fx5MdvLJdxsCqqhtJN4mycD+l4My2cUw=;
        b=gQhPU/RbqH1TmrTgwdZx5PcEoobNFjVtv9vROUoZSiGkUEUGJs7TvdfGWsn1FA1ArT
         m5D0wJJMLc7rmW2bvK1HalP5bpwWzw1Zag+ljMZx9Q8FBHN3jgDEtAitTKWbZdZpgIF3
         4r+420xq/xLz1pXL+r3qczB+WEmJM305MNNmfP9uH0KgyDFufQOeIFkW9IpeEEW62R+Z
         UIW7B4wte2Fqz0Eo9UV0KhwFzJRjtSLlgWaUj2fCMiLA1nyCLALG7IoyvtQRVHHEAiZY
         uktWAC2kdmghPK8qPPDBjTWDIJB9Z42zCAiMH/eaPylL7SzWXVxjy3oWc6maSh2IysSr
         qm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748382792; x=1748987592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQ8QlcBdWd0Fx5MdvLJdxsCqqhtJN4mycD+l4My2cUw=;
        b=EHGGHnagzJuEAyrHu779bMkmtGXGMg/reHE4y7ELOCHCBOYUkb8HJzTHdMUp5RI8XC
         Lircl6v9JZQ3SzQ9I+1YECFkAuAvhvMy/wZyZ3meF9YlZsNpivp4/zb9/2PbcEViJddW
         HmUpdpy/aVsvu4/vvtL6YXhI/iW5StxICLzn9FxeAx7ljnRrYRyElWppHgPrvPWUdp8Q
         3Sqp6Nf+hMfMyCeOwibCKjtjx8rRAEv2SVubKedpjEUvQdAjG5/ledhERkGXeTVeyACg
         lOBf6qhsFkojQJBoUpzO0ugothstKB356668GtBMOqekkRsUMOUmynfX3jq6dIBkW8xB
         YN2A==
X-Forwarded-Encrypted: i=1; AJvYcCVrBMkLIv6pgoya0oe2xcwkIjtn41vOAcbdUS5xPpjUYBQ8SaN5WGurbp+HM11cxC3eRjKZZk6fjYckzYQ+@vger.kernel.org, AJvYcCVrEinrK956BnYdIO4nCTndIPfyEnJYc1VC7RvJXX9C8p+3U1GNQbS8mGB7MG9pMKR34Ahf47GpAuIC@vger.kernel.org, AJvYcCXvz6yFut5mY3OVpABACGMe+IRDtBqgfeQnpkCnu8gyV7AdXsAt59K7UyXsELS7kv9ocCYqcCbS9cs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6cCZWP2joWxUHtBJgqy9760jke759bLTjVxV31vjtmCQo7u8f
	zR1fV9FXIqADrhiOedOij+Au4ra38uWxtPrnotANOgAOZmhUzU+IpfnA
X-Gm-Gg: ASbGnct2qIVn/gQe1wuZuf07JCetdz8ppo/6Qko4gOq2VOJeS+6Zbdr5LD/eO+Sn3Dz
	1OfDmsagUDEahnyf0kQwqZWL1tXZSh6Ae4T68uNfLXizL5VgqIZrhl/5cDssTIUXBM75A0m7JHc
	iBHPIfZTjCplaANdiAqfaUe7YbtbTCsR3K19wC9GPNdsQdfe+BJyU1ESVRCSAe6e/vmQtyIopDb
	M7cgFrDtvvNFyxbPtgytrqn0jzvxZ6sRJiQKQ7COcy4o28zKkR294X3/xh+kwBZRO+FPS8djaJX
	j1nFeT3RriJEclS82QSWbaRIBEZ6n9i/EG1RQnMchmDSafMh/eAO+2jqITUSJHH9YK4H/M1wth5
	fAlM3pExdsEXLEt7Poes4GjKX91bKsRQ=
X-Google-Smtp-Source: AGHT+IHwdlIjl4XdhfQz3skBsBAaA2A6LDfME6WNoDpTGosbqtfqEag4vHLNAhvHpnxTCUxQLVnrPA==
X-Received: by 2002:a05:6000:2dc7:b0:3a4:e6e6:a026 with SMTP id ffacd0b85a97d-3a4e6e6a0dbmr1016333f8f.28.1748382791535;
        Tue, 27 May 2025 14:53:11 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a4e8b8dcdasm206656f8f.11.2025.05.27.14.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 14:53:11 -0700 (PDT)
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
Subject: [PATCH v2 3/5] thermal/drivers: airoha: Generalize get_thermal_ADC and set_mux function
Date: Tue, 27 May 2025 23:52:37 +0200
Message-ID: <20250527215241.25767-4-ansuelsmth@gmail.com>
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


