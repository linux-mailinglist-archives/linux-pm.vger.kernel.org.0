Return-Path: <linux-pm+bounces-9481-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D3F90D79F
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 17:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00EE4288CFF
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 15:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D70D130E4A;
	Tue, 18 Jun 2024 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R2TyZkR+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD5D7D401;
	Tue, 18 Jun 2024 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725427; cv=none; b=ZOWFnGZqjr6PvWnL/KyrYMQfwwOUSl2oixh1hWFFzdjyFXnuc+vsfM3k8pml/k86cOTHSWONm03+CSgVSIIyMUlGiJZkVwWEqz97U9xKQJyp6Tqw9Lh0SuCAsRCPcjAhPj3txZERAkSY/egw+kRfif8QfHBIDNS9oKnMl/J5/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725427; c=relaxed/simple;
	bh=1iyvyvdlNcpQgO68rGlstK2TPWgSviLBiSjlN5hjUcg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSL3zp42qms3oz2ccyl3WqPtnldbhbC0GFr8iTpiqseGIu+38rjuEUdFLaYfTvxbWUf/KFjLtyiOhO3+Bml0maxnXLMa/nsKojCwIr9VwSerTNl0cAoYPV6hakNO/WGoUs9CtRcMTO7ZrincZ/LJonpkCsdwnp3lAp7K7CBRzP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R2TyZkR+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IBuea3018642;
	Tue, 18 Jun 2024 15:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DmqfayM9s7xgTIVNPfY+wGeEaUtQTuZQkA9EwVbSZFo=; b=R2TyZkR+bEkdSxlD
	4t0Le0sjQJ8AyE0qtNaHQge1ACltCkISaQnKC5W+76oPLhL8rxQCP5enbrgOlBRc
	c3dTJFdWywZpcaRPXKKzr+ypAcEJFlWPLul4fBAfZ+HwC5ah3lF8/NK+p+k5csge
	eufdKmi/maVneSEa9yE+STh4JmbJNoZuTlnoQ5Lm7F/koPWAKNYcVO5aJhhwteVr
	Ha24B3pjodQcWclSHceTTCeJSTjH1NeUXRdlo2S8JCTT74wYI/eI1IN3rhaXzton
	V3TTPP0pC7oHWK412GS7RYonakWxk4JvvfauO0Vculq3SrmNgg5P47ZdAuOIy1A1
	qhJoLQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yu22gsq1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 15:43:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45IFhelr016882
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 15:43:40 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Jun 2024 08:43:35 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <srinivas.kandagatla@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <quic_sibis@quicinc.com>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <abel.vesa@linaro.org>
Subject: [PATCH V2 3/3] arm64: dts: qcom: x1e80100: Add BWMONs
Date: Tue, 18 Jun 2024 21:13:06 +0530
Message-ID: <20240618154306.279637-4-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618154306.279637-1-quic_sibis@quicinc.com>
References: <20240618154306.279637-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -eGVITtBTPpmMSsNrRYd3YO9Eu9-W3WZ
X-Proofpoint-GUID: -eGVITtBTPpmMSsNrRYd3YO9Eu9-W3WZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 mlxlogscore=916 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180118

Add the CPU and LLCC BWMONs on X1E80100 SoCs.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v2:
* Allow for opp-tables to be optional on X1E cpu-bwmon instances. [Konrad]
* Use consistent numbering of the opps across instances. [Shiv]
* Use ICC_TAG_ACTIVE_ONLY instead of magic numbers. [Konrad]

 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 120 +++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 9944c654851e..d8b972c2bc3e 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -5299,6 +5299,126 @@ frame@1780d000 {
 			};
 		};
 
+		pmu@24091000 {
+			compatible = "qcom,x1e80100-llcc-bwmon", "qcom,sc7280-llcc-bwmon";
+			reg = <0 0x24091000 0 0x1000>;
+
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+
+			interconnects = <&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+
+			operating-points-v2 = <&llcc_bwmon_opp_table>;
+
+			llcc_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <800000>;
+				};
+
+				opp-1 {
+					opp-peak-kBps = <2188000>;
+				};
+
+				opp-2 {
+					opp-peak-kBps = <3072000>;
+				};
+
+				opp-3 {
+					opp-peak-kBps = <6220800>;
+				};
+
+				opp-4 {
+					opp-peak-kBps = <6835200>;
+				};
+
+				opp-5 {
+					opp-peak-kBps = <8371200>;
+				};
+
+				opp-6 {
+					opp-peak-kBps = <10944000>;
+				};
+
+				opp-7 {
+					opp-peak-kBps = <12748800>;
+				};
+
+				opp-8 {
+					opp-peak-kBps = <14745600>;
+				};
+
+				opp-9 {
+					opp-peak-kBps = <16896000>;
+				};
+			};
+		};
+
+		pmu@240b3400 {
+			compatible = "qcom,x1e80100-cpu-bwmon", "qcom,sdm845-bwmon";
+			reg = <0 0x240b3400 0 0x600>;
+
+			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>;
+
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+
+			cpu_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <4800000>;
+				};
+
+				opp-1 {
+					opp-peak-kBps = <7464000>;
+				};
+
+				opp-2 {
+					opp-peak-kBps = <9600000>;
+				};
+
+				opp-3 {
+					opp-peak-kBps = <12896000>;
+				};
+
+				opp-4 {
+					opp-peak-kBps = <14928000>;
+				};
+
+				opp-5 {
+					opp-peak-kBps = <17064000>;
+				};
+			};
+		};
+
+		pmu@240b5400 {
+			compatible = "qcom,x1e80100-cpu-bwmon", "qcom,sdm845-bwmon";
+			reg = <0 0x240b5400 0 0x600>;
+
+			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>;
+
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+		};
+
+		pmu@240b6400 {
+			compatible = "qcom,x1e80100-cpu-bwmon", "qcom,sdm845-bwmon";
+			reg = <0 0x240b6400 0 0x600>;
+
+			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>;
+
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+		};
+
 		system-cache-controller@25000000 {
 			compatible = "qcom,x1e80100-llcc";
 			reg = <0 0x25000000 0 0x200000>,
-- 
2.34.1


