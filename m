Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B65B913824D
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2020 17:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgAKQQS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Jan 2020 11:16:18 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:58405 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730322AbgAKQQS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Jan 2020 11:16:18 -0500
Received: from localhost.localdomain ([37.4.249.154]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N2VGj-1joql63Bip-013ze2; Sat, 11 Jan 2020 17:15:51 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V4 2/4] thermal: Add BCM2711 thermal driver
Date:   Sat, 11 Jan 2020 17:15:40 +0100
Message-Id: <1578759342-4550-3-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578759342-4550-1-git-send-email-stefan.wahren@i2se.com>
References: <1578759342-4550-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:jpF70Cx2jUyAw6JIvYmMLcAnFVDLZaCts+nTxiBrfb4+0NVpStD
 bD85rov7s3eKlRtF9OCsAN8N5X3nelMp777k//ChHAsvbr0um0P1eenRhsKIcgi54EDv1e4
 Yaej82NAf2Q8NWZhsrJyI/y3lRJi0GKAWmr8TAZjZ6EM0XoSWryu9wUogTheqEl5rWtYrU6
 8FHknqHHCKqXgJFPc+wlA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6yyhpYWfYjg=:hDWk++0d+zTF3NotoYlqgq
 dG1kqCik+ZYKFdfG1J+91LHuJhIvdsLxxSgJAAx6RbWf2sAiLBClM1kFG6It9JDlGhOsgAprt
 IVqH3P5G+DoHKrl0klrpG99Bb9M0hCQ633IEzToWodC4rzWNR0GlL6YrWucrLxAc+cEI7c8ft
 PqJZKxnVY0OiGqsdm+OwB9ffRINi4YFvDrtdyxv7dgNmiYc42TMr0TMRrsUasbTkISu3aQ22r
 qeDJYBfzm104DvYM6PP+NvSn5+6YfCgddo7V/OlQafkutHPyYWAuDfULVVds5njv6c8dS2gjm
 FaC/icnWnM8HBDMLsCTptyQelF9DSH4SjYwPm1TvbtMhMqqMj91CtsYqlI30dCacRWtDI3bSP
 97bejCjJ4gt3GE2qEVfMXKme9RrhDWkYe9FyPK+gdUSdKkWXgRsuYmkfq83ts0T02KBswQhHB
 ceoIZlaA1YYvsrc4Hc8SkUq5MJt2Uyc1hL0FOaKEsbExkr5GVF3XiSfWVIkky30E204OZxV2A
 L+ROBXxw+NeeA8L97GSLzlCXRLn0Cth+f9R+3AZJu7NtpDXsMa64wHPOL8xG5ZrH3f/6CulbN
 /X/IO09piUzG7lRtBXozPsGqKxYdWPCxC7EuWZubUYsUXhskbJeL68d1xISpwUqFCm6N1TmR4
 H17hhOGx40U2JTDZG5xRWq06SFXECzBw4yNR579WkkfMagtoT1q3sEUEumVhzT+B178qlqjvC
 HzXXxXG79AFfjWXyVWYnaYC9Z9XdKQKlrAawejVGNwQI3X3ZHtTcYcf4vABglID+NF4qgsL6P
 Zo2ymwSegKqbHeK5Xf4K2CIpj0tDG9cbIiKbQh1jOzuUpxMW34LH5zSGDXrMfN2tvfAvlORaO
 88yVTTYPEmWnTTBBOSdpFhlO5+IfaddBSqysmbmGk=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds the thermal sensor driver for the Broadcom BCM2711 SoC,
which is placed on the Raspberry Pi 4. The driver only provides
SoC temperature reading so far.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/thermal/broadcom/Kconfig           |   7 ++
 drivers/thermal/broadcom/Makefile          |   1 +
 drivers/thermal/broadcom/bcm2711_thermal.c | 129 +++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+)
 create mode 100644 drivers/thermal/broadcom/bcm2711_thermal.c

diff --git a/drivers/thermal/broadcom/Kconfig b/drivers/thermal/broadcom/Kconfig
index cf43e15..061f1db 100644
--- a/drivers/thermal/broadcom/Kconfig
+++ b/drivers/thermal/broadcom/Kconfig
@@ -1,4 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
+config BCM2711_THERMAL
+	tristate "Broadcom AVS RO thermal sensor driver"
+	depends on ARCH_BCM2835 || COMPILE_TEST
+	depends on THERMAL_OF && MFD_SYSCON
+	help
+	  Support for thermal sensors on Broadcom BCM2711 SoCs.
+
 config BCM2835_THERMAL
 	tristate "Thermal sensors on bcm2835 SoC"
 	depends on ARCH_BCM2835 || COMPILE_TEST
diff --git a/drivers/thermal/broadcom/Makefile b/drivers/thermal/broadcom/Makefile
index 490ab1f..c917b24 100644
--- a/drivers/thermal/broadcom/Makefile
+++ b/drivers/thermal/broadcom/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_BCM2711_THERMAL)		+= bcm2711_thermal.o
 obj-$(CONFIG_BCM2835_THERMAL)		+= bcm2835_thermal.o
 obj-$(CONFIG_BRCMSTB_THERMAL)		+= brcmstb_thermal.o
 obj-$(CONFIG_BCM_NS_THERMAL)		+= ns-thermal.o
diff --git a/drivers/thermal/broadcom/bcm2711_thermal.c b/drivers/thermal/broadcom/bcm2711_thermal.c
new file mode 100644
index 0000000..b1d3c4d
--- /dev/null
+++ b/drivers/thermal/broadcom/bcm2711_thermal.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Broadcom AVS RO thermal sensor driver
+ *
+ * based on brcmstb_thermal
+ *
+ * Copyright (C) 2020 Stefan Wahren
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/thermal.h>
+
+#include "../thermal_hwmon.h"
+
+#define AVS_RO_TEMP_STATUS		0x200
+ #define AVS_RO_TEMP_STATUS_valid_msk	(BIT(16) | BIT(10))
+ #define AVS_RO_TEMP_STATUS_data_msk	GENMASK(9, 0)
+
+struct bcm2711_thermal_priv {
+	struct regmap *regmap;
+	struct device *dev;
+	struct thermal_zone_device *thermal;
+};
+
+static int bcm2711_get_temp(void *data, int *temp)
+{
+	struct bcm2711_thermal_priv *priv = data;
+	int slope = thermal_zone_get_slope(priv->thermal);
+	int offset = thermal_zone_get_offset(priv->thermal);
+	u32 val;
+	int ret;
+	long t;
+
+	ret = regmap_read(priv->regmap, AVS_RO_TEMP_STATUS, &val);
+	if (ret)
+		return ret;
+
+	if (!(val & AVS_RO_TEMP_STATUS_valid_msk)) {
+		dev_err(priv->dev, "reading not valid\n");
+		return -EIO;
+	}
+
+	val &= AVS_RO_TEMP_STATUS_data_msk;
+
+	/* Convert a HW code to a temperature reading (millidegree celsius) */
+	t = slope * val + offset;
+	if (t < 0)
+		*temp = 0;
+	else
+		*temp = t;
+
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops bcm2711_thermal_of_ops = {
+	.get_temp	= bcm2711_get_temp,
+};
+
+static const struct of_device_id bcm2711_thermal_id_table[] = {
+	{ .compatible = "brcm,bcm2711-thermal" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, bcm2711_thermal_id_table);
+
+static int bcm2711_thermal_probe(struct platform_device *pdev)
+{
+	struct thermal_zone_device *thermal;
+	struct bcm2711_thermal_priv *priv;
+	struct device *dev = &pdev->dev;
+	struct device_node *parent;
+	struct regmap *regmap;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	/* get regmap from syscon node */
+	parent = of_get_parent(dev->of_node); /* parent should be syscon node */
+	regmap = syscon_node_to_regmap(parent);
+	of_node_put(parent);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(dev, "failed to get regmap: %d\n", ret);
+		return ret;
+	}
+	priv->regmap = regmap;
+	priv->dev = dev;
+
+	thermal = devm_thermal_zone_of_sensor_register(dev, 0, priv,
+						       &bcm2711_thermal_of_ops);
+	if (IS_ERR(thermal)) {
+		ret = PTR_ERR(thermal);
+		dev_err(dev, "could not register sensor: %d\n", ret);
+		return ret;
+	}
+
+	priv->thermal = thermal;
+
+	thermal->tzp->no_hwmon = false;
+	ret = thermal_add_hwmon_sysfs(thermal);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static struct platform_driver bcm2711_thermal_driver = {
+	.probe = bcm2711_thermal_probe,
+	.driver = {
+		.name = "bcm2711_thermal",
+		.of_match_table = bcm2711_thermal_id_table,
+	},
+};
+module_platform_driver(bcm2711_thermal_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Stefan Wahren");
+MODULE_DESCRIPTION("Broadcom AVS RO thermal sensor driver");
-- 
2.7.4

