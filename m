Return-Path: <linux-pm+bounces-20273-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC69A0A4A1
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 17:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424A316ABDB
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 16:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB891B4126;
	Sat, 11 Jan 2025 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JHcXGNMA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DD51B414A;
	Sat, 11 Jan 2025 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736612105; cv=none; b=Wq4VGRlQ7q+FXas0ZwPWE1mc2usLd4HgtAkf+5YXy3trGcVk0AJ7r5V9V4oUf+WIieyxh/dwN/lUOVpgA+w+4VjXE6cCkwXwrwim8loqURgwzWEMiWqc+VlmbiOXimR1eKw9C7L2v7LKy2HdNdEl5Boe5XlYQuxKDietHCQKze0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736612105; c=relaxed/simple;
	bh=BhLk/fX3apcMlxHiMEum09lskm6kBKq+hPKAUJcWBOw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pc56PSJ2DaUCGOQo2tsuM4KYzyv2RsQHmbZHrvyeC1XZfpPD6SJ9KisVEtE/cOohR8a8gVfJXfJ2CXu3fEzJaUu4Y2HsGqcmFztqzodgKSivyI3hGyiHP2Xc2gA0pmF/VxFL/FRY/jfG4SQFqPpBacBTIjmof3sANqruv8bxb5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JHcXGNMA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50BDv1sp006553;
	Sat, 11 Jan 2025 16:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U4Q9PkqYazYoStc8iI4YjdDVKZ56sNQArTqJBMEpWTA=; b=JHcXGNMApsGJvnJB
	j9DO2AXYo5VPv+6rSGZVZhpr9yB0qU5BHERrTFnzlqKhYB8i5ST/P8tTC5BeD64r
	fgOEb/V+eT3vyVNyyANkU1Wsmo84/ZzAgwIelkI8fSbdHt3OqojlhMN6ai06wpVa
	2PjQ1y81hfJbIv5+L/3kBRurHrMGPhmDZROLoQSgt/Bv4DWQ28DuVLixi5z681Dm
	8fD8r8hJa7IWOZl2nI+qkvxHwn+788VNHPnldFf5AKttvRz2ClHWdjilaa+F9dmR
	K+imwA3NRDB9ZrYbz7GXfexyIEcDyjQnEN5aFXIw5Pt0UDKjhi6mRRpwMsZFZJwF
	URDxxA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 443hx70rf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Jan 2025 16:15:00 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50BGExhO012060
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Jan 2025 16:14:59 GMT
Received: from 4206f847eb12.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 11 Jan 2025 08:14:55 -0800
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        "Mike
 Tipton" <mdptipton@quicinc.com>,
        Vivek Aknurwar <viveka@quicinc.com>
CC: Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V7 2/5] interconnect: qcom: Add multidev EPSS L3 support
Date: Sat, 11 Jan 2025 16:14:26 +0000
Message-ID: <20250111161429.51-3-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250111161429.51-1-quic_rlaggysh@quicinc.com>
References: <20250111161429.51-1-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-GUID: AYXkRSNb30QssqBuiVC23hoKYxfdcbtC
X-Proofpoint-ORIG-GUID: AYXkRSNb30QssqBuiVC23hoKYxfdcbtC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 clxscore=1015 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501110138

EPSS on SA8775P has two instances which requires creation of two device
nodes with different compatible and device data because of unique
icc node id and name limitation in interconnect framework.
Add multidevice support to osm-l3 code to get unique node id from icc
framework.

Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 drivers/interconnect/qcom/osm-l3.c | 91 ++++++++++++++++++++++--------
 1 file changed, 67 insertions(+), 24 deletions(-)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index 6a656ed44d49..8e98d1c9a840 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/args.h>
@@ -11,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
@@ -34,6 +36,9 @@
 
 #define OSM_L3_MAX_LINKS		1
 
+#define OSM_L3_NODE_ID_START		10000
+#define OSM_NODE_NAME_SUFFIX_SIZE	10
+
 #define to_osm_l3_provider(_provider) \
 	container_of(_provider, struct qcom_osm_l3_icc_provider, provider)
 
@@ -55,46 +60,40 @@ struct qcom_osm_l3_icc_provider {
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
@@ -123,6 +122,19 @@ static const struct qcom_osm_l3_desc epss_l3_l3_vote = {
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
@@ -164,10 +176,11 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
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
@@ -188,6 +201,10 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 	if (!qp)
 		return -ENOMEM;
 
+	ret = of_property_read_reg(pdev->dev.of_node, 0, &addr, NULL);
+	if (ret)
+		return ret;
+
 	qp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(qp->base))
 		return PTR_ERR(qp->base);
@@ -242,26 +259,51 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 
 	icc_provider_init(provider);
 
+	/* create icc nodes */
 	for (i = 0; i < num_nodes; i++) {
-		size_t j;
+		char *node_name;
+		size_t len;
 
-		node = icc_node_create(qnodes[i]->id);
+		node = icc_node_create_alloc_id(OSM_L3_NODE_ID_START);
 		if (IS_ERR(node)) {
 			ret = PTR_ERR(node);
 			goto err;
 		}
+		qnodes[i]->id = node->id;
+
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
 
-		node->name = qnodes[i]->name;
 		/* Cast away const and add it back in qcom_osm_l3_set() */
 		node->data = (void *)qnodes[i];
 		icc_node_add(node, provider);
 
-		for (j = 0; j < qnodes[i]->num_links; j++)
-			icc_link_create(node, qnodes[i]->links[j]);
-
 		data->nodes[i] = node;
 	}
 
+	/* create links in topolgy */
+	for (i = 0; i < num_nodes; i++) {
+		size_t j;
+
+		node = data->nodes[i];
+		for (j = 0; j < qnodes[i]->num_links; j++) {
+			u16 link_node_id = get_node_id_by_name(qnodes[i]->links[j], desc);
+
+			if (link_node_id)
+				icc_link_create(node, link_node_id);
+			else
+				goto err;
+		}
+	}
+
 	ret = icc_provider_register(provider);
 	if (ret)
 		goto err;
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


