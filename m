Return-Path: <linux-pm+bounces-30569-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ABBB001CF
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 14:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659205C1AAF
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 12:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DCE2D0298;
	Thu, 10 Jul 2025 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HLqAtbr9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F082571DE;
	Thu, 10 Jul 2025 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752150565; cv=none; b=P3uKgWbgXJIrZOA19dY4aAj9wxw6svyTEsM6+7cv4SbLNj60MwvnVyLUfQ0VlUoGt1rt8o2oEkvlI3jS5ZJkQPmQkrjDP/4o2EuoNRVZxZEx5PWD9lRigBn1wL+5Mj2WWTK+HwB35zhNsYOZ9LN6f8u3RGN1vIyoOWhKAY7n6Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752150565; c=relaxed/simple;
	bh=erJrWCYa4Jo64Iuc+N8zg/ohmf2MGD0jxskYDndjX8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TITdQpbiwG+ovtSijuhWktBuVChBRr1DKKsH9Gkyl+i1NMT/RT4qNItyAv2xkNgbNvV5upB2jWsb+6S1tRnXd5bONfDT4sz4fZWGo9E3HbcE2owZbQZD1+3dJJ6wS+CrOANRragPjXxbtZ2r3YPYsb8qW6tNiKwanAt+ai86tkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HLqAtbr9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9ZZfe016458;
	Thu, 10 Jul 2025 12:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fQS9pAbi0R1zZSxpnVhJy05NkOiQth/NVIsEq+XayXA=; b=HLqAtbr9ARQlvoCT
	s/wXAgdGmefmQebHfxZsYKTqtRfDjxTzv+HFxWb0atlY+Wk8xTI8A6ckebLHXh6Y
	LNFwsaLH8BlGwRh9rG9qAArU9WxTg3GyTNB+bxOEy1UgZ9Q1Vacz4meG4TSMmZo6
	fTNqOZPHjmu15b75fXpQA3PVzprU3Cyz0J81ns7eQczXWFl6EBzKzIbM6SlxGtji
	1mHfm0lg7NPdLS5edDeOqzXvbCZN9rc6jPYGwWwiTQ9hynVlyWmvtmZdmjv0boEO
	3iIdMCmea4RQ8e5Cz73FZ3GJxsbdbCP8gXF8semw5GDGLQ4u4EQefEOQeUhoorn+
	KHQOIw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smap4xq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 12:29:12 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56ACTB1D024759
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 12:29:11 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 10 Jul 2025 05:29:05 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 10 Jul 2025 20:28:11 +0800
Subject: [PATCH v3 03/10] dt-bindings: clock: gcc-ipq5424: Add definition
 for GPLL0_OUT_AUX
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250710-qcom_ipq5424_nsscc-v3-3-f149dc461212@quicinc.com>
References: <20250710-qcom_ipq5424_nsscc-v3-0-f149dc461212@quicinc.com>
In-Reply-To: <20250710-qcom_ipq5424_nsscc-v3-0-f149dc461212@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Anusha Rao
	<quic_anusha@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Philipp
 Zabel" <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_kkumarcs@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>,
        <quic_pavir@quicinc.com>, <quic_suruchia@quicinc.com>,
        Luo Jie
	<quic_luoj@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752150527; l=1051;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=erJrWCYa4Jo64Iuc+N8zg/ohmf2MGD0jxskYDndjX8I=;
 b=eXXqGGEYanOYaA6wZDxBp1gq/PrMpF6WLJn33KbHsF8cbebGBrsn0fNkSWSU9uboQIgk4/Eai
 hCydABeLF32CL2sYOoMrzCyZ0oB3K6DV2tHVfcyqOwCviqz0T/GlVF/
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=Ar7u3P9P c=1 sm=1 tr=0 ts=686fb218 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=HyGcnaojGsed0H-j9tUA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 92TD1khH-uDUTtHytuozKg2xvSC3zL6U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwNiBTYWx0ZWRfX4sCY3+mpw1mM
 L4PQrckx/LHkWYq5QjZPGrs2e6ApRuS831b3H956Lirmh3IHro8AKXx1U+Aew6EadMbZICC06O9
 IZSe0gBVjsSi0k6+oZF+DXPI4F8IR9zlq54qhCaLLNSz23E7n26ap2JJ/hpUbZw25vSE7NOmtkD
 ngZx/pOj1JNcv2kIJH7AQWUXVxV5RCYtL0MfDNdyw3tHcYLKpIBvLh9ddO3C0EzyMygwzKB+6z2
 p5jYQK0Pd/YnP3BjoWiraSUgAB43PgOSEWIDAAw27mDA5Ssh3xPtKd3URbpdnsOuK9G6nWanBKb
 4SSBIf1dv+otQVyqBbiU6shoaYMZwmanuQBeLDah0TmcF/lb2jgG2ThVpczrEk6XDfYQxEOQsur
 yclqj3/7ZGImTdq5NkuN+FpTAW8SNioFIVqddfGvGIlk6FhxI/6uPyE9oqJF7dIhJaXqz7O4
X-Proofpoint-GUID: 92TD1khH-uDUTtHytuozKg2xvSC3zL6U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100106

The GCC clock GPLL0_OUT_AUX is one of source clocks for IPQ5424 NSS clock
controller.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 include/dt-bindings/clock/qcom,ipq5424-gcc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/qcom,ipq5424-gcc.h b/include/dt-bindings/clock/qcom,ipq5424-gcc.h
index c15ad16923bd..ab23c6844a06 100644
--- a/include/dt-bindings/clock/qcom,ipq5424-gcc.h
+++ b/include/dt-bindings/clock/qcom,ipq5424-gcc.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
 /*
  * Copyright (c) 2018,2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
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


