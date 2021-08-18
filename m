Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271013EF7C2
	for <lists+linux-pm@lfdr.de>; Wed, 18 Aug 2021 03:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbhHRB6P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Aug 2021 21:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236080AbhHRB6O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Aug 2021 21:58:14 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B75EC061764
        for <linux-pm@vger.kernel.org>; Tue, 17 Aug 2021 18:57:38 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x27so1166495lfu.5
        for <linux-pm@vger.kernel.org>; Tue, 17 Aug 2021 18:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=epUjZHCaayjm5WRLWy2Nu++YSYqOpcQqtv7/OI0D9JE=;
        b=OwltFBi1Je5HJ4u9mE1nkxUvOdY/KZ7QkZwaSJrrWqViKzhNsD8+6jdT7VmxHGjCee
         X2AkzU4sKLtz42eOoAdXKj9bir5JthxBpFa444BGF1INRZC+kUBpa9lbij38uZ4UPs9h
         Dhg00Wa8OJA1g4tNO6SoyJaGxTqCAlEF1bcKRsioEMjcMR+f1c8nQRKo+B9P3CjNKMH2
         hVCWrA8b3dV875iYRCypcJ/6ivfI31sDdtXDqDr2RPtgguT618A8UDvGlZjCBAWzL26P
         Hx27ax2WUAnQHOxoOLeFFNNHOJcUuoX0LpzKM8lT9alw5TnlRG3wxxYA2OCQyKKhRLYj
         Fabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=epUjZHCaayjm5WRLWy2Nu++YSYqOpcQqtv7/OI0D9JE=;
        b=eOFRNJgpgll+n2SvmV+CHAaytoK8lqiNrjSjEifmRnbTPbiO28U4unAqhxzGFLwZxy
         yB7S6F1v4nv364xXrOd9fKF4+sGrbCfDrUSmpqOtJUKVIOTaOQTIvU/G06SveyzJmVat
         s0/jcx14kf+tRnWCcv/GmrLB72omKKNduWY/AR+f4d2aUjiwfcf3YjoIcIjWITy5dRIN
         O5GwlSBvbu8nRcrXz3uiP7155zKWr4JDMCTLJwdS+TzZk6KgqWMJyMnFXC19dWHYbMQS
         ZmHsfOKtb5qklc/O2jx1RxA5eQrX6knCy/Cbj3jyj0UrpsjljS8XrKn7668oIJEG67a+
         N6Cw==
X-Gm-Message-State: AOAM530MKNfjXARhnOeJdVOLxgUpEVb/XniGZOpPZaen2we+2XO8pXgC
        LOEFa+lkqqj88zD6lvr3Vq+IcA==
X-Google-Smtp-Source: ABdhPJzaC66BrbtcMFJX20GW3TxWWcvw+dmVPa4pz1MfYWmpDrg4afrncHgt8cdDJsZQ7bzcnkPLiw==
X-Received: by 2002:ac2:5327:: with SMTP id f7mr4484139lfh.62.1629251856221;
        Tue, 17 Aug 2021 18:57:36 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y8sm349500lfh.249.2021.08.17.18.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 18:57:35 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 2/5] interconnect: sdm660: merge common code into icc-rpm
Date:   Wed, 18 Aug 2021 04:57:29 +0300
Message-Id: <20210818015732.1717810-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210818015732.1717810-1-dmitry.baryshkov@linaro.org>
References: <20210818015732.1717810-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Other RPM interconnect drivers might also use QoS support. Move AP-owned
nodes support from SDM660 driver to common icc-rpm.c.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 248 ++++++++++-
 drivers/interconnect/qcom/icc-rpm.h |  55 ++-
 drivers/interconnect/qcom/sdm660.c  | 662 +++++-----------------------
 3 files changed, 380 insertions(+), 585 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 394f515cc88d..05130e74364a 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -11,60 +11,231 @@
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 
 #include "smd-rpm.h"
 #include "icc-rpm.h"
 
-static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
+/* BIMC QoS */
+#define M_BKE_REG_BASE(n)		(0x300 + (0x4000 * n))
+#define M_BKE_EN_ADDR(n)		(M_BKE_REG_BASE(n))
+#define M_BKE_HEALTH_CFG_ADDR(i, n)	(M_BKE_REG_BASE(n) + 0x40 + (0x4 * i))
+
+#define M_BKE_HEALTH_CFG_LIMITCMDS_MASK	0x80000000
+#define M_BKE_HEALTH_CFG_AREQPRIO_MASK	0x300
+#define M_BKE_HEALTH_CFG_PRIOLVL_MASK	0x3
+#define M_BKE_HEALTH_CFG_AREQPRIO_SHIFT	0x8
+#define M_BKE_HEALTH_CFG_LIMITCMDS_SHIFT 0x1f
+
+#define M_BKE_EN_EN_BMASK		0x1
+
+/* NoC QoS */
+#define NOC_QOS_PRIORITYn_ADDR(n)	(0x8 + (n * 0x1000))
+#define NOC_QOS_PRIORITY_MASK		0xf
+#define NOC_QOS_PRIORITY_P1_SHIFT	0x2
+#define NOC_QOS_PRIORITY_P0_SHIFT	0x3
+
+#define NOC_QOS_MODEn_ADDR(n)		(0xc + (n * 0x1000))
+#define NOC_QOS_MODEn_MASK		0x3
+
+static int qcom_icc_bimc_set_qos_health(struct regmap *rmap,
+					struct qcom_icc_qos *qos,
+					int regnum)
+{
+	u32 val;
+	u32 mask;
+
+	val = qos->prio_level;
+	mask = M_BKE_HEALTH_CFG_PRIOLVL_MASK;
+
+	val |= qos->areq_prio << M_BKE_HEALTH_CFG_AREQPRIO_SHIFT;
+	mask |= M_BKE_HEALTH_CFG_AREQPRIO_MASK;
+
+	/* LIMITCMDS is not present on M_BKE_HEALTH_3 */
+	if (regnum != 3) {
+		val |= qos->limit_commands << M_BKE_HEALTH_CFG_LIMITCMDS_SHIFT;
+		mask |= M_BKE_HEALTH_CFG_LIMITCMDS_MASK;
+	}
+
+	return regmap_update_bits(rmap,
+				  M_BKE_HEALTH_CFG_ADDR(regnum, qos->qos_port),
+				  mask, val);
+}
+
+static int qcom_icc_set_bimc_qos(struct icc_node *src, u64 max_bw,
+				 bool bypass_mode)
 {
 	struct qcom_icc_provider *qp;
 	struct qcom_icc_node *qn;
 	struct icc_provider *provider;
-	struct icc_node *n;
-	u64 sum_bw;
-	u64 max_peak_bw;
-	u64 rate;
-	u32 agg_avg = 0;
-	u32 agg_peak = 0;
-	int ret, i;
+	u32 mode = NOC_QOS_MODE_BYPASS;
+	u32 val = 0;
+	int i, rc = 0;
 
 	qn = src->data;
 	provider = src->provider;
 	qp = to_qcom_provider(provider);
 
-	list_for_each_entry(n, &provider->nodes, node_list)
-		provider->aggregate(n, 0, n->avg_bw, n->peak_bw,
-				    &agg_avg, &agg_peak);
+	if (qn->qos.qos_mode != -1)
+		mode = qn->qos.qos_mode;
+
+	/* QoS Priority: The QoS Health parameters are getting considered
+	 * only if we are NOT in Bypass Mode.
+	 */
+	if (mode != NOC_QOS_MODE_BYPASS) {
+		for (i = 3; i >= 0; i--) {
+			rc = qcom_icc_bimc_set_qos_health(qp->regmap,
+							  &qn->qos, i);
+			if (rc)
+				return rc;
+		}
 
-	sum_bw = icc_units_to_bps(agg_avg);
-	max_peak_bw = icc_units_to_bps(agg_peak);
+		/* Set BKE_EN to 1 when Fixed, Regulator or Limiter Mode */
+		val = 1;
+	}
+
+	return regmap_update_bits(qp->regmap, M_BKE_EN_ADDR(qn->qos.qos_port),
+				  M_BKE_EN_EN_BMASK, val);
+}
+
+static int qcom_icc_noc_set_qos_priority(struct regmap *rmap,
+					 struct qcom_icc_qos *qos)
+{
+	u32 val;
+	int rc;
+
+	/* Must be updated one at a time, P1 first, P0 last */
+	val = qos->areq_prio << NOC_QOS_PRIORITY_P1_SHIFT;
+	rc = regmap_update_bits(rmap, NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
+				NOC_QOS_PRIORITY_MASK, val);
+	if (rc)
+		return rc;
+
+	val = qos->prio_level << NOC_QOS_PRIORITY_P0_SHIFT;
+	return regmap_update_bits(rmap, NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
+				  NOC_QOS_PRIORITY_MASK, val);
+}
+
+static int qcom_icc_set_noc_qos(struct icc_node *src, u64 max_bw)
+{
+	struct qcom_icc_provider *qp;
+	struct qcom_icc_node *qn;
+	struct icc_provider *provider;
+	u32 mode = NOC_QOS_MODE_BYPASS;
+	int rc = 0;
+
+	qn = src->data;
+	provider = src->provider;
+	qp = to_qcom_provider(provider);
+
+	if (qn->qos.qos_port < 0) {
+		dev_dbg(src->provider->dev,
+			"NoC QoS: Skipping %s: vote aggregated on parent.\n",
+			qn->name);
+		return 0;
+	}
+
+	if (qn->qos.qos_mode != -1)
+		mode = qn->qos.qos_mode;
+
+	if (mode == NOC_QOS_MODE_FIXED) {
+		dev_dbg(src->provider->dev, "NoC QoS: %s: Set Fixed mode\n",
+			qn->name);
+		rc = qcom_icc_noc_set_qos_priority(qp->regmap, &qn->qos);
+		if (rc)
+			return rc;
+	} else if (mode == NOC_QOS_MODE_BYPASS) {
+		dev_dbg(src->provider->dev, "NoC QoS: %s: Set Bypass mode\n",
+			qn->name);
+	}
+
+	return regmap_update_bits(qp->regmap,
+				  NOC_QOS_MODEn_ADDR(qn->qos.qos_port),
+				  NOC_QOS_MODEn_MASK, mode);
+}
+
+static int qcom_icc_qos_set(struct icc_node *node, u64 sum_bw)
+{
+	struct qcom_icc_provider *qp = to_qcom_provider(node->provider);
+	struct qcom_icc_node *qn = node->data;
+
+	dev_dbg(node->provider->dev, "Setting QoS for %s\n", qn->name);
+
+	if (qp->is_bimc_node)
+		return qcom_icc_set_bimc_qos(node, sum_bw,
+				(qn->qos.qos_mode == NOC_QOS_MODE_BYPASS));
+
+	return qcom_icc_set_noc_qos(node, sum_bw);
+}
+
+static int qcom_icc_rpm_set(int mas_rpm_id, int slv_rpm_id, u64 sum_bw)
+{
+	int ret = 0;
 
-	/* send bandwidth request message to the RPM processor */
-	if (qn->mas_rpm_id != -1) {
+	if (mas_rpm_id != -1) {
 		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
 					    RPM_BUS_MASTER_REQ,
-					    qn->mas_rpm_id,
+					    mas_rpm_id,
 					    sum_bw);
 		if (ret) {
 			pr_err("qcom_icc_rpm_smd_send mas %d error %d\n",
-			       qn->mas_rpm_id, ret);
+			       mas_rpm_id, ret);
 			return ret;
 		}
 	}
 
-	if (qn->slv_rpm_id != -1) {
+	if (slv_rpm_id != -1) {
 		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
 					    RPM_BUS_SLAVE_REQ,
-					    qn->slv_rpm_id,
+					    slv_rpm_id,
 					    sum_bw);
 		if (ret) {
 			pr_err("qcom_icc_rpm_smd_send slv %d error %d\n",
-			       qn->slv_rpm_id, ret);
+			       slv_rpm_id, ret);
 			return ret;
 		}
 	}
 
+	return ret;
+}
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
+	if (!qn->qos.ap_owned) {
+		/* send bandwidth request message to the RPM processor */
+		ret = qcom_icc_rpm_set(qn->mas_rpm_id, qn->slv_rpm_id, sum_bw);
+		if (ret)
+			return ret;
+	} else if (qn->qos.qos_mode != -1) {
+		/* set bandwidth directly from the AP */
+		ret = qcom_icc_qos_set(src, sum_bw);
+		if (ret)
+			return ret;
+	}
+
 	rate = max(sum_bw, max_peak_bw);
 
 	do_div(rate, qn->buswidth);
@@ -90,6 +261,10 @@ static const char * const bus_clocks[] = {
 	"bus", "bus_a",
 };
 
+static const char * const bus_mm_clocks[] = {
+	"bus", "bus_a", "iface",
+};
+
 int qnoc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -115,8 +290,13 @@ int qnoc_probe(struct platform_device *pdev)
 	qnodes = desc->nodes;
 	num_nodes = desc->num_nodes;
 
-	cds = bus_clocks;
-	cd_num = ARRAY_SIZE(bus_clocks);
+	if (desc->has_iface_clk) {
+		cds = bus_mm_clocks;
+		cd_num = ARRAY_SIZE(bus_mm_clocks);
+	} else {
+		cds = bus_clocks;
+		cd_num = ARRAY_SIZE(bus_clocks);
+	}
 
 	qp = devm_kzalloc(dev, struct_size(qp, bus_clks, cd_num), GFP_KERNEL);
 	if (!qp)
@@ -131,6 +311,30 @@ int qnoc_probe(struct platform_device *pdev)
 		qp->bus_clks[i].id = cds[i];
 	qp->num_clks = cd_num;
 
+	qp->is_bimc_node = desc->is_bimc_node;
+
+	if (desc->regmap_cfg) {
+		struct resource *res;
+		void __iomem *mmio;
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!res)
+			return -ENODEV;
+
+		mmio = devm_ioremap_resource(dev, res);
+
+		if (IS_ERR(mmio)) {
+			dev_err(dev, "Cannot ioremap interconnect bus resource\n");
+			return PTR_ERR(mmio);
+		}
+
+		qp->regmap = devm_regmap_init_mmio(dev, mmio, desc->regmap_cfg);
+		if (IS_ERR(qp->regmap)) {
+			dev_err(dev, "Cannot regmap interconnect bus resource\n");
+			return PTR_ERR(qp->regmap);
+		}
+	}
+
 	ret = devm_clk_bulk_get(dev, qp->num_clks, qp->bus_clks);
 	if (ret)
 		return ret;
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index f4b05c20c097..3cb57d8a20e6 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -9,7 +9,7 @@
 #define RPM_BUS_MASTER_REQ	0x73616d62
 #define RPM_BUS_SLAVE_REQ	0x766c7362
 
-#define QCOM_MAX_LINKS 12
+#define QCOM_MAX_LINKS 34
 
 #define to_qcom_provider(_provider) \
 	container_of(_provider, struct qcom_icc_provider, provider)
@@ -19,13 +19,35 @@
  * @provider: generic interconnect provider
  * @bus_clks: the clk_bulk_data table of bus clocks
  * @num_clks: the total number of clk_bulk_data entries
+ * @is_bimc_node: indicates whether to use bimc specific setting
+ * @regmap: regmap for QoS registers read/write access
  */
 struct qcom_icc_provider {
 	struct icc_provider provider;
 	int num_clks;
+	bool is_bimc_node;
+	struct regmap *regmap;
 	struct clk_bulk_data bus_clks[];
 };
 
+/**
+ * struct qcom_icc_qos - Qualcomm specific interconnect QoS parameters
+ * @areq_prio: node requests priority
+ * @prio_level: priority level for bus communication
+ * @limit_commands: activate/deactivate limiter mode during runtime
+ * @ap_owned: indicates if the node is owned by the AP or by the RPM
+ * @qos_mode: default qos mode for this node
+ * @qos_port: qos port number for finding qos registers of this node
+ */
+struct qcom_icc_qos {
+	u32 areq_prio;
+	u32 prio_level;
+	bool limit_commands;
+	bool ap_owned;
+	int qos_mode;
+	int qos_port;
+};
+
 /**
  * struct qcom_icc_node - Qualcomm specific interconnect nodes
  * @name: the node name used in debugfs
@@ -35,6 +57,7 @@ struct qcom_icc_provider {
  * @buswidth: width of the interconnect between a node and the bus (bytes)
  * @mas_rpm_id:	RPM id for devices that are bus masters
  * @slv_rpm_id:	RPM id for devices that are bus slaves
+ * @qos: NoC QoS setting parameters
  * @rate: current bus clock rate in Hz
  */
 struct qcom_icc_node {
@@ -45,12 +68,16 @@ struct qcom_icc_node {
 	u16 buswidth;
 	int mas_rpm_id;
 	int slv_rpm_id;
+	struct qcom_icc_qos qos;
 	u64 rate;
 };
 
 struct qcom_icc_desc {
 	struct qcom_icc_node **nodes;
 	size_t num_nodes;
+	bool is_bimc_node;
+	bool has_iface_clk;
+	const struct regmap_config *regmap_cfg;
 };
 
 #define DEFINE_QNODE(_name, _id, _buswidth, _mas_rpm_id, _slv_rpm_id,	\
@@ -61,10 +88,36 @@ struct qcom_icc_desc {
 		.buswidth = _buswidth,					\
 		.mas_rpm_id = _mas_rpm_id,				\
 		.slv_rpm_id = _slv_rpm_id,				\
+		.qos.ap_owned = false,					\
+		.qos.qos_mode = -1,					\
+		.qos.areq_prio = 0,					\
+		.qos.prio_level = 01,					\
+		.qos.qos_port = -1,					\
+		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
+		.links = { __VA_ARGS__ },				\
+	}
+
+#define DEFINE_QNODE_AP(_name, _id, _buswidth, _mas_rpm_id, _slv_rpm_id, \
+		     _qos_mode, _qos_prio, _qos_port, ...)		\
+		static struct qcom_icc_node _name = {			\
+		.name = #_name,						\
+		.id = _id,						\
+		.buswidth = _buswidth,					\
+		.mas_rpm_id = _mas_rpm_id,				\
+		.slv_rpm_id = _slv_rpm_id,				\
+		.qos.ap_owned = true,					\
+		.qos.qos_mode = _qos_mode,				\
+		.qos.areq_prio = _qos_prio,				\
+		.qos.prio_level = _qos_prio,				\
+		.qos.qos_port = _qos_port,				\
 		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
 		.links = { __VA_ARGS__ },				\
 	}
 
+/* Valid for both NoC and BIMC */
+#define NOC_QOS_MODE_FIXED		0x0
+#define NOC_QOS_MODE_LIMITER		0x1
+#define NOC_QOS_MODE_BYPASS		0x2
 
 int qnoc_probe(struct platform_device *pdev);
 int qnoc_remove(struct platform_device *pdev);
diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index 632dbdd21915..5686865aabbb 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -17,39 +17,7 @@
 #include <linux/slab.h>
 
 #include "smd-rpm.h"
-
-#define RPM_BUS_MASTER_REQ	0x73616d62
-#define RPM_BUS_SLAVE_REQ	0x766c7362
-
-/* BIMC QoS */
-#define M_BKE_REG_BASE(n)		(0x300 + (0x4000 * n))
-#define M_BKE_EN_ADDR(n)		(M_BKE_REG_BASE(n))
-#define M_BKE_HEALTH_CFG_ADDR(i, n)	(M_BKE_REG_BASE(n) + 0x40 + (0x4 * i))
-
-#define M_BKE_HEALTH_CFG_LIMITCMDS_MASK	0x80000000
-#define M_BKE_HEALTH_CFG_AREQPRIO_MASK	0x300
-#define M_BKE_HEALTH_CFG_PRIOLVL_MASK	0x3
-#define M_BKE_HEALTH_CFG_AREQPRIO_SHIFT	0x8
-#define M_BKE_HEALTH_CFG_LIMITCMDS_SHIFT 0x1f
-
-#define M_BKE_EN_EN_BMASK		0x1
-
-/* Valid for both NoC and BIMC */
-#define NOC_QOS_MODE_FIXED		0x0
-#define NOC_QOS_MODE_LIMITER		0x1
-#define NOC_QOS_MODE_BYPASS		0x2
-
-/* NoC QoS */
-#define NOC_PERM_MODE_FIXED		1
-#define NOC_PERM_MODE_BYPASS		(1 << NOC_QOS_MODE_BYPASS)
-
-#define NOC_QOS_PRIORITYn_ADDR(n)	(0x8 + (n * 0x1000))
-#define NOC_QOS_PRIORITY_MASK		0xf
-#define NOC_QOS_PRIORITY_P1_SHIFT	0x2
-#define NOC_QOS_PRIORITY_P0_SHIFT	0x3
-
-#define NOC_QOS_MODEn_ADDR(n)		(0xc + (n * 0x1000))
-#define NOC_QOS_MODEn_MASK		0x3
+#include "icc-rpm.h"
 
 enum {
 	SDM660_MASTER_IPA = 1,
@@ -159,9 +127,6 @@ enum {
 	SDM660_SNOC,
 };
 
-#define to_qcom_provider(_provider) \
-	container_of(_provider, struct qcom_icc_provider, provider)
-
 static const struct clk_bulk_data bus_clocks[] = {
 	{ .id = "bus" },
 	{ .id = "bus_a" },
@@ -173,188 +138,103 @@ static const struct clk_bulk_data bus_mm_clocks[] = {
 	{ .id = "iface" },
 };
 
-/**
- * struct qcom_icc_provider - Qualcomm specific interconnect provider
- * @provider: generic interconnect provider
- * @bus_clks: the clk_bulk_data table of bus clocks
- * @num_clks: the total number of clk_bulk_data entries
- * @is_bimc_node: indicates whether to use bimc specific setting
- * @regmap: regmap for QoS registers read/write access
- * @mmio: NoC base iospace
- */
-struct qcom_icc_provider {
-	struct icc_provider provider;
-	struct clk_bulk_data *bus_clks;
-	int num_clks;
-	bool is_bimc_node;
-	struct regmap *regmap;
-	void __iomem *mmio;
-};
-
-#define SDM660_MAX_LINKS	34
-
-/**
- * struct qcom_icc_qos - Qualcomm specific interconnect QoS parameters
- * @areq_prio: node requests priority
- * @prio_level: priority level for bus communication
- * @limit_commands: activate/deactivate limiter mode during runtime
- * @ap_owned: indicates if the node is owned by the AP or by the RPM
- * @qos_mode: default qos mode for this node
- * @qos_port: qos port number for finding qos registers of this node
- */
-struct qcom_icc_qos {
-	u32 areq_prio;
-	u32 prio_level;
-	bool limit_commands;
-	bool ap_owned;
-	int qos_mode;
-	int qos_port;
-};
-
-/**
- * struct qcom_icc_node - Qualcomm specific interconnect nodes
- * @name: the node name used in debugfs
- * @id: a unique node identifier
- * @links: an array of nodes where we can go next while traversing
- * @num_links: the total number of @links
- * @buswidth: width of the interconnect between a node and the bus (bytes)
- * @mas_rpm_id: RPM id for devices that are bus masters
- * @slv_rpm_id: RPM id for devices that are bus slaves
- * @qos: NoC QoS setting parameters
- * @rate: current bus clock rate in Hz
- */
-struct qcom_icc_node {
-	unsigned char *name;
-	u16 id;
-	u16 links[SDM660_MAX_LINKS];
-	u16 num_links;
-	u16 buswidth;
-	int mas_rpm_id;
-	int slv_rpm_id;
-	struct qcom_icc_qos qos;
-	u64 rate;
-};
-
-struct qcom_icc_desc {
-	struct qcom_icc_node **nodes;
-	size_t num_nodes;
-	const struct regmap_config *regmap_cfg;
-};
-
-#define DEFINE_QNODE(_name, _id, _buswidth, _mas_rpm_id, _slv_rpm_id,	\
-		     _ap_owned, _qos_mode, _qos_prio, _qos_port, ...)	\
-		static struct qcom_icc_node _name = {			\
-		.name = #_name,						\
-		.id = _id,						\
-		.buswidth = _buswidth,					\
-		.mas_rpm_id = _mas_rpm_id,				\
-		.slv_rpm_id = _slv_rpm_id,				\
-		.qos.ap_owned = _ap_owned,				\
-		.qos.qos_mode = _qos_mode,				\
-		.qos.areq_prio = _qos_prio,				\
-		.qos.prio_level = _qos_prio,				\
-		.qos.qos_port = _qos_port,				\
-		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
-		.links = { __VA_ARGS__ },				\
-	}
-
-DEFINE_QNODE(mas_ipa, SDM660_MASTER_IPA, 8, 59, -1, true, NOC_QOS_MODE_FIXED, 1, 3, SDM660_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(mas_cnoc_a2noc, SDM660_MASTER_CNOC_A2NOC, 8, 146, -1, true, -1, 0, -1, SDM660_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(mas_sdcc_1, SDM660_MASTER_SDCC_1, 8, 33, -1, false, -1, 0, -1, SDM660_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(mas_sdcc_2, SDM660_MASTER_SDCC_2, 8, 35, -1, false, -1, 0, -1, SDM660_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(mas_blsp_1, SDM660_MASTER_BLSP_1, 4, 41, -1, false, -1, 0, -1, SDM660_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(mas_blsp_2, SDM660_MASTER_BLSP_2, 4, 39, -1, false, -1, 0, -1, SDM660_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(mas_ufs, SDM660_MASTER_UFS, 8, 68, -1, true, NOC_QOS_MODE_FIXED, 1, 4, SDM660_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(mas_usb_hs, SDM660_MASTER_USB_HS, 8, 42, -1, true, NOC_QOS_MODE_FIXED, 1, 1, SDM660_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(mas_usb3, SDM660_MASTER_USB3, 8, 32, -1, true, NOC_QOS_MODE_FIXED, 1, 2, SDM660_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(mas_crypto, SDM660_MASTER_CRYPTO_C0, 8, 23, -1, true, NOC_QOS_MODE_FIXED, 1, 11, SDM660_SLAVE_A2NOC_SNOC);
-DEFINE_QNODE(mas_gnoc_bimc, SDM660_MASTER_GNOC_BIMC, 4, 144, -1, true, NOC_QOS_MODE_FIXED, 0, 0, SDM660_SLAVE_EBI);
-DEFINE_QNODE(mas_oxili, SDM660_MASTER_OXILI, 4, 6, -1, true, NOC_QOS_MODE_BYPASS, 0, 1, SDM660_SLAVE_HMSS_L3, SDM660_SLAVE_EBI, SDM660_SLAVE_BIMC_SNOC);
-DEFINE_QNODE(mas_mnoc_bimc, SDM660_MASTER_MNOC_BIMC, 4, 2, -1, true, NOC_QOS_MODE_BYPASS, 0, 2, SDM660_SLAVE_HMSS_L3, SDM660_SLAVE_EBI, SDM660_SLAVE_BIMC_SNOC);
-DEFINE_QNODE(mas_snoc_bimc, SDM660_MASTER_SNOC_BIMC, 4, 3, -1, false, -1, 0, -1, SDM660_SLAVE_HMSS_L3, SDM660_SLAVE_EBI);
-DEFINE_QNODE(mas_pimem, SDM660_MASTER_PIMEM, 4, 113, -1, true, NOC_QOS_MODE_FIXED, 1, 4, SDM660_SLAVE_HMSS_L3, SDM660_SLAVE_EBI);
-DEFINE_QNODE(mas_snoc_cnoc, SDM660_MASTER_SNOC_CNOC, 8, 52, -1, true, -1, 0, -1, SDM660_SLAVE_CLK_CTL, SDM660_SLAVE_QDSS_CFG, SDM660_SLAVE_QM_CFG, SDM660_SLAVE_SRVC_CNOC, SDM660_SLAVE_UFS_CFG, SDM660_SLAVE_TCSR, SDM660_SLAVE_A2NOC_SMMU_CFG, SDM660_SLAVE_SNOC_CFG, SDM660_SLAVE_TLMM_SOUTH, SDM660_SLAVE_MPM, SDM660_SLAVE_CNOC_MNOC_MMSS_CFG, SDM660_SLAVE_SDCC_2, SDM660_SLAVE_SDCC_1, SDM660_SLAVE_SPDM, SDM660_SLAVE_PMIC_ARB, SDM660_SLAVE_PRNG, SDM660_SLAVE_MSS_CFG, SDM660_SLAVE_GPUSS_CFG, SDM660_SLAVE_IMEM_CFG, SDM660_SLAVE_USB3_0, SDM660_SLAVE_A2NOC_CFG, SDM660_SLAVE_TLMM_NORTH, SDM660_SLAVE_USB_HS, SDM660_SLAVE_PDM, SDM660_SLAVE_TLMM_CENTER, SDM660_SLAVE_AHB2PHY, SDM660_SLAVE_BLSP_2, SDM660_SLAVE_BLSP_1, SDM660_SLAVE_PIMEM_CFG, SDM660_SLAVE_GLM, SDM660_SLAVE_MESSAGE_RAM, SDM660_SLAVE_BIMC_CFG, SDM660_SLAVE_CNOC_MNOC_CFG);
-DEFINE_QNODE(mas_qdss_dap, SDM660_MASTER_QDSS_DAP, 8, 49, -1, true, -1, 0, -1, SDM660_SLAVE_CLK_CTL, SDM660_SLAVE_QDSS_CFG, SDM660_SLAVE_QM_CFG, SDM660_SLAVE_SRVC_CNOC, SDM660_SLAVE_UFS_CFG, SDM660_SLAVE_TCSR, SDM660_SLAVE_A2NOC_SMMU_CFG, SDM660_SLAVE_SNOC_CFG, SDM660_SLAVE_TLMM_SOUTH, SDM660_SLAVE_MPM, SDM660_SLAVE_CNOC_MNOC_MMSS_CFG, SDM660_SLAVE_SDCC_2, SDM660_SLAVE_SDCC_1, SDM660_SLAVE_SPDM, SDM660_SLAVE_PMIC_ARB, SDM660_SLAVE_PRNG, SDM660_SLAVE_MSS_CFG, SDM660_SLAVE_GPUSS_CFG, SDM660_SLAVE_IMEM_CFG, SDM660_SLAVE_USB3_0, SDM660_SLAVE_A2NOC_CFG, SDM660_SLAVE_TLMM_NORTH, SDM660_SLAVE_USB_HS, SDM660_SLAVE_PDM, SDM660_SLAVE_TLMM_CENTER, SDM660_SLAVE_AHB2PHY, SDM660_SLAVE_BLSP_2, SDM660_SLAVE_BLSP_1, SDM660_SLAVE_PIMEM_CFG, SDM660_SLAVE_GLM, SDM660_SLAVE_MESSAGE_RAM, SDM660_SLAVE_CNOC_A2NOC, SDM660_SLAVE_BIMC_CFG, SDM660_SLAVE_CNOC_MNOC_CFG);
-DEFINE_QNODE(mas_apss_proc, SDM660_MASTER_APPS_PROC, 16, 0, -1, true, -1, 0, -1, SDM660_SLAVE_GNOC_SNOC, SDM660_SLAVE_GNOC_BIMC);
-DEFINE_QNODE(mas_cnoc_mnoc_mmss_cfg, SDM660_MASTER_CNOC_MNOC_MMSS_CFG, 8, 4, -1, true, -1, 0, -1, SDM660_SLAVE_VENUS_THROTTLE_CFG, SDM660_SLAVE_VENUS_CFG, SDM660_SLAVE_CAMERA_THROTTLE_CFG, SDM660_SLAVE_SMMU_CFG, SDM660_SLAVE_CAMERA_CFG, SDM660_SLAVE_CSI_PHY_CFG, SDM660_SLAVE_DISPLAY_THROTTLE_CFG, SDM660_SLAVE_DISPLAY_CFG, SDM660_SLAVE_MMSS_CLK_CFG, SDM660_SLAVE_MNOC_MPU_CFG, SDM660_SLAVE_MISC_CFG, SDM660_SLAVE_MMSS_CLK_XPU_CFG);
-DEFINE_QNODE(mas_cnoc_mnoc_cfg, SDM660_MASTER_CNOC_MNOC_CFG, 4, 5, -1, true, -1, 0, -1, SDM660_SLAVE_SRVC_MNOC);
-DEFINE_QNODE(mas_cpp, SDM660_MASTER_CPP, 16, 115, -1, true, NOC_QOS_MODE_BYPASS, 0, 4, SDM660_SLAVE_MNOC_BIMC);
-DEFINE_QNODE(mas_jpeg, SDM660_MASTER_JPEG, 16, 7, -1, true, NOC_QOS_MODE_BYPASS, 0, 6, SDM660_SLAVE_MNOC_BIMC);
-DEFINE_QNODE(mas_mdp_p0, SDM660_MASTER_MDP_P0, 16, 8, -1, true, NOC_QOS_MODE_BYPASS, 0, 0, SDM660_SLAVE_MNOC_BIMC); /* vrail-comp???? */
-DEFINE_QNODE(mas_mdp_p1, SDM660_MASTER_MDP_P1, 16, 61, -1, true, NOC_QOS_MODE_BYPASS, 0, 1, SDM660_SLAVE_MNOC_BIMC); /* vrail-comp??? */
-DEFINE_QNODE(mas_venus, SDM660_MASTER_VENUS, 16, 9, -1, true, NOC_QOS_MODE_BYPASS, 0, 1, SDM660_SLAVE_MNOC_BIMC);
-DEFINE_QNODE(mas_vfe, SDM660_MASTER_VFE, 16, 11, -1, true, NOC_QOS_MODE_BYPASS, 0, 5, SDM660_SLAVE_MNOC_BIMC);
-DEFINE_QNODE(mas_qdss_etr, SDM660_MASTER_QDSS_ETR, 8, 31, -1, true, NOC_QOS_MODE_FIXED, 1, 1, SDM660_SLAVE_PIMEM, SDM660_SLAVE_IMEM, SDM660_SLAVE_SNOC_CNOC, SDM660_SLAVE_SNOC_BIMC);
-DEFINE_QNODE(mas_qdss_bam, SDM660_MASTER_QDSS_BAM, 4, 19, -1, true, NOC_QOS_MODE_FIXED, 1, 0, SDM660_SLAVE_PIMEM, SDM660_SLAVE_IMEM, SDM660_SLAVE_SNOC_CNOC, SDM660_SLAVE_SNOC_BIMC);
-DEFINE_QNODE(mas_snoc_cfg, SDM660_MASTER_SNOC_CFG, 4, 20, -1, false, -1, 0, -1, SDM660_SLAVE_SRVC_SNOC);
-DEFINE_QNODE(mas_bimc_snoc, SDM660_MASTER_BIMC_SNOC, 8, 21, -1, false, -1, 0, -1, SDM660_SLAVE_PIMEM, SDM660_SLAVE_IPA, SDM660_SLAVE_QDSS_STM, SDM660_SLAVE_LPASS, SDM660_SLAVE_HMSS, SDM660_SLAVE_CDSP, SDM660_SLAVE_SNOC_CNOC, SDM660_SLAVE_WLAN, SDM660_SLAVE_IMEM);
-DEFINE_QNODE(mas_gnoc_snoc, SDM660_MASTER_GNOC_SNOC, 8, 150, -1, false, -1, 0, -1, SDM660_SLAVE_PIMEM, SDM660_SLAVE_IPA, SDM660_SLAVE_QDSS_STM, SDM660_SLAVE_LPASS, SDM660_SLAVE_HMSS, SDM660_SLAVE_CDSP, SDM660_SLAVE_SNOC_CNOC, SDM660_SLAVE_WLAN, SDM660_SLAVE_IMEM);
-DEFINE_QNODE(mas_a2noc_snoc, SDM660_MASTER_A2NOC_SNOC, 16, 112, -1, false, -1, 0, -1, SDM660_SLAVE_PIMEM, SDM660_SLAVE_IPA, SDM660_SLAVE_QDSS_STM, SDM660_SLAVE_LPASS, SDM660_SLAVE_HMSS, SDM660_SLAVE_SNOC_BIMC, SDM660_SLAVE_CDSP, SDM660_SLAVE_SNOC_CNOC, SDM660_SLAVE_WLAN, SDM660_SLAVE_IMEM);
-DEFINE_QNODE(slv_a2noc_snoc, SDM660_SLAVE_A2NOC_SNOC, 16, -1, 143, false, -1, 0, -1, SDM660_MASTER_A2NOC_SNOC);
-DEFINE_QNODE(slv_ebi, SDM660_SLAVE_EBI, 4, -1, 0, false, -1, 0, -1, 0);
-DEFINE_QNODE(slv_hmss_l3, SDM660_SLAVE_HMSS_L3, 4, -1, 160, false, -1, 0, -1, 0);
-DEFINE_QNODE(slv_bimc_snoc, SDM660_SLAVE_BIMC_SNOC, 4, -1, 2, false, -1, 0, -1, SDM660_MASTER_BIMC_SNOC);
-DEFINE_QNODE(slv_cnoc_a2noc, SDM660_SLAVE_CNOC_A2NOC, 8, -1, 208, true, -1, 0, -1, SDM660_MASTER_CNOC_A2NOC);
-DEFINE_QNODE(slv_mpm, SDM660_SLAVE_MPM, 4, -1, 62, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_pmic_arb, SDM660_SLAVE_PMIC_ARB, 4, -1, 59, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_tlmm_north, SDM660_SLAVE_TLMM_NORTH, 8, -1, 214, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_tcsr, SDM660_SLAVE_TCSR, 4, -1, 50, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_pimem_cfg, SDM660_SLAVE_PIMEM_CFG, 4, -1, 167, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_imem_cfg, SDM660_SLAVE_IMEM_CFG, 4, -1, 54, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_message_ram, SDM660_SLAVE_MESSAGE_RAM, 4, -1, 55, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_glm, SDM660_SLAVE_GLM, 4, -1, 209, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_bimc_cfg, SDM660_SLAVE_BIMC_CFG, 4, -1, 56, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_prng, SDM660_SLAVE_PRNG, 4, -1, 44, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_spdm, SDM660_SLAVE_SPDM, 4, -1, 60, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_qdss_cfg, SDM660_SLAVE_QDSS_CFG, 4, -1, 63, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_cnoc_mnoc_cfg, SDM660_SLAVE_BLSP_1, 4, -1, 66, true, -1, 0, -1, SDM660_MASTER_CNOC_MNOC_CFG);
-DEFINE_QNODE(slv_snoc_cfg, SDM660_SLAVE_SNOC_CFG, 4, -1, 70, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_qm_cfg, SDM660_SLAVE_QM_CFG, 4, -1, 212, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_clk_ctl, SDM660_SLAVE_CLK_CTL, 4, -1, 47, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_mss_cfg, SDM660_SLAVE_MSS_CFG, 4, -1, 48, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_tlmm_south, SDM660_SLAVE_TLMM_SOUTH, 4, -1, 217, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_ufs_cfg, SDM660_SLAVE_UFS_CFG, 4, -1, 92, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_a2noc_cfg, SDM660_SLAVE_A2NOC_CFG, 4, -1, 150, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_a2noc_smmu_cfg, SDM660_SLAVE_A2NOC_SMMU_CFG, 8, -1, 152, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_gpuss_cfg, SDM660_SLAVE_GPUSS_CFG, 8, -1, 11, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_ahb2phy, SDM660_SLAVE_AHB2PHY, 4, -1, 163, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_blsp_1, SDM660_SLAVE_BLSP_1, 4, -1, 39, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_sdcc_1, SDM660_SLAVE_SDCC_1, 4, -1, 31, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_sdcc_2, SDM660_SLAVE_SDCC_2, 4, -1, 33, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_tlmm_center, SDM660_SLAVE_TLMM_CENTER, 4, -1, 218, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_blsp_2, SDM660_SLAVE_BLSP_2, 4, -1, 37, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_pdm, SDM660_SLAVE_PDM, 4, -1, 41, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_cnoc_mnoc_mmss_cfg, SDM660_SLAVE_CNOC_MNOC_MMSS_CFG, 8, -1, 58, true, -1, 0, -1, SDM660_MASTER_CNOC_MNOC_MMSS_CFG);
-DEFINE_QNODE(slv_usb_hs, SDM660_SLAVE_USB_HS, 4, -1, 40, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_usb3_0, SDM660_SLAVE_USB3_0, 4, -1, 22, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_srvc_cnoc, SDM660_SLAVE_SRVC_CNOC, 4, -1, 76, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_gnoc_bimc, SDM660_SLAVE_GNOC_BIMC, 16, -1, 210, true, -1, 0, -1, SDM660_MASTER_GNOC_BIMC);
-DEFINE_QNODE(slv_gnoc_snoc, SDM660_SLAVE_GNOC_SNOC, 8, -1, 211, true, -1, 0, -1, SDM660_MASTER_GNOC_SNOC);
-DEFINE_QNODE(slv_camera_cfg, SDM660_SLAVE_CAMERA_CFG, 4, -1, 3, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_camera_throttle_cfg, SDM660_SLAVE_CAMERA_THROTTLE_CFG, 4, -1, 154, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_misc_cfg, SDM660_SLAVE_MISC_CFG, 4, -1, 8, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_venus_throttle_cfg, SDM660_SLAVE_VENUS_THROTTLE_CFG, 4, -1, 178, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_venus_cfg, SDM660_SLAVE_VENUS_CFG, 4, -1, 10, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_mmss_clk_xpu_cfg, SDM660_SLAVE_MMSS_CLK_XPU_CFG, 4, -1, 13, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_mmss_clk_cfg, SDM660_SLAVE_MMSS_CLK_CFG, 4, -1, 12, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_mnoc_mpu_cfg, SDM660_SLAVE_MNOC_MPU_CFG, 4, -1, 14, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_display_cfg, SDM660_SLAVE_DISPLAY_CFG, 4, -1, 4, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_csi_phy_cfg, SDM660_SLAVE_CSI_PHY_CFG, 4, -1, 224, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_display_throttle_cfg, SDM660_SLAVE_DISPLAY_THROTTLE_CFG, 4, -1, 156, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_smmu_cfg, SDM660_SLAVE_SMMU_CFG, 8, -1, 205, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_mnoc_bimc, SDM660_SLAVE_MNOC_BIMC, 16, -1, 16, true, -1, 0, -1, SDM660_MASTER_MNOC_BIMC);
-DEFINE_QNODE(slv_srvc_mnoc, SDM660_SLAVE_SRVC_MNOC, 8, -1, 17, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_hmss, SDM660_SLAVE_HMSS, 8, -1, 20, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_lpass, SDM660_SLAVE_LPASS, 4, -1, 21, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_wlan, SDM660_SLAVE_WLAN, 4, -1, 206, false, -1, 0, -1, 0);
-DEFINE_QNODE(slv_cdsp, SDM660_SLAVE_CDSP, 4, -1, 221, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_ipa, SDM660_SLAVE_IPA, 4, -1, 183, true, -1, 0, -1, 0);
-DEFINE_QNODE(slv_snoc_bimc, SDM660_SLAVE_SNOC_BIMC, 16, -1, 24, false, -1, 0, -1, SDM660_MASTER_SNOC_BIMC);
-DEFINE_QNODE(slv_snoc_cnoc, SDM660_SLAVE_SNOC_CNOC, 8, -1, 25, false, -1, 0, -1, SDM660_MASTER_SNOC_CNOC);
-DEFINE_QNODE(slv_imem, SDM660_SLAVE_IMEM, 8, -1, 26, false, -1, 0, -1, 0);
-DEFINE_QNODE(slv_pimem, SDM660_SLAVE_PIMEM, 8, -1, 166, false, -1, 0, -1, 0);
-DEFINE_QNODE(slv_qdss_stm, SDM660_SLAVE_QDSS_STM, 4, -1, 30, false, -1, 0, -1, 0);
-DEFINE_QNODE(slv_srvc_snoc, SDM660_SLAVE_SRVC_SNOC, 16, -1, 29, false, -1, 0, -1, 0);
+DEFINE_QNODE_AP(mas_ipa, SDM660_MASTER_IPA, 8, 59, -1, NOC_QOS_MODE_FIXED, 1, 3, SDM660_SLAVE_A2NOC_SNOC);
+DEFINE_QNODE_AP(mas_cnoc_a2noc, SDM660_MASTER_CNOC_A2NOC, 8, 146, -1, -1, 0, -1, SDM660_SLAVE_A2NOC_SNOC);
+DEFINE_QNODE(mas_sdcc_1, SDM660_MASTER_SDCC_1, 8, 33, -1, SDM660_SLAVE_A2NOC_SNOC);
+DEFINE_QNODE(mas_sdcc_2, SDM660_MASTER_SDCC_2, 8, 35, -1, SDM660_SLAVE_A2NOC_SNOC);
+DEFINE_QNODE(mas_blsp_1, SDM660_MASTER_BLSP_1, 4, 41, -1, SDM660_SLAVE_A2NOC_SNOC);
+DEFINE_QNODE(mas_blsp_2, SDM660_MASTER_BLSP_2, 4, 39, -1, SDM660_SLAVE_A2NOC_SNOC);
+DEFINE_QNODE_AP(mas_ufs, SDM660_MASTER_UFS, 8, 68, -1, NOC_QOS_MODE_FIXED, 1, 4, SDM660_SLAVE_A2NOC_SNOC);
+DEFINE_QNODE_AP(mas_usb_hs, SDM660_MASTER_USB_HS, 8, 42, -1, NOC_QOS_MODE_FIXED, 1, 1, SDM660_SLAVE_A2NOC_SNOC);
+DEFINE_QNODE_AP(mas_usb3, SDM660_MASTER_USB3, 8, 32, -1, NOC_QOS_MODE_FIXED, 1, 2, SDM660_SLAVE_A2NOC_SNOC);
+DEFINE_QNODE_AP(mas_crypto, SDM660_MASTER_CRYPTO_C0, 8, 23, -1, NOC_QOS_MODE_FIXED, 1, 11, SDM660_SLAVE_A2NOC_SNOC);
+DEFINE_QNODE_AP(mas_gnoc_bimc, SDM660_MASTER_GNOC_BIMC, 4, 144, -1, NOC_QOS_MODE_FIXED, 0, 0, SDM660_SLAVE_EBI);
+DEFINE_QNODE_AP(mas_oxili, SDM660_MASTER_OXILI, 4, 6, -1, NOC_QOS_MODE_BYPASS, 0, 1, SDM660_SLAVE_HMSS_L3, SDM660_SLAVE_EBI, SDM660_SLAVE_BIMC_SNOC);
+DEFINE_QNODE_AP(mas_mnoc_bimc, SDM660_MASTER_MNOC_BIMC, 4, 2, -1, NOC_QOS_MODE_BYPASS, 0, 2, SDM660_SLAVE_HMSS_L3, SDM660_SLAVE_EBI, SDM660_SLAVE_BIMC_SNOC);
+DEFINE_QNODE(mas_snoc_bimc, SDM660_MASTER_SNOC_BIMC, 4, 3, -1, SDM660_SLAVE_HMSS_L3, SDM660_SLAVE_EBI);
+DEFINE_QNODE_AP(mas_pimem, SDM660_MASTER_PIMEM, 4, 113, -1, NOC_QOS_MODE_FIXED, 1, 4, SDM660_SLAVE_HMSS_L3, SDM660_SLAVE_EBI);
+DEFINE_QNODE_AP(mas_snoc_cnoc, SDM660_MASTER_SNOC_CNOC, 8, 52, -1, -1, 0, -1, SDM660_SLAVE_CLK_CTL, SDM660_SLAVE_QDSS_CFG, SDM660_SLAVE_QM_CFG, SDM660_SLAVE_SRVC_CNOC, SDM660_SLAVE_UFS_CFG, SDM660_SLAVE_TCSR, SDM660_SLAVE_A2NOC_SMMU_CFG, SDM660_SLAVE_SNOC_CFG, SDM660_SLAVE_TLMM_SOUTH, SDM660_SLAVE_MPM, SDM660_SLAVE_CNOC_MNOC_MMSS_CFG, SDM660_SLAVE_SDCC_2, SDM660_SLAVE_SDCC_1, SDM660_SLAVE_SPDM, SDM660_SLAVE_PMIC_ARB, SDM660_SLAVE_PRNG, SDM660_SLAVE_MSS_CFG, SDM660_SLAVE_GPUSS_CFG, SDM660_SLAVE_IMEM_CFG, SDM660_SLAVE_USB3_0, SDM660_SLAVE_A2NOC_CFG, SDM660_SLAVE_TLMM_NORTH, SDM660_SLAVE_USB_HS, SDM660_SLAVE_PDM, SDM660_SLAVE_TLMM_CENTER, SDM660_SLAVE_AHB2PHY, SDM660_SLAVE_BLSP_2, SDM660_SLAVE_BLSP_1, SDM660_SLAVE_PIMEM_CFG, SDM660_SLAVE_GLM, SDM660_SLAVE_MESSAGE_RAM, SDM660_SLAVE_BIMC_CFG, SDM660_SLAVE_CNOC_MNOC_CFG);
+DEFINE_QNODE_AP(mas_qdss_dap, SDM660_MASTER_QDSS_DAP, 8, 49, -1, -1, 0, -1, SDM660_SLAVE_CLK_CTL, SDM660_SLAVE_QDSS_CFG, SDM660_SLAVE_QM_CFG, SDM660_SLAVE_SRVC_CNOC, SDM660_SLAVE_UFS_CFG, SDM660_SLAVE_TCSR, SDM660_SLAVE_A2NOC_SMMU_CFG, SDM660_SLAVE_SNOC_CFG, SDM660_SLAVE_TLMM_SOUTH, SDM660_SLAVE_MPM, SDM660_SLAVE_CNOC_MNOC_MMSS_CFG, SDM660_SLAVE_SDCC_2, SDM660_SLAVE_SDCC_1, SDM660_SLAVE_SPDM, SDM660_SLAVE_PMIC_ARB, SDM660_SLAVE_PRNG, SDM660_SLAVE_MSS_CFG, SDM660_SLAVE_GPUSS_CFG, SDM660_SLAVE_IMEM_CFG, SDM660_SLAVE_USB3_0, SDM660_SLAVE_A2NOC_CFG, SDM660_SLAVE_TLMM_NORTH, SDM660_SLAVE_USB_HS, SDM660_SLAVE_PDM, SDM660_SLAVE_TLMM_CENTER, SDM660_SLAVE_AHB2PHY, SDM660_SLAVE_BLSP_2, SDM660_SLAVE_BLSP_1, SDM660_SLAVE_PIMEM_CFG, SDM660_SLAVE_GLM, SDM660_SLAVE_MESSAGE_RAM, SDM660_SLAVE_CNOC_A2NOC, SDM660_SLAVE_BIMC_CFG, SDM660_SLAVE_CNOC_MNOC_CFG);
+DEFINE_QNODE_AP(mas_apss_proc, SDM660_MASTER_APPS_PROC, 16, 0, -1, -1, 0, -1, SDM660_SLAVE_GNOC_SNOC, SDM660_SLAVE_GNOC_BIMC);
+DEFINE_QNODE_AP(mas_cnoc_mnoc_mmss_cfg, SDM660_MASTER_CNOC_MNOC_MMSS_CFG, 8, 4, -1, -1, 0, -1, SDM660_SLAVE_VENUS_THROTTLE_CFG, SDM660_SLAVE_VENUS_CFG, SDM660_SLAVE_CAMERA_THROTTLE_CFG, SDM660_SLAVE_SMMU_CFG, SDM660_SLAVE_CAMERA_CFG, SDM660_SLAVE_CSI_PHY_CFG, SDM660_SLAVE_DISPLAY_THROTTLE_CFG, SDM660_SLAVE_DISPLAY_CFG, SDM660_SLAVE_MMSS_CLK_CFG, SDM660_SLAVE_MNOC_MPU_CFG, SDM660_SLAVE_MISC_CFG, SDM660_SLAVE_MMSS_CLK_XPU_CFG);
+DEFINE_QNODE_AP(mas_cnoc_mnoc_cfg, SDM660_MASTER_CNOC_MNOC_CFG, 4, 5, -1, -1, 0, -1, SDM660_SLAVE_SRVC_MNOC);
+DEFINE_QNODE_AP(mas_cpp, SDM660_MASTER_CPP, 16, 115, -1, NOC_QOS_MODE_BYPASS, 0, 4, SDM660_SLAVE_MNOC_BIMC);
+DEFINE_QNODE_AP(mas_jpeg, SDM660_MASTER_JPEG, 16, 7, -1, NOC_QOS_MODE_BYPASS, 0, 6, SDM660_SLAVE_MNOC_BIMC);
+DEFINE_QNODE_AP(mas_mdp_p0, SDM660_MASTER_MDP_P0, 16, 8, -1, NOC_QOS_MODE_BYPASS, 0, 0, SDM660_SLAVE_MNOC_BIMC); /* vrail-comp???? */
+DEFINE_QNODE_AP(mas_mdp_p1, SDM660_MASTER_MDP_P1, 16, 61, -1, NOC_QOS_MODE_BYPASS, 0, 1, SDM660_SLAVE_MNOC_BIMC); /* vrail-comp??? */
+DEFINE_QNODE_AP(mas_venus, SDM660_MASTER_VENUS, 16, 9, -1, NOC_QOS_MODE_BYPASS, 0, 1, SDM660_SLAVE_MNOC_BIMC);
+DEFINE_QNODE_AP(mas_vfe, SDM660_MASTER_VFE, 16, 11, -1, NOC_QOS_MODE_BYPASS, 0, 5, SDM660_SLAVE_MNOC_BIMC);
+DEFINE_QNODE_AP(mas_qdss_etr, SDM660_MASTER_QDSS_ETR, 8, 31, -1, NOC_QOS_MODE_FIXED, 1, 1, SDM660_SLAVE_PIMEM, SDM660_SLAVE_IMEM, SDM660_SLAVE_SNOC_CNOC, SDM660_SLAVE_SNOC_BIMC);
+DEFINE_QNODE_AP(mas_qdss_bam, SDM660_MASTER_QDSS_BAM, 4, 19, -1, NOC_QOS_MODE_FIXED, 1, 0, SDM660_SLAVE_PIMEM, SDM660_SLAVE_IMEM, SDM660_SLAVE_SNOC_CNOC, SDM660_SLAVE_SNOC_BIMC);
+DEFINE_QNODE(mas_snoc_cfg, SDM660_MASTER_SNOC_CFG, 4, 20, -1, SDM660_SLAVE_SRVC_SNOC);
+DEFINE_QNODE(mas_bimc_snoc, SDM660_MASTER_BIMC_SNOC, 8, 21, -1, SDM660_SLAVE_PIMEM, SDM660_SLAVE_IPA, SDM660_SLAVE_QDSS_STM, SDM660_SLAVE_LPASS, SDM660_SLAVE_HMSS, SDM660_SLAVE_CDSP, SDM660_SLAVE_SNOC_CNOC, SDM660_SLAVE_WLAN, SDM660_SLAVE_IMEM);
+DEFINE_QNODE(mas_gnoc_snoc, SDM660_MASTER_GNOC_SNOC, 8, 150, -1, SDM660_SLAVE_PIMEM, SDM660_SLAVE_IPA, SDM660_SLAVE_QDSS_STM, SDM660_SLAVE_LPASS, SDM660_SLAVE_HMSS, SDM660_SLAVE_CDSP, SDM660_SLAVE_SNOC_CNOC, SDM660_SLAVE_WLAN, SDM660_SLAVE_IMEM);
+DEFINE_QNODE(mas_a2noc_snoc, SDM660_MASTER_A2NOC_SNOC, 16, 112, -1, SDM660_SLAVE_PIMEM, SDM660_SLAVE_IPA, SDM660_SLAVE_QDSS_STM, SDM660_SLAVE_LPASS, SDM660_SLAVE_HMSS, SDM660_SLAVE_SNOC_BIMC, SDM660_SLAVE_CDSP, SDM660_SLAVE_SNOC_CNOC, SDM660_SLAVE_WLAN, SDM660_SLAVE_IMEM);
+DEFINE_QNODE(slv_a2noc_snoc, SDM660_SLAVE_A2NOC_SNOC, 16, -1, 143, SDM660_MASTER_A2NOC_SNOC);
+DEFINE_QNODE(slv_ebi, SDM660_SLAVE_EBI, 4, -1, 0, 0);
+DEFINE_QNODE(slv_hmss_l3, SDM660_SLAVE_HMSS_L3, 4, -1, 160, 0);
+DEFINE_QNODE(slv_bimc_snoc, SDM660_SLAVE_BIMC_SNOC, 4, -1, 2, SDM660_MASTER_BIMC_SNOC);
+DEFINE_QNODE_AP(slv_cnoc_a2noc, SDM660_SLAVE_CNOC_A2NOC, 8, -1, 208, -1, 0, -1, SDM660_MASTER_CNOC_A2NOC);
+DEFINE_QNODE_AP(slv_mpm, SDM660_SLAVE_MPM, 4, -1, 62, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_pmic_arb, SDM660_SLAVE_PMIC_ARB, 4, -1, 59, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_tlmm_north, SDM660_SLAVE_TLMM_NORTH, 8, -1, 214, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_tcsr, SDM660_SLAVE_TCSR, 4, -1, 50, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_pimem_cfg, SDM660_SLAVE_PIMEM_CFG, 4, -1, 167, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_imem_cfg, SDM660_SLAVE_IMEM_CFG, 4, -1, 54, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_message_ram, SDM660_SLAVE_MESSAGE_RAM, 4, -1, 55, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_glm, SDM660_SLAVE_GLM, 4, -1, 209, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_bimc_cfg, SDM660_SLAVE_BIMC_CFG, 4, -1, 56, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_prng, SDM660_SLAVE_PRNG, 4, -1, 44, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_spdm, SDM660_SLAVE_SPDM, 4, -1, 60, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_qdss_cfg, SDM660_SLAVE_QDSS_CFG, 4, -1, 63, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_cnoc_mnoc_cfg, SDM660_SLAVE_BLSP_1, 4, -1, 66, -1, 0, -1, SDM660_MASTER_CNOC_MNOC_CFG);
+DEFINE_QNODE_AP(slv_snoc_cfg, SDM660_SLAVE_SNOC_CFG, 4, -1, 70, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_qm_cfg, SDM660_SLAVE_QM_CFG, 4, -1, 212, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_clk_ctl, SDM660_SLAVE_CLK_CTL, 4, -1, 47, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_mss_cfg, SDM660_SLAVE_MSS_CFG, 4, -1, 48, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_tlmm_south, SDM660_SLAVE_TLMM_SOUTH, 4, -1, 217, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_ufs_cfg, SDM660_SLAVE_UFS_CFG, 4, -1, 92, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_a2noc_cfg, SDM660_SLAVE_A2NOC_CFG, 4, -1, 150, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_a2noc_smmu_cfg, SDM660_SLAVE_A2NOC_SMMU_CFG, 8, -1, 152, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_gpuss_cfg, SDM660_SLAVE_GPUSS_CFG, 8, -1, 11, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_ahb2phy, SDM660_SLAVE_AHB2PHY, 4, -1, 163, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_blsp_1, SDM660_SLAVE_BLSP_1, 4, -1, 39, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_sdcc_1, SDM660_SLAVE_SDCC_1, 4, -1, 31, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_sdcc_2, SDM660_SLAVE_SDCC_2, 4, -1, 33, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_tlmm_center, SDM660_SLAVE_TLMM_CENTER, 4, -1, 218, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_blsp_2, SDM660_SLAVE_BLSP_2, 4, -1, 37, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_pdm, SDM660_SLAVE_PDM, 4, -1, 41, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_cnoc_mnoc_mmss_cfg, SDM660_SLAVE_CNOC_MNOC_MMSS_CFG, 8, -1, 58, -1, 0, -1, SDM660_MASTER_CNOC_MNOC_MMSS_CFG);
+DEFINE_QNODE_AP(slv_usb_hs, SDM660_SLAVE_USB_HS, 4, -1, 40, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_usb3_0, SDM660_SLAVE_USB3_0, 4, -1, 22, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_srvc_cnoc, SDM660_SLAVE_SRVC_CNOC, 4, -1, 76, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_gnoc_bimc, SDM660_SLAVE_GNOC_BIMC, 16, -1, 210, -1, 0, -1, SDM660_MASTER_GNOC_BIMC);
+DEFINE_QNODE_AP(slv_gnoc_snoc, SDM660_SLAVE_GNOC_SNOC, 8, -1, 211, -1, 0, -1, SDM660_MASTER_GNOC_SNOC);
+DEFINE_QNODE_AP(slv_camera_cfg, SDM660_SLAVE_CAMERA_CFG, 4, -1, 3, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_camera_throttle_cfg, SDM660_SLAVE_CAMERA_THROTTLE_CFG, 4, -1, 154, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_misc_cfg, SDM660_SLAVE_MISC_CFG, 4, -1, 8, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_venus_throttle_cfg, SDM660_SLAVE_VENUS_THROTTLE_CFG, 4, -1, 178, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_venus_cfg, SDM660_SLAVE_VENUS_CFG, 4, -1, 10, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_mmss_clk_xpu_cfg, SDM660_SLAVE_MMSS_CLK_XPU_CFG, 4, -1, 13, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_mmss_clk_cfg, SDM660_SLAVE_MMSS_CLK_CFG, 4, -1, 12, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_mnoc_mpu_cfg, SDM660_SLAVE_MNOC_MPU_CFG, 4, -1, 14, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_display_cfg, SDM660_SLAVE_DISPLAY_CFG, 4, -1, 4, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_csi_phy_cfg, SDM660_SLAVE_CSI_PHY_CFG, 4, -1, 224, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_display_throttle_cfg, SDM660_SLAVE_DISPLAY_THROTTLE_CFG, 4, -1, 156, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_smmu_cfg, SDM660_SLAVE_SMMU_CFG, 8, -1, 205, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_mnoc_bimc, SDM660_SLAVE_MNOC_BIMC, 16, -1, 16, -1, 0, -1, SDM660_MASTER_MNOC_BIMC);
+DEFINE_QNODE_AP(slv_srvc_mnoc, SDM660_SLAVE_SRVC_MNOC, 8, -1, 17, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_hmss, SDM660_SLAVE_HMSS, 8, -1, 20, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_lpass, SDM660_SLAVE_LPASS, 4, -1, 21, -1, 0, -1, 0);
+DEFINE_QNODE(slv_wlan, SDM660_SLAVE_WLAN, 4, -1, 206, 0);
+DEFINE_QNODE_AP(slv_cdsp, SDM660_SLAVE_CDSP, 4, -1, 221, -1, 0, -1, 0);
+DEFINE_QNODE_AP(slv_ipa, SDM660_SLAVE_IPA, 4, -1, 183, -1, 0, -1, 0);
+DEFINE_QNODE(slv_snoc_bimc, SDM660_SLAVE_SNOC_BIMC, 16, -1, 24, SDM660_MASTER_SNOC_BIMC);
+DEFINE_QNODE(slv_snoc_cnoc, SDM660_SLAVE_SNOC_CNOC, 8, -1, 25, SDM660_MASTER_SNOC_CNOC);
+DEFINE_QNODE(slv_imem, SDM660_SLAVE_IMEM, 8, -1, 26, 0);
+DEFINE_QNODE(slv_pimem, SDM660_SLAVE_PIMEM, 8, -1, 166, 0);
+DEFINE_QNODE(slv_qdss_stm, SDM660_SLAVE_QDSS_STM, 4, -1, 30, 0);
+DEFINE_QNODE(slv_srvc_snoc, SDM660_SLAVE_SRVC_SNOC, 16, -1, 29, 0);
 
 static struct qcom_icc_node *sdm660_a2noc_nodes[] = {
 	[MASTER_IPA] = &mas_ipa,
@@ -406,6 +286,7 @@ static const struct regmap_config sdm660_bimc_regmap_config = {
 static struct qcom_icc_desc sdm660_bimc = {
 	.nodes = sdm660_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_bimc_nodes),
+	.is_bimc_node = true,
 	.regmap_cfg = &sdm660_bimc_regmap_config,
 };
 
@@ -518,6 +399,7 @@ static const struct regmap_config sdm660_mnoc_regmap_config = {
 static struct qcom_icc_desc sdm660_mnoc = {
 	.nodes = sdm660_mnoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_mnoc_nodes),
+	.has_iface_clk = true,
 	.regmap_cfg = &sdm660_mnoc_regmap_config,
 };
 
@@ -555,350 +437,6 @@ static struct qcom_icc_desc sdm660_snoc = {
 	.regmap_cfg = &sdm660_snoc_regmap_config,
 };
 
-static int qcom_icc_bimc_set_qos_health(struct regmap *rmap,
-					struct qcom_icc_qos *qos,
-					int regnum)
-{
-	u32 val;
-	u32 mask;
-
-	val = qos->prio_level;
-	mask = M_BKE_HEALTH_CFG_PRIOLVL_MASK;
-
-	val |= qos->areq_prio << M_BKE_HEALTH_CFG_AREQPRIO_SHIFT;
-	mask |= M_BKE_HEALTH_CFG_AREQPRIO_MASK;
-
-	/* LIMITCMDS is not present on M_BKE_HEALTH_3 */
-	if (regnum != 3) {
-		val |= qos->limit_commands << M_BKE_HEALTH_CFG_LIMITCMDS_SHIFT;
-		mask |= M_BKE_HEALTH_CFG_LIMITCMDS_MASK;
-	}
-
-	return regmap_update_bits(rmap,
-				  M_BKE_HEALTH_CFG_ADDR(regnum, qos->qos_port),
-				  mask, val);
-}
-
-static int qcom_icc_set_bimc_qos(struct icc_node *src, u64 max_bw,
-				 bool bypass_mode)
-{
-	struct qcom_icc_provider *qp;
-	struct qcom_icc_node *qn;
-	struct icc_provider *provider;
-	u32 mode = NOC_QOS_MODE_BYPASS;
-	u32 val = 0;
-	int i, rc = 0;
-
-	qn = src->data;
-	provider = src->provider;
-	qp = to_qcom_provider(provider);
-
-	if (qn->qos.qos_mode != -1)
-		mode = qn->qos.qos_mode;
-
-	/* QoS Priority: The QoS Health parameters are getting considered
-	 * only if we are NOT in Bypass Mode.
-	 */
-	if (mode != NOC_QOS_MODE_BYPASS) {
-		for (i = 3; i >= 0; i--) {
-			rc = qcom_icc_bimc_set_qos_health(qp->regmap,
-							  &qn->qos, i);
-			if (rc)
-				return rc;
-		}
-
-		/* Set BKE_EN to 1 when Fixed, Regulator or Limiter Mode */
-		val = 1;
-	}
-
-	return regmap_update_bits(qp->regmap, M_BKE_EN_ADDR(qn->qos.qos_port),
-				  M_BKE_EN_EN_BMASK, val);
-}
-
-static int qcom_icc_noc_set_qos_priority(struct regmap *rmap,
-					 struct qcom_icc_qos *qos)
-{
-	u32 val;
-	int rc;
-
-	/* Must be updated one at a time, P1 first, P0 last */
-	val = qos->areq_prio << NOC_QOS_PRIORITY_P1_SHIFT;
-	rc = regmap_update_bits(rmap, NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
-				NOC_QOS_PRIORITY_MASK, val);
-	if (rc)
-		return rc;
-
-	val = qos->prio_level << NOC_QOS_PRIORITY_P0_SHIFT;
-	return regmap_update_bits(rmap, NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
-				  NOC_QOS_PRIORITY_MASK, val);
-}
-
-static int qcom_icc_set_noc_qos(struct icc_node *src, u64 max_bw)
-{
-	struct qcom_icc_provider *qp;
-	struct qcom_icc_node *qn;
-	struct icc_provider *provider;
-	u32 mode = NOC_QOS_MODE_BYPASS;
-	int rc = 0;
-
-	qn = src->data;
-	provider = src->provider;
-	qp = to_qcom_provider(provider);
-
-	if (qn->qos.qos_port < 0) {
-		dev_dbg(src->provider->dev,
-			"NoC QoS: Skipping %s: vote aggregated on parent.\n",
-			qn->name);
-		return 0;
-	}
-
-	if (qn->qos.qos_mode != -1)
-		mode = qn->qos.qos_mode;
-
-	if (mode == NOC_QOS_MODE_FIXED) {
-		dev_dbg(src->provider->dev, "NoC QoS: %s: Set Fixed mode\n",
-			qn->name);
-		rc = qcom_icc_noc_set_qos_priority(qp->regmap, &qn->qos);
-		if (rc)
-			return rc;
-	} else if (mode == NOC_QOS_MODE_BYPASS) {
-		dev_dbg(src->provider->dev, "NoC QoS: %s: Set Bypass mode\n",
-			qn->name);
-	}
-
-	return regmap_update_bits(qp->regmap,
-				  NOC_QOS_MODEn_ADDR(qn->qos.qos_port),
-				  NOC_QOS_MODEn_MASK, mode);
-}
-
-static int qcom_icc_qos_set(struct icc_node *node, u64 sum_bw)
-{
-	struct qcom_icc_provider *qp = to_qcom_provider(node->provider);
-	struct qcom_icc_node *qn = node->data;
-
-	dev_dbg(node->provider->dev, "Setting QoS for %s\n", qn->name);
-
-	if (qp->is_bimc_node)
-		return qcom_icc_set_bimc_qos(node, sum_bw,
-				(qn->qos.qos_mode == NOC_QOS_MODE_BYPASS));
-
-	return qcom_icc_set_noc_qos(node, sum_bw);
-}
-
-static int qcom_icc_rpm_set(int mas_rpm_id, int slv_rpm_id, u64 sum_bw)
-{
-	int ret = 0;
-
-	if (mas_rpm_id != -1) {
-		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
-					    RPM_BUS_MASTER_REQ,
-					    mas_rpm_id,
-					    sum_bw);
-		if (ret) {
-			pr_err("qcom_icc_rpm_smd_send mas %d error %d\n",
-			       mas_rpm_id, ret);
-			return ret;
-		}
-	}
-
-	if (slv_rpm_id != -1) {
-		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
-					    RPM_BUS_SLAVE_REQ,
-					    slv_rpm_id,
-					    sum_bw);
-		if (ret) {
-			pr_err("qcom_icc_rpm_smd_send slv %d error %d\n",
-			       slv_rpm_id, ret);
-			return ret;
-		}
-	}
-
-	return ret;
-}
-
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
-	if (!qn->qos.ap_owned) {
-		/* send bandwidth request message to the RPM processor */
-		ret = qcom_icc_rpm_set(qn->mas_rpm_id, qn->slv_rpm_id, sum_bw);
-		if (ret)
-			return ret;
-	} else if (qn->qos.qos_mode != -1) {
-		/* set bandwidth directly from the AP */
-		ret = qcom_icc_qos_set(src, sum_bw);
-		if (ret)
-			return ret;
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
-static int qnoc_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	const struct qcom_icc_desc *desc;
-	struct icc_onecell_data *data;
-	struct icc_provider *provider;
-	struct qcom_icc_node **qnodes;
-	struct qcom_icc_provider *qp;
-	struct icc_node *node;
-	struct resource *res;
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
-	if (of_device_is_compatible(dev->of_node, "qcom,sdm660-mnoc")) {
-		qp->bus_clks = devm_kmemdup(dev, bus_mm_clocks,
-					    sizeof(bus_mm_clocks), GFP_KERNEL);
-		qp->num_clks = ARRAY_SIZE(bus_mm_clocks);
-	} else {
-		if (of_device_is_compatible(dev->of_node, "qcom,sdm660-bimc"))
-			qp->is_bimc_node = true;
-
-		qp->bus_clks = devm_kmemdup(dev, bus_clocks, sizeof(bus_clocks),
-					    GFP_KERNEL);
-		qp->num_clks = ARRAY_SIZE(bus_clocks);
-	}
-	if (!qp->bus_clks)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
-	qp->mmio = devm_ioremap_resource(dev, res);
-	if (IS_ERR(qp->mmio)) {
-		dev_err(dev, "Cannot ioremap interconnect bus resource\n");
-		return PTR_ERR(qp->mmio);
-	}
-
-	qp->regmap = devm_regmap_init_mmio(dev, qp->mmio, desc->regmap_cfg);
-	if (IS_ERR(qp->regmap)) {
-		dev_err(dev, "Cannot regmap interconnect bus resource\n");
-		return PTR_ERR(qp->regmap);
-	}
-
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
-		for (j = 0; j < qnodes[i]->num_links; j++)
-			icc_link_create(node, qnodes[i]->links[j]);
-
-		data->nodes[i] = node;
-	}
-	data->num_nodes = num_nodes;
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
-}
-
 static const struct of_device_id sdm660_noc_of_match[] = {
 	{ .compatible = "qcom,sdm660-a2noc", .data = &sdm660_a2noc },
 	{ .compatible = "qcom,sdm660-bimc", .data = &sdm660_bimc },
-- 
2.32.0

