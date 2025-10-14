Return-Path: <linux-pm+bounces-36076-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A29BDA0F9
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 16:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BC13E4573
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 14:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895132FFFA1;
	Tue, 14 Oct 2025 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PYYTHJMH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05F72FFDF2;
	Tue, 14 Oct 2025 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452578; cv=none; b=et/W+35uTU8AYg7d8u3Pt6fTuOuIifobGPcf6YX4DA/fgP2z5pTwFN0fDrbs3sJdLyqF7CDOu8j0fXvAAYAynYk+yGKmqKn9XbptALgr9lm5gEXdInk9CM0FQXNgEosgcMbtHDvvl8TLYP/87vKEzjtvmyIotKrkP70WrV7793s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452578; c=relaxed/simple;
	bh=kH9yGElyWBnELP/oEXPleNMPFixC7y1kzjtS7CTHSFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CHzagcodsxW+hG0L9VMTr2ZtM4PSNanDmuMiAF8F4xJtwDmGIufrF0AW/6p6ZyfL6nnRrJqA9i9NgqHTAKe/fCFPzmgKtbqK4FAwOpm1QNzmlI0CFgjEQlfbPuqDG5vDhhSE192YaPOm5hjcHSx++BYdpXi8qEuJ+iFq63lmzJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PYYTHJMH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87LVh008546;
	Tue, 14 Oct 2025 14:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tY/0m9q0rGGkoFRSYCXpkQbDpBY+S/pr5FuQV4oLYdM=; b=PYYTHJMHQYX2DEs3
	rL6S2mzzStsvOHPy4OVlGc4Swn3Gvs1eRQKRy37M2sbIMzck/TYyLP/QGrEj+2P/
	1oPjuAlK029mxKy3+t3PtJ9IKlhIoR/8MAwtz/17H8ItRYNwjxfCB8OpUrNcF7i/
	rNSWwz2woQJRW9OEk6FNnPD4L3RBJ4YDmT9AM0rkC2smsh++34o+X1t/ZYc22M76
	YGcVVRWQ1V3gGgzW3pRd+xhC9hII87+4LytV6PC6Zs3D2om6nGkLYPdaTMkORjEZ
	ZS6K14+LQGBNIS4+DipvsJVTofgAMp0zabgPI88ggRawdYfv9xkp4158iAhvoDJu
	jDTVXQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrt5nwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 14:36:11 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59EEaAKe005345
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 14:36:10 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 14 Oct 2025 07:36:04 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Tue, 14 Oct 2025 22:35:30 +0800
Subject: [PATCH v7 05/10] dt-bindings: clock: gcc-ipq5424: Add definition
 for GPLL0_OUT_AUX
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251014-qcom_ipq5424_nsscc-v7-5-081f4956be02@quicinc.com>
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
        Luo Jie <quic_luoj@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760452536; l=1087;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=kH9yGElyWBnELP/oEXPleNMPFixC7y1kzjtS7CTHSFc=;
 b=cgbeDS74adoecckKOpzms1tEOrFsBJ+D6ENwFvDVOyXBS1kqqqInLws0bUTVprdUaFECfT7wU
 7faS3LrUDizB2YxkL7Cojf5xZ0WGbvq8iotEiTCHsS/XKkM8LDHvGI2
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JDDDIB5CFgEgxWJ1JI8i_uTMdkxOiUk9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfX70lt6v04nQrG
 o99OI9+zQ32t+4gtJ1WyibUpCSjBGTnHrErPmh5BtSbGD01RseIGgW04QopYIOCf9FggK+fzAt8
 Sg72C+GvuLiVW7o0ZSjKYOVL+wDqNe1kYK31GjZitrbKBZyigmTW8v/4YGy1AxQwvF6PS8sBw9P
 92+vRMQKf9ZJsA5wKYl7F71gjHo70Y4ojne6ZsHF2u4DLg70aGq55gTuAZ38I+1VeUInJ5mJuxf
 k76JhojpKKqceezeJH9NNjyZILPtRIdRb8+ITMzTEwhm56MqWj9SYA7GLtDCe6vCbC1NC3GfDXV
 +L0bP9ij2mazmvyh3ul9GmcrWNs0Zds3iFyp+q7++tVO4Lq1c1zDVyMUNG07GI8tInBtMB2LgSs
 ScvORENOGoqcSJg8BMIHJX6sGLDcxw==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68ee5fdb cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=J5jK_jrvxbvMreSVrnAA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: JDDDIB5CFgEgxWJ1JI8i_uTMdkxOiUk9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022

The GCC clock GPLL0_OUT_AUX is one of source clocks for IPQ5424 NSS clock
controller.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
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


