Return-Path: <linux-pm+bounces-27606-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF00AC29C0
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 20:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90B93AA249
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 18:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355F529B239;
	Fri, 23 May 2025 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVzGqJ5Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F8729A9F2;
	Fri, 23 May 2025 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748025016; cv=none; b=G9PD7FZyGIqR4KFJmIbA2G1EhjSF1GdUKdTHC2WHaUNwj7fK/S64Hi0loUH/zUO3GEJkCDOiC7ciIalRf6+3Sr4KUNcQrw1OStqOEE3UvPDEBcJFpL9USqTlobtS3nacIkMEdxzuQHkuV6ysKmwAwxQOrzO7SgddRnIPZEqEmUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748025016; c=relaxed/simple;
	bh=XA27u/VOEH9VoBWsiugWrpftUIiRrwvmykvq6UgMRpg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2SxrlQvteSOvq+HOhIQouLdeeg4gBsB+FczsAyzraOUnWptmMGNa9KqfIzodxlWTUSEiup7R/Ue5nxBBZrlBXAX5nMgDCDMOpEsT3EshvESp99TqB4tzFTzC0f8ox85/50Sg/bfKHsRadZBK6NmvwT/+r0j+a08Itf0viHWMjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVzGqJ5Y; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a37ed01aa0so169963f8f.2;
        Fri, 23 May 2025 11:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748025012; x=1748629812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vr7W9LI+qlsRFn4c9Ws/BXSMWXobP4FxVmqkbUjGpg=;
        b=HVzGqJ5YbUK+tpQf6nzC/U4/Cb0+RhX+vpBNTh/5zF4qnfwGe3oSe0vssUsyevgSos
         +6NyMP82aRrgjeglRk4k6wu06drJGZClvW8wMMdeLgiaRjSvMMUmB29f8er24NOtxov0
         aip85uD+Uauo2lTGg767WG2JJnun6Y83zCKuD3t8WDoWDamARQdtIdqcXoONasARmI4C
         pXwtYQvOndKGJtkjt921IpruawCfFcQddtz/BMAzCVui9O7iI+wngufkmm/XIH8obFve
         arubhV5cRt0WFLIAoFNHWnjWuEWIgxIPZe2VbC9ud4o/4cqoJ5Trp06ZzzJQaPytX8NR
         N1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748025012; x=1748629812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vr7W9LI+qlsRFn4c9Ws/BXSMWXobP4FxVmqkbUjGpg=;
        b=ECYEITZE/4s1wqLRUAtj0M9J7KBeEvnBCVAPH8XDbzoOSq9SFs3vBqm6+Gk8QSkMxW
         uAKQ6QZDW/fe8ptRDtCGAH34uyZbQds9VIayCeNwgf/xX7/YI+sqzbZjkNKiD+7tCx0F
         lHT6cBUJlL1tepVB+oKVo7mVx1tl3uka5eZlZ0isHmOpxYZg8WhTjOSN90HqbnMvqYzA
         6in3sz2is2fErbizbAbqZF1evuSkuiwO/LdHgdus9CHJJVdsACQa/CllHfEgHal5Eze5
         Qfw/dr/uAuUMTHeumySG6BrH/riG+fc/fglW8YIuVQdSTEbaA2HI0peOdA9c3fP2awdZ
         CXlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbo4Z6NZyG8uVOVpQ63uDTL5HC1ZaS2JpgM2PCjcWCbdKrgtyCVWhn/XPqyRTN03kWkgUvCp8yC4UoLwfX@vger.kernel.org, AJvYcCUyycpKhfTlDpEz7GNUIKxDMIL224lNaqeVamlmd8F36MoF6pL7z102m7xeiLvSNya+NU70X/Ge0m4=@vger.kernel.org, AJvYcCVfKfZegArwYG3ydQZtB5OjcdqSJyce1SmoyauoS2Wp/Plenb+TJnxg/2vOyO0QqCPAl860vwSZFSpb@vger.kernel.org
X-Gm-Message-State: AOJu0YynfWXJccKRU5BcN1Xgr32ipEIo9ZxEyReP7izhhd1gNLo1UJr3
	zJDAVz1zqIMwBK6csuv52ch9FAvKuURCwlDSEsex+zxdZL5WvpdOsp7Z
X-Gm-Gg: ASbGnct9XlOR5GgV7K8Pr+5DifMJoza9/oVK/ttfPhu0EnVxet1VZ/vY9i5BCTmCVzx
	2kaKiqwjRwU5BtD1Cyjx7Bt7OCDb1bsaVxMPwJ0RvVsHFV2oudoHxywOJeBdgdM28TuSmIbh45f
	3E2t3JBEjuSUklDr9xHXX+sQjv7jrriwupsRigeElwieepQ+NkXoqoOoDOE2kA//9YYMT2h8ZCu
	vQQQj+7YZKtOKfbXNRRObS3mP5Kpw/9lXr6v9fhSFdmZjV/KDbSOCzuu/lSBmuP3EJ4R9Uzv9gj
	djlbs9hbmH0bu1mJ7f3LqVNxxqrhQKBktMv3Vi9KJsEm9P3GFrFUA+JGQvIq0PT8Rr6ciQ5E+QP
	XpXbmLud74W2yG/E5WwLW
X-Google-Smtp-Source: AGHT+IHTdDqy1RlQa0qSMaPoytM7r3Iiu2dONZ4cbSHo6s/eEXtNzmkE22JGoZfCCbSMaVbQf+6Imw==
X-Received: by 2002:a05:6000:2512:b0:3a3:6a2b:ab25 with SMTP id ffacd0b85a97d-3a4cb4834c2mr369511f8f.45.1748025012278;
        Fri, 23 May 2025 11:30:12 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d2d1sm28180695f8f.19.2025.05.23.11.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 11:30:11 -0700 (PDT)
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
Subject: [PATCH 2/5] thermal/drivers: airoha: Generalize probe function
Date: Fri, 23 May 2025 20:29:30 +0200
Message-ID: <20250523182939.30489-3-ansuelsmth@gmail.com>
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

In preparation for support of Airoha AN7583, generalize the probe
function to address for the 2 SoC differece.

Implement a match_data struct where it's possible to define a more
specific probe and post_probe function and specific thermal ops and
pllrg protect value.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/thermal/airoha_thermal.c | 102 +++++++++++++++++++++++--------
 1 file changed, 75 insertions(+), 27 deletions(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index 04bda890dbb1..9bfa59b97032 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -198,12 +198,23 @@ struct airoha_thermal_priv {
 	struct regmap *chip_scu;
 	struct resource scu_adc_res;
 
+	u32 pllrg_protect;
+
 	struct thermal_zone_device *tz;
 	int init_temp;
 	int default_slope;
 	int default_offset;
 };
 
+struct airoha_thermal_soc_data {
+	u32 pllrg_protect;
+
+	const struct thermal_zone_device_ops *thdev_ops;
+	int (*probe)(struct platform_device *pdev,
+		     struct airoha_thermal_priv *priv);
+	int (*post_probe)(struct platform_device *pdev);
+};
+
 static int airoha_get_thermal_ADC(struct airoha_thermal_priv *priv)
 {
 	u32 val;
@@ -220,7 +231,8 @@ static void airoha_init_thermal_ADC_mode(struct airoha_thermal_priv *priv)
 	regmap_read(priv->chip_scu, EN7581_PLLRG_PROTECT, &pllrg);
 
 	/* Give access to thermal regs */
-	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT, EN7581_SCU_THERMAL_PROTECT_KEY);
+	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT,
+		     priv->pllrg_protect);
 	adc_mux = FIELD_PREP(EN7581_MUX_TADC, EN7581_SCU_THERMAL_MUX_DIODE1);
 	regmap_write(priv->chip_scu, EN7581_PWD_TADC, adc_mux);
 
@@ -228,7 +240,7 @@ static void airoha_init_thermal_ADC_mode(struct airoha_thermal_priv *priv)
 	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT, pllrg);
 }
 
-static int airoha_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
+static int en7581_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct airoha_thermal_priv *priv = thermal_zone_device_priv(tz);
 	int min_value, max_value, avg_value, value;
@@ -253,7 +265,7 @@ static int airoha_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 	return 0;
 }
 
-static int airoha_thermal_set_trips(struct thermal_zone_device *tz, int low,
+static int en7581_thermal_set_trips(struct thermal_zone_device *tz, int low,
 				    int high)
 {
 	struct airoha_thermal_priv *priv = thermal_zone_device_priv(tz);
@@ -290,12 +302,12 @@ static int airoha_thermal_set_trips(struct thermal_zone_device *tz, int low,
 	return 0;
 }
 
-static const struct thermal_zone_device_ops thdev_ops = {
-	.get_temp = airoha_thermal_get_temp,
-	.set_trips = airoha_thermal_set_trips,
+static const struct thermal_zone_device_ops en7581_thdev_ops = {
+	.get_temp = en7581_thermal_get_temp,
+	.set_trips = en7581_thermal_set_trips,
 };
 
-static irqreturn_t airoha_thermal_irq(int irq, void *data)
+static irqreturn_t en7581_thermal_irq(int irq, void *data)
 {
 	struct airoha_thermal_priv *priv = data;
 	enum thermal_notify_event event;
@@ -326,7 +338,7 @@ static irqreturn_t airoha_thermal_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void airoha_thermal_setup_adc_val(struct device *dev,
+static void en7581_thermal_setup_adc_val(struct device *dev,
 					 struct airoha_thermal_priv *priv)
 {
 	u32 efuse_calib_info, cpu_sensor;
@@ -356,7 +368,7 @@ static void airoha_thermal_setup_adc_val(struct device *dev,
 	}
 }
 
-static void airoha_thermal_setup_monitor(struct airoha_thermal_priv *priv)
+static void en7581_thermal_setup_monitor(struct airoha_thermal_priv *priv)
 {
 	/* Set measure mode */
 	regmap_write(priv->map, EN7581_TEMPMSRCTL0,
@@ -411,30 +423,26 @@ static void airoha_thermal_setup_monitor(struct airoha_thermal_priv *priv)
 		     FIELD_PREP(EN7581_ADC_POLL_INTVL, 146));
 }
 
-static const struct regmap_config airoha_thermal_regmap_config = {
+static const struct regmap_config en7581_thermal_regmap_config = {
 	.reg_bits		= 32,
 	.reg_stride		= 4,
 	.val_bits		= 32,
 };
 
-static int airoha_thermal_probe(struct platform_device *pdev)
+static int en7581_thermal_probe(struct platform_device *pdev,
+				struct airoha_thermal_priv *priv)
 {
-	struct airoha_thermal_priv *priv;
 	struct device_node *chip_scu_np;
 	struct device *dev = &pdev->dev;
 	void __iomem *base;
 	int irq, ret;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
 	priv->map = devm_regmap_init_mmio(dev, base,
-					  &airoha_thermal_regmap_config);
+					  &en7581_thermal_regmap_config);
 	if (IS_ERR(priv->map))
 		return PTR_ERR(priv->map);
 
@@ -454,18 +462,55 @@ static int airoha_thermal_probe(struct platform_device *pdev)
 		return irq;
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-					airoha_thermal_irq, IRQF_ONESHOT,
+					en7581_thermal_irq, IRQF_ONESHOT,
 					pdev->name, priv);
 	if (ret) {
 		dev_err(dev, "Can't get interrupt working.\n");
 		return ret;
 	}
 
-	airoha_thermal_setup_monitor(priv);
-	airoha_thermal_setup_adc_val(dev, priv);
+	en7581_thermal_setup_monitor(priv);
+	en7581_thermal_setup_adc_val(dev, priv);
+
+	return 0;
+}
+
+static int en7581_thermal_post_probe(struct platform_device *pdev)
+{
+	struct airoha_thermal_priv *priv = platform_get_drvdata(pdev);
+
+	/* Enable LOW and HIGH interrupt (if supported) */
+	regmap_write(priv->map, EN7581_TEMPMONINT,
+		     EN7581_HOFSINTEN0 | EN7581_LOFSINTEN0);
+
+	return 0;
+}
+
+static int airoha_thermal_probe(struct platform_device *pdev)
+{
+	const struct airoha_thermal_soc_data *soc_data;
+	struct airoha_thermal_priv *priv;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	soc_data = device_get_match_data(dev);
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->pllrg_protect = soc_data->pllrg_protect;
+
+	if (!soc_data->probe)
+		return -EINVAL;
+
+	ret = soc_data->probe(pdev, priv);
+	if (ret)
+		return ret;
 
 	/* register of thermal sensor and get info from DT */
-	priv->tz = devm_thermal_of_zone_register(dev, 0, priv, &thdev_ops);
+	priv->tz = devm_thermal_of_zone_register(dev, 0, priv,
+						 soc_data->thdev_ops);
 	if (IS_ERR(priv->tz)) {
 		dev_err(dev, "register thermal zone sensor failed\n");
 		return PTR_ERR(priv->tz);
@@ -473,15 +518,18 @@ static int airoha_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	/* Enable LOW and HIGH interrupt */
-	regmap_write(priv->map, EN7581_TEMPMONINT,
-		     EN7581_HOFSINTEN0 | EN7581_LOFSINTEN0);
-
-	return 0;
+	return soc_data->post_probe ? soc_data->post_probe(pdev) : 0;
 }
 
+static const struct airoha_thermal_soc_data en7581_data = {
+	.pllrg_protect = EN7581_SCU_THERMAL_PROTECT_KEY,
+	.thdev_ops = &en7581_thdev_ops,
+	.probe = &en7581_thermal_probe,
+	.post_probe = &en7581_thermal_post_probe,
+};
+
 static const struct of_device_id airoha_thermal_match[] = {
-	{ .compatible = "airoha,en7581-thermal" },
+	{ .compatible = "airoha,en7581-thermal", .data = &en7581_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, airoha_thermal_match);
-- 
2.48.1


