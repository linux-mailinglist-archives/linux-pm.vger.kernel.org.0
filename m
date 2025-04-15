Return-Path: <linux-pm+bounces-25450-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6779A898D1
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 11:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47EB440211
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 09:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B05C28E5F9;
	Tue, 15 Apr 2025 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lEyZcSo3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5706C28E5F4;
	Tue, 15 Apr 2025 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744710873; cv=none; b=qjaWZba/m0giCqjnBapmp4TlAj93EM3wgGcTn5GFvOW0zmAE+BScGXQ1DSMlG9uqOiMb/mSwXCe4kMDULbd8DJhEEgdVj41MeNcQhzU+IYtImtSoZXwuBynER4nXKXS/P/Qet9Fxx87H/sGdSlpGM9U75oGrMqVaTJtTEJGTgwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744710873; c=relaxed/simple;
	bh=LlnCxcKMkGAQKZJVH5xPgDSSmvGo45pWTFmC1ifQflY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0tiUhjGqU+R00o40wJj7suVQCoe60levmenJBjYrTho1veFQuICwDewG6F3ICJmQu/n5uA9jCk8dQYsMfTNedtzanqdGjzd+i1HWBKaVA6Fhh9CnVWCiH3hm0f6/dqJToUOH4OmUyRQ37akij3w5KVgi+wwRoWwRzDCzIi1kwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lEyZcSo3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F8tGWR018885;
	Tue, 15 Apr 2025 09:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WxPcUxkOwCl8Dt0np4zh9lOGn7YPPSGePTcgh3NMbVM=; b=lEyZcSo3ovzXm7vy
	Ls+nlIj4lSgDPbXX+muNZL6dKz2vh6ovl9VEA3pKp2R0SBeRiBTEYAyHoeyynRSa
	WaeweqcQcmFqteRbtZAmDP0qfFKTLoztTlkxeHDKNWKO3sjnfWhwUjm6qIiQmqee
	TJqrvgQItnT+qBygyw1lSwEN2wNk+ZHx9fIavpkOmOp5iLCBNGmkb74ubFiEnIQZ
	vmh+oH9Dz5JUjuSVUgJGhDW8CjOmGaeLqeXORgG0GcaDIfuJXPWFB6YFxubzAFiD
	nj2DIcV6Kcg/eqpV4D4Dq8hNK8jUjFeRdNu+Ltq5rMR7RFTv0emumgZcgRBoP9nz
	0DqlmQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfgjfhvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 09:54:28 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53F9sRat021819
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 09:54:27 GMT
Received: from 087e9057f447.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Apr 2025 02:54:23 -0700
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
        Dmitry Baryshkov
	<dmitry.baryshkov@oss.qualcomm.com>,
        Mike Tipton <mdtipton@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Raviteja
 Laggyshetty" <quic_rlaggysh@quicinc.com>
Subject: [PATCH V11 3/7] interconnect: qcom: Add multidev EPSS L3 support
Date: Tue, 15 Apr 2025 09:53:39 +0000
Message-ID: <20250415095343.32125-4-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415095343.32125-1-quic_rlaggysh@quicinc.com>
References: <20250415095343.32125-1-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-GUID: zZnvcYkXAmRwlfhqyTmLfoguCx83BFR4
X-Proofpoint-ORIG-GUID: zZnvcYkXAmRwlfhqyTmLfoguCx83BFR4
X-Authority-Analysis: v=2.4 cv=Cve/cm4D c=1 sm=1 tr=0 ts=67fe2cd4 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=1_MGGdC0Z1Sj5Se9BHcA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150069

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
 drivers/interconnect/qcom/osm-l3.c | 38 ++++++++++--------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index 6a656ed44d49..baecbf2533f7 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/args.h>
@@ -32,8 +33,6 @@
 #define EPSS_REG_FREQ_LUT		0x100
 #define EPSS_REG_PERF_STATE		0x320
 
-#define OSM_L3_MAX_LINKS		1
-
 #define to_osm_l3_provider(_provider) \
 	container_of(_provider, struct qcom_osm_l3_icc_provider, provider)
 
@@ -48,16 +47,10 @@ struct qcom_osm_l3_icc_provider {
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
 
@@ -69,30 +62,22 @@ struct qcom_osm_l3_desc {
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
+DEFINE_QNODE(osm_l3_slave, 16);
+DEFINE_QNODE(osm_l3_master, 16);
 
 static const struct qcom_osm_l3_node * const osm_l3_nodes[] = {
 	[MASTER_OSM_L3_APPS] = &osm_l3_master,
 	[SLAVE_OSM_L3] = &osm_l3_slave,
 };
 
-DEFINE_QNODE(epss_l3_master, OSM_L3_MASTER_NODE, 32, OSM_L3_SLAVE_NODE);
-DEFINE_QNODE(epss_l3_slave, OSM_L3_SLAVE_NODE, 32);
+DEFINE_QNODE(epss_l3_slave, 32);
+DEFINE_QNODE(epss_l3_master, 32);
 
 static const struct qcom_osm_l3_node * const epss_l3_nodes[] = {
 	[MASTER_EPSS_L3_APPS] = &epss_l3_master,
@@ -242,10 +227,10 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 
 	icc_provider_init(provider);
 
+	/* Create nodes */
 	for (i = 0; i < num_nodes; i++) {
-		size_t j;
+		node = icc_node_create_dyn();
 
-		node = icc_node_create(qnodes[i]->id);
 		if (IS_ERR(node)) {
 			ret = PTR_ERR(node);
 			goto err;
@@ -256,12 +241,12 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 		node->data = (void *)qnodes[i];
 		icc_node_add(node, provider);
 
-		for (j = 0; j < qnodes[i]->num_links; j++)
-			icc_link_create(node, qnodes[i]->links[j]);
-
 		data->nodes[i] = node;
 	}
 
+	/* Create link */
+	icc_link_nodes(data->nodes[MASTER_OSM_L3_APPS], &data->nodes[SLAVE_OSM_L3]);
+
 	ret = icc_provider_register(provider);
 	if (ret)
 		goto err;
@@ -278,6 +263,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 static const struct of_device_id osm_l3_of_match[] = {
 	{ .compatible = "qcom,epss-l3", .data = &epss_l3_l3_vote },
 	{ .compatible = "qcom,osm-l3", .data = &osm_l3 },
+	{ .compatible = "qcom,sa8775p-epss-l3", .data = &epss_l3_perf_state },
 	{ .compatible = "qcom,sc7180-osm-l3", .data = &osm_l3 },
 	{ .compatible = "qcom,sc7280-epss-l3", .data = &epss_l3_perf_state },
 	{ .compatible = "qcom,sdm845-osm-l3", .data = &osm_l3 },
-- 
2.43.0


