Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D029964E9
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2019 17:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbfHTPp0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 11:45:26 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39176 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbfHTPp0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Aug 2019 11:45:26 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EFA0A2002B0;
        Tue, 20 Aug 2019 17:45:23 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D6F572002AA;
        Tue, 20 Aug 2019 17:45:23 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D48DC20604;
        Tue, 20 Aug 2019 17:45:22 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/7] PM / devfreq: Add generic imx bus driver
Date:   Tue, 20 Aug 2019 18:45:08 +0300
Message-Id: <8726e078e0c0661eead993f26c1bd8546b63e6ab.1566315740.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1566315740.git.leonard.crestez@nxp.com>
References: <cover.1566315740.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1566315740.git.leonard.crestez@nxp.com>
References: <cover.1566315740.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add initial support for dynamic frequency switching on pieces of the imx
interconnect fabric.

All this driver actually does is set a clk rate based on an opp table.

No attempt is made to map registers or anything clever.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/devfreq/Kconfig       |  12 +++
 drivers/devfreq/Makefile      |   1 +
 drivers/devfreq/imx-devfreq.c | 148 ++++++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+)
 create mode 100644 drivers/devfreq/imx-devfreq.c

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index defe1d438710..9088a151bafe 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -90,10 +90,22 @@ config ARM_EXYNOS_BUS_DEVFREQ
 	  Each memory bus group could contain many memoby bus block. It reads
 	  PPMU counters of memory controllers by using DEVFREQ-event device
 	  and adjusts the operating frequencies and voltages with OPP support.
 	  This does not yet operate with optimal voltages.
 
+config ARM_IMX_DEVFREQ
+	tristate "i.MX DEVFREQ Driver"
+	depends on ARCH_MXC || COMPILE_TEST
+	select DEVFREQ_GOV_PASSIVE
+	select DEVFREQ_GOV_SIMPLE_ONDEMAND
+	select DEVFREQ_GOV_USERSPACE
+	select PM_OPP
+	help
+	  This adds the DEVFREQ driver for the i.MX family of SoCs.
+	  It allows adjusting frequencies for DDRC (DDR Controller) and various
+	  NICs and NOCs which form the SOC interconnect fabric
+
 config ARM_TEGRA_DEVFREQ
 	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
 	depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || \
 		ARCH_TEGRA_132_SOC || ARCH_TEGRA_124_SOC || \
 		ARCH_TEGRA_210_SOC || \
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index 338ae8440db6..c2463ed4c934 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -7,10 +7,11 @@ obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+= governor_powersave.o
 obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
 obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
 
 # DEVFREQ Drivers
 obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
+obj-$(CONFIG_ARM_IMX_DEVFREQ)		+= imx-devfreq.o
 obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
 obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
 obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+= tegra20-devfreq.o
 
 # DEVFREQ Event Drivers
diff --git a/drivers/devfreq/imx-devfreq.c b/drivers/devfreq/imx-devfreq.c
new file mode 100644
index 000000000000..5c907b3ab9c0
--- /dev/null
+++ b/drivers/devfreq/imx-devfreq.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 NXP
+ */
+
+#include <linux/clk.h>
+#include <linux/devfreq.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/pm_opp.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+struct imx_devfreq {
+	struct devfreq_dev_profile profile;
+	struct devfreq *devfreq;
+	struct clk *clk;
+	struct devfreq_passive_data passive_data;
+};
+
+static int imx_devfreq_target(struct device *dev, unsigned long *freq, u32 flags)
+{
+	struct imx_devfreq *priv = dev_get_drvdata(dev);
+	struct dev_pm_opp *new_opp;
+	unsigned long new_freq;
+	int ret;
+
+	new_opp = devfreq_recommended_opp(dev, freq, flags);
+	if (IS_ERR(new_opp)) {
+		ret = PTR_ERR(new_opp);
+		dev_err(dev, "failed to get recommended opp: %d\n", ret);
+		return ret;
+	}
+	new_freq = dev_pm_opp_get_freq(new_opp);
+	dev_pm_opp_put(new_opp);
+
+	return clk_set_rate(priv->clk, new_freq);
+}
+
+static int imx_devfreq_get_cur_freq(struct device *dev, unsigned long *freq)
+{
+	struct imx_devfreq *priv = dev_get_drvdata(dev);
+
+	*freq = clk_get_rate(priv->clk);
+
+	return 0;
+}
+
+static int imx_devfreq_get_dev_status(struct device *dev,
+		struct devfreq_dev_status *stat)
+{
+	struct imx_devfreq *priv = dev_get_drvdata(dev);
+
+	stat->busy_time = 0;
+	stat->total_time = 0;
+	stat->current_frequency = clk_get_rate(priv->clk);
+
+	return 0;
+}
+
+static void imx_devfreq_exit(struct device *dev)
+{
+	dev_pm_opp_of_remove_table(dev);
+}
+
+static int imx_devfreq_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imx_devfreq *priv;
+	const char *gov = DEVFREQ_GOV_USERSPACE;
+	void *govdata = NULL;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		ret = PTR_ERR(priv->clk);
+		dev_err(dev, "failed to fetch clk: %d\n", ret);
+		return ret;
+	}
+	platform_set_drvdata(pdev, priv);
+
+	ret = dev_pm_opp_of_add_table(dev);
+	if (ret < 0) {
+		dev_err(dev, "failed to get OPP table\n");
+		return ret;
+	}
+
+	priv->profile.polling_ms = 1000;
+	priv->profile.target = imx_devfreq_target;
+	priv->profile.get_dev_status = imx_devfreq_get_dev_status;
+	priv->profile.exit = imx_devfreq_exit;
+	priv->profile.get_cur_freq = imx_devfreq_get_cur_freq;
+	priv->profile.initial_freq = clk_get_rate(priv->clk);
+
+	/* Handle passive devfreq parent link */
+	priv->passive_data.parent = devfreq_get_devfreq_by_phandle(dev, 0);
+	if (!IS_ERR(priv->passive_data.parent)) {
+		dev_info(dev, "passive link to %s\n",
+				dev_name(priv->passive_data.parent->dev.parent));
+		gov = DEVFREQ_GOV_PASSIVE;
+		govdata = &priv->passive_data;
+	} else if (priv->passive_data.parent != ERR_PTR(-ENODEV)) {
+		// -ENODEV means no parent: not an error.
+		ret = PTR_ERR(priv->passive_data.parent);
+		if (ret != -EPROBE_DEFER)
+			dev_warn(dev, "failed to get passive parent: %d\n", ret);
+		goto err;
+	}
+
+	priv->devfreq = devm_devfreq_add_device(dev, &priv->profile,
+						gov, govdata);
+	if (IS_ERR(priv->devfreq)) {
+		ret = PTR_ERR(priv->devfreq);
+		dev_err(dev, "failed to add devfreq device: %d\n", ret);
+		goto err;
+	}
+
+	return 0;
+
+err:
+	dev_pm_opp_of_remove_table(dev);
+	return ret;
+}
+
+static const struct of_device_id imx_devfreq_of_match[] = {
+	{ .compatible = "fsl,imx8m-noc", },
+	{ .compatible = "fsl,imx8m-nic", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, imx_devfreq_of_match);
+
+static struct platform_driver imx_devfreq_platdrv = {
+	.probe		= imx_devfreq_probe,
+	.driver = {
+		.name	= "imx-devfreq",
+		.of_match_table = of_match_ptr(imx_devfreq_of_match),
+	},
+};
+module_platform_driver(imx_devfreq_platdrv);
+
+MODULE_DESCRIPTION("Generic i.MX bus frequency driver");
+MODULE_AUTHOR("Leonard Crestez <leonard.crestez@nxp.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

