Return-Path: <linux-pm+bounces-9857-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650609141B4
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 07:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961E31C232D7
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 05:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C125018039;
	Mon, 24 Jun 2024 05:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gqSeoqbH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4682D28DCB;
	Mon, 24 Jun 2024 05:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719205445; cv=none; b=DValFeq0s5saHYjv/wukxpAjuml4Nc8Xt7FG5bDg5G37Et42NsEsonUSzNeLGpMiXaNAeRRD/DCFCXNFLgXnVD2ns4CasvP50tl65h1WLh2KtPASGAIRNXCpfpn+7+mIhpEWXGPdEVdKOGQKL1iOgx9XlcXXiDCV6V598Xqvpbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719205445; c=relaxed/simple;
	bh=5RxuKcf7K9zofoL9ePsHYvi09cxUmvZ24agf1PozIBk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GN2krPL85j5gbA+Ez/XqnmEQNMSu1ts5/wYnAHa0c9ZHOFY41/qqQfXXaW9SoQQ85l5NqMzDa+/YsfRm7dHfH/xDbm8iaDyrtu/hBNlvPpZrmco8VahQ+NiODTbFU148B6S6IXZ9040kkWAtJBReVe1IkSif7aLYwKCJdmW+TsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gqSeoqbH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45NNeA9T014121;
	Mon, 24 Jun 2024 05:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tVSeLNWCKCxDnsAP89koARmZVHGv6ANuXSLVVpmFJdM=; b=gqSeoqbH2gEKh1dc
	3Ys+6BnmB0LB4n4aJHrWFb3tiTiaHSuZy8Zs5/wEdqu3ejgcIlBfJs9X1WwfLAQ3
	WjncDRApNoh0BsYq0jukHGzJVWRADDRVqr9s/88qFplZUK1LkhWO8uwHgf0njKRe
	/Zxnd2tGch5to1LJB7o/P+9EGliVlMQIEAlz6MmQUsvKCOcWwDqDnxnlTVjrSc1q
	ItpqxbSGuyQgk8qa74yWId36vJm/ydSzCVwe48FxNtubCbXa+4KGU+2BCdZcy3rT
	wH/9KRxfYyrBCsr+Q40gd4ehafRPTyGFb547oTsF9fVR+G58bhIhrnJqFvfjPUtR
	3KWmJA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywq072m1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 05:03:57 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45O53uOW019979
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 05:03:56 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 23 Jun 2024 22:03:50 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>, <quic_sibis@quicinc.com>,
        <abel.vesa@linaro.org>, <otto.pflueger@abscue.de>,
        <quic_rohiagar@quicinc.com>, <quic_varada@quicinc.com>,
        <luca@z3ntu.xyz>, <quic_ipkumar@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v2 5/7] clk: qcom: gcc-ipq9574: Add CPR clock definition
Date: Mon, 24 Jun 2024 10:32:52 +0530
Message-ID: <20240624050254.2942959-6-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624050254.2942959-1-quic_varada@quicinc.com>
References: <20240624050254.2942959-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: AmgOaITc3MKwIquDDCOGyLaxltRo3GeM
X-Proofpoint-GUID: AmgOaITc3MKwIquDDCOGyLaxltRo3GeM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_04,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240038

Add the CPR clock definition needed for enabling access to
CPR register space.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v2: Add rbcpr_clk_src to gcc_ipq9574_hws for registration.
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


