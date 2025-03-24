Return-Path: <linux-pm+bounces-24475-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFE2A6E260
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 19:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12984166C4B
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 18:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A6226561D;
	Mon, 24 Mar 2025 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V7sw4Cy9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E9F265610;
	Mon, 24 Mar 2025 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742841186; cv=none; b=RhQQ0vVDUXpQ2N7LYCVhHbNTEKxgxE2A6TXS0n9xK4kRh62//8a8wGV1vWe2pS4n/ONVeNQKPzi8e42uUXVxPWcxiJHR/tO2ay71Lc8KLZYw22qUwAWbomkwWnEsnvBdSBIG4tZXkK738z5DlstNJZyr7RWmgijbOxW/szTgHSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742841186; c=relaxed/simple;
	bh=DzrYWQ4LnhNZBZCVU8N/9jUuzG0vmYZApCV5u7K1bMk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nteIyQq9YmQxZIgjuJgzltmE2QQJZ2UgCzx3yLrq59Z6vLnuo6tN8LJw1Mlg5+Me25/RVzFkWh7VfV8xjv4MghahGMlr7j2KH/6Qbtl+BZBBUoHyjSAkFIeUkJGuddrl/N6pX3HcN9fB6hbsKmKp+uQZdjylepo8bpzXFCI7iLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V7sw4Cy9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O9PLhI025884;
	Mon, 24 Mar 2025 18:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ImMObG6mn54eM1KudSgYFZG7xvEkPDNn62WUJoLtcwY=; b=V7sw4Cy9tQi/PTJ4
	NSxm59i7Jeik5bIYhJgYTQ0wnb8+idKryfr7kGxvj0sxhhKixPiTAmom15nZ6n0Q
	Rt4sJeKHxDfYGdlGWki116kpgciv9C1aYEMR09v2QOoQKuox342jPXD3oqsx6gtG
	bRM1utyDl3G/c5t4IFB0+sOB4sdAi55XHy0LkPx6cq0+QxthYkZjNHniSCNJwU07
	cd68TQbvSbIaRzpWOo7UMyFIp9Nh3BAkNU2XswRku+s+Xl/nfJ8+nEc/kZ8IMvwu
	kVoeoOyu7eqyscIHJ4xQRlk1ZPDAf1OYq3lOeE0n7scoIcc4ieXO1GxhWX8K/17X
	YNRPKA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hjjnnh17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 18:33:00 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52OIWxrE000927
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 18:32:59 GMT
Received: from 6cb0ec70778b.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 24 Mar 2025 11:32:54 -0700
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Raviteja
 Laggyshetty" <quic_rlaggysh@quicinc.com>,
        Odelu Kukatla
	<quic_okukatla@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
CC: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V10 4/7] interconnect: qcom: icc-rpmh: Add dynamic icc node id support
Date: Mon, 24 Mar 2025 18:32:00 +0000
Message-ID: <20250324183203.30127-5-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324183203.30127-1-quic_rlaggysh@quicinc.com>
References: <20250324183203.30127-1-quic_rlaggysh@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=fNc53Yae c=1 sm=1 tr=0 ts=67e1a55c cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=UNRJ9jDMnXwphipqVB4A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 7CZ8_gEdK4cl4ZBIEb8VeimxyoekKSd-
X-Proofpoint-GUID: 7CZ8_gEdK4cl4ZBIEb8VeimxyoekKSd-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_06,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240132

Interconnect framework relies on static IDs for creating,
linking and maintaning the topology. This dependency on static
IDs prevents creating two instances of same provider. To overcome
the dependency on static IDs, dynamic ID support is being added.
To facilitate dynamic node ID support, the driver now uses
node pointers for links instead of static node IDs and icc_node
pointer is added as member in qcom_icc_node structure to track
the node creation.

Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 drivers/interconnect/qcom/icc-rpmh.c | 17 ++++++++++++++---
 drivers/interconnect/qcom/icc-rpmh.h |  5 +++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index f2d63745be54..41bfc6e7ee1d 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -280,7 +280,14 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 		if (!qn)
 			continue;
 
-		node = icc_node_create(qn->id);
+		if (desc->alloc_dyn_id) {
+			if (!qn->node)
+				qn->node = icc_node_create_dyn();
+			node = qn->node;
+		} else {
+			node = icc_node_create(qn->id);
+		}
+
 		if (IS_ERR(node)) {
 			ret = PTR_ERR(node);
 			goto err_remove_nodes;
@@ -290,8 +297,12 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 		node->data = qn;
 		icc_node_add(node, provider);
 
-		for (j = 0; j < qn->num_links; j++)
-			icc_link_create(node, qn->links[j]);
+		for (j = 0; j < qn->num_links; j++) {
+			if (desc->alloc_dyn_id)
+				icc_link_nodes(node, &qn->link_nodes[j]->node);
+			else
+				icc_link_create(node, qn->links[j]);
+		}
 
 		data->nodes[i] = node;
 	}
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index 82344c734091..bd8d730249b1 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -83,6 +83,8 @@ struct qcom_icc_qosbox {
  * @name: the node name used in debugfs
  * @links: an array of nodes where we can go next while traversing
  * @id: a unique node identifier
+ * @link_nodes: links associated with this node
+ * @node: icc_node associated with this node
  * @num_links: the total number of @links
  * @channels: num of channels at this node
  * @buswidth: width of the interconnect between a node and the bus
@@ -96,6 +98,8 @@ struct qcom_icc_node {
 	const char *name;
 	u16 links[MAX_LINKS];
 	u16 id;
+	struct qcom_icc_node **link_nodes;
+	struct icc_node *node;
 	u16 num_links;
 	u16 channels;
 	u16 buswidth;
@@ -154,6 +158,7 @@ struct qcom_icc_desc {
 	struct qcom_icc_bcm * const *bcms;
 	size_t num_bcms;
 	bool qos_requires_clocks;
+	bool alloc_dyn_id;
 };
 
 int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
-- 
2.43.0


