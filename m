Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0AF27E37B
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 10:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgI3IRP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 04:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbgI3IRP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2020 04:17:15 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A31BC0613D1
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 01:17:14 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id y14so618571pgf.12
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 01:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dWlDoelKixsxfMtKwE9GpG65I0GdQ74NEFpox/PzM00=;
        b=AdUGx4UjCkME3kFcUK/I6NZV0NMrIFNL9M9VLy0ef/F5isSAgLaIFvLwH0w5igD3v7
         uh15ZTQQAdFkZMJ3CjMYzcp6pMosI1IiIW+lD0aIWAn5YJsrrJDSRO8JW+2h2pTkGU5R
         iuxmvwu1quYQbDN5Ngl3FBDOb0Onjy9y+5iLnz2/L+Kub3x6leSCB1h4sjzD3YoIWHtw
         kSg6hPk0tEZyv6H+ccAWGAzi1u+4GWeB+OhnDwp2+yFsBiXK3HRJL+sGr4fYALrg9fQZ
         igJsv/wg3MeeUTbr6RwLQN5/OKROwJxrzyZzASTNYpsKV+AM6aK268KiB64hpOc3Zefg
         nTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dWlDoelKixsxfMtKwE9GpG65I0GdQ74NEFpox/PzM00=;
        b=aFEVIguQOsuktYuwnXV8GaH2n6WIT/073PrK1fLHJDcziAcF+lzlctsiZFDMPQbSdx
         OcbZLed2QL3qTDSSBonUDcmJRRd8jMn6ie+j/uQhPFomri5y1emS2W1q7CwNw87EWLXT
         hT6eVSkwng7JsvsVwOoKtgVc6FsR6Lb3tDwoyDECdicRtzLB87eWDqe2dgTON83E9m2U
         7SeotEL/gAN8GmvUyVUGR+0lANocPG4pq59FVWbaPVUmjj505DlSyGHjuY0e3/jaWK3S
         SBCAdt8RBmB0hDth4pwitOSTefT4eZFBRHVSK8o5ITI9pw2Nw9g+hoFmhGDAdoSXfy1h
         ZfFQ==
X-Gm-Message-State: AOAM531FYUG/+pBOYmeGMoX2lLRIy92XMDzEO/VdfVSrVI+/q50j6Yi9
        9E1jZnkBWL0lCZKSFXBC7nm0ZSRfmJm8Qcxq
X-Google-Smtp-Source: ABdhPJxnhG4IKXcNeZbzfpAylrrTJH7JpAe6eZCCnsUN/I//p7deL9NZYQgWtm4dCuyMoNF345340w==
X-Received: by 2002:aa7:9a0e:0:b029:142:2501:35e5 with SMTP id w14-20020aa79a0e0000b0290142250135e5mr1591535pfj.69.1601453833692;
        Wed, 30 Sep 2020 01:17:13 -0700 (PDT)
Received: from localhost.localdomain (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id q15sm1385345pje.29.2020.09.30.01.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 01:17:13 -0700 (PDT)
From:   Jun Nie <jun.nie@linaro.org>
To:     devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org
Cc:     shawn.guo@linaro.org, Jun Nie <jun.nie@linaro.org>
Subject: [PATCH 1/5] interconnect: qcom: Consolidate interconnect RPM support
Date:   Wed, 30 Sep 2020 16:16:41 +0800
Message-Id: <20200930081645.3434-2-jun.nie@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930081645.3434-1-jun.nie@linaro.org>
References: <20200930081645.3434-1-jun.nie@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add RPM based interconnect driver implements the set and aggregate
functionalities that translates bandwidth requests into RPM messages.
These modules provide a common set of functionalities for all
Qualcomm RPM based interconnect providers and should help reduce code
duplication when adding new providers.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/interconnect/qcom/Makefile  |   3 +-
 drivers/interconnect/qcom/icc-rpm.c | 194 ++++++++++++++++++++++
 drivers/interconnect/qcom/icc-rpm.h |  73 +++++++++
 drivers/interconnect/qcom/msm8916.c | 241 ++--------------------------
 4 files changed, 279 insertions(+), 232 deletions(-)
 create mode 100644 drivers/interconnect/qcom/icc-rpm.c
 create mode 100644 drivers/interconnect/qcom/icc-rpm.h

diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index 1702ece67dc5..f5e803489de0 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -9,7 +9,7 @@ icc-rpmh-obj				:= icc-rpmh.o
 qnoc-sc7180-objs			:= sc7180.o
 qnoc-sdm845-objs			:= sdm845.o
 qnoc-sm8150-objs			:= sm8150.o
-icc-smd-rpm-objs			:= smd-rpm.o
+icc-smd-rpm-objs			:= smd-rpm.o icc-rpm.o
 
 obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) += icc-bcm-voter.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) += qnoc-msm8916.o
@@ -21,3 +21,4 @@ obj-$(CONFIG_INTERCONNECT_QCOM_SC7180) += qnoc-sc7180.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8150) += qnoc-sm8150.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o
+obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o
diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
new file mode 100644
index 000000000000..4ddcb6cd4b84
--- /dev/null
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Linaro Ltd
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/interconnect-provider.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "smd-rpm.h"
+#include "icc-rpm.h"
+
+static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	struct qcom_icc_provider *qp;
+	struct qcom_icc_node *qn;
+	struct icc_provider *provider;
+	struct icc_node *n;
+	u64 sum_bw;
+	u64 max_peak_bw;
+	u64 rate;
+	u32 agg_avg = 0;
+	u32 agg_peak = 0;
+	int ret, i;
+
+	qn = src->data;
+	provider = src->provider;
+	qp = to_qcom_provider(provider);
+
+	list_for_each_entry(n, &provider->nodes, node_list)
+		provider->aggregate(n, 0, n->avg_bw, n->peak_bw,
+				    &agg_avg, &agg_peak);
+
+	sum_bw = icc_units_to_bps(agg_avg);
+	max_peak_bw = icc_units_to_bps(agg_peak);
+
+	/* send bandwidth request message to the RPM processor */
+	if (qn->mas_rpm_id != -1) {
+		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
+					    RPM_BUS_MASTER_REQ,
+					    qn->mas_rpm_id,
+					    sum_bw);
+		if (ret) {
+			pr_err("qcom_icc_rpm_smd_send mas %d error %d\n",
+			       qn->mas_rpm_id, ret);
+			return ret;
+		}
+	}
+
+	if (qn->slv_rpm_id != -1) {
+		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
+					    RPM_BUS_SLAVE_REQ,
+					    qn->slv_rpm_id,
+					    sum_bw);
+		if (ret) {
+			pr_err("qcom_icc_rpm_smd_send slv error %d\n",
+			       ret);
+			return ret;
+		}
+	}
+
+	rate = max(sum_bw, max_peak_bw);
+
+	do_div(rate, qn->buswidth);
+
+	if (qn->rate == rate)
+		return 0;
+
+	for (i = 0; i < qp->num_clks; i++) {
+		ret = clk_set_rate(qp->bus_clks[i].clk, rate);
+		if (ret) {
+			pr_err("%s clk_set_rate error: %d\n",
+			       qp->bus_clks[i].id, ret);
+			return ret;
+		}
+	}
+
+	qn->rate = rate;
+
+	return 0;
+}
+
+int qnoc_probe(struct platform_device *pdev, size_t cd_size, int cd_num,
+	       const struct clk_bulk_data *cd)
+{
+	struct device *dev = &pdev->dev;
+	const struct qcom_icc_desc *desc;
+	struct icc_onecell_data *data;
+	struct icc_provider *provider;
+	struct qcom_icc_node **qnodes;
+	struct qcom_icc_provider *qp;
+	struct icc_node *node;
+	size_t num_nodes, i;
+	int ret;
+
+	/* wait for the RPM proxy */
+	if (!qcom_icc_rpm_smd_available())
+		return -EPROBE_DEFER;
+
+	desc = of_device_get_match_data(dev);
+	if (!desc)
+		return -EINVAL;
+
+	qnodes = desc->nodes;
+	num_nodes = desc->num_nodes;
+
+	qp = devm_kzalloc(dev, sizeof(*qp), GFP_KERNEL);
+	if (!qp)
+		return -ENOMEM;
+
+	data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	qp->bus_clks = devm_kmemdup(dev, cd, cd_size,
+				    GFP_KERNEL);
+	if (!qp->bus_clks)
+		return -ENOMEM;
+
+	qp->num_clks = cd_num;
+	ret = devm_clk_bulk_get(dev, qp->num_clks, qp->bus_clks);
+	if (ret)
+		return ret;
+
+	ret = clk_bulk_prepare_enable(qp->num_clks, qp->bus_clks);
+	if (ret)
+		return ret;
+
+	provider = &qp->provider;
+	INIT_LIST_HEAD(&provider->nodes);
+	provider->dev = dev;
+	provider->set = qcom_icc_set;
+	provider->aggregate = icc_std_aggregate;
+	provider->xlate = of_icc_xlate_onecell;
+	provider->data = data;
+
+	ret = icc_provider_add(provider);
+	if (ret) {
+		dev_err(dev, "error adding interconnect provider: %d\n", ret);
+		clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+		return ret;
+	}
+
+	for (i = 0; i < num_nodes; i++) {
+		size_t j;
+
+		node = icc_node_create(qnodes[i]->id);
+		if (IS_ERR(node)) {
+			ret = PTR_ERR(node);
+			goto err;
+		}
+
+		node->name = qnodes[i]->name;
+		node->data = qnodes[i];
+		icc_node_add(node, provider);
+
+		dev_dbg(dev, "registered node %s\n", node->name);
+
+		/* populate links */
+		for (j = 0; j < qnodes[i]->num_links; j++)
+			icc_link_create(node, qnodes[i]->links[j]);
+
+		data->nodes[i] = node;
+	}
+	data->num_nodes = num_nodes;
+
+	platform_set_drvdata(pdev, qp);
+
+	return 0;
+err:
+	icc_nodes_remove(provider);
+	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+	icc_provider_del(provider);
+
+	return ret;
+}
+EXPORT_SYMBOL(qnoc_probe);
+
+int qnoc_remove(struct platform_device *pdev)
+{
+	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
+
+	icc_nodes_remove(&qp->provider);
+	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+	return icc_provider_del(&qp->provider);
+}
+EXPORT_SYMBOL(qnoc_remove);
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
new file mode 100644
index 000000000000..b75bb59d79b7
--- /dev/null
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Linaro Ltd
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_SMD_RPM_COMMON_H
+#define __DRIVERS_INTERCONNECT_QCOM_SMD_RPM_COMMON_H
+
+#define RPM_BUS_MASTER_REQ	0x73616d62
+#define RPM_BUS_SLAVE_REQ	0x766c7362
+
+#define QCOM_MAX_LINKS 12
+
+#define to_qcom_provider(_provider) \
+	container_of(_provider, struct qcom_icc_provider, provider)
+
+/**
+ * struct qcom_icc_provider - Qualcomm specific interconnect provider
+ * @provider: generic interconnect provider
+ * @bus_clks: the clk_bulk_data table of bus clocks
+ * @num_clks: the total number of clk_bulk_data entries
+ */
+struct qcom_icc_provider {
+	struct icc_provider provider;
+	struct clk_bulk_data *bus_clks;
+	int num_clks;
+};
+
+/**
+ * struct qcom_icc_node - Qualcomm specific interconnect nodes
+ * @name: the node name used in debugfs
+ * @id: a unique node identifier
+ * @links: an array of nodes where we can go next while traversing
+ * @num_links: the total number of @links
+ * @buswidth: width of the interconnect between a node and the bus (bytes)
+ * @mas_rpm_id:	RPM id for devices that are bus masters
+ * @slv_rpm_id:	RPM id for devices that are bus slaves
+ * @rate: current bus clock rate in Hz
+ */
+struct qcom_icc_node {
+	unsigned char *name;
+	u16 id;
+	u16 links[QCOM_MAX_LINKS];
+	u16 num_links;
+	u16 buswidth;
+	int mas_rpm_id;
+	int slv_rpm_id;
+	u64 rate;
+};
+
+struct qcom_icc_desc {
+	struct qcom_icc_node **nodes;
+	size_t num_nodes;
+};
+
+#define DEFINE_QNODE(_name, _id, _buswidth, _mas_rpm_id, _slv_rpm_id,	\
+		     ...)						\
+		static struct qcom_icc_node _name = {			\
+		.name = #_name,						\
+		.id = _id,						\
+		.buswidth = _buswidth,					\
+		.mas_rpm_id = _mas_rpm_id,				\
+		.slv_rpm_id = _slv_rpm_id,				\
+		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
+		.links = { __VA_ARGS__ },				\
+	}
+
+
+int qnoc_probe(struct platform_device *pdev, size_t cd_size, int cd_num,
+	       const struct clk_bulk_data *cd);
+int qnoc_remove(struct platform_device *pdev);
+
+#endif
diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
index 42c6c5581662..c4985c5774eb 100644
--- a/drivers/interconnect/qcom/msm8916.c
+++ b/drivers/interconnect/qcom/msm8916.c
@@ -15,9 +15,7 @@
 #include <dt-bindings/interconnect/qcom,msm8916.h>
 
 #include "smd-rpm.h"
-
-#define RPM_BUS_MASTER_REQ      0x73616d62
-#define RPM_BUS_SLAVE_REQ       0x766c7362
+#include "icc-rpm.h"
 
 enum {
 	MSM8916_BIMC_SNOC_MAS = 1,
@@ -107,67 +105,11 @@ enum {
 	MSM8916_SNOC_PNOC_SLV,
 };
 
-#define to_msm8916_provider(_provider) \
-	container_of(_provider, struct msm8916_icc_provider, provider)
-
 static const struct clk_bulk_data msm8916_bus_clocks[] = {
 	{ .id = "bus" },
 	{ .id = "bus_a" },
 };
 
-/**
- * struct msm8916_icc_provider - Qualcomm specific interconnect provider
- * @provider: generic interconnect provider
- * @bus_clks: the clk_bulk_data table of bus clocks
- * @num_clks: the total number of clk_bulk_data entries
- */
-struct msm8916_icc_provider {
-	struct icc_provider provider;
-	struct clk_bulk_data *bus_clks;
-	int num_clks;
-};
-
-#define MSM8916_MAX_LINKS	8
-
-/**
- * struct msm8916_icc_node - Qualcomm specific interconnect nodes
- * @name: the node name used in debugfs
- * @id: a unique node identifier
- * @links: an array of nodes where we can go next while traversing
- * @num_links: the total number of @links
- * @buswidth: width of the interconnect between a node and the bus (bytes)
- * @mas_rpm_id:	RPM ID for devices that are bus masters
- * @slv_rpm_id:	RPM ID for devices that are bus slaves
- * @rate: current bus clock rate in Hz
- */
-struct msm8916_icc_node {
-	unsigned char *name;
-	u16 id;
-	u16 links[MSM8916_MAX_LINKS];
-	u16 num_links;
-	u16 buswidth;
-	int mas_rpm_id;
-	int slv_rpm_id;
-	u64 rate;
-};
-
-struct msm8916_icc_desc {
-	struct msm8916_icc_node **nodes;
-	size_t num_nodes;
-};
-
-#define DEFINE_QNODE(_name, _id, _buswidth, _mas_rpm_id, _slv_rpm_id,	\
-					...)				\
-		static struct msm8916_icc_node _name = {		\
-		.name = #_name,						\
-		.id = _id,						\
-		.buswidth = _buswidth,					\
-		.mas_rpm_id = _mas_rpm_id,				\
-		.slv_rpm_id = _slv_rpm_id,				\
-		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
-		.links = { __VA_ARGS__ },				\
-	}
-
 DEFINE_QNODE(bimc_snoc_mas, MSM8916_BIMC_SNOC_MAS, 8, -1, -1, MSM8916_BIMC_SNOC_SLV);
 DEFINE_QNODE(bimc_snoc_slv, MSM8916_BIMC_SNOC_SLV, 8, -1, -1, MSM8916_SNOC_INT_0, MSM8916_SNOC_INT_1);
 DEFINE_QNODE(mas_apss, MSM8916_MASTER_AMPSS_M0, 8, -1, -1, MSM8916_SLAVE_EBI_CH0, MSM8916_BIMC_SNOC_MAS, MSM8916_SLAVE_AMPSS_L2);
@@ -254,7 +196,7 @@ DEFINE_QNODE(snoc_int_bimc, MSM8916_SNOC_INT_BIMC, 8, 101, 132, MSM8916_SNOC_BIM
 DEFINE_QNODE(snoc_pcnoc_mas, MSM8916_SNOC_PNOC_MAS, 8, -1, -1, MSM8916_SNOC_PNOC_SLV);
 DEFINE_QNODE(snoc_pcnoc_slv, MSM8916_SNOC_PNOC_SLV, 8, -1, -1, MSM8916_PNOC_INT_0);
 
-static struct msm8916_icc_node *msm8916_snoc_nodes[] = {
+static struct qcom_icc_node *msm8916_snoc_nodes[] = {
 	[BIMC_SNOC_SLV] = &bimc_snoc_slv,
 	[MASTER_JPEG] = &mas_jpeg,
 	[MASTER_MDP_PORT0] = &mas_mdp,
@@ -283,12 +225,12 @@ static struct msm8916_icc_node *msm8916_snoc_nodes[] = {
 	[SNOC_QDSS_INT] = &qdss_int,
 };
 
-static struct msm8916_icc_desc msm8916_snoc = {
+static struct qcom_icc_desc msm8916_snoc = {
 	.nodes = msm8916_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8916_snoc_nodes),
 };
 
-static struct msm8916_icc_node *msm8916_bimc_nodes[] = {
+static struct qcom_icc_node *msm8916_bimc_nodes[] = {
 	[BIMC_SNOC_MAS] = &bimc_snoc_mas,
 	[MASTER_AMPSS_M0] = &mas_apss,
 	[MASTER_GRAPHICS_3D] = &mas_gfx,
@@ -300,12 +242,12 @@ static struct msm8916_icc_node *msm8916_bimc_nodes[] = {
 	[SNOC_BIMC_1_SLV] = &snoc_bimc_1_slv,
 };
 
-static struct msm8916_icc_desc msm8916_bimc = {
+static struct qcom_icc_desc msm8916_bimc = {
 	.nodes = msm8916_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8916_bimc_nodes),
 };
 
-static struct msm8916_icc_node *msm8916_pcnoc_nodes[] = {
+static struct qcom_icc_node *msm8916_pcnoc_nodes[] = {
 	[MASTER_BLSP_1] = &mas_blsp_1,
 	[MASTER_DEHR] = &mas_dehr,
 	[MASTER_LPASS] = &mas_audio,
@@ -358,178 +300,15 @@ static struct msm8916_icc_node *msm8916_pcnoc_nodes[] = {
 	[SNOC_PCNOC_SLV] = &snoc_pcnoc_slv,
 };
 
-static struct msm8916_icc_desc msm8916_pcnoc = {
+static struct qcom_icc_desc msm8916_pcnoc = {
 	.nodes = msm8916_pcnoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8916_pcnoc_nodes),
 };
 
-static int msm8916_icc_set(struct icc_node *src, struct icc_node *dst)
-{
-	struct msm8916_icc_provider *qp;
-	struct msm8916_icc_node *qn;
-	u64 sum_bw, max_peak_bw, rate;
-	u32 agg_avg = 0, agg_peak = 0;
-	struct icc_provider *provider;
-	struct icc_node *n;
-	int ret, i;
-
-	qn = src->data;
-	provider = src->provider;
-	qp = to_msm8916_provider(provider);
-
-	list_for_each_entry(n, &provider->nodes, node_list)
-		provider->aggregate(n, 0, n->avg_bw, n->peak_bw,
-				    &agg_avg, &agg_peak);
-
-	sum_bw = icc_units_to_bps(agg_avg);
-	max_peak_bw = icc_units_to_bps(agg_peak);
-
-	/* send bandwidth request message to the RPM processor */
-	if (qn->mas_rpm_id != -1) {
-		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
-					    RPM_BUS_MASTER_REQ,
-					    qn->mas_rpm_id,
-					    sum_bw);
-		if (ret) {
-			pr_err("qcom_icc_rpm_smd_send mas %d error %d\n",
-			       qn->mas_rpm_id, ret);
-			return ret;
-		}
-	}
-
-	if (qn->slv_rpm_id != -1) {
-		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
-					    RPM_BUS_SLAVE_REQ,
-					    qn->slv_rpm_id,
-					    sum_bw);
-		if (ret) {
-			pr_err("qcom_icc_rpm_smd_send slv error %d\n",
-			       ret);
-			return ret;
-		}
-	}
-
-	rate = max(sum_bw, max_peak_bw);
-
-	do_div(rate, qn->buswidth);
-
-	if (qn->rate == rate)
-		return 0;
-
-	for (i = 0; i < qp->num_clks; i++) {
-		ret = clk_set_rate(qp->bus_clks[i].clk, rate);
-		if (ret) {
-			pr_err("%s clk_set_rate error: %d\n",
-			       qp->bus_clks[i].id, ret);
-			return ret;
-		}
-	}
-
-	qn->rate = rate;
-
-	return 0;
-}
-
 static int msm8916_qnoc_probe(struct platform_device *pdev)
 {
-	const struct msm8916_icc_desc *desc;
-	struct msm8916_icc_node **qnodes;
-	struct msm8916_icc_provider *qp;
-	struct device *dev = &pdev->dev;
-	struct icc_onecell_data *data;
-	struct icc_provider *provider;
-	struct icc_node *node;
-	size_t num_nodes, i;
-	int ret;
-
-	/* wait for the RPM proxy */
-	if (!qcom_icc_rpm_smd_available())
-		return -EPROBE_DEFER;
-
-	desc = of_device_get_match_data(dev);
-	if (!desc)
-		return -EINVAL;
-
-	qnodes = desc->nodes;
-	num_nodes = desc->num_nodes;
-
-	qp = devm_kzalloc(dev, sizeof(*qp), GFP_KERNEL);
-	if (!qp)
-		return -ENOMEM;
-
-	data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes),
-			    GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	qp->bus_clks = devm_kmemdup(dev, msm8916_bus_clocks,
-				    sizeof(msm8916_bus_clocks), GFP_KERNEL);
-	if (!qp->bus_clks)
-		return -ENOMEM;
-
-	qp->num_clks = ARRAY_SIZE(msm8916_bus_clocks);
-	ret = devm_clk_bulk_get(dev, qp->num_clks, qp->bus_clks);
-	if (ret)
-		return ret;
-
-	ret = clk_bulk_prepare_enable(qp->num_clks, qp->bus_clks);
-	if (ret)
-		return ret;
-
-	provider = &qp->provider;
-	INIT_LIST_HEAD(&provider->nodes);
-	provider->dev = dev;
-	provider->set = msm8916_icc_set;
-	provider->aggregate = icc_std_aggregate;
-	provider->xlate = of_icc_xlate_onecell;
-	provider->data = data;
-
-	ret = icc_provider_add(provider);
-	if (ret) {
-		dev_err(dev, "error adding interconnect provider: %d\n", ret);
-		clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
-		return ret;
-	}
-
-	for (i = 0; i < num_nodes; i++) {
-		size_t j;
-
-		node = icc_node_create(qnodes[i]->id);
-		if (IS_ERR(node)) {
-			ret = PTR_ERR(node);
-			goto err;
-		}
-
-		node->name = qnodes[i]->name;
-		node->data = qnodes[i];
-		icc_node_add(node, provider);
-
-		for (j = 0; j < qnodes[i]->num_links; j++)
-			icc_link_create(node, qnodes[i]->links[j]);
-
-		data->nodes[i] = node;
-	}
-	data->num_nodes = num_nodes;
-
-	platform_set_drvdata(pdev, qp);
-
-	return 0;
-
-err:
-	icc_nodes_remove(provider);
-	icc_provider_del(provider);
-	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
-
-	return ret;
-}
-
-static int msm8916_qnoc_remove(struct platform_device *pdev)
-{
-	struct msm8916_icc_provider *qp = platform_get_drvdata(pdev);
-
-	icc_nodes_remove(&qp->provider);
-	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
-	return icc_provider_del(&qp->provider);
+	return qnoc_probe(pdev, sizeof(msm8916_bus_clocks),
+			  ARRAY_SIZE(msm8916_bus_clocks), msm8916_bus_clocks);
 }
 
 static const struct of_device_id msm8916_noc_of_match[] = {
@@ -542,7 +321,7 @@ MODULE_DEVICE_TABLE(of, msm8916_noc_of_match);
 
 static struct platform_driver msm8916_noc_driver = {
 	.probe = msm8916_qnoc_probe,
-	.remove = msm8916_qnoc_remove,
+	.remove = qnoc_remove,
 	.driver = {
 		.name = "qnoc-msm8916",
 		.of_match_table = msm8916_noc_of_match,
-- 
2.17.1

