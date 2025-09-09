Return-Path: <linux-pm+bounces-34262-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDF5B4FDBB
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 15:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263DC1896BDE
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 13:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AE934DCFD;
	Tue,  9 Sep 2025 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lzss2o8l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531CB3451B3;
	Tue,  9 Sep 2025 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425226; cv=none; b=hn/eXaTGkvLHzl++cAM2kIU3CGfX7RP8M8bvUC2MkO5ZpXL75r6Nq3PO3crIWChf77GW4mkDymXMm7m/+0N0BZ4WsCkqFuOdvD7NXusV9+sk+5uWkZO/N/fINRJWJJAOtMfeB09LNkqMRUQUyYsCvblWSgbE/CB8DK2s84DlPhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425226; c=relaxed/simple;
	bh=KuovKEQlwmh8oCwvjFmFfUc7Q/lftXQQSlX/OAViXWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Xd3I0pq/vy0ZSyzJsLSSMamQob4qgphr/4iLM8QUtI3PS+sNt4cfCick4r+V2AmdXYLI0OnA2atLiS03kZsEXnmgQuGfpzHd2w5/eauEgA37MJU4wPJ/bDdEZee+Q5ik3oNj8T8IhPDiMuUiDQsLULL+gzDNFvYxfkTWSe4md00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lzss2o8l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LYZh011085;
	Tue, 9 Sep 2025 13:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2hERqCjKKo8nYbV8I9A7DrGzOeOvQ5/8pI1ggHCbJuA=; b=lzss2o8l8QikStGs
	bNFp6xV3K4FsMWId+AwyYJgqXeXF7ZOLEEjkjm8PPIppfdsJNdQjH7KNBz1fexLJ
	R1zp0zDQsezaghfKsCHbF3ZpzUxg7Z8ngAAxbpnKTtLpsd/sOt0y0B+F6QaF2HHI
	Gj8tVjNBDBkLpzwkHc1uZVU9BNGWshhtSNNfh9iTOegAfU9f/LbANRJM6X+3oiim
	m54DzeV40dG1PxdVOr9AAqiE5eCQLtH5PoOSDnM8biv8N5IAVLb7F72MliMSuRvg
	cnJ3oCZ6FzcYm1ralad4YPMWA+PlQGAvZrQU4s0n4zAcYVLhTtSLXfpQFt3BFlc0
	HKXO3Q==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0rcf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 13:39:59 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 589DdwDi030843
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Sep 2025 13:39:58 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 9 Sep 2025 06:39:52 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Tue, 9 Sep 2025 21:39:14 +0800
Subject: [PATCH v5 05/10] dt-bindings: clock: gcc-ipq5424: Add definition
 for GPLL0_OUT_AUX
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250909-qcom_ipq5424_nsscc-v5-5-332c49a8512b@quicinc.com>
References: <20250909-qcom_ipq5424_nsscc-v5-0-332c49a8512b@quicinc.com>
In-Reply-To: <20250909-qcom_ipq5424_nsscc-v5-0-332c49a8512b@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757425161; l=1040;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=KuovKEQlwmh8oCwvjFmFfUc7Q/lftXQQSlX/OAViXWw=;
 b=pgzIOJPucKpGZ3r/u/Pu8yuaTr0Q3c2FfSOwf6sbpz6c4HEj7b9QhdJScWeEOwxjtl3EneFu9
 eeYU1lbw6p/DZkXpZplXaoimHHH4V8uU5z5S8nO6DpWRIYRtv+2IuvC
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XuTmUDAXd37FE9Df9Psw4uQ0FMJYJQdE
X-Proofpoint-GUID: XuTmUDAXd37FE9Df9Psw4uQ0FMJYJQdE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX9LRlDw6+NjeZ
 ky4HyV6aq8PuV8SvDupD2I78P68dZLFtLw433jwN/jcEUrryHRQclwNWpxLUcsVFOWOt9FqdyOL
 mBtNfcF5e4XjfpT29MrCSq+FVg3r1cWKjDS6uv6rG5lA5/W7Krde0MAh811G0vee0sCe0imx6My
 YI0QmhBoAnQ8CUt08y1JggUm9Mp6KGBUrHxsaHrKM08BwL99iUDVq0m8GxDr0vCAX11rdghjGI8
 1YLeQF471uyAVEe+ccpjOQqVxQEEt1fhO0397A9iNvKqGA/siIKkP5c/X+0dKlc62hiCUP6N+UX
 SPNTL7qbgnLaRIqb5jDfWXpSede01Zcjc7DtQlhB/7kFByapYHGPdEpWo1mZkzfP2ydSedg8Us4
 uyvrqH62
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68c02e2f cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8
 a=J5jK_jrvxbvMreSVrnAA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

The GCC clock GPLL0_OUT_AUX is one of source clocks for IPQ5424 NSS clock
controller.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 include/dt-bindings/clock/qcom,ipq5424-gcc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/qcom,ipq5424-gcc.h b/include/dt-bindings/clock/qcom,ipq5424-gcc.h
index c15ad16923bd..3ae33a0fa002 100644
--- a/include/dt-bindings/clock/qcom,ipq5424-gcc.h
+++ b/include/dt-bindings/clock/qcom,ipq5424-gcc.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
 /*
  * Copyright (c) 2018,2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef _DT_BINDINGS_CLOCK_IPQ_GCC_IPQ5424_H
@@ -152,5 +152,6 @@
 #define GCC_PCIE3_RCHNG_CLK			143
 #define GCC_IM_SLEEP_CLK			144
 #define GCC_XO_CLK				145
+#define GPLL0_OUT_AUX				146
 
 #endif

-- 
2.34.1


