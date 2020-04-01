Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0228819ADEB
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 16:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733067AbgDAOdV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 10:33:21 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51494 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733059AbgDAOdV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Apr 2020 10:33:21 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6F0BE200DF5;
        Wed,  1 Apr 2020 16:33:18 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 55A00200DEE;
        Wed,  1 Apr 2020 16:33:18 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 45BBD20507;
        Wed,  1 Apr 2020 16:33:17 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
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
        Martin Kepplinger <martink@posteo.de>,
        Silvano di Ninno <silvano.dininno@nxp.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/8] interconnect: Add imx core driver
Date:   Wed,  1 Apr 2020 17:33:03 +0300
Message-Id: <50e6bdb1aab7d8f73cb10d11a4ea1e55056448fc.1585751281.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1585751281.git.leonard.crestez@nxp.com>
References: <cover.1585751281.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1585751281.git.leonard.crestez@nxp.com>
References: <cover.1585751281.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds support for i.MX SoC family to interconnect framework.

Platform drivers can describe the interconnect graph and several
adjustment knobs where icc node bandwidth is converted to a
DEV_PM_QOS_MIN_FREQUENCY request.

The interconnect provider is probed through the main NOC device and
other adjustable nodes on the same graph are found from a
fsl,scalable-nodes phandle array property.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/interconnect/Kconfig      |   1 +
 drivers/interconnect/Makefile     |   1 +
 drivers/interconnect/imx/Kconfig  |   5 +
 drivers/interconnect/imx/Makefile |   3 +
 drivers/interconnect/imx/imx.c    | 298 ++++++++++++++++++++++++++++++
 drivers/interconnect/imx/imx.h    |  62 +++++++
 6 files changed, 370 insertions(+)
 create mode 100644 drivers/interconnect/imx/Kconfig
 create mode 100644 drivers/interconnect/imx/Makefile
 create mode 100644 drivers/interconnect/imx/imx.c
 create mode 100644 drivers/interconnect/imx/imx.h

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
index 725029ae7a2c..6998288a7d98 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -3,5 +3,6 @@
 CFLAGS_core.o				:= -I$(src)
 icc-core-objs				:= core.o
 
 obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
 obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
+obj-$(CONFIG_INTERCONNECT_IMX)		+= imx/
diff --git a/drivers/interconnect/imx/Kconfig b/drivers/interconnect/imx/Kconfig
new file mode 100644
index 000000000000..f39336f8d603
--- /dev/null
+++ b/drivers/interconnect/imx/Kconfig
@@ -0,0 +1,5 @@
+config INTERCONNECT_IMX
+	tristate "i.MX interconnect drivers"
+	depends on ARCH_MXC || COMPILE_TEST
+	help
+	  Generic interconnect drivers for i.MX SOCs
diff --git a/drivers/interconnect/imx/Makefile b/drivers/interconnect/imx/Makefile
new file mode 100644
index 000000000000..86ae0bd28d8c
--- /dev/null
+++ b/drivers/interconnect/imx/Makefile
@@ -0,0 +1,3 @@
+imx-interconnect-objs			:= imx.o
+
+obj-$(CONFIG_INTERCONNECT_IMX)		+= imx-interconnect.o
diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
new file mode 100644
index 000000000000..527b1de1c41a
--- /dev/null
+++ b/drivers/interconnect/imx/imx.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Interconnect framework driver for i.MX SoC
+ *
+ * Copyright (c) 2019, BayLibre
+ * Copyright (c) 2019, NXP
+ * Author: Alexandre Bailon <abailon@baylibre.com>
+ * Author: Leonard Crestez <leonard.crestez@nxp.com>
+ */
+
+#include <linux/device.h>
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_qos.h>
+
+#include "imx.h"
+
+/* private icc_node data */
+struct imx_icc_node {
+	const struct imx_icc_node_desc *desc;
+	struct device *qos_dev;
+	struct dev_pm_qos_request qos_req;
+};
+
+static int imx_icc_aggregate(struct icc_node *node, u32 tag,
+			     u32 avg_bw, u32 peak_bw,
+			     u32 *agg_avg, u32 *agg_peak)
+{
+	*agg_avg += avg_bw;
+	*agg_peak = max(*agg_peak, peak_bw);
+
+	return 0;
+}
+
+static int imx_icc_node_set(struct icc_node *node)
+{
+	struct device *dev = node->provider->dev;
+	struct imx_icc_node *node_data = node->data;
+	u64 freq;
+
+	if (!node_data->qos_dev)
+		return 0;
+
+	freq = (node->avg_bw + node->peak_bw) * node_data->desc->adj->bw_mul;
+	do_div(freq, node_data->desc->adj->bw_div);
+	dev_dbg(dev, "node %s device %s avg_bw %ukBps peak_bw %ukBps min_freq %llukHz\n",
+		node->name, dev_name(node_data->qos_dev),
+		node->avg_bw, node->peak_bw, freq);
+
+	if (freq > S32_MAX) {
+		dev_err(dev, "%s can't request more than S32_MAX freq\n",
+				node->name);
+		return -ERANGE;
+	}
+
+	dev_pm_qos_update_request(&node_data->qos_req, freq);
+
+	return 0;
+}
+
+static int imx_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	return imx_icc_node_set(dst);
+}
+
+/* imx_icc_node_destroy() - Destroy an imx icc_node, including private data */
+static void imx_icc_node_destroy(struct icc_node *node)
+{
+	struct imx_icc_node *node_data = node->data;
+	int ret;
+
+	if (dev_pm_qos_request_active(&node_data->qos_req)) {
+		ret = dev_pm_qos_remove_request(&node_data->qos_req);
+		if (ret)
+			dev_warn(node->provider->dev, "failed to remove qos request for %s\n",
+				 dev_name(node_data->qos_dev));
+	}
+
+	put_device(node_data->qos_dev);
+	icc_node_del(node);
+	icc_node_destroy(node->id);
+}
+
+static int imx_icc_node_init_qos(struct icc_provider *provider,
+				 struct icc_node *node)
+{
+	struct imx_icc_node *node_data = node->data;
+	const struct imx_icc_node_adj_desc *adj = node_data->desc->adj;
+	struct device *dev = provider->dev;
+	struct device_node *dn = NULL;
+	struct platform_device *pdev;
+
+	if (adj->main_noc) {
+		node_data->qos_dev = dev;
+		dev_info(dev, "icc node %s[%d] is main noc itself\n",
+			 node->name, node->id);
+	} else {
+		dn = of_parse_phandle(dev->of_node, adj->phandle_name, 0);
+		if (IS_ERR(dn)) {
+			dev_warn(dev, "Failed to parse %s: %ld\n",
+					adj->phandle_name, PTR_ERR(dn));
+			return PTR_ERR(dn);
+		}
+		/* Allow scaling to be disabled on a per-node basis */
+		if (!dn || !of_device_is_available(dn)) {
+			dev_warn(dev, "Missing property %s, skip scaling %s\n",
+					adj->phandle_name, node->name);
+			return 0;
+		}
+
+		pdev = of_find_device_by_node(dn);
+		of_node_put(dn);
+		if (!pdev) {
+			dev_warn(dev, "node %s[%d] missing device for %pOF\n",
+					node->name, node->id, dn);
+			return -EPROBE_DEFER;
+		}
+		node_data->qos_dev = &pdev->dev;
+		dev_info(dev, "node %s[%d] has device node %pOF\n",
+			 node->name, node->id, dn);
+	}
+
+	return dev_pm_qos_add_request(node_data->qos_dev,
+				      &node_data->qos_req,
+				      DEV_PM_QOS_MIN_FREQUENCY, 0);
+}
+
+static struct icc_node *imx_icc_node_add(struct icc_provider *provider,
+					 const struct imx_icc_node_desc *node_desc)
+{
+	struct device *dev = provider->dev;
+	struct imx_icc_node *node_data;
+	struct icc_node *node;
+	int ret;
+
+	node = icc_node_create(node_desc->id);
+	if (IS_ERR(node)) {
+		dev_err(dev, "failed to create node %d\n", node_desc->id);
+		return node;
+	}
+
+	if (node->data) {
+		dev_err(dev, "already created node %s id=%d\n",
+				node_desc->name, node_desc->id);
+		return ERR_PTR(-EEXIST);
+	}
+
+	node_data = devm_kzalloc(dev, sizeof(*node_data), GFP_KERNEL);
+	if (!node_data) {
+		icc_node_destroy(node->id);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	node->name = node_desc->name;
+	node->data = node_data;
+	node_data->desc = node_desc;
+	icc_node_add(node, provider);
+
+	if (node_desc->adj) {
+		ret = imx_icc_node_init_qos(provider, node);
+		if (ret < 0) {
+			imx_icc_node_destroy(node);
+			return ERR_PTR(ret);
+		}
+	}
+
+	return node;
+}
+
+static void imx_icc_unregister_nodes(struct icc_provider *provider)
+{
+	struct icc_node *node, *tmp;
+
+	list_for_each_entry_safe(node, tmp, &provider->nodes, node_list)
+		imx_icc_node_destroy(node);
+}
+
+static int imx_icc_register_nodes(struct icc_provider *provider,
+				  const struct imx_icc_node_desc *descs,
+				  int count)
+{
+	struct icc_onecell_data *provider_data = provider->data;
+	int ret;
+	int i;
+
+	for (i = 0; i < count; i++) {
+		struct icc_node *node;
+		const struct imx_icc_node_desc *node_desc = &descs[i];
+		size_t j;
+
+		node = imx_icc_node_add(provider, node_desc);
+		if (IS_ERR(node)) {
+			ret = PTR_ERR(node);
+			if (ret != -EPROBE_DEFER)
+				dev_err(provider->dev, "failed to add %s: %d\n",
+					node_desc->name, ret);
+			goto err;
+		}
+		provider_data->nodes[node->id] = node;
+
+		for (j = 0; j < node_desc->num_links; j++) {
+			ret = icc_link_create(node, node_desc->links[j]);
+			if (ret) {
+				dev_err(provider->dev, "failed to link node %d to %d: %d\n",
+					node->id, node_desc->links[j], ret);
+				goto err;
+			}
+		}
+	}
+
+	return 0;
+
+err:
+	imx_icc_unregister_nodes(provider);
+
+	return ret;
+}
+
+static int get_max_node_id(struct imx_icc_node_desc *nodes, int nodes_count)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < nodes_count; ++i)
+		if (nodes[i].id > ret)
+			ret = nodes[i].id;
+
+	return ret;
+}
+
+int imx_icc_register(struct platform_device *pdev,
+		     struct imx_icc_node_desc *nodes, int nodes_count)
+{
+	struct device *dev = &pdev->dev;
+	struct icc_onecell_data *data;
+	struct icc_provider *provider;
+	int max_node_id;
+	int ret;
+
+	/* icc_onecell_data is indexed by node_id, unlike nodes param */
+	max_node_id = get_max_node_id(nodes, nodes_count);
+	data = devm_kzalloc(dev, struct_size(data, nodes, max_node_id),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	data->num_nodes = max_node_id;
+
+	provider = devm_kzalloc(dev, sizeof(*provider), GFP_KERNEL);
+	if (!provider)
+		return -ENOMEM;
+	provider->set = imx_icc_set;
+	provider->aggregate = imx_icc_aggregate;
+	provider->xlate = of_icc_xlate_onecell;
+	provider->data = data;
+	provider->dev = dev->parent;
+	platform_set_drvdata(pdev, provider);
+
+	ret = icc_provider_add(provider);
+	if (ret) {
+		dev_err(dev, "error adding interconnect provider: %d\n", ret);
+		return ret;
+	}
+
+	ret = imx_icc_register_nodes(provider, nodes, nodes_count);
+	if (ret)
+		goto provider_del;
+
+	return 0;
+
+provider_del:
+	icc_provider_del(provider);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(imx_icc_register);
+
+int imx_icc_unregister(struct platform_device *pdev)
+{
+	struct icc_provider *provider = platform_get_drvdata(pdev);
+	int ret;
+
+	if (provider->users) {
+		dev_warn(&pdev->dev, "interconnect provider still has %d users\n",
+			provider->users);
+		return -EBUSY;
+	}
+	imx_icc_unregister_nodes(provider);
+
+	ret = icc_provider_del(provider);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(imx_icc_unregister);
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/interconnect/imx/imx.h b/drivers/interconnect/imx/imx.h
new file mode 100644
index 000000000000..aa811e4ebb7e
--- /dev/null
+++ b/drivers/interconnect/imx/imx.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Interconnect framework driver for i.MX SoC
+ *
+ * Copyright (c) 2019, BayLibre
+ * Copyright (c) 2019, NXP
+ * Author: Alexandre Bailon <abailon@baylibre.com>
+ * Author: Leonard Crestez <leonard.crestez@nxp.com>
+ */
+#ifndef __DRIVERS_INTERCONNECT_IMX_H
+#define __DRIVERS_INTERCONNECT_IMX_H
+
+#include <linux/kernel.h>
+
+#define IMX_ICC_MAX_LINKS	4
+
+/*
+ * struct imx_icc_node_adj - Describe a dynamic adjustable node
+ */
+struct imx_icc_node_adj_desc {
+	unsigned int bw_mul, bw_div;
+	const char *phandle_name;
+	bool main_noc;
+};
+
+/*
+ * struct imx_icc_node - Describe an interconnect node
+ * @name: name of the node
+ * @id: an unique id to identify the node
+ * @links: an array of slaves' node id
+ * @num_links: number of id defined in links
+ */
+struct imx_icc_node_desc {
+	const char *name;
+	u16 id;
+	u16 links[IMX_ICC_MAX_LINKS];
+	u16 num_links;
+
+	const struct imx_icc_node_adj_desc *adj;
+};
+
+#define DEFINE_BUS_INTERCONNECT(_name, _id, _adj, ...)			\
+	{								\
+		.id = _id,						\
+		.name = _name,						\
+		.adj = _adj,						\
+		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
+		.links = { __VA_ARGS__ },				\
+	}
+
+#define DEFINE_BUS_MASTER(_name, _id, _dest_id)				\
+	DEFINE_BUS_INTERCONNECT(_name, _id, NULL, _dest_id)
+
+#define DEFINE_BUS_SLAVE(_name, _id, _adj)				\
+	DEFINE_BUS_INTERCONNECT(_name, _id, _adj)
+
+int imx_icc_register(struct platform_device *pdev,
+		     struct imx_icc_node_desc *nodes,
+		     int nodes_count);
+int imx_icc_unregister(struct platform_device *pdev);
+
+#endif /* __DRIVERS_INTERCONNECT_IMX_H */
-- 
2.17.1

