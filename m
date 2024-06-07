Return-Path: <linux-pm+bounces-8793-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF931900B61
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 19:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DF75B232D9
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 17:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF4A19B587;
	Fri,  7 Jun 2024 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QaWJ/Z15"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A038C19B3E4;
	Fri,  7 Jun 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717782033; cv=none; b=OID19vLhD4XDa9pZZ2UZOv0sX9xhyL+RRFkRA6PO3wo2sWU+BIsuvHoKPFZSRIupcEst7SbXWJWbHXqnZ6Ojgjk3dLsiqoCsNrWueMjOTvRYb02InSdexAeTsRGYqJCmkMOke0+6WyMZyxbVZg6NMGbwXHHDGCHajE3QbynY0XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717782033; c=relaxed/simple;
	bh=vcLNBdfb5X1uH1rDBsMlhi+NLBEo1qnsfc9WC4CKA1I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RA9BBaj0qv67MLNOw6EmDPV46mKp+hyXbp/wusHfAy+N70LDGqI1lAued69wvDcgDvkGfVcpx34ehFws1CVEBpVzzVcvVgT7hcW/V22aMM+i0JVKsPI09yuWMJV63bfDga2d6nsy9A6bh7T/62AMcBIbsxT8b291BImfTdqXmdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QaWJ/Z15; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457HZhRB028213;
	Fri, 7 Jun 2024 17:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NcMmSete2f2zn6oBP5ryr5iW
	QQ4yXf3jAQcz9cbBKEs=; b=QaWJ/Z15i6Y5E8pGCnsX0qVzGv9nCKiMeMm3PTdJ
	PNQvM8HCGdZNKCv88u6uOyWR9AZJeQ8hVx6Ccy+UtTh9BVb0e/rKAJZ28eu+WKsD
	TT0myucVNo/BHrq4uMp7tQyeyioETzWql8Fz8Ji43odjW9dbt15m4GlyHD+oLwgw
	jsklMc30iv0Dev0/T3SkqpvAJrRQ+Mw9OOjsS8pxOSlVb93lVBRaU7+AEiLfzbk4
	rPO8JWicKsexSyFC4pcuRZhuk5aBzWkmv8GxFO1aBHFMl+u5okaHOcj+tE79pSed
	efx/3zjg8m1Wev6ksdURlyxLzs/tMT3Rqfim6jhRKfEXJQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yk3h2vx2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 17:40:24 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 457HeMA1004383
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 17:40:22 GMT
Received: from hu-okukatla-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 7 Jun 2024 10:40:17 -0700
From: Odelu Kukatla <quic_okukatla@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Kees Cook <keescook@chromium.org>, <cros-qcom-dts-watchers@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <quic_rlaggysh@quicinc.com>,
        <quic_mdtipton@quicinc.com>, <quic_okukatla@quicinc.com>
Subject: [PATCH v5 2/4] interconnect: qcom: sc7280: enable QoS configuration
Date: Fri, 7 Jun 2024 23:09:25 +0530
Message-ID: <20240607173927.26321-3-quic_okukatla@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240607173927.26321-1-quic_okukatla@quicinc.com>
References: <20240607173927.26321-1-quic_okukatla@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8ovxQT1zDM_5VpaC5_PNLpitmNPKO_5n
X-Proofpoint-ORIG-GUID: 8ovxQT1zDM_5VpaC5_PNLpitmNPKO_5n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_10,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070130

Enable QoS configuration for master ports with predefined values
for priority and urgency forawrding.

Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
---
 drivers/interconnect/qcom/sc7280.c | 274 +++++++++++++++++++++++++++++
 1 file changed, 274 insertions(+)

diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
index 7d33694368e8..759c609a20bf 100644
--- a/drivers/interconnect/qcom/sc7280.c
+++ b/drivers/interconnect/qcom/sc7280.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
  *
  */
 
@@ -21,6 +22,12 @@ static struct qcom_icc_node qhm_qspi = {
 	.id = SC7280_MASTER_QSPI_0,
 	.channels = 1,
 	.buswidth = 4,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x7000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A1NOC_SNOC },
 };
@@ -30,6 +37,12 @@ static struct qcom_icc_node qhm_qup0 = {
 	.id = SC7280_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x11000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A1NOC_SNOC },
 };
@@ -39,6 +52,12 @@ static struct qcom_icc_node qhm_qup1 = {
 	.id = SC7280_MASTER_QUP_1,
 	.channels = 1,
 	.buswidth = 4,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x8000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A1NOC_SNOC },
 };
@@ -57,6 +76,12 @@ static struct qcom_icc_node xm_sdc1 = {
 	.id = SC7280_MASTER_SDCC_1,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xc000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A1NOC_SNOC },
 };
@@ -66,6 +91,12 @@ static struct qcom_icc_node xm_sdc2 = {
 	.id = SC7280_MASTER_SDCC_2,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xe000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A1NOC_SNOC },
 };
@@ -75,6 +106,12 @@ static struct qcom_icc_node xm_sdc4 = {
 	.id = SC7280_MASTER_SDCC_4,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x9000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A1NOC_SNOC },
 };
@@ -84,6 +121,12 @@ static struct qcom_icc_node xm_ufs_mem = {
 	.id = SC7280_MASTER_UFS_MEM,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xa000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A1NOC_SNOC },
 };
@@ -102,6 +145,12 @@ static struct qcom_icc_node xm_usb3_0 = {
 	.id = SC7280_MASTER_USB3_0,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xb000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A1NOC_SNOC },
 };
@@ -111,6 +160,12 @@ static struct qcom_icc_node qhm_qdss_bam = {
 	.id = SC7280_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x18000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A2NOC_SNOC },
 };
@@ -129,6 +184,12 @@ static struct qcom_icc_node qnm_cnoc_datapath = {
 	.id = SC7280_MASTER_CNOC_A2NOC,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x1c000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A2NOC_SNOC },
 };
@@ -138,6 +199,12 @@ static struct qcom_icc_node qxm_crypto = {
 	.id = SC7280_MASTER_CRYPTO,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x1d000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A2NOC_SNOC },
 };
@@ -147,6 +214,12 @@ static struct qcom_icc_node qxm_ipa = {
 	.id = SC7280_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x10000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A2NOC_SNOC },
 };
@@ -173,6 +246,12 @@ static struct qcom_icc_node xm_qdss_etr = {
 	.id = SC7280_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x15000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.links = { SC7280_SLAVE_A2NOC_SNOC },
 };
@@ -305,6 +384,12 @@ static struct qcom_icc_node alm_gpu_tcu = {
 	.id = SC7280_MASTER_GPU_TCU,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xd7000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 2,
 	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
 };
@@ -314,6 +399,12 @@ static struct qcom_icc_node alm_sys_tcu = {
 	.id = SC7280_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xd6000 },
+		.prio = 6,
+		.urg_fwd = 0,
+	},
 	.num_links = 2,
 	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
 };
@@ -333,6 +424,12 @@ static struct qcom_icc_node qnm_cmpnoc = {
 	.id = SC7280_MASTER_COMPUTE_NOC,
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x21000, 0x61000 },
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 2,
 	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
 };
@@ -353,6 +450,12 @@ static struct qcom_icc_node qnm_gpu = {
 	.id = SC7280_MASTER_GFX3D,
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x22000, 0x62000 },
+		.prio = 0,
+		.urg_fwd = 0,
+	},
 	.num_links = 2,
 	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
 };
@@ -362,6 +465,12 @@ static struct qcom_icc_node qnm_mnoc_hf = {
 	.id = SC7280_MASTER_MNOC_HF_MEM_NOC,
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x23000, 0x63000 },
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.links = { SC7280_SLAVE_LLCC },
 };
@@ -371,6 +480,12 @@ static struct qcom_icc_node qnm_mnoc_sf = {
 	.id = SC7280_MASTER_MNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xcf000 },
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 2,
 	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC },
 };
@@ -389,6 +504,12 @@ static struct qcom_icc_node qnm_snoc_gc = {
 	.id = SC7280_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xd3000 },
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.links = { SC7280_SLAVE_LLCC },
 };
@@ -398,6 +519,12 @@ static struct qcom_icc_node qnm_snoc_sf = {
 	.id = SC7280_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xd4000 },
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 3,
 	.links = { SC7280_SLAVE_GEM_NOC_CNOC, SC7280_SLAVE_LLCC,
 		   SC7280_SLAVE_MEM_NOC_PCIE_SNOC },
@@ -437,6 +564,12 @@ static struct qcom_icc_node qnm_video0 = {
 	.id = SC7280_MASTER_VIDEO_P0,
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x14000 },
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.links = { SC7280_SLAVE_MNOC_SF_MEM_NOC },
 };
@@ -446,6 +579,12 @@ static struct qcom_icc_node qnm_video_cpu = {
 	.id = SC7280_MASTER_VIDEO_PROC,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x15000 },
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.links = { SC7280_SLAVE_MNOC_SF_MEM_NOC },
 };
@@ -455,6 +594,12 @@ static struct qcom_icc_node qxm_camnoc_hf = {
 	.id = SC7280_MASTER_CAMNOC_HF,
 	.channels = 2,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x10000, 0x10180 },
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.links = { SC7280_SLAVE_MNOC_HF_MEM_NOC },
 };
@@ -464,6 +609,12 @@ static struct qcom_icc_node qxm_camnoc_icp = {
 	.id = SC7280_MASTER_CAMNOC_ICP,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x11000 },
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.links = { SC7280_SLAVE_MNOC_SF_MEM_NOC },
 };
@@ -473,6 +624,12 @@ static struct qcom_icc_node qxm_camnoc_sf = {
 	.id = SC7280_MASTER_CAMNOC_SF,
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x12000 },
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.links = { SC7280_SLAVE_MNOC_SF_MEM_NOC },
 };
@@ -482,6 +639,12 @@ static struct qcom_icc_node qxm_mdp0 = {
 	.id = SC7280_MASTER_MDP0,
 	.channels = 1,
 	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x16000 },
+		.prio = 0,
+		.urg_fwd = 1,
+	},
 	.num_links = 1,
 	.links = { SC7280_SLAVE_MNOC_HF_MEM_NOC },
 };
@@ -536,6 +699,12 @@ static struct qcom_icc_node qxm_pimem = {
 	.id = SC7280_MASTER_PIMEM,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x8000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.links = { SC7280_SLAVE_SNOC_GEM_NOC_GC },
 };
@@ -545,6 +714,12 @@ static struct qcom_icc_node xm_gic = {
 	.id = SC7280_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xa000 },
+		.prio = 2,
+		.urg_fwd = 0,
+	},
 	.num_links = 1,
 	.links = { SC7280_SLAVE_SNOC_GEM_NOC_GC },
 };
@@ -1502,7 +1677,16 @@ static struct qcom_icc_node * const aggre1_noc_nodes[] = {
 	[SLAVE_SERVICE_A1NOC] = &srvc_aggre1_noc,
 };
 
+static const struct regmap_config sc7280_aggre1_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x1c080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sc7280_aggre1_noc = {
+	.config = &sc7280_aggre1_noc_regmap_config,
 	.nodes = aggre1_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
 	.bcms = aggre1_noc_bcms,
@@ -1513,6 +1697,14 @@ static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
 	&bcm_ce0,
 };
 
+static const struct regmap_config sc7280_aggre2_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x2b080,
+	.fast_io = true,
+};
+
 static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
 	[MASTER_A2NOC_CFG] = &qnm_a2noc_cfg,
@@ -1525,6 +1717,7 @@ static struct qcom_icc_node * const aggre2_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sc7280_aggre2_noc = {
+	.config = &sc7280_aggre2_noc_regmap_config,
 	.nodes = aggre2_noc_nodes,
 	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
 	.bcms = aggre2_noc_bcms,
@@ -1605,7 +1798,16 @@ static struct qcom_icc_node * const cnoc2_nodes[] = {
 	[SLAVE_SNOC_CFG] = &qns_snoc_cfg,
 };
 
+static const struct regmap_config sc7280_cnoc2_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x1000,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sc7280_cnoc2 = {
+	.config = &sc7280_cnoc2_regmap_config,
 	.nodes = cnoc2_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc2_nodes),
 	.bcms = cnoc2_bcms,
@@ -1637,7 +1839,16 @@ static struct qcom_icc_node * const cnoc3_nodes[] = {
 	[SLAVE_TCU] = &xs_sys_tcu_cfg,
 };
 
+static const struct regmap_config sc7280_cnoc3_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x1000,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sc7280_cnoc3 = {
+	.config = &sc7280_cnoc3_regmap_config,
 	.nodes = cnoc3_nodes,
 	.num_nodes = ARRAY_SIZE(cnoc3_nodes),
 	.bcms = cnoc3_bcms,
@@ -1653,7 +1864,16 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 	[SLAVE_GEM_NOC_CFG] = &qns_gemnoc,
 };
 
+static const struct regmap_config sc7280_dc_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x5080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sc7280_dc_noc = {
+	.config = &sc7280_dc_noc_regmap_config,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 	.bcms = dc_noc_bcms,
@@ -1689,7 +1909,16 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 	[SLAVE_SERVICE_GEM_NOC] = &srvc_sys_gemnoc,
 };
 
+static const struct regmap_config sc7280_gem_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0xe2200,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sc7280_gem_noc = {
+	.config = &sc7280_gem_noc_regmap_config,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -1709,7 +1938,16 @@ static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
 	[SLAVE_SERVICE_LPASS_AG_NOC] = &srvc_niu_lpass_agnoc,
 };
 
+static const struct regmap_config sc7280_lpass_ag_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0xf080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sc7280_lpass_ag_noc = {
+	.config = &sc7280_lpass_ag_noc_regmap_config,
 	.nodes = lpass_ag_noc_nodes,
 	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
 	.bcms = lpass_ag_noc_bcms,
@@ -1726,7 +1964,16 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 	[SLAVE_EBI1] = &ebi,
 };
 
+static const struct regmap_config sc7280_mc_virt_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x4,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sc7280_mc_virt = {
+	.config = &sc7280_mc_virt_regmap_config,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -1753,7 +2000,16 @@ static struct qcom_icc_node * const mmss_noc_nodes[] = {
 	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
 };
 
+static const struct regmap_config sc7280_mmss_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x1e080,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sc7280_mmss_noc = {
+	.config = &sc7280_mmss_noc_regmap_config,
 	.nodes = mmss_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
 	.bcms = mmss_noc_bcms,
@@ -1772,7 +2028,16 @@ static struct qcom_icc_node * const nsp_noc_nodes[] = {
 	[SLAVE_SERVICE_NSP_NOC] = &service_nsp_noc,
 };
 
+static const struct regmap_config sc7280_nsp_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x10000,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sc7280_nsp_noc = {
+	.config = &sc7280_nsp_noc_regmap_config,
 	.nodes = nsp_noc_nodes,
 	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
 	.bcms = nsp_noc_bcms,
@@ -1797,7 +2062,16 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 	[SLAVE_SERVICE_SNOC] = &srvc_snoc,
 };
 
+static const struct regmap_config sc7280_system_noc_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x15480,
+	.fast_io = true,
+};
+
 static const struct qcom_icc_desc sc7280_system_noc = {
+	.config = &sc7280_system_noc_regmap_config,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
-- 
2.17.1


