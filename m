Return-Path: <linux-pm+bounces-19418-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C28239F6385
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 11:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C3B166880
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 10:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70E919D091;
	Wed, 18 Dec 2024 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o4TmasGQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF3919D072;
	Wed, 18 Dec 2024 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734518432; cv=none; b=rcVMcVLDqBz7g4uUQPYKGBdbVk4hubhr+ExydeDEEoZhNa9S1tLofOBvO4YtijWuqfCuMbx63qE7V6j2u+KXwvbav8nJL9sgK4oDVr7XQ7oDYKoQo2EponEF3hSL6HB+wAsyJsk0UYk6TWA15OxQdvAdktRIr4+VmqNAhpx5hpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734518432; c=relaxed/simple;
	bh=NBrWsjdOdOtXVPT086c06ucUVWg4GkYQaJindA760Lk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mZK0mmAqj8gnhz22lc66BPNftCg7NYXNC4+0DbuXMU/AlnEp55KNywsMbqPEz5heFY8tfLO9dx0nNMlnEFM/hoIFa1P3JTa4rw8NoCmBmwt+oCicXr4kDUquaHMIsV09qU9iVrjtU+4J9laXhzBWKxmq11Ey1ARLvANMuSExLWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o4TmasGQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI8mbtk027172;
	Wed, 18 Dec 2024 10:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C0gBA8vbAkCEhzYy5FAZGzsyYOSqA+is6Y5Y8LJS7Vc=; b=o4TmasGQzrsc0aUD
	KAsxc9K08LRXp1A5u777ldKVzQSKmjoTPBnJw6CodX5utm+m8Xyu0gf+qXWJuFYe
	zxoXqrVC4VIvQUQCqZtz36WVo1eqmnJYTWNzSSAxxLRKOjMppWbfroGx3H3q70CP
	936O0RAaSnynUJLXuZzXMF8J8B51BTXOLcU1/Xmcp06OhPuRbpaqa1nEywRZRaRm
	1S5A20r2M9m7KAlUBS27wl0uhmgnLOGvFN2edQX+Van51By+B91ppKQZJW9jCBYL
	Q1PljyZWFfIGw4RWI1lvgeUm7inE9V5q/KT53HGzG++av3WTEE/QtmZKmwRaww2C
	Pd1smg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ku7808wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 10:40:27 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BIAePxK031941
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 10:40:25 GMT
Received: from lijuang2-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 18 Dec 2024 02:40:19 -0800
From: Lijuan Gao <quic_lijuang@quicinc.com>
Date: Wed, 18 Dec 2024 18:39:39 +0800
Subject: [PATCH 2/2] arm64: dts: qcom: qcs615: Add CPU and LLCC BWMON
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241218-add_bwmon_support_for_qcs615-v1-2-680d798a19e5@quicinc.com>
References: <20241218-add_bwmon_support_for_qcs615-v1-0-680d798a19e5@quicinc.com>
In-Reply-To: <20241218-add_bwmon_support_for_qcs615-v1-0-680d798a19e5@quicinc.com>
To: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Lijuan Gao <quic_lijuang@quicinc.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734518412; l=2450;
 i=quic_lijuang@quicinc.com; s=20240827; h=from:subject:message-id;
 bh=NBrWsjdOdOtXVPT086c06ucUVWg4GkYQaJindA760Lk=;
 b=Uz7o+lxSzsO+NlPznauq32WjYj1KD0oPt/PT9XYn4hiljL3cTwdCcdLw84QEGzZGlp0sBN2xs
 mDJL0w8BfVzAMicBYA1bFWbAAMc4FeGS/cctemS+dCOP8iC8WGXmbwU
X-Developer-Key: i=quic_lijuang@quicinc.com; a=ed25519;
 pk=1zeM8FpQK/J1jSFHn8iXHeb3xt7F/3GvHv7ET2RNJxE=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rrCvNGir1n_BwvVeCHPiGn66dlT-ddSY
X-Proofpoint-GUID: rrCvNGir1n_BwvVeCHPiGn66dlT-ddSY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 mlxlogscore=992 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412180085

Add CPU and LLCC BWMON nodes and their corresponding opp tables to
support bandwidth monitoring on QCS615 SoC. This is necessary to enable
power management and optimize system performance from the perspective of
dynamically changing LLCC and DDR frequencies.

Signed-off-by: Lijuan Gao <quic_lijuang@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs615.dtsi | 72 ++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
index c0e4b376a1c6..45a4d9a76163 100644
--- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
@@ -2753,6 +2753,78 @@ cti@7900000 {
 			clock-names = "apb_pclk";
 		};
 
+		pmu@90b6300 {
+			compatible = "qcom,qcs615-cpu-bwmon", "qcom,sdm845-bwmon";
+			reg = <0x0 0x090b6300 0x0 0x600>;
+			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>;
+
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+
+			cpu_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <12896000>;
+				};
+
+				opp-1 {
+					opp-peak-kBps = <14928000>;
+				};
+			};
+		};
+
+		pmu@90cd000 {
+			compatible = "qcom,qcs615-llcc-bwmon", "qcom,sc7280-llcc-bwmon";
+			reg = <0x0 0x090cd000 0x0 0x1000>;
+			interrupts = <GIC_SPI 667 IRQ_TYPE_LEVEL_HIGH>;
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
+					opp-peak-kBps = <1200000>;
+				};
+
+				opp-2 {
+					opp-peak-kBps = <1804800>;
+				};
+
+				opp-3 {
+					opp-peak-kBps = <2188800>;
+				};
+
+				opp-4 {
+					opp-peak-kBps = <2726400>;
+				};
+
+				opp-5 {
+					opp-peak-kBps = <3072000>;
+				};
+
+				opp-6 {
+					opp-peak-kBps = <4070400>;
+				};
+
+				opp-7 {
+					opp-peak-kBps = <5414400>;
+				};
+
+				opp-8 {
+					opp-peak-kBps = <6220800>;
+				};
+			};
+		};
+
 		dc_noc: interconnect@9160000 {
 			reg = <0x0 0x09160000 0x0 0x3200>;
 			compatible = "qcom,qcs615-dc-noc";

-- 
2.46.0


