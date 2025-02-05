Return-Path: <linux-pm+bounces-21432-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D51CA29919
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 19:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799C818862CE
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 18:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C6B20CCF0;
	Wed,  5 Feb 2025 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MNl3s/00"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AAF20FAAB;
	Wed,  5 Feb 2025 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738780113; cv=none; b=IgD2mOnpPBYi43k75YRmNqYODJ9DY4A3FXONNkfJ8qPAngcxTRN54ebKjF5dO3CuO2Q1ot/X44GahIWghe22IygkJvEx96SkfzNJEbDJhK7Y4XRx3xnV/jvzkUO895tZJDyz/E0JcxVvMoq+GwWnLg7VHvR2WZKjv3+m8bT6kuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738780113; c=relaxed/simple;
	bh=vHhVnG5kW6lbKXwPHpCSaynYlCCRgtLzp2xiCr5MEMk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoC/xCsV1wWgHuImnBbPcKpsMdNZAOQp/DyWahoUbp8GJM4xCQ3+XHzHoKntbQe8FqL7r6ddohN1r3k9Nr+mHQT0u1B94TndkaFnmzgb8WnP46KkV07WmYYzg934uj6WD2+6+yBiga2k9DgiJbSnlh4uyjjB80A7ZvOA3a8j1Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MNl3s/00; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515FWaZD001694;
	Wed, 5 Feb 2025 18:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JGXPfmRcBxyZn/L8L7jTYzs6XsomWfsbT2nngtAougw=; b=MNl3s/00VQOD0HQL
	LPhTwrNOE8BO5eFxGM5+2TlGSBzjJ007TYqzNlrf/F0VcVIeqf4No/ad0JshON4b
	TbYe4z0uuQSUdVGemYJAejg11equMJmklbzfemXjJvH6Gr9Ya1iFuPgkcpOldEUN
	6JoSXHL0rcBrSulBA/vkJlVX1Xx9iu8D41wN5dY5cRj2ooX31STIWVeXqSOIkf1n
	dCtrvmyweE0nIoSCBjKEQC64aOzsk1eOEmM3FMPoYwbY2rfIfX9whvikX/r2y70O
	ToJZykzbLZMSCmuX4XXmHnaTxG8okpEO0HvpTbowt17neaY5xzonQNWEYtJAJij3
	Rz6ftA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44maqgreu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 18:28:26 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 515ISQh5016936
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Feb 2025 18:28:26 GMT
Received: from c194c8e2f407.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 5 Feb 2025 10:28:21 -0800
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
Subject: [PATCH V8 4/7] interconnect: qcom: icc-rpmh: Add dynamic icc node id support
Date: Wed, 5 Feb 2025 18:27:40 +0000
Message-ID: <20250205182743.915-5-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-GUID: lCq0mdUVImcQM_01nutcj55Eo4VJjDeX
X-Proofpoint-ORIG-GUID: lCq0mdUVImcQM_01nutcj55Eo4VJjDeX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 clxscore=1011 phishscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050141

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
2.39.2


