Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE9D59527
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 09:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfF1HkF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 03:40:05 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54578 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfF1HkF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Jun 2019 03:40:05 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B71671A0DC8;
        Fri, 28 Jun 2019 09:40:01 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B17411A0DB7;
        Fri, 28 Jun 2019 09:40:01 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id C9B0C205D5;
        Fri, 28 Jun 2019 09:40:00 +0200 (CEST)
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
Subject: [RFCv2 1/8] clk: imx8mm: Add dram freq switch support
Date:   Fri, 28 Jun 2019 10:39:49 +0300
Message-Id: <9db4b54dadf7bfa08bec1853243822c825b72b90.1561707104.git.leonard.crestez@nxp.com>
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

Add a compound clock encapsulating dram frequency switch support for
imx8m chips. This allows higher-level DVFS code to manipulate dram
frequency using standard clock framework APIs.

Linux-side implementation is similar in principle to imx_clk_cpu or a
composite clock. Only some preparation is done inside the kernel, the
actual freq switch is performed from TF-A code which runs from an SRAM
area.

This is an early proof-of-concept which only support low/high mode on
imx8mm.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---
Changes since v1:
* Implement determin_rate so that consumers can set_min_rate
* Initial freq table
Link to v1:

Among the possible cleanups:
 * Handle errors in low/high busfreq code and back off
 * Move irq to secure world
 * Try to use fewer clk parameters
 * Use a table of frequencies
 * More chips and frequencies
---
 drivers/clk/imx/Makefile                 |   1 +
 drivers/clk/imx/clk-imx8m-dram.c         | 357 +++++++++++++++++++++++
 drivers/clk/imx/clk-imx8mm.c             |  12 +
 drivers/clk/imx/clk.h                    |  13 +
 include/dt-bindings/clock/imx8mm-clock.h |   4 +-
 5 files changed, 386 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/clk-imx8m-dram.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 05641c64b317..0fc7195d6d3a 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -10,10 +10,11 @@ obj-$(CONFIG_MXC_CLK) += \
 	clk-fixup-div.o \
 	clk-fixup-mux.o \
 	clk-frac-pll.o \
 	clk-gate-exclusive.o \
 	clk-gate2.o \
+	clk-imx8m-dram.o \
 	clk-pfd.o \
 	clk-pfdv2.o \
 	clk-pllv1.o \
 	clk-pllv2.o \
 	clk-pllv3.o \
diff --git a/drivers/clk/imx/clk-imx8m-dram.c b/drivers/clk/imx/clk-imx8m-dram.c
new file mode 100644
index 000000000000..1d75be4a2f3a
--- /dev/null
+++ b/drivers/clk/imx/clk-imx8m-dram.c
@@ -0,0 +1,357 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 NXP
+ */
+
+#define DEBUG
+#include <linux/arm-smccc.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/of_irq.h>
+#include "clk.h"
+
+#define FSL_SIP_DDR_DVFS                0xc2000004
+
+/* Freq of setpoints is soc-dependent */
+#define FSL_SIP_DDR_FREQ_SET_HIGH	0x0
+#define FSL_SIP_DDR_FREQ_WAIT_DONE	0xf
+
+struct imx8m_dram_rate {
+	unsigned long	rate;
+	unsigned int	smcarg;
+};
+
+/*
+ * This clk roughly wraps the following clk structure:
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
+ * The DDR data rate is 4x dram_core
+ *
+ * The APB interface is only used for control registers and can otherwise
+ * be shut off.
+ *
+ * The dram_pll is used for higher rates and dram_alt is used for lower rates.
+ *
+ * The actual switch is done inside ATF, what this wrapper does is:
+ *  - Enable the new parents
+ *  - Call into ATF
+ *  - Set the new rates
+ *  - Set the new parents
+ *  - Drop the reference count added to new parents at step 1
+ *
+ * In practice only 2 rates are supported: low and high.
+ */
+
+struct dram_clk {
+	struct clk_hw	hw;
+	struct clk	*dram_core;
+	struct clk	*dram_apb;
+	struct clk	*dram_pll;
+	struct clk	*dram_alt;
+	struct clk	*dram_alt_root;
+	struct clk	*sys1_pll_40m;
+	struct clk	*sys1_pll_100m;
+	struct clk	*sys1_pll_800m;
+	int		irqs[CONFIG_NR_CPUS];
+
+	unsigned int rate_count;
+	const struct imx8m_dram_rate *rate_table;
+};
+
+static inline struct dram_clk *to_dram_clk(struct clk_hw *hw)
+{
+	return container_of(hw, struct dram_clk, hw);
+}
+
+static irqreturn_t wait_in_wfe_irq(int irq, void *dev_id)
+{
+	struct arm_smccc_res res;
+
+	/* call smc trap to ATF */
+	arm_smccc_smc(FSL_SIP_DDR_DVFS, FSL_SIP_DDR_FREQ_WAIT_DONE, 0,
+		0, 0, 0, 0, 0, &res);
+
+	return IRQ_HANDLED;
+}
+
+static void update_bus_freq(int target_freq)
+{
+	struct arm_smccc_res res;
+	u32 online_cpus = 0;
+	int cpu = 0;
+
+	local_irq_disable();
+
+	for_each_online_cpu(cpu)
+		online_cpus |= (1 << (cpu * 8));
+
+	/* change the ddr freqency */
+	arm_smccc_smc(FSL_SIP_DDR_DVFS, target_freq, online_cpus,
+		0, 0, 0, 0, 0, &res);
+
+	local_irq_enable();
+}
+
+static int dram_clk_ensure_irq_affinity(struct dram_clk* priv)
+{
+	int err, cpu;
+
+	for_each_online_cpu(cpu) {
+		err = irq_set_affinity(priv->irqs[cpu], cpumask_of(cpu));
+		if (err) {
+			pr_err("imx8m_dram_clk set irqs[%d] affinity failed: %d\n",
+				cpu, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/* Round UP */
+static const struct imx8m_dram_rate *dram_clk_find_rate(
+		struct dram_clk *priv,
+		unsigned long rate)
+{
+	int i;
+
+	for (i = priv->rate_count - 1; i >= 0; --i)
+		if (priv->rate_table[i].rate >= rate)
+			return &priv->rate_table[i];
+
+	return &priv->rate_table[0];
+}
+
+/* Round UP taking min and max into account */
+static int dram_clk_determine_rate(
+		struct clk_hw *hw,
+		struct clk_rate_request *req)
+{
+	struct dram_clk *priv = to_dram_clk(hw);
+	unsigned long tab_rate;
+	int i;
+
+	for (i = priv->rate_count - 1; i >= 0; --i) {
+		tab_rate = priv->rate_table[i].rate;
+		if (tab_rate >= req->rate &&
+		    tab_rate >= req->min_rate &&
+		    tab_rate <= req->max_rate)
+		{
+			req->rate = tab_rate;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int dram_clk_set_low(struct dram_clk *priv)
+{
+	clk_prepare_enable(priv->sys1_pll_40m);
+	clk_prepare_enable(priv->dram_alt_root);
+	clk_prepare_enable(priv->sys1_pll_100m);
+
+	/* switch the DDR frequency */
+	update_bus_freq(0x2);
+
+	/* correct the clock tree info */
+	clk_set_parent(priv->dram_alt, priv->sys1_pll_100m);
+	clk_set_parent(priv->dram_core, priv->dram_alt_root);
+	clk_set_parent(priv->dram_apb, priv->sys1_pll_40m);
+	clk_set_rate(priv->dram_apb, 20000000);
+	clk_disable_unprepare(priv->sys1_pll_100m);
+	clk_disable_unprepare(priv->sys1_pll_40m);
+	clk_disable_unprepare(priv->dram_alt_root);
+	return 0;
+}
+
+static int dram_clk_set_high(struct dram_clk *priv)
+{
+	clk_prepare_enable(priv->sys1_pll_800m);
+	clk_prepare_enable(priv->dram_pll);
+
+	/* switch the DDR frequency */
+	update_bus_freq(0x0);
+
+	/* correct the clock tree info */
+	clk_set_parent(priv->dram_apb, priv->sys1_pll_800m);
+	clk_set_rate(priv->dram_apb, 160000000);
+	clk_set_parent(priv->dram_core, priv->dram_pll);
+	clk_disable_unprepare(priv->sys1_pll_800m);
+	clk_disable_unprepare(priv->dram_pll);
+
+	return 0;
+}
+
+static int dram_clk_set_rate(
+		struct clk_hw *hw,
+		unsigned long rate,
+		unsigned long parent_rate)
+{
+	struct dram_clk *priv = to_dram_clk(hw);
+	const struct imx8m_dram_rate *opp = dram_clk_find_rate(priv, rate);
+	int ret;
+
+	ret = dram_clk_ensure_irq_affinity(priv);
+	if (ret)
+		return ret;
+
+	if (opp->smcarg == 2) {
+		ret = dram_clk_set_low(priv);
+	} else if (opp->smcarg == 0) {
+		ret = dram_clk_set_high(priv);
+	} else {
+		ret = -EINVAL;
+	}
+
+	if (ret == 0)
+		pr_debug("%s freq set to %lu\n", clk_hw_get_name(hw), opp->rate);
+	else
+		pr_debug("%s freq set fail: %d\n", clk_hw_get_name(hw), ret);
+
+	return ret;
+}
+
+static unsigned long dram_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct dram_clk *priv = to_dram_clk(hw);
+
+	return clk_get_rate(priv->dram_core);
+}
+
+static const struct clk_ops dram_clk_ops = {
+	.determine_rate	= dram_clk_determine_rate,
+	.recalc_rate	= dram_clk_recalc_rate,
+	.set_rate	= dram_clk_set_rate,
+};
+
+static int dram_clk_init_irqs(struct dram_clk* priv, struct device_node *np)
+{
+	int err, irq, cpu;
+
+	for_each_possible_cpu(cpu) {
+		irq = of_irq_get(np, cpu);
+		if (irq < 0) {
+			pr_err("imx8m_dram_clk fail of_irq_get %d\n", irq);
+			return irq;
+		}
+
+		err = request_irq(irq, wait_in_wfe_irq,
+				IRQF_PERCPU, "ddrc", NULL);
+		if (err) {
+			pr_err("imx8m_dram_clk request irq %d failed: %d\n",
+				irq, err);
+			return err;
+		}
+		priv->irqs[cpu] = irq;
+	}
+
+	return 0;
+}
+
+static void dram_clk_free_irqs(struct dram_clk* priv)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		free_irq(priv->irqs[cpu], NULL);
+		priv->irqs[cpu] = 0;
+	}
+}
+
+static const struct imx8m_dram_rate imx8mq_dram_rate_table[] = {
+	{
+		.rate	= 800000000,
+		.smcarg	= 0x0,
+	},
+	{
+		.rate	= 25000000,
+		.smcarg	= 0x2,
+	},
+};
+
+static const struct imx8m_dram_rate imx8mm_dram_rate_table[] = {
+	{
+		.rate	= 750000000,
+		.smcarg	= 0x0,
+	},
+	{
+		.rate	= 25000000,
+		.smcarg	= 0x2,
+	},
+};
+
+struct clk* imx8m_dram_clk(
+		struct device_node* np,
+		const char *name, const char* parent_name,
+		struct clk* dram_core,
+		struct clk* dram_apb,
+		struct clk* dram_pll,
+		struct clk* dram_alt,
+		struct clk* dram_alt_root,
+		struct clk* sys1_pll_40m,
+		struct clk* sys1_pll_100m,
+		struct clk* sys1_pll_800m)
+{
+	struct dram_clk *priv;
+	struct clk *clk;
+	struct clk_init_data init;
+	int err;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return ERR_PTR(-ENOMEM);
+
+	priv->dram_apb = dram_apb;
+	priv->dram_core = dram_core;
+	priv->dram_pll = dram_pll;
+	priv->dram_alt = dram_alt;
+	priv->dram_alt_root = dram_alt_root;
+	priv->sys1_pll_40m = sys1_pll_40m;
+	priv->sys1_pll_100m = sys1_pll_100m;
+	priv->sys1_pll_800m = sys1_pll_800m;
+	priv->rate_count = ARRAY_SIZE(imx8mm_dram_rate_table);
+	priv->rate_table = imx8mm_dram_rate_table;
+
+	init.name = name;
+	init.ops = &dram_clk_ops;
+	init.flags = CLK_IS_CRITICAL;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	err = dram_clk_init_irqs(priv, np);
+	if (err)
+		goto err_free_priv;
+
+	priv->hw.init = &init;
+	clk = clk_register(NULL, &priv->hw);
+	if (IS_ERR(clk)) {
+		err = PTR_ERR(clk);
+		goto err_free_irqs;
+	}
+	return clk;
+
+err_free_irqs:
+	dram_clk_free_irqs(priv);
+err_free_priv:
+	kfree(priv);
+	return ERR_PTR(err);
+}
diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 6b8e75df994d..8e19a6fdc415 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -660,10 +660,22 @@ static int __init imx8mm_clocks_init(struct device_node *ccm_node)
 	clks[IMX8MM_CLK_GPT_3M] = imx_clk_fixed_factor("gpt_3m", "osc_24m", 1, 8);
 
 	clks[IMX8MM_CLK_DRAM_ALT_ROOT] = imx_clk_fixed_factor("dram_alt_root", "dram_alt", 1, 4);
 	clks[IMX8MM_CLK_DRAM_CORE] = imx_clk_mux2_flags("dram_core_clk", base + 0x9800, 24, 1, imx8mm_dram_core_sels, ARRAY_SIZE(imx8mm_dram_core_sels), CLK_IS_CRITICAL);
 
+	clks[IMX8MM_CLK_DRAM] = imx8m_dram_clk(
+			ccm_node,
+			"dram", "dram_core_clk",
+			clks[IMX8MM_CLK_DRAM_CORE],
+			clks[IMX8MM_CLK_DRAM_APB],
+			clks[IMX8MM_DRAM_PLL_OUT],
+			clks[IMX8MM_CLK_DRAM_ALT],
+			clks[IMX8MM_CLK_DRAM_ALT_ROOT],
+			clks[IMX8MM_SYS_PLL1_40M],
+			clks[IMX8MM_SYS_PLL1_100M],
+			clks[IMX8MM_SYS_PLL1_800M]);
+
 	clks[IMX8MM_CLK_ARM] = imx_clk_cpu("arm", "arm_a53_div",
 					   clks[IMX8MM_CLK_A53_DIV],
 					   clks[IMX8MM_CLK_A53_SRC],
 					   clks[IMX8MM_ARM_PLL_OUT],
 					   clks[IMX8MM_CLK_24M]);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index d94d9cb079d3..858547fbad58 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -468,6 +468,19 @@ struct clk *imx8m_clk_composite_flags(const char *name,
 
 struct clk_hw *imx_clk_divider_gate(const char *name, const char *parent_name,
 		unsigned long flags, void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, const struct clk_div_table *table,
 		spinlock_t *lock);
+
+struct clk* imx8m_dram_clk(
+		struct device_node *np,
+		const char *name, const char* parent_name,
+		struct clk* dram_core,
+		struct clk* dram_apb,
+		struct clk* dram_pll,
+		struct clk* dram_alt,
+		struct clk* dram_alt_root,
+		struct clk* sys1_pll_40m,
+		struct clk* sys1_pll_100m,
+		struct clk* sys1_pll_800m);
+
 #endif
diff --git a/include/dt-bindings/clock/imx8mm-clock.h b/include/dt-bindings/clock/imx8mm-clock.h
index 07e6c686f3ef..dde146b923a8 100644
--- a/include/dt-bindings/clock/imx8mm-clock.h
+++ b/include/dt-bindings/clock/imx8mm-clock.h
@@ -246,8 +246,10 @@
 #define IMX8MM_CLK_GPIO5_ROOT			227
 
 #define IMX8MM_CLK_SNVS_ROOT			228
 #define IMX8MM_CLK_GIC				229
 
-#define IMX8MM_CLK_END				230
+#define IMX8MM_CLK_DRAM				230
+
+#define IMX8MM_CLK_END				231
 
 #endif
-- 
2.17.1

