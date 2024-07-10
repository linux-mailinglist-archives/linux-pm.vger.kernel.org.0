Return-Path: <linux-pm+bounces-10910-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9C192CA91
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 08:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A73B1F21A51
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 06:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114DE7BB0A;
	Wed, 10 Jul 2024 06:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cfXl5xQ6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1BF57CB6;
	Wed, 10 Jul 2024 06:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720591953; cv=none; b=OiqZLYG57JtOUagernf80QXgUuFusqpmQLyypP+PkSLFk7c/TOCQ4Lbisr8boE4dVDOflFobrfyZdxIxmzqQo46Nz70H8qawKXL8/cvQU6+WjUPIgu1A7AFUgzeTpBlJqcTio1OzKAu0RCsJi9DUm4LImzap9lDU4ZXXkzGYKAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720591953; c=relaxed/simple;
	bh=NbghBCuv6Z9GqbuZNLOUww8AHwyziSDpjlICfOPy36A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbpsG2E9HgY0hnKlA/ax7ocMN3LBBgoMHrciNr1s8oojTJTWlIaQWsDKyY8thpwkp0DGdwkiiEzCtEWWsPLYKwhIfbsKfqLVegE0aAJLu9llVqa3jXuYVuAbdyf919oBdNxFcngkUOid3YMFsCoFJm5pbaU77F9FS/Ufeg/UQsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cfXl5xQ6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469MV6Mu031488;
	Wed, 10 Jul 2024 06:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b7L/FBiJ5rwG+vtCCzRfyxibTJlnj405qJWswdSeEWc=; b=cfXl5xQ6q5MAsOrE
	HK/HiozEB/2Bsd8qgATZ3Ernve2tyViHlN+cRRhxMwCmj1CAfP+RuyVUbOPmpKy7
	xCd+pVfbB8SCkBNtW7Ac6LN9eS89dYxgFFOa7LfdQa9+ZwX4wQYNsK1LyV2XGtKr
	v7mQnERk8S+yacK/UQde+3q8i8pxxeAkjn65RzhwI3rIxiPNyee2KMN86qKCcaLW
	81+RlXKeyouCkiflRvgZt2rcOd9Jn6Xf1eYhK/ehuxFv05xeiVcIvSh++5XYoCXT
	AfJMjccswXUSKX4MHSseNUugfUyxwcVr4ShyH94uBXx0qBM9Bz60MKZenRU93ifT
	rL3syw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wgwrcat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 06:12:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46A6CHJR026269
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 06:12:17 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 9 Jul 2024 23:12:10 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <ilia.lin@kernel.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <ulf.hansson@linaro.org>, <quic_sibis@quicinc.com>,
        <quic_rjendra@quicinc.com>, <danila@jiaxyga.com>,
        <quic_varada@quicinc.com>, <neil.armstrong@linaro.org>,
        <otto.pflueger@abscue.de>, <abel.vesa@linaro.org>, <luca@z3ntu.xyz>,
        <geert+renesas@glider.be>, <stephan.gerhold@kernkonzept.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v6 7/9] clk: qcom: gcc-ipq9574: Add CPR clock definition
Date: Wed, 10 Jul 2024 11:41:00 +0530
Message-ID: <20240710061102.1323550-8-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710061102.1323550-1-quic_varada@quicinc.com>
References: <20240710061102.1323550-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: qdznHAP2ff9NesnUHJJSYM3Q9WV2vfKa
X-Proofpoint-ORIG-GUID: qdznHAP2ff9NesnUHJJSYM3Q9WV2vfKa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100046

Add the CPR clock definition needed for enabling access to
CPR register space.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/clk/qcom/gcc-ipq9574.c | 39 ++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
index e1dc74d04ed1..eac557937fd3 100644
--- a/drivers/clk/qcom/gcc-ipq9574.c
+++ b/drivers/clk/qcom/gcc-ipq9574.c
@@ -3994,6 +3994,43 @@ static struct clk_branch gcc_xo_div4_clk = {
 	},
 };
 
+static const struct freq_tbl ftbl_hmss_rbcpr_clk_src[] = {
+	F(24000000, P_XO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 rbcpr_clk_src = {
+	.cmd_rcgr = 0x48044,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_xo_map,
+	.freq_tbl = ftbl_gp1_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "rbcpr_clk_src",
+		.parent_data = gcc_xo_gpll0_gpll4,
+		.num_parents = ARRAY_SIZE(gcc_xo_map),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_branch gcc_rbcpr_clk = {
+	.halt_reg = 0x48008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x48008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_rbcpr_clk",
+			.parent_hws = (const struct clk_hw *[]) {
+				&rbcpr_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_hw *gcc_ipq9574_hws[] = {
 	&gpll0_out_main_div2.hw,
 	&gcc_xo_div4_clk_src.hw,
@@ -4219,6 +4256,8 @@ static struct clk_regmap *gcc_ipq9574_clks[] = {
 	[GCC_PCIE1_PIPE_CLK] = &gcc_pcie1_pipe_clk.clkr,
 	[GCC_PCIE2_PIPE_CLK] = &gcc_pcie2_pipe_clk.clkr,
 	[GCC_PCIE3_PIPE_CLK] = &gcc_pcie3_pipe_clk.clkr,
+	[GCC_RBCPR_CLK_SRC] = &rbcpr_clk_src.clkr,
+	[GCC_RBCPR_CLK] = &gcc_rbcpr_clk.clkr,
 };
 
 static const struct qcom_reset_map gcc_ipq9574_resets[] = {
-- 
2.34.1


