Return-Path: <linux-pm+bounces-23103-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9BAA483D0
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93B6D7A775E
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A7226E16C;
	Thu, 27 Feb 2025 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="US2TV3BM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99EB25F790;
	Thu, 27 Feb 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671590; cv=none; b=pEt6JNXZw2TFLt22gA7FxWbeyaI6D3feDP8HqWxV+NlRLLgmyw2V2H/O8snuVn7PZRx7TohugWU5+LHbv3VZyDTzVB9XnEtiDeZAE9diD6IXxkwLnpfVbUNXtz+u++c1bEudMzLIYYmJyuG9Wb6XnLunF32ULGh1S581xCrBcZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671590; c=relaxed/simple;
	bh=qjw+CntSOPkjOmLFOccqqCtmc1V5Na/eYdZ8DfiskV0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=raiNV7PAKdTDED42F43NKXkYHQ67KEWTpEzvKvMd0W7Q8sC5A0FYu2ushhVRPwahvlZjUmyIST/xfj6BI4QoTCmciK4Tp1IGXTCDglfZmE56FrC2I3c1/eIS3mmnLSvCqraaAdM6UwvEvV5N0lBiAVUUdgduUUJ9Afak3ZHSTB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=US2TV3BM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R8sIkR021536;
	Thu, 27 Feb 2025 15:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a6b778EMkpw2o4BnHKWeBNV1DQywEL8Yq4GjDNBTywk=; b=US2TV3BMqyps80ks
	sSln6FGCN1oXhREEIcl2dowOTZKjl6dPoD+Fkr7iHtZ6yC753zOo0CNIeXeN8yO1
	xU6IjFm33jN4ty0EPdy0LpFQPB+caHe6XUtzR6rx05dpviGEUyK2Vx1CFSfcyjw8
	QilIOJGDxkdnRPyItAmL7QWzZQyP9oK8px3ZGHlDHRDx+AkXaEJW1rQz3lCEHLvr
	2Sl6ZY0RHf+vVkqGhhLVKgfIzCBfnGPeTMWaR56CXgRnzIlZQ/e717n0gJuDQNNZ
	0vBrEl4vk5eJYygvgeOK5WEsKy0ABNXmvshf3VuGxv8GtOYqMgtZCJpwBLGWTzx7
	r4BpxA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prkpa8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 15:53:05 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51RFr5Ys011607
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 15:53:05 GMT
Received: from 0d558f49c4ed.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 27 Feb 2025 07:53:00 -0800
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
Subject: [PATCH V9 4/7] interconnect: qcom: icc-rpmh: Add dynamic icc node id support
Date: Thu, 27 Feb 2025 15:52:10 +0000
Message-ID: <20250227155213.404-5-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-GUID: gj5RsBO9SqX3EN6vK5aMDepLZ5ZoGu4N
X-Proofpoint-ORIG-GUID: gj5RsBO9SqX3EN6vK5aMDepLZ5ZoGu4N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270120

To facilitate dynamic node ID support, the driver now uses
node pointers for links instead of static node IDs.
Additionally, the default node ID is set to -1 to prompt
the ICC framework for dynamic node ID allocation.

Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 drivers/interconnect/qcom/icc-rpmh.c | 16 ++++++++++++++--
 drivers/interconnect/qcom/icc-rpmh.h |  3 ++-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index f2d63745be54..2e654917f535 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -285,13 +285,25 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 			ret = PTR_ERR(node);
 			goto err_remove_nodes;
 		}
+		qn->id = node->id;
 
 		node->name = qn->name;
 		node->data = qn;
 		icc_node_add(node, provider);
 
-		for (j = 0; j < qn->num_links; j++)
-			icc_link_create(node, qn->links[j]);
+		for (j = 0; j < qn->num_links; j++) {
+			struct qcom_icc_node *qn_link_node = qn->link_nodes[j];
+			struct icc_node *link_node;
+
+			if (qn_link_node) {
+				link_node = icc_node_create(qn_link_node->id);
+				qn_link_node->id = link_node->id;
+				icc_link_create(node, qn_link_node->id);
+			} else {
+				/* backward compatibility for target using static IDs */
+				icc_link_create(node, qn->links[j]);
+			}
+		}
 
 		data->nodes[i] = node;
 	}
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index 82344c734091..cf4aa69c707c 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -95,7 +95,8 @@ struct qcom_icc_qosbox {
 struct qcom_icc_node {
 	const char *name;
 	u16 links[MAX_LINKS];
-	u16 id;
+	struct qcom_icc_node *link_nodes[MAX_LINKS];
+	int id;
 	u16 num_links;
 	u16 channels;
 	u16 buswidth;
-- 
2.43.0


