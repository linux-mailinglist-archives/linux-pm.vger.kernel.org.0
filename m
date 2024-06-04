Return-Path: <linux-pm+bounces-8550-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA218FA762
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 03:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996FD28693B
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 01:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D902C8F66;
	Tue,  4 Jun 2024 01:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="acMR1Poc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC6B18EAF;
	Tue,  4 Jun 2024 01:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717463609; cv=none; b=YT9d3OUlDuDMC7wuPHjbQqExZy5z7pgiJFnl6p8N63D83dmGEkLSJQxOUDSNVGq23Cbj3J9MRTzY6PKMuDJQNe73ILtR6Q7F0HOYd/rYqVLcX6QIsEVeolCBAM0EsaGMKauGdQxp4+2veAqiaaxHlUP6e4yMWQhY3IV2nU1zjq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717463609; c=relaxed/simple;
	bh=0MJjx4QjT0jX2wWToiHvtIu7YcmjnzcYZNMa19A0KSM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nY+Nz3nCdSWvTBIsnN8iWoK3iOvsBMDxQStMMSOhPTvbQgp6XP6pa8CbR0HD5jxfk3IJJydRJRPJR6yqww0Y7X/k1BxUBPJs2dea0shIZ9BQVEKiFhqsM4z85NE7BVXbl2/PqmZMoZAqaTgzwnW2OHSJBXQ+d9vvCuFPJu0Hc1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=acMR1Poc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453D265n031534;
	Tue, 4 Jun 2024 01:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F/W4lDdY6X2lh6aTgZSzx4PYPpK0djVRNtFVTL8YCPk=; b=acMR1Pocd4kZPoD9
	2cZgrPP7NE8YFVJAiXnL+fWo2Q3+iPXUrTxS7+So4+aLITsEBmzVtXsMZ+1RGjiV
	MREXIKZ78udnQfhNULdZ+QHXwwDkyMwUdc3mGagINDlPoXoz6uz2H3HJpEyW5pIw
	4IwDF+Xa6cvh2WVWnCTrjz5LOop6vnymoFZwLlLjfQxLQh6jxAKvh3hN+uUgELSA
	wSFmutZiiogT39pNJv+0f14nkV06r0J2ppA6qhs/60D3GYfmJBMKqsX9g+AY90uK
	EuuJm/5cZKf9OdaklVOc0QXenAfeZJTAdNZ9u60Gn/ZKCRnL/9lpwfiZhA95mvLl
	VE3CaQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw4bdcuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 01:13:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4541DNhf023372
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Jun 2024 01:13:23 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Jun 2024 18:13:18 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <srinivas.kandagatla@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <quic_sibis@quicinc.com>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <abel.vesa@linaro.org>
Subject: [PATCH 3/4] arm64: dts: qcom: x1e80100: Add BWMONs
Date: Tue, 4 Jun 2024 06:41:56 +0530
Message-ID: <20240604011157.2358019-4-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604011157.2358019-1-quic_sibis@quicinc.com>
References: <20240604011157.2358019-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 18uscrXsqX-CN_9yCd2j9tn6Djfb0JcD
X-Proofpoint-GUID: 18uscrXsqX-CN_9yCd2j9tn6Djfb0JcD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_17,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=823 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406040008

Add the CPU and LLCC BWMONs on X1E80100 SoCs.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 169 +++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 1929c34ae70a..d86c4d3be126 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -5329,6 +5329,175 @@ cpu_scp_lpri1: scp-sram-section@200 {
 			};
 		};
 
+		pmu@24091000 {
+			compatible = "qcom,x1e80100-llcc-bwmon", "qcom,sc7280-llcc-bwmon";
+			reg = <0 0x24091000 0 0x1000>;
+
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+
+			interconnects = <&mc_virt MASTER_LLCC 3 &mc_virt SLAVE_EBI1 3>;
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
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &gem_noc SLAVE_LLCC 3>;
+			operating-points-v2 = <&cpu0_bwmon_opp_table>;
+
+			cpu0_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-1 {
+					opp-peak-kBps = <4800000>;
+				};
+
+				opp-2 {
+					opp-peak-kBps = <7464000>;
+				};
+
+				opp-3 {
+					opp-peak-kBps = <9600000>;
+				};
+
+				opp-4 {
+					opp-peak-kBps = <12896000>;
+				};
+
+				opp-5 {
+					opp-peak-kBps = <14928000>;
+				};
+
+				opp-6 {
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
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &gem_noc SLAVE_LLCC 3>;
+			operating-points-v2 = <&cpu8_bwmon_opp_table>;
+
+			cpu8_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-1 {
+					opp-peak-kBps = <4800000>;
+				};
+
+				opp-2 {
+					opp-peak-kBps = <7464000>;
+				};
+
+				opp-3 {
+					opp-peak-kBps = <9600000>;
+				};
+
+				opp-4 {
+					opp-peak-kBps = <12896000>;
+				};
+
+				opp-5 {
+					opp-peak-kBps = <14928000>;
+				};
+
+				opp-6 {
+					opp-peak-kBps = <17064000>;
+				};
+			};
+		};
+
+		pmu@240b6400 {
+			compatible = "qcom,x1e80100-cpu-bwmon", "qcom,sdm845-bwmon";
+			reg = <0 0x240b6400 0 0x600>;
+
+			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &gem_noc SLAVE_LLCC 3>;
+			operating-points-v2 = <&cpu4_bwmon_opp_table>;
+
+			cpu4_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-1 {
+					opp-peak-kBps = <4800000>;
+				};
+
+				opp-2 {
+					opp-peak-kBps = <7464000>;
+				};
+
+				opp-3 {
+					opp-peak-kBps = <9600000>;
+				};
+
+				opp-4 {
+					opp-peak-kBps = <12896000>;
+				};
+
+				opp-5 {
+					opp-peak-kBps = <14928000>;
+				};
+
+				opp-6 {
+					opp-peak-kBps = <17064000>;
+				};
+			};
+		};
+
 		system-cache-controller@25000000 {
 			compatible = "qcom,x1e80100-llcc";
 			reg = <0 0x25000000 0 0x200000>,
-- 
2.34.1


