Return-Path: <linux-pm+bounces-11284-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EB49388A5
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 07:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C221C20E36
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 05:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD09C18044;
	Mon, 22 Jul 2024 05:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CjZRxrlG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB1228DCB;
	Mon, 22 Jul 2024 05:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721627784; cv=none; b=BqyWcNPiKxRu+JbhU74QvRGySdC7+1UJI0eS597DpRvur0I+fXV38lw/OaWesNj77+nJ505zAEoT6/TIH76EjvA8L9sEJyGXN9A2YbpOHVVQQu+tTJQE9fTWgMIznW/Ol4MNC9R0Av2U6w2YWyqTp+ijPl0dgDZiQ9bjR+pN6zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721627784; c=relaxed/simple;
	bh=uXJGW7j0GbOBC4uBh1DnGRPRO5viTlhGyeGPID9VfIU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnXGRCrJOyS8IG1Yi9tlK43ZLTuG50jHfuAXtGODRhR4dOgkHK/aXXp4DXc+/PyBdSzFQEwbj6RwfgtApRigOj3yfhepx18y5oBgLiR00GjRtSopwkje4FC5cmSxqB7tm7x6a0XaIfifBj6iO01iycDE8FekOpsct4fD8yfRi3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CjZRxrlG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46LN6Jpp007911;
	Mon, 22 Jul 2024 05:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yQemGNbl/sd1tzOGKg3TAHVXEVhprYL2EkuReDXWr7o=; b=CjZRxrlGr+jSMWH+
	B3Si6peQIEckGjb31CyTxa4eikCtdt52me1MEPIy0JIETrjFSUCXGEmfesHpr0VV
	SGXAMOuvvvVwfXb1vHf/TSPlvtukiCTnCTjfH1K6j/VyJ0rsi3QokypBiNkFdVOD
	tiHlRbZMnMtr3Jk0xSQGwsOK0yVar05zuxOxsX3kaUYzfogVi9YGUtQ2o9GLaVvv
	AAVGZhM13GSHyRn+yUWqq3DjDq6p1r8gfj0DLgLmyO0peegbWJ8iLl8fx7qhns4S
	fUrMAnVlxEkjC71CopWCsp+3Mau6EJFv7V/X7ypXXJfyz57t8fiAxMd2mhZL9TkM
	uTUtrg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g4jgtrc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 05:56:18 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46M5uHOd012912
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 05:56:17 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 21 Jul 2024 22:56:12 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <konrad.dybcio@linaro.org>,
        <djakov@kernel.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v3 4/5] clk: qcom: ipq5332: Use icc-clk for enabling NoC related clocks
Date: Mon, 22 Jul 2024 11:25:38 +0530
Message-ID: <20240722055539.2594434-5-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722055539.2594434-1-quic_varada@quicinc.com>
References: <20240722055539.2594434-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: gslsfuTmAbYaO79jEoUMozO8nRJEPpSR
X-Proofpoint-GUID: gslsfuTmAbYaO79jEoUMozO8nRJEPpSR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_02,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407220044

Use the icc-clk framework to enable few clocks to be able to
create paths and use the peripherals connected on those NoCs.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v3: Not taking Reviewed-by: Konrad as NAK-ed by Dmitry
    Remove CLK_IGNORE_UNUSED -> CLK_IS_CRITICAL change and fix
    that in a separate patch
---

 drivers/clk/qcom/gcc-ipq5332.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index 237b6a766179..9536b2b7d07c 100644
--- a/drivers/clk/qcom/gcc-ipq5332.c
+++ b/drivers/clk/qcom/gcc-ipq5332.c
@@ -4,12 +4,14 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/interconnect-provider.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
+#include <dt-bindings/interconnect/qcom,ipq5332.h>
 
 #include "clk-alpha-pll.h"
 #include "clk-branch.h"
@@ -3618,6 +3620,24 @@ static const struct qcom_reset_map gcc_ipq5332_resets[] = {
 	[GCC_UNIPHY1_XPCS_ARES] = { 0x16060 },
 };
 
+#define IPQ_APPS_ID			5332	/* some unique value */
+
+static struct qcom_icc_hws_data icc_ipq5332_hws[] = {
+	{ MASTER_SNOC_PCIE3_1_M, SLAVE_SNOC_PCIE3_1_M, GCC_SNOC_PCIE3_1LANE_M_CLK },
+	{ MASTER_ANOC_PCIE3_1_S, SLAVE_ANOC_PCIE3_1_S, GCC_SNOC_PCIE3_1LANE_S_CLK },
+	{ MASTER_SNOC_PCIE3_2_M, SLAVE_SNOC_PCIE3_2_M, GCC_SNOC_PCIE3_2LANE_M_CLK },
+	{ MASTER_ANOC_PCIE3_2_S, SLAVE_ANOC_PCIE3_2_S, GCC_SNOC_PCIE3_2LANE_S_CLK },
+	{ MASTER_SNOC_USB, SLAVE_SNOC_USB, GCC_SNOC_USB_CLK },
+	{ MASTER_NSSNOC_NSSCC, SLAVE_NSSNOC_NSSCC, GCC_NSSNOC_NSSCC_CLK },
+	{ MASTER_NSSNOC_SNOC_0, SLAVE_NSSNOC_SNOC_0, GCC_NSSNOC_SNOC_CLK },
+	{ MASTER_NSSNOC_SNOC_1, SLAVE_NSSNOC_SNOC_1, GCC_NSSNOC_SNOC_1_CLK },
+	{ MASTER_NSSNOC_ATB, SLAVE_NSSNOC_ATB, GCC_NSSNOC_ATB_CLK },
+	{ MASTER_NSSNOC_PCNOC_1, SLAVE_NSSNOC_PCNOC_1, GCC_NSSNOC_PCNOC_1_CLK },
+	{ MASTER_NSSNOC_QOSGEN_REF, SLAVE_NSSNOC_QOSGEN_REF, GCC_NSSNOC_QOSGEN_REF_CLK },
+	{ MASTER_NSSNOC_TIMEOUT_REF, SLAVE_NSSNOC_TIMEOUT_REF, GCC_NSSNOC_TIMEOUT_REF_CLK },
+	{ MASTER_NSSNOC_XO_DCD, SLAVE_NSSNOC_XO_DCD, GCC_NSSNOC_XO_DCD_CLK },
+};
+
 static const struct regmap_config gcc_ipq5332_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
@@ -3646,6 +3666,9 @@ static const struct qcom_cc_desc gcc_ipq5332_desc = {
 	.num_resets = ARRAY_SIZE(gcc_ipq5332_resets),
 	.clk_hws = gcc_ipq5332_hws,
 	.num_clk_hws = ARRAY_SIZE(gcc_ipq5332_hws),
+	.icc_hws = icc_ipq5332_hws,
+	.num_icc_hws = ARRAY_SIZE(icc_ipq5332_hws),
+	.icc_first_node_id = IPQ_APPS_ID,
 };
 
 static int gcc_ipq5332_probe(struct platform_device *pdev)
@@ -3664,6 +3687,7 @@ static struct platform_driver gcc_ipq5332_driver = {
 	.driver = {
 		.name = "gcc-ipq5332",
 		.of_match_table = gcc_ipq5332_match_table,
+		.sync_state = icc_sync_state,
 	},
 };
 
-- 
2.34.1


