Return-Path: <linux-pm+bounces-21431-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 536ABA29911
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 19:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A16B18819E4
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 18:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32CC2054F9;
	Wed,  5 Feb 2025 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DaL2H+yZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A4B2066D8;
	Wed,  5 Feb 2025 18:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738780108; cv=none; b=UbqKP0vCkJuWSDAsgpyvjpNr3oaFaebCiOWHjnCuHh9sxBZnU+W2mg3LI/OASZjs4kBhCD30SkGBvgbusXB1/gYjGmnBk8b0wLUDweQK/b8wa8hzWJcuNUjzgS1H0hrMj6BnEoqps07sy3zOgEmj5FAegR0stt2uRFHUuhFO4Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738780108; c=relaxed/simple;
	bh=FNQ7IxtxT2minTzs/B2LDFRqdrLR0PnL2732GPTqL5o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZ6/XR3sG6uVuB64ihTygAR7w0s5GG/eSSciI0emoNY/pln7Y1mGDKEElktnnX+zJd2SamUwVgEdZBeUVm/kfMUMhfZhASa4vZkvein5PLDm1m9aPBQWl7fOx+krLepCGfFWTz3shfmA+I1MEtHDNuKjV71xBJVmflUhO/5cVLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DaL2H+yZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515C4Wp7015605;
	Wed, 5 Feb 2025 18:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lf0Ybz47XKLkEdFkpbvkc19pblW2c8brE5uH7aAxhTU=; b=DaL2H+yZjsZuIxdV
	n6Z4igKh6aPdyvWOiIYOC+tw433vEHY9Jwp9CgU9whxQqcghP4OPxGWug1mOBx/d
	jzUuLcCy4Eb6fLijGwyAJq1Ir8BBBoIXO/n9cxJBkWKHqgwEd2WZmPt/+SPC2ddP
	tl2euyWp9DcnxLrxQdJxOtF8VxPdlW7ts4ifAruq676ExaVcI+JF5eG7DOsGymSk
	+pMUfC5E3nsQ9VlgKHtH2T1ix4Y2bu5vwsvSe14Ps8DtIf3FKvjbIt7CwKDb2Jn6
	azWoxN0VbxuINtBaC2DI2l8GiPBqy3UY8GNAtGPrUG50c98G41u2mDzxns2qq5Ug
	3F8iLA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44m7p38ye2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 18:28:22 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 515ISL4t012244
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Feb 2025 18:28:21 GMT
Received: from c194c8e2f407.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 5 Feb 2025 10:28:17 -0800
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
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        "Andrew Halaney" <ahalaney@redhat.com>,
        Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V8 3/7] interconnect: qcom: Add multidev EPSS L3 support
Date: Wed, 5 Feb 2025 18:27:39 +0000
Message-ID: <20250205182743.915-4-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250205182743.915-1-quic_rlaggysh@quicinc.com>
References: <20250205182743.915-1-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-GUID: GC3RFZHm9o6tSrkfQ7AEmZAvdFhulNTD
X-Proofpoint-ORIG-GUID: GC3RFZHm9o6tSrkfQ7AEmZAvdFhulNTD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502050141

EPSS on SA8775P has two instances, necessitating the creation of two
device nodes with different compatibles due to the unique ICC node ID
and name limitations in the interconnect framework. Add multidevice
support for the OSM-L3 provider to dynamically obtain unique node IDs
and register with the framework.

Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 drivers/interconnect/qcom/osm-l3.c | 46 +++++++++++++++++-------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index 6a656ed44d49..da2d82700b5a 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/args.h>
@@ -33,6 +34,7 @@
 #define EPSS_REG_PERF_STATE		0x320
 
 #define OSM_L3_MAX_LINKS		1
+#define ALLOC_DYN_ID			-1
 
 #define to_osm_l3_provider(_provider) \
 	container_of(_provider, struct qcom_osm_l3_icc_provider, provider)
@@ -55,46 +57,40 @@ struct qcom_osm_l3_icc_provider {
  */
 struct qcom_osm_l3_node {
 	const char *name;
-	u16 links[OSM_L3_MAX_LINKS];
-	u16 id;
+	struct qcom_osm_l3_node *links[OSM_L3_MAX_LINKS];
+	int id;
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
+#define DEFINE_QNODE(_name, _buswidth, ...)			\
+	static struct qcom_osm_l3_node _name = {			\
 		.name = #_name,						\
-		.id = _id,						\
 		.buswidth = _buswidth,					\
 		.num_links = COUNT_ARGS(__VA_ARGS__),			\
 		.links = { __VA_ARGS__ },				\
 	}
 
-DEFINE_QNODE(osm_l3_master, OSM_L3_MASTER_NODE, 16, OSM_L3_SLAVE_NODE);
-DEFINE_QNODE(osm_l3_slave, OSM_L3_SLAVE_NODE, 16);
+DEFINE_QNODE(osm_l3_slave, 16);
+DEFINE_QNODE(osm_l3_master, 16, &osm_l3_slave);
 
-static const struct qcom_osm_l3_node * const osm_l3_nodes[] = {
+static struct qcom_osm_l3_node * const osm_l3_nodes[] = {
 	[MASTER_OSM_L3_APPS] = &osm_l3_master,
 	[SLAVE_OSM_L3] = &osm_l3_slave,
 };
 
-DEFINE_QNODE(epss_l3_master, OSM_L3_MASTER_NODE, 32, OSM_L3_SLAVE_NODE);
-DEFINE_QNODE(epss_l3_slave, OSM_L3_SLAVE_NODE, 32);
+DEFINE_QNODE(epss_l3_slave, 32);
+DEFINE_QNODE(epss_l3_master, 32, &epss_l3_slave);
 
-static const struct qcom_osm_l3_node * const epss_l3_nodes[] = {
+static struct qcom_osm_l3_node * const epss_l3_nodes[] = {
 	[MASTER_EPSS_L3_APPS] = &epss_l3_master,
 	[SLAVE_EPSS_L3_SHARED] = &epss_l3_slave,
 };
@@ -164,7 +160,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 	const struct qcom_osm_l3_desc *desc;
 	struct icc_onecell_data *data;
 	struct icc_provider *provider;
-	const struct qcom_osm_l3_node * const *qnodes;
+	struct qcom_osm_l3_node * const *qnodes;
 	struct icc_node *node;
 	size_t num_nodes;
 	struct clk *clk;
@@ -242,6 +238,10 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 
 	icc_provider_init(provider);
 
+	/*Initialize IDs to ALLOC_DYN_ID to indicate dynamic id allocation*/
+	for (i = 0; i < num_nodes; i++)
+		qnodes[i]->id = ALLOC_DYN_ID;
+
 	for (i = 0; i < num_nodes; i++) {
 		size_t j;
 
@@ -250,14 +250,19 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 			ret = PTR_ERR(node);
 			goto err;
 		}
+		qnodes[i]->id = node->id;
 
 		node->name = qnodes[i]->name;
 		/* Cast away const and add it back in qcom_osm_l3_set() */
 		node->data = (void *)qnodes[i];
 		icc_node_add(node, provider);
 
-		for (j = 0; j < qnodes[i]->num_links; j++)
-			icc_link_create(node, qnodes[i]->links[j]);
+		for (j = 0; j < qnodes[i]->num_links; j++) {
+			struct qcom_osm_l3_node *link_node = qnodes[i]->links[j];
+
+			icc_link_create(node, link_node->id);
+			link_node->id = (node->links[node->num_links - 1])->id;
+		}
 
 		data->nodes[i] = node;
 	}
@@ -278,6 +283,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 static const struct of_device_id osm_l3_of_match[] = {
 	{ .compatible = "qcom,epss-l3", .data = &epss_l3_l3_vote },
 	{ .compatible = "qcom,osm-l3", .data = &osm_l3 },
+	{ .compatible = "qcom,sa8775p-epss-l3", .data = &epss_l3_perf_state },
 	{ .compatible = "qcom,sc7180-osm-l3", .data = &osm_l3 },
 	{ .compatible = "qcom,sc7280-epss-l3", .data = &epss_l3_perf_state },
 	{ .compatible = "qcom,sdm845-osm-l3", .data = &osm_l3 },
-- 
2.39.2


