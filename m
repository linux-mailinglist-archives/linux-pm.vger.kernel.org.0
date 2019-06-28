Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 203585952D
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 09:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfF1HkJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 03:40:09 -0400
Received: from inva020.nxp.com ([92.121.34.13]:55032 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbfF1HkJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Jun 2019 03:40:09 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BC54C1A0342;
        Fri, 28 Jun 2019 09:40:04 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B72A71A0DCF;
        Fri, 28 Jun 2019 09:40:04 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id CD5D1205D5;
        Fri, 28 Jun 2019 09:40:03 +0200 (CEST)
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
Subject: [RFCv2 4/8] interconnect: Add generic driver for imx
Date:   Fri, 28 Jun 2019 10:39:52 +0300
Message-Id: <98db5a71d1bcaf486dc1a8f900501d2c9d01380d.1561707104.git.leonard.crestez@nxp.com>
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

From: Alexandre Bailon <abailon@baylibre.com>

This adds support for i.MX SoC to interconnect framework.

This is based on busfreq from NXP vendor tree tree. The implementation
is sufficiently generic to be applies to any imx SOC and perhaps others.

Using the interconnect framework driver requests for bandwidth are used
to determine a global "platform opp" which is then and then scale the
frequency. These "platform opps" are similar to the "low/audio/high"
busfreq levels from NXP tree.

Busfreq platform drivers just have to register interconnect nodes and
OPPs.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Changes by Leonard:
* Make it probe: add xlate and provider->dev
* Clarify commit message
* Use unsigned long for rate

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/interconnect/Kconfig       |   1 +
 drivers/interconnect/Makefile      |   1 +
 drivers/interconnect/imx/Kconfig   |  13 +
 drivers/interconnect/imx/Makefile  |   1 +
 drivers/interconnect/imx/busfreq.c | 628 +++++++++++++++++++++++++++++
 drivers/interconnect/imx/busfreq.h | 123 ++++++
 6 files changed, 767 insertions(+)
 create mode 100644 drivers/interconnect/imx/Kconfig
 create mode 100644 drivers/interconnect/imx/Makefile
 create mode 100644 drivers/interconnect/imx/busfreq.c
 create mode 100644 drivers/interconnect/imx/busfreq.h

diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
index bfa4ca3ab7a9..e61802230f90 100644
--- a/drivers/interconnect/Kconfig
+++ b/drivers/interconnect/Kconfig
@@ -10,7 +10,8 @@ menuconfig INTERCONNECT
 	  If unsure, say no.
 
 if INTERCONNECT
 
 source "drivers/interconnect/qcom/Kconfig"
+source "drivers/interconnect/imx/Kconfig"
 
 endif
diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
index 28f2ab0824d5..20a13b7eb37f 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -2,5 +2,6 @@
 
 icc-core-objs				:= core.o
 
 obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
 obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
+obj-$(CONFIG_INTERCONNECT_IMX)		+= imx/
diff --git a/drivers/interconnect/imx/Kconfig b/drivers/interconnect/imx/Kconfig
new file mode 100644
index 000000000000..afd7b71bbd82
--- /dev/null
+++ b/drivers/interconnect/imx/Kconfig
@@ -0,0 +1,13 @@
+config INTERCONNECT_IMX
+	bool "i.MX interconnect drivers"
+	depends on ARCH_MXC || ARCH_MXC_ARM64 || COMPILE_TEST
+	help
+	  Support for i.MX interconnect hardware.
+
+config BUSFREQ
+	bool "busfreq interconnect driver"
+	depends on INTERCONNECT_IMX
+	help
+	  A generic interconnect driver that could be used for any i.MX.
+	  This provides a way to register master and slave and some opp
+	  to use when one or more master are in use.
diff --git a/drivers/interconnect/imx/Makefile b/drivers/interconnect/imx/Makefile
new file mode 100644
index 000000000000..fea647183815
--- /dev/null
+++ b/drivers/interconnect/imx/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_BUSFREQ) += busfreq.o
diff --git a/drivers/interconnect/imx/busfreq.c b/drivers/interconnect/imx/busfreq.c
new file mode 100644
index 000000000000..19578728e1b3
--- /dev/null
+++ b/drivers/interconnect/imx/busfreq.c
@@ -0,0 +1,628 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Interconnect framework driver for i.MX SoC
+ *
+ * Copyright (c) 2019, BayLibre
+ * Author: Alexandre Bailon <abailon@baylibre.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/suspend.h>
+#include <linux/of.h>
+
+#include "busfreq.h"
+
+/*
+ * struct busfreq_opp_node - Describe the minimum bandwidth required by a node
+ * to enable the opp
+ * @icc_node: icc_node to test
+ * @min_avg_bw: minimum average bandwidth in kbps required to enable opp
+ * @min_peak_bw: minimum peak bandwidth in kbps required to enable opp
+ */
+struct busfreq_opp_node {
+	struct icc_node *icc_node;
+	u32 min_avg_bw;
+	u32 min_peak_bw;
+};
+
+/*
+ * struct busfreq_opp - Describe an opp
+ * This is used to configure multiple clock at once with the respect of
+ * hardware and performance requirements.
+ * @clks_count: number of clocks to configure
+ * @clks: array of clock
+ * @rates: array of rate, to apply for each clock when the opp is enabled
+ * @perf_level: Used to select the opp that would allow the lowest power
+ *              consumption when two or more opp satisfies the performances
+ *              requirements
+ * @node: entry in list of opp
+ * @nodes_count: number of opp node
+ * @nodes: array of opp node, to check node by node if opp satisfies the
+ *         the required performances
+ */
+struct busfreq_opp {
+	int clks_count;
+	struct clk **clks;
+	unsigned long *rates;
+	u32 perf_level;
+
+	struct list_head node;
+
+	int nodes_count;
+	struct busfreq_opp_node *nodes;
+};
+
+/*
+ * struct busfreq_icc_desc - Hold data required to control the interconnects
+ * @dev: device pointer for the overall interconnect
+ * @opps: list of opp
+ * @default_opp: the opp opp to use when the system is in special states
+ *               (boot, suspend, resume, shutdown)
+ * @current_opp: the opp currently in use
+ * @opp_locked: prevent opp to change while this is set
+ * @pm_notifier: used to set the default opp before suspend and
+ *               and select the best one after resume
+ * @pm_notifier: used to set the default opp before to reboot
+ */
+struct busfreq_icc_desc {
+	struct device *dev;
+
+	struct list_head opps;
+	struct busfreq_opp *default_opp;
+	struct busfreq_opp *current_opp;
+	bool opp_locked;
+
+	struct notifier_block pm_notifier;
+	struct notifier_block reboot_notifier;
+
+	struct mutex mutex;
+};
+
+static int busfreq_icc_aggregate(struct icc_node *node, u32 avg_bw,
+				  u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	*agg_avg += avg_bw;
+	*agg_peak = max(*agg_peak, peak_bw);
+
+	return 0;
+}
+
+static struct icc_node* busfreq_icc_xlate(struct of_phandle_args *spec, void *data)
+{
+	struct busfreq_icc_desc *desc = data;
+	struct icc_provider *provider = dev_get_drvdata(desc->dev);
+	unsigned int id = spec->args[0];
+	struct icc_node *node;
+
+	list_for_each_entry (node, &provider->nodes, node_list)
+		if (node->id == id)
+			return node;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static int busfreq_doset_opp(struct busfreq_opp *opp)
+{
+	int i;
+	int ret;
+
+	for (i = 0; i < opp->clks_count; i++) {
+		ret = clk_set_min_rate(opp->clks[i], opp->rates[i]);
+		if (ret)
+			goto err;
+	}
+
+	return 0;
+err:
+	for (; i >= 0; i--)
+		clk_set_min_rate(opp->clks[i], 0);
+
+	return ret;
+}
+
+static void busfreq_unset_opp(struct busfreq_opp *opp)
+{
+	int i;
+
+	for (i = 0; i < opp->clks_count; i++)
+		clk_set_min_rate(opp->clks[i], 0);
+}
+
+static int busfreq_set_opp_no_lock(struct busfreq_icc_desc *desc,
+				   struct busfreq_opp *requested_opp)
+{
+	int ret;
+	int i;
+
+	if (!requested_opp && !desc->default_opp)
+		return -EINVAL;
+
+	if (!requested_opp)
+		requested_opp = desc->default_opp;
+
+	if (desc->current_opp == requested_opp)
+		return 0;
+
+	if (desc->opp_locked)
+		return -EBUSY;
+
+	/*
+	 * Each OPP fetches clks separately and min_rate is aggregated by ccf
+	 * so we need to "unset" the min_rate explicitly afterwards.
+	 */
+	ret = busfreq_doset_opp(requested_opp);
+	if (ret)
+		return ret;
+
+	if (desc->current_opp)
+		busfreq_unset_opp(desc->current_opp);
+	desc->current_opp = requested_opp;
+
+	for (i = 0; i < requested_opp->clks_count; i++) {
+		/* clk must implement determine_rate to deal with min_rate */
+		ret = clk_set_rate(requested_opp->clks[i], 0);
+		if (ret)
+			dev_err(desc->dev, "failed to request min rate\n");
+	}
+
+	/* Read back for debugging: */
+	for (i = 0; i < requested_opp->clks_count; i++) {
+		unsigned long new_rate, round_zero_rate;
+		new_rate = clk_get_rate(requested_opp->clks[i]);
+		round_zero_rate = clk_round_rate(requested_opp->clks[i], 0);
+		dev_dbg(desc->dev, "clk[%d] rate %lu round0 %lu set_min %lu\n",
+				i, new_rate, round_zero_rate,
+				requested_opp->rates[i]);
+	}
+
+	return 0;
+}
+
+static int busfreq_set_opp(struct busfreq_icc_desc *desc,
+			   struct busfreq_opp *requested_opp)
+{
+	int ret;
+
+	mutex_lock(&desc->mutex);
+	ret = busfreq_set_opp_no_lock(desc, requested_opp);
+	mutex_unlock(&desc->mutex);
+
+	return ret;
+}
+
+static int busfreq_opp_bw_gt(struct busfreq_opp_node *opp_node,
+			      u32 avg_bw, u32 peak_bw)
+{
+	if (!opp_node)
+		return 0;
+	if (opp_node->min_avg_bw == BUSFREQ_UNDEFINED_BW) {
+		if (avg_bw)
+			return 2;
+		else
+			return 1;
+	}
+	if (opp_node->min_peak_bw == BUSFREQ_UNDEFINED_BW) {
+		if (peak_bw)
+			return 2;
+		else
+			return 1;
+	}
+	if (avg_bw >= opp_node->min_avg_bw)
+		return 1;
+	if (peak_bw >= opp_node->min_peak_bw)
+		return 1;
+	return 0;
+}
+
+static struct busfreq_opp *busfreq_cmp_bw_opp(struct busfreq_icc_desc *desc,
+					      struct busfreq_opp *opp1,
+					      struct busfreq_opp *opp2)
+{
+	int i;
+	int opp1_valid;
+	int opp2_valid;
+	int opp1_count = 0;
+	int opp2_count = 0;
+
+	if (!opp1 && !opp2)
+		return desc->current_opp;
+
+	if (!opp1)
+		return opp2;
+
+	if (!opp2)
+		return opp1;
+
+	if (opp1 == opp2)
+		return opp1;
+
+	for (i = 0; i < opp1->nodes_count; i++) {
+		struct busfreq_opp_node *opp_node1, *opp_node2;
+		struct icc_node *icc_node;
+		u32 avg_bw;
+		u32 peak_bw;
+
+		opp_node1 = &opp1->nodes[i];
+		opp_node2 = &opp2->nodes[i];
+		icc_node = opp_node1->icc_node;
+		avg_bw = icc_node->avg_bw;
+		peak_bw = icc_node->peak_bw;
+
+		opp1_valid = busfreq_opp_bw_gt(opp_node1, avg_bw, peak_bw);
+		opp2_valid = busfreq_opp_bw_gt(opp_node2, avg_bw, peak_bw);
+
+		if (opp1_valid == opp2_valid && opp1_valid == 1) {
+			if (opp_node1->min_avg_bw > opp_node2->min_avg_bw &&
+				opp_node1->min_avg_bw != BUSFREQ_UNDEFINED_BW)
+				opp1_valid++;
+			if (opp_node1->min_avg_bw < opp_node2->min_avg_bw &&
+				opp_node2->min_avg_bw != BUSFREQ_UNDEFINED_BW)
+				opp2_valid++;
+		}
+
+		opp1_count += opp1_valid;
+		opp2_count += opp2_valid;
+	}
+
+	if (opp1_count > opp2_count)
+		return opp1;
+	if (opp1_count < opp2_count)
+		return opp2;
+	return opp1->perf_level >= opp2->perf_level ? opp2 : opp1;
+}
+
+static int busfreq_set_best_opp(struct busfreq_icc_desc *desc)
+{
+	struct busfreq_opp *opp, *best_opp = desc->current_opp;
+
+	list_for_each_entry(opp, &desc->opps, node)
+		best_opp = busfreq_cmp_bw_opp(desc, opp, best_opp);
+	return busfreq_set_opp(desc, best_opp);
+}
+
+static int busfreq_set_locked_opp(struct busfreq_icc_desc *desc,
+				  struct busfreq_opp *requested_opp)
+{
+	int ret;
+
+	mutex_lock(&desc->mutex);
+	ret = busfreq_set_opp_no_lock(desc, requested_opp);
+	if (ret)
+		goto err;
+	desc->opp_locked = true;
+err:
+	mutex_unlock(&desc->mutex);
+
+	return ret;
+}
+
+static int busfreq_unlock_opp(struct busfreq_icc_desc *desc)
+{
+	mutex_lock(&desc->mutex);
+	desc->opp_locked = false;
+	mutex_unlock(&desc->mutex);
+
+	return busfreq_set_best_opp(desc);
+}
+
+static int busfreq_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	struct busfreq_icc_desc *desc = src->provider->data;
+
+	if (!dst->num_links)
+		return busfreq_set_best_opp(desc);
+
+	return 0;
+}
+
+static int busfreq_pm_notify(struct notifier_block *nb, unsigned long event,
+			     void *ptr)
+{
+	struct busfreq_icc_desc *desc;
+
+	desc = container_of(nb, struct busfreq_icc_desc, pm_notifier);
+	if (event == PM_SUSPEND_PREPARE)
+		busfreq_set_locked_opp(desc, desc->default_opp);
+	else if (event == PM_POST_SUSPEND)
+		busfreq_unlock_opp(desc);
+
+	return NOTIFY_OK;
+}
+
+static int busfreq_reboot_notify(struct notifier_block *nb, unsigned long event,
+				 void *ptr)
+{
+	struct busfreq_icc_desc *desc;
+
+	desc = container_of(nb, struct busfreq_icc_desc, reboot_notifier);
+	busfreq_set_locked_opp(desc, desc->default_opp);
+
+	return NOTIFY_OK;
+}
+
+static struct icc_node *busfreq_icc_node_add(struct icc_provider *provider,
+					     int id, const char *name)
+{
+	struct busfreq_icc_desc *desc = provider->data;
+	struct device *dev = desc->dev;
+	struct icc_node *icc_node;
+
+	icc_node = icc_node_create(id);
+	if (IS_ERR(icc_node)) {
+		dev_err(dev, "Failed to create node %d\n", id);
+		return icc_node;
+	}
+
+	if (icc_node->data)
+		return icc_node;
+
+	icc_node->name = name;
+	icc_node->data = &icc_node;
+	icc_node_add(icc_node, provider);
+
+	return icc_node;
+}
+
+static struct icc_node *busfreq_icc_node_get(struct icc_provider *provider,
+					     int id)
+{
+	return busfreq_icc_node_add(provider, id, NULL);
+}
+
+static void busfreq_unregister_nodes(struct icc_provider *provider)
+{
+	struct icc_node *icc_node, *tmp;
+
+	list_for_each_entry_safe(icc_node, tmp, &provider->nodes, node_list)
+		icc_node_destroy(icc_node->id);
+}
+
+static int busfreq_register_nodes(struct icc_provider *provider,
+				  struct busfreq_icc_node *busfreq_nodes,
+				  int count)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < count; i++) {
+		struct icc_node *icc_node;
+		size_t j;
+
+		icc_node = busfreq_icc_node_add(provider,
+						busfreq_nodes[i].id,
+						busfreq_nodes[i].name);
+		if (IS_ERR(icc_node)) {
+			ret = PTR_ERR(icc_node);
+			goto err;
+		}
+
+		for (j = 0; j < busfreq_nodes[i].num_links; j++)
+			icc_link_create(icc_node, busfreq_nodes[i].links[j]);
+	}
+
+	return 0;
+
+err:
+	busfreq_unregister_nodes(provider);
+
+	return ret;
+}
+
+static struct busfreq_opp *busfreq_opp_alloc(struct icc_provider *provider,
+					     int count)
+{
+	struct busfreq_icc_desc *desc = provider->data;
+	struct device *dev = desc->dev;
+	struct busfreq_opp *opp;
+	struct icc_node *icc_node;
+
+	opp = devm_kzalloc(dev, sizeof(*opp), GFP_KERNEL);
+	if (!opp)
+		return ERR_PTR(-ENOMEM);
+
+	opp->clks_count = count;
+	opp->clks = devm_kzalloc(dev, sizeof(struct clk *) * count, GFP_KERNEL);
+	if (!opp->clks)
+		return ERR_PTR(-ENOMEM);
+
+	opp->rates = devm_kzalloc(dev, sizeof(unsigned long) * count, GFP_KERNEL);
+	if (!opp->rates)
+		return ERR_PTR(-ENOMEM);
+
+	count = 0;
+	list_for_each_entry(icc_node, &provider->nodes, node_list)
+		count++;
+
+	opp->nodes = devm_kzalloc(dev, sizeof(*opp->nodes) * count, GFP_KERNEL);
+	if (!opp->nodes)
+		return ERR_PTR(-ENOMEM);
+	opp->nodes_count = count;
+
+	return opp;
+}
+
+static int busfreq_init_opp(struct icc_provider *provider,
+			    struct busfreq_opp *opp,
+			    struct busfreq_plat_opp *plat_opp)
+{
+	struct busfreq_icc_desc *desc = provider->data;
+	struct device *dev = desc->dev;
+	struct busfreq_opp_node *node;
+	struct icc_node *icc_node;
+	int i, j;
+
+	opp->perf_level = 0;
+	for (i = 0; i < opp->clks_count; i++) {
+		opp->clks[i] = devm_clk_get(dev, plat_opp->clks[i].name);
+		if (IS_ERR(opp->clks[i])) {
+			dev_err(dev, "Failed to get clock %s\n",
+				plat_opp->clks[i].name);
+			return PTR_ERR(opp->clks[i]);
+		}
+		opp->rates[i] = plat_opp->clks[i].rate;
+		opp->perf_level += opp->rates[i] >> 10;
+	}
+
+	i = 0;
+	list_for_each_entry(icc_node, &provider->nodes, node_list) {
+		node = &opp->nodes[i++];
+		node->icc_node = icc_node;
+	}
+
+	for (i = 0; i < plat_opp->nodes_count; i++) {
+		icc_node = busfreq_icc_node_get(provider,
+						plat_opp->nodes[i].id);
+		if (IS_ERR_OR_NULL(icc_node))
+			return -EINVAL;
+
+		for (j = 0, node = &opp->nodes[j]; j < opp->nodes_count;
+			j++, node = &opp->nodes[j]) {
+			if (node->icc_node == icc_node) {
+				node->min_avg_bw = BUSFREQ_UNDEFINED_BW;
+				node->min_peak_bw = BUSFREQ_UNDEFINED_BW;
+			}
+		}
+	}
+
+	INIT_LIST_HEAD(&opp->node);
+
+	return 0;
+}
+
+static int busfreq_register_opps(struct device *dev,
+				 struct icc_provider *provider,
+				 struct busfreq_plat_opp *busfreq_opps,
+				 int count)
+{
+	struct busfreq_icc_desc *desc = provider->data;
+	struct busfreq_opp *opp;
+	int ret;
+	int i;
+
+	for (i = 0; i < count; i++) {
+		opp = busfreq_opp_alloc(provider, busfreq_opps[i].clks_count);
+		if (IS_ERR(opp))
+			return PTR_ERR(opp);
+
+		ret = busfreq_init_opp(provider, opp, &busfreq_opps[i]);
+		if (ret)
+			return ret;
+
+		if (busfreq_opps[i].default_opp)
+			desc->default_opp = opp;
+
+		list_add(&opp->node, &desc->opps);
+	}
+
+	return 0;
+}
+
+static void busfreq_unregister_opps(struct icc_provider *provider)
+{
+	struct busfreq_icc_desc *desc = provider->data;
+	struct device *dev = desc->dev;
+	struct busfreq_opp *opp, *tmp_opp;
+
+	list_for_each_entry_safe(opp, tmp_opp, &desc->opps, node) {
+		list_del(&opp->node);
+		devm_kfree(dev, opp->nodes);
+		devm_kfree(dev, opp->clks);
+		devm_kfree(dev, opp->rates);
+		devm_kfree(dev, opp);
+	}
+}
+
+int busfreq_register(struct platform_device *pdev,
+		     struct busfreq_icc_node *busfreq_nodes, int nodes_count,
+		     struct busfreq_plat_opp *busfreq_opps, int opps_count)
+{
+	struct device *dev = &pdev->dev;
+	struct busfreq_icc_desc *desc;
+	struct icc_provider *provider;
+	int ret;
+
+	desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
+	if (!desc)
+		return -ENOMEM;
+	desc->dev = dev;
+	mutex_init(&desc->mutex);
+	INIT_LIST_HEAD(&desc->opps);
+
+	provider = devm_kzalloc(dev, sizeof(*provider), GFP_KERNEL);
+	if (!provider)
+		return -ENOMEM;
+	provider->set = busfreq_icc_set;
+	provider->aggregate = busfreq_icc_aggregate;
+	provider->xlate = busfreq_icc_xlate;
+	provider->data = desc;
+	provider->dev = dev;
+	platform_set_drvdata(pdev, provider);
+
+	ret = icc_provider_add(provider);
+	if (ret) {
+		dev_err(dev, "error adding interconnect provider\n");
+		return ret;
+	}
+
+	ret = busfreq_register_nodes(provider, busfreq_nodes, nodes_count);
+	if (ret) {
+		dev_err(dev, "error adding interconnect nodes\n");
+		goto provider_del;
+	}
+
+	ret = busfreq_register_opps(dev, provider, busfreq_opps, opps_count);
+	if (ret) {
+		dev_err(dev, "error adding busfreq opp\n");
+		goto unregister_nodes;
+	}
+
+	ret = busfreq_set_opp(desc, desc->default_opp);
+	if (ret)
+		goto unregister_opps;
+
+	desc->pm_notifier.notifier_call = busfreq_pm_notify;
+	register_pm_notifier(&desc->pm_notifier);
+
+	desc->reboot_notifier.notifier_call = busfreq_reboot_notify;
+	register_reboot_notifier(&desc->reboot_notifier);
+
+	return 0;
+
+unregister_opps:
+	busfreq_unregister_opps(provider);
+unregister_nodes:
+	busfreq_unregister_nodes(provider);
+provider_del:
+	icc_provider_del(provider);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(busfreq_register);
+
+int busfreq_unregister(struct platform_device *pdev)
+{
+	struct icc_provider *provider = platform_get_drvdata(pdev);
+	struct busfreq_icc_desc *desc = provider->data;
+	int ret;
+
+	unregister_reboot_notifier(&desc->reboot_notifier);
+	unregister_pm_notifier(&desc->pm_notifier);
+
+	ret = busfreq_set_opp(desc, desc->default_opp);
+	if (ret)
+		return ret;
+
+	icc_provider_del(provider);
+
+	busfreq_unregister_opps(provider);
+	busfreq_unregister_nodes(provider);
+	devm_kfree(&pdev->dev, desc);
+	devm_kfree(&pdev->dev, provider);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(busfreq_unregister);
diff --git a/drivers/interconnect/imx/busfreq.h b/drivers/interconnect/imx/busfreq.h
new file mode 100644
index 000000000000..a60481f10500
--- /dev/null
+++ b/drivers/interconnect/imx/busfreq.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Interconnect framework driver for i.MX SoC
+ *
+ * Copyright (c) 2019, BayLibre
+ * Author: Alexandre Bailon <abailon@baylibre.com>
+ */
+#ifndef __BUSFREQ_H
+#define __BUSFREQ_H
+
+#include <linux/kernel.h>
+
+#define BUSFREQ_MAX_LINKS	32
+#define BUSFREQ_UNDEFINED_BW	0xffffffff
+
+/*
+ * struct busfreq_icc_node - Describe an interconnect node
+ * @name: name of the node
+ * @id: an unique id to identify the node
+ * @links: an array of slaves' node id
+ * @num_links: number of id defined in links
+ */
+struct busfreq_icc_node {
+	char *name;
+	u16 id;
+	u16 links[BUSFREQ_MAX_LINKS];
+	u16 num_links;
+};
+
+/*
+ * struct busfreq_opp_clk - Clock name and rate to set for an opp
+ * @name: name of clock
+ * @rate: the rate to set when the opp is enabled
+ */
+struct busfreq_opp_clk {
+	char *name;
+	unsigned long rate;
+};
+
+/*
+ * struct busfreq_opp_bw - Describe a condition to meet to enable an opp
+ * @id: id of the node to test
+ * @avg_bw: minimum average bandwidth required to enable the opp, or
+ *          ignored if set to BUSFREQ_UNDEFINED_BW
+ * @peak_bw: minimum peak bandwidth required to enable the opp, or
+ *           ignored if set to BUSFREQ_UNDEFINED_BW
+ */
+struct busfreq_opp_bw {
+	u16 id;
+	u32 avg_bw;
+	u32 peak_bw;
+};
+
+/*
+ * struct busfreq_plat_opp - Describe an opp to register in busfreq
+ * @clks: array of clocks to configure when the opp is enable
+ * @clks_count: number of clocks
+ * @nodes: array of opp nodes (condition to meet for each node to enable opp)
+ * @nodes_count: number of nodes
+ * @default_opp: use this opp as default opp if true
+ */
+struct busfreq_plat_opp {
+	struct busfreq_opp_clk *clks;
+	int clks_count;
+	struct busfreq_opp_bw *nodes;
+	int nodes_count;
+	bool default_opp;
+};
+
+#define DEFINE_BUS_INTERCONNECT(_name, _id, _numlinks, ...)	\
+	{							\
+		.id = _id,					\
+		.name = _name,					\
+		.num_links = _numlinks,				\
+		.links = { __VA_ARGS__ },			\
+	}
+
+#define DEFINE_BUS_MASTER(_name, _id, _dest_id)			\
+	DEFINE_BUS_INTERCONNECT(_name, _id, 1, _dest_id)
+
+#define DEFINE_BUS_SLAVE(_name, _id)				\
+	DEFINE_BUS_INTERCONNECT(_name, _id, 0)
+
+#define DEFINE_OPP_CLOCK(_name, _rate)				\
+	{							\
+		.name = _name,					\
+		.rate = _rate,					\
+	}
+
+#define DEFINE_OPP_BW(_id, _avg, _peak)				\
+	{							\
+		.id = _id,					\
+		.avg_bw = _avg,					\
+		.peak_bw = _peak,				\
+	}
+
+#define DEFINE_OPP_NODE(_id)					\
+	DEFINE_OPP_BW(_id, BUSFREQ_UNDEFINED_BW, BUSFREQ_UNDEFINED_BW)
+
+#define DEFINE_OPP(_clks, _nodes, _default)				\
+	{							\
+		.clks = _clks,					\
+		.clks_count = ARRAY_SIZE(_clks),		\
+		.nodes = _nodes,				\
+		.nodes_count = ARRAY_SIZE(_nodes),		\
+		.default_opp = _default,			\
+	}
+
+#define DEFINE_OPP_NO_NODES(_clks, _default)				\
+	{							\
+		.clks = _clks,					\
+		.clks_count = ARRAY_SIZE(_clks),		\
+		.nodes = NULL,					\
+		.nodes_count = 0,				\
+		.default_opp = _default,			\
+	}
+
+int busfreq_register(struct platform_device *pdev,
+		     struct busfreq_icc_node *busfreq_nodes, int nodes_count,
+		     struct busfreq_plat_opp *busfreq_opps, int opps_count);
+int busfreq_unregister(struct platform_device *pdev);
+
+#endif /* __BUSFREQ_H */
-- 
2.17.1

