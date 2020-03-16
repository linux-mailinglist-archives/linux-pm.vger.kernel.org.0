Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 421B0186B91
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 13:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbgCPMzs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Mar 2020 08:55:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11700 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731063AbgCPMzs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Mar 2020 08:55:48 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CB700637AB3DEF3F4961;
        Mon, 16 Mar 2020 20:55:35 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Mar 2020 20:55:34 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <rui.zhang@intel.com>, <daniel.lezcano@linaro.org>,
        <amit.kucheria@verdurent.com>
CC:     <linux-pm@vger.kernel.org>
Subject: [PATCH V2 1/2] thermal: Add HiSilicon Kunpeng thermal driver
Date:   Mon, 16 Mar 2020 20:55:00 +0800
Message-ID: <1584363301-15858-2-git-send-email-shenyang39@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584363301-15858-1-git-send-email-shenyang39@huawei.com>
References: <1584363301-15858-1-git-send-email-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Support HiSilicon Kunpeng tsensor. the driver will report the max
temperature for each core.

Signed-off-by: Yang Shen <shenyang39@huawei.com>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Kunshan Tang <tangkunshan@huawei.com>
---
 drivers/thermal/Kconfig           |   8 ++
 drivers/thermal/Makefile          |   1 +
 drivers/thermal/kunpeng_thermal.c | 219 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 228 insertions(+)
 create mode 100644 drivers/thermal/kunpeng_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 5a05db5..7611b5d 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -239,6 +239,14 @@ config HISI_THERMAL
 	  thermal framework. cpufreq is used as the cooling device to throttle
 	  CPUs when the passive trip is crossed.
 
+config KUNPENG_THERMAL
+	tristate "HiSilicon kunpeng thermal driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	  Enable this to plug HiSilicon kunpeng's thermal sensors driver into
+	  the Linux thermal framework, which supports to get the highest
+	  temperature of one Kunpeng SoC.
+
 config IMX_THERMAL
 	tristate "Temperature sensor driver for Freescale i.MX SoCs"
 	depends on ARCH_MXC || COMPILE_TEST
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 9fb88e2..88ffca5 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
 obj-$(CONFIG_ZX2967_THERMAL)	+= zx2967_thermal.o
 obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
 obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
+obj-$(CONFIG_KUNPENG_THERMAL)     += kunpeng_thermal.o
diff --git a/drivers/thermal/kunpeng_thermal.c b/drivers/thermal/kunpeng_thermal.c
new file mode 100644
index 0000000..5b5df82
--- /dev/null
+++ b/drivers/thermal/kunpeng_thermal.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 HiSilicon Limited. */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+
+#define KUNPENG_TSENSOR_CONTROL			0x20D0
+#define KUNPENG_TSENSOR_ST			0x60D0
+#define KUNPENG_TSENSOR_SAMPLE			0x60D4
+#define KUNPENG_TSENSOR_CONTROL_EN		BIT(0)
+
+#define KUNPENG_TSENSOR_IS_ENABLE(reg)		((reg) & 0x1)
+#define KUNPENG_TSENSOR_IS_READY(reg)		(((reg) >> 12) & 0x1)
+#define KUNPENG_TSENSOR_IS_VALID(reg)		(((reg) >> 31) & 0x1)
+#define KUNPENG_TSENSOR_TRIM_HIGH(reg)		(((reg) >> 15) & 0x7FF)
+#define KUNPENG_TSENSOR_TRIM_LOW(reg)		((reg) & 0x7FF)
+#define KUNPENG_TSENSOR_TEMP_VAL(reg)		((reg) & 0x3FF)
+#define KUNPENG_TSENSOR_BASE_NUM(num)		(2 * (num))
+#define KUNPENG_TSENSOR_TRIM_NUM(num)		(2 * (num) + 1)
+
+#define KUNPENG_TSENSOR_RD_INTVRL_US		5
+#define KUNPENG_TSENSOR_RD_TMOUT_US		2000
+#define KUNPENG_TSENSOR_BASIC_TMP		25000
+#define KUNPENG_TSENSOR_BASIC_TRIM_RANGE	80000
+
+struct kunpeng_tsensor {
+	void __iomem *base;
+	void __iomem *trim_register;
+};
+
+struct kunpeng_thermal_dev {
+	u32 num_tsensors;
+	struct kunpeng_tsensor tsensor[];
+};
+
+static int kunpeng_thermal_temp_correct(u32 tmp, u32 trim)
+{
+	int trim_high = KUNPENG_TSENSOR_TRIM_HIGH(trim);
+	int trim_low = KUNPENG_TSENSOR_TRIM_LOW(trim);
+	int val = KUNPENG_TSENSOR_TEMP_VAL(tmp);
+
+	if (trim_high == trim_low)
+		return INT_MIN;
+
+	/* temperature of tsensor needs to be calibrated */
+	return KUNPENG_TSENSOR_BASIC_TRIM_RANGE * (val - trim_low)
+	       / (trim_high - trim_low) + KUNPENG_TSENSOR_BASIC_TMP;
+}
+
+static int kunpeng_thermal_get_temp(struct thermal_zone_device *thermal,
+				    int *temp)
+{
+	struct kunpeng_thermal_dev *tdev = thermal->devdata;
+	int tempmax = INT_MIN;
+	u32 i, reg, tmp, trim;
+	int ret;
+
+	for (i = 0; i < tdev->num_tsensors; i++) {
+		/* Waiting for tsensor ready */
+		ret = readl_relaxed_poll_timeout(tdev->tsensor[i].base +
+						 KUNPENG_TSENSOR_ST, reg,
+						 KUNPENG_TSENSOR_IS_READY(reg),
+						 KUNPENG_TSENSOR_RD_INTVRL_US,
+						 KUNPENG_TSENSOR_RD_TMOUT_US);
+		if (ret) {
+			dev_err(&thermal->device,
+				"Tsensor%u isn't ready!\n", i);
+			continue;
+		}
+
+		/* checking if tsensors are valid */
+		tmp = readl_relaxed(tdev->tsensor[i].base
+				    + KUNPENG_TSENSOR_SAMPLE);
+		if (!KUNPENG_TSENSOR_IS_VALID(tmp)) {
+			dev_err(&thermal->device,
+				"Tsensor%u temperature is invalid!\n", i);
+			continue;
+		}
+
+		trim = readl_relaxed(tdev->tsensor[i].trim_register);
+
+		ret = kunpeng_thermal_temp_correct(tmp, trim);
+		if (ret == INT_MIN) {
+			dev_err(&thermal->device,
+				"Tsensor%u trim value is invalid!\n", i);
+			continue;
+		}
+
+		tempmax = max(ret, tempmax);
+	}
+
+	if (tempmax == INT_MIN)
+		return -EINVAL;
+
+	*temp = tempmax;
+
+	return 0;
+}
+
+static struct thermal_zone_device_ops ops = {
+	.get_temp	= kunpeng_thermal_get_temp,
+};
+
+static int kunpeng_thermal_get_iobase(struct platform_device *pdev,
+				      struct kunpeng_tsensor *tsensor,
+				      u32 resource_num)
+{
+	struct resource *res;
+	void __iomem *base;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, resource_num);
+	if (!res)
+		return -EINVAL;
+
+	base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (IS_ERR(base))
+		return -EINVAL;
+
+	if (resource_num & 1)
+		tsensor->trim_register = base;
+	else
+		tsensor->base = base;
+
+	return 0;
+}
+
+/**
+ * kunpeng_thermal_probe() - Enable tsensors. And register device to thermal.
+ *
+ * This driver and IMU share tsensor devices. This funciton only enable the
+ * devices but never change configure or disable them.
+ */
+static int kunpeng_thermal_probe(struct platform_device *pdev)
+{
+	u32 num_tsensors = pdev->num_resources >> 1;
+	struct thermal_zone_device *thermal_zone;
+	struct kunpeng_thermal_dev *tdev;
+	u32 i, reg;
+	int ret;
+
+	tdev = devm_kzalloc(&pdev->dev, sizeof(*tdev) + sizeof(*tdev->tsensor) *
+			    num_tsensors, GFP_KERNEL);
+	if (!tdev)
+		return -ENOMEM;
+
+	tdev->num_tsensors = num_tsensors;
+
+	for (i = 0; i < num_tsensors; i++) {
+		ret = kunpeng_thermal_get_iobase(pdev, &tdev->tsensor[i],
+						 KUNPENG_TSENSOR_BASE_NUM(i));
+		if (ret) {
+			dev_err(&pdev->dev, "Fail to ioremap base!\n");
+			return ret;
+		}
+
+		ret = kunpeng_thermal_get_iobase(pdev, &tdev->tsensor[i],
+						 KUNPENG_TSENSOR_TRIM_NUM(i));
+		if (ret) {
+			dev_err(&pdev->dev, "Fail to ioremap trim register!\n");
+			return ret;
+		}
+
+		/* Enable thermal sensors when devices are disable */
+		reg = readl_relaxed(tdev->tsensor[i].base +
+				    KUNPENG_TSENSOR_CONTROL);
+		if (!KUNPENG_TSENSOR_IS_ENABLE(reg))
+			writel_relaxed(reg | KUNPENG_TSENSOR_CONTROL_EN,
+				       tdev->tsensor[i].base +
+				       KUNPENG_TSENSOR_CONTROL);
+	}
+
+	thermal_zone = thermal_zone_device_register("kunpeng_thermal", 0, 0,
+						    tdev, &ops, NULL, 0, 0);
+	if (IS_ERR(thermal_zone)) {
+		dev_err(&pdev->dev, "Fail to register to thermal subsystem\n");
+		return PTR_ERR(thermal_zone);
+	}
+
+	platform_set_drvdata(pdev, thermal_zone);
+
+	return 0;
+}
+
+static int kunpeng_thermal_remove(struct platform_device *pdev)
+{
+	struct thermal_zone_device *thermal_zone = platform_get_drvdata(pdev);
+
+	thermal_zone_device_unregister(thermal_zone);
+
+	return 0;
+}
+
+static const struct acpi_device_id kunpeng_thermal_acpi_match[] = {
+	{ "HISI0371", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, kunpeng_thermal_acpi_match);
+
+static struct platform_driver kunpeng_thermal_driver = {
+	.probe		= kunpeng_thermal_probe,
+	.remove		= kunpeng_thermal_remove,
+	.driver		= {
+		.name	= "kunpeng_thermal",
+		.acpi_match_table = ACPI_PTR(kunpeng_thermal_acpi_match),
+	},
+};
+
+module_platform_driver(kunpeng_thermal_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Yang Shen <shenyang39@huawei.com>");
+MODULE_DESCRIPTION("HiSilicon Kunpeng thermal driver");
-- 
2.7.4

