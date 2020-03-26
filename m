Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D28C1935A8
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 03:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgCZCQa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 22:16:30 -0400
Received: from inva021.nxp.com ([92.121.34.21]:52688 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727564AbgCZCQa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 25 Mar 2020 22:16:30 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EB33E200783;
        Thu, 26 Mar 2020 03:16:27 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D3DA2200782;
        Thu, 26 Mar 2020 03:16:27 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id C41D4203CD;
        Thu, 26 Mar 2020 03:16:26 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Martin Kepplinger <martink@posteo.de>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Angus Ainslie <angus@akkea.ca>,
        Silvano di Ninno <silvano.dininno@nxp.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/8] PM / devfreq: Add generic imx bus scaling driver
Date:   Thu, 26 Mar 2020 04:16:14 +0200
Message-Id: <e32290a36b31fbe922cc8ed48c33e89a5eb08804.1585188174.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1585188174.git.leonard.crestez@nxp.com>
References: <cover.1585188174.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1585188174.git.leonard.crestez@nxp.com>
References: <cover.1585188174.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add initial support for dynamic frequency switching on pieces of the imx
interconnect fabric.

All this driver does is set a clk rate based on an opp table, it does
not map register areas.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/devfreq/Kconfig   |   9 +++
 drivers/devfreq/Makefile  |   1 +
 drivers/devfreq/imx-bus.c | 142 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+)
 create mode 100644 drivers/devfreq/imx-bus.c

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 0b1df12e0f21..44d26192ddc4 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -99,10 +99,19 @@ config ARM_IMX8M_DDRC_DEVFREQ
 	select DEVFREQ_GOV_USERSPACE
 	help
 	  This adds the DEVFREQ driver for the i.MX8M DDR Controller. It allows
 	  adjusting DRAM frequency.
 
+config ARM_IMX_BUS_DEVFREQ
+	tristate "i.MX Generic Bus DEVFREQ Driver"
+	depends on ARCH_MXC || COMPILE_TEST
+	select DEVFREQ_GOV_PASSIVE
+	select DEVFREQ_GOV_USERSPACE
+	help
+	  This adds the generic DEVFREQ driver for i.MX interconnects. It
+	  allows adjusting NIC/NOC frequency.
+
 config ARM_TEGRA_DEVFREQ
 	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
 	depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || \
 		ARCH_TEGRA_132_SOC || ARCH_TEGRA_124_SOC || \
 		ARCH_TEGRA_210_SOC || \
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index 3eb4d5e6635c..3ca1ad0ecb97 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -7,10 +7,11 @@ obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+= governor_powersave.o
 obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
 obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
 
 # DEVFREQ Drivers
 obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
+obj-$(CONFIG_ARM_IMX_BUS_DEVFREQ)	+= imx-bus.o
 obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
 obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
 obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
 obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+= tegra20-devfreq.o
 
diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
new file mode 100644
index 000000000000..285e0f1ae6b1
--- /dev/null
+++ b/drivers/devfreq/imx-bus.c
@@ -0,0 +1,142 @@
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
+struct imx_bus {
+	struct devfreq_dev_profile profile;
+	struct devfreq *devfreq;
+	struct clk *clk;
+	struct devfreq_passive_data passive_data;
+};
+
+static int imx_bus_target(struct device *dev,
+		unsigned long *freq, u32 flags)
+{
+	struct imx_bus *priv = dev_get_drvdata(dev);
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
+static int imx_bus_get_cur_freq(struct device *dev, unsigned long *freq)
+{
+	struct imx_bus *priv = dev_get_drvdata(dev);
+
+	*freq = clk_get_rate(priv->clk);
+
+	return 0;
+}
+
+static int imx_bus_get_dev_status(struct device *dev,
+		struct devfreq_dev_status *stat)
+{
+	struct imx_bus *priv = dev_get_drvdata(dev);
+
+	stat->busy_time = 0;
+	stat->total_time = 0;
+	stat->current_frequency = clk_get_rate(priv->clk);
+
+	return 0;
+}
+
+static void imx_bus_exit(struct device *dev)
+{
+	dev_pm_opp_of_remove_table(dev);
+}
+
+static int imx_bus_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imx_bus *priv;
+	const char *gov = DEVFREQ_GOV_USERSPACE;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	/*
+	 * Fetch the clock to adjust but don't explictly enable.
+	 *
+	 * For imx bus clock clk_set_rate is safe no matter if the clock is on
+	 * or off and some peripheral side-buses might be off unless enabled by
+	 * drivers for devices on those specific buses.
+	 *
+	 * Rate adjustment on a disabled bus clock just takes effect later.
+	 */
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
+	priv->profile.target = imx_bus_target;
+	priv->profile.get_dev_status = imx_bus_get_dev_status;
+	priv->profile.exit = imx_bus_exit;
+	priv->profile.get_cur_freq = imx_bus_get_cur_freq;
+	priv->profile.initial_freq = clk_get_rate(priv->clk);
+
+	priv->devfreq = devm_devfreq_add_device(dev, &priv->profile,
+						gov, NULL);
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
+static const struct of_device_id imx_bus_of_match[] = {
+	{ .compatible = "fsl,imx8m-noc", },
+	{ .compatible = "fsl,imx8m-nic", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, imx_bus_of_match);
+
+static struct platform_driver imx_bus_platdrv = {
+	.probe		= imx_bus_probe,
+	.driver = {
+		.name	= "imx-bus-devfreq",
+		.of_match_table = of_match_ptr(imx_bus_of_match),
+	},
+};
+module_platform_driver(imx_bus_platdrv);
+
+MODULE_DESCRIPTION("Generic i.MX bus frequency scaling driver");
+MODULE_AUTHOR("Leonard Crestez <leonard.crestez@nxp.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

