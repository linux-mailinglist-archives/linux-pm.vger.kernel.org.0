Return-Path: <linux-pm+bounces-20967-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B201A1D378
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 10:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED1B1885C50
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 09:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B45A1FE46A;
	Mon, 27 Jan 2025 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UqhyNiAV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD111FDA9C;
	Mon, 27 Jan 2025 09:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737970332; cv=none; b=r/7oAe0BcoHkIndQ1KMkC753eJ2L9MUGpEXIQVraLnvg52b74EKVw5bwfMTRa2+TufoN/it8xVauAvnP3Uh1xxN8GLPy9Sego8WIjBc2IVKvGdDvMwh1YSmfH8ThGZbThaXMHrI0bXQYF2ultR75uV8Cf6aSIihFQPrnJT3seHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737970332; c=relaxed/simple;
	bh=CDckDTWRVbLLHVsSqCmObMMPBHpC3XZ8+xevYDfnDTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PTo9ny3E8jKqwhxZSwF7Luc32fjD3Xb2INjO1kTTOFWy/jvDvmGjaEaoMa+ir348sVPm80kFPgmQSsoGxPEdyUe3Nbe8jKRUVs9bNMXIS+I4hcT6wejissh+hK7pOFK7uzQ5YqUTEw1rHpegwiaTU6xj/SbCUmuOTtH74d9aAQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UqhyNiAV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50R1hUrc008471;
	Mon, 27 Jan 2025 09:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xrwZitG5Pruqvw3YvFX++HaCjin3bRg7HvX3tHo6OZc=; b=UqhyNiAVzSsoKGl+
	0LFaJXEzGfK5xZ+cVCOn0Qe85Orvu2h4LEqubCzPPI18EdmRFU85PE4W3+XgvK6m
	YSAV0gxT+wUYrvaiqWZjDduPq8O9nQVHX4X2YYwLhpW0b4JBY1wW5GDIpI/DhhJN
	rzPwibwzAi3eB7Y57FGbLCmyWusfWmcc0SjbqxY/h3poJVFZyhLCtjgiIdaOz8lc
	g9f7Jd4ouC/je745wZ/5B93z73h5qcO3jmu6sviivvJNu3102vpcY+0lhLfRFwIH
	gu2Ng4WCHA8WFsYNjVvTeRVoTc1cmzmDbKhWwESk38Ceokb8TJcaWzxBEEJ0eSvR
	2Po4Pg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44dhu9hq4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 09:32:06 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50R9W5S9030866
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 09:32:05 GMT
Received: from hu-srichara-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 27 Jan 2025 01:32:01 -0800
From: Sricharan R <quic_srichara@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>
Subject: [PATCH 4/4] arm64: dts: qcom: ipq5424: Enable cpufreq support
Date: Mon, 27 Jan 2025 15:01:28 +0530
Message-ID: <20250127093128.2611247-5-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127093128.2611247-1-quic_srichara@quicinc.com>
References: <20250127093128.2611247-1-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4r0cpW53rfduI2Ln8-Nftt1L49yWmm0X
X-Proofpoint-ORIG-GUID: 4r0cpW53rfduI2Ln8-Nftt1L49yWmm0X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501270076

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Add the qfprom, cpu clocks, A53 PLL and cpu-opp-table required for
CPU clock scaling.

Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5424.dtsi | 71 +++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
index 577b88cd5172..3c07f7c28c4a 100644
--- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
@@ -7,6 +7,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/qcom,apss-ipq.h>
 #include <dt-bindings/clock/qcom,ipq5424-gcc.h>
 #include <dt-bindings/reset/qcom,ipq5424-gcc.h>
 #include <dt-bindings/gpio/gpio.h>
@@ -38,6 +39,11 @@ cpu0: cpu@0 {
 			reg = <0x0>;
 			enable-method = "psci";
 			next-level-cache = <&l2_0>;
+			clocks = <&apss_clk APSS_SILVER_CORE_CLK>,
+				 <&apss_clk L3_CORE_CLK>;
+			clock-names = "cpu", "l3_core";
+			operating-points-v2 = <&cpu_opp_table>;
+
 			l2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
@@ -58,6 +64,10 @@ cpu1: cpu@100 {
 			enable-method = "psci";
 			reg = <0x100>;
 			next-level-cache = <&l2_100>;
+			clocks = <&apss_clk APSS_SILVER_CORE_CLK>,
+				 <&apss_clk L3_CORE_CLK>;
+			clock-names = "cpu", "l3_core";
+			operating-points-v2 = <&cpu_opp_table>;
 
 			l2_100: l2-cache {
 				compatible = "cache";
@@ -73,6 +83,10 @@ cpu2: cpu@200 {
 			enable-method = "psci";
 			reg = <0x200>;
 			next-level-cache = <&l2_200>;
+			clocks = <&apss_clk APSS_SILVER_CORE_CLK>,
+				 <&apss_clk L3_CORE_CLK>;
+			clock-names = "cpu", "l3_core";
+			operating-points-v2 = <&cpu_opp_table>;
 
 			l2_200: l2-cache {
 				compatible = "cache";
@@ -88,6 +102,10 @@ cpu3: cpu@300 {
 			enable-method = "psci";
 			reg = <0x300>;
 			next-level-cache = <&l2_300>;
+			clocks = <&apss_clk APSS_SILVER_CORE_CLK>,
+				 <&apss_clk L3_CORE_CLK>;
+			clock-names = "cpu", "l3_core";
+			operating-points-v2 = <&cpu_opp_table>;
 
 			l2_300: l2-cache {
 				compatible = "cache";
@@ -98,6 +116,39 @@ l2_300: l2-cache {
 		};
 	};
 
+	cpu_opp_table: opp-table-cpu {
+		compatible = "operating-points-v2-kryo-cpu";
+		opp-shared;
+		nvmem-cells = <&cpu_speed_bin>;
+
+		/*
+		 * CPU supports two frequencies and the fuse has LValue instead
+		 * of limits. As only two frequencies are supported, considering
+		 * zero Lvalue as no limit and Lvalue as 1.4GHz limit.
+		 * ------------------------------------------------------------
+		 * Frequency     BIT1    BIT0    opp-supported-hw
+		 *	      1.4GHz  No Limit
+		 * ------------------------------------------------------------
+		 * 1416000000      1       1	    0x3
+		 * 1800000000      0       1	    0x1
+		 * ------------------------------------------------------------
+		 */
+
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <1>;
+			opp-supported-hw = <0x3>;
+			clock-latency-ns = <200000>;
+		};
+
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <2>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <200000>;
+		};
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		/* We expect the bootloader to fill in the size */
@@ -151,6 +202,18 @@ soc@0 {
 		#size-cells = <2>;
 		ranges = <0 0 0 0 0x10 0>;
 
+		qfprom@a6000 {
+			compatible = "qcom,qfprom";
+			reg = <0x0 0xa6000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			cpu_speed_bin: cpu-speed-bin@234 {
+				reg = <0x234 0x1>;
+				bits = <0 8>;
+			};
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,ipq5424-tlmm";
 			reg = <0 0x01000000 0 0x300000>;
@@ -363,6 +426,14 @@ frame@f42d000 {
 			};
 		};
 
+		apss_clk: apss-clock@fa80000 {
+			compatible = "qcom,ipq5424-apss-clk";
+			reg = <0x0 0x0fa80000 0x0 0x20000>;
+			clocks = <&xo_board>, <&gcc GPLL0>;
+			clock-names = "xo", "gpll0";
+			#clock-cells = <1>;
+		};
+
 		tmel_qmp: qmp@32090000 {
 			compatible = "qcom,ipq5424-tmel-qmp", "qcom,tmel-qmp";
 			reg = <0 0x32090000 0 0x2000>;
-- 
2.34.1


