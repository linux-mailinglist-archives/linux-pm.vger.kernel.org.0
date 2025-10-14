Return-Path: <linux-pm+bounces-36075-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91540BDA0C0
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 16:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C5D8500EF2
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 14:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A847D2FFDD9;
	Tue, 14 Oct 2025 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hv9bm04u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF90C2FFDDB;
	Tue, 14 Oct 2025 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452574; cv=none; b=lqMtOM1lXTS/hn6RrSk/zky6OpDyQE4LPrmVaHm8QD0IAX3snsGoVJ0gEC+fkuvywmmaSoOnPwGbo3UkBpL91xDxnt8YYa2aKGPZv285zpAPJZiZEuZfkvkx9TeG+OL2xRuIMkv+LSB25QY3wFEljKwmH4u9A23Jx2X3/aGSW7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452574; c=relaxed/simple;
	bh=NlXEF3VmiXF2+P9u5NoblgQUs0TpNmThc3On54QrJMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nkWyNrbnwY1MiyHQpHOX4wmO1XIGmEP2hCbSKW5fa1rw3Ib3om3HxJR/7O7w76JZe1D3jzX67TcOs1L0xuc6zqFsEvB3BD0xyRZQUzmpBmlS3Y28RjqjoOKVpUtNZn7xnTkeac0r/k+TGCYpITtt6ayAD3QZlc1ds+Up4ZWqMew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hv9bm04u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87H0S018082;
	Tue, 14 Oct 2025 14:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yd/oPuUfVOJcMQA/lTcKzDkbSGoGxeZhh5S6dzLVh+I=; b=hv9bm04ulZBW0xCZ
	Hk9scEywIBjrRWJxFAuhmSiBe5znggxjJm450WsV9EscwAuNDQ9wanCrqbg42U1j
	lh/d0tT/QxI9TPwyqo1lEDesmCZN8B1lG2dnaxEWxmuFv95WajoLoS5mZ2l1mSIE
	yAFlhZIRjXkWTyC02ufadbUjHDTeiiimUYAGdTtt4pd04hMsZODhrYEK6qWcYWnW
	tAGZxaYZikKUz4PV6NGv9uXiUFgb8d1DbUaUUMxOG3of11R34EIJp/YTsRpu60sa
	jSgeJKJe6nsbZZpSex5nZ8Q4Z8qNASlPDg1l44Iwh+7QsjnXxvk2e96r9e1qXaXm
	ReIfOw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfes0uxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 14:36:05 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59EEa4vW005270
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 14:36:04 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 14 Oct 2025 07:35:59 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Tue, 14 Oct 2025 22:35:29 +0800
Subject: [PATCH v7 04/10] clk: qcom: gcc-ipq5424: Enable NSS NoC clocks to
 use icc-clk
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251014-qcom_ipq5424_nsscc-v7-4-081f4956be02@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760452536; l=1747;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=NlXEF3VmiXF2+P9u5NoblgQUs0TpNmThc3On54QrJMw=;
 b=ERletD1EgkiG1e/dI5+YejX+i/51vAyzyiqFQYfwuJ73bAraGYAfDbmjhKkZDWp1xcKx9FVy0
 4P5+1sb/LtHAaXSryOU9WDItPTYJysPot2H9B+zv3/+JKfID9m3Vey1
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=R64O2NRX c=1 sm=1 tr=0 ts=68ee5fd5 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=gl6uzLfi5yNa2Npxn2gA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: hnnXZy_gj907MzPwO6SFK9OpTOhGkADW
X-Proofpoint-ORIG-GUID: hnnXZy_gj907MzPwO6SFK9OpTOhGkADW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX03byjNh4cVED
 UY/DVahg0MXXZAM5hxpgJmgvOZS1a0CBSAKth9a4ZPgXSM6R0WRX7KULUqoNPolZbdbBsxGDH8W
 +cAriOqWof2H89PuVZViJdytZVGKGY5OLRJqWkHD5+u8bKOaD3lVTqu4HXJUu8f3fg9OJlzGFbG
 c5S/eS96+IIscwTQq7qa9V9GvezWM4a7Ro9GBNJW3FHwzkiSU/v4fN5UBKQOi2cpOS1IEAK2xwR
 XeMNfATWiqlqOeGqrOZvtKF+tMLxkZwu42JUCOHUnZHAf6FVcHdIfrmQSdJI/gpz/j5NU4SEM3J
 PhKplBGYBt5l4GmU40uoikkQUnNq6Vbb1f8rDlY7zvMUw+trV7xI74AQQSVkOxnoWpYOWa3wY7W
 daJwGmjIy5EbsWs7GtDdzlEOHCdR2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018

Add NSS NoC clocks using the icc-clk framework to create interconnect
paths. The network subsystem (NSS) can be connected to these NoCs.

Additionally, add the LPASS CNOC and SNOC nodes to establish the complete
interconnect path.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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


