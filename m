Return-Path: <linux-pm+bounces-23956-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B92A5EB74
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 07:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E464616CF4F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 06:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A541FBE9F;
	Thu, 13 Mar 2025 06:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lFT7W7Of"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC2F1FBE92;
	Thu, 13 Mar 2025 06:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741845846; cv=none; b=g3Q8V1DUvxHBT6kfHbQIpP/ygrJQDNAw9WNkapI18aV2oImfGzr07K6NB9NyBJV1orl2ZIuzSpltFjj6RVKBWkxtJpX0uu+ohTYdOt5CddA0mgW5a17dI0uC5M8YnhJ4EWZqCwbKXrUyX/rXHG41wD6RKB7OJKMGl1BxnpRUdys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741845846; c=relaxed/simple;
	bh=UqnA4Y9ZnkmDLOxHRgyITFmrTx5GTkAFBtGcKpO/xI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hcSFy8/fgY6M2aunZDAboFUNPi5gTxeptd/HiBfFHlTJ/qGjxnVmC1vHdN0qrWPXfw5skNDaK8b7xTHy7AnVKOq6qMAVpHmiCREDyf5hkbofrtPwbHCCvYHvCc6zHT3ome9Y+HjYZIRtemU236O3cevCvbMZHjeFDFvoUhK2TLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lFT7W7Of; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D2KLXD007310;
	Thu, 13 Mar 2025 06:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uAEYDZT7XNQdv+gxhZhu0lkAO2jOF3EV0Qf8X8IkF+Q=; b=lFT7W7Of7cjOxBiN
	qiqnqwaFDIz+LQAhIaiM18YUOEL7QYw3AuFHN3/QIjZtqJqVIGQNiFDSH6mV8gNK
	TuIcLOvEnomI2YOzr6dYJlGB0Ibu0xRQUnMuQ4tkxq4iOxqd3GfZA+x2E6P3rGNH
	W0YSM8wBzsrVwKKsqeNW04IGtEo1uVGcA5bRBu6fAYLXRXd9e/4OXQPO6vwazUkb
	jh/8cVcBIy96EJE3QrYG/FP7uVe3IBqSq1sAnLh0eDhwwRXgE3KrkDyTqOwSkpis
	Ikt6TyzpZel4250x5QHmZU9JLnOHXptyeyiTniW90sHYhsM5Pt+P4CvW2Ng4V/A0
	rm07Tw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45bpg88fx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 06:04:01 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52D640sM031484
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 06:04:00 GMT
Received: from hu-imrashai-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Mar 2025 23:03:56 -0700
From: Imran Shaik <quic_imrashai@quicinc.com>
Date: Thu, 13 Mar 2025 11:33:40 +0530
Subject: [PATCH 2/2] arm64: dts: qcom: qcs8300: Add cpufreq scaling node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250313-qcs8300-cpufreq-scaling-v1-2-d4cd3bd9c018@quicinc.com>
References: <20250313-qcs8300-cpufreq-scaling-v1-0-d4cd3bd9c018@quicinc.com>
In-Reply-To: <20250313-qcs8300-cpufreq-scaling-v1-0-d4cd3bd9c018@quicinc.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
CC: Ajit Pandey <quic_ajipan@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Imran Shaik <quic_imrashai@quicinc.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=PtWTbxM3 c=1 sm=1 tr=0 ts=67d27551 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=-kjJAZhfdypRAnGlKBgA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: l8GukOOoWU1Dfs00tphHw_8e2Q370Wn6
X-Proofpoint-ORIG-GUID: l8GukOOoWU1Dfs00tphHw_8e2Q370Wn6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 mlxlogscore=828 impostorscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 clxscore=1011 malwarescore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130045

Add cpufreq-hw node to support cpufreq scaling on QCS8300.

Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs8300.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
index cdd412706b5b..eb6b01683d1d 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
@@ -52,6 +52,7 @@ cpu0: cpu@0 {
 			power-domain-names = "psci";
 			capacity-dmips-mhz = <1946>;
 			dynamic-power-coefficient = <472>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 
 			l2_0: l2-cache {
 				compatible = "cache";
@@ -71,6 +72,7 @@ cpu1: cpu@100 {
 			power-domain-names = "psci";
 			capacity-dmips-mhz = <1946>;
 			dynamic-power-coefficient = <472>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
 
 			l2_1: l2-cache {
 				compatible = "cache";
@@ -90,6 +92,7 @@ cpu2: cpu@200 {
 			power-domain-names = "psci";
 			capacity-dmips-mhz = <1946>;
 			dynamic-power-coefficient = <507>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
 
 			l2_2: l2-cache {
 				compatible = "cache";
@@ -109,6 +112,7 @@ cpu3: cpu@300 {
 			power-domain-names = "psci";
 			capacity-dmips-mhz = <1946>;
 			dynamic-power-coefficient = <507>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
 
 			l2_3: l2-cache {
 				compatible = "cache";
@@ -128,6 +132,7 @@ cpu4: cpu@10000 {
 			power-domain-names = "psci";
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
+			qcom,freq-domain = <&cpufreq_hw 2>;
 
 			l2_4: l2-cache {
 				compatible = "cache";
@@ -147,6 +152,7 @@ cpu5: cpu@10100 {
 			power-domain-names = "psci";
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
+			qcom,freq-domain = <&cpufreq_hw 2>;
 
 			l2_5: l2-cache {
 				compatible = "cache";
@@ -166,6 +172,7 @@ cpu6: cpu@10200 {
 			power-domain-names = "psci";
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
+			qcom,freq-domain = <&cpufreq_hw 2>;
 
 			l2_6: l2-cache {
 				compatible = "cache";
@@ -185,6 +192,7 @@ cpu7: cpu@10300 {
 			power-domain-names = "psci";
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
+			qcom,freq-domain = <&cpufreq_hw 2>;
 
 			l2_7: l2-cache {
 				compatible = "cache";
@@ -5235,6 +5243,24 @@ rpmhpd_opp_turbo_l1: opp-9 {
 			};
 		};
 
+		cpufreq_hw: cpufreq@18591000 {
+			compatible = "qcom,qcs8300-cpufreq-epss", "qcom,cpufreq-epss";
+			reg = <0x0 0x18591000 0x0 0x1000>,
+			      <0x0 0x18594000 0x0 0x1000>,
+			      <0x0 0x18593000 0x0 0x1000>;
+			reg-names = "freq-domain0", "freq-domain1", "freq-domain2";
+
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dcvsh-irq-0", "dcvsh-irq-1", "dcvsh-irq-2";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
+
+			#freq-domain-cells = <1>;
+		};
+
 		remoteproc_gpdsp: remoteproc@20c00000 {
 			compatible = "qcom,qcs8300-gpdsp-pas", "qcom,sa8775p-gpdsp0-pas";
 			reg = <0x0 0x20c00000 0x0 0x10000>;

-- 
2.25.1


