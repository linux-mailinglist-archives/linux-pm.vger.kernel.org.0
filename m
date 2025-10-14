Return-Path: <linux-pm+bounces-36078-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AD1BDA0CC
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 16:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED8A834B311
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 14:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949823002B4;
	Tue, 14 Oct 2025 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UBJKRBlb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20762D8DD0;
	Tue, 14 Oct 2025 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452591; cv=none; b=eleqlvkT8bi0FeWjR6+5lub5hn+eg8LKXOxwXojSsNTSbYCynnvIfWDNIUqKiDdrIox+san/Em25Q6uiPpJoBuBHWXNmQ5e33juiL+3n4lj25/AqEIoQQWfzULNOgW5MGmCoItUaNjCVmT2KUILzo4XtAxM7D72wQLqJrlvUoFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452591; c=relaxed/simple;
	bh=Eimgia/Bx+eO8L8UJ+aEbzz/pUw0klt6lj4m5EBC2Fk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=X1Z7aRcLXCJh5lNCchKWOQy9Mrgtr2NOvqbartROIK92YVPXqI5qerNt8V3f6lNfzBkUUp2KgUSOzDE1RCom+tINqnfh3BITd4G4HM898nkMQXkvIayNbv/sAwTBR85qud2X8KEb9B5bCAd4ZtIQ8JtYwDxCXT0Tke1NvJKnlJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UBJKRBlb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87PjU016826;
	Tue, 14 Oct 2025 14:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OjqkTZoCAD9ovROFl0rX5aKoq7H9e/i+GzLPj/Z2kg4=; b=UBJKRBlbdI2kMFeD
	1HgEgrxoulLjJbIL4i6C/uJJxklKlFi9QRqiHymiAGlJ/TbG6ODl/9exCeTJGKMx
	F/q7CB6zePcRgGrjSdo18sjlnpLU1+2K06C3EdYAbOAaOR03RGT8VXkVwC2yN+GH
	R0zIeC9CSsVDGYp5zADpD9S1Q6Q/vcIoVOfk3akCj5d1Ulj6QzQN1ZlbTfVgCK2Q
	Xt2rAs8StJ9FssYSLjFhe2Y5bhCWS7akBJPvbHhpJQCgx0xxv5TzC8G+7EOAiXbu
	5R3nKy6NIgUw4DKtIv6nnx2wUd1XuE0o3l/uLV6fxDqInSX7x9IK851L9f9W9oZb
	j/880w==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd90x1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 14:36:16 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59EEaFvD007296
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 14:36:15 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 14 Oct 2025 07:36:10 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Tue, 14 Oct 2025 22:35:31 +0800
Subject: [PATCH v7 06/10] clk: qcom: gcc-ipq5424: Add gpll0_out_aux clock
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251014-qcom_ipq5424_nsscc-v7-6-081f4956be02@quicinc.com>
References: <20251014-qcom_ipq5424_nsscc-v7-0-081f4956be02@quicinc.com>
In-Reply-To: <20251014-qcom_ipq5424_nsscc-v7-0-081f4956be02@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Varadarajan
 Narayanan" <quic_varada@quicinc.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "Anusha Rao" <quic_anusha@quicinc.com>,
        Devi Priya
	<quic_devipriy@quicinc.com>,
        Manikanta Mylavarapu
	<quic_mmanikan@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad
 Dybcio <konradybcio@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <netdev@vger.kernel.org>, <quic_kkumarcs@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>,
        <quic_pavir@quicinc.com>, <quic_suruchia@quicinc.com>,
        Luo Jie <quic_luoj@quicinc.com>,
        Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760452536; l=1385;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=Eimgia/Bx+eO8L8UJ+aEbzz/pUw0klt6lj4m5EBC2Fk=;
 b=edh9y0hKBvQOKrvRZp1rWGcyf7KNj0/Iv0O7aa3ySaP2I0MuyzgrVGsIHKg2wK5GUY/+chooD
 OFizOqlS7pwDtJGqAYteC0dHJ1JscIS79o6/rFHB2u3K/gATNtwfuLz
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gqonthmFeqpkyVkFZA9Nts9Th0lSBinP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX356slI6MM32t
 30fcazyi7W8LD61EdC+TAomGiwB+aSYgRsysQu0YYNeq8xKseIY9BfA5eI3wh5WMNF8FxloRbth
 as/55TjvdDRXnhKf3qQzqYjkpl09gU4qxEPF1BW1tctWEgE/OHzdELIayeJ4ZTHyezVGEKSHSSH
 Oowbyj5f3VWpAtBBuoSfB7w4eXuUxtp5i8Eg7bI2P2zNzpY8YulJuKkxo6ulvtE2nfLPh7hyeAG
 4ba0+mNQ4DOJppsUYHJRHuBvX4szFPLXoVYEzOj+PJMy879/oU0iEIHyxVdLQoW2AXOs+fMYd4/
 YvkDTPh2ZwvIV3y8eSO6jBlJIQdXug0cEZ5Qk9dRlghLKXbLykQLejYEzh490GYlmDnZNWCJwOe
 gbWLr0TdnvTpqnzCoJHScaHOe4Ki8Q==
X-Proofpoint-GUID: gqonthmFeqpkyVkFZA9Nts9Th0lSBinP
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68ee5fe0 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=PgHBclK_Yek0rHWKhOgA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

The clock gpll0_out_aux acts as the parent clock for some of the NSS
(Network Subsystem) clocks.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/clk/qcom/gcc-ipq5424.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq5424.c b/drivers/clk/qcom/gcc-ipq5424.c
index 6cfe4f2b2888..35af6ffeeb85 100644
--- a/drivers/clk/qcom/gcc-ipq5424.c
+++ b/drivers/clk/qcom/gcc-ipq5424.c
@@ -79,6 +79,20 @@ static struct clk_fixed_factor gpll0_div2 = {
 	},
 };
 
+static struct clk_alpha_pll_postdiv gpll0_out_aux = {
+	.offset = 0x20000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gpll0_out_aux",
+		.parent_hws = (const struct clk_hw *[]) {
+			&gpll0.clkr.hw
+		},
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_postdiv_ro_ops,
+	},
+};
+
 static struct clk_alpha_pll gpll2 = {
 	.offset = 0x21000,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_NSS_HUAYRA],
@@ -2934,6 +2948,7 @@ static struct clk_regmap *gcc_ipq5424_clocks[] = {
 	[GPLL2] = &gpll2.clkr,
 	[GPLL2_OUT_MAIN] = &gpll2_out_main.clkr,
 	[GPLL4] = &gpll4.clkr,
+	[GPLL0_OUT_AUX] = &gpll0_out_aux.clkr,
 };
 
 static const struct qcom_reset_map gcc_ipq5424_resets[] = {

-- 
2.34.1


