Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B883E31F13C
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 21:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhBRUmT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 15:42:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54214 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhBRUk3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 15:40:29 -0500
Date:   Thu, 18 Feb 2021 20:39:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613680783;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K3Od5sz0YJKom6NHXKyYyrOguqdyoyE4obOVQPw7Ujw=;
        b=nUStnSgiW8Jpt1nUyV0jAYd4H5cj1pHxWURigRFRAa9/nSGlzu/OsCk3COAMNZubWbD7Po
        +oaq3c80/Wa5aRaUD27tV7We3ms6cCbLGcaW+6gmdYJK/45eG7P0AyRRHQ1rF4PNj8NQyS
        z68IOoTUFZ38KJIZnJV2ZN2rADvtPYB0ppf+N97adBexFPEDg4+Wyb2+6ar92XMh6ecMD3
        3lkW6jGMP0FtEsLCsxS+d/NG5b6dF7ZPu6Z+aBcPNQI0aXUJCU4k/Fbqf3stUa8yR5XmY+
        fraeF0NMzHY6Ha0ONKwGilccL5ChC0PuThGrK/NEoqDaXA4sD8owM32fzAyo8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613680783;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K3Od5sz0YJKom6NHXKyYyrOguqdyoyE4obOVQPw7Ujw=;
        b=2W6MvZzG/UJQWsXA9Zp9KUwHZFW48l7jT9TVgAIhVpa5AU4EerulgRtFz0TH53ntlHYeKi
        DjFTEg397JgTM8DQ==
From:   "thermal-bot for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/zx: Remove zx driver
Cc:     Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210120162400.4115366-3-arnd@kernel.org>
References: <20210120162400.4115366-3-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <161368078238.20312.9576745669575159104.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     73da3f0cca94555d08d62b60ec9b8b9582bc1313
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//73da3f0cca94555d08d62b60ec9b8b9582bc1313
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 20 Jan 2021 17:24:00 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 03 Feb 2021 09:17:47 +01:00

thermal/drivers/zx: Remove zx driver

The zte zx platform is getting removed, so this driver is no
longer needed.

Cc: Jun Nie <jun.nie@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210120162400.4115366-3-arnd@kernel.org
---
 Documentation/devicetree/bindings/thermal/zx2967-thermal.txt | 116 +---
 drivers/thermal/Kconfig                                      |   8 +-
 drivers/thermal/Makefile                                     |   1 +-
 drivers/thermal/zx2967_thermal.c                             | 256 +-------
 4 files changed, 381 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
 delete mode 100644 drivers/thermal/zx2967_thermal.c

diff --git a/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt b/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
deleted file mode 100644
index 3dc1c6b..0000000
--- a/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
+++ /dev/null
@@ -1,116 +0,0 @@
-* ZTE zx2967 family Thermal
-
-Required Properties:
-- compatible: should be one of the following.
-    * zte,zx296718-thermal
-- reg: physical base address of the controller and length of memory mapped
-    region.
-- clocks : Pairs of phandle and specifier referencing the controller's clocks.
-- clock-names: "topcrm" for the topcrm clock.
-	       "apb" for the apb clock.
-- #thermal-sensor-cells: must be 0.
-
-Please note: slope coefficient defined in thermal-zones section need to be
-multiplied by 1000.
-
-Example for tempsensor:
-
-	tempsensor: tempsensor@148a000 {
-		compatible = "zte,zx296718-thermal";
-		reg = <0x0148a000 0x20>;
-		clocks = <&topcrm TEMPSENSOR_GATE>, <&audiocrm AUDIO_TS_PCLK>;
-		clock-names = "topcrm", "apb";
-		#thermal-sensor-cells = <0>;
-	};
-
-Example for cooling device:
-
-	cooling_dev: cooling_dev {
-		cluster0_cooling_dev: cluster0-cooling-dev {
-			#cooling-cells = <2>;
-			cpumask = <0xf>;
-			capacitance = <1500>;
-		};
-
-	cluster1_cooling_dev: cluster1-cooling-dev {
-			#cooling-cells = <2>;
-			cpumask = <0x30>;
-			capacitance = <2000>;
-		};
-	};
-
-Example for thermal zones:
-
-	thermal-zones {
-		zx296718_thermal: zx296718_thermal {
-			polling-delay-passive = <500>;
-			polling-delay = <1000>;
-			sustainable-power = <6500>;
-
-			thermal-sensors = <&tempsensor 0>;
-			/*
-			 * slope need to be multiplied by 1000.
-			 */
-			coefficients = <1951 (-922)>;
-
-			trips {
-				trip0: switch_on_temperature {
-					temperature = <90000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-
-				trip1: desired_temperature {
-					temperature = <100000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-
-				crit: critical_temperature {
-					temperature = <110000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&trip0>;
-					cooling-device = <&gpu 2 5>;
-				};
-
-				map1 {
-					trip = <&trip0>;
-					cooling-device = <&cluster0_cooling_dev 1 2>;
-				};
-
-				map2 {
-					trip = <&trip1>;
-					cooling-device = <&cluster0_cooling_dev 1 2>;
-				};
-
-				map3 {
-					trip = <&crit>;
-					cooling-device = <&cluster0_cooling_dev 1 2>;
-				};
-
-				map4 {
-					trip = <&trip0>;
-					cooling-device = <&cluster1_cooling_dev 1 2>;
-					contribution = <9000>;
-				};
-
-				map5 {
-					trip = <&trip1>;
-					cooling-device = <&cluster1_cooling_dev 1 2>;
-					contribution = <4096>;
-				};
-
-				map6 {
-					trip = <&crit>;
-					cooling-device = <&cluster1_cooling_dev 1 2>;
-					contribution = <4096>;
-				};
-			};
-		};
-	};
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index cf19957..d7f44de 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -467,14 +467,6 @@ depends on (ARCH_QCOM && OF) || COMPILE_TEST
 source "drivers/thermal/qcom/Kconfig"
 endmenu
 
-config ZX2967_THERMAL
-	tristate "Thermal sensors on zx2967 SoC"
-	depends on ARCH_ZX || COMPILE_TEST
-	help
-	  Enable the zx2967 thermal sensors driver, which supports
-	  the primitive temperature sensor embedded in zx2967 SoCs.
-	  This sensor generates the real time die temperature.
-
 config UNIPHIER_THERMAL
 	tristate "Socionext UniPhier thermal driver"
 	depends on ARCH_UNIPHIER || COMPILE_TEST
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index a44dda2..82fc3e6 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -56,7 +56,6 @@ obj-y				+= tegra/
 obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
 obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
 obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
-obj-$(CONFIG_ZX2967_THERMAL)	+= zx2967_thermal.o
 obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
 obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
 obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
diff --git a/drivers/thermal/zx2967_thermal.c b/drivers/thermal/zx2967_thermal.c
deleted file mode 100644
index 8e3a2d3..0000000
--- a/drivers/thermal/zx2967_thermal.c
+++ /dev/null
@@ -1,256 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * ZTE's zx2967 family thermal sensor driver
- *
- * Copyright (C) 2017 ZTE Ltd.
- *
- * Author: Baoyou Xie <baoyou.xie@linaro.org>
- */
-
-#include <linux/clk.h>
-#include <linux/device.h>
-#include <linux/err.h>
-#include <linux/iopoll.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/thermal.h>
-
-/* Power Mode: 0->low 1->high */
-#define ZX2967_THERMAL_POWER_MODE	0
-#define ZX2967_POWER_MODE_LOW		0
-#define ZX2967_POWER_MODE_HIGH		1
-
-/* DCF Control Register */
-#define ZX2967_THERMAL_DCF		0x4
-#define ZX2967_DCF_EN			BIT(1)
-#define ZX2967_DCF_FREEZE		BIT(0)
-
-/* Selection Register */
-#define ZX2967_THERMAL_SEL		0x8
-
-/* Control Register */
-#define ZX2967_THERMAL_CTRL		0x10
-
-#define ZX2967_THERMAL_READY		BIT(12)
-#define ZX2967_THERMAL_TEMP_MASK	GENMASK(11, 0)
-#define ZX2967_THERMAL_ID_MASK		0x18
-#define ZX2967_THERMAL_ID		0x10
-
-#define ZX2967_GET_TEMP_TIMEOUT_US	(100 * 1024)
-
-/**
- * struct zx2967_thermal_priv - zx2967 thermal sensor private structure
- * @tzd: struct thermal_zone_device where the sensor is registered
- * @lock: prevents read sensor in parallel
- * @clk_topcrm: topcrm clk structure
- * @clk_apb: apb clk structure
- * @regs: pointer to base address of the thermal sensor
- * @dev: struct device pointer
- */
-
-struct zx2967_thermal_priv {
-	struct thermal_zone_device	*tzd;
-	struct mutex			lock;
-	struct clk			*clk_topcrm;
-	struct clk			*clk_apb;
-	void __iomem			*regs;
-	struct device			*dev;
-};
-
-static int zx2967_thermal_get_temp(void *data, int *temp)
-{
-	void __iomem *regs;
-	struct zx2967_thermal_priv *priv = data;
-	u32 val;
-	int ret;
-
-	if (!priv->tzd)
-		return -EAGAIN;
-
-	regs = priv->regs;
-	mutex_lock(&priv->lock);
-	writel_relaxed(ZX2967_POWER_MODE_LOW,
-		       regs + ZX2967_THERMAL_POWER_MODE);
-	writel_relaxed(ZX2967_DCF_EN, regs + ZX2967_THERMAL_DCF);
-
-	val = readl_relaxed(regs + ZX2967_THERMAL_SEL);
-	val &= ~ZX2967_THERMAL_ID_MASK;
-	val |= ZX2967_THERMAL_ID;
-	writel_relaxed(val, regs + ZX2967_THERMAL_SEL);
-
-	/*
-	 * Must wait for a while, surely it's a bit odd.
-	 * otherwise temperature value we got has a few deviation, even if
-	 * the THERMAL_READY bit is set.
-	 */
-	usleep_range(100, 300);
-	ret = readx_poll_timeout(readl, regs + ZX2967_THERMAL_CTRL,
-				 val, val & ZX2967_THERMAL_READY, 300,
-				 ZX2967_GET_TEMP_TIMEOUT_US);
-	if (ret) {
-		dev_err(priv->dev, "Thermal sensor data timeout\n");
-		goto unlock;
-	}
-
-	writel_relaxed(ZX2967_DCF_FREEZE | ZX2967_DCF_EN,
-		       regs + ZX2967_THERMAL_DCF);
-	val = readl_relaxed(regs + ZX2967_THERMAL_CTRL)
-			 & ZX2967_THERMAL_TEMP_MASK;
-	writel_relaxed(ZX2967_POWER_MODE_HIGH,
-		       regs + ZX2967_THERMAL_POWER_MODE);
-
-	/*
-	 * Calculate temperature
-	 * In dts, slope is multiplied by 1000.
-	 */
-	*temp = DIV_ROUND_CLOSEST(((s32)val + priv->tzd->tzp->offset) * 1000,
-				  priv->tzd->tzp->slope);
-
-unlock:
-	mutex_unlock(&priv->lock);
-	return ret;
-}
-
-static const struct thermal_zone_of_device_ops zx2967_of_thermal_ops = {
-	.get_temp = zx2967_thermal_get_temp,
-};
-
-static int zx2967_thermal_probe(struct platform_device *pdev)
-{
-	struct zx2967_thermal_priv *priv;
-	struct resource *res;
-	int ret;
-
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(priv->regs))
-		return PTR_ERR(priv->regs);
-
-	priv->clk_topcrm = devm_clk_get(&pdev->dev, "topcrm");
-	if (IS_ERR(priv->clk_topcrm)) {
-		ret = PTR_ERR(priv->clk_topcrm);
-		dev_err(&pdev->dev, "failed to get topcrm clock: %d\n", ret);
-		return ret;
-	}
-
-	ret = clk_prepare_enable(priv->clk_topcrm);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to enable topcrm clock: %d\n",
-			ret);
-		return ret;
-	}
-
-	priv->clk_apb = devm_clk_get(&pdev->dev, "apb");
-	if (IS_ERR(priv->clk_apb)) {
-		ret = PTR_ERR(priv->clk_apb);
-		dev_err(&pdev->dev, "failed to get apb clock: %d\n", ret);
-		goto disable_clk_topcrm;
-	}
-
-	ret = clk_prepare_enable(priv->clk_apb);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to enable apb clock: %d\n",
-			ret);
-		goto disable_clk_topcrm;
-	}
-
-	mutex_init(&priv->lock);
-	priv->tzd = thermal_zone_of_sensor_register(&pdev->dev,
-					0, priv, &zx2967_of_thermal_ops);
-
-	if (IS_ERR(priv->tzd)) {
-		ret = PTR_ERR(priv->tzd);
-		dev_err(&pdev->dev, "failed to register sensor: %d\n", ret);
-		goto disable_clk_all;
-	}
-
-	if (priv->tzd->tzp->slope == 0) {
-		thermal_zone_of_sensor_unregister(&pdev->dev, priv->tzd);
-		dev_err(&pdev->dev, "coefficients of sensor is invalid\n");
-		ret = -EINVAL;
-		goto disable_clk_all;
-	}
-
-	priv->dev = &pdev->dev;
-	platform_set_drvdata(pdev, priv);
-
-	return 0;
-
-disable_clk_all:
-	clk_disable_unprepare(priv->clk_apb);
-disable_clk_topcrm:
-	clk_disable_unprepare(priv->clk_topcrm);
-	return ret;
-}
-
-static int zx2967_thermal_exit(struct platform_device *pdev)
-{
-	struct zx2967_thermal_priv *priv = platform_get_drvdata(pdev);
-
-	thermal_zone_of_sensor_unregister(&pdev->dev, priv->tzd);
-	clk_disable_unprepare(priv->clk_topcrm);
-	clk_disable_unprepare(priv->clk_apb);
-
-	return 0;
-}
-
-static const struct of_device_id zx2967_thermal_id_table[] = {
-	{ .compatible = "zte,zx296718-thermal" },
-	{}
-};
-MODULE_DEVICE_TABLE(of, zx2967_thermal_id_table);
-
-#ifdef CONFIG_PM_SLEEP
-static int zx2967_thermal_suspend(struct device *dev)
-{
-	struct zx2967_thermal_priv *priv = dev_get_drvdata(dev);
-
-	if (priv && priv->clk_topcrm)
-		clk_disable_unprepare(priv->clk_topcrm);
-
-	if (priv && priv->clk_apb)
-		clk_disable_unprepare(priv->clk_apb);
-
-	return 0;
-}
-
-static int zx2967_thermal_resume(struct device *dev)
-{
-	struct zx2967_thermal_priv *priv = dev_get_drvdata(dev);
-	int error;
-
-	error = clk_prepare_enable(priv->clk_topcrm);
-	if (error)
-		return error;
-
-	error = clk_prepare_enable(priv->clk_apb);
-	if (error) {
-		clk_disable_unprepare(priv->clk_topcrm);
-		return error;
-	}
-
-	return 0;
-}
-#endif
-
-static SIMPLE_DEV_PM_OPS(zx2967_thermal_pm_ops,
-			 zx2967_thermal_suspend, zx2967_thermal_resume);
-
-static struct platform_driver zx2967_thermal_driver = {
-	.probe = zx2967_thermal_probe,
-	.remove = zx2967_thermal_exit,
-	.driver = {
-		.name = "zx2967_thermal",
-		.of_match_table = zx2967_thermal_id_table,
-		.pm = &zx2967_thermal_pm_ops,
-	},
-};
-module_platform_driver(zx2967_thermal_driver);
-
-MODULE_AUTHOR("Baoyou Xie <baoyou.xie@linaro.org>");
-MODULE_DESCRIPTION("ZTE zx2967 thermal driver");
-MODULE_LICENSE("GPL v2");
