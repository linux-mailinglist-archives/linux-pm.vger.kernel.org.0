Return-Path: <linux-pm+bounces-17282-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8029F9C3209
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2024 13:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8361C20999
	for <lists+linux-pm@lfdr.de>; Sun, 10 Nov 2024 12:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E14315747D;
	Sun, 10 Nov 2024 12:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="efR+vi3M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97EA156F4A;
	Sun, 10 Nov 2024 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731242353; cv=none; b=DTDLwkmQJ35PjE7peByAN6jltaKp1jFM5Ex6LsJXzLHrU3ikJP/AU5Sts5YgkJxitSVqYKZjVpu1of3TorCIrih63GM5GoQXQCCiBDZ+AeAHda2ayQAg0yzha95O7SZ0GRhzf6XWkehBoWpTpKefSSCpaIPM/RlglL4oKKbzlyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731242353; c=relaxed/simple;
	bh=uSoI4Jgvt06nYPkjtiT4W5arjd9aCbBCnRVFF/s+4is=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WudlbCqc9rrAZfcYKCV5bObFDV3J8OX8FyOKXq4HZ2D3sywj1mTP3XZQCddDz77i3nRTg41GsqHZXHwLZVJGbDMkqqpJqVWyOkLX5zG3qior/pc1dwsjuNcKylZTf8kQA0yDzgqvOgCXDzYfm0EoTsnU3Khnk09Z34+U6+qOlNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=efR+vi3M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AABZ11i006873;
	Sun, 10 Nov 2024 12:38:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/7lDrT77xJWCw71haLsEqwESMwIuPb6n7MPKD5Hp3Qw=; b=efR+vi3M/GOyM1cC
	cU8T10Br+SL7SFNN9ZrUUZopCk5oiuzpe3S9ABb8RrF/K7vo/l5LAIufiRzO7gy1
	yQsAjF1h4+E+T34jiCoMJKH9eTTJgKGXxWZXx07MUgQ5eZ1o5ZKdT3to1F5u3ODh
	JCC8aLCRsJgg8ArnCm8tPCQX7RC50i+pEQXSOwcH88wMt3YUpRN/cy0XZlVRcZaX
	8pN39/gtAMZgTm7q4eNuwUy2lYEb+IDRiqDfdYwIXhyu0jWSDIKSLLmG9TzD4UdD
	YhHeclBkEMEOW9U+/oIZ0mq/4JODG2cdNg7zSGuxyKY70kD/2uZ6GhJgS6b+2g5Q
	isEhlg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42sw3m2863-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 12:38:55 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AACcsde012840
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 12:38:54 GMT
Received: from 7b2794c915f4.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 10 Nov 2024 04:38:51 -0800
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>
CC: Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 3/3] interconnect: qcom: Add EPSS L3 support on SA8775P
Date: Sun, 10 Nov 2024 12:38:25 +0000
Message-ID: <20241110123825.28783-4-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241110123825.28783-1-quic_rlaggysh@quicinc.com>
References: <20241110123825.28783-1-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: o5xvdAERFZFpQvrET-j0IOMIYJ9c3Sb_
X-Proofpoint-ORIG-GUID: o5xvdAERFZFpQvrET-j0IOMIYJ9c3Sb_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411100113

Add Epoch Subsystem (EPSS) L3 interconnect provider support on
SA8775P SoCs.

The EPSS instance in SA8775P uses PERF_STATE register instead of
REG_L3_VOTE to scale L3 clocks. Add new generic compatible
"qcom,epss-l3-perf" for PERF_STATE register based L3 scaling.

Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 drivers/interconnect/qcom/osm-l3.c | 87 ++++++++++++++++++++++--------
 1 file changed, 65 insertions(+), 22 deletions(-)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index 6a656ed44d49..285afaa1f61e 100644
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
@@ -277,6 +318,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 
 static const struct of_device_id osm_l3_of_match[] = {
 	{ .compatible = "qcom,epss-l3", .data = &epss_l3_l3_vote },
+	{ .compatible = "qcom,epss-l3-perf", .data = &epss_l3_perf_state },
 	{ .compatible = "qcom,osm-l3", .data = &osm_l3 },
 	{ .compatible = "qcom,sc7180-osm-l3", .data = &osm_l3 },
 	{ .compatible = "qcom,sc7280-epss-l3", .data = &epss_l3_perf_state },
@@ -284,6 +326,7 @@ static const struct of_device_id osm_l3_of_match[] = {
 	{ .compatible = "qcom,sm8150-osm-l3", .data = &osm_l3 },
 	{ .compatible = "qcom,sc8180x-osm-l3", .data = &osm_l3 },
 	{ .compatible = "qcom,sm8250-epss-l3", .data = &epss_l3_perf_state },
+	{ .compatible = "qcom,sa8775p-epss-l3", .data = &epss_l3_perf_state },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, osm_l3_of_match);
-- 
2.39.2


