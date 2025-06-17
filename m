Return-Path: <linux-pm+bounces-28893-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A465ADCA7D
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 14:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49043B31E8
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 12:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACA52DF3C7;
	Tue, 17 Jun 2025 12:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IEONQrzL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F2E2D9EDE;
	Tue, 17 Jun 2025 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750162036; cv=none; b=RCPWYa4UMN4OztW92T3SD6s93qSgciqWXrl5z9LdyXjzhcMgEfehDyyv7KbdI2eUSGcx7+YcOupHFX8h3MMwueYOMFQFaS8vojI44L0MChkIUMGL3GvuSHocA7ge7PybzjQQUIcR2kxiO7bCaCGfcO4yP9IuEy5IV6s18F1PLFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750162036; c=relaxed/simple;
	bh=LW9djbY5uvMpX/1C731IyN9Q2paEzsWyatCqe0dYowE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ddDukmz3fxp+HEn24tC1VHEP8/eO4mRMmKXSAYoQxFF5n5o985heO4BRiDLpXFNcCmiA0xyrq9NYq2GUqGFFquxm0CZRxvKlPTCm596RUSpP2gRkZkm2/vNeId312OCsFL2pMSPcyKtSxmKENEPV4mlb+YEyvjFSCrI9hA+WJTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IEONQrzL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H7hdgg006026;
	Tue, 17 Jun 2025 12:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	99M35CN/UIeVzTNTGP/oni4W2zXbo6xaxFJdsienfjs=; b=IEONQrzLvf+QGjsM
	PQ9PXFfkyeVHEqLqgZKbj1R/kl87AKl+V5fXWlBxogoGzS0u0ViL6vAL35gdEfjk
	XAMP3RkkoRbOHTFXoAbStsl/C63acaNFXMrc40V6TnR556Se2SWjLtgVEJ/yY1fY
	m0V5HHxae+bdTNzZnGvFqHuAFxmOYcZU6V7XPaS2Th2ls1RHjfxWwaxt14n8/0JX
	Gm4DLfVnNJTfzHv2geL2DCjJV1BVrCvyirROen1PujhUudlAI0sexfEF40r6xQCq
	zJE3RTAaSNQSJfBONGoE65YKCuF7pMK/PlyB3s9rUvevmsp5xaGNkyqQgJCtiT7C
	SIGhOw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791ft02e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 12:07:02 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55HC718h009860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 12:07:01 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Jun 2025 05:06:55 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Tue, 17 Jun 2025 20:06:34 +0800
Subject: [PATCH 3/8] dt-bindings: clock: gcc-ipq5424: Add definition for
 GPLL0_OUT_AUX
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250617-qcom_ipq5424_nsscc-v1-3-4dc2d6b3cdfc@quicinc.com>
References: <20250617-qcom_ipq5424_nsscc-v1-0-4dc2d6b3cdfc@quicinc.com>
In-Reply-To: <20250617-qcom_ipq5424_nsscc-v1-0-4dc2d6b3cdfc@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Anusha Rao <quic_anusha@quicinc.com>,
        "Richard
 Cochran" <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_kkumarcs@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>,
        <quic_suruchia@quicinc.com>, <quic_pavir@quicinc.com>,
        Luo Jie
	<quic_luoj@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750161999; l=1043;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=LW9djbY5uvMpX/1C731IyN9Q2paEzsWyatCqe0dYowE=;
 b=/hc+Gf7DNU9p0wz9p/4Gmwv4YTzX5VtU+Df7BYqQVKP0mzDizjDbqBdkV0B5liKyUnWs236s9
 X16Cvy77laeA07YRxHaVEpGML5ne4a99a64ILp6KjoReiJcm1C53eKw
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA5NiBTYWx0ZWRfX6gBy8piJ2bdU
 0dY/21j+6DzWlasdsyZdQI7uQbzpPEV2MaJbAdmjBa4NOs7soOlm8HzEuISjDHK0OzdGTR2VL8z
 SMjVjBp4J7zkHlS+4WZDTpDwGOJYrwos49sT52yM1/pkCiTD4ojx2QgT6S3aF3XGsdlOxrr4jfx
 E57J6MSrMu9KEqU0p5fXngJh4Cj/Im9JOW4qRP3K793a43MlsCMkcOAWqKFLcyZRq2Xnwq3xPgt
 7blD6/4MQQ5yANsIrf587CMgisI2P+s1jfDzY9YCm0aJGLxeLDIzM0N8r+9bGUbpkK8lKPFhny3
 5PsYubHyUwytitKrehRTFjdBOb8JG75yt3zMQO+R/xl9/PT0JqkJP1R8AjZlB1UZH4LY7QfIPlq
 DFTuJDrzZVKmTpyDWv1uWqeIymrdm/xoWgpBU4iSPdpEUhkEQnHwF6f/P06kcszoOtiy2sTR
X-Proofpoint-ORIG-GUID: RjN__AQ0K6AJWdJX2Di9oJ2E5dgiYcKg
X-Authority-Analysis: v=2.4 cv=OLIn3TaB c=1 sm=1 tr=0 ts=68515a66 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8
 a=HyGcnaojGsed0H-j9tUA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: RjN__AQ0K6AJWdJX2Di9oJ2E5dgiYcKg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_05,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506170096

The GCC clock GPLL0_OUT_AUX is one of source clocks for NSS clock
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


