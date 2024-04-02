Return-Path: <linux-pm+bounces-5796-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2777F89505D
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 12:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2401F24980
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 10:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8581D7FBA1;
	Tue,  2 Apr 2024 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="krhtzC/G"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC67D83CA6;
	Tue,  2 Apr 2024 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054097; cv=none; b=MyEr6aLPMwGUv7q1HkRTY86ZCyoZxB+Fnx5j9O7Q0UkCCDImmioHWqofG9+GgX85dqSKRXRmsCHqfLIu59T4zz9MFLuaRt42QaWdTE0Ck+bemc2d6dLe9pTuucR1dGNT6tvuua//PtOU5ifzArtLpCu0HlsEAUm1U1ii/YpStcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054097; c=relaxed/simple;
	bh=nQj5TqS4TGiP3+Trkc73DP+SBP4JrGBsYxIRMqz9F6E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cgZ15+38ATvx1yClyNFY+PGb5mPMQyFokfYvcfrccskxEKApYgfAOAGTjRf13//jDR/ioLfZBIfzrdMn8/kSYyc1ywQWYZQNP5fyCwH/WeJriPe7niEf7u1gnghUTJJumf4+oRY/TBAR854LPVb60rI5eeFHEq6cQdBBHHHWG68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=krhtzC/G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4326GuZf023689;
	Tue, 2 Apr 2024 10:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=cL1vn9tJj3FxDy1xM4DGDV6XOg/UDFJpGMkOvt1yzj4=; b=kr
	htzC/Gy8LtV6zW6QQpgZQKCIzjS46LdBKAEvA/pY5eZTM8aSAET5Jq5afV4HroQb
	fqVklQS/jfLTnayZmND/Hdi0B7pWNmUXA8gUBJyUcx/0aqkJa1ENiIVZYV+3J4xd
	OPbLk9lbXvJbsgPaLjRkqO7YkvJ4b6he+0UOs4RfSqDt2lpIEK3PR4x7UmwXtm4X
	j7uapXdSVDRvssjTcCsXn1fP12tCZY3svCwymMYttLqJMrm38gw4RM1UYLF45F4Z
	i1ruBRDo4MZQStI1cQoDKTouw5ieR/OhtmY+M6KGciWlI8dPyG/2r6jNQfC5wDZp
	Qpo+uafqwDymKCMPehDw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8cm5gmm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 10:34:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432AYo9u012174
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 10:34:50 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 03:34:45 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <quic_varada@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v6 5/6] clk: qcom: ipq9574: Use icc-clk for enabling NoC related clocks
Date: Tue, 2 Apr 2024 16:04:05 +0530
Message-ID: <20240402103406.3638821-6-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402103406.3638821-1-quic_varada@quicinc.com>
References: <20240402103406.3638821-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: WygmSi_lxJPle8N-r6YJSQMKC04K6D6d
X-Proofpoint-ORIG-GUID: WygmSi_lxJPle8N-r6YJSQMKC04K6D6d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_04,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404020076

Use the icc-clk framework to enable few clocks to be able to
create paths and use the peripherals connected on those NoCs.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v6: Move enum to dt-bindings and share between here and DT
    first_id -> icc_first_node_id
v5: Split from common.c changes into separate patch
    No functional changes
---
 drivers/clk/qcom/Kconfig       |  2 ++
 drivers/clk/qcom/gcc-ipq9574.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 8ab08e7b5b6c..af73a0b396eb 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -243,6 +243,8 @@ config IPQ_GCC_8074
 
 config IPQ_GCC_9574
 	tristate "IPQ9574 Global Clock Controller"
+	select INTERCONNECT
+	select INTERCONNECT_CLK
 	help
 	  Support for global clock controller on ipq9574 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
index 0a3f846695b8..646cafcf8f0b 100644
--- a/drivers/clk/qcom/gcc-ipq9574.c
+++ b/drivers/clk/qcom/gcc-ipq9574.c
@@ -12,6 +12,7 @@
 
 #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
 #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
+#include <dt-bindings/interconnect/qcom,ipq9574.h>
 
 #include "clk-alpha-pll.h"
 #include "clk-branch.h"
@@ -4301,6 +4302,32 @@ static const struct qcom_reset_map gcc_ipq9574_resets[] = {
 	[GCC_WCSS_Q6_TBU_BCR] = { 0x12054, 0 },
 };
 
+#define IPQ_APPS_ID			9574	/* some unique value */
+
+static struct clk_hw *icc_ipq9574_hws[] = {
+	[ICC_ANOC_PCIE0] = &gcc_anoc_pcie0_1lane_m_clk.clkr.hw,
+	[ICC_SNOC_PCIE0] = &gcc_anoc_pcie1_1lane_m_clk.clkr.hw,
+	[ICC_ANOC_PCIE1] = &gcc_anoc_pcie2_2lane_m_clk.clkr.hw,
+	[ICC_SNOC_PCIE1] = &gcc_anoc_pcie3_2lane_m_clk.clkr.hw,
+	[ICC_ANOC_PCIE2] = &gcc_snoc_pcie0_1lane_s_clk.clkr.hw,
+	[ICC_SNOC_PCIE2] = &gcc_snoc_pcie1_1lane_s_clk.clkr.hw,
+	[ICC_ANOC_PCIE3] = &gcc_snoc_pcie2_2lane_s_clk.clkr.hw,
+	[ICC_SNOC_PCIE3] = &gcc_snoc_pcie3_2lane_s_clk.clkr.hw,
+	[ICC_SNOC_USB] = &gcc_snoc_usb_clk.clkr.hw,
+	[ICC_ANOC_USB_AXI] = &gcc_anoc_usb_axi_clk.clkr.hw,
+	[ICC_NSSNOC_NSSCC] = &gcc_nssnoc_nsscc_clk.clkr.hw,
+	[ICC_NSSNOC_SNOC_0] = &gcc_nssnoc_snoc_clk.clkr.hw,
+	[ICC_NSSNOC_SNOC_1] = &gcc_nssnoc_snoc_1_clk.clkr.hw,
+	[ICC_NSSNOC_PCNOC_1] = &gcc_nssnoc_pcnoc_1_clk.clkr.hw,
+	[ICC_NSSNOC_QOSGEN_REF] = &gcc_nssnoc_qosgen_ref_clk.clkr.hw,
+	[ICC_NSSNOC_TIMEOUT_REF] = &gcc_nssnoc_timeout_ref_clk.clkr.hw,
+	[ICC_NSSNOC_XO_DCD] = &gcc_nssnoc_xo_dcd_clk.clkr.hw,
+	[ICC_NSSNOC_ATB] = &gcc_nssnoc_atb_clk.clkr.hw,
+	[ICC_MEM_NOC_NSSNOC] = &gcc_mem_noc_nssnoc_clk.clkr.hw,
+	[ICC_NSSNOC_MEMNOC] = &gcc_nssnoc_memnoc_clk.clkr.hw,
+	[ICC_NSSNOC_MEM_NOC_1] = &gcc_nssnoc_mem_noc_1_clk.clkr.hw,
+};
+
 static const struct of_device_id gcc_ipq9574_match_table[] = {
 	{ .compatible = "qcom,ipq9574-gcc" },
 	{ }
@@ -4323,6 +4350,9 @@ static const struct qcom_cc_desc gcc_ipq9574_desc = {
 	.num_resets = ARRAY_SIZE(gcc_ipq9574_resets),
 	.clk_hws = gcc_ipq9574_hws,
 	.num_clk_hws = ARRAY_SIZE(gcc_ipq9574_hws),
+	.icc_hws = icc_ipq9574_hws,
+	.num_icc_hws = ARRAY_SIZE(icc_ipq9574_hws),
+	.icc_first_node_id = IPQ_APPS_ID,
 };
 
 static int gcc_ipq9574_probe(struct platform_device *pdev)
-- 
2.34.1


