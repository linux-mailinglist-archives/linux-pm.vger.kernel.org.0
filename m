Return-Path: <linux-pm+bounces-15558-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69EE99AD8F
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 22:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE55287454
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 20:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D498E1D174A;
	Fri, 11 Oct 2024 20:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i/mycbrp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3521D14E0;
	Fri, 11 Oct 2024 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728678644; cv=none; b=rfELKhaOLnQtmnZMO8C9VpIoE91wtANas+eeRexwVs9fU+esfwWrg6KIkCvk9Sf4jgXA8Cv/+hCdw3Sl2JPBfMYGS1SjHNKbRBuUkubRU135UOXO4ag5l8sRwhyrKtKIyTNHMOpRwgOitcU0tTrQIsJRMYKjuZz+f0Y9zwuArLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728678644; c=relaxed/simple;
	bh=kSN6Qf/np2JHr04GL7BD7rr7xGnCoT7orLpsgMOvUb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DN7AoH+1OMpiAokRgSar7zGRpyHSZUQ6cN1NF37nrDCq60TJOOoKm1jTkQrn2SicRrf8WinAf6rkvCsRkIsg6r8g0IOFW6frqXl8z94n9x2KfwnzUy4AA87UEuXa/EbSxX/97a6FhN7FNtE64ORW/HI9FWBMkX2+r4hojl4KGuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i/mycbrp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BFf04a023975;
	Fri, 11 Oct 2024 20:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aLkvekefPD3B+IbGrBJhkngClyZCmFG0RTm3Wfr5X68=; b=i/mycbrpGHFzdnO+
	3nvL5eNZZSwUAX9R3IfD7P/Yq/kkYOR+NFAFoUWEL6F8Da7ZFaee96KCMWQ3kK/i
	jMKNMqG78IdoSouoN6gqwgcwGFUNwWSKT+xmQWAx6lsFjsgZmGr0br+lMp3NeD6W
	hcg+sFiMkT5EJ4OWkRhmgh3f2b3NrYKpLaCiqERH8vAgsb8gFUbXbv75HJVsnscO
	c/inlf9uQof4w1diMOatbMeDh9c4ICWk8K87fHax9bd9rK9ao3wLG6XKUh5rcpVc
	lVKyd+Fxggjb95cqGonZ1xYdznsX8kPyrji6k0HoLFhHwWaOKZJMf6a+7lBk4XJn
	yv8urQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 426y3vt6nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 20:30:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49BKUUIH024900
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 20:30:30 GMT
Received: from [10.213.111.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 11 Oct
 2024 13:30:24 -0700
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
Date: Sat, 12 Oct 2024 01:59:30 +0530
Subject: [PATCH RFC 3/3] arm64: dts: qcom: x1e80100: Add ACD levels for GPU
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241012-gpu-acd-v1-3-1e5e91aa95b6@quicinc.com>
References: <20241012-gpu-acd-v1-0-1e5e91aa95b6@quicinc.com>
In-Reply-To: <20241012-gpu-acd-v1-0-1e5e91aa95b6@quicinc.com>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        "Konrad
 Dybcio" <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon
	<nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728678606; l=2450;
 i=quic_akhilpo@quicinc.com; s=20240726; h=from:subject:message-id;
 bh=kSN6Qf/np2JHr04GL7BD7rr7xGnCoT7orLpsgMOvUb0=;
 b=MSKX1CdntVYslBe60UodsXukJZmLDmIj49ZIwGM10LW/kMOCcYAhBKElvADQn4JaYdpOKbIlR
 ZppX7VivdJGDn7pv9vwXe7i0l/0VGPsKhpZdd0d0M3ssDIpdFsqO+Ou
X-Developer-Key: i=quic_akhilpo@quicinc.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ce3s_howiHHxhiASQSkqKbOlgcp0X-tk
X-Proofpoint-GUID: Ce3s_howiHHxhiASQSkqKbOlgcp0X-tk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 clxscore=1015 mlxscore=0 phishscore=0 impostorscore=0 adultscore=0
 mlxlogscore=785 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410110143

Update GPU node to include acd level values.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index a36076e3c56b..e6c500480eb1 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3323,60 +3323,69 @@ zap-shader {
 			};
 
 			gpu_opp_table: opp-table {
-				compatible = "operating-points-v2";
+				compatible = "operating-points-v2-adreno";
 
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
2.45.2


