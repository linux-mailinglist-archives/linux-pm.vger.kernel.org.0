Return-Path: <linux-pm+bounces-33236-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A1CB39A27
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 12:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760D61882413
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 10:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D232830E0D6;
	Thu, 28 Aug 2025 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dsmprmql"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AD130E0CE;
	Thu, 28 Aug 2025 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377243; cv=none; b=BNNAWBJpaL+C8dHVPlfrNCR+exWIlxVJUKBKecg2t71LqPhruvr/6GfoeUOhuzVsVoZyYJE7r9Jd8gS8VaQMGxhrs/ynWxzzuI08bcGQKIdqUXAmNX4mWfRHIYWbOxfPqxeNmZWHEfjjqE/0c+745rxF7jKFigr+1mZdcSZrVNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377243; c=relaxed/simple;
	bh=fyHtiJAwSvuzku/slW+IcAT+Y1UhAHWKMtyHX/RJmN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bRyoZyRQJZS1zs7W6GCAiINSND1kQRbUBLLK3ZqpTHC+U2ugXDjHlr3+8lTkUVX29/XuHAYkC6JQnsJWo84Nz+6vsFrUvFhAaJcqIvkD3zh7Hsl+eKQghNm81NBCywzlNVceQ6u0t54bP7ODBALQMFyh1xOWVw6UFBv1/HtOuqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Dsmprmql; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S1igAK005504;
	Thu, 28 Aug 2025 10:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W8AuT7qUjLVbgbZj3ofs9pXzbxBhhVA2Da78pL9QTwo=; b=Dsmprmqly5Pjfrz2
	50VJZ9Lgx+0O2S3NAHtCSyMhyAyi/Vq4uZfFSBVWFwXO8Z7IFYKQuD6ipTLP9yje
	e5bQmDiA3gmp2dJM1p3hmKGFv49hxa4FyYASTSN6xW7qY+5M6OTH12VCD2ZOZoFi
	p/iVFmzspEdgFaWm8nG9ZjmnvZuA7WS2KjXnVKBP+3y18O+8QjnSPv1nkLWavX2i
	zDiqC+PR96G21KyG/rhV5mABG4Fo9iTsG+K33uKBIjg/zKWVOP5u6TKl8BF8fZ70
	HmjPGsJIgRugV35dW3A633VqleNEDZN1WI5MJeHh0O853WwoYdNj+GLAxXaBDlqn
	FMmUTA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5unyquv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 10:33:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57SAXo7N028828
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 10:33:50 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 28 Aug 2025 03:33:44 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 28 Aug 2025 18:32:16 +0800
Subject: [PATCH v4 03/10] clk: qcom: gcc-ipq5424: Enable NSS NoC clocks to
 use icc-clk
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250828-qcom_ipq5424_nsscc-v4-3-cb913b205bcb@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756377204; l=1686;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=fyHtiJAwSvuzku/slW+IcAT+Y1UhAHWKMtyHX/RJmN0=;
 b=JEtN8WblIe4B7JoQUI25HrhJ92OB6TjgmtwPweWyeUkxtu/Wk7P9kKJtfSXrDjSlrpoxRrXcp
 MrciA5bnnsaAIL+5yJHfr8+Kv3KERvadYE7VpSP16GtElMT6c6utR+a
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KIuQuJHkN6aerg_9TTEtX0FPkf0rwyNt
X-Proofpoint-ORIG-GUID: KIuQuJHkN6aerg_9TTEtX0FPkf0rwyNt
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68b03090 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8
 a=gl6uzLfi5yNa2Npxn2gA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX0Wbm6YPH2FhM
 QPdageghu5U0xXCV1CO+lZqQLyPmjRrhFNldb/G9m2VN1KjmBDztSW3RgVn9DPZzkM1VtUtVdtk
 bSJk/fJxDIXodDXMYGmR3EjCINzb5nb17TAmHPZClX4ITpuf24KgEWCwiWB1FmBUFXk9c5yGNGI
 tj74EKB+xyv3I8l3dlJyFiyuL1EsYuIo+PPnDxgbbA5VTRwBQv4g7FAhpOwbZAKno/lEPWpzIT2
 mHlQxHr4fnWmjTYFarN6oFLZGWsgBYUDNjVswlz53fssWuTJG3y761oI/XtshLBDkViqyK3Osr1
 L3AeE5DQJjDcl8cEUctnVOW/iAN3SananxmU0RieM6i9PneV8DdhS0szKuNsulk9tX1R7FA0RgH
 DWCfXK/+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

Add NSS NoC clocks using the icc-clk framework to create interconnect
paths. The network subsystem (NSS) can be connected to these NoCs.

Additionally, add the LPASS CNOC and SNOC nodes to establish the complete
interconnect path.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/clk/qcom/gcc-ipq5424.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq5424.c b/drivers/clk/qcom/gcc-ipq5424.c
index 71afa1b86b72..6cfe4f2b2888 100644
--- a/drivers/clk/qcom/gcc-ipq5424.c
+++ b/drivers/clk/qcom/gcc-ipq5424.c
@@ -3250,6 +3250,16 @@ static const struct qcom_icc_hws_data icc_ipq5424_hws[] = {
 	{ MASTER_ANOC_PCIE3, SLAVE_ANOC_PCIE3, GCC_ANOC_PCIE3_2LANE_M_CLK },
 	{ MASTER_CNOC_PCIE3, SLAVE_CNOC_PCIE3, GCC_CNOC_PCIE3_2LANE_S_CLK },
 	{ MASTER_CNOC_USB, SLAVE_CNOC_USB, GCC_CNOC_USB_CLK },
+	{ MASTER_NSSNOC_NSSCC, SLAVE_NSSNOC_NSSCC, GCC_NSSNOC_NSSCC_CLK },
+	{ MASTER_NSSNOC_SNOC_0, SLAVE_NSSNOC_SNOC_0, GCC_NSSNOC_SNOC_CLK },
+	{ MASTER_NSSNOC_SNOC_1, SLAVE_NSSNOC_SNOC_1, GCC_NSSNOC_SNOC_1_CLK },
+	{ MASTER_NSSNOC_PCNOC_1, SLAVE_NSSNOC_PCNOC_1, GCC_NSSNOC_PCNOC_1_CLK },
+	{ MASTER_NSSNOC_QOSGEN_REF, SLAVE_NSSNOC_QOSGEN_REF, GCC_NSSNOC_QOSGEN_REF_CLK },
+	{ MASTER_NSSNOC_TIMEOUT_REF, SLAVE_NSSNOC_TIMEOUT_REF, GCC_NSSNOC_TIMEOUT_REF_CLK },
+	{ MASTER_NSSNOC_XO_DCD, SLAVE_NSSNOC_XO_DCD, GCC_NSSNOC_XO_DCD_CLK },
+	{ MASTER_NSSNOC_ATB, SLAVE_NSSNOC_ATB, GCC_NSSNOC_ATB_CLK },
+	{ MASTER_CNOC_LPASS_CFG, SLAVE_CNOC_LPASS_CFG, GCC_CNOC_LPASS_CFG_CLK },
+	{ MASTER_SNOC_LPASS, SLAVE_SNOC_LPASS, GCC_SNOC_LPASS_CLK },
 };
 
 static const struct of_device_id gcc_ipq5424_match_table[] = {

-- 
2.34.1


