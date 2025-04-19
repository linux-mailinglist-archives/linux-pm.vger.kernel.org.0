Return-Path: <linux-pm+bounces-25753-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 147DBA94401
	for <lists+linux-pm@lfdr.de>; Sat, 19 Apr 2025 16:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE8F16E38F
	for <lists+linux-pm@lfdr.de>; Sat, 19 Apr 2025 14:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5AF1E25FA;
	Sat, 19 Apr 2025 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OQdnhnsM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92761DF748;
	Sat, 19 Apr 2025 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745074400; cv=none; b=W0JGAnr/aN0oXJ3CScnwcH3r5mqHW1O4fSV9JN6OPXxmTUjDyG5RUmvPFsz+oHfB6QNMcrlJnp9FAaVcEahcx8KV6OZ6K48ZyZooMwRqTKgYHrxVf/KFYGOSurZZPO8Iek2lEMXT+mVP4wJ2MFH20AG3Et/MVuYuFjUuNmrTqks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745074400; c=relaxed/simple;
	bh=4T/HC8WzUNag3b/TdI9h2sRpr8wstnE/YPlEJLgaE0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EtRuBwcHoHi/X3PhLzIonApM6WCyjpQm6/+9krK7Wtm9AN2mRGbt6s4GdgFApOOqAvMPXFv0gtX38DTyW7SgraynJxoXuxPKhQrLNrZvH/hMuETCHGPqwN9py0+JtLONGcHT5C0GaF38yTdQj4bcpiADKJXYa9RWeqn+xBy09xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OQdnhnsM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53JCrWg7029716;
	Sat, 19 Apr 2025 14:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bwb4ARwyOqLXEZJuxL4XbgDNIeBe8WVK6SbMRHhkI0Q=; b=OQdnhnsMGmSEyhwS
	Q0eYzAX29n8O1/I1uUQYq4e4bAKnsMRPKdTdkMaCqqDljvepA7Aw+8I7xqgaQwvy
	LNdj+BE709VZZygvRw3SUFapv0Tp4R5M9QnZyH2NJX00GXBs7o3BNvQ7nl2DReyl
	Claouvyjg/Wvt88Ab27Tj89OQjd4UcPohIzzW2Il4CLMM7Z/Nw4aEZH6gp0yinil
	5pwrtNx8dGDUi88c63K+7wYpkDx92OuO7MhUCSsDaWEgTYUU+nqDXFq9/wMrAYuz
	F7T4Iakj+ZVa8aQGi3ojhdh041o7AgP/EFRMNlbGEMsfqS1w2JR1jLEpoqVPU05c
	090RnQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4644kj8kk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 14:52:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53JEqrmQ011225
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 14:52:53 GMT
Received: from [10.213.111.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 19 Apr
 2025 07:52:47 -0700
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
Date: Sat, 19 Apr 2025 20:21:36 +0530
Subject: [PATCH v5 7/7] arm64: dts: qcom: x1e80100: Add OPPs up to Turbo L3
 for GPU
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250419-gpu-acd-v5-7-8dbab23569e0@quicinc.com>
References: <20250419-gpu-acd-v5-0-8dbab23569e0@quicinc.com>
In-Reply-To: <20250419-gpu-acd-v5-0-8dbab23569e0@quicinc.com>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        "Konrad
 Dybcio" <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Viresh Kumar
	<vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Akhil P Oommen
	<quic_akhilpo@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "Maya
 Matuszczyk" <maccraft123mc@gmail.com>,
        Anthony Ruhier <aruhier@mailbox.org>,
        Dmitry Baryshkov <lumag@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745074319; l=1555;
 i=quic_akhilpo@quicinc.com; s=20240726; h=from:subject:message-id;
 bh=4T/HC8WzUNag3b/TdI9h2sRpr8wstnE/YPlEJLgaE0k=;
 b=SPrpVMe6gPY8xO31yY4dNQtmho0P0E+RHd/Y7BByIm6m0qPQVD6u2uu9RubnEr3sFvvX1d9nB
 +Y/TMsFnIHrCF+O69rPsRWi68Adlh87NgxBrpBzl+WVk+znMAxwyZ3d
X-Developer-Key: i=quic_akhilpo@quicinc.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iiDqqIGQXDt2awhmICwderBpiQ22fTix
X-Authority-Analysis: v=2.4 cv=f5pIBPyM c=1 sm=1 tr=0 ts=6803b8c6 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=b3CbU_ItAAAA:8 a=1Bjw1aJ-qlzXb4ygRX0A:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-ORIG-GUID: iiDqqIGQXDt2awhmICwderBpiQ22fTix
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=928 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504190122

Now that we have ACD support for GPU, add additional OPPs up to
Turbo L3 which are supported across all existing SKUs.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Maya Matuszczyk <maccraft123mc@gmail.com>
Tested-by: Anthony Ruhier <aruhier@mailbox.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index a9c8cca1c6356393962cef856b3dbd9420733999..8eddf0c9609871b8660587a22b008212a67604b3 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3754,10 +3754,24 @@ zap-shader {
 			gpu_opp_table: opp-table {
 				compatible = "operating-points-v2-adreno", "operating-points-v2";
 
+				opp-1250000000 {
+					opp-hz = /bits/ 64 <1250000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L3>;
+					opp-peak-kBps = <16500000>;
+					qcom,opp-acd-level = <0xa82a5ffd>;
+				};
+
+				opp-1175000000 {
+					opp-hz = /bits/ 64 <1175000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L2>;
+					opp-peak-kBps = <14398438>;
+					qcom,opp-acd-level = <0xa82a5ffd>;
+				};
+
 				opp-1100000000 {
 					opp-hz = /bits/ 64 <1100000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
-					opp-peak-kBps = <16500000>;
+					opp-peak-kBps = <14398438>;
 					qcom,opp-acd-level = <0xa82a5ffd>;
 				};
 

-- 
2.48.1


