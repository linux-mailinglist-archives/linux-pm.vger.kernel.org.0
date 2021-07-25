Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1073D4B1E
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jul 2021 05:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhGYCfd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 24 Jul 2021 22:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhGYCfc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Jul 2021 22:35:32 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92494C06175F
        for <linux-pm@vger.kernel.org>; Sat, 24 Jul 2021 20:16:02 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id o185so6725766oih.13
        for <linux-pm@vger.kernel.org>; Sat, 24 Jul 2021 20:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qU1AQGUnzAw+tR9LiitVOozStwaZW7Fxl3hPiKdznLY=;
        b=z22benouZj6zj2bR2WhXxpmi7bvoS4Ig6vypL4a/j6+n94aaZRe1dSeZUnmSo6ymo4
         flmG2UP5uPJ77u1OAoGViyqNbk+o/CUVVHXJaWqxKplIz3RkwwERD1JxaMB30l2R323q
         jMM2ex9P//goFPBHrMYuXvQ0mFbXX9qTCFC8HtL0C4K1f8x5zvQ5DoEVxbiUY6HP/OY2
         6SZDNfJB0qGH7cSthG8TKvDX1RfqrrsP25GoY87OBkJTuEzS4dlI74RQqvzhWuPLeCZM
         psv8zTqYwgYu7JsTpEG+qnkkZCIJLGyFmwbYwmLe2JLthgo66tL4K16uL4b4+Z3990rj
         pg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qU1AQGUnzAw+tR9LiitVOozStwaZW7Fxl3hPiKdznLY=;
        b=d8VvRUUqdpl20UEqzBCny5sDyDtlHMtotU7sDg8jVQf8N/F826tkhGb2FVdMdqo7l5
         OqXzHGqrzhegkYK2k2aGDQBOEVQIMyA5Y3x8m97IZsgLPLD+SukTF9Mv9KTT1TFZO0UY
         r3BF5TMdIl2bNCcuCZSd9eE121O0xW7DJHepEpAu4zHPOQz+GY7UxxlH4An659dHdjfO
         w38sfOuOJ1ep7/4MK6U3D4jfMPVYSJezWKQr7Qho8Mq+RdOrdyjO9Z3xSxVKl8idNJjO
         hoAgoXj3Ucmk6hhKftB25xQ13GoOBV3CnOW410dmICb4bZnPQV5KTbkxMf63noJJ4rTt
         Pe0w==
X-Gm-Message-State: AOAM533bgfxrxX/NrMFI0O7kBK1LgBybCjyY+AkQrhnN8dksgPN97kt1
        Se/aQ619iqw/Xh+xulxVRYvT0w==
X-Google-Smtp-Source: ABdhPJxIjL2FbGXn7dCQTRhU811vMnH9qJvn0LLvhRdN6cso4k3B7jbTmEc7dwQlHPysKa1p6eyQww==
X-Received: by 2002:aca:fc12:: with SMTP id a18mr7208886oii.85.1627182960828;
        Sat, 24 Jul 2021 20:16:00 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id k7sm6210660otn.60.2021.07.24.20.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 20:16:00 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] interconnect: qcom: osm-l3: Use driver-specific naming
Date:   Sat, 24 Jul 2021 20:14:14 -0700
Message-Id: <20210725031414.3961227-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In situations were the developer screws up by e.g. not giving the OSM
nodes unique identifiers the interconnect framework might mix up nodes
between the OSM L3 provider and e.g. the RPMh provider.

The resulting callstack containts "qcom_icc_set", which is not unique to
the OSM L3 provider driver. Once the faulting qcom_icc_set() is
identified it's further confusing that "qcom_icc_node" is different
between the different drivers.

To avoid this confusion, rename the node struct and the setter in the
OSM L3 driver to include "osm_l3" in their names.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

This was written after the sc8180x patch and as such applies ontop of:
https://lore.kernel.org/linux-arm-msm/20210725025834.3941777-2-bjorn.andersson@linaro.org/

 drivers/interconnect/qcom/osm-l3.c | 46 +++++++++++++++---------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index 13e41b932567..c7af143980de 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -38,7 +38,7 @@
 
 #define OSM_L3_MAX_LINKS		1
 
-#define to_qcom_provider(_provider) \
+#define to_osm_l3_provider(_provider) \
 	container_of(_provider, struct qcom_osm_l3_icc_provider, provider)
 
 struct qcom_osm_l3_icc_provider {
@@ -50,14 +50,14 @@ struct qcom_osm_l3_icc_provider {
 };
 
 /**
- * struct qcom_icc_node - Qualcomm specific interconnect nodes
+ * struct qcom_osm_l3_node - Qualcomm specific interconnect nodes
  * @name: the node name used in debugfs
  * @links: an array of nodes where we can go next while traversing
  * @id: a unique node identifier
  * @num_links: the total number of @links
  * @buswidth: width of the interconnect between a node and the bus
  */
-struct qcom_icc_node {
+struct qcom_osm_l3_node {
 	const char *name;
 	u16 links[OSM_L3_MAX_LINKS];
 	u16 id;
@@ -65,8 +65,8 @@ struct qcom_icc_node {
 	u16 buswidth;
 };
 
-struct qcom_icc_desc {
-	const struct qcom_icc_node **nodes;
+struct qcom_osm_l3_desc {
+	const struct qcom_osm_l3_node **nodes;
 	size_t num_nodes;
 	unsigned int lut_row_size;
 	unsigned int reg_freq_lut;
@@ -74,7 +74,7 @@ struct qcom_icc_desc {
 };
 
 #define DEFINE_QNODE(_name, _id, _buswidth, ...)			\
-	static const struct qcom_icc_node _name = {			\
+	static const struct qcom_osm_l3_node _name = {			\
 		.name = #_name,						\
 		.id = _id,						\
 		.buswidth = _buswidth,					\
@@ -85,12 +85,12 @@ struct qcom_icc_desc {
 DEFINE_QNODE(sdm845_osm_apps_l3, SDM845_MASTER_OSM_L3_APPS, 16, SDM845_SLAVE_OSM_L3);
 DEFINE_QNODE(sdm845_osm_l3, SDM845_SLAVE_OSM_L3, 16);
 
-static const struct qcom_icc_node *sdm845_osm_l3_nodes[] = {
+static const struct qcom_osm_l3_node *sdm845_osm_l3_nodes[] = {
 	[MASTER_OSM_L3_APPS] = &sdm845_osm_apps_l3,
 	[SLAVE_OSM_L3] = &sdm845_osm_l3,
 };
 
-static const struct qcom_icc_desc sdm845_icc_osm_l3 = {
+static const struct qcom_osm_l3_desc sdm845_icc_osm_l3 = {
 	.nodes = sdm845_osm_l3_nodes,
 	.num_nodes = ARRAY_SIZE(sdm845_osm_l3_nodes),
 	.lut_row_size = OSM_LUT_ROW_SIZE,
@@ -101,12 +101,12 @@ static const struct qcom_icc_desc sdm845_icc_osm_l3 = {
 DEFINE_QNODE(sc7180_osm_apps_l3, SC7180_MASTER_OSM_L3_APPS, 16, SC7180_SLAVE_OSM_L3);
 DEFINE_QNODE(sc7180_osm_l3, SC7180_SLAVE_OSM_L3, 16);
 
-static const struct qcom_icc_node *sc7180_osm_l3_nodes[] = {
+static const struct qcom_osm_l3_node *sc7180_osm_l3_nodes[] = {
 	[MASTER_OSM_L3_APPS] = &sc7180_osm_apps_l3,
 	[SLAVE_OSM_L3] = &sc7180_osm_l3,
 };
 
-static const struct qcom_icc_desc sc7180_icc_osm_l3 = {
+static const struct qcom_osm_l3_desc sc7180_icc_osm_l3 = {
 	.nodes = sc7180_osm_l3_nodes,
 	.num_nodes = ARRAY_SIZE(sc7180_osm_l3_nodes),
 	.lut_row_size = OSM_LUT_ROW_SIZE,
@@ -117,12 +117,12 @@ static const struct qcom_icc_desc sc7180_icc_osm_l3 = {
 DEFINE_QNODE(sc8180x_osm_apps_l3, SC8180X_MASTER_OSM_L3_APPS, 32, SC8180X_SLAVE_OSM_L3);
 DEFINE_QNODE(sc8180x_osm_l3, SC8180X_SLAVE_OSM_L3, 32);
 
-static const struct qcom_icc_node *sc8180x_osm_l3_nodes[] = {
+static const struct qcom_osm_l3_node *sc8180x_osm_l3_nodes[] = {
 	[MASTER_OSM_L3_APPS] = &sc8180x_osm_apps_l3,
 	[SLAVE_OSM_L3] = &sc8180x_osm_l3,
 };
 
-static const struct qcom_icc_desc sc8180x_icc_osm_l3 = {
+static const struct qcom_osm_l3_desc sc8180x_icc_osm_l3 = {
 	.nodes = sc8180x_osm_l3_nodes,
 	.num_nodes = ARRAY_SIZE(sc8180x_osm_l3_nodes),
 	.lut_row_size = OSM_LUT_ROW_SIZE,
@@ -133,12 +133,12 @@ static const struct qcom_icc_desc sc8180x_icc_osm_l3 = {
 DEFINE_QNODE(sm8150_osm_apps_l3, SM8150_MASTER_OSM_L3_APPS, 32, SM8150_SLAVE_OSM_L3);
 DEFINE_QNODE(sm8150_osm_l3, SM8150_SLAVE_OSM_L3, 32);
 
-static const struct qcom_icc_node *sm8150_osm_l3_nodes[] = {
+static const struct qcom_osm_l3_node *sm8150_osm_l3_nodes[] = {
 	[MASTER_OSM_L3_APPS] = &sm8150_osm_apps_l3,
 	[SLAVE_OSM_L3] = &sm8150_osm_l3,
 };
 
-static const struct qcom_icc_desc sm8150_icc_osm_l3 = {
+static const struct qcom_osm_l3_desc sm8150_icc_osm_l3 = {
 	.nodes = sm8150_osm_l3_nodes,
 	.num_nodes = ARRAY_SIZE(sm8150_osm_l3_nodes),
 	.lut_row_size = OSM_LUT_ROW_SIZE,
@@ -149,12 +149,12 @@ static const struct qcom_icc_desc sm8150_icc_osm_l3 = {
 DEFINE_QNODE(sm8250_epss_apps_l3, SM8250_MASTER_EPSS_L3_APPS, 32, SM8250_SLAVE_EPSS_L3);
 DEFINE_QNODE(sm8250_epss_l3, SM8250_SLAVE_EPSS_L3, 32);
 
-static const struct qcom_icc_node *sm8250_epss_l3_nodes[] = {
+static const struct qcom_osm_l3_node *sm8250_epss_l3_nodes[] = {
 	[MASTER_EPSS_L3_APPS] = &sm8250_epss_apps_l3,
 	[SLAVE_EPSS_L3_SHARED] = &sm8250_epss_l3,
 };
 
-static const struct qcom_icc_desc sm8250_icc_epss_l3 = {
+static const struct qcom_osm_l3_desc sm8250_icc_epss_l3 = {
 	.nodes = sm8250_epss_l3_nodes,
 	.num_nodes = ARRAY_SIZE(sm8250_epss_l3_nodes),
 	.lut_row_size = EPSS_LUT_ROW_SIZE,
@@ -162,11 +162,11 @@ static const struct qcom_icc_desc sm8250_icc_epss_l3 = {
 	.reg_perf_state = EPSS_REG_PERF_STATE,
 };
 
-static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
+static int qcom_osm_l3_set(struct icc_node *src, struct icc_node *dst)
 {
 	struct qcom_osm_l3_icc_provider *qp;
 	struct icc_provider *provider;
-	const struct qcom_icc_node *qn;
+	const struct qcom_osm_l3_node *qn;
 	struct icc_node *n;
 	unsigned int index;
 	u32 agg_peak = 0;
@@ -175,7 +175,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 
 	qn = src->data;
 	provider = src->provider;
-	qp = to_qcom_provider(provider);
+	qp = to_osm_l3_provider(provider);
 
 	list_for_each_entry(n, &provider->nodes, node_list)
 		provider->aggregate(n, 0, n->avg_bw, n->peak_bw,
@@ -208,10 +208,10 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 	u32 info, src, lval, i, prev_freq = 0, freq;
 	static unsigned long hw_rate, xo_rate;
 	struct qcom_osm_l3_icc_provider *qp;
-	const struct qcom_icc_desc *desc;
+	const struct qcom_osm_l3_desc *desc;
 	struct icc_onecell_data *data;
 	struct icc_provider *provider;
-	const struct qcom_icc_node **qnodes;
+	const struct qcom_osm_l3_node **qnodes;
 	struct icc_node *node;
 	size_t num_nodes;
 	struct clk *clk;
@@ -281,7 +281,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 
 	provider = &qp->provider;
 	provider->dev = &pdev->dev;
-	provider->set = qcom_icc_set;
+	provider->set = qcom_osm_l3_set;
 	provider->aggregate = icc_std_aggregate;
 	provider->xlate = of_icc_xlate_onecell;
 	INIT_LIST_HEAD(&provider->nodes);
@@ -303,7 +303,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 		}
 
 		node->name = qnodes[i]->name;
-		/* Cast away const and add it back in qcom_icc_set() */
+		/* Cast away const and add it back in qcom_osm_l3_set() */
 		node->data = (void *)qnodes[i];
 		icc_node_add(node, provider);
 
-- 
2.29.2

