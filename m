Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89CE67C0E6
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 14:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfGaMOp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 08:14:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52283 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbfGaMOR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 08:14:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so60541063wms.2
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 05:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2GI3WROr9PL26mrpDFVBlnpN8oY0cW4cXyUuX6sB6nw=;
        b=xL9zu1narbapY5n1BST9kQofAhW6fysxknqJW3CPJMFUqHrvtzTn3J5tHdOvdWbEio
         xhYqPGYY543Da/xxFfDHQPcW3KtHBlR5Eg0xPiLY7g5k9bAiuSDXrRJX8QmY6a94/QTW
         26anVxSCk4vIwtPfImAp0ugIWkTTg+OkJMNzPcAhZ7oLNY+8OLoEPoYQ3r0+skwKw8be
         Q4yNbYMitUP9m0fwAJIoSpRK5gpgikwgtYn7smAZxilO/hltI+vgeBMRvf2FbMqzzUZ9
         gFo9kMKfRGslFMk5+6TR1dlKyha/ojcvFrXcRJxpTYq1DChnl25EuoVuPtPfMlHCg+gd
         uXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2GI3WROr9PL26mrpDFVBlnpN8oY0cW4cXyUuX6sB6nw=;
        b=IPsSegzv6OOu4O59j8ERMr7DVMJZABojRfnQWXbBy5oC4YTkI032cO8ihec4D4moLU
         g/CIqGrskapbbDzW4Y7xz/bAX6Qb11fCve/8ssD7tLNsJJtF9s6nRa0T0EBWkxtMvIIq
         UWhs9AkJcRrLjuseJH5DLk+erRmHp+V/GoAVfxFn0vi24iI0N9/POlEuoUyipv1ZQl9h
         r8f2zCT6nzQcLrQz1i5rlrwnWP9V/LLIgwOQFf3Qbbo6qxvaU0GSmGLhbujC72HqmPz9
         XRzAZiSejgMr/Db+cxczFZByTnBtFGcgn4+LB7LrY554nIYg+mCDEtNy/DWqfFyjydi0
         OEkg==
X-Gm-Message-State: APjAAAVzYnF3eKWXy6Ze+sqQbVbvJX4SkKmudsjksmpmPX0+9BvJxm52
        2XPogtpEvFXsBlT/D1R+WokW5g==
X-Google-Smtp-Source: APXvYqxgHTYrDDcBXZ5CHzL04lHb6W+8B/+GIKHNhQOWL7jnCk3gpn+BVpyUE9zHfCp6xRhz3AymXQ==
X-Received: by 2002:a1c:e710:: with SMTP id e16mr113970351wmh.38.1564575255337;
        Wed, 31 Jul 2019 05:14:15 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a64sm3613713wmf.1.2019.07.31.05.14.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:14:14 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     daniel.lezcano@linaro.org, khilman@baylibre.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/6] thermal: amlogic: Add thermal driver to support G12 SoCs
Date:   Wed, 31 Jul 2019 14:14:05 +0200
Message-Id: <20190731121409.17285-3-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731121409.17285-1-glaroque@baylibre.com>
References: <20190731121409.17285-1-glaroque@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 drivers/thermal/Kconfig           |  12 +-
 drivers/thermal/Makefile          |   1 +
 drivers/thermal/amlogic_thermal.c | 335 ++++++++++++++++++++++++++++++
 3 files changed, 347 insertions(+), 1 deletion(-)
 create mode 100644 drivers/thermal/amlogic_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 9966364a6deb..2332ef1bfafc 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -1,4 +1,3 @@
-# SPDX-License-Identifier: GPL-2.0-only
 #
 # Generic thermal sysfs drivers configuration
 #
@@ -348,6 +347,17 @@ config MTK_THERMAL
 	  Enable this option if you want to have support for thermal management
 	  controller present in Mediatek SoCs
 
+config AMLOGIC_THERMAL
+	tristate "Amlogic Thermal Support"
+	default ARCH_MESON
+	depends on OF && ARCH_MESON
+	help
+	  If you say yes here you get support for Amlogic Thermal
+	  for G12 SoC Family.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called amlogic_thermal.
+
 menu "Intel thermal drivers"
 depends on X86 || X86_INTEL_QUARK || COMPILE_TEST
 source "drivers/thermal/intel/Kconfig"
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 74a37c7f847a..baeb70bf0568 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -54,3 +54,4 @@ obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
 obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
 obj-$(CONFIG_ZX2967_THERMAL)	+= zx2967_thermal.o
 obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
+obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
new file mode 100644
index 000000000000..6b6d62326725
--- /dev/null
+++ b/drivers/thermal/amlogic_thermal.c
@@ -0,0 +1,335 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Amlogic Meson Thermal Sensor Driver
+ *
+ * Copyright (C) 2017 Huan Biao <huan.biao@amlogic.com>
+ * Copyright (C) 2019 Guillaume La Roque <glaroque@baylibre.com>
+ *
+ * Register value to celsius temperature formulas:
+ *	Read_Val	    m * U
+ * U = ---------, Uptat = ---------
+ *	2^16		  1 + n * U
+ *
+ * Temperature = A * ( Uptat + u_efuse / 2^16 )- B
+ *
+ *  A B m n : calibration parameters
+ *  u_efuse : fused calibration value, it's a signed 16 bits value
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/thermal.h>
+
+#include "thermal_core.h"
+
+#define TSENSOR_CFG_REG1			0x4
+	#define TSENSOR_CFG_REG1_RSET_VBG	BIT(12)
+	#define TSENSOR_CFG_REG1_RSET_ADC	BIT(11)
+	#define TSENSOR_CFG_REG1_VCM_EN		BIT(10)
+	#define TSENSOR_CFG_REG1_VBG_EN		BIT(9)
+	#define TSENSOR_CFG_REG1_OUT_CTL	BIT(6)
+	#define TSENSOR_CFG_REG1_FILTER_EN	BIT(5)
+	#define TSENSOR_CFG_REG1_DEM_EN		BIT(3)
+	#define TSENSOR_CFG_REG1_CH_SEL		GENMASK(1, 0)
+	#define TSENSOR_CFG_REG1_ENABLE		\
+		(TSENSOR_CFG_REG1_FILTER_EN |	\
+		 TSENSOR_CFG_REG1_VCM_EN |	\
+		 TSENSOR_CFG_REG1_VBG_EN |	\
+		 TSENSOR_CFG_REG1_DEM_EN |	\
+		 TSENSOR_CFG_REG1_CH_SEL)
+
+#define TSENSOR_STAT0			0x40
+
+#define TSENSOR_STAT9			0x64
+
+#define TSENSOR_READ_TEMP_MASK		GENMASK(15, 0)
+#define TSENSOR_TEMP_MASK		GENMASK(11, 0)
+
+#define TSENSOR_TRIM_SIGN_MASK		BIT(15)
+#define TSENSOR_TRIM_TEMP_MASK		GENMASK(14, 0)
+#define TSENSOR_TRIM_VERSION_MASK	GENMASK(31, 24)
+
+#define TSENSOR_TRIM_VERSION(_version)	\
+	FIELD_GET(TSENSOR_TRIM_VERSION_MASK, _version)
+
+#define TSENSOR_TRIM_CALIB_VALID_MASK	(GENMASK(3, 2) | BIT(7))
+
+#define TSENSOR_CALIB_OFFSET	1
+#define TSENSOR_CALIB_SHIFT	4
+
+/**
+ * struct amlogic_thermal_soc_data
+ * @A, B, m, n: calibration parameters
+ * This structure is required for configuration of amlogic thermal driver.
+ */
+struct amlogic_thermal_soc_data {
+	int A;
+	int B;
+	int m;
+	int n;
+};
+
+/**
+ * struct amlogic_thermal_data
+ * @u_efuse_off: register offset to read fused calibration value
+ * @soc: calibration parameters structure pointer
+ * @regmap_config: regmap config for the device
+ * This structure is required for configuration of amlogic thermal driver.
+ */
+struct amlogic_thermal_data {
+	int id;
+	int u_efuse_off;
+	const struct amlogic_thermal_soc_data *soc;
+	const struct regmap_config *regmap_config;
+};
+
+struct amlogic_thermal {
+	struct platform_device *pdev;
+	const struct amlogic_thermal_data *data;
+	struct regmap *regmap;
+	struct regmap *sec_ao_map;
+	struct clk *clk;
+	struct thermal_zone_device *tzd;
+	u32 trim_info;
+	void __iomem *base;
+};
+
+/*
+ * Calculate a temperature value from a temperature code.
+ * The unit of the temperature is degree Celsius.
+ */
+static int code_to_temp(struct amlogic_thermal *pdata, int temp_code)
+{
+	const struct amlogic_thermal_soc_data *param = pdata->data->soc;
+	int temp;
+	s64 factor, Uptat, uefuse;
+
+	uefuse = pdata->trim_info & TSENSOR_TRIM_SIGN_MASK ?
+			     ~(pdata->trim_info & TSENSOR_TRIM_TEMP_MASK) + 1 :
+			     (pdata->trim_info & TSENSOR_TRIM_TEMP_MASK);
+
+	factor = param->n * temp_code;
+	factor = div_s64(factor, 100);
+
+	Uptat = temp_code * param->m;
+	Uptat = div_s64(Uptat, 100);
+	Uptat = Uptat * BIT(16);
+	Uptat = div_s64(Uptat, BIT(16) + factor);
+
+	temp = (Uptat + uefuse) * param->A;
+	temp = div_s64(temp, BIT(16));
+	temp = (temp - param->B) * 100;
+
+	return temp;
+}
+
+static int amlogic_thermal_initialize(struct amlogic_thermal *pdata)
+{
+	int ret = 0;
+	int ver;
+
+	regmap_read(pdata->sec_ao_map, pdata->data->u_efuse_off,
+		    &pdata->trim_info);
+
+	ver = TSENSOR_TRIM_VERSION(pdata->trim_info);
+
+	if ((ver & TSENSOR_TRIM_CALIB_VALID_MASK) == 0) {
+		ret = -EINVAL;
+		dev_err(&pdata->pdev->dev,
+			"tsensor thermal calibration not supported: 0x%x!\n",
+			ver);
+	}
+
+	return ret;
+}
+
+static int amlogic_thermal_enable(struct amlogic_thermal *data)
+{
+	clk_prepare_enable(data->clk);
+	regmap_update_bits(data->regmap, TSENSOR_CFG_REG1,
+			   TSENSOR_CFG_REG1_ENABLE, TSENSOR_CFG_REG1_ENABLE);
+
+	return 0;
+}
+
+static int amlogic_thermal_disable(struct amlogic_thermal *data)
+{
+	regmap_update_bits(data->regmap, TSENSOR_CFG_REG1,
+			   TSENSOR_CFG_REG1_ENABLE, 0);
+	clk_disable(data->clk);
+
+	return 0;
+}
+
+static int amlogic_thermal_get_temp(void *data, int *temp)
+{
+	unsigned int tvalue;
+	struct amlogic_thermal *pdata = data;
+
+	if (!data)
+		return -EINVAL;
+
+	regmap_read(pdata->regmap, TSENSOR_STAT0, &tvalue);
+	*temp = code_to_temp(pdata,
+			     tvalue & TSENSOR_READ_TEMP_MASK);
+
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops amlogic_thermal_ops = {
+	.get_temp	= amlogic_thermal_get_temp,
+};
+
+static const struct regmap_config amlogic_thermal_regmap_config_g12 = {
+	.reg_bits = 8,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = TSENSOR_STAT9,
+};
+
+static const struct amlogic_thermal_soc_data amlogic_thermal_g12 = {
+	.A = 9411,
+	.B = 3159,
+	.m = 424,
+	.n = 324,
+};
+
+static const struct amlogic_thermal_data amlogic_thermal_g12_cpu_param = {
+	.id = 0,
+	.u_efuse_off = 0x128,
+	.soc = &amlogic_thermal_g12,
+	.regmap_config = &amlogic_thermal_regmap_config_g12,
+};
+
+static const struct amlogic_thermal_data amlogic_thermal_g12_ddr_param = {
+	.id = 1,
+	.u_efuse_off = 0xF0,
+	.soc = &amlogic_thermal_g12,
+	.regmap_config = &amlogic_thermal_regmap_config_g12,
+};
+
+static const struct of_device_id of_amlogic_thermal_match[] = {
+	{
+		.compatible = "amlogic,g12-ddr-thermal",
+		.data = &amlogic_thermal_g12_ddr_param,
+	},
+	{
+		.compatible = "amlogic,g12-cpu-thermal",
+		.data = &amlogic_thermal_g12_cpu_param,
+	},
+	{ /* end */ }
+};
+MODULE_DEVICE_TABLE(of, of_amlogic_thermal_match);
+
+static int amlogic_thermal_probe(struct platform_device *pdev)
+{
+	struct amlogic_thermal *pdata;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	int ret;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	pdata->data = of_device_get_match_data(dev);
+	pdata->pdev = pdev;
+	platform_set_drvdata(pdev, pdata);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pdata->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pdata->base)) {
+		dev_err(dev, "failed to get io address\n");
+		return PTR_ERR(pdata->base);
+	}
+
+	pdata->regmap = devm_regmap_init_mmio(dev, pdata->base,
+					      pdata->data->regmap_config);
+	if (IS_ERR(pdata->regmap))
+		return PTR_ERR(pdata->regmap);
+
+	pdata->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(pdata->clk)) {
+		if (PTR_ERR(pdata->clk) != -EPROBE_DEFER)
+			dev_err(dev, "failed to get clock\n");
+		return PTR_ERR(pdata->clk);
+	}
+
+	pdata->sec_ao_map = syscon_regmap_lookup_by_phandle
+		(pdev->dev.of_node, "amlogic,ao-secure");
+	if (IS_ERR(pdata->sec_ao_map)) {
+		dev_err(dev, "syscon regmap lookup failed.\n");
+		return PTR_ERR(pdata->sec_ao_map);
+	}
+
+	pdata->tzd = devm_thermal_zone_of_sensor_register
+				(&pdev->dev,
+				 pdata->data->id,
+				 pdata,
+				 &amlogic_thermal_ops);
+	if (IS_ERR(pdata->tzd)) {
+		ret = PTR_ERR(pdata->tzd);
+		dev_err(dev, "Failed to register tsensor: %d\n", ret);
+		return PTR_ERR(pdata->tzd);
+	}
+
+	ret = amlogic_thermal_initialize(pdata);
+	if (ret)
+		return ret;
+
+	ret = amlogic_thermal_enable(pdata);
+	if (ret)
+		clk_unprepare(pdata->clk);
+
+	return ret;
+}
+
+static int amlogic_thermal_remove(struct platform_device *pdev)
+{
+	struct amlogic_thermal *data = platform_get_drvdata(pdev);
+
+	return amlogic_thermal_disable(data);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int amlogic_thermal_suspend(struct device *dev)
+{
+	struct amlogic_thermal *data = dev_get_drvdata(dev);
+
+	return amlogic_thermal_disable(data);
+}
+
+static int amlogic_thermal_resume(struct device *dev)
+{
+	struct amlogic_thermal *data = dev_get_drvdata(dev);
+
+	return amlogic_thermal_enable(data);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(amlogic_thermal_pm_ops,
+			 amlogic_thermal_suspend, amlogic_thermal_resume);
+
+static struct platform_driver amlogic_thermal_driver = {
+	.driver = {
+		.name		= "amlogic_thermal",
+		.pm		= &amlogic_thermal_pm_ops,
+		.of_match_table = of_amlogic_thermal_match,
+	},
+	.probe	= amlogic_thermal_probe,
+	.remove	= amlogic_thermal_remove,
+};
+
+module_platform_driver(amlogic_thermal_driver);
+
+MODULE_AUTHOR("Guillaume La Roque <glaroque@baylibre.com>");
+MODULE_DESCRIPTION("Amlogic thermal driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

