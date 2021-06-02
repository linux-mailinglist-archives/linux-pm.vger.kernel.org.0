Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4321D398E22
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 17:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhFBPRd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 11:17:33 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:52840 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbhFBPRc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 11:17:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622646949; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=B5lUNjOPqdTnD/AHUYxFUKQuhxcZYIeN15NySdsQFio=; b=n9sLb8Xc2/D6T3+EMVUhtdiH1ddAAW6uyIBaQJf2gYPiTR31MgKC/aM1zzGDr+ui4P3i8+bt
 N+WLgoHa4YOtPhw+iTFqcwFM952u38xllt3vnLUdsiL6vz7XQGytLREBeWhPmj8MCUCyVQm0
 Kn+JgRwXuY2VjcPAvc/vi0756J4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60b7a08aabfd22a3dca5909e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Jun 2021 15:15:22
 GMT
Sender: okukatla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 04EEDC4338A; Wed,  2 Jun 2021 15:15:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from okukatla1-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8D4CDC43143;
        Wed,  2 Jun 2021 15:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8D4CDC43143
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=okukatla@codeaurora.org
From:   Odelu Kukatla <okukatla@codeaurora.org>
To:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, Andy Gross <agross@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-arm-msm-owner@vger.kernel.org,
        Odelu Kukatla <okukatla@codeaurora.org>
Subject: [V3 2/3] interconnect: qcom: Add EPSS L3 support on SC7280
Date:   Wed,  2 Jun 2021 20:44:52 +0530
Message-Id: <1622646894-7833-3-git-send-email-okukatla@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622646894-7833-1-git-send-email-okukatla@codeaurora.org>
References: <1622646894-7833-1-git-send-email-okukatla@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add Epoch Subsystem (EPSS) L3 interconnect provider support on
SC7280 SoCs.

Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
---
 drivers/interconnect/qcom/osm-l3.c | 135 +++++++++++++++++++++++++++++--------
 drivers/interconnect/qcom/sc7280.h |  10 +++
 2 files changed, 116 insertions(+), 29 deletions(-)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index 695f287..a8c0ee8 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -15,6 +15,7 @@
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 
 #include "sc7180.h"
+#include "sc7280.h"
 #include "sdm845.h"
 #include "sm8150.h"
 #include "sm8250.h"
@@ -32,17 +33,33 @@
 
 /* EPSS Register offsets */
 #define EPSS_LUT_ROW_SIZE		4
+#define EPSS_REG_L3_VOTE		0x90
 #define EPSS_REG_FREQ_LUT		0x100
 #define EPSS_REG_PERF_STATE		0x320
+#define EPSS_CORE_OFFSET		0x4
+#define EPSS_L3_VOTE_REG(base, cpu)\
+			(((base) + EPSS_REG_L3_VOTE) +\
+			((cpu) * EPSS_CORE_OFFSET))
 
-#define OSM_L3_MAX_LINKS		1
+#define L3_DOMAIN_CNT		4
+#define L3_MAX_LINKS		9
 
 #define to_qcom_provider(_provider) \
 	container_of(_provider, struct qcom_osm_l3_icc_provider, provider)
 
+/**
+ * @domain_base: an array of base address for each clock domain
+ * @max_state: max supported frequency level
+ * @per_core_dcvs: flag used to indicate whether the frequency scaling
+ * for each core is enabled
+ * @reg_perf_state: requested frequency level
+ * @lut_tables: an array of supported frequency levels
+ * @provider: interconnect provider of this node
+ */
 struct qcom_osm_l3_icc_provider {
-	void __iomem *base;
+	void __iomem *domain_base[L3_DOMAIN_CNT];
 	unsigned int max_state;
+	bool per_core_dcvs;
 	unsigned int reg_perf_state;
 	unsigned long lut_tables[LUT_MAX_ENTRIES];
 	struct icc_provider provider;
@@ -55,34 +72,41 @@ struct qcom_osm_l3_icc_provider {
  * @id: a unique node identifier
  * @num_links: the total number of @links
  * @buswidth: width of the interconnect between a node and the bus
+ * @domain: clock domain of the cpu node
+ * @cpu: cpu instance within its clock domain
  */
 struct qcom_icc_node {
 	const char *name;
-	u16 links[OSM_L3_MAX_LINKS];
+	u16 links[L3_MAX_LINKS];
 	u16 id;
 	u16 num_links;
 	u16 buswidth;
+	u16 domain;
+	int cpu;
 };
 
 struct qcom_icc_desc {
 	const struct qcom_icc_node **nodes;
 	size_t num_nodes;
+	bool per_core_dcvs;
 	unsigned int lut_row_size;
 	unsigned int reg_freq_lut;
 	unsigned int reg_perf_state;
 };
 
-#define DEFINE_QNODE(_name, _id, _buswidth, ...)			\
-	static const struct qcom_icc_node _name = {			\
-		.name = #_name,						\
-		.id = _id,						\
-		.buswidth = _buswidth,					\
-		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
-		.links = { __VA_ARGS__ },				\
+#define DEFINE_QNODE(_name, _id, _buswidth, _domain, _cpu, ...)			\
+	static const struct qcom_icc_node _name = {				\
+		.name = #_name,							\
+		.id = _id,							\
+		.buswidth = _buswidth,						\
+		.domain = _domain,						\
+		.cpu = _cpu,						\
+		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),		\
+		.links = { __VA_ARGS__ },					\
 	}
 
-DEFINE_QNODE(sdm845_osm_apps_l3, SDM845_MASTER_OSM_L3_APPS, 16, SDM845_SLAVE_OSM_L3);
-DEFINE_QNODE(sdm845_osm_l3, SDM845_SLAVE_OSM_L3, 16);
+DEFINE_QNODE(sdm845_osm_apps_l3, SDM845_MASTER_OSM_L3_APPS, 16, 0, 0, SDM845_SLAVE_OSM_L3);
+DEFINE_QNODE(sdm845_osm_l3, SDM845_SLAVE_OSM_L3, 16, 0, 0);
 
 static const struct qcom_icc_node *sdm845_osm_l3_nodes[] = {
 	[MASTER_OSM_L3_APPS] = &sdm845_osm_apps_l3,
@@ -97,8 +121,8 @@ static const struct qcom_icc_desc sdm845_icc_osm_l3 = {
 	.reg_perf_state = OSM_REG_PERF_STATE,
 };
 
-DEFINE_QNODE(sc7180_osm_apps_l3, SC7180_MASTER_OSM_L3_APPS, 16, SC7180_SLAVE_OSM_L3);
-DEFINE_QNODE(sc7180_osm_l3, SC7180_SLAVE_OSM_L3, 16);
+DEFINE_QNODE(sc7180_osm_apps_l3, SC7180_MASTER_OSM_L3_APPS, 16, 0, 0, SC7180_SLAVE_OSM_L3);
+DEFINE_QNODE(sc7180_osm_l3, SC7180_SLAVE_OSM_L3, 16, 0, 0);
 
 static const struct qcom_icc_node *sc7180_osm_l3_nodes[] = {
 	[MASTER_OSM_L3_APPS] = &sc7180_osm_apps_l3,
@@ -113,8 +137,8 @@ static const struct qcom_icc_desc sc7180_icc_osm_l3 = {
 	.reg_perf_state = OSM_REG_PERF_STATE,
 };
 
-DEFINE_QNODE(sm8150_osm_apps_l3, SM8150_MASTER_OSM_L3_APPS, 32, SM8150_SLAVE_OSM_L3);
-DEFINE_QNODE(sm8150_osm_l3, SM8150_SLAVE_OSM_L3, 32);
+DEFINE_QNODE(sm8150_osm_apps_l3, SM8150_MASTER_OSM_L3_APPS, 32, 0, 0, SM8150_SLAVE_OSM_L3);
+DEFINE_QNODE(sm8150_osm_l3, SM8150_SLAVE_OSM_L3, 32, 0, 0);
 
 static const struct qcom_icc_node *sm8150_osm_l3_nodes[] = {
 	[MASTER_OSM_L3_APPS] = &sm8150_osm_apps_l3,
@@ -129,8 +153,8 @@ static const struct qcom_icc_desc sm8150_icc_osm_l3 = {
 	.reg_perf_state = OSM_REG_PERF_STATE,
 };
 
-DEFINE_QNODE(sm8250_epss_apps_l3, SM8250_MASTER_EPSS_L3_APPS, 32, SM8250_SLAVE_EPSS_L3);
-DEFINE_QNODE(sm8250_epss_l3, SM8250_SLAVE_EPSS_L3, 32);
+DEFINE_QNODE(sm8250_epss_apps_l3, SM8250_MASTER_EPSS_L3_APPS, 32, 0, 0, SM8250_SLAVE_EPSS_L3);
+DEFINE_QNODE(sm8250_epss_l3, SM8250_SLAVE_EPSS_L3, 32, 0, 0);
 
 static const struct qcom_icc_node *sm8250_epss_l3_nodes[] = {
 	[MASTER_EPSS_L3_APPS] = &sm8250_epss_apps_l3,
@@ -145,6 +169,39 @@ static const struct qcom_icc_desc sm8250_icc_epss_l3 = {
 	.reg_perf_state = EPSS_REG_PERF_STATE,
 };
 
+DEFINE_QNODE(sc7280_epss_apps_l3, SC7280_MASTER_EPSS_L3_APPS, 32, 0, 0, SC7280_SLAVE_EPSS_L3_SHARED, SC7280_SLAVE_EPSS_L3_CPU0, SC7280_SLAVE_EPSS_L3_CPU1, SC7280_SLAVE_EPSS_L3_CPU2, SC7280_SLAVE_EPSS_L3_CPU3, SC7280_SLAVE_EPSS_L3_CPU4, SC7280_SLAVE_EPSS_L3_CPU5, SC7280_SLAVE_EPSS_L3_CPU6, SC7280_SLAVE_EPSS_L3_CPU7);
+DEFINE_QNODE(sc7280_epss_l3_shared, SC7280_SLAVE_EPSS_L3_SHARED, 32, 0, 0);
+DEFINE_QNODE(sc7280_epss_l3_cpu0, SC7280_SLAVE_EPSS_L3_CPU0, 32, 1, 0);
+DEFINE_QNODE(sc7280_epss_l3_cpu1, SC7280_SLAVE_EPSS_L3_CPU1, 32, 1, 1);
+DEFINE_QNODE(sc7280_epss_l3_cpu2, SC7280_SLAVE_EPSS_L3_CPU2, 32, 1, 2);
+DEFINE_QNODE(sc7280_epss_l3_cpu3, SC7280_SLAVE_EPSS_L3_CPU3, 32, 1, 3);
+DEFINE_QNODE(sc7280_epss_l3_cpu4, SC7280_SLAVE_EPSS_L3_CPU4, 32, 2, 0);
+DEFINE_QNODE(sc7280_epss_l3_cpu5, SC7280_SLAVE_EPSS_L3_CPU5, 32, 2, 1);
+DEFINE_QNODE(sc7280_epss_l3_cpu6, SC7280_SLAVE_EPSS_L3_CPU6, 32, 2, 2);
+DEFINE_QNODE(sc7280_epss_l3_cpu7, SC7280_SLAVE_EPSS_L3_CPU7, 32, 3, 0);
+
+static const struct qcom_icc_node *sc7280_epss_l3_nodes[] = {
+	[MASTER_EPSS_L3_APPS] = &sc7280_epss_apps_l3,
+	[SLAVE_EPSS_L3_SHARED] = &sc7280_epss_l3_shared,
+	[SLAVE_EPSS_L3_CPU0] = &sc7280_epss_l3_cpu0,
+	[SLAVE_EPSS_L3_CPU1] = &sc7280_epss_l3_cpu1,
+	[SLAVE_EPSS_L3_CPU2] = &sc7280_epss_l3_cpu2,
+	[SLAVE_EPSS_L3_CPU3] = &sc7280_epss_l3_cpu3,
+	[SLAVE_EPSS_L3_CPU4] = &sc7280_epss_l3_cpu4,
+	[SLAVE_EPSS_L3_CPU5] = &sc7280_epss_l3_cpu5,
+	[SLAVE_EPSS_L3_CPU6] = &sc7280_epss_l3_cpu6,
+	[SLAVE_EPSS_L3_CPU7] = &sc7280_epss_l3_cpu7,
+};
+
+static const struct qcom_icc_desc sc7280_icc_epss_l3 = {
+	.nodes = sc7280_epss_l3_nodes,
+	.num_nodes = ARRAY_SIZE(sc7280_epss_l3_nodes),
+	.per_core_dcvs = true,
+	.lut_row_size = EPSS_LUT_ROW_SIZE,
+	.reg_freq_lut = EPSS_REG_FREQ_LUT,
+	.reg_perf_state = EPSS_REG_PERF_STATE,
+};
+
 static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 {
 	struct qcom_osm_l3_icc_provider *qp;
@@ -156,13 +213,18 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	u32 agg_avg = 0;
 	u64 rate;
 
-	qn = src->data;
+	qn = dst->data;
 	provider = src->provider;
 	qp = to_qcom_provider(provider);
 
-	list_for_each_entry(n, &provider->nodes, node_list)
-		provider->aggregate(n, 0, n->avg_bw, n->peak_bw,
-				    &agg_avg, &agg_peak);
+	/* Skip aggregation when per core l3 scaling is enabled */
+	if (qp->per_core_dcvs) {
+		agg_peak = dst->peak_bw;
+	} else {
+		list_for_each_entry(n, &provider->nodes, node_list)
+			provider->aggregate(n, 0, n->avg_bw, n->peak_bw,
+						&agg_avg, &agg_peak);
+	}
 
 	rate = max(agg_avg, agg_peak);
 	rate = icc_units_to_bps(rate);
@@ -173,7 +235,10 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 			break;
 	}
 
-	writel_relaxed(index, qp->base + qp->reg_perf_state);
+	if (qp->per_core_dcvs)
+		writel_relaxed(index, EPSS_L3_VOTE_REG(qp->domain_base[qn->domain], qn->cpu));
+	else
+		writel_relaxed(index, qp->domain_base[qn->domain] + qp->reg_perf_state);
 
 	return 0;
 }
@@ -194,11 +259,12 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 	const struct qcom_icc_desc *desc;
 	struct icc_onecell_data *data;
 	struct icc_provider *provider;
+	struct property *prop;
 	const struct qcom_icc_node **qnodes;
 	struct icc_node *node;
 	size_t num_nodes;
 	struct clk *clk;
-	int ret;
+	int ret, index, domain_count;
 
 	clk = clk_get(&pdev->dev, "xo");
 	if (IS_ERR(clk))
@@ -218,12 +284,21 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 	if (!qp)
 		return -ENOMEM;
 
-	qp->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(qp->base))
-		return PTR_ERR(qp->base);
+	prop = of_find_property(pdev->dev.of_node, "reg", NULL);
+	if (!prop)
+		return -EINVAL;
+	domain_count = prop->length / (4 * sizeof(prop->length));
+	if (!domain_count)
+		return -EINVAL;
+
+	for (index = 0; index < domain_count ; index++) {
+		qp->domain_base[index] = devm_platform_ioremap_resource(pdev, index);
+		if (IS_ERR(qp->domain_base[index]))
+			return PTR_ERR(qp->domain_base[index]);
+	}
 
 	/* HW should be in enabled state to proceed */
-	if (!(readl_relaxed(qp->base + REG_ENABLE) & 0x1)) {
+	if (!(readl_relaxed(qp->domain_base[0] + REG_ENABLE) & 0x1)) {
 		dev_err(&pdev->dev, "error hardware not enabled\n");
 		return -ENODEV;
 	}
@@ -235,7 +310,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 	qp->reg_perf_state = desc->reg_perf_state;
 
 	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
-		info = readl_relaxed(qp->base + desc->reg_freq_lut +
+		info = readl_relaxed(qp->domain_base[0] + desc->reg_freq_lut +
 				     i * desc->lut_row_size);
 		src = FIELD_GET(LUT_SRC, info);
 		lval = FIELD_GET(LUT_L_VAL, info);
@@ -254,6 +329,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 		prev_freq = freq;
 	}
 	qp->max_state = i;
+	qp->per_core_dcvs = desc->per_core_dcvs;
 
 	qnodes = desc->nodes;
 	num_nodes = desc->num_nodes;
@@ -309,6 +385,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 
 static const struct of_device_id osm_l3_of_match[] = {
 	{ .compatible = "qcom,sc7180-osm-l3", .data = &sc7180_icc_osm_l3 },
+	{ .compatible = "qcom,sc7280-epss-l3", .data = &sc7280_icc_epss_l3 },
 	{ .compatible = "qcom,sdm845-osm-l3", .data = &sdm845_icc_osm_l3 },
 	{ .compatible = "qcom,sm8150-osm-l3", .data = &sm8150_icc_osm_l3 },
 	{ .compatible = "qcom,sm8250-epss-l3", .data = &sm8250_icc_epss_l3 },
diff --git a/drivers/interconnect/qcom/sc7280.h b/drivers/interconnect/qcom/sc7280.h
index 175e400..5df7600 100644
--- a/drivers/interconnect/qcom/sc7280.h
+++ b/drivers/interconnect/qcom/sc7280.h
@@ -150,5 +150,15 @@
 #define SC7280_SLAVE_PCIE_1			139
 #define SC7280_SLAVE_QDSS_STM			140
 #define SC7280_SLAVE_TCU			141
+#define SC7280_MASTER_EPSS_L3_APPS			142
+#define SC7280_SLAVE_EPSS_L3_SHARED			143
+#define SC7280_SLAVE_EPSS_L3_CPU0			144
+#define SC7280_SLAVE_EPSS_L3_CPU1			145
+#define SC7280_SLAVE_EPSS_L3_CPU2			146
+#define SC7280_SLAVE_EPSS_L3_CPU3			147
+#define SC7280_SLAVE_EPSS_L3_CPU4			148
+#define SC7280_SLAVE_EPSS_L3_CPU5			149
+#define SC7280_SLAVE_EPSS_L3_CPU6			150
+#define SC7280_SLAVE_EPSS_L3_CPU7			151
 
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

