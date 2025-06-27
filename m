Return-Path: <linux-pm+bounces-29657-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DD4AEB73B
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 14:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAF004A4918
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 12:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698CA2D1309;
	Fri, 27 Jun 2025 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NO9vvBeT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CDC2C08D5;
	Fri, 27 Jun 2025 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751026245; cv=none; b=MXl/Uu1LGWCqOOzw0lIvZ5PPEgboaeaknt8wdnKuaZlExsx+Hhh6ZLTKJWDRGB7nEL14SIHYSpINgOrotfk9M4wS9cM7Dl7O8S+UY1fRyI0E0Z7zsDO5JdGNxS3QDkbILoqdGAbeEHbjI0eBN1y6+q3TBgl/Koce8eEtyLMZCQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751026245; c=relaxed/simple;
	bh=erJrWCYa4Jo64Iuc+N8zg/ohmf2MGD0jxskYDndjX8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=b8RB7pR6mG8djCSxU3hu/B8L/Az3sXm947C6pBZfEVX0P84srKXicO2iUW6RF9oZO0o5jAQR56506D5RRNTXG49trqo+GOPrmTcDxY2oPnipmsJpfIXFU8uBIFJ3AlDdIndV8H9jGUwKcn7qXqIpAXrVvpwfwLkdaHg7LqvtQqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NO9vvBeT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R4DCsp027650;
	Fri, 27 Jun 2025 12:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fQS9pAbi0R1zZSxpnVhJy05NkOiQth/NVIsEq+XayXA=; b=NO9vvBeT7fVqwMwb
	FZ07uBb135nVGpqdU8Ysc3a7PiX+Z82DXpZfIzkkldpGtWuEfpVPNI/SwIF0KFNK
	IwRMvdr/mEod3XrobhZTVTewFBgXpZlhc6ewFS+eMdDCapy82MvU4dXTsUJua+3n
	RauAYpmh5/8vY1T7YAmfKKZtY/qe9vv65DYAszvRVRaqiFb7TLM8DawuK02iq/Ap
	EhwVY2N1TVSnt48u/tgesehLyt40DDlybrcfcwXc7fDqMGNoJcWf0snfmCG2bI7U
	o52h3fDFhN9fKfB21ubLL0EFmBnB5Wzp/prM4ydLqW01bCdxTJgUOUEL2Uw2LbLH
	UwsrVg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ec26h5m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 12:10:30 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55RCAU3V027952
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 12:10:30 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 27 Jun 2025 05:10:24 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Fri, 27 Jun 2025 20:09:19 +0800
Subject: [PATCH v2 3/8] dt-bindings: clock: gcc-ipq5424: Add definition for
 GPLL0_OUT_AUX
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250627-qcom_ipq5424_nsscc-v2-3-8d392f65102a@quicinc.com>
References: <20250627-qcom_ipq5424_nsscc-v2-0-8d392f65102a@quicinc.com>
In-Reply-To: <20250627-qcom_ipq5424_nsscc-v2-0-8d392f65102a@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        "Konrad
 Dybcio" <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Anusha Rao <quic_anusha@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_kkumarcs@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>,
        <quic_suruchia@quicinc.com>, <quic_pavir@quicinc.com>,
        Luo Jie
	<quic_luoj@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751026208; l=1051;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=erJrWCYa4Jo64Iuc+N8zg/ohmf2MGD0jxskYDndjX8I=;
 b=SqvXDmpFJFGHF+2BikJfTJlUkDDmP4x5G43toIZ4vaMOuviT/Ps23lgRjkZpGRbjq6d3JZL5R
 6Twi+hpWR71AvmRYARf3cRfVjdlH70Wg0bvwsUqGhoudJTsyUcOXehX
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEwMSBTYWx0ZWRfXw4udTGGmH91b
 xPhyKl4ytILaSbNT9VkrZY+EKxRPW4y3EHtr9NQo25iF16JhqDA0B8lxiNODXUTMfgPDXQPz8fc
 U6LZsRimKrpNGQmTSO+CByJf8+HoP+wuRTJZcgNa5zXiSolznUDyeRxylIuLIqKP14Bkmz9eI42
 28+CZL7VB5PhAFX3ehUpBNFH4c02JN2Pv49g1uR2/b1XkOj+H1ym/nX6o+jLH4GbLVKDXGvcL3Y
 bLPkADsiAN24iZCHFz2KhWSIJNCsroU/Z6SyiNMLWAWSrUUF+I1/oosqKjMl0NQ8yTdka1tkBsD
 4zsuOsNoEOI/wXT+kPlTqOxdysK3e3CrRnpKCyTuo2yU1J0l8asrdFbNlu/iZPjiZWaxa1NtEyY
 FAdBtA9ZeCDN8ur73oaqtf2KFfs+IG3+/DCLJ/0Py1R2JW5aIijyQtuWY+hO2Ak/hliNH3em
X-Authority-Analysis: v=2.4 cv=XPQwSRhE c=1 sm=1 tr=0 ts=685e8a36 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8
 a=HyGcnaojGsed0H-j9tUA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: t5_Oh1N_Oz763506zQ9O9N5mr-HiKViT
X-Proofpoint-ORIG-GUID: t5_Oh1N_Oz763506zQ9O9N5mr-HiKViT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506270101

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


