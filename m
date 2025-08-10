Return-Path: <linux-pm+bounces-32090-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDEDB1F9DE
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 14:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398C618990CA
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 12:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655292571BF;
	Sun, 10 Aug 2025 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="J5NXatVa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBF825487C
	for <linux-pm@vger.kernel.org>; Sun, 10 Aug 2025 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754828507; cv=none; b=ZNFIb3jTD/eqHQnPC3FOwPP92LXXYe5L0JXSiZTkVAIxYLpEdPP24xyYQjy4oXO3JLrHetpsf+xCu1XrGV4bcQcl1eXCUUVrnoUcqmnpJM+RL9LeehMXYRywJW8qMGEaaY65CxvWlMAq1B5XHZfNuowZxUwVe2YRoDpXi+d6zQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754828507; c=relaxed/simple;
	bh=eVLm2U269XumSG3XgvntSsO2YYsq6hp31WlhS7tB+zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4rK54FrSrzzqjnNj32R5Rm0hto9ReknG9zrODlJWi7cMAoMgvDOdVFAKjgisr+WhZ4Ucj3eu8jeEYrjFRwLZ87LwFuHMXr3kS75+ZW9hMsycq3q16ST/wBcU+pcUifeAZLvosm7wOpESr+agWp6j7M6m0XNHbb8TLKaBhG2c+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=J5NXatVa; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61576e33ce9so5941024a12.1
        for <linux-pm@vger.kernel.org>; Sun, 10 Aug 2025 05:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754828503; x=1755433303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSIoAiRkeCiVdjvRg5o5xYC0Mu/JS62yEqRPIFbE2nk=;
        b=J5NXatVaNYpLMoArTTw422P/kOrcP6gQnAJ8Xs7JVStZ3fr6uxD6OHyc2e1xid6tQp
         wNFol1VkDVKvWieq0f+l2adWXMNzSLVueWP+Rb0+cg3Wxo2qyL37WphlR6m673JQxixK
         jCqIG1TG8vBN8HIx4aykN2SN+GliA0lQsM5ZxaGiw9ruGgIXta2fndqTRAjf8c+FXDE3
         hMkTiJUU6jzq5zIxnV4/NXmY0VeHHFGx5WfVxs/4MBw5/sGS+Hsje8jsUNxvRzzriTyG
         boZoDYmHgXC4G5KkDemDhgd+fOcWFEeQvcJwfVGHqtHEp+sLd3hW4ZOJe9XhwS0nS/iy
         Ebiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754828503; x=1755433303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSIoAiRkeCiVdjvRg5o5xYC0Mu/JS62yEqRPIFbE2nk=;
        b=iu2EPpN75YHxopLglxxdy5FreRnYdYbCV+so8Ispxpmpn/wdnB+m88Zvccc7mJ8e5H
         bb64dE23whLdaUV9wqHZnClHpVQe1Yp4BDQ84OLQ5V+mQJf1LMuuwkVAyLY0ghWfqmDS
         U3/Mmb+ZlSKNj/pwFSDTz7uWNZcnrPC8ajPGocxBfivu5MivRhtazXvjDhbwK0uoKNvT
         PxBKacv9K6ocPAYo+HKmqzATsoOmfe5N6zG8WpyeoCFmeDTDPR+vinF3GU+IgoPHF8Yt
         T38OYxAC1g1gykqFWafMqOMfE1AZ//LDojtWk2e4ShQ7+ab/pHcbeQu1wW8jiVv1XA8o
         P0lw==
X-Forwarded-Encrypted: i=1; AJvYcCWMTkU+3jsKruNEzKq09PmfEAoiDbxJzPqDKO2Rqb35JanK8nezT7K6IdpzjaEOcDF4FjviF6xfng==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVhj7AO7CnuN2fKwmlmF5jAColrlGFwRCWekby2XRRKlNYI1fO
	uW+zfcA54Uroy4WzR0A81r6dEdW9VI8V0qt0BCks7Ov/5ZtTfWnOBoSauT6fiFXfCHw=
X-Gm-Gg: ASbGncsWkRZCqxWjgXgThvFQAvIikQwpfO3lGIq25HU8aHa6MGVRzvNs87G9OyeU03u
	f5xf/7DNTZMTXrEpZZMju9r3mYwSqaE9zFWNQrcMTwDMvW/V2Uc02eg6+ocAUDgjug44CeCaT6o
	hF5+uxLKWyn0KZHWaTrkCMvDt2F++pkKo03rVZuQzUu6oVhBxgdN5RdpA3S9lEnUh4+PWG3BoUd
	OS7vWwngBv4KYmlfCFw2jL/jYecnYDwN1/bmnhnQflo8sBPFkAd1bs+CzqGfivajTqvHRW9uT1b
	4LiwsJRmXJuMybHFVC1N5H+IWFIysz7AIUfDSs+OyFwCKDrSAWmgiZsaR4uRwYKoGYYpPhWTXGp
	F27BEV1aSeSWjjEY1syNfMv7dOis4R6gHwRjQ5tM+WCQi2yy0bQR6
X-Google-Smtp-Source: AGHT+IH5RURJU8R/hsLnDWgzAx6PvtOkN47A4VFJLp9lM4F+ZQqiRcrQBh8JqURs+51qrv0pfZ+GwA==
X-Received: by 2002:a50:9ece:0:b0:615:7e88:ef95 with SMTP id 4fb4d7f45d1cf-617b37dab62mr7345070a12.11.1754828503499;
        Sun, 10 Aug 2025 05:21:43 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a86758fcsm16611897a12.0.2025.08.10.05.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 05:21:43 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	niklas.soderlund@ragnatech.se,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 2/4] thermal: renesas: rzg3s: Add thermal driver for the Renesas RZ/G3S SoC
Date: Sun, 10 Aug 2025 15:21:23 +0300
Message-ID: <20250810122125.792966-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250810122125.792966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250810122125.792966-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The Renesas RZ/G3S SoC features a Thermal Sensor Unit (TSU) that reports
the junction temperature. The temperature is reported through a dedicated
ADC channel. Add a driver for the Renesas RZ/G3S TSU.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- dropped devres_group_id along with its code, as now the issue is fixed
  by [3] which was integrated
- in rzg3s_thermal_get_temp():
-- moved val, ret declaration in for block as it is used only there
-- dropped ret = 0 and return 0 directly instead
-- use div_s64()
- added HW manual revision in citations
- s/mili/milli/g
- dropped pm_runtime_mark_last_busy() as now it is embedded in
  pm_runtime_put_autosuspend()
- changed driver name into "rzg3s-thermal"


Changes in v3:
- drop the runtime resume/suspend from rzg3s_thermal_get_temp(); this
  is not needed as the temperature is read with ADC
- opened the devres group id in rzg3s_thermal_probe() and rename
  previsouly rzg3s_thermal_probe() to rzg3s_thermal_probe_helper(), to
  have simpler code; this approach was suggested by Jonathan in [1];
  as there is no positive feedback for the generic solution [2] this
  looks currently the best approach

[1] https://lore.kernel.org/all/20250224120608.1769039-2-claudiu.beznea.uj@bp.renesas.com
[2] https://lore.kernel.org/all/20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com
[3] https://lore.kernel.org/all/20250703112708.1621607-1-claudiu.beznea.uj@bp.renesas.com/

Changes in v2:
- use a devres group for the devm resources obtained though this
  driver to avoid issue described in [1]; with this dropped the
  following calls:
-- thermal_add_hwmon_sysfs(priv->tz);
-- thermal_of_zone_register(priv->tz);
-- pm_runtime_enable(priv->dev);
  and use devm variants
- used signed variables for temperature computation
- convert to mili degree Celsius before applying the computation formula
  to avoid losing precision

[1] https://lore.kernel.org/all/20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com/

 MAINTAINERS                             |   7 +
 drivers/thermal/renesas/Kconfig         |   8 +
 drivers/thermal/renesas/Makefile        |   1 +
 drivers/thermal/renesas/rzg3s_thermal.c | 272 ++++++++++++++++++++++++
 4 files changed, 288 insertions(+)
 create mode 100644 drivers/thermal/renesas/rzg3s_thermal.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e80494f93dbc..bc63bcd0e670 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21544,6 +21544,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
 F:	drivers/iio/potentiometer/x9250.c
 
+RENESAS RZ/G3S THERMAL SENSOR UNIT DRIVER
+M:	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
+F:	drivers/thermal/renesas/rzg3s_thermal.c
+
 RESET CONTROLLER FRAMEWORK
 M:	Philipp Zabel <p.zabel@pengutronix.de>
 S:	Maintained
diff --git a/drivers/thermal/renesas/Kconfig b/drivers/thermal/renesas/Kconfig
index dcf5fc5ae08e..566478797095 100644
--- a/drivers/thermal/renesas/Kconfig
+++ b/drivers/thermal/renesas/Kconfig
@@ -26,3 +26,11 @@ config RZG2L_THERMAL
 	help
 	  Enable this to plug the RZ/G2L thermal sensor driver into the Linux
 	  thermal framework.
+
+config RZG3S_THERMAL
+	tristate "Renesas RZ/G3S thermal driver"
+	depends on ARCH_R9A08G045 || COMPILE_TEST
+	depends on OF && IIO && RZG2L_ADC
+	help
+	  Enable this to plug the RZ/G3S thermal sensor driver into the Linux
+	  thermal framework.
diff --git a/drivers/thermal/renesas/Makefile b/drivers/thermal/renesas/Makefile
index bf9cb3cb94d6..1feb5ab78827 100644
--- a/drivers/thermal/renesas/Makefile
+++ b/drivers/thermal/renesas/Makefile
@@ -3,3 +3,4 @@
 obj-$(CONFIG_RCAR_GEN3_THERMAL)	+= rcar_gen3_thermal.o
 obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
 obj-$(CONFIG_RZG2L_THERMAL)	+= rzg2l_thermal.o
+obj-$(CONFIG_RZG3S_THERMAL)	+= rzg3s_thermal.o
diff --git a/drivers/thermal/renesas/rzg3s_thermal.c b/drivers/thermal/renesas/rzg3s_thermal.c
new file mode 100644
index 000000000000..e25e36c99a88
--- /dev/null
+++ b/drivers/thermal/renesas/rzg3s_thermal.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G3S TSU Thermal Sensor Driver
+ *
+ * Copyright (C) 2024 Renesas Electronics Corporation
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/iio/consumer.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/thermal.h>
+#include <linux/units.h>
+
+#include "../thermal_hwmon.h"
+
+#define TSU_SM			0x0
+#define TSU_SM_EN		BIT(0)
+#define TSU_SM_OE		BIT(1)
+#define OTPTSUTRIM_REG(n)	(0x18 + (n) * 0x4)
+#define OTPTSUTRIM_EN_MASK	BIT(31)
+#define OTPTSUTRIM_MASK		GENMASK(11, 0)
+
+#define TSU_READ_STEPS		8
+
+/* Default calibration values, if FUSE values are missing. */
+#define SW_CALIB0_VAL		1297
+#define SW_CALIB1_VAL		751
+
+#define MCELSIUS(temp)		((temp) * MILLIDEGREE_PER_DEGREE)
+
+/**
+ * struct rzg3s_thermal_priv - RZ/G3S thermal private data structure
+ * @base: TSU base address
+ * @dev: device pointer
+ * @tz: thermal zone pointer
+ * @rstc: reset control
+ * @channel: IIO channel to read the TSU
+ * @mode: current device mode
+ * @calib0: calibration value
+ * @calib1: calibration value
+ */
+struct rzg3s_thermal_priv {
+	void __iomem *base;
+	struct device *dev;
+	struct thermal_zone_device *tz;
+	struct reset_control *rstc;
+	struct iio_channel *channel;
+	enum thermal_device_mode mode;
+	u16 calib0;
+	u16 calib1;
+};
+
+static int rzg3s_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct rzg3s_thermal_priv *priv = thermal_zone_device_priv(tz);
+	int ts_code_ave = 0;
+
+	if (priv->mode != THERMAL_DEVICE_ENABLED)
+		return -EAGAIN;
+
+	for (u8 i = 0; i < TSU_READ_STEPS; i++) {
+		int ret, val;
+
+		ret = iio_read_channel_raw(priv->channel, &val);
+		if (ret < 0)
+			return ret;
+
+		ts_code_ave += val;
+		/*
+		 * According to the HW manual (Rev.1.10, section 40.4.4 Procedure for Measuring
+		 * the Temperature) we need to wait here at leat 3us.
+		 */
+		usleep_range(5, 10);
+	}
+
+	ts_code_ave = DIV_ROUND_CLOSEST(MCELSIUS(ts_code_ave), TSU_READ_STEPS);
+
+	/*
+	 * According to the HW manual (Rev.1.10, section 40.4.4 Procedure for Measuring the
+	 * Temperature) the computation formula is as follows:
+	 *
+	 * Tj = (ts_code_ave - priv->calib1) * 165 / (priv->calib0 - priv->calib1) - 40
+	 *
+	 * Convert everything to milli Celsius before applying the formula to avoid
+	 * losing precision.
+	 */
+
+	*temp = div_s64((s64)(ts_code_ave - MCELSIUS(priv->calib1)) * MCELSIUS(165),
+			MCELSIUS(priv->calib0 - priv->calib1)) - MCELSIUS(40);
+
+	/* Report it in milli degrees Celsius and round it up to 0.5 degrees Celsius. */
+	*temp = roundup(*temp, 500);
+
+	return 0;
+}
+
+static void rzg3s_thermal_set_mode(struct rzg3s_thermal_priv *priv,
+				   enum thermal_device_mode mode)
+{
+	struct device *dev = priv->dev;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return;
+
+	if (mode == THERMAL_DEVICE_DISABLED) {
+		writel(0, priv->base + TSU_SM);
+	} else {
+		writel(TSU_SM_EN, priv->base + TSU_SM);
+		/*
+		 * According to the HW manual (Rev.1.10, section 40.4.1 Procedure for
+		 * Starting the TSU) we need to wait here 30us or more.
+		 */
+		usleep_range(30, 40);
+
+		writel(TSU_SM_OE | TSU_SM_EN, priv->base + TSU_SM);
+		/*
+		 * According to the HW manual (Rev.1.10, section 40.4.1 Procedure for
+		 * Starting the TSU) we need to wait here 50us or more.
+		 */
+		usleep_range(50, 60);
+	}
+
+	pm_runtime_put_autosuspend(dev);
+}
+
+static int rzg3s_thermal_change_mode(struct thermal_zone_device *tz,
+				     enum thermal_device_mode mode)
+{
+	struct rzg3s_thermal_priv *priv = thermal_zone_device_priv(tz);
+
+	if (priv->mode == mode)
+		return 0;
+
+	rzg3s_thermal_set_mode(priv, mode);
+	priv->mode = mode;
+
+	return 0;
+}
+
+static const struct thermal_zone_device_ops rzg3s_tz_of_ops = {
+	.get_temp = rzg3s_thermal_get_temp,
+	.change_mode = rzg3s_thermal_change_mode,
+};
+
+static int rzg3s_thermal_read_calib(struct rzg3s_thermal_priv *priv)
+{
+	struct device *dev = priv->dev;
+	u32 val;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	val = readl(priv->base + OTPTSUTRIM_REG(0));
+	if (val & OTPTSUTRIM_EN_MASK)
+		priv->calib0 = FIELD_GET(OTPTSUTRIM_MASK, val);
+	else
+		priv->calib0 = SW_CALIB0_VAL;
+
+	val = readl(priv->base + OTPTSUTRIM_REG(1));
+	if (val & OTPTSUTRIM_EN_MASK)
+		priv->calib1 = FIELD_GET(OTPTSUTRIM_MASK, val);
+	else
+		priv->calib1 = SW_CALIB1_VAL;
+
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+}
+
+static int rzg3s_thermal_probe(struct platform_device *pdev)
+{
+	struct rzg3s_thermal_priv *priv;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->channel = devm_iio_channel_get(dev, "tsu");
+	if (IS_ERR(priv->channel))
+		return dev_err_probe(dev, PTR_ERR(priv->channel), "Failed to get IIO channel!\n");
+
+	priv->rstc = devm_reset_control_get_exclusive_deasserted(dev, NULL);
+	if (IS_ERR(priv->rstc))
+		return dev_err_probe(dev, PTR_ERR(priv->rstc), "Failed to get reset!\n");
+
+	priv->dev = dev;
+	priv->mode = THERMAL_DEVICE_DISABLED;
+	platform_set_drvdata(pdev, priv);
+
+	pm_runtime_set_autosuspend_delay(dev, 300);
+	pm_runtime_use_autosuspend(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable runtime PM!\n");
+
+	ret = rzg3s_thermal_read_calib(priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read calibration data!\n");
+
+	priv->tz = devm_thermal_of_zone_register(dev, 0, priv, &rzg3s_tz_of_ops);
+	if (IS_ERR(priv->tz))
+		return dev_err_probe(dev, PTR_ERR(priv->tz), "Failed to register thermal zone!\n");
+
+	ret = devm_thermal_add_hwmon_sysfs(dev, priv->tz);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add hwmon sysfs!\n");
+
+	return 0;
+}
+
+static int rzg3s_thermal_suspend(struct device *dev)
+{
+	struct rzg3s_thermal_priv *priv = dev_get_drvdata(dev);
+
+	rzg3s_thermal_set_mode(priv, THERMAL_DEVICE_DISABLED);
+
+	return reset_control_assert(priv->rstc);
+}
+
+static int rzg3s_thermal_resume(struct device *dev)
+{
+	struct rzg3s_thermal_priv *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = reset_control_deassert(priv->rstc);
+	if (ret)
+		return ret;
+
+	if (priv->mode != THERMAL_DEVICE_DISABLED)
+		rzg3s_thermal_set_mode(priv, priv->mode);
+
+	return 0;
+}
+
+static const struct dev_pm_ops rzg3s_thermal_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(rzg3s_thermal_suspend, rzg3s_thermal_resume)
+};
+
+static const struct of_device_id rzg3s_thermal_dt_ids[] = {
+	{ .compatible = "renesas,r9a08g045-tsu" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rzg3s_thermal_dt_ids);
+
+static struct platform_driver rzg3s_thermal_driver = {
+	.driver = {
+		.name = "rzg3s-thermal",
+		.of_match_table = rzg3s_thermal_dt_ids,
+		.pm = pm_ptr(&rzg3s_thermal_pm_ops),
+	},
+	.probe = rzg3s_thermal_probe,
+};
+module_platform_driver(rzg3s_thermal_driver);
+
+MODULE_DESCRIPTION("Renesas RZ/G3S Thermal Sensor Unit Driver");
+MODULE_AUTHOR("Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>");
+MODULE_LICENSE("GPL");
-- 
2.43.0


