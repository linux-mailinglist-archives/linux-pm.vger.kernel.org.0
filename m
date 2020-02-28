Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0FB8172F03
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2020 04:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbgB1C7w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 21:59:52 -0500
Received: from inva020.nxp.com ([92.121.34.13]:34784 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730445AbgB1C7v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Feb 2020 21:59:51 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5D55E1A07AD;
        Fri, 28 Feb 2020 03:59:49 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7DB221A00DD;
        Fri, 28 Feb 2020 03:59:34 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 660E9402D5;
        Fri, 28 Feb 2020 10:59:20 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        aford173@gmail.com, shengjiu.wang@nxp.com, ping.bai@nxp.com,
        jun.li@nxp.com, peng.fan@nxp.com, bjorn.andersson@linaro.org,
        olof@lixom.net, dinguyen@kernel.org, marcin.juszkiewicz@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 2/4] thermal: imx8mm: Add support for i.MX8MM thermal monitoring unit
Date:   Fri, 28 Feb 2020 10:53:31 +0800
Message-Id: <1582858413-11906-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582858413-11906-1-git-send-email-Anson.Huang@nxp.com>
References: <1582858413-11906-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

i.MX8MM has a thermal monitoring unit(TMU) inside, it ONLY has one
sensor for CPU, add support for reading immediate temperature of
this sensor.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- Update the copyright and add the author.
---
 drivers/thermal/Kconfig          |  10 +++
 drivers/thermal/Makefile         |   1 +
 drivers/thermal/imx8mm_thermal.c | 135 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+)
 create mode 100644 drivers/thermal/imx8mm_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 3502ee8..165b7d6 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -262,6 +262,16 @@ config IMX_SC_THERMAL
 	  sensor. It supports one critical trip point and one
 	  passive trip point for each thermal sensor.
 
+config IMX8MM_THERMAL
+	tristate "Temperature sensor driver for Freescale i.MX8MM SoC"
+	depends on ARCH_MXC
+	depends on OF
+	help
+	  Support for Thermal Monitoring Unit (TMU) found on Freescale i.MX8MM SoC.
+	  It supports one critical trip point and one passive trip point. The
+	  cpufreq is used as the cooling device to throttle CPUs when the passive
+	  trip is crossed.
+
 config MAX77620_THERMAL
 	tristate "Temperature sensor driver for Maxim MAX77620 PMIC"
 	depends on MFD_MAX77620
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index a11a6d8..120a05e 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
 obj-$(CONFIG_TANGO_THERMAL)	+= tango_thermal.o
 obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
 obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
+obj-$(CONFIG_IMX8MM_THERMAL)	+= imx8mm_thermal.o
 obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
 obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
 obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
new file mode 100644
index 0000000..ad5dd57
--- /dev/null
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020 NXP.
+ *
+ * Author: Anson Huang <Anson.Huang@nxp.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+
+#include "thermal_core.h"
+
+#define TER			0x0	/* TMU enable */
+#define TRITSR			0x20	/* TMU immediate temp */
+
+#define TER_EN			BIT(31)
+#define TRITSR_VAL_MASK		0xff
+
+#define TEMP_LOW_LIMIT		10
+
+struct imx8mm_tmu {
+	struct thermal_zone_device *tzd;
+	void __iomem *base;
+	struct clk *clk;
+};
+
+static int tmu_get_temp(void *data, int *temp)
+{
+	struct imx8mm_tmu *tmu = data;
+	u32 val;
+
+	/* the temp sensor need about 1ms to finish the measurement */
+	usleep_range(1000, 2000);
+
+	val = readl_relaxed(tmu->base + TRITSR) & TRITSR_VAL_MASK;
+	if (val < TEMP_LOW_LIMIT)
+		return -EAGAIN;
+
+	*temp = val * 1000;
+
+	return 0;
+}
+
+static struct thermal_zone_of_device_ops tmu_tz_ops = {
+	.get_temp = tmu_get_temp,
+};
+
+static int imx8mm_tmu_probe(struct platform_device *pdev)
+{
+	struct imx8mm_tmu *tmu;
+	u32 val;
+	int ret;
+
+	tmu = devm_kzalloc(&pdev->dev, sizeof(struct imx8mm_tmu), GFP_KERNEL);
+	if (!tmu)
+		return -ENOMEM;
+
+	tmu->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(tmu->base))
+		return PTR_ERR(tmu->base);
+
+	tmu->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(tmu->clk)) {
+		ret = PTR_ERR(tmu->clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"failed to get tmu clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(tmu->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable tmu clock: %d\n", ret);
+		return ret;
+	}
+
+	tmu->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, 0,
+							tmu, &tmu_tz_ops);
+	if (IS_ERR(tmu->tzd)) {
+		dev_err(&pdev->dev,
+			"failed to register thermal zone sensor: %d\n", ret);
+		return PTR_ERR(tmu->tzd);
+	}
+
+	platform_set_drvdata(pdev, tmu);
+
+	/* enable the monitor */
+	val = readl_relaxed(tmu->base + TER);
+	val |= TER_EN;
+	writel_relaxed(val, tmu->base + TER);
+
+	return 0;
+}
+
+static int imx8mm_tmu_remove(struct platform_device *pdev)
+{
+	struct imx8mm_tmu *tmu = platform_get_drvdata(pdev);
+	u32 val;
+
+	/* disable TMU */
+	val = readl_relaxed(tmu->base + TER);
+	val &= ~TER_EN;
+	writel_relaxed(val, tmu->base + TER);
+
+	clk_disable_unprepare(tmu->clk);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static const struct of_device_id imx8mm_tmu_table[] = {
+	{ .compatible = "fsl,imx8mm-tmu", },
+	{ },
+};
+
+static struct platform_driver imx8mm_tmu = {
+	.driver = {
+		.name	= "i.mx8mm_thermal",
+		.of_match_table = imx8mm_tmu_table,
+	},
+	.probe = imx8mm_tmu_probe,
+	.remove = imx8mm_tmu_remove,
+};
+module_platform_driver(imx8mm_tmu);
+
+MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
+MODULE_DESCRIPTION("i.MX8MM Thermal Monitor Unit driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

