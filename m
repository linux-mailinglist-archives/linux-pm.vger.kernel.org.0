Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88E1612711E
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 00:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfLSXDG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 18:03:06 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:35918 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfLSXDG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 18:03:06 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191219230302epoutp02e000c9f59beffd54796fdc4439f33c1e~h6CNAZYby1273612736epoutp02B
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 23:03:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191219230302epoutp02e000c9f59beffd54796fdc4439f33c1e~h6CNAZYby1273612736epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576796582;
        bh=GEAkY+ue1gNZs0B5obdcYdEyJxTIapY+2YlSllCpMHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HMVB7VR+7BNCjx0OxrNWPMVLfCn9Uvdz3kCldYpOen1482JxfDOfrJyQ91LFVqg52
         m7B+Cr+S+bK9r9nXLLEwHU7CVnqpvEajhKi76oxMfjhy+lYOVBT5wC7kI6odilSeh/
         Cc2RzP8H1b74+DEBnWjw69I2jOkQcIaj9jgsfRQw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191219230302epcas1p4e96cc8ec9a04a75ec54bbfdcd83d4ebd~h6CMiyaQP0556405564epcas1p4j;
        Thu, 19 Dec 2019 23:03:02 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.153]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47f6q6582vzMqYkY; Thu, 19 Dec
        2019 23:02:58 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.A6.51241.2A10CFD5; Fri, 20 Dec 2019 08:02:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191219230258epcas1p16ec64c3a06eafd9f0a3784d18541ce5c~h6CIzF3dD2546225462epcas1p1l;
        Thu, 19 Dec 2019 23:02:58 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191219230258epsmtrp2ec51bc1e0265f93473e099688ad54978~h6CIxvxes2882328823epsmtrp28;
        Thu, 19 Dec 2019 23:02:58 +0000 (GMT)
X-AuditID: b6c32a39-14bff7000001c829-cf-5dfc01a27067
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7E.E7.06569.2A10CFD5; Fri, 20 Dec 2019 08:02:58 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191219230257epsmtip14bf74683d89c4f280a48c22d75c4d04e~h6CIn2SQO1140211402epsmtip1B;
        Thu, 19 Dec 2019 23:02:57 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        leonard.crestez@nxp.com, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [v8 PATCH] PM / devfreq: Add dynamic scaling for imx8m ddr
 controller
Date:   Fri, 20 Dec 2019 08:09:19 +0900
Message-Id: <20191219230919.16037-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <c0b332b85560e39d7dbb5e88b99bbed1d1b32373.1574458460.git.leonard.crestez@nxp.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7bCmvu4ixj+xBmvPaVpc//Kc1WL+kXOs
        Fmeb3rBbrLj7kdXi8q45bBafe48wWtxuXMHmwO6x8d0OJo++LasYPT5vkgtgjsq2yUhNTEkt
        UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAFarqRQlphTChQKSCwu
        VtK3synKLy1JVcjILy6xVUotSMkpsCzQK07MLS7NS9dLzs+1MjQwMDIFKkzIzrh18xVjwb5W
        xoodb4oaGB9mdDFyckgImEi0LL/P1sXIxSEksINR4uT+n4wQzidGiXmfDkE53xglFq3/zQ7T
        8nROJytEYi+jxK5dk6CqvjBKnDu7DqyKTUBLYv+LG2wgtoiAjMTUK/vBOpgFljJKHF5ykgkk
        ISwQIPHqwGoWEJtFQFWi9xfIck4OXgEridVPXkKtk5dYveEAcxcjBwenQJzE5gU1EOEZbBLN
        HxghbBeJpi2nmSBsYYlXx7dAtUpJfH63lw3CrpZYefII2KMSAh2MElv2X2CFSBhL7F86mQlk
        PrOApsT6XfoQYUWJnb/ngs1nFuCTePe1hxWkREKAV6KjTQiiRFni8oO7UGslJRa3d0Kt8pC4
        1jMfbLqQwEZGiVWbSyYwys1CWLCAkXEVo1hqQXFuemqxYYEpcoxtYgQnLi3LHYzHzvkcYhTg
        YFTi4XVI+x0rxJpYVlyZe4hRgoNZSYT3dsfPWCHelMTKqtSi/Pii0pzU4kOMpsBwnMgsJZqc
        D0yqeSXxhqZGxsbGFiaGZqaGhkrivBw/LsYKCaQnlqRmp6YWpBbB9DFxcEo1MEpqll9W7XTf
        I3bu8or1v1X3JSbnlVU8iJn3493ym0X5V7KEt3LIJcevLWkQ63qYtc2z3Npo+UdpG01m6c2i
        bieO9LCpL5367xO7YO3ZnLhNGorLK+olVVkrwj9v2LNn6oFKgaD479P5XAqEPUtDJnzdwnXw
        6FUfbrU9p4qihV8821++2O7kJyWW4oxEQy3mouJEADtIwPRyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJLMWRmVeSWpSXmKPExsWy7bCSnO4ixj+xBt3zWCyuf3nOajH/yDlW
        i7NNb9gtVtz9yGpxedccNovPvUcYLW43rmBzYPfY+G4Hk0ffllWMHp83yQUwR3HZpKTmZJal
        FunbJXBl3Lr5irFgXytjxY43RQ2MDzO6GDk5JARMJJ7O6WTtYuTiEBLYzSix9PoxdoiEpMS0
        i0eZuxg5gGxhicOHiyFqPjFKzL62hwWkhk1AS2L/ixtsILaIgIzE1Cv7wQYxC6xmlLhw7Cwr
        SEJYwE9i87FOJhCbRUBVovfXT0YQm1fASmL1k5dQy+QlVm84ALaMUyBOYvOCGpCwkECsxO4j
        v1kmMPItYGRYxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHGBaWjsYT5yIP8QowMGo
        xMPrkPY7Vog1say4MvcQowQHs5II7+2On7FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeeXzj0UK
        CaQnlqRmp6YWpBbBZJk4OKUaGD2VWO/9UdvYcHbynN151xZ+Pld2KcOdJ7RE99HxGXmZeYLP
        BGcs7D37hHPV2kcvchYfE5vcUGil3H0vJJD9nIDnG99kN9PI+asNY2c+U6yIvnJg6t0paV9v
        9q9bsSc7bJHsf8ugJnWZc1f3p8/e/+joQ/dLzn8vZ1y+lzjx/BG59ma+u40vm/8osRRnJBpq
        MRcVJwIAJwPYFywCAAA=
X-CMS-MailID: 20191219230258epcas1p16ec64c3a06eafd9f0a3784d18541ce5c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191219230258epcas1p16ec64c3a06eafd9f0a3784d18541ce5c
References: <c0b332b85560e39d7dbb5e88b99bbed1d1b32373.1574458460.git.leonard.crestez@nxp.com>
        <CGME20191219230258epcas1p16ec64c3a06eafd9f0a3784d18541ce5c@epcas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

Add driver for dynamic scaling the DDR Controller on imx8m chips. Actual
frequency switching is implemented inside TF-A, this driver wraps the
SMC calls and synchronizes the clk tree.

The DRAM clocks on imx8m have the following structure (abridged):

 +----------+       |\            +------+
 | dram_pll |-------|M| dram_core |      |
 +----------+       |U|---------->| D    |
                 /--|X|           |  D   |
   dram_alt_root |  |/            |   R  |
                 |                |    C |
            +---------+           |      |
            |FIX DIV/4|           |      |
            +---------+           |      |
  composite:     |                |      |
 +----------+    |                |      |
 | dram_alt |----/                |      |
 +----------+                     |      |
 | dram_apb |-------------------->|      |
 +----------+                     +------+

The dram_pll is used for higher rates and dram_alt is used for lower
rates. The dram_alt and dram_apb clocks are "imx composite" and their
parent can also be modified.

This driver will prepare/enable the new parents ahead of switching (so
that the expected roots are enabled) and afterwards it will call
clk_set_parent to ensure the parents in clock framework are up-to-date.

The driver relies on dram_pll dram_alt and dram_apb being marked with
CLK_GET_RATE_NOCACHE for rate updates.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
[cw00.choi: Edit the COMPILE_TEST module dependency in Kconfig]
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
Changes from v7:
- Squash patch[1] to this patch
[1] https://patchwork.kernel.org/patch/11303869/
- [PATCH] PM / devfreq: imx8m-ddrc: Fix argument swap in error print

 drivers/devfreq/Kconfig      |  10 +
 drivers/devfreq/Makefile     |   1 +
 drivers/devfreq/imx8m-ddrc.c | 465 +++++++++++++++++++++++++++++++++++
 3 files changed, 476 insertions(+)
 create mode 100644 drivers/devfreq/imx8m-ddrc.c

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index ca45d57ad947..8485f948caeb 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -91,6 +91,16 @@ config ARM_EXYNOS_BUS_DEVFREQ
 	  and adjusts the operating frequencies and voltages with OPP support.
 	  This does not yet operate with optimal voltages.
 
+config ARM_IMX8M_DDRC_DEVFREQ
+	tristate "i.MX8M DDRC DEVFREQ Driver"
+	depends on (ARCH_MXC && HAVE_ARM_SMCCC) || \
+		(COMPILE_TEST && HAVE_ARM_SMCCC)
+	select DEVFREQ_GOV_SIMPLE_ONDEMAND
+	select DEVFREQ_GOV_USERSPACE
+	help
+	  This adds the DEVFREQ driver for the i.MX8M DDR Controller. It allows
+	  adjusting DRAM frequency.
+
 config ARM_TEGRA_DEVFREQ
 	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
 	depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || \
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index 338ae8440db6..3eb4d5e6635c 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
 
 # DEVFREQ Drivers
 obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
+obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
 obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
 obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
 obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+= tegra20-devfreq.o
diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
new file mode 100644
index 000000000000..01ff9afdc8bf
--- /dev/null
+++ b/drivers/devfreq/imx8m-ddrc.c
@@ -0,0 +1,465 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 NXP
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
+struct imx8m_ddrc_freq {
+	unsigned long rate;
+	unsigned long smcarg;
+	int dram_core_parent_index;
+	int dram_alt_parent_index;
+	int dram_apb_parent_index;
+};
+
+/* Hardware limitation */
+#define IMX8M_DDRC_MAX_FREQ_COUNT 4
+
+/*
+ * i.MX8M DRAM Controller clocks have the following structure (abridged):
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
+struct imx8m_ddrc {
+	struct devfreq_dev_profile profile;
+	struct devfreq *devfreq;
+
+	/* For frequency switching: */
+	struct clk *dram_core;
+	struct clk *dram_pll;
+	struct clk *dram_alt;
+	struct clk *dram_apb;
+
+	int freq_count;
+	struct imx8m_ddrc_freq freq_table[IMX8M_DDRC_MAX_FREQ_COUNT];
+};
+
+static struct imx8m_ddrc_freq *imx8m_ddrc_find_freq(struct imx8m_ddrc *priv,
+						    unsigned long rate)
+{
+	struct imx8m_ddrc_freq *freq;
+	int i;
+
+	/*
+	 * Firmware reports values in MT/s, so we round-down from Hz
+	 * Rounding is extra generous to ensure a match.
+	 */
+	rate = DIV_ROUND_CLOSEST(rate, 250000);
+	for (i = 0; i < priv->freq_count; ++i) {
+		freq = &priv->freq_table[i];
+		if (freq->rate == rate ||
+				freq->rate + 1 == rate ||
+				freq->rate - 1 == rate)
+			return freq;
+	}
+
+	return NULL;
+}
+
+static void imx8m_ddrc_smc_set_freq(int target_freq)
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
+static struct clk *clk_get_parent_by_index(struct clk *clk, int index)
+{
+	struct clk_hw *hw;
+
+	hw = clk_hw_get_parent_by_index(__clk_get_hw(clk), index);
+
+	return hw ? hw->clk : NULL;
+}
+
+static int imx8m_ddrc_set_freq(struct device *dev, struct imx8m_ddrc_freq *freq)
+{
+	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
+	struct clk *new_dram_core_parent;
+	struct clk *new_dram_alt_parent;
+	struct clk *new_dram_apb_parent;
+	int ret;
+
+	/*
+	 * Fetch new parents
+	 *
+	 * new_dram_alt_parent and new_dram_apb_parent are optional but
+	 * new_dram_core_parent is not.
+	 */
+	new_dram_core_parent = clk_get_parent_by_index(
+			priv->dram_core, freq->dram_core_parent_index - 1);
+	if (!new_dram_core_parent) {
+		dev_err(dev, "failed to fetch new dram_core parent\n");
+		return -EINVAL;
+	}
+	if (freq->dram_alt_parent_index) {
+		new_dram_alt_parent = clk_get_parent_by_index(
+				priv->dram_alt,
+				freq->dram_alt_parent_index - 1);
+		if (!new_dram_alt_parent) {
+			dev_err(dev, "failed to fetch new dram_alt parent\n");
+			return -EINVAL;
+		}
+	} else
+		new_dram_alt_parent = NULL;
+
+	if (freq->dram_apb_parent_index) {
+		new_dram_apb_parent = clk_get_parent_by_index(
+				priv->dram_apb,
+				freq->dram_apb_parent_index - 1);
+		if (!new_dram_apb_parent) {
+			dev_err(dev, "failed to fetch new dram_apb parent\n");
+			return -EINVAL;
+		}
+	} else
+		new_dram_apb_parent = NULL;
+
+	/* increase reference counts and ensure clks are ON before switch */
+	ret = clk_prepare_enable(new_dram_core_parent);
+	if (ret) {
+		dev_err(dev, "failed to enable new dram_core parent: %d\n",
+			ret);
+		goto out;
+	}
+	ret = clk_prepare_enable(new_dram_alt_parent);
+	if (ret) {
+		dev_err(dev, "failed to enable new dram_alt parent: %d\n",
+			ret);
+		goto out_disable_core_parent;
+	}
+	ret = clk_prepare_enable(new_dram_apb_parent);
+	if (ret) {
+		dev_err(dev, "failed to enable new dram_apb parent: %d\n",
+			ret);
+		goto out_disable_alt_parent;
+	}
+
+	imx8m_ddrc_smc_set_freq(freq->smcarg);
+
+	/* update parents in clk tree after switch. */
+	ret = clk_set_parent(priv->dram_core, new_dram_core_parent);
+	if (ret)
+		dev_warn(dev, "failed to set dram_core parent: %d\n", ret);
+	if (new_dram_alt_parent) {
+		ret = clk_set_parent(priv->dram_alt, new_dram_alt_parent);
+		if (ret)
+			dev_warn(dev, "failed to set dram_alt parent: %d\n",
+				 ret);
+	}
+	if (new_dram_apb_parent) {
+		ret = clk_set_parent(priv->dram_apb, new_dram_apb_parent);
+		if (ret)
+			dev_warn(dev, "failed to set dram_apb parent: %d\n",
+				 ret);
+	}
+
+	/*
+	 * Explicitly refresh dram PLL rate.
+	 *
+	 * Even if it's marked with CLK_GET_RATE_NOCACHE the rate will not be
+	 * automatically refreshed when clk_get_rate is called on children.
+	 */
+	clk_get_rate(priv->dram_pll);
+
+	/*
+	 * clk_set_parent transfer the reference count from old parent.
+	 * now we drop extra reference counts used during the switch
+	 */
+	clk_disable_unprepare(new_dram_apb_parent);
+out_disable_alt_parent:
+	clk_disable_unprepare(new_dram_alt_parent);
+out_disable_core_parent:
+	clk_disable_unprepare(new_dram_core_parent);
+out:
+	return ret;
+}
+
+static int imx8m_ddrc_target(struct device *dev, unsigned long *freq, u32 flags)
+{
+	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
+	struct imx8m_ddrc_freq *freq_info;
+	struct dev_pm_opp *new_opp;
+	unsigned long old_freq, new_freq;
+	int ret;
+
+	new_opp = devfreq_recommended_opp(dev, freq, flags);
+	if (IS_ERR(new_opp)) {
+		ret = PTR_ERR(new_opp);
+		dev_err(dev, "failed to get recommended opp: %d\n", ret);
+		return ret;
+	}
+	dev_pm_opp_put(new_opp);
+
+	old_freq = clk_get_rate(priv->dram_core);
+	if (*freq == old_freq)
+		return 0;
+
+	freq_info = imx8m_ddrc_find_freq(priv, *freq);
+	if (!freq_info)
+		return -EINVAL;
+
+	/*
+	 * Read back the clk rate to verify switch was correct and so that
+	 * we can report it on all error paths.
+	 */
+	ret = imx8m_ddrc_set_freq(dev, freq_info);
+
+	new_freq = clk_get_rate(priv->dram_core);
+	if (ret)
+		dev_err(dev, "ddrc failed freq switch to %lu from %lu: error %d. now at %lu\n",
+			*freq, old_freq, ret, new_freq);
+	else if (*freq != new_freq)
+		dev_err(dev, "ddrc failed freq update to %lu from %lu, now at %lu\n",
+			*freq, old_freq, new_freq);
+	else
+		dev_dbg(dev, "ddrc freq set to %lu (was %lu)\n",
+			*freq, old_freq);
+
+	return ret;
+}
+
+static int imx8m_ddrc_get_cur_freq(struct device *dev, unsigned long *freq)
+{
+	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
+
+	*freq = clk_get_rate(priv->dram_core);
+
+	return 0;
+}
+
+static int imx8m_ddrc_get_dev_status(struct device *dev,
+				     struct devfreq_dev_status *stat)
+{
+	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
+
+	stat->busy_time = 0;
+	stat->total_time = 0;
+	stat->current_frequency = clk_get_rate(priv->dram_core);
+
+	return 0;
+}
+
+static int imx8m_ddrc_init_freq_info(struct device *dev)
+{
+	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
+	struct arm_smccc_res res;
+	int index;
+
+	/* An error here means DDR DVFS API not supported by firmware */
+	arm_smccc_smc(IMX_SIP_DDR_DVFS, IMX_SIP_DDR_DVFS_GET_FREQ_COUNT,
+			0, 0, 0, 0, 0, 0, &res);
+	priv->freq_count = res.a0;
+	if (priv->freq_count <= 0 ||
+			priv->freq_count > IMX8M_DDRC_MAX_FREQ_COUNT)
+		return -ENODEV;
+
+	for (index = 0; index < priv->freq_count; ++index) {
+		struct imx8m_ddrc_freq *freq = &priv->freq_table[index];
+
+		arm_smccc_smc(IMX_SIP_DDR_DVFS, IMX_SIP_DDR_DVFS_GET_FREQ_INFO,
+			      index, 0, 0, 0, 0, 0, &res);
+		/* Result should be strictly positive */
+		if ((long)res.a0 <= 0)
+			return -ENODEV;
+
+		freq->rate = res.a0;
+		freq->smcarg = index;
+		freq->dram_core_parent_index = res.a1;
+		freq->dram_alt_parent_index = res.a2;
+		freq->dram_apb_parent_index = res.a3;
+
+		/* dram_core has 2 options: dram_pll or dram_alt_root */
+		if (freq->dram_core_parent_index != 1 &&
+				freq->dram_core_parent_index != 2)
+			return -ENODEV;
+		/* dram_apb and dram_alt have exactly 8 possible parents */
+		if (freq->dram_alt_parent_index > 8 ||
+				freq->dram_apb_parent_index > 8)
+			return -ENODEV;
+		/* dram_core from alt requires explicit dram_alt parent */
+		if (freq->dram_core_parent_index == 2 &&
+				freq->dram_alt_parent_index == 0)
+			return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int imx8m_ddrc_check_opps(struct device *dev)
+{
+	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
+	struct imx8m_ddrc_freq *freq_info;
+	struct dev_pm_opp *opp;
+	unsigned long freq;
+	int i, opp_count;
+
+	/* Enumerate DT OPPs and disable those not supported by firmware */
+	opp_count = dev_pm_opp_get_opp_count(dev);
+	if (opp_count < 0)
+		return opp_count;
+	for (i = 0, freq = 0; i < opp_count; ++i, ++freq) {
+		opp = dev_pm_opp_find_freq_ceil(dev, &freq);
+		if (IS_ERR(opp)) {
+			dev_err(dev, "Failed enumerating OPPs: %ld\n",
+				PTR_ERR(opp));
+			return PTR_ERR(opp);
+		}
+		dev_pm_opp_put(opp);
+
+		freq_info = imx8m_ddrc_find_freq(priv, freq);
+		if (!freq_info) {
+			dev_info(dev, "Disable unsupported OPP %luHz %luMT/s\n",
+					freq, DIV_ROUND_CLOSEST(freq, 250000));
+			dev_pm_opp_disable(dev, freq);
+		}
+	}
+
+	return 0;
+}
+
+static void imx8m_ddrc_exit(struct device *dev)
+{
+	dev_pm_opp_of_remove_table(dev);
+}
+
+static int imx8m_ddrc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imx8m_ddrc *priv;
+	const char *gov = DEVFREQ_GOV_USERSPACE;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	ret = imx8m_ddrc_init_freq_info(dev);
+	if (ret) {
+		dev_err(dev, "failed to init firmware freq info: %d\n", ret);
+		return ret;
+	}
+
+	priv->dram_core = devm_clk_get(dev, "core");
+	priv->dram_pll = devm_clk_get(dev, "pll");
+	priv->dram_alt = devm_clk_get(dev, "alt");
+	priv->dram_apb = devm_clk_get(dev, "apb");
+	if (IS_ERR(priv->dram_core) ||
+		IS_ERR(priv->dram_pll) ||
+		IS_ERR(priv->dram_alt) ||
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
+	ret = imx8m_ddrc_check_opps(dev);
+	if (ret < 0)
+		goto err;
+
+	priv->profile.polling_ms = 1000;
+	priv->profile.target = imx8m_ddrc_target;
+	priv->profile.get_dev_status = imx8m_ddrc_get_dev_status;
+	priv->profile.exit = imx8m_ddrc_exit;
+	priv->profile.get_cur_freq = imx8m_ddrc_get_cur_freq;
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
+static const struct of_device_id imx8m_ddrc_of_match[] = {
+	{ .compatible = "fsl,imx8m-ddrc", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, imx8m_ddrc_of_match);
+
+static struct platform_driver imx8m_ddrc_platdrv = {
+	.probe		= imx8m_ddrc_probe,
+	.driver = {
+		.name	= "imx8m-ddrc-devfreq",
+		.of_match_table = of_match_ptr(imx8m_ddrc_of_match),
+	},
+};
+module_platform_driver(imx8m_ddrc_platdrv);
+
+MODULE_DESCRIPTION("i.MX8M DDR Controller frequency driver");
+MODULE_AUTHOR("Leonard Crestez <leonard.crestez@nxp.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

