Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A06F035CE2
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 14:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfFEMbl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 08:31:41 -0400
Received: from inva020.nxp.com ([92.121.34.13]:37990 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbfFEMbl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jun 2019 08:31:41 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 397A41A0869;
        Wed,  5 Jun 2019 14:31:38 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2B9371A0867;
        Wed,  5 Jun 2019 14:31:38 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (gw_auto.ea.freescale.net [10.171.94.100])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 4C7A2205FA;
        Wed,  5 Jun 2019 14:31:37 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel@pengutronix.de,
        linux-clk@vger.kernel.org, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC] devfreq: Add generic devfreq-dt driver
Date:   Wed,  5 Jun 2019 15:31:33 +0300
Message-Id: <e48d7e3d71166cea20c3c200300e0ffa6d26d085.1559737589.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a generic devfreq driver which switches frequencies from an OPP
table based on userspace requests.

This can be used to testing frequency switching on buses or devices
which can be manipulated with a single "clk" but don't otherwise have
any smarter complex targeting logic or performance counters.

It relies entirely on the dev_pm_opp subsystem and be used to test
arbitrary opp tables.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---
I used this to test imx8mm dram freq switching in complete isolation:

    https://patchwork.kernel.org/patch/10968303/

Perhaps it could be useful for others? It is somewhat analogous to
cpufreq-dt.

It might be possible to pair this with a generic devfreq event driver
based entirely on perf.

 drivers/devfreq/Kconfig      |  11 +++
 drivers/devfreq/Makefile     |   3 +
 drivers/devfreq/devfreq-dt.c | 166 +++++++++++++++++++++++++++++++++++
 3 files changed, 180 insertions(+)
 create mode 100644 drivers/devfreq/devfreq-dt.c

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index ba98a4e3ad33..abfb3b8da1c2 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -112,8 +112,19 @@ config ARM_RK3399_DMC_DEVFREQ
 	help
           This adds the DEVFREQ driver for the RK3399 DMC(Dynamic Memory Controller).
           It sets the frequency for the memory controller and reads the usage counts
           from hardware.
 
+config DEVFREQ_DT
+	tristate "Simple DT-based DEVFREQ Driver"
+	select DEVFREQ_GOV_USERSPACE
+	help
+	  This adds a generic DT based devfreq driver for frequency management
+	  of arbitrary devices with no special support.
+
+	  This can be used to test arbitrary OPP tables.
+
+	  Only supports the userspace governor.
+
 source "drivers/devfreq/event/Kconfig"
 
 endif # PM_DEVFREQ
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index 32b8d4d3f12c..3d57b007b6c2 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -10,7 +10,10 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
 # DEVFREQ Drivers
 obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
 obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
 obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra-devfreq.o
 
+# Generic DEVFREQ driver
+obj-$(CONFIG_DEVFREQ_DT)		+= devfreq-dt.o
+
 # DEVFREQ Event Drivers
 obj-$(CONFIG_PM_DEVFREQ_EVENT)		+= event/
diff --git a/drivers/devfreq/devfreq-dt.c b/drivers/devfreq/devfreq-dt.c
new file mode 100644
index 000000000000..fa70fa216c23
--- /dev/null
+++ b/drivers/devfreq/devfreq-dt.c
@@ -0,0 +1,166 @@
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
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+// FIXME:
+#include <../opp/opp.h>
+
+struct devfreq_dt {
+	struct device *dev;
+	struct devfreq *devfreq;
+	struct mutex lock;
+
+	unsigned long curr_freq;
+};
+
+/*
+ * Must necessary function for devfreq simple-ondemand governor
+ */
+static int devfreq_dt_target(struct device *dev, unsigned long *freq, u32 flags)
+{
+	struct devfreq_dt *priv = dev_get_drvdata(dev);
+	struct dev_pm_opp *new_opp;
+	unsigned long new_freq;
+	int ret = 0;
+
+	mutex_lock(&priv->lock);
+
+	new_opp = devfreq_recommended_opp(dev, freq, flags);
+	if (IS_ERR(new_opp)) {
+		ret = PTR_ERR(new_opp);
+		dev_err(dev, "failed to get recommended opp: %d\n", ret);
+		goto out;
+	}
+
+	new_freq = dev_pm_opp_get_freq(new_opp);
+	dev_dbg(dev, "try frequency %luHz for %luHz", new_freq, *freq);
+	ret = dev_pm_opp_set_rate(priv->dev, new_freq);
+	if (ret == 0) {
+		dev_info(dev, "set frequency %luHz for %luHz", new_freq, *freq);
+		priv->curr_freq = new_freq;
+	} else {
+		dev_err(dev, "fail set frequency %luHz for %luHz", new_freq, *freq);
+	}
+out:
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
+static int devfreq_dt_get_cur_freq(struct device *dev, unsigned long *freq)
+{
+	struct opp_table *tab;
+	struct clk* clk;
+
+	tab = dev_pm_opp_get_opp_table(dev);
+	clk = tab->clk;
+	*freq = clk_get_rate(tab->clk);
+
+	return 0;
+}
+
+static int devfreq_dt_get_dev_status(struct device *dev,
+				     struct devfreq_dev_status *stat)
+{
+	struct devfreq_dt *priv = dev_get_drvdata(dev);
+
+	stat->current_frequency = priv->curr_freq;
+	stat->busy_time = 100;
+	stat->total_time = 0;
+
+	return 0;
+}
+
+static void devfreq_dt_exit(struct device *dev)
+{
+	return dev_pm_opp_of_remove_table(dev);
+}
+
+static int devfreq_dt_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct devfreq_dev_profile *profile;
+	struct devfreq_dt *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	mutex_init(&priv->lock);
+	priv->dev = &pdev->dev;
+	platform_set_drvdata(pdev, priv);
+
+	/* Parse the device-tree to get the resource information */
+	/* Get the freq and voltage from OPP table to scale the priv freq */
+	ret = dev_pm_opp_of_add_table(dev);
+	if (ret < 0) {
+		dev_err(dev, "failed to get OPP table\n");
+		return ret;
+	}
+
+	profile = devm_kzalloc(dev, sizeof(*profile), GFP_KERNEL);
+	if (!profile) {
+		ret = -ENOMEM;
+		goto err_remove_table;
+	}
+
+	profile->polling_ms = 1000;
+	profile->target = devfreq_dt_target;
+	profile->get_dev_status = devfreq_dt_get_dev_status;
+	profile->exit = devfreq_dt_exit;
+	profile->get_cur_freq = devfreq_dt_get_cur_freq;
+	devfreq_dt_get_cur_freq(dev, &profile->initial_freq);
+
+	priv->devfreq = devm_devfreq_add_device(dev, profile,
+						DEVFREQ_GOV_USERSPACE,
+						NULL);
+	if (IS_ERR(priv->devfreq)) {
+		dev_err(dev, "failed to add devfreq device\n");
+		ret = PTR_ERR(priv->devfreq);
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
+static void devfreq_dt_shutdown(struct platform_device *pdev)
+{
+	struct devfreq_dt *priv = dev_get_drvdata(&pdev->dev);
+
+	devfreq_suspend_device(priv->devfreq);
+}
+
+static const struct of_device_id devfreq_dt_of_match[] = {
+	{ .compatible = "generic-devfreq", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, devfreq_dt_of_match);
+
+static struct platform_driver devfreq_dt_platdrv = {
+	.probe		= devfreq_dt_probe,
+	.shutdown	= devfreq_dt_shutdown,
+	.driver = {
+		.name	= "devfreq-dt",
+		.of_match_table = of_match_ptr(devfreq_dt_of_match),
+	},
+};
+module_platform_driver(devfreq_dt_platdrv);
+
+MODULE_DESCRIPTION("Generic devfreq-dt driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

