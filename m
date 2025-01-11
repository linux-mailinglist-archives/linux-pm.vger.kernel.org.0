Return-Path: <linux-pm+bounces-20272-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03777A0A49D
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 17:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFFF7188B57A
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 16:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FE31B393E;
	Sat, 11 Jan 2025 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c+QW8i5m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE521B3926;
	Sat, 11 Jan 2025 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736612100; cv=none; b=VMOahrnxU6bBLU3bqHOzNpR75OZvx9ZyimRFVksVI2spu0AYaiBamDjbqTU1v3J5XBxwAhTL8lzqfcHx+/K79W+4shYygI60EtSBPm/infDoJLrnNk+KK8B6acKExsOhD3DPNkqCl0aRHrEnsqPgR16Yaj/xhvtFZXgtJUxgCx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736612100; c=relaxed/simple;
	bh=QhIR6IVNhDKIGvS9mrCQN+vy8fYDqP+FrI/vAQE6KCM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A1/d8/e19yw573NnMbDh1lYvZzqIPsREYmOAMiwMaynFBqbNkkkv6sHdgqQeUTXyleVpOexEZ4FLKm7k4YksfDHuLFMq1K/0ixcFBUzgmFSpRqEI02LOrglp+XXY5i3hP4YPO8QkWFxdbF9Qz/1HkyZ+hqm3o3cDHvSjyUIBlkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c+QW8i5m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50BFt2qj025825;
	Sat, 11 Jan 2025 16:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ah78BFGjD6Fm34xergrtStLVEB9suSsnXRU0tvf5bN8=; b=c+QW8i5m5ZnAjNmp
	6UxBWDeqPUlVjpNDbFz3XUD+JuwFIIwAtTrJcgv890ygDrDUKZ65fqeVGzLHFShH
	xi95dABUo6U1cVweQHWmacC5P9q5UHlom/aCSHryT7L4btTxzFc8LZb/iGEMxL0B
	G+9nDkRjd6tLtUB73ryQP1FfhrSCDV8xWEcC1FzN5WOqpYbsvRVgw4pxuqzN0gH6
	YyfLGvWXlwHufLb21puSCeOEniC+dAIeQUAB6UhjaQwHJm9QRzzpmQSQKjf0Wwp5
	4BRBFX1ejFjke5ahZ5BT+n3lssdsQ088w5mGVJKxTJMHlWICEDdaHHOEoq9bC0W/
	Ig4LmQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 443hmy8s5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Jan 2025 16:14:56 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50BGEtOP008030
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Jan 2025 16:14:55 GMT
Received: from 4206f847eb12.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 11 Jan 2025 08:14:51 -0800
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
Subject: [PATCH V7 1/5] interconnect: core: Add dynamic id allocation support
Date: Sat, 11 Jan 2025 16:14:25 +0000
Message-ID: <20250111161429.51-2-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-ORIG-GUID: BYiuIdzH9mf4e1M5lIXHM0zQSAyfFAlv
X-Proofpoint-GUID: BYiuIdzH9mf4e1M5lIXHM0zQSAyfFAlv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501110138

Current interconnect framework is based on static IDs for creating node
and registering with framework. This becomes a limitation for topologies
where there are multiple instances of same interconnect provider. Add
icc_node_create_alloc_id() API to create icc node with dynamic id, this
will help to overcome the dependency on static IDs.

Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 drivers/interconnect/core.c           | 32 +++++++++++++++++++++++++++
 include/linux/interconnect-provider.h |  6 +++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 9d5404a07e8a..0b7093eb51af 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -858,6 +858,38 @@ struct icc_node *icc_node_create(int id)
 }
 EXPORT_SYMBOL_GPL(icc_node_create);
 
+/**
+ * icc_node_create_alloc_id() - create node and dynamically allocate id
+ * @start_id: min id to be allocated
+ *
+ * Return: icc_node pointer on success, or ERR_PTR() on error
+ */
+struct icc_node *icc_node_create_alloc_id(int start_id)
+{
+	struct icc_node *node;
+	int id;
+
+	mutex_lock(&icc_lock);
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return ERR_PTR(-ENOMEM);
+
+	id = idr_alloc(&icc_idr, node, start_id, 0, GFP_KERNEL);
+	if (id < 0) {
+		WARN(1, "%s: couldn't get idr\n", __func__);
+		kfree(node);
+		node = ERR_PTR(id);
+		goto out;
+	}
+	node->id = id;
+out:
+	mutex_unlock(&icc_lock);
+
+	return node;
+}
+EXPORT_SYMBOL_GPL(icc_node_create_alloc_id);
+
 /**
  * icc_node_destroy() - destroy a node
  * @id: node id
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index f5aef8784692..4fc7a5884374 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -117,6 +117,7 @@ struct icc_node {
 int icc_std_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 		      u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
 struct icc_node *icc_node_create(int id);
+struct icc_node *icc_node_create_alloc_id(int start_id);
 void icc_node_destroy(int id);
 int icc_link_create(struct icc_node *node, const int dst_id);
 void icc_node_add(struct icc_node *node, struct icc_provider *provider);
@@ -141,6 +142,11 @@ static inline struct icc_node *icc_node_create(int id)
 	return ERR_PTR(-ENOTSUPP);
 }
 
+static inline struct icc_node *icc_node_create_alloc_id(int start_id)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline void icc_node_destroy(int id)
 {
 }
-- 
2.39.2


