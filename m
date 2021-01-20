Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666A72FD58E
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 17:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403894AbhATQY7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 11:24:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:44822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403893AbhATQYw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Jan 2021 11:24:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6C4C233ED;
        Wed, 20 Jan 2021 16:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611159851;
        bh=eG3o7RNQNmbbePhK5Y42jmdi078MlD0NNajL0NTLpJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aEp5t3XyG8kpPYLMnw0WxXLMJ7d7GnMlUT11hy7ubdpl3a2vx60XR5YlPjOkjrrMW
         bUsQ4SKcB0EsnH79GZVttDZCIG5foGwysz36mhXvu5KktP5ZUR7XjG+aNvhEIVERpv
         nWqx52wMW6p8/SNtQJaAqAQcE2XxzueoiADypTeKFVlc4Gikjpmh1trOSk80VLHZcX
         KfZFYwl0g6rIlGzOz2msf4MNbmC+xCSvl4NN0EHkUlXKt13tKdHkDQ+Kh+pcVJ3yin
         /ill9o4AwmCApSEUIed7LRdHZiu/5+YL2DEIrMSUdZgGj3+XGllv6BR3Az6UYhDylc
         lS2X1dgt8g5+Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>
Subject: [PATCH 1/2] thermal: remove tango driver
Date:   Wed, 20 Jan 2021 17:23:59 +0100
Message-Id: <20210120162400.4115366-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120162400.4115366-1-arnd@kernel.org>
References: <20210120162400.4115366-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The tango platform is getting removed, so the driver is no
longer needed.

Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc: Mans Rullgard <mans@mansr.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../bindings/thermal/tango-thermal.txt        |  17 ---
 drivers/thermal/Kconfig                       |   9 --
 drivers/thermal/Makefile                      |   1 -
 drivers/thermal/tango_thermal.c               | 126 ------------------
 4 files changed, 153 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/tango-thermal.txt
 delete mode 100644 drivers/thermal/tango_thermal.c

diff --git a/Documentation/devicetree/bindings/thermal/tango-thermal.txt b/Documentation/devicetree/bindings/thermal/tango-thermal.txt
deleted file mode 100644
index 2c918d742867..000000000000
--- a/Documentation/devicetree/bindings/thermal/tango-thermal.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-* Tango Thermal
-
-The SMP8758 SoC includes 3 instances of this temperature sensor
-(in the CPU, video decoder, and PCIe controller).
-
-Required properties:
-- #thermal-sensor-cells: Should be 0 (see Documentation/devicetree/bindings/thermal/thermal-sensor.yaml)
-- compatible: "sigma,smp8758-thermal"
-- reg: Address range of the thermal registers
-
-Example:
-
-	cpu_temp: thermal@920100 {
-		#thermal-sensor-cells = <0>;
-		compatible = "sigma,smp8758-thermal";
-		reg = <0x920100 12>;
-	};
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 7edc8dc6bbab..cf199574c096 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -450,15 +450,6 @@ depends on (ARCH_STI || ARCH_STM32) && OF
 source "drivers/thermal/st/Kconfig"
 endmenu
 
-config TANGO_THERMAL
-	tristate "Tango thermal management"
-	depends on ARCH_TANGO || COMPILE_TEST
-	help
-	  Enable the Tango thermal driver, which supports the primitive
-	  temperature sensor embedded in Tango chips since the SMP8758.
-	  This sensor only generates a 1-bit signal to indicate whether
-	  the die temperature exceeds a programmable threshold.
-
 source "drivers/thermal/tegra/Kconfig"
 
 config GENERIC_ADC_THERMAL
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index b64dd50a6629..a44dda2d03bc 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -42,7 +42,6 @@ obj-y				+= samsung/
 obj-$(CONFIG_DOVE_THERMAL)  	+= dove_thermal.o
 obj-$(CONFIG_DB8500_THERMAL)	+= db8500_thermal.o
 obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
-obj-$(CONFIG_TANGO_THERMAL)	+= tango_thermal.o
 obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
 obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
 obj-$(CONFIG_IMX8MM_THERMAL)	+= imx8mm_thermal.o
diff --git a/drivers/thermal/tango_thermal.c b/drivers/thermal/tango_thermal.c
deleted file mode 100644
index 304b461e12aa..000000000000
--- a/drivers/thermal/tango_thermal.c
+++ /dev/null
@@ -1,126 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-#include <linux/io.h>
-#include <linux/delay.h>
-#include <linux/module.h>
-#include <linux/thermal.h>
-#include <linux/platform_device.h>
-
-/*
- * According to a data sheet draft, "this temperature sensor uses a bandgap
- * type of circuit to compare a voltage which has a negative temperature
- * coefficient with a voltage that is proportional to absolute temperature.
- * A resistor bank allows 41 different temperature thresholds to be selected
- * and the logic output will then indicate whether the actual die temperature
- * lies above or below the selected threshold."
- */
-
-#define TEMPSI_CMD	0
-#define TEMPSI_RES	4
-#define TEMPSI_CFG	8
-
-#define CMD_OFF		0
-#define CMD_ON		1
-#define CMD_READ	2
-
-#define IDX_MIN		15
-#define IDX_MAX		40
-
-struct tango_thermal_priv {
-	void __iomem *base;
-	int thresh_idx;
-};
-
-static bool temp_above_thresh(void __iomem *base, int thresh_idx)
-{
-	writel(CMD_READ | thresh_idx << 8, base + TEMPSI_CMD);
-	usleep_range(10, 20);
-	writel(CMD_READ | thresh_idx << 8, base + TEMPSI_CMD);
-
-	return readl(base + TEMPSI_RES);
-}
-
-static int tango_get_temp(void *arg, int *res)
-{
-	struct tango_thermal_priv *priv = arg;
-	int idx = priv->thresh_idx;
-
-	if (temp_above_thresh(priv->base, idx)) {
-		/* Search upward by incrementing thresh_idx */
-		while (idx < IDX_MAX && temp_above_thresh(priv->base, ++idx))
-			cpu_relax();
-		idx = idx - 1; /* always return lower bound */
-	} else {
-		/* Search downward by decrementing thresh_idx */
-		while (idx > IDX_MIN && !temp_above_thresh(priv->base, --idx))
-			cpu_relax();
-	}
-
-	*res = (idx * 9 / 2 - 38) * 1000; /* millidegrees Celsius */
-	priv->thresh_idx = idx;
-
-	return 0;
-}
-
-static const struct thermal_zone_of_device_ops ops = {
-	.get_temp	= tango_get_temp,
-};
-
-static void tango_thermal_init(struct tango_thermal_priv *priv)
-{
-	writel(0, priv->base + TEMPSI_CFG);
-	writel(CMD_ON, priv->base + TEMPSI_CMD);
-}
-
-static int tango_thermal_probe(struct platform_device *pdev)
-{
-	struct resource *res;
-	struct tango_thermal_priv *priv;
-	struct thermal_zone_device *tzdev;
-
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
-
-	platform_set_drvdata(pdev, priv);
-	priv->thresh_idx = IDX_MIN;
-	tango_thermal_init(priv);
-
-	tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, priv, &ops);
-	return PTR_ERR_OR_ZERO(tzdev);
-}
-
-static int __maybe_unused tango_thermal_resume(struct device *dev)
-{
-	tango_thermal_init(dev_get_drvdata(dev));
-	return 0;
-}
-
-static SIMPLE_DEV_PM_OPS(tango_thermal_pm, NULL, tango_thermal_resume);
-
-static const struct of_device_id tango_sensor_ids[] = {
-	{
-		.compatible = "sigma,smp8758-thermal",
-	},
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, tango_sensor_ids);
-
-static struct platform_driver tango_thermal_driver = {
-	.probe	= tango_thermal_probe,
-	.driver	= {
-		.name		= "tango-thermal",
-		.of_match_table	= tango_sensor_ids,
-		.pm		= &tango_thermal_pm,
-	},
-};
-
-module_platform_driver(tango_thermal_driver);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Sigma Designs");
-MODULE_DESCRIPTION("Tango temperature sensor");
-- 
2.29.2

