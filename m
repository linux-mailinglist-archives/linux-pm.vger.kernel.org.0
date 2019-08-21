Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5569098725
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 00:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbfHUWY3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 18:24:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39206 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731125AbfHUWY2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 18:24:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id i63so3700229wmg.4
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 15:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o4B5g7ymsZFF76xtNscU9JetOxGjq+u94RReojQK+6Q=;
        b=XvS1z6ukqYhIPpcYXAY5r6awY7mdGho/3IgCtIioKUF8rfwGCgymajKFkaYk69+dfS
         yyjAZ1mFur4n0TC9LLwTkmaYG4V/P20Jzpb5B1Ihk4woDyYY1Yxbzf0Vgb3d8YwBcWe2
         OSazH/Z1BRSzphlSHxiJzb0r6rxKWwBFyINLtuTKiKSIN5u7vB71nQnYimgqidgYXfw9
         BldbWN6JAD6EsA8wvTDv7BYrz4z1QtvHsN0aMX/WrwdBGrmPZ4hJ9jcce5IB6Dah6qLn
         JX6qEZG8BZvulDVByOu/K68iyigND/59phYFfZl1CxGGue2nZMKr0KKLGgsA0YiTA02Z
         FCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o4B5g7ymsZFF76xtNscU9JetOxGjq+u94RReojQK+6Q=;
        b=O1szhd4ndngYsi9czEgHnOxYlC4/gSQS68DV+HumEY/4jYf8IBxfq6nuBJozojqcxl
         KrJktrybcIUpuJ7Vfz2SYXmpYy2kmHONixZWJiT3ytdLfN2qxUCfSgPR+Q+EGnaKdOyR
         5JReUA73u3wAFopkPhJ5Oi0BbwjRGT6Xcj6WeoeIsRw3RMmnitOLSIC6dbgkDqPoGE2+
         Vapb9cy19XXE6dPX47t8nmOjfBA6wRpJTpfbQTM48PF1unbsn2bu1fsU5eX9eoZYI3xh
         w9E6svEZj/xkyXFlMJBPYz5j7LwGEwUJLBZFVYmnjDDmK+sO8gXyvYQfLPw1cXlJc04W
         9GEQ==
X-Gm-Message-State: APjAAAV7kNJmgba8fUWj1TigNTOK37bIpjEf0otAZOWtN9Fx3dcSMZOv
        wQdjumkH02n5pQwv3iKAXOuTHQli6tc=
X-Google-Smtp-Source: APXvYqxMWVZj0HFKTX2paTQvCqKDq6ltjFRYlzoMrl/h6uDg1GcCSsjpwAVwOSG8LXjNhb7tGslQZg==
X-Received: by 2002:a1c:7611:: with SMTP id r17mr2325745wmc.117.1566426266039;
        Wed, 21 Aug 2019 15:24:26 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id f197sm3548549wme.22.2019.08.21.15.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 15:24:25 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v4 2/6] thermal: amlogic: Add thermal driver to support G12 SoCs
Date:   Thu, 22 Aug 2019 00:24:17 +0200
Message-Id: <20190821222421.30242-3-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821222421.30242-1-glaroque@baylibre.com>
References: <20190821222421.30242-1-glaroque@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Amlogic G12A and G12B SoCs integrate two thermal sensors
with the same design.
One is located close to the DDR controller and the other one is
located close to the PLLs (between the CPU and GPU).

The calibration data for each of the thermal sensors instance is
stored in a different location within the AO region.

Implement reading the temperature from each thermal sensor.

The IP block has more functionality, which may be added to this driver
in the future:
- chip reset when the temperature exceeds a configurable threshold
- up to four interrupts when the temperature has risen above a
configurable threshold
- up to four interrupts when the temperature has fallen below a
configurable threshold

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 drivers/thermal/Kconfig           |  11 +
 drivers/thermal/Makefile          |   1 +
 drivers/thermal/amlogic_thermal.c | 335 ++++++++++++++++++++++++++++++
 3 files changed, 347 insertions(+)
 create mode 100644 drivers/thermal/amlogic_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 9966364a6deb..0f31bb4bc372 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -348,6 +348,17 @@ config MTK_THERMAL
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
index 000000000000..173d808048d2
--- /dev/null
+++ b/drivers/thermal/amlogic_thermal.c
@@ -0,0 +1,335 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Amlogic Thermal Sensor Driver
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
+ * struct amlogic_thermal_soc_calib_data
+ * @A, B, m, n: calibration parameters
+ * This structure is required for configuration of amlogic thermal driver.
+ */
+struct amlogic_thermal_soc_calib_data {
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
+	int u_efuse_off;
+	const struct amlogic_thermal_soc_calib_data *calibration_parameters;
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
+};
+
+/*
+ * Calculate a temperature value from a temperature code.
+ * The unit of the temperature is degree milliCelsius.
+ */
+static int amlogic_thermal_code_to_millicelsius(struct amlogic_thermal *pdata,
+						int temp_code)
+{
+	const struct amlogic_thermal_soc_calib_data *param =
+					pdata->data->calibration_parameters;
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
+	int ret;
+
+	ret = clk_prepare_enable(data->clk);
+	if (ret)
+		return ret;
+
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
+	clk_disable_unprepare(data->clk);
+
+	return 0;
+}
+
+static int amlogic_thermal_get_temp(void *data, int *temp)
+{
+	unsigned int tval;
+	struct amlogic_thermal *pdata = data;
+
+	if (!data)
+		return -EINVAL;
+
+	regmap_read(pdata->regmap, TSENSOR_STAT0, &tval);
+	*temp =
+	   amlogic_thermal_code_to_millicelsius(pdata,
+						tval & TSENSOR_READ_TEMP_MASK);
+
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops amlogic_thermal_ops = {
+	.get_temp	= amlogic_thermal_get_temp,
+};
+
+static const struct regmap_config amlogic_thermal_regmap_config_g12a = {
+	.reg_bits = 8,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = TSENSOR_STAT9,
+};
+
+static const struct amlogic_thermal_soc_calib_data amlogic_thermal_g12a = {
+	.A = 9411,
+	.B = 3159,
+	.m = 424,
+	.n = 324,
+};
+
+static const struct amlogic_thermal_data amlogic_thermal_g12a_cpu_param = {
+	.u_efuse_off = 0x128,
+	.calibration_parameters = &amlogic_thermal_g12a,
+	.regmap_config = &amlogic_thermal_regmap_config_g12a,
+};
+
+static const struct amlogic_thermal_data amlogic_thermal_g12a_ddr_param = {
+	.u_efuse_off = 0xf0,
+	.calibration_parameters = &amlogic_thermal_g12a,
+	.regmap_config = &amlogic_thermal_regmap_config_g12a,
+};
+
+static const struct of_device_id of_amlogic_thermal_match[] = {
+	{
+		.compatible = "amlogic,g12a-ddr-thermal",
+		.data = &amlogic_thermal_g12a_ddr_param,
+	},
+	{
+		.compatible = "amlogic,g12a-cpu-thermal",
+		.data = &amlogic_thermal_g12a_cpu_param,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_amlogic_thermal_match);
+
+static int amlogic_thermal_probe(struct platform_device *pdev)
+{
+	struct amlogic_thermal *pdata;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	void __iomem *base;
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
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base)) {
+		dev_err(dev, "failed to get io address\n");
+		return PTR_ERR(base);
+	}
+
+	pdata->regmap = devm_regmap_init_mmio(dev, base,
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
+	pdata->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
+							  0,
+							  pdata,
+							  &amlogic_thermal_ops);
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
+static int __maybe_unused amlogic_thermal_suspend(struct device *dev)
+{
+	struct amlogic_thermal *data = dev_get_drvdata(dev);
+
+	return amlogic_thermal_disable(data);
+}
+
+static int __maybe_unused amlogic_thermal_resume(struct device *dev)
+{
+	struct amlogic_thermal *data = dev_get_drvdata(dev);
+
+	return amlogic_thermal_enable(data);
+}
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

