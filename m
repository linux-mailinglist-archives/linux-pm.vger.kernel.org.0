Return-Path: <linux-pm+bounces-33237-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF6BB39A30
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 12:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8501883AD1
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 10:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8A730E85E;
	Thu, 28 Aug 2025 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c6mEI4fb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613B9230BF6;
	Thu, 28 Aug 2025 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377250; cv=none; b=kXFewNMMxM71WnDJity55Wkygf948ZF6ggfkDU04vENwo4uKWvPinWXQ4vBR44GXzkJQcpJwB2/ZzYtsnIuUtLyy3nd9j5kq8qdjMPmPqowZFcUOA2scJHA+6vczLfUjNcTVeJ/Obd2mmWIhwz/Q4RoUtWtBDrYUFCWJvjxy8/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377250; c=relaxed/simple;
	bh=KuovKEQlwmh8oCwvjFmFfUc7Q/lftXQQSlX/OAViXWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gAzGwcqDCuaToy2rWLiCvJyesIxPDuNWcYtahMQSXr1rOR41ep+FOPhtSP/Gjm/xIwpD4TQ+n7ysc6kHVDwK69eq25FLXIhL2x7i9OrvNCWYyGOCSsZOwF2sLPZBh8SxV6FgRGhUyUtvJYdngyhOSAywSeZIMNed/oeCnBh1OJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c6mEI4fb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S654WA015828;
	Thu, 28 Aug 2025 10:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2hERqCjKKo8nYbV8I9A7DrGzOeOvQ5/8pI1ggHCbJuA=; b=c6mEI4fbbEIMtfMq
	N40z7vHcif0yR9tO8+hnXEwz+jbe6U5DX9LE0PO1wkZu9Ch0j4msrhe/XkI61n7t
	k6lspiL9n6PxYHYSsn1nseqa+pyHdbm0GD8wMmhgeveSHTSDYX5ozqeue4RA1eZ2
	nbV1a+P+FtncwoFuXGE/hTbsH1F2vMZ1Vyckdl4GHLW76BeB4gt8BA1mtQouUvpt
	MBbNBkR0HVYgep+u2Mk1lL6Tu7LipO4XsvJnhK0b0I1pHT0z50llAbX9qTyyFt0a
	nsAK+QXmLhLzci5UX2SkRyQTzVKFNXsEKKeNLwhlHk95yHyi5rjzFgdG8wFwJV3H
	W/qodg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48rtpf26ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 10:33:58 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57SAXvxq017652
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 10:33:57 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 28 Aug 2025 03:33:50 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 28 Aug 2025 18:32:17 +0800
Subject: [PATCH v4 04/10] dt-bindings: clock: gcc-ipq5424: Add definition
 for GPLL0_OUT_AUX
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250828-qcom_ipq5424_nsscc-v4-4-cb913b205bcb@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756377204; l=1040;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=KuovKEQlwmh8oCwvjFmFfUc7Q/lftXQQSlX/OAViXWw=;
 b=vISAqDcUNLPRk0vZE4ayuOyOjx+owS0MiLBEBSQnFXxa8j8HXVh/lOPKsxbE6OFuBzRjVMlPq
 bFZR5eyRBYaAVVs62ZcGsWCMkdP0WIWWFei2/j2mGDNOrmQPHObHSi+
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2f8bBwfDuIXdnB-WL_sRLu4lI99VU6wV
X-Proofpoint-ORIG-GUID: 2f8bBwfDuIXdnB-WL_sRLu4lI99VU6wV
X-Authority-Analysis: v=2.4 cv=Hd8UTjE8 c=1 sm=1 tr=0 ts=68b03096 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8
 a=J5jK_jrvxbvMreSVrnAA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE0MiBTYWx0ZWRfX3V4/uAAZkDFz
 K6bUEghwlJPQOYtwLDmyeNv1LnOxH08U6iz3yBrWiyNN43g0qzReGd4lq2ZOL1AH2aBHB75f34A
 dG8gtmNOm+PWL3z4KJdbveY+a1+7KFUht/dfT2plx9qH9/kQPJZ/mgZnvJXzJLn1Y0z/Bzi6uuv
 Y4R7WpyYtU6RvorCIlGgGJHPSpTWrzbyYZtL0jT3BDI4wvHd8s4A3KgvvSISUKw9N5nnxOmtIKA
 PDtYIcYGSjA/r5NgfLOb1/GfPfaWWeYtXg+gxjGVal84g8xoBDc6Ok30YiNt/S9NhEVFvpesXf2
 fbGCCewn2z9Xl6B32Y8B2AQzSuLtAS72PYGH1EyZKNpVs6kPwco5SbtXtzvvgcmZO0EWVuZaDsF
 BU8BR6hV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250142

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


