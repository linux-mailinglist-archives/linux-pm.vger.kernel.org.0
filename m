Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3640431F13D
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 21:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhBRUmV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 15:42:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54234 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbhBRUka (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 15:40:30 -0500
Date:   Thu, 18 Feb 2021 20:39:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613680783;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MeuaiWuDOQzrRBW00NxD8EaHHaRJX4D+c4f1z69XVwA=;
        b=hAIFvq9hSGb3VArE7RZvwTe19EpAC2pH1yHT/5Yz48qyPBK4OhObwQHmTWbvzxyv2wBcLb
        P8LmoZG1l0VpNzUz1F2EpL4bGFmSMGFAI7mZSiYUPejzx7nxMmtjz12VckLIDEOqHMFBPC
        AQacLMKpq5wgMyTK46+c1ux2blVcyhTBucgViahiujJgS3au9TdX72gXo5lsIBV2i2CjPX
        CSfV8pQ+diKGwRYypptbKbYr6w2Cg+WyQFS/w2RbwxRYZbmPOM1Akf5g/tIehgqXETVB/2
        2E7V4In+iONlCxGHMQyGlcJwvOvvV4lKXgjA86yrwapKtfXwc/T3PdK86W5WYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613680783;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MeuaiWuDOQzrRBW00NxD8EaHHaRJX4D+c4f1z69XVwA=;
        b=Lkl+VZ9vhlJ8dF+/jR+0HncP1Y0Xfkw1+iLUc7fqCWdBbrSVq7365oymT9yGypKhDwLGc3
        o5PKDHQnEJ/2cQBg==
From:   "thermal-bot for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/tango: Remove tango driver
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210120162400.4115366-2-arnd@kernel.org>
References: <20210120162400.4115366-2-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <161368078267.20312.12142195009360169335.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     8fefe3ce6b7d11a551d98557d5dfc5eba6477409
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//8fefe3ce6b7d11a551d98557d5dfc5eba6477409
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 20 Jan 2021 17:23:59 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 03 Feb 2021 09:16:54 +01:00

thermal/drivers/tango: Remove tango driver

The tango platform is getting removed, so the driver is no
longer needed.

Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc: Mans Rullgard <mans@mansr.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Mans Rullgard <mans@mansr.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210120162400.4115366-2-arnd@kernel.org
---
 Documentation/devicetree/bindings/thermal/tango-thermal.txt |  17 +-
 drivers/thermal/Kconfig                                     |   9 +-
 drivers/thermal/Makefile                                    |   1 +-
 drivers/thermal/tango_thermal.c                             | 126 +-------
 4 files changed, 153 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/tango-thermal.txt
 delete mode 100644 drivers/thermal/tango_thermal.c

diff --git a/Documentation/devicetree/bindings/thermal/tango-thermal.txt b/Documentation/devicetree/bindings/thermal/tango-thermal.txt
deleted file mode 100644
index 2c918d7..0000000
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
index 7edc8dc..cf19957 100644
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
index b64dd50..a44dda2 100644
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
index 304b461..0000000
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
