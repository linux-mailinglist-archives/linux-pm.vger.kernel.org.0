Return-Path: <linux-pm+bounces-9645-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3619090FE8B
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 10:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C701C21559
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 08:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6785318FC67;
	Thu, 20 Jun 2024 08:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qq2jST3W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC13318EFDB;
	Thu, 20 Jun 2024 08:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871359; cv=none; b=cTGtCLraknQk4AiXH3+tgz8mCXg8VMspX3XzuuOc4cx+vDn5SbsF57R94ENbE4rG3tvZ7ExdRuAN4xdapVKDGjHW0XwhE//gXvKrVBLfbXD/vCgRHSbxAEYqTL4kQdyzkaDB5b6OqLqgQ8Rv1giXUyHBtNXV5AYu+JR8AmE64Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871359; c=relaxed/simple;
	bh=duUqFo7q/BRNlJeiQSXTkZQO0s52Kj2nR4WqXvhN3Mg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJ/xsXn9wh+jlF+TM2go3iIZDi4VyAptdNy0E2u3vMuNYtH7xz11ns4tbFL3m2X5gxgLJ0vCve6QrtacKTIuwl85GIJL7LLnkKaUOniv7QVwljNGUPz9onK/IJbthP4d0nPn3shYSmnBKjpvFhzV9hMFX3R7t3dpG9DdkwoV3JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qq2jST3W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K0lI27024370;
	Thu, 20 Jun 2024 08:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TJrjwLekDYJvRwJMM7JqCobX4z/qWXYab08yaYW7ieE=; b=Qq2jST3WAMHxnSFr
	zE2wezi/ZBRJFVlKApNX7/uMQ7nvZqL5efK6A+W6MU1qS3QEYyXSY+3U4YOJDa29
	ka/iVFJjZ3cx2RiBYTmcSCEcEMjnNY2PSethVCyjSiF0/pR2qHeWjMlrx8FMNIiy
	asVPabDdT1QNNgmktaKso8lEHJjG1dswzigusLapkOL055PO1u9YX6KKEcGYOC2d
	H6Le61ThfGJwYXQxDb0+ZW+LgTFMfc+HUlSjqH6H/zM4MlTK3kR3G7al3EuAwhH6
	RzFARXfZCCQaXQqr7RuInn3uNietucwsNfIOdsfgM74lDAxE9hQXDVtCmPH6RkZu
	XTqpfQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yux152dpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 08:15:42 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45K8FfwS001611
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 08:15:41 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 20 Jun 2024 01:15:34 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>, <quic_sibis@quicinc.com>,
        <quic_rjendra@quicinc.com>, <luca@z3ntu.xyz>, <abel.vesa@linaro.org>,
        <quic_varada@quicinc.com>, <quic_rohiagar@quicinc.com>,
        <danila@jiaxyga.com>, <otto.pflueger@abscue.de>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v1 5/7] clk: qcom: gcc-ipq9574: Add CPR clock definition
Date: Thu, 20 Jun 2024 13:44:25 +0530
Message-ID: <20240620081427.2860066-6-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620081427.2860066-1-quic_varada@quicinc.com>
References: <20240620081427.2860066-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: viXU8ek_YLZ4V38HZC1opKwBL0jnVeV5
X-Proofpoint-ORIG-GUID: viXU8ek_YLZ4V38HZC1opKwBL0jnVeV5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_04,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 mlxscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200058

Add the CPR clock definition needed for enabling access to
CPR register space.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/clk/qcom/gcc-ipq9574.c | 38 ++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
index e1dc74d04ed1..7c8eb94f654b 100644
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
@@ -4219,6 +4256,7 @@ static struct clk_regmap *gcc_ipq9574_clks[] = {
 	[GCC_PCIE1_PIPE_CLK] = &gcc_pcie1_pipe_clk.clkr,
 	[GCC_PCIE2_PIPE_CLK] = &gcc_pcie2_pipe_clk.clkr,
 	[GCC_PCIE3_PIPE_CLK] = &gcc_pcie3_pipe_clk.clkr,
+	[GCC_RBCPR_CLK] = &gcc_rbcpr_clk.clkr,
 };
 
 static const struct qcom_reset_map gcc_ipq9574_resets[] = {
-- 
2.34.1


