Return-Path: <linux-pm+bounces-36074-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8CEBDA09C
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 16:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D22A19A191F
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 14:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82C82FF676;
	Tue, 14 Oct 2025 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cZlLC+U7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F8D2F1FDA;
	Tue, 14 Oct 2025 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452568; cv=none; b=o9Jr7C3mpt5+aluXsUqxK20TFOi6HAhdVVAXvq/WSz4j2CQJE1bSQFcs0rw2ZVfiC5M39rXeaa/XoDmTrzcQDM5/aZYRUdulxqx8fdb2BY9WSzWs5HbzYCs+ha5w715J/7fYxpyTXzSbjK5976EGTE1xdN9d6bdL+Eyj2pFx7n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452568; c=relaxed/simple;
	bh=5ta/LWaJssx4yk7oF1/lZyMoh3TyiMbwDeKhxJNX6dc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JdO7vZq1nCswy4PlVAhNNwBMrxyv/K2Lz5LmoZBc8TpSbFlDMPC8WuRpanaWSBMuTO3RVH3GjxP/vVG6LDh1Dz0ZCQ5wKKe6IbDfr2HJEIF6jnOjQwXrA5hdVIhBt2wM1cVVnysDwKPiGZa6+ZV9T7HVqblcicgPc45JccPKSkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cZlLC+U7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87UkB006284;
	Tue, 14 Oct 2025 14:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ff2X8gB94uot2LVF62+g+L2VpJDyKN5xMhgFIuxqP4A=; b=cZlLC+U72wH4Dp/Y
	Zlzaf2UNqTW0+bgLRNbvASi75ATAZ/9g7My1FOsQHuKENuJNrgnxOzrg+1LL/JgH
	kMFvRXNdmd0if7EJROqM9GwaODLLxmyfbacuqsyX5+h+SmUzz8ZeH32+wx237Mir
	0+hw3g55ptxVCooRnp0ciWYvVWHjzvBWaWGrJcr2S0CrmD5NH5so0rdy1hJ5eI9Y
	ki90m6Z0RW2sPF5P+Fd767QrFpt4U2NK0zu5dgnjCr4M9YJOPHOhUHN3SLlZEWjF
	lmOSVO5/vy8+nGMpn9eF2MqY35ovX2IFVKSJE27oDJo67n1s/aqwcqZV0rDz0KMr
	Akh55g==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfbj0uks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 14:36:00 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59EEZxZP005687
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 14:35:59 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 14 Oct 2025 07:35:53 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Tue, 14 Oct 2025 22:35:28 +0800
Subject: [PATCH v7 03/10] dt-bindings: interconnect: Add Qualcomm IPQ5424
 NSSNOC IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251014-qcom_ipq5424_nsscc-v7-3-081f4956be02@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760452536; l=1565;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=5ta/LWaJssx4yk7oF1/lZyMoh3TyiMbwDeKhxJNX6dc=;
 b=sKXwbgsGVLEc50UvJM1yw3x3FEjRqnXqzMoO8H9FKQXr24+zf956wTA0YYMN4t4jJ9hO5KCrJ
 hppvDdLkLUHAtPfQzMiqDucxr3WizcBRjVSM8GhD8+VsTw5VmQgv0mN
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX5dyhCv3vK+1y
 uTEslEDWILxeeM7AeXzGoWJG+WmSQKqbW8RQUdAqPw+Xx9W36pwBESrrLNNLeMLepFyCeI5/y1D
 Va7JoHUU3CBsa84zPeyyjm4C4H2sj7NBj0GGDBMH+udZKpYAiJPB9JuP9fADN2ovp7LOdqSD2Ah
 jeSjbmFXhVYjrNcsDLz3LHZUDQ5Eb7GB7q3Yr8yJ31UMY7nRJfLR6KwncNpROUMGd/LaodDxNIj
 sQV7ufp0PuLc1uK6kIAA945cSfKMP6+uGEHWMJy3+q692xsRfZ053/YExP/VzESWOvRuAC7K7+s
 wOllV0ehyEVHaQ6/CJ1Gsfld84t9WXQ/z+YIjVOX0b7u9IqpKTjt0bgOzY20+TMTB5HZnfbGcIH
 1vbTRB9SSHw7PEvOAy2EFcenHMPxVg==
X-Proofpoint-ORIG-GUID: gZ95rBgNzNuInFetGUM9ONPZOzbqGt1j
X-Authority-Analysis: v=2.4 cv=bodBxUai c=1 sm=1 tr=0 ts=68ee5fd0 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=Qcuqu0ky38DJWFOqejsA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: gZ95rBgNzNuInFetGUM9ONPZOzbqGt1j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018

Add the NSSNOC master/slave ids for Qualcomm IPQ5424 network subsystem
(NSS) hardware blocks. These will be used by the gcc-ipq5424 driver
that provides the interconnect services by using the icc-clk framework.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 include/dt-bindings/interconnect/qcom,ipq5424.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/dt-bindings/interconnect/qcom,ipq5424.h b/include/dt-bindings/interconnect/qcom,ipq5424.h
index afd7e0683a24..c5e0dec0b300 100644
--- a/include/dt-bindings/interconnect/qcom,ipq5424.h
+++ b/include/dt-bindings/interconnect/qcom,ipq5424.h
@@ -20,6 +20,26 @@
 #define SLAVE_CNOC_PCIE3		15
 #define MASTER_CNOC_USB			16
 #define SLAVE_CNOC_USB			17
+#define MASTER_NSSNOC_NSSCC		18
+#define SLAVE_NSSNOC_NSSCC		19
+#define MASTER_NSSNOC_SNOC_0		20
+#define SLAVE_NSSNOC_SNOC_0		21
+#define MASTER_NSSNOC_SNOC_1		22
+#define SLAVE_NSSNOC_SNOC_1		23
+#define MASTER_NSSNOC_PCNOC_1		24
+#define SLAVE_NSSNOC_PCNOC_1		25
+#define MASTER_NSSNOC_QOSGEN_REF	26
+#define SLAVE_NSSNOC_QOSGEN_REF		27
+#define MASTER_NSSNOC_TIMEOUT_REF	28
+#define SLAVE_NSSNOC_TIMEOUT_REF	29
+#define MASTER_NSSNOC_XO_DCD		30
+#define SLAVE_NSSNOC_XO_DCD		31
+#define MASTER_NSSNOC_ATB		32
+#define SLAVE_NSSNOC_ATB		33
+#define MASTER_CNOC_LPASS_CFG		34
+#define SLAVE_CNOC_LPASS_CFG		35
+#define MASTER_SNOC_LPASS		36
+#define SLAVE_SNOC_LPASS		37
 
 #define MASTER_CPU			0
 #define SLAVE_L3			1

-- 
2.34.1


