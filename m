Return-Path: <linux-pm+bounces-25752-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90124A943FC
	for <lists+linux-pm@lfdr.de>; Sat, 19 Apr 2025 16:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A88457A7631
	for <lists+linux-pm@lfdr.de>; Sat, 19 Apr 2025 14:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ECD1DF244;
	Sat, 19 Apr 2025 14:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PgX2I5k5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E76D1DEFE9;
	Sat, 19 Apr 2025 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745074396; cv=none; b=NLd0G4KWj04pMLms9VVDqgkwoUimW8GKeulPCkU0Z63BaQyIu5epFO87SkybWK1lU0Ef2mqDx9Ik3e0d7ehvq7WjR9Hhbx6Baur5qUPorCfhWwIx66sdzJB43NaEYMKMvr06M88gn6ZfDSmXnQggHFo6e1APgajHhD16rb5qaP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745074396; c=relaxed/simple;
	bh=cwK0Yi1Ms1d4HSG6uhxdA/cIZtja517mYl3gFatnwaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=U3dpqUoV+N76d5tkanWyiaK0DbaRgkhMVz3+mCYfnluPOmRwHD0L4HJ7fEv4joJWxNiukYN+IDoKEchXTZ7oD+Z7LzNoGxG4Ue3j4bmjgyHaYONjKw7BWagfRsewoHBH9PstlggU/AEvqoyXlEDpaAyCigDVQAcv7lECLHn0044=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PgX2I5k5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53JAMY4m029856;
	Sat, 19 Apr 2025 14:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CtZccpwAemkEA1sdRi1DngJ9WIAcI+3Hcq11UhxSWKU=; b=PgX2I5k5vH+MPjlR
	a3KtJGeQ5TodWwjW/oZUNm9arR3/nt00xZKF4Ix9QRbTxIExlX5nUDPxlPq1RXP2
	BBuSQAP65mDTNLF8VOOiVN5q5XsFGZU499r+WknswBNTdn/3OLTqebDy8xgffVmw
	ZS1kVUj8KAFUNoxCYfeA8Hu0OaxrXe4zUZKnSlR5elRyulBUTfiW5HaLNinwLJ04
	OrAbCGINlIWE+Gz9QGdPl9MfBieJJkAwagw8h6kcvPdq9cPUQMi8G/73Kf/ZSjgT
	wy+Spd4Z5XlrL7n5bXPAJn+aDOzPgPvT318dFK72kqsxlAazE7d4zH6JfCVggBA8
	bP4FqA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4643wwgnq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 14:52:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53JEqk9t013560
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 14:52:46 GMT
Received: from [10.213.111.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 19 Apr
 2025 07:52:40 -0700
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
Date: Sat, 19 Apr 2025 20:21:35 +0530
Subject: [PATCH v5 6/7] arm64: dts: qcom: x1e80100: Add ACD levels for GPU
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250419-gpu-acd-v5-6-8dbab23569e0@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745074319; l=2693;
 i=quic_akhilpo@quicinc.com; s=20240726; h=from:subject:message-id;
 bh=cwK0Yi1Ms1d4HSG6uhxdA/cIZtja517mYl3gFatnwaQ=;
 b=2ogLocCuNsRpYwupdMH8UI+VmnwPPnJU/S9caV/+dO0zq3L5Dvm75g0vXF1YdylpGsxSSS97K
 P57E+r4eogeBPZTgmauI8TuqpXcTQjGstnFzjoD3sWQWD/IXDBgdmBH
X-Developer-Key: i=quic_akhilpo@quicinc.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=IpEecK/g c=1 sm=1 tr=0 ts=6803b8c0 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=b3CbU_ItAAAA:8 a=VcD_Odrf9_TlHS68OuAA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-GUID: 0HHEKMpjRqgAgslzkFmodhgiUWiYMznw
X-Proofpoint-ORIG-GUID: 0HHEKMpjRqgAgslzkFmodhgiUWiYMznw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=855
 impostorscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504190122

Update GPU node to include acd level values.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Maya Matuszczyk <maccraft123mc@gmail.com>
Tested-by: Anthony Ruhier <aruhier@mailbox.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 4936fa5b98ff7a9a009e3106f4dba90131251971..a9c8cca1c6356393962cef856b3dbd9420733999 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3752,60 +3752,69 @@ zap-shader {
 			};
 
 			gpu_opp_table: opp-table {
-				compatible = "operating-points-v2";
+				compatible = "operating-points-v2-adreno", "operating-points-v2";
 
 				opp-1100000000 {
 					opp-hz = /bits/ 64 <1100000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
 					opp-peak-kBps = <16500000>;
+					qcom,opp-acd-level = <0xa82a5ffd>;
 				};
 
 				opp-1000000000 {
 					opp-hz = /bits/ 64 <1000000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
 					opp-peak-kBps = <14398438>;
+					qcom,opp-acd-level = <0xa82b5ffd>;
 				};
 
 				opp-925000000 {
 					opp-hz = /bits/ 64 <925000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
 					opp-peak-kBps = <14398438>;
+					qcom,opp-acd-level = <0xa82b5ffd>;
 				};
 
 				opp-800000000 {
 					opp-hz = /bits/ 64 <800000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
 					opp-peak-kBps = <12449219>;
+					qcom,opp-acd-level = <0xa82c5ffd>;
 				};
 
 				opp-744000000 {
 					opp-hz = /bits/ 64 <744000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
 					opp-peak-kBps = <10687500>;
+					qcom,opp-acd-level = <0x882e5ffd>;
 				};
 
 				opp-687000000 {
 					opp-hz = /bits/ 64 <687000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
 					opp-peak-kBps = <8171875>;
+					qcom,opp-acd-level = <0x882e5ffd>;
 				};
 
 				opp-550000000 {
 					opp-hz = /bits/ 64 <550000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
 					opp-peak-kBps = <6074219>;
+					qcom,opp-acd-level = <0xc0285ffd>;
 				};
 
 				opp-390000000 {
 					opp-hz = /bits/ 64 <390000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
 					opp-peak-kBps = <3000000>;
+					qcom,opp-acd-level = <0xc0285ffd>;
 				};
 
 				opp-300000000 {
 					opp-hz = /bits/ 64 <300000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
 					opp-peak-kBps = <2136719>;
+					qcom,opp-acd-level = <0xc02b5ffd>;
 				};
 			};
 		};

-- 
2.48.1


