Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D542CE8F8
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 08:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387463AbgLDHza (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 02:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387435AbgLDHz3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2020 02:55:29 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF55C08E860
        for <linux-pm@vger.kernel.org>; Thu,  3 Dec 2020 23:54:19 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 131so3132516pfb.9
        for <linux-pm@vger.kernel.org>; Thu, 03 Dec 2020 23:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ffh6MHUF3pcIH20QeFw4DyMogPpGQ0qYgD+VOcKz+Uo=;
        b=ifrWHC1qNTOfLpfFReqng90ivM/9dXxNnwH2izb+t37SN4zVdigjjG7dikglKgHxdy
         Q3Pc+8941sR8KhIGMdRxovzWNFtdiehXE8iSELA3APiijQZCtsT/eP1bl7K9E9daBIHb
         dojUEi7lUagAEa/JJ0JsRXCVzJyUbNjyc5kbOYDcnvY1E9zoi5RxcnKQypc6lAdLgVk2
         GvNM/VZCWlIsVZj0yr9Mw4z/cKbmlR0/TnXprxeZHnouAxOorhkYiFEF7Up9/JBL8y6Z
         MK/nB8JTTWgeDiwLLU+d3kfLSqWogAaZlvMKQ6lbIULp9zVG4rAFZbL8Br1sZTPVHQLP
         eNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ffh6MHUF3pcIH20QeFw4DyMogPpGQ0qYgD+VOcKz+Uo=;
        b=RLFHu2/rvMu62g4VX/8c23uXMt7LjPYrStoVieAoZwr06mprXtxTQ463pxk+DRUzNk
         DW2L5MJt6bhGBvdDa+ytzlJkmS4rG5RPAIH1KlVbFBox4/XTvM7HxmW7DKSOvqKCuQAJ
         KtTNKsJLWdiOxYWfX17npvQ/OtC3rkk6C6k/pLG/mjrGmdiBnWklCOP67r8k/dVhizaW
         rEiWGAT2IgvPhrEev/B1BHZdQC89/iDAmG+zNWD8B+/LgtfLAaVe4obVBXlc16HJM7K/
         pTj0hLWkiMI0jkKNMhsJrV6U0N1I/hhiz1V+SwbWZHS09UaF3n4JqZpS+eZry4C842iP
         D3Uw==
X-Gm-Message-State: AOAM530fN5C/3n33yicjEH3XrkQ/psIWdpEtySYuPOFtu2t9SAnHAMJf
        rUmQ27LYBfFGVKODpHOMdDj6Nw==
X-Google-Smtp-Source: ABdhPJwsOffU4zoL5W9CpHN+spHQJ937TtzGKIlSGAoicLDOitHMacthyKRYqhw1i4Wbe2zwfqPoGQ==
X-Received: by 2002:a63:a902:: with SMTP id u2mr6548638pge.263.1607068458748;
        Thu, 03 Dec 2020 23:54:18 -0800 (PST)
Received: from localhost.localdomain (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id l190sm3822262pfl.205.2020.12.03.23.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 23:54:18 -0800 (PST)
From:   Jun Nie <jun.nie@linaro.org>
To:     devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org
Cc:     vincent.knecht@mailoo.org, shawn.guo@linaro.org,
        Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v2 2/5] interconnect: qcom: qcs404: use shared code
Date:   Fri,  4 Dec 2020 15:53:42 +0800
Message-Id: <20201204075345.5161-3-jun.nie@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201204075345.5161-1-jun.nie@linaro.org>
References: <20201204075345.5161-1-jun.nie@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use shared code for aggregate functionalities and probe function
to remove duplicated code.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/interconnect/qcom/qcs404.c | 242 +----------------------------
 1 file changed, 8 insertions(+), 234 deletions(-)

diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index 9820709b43db..36a7e30a00be 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -9,15 +9,12 @@
 #include <linux/interconnect-provider.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
-#include <linux/slab.h>
+#include <linux/of_device.h>
 
-#include "smd-rpm.h"
 
-#define RPM_BUS_MASTER_REQ	0x73616d62
-#define RPM_BUS_SLAVE_REQ	0x766c7362
+#include "smd-rpm.h"
+#include "icc-rpm.h"
 
 enum {
 	QCS404_MASTER_AMPSS_M0 = 1,
@@ -95,67 +92,11 @@ enum {
 	QCS404_SLAVE_LPASS,
 };
 
-#define to_qcom_provider(_provider) \
-	container_of(_provider, struct qcom_icc_provider, provider)
-
-static const struct clk_bulk_data bus_clocks[] = {
+static const struct clk_bulk_data qcs404_bus_clocks[] = {
 	{ .id = "bus" },
 	{ .id = "bus_a" },
 };
 
-/**
- * struct qcom_icc_provider - Qualcomm specific interconnect provider
- * @provider: generic interconnect provider
- * @bus_clks: the clk_bulk_data table of bus clocks
- * @num_clks: the total number of clk_bulk_data entries
- */
-struct qcom_icc_provider {
-	struct icc_provider provider;
-	struct clk_bulk_data *bus_clks;
-	int num_clks;
-};
-
-#define QCS404_MAX_LINKS	12
-
-/**
- * struct qcom_icc_node - Qualcomm specific interconnect nodes
- * @name: the node name used in debugfs
- * @id: a unique node identifier
- * @links: an array of nodes where we can go next while traversing
- * @num_links: the total number of @links
- * @buswidth: width of the interconnect between a node and the bus (bytes)
- * @mas_rpm_id:	RPM id for devices that are bus masters
- * @slv_rpm_id:	RPM id for devices that are bus slaves
- * @rate: current bus clock rate in Hz
- */
-struct qcom_icc_node {
-	unsigned char *name;
-	u16 id;
-	u16 links[QCS404_MAX_LINKS];
-	u16 num_links;
-	u16 buswidth;
-	int mas_rpm_id;
-	int slv_rpm_id;
-	u64 rate;
-};
-
-struct qcom_icc_desc {
-	struct qcom_icc_node **nodes;
-	size_t num_nodes;
-};
-
-#define DEFINE_QNODE(_name, _id, _buswidth, _mas_rpm_id, _slv_rpm_id,	\
-		     ...)						\
-		static struct qcom_icc_node _name = {			\
-		.name = #_name,						\
-		.id = _id,						\
-		.buswidth = _buswidth,					\
-		.mas_rpm_id = _mas_rpm_id,				\
-		.slv_rpm_id = _slv_rpm_id,				\
-		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
-		.links = { __VA_ARGS__ },				\
-	}
-
 DEFINE_QNODE(mas_apps_proc, QCS404_MASTER_AMPSS_M0, 8, 0, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);
 DEFINE_QNODE(mas_oxili, QCS404_MASTER_GRAPHICS_3D, 8, -1, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);
 DEFINE_QNODE(mas_mdp, QCS404_MASTER_MDP_PORT0, 8, -1, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);
@@ -327,178 +268,11 @@ static struct qcom_icc_desc qcs404_snoc = {
 	.num_nodes = ARRAY_SIZE(qcs404_snoc_nodes),
 };
 
-static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
-{
-	struct qcom_icc_provider *qp;
-	struct qcom_icc_node *qn;
-	struct icc_provider *provider;
-	struct icc_node *n;
-	u64 sum_bw;
-	u64 max_peak_bw;
-	u64 rate;
-	u32 agg_avg = 0;
-	u32 agg_peak = 0;
-	int ret, i;
-
-	qn = src->data;
-	provider = src->provider;
-	qp = to_qcom_provider(provider);
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
 
-	return 0;
-}
-
-static int qnoc_probe(struct platform_device *pdev)
+static int qcs404_qnoc_probe(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
-	const struct qcom_icc_desc *desc;
-	struct icc_onecell_data *data;
-	struct icc_provider *provider;
-	struct qcom_icc_node **qnodes;
-	struct qcom_icc_provider *qp;
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
-	qp->bus_clks = devm_kmemdup(dev, bus_clocks, sizeof(bus_clocks),
-				    GFP_KERNEL);
-	if (!qp->bus_clks)
-		return -ENOMEM;
-
-	qp->num_clks = ARRAY_SIZE(bus_clocks);
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
-	provider->set = qcom_icc_set;
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
-		dev_dbg(dev, "registered node %s\n", node->name);
-
-		/* populate links */
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
-err:
-	icc_nodes_remove(provider);
-	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
-	icc_provider_del(provider);
-
-	return ret;
-}
-
-static int qnoc_remove(struct platform_device *pdev)
-{
-	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
-
-	icc_nodes_remove(&qp->provider);
-	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
-	return icc_provider_del(&qp->provider);
+	return qnoc_probe(pdev, sizeof(qcs404_bus_clocks),
+			  ARRAY_SIZE(qcs404_bus_clocks), qcs404_bus_clocks);
 }
 
 static const struct of_device_id qcs404_noc_of_match[] = {
@@ -510,7 +284,7 @@ static const struct of_device_id qcs404_noc_of_match[] = {
 MODULE_DEVICE_TABLE(of, qcs404_noc_of_match);
 
 static struct platform_driver qcs404_noc_driver = {
-	.probe = qnoc_probe,
+	.probe = qcs404_qnoc_probe,
 	.remove = qnoc_remove,
 	.driver = {
 		.name = "qnoc-qcs404",
-- 
2.17.1

