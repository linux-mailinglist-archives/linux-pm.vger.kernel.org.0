Return-Path: <linux-pm+bounces-13609-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3461096C507
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 19:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8AB1F2675E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 17:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDA11E0B99;
	Wed,  4 Sep 2024 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DeEYKrM0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF66C1E0B9C;
	Wed,  4 Sep 2024 17:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470001; cv=none; b=NVcU0n35t3O5YRwYAlORP1Y7av9h63L4Xp7LkQ9yCpH/aawpjy5OcvoiC2KXej/NK3HxosrIhhcI5PwR+V25D4o5za5bDOCIdpKkL7wsxzFatoE6EnK17C+s/3QnCXVMy4lfdCZ8oNQoFRY4DHxznbHSKWg0eGfc1VUrgsrDOfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470001; c=relaxed/simple;
	bh=zXOJQ/UCxU/X7YZ+JxOCpo43hPUlI/yPHWHnL1qk9AE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ag1642v+lDYmuXWNe8GaQQkejyGBV6bXySIilKLS1YAFhJtE6w38i2vZD5npjRyO8RYP7vkbsfOC0WYIjYJOXMwhctkGx+s7xtzEW/wrV8y6R+DRdpXvxUUeoZTzg5gHwaS9fsoRn8bjlSLZ1ScVwzWF7UoljW+vqmB/SyUSWzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DeEYKrM0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484CVMng015471;
	Wed, 4 Sep 2024 17:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dDaBl3/YfLL5Qj4of6p4m4jPI9trNcvUzjdXfKtGh0U=; b=DeEYKrM0UtlkZzL9
	hMBaYUv2LDXKw++M0I597WYL2NBqG0aUqa4YQmwv0bQUQzxOqxHkXeBsySmBWPqX
	f8ADt0eqeCWY3l/5FClsMQkY8F1Il82zrvFP/x2H5+KQy3ke6fYE0A+EDdamF4Rr
	s4FTqb59pe4WteHae5OA+jYTJzRyl84S/0kaDLignybpFDqqIaFo5esbBRCFNJ1a
	QhseSNO5yvuoNY9BAiCJ0Lg4Blh9mhjTtOlcFxFu0B/nqAnsVLA1CpupBOJNs9U/
	n6GbosjMmlBo1O6ga/EL43OQIz3ASMTkjU7kJqoxQzGKA7hedUe5n/nlPwAVHNLk
	H4mlQA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41dt69dnch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 17:13:15 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 484HClG3007421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 17:12:47 GMT
Received: from 0e63825dadb5.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Sep 2024 10:12:43 -0700
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] interconnect: qcom: Add EPSS L3 support on SA8775P
Date: Wed, 4 Sep 2024 17:12:09 +0000
Message-ID: <20240904171209.29120-4-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240904171209.29120-1-quic_rlaggysh@quicinc.com>
References: <20240904171209.29120-1-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-GUID: nls1X0YWTswSdAw6t14ShnQQ4ROnKrP_
X-Proofpoint-ORIG-GUID: nls1X0YWTswSdAw6t14ShnQQ4ROnKrP_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_15,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040131

Add Epoch Subsystem (EPSS) L3 interconnect provider support on
SA8775P SoCs.

Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 drivers/interconnect/qcom/osm-l3.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index 61a8695a9adc..e97d61a9d8d7 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/args.h>
@@ -74,6 +75,11 @@ enum {
 	OSM_L3_SLAVE_NODE,
 };
 
+enum {
+	EPSS_L3_CL1_MASTER_NODE = 20000,
+	EPSS_L3_CL1_SLAVE_NODE,
+};
+
 #define DEFINE_QNODE(_name, _id, _buswidth, ...)			\
 	static const struct qcom_osm_l3_node _name = {			\
 		.name = #_name,						\
@@ -99,6 +105,15 @@ static const struct qcom_osm_l3_node * const epss_l3_nodes[] = {
 	[SLAVE_EPSS_L3_SHARED] = &epss_l3_slave,
 };
 
+DEFINE_QNODE(epss_l3_cl1_master, EPSS_L3_CL1_MASTER_NODE, 32,
+	     EPSS_L3_CL1_SLAVE_NODE);
+DEFINE_QNODE(epss_l3_cl1_slave, EPSS_L3_CL1_SLAVE_NODE, 32);
+
+static const struct qcom_osm_l3_node * const epss_l3_cl1_nodes[] = {
+	[MASTER_EPSS_L3_APPS] = &epss_l3_cl1_master,
+	[SLAVE_EPSS_L3_SHARED] = &epss_l3_cl1_slave,
+};
+
 static const struct qcom_osm_l3_desc osm_l3 = {
 	.nodes = osm_l3_nodes,
 	.num_nodes = ARRAY_SIZE(osm_l3_nodes),
@@ -115,6 +130,14 @@ static const struct qcom_osm_l3_desc epss_l3_perf_state = {
 	.reg_perf_state = EPSS_REG_PERF_STATE,
 };
 
+static const struct qcom_osm_l3_desc epss_l3_cl1_perf_state = {
+	.nodes = epss_l3_cl1_nodes,
+	.num_nodes = ARRAY_SIZE(epss_l3_cl1_nodes),
+	.lut_row_size = EPSS_LUT_ROW_SIZE,
+	.reg_freq_lut = EPSS_REG_FREQ_LUT,
+	.reg_perf_state = EPSS_REG_PERF_STATE,
+};
+
 static const struct qcom_osm_l3_desc epss_l3_l3_vote = {
 	.nodes = epss_l3_nodes,
 	.num_nodes = ARRAY_SIZE(epss_l3_nodes),
@@ -284,6 +307,10 @@ static const struct of_device_id osm_l3_of_match[] = {
 	{ .compatible = "qcom,sm8150-osm-l3", .data = &osm_l3 },
 	{ .compatible = "qcom,sc8180x-osm-l3", .data = &osm_l3 },
 	{ .compatible = "qcom,sm8250-epss-l3", .data = &epss_l3_perf_state },
+	{ .compatible = "qcom,sa8775p-epss-l3-cl0",
+	  .data = &epss_l3_perf_state },
+	{ .compatible = "qcom,sa8775p-epss-l3-cl1",
+	  .data = &epss_l3_cl1_perf_state },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, osm_l3_of_match);
-- 
2.39.2


