Return-Path: <linux-pm+bounces-33238-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597A8B39A1D
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 12:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49FE37A8C16
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 10:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BF830F547;
	Thu, 28 Aug 2025 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SNghZTfX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39E130DD03;
	Thu, 28 Aug 2025 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377257; cv=none; b=bBhQmmUufk7cyNkumub75GjtTn9wBXO4WlnOQWHF/dC7sJbbUJ+wGjfMuJtxQoP64UmqG4e7/a0sBGVuQFqEftbYbkoKpLAQKi3w9wGlScI7NlatgObSq6LEAvkZQ/jL7SCaOyU/tXOoSxkaQxdbfZ69H9galEe8DrXJOJlaj4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377257; c=relaxed/simple;
	bh=c5DT48aoQZ7X1knBYe5rOYCGp5wD2CLxegvkvTJRTO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ckWeARIwg4RyhHszeMPcAaqNreyI0uFB0izF3VG1OYIgvYoyQyBDypjmBQR/TKv3WzCc+/+MnYCUiURdIM2c60hbkhoXSs2yNFWYPBKIgcs4JMgjaHoAh/sJxQH22LFEmCSBkHD+ZAgw0MlZucSiBZv1Eku4lOeWDNVYJ1MjA+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SNghZTfX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S5Vqo4015944;
	Thu, 28 Aug 2025 10:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r8pQz1QIEGJgZvutXOiXYNtH4SYE0ARV5y1Y1rxJJgc=; b=SNghZTfX5P/NIjRE
	g3OTI0S1VPHPe7deGgEvKD5pCTaGI49rgwJxvSEY4+JiSoi/AYPTcQNzloZrcxzi
	hxxIvlb9Ld4mlkkrdQ2BGKHa2V0es8r1hL2xx5Jp1NOJaxcES917+SzLDDSZcAxQ
	GsNn7XUjvejgubtEo5TocwWooylJKLNwbIf0wZBLkh6eCQJ7SDxECoDCcCp51ZRA
	6q0dVTAyxPw5W9jC1xdLs5vi1TgnA6ZCPOMFaSCjL4dqL0gs9bPioruBPJiiaMnC
	WJGyp4eyCvfUwTNjivSt53IVHB73Q/zF5G5H0R/cKUC5M/ue/p1LSCxPMN5N7643
	HLcdrA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48rtpf26gp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 10:34:04 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57SAY3BC008798
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 10:34:03 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 28 Aug 2025 03:33:57 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 28 Aug 2025 18:32:18 +0800
Subject: [PATCH v4 05/10] clk: qcom: gcc-ipq5424: Add gpll0_out_aux clock
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250828-qcom_ipq5424_nsscc-v4-5-cb913b205bcb@quicinc.com>
References: <20250828-qcom_ipq5424_nsscc-v4-0-cb913b205bcb@quicinc.com>
In-Reply-To: <20250828-qcom_ipq5424_nsscc-v4-0-cb913b205bcb@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Varadarajan
 Narayanan" <quic_varada@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        "Manikanta Mylavarapu" <quic_mmanikan@quicinc.com>,
        Devi Priya
	<quic_devipriy@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Richard
 Cochran" <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <quic_kkumarcs@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_suruchia@quicinc.com>, Luo Jie
	<quic_luoj@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756377204; l=1324;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=c5DT48aoQZ7X1knBYe5rOYCGp5wD2CLxegvkvTJRTO0=;
 b=AizbfJR2Oz7kfLBj8JllV9ezzSobleg17Dv8YOwVDPo9dJylIoBSVZKuHbWWIO2IyLZDbA7vj
 0C0Lgq64i0YDqFPMG27qDBNkuFbYoxYCnoKL0vJzYDiygkatDK3BQ0k
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fP1gcbK9RQwOeUUdVoQvCUOFbmxOL3do
X-Proofpoint-ORIG-GUID: fP1gcbK9RQwOeUUdVoQvCUOFbmxOL3do
X-Authority-Analysis: v=2.4 cv=Hd8UTjE8 c=1 sm=1 tr=0 ts=68b0309c cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8
 a=PgHBclK_Yek0rHWKhOgA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE0MiBTYWx0ZWRfX4uhnHCHkRBuF
 mcz/h1VjvQVP5We+U397741ycpndCWIcD4s8zO4/9IOERpcCLrd90Uw9XhrLxns/XsnuaiIVrNj
 vo7aRzD73w0lq0NaHK3uLJUocygrgBcPEQggp/dJwYFmEJTPBGRcTK2PKAbuXg5gE+2Eusn65Tb
 xglksKdv1KCNbPZfzz2mkib/i2mdguB+zVMco5uwyoTt74Lj/1YEY/id3iQ0OfIiRTcB9iKs9+i
 IhjoL4ggNi9awtAw/w2SrYSbvSLAyQ5yXbuNa8uVNsNlDgZYoOHZOjn/qlEl2EeOucY2WDojI9j
 mIa56ClNy5r7BF471AGr05q3U/mj1akbWswxz0lK+Gv6NXngXDQcJoLRHHUrMWf2/8AgsbTGJb6
 nZkNs7vY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250142

The clock gpll0_out_aux acts as the parent clock for some of the NSS
(Network Subsystem) clocks.

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


