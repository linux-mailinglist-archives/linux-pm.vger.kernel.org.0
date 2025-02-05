Return-Path: <linux-pm+bounces-21430-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF9FA2990F
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 19:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55DF43AAD2C
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 18:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79B01FF7A0;
	Wed,  5 Feb 2025 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nT6XX5GE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D311FFC63;
	Wed,  5 Feb 2025 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738780104; cv=none; b=sK9QivrmEev3YmPq2jbr2ALfQYw8b+DqJ98yvDGhuQHODREdZ//MqUwdzDIilJhiVb3ZU9T1++3V1qIx5w9IhvDtYUoHvu2td6W0zHfALScKMIQoFDI3m8fLN6zzszxn+yBeBA70QWByn0+XeqZQgtbHpDMv7BgG5NYjwRNeREQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738780104; c=relaxed/simple;
	bh=eNVvjIFGAsvEALustSXjsKe3NcYrWszc4+uIuFGcJEg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8swSw7ZvDPsJjBpbz9FrYRTI8zBplTtJfpNDcLTLR9hix7Jzs1dlNorNy+GL1OzQqvSj3fEzzoCPdpzjtIS5HmRv/XnwNex+veYFdjewdQ3LIWI+YyfFTVf3mvGkUwTQ6sk6iiAGsIrnFpUN/KIqpoerEkfEbBf040zoE5EoMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nT6XX5GE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GqZO5029263;
	Wed, 5 Feb 2025 18:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uRLMXYgGMFgcqLEeRv382JBwvJGd1S7aJ0HM8A4TlpU=; b=nT6XX5GE0Ut/pl/i
	N4/LGi8cLtueLDUaIJwGTcfKe/tnX0YHb5ZDrJjO9pCAY1PPIq99MTO247AYxRef
	rskZhUa5YyxxBCv8eUIc5s6toAodeZlCiyW9pdgTkQ8BtdBIhYbwfQGZ8dCat8jV
	koZ6ig6v8GeamcQ/wo6OinpImH7XvIgKOJ/DzHzMWsofy8peffRblpxVVqenE5YC
	+lsI4F9Y1GvVKZuly7Khy8lMuP3T72qMWCWkmsJk7LsyMrpZgWagcprcKztI5eaf
	vAVlltcEi/8N43FV43omu2pAO3eo6pDxan8xkM68c2Z1pHf8MbypisYvX9pg1AUX
	t70X2g==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44mbw4888e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 18:28:18 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 515ISHhi012201
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Feb 2025 18:28:17 GMT
Received: from c194c8e2f407.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 5 Feb 2025 10:28:12 -0800
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
Subject: [PATCH V8 2/7] interconnect: core: Add dynamic id allocation support
Date: Wed, 5 Feb 2025 18:27:38 +0000
Message-ID: <20250205182743.915-3-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-GUID: 6u3RgiMob9PPwFn8dLD6VR3tD0ikuQoh
X-Proofpoint-ORIG-GUID: 6u3RgiMob9PPwFn8dLD6VR3tD0ikuQoh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502050141

The current interconnect framework relies on static IDs for node
creation and registration, which limits topologies with multiple
instances of the same interconnect provider. To address this, update
the interconnect framework APIs icc_node_create() and icc_link_create()
APIs to dynamically allocate IDs for interconnect nodes during creation.
This change removes the dependency on static IDs, allowing multiple
instances of the same hardware, such as EPSS L3.

Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 drivers/interconnect/core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 9d5404a07e8a..40700246f1b6 100644
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
+	/* negative id indicates dynamic id allocation */
+	if (id < 0)
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
-- 
2.39.2


