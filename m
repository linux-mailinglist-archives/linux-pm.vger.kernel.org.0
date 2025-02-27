Return-Path: <linux-pm+bounces-23088-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD91A48395
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A5F3B5EB4
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E3B1A8402;
	Thu, 27 Feb 2025 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="apECHTMG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4851A5B8E;
	Thu, 27 Feb 2025 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671576; cv=none; b=RmLCg2i7VuXHUREDxsDfNexG6FtcOn8YSeN637eNZrtZLPOY3KGwhVlr3G+KbCWA9c5QoUWXvIxDxsIKCcqAHHd+c1cxGIysw9pq13s9iNQF1u17ev6rZLYrLzeIohESMbNbvJnpNTADroTxanbQ+MSlxeLVokK7YU5TExuEmkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671576; c=relaxed/simple;
	bh=7EYjOyxg6IRT1jKQTUf1dfWCA9NTlM8o6WmOW1tfSsY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFMgs+NxHZZgWoVQDY5r1QmoGX0TXsFexjzgBqj70rT1hxh9rm9d7QhDzCpSU88BHiTBB+Sd88mHRnp/bGa4JBn6kOe5Kvb+BnNmcXArN26+zE9WYwC50mM2BIcx87VmOUwhQPGUjChr8iZMyfWQuSFhq0fb0K4MjQz5v3CW33g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=apECHTMG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R8tWu1017852;
	Thu, 27 Feb 2025 15:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gdghZV7rqmH9L13A0iLlP5v/RZs7EWdF+j996RUisN8=; b=apECHTMGRykkMRsc
	/r55xz+LvjWpnTanVYUImexuT6ym3ReVue5A5aEZMlbHgAYVAEHWDyosaea42hRd
	Za5HKr9c0HtF6kI7HCE3QUoEbbBqa1hlF1oVoWxohnO/P8KTa1hyPdstln46Au8m
	c8wi4W0XWWv66g897TFUay8Kyv/vshWIWQQIzBrzV9sL5IFnTSACU6wNP1lZeqLE
	g4sAVBUFfepUy1296dyeMLdndwCxCs+dYPgSo3Sq+x0sYWg2aWPhrQiu+iSu1UpQ
	5c+drsUzgAJePyt/t+hoooxRrjXc30FKGkh3QIvRNDBMr3vhl4/Spe+mrXywzDfJ
	4hdZ8g==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prn688p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 15:52:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51RFqovP030449
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 15:52:50 GMT
Received: from 0d558f49c4ed.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 27 Feb 2025 07:52:45 -0800
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
Subject: [PATCH V9 2/7] interconnect: core: Add dynamic id allocation support
Date: Thu, 27 Feb 2025 15:52:08 +0000
Message-ID: <20250227155213.404-3-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ayDeQPz1BpOX8v4T4olLWql-CzF6HsYX
X-Proofpoint-GUID: ayDeQPz1BpOX8v4T4olLWql-CzF6HsYX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270120

The current interconnect framework relies on static IDs for node
creation and registration, which limits topologies with multiple
instances of the same interconnect provider. To address this, update
the interconnect framework APIs icc_node_create() and icc_link_create()
APIs to dynamically allocate IDs for interconnect nodes during creation.
This change removes the dependency on static IDs, allowing multiple
instances of the same hardware, such as EPSS L3.

Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 drivers/interconnect/core.c  | 13 ++++++++++++-
 include/linux/interconnect.h |  3 +++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 9d5404a07e8a..40adc1d0d89a 100644
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
+	if (id == ALLOC_DYN_ID)
+		id = idr_alloc(&icc_idr, node, ICC_DYN_ID_START, 0, GFP_KERNEL);
+	else
+		id = idr_alloc(&icc_idr, node, id, id + 1, GFP_KERNEL);
+
 	if (id < 0) {
 		WARN(1, "%s: couldn't get idr\n", __func__);
 		kfree(node);
@@ -962,6 +969,10 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 	node->avg_bw = node->init_avg;
 	node->peak_bw = node->init_peak;
 
+	if (node->id >= ICC_DYN_ID_START)
+		node->name = devm_kasprintf(provider->dev, GFP_KERNEL, "%s@%s",
+					    node->name, dev_name(provider->dev));
+
 	if (node->avg_bw || node->peak_bw) {
 		if (provider->pre_aggregate)
 			provider->pre_aggregate(node);
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index 97ac253df62c..8b0f892aaed2 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -20,6 +20,9 @@
 #define Mbps_to_icc(x)	((x) * 1000 / 8)
 #define Gbps_to_icc(x)	((x) * 1000 * 1000 / 8)
 
+/* macro to indicate dynamic id allocation */
+#define ALLOC_DYN_ID	-1
+
 struct icc_path;
 struct device;
 
-- 
2.43.0


