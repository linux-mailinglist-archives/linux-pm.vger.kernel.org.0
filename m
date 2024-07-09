Return-Path: <linux-pm+bounces-10811-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BA992B067
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 08:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DABEB1F24AB7
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 06:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6936D149C6C;
	Tue,  9 Jul 2024 06:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nkQLuIRe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B8712D1FA;
	Tue,  9 Jul 2024 06:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720507234; cv=none; b=Cli+iCVxIdVaYwGnRnXcLUCambphRvfvqgIOhxTZlUK3U1F6isbJQFBANj46B5CZcX7NZvRVM21A2W3tZbPZGK4XBUQ4FSCX2KOQ9wvom+MTJ3srI06RPd3JJ3vZk70tqyb1JDfCEKtuAPEXM0E281G7rDEU32bABZiCKAlU9FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720507234; c=relaxed/simple;
	bh=uujak06IW2UNobe/1OqOMtTsXnBMEzOJMT5IF6GThcU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qAFnJr8tjtvDQsGHcy2Su4FXADR23TRCQxhI4Z+STEgyxYKNF9PhZ733/n2hHUO5rjiNj+Zy0+XeGu+XLsUGkjw404Qe0lhvD6iPIXWBg5sB4/VvM54fxYPevIeQgEkFCzJIx0IFm39A5SagMf/4R4W94oRA1Zd8MbZCz9YRsTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nkQLuIRe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468MKMF5000592;
	Tue, 9 Jul 2024 06:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZYLzcmzX3o/k7Zf96ncBXksU+pTLMTaMVKDEr1/C+Yw=; b=nkQLuIRexNHN5x/c
	M8F/Fy/sokFuUIj6VjkFPRKmf/tqCCvA5t0bzZTuT54rFwwBT0WdrMTthYiGEaW7
	XWwVryKlyEOAIqSYKxp6QQ2gvuRJv9VL6Z1jUEbLB4/vfKcVtu3DOvN/cNEiOa2F
	QG/gGU7655xyue6Q77PSBSFpyy/bf2wjOflNLUEnOMr84sK1sVAjPhUbvDoOl5s7
	HTmlFF1i91edgMwbCAArs1wMZKYqWWUEECwnNaRE6hRiFJawHF+KVz9FjdDbxSzB
	yv6/IcxIPCW0CIKesvmE5YUECdzfG4HCH6T4q3nKTfc2oA2OtZMsYKExo+OL49tE
	RzBsNg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wjn5rxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 06:40:27 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4696eHdD022927
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 06:40:17 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 8 Jul 2024 23:40:12 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v1 2/3] clk: qcom: ipq5332: Use icc-clk for enabling NoC related clocks
Date: Tue, 9 Jul 2024 12:09:47 +0530
Message-ID: <20240709063949.4127310-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709063949.4127310-1-quic_varada@quicinc.com>
References: <20240709063949.4127310-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Jur4ZDXIQuS8Gf2MMqrj0ZEIKNcxPrum
X-Proofpoint-GUID: Jur4ZDXIQuS8Gf2MMqrj0ZEIKNcxPrum
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090044

Use the icc-clk framework to enable few clocks to be able to
create paths and use the peripherals connected on those NoCs.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/clk/qcom/gcc-ipq5332.c | 36 +++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index f98591148a97..6d7672cae0f7 100644
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
@@ -131,12 +133,14 @@ static struct clk_alpha_pll gpll4_main = {
 			 * (will be added soon), so the clock framework
 			 * disables this source. But some of the clocks
 			 * initialized by boot loaders uses this source. So we
-			 * need to keep this clock ON. Add the
-			 * CLK_IGNORE_UNUSED flag so the clock will not be
-			 * disabled. Once the consumer in kernel is added, we
-			 * can get rid of this flag.
+			 * need to keep this clock ON.
+			 *
+			 * After initial bootup, when the ICC framework turns
+			 * off unused paths, as part of the icc-clk dependencies
+			 * this clock gets disabled resulting in a hang. Marking
+			 * it as critical to ensure it is not turned off.
 			 */
-			.flags = CLK_IGNORE_UNUSED,
+			.flags = CLK_IS_CRITICAL,
 		},
 	},
 };
@@ -3628,6 +3632,24 @@ static const struct qcom_reset_map gcc_ipq5332_resets[] = {
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
@@ -3656,6 +3678,9 @@ static const struct qcom_cc_desc gcc_ipq5332_desc = {
 	.num_resets = ARRAY_SIZE(gcc_ipq5332_resets),
 	.clk_hws = gcc_ipq5332_hws,
 	.num_clk_hws = ARRAY_SIZE(gcc_ipq5332_hws),
+	.icc_hws = icc_ipq5332_hws,
+	.num_icc_hws = ARRAY_SIZE(icc_ipq5332_hws),
+	.icc_first_node_id = IPQ_APPS_ID,
 };
 
 static int gcc_ipq5332_probe(struct platform_device *pdev)
@@ -3674,6 +3699,7 @@ static struct platform_driver gcc_ipq5332_driver = {
 	.driver = {
 		.name = "gcc-ipq5332",
 		.of_match_table = gcc_ipq5332_match_table,
+		.sync_state = icc_sync_state,
 	},
 };
 
-- 
2.34.1


