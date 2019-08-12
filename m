Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 906638A693
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 20:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfHLSuD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 14:50:03 -0400
Received: from inva020.nxp.com ([92.121.34.13]:34646 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbfHLSuD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Aug 2019 14:50:03 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9E6961A06C6;
        Mon, 12 Aug 2019 20:50:00 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8F5421A06C3;
        Mon, 12 Aug 2019 20:50:00 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8E220205ED;
        Mon, 12 Aug 2019 20:49:59 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
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
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/7] PM / devfreq: Add dynamic scaling for imx ddr controller
Date:   Mon, 12 Aug 2019 21:49:49 +0300
Message-Id: <34e3a738cf2fea21116eca38b5b0b782e67ea9c3.1565633880.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1565633880.git.leonard.crestez@nxp.com>
References: <cover.1565633880.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1565633880.git.leonard.crestez@nxp.com>
References: <cover.1565633880.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add driver for dynamic scaling the DDR Controller on imx8m chips. Actual
frequency switching is implemented in TF-A, this driver just wraps the
SMC calls and updates the clk tree.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/devfreq/Makefile   |   2 +-
 drivers/devfreq/imx-ddrc.c | 379 +++++++++++++++++++++++++++++++++++++
 2 files changed, 380 insertions(+), 1 deletion(-)
 create mode 100644 drivers/devfreq/imx-ddrc.c

diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index c2463ed4c934..eba138914c74 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -7,11 +7,11 @@ obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+= governor_powersave.o
 obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
 obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
 
 # DEVFREQ Drivers
 obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
-obj-$(CONFIG_ARM_IMX_DEVFREQ)		+= imx-devfreq.o
+obj-$(CONFIG_ARM_IMX_DEVFREQ)		+= imx-devfreq.o imx-ddrc.o
 obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
 obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
 obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+= tegra20-devfreq.o
 
 # DEVFREQ Event Drivers
diff --git a/drivers/devfreq/imx-ddrc.c b/drivers/devfreq/imx-ddrc.c
new file mode 100644
index 000000000000..e46a1e711bc6
--- /dev/null
+++ b/drivers/devfreq/imx-ddrc.c
@@ -0,0 +1,379 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 NXP
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/devfreq.h>
+#include <linux/pm_opp.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/arm-smccc.h>
+
+#define IMX_SIP_DDR_DVFS			0xc2000004
+
+/* Values starting from 0 switch to specific frequency */
+#define IMX_SIP_DDR_FREQ_SET_HIGH		0x00
+
+/* Deprecated after moving IRQ handling to ATF */
+#define IMX_SIP_DDR_DVFS_WAIT_CHANGE		0x0F
+
+/* Query available frequencies. */
+#define IMX_SIP_DDR_DVFS_GET_FREQ_COUNT		0x10
+#define IMX_SIP_DDR_DVFS_GET_FREQ_INFO		0x11
+
+/*
+ * This should be in a 1:1 mapping with devicetree OPPs but
+ * firmware provides additional info.
+ */
+struct imx_ddrc_freq {
+	unsigned long rate;
+	unsigned long smcarg;
+	int dram_core_parent_index;
+	int dram_alt_parent_index;
+	int dram_apb_parent_index;
+};
+
+/* Hardware limitation */
+#define IMX_DDRC_MAX_FREQ_COUNT 4
+
+/*
+ * imx DRAM controller
+ *
+ * imx DRAM controller clocks have the following structure (abridged):
+ *
+ * +----------+       |\            +------+
+ * | dram_pll |-------|M| dram_core |      |
+ * +----------+       |U|---------->| D    |
+ *                 /--|X|           |  D   |
+ *   dram_alt_root |  |/            |   R  |
+ *                 |                |    C |
+ *            +---------+           |      |
+ *            |FIX DIV/4|           |      |
+ *            +---------+           |      |
+ *  composite:     |                |      |
+ * +----------+    |                |      |
+ * | dram_alt |----/                |      |
+ * +----------+                     |      |
+ * | dram_apb |-------------------->|      |
+ * +----------+                     +------+
+ *
+ * The dram_pll is used for higher rates and dram_alt is used for lower rates.
+ *
+ * Frequency switching is implemented in TF-A (via SMC call) and can change the
+ * configuration of the clocks, including mux parents. The dram_alt and
+ * dram_apb clocks are "imx composite" and their parent can change too.
+ *
+ * We need to prepare/enable the new mux parents head of switching and update
+ * their information afterwards.
+ */
+struct imx_ddrc {
+	struct devfreq_dev_profile profile;
+	struct devfreq *devfreq;
+
+	/* For frequency switching: */
+	struct clk *dram_core;
+	struct clk *dram_pll;
+	struct clk *dram_alt_root;
+	struct clk *dram_alt;
+	struct clk *dram_apb;
+
+	int freq_count;
+	struct imx_ddrc_freq freq_table[IMX_DDRC_MAX_FREQ_COUNT];
+};
+
+static struct imx_ddrc_freq* imx_ddrc_find_freq(struct imx_ddrc* priv,
+						unsigned long rate)
+{
+	int i;
+
+	for (i = 0; i < priv->freq_count; ++i)
+		if (priv->freq_table[i].rate == rate)
+			return &priv->freq_table[i];
+
+	return NULL;
+}
+
+static void imx_ddrc_smc_set_freq(int target_freq)
+{
+	struct arm_smccc_res res;
+	u32 online_cpus = 0;
+	int cpu;
+
+	local_irq_disable();
+
+	for_each_online_cpu(cpu)
+		online_cpus |= (1 << (cpu * 8));
+
+	/* change the ddr freqency */
+	arm_smccc_smc(IMX_SIP_DDR_DVFS, target_freq, online_cpus,
+			0, 0, 0, 0, 0, &res);
+
+	local_irq_enable();
+}
+
+struct clk *clk_get_parent_by_index(struct clk* clk, int index)
+{
+	struct clk_hw *hw;
+
+	hw = clk_hw_get_parent_by_index(__clk_get_hw(clk), index);
+
+	return hw ? hw->clk : NULL;
+}
+
+static int imx_ddrc_set_freq(struct device *dev, struct imx_ddrc_freq* freq)
+{
+	struct imx_ddrc *priv = dev_get_drvdata(dev);
+	struct clk* new_dram_core_parent;
+	struct clk* new_dram_alt_parent;
+	struct clk* new_dram_apb_parent;
+	int ret;
+
+	new_dram_core_parent = clk_get_parent_by_index(
+			priv->dram_core, freq->dram_core_parent_index - 1);
+	new_dram_alt_parent = clk_get_parent_by_index(
+			priv->dram_alt, freq->dram_alt_parent_index - 1);
+	new_dram_apb_parent = clk_get_parent_by_index(
+			priv->dram_apb, freq->dram_apb_parent_index - 1);
+
+	/* increase reference counts and ensure clks are ON before switch */
+	ret = clk_prepare_enable(new_dram_core_parent);
+	if (ret) {
+		dev_err(dev, "failed enable new dram_core parent: %d\n", ret);
+		goto out;
+	}
+	ret = clk_prepare_enable(new_dram_alt_parent);
+	if (ret) {
+		dev_err(dev, "failed enable new dram_alt parent: %d\n", ret);
+		goto out_dis_core;
+	}
+	ret = clk_prepare_enable(new_dram_apb_parent);
+	if (ret) {
+		dev_err(dev, "failed enable new dram_apb parent: %d\n", ret);
+		goto out_dis_alt;
+	}
+
+	imx_ddrc_smc_set_freq(freq->smcarg);
+
+	/* update parents in clk tree after switch. */
+	ret = clk_set_parent(priv->dram_core, new_dram_core_parent);
+	if (ret)
+		dev_err(dev, "failed clk_set_parent dram_core: %d\n", ret);
+	if (new_dram_alt_parent) {
+		ret = clk_set_parent(priv->dram_alt, new_dram_alt_parent);
+		if (ret)
+			dev_err(dev, "failed clk_set_parent dram_alt_parent: %d\n", ret);
+	}
+	if (new_dram_apb_parent) {
+		ret = clk_set_parent(priv->dram_apb, new_dram_apb_parent);
+		if (ret)
+			dev_err(dev, "failed clk_set_parent dram_apb_parent: %d\n", ret);
+	}
+	
+	/*
+	 * clk_set_parent transfer the reference count from old parent.
+	 * now we drop extra reference counts used during the switch
+	 */
+	clk_disable_unprepare(new_dram_apb_parent);
+out_dis_alt:
+	clk_disable_unprepare(new_dram_alt_parent);
+out_dis_core:
+	clk_disable_unprepare(new_dram_core_parent);
+out:
+	return ret;
+}
+
+static int imx_ddrc_target(struct device *dev, unsigned long *freq, u32 flags)
+{
+	struct imx_ddrc *priv = dev_get_drvdata(dev);
+	struct imx_ddrc_freq *freq_info;
+	struct dev_pm_opp *new_opp;
+	unsigned long new_freq, cur_freq;
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
+	cur_freq = clk_get_rate(priv->dram_core);
+
+	if (new_freq == cur_freq)
+		return 0;
+
+	freq_info = imx_ddrc_find_freq(priv, new_freq);
+	if (!freq_info)
+		return -EINVAL;
+	ret = imx_ddrc_set_freq(dev, freq_info);
+	if (ret)
+		dev_err(dev, "ddrc failed to change freq %lu to %lu\n",
+				cur_freq, new_freq);
+	else
+		dev_dbg(dev, "ddrc changed freq %lu to %lu\n",
+				cur_freq, new_freq);
+
+	return ret;
+}
+
+static int imx_ddrc_get_cur_freq(struct device *dev, unsigned long *freq)
+{
+	struct imx_ddrc *priv = dev_get_drvdata(dev);
+
+	*freq = clk_get_rate(priv->dram_core);
+
+	return 0;
+}
+
+static int imx_ddrc_get_dev_status(struct device *dev,
+		struct devfreq_dev_status *stat)
+{
+	struct imx_ddrc *priv = dev_get_drvdata(dev);
+
+	stat->busy_time = 0;
+	stat->total_time = 0;
+	stat->current_frequency = clk_get_rate(priv->dram_core);
+
+	return 0;
+}
+
+static int imx_ddrc_init_freq_info(struct device *dev)
+{
+	struct imx_ddrc *priv = dev_get_drvdata(dev);
+	struct arm_smccc_res res;
+	int index;
+
+	/*
+	 * An error here means DDR DVFS API not supported by firmware
+	 */
+	arm_smccc_smc(IMX_SIP_DDR_DVFS, IMX_SIP_DDR_DVFS_GET_FREQ_COUNT,
+			0, 0, 0, 0, 0, 0, &res);
+	priv->freq_count = res.a0;
+	if (priv->freq_count <= 0 || priv->freq_count > IMX_DDRC_MAX_FREQ_COUNT)
+		return -ENOSYS;
+
+	for (index = 0; index < priv->freq_count; ++index) {
+		struct imx_ddrc_freq *freq = &priv->freq_table[index];
+
+		arm_smccc_smc(IMX_SIP_DDR_DVFS, IMX_SIP_DDR_DVFS_GET_FREQ_INFO,
+				index, 0, 0, 0, 0, 0, &res);
+		/* Result should be strictly positive */
+		if ((long)res.a0 <= 0)
+			return -ENOSYS;
+
+		freq->rate = res.a0 * 250000;
+		freq->smcarg = index;
+		freq->dram_core_parent_index = res.a1;
+		freq->dram_alt_parent_index = res.a2;
+		freq->dram_apb_parent_index = res.a3;
+
+		/* dram_core has 2 options: dram_pll or dram_alt_root */
+		if (freq->dram_core_parent_index != 1 &&
+				freq->dram_core_parent_index != 2)
+			return -ENOSYS;
+		/* dram_apb and dram_alt have exactly 8 possible parents */
+		if (freq->dram_alt_parent_index > 8 ||
+				freq->dram_apb_parent_index > 8)
+			return -ENOSYS;
+		/* dram_core from alt requires explicit dram_alt parent */
+		if (freq->dram_core_parent_index == 2 &&
+				freq->dram_alt_parent_index == 0)
+			return -ENOSYS;
+	}
+
+	return 0;
+}
+
+static void imx_ddrc_exit(struct device *dev)
+{
+	struct imx_ddrc *priv = dev_get_drvdata(dev);
+
+	return dev_pm_opp_of_remove_table(dev);
+}
+
+static int imx_ddrc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imx_ddrc *priv;
+	struct device_node *events_node;
+	const char *gov = DEVFREQ_GOV_USERSPACE;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	ret = imx_ddrc_init_freq_info(dev);
+	if (ret) {
+		dev_err(dev, "failed to init firmware freq info: %d\n", ret);
+		return ret;
+	}
+
+	priv->dram_core = devm_clk_get(dev, "dram_core");
+	priv->dram_pll = devm_clk_get(dev, "dram_pll");
+	priv->dram_alt = devm_clk_get(dev, "dram_alt");
+	priv->dram_alt_root = devm_clk_get(dev, "dram_alt_root");
+	priv->dram_apb = devm_clk_get(dev, "dram_apb");
+	if (IS_ERR(priv->dram_core) ||
+		IS_ERR(priv->dram_pll) ||
+		IS_ERR(priv->dram_alt) ||
+		IS_ERR(priv->dram_alt_root) ||
+		IS_ERR(priv->dram_apb)) {
+		ret = PTR_ERR(priv->devfreq);
+		dev_err(dev, "failed to fetch clocks: %d\n", ret);
+		return ret;
+	}
+
+	ret = dev_pm_opp_of_add_table(dev);
+	if (ret < 0) {
+		dev_err(dev, "failed to get OPP table\n");
+		return ret;
+	}
+
+	priv->profile.polling_ms = 1000;
+	priv->profile.target = imx_ddrc_target;
+	priv->profile.get_dev_status = imx_ddrc_get_dev_status;
+	priv->profile.exit = imx_ddrc_exit;
+	priv->profile.get_cur_freq = imx_ddrc_get_cur_freq;
+	priv->profile.initial_freq = clk_get_rate(priv->dram_core);
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
+static const struct of_device_id imx_ddrc_of_match[] = {
+	{ .compatible = "fsl,imx8m-ddrc", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, imx_ddrc_of_match);
+
+static struct platform_driver imx_ddrc_platdrv = {
+	.probe		= imx_ddrc_probe,
+	.driver = {
+		.name	= "imx-ddrc-devfreq",
+		.of_match_table = of_match_ptr(imx_ddrc_of_match),
+	},
+};
+module_platform_driver(imx_ddrc_platdrv);
+
+MODULE_DESCRIPTION("i.MX DDR controller frequency driver");
+MODULE_AUTHOR("Leonard Crestez <leonard.crestez@nxp.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

