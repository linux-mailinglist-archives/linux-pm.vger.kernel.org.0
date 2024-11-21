Return-Path: <linux-pm+bounces-17853-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 572959D4BF4
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 12:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26671F221EB
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 11:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5091D6191;
	Thu, 21 Nov 2024 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O/ji7CK+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45D91D6DA3;
	Thu, 21 Nov 2024 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188648; cv=none; b=lrnr4CnievmMML9VYNhIg/7PQa0DTLw//YjhIviAgvkJHx1vd3yBg8+KunIUj5RHxjdHXLo0K2rglyqxXRWFgrpRrZyHlf+GfHKsJdI0AMsun8uZnaueq4AbiUj6B76FQj4UC/016g4W9PP1jLXK06BqVRfoP5c2ZBt/yNp7iPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188648; c=relaxed/simple;
	bh=6sLXPWIejKvQEw1eeVLTnmPQxEFC7L5Cd3/ij44tG/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwPQawn6OTVjdZSSo1UYBcIICDTwSYTLw5vKd8odg6wPVt0rCyt+lInHCxe/qdqs9SO3eqFb3/Wa2BkYRC3KUI9/27foFUfk8/M7HAnDZOFeKIjrir0Gva0zSfUic1tbHoRXq7ZF6sysb0W/kFefK5f4qHUMxby9rLhDzSPciF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O/ji7CK+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL8nAGU005839;
	Thu, 21 Nov 2024 11:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dIwwfwmCAfmjiqqj3DfES17IS0Tmh/E1ac07zTgwftw=; b=O/ji7CK+FziO8+Ic
	ivyYFxrDY4xxQW7wR4a5eX+gcscMdAw1IB7IYYnojRdsYn295dI6xGT3vc/Ra/KT
	p5zv/i6evPfObRV+iQhn0w0gBAZF2zLmAgwGRcMxiDaiKB1XkExmQExgTw70XLqE
	k3hXuA/wghWf7kYY0PLLrJcuCH7W183+xNJU8sIhCxWDu1drWKAUfPjRLeyklLQT
	lzLfzV5zsTXET3A26n0GXPnuI/m+FUQJgIOzxla3P0uYjGPhL2DEPsql3AxZOoh2
	lpKPCjvMjSAX+uuiJp+N1/9fg3QXWVI57VmFaLGQZLGgvpmdXLMUTBB9SDvBOzgF
	Sl9mZQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y815kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 11:30:42 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ALBUfQl018424
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 11:30:42 GMT
Received: from 41ee23f3c785.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 21 Nov 2024 03:30:37 -0800
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>
CC: Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton
	<quic_mdtipton@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V5 3/4] interconnect: qcom: Add EPSS L3 support on SA8775P
Date: Thu, 21 Nov 2024 11:30:05 +0000
Message-ID: <20241121113006.28520-4-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241121113006.28520-1-quic_rlaggysh@quicinc.com>
References: <20241121113006.28520-1-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KGXUE29HVTNfNJ5fDbJjm-xpLWUSS5kb
X-Proofpoint-GUID: KGXUE29HVTNfNJ5fDbJjm-xpLWUSS5kb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411210090

Add Epoch Subsystem (EPSS) L3 interconnect provider on
SA8775P SoCs with multiple device support.

Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 drivers/interconnect/qcom/osm-l3.c | 85 ++++++++++++++++++++++--------
 1 file changed, 63 insertions(+), 22 deletions(-)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index 6a656ed44d49..a9405b7d251b 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -1,16 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/args.h>
 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/idr.h>
 #include <linux/interconnect-provider.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
@@ -34,9 +37,14 @@
 
 #define OSM_L3_MAX_LINKS		1
 
+#define OSM_L3_NODE_ID_START		10000
+#define OSM_NODE_NAME_SUFFIX_SIZE	10
+
 #define to_osm_l3_provider(_provider) \
 	container_of(_provider, struct qcom_osm_l3_icc_provider, provider)
 
+static DEFINE_IDA(osm_l3_id);
+
 struct qcom_osm_l3_icc_provider {
 	void __iomem *base;
 	unsigned int max_state;
@@ -55,46 +63,40 @@ struct qcom_osm_l3_icc_provider {
  */
 struct qcom_osm_l3_node {
 	const char *name;
-	u16 links[OSM_L3_MAX_LINKS];
+	const char *links[OSM_L3_MAX_LINKS];
 	u16 id;
 	u16 num_links;
 	u16 buswidth;
 };
 
 struct qcom_osm_l3_desc {
-	const struct qcom_osm_l3_node * const *nodes;
+	struct qcom_osm_l3_node * const *nodes;
 	size_t num_nodes;
 	unsigned int lut_row_size;
 	unsigned int reg_freq_lut;
 	unsigned int reg_perf_state;
 };
 
-enum {
-	OSM_L3_MASTER_NODE = 10000,
-	OSM_L3_SLAVE_NODE,
-};
-
-#define DEFINE_QNODE(_name, _id, _buswidth, ...)			\
-	static const struct qcom_osm_l3_node _name = {			\
+#define DEFINE_QNODE(_name, _buswidth, ...)				\
+	static struct qcom_osm_l3_node _name = {			\
 		.name = #_name,						\
-		.id = _id,						\
 		.buswidth = _buswidth,					\
 		.num_links = COUNT_ARGS(__VA_ARGS__),			\
-		.links = { __VA_ARGS__ },				\
+		__VA_OPT__(.links = { #__VA_ARGS__ })			\
 	}
 
-DEFINE_QNODE(osm_l3_master, OSM_L3_MASTER_NODE, 16, OSM_L3_SLAVE_NODE);
-DEFINE_QNODE(osm_l3_slave, OSM_L3_SLAVE_NODE, 16);
+DEFINE_QNODE(osm_l3_master, 16, osm_l3_slave);
+DEFINE_QNODE(osm_l3_slave, 16);
 
-static const struct qcom_osm_l3_node * const osm_l3_nodes[] = {
+static struct qcom_osm_l3_node * const osm_l3_nodes[] = {
 	[MASTER_OSM_L3_APPS] = &osm_l3_master,
 	[SLAVE_OSM_L3] = &osm_l3_slave,
 };
 
-DEFINE_QNODE(epss_l3_master, OSM_L3_MASTER_NODE, 32, OSM_L3_SLAVE_NODE);
-DEFINE_QNODE(epss_l3_slave, OSM_L3_SLAVE_NODE, 32);
+DEFINE_QNODE(epss_l3_master, 32, epss_l3_slave);
+DEFINE_QNODE(epss_l3_slave, 32);
 
-static const struct qcom_osm_l3_node * const epss_l3_nodes[] = {
+static struct qcom_osm_l3_node * const epss_l3_nodes[] = {
 	[MASTER_EPSS_L3_APPS] = &epss_l3_master,
 	[SLAVE_EPSS_L3_SHARED] = &epss_l3_slave,
 };
@@ -123,6 +125,19 @@ static const struct qcom_osm_l3_desc epss_l3_l3_vote = {
 	.reg_perf_state = EPSS_REG_L3_VOTE,
 };
 
+static u16 get_node_id_by_name(const char *node_name,
+			       const struct qcom_osm_l3_desc *desc)
+{
+	struct qcom_osm_l3_node *const *nodes = desc->nodes;
+	int i;
+
+	for (i = 0; i < desc->num_nodes; i++) {
+		if (!strcmp(nodes[i]->name, node_name))
+			return nodes[i]->id;
+	}
+	return 0;
+}
+
 static int qcom_osm_l3_set(struct icc_node *src, struct icc_node *dst)
 {
 	struct qcom_osm_l3_icc_provider *qp;
@@ -164,10 +179,11 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 	const struct qcom_osm_l3_desc *desc;
 	struct icc_onecell_data *data;
 	struct icc_provider *provider;
-	const struct qcom_osm_l3_node * const *qnodes;
+	struct qcom_osm_l3_node * const *qnodes;
 	struct icc_node *node;
 	size_t num_nodes;
 	struct clk *clk;
+	u64 addr;
 	int ret;
 
 	clk = clk_get(&pdev->dev, "xo");
@@ -188,6 +204,10 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 	if (!qp)
 		return -ENOMEM;
 
+	ret = of_property_read_reg(pdev->dev.of_node, 0, &addr, NULL);
+	if (ret)
+		return ret;
+
 	qp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(qp->base))
 		return PTR_ERR(qp->base);
@@ -242,8 +262,13 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 
 	icc_provider_init(provider);
 
+	/* Allocate unique id for qnodes */
+	for (i = 0; i < num_nodes; i++)
+		qnodes[i]->id = ida_alloc_min(&osm_l3_id, OSM_L3_NODE_ID_START, GFP_KERNEL);
+
 	for (i = 0; i < num_nodes; i++) {
-		size_t j;
+		char *node_name;
+		size_t j, len;
 
 		node = icc_node_create(qnodes[i]->id);
 		if (IS_ERR(node)) {
@@ -251,13 +276,29 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 			goto err;
 		}
 
-		node->name = qnodes[i]->name;
+		/* len = strlen(node->name) + @ + 8 (base-address) + NULL */
+		len = strlen(qnodes[i]->name) + OSM_NODE_NAME_SUFFIX_SIZE;
+		node_name = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
+		if (!node_name) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		snprintf(node_name, len, "%s@%08llx", qnodes[i]->name, addr);
+		node->name = node_name;
+
 		/* Cast away const and add it back in qcom_osm_l3_set() */
 		node->data = (void *)qnodes[i];
 		icc_node_add(node, provider);
 
-		for (j = 0; j < qnodes[i]->num_links; j++)
-			icc_link_create(node, qnodes[i]->links[j]);
+		for (j = 0; j < qnodes[i]->num_links; j++) {
+			u16 link_node_id = get_node_id_by_name(qnodes[i]->links[j], desc);
+
+			if (link_node_id)
+				icc_link_create(node, link_node_id);
+			else
+				goto err;
+		}
 
 		data->nodes[i] = node;
 	}
-- 
2.39.2


