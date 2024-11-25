Return-Path: <linux-pm+bounces-18018-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B859D7AEF
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 06:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA341281F6D
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 05:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0BC16BE20;
	Mon, 25 Nov 2024 05:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AK3OKQ1m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FC714F9D9;
	Mon, 25 Nov 2024 05:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732511314; cv=none; b=uCA/NAsJ7GfGni74JLfGwc3JFfT907ficgfH3gwia7R9tp7CVQANjRNv0UXZPAB+RelL1xgT81rsmeLtiOhMrZT0bDPaKPNy62AdsIeOLju681tHfERXBDB2O8k08JmjbzinLGEiOP9NbxTgu6eMzGDCG1A7Y5x9DBgTZkh5sfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732511314; c=relaxed/simple;
	bh=TuzqPVBSgHrKpRigVkR80EMUSgX1jZIOeg5dbAm6qFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMDStCd3hYj3A8khf7oaB9QhHrYCM7otrsVz/Imm8b0++y+HaNKQtKubS6cUFLsOtBd8x+SyRl+Tw6OtiLm/PjutNPJHsGFmN5fKWj9v8qtt6eBz6VysMGnhcLEoMyGXKiM1VtZ0hXUKcnm5ROhPTvGeXdM6RxhSY8Ja44yHmTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AK3OKQ1m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AONhkD1003461;
	Mon, 25 Nov 2024 05:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GPKoCuZ+wD5hqlLnTno4khP4jH1tacLrP3QoQoTl2pQ=; b=AK3OKQ1mCFB8zhwM
	qDjawYNgIUBo8RCDffK7hZ2A+8p3CDhUpE3IUmcw8s5y2qU6jb+II/LUGSmCLgj+
	J18B9FF6SGqcUv13UPIqYgWR9Bz5R+AHYh37akpiTNO8aTEv2twVC2L00Sj3UcZ9
	2N0yJ+ExlEga7tHuRnhM7GLAsmpusQ35yrwsAISm7p9RDEgZMSzVGVrmkLW4iPvV
	XVFGJtFOYHyWAr+AqDFrKZ4QUGhhp82AW0FTseZveQ/AL3hVfiA+twyulZuH0hw+
	Y08HXP4RMj3dS5Ggp/Z4QFav6UaBtcZHEKH2aitUDfhyJUCOAA0U9nKZhzLoa7da
	Hh6mPg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43374sue0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 05:08:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AP58NpN021611
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 05:08:23 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 24 Nov 2024 21:08:18 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v9 5/7] arm64: dts: qcom: ipq5332: Add thermal zone nodes
Date: Mon, 25 Nov 2024 10:37:26 +0530
Message-ID: <20241125050728.3699241-6-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125050728.3699241-1-quic_mmanikan@quicinc.com>
References: <20241125050728.3699241-1-quic_mmanikan@quicinc.com>
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
X-Proofpoint-GUID: CFOWzLJyFyxU3xcvKYZahsaW54LZ-SkP
X-Proofpoint-ORIG-GUID: CFOWzLJyFyxU3xcvKYZahsaW54LZ-SkP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411250041

From: Praveenkumar I <quic_ipkumar@quicinc.com>

This patch adds thermal zone nodes for sensors present in
IPQ5332.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V9:
	- No change

 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 69 +++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index d643dafe5846..4f37781de86a 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -554,4 +554,73 @@ timer {
 			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
+
+	thermal-zones {
+		rfa-0-thermal {
+			thermal-sensors = <&tsens 11>;
+
+			trips {
+				rfa-0-critical {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		rfa-1-thermal {
+			thermal-sensors = <&tsens 12>;
+
+			trips {
+				rfa-1-critical {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		misc-thermal {
+			thermal-sensors = <&tsens 13>;
+
+			trips {
+				misc-critical {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-top-thermal {
+			polling-delay-passive = <100>;
+			thermal-sensors = <&tsens 14>;
+
+			trips {
+				cpu-top-critical {
+					temperature = <115000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+
+				cpu-passive {
+					temperature = <105000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		top-glue-thermal {
+			thermal-sensors = <&tsens 15>;
+
+			trips {
+				top-glue-critical {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+	};
 };
-- 
2.34.1


