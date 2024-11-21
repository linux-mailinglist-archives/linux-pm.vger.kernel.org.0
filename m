Return-Path: <linux-pm+bounces-17879-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD179D51C2
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC431F2287F
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 17:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6671C877E;
	Thu, 21 Nov 2024 17:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WDvj6UBC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC47F1C82E2;
	Thu, 21 Nov 2024 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732210093; cv=none; b=H4jMypis6M592UFmMQopf7bAseZSujmIv2AntvzBX+52McoFrdo/wik4ZdqHTAVAkNVE9FvzkKESXcVK9Pkm3c3q4CiTk52lQWA6twdZSPSufupw/qWg/Gj+/95M52ATgFJ4Nya3B4n0857r5zN0QkL9fvYQDRDLZvekTaj672w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732210093; c=relaxed/simple;
	bh=jzi/XV+v10t0Tu+pou40m4qwzk2RQTjdzeDzGxXchgM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AtvmXRmgbfDwVzYwXz7Tbop6Nm3HxKY4IS0SQhPhvxJ2Pm+Bk8HgQiQaWT+HJtvYADEo2X+4MAhXevda/1Yqy5DvOzl7Z/XusdZCiHdJRVKVopjUNy1Z+jJ/MhXdU7Gbo7w60T737++IL5T5dNcjF9vP/LdBt/91veFuRM9rkMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WDvj6UBC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALGfo9q022204;
	Thu, 21 Nov 2024 17:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/8u/vNecc53IGxE3L/RjtRDJI6qPhOI2ZWyuk/XFR5Q=; b=WDvj6UBCcv56+oZg
	ODLSqG2zxZTSjDJU3TK/fd9+33h2YFzBluGCstq7+ubat1A7D5eosJlV/7Cl6lx9
	q+ICprJ9JpOs/Uo8Uhc1GC7M4JvpINSpDGFIPddKUu5WdeY10p23TQf7OWdyRToY
	jT1o9cct8rwmL6Gim7mWb2KAGAlYj32bQci0MDeLte+Aj+Pek0oaawJwfHqpF20h
	j+ay74SUyG7JP+d5JHdDkENeNikR/0AGZRR9WDTZzUnA8+TJZA/SAiNSXYvFU+6t
	XCBop+yluOFwZZl0h44dgclh1QqtLvO6g9SBi1s1GCC9HLwzMoRJri92rcYV0EEi
	21JpLQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4320wk1n8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 17:28:07 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ALHS6cA005317
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 17:28:06 GMT
Received: from a629a2d9ebad.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 21 Nov 2024 09:28:02 -0800
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton
	<quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] interconnect: qcom: sdx75: Drop QP0 related interconnect and BCM nodes
Date: Thu, 21 Nov 2024 17:27:37 +0000
Message-ID: <20241121172737.255-3-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241121172737.255-1-quic_rlaggysh@quicinc.com>
References: <20241121172737.255-1-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-ORIG-GUID: pULXLZK5eCVVCGS_y8Cx_4BQH9y6b3Z7
X-Proofpoint-GUID: pULXLZK5eCVVCGS_y8Cx_4BQH9y6b3Z7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=994
 adultscore=0 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210132

QP0 resource on sdx75 is managed by clk-rpmh.
There are no interconnect clients voting for QP0, hence dropping the
redundant nodes from topolgy to avoid the risk of overriding the vote
placed on QP0 using clk-rpmh.

Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 drivers/interconnect/qcom/sdx75.c |  25 -------
 drivers/interconnect/qcom/sdx75.h | 118 +++++++++++++++---------------
 2 files changed, 58 insertions(+), 85 deletions(-)

diff --git a/drivers/interconnect/qcom/sdx75.c b/drivers/interconnect/qcom/sdx75.c
index 7ef1f17f3292..4afcdc5f25a7 100644
--- a/drivers/interconnect/qcom/sdx75.c
+++ b/drivers/interconnect/qcom/sdx75.c
@@ -16,15 +16,6 @@
 #include "icc-rpmh.h"
 #include "sdx75.h"
 
-static struct qcom_icc_node qpic_core_master = {
-	.name = "qpic_core_master",
-	.id = SDX75_MASTER_QPIC_CORE,
-	.channels = 1,
-	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_QPIC_CORE },
-};
-
 static struct qcom_icc_node qup0_core_master = {
 	.name = "qup0_core_master",
 	.id = SDX75_MASTER_QUP_CORE_0,
@@ -375,14 +366,6 @@ static struct qcom_icc_node xm_usb3 = {
 	.links = { SDX75_SLAVE_A1NOC_CFG },
 };
 
-static struct qcom_icc_node qpic_core_slave = {
-	.name = "qpic_core_slave",
-	.id = SDX75_SLAVE_QPIC_CORE,
-	.channels = 1,
-	.buswidth = 4,
-	.num_links = 0,
-};
-
 static struct qcom_icc_node qup0_core_slave = {
 	.name = "qup0_core_slave",
 	.id = SDX75_SLAVE_QUP_CORE_0,
@@ -831,12 +814,6 @@ static struct qcom_icc_bcm bcm_mc0 = {
 	.nodes = { &ebi },
 };
 
-static struct qcom_icc_bcm bcm_qp0 = {
-	.name = "QP0",
-	.num_nodes = 1,
-	.nodes = { &qpic_core_slave },
-};
-
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = true,
@@ -903,9 +880,7 @@ static struct qcom_icc_bcm * const clk_virt_bcms[] = {
 };
 
 static struct qcom_icc_node * const clk_virt_nodes[] = {
-	[MASTER_QPIC_CORE] = &qpic_core_master,
 	[MASTER_QUP_CORE_0] = &qup0_core_master,
-	[SLAVE_QPIC_CORE] = &qpic_core_slave,
 	[SLAVE_QUP_CORE_0] = &qup0_core_slave,
 };
 
diff --git a/drivers/interconnect/qcom/sdx75.h b/drivers/interconnect/qcom/sdx75.h
index 24e887159920..3fd2bfcdce84 100644
--- a/drivers/interconnect/qcom/sdx75.h
+++ b/drivers/interconnect/qcom/sdx75.h
@@ -33,65 +33,63 @@
 #define SDX75_MASTER_QDSS_ETR			24
 #define SDX75_MASTER_QDSS_ETR_1			25
 #define SDX75_MASTER_QPIC			26
-#define SDX75_MASTER_QPIC_CORE			27
-#define SDX75_MASTER_QUP_0			28
-#define SDX75_MASTER_QUP_CORE_0			29
-#define SDX75_MASTER_SDCC_1			30
-#define SDX75_MASTER_SDCC_4			31
-#define SDX75_MASTER_SNOC_CFG			32
-#define SDX75_MASTER_SNOC_SF_MEM_NOC		33
-#define SDX75_MASTER_SYS_TCU			34
-#define SDX75_MASTER_USB3_0			35
-#define SDX75_SLAVE_A1NOC_CFG			36
-#define SDX75_SLAVE_ANOC_PCIE_GEM_NOC		37
-#define SDX75_SLAVE_AUDIO			38
-#define SDX75_SLAVE_CLK_CTL			39
-#define SDX75_SLAVE_CRYPTO_0_CFG		40
-#define SDX75_SLAVE_CNOC_MSS			41
-#define SDX75_SLAVE_DDRSS_CFG			42
-#define SDX75_SLAVE_EBI1			43
-#define SDX75_SLAVE_ETH0_CFG			44
-#define SDX75_SLAVE_ETH1_CFG			45
-#define SDX75_SLAVE_GEM_NOC_CFG			46
-#define SDX75_SLAVE_GEM_NOC_CNOC		47
-#define SDX75_SLAVE_ICBDI_MVMSS_CFG		48
-#define SDX75_SLAVE_IMEM			49
-#define SDX75_SLAVE_IMEM_CFG			50
-#define SDX75_SLAVE_IPA_CFG			51
-#define SDX75_SLAVE_IPC_ROUTER_CFG		52
-#define SDX75_SLAVE_LAGG_CFG			53
-#define SDX75_SLAVE_LLCC			54
-#define SDX75_SLAVE_MCCC_MASTER			55
-#define SDX75_SLAVE_MEM_NOC_PCIE_SNOC		56
-#define SDX75_SLAVE_PCIE_0			57
-#define SDX75_SLAVE_PCIE_1			58
-#define SDX75_SLAVE_PCIE_2			59
-#define SDX75_SLAVE_PCIE_0_CFG			60
-#define SDX75_SLAVE_PCIE_1_CFG			61
-#define SDX75_SLAVE_PCIE_2_CFG			62
-#define SDX75_SLAVE_PCIE_ANOC_CFG		63
-#define SDX75_SLAVE_PCIE_RSC_CFG		64
-#define SDX75_SLAVE_PDM				65
-#define SDX75_SLAVE_PRNG			66
-#define SDX75_SLAVE_QDSS_CFG			67
-#define SDX75_SLAVE_QDSS_STM			68
-#define SDX75_SLAVE_QPIC			69
-#define SDX75_SLAVE_QPIC_CORE			70
-#define SDX75_SLAVE_QUP_0			71
-#define SDX75_SLAVE_QUP_CORE_0			72
-#define SDX75_SLAVE_SDCC_1			73
-#define SDX75_SLAVE_SDCC_4			74
-#define SDX75_SLAVE_SERVICE_GEM_NOC		75
-#define SDX75_SLAVE_SERVICE_PCIE_ANOC		76
-#define SDX75_SLAVE_SERVICE_SNOC		77
-#define SDX75_SLAVE_SNOC_CFG			78
-#define SDX75_SLAVE_SNOC_GEM_NOC_SF		79
-#define SDX75_SLAVE_SNOOP_BWMON			80
-#define SDX75_SLAVE_SPMI_VGI_COEX		81
-#define SDX75_SLAVE_TCSR			82
-#define SDX75_SLAVE_TCU				83
-#define SDX75_SLAVE_TLMM			84
-#define SDX75_SLAVE_USB3			85
-#define SDX75_SLAVE_USB3_PHY_CFG		86
+#define SDX75_MASTER_QUP_0			27
+#define SDX75_MASTER_QUP_CORE_0			28
+#define SDX75_MASTER_SDCC_1			29
+#define SDX75_MASTER_SDCC_4			30
+#define SDX75_MASTER_SNOC_CFG			31
+#define SDX75_MASTER_SNOC_SF_MEM_NOC		32
+#define SDX75_MASTER_SYS_TCU			33
+#define SDX75_MASTER_USB3_0			34
+#define SDX75_SLAVE_A1NOC_CFG			35
+#define SDX75_SLAVE_ANOC_PCIE_GEM_NOC		36
+#define SDX75_SLAVE_AUDIO			37
+#define SDX75_SLAVE_CLK_CTL			38
+#define SDX75_SLAVE_CRYPTO_0_CFG		39
+#define SDX75_SLAVE_CNOC_MSS			40
+#define SDX75_SLAVE_DDRSS_CFG			41
+#define SDX75_SLAVE_EBI1			42
+#define SDX75_SLAVE_ETH0_CFG			43
+#define SDX75_SLAVE_ETH1_CFG			44
+#define SDX75_SLAVE_GEM_NOC_CFG			45
+#define SDX75_SLAVE_GEM_NOC_CNOC		46
+#define SDX75_SLAVE_ICBDI_MVMSS_CFG		47
+#define SDX75_SLAVE_IMEM			48
+#define SDX75_SLAVE_IMEM_CFG			49
+#define SDX75_SLAVE_IPA_CFG			50
+#define SDX75_SLAVE_IPC_ROUTER_CFG		51
+#define SDX75_SLAVE_LAGG_CFG			52
+#define SDX75_SLAVE_LLCC			53
+#define SDX75_SLAVE_MCCC_MASTER			54
+#define SDX75_SLAVE_MEM_NOC_PCIE_SNOC		55
+#define SDX75_SLAVE_PCIE_0			56
+#define SDX75_SLAVE_PCIE_1			57
+#define SDX75_SLAVE_PCIE_2			58
+#define SDX75_SLAVE_PCIE_0_CFG			59
+#define SDX75_SLAVE_PCIE_1_CFG			60
+#define SDX75_SLAVE_PCIE_2_CFG			61
+#define SDX75_SLAVE_PCIE_ANOC_CFG		62
+#define SDX75_SLAVE_PCIE_RSC_CFG		63
+#define SDX75_SLAVE_PDM				64
+#define SDX75_SLAVE_PRNG			65
+#define SDX75_SLAVE_QDSS_CFG			66
+#define SDX75_SLAVE_QDSS_STM			67
+#define SDX75_SLAVE_QPIC			68
+#define SDX75_SLAVE_QUP_0			69
+#define SDX75_SLAVE_QUP_CORE_0			70
+#define SDX75_SLAVE_SDCC_1			71
+#define SDX75_SLAVE_SDCC_4			72
+#define SDX75_SLAVE_SERVICE_GEM_NOC		73
+#define SDX75_SLAVE_SERVICE_PCIE_ANOC		74
+#define SDX75_SLAVE_SERVICE_SNOC		75
+#define SDX75_SLAVE_SNOC_CFG			76
+#define SDX75_SLAVE_SNOC_GEM_NOC_SF		77
+#define SDX75_SLAVE_SNOOP_BWMON			78
+#define SDX75_SLAVE_SPMI_VGI_COEX		79
+#define SDX75_SLAVE_TCSR			80
+#define SDX75_SLAVE_TCU				81
+#define SDX75_SLAVE_TLMM			82
+#define SDX75_SLAVE_USB3			83
+#define SDX75_SLAVE_USB3_PHY_CFG		84
 
 #endif
-- 
2.39.2


