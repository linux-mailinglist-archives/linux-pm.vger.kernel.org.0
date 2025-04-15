Return-Path: <linux-pm+bounces-25449-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD224A898C5
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 11:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0DB189EF6D
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 09:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D4128DEF2;
	Tue, 15 Apr 2025 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CUH23bhf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FABA1DF994;
	Tue, 15 Apr 2025 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744710868; cv=none; b=cevHvIp0HtpLTc/4w2jebIFLDc8UcpFSeD0tET926DeVjQfWhvEuAapEYFAISDIBSM2aZVJLQY5eGKNkL+7r/4aSRVn7Y0HuGjsQ/Qs8QasZYY60S8n9xBLyHM64mR5VIG8NlvGJ704hRvV5TFjxCF0IhyOiwts6u9uptFV9DtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744710868; c=relaxed/simple;
	bh=dDhpq++W6HJnwNqVj7EdN30IAMmLatmItOs2z+mp+NI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RK17YmfTHu9U6OvTx7TMD9EYvTKcuqxTzEzc5QafLbCgnFoSC51f0ttd4Kdxhvi5LjTMkhY5xVuK6XA/XIR2o3EexWA2hsgcg44cKyde1Sg3SZlmZZOJdlq1WiG5lK9k81YtmQWwzq6DUKJm1n1lzlu16MHNisqdTqRj67ezQaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CUH23bhf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F8tKeG025188;
	Tue, 15 Apr 2025 09:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o/Lz5rwguUXqsk8HlVRhbhoMgd+g18cHL0dsMmrxrp0=; b=CUH23bhfvuUOg5P6
	P1r1isgcDPq3auU7Fmi6I94ST9JYPToP3azfU3YjTRo6yOGlO0Fntaw+u7huUaZG
	pEvFyL+no/RGrd8wEuLVLzNguslHUWmi8BLRsQ0FQo0HkJNFCU6mc2ir8n7XGOpd
	SIGdtzgyq7rbjPSTXTNWZTPpx5SxPPQ5DDU24m27qzEGQL469BenR9WJJA5Tkqfx
	TcszeZmB1zfd57zqNpl1MugBPd7GVSvV/iJklreFntmZnXiJvcq7wK2KRo4Oj1jB
	H5FPcodIIbvRZkTcSNM8t4Jtl0RV9Op6LdWcZpPlq50rwVUl2nchtBp/k2xzVL0f
	4Ak90Q==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf69qmag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 09:54:22 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53F9sLuZ013106
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 09:54:21 GMT
Received: from 087e9057f447.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Apr 2025 02:54:17 -0700
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
Subject: [PATCH V11 2/7] interconnect: core: Add dynamic id allocation support
Date: Tue, 15 Apr 2025 09:53:38 +0000
Message-ID: <20250415095343.32125-3-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-GUID: _jdqKAUnzW-FDz0eoy6wRnTvz6ySCvQt
X-Authority-Analysis: v=2.4 cv=JNc7s9Kb c=1 sm=1 tr=0 ts=67fe2cce cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=U35lfTTpteBrRMSzLT0A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: _jdqKAUnzW-FDz0eoy6wRnTvz6ySCvQt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150069

The current interconnect framework relies on static IDs for node
creation and registration, which limits topologies with multiple
instances of the same interconnect provider. To address this,
introduce icc_node_create_dyn() and icc_link_nodes() APIs to
dynamically allocate IDs for interconnect nodes during creation
and link. This change removes the dependency on static IDs,
allowing multiple instances of the same hardware, such as EPSS L3.

Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 drivers/interconnect/core.c           | 82 ++++++++++++++++++++++++++-
 include/linux/interconnect-provider.h | 12 ++++
 include/linux/interconnect.h          |  3 +
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 9d5404a07e8a..1a41e59c77f8 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -20,6 +20,8 @@
 
 #include "internal.h"
 
+#define ICC_DYN_ID_START 10000
+
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
@@ -826,7 +828,12 @@ static struct icc_node *icc_node_create_nolock(int id)
 	if (!node)
 		return ERR_PTR(-ENOMEM);
 
-	id = idr_alloc(&icc_idr, node, id, id + 1, GFP_KERNEL);
+	/* dynamic id allocation */
+	if (id == ICC_ALLOC_DYN_ID)
+		id = idr_alloc(&icc_idr, node, ICC_DYN_ID_START, 0, GFP_KERNEL);
+	else
+		id = idr_alloc(&icc_idr, node, id, id + 1, GFP_KERNEL);
+
 	if (id < 0) {
 		WARN(1, "%s: couldn't get idr\n", __func__);
 		kfree(node);
@@ -838,6 +845,25 @@ static struct icc_node *icc_node_create_nolock(int id)
 	return node;
 }
 
+/**
+ * icc_node_create_dyn() - create a node with dynamic id
+ *
+ * Return: icc_node pointer on success, or ERR_PTR() on error
+ */
+struct icc_node *icc_node_create_dyn(void)
+{
+	struct icc_node *node;
+
+	mutex_lock(&icc_lock);
+
+	node = icc_node_create_nolock(ICC_ALLOC_DYN_ID);
+
+	mutex_unlock(&icc_lock);
+
+	return node;
+}
+EXPORT_SYMBOL_GPL(icc_node_create_dyn);
+
 /**
  * icc_node_create() - create a node
  * @id: node id
@@ -884,6 +910,56 @@ void icc_node_destroy(int id)
 }
 EXPORT_SYMBOL_GPL(icc_node_destroy);
 
+/**
+ * icc_link_nodes() - create link between two nodes
+ * @src_node: source node
+ * @dst_node: destination node
+ *
+ * Create a link between two nodes. The nodes might belong to different
+ * interconnect providers and the @dst_node might not exist (if the
+ * provider driver has not probed yet). So just create the @dst_node
+ * and when the actual provider driver is probed, the rest of the node
+ * data is filled.
+ *
+ * Return: 0 on success, or an error code otherwise
+ */
+int icc_link_nodes(struct icc_node *src_node, struct icc_node **dst_node)
+{
+	struct icc_node **new;
+	int ret = 0;
+
+	if (!src_node->provider)
+		return -EINVAL;
+
+	mutex_lock(&icc_lock);
+
+	if (!*dst_node) {
+		*dst_node = icc_node_create_nolock(ICC_ALLOC_DYN_ID);
+
+		if (IS_ERR(*dst_node)) {
+			ret = PTR_ERR(*dst_node);
+			goto out;
+		}
+	}
+
+	new = krealloc(src_node->links,
+		       (src_node->num_links + 1) * sizeof(*src_node->links),
+		       GFP_KERNEL);
+	if (!new) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	src_node->links = new;
+	src_node->links[src_node->num_links++] = *dst_node;
+
+out:
+	mutex_unlock(&icc_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(icc_link_nodes);
+
 /**
  * icc_link_create() - create a link between two nodes
  * @node: source node id
@@ -962,6 +1038,10 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 	node->avg_bw = node->init_avg;
 	node->peak_bw = node->init_peak;
 
+	if (node->id >= ICC_DYN_ID_START)
+		node->name = devm_kasprintf(provider->dev, GFP_KERNEL, "%s@%s",
+					    node->name, dev_name(provider->dev));
+
 	if (node->avg_bw || node->peak_bw) {
 		if (provider->pre_aggregate)
 			provider->pre_aggregate(node);
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index f5aef8784692..55cfebc658e6 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -116,8 +116,10 @@ struct icc_node {
 
 int icc_std_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 		      u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
+struct icc_node *icc_node_create_dyn(void);
 struct icc_node *icc_node_create(int id);
 void icc_node_destroy(int id);
+int icc_link_nodes(struct icc_node *src_node, struct icc_node **dst_node);
 int icc_link_create(struct icc_node *node, const int dst_id);
 void icc_node_add(struct icc_node *node, struct icc_provider *provider);
 void icc_node_del(struct icc_node *node);
@@ -136,6 +138,11 @@ static inline int icc_std_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 	return -ENOTSUPP;
 }
 
+static inline struct icc_node *icc_node_create_dyn(void)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline struct icc_node *icc_node_create(int id)
 {
 	return ERR_PTR(-ENOTSUPP);
@@ -145,6 +152,11 @@ static inline void icc_node_destroy(int id)
 {
 }
 
+static inline int icc_link_nodes(struct icc_node *src_node, struct icc_node **dst_node)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int icc_link_create(struct icc_node *node, const int dst_id)
 {
 	return -ENOTSUPP;
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index 97ac253df62c..e4b8808823ad 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -20,6 +20,9 @@
 #define Mbps_to_icc(x)	((x) * 1000 / 8)
 #define Gbps_to_icc(x)	((x) * 1000 * 1000 / 8)
 
+/* macro to indicate dynamic id allocation */
+#define ICC_ALLOC_DYN_ID	-1
+
 struct icc_path;
 struct device;
 
-- 
2.43.0


