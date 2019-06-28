Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D22985952F
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 09:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfF1HkJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 03:40:09 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54886 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfF1HkJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Jun 2019 03:40:09 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C2A0A1A0340;
        Fri, 28 Jun 2019 09:40:06 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id ABA9D1A0249;
        Fri, 28 Jun 2019 09:40:06 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id C4D3A205D5;
        Fri, 28 Jun 2019 09:40:05 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Saravana Kannan <saravanak@google.com>, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFCv2 6/8] devfreq: Add imx-devfreq driver
Date:   Fri, 28 Jun 2019 10:39:54 +0300
Message-Id: <5531b22cdcb056c66fc0a51b4c839df5d86049d0.1561707104.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1561707104.git.leonard.crestez@nxp.com>
References: <cover.1561707104.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1561707104.git.leonard.crestez@nxp.com>
References: <cover.1561707104.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add initial support for frequency switches on pieces of the imx
interconnect fabric.

Uses clk_set_min_rate so that other subsytems can also impose minimum
rate requests.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/devfreq/Kconfig       |  10 +++
 drivers/devfreq/Makefile      |   1 +
 drivers/devfreq/imx-devfreq.c | 142 ++++++++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+)
 create mode 100644 drivers/devfreq/imx-devfreq.c

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index f3b242987fd9..3a7c6265ca2f 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -90,10 +90,20 @@ config ARM_EXYNOS_BUS_DEVFREQ
 	  Each memory bus group could contain many memoby bus block. It reads
 	  PPMU counters of memory controllers by using DEVFREQ-event device
 	  and adjusts the operating frequencies and voltages with OPP support.
 	  This does not yet operate with optimal voltages.
 
+config ARM_IMX_DEVFREQ
+	tristate "i.MX DEVFREQ Driver"
+	depends on ARCH_MXC
+	select DEVFREQ_GOV_USERSPACE
+	select PM_OPP
+	help
+	  This adds the DEVFREQ driver for the Tegra family of SoCs.
+	  It reads ACTMON counters of memory controllers and adjusts the
+	  operating frequencies and voltages with OPP support.
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
index 000000000000..aa8868d32f22
--- /dev/null
+++ b/drivers/devfreq/imx-devfreq.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 NXP
+ */
+
+#include <linux/clk.h>
+#include <linux/devfreq.h>
+#include <linux/devfreq-event.h>
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
+	ret = clk_set_min_rate(priv->clk, new_freq);
+        if (ret)
+		return ret;
+
+	ret = clk_set_rate(priv->clk, 0);
+	if (ret) {
+		clk_set_min_rate(priv->clk, priv->devfreq->previous_freq);
+		return ret;
+	}
+
+	return 0;
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
+	return dev_pm_opp_of_remove_table(dev);
+}
+
+static int imx_devfreq_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imx_devfreq *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->devfreq)) {
+		ret = PTR_ERR(priv->devfreq);
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
+	priv->devfreq = devm_devfreq_add_device(dev, &priv->profile,
+						DEVFREQ_GOV_USERSPACE,
+						NULL);
+	if (IS_ERR(priv->devfreq)) {
+		ret = PTR_ERR(priv->devfreq);
+		dev_err(dev, "failed to add devfreq device: %d\n", ret);
+		goto err_remove_table;
+	}
+
+	return 0;
+
+err_remove_table:
+	dev_pm_opp_of_remove_table(dev);
+	return ret;
+}
+
+static const struct of_device_id imx_devfreq_of_match[] = {
+	{ .compatible = "fsl,imx8mm-ddrc", },
+	{ .compatible = "fsl,imx8mm-noc", },
+	{ .compatible = "fsl,imx8mm-nic", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, imx_devfreq_of_match);
+
+static struct platform_driver imx_devfreq_platdrv = {
+	.probe		= imx_devfreq_probe,
+	.driver = {
+		.name	= "devfreq-imx",
+		.of_match_table = of_match_ptr(imx_devfreq_of_match),
+	},
+};
+module_platform_driver(imx_devfreq_platdrv);
+
+MODULE_DESCRIPTION("Generic i.MX bus frequency driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

