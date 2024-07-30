Return-Path: <linux-pm+bounces-11625-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 350129407DA
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 07:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62DA1F233DA
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 05:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74C418FDD3;
	Tue, 30 Jul 2024 05:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OEd1Fd7U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2296A16B3B7;
	Tue, 30 Jul 2024 05:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722318546; cv=none; b=ZXsX1xb5AKFfiKGdN1fX15oc3xq+fRpi2rrhgkIj2tkhKbY0tz61VOp94ofep3j9KyYFXPV96+A+iG+86HKGR4KxXPDrKFuJbb1TVsXQUEg4r/GD1uo22ZCESRlGHWWTrukVYbRxZr8XSeooufJXvdsh1evhYewNi47SD6Q3RUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722318546; c=relaxed/simple;
	bh=kQuvP/hIIoHz2ZH+UtUdLvtsuRleCLhV5s38dwoPd/I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJcHwgvsreX6QLjzyrc9jkQULQirXYWNPHGh51Scoc8+24+F4pCWjsC0T82OMpcanO/dEkPNIraN2pDfTsd9HywqPwh6QZKjPKTWec0oXPJ9/DiUJgJmW5qEJ/NC6+lZE3TzeTzqhbwQt5KpK/9E886hoyxzT6+Tlw+hxh4FpcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OEd1Fd7U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TLXl0J017247;
	Tue, 30 Jul 2024 05:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b+4SOmcQ3t5clOw5uhJ7I63u0QWihO0nameHvI508Jk=; b=OEd1Fd7UiTIIKq5O
	tWLDJfwmSZRljhPFdO3SoNCreC6dSNa61eRY5kR8Hlh03dYh9WE7LmU4UUnQZ8HL
	8GraCRoGJI+2FSfhUIp5OgbZ+WbuAqxRBSplYmJ1JCqmWMYGB0bi547XzgaMLwNX
	/C8a8rvhuZ9ar0fGEa2i6Cc2ro1mO2/tIB3VcQcjY8d0ALOrTmwm3GJeRsIvERBP
	EpgexDWjBiQZQseHtAvqxzVaKa8BSxAYVje+CRIiTsaY6SoitHNQI74ZIWjGoNnk
	ROLwVqSVyrScks08ManhH6Zswer8PZVmZ0eSbPIoBshlQx3+EqhDtKgIUlCN54in
	evvbew==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mrytxagg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 05:48:59 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46U5mw6O011072
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 05:48:58 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Jul 2024 22:48:52 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <konrad.dybcio@linaro.org>,
        <djakov@kernel.org>, <quic_wcheng@quicinc.com>,
        <quic_kathirav@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
Subject: [PATCH v6 4/5] clk: qcom: ipq5332: Use icc-clk for enabling NoC related clocks
Date: Tue, 30 Jul 2024 11:18:16 +0530
Message-ID: <20240730054817.1915652-5-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730054817.1915652-1-quic_varada@quicinc.com>
References: <20240730054817.1915652-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: _U4Wi9YRK4Cyjmj8g5c1g1r4VPB8pndV
X-Proofpoint-GUID: _U4Wi9YRK4Cyjmj8g5c1g1r4VPB8pndV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_05,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300042

Use the icc-clk framework to enable few clocks to be able to
create paths and use the peripherals connected on those NoCs.

Remove CLK_IGNORE_UNUSED from gpll4_main as all consumers have
been identified.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v5: Add 'Reviewed-by: Dmitry Baryshkov'

v4: Remove CLK_IGNORE_UNUSED from gpll4_main

v3: Not taking Reviewed-by: Konrad as NAK-ed by Dmitry
    Remove CLK_IGNORE_UNUSED -> CLK_IS_CRITICAL change and fix
    that in a separate patch
---
 drivers/clk/qcom/gcc-ipq5332.c | 35 +++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index 6a4877d88829..9536b2b7d07c 100644
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
@@ -126,17 +128,6 @@ static struct clk_alpha_pll gpll4_main = {
 			.parent_data = &gcc_parent_data_xo,
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_stromer_ops,
-			/*
-			 * There are no consumers for this GPLL in kernel yet,
-			 * (will be added soon), so the clock framework
-			 * disables this source. But some of the clocks
-			 * initialized by boot loaders uses this source. So we
-			 * need to keep this clock ON. Add the
-			 * CLK_IGNORE_UNUSED flag so the clock will not be
-			 * disabled. Once the consumer in kernel is added, we
-			 * can get rid of this flag.
-			 */
-			.flags = CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -3629,6 +3620,24 @@ static const struct qcom_reset_map gcc_ipq5332_resets[] = {
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
@@ -3657,6 +3666,9 @@ static const struct qcom_cc_desc gcc_ipq5332_desc = {
 	.num_resets = ARRAY_SIZE(gcc_ipq5332_resets),
 	.clk_hws = gcc_ipq5332_hws,
 	.num_clk_hws = ARRAY_SIZE(gcc_ipq5332_hws),
+	.icc_hws = icc_ipq5332_hws,
+	.num_icc_hws = ARRAY_SIZE(icc_ipq5332_hws),
+	.icc_first_node_id = IPQ_APPS_ID,
 };
 
 static int gcc_ipq5332_probe(struct platform_device *pdev)
@@ -3675,6 +3687,7 @@ static struct platform_driver gcc_ipq5332_driver = {
 	.driver = {
 		.name = "gcc-ipq5332",
 		.of_match_table = gcc_ipq5332_match_table,
+		.sync_state = icc_sync_state,
 	},
 };
 
-- 
2.34.1


