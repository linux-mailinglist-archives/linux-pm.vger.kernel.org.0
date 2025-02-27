Return-Path: <linux-pm+bounces-23091-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E497EA4839C
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240303B6C93
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF2C1B3943;
	Thu, 27 Feb 2025 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F5SNWexz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E131819CC11;
	Thu, 27 Feb 2025 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671583; cv=none; b=ZYMIJ+2Ov4ZsblHfyWGXgC8h6EyDJ0Pc9TnaNCiLsu7u6hTpwLtCWxAr3iIewBPuAKD51Md3omro3C/o+hC9y8kviimuWlpFOdBr+AHgJbElLCgKC6cjX9/MGdIad/4KpVeZHLobGZ3b7jm7H/tM5QnWZ2X9RDCODUvWLi6nOYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671583; c=relaxed/simple;
	bh=Fe+hmUMSUm1Wb1Qlt9IInUE6kiddAWWGcBwQ/MjuNxE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGHtKV3BcDk7RgHmtLlEWWu/MRUTRigWKhDQYzVEnSCG9Et+zhnVUEhuOF1r7QwM5npmZnOtKQxwjDooxZX4jdFYvMQHFKsxr4NOtx7n+ou2FzWkK1IhGKfPLkT1rl7sfiEnO7YmQfdV52QKkUhX6oeYhPCRzEFBXID1WJ34WOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F5SNWexz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R9l18M017273;
	Thu, 27 Feb 2025 15:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3PfjNi9wOO2PgcAaKMRJvCPwyRhtcONDvykIYvjrwqI=; b=F5SNWexzkrykCgBn
	Al+Yq9tIj8BFAwwo9jkHXVy78W0OwqTP0bkucFN88tKXXlnKqtDUveyoLC53luLg
	75B7QPG4Ek7f/0wcXWSgKXrg2aLQgNjE41skb3icYSJjoAsPPUjRIIYgWJ5RpNvd
	X3yuMjd+kX0Dg4hHBtXip6Hxsw2d8KF79YLnFqW73d1QVsaCHJasgUOt/JSvpOo+
	nCaiQUTHVJuHjiFU6/dOo0qJHMTZ0x35ghxlbKgzEFBZBZaQKy82ZxufAvcQJNNJ
	qq66xKFHtdZWqMIRjvdkseStEXNRwPDdF89o+omopPgwBWXEpu6rOSi2t0xOXTpM
	cnsBCg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 452nqkh3r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 15:52:58 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51RFqwfS011238
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 15:52:58 GMT
Received: from 0d558f49c4ed.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 27 Feb 2025 07:52:53 -0800
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>
CC: Odelu Kukatla <quic_okukatla@quicinc.com>,
        Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>,
        Mike Tipton <mdtipton@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Raviteja Laggyshetty
	<quic_rlaggysh@quicinc.com>
Subject: [PATCH V9 3/7] interconnect: qcom: Add multidev EPSS L3 support
Date: Thu, 27 Feb 2025 15:52:09 +0000
Message-ID: <20250227155213.404-4-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227155213.404-1-quic_rlaggysh@quicinc.com>
References: <20250227155213.404-1-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-ORIG-GUID: uudQzO7jsB-sQ-j8Nyu12c8VzVt77U2P
X-Proofpoint-GUID: uudQzO7jsB-sQ-j8Nyu12c8VzVt77U2P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270120

EPSS on SA8775P has two instances, necessitating the creation of two
device nodes with different compatibles due to the unique ICC node ID
and name limitations in the interconnect framework. Add multidevice
support for the OSM-L3 provider to dynamically obtain unique node IDs
and register with the framework.
EPSS topology includes a single master-slave pair within the same
provider, the node linking logic is simplified by directly connecting
the master node to the slave node.

Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 drivers/interconnect/qcom/osm-l3.c | 37 ++++++++++--------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index 6a656ed44d49..a9dacc4b7f2e 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/args.h>
@@ -48,16 +49,10 @@ struct qcom_osm_l3_icc_provider {
 /**
  * struct qcom_osm_l3_node - Qualcomm specific interconnect nodes
  * @name: the node name used in debugfs
- * @links: an array of nodes where we can go next while traversing
- * @id: a unique node identifier
- * @num_links: the total number of @links
  * @buswidth: width of the interconnect between a node and the bus
  */
 struct qcom_osm_l3_node {
 	const char *name;
-	u16 links[OSM_L3_MAX_LINKS];
-	u16 id;
-	u16 num_links;
 	u16 buswidth;
 };
 
@@ -69,30 +64,22 @@ struct qcom_osm_l3_desc {
 	unsigned int reg_perf_state;
 };
 
-enum {
-	OSM_L3_MASTER_NODE = 10000,
-	OSM_L3_SLAVE_NODE,
-};
-
-#define DEFINE_QNODE(_name, _id, _buswidth, ...)			\
+#define DEFINE_QNODE(_name, _buswidth)					\
 	static const struct qcom_osm_l3_node _name = {			\
 		.name = #_name,						\
-		.id = _id,						\
 		.buswidth = _buswidth,					\
-		.num_links = COUNT_ARGS(__VA_ARGS__),			\
-		.links = { __VA_ARGS__ },				\
 	}
 
-DEFINE_QNODE(osm_l3_master, OSM_L3_MASTER_NODE, 16, OSM_L3_SLAVE_NODE);
-DEFINE_QNODE(osm_l3_slave, OSM_L3_SLAVE_NODE, 16);
+DEFINE_QNODE(osm_l3_master, 16);
+DEFINE_QNODE(osm_l3_slave, 16);
 
 static const struct qcom_osm_l3_node * const osm_l3_nodes[] = {
 	[MASTER_OSM_L3_APPS] = &osm_l3_master,
 	[SLAVE_OSM_L3] = &osm_l3_slave,
 };
 
-DEFINE_QNODE(epss_l3_master, OSM_L3_MASTER_NODE, 32, OSM_L3_SLAVE_NODE);
-DEFINE_QNODE(epss_l3_slave, OSM_L3_SLAVE_NODE, 32);
+DEFINE_QNODE(epss_l3_master, 32);
+DEFINE_QNODE(epss_l3_slave, 32);
 
 static const struct qcom_osm_l3_node * const epss_l3_nodes[] = {
 	[MASTER_EPSS_L3_APPS] = &epss_l3_master,
@@ -242,10 +229,9 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 
 	icc_provider_init(provider);
 
+	/* Create nodes */
 	for (i = 0; i < num_nodes; i++) {
-		size_t j;
-
-		node = icc_node_create(qnodes[i]->id);
+		node = icc_node_create(ALLOC_DYN_ID);
 		if (IS_ERR(node)) {
 			ret = PTR_ERR(node);
 			goto err;
@@ -256,12 +242,12 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 		node->data = (void *)qnodes[i];
 		icc_node_add(node, provider);
 
-		for (j = 0; j < qnodes[i]->num_links; j++)
-			icc_link_create(node, qnodes[i]->links[j]);
-
 		data->nodes[i] = node;
 	}
 
+	/* Create link */
+	icc_link_create(data->nodes[MASTER_OSM_L3_APPS], data->nodes[SLAVE_OSM_L3]->id);
+
 	ret = icc_provider_register(provider);
 	if (ret)
 		goto err;
@@ -278,6 +264,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 static const struct of_device_id osm_l3_of_match[] = {
 	{ .compatible = "qcom,epss-l3", .data = &epss_l3_l3_vote },
 	{ .compatible = "qcom,osm-l3", .data = &osm_l3 },
+	{ .compatible = "qcom,sa8775p-epss-l3", .data = &epss_l3_perf_state },
 	{ .compatible = "qcom,sc7180-osm-l3", .data = &osm_l3 },
 	{ .compatible = "qcom,sc7280-epss-l3", .data = &epss_l3_perf_state },
 	{ .compatible = "qcom,sdm845-osm-l3", .data = &osm_l3 },
-- 
2.43.0


