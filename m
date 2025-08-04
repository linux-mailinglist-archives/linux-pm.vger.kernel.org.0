Return-Path: <linux-pm+bounces-31874-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8ECB1A083
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 13:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37A63B4074
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 11:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391E0258CEF;
	Mon,  4 Aug 2025 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b+v+An14"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAA02580DE;
	Mon,  4 Aug 2025 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754306490; cv=none; b=t/LvC7ibsvf3ZsrYjuqnNM3w9/xlPRFLXifBSdtK6PRhWaiZ+pQuykvTb9bEH68ZBD4c6KJaQMuxwgL8mmg65l1aQ5Sk3FGUlEt6EzW4m2Ces/xyE3v7T722n3wUwKZMLJTcEgczbJkm6/0lU512kDSWMlIp5wYr9w82O85g8DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754306490; c=relaxed/simple;
	bh=IKord6IpeelNj3FMj8DXS7/8f4TyAh9KedRoZ2xAkxw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNrtamCVhSJtQ2J+WS46F4B1NKyDFWMuAjzE/K/cxkrzKvzlhorxj+JJFy2Gup+1NnYF1xGynYB24apJ7exqiMyJqydhGwcHa/clkDXYRXApRXgcq6DOOOk+0UU2805euNL/BhWbR5OS1DsXW9FjC+n+B0WPFr0hrtf3r0hIFfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b+v+An14; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5749A5WJ006884;
	Mon, 4 Aug 2025 11:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UBusSIZyL1MGE0G7O8TZwJtOI8uDQaVIaHZo5OFq7gA=; b=b+v+An14d7M03e1n
	/x1DYvDoEtZ4uxsNL46RLWvpRPa6L4IEAA7zRroivWWihHn2i7A32PGePs4GoYwo
	H+BMV8namp3U2AnPqi0h81r5kPe0vbB1dIni6KFfsngw+TirAyZXjET2gj3dUWgB
	1v+nyEz8l/IRLAOPHFIzLqneNkZ8PtOKX3LjXtaXVAZsPBVFP2YCq3j2A+IqfO7f
	MM5GcD4lpFMpvRX77uSvIMu0+UmsGMAQGjR6+ZmDsl3juysfVf8+m8LoAjfz2WPj
	CodHwo/J6Dr+YHRLb1IMRVWnRFtTJ+MwhUFJ17/nTfdh/3OWoYqGJvL9aAxWBw9u
	sDAAww==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489bek4pd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 11:21:24 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 574BLOOu030818
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Aug 2025 11:21:24 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 4 Aug 2025 04:21:18 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>, <djakov@kernel.org>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Subject: [PATCH v5 4/4] arm64: dts: qcom: ipq5424: Enable cpufreq
Date: Mon, 4 Aug 2025 16:50:41 +0530
Message-ID: <20250804112041.845135-5-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804112041.845135-1-quic_varada@quicinc.com>
References: <20250804112041.845135-1-quic_varada@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=M7tNKzws c=1 sm=1 tr=0 ts=689097b4 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=8iwBCvIuHXaDhwMfttAA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA2MiBTYWx0ZWRfXx4HGvtUPn79Y
 rxcC1izFqmkz8Vp/Y9rb7IjFaG7m2NfWD/C7Q6/wrsuxhoKChmWh4pIN/hBfBQLsSUv4JQYehIg
 FvpV3kKwJc//qurKUBw43ie+AuORBXk5Bohnwk4Beh6Q0YR0cOCASE9y1rjmvCkSfddrXUeThIb
 B5CC19Bxmd1s3RQfRWM2z3XLUx7PU6V+d+2AHLe9D3jEnnWbQwmyN2fZamOFJy6Te22xqGDsPAv
 ikm8DRIV4ldB/xmPsHcELfkdWvUaMpWasACkYRijinZsa07DoSs7jyymMpJM/14jFFkS9O1zkTB
 XDPawgtvd3b0QR6JIH1WllDxEKoNr5Cb7G9lFwSrvDsSrB7AEE8IrjVIWv8jyNefnGeWC8FWJ1R
 1RrlGjn9inmuQusc91oingIB7LUtsJQfje9eR16tQnlB/aPL6KECpNuRTUf/B1ME9fQQx6we
X-Proofpoint-ORIG-GUID: dmA7pSpLV4iwL_9O2yn-Bv4yyTbtiMtJ
X-Proofpoint-GUID: dmA7pSpLV4iwL_9O2yn-Bv4yyTbtiMtJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 mlxlogscore=941 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040062

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Add the qfprom, cpu clocks, A53 PLL and cpu-opp-table required for
CPU clock scaling.

Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
[ Added interconnect related entries, fix dt-bindings errors ]
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v5: Add opp-816000000
    Have one item per line for clocks and clock-names

v4: s/gpll0/clk_ref/ in clock-names
    s/apss-clock/clock/ in node name

v3: Remove L3_CORE_CLK from cpu node as it comes through icc-clk

v2: Add 'interconnects' to cpu nodes
    Add 'opp-peak-kBps' to opp table
    Add '#interconnect-cells' to apss_clk
    Remove unnecessary comment
    Fix dt-binding-errors in qfprom node
---
 arch/arm64/boot/dts/qcom/ipq5424.dtsi | 71 +++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
index 2eea8a078595..0bc46734e8b4 100644
--- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
@@ -7,6 +7,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/qcom,apss-ipq.h>
 #include <dt-bindings/clock/qcom,ipq5424-cmn-pll.h>
 #include <dt-bindings/clock/qcom,ipq5424-gcc.h>
 #include <dt-bindings/reset/qcom,ipq5424-gcc.h>
@@ -52,6 +53,11 @@ cpu0: cpu@0 {
 			reg = <0x0>;
 			enable-method = "psci";
 			next-level-cache = <&l2_0>;
+			clocks = <&apss_clk APSS_SILVER_CORE_CLK>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu_opp_table>;
+			interconnects = <&apss_clk MASTER_CPU &apss_clk SLAVE_L3>;
+
 			l2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
@@ -72,6 +78,10 @@ cpu1: cpu@100 {
 			enable-method = "psci";
 			reg = <0x100>;
 			next-level-cache = <&l2_100>;
+			clocks = <&apss_clk APSS_SILVER_CORE_CLK>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu_opp_table>;
+			interconnects = <&apss_clk MASTER_CPU &apss_clk SLAVE_L3>;
 
 			l2_100: l2-cache {
 				compatible = "cache";
@@ -87,6 +97,10 @@ cpu2: cpu@200 {
 			enable-method = "psci";
 			reg = <0x200>;
 			next-level-cache = <&l2_200>;
+			clocks = <&apss_clk APSS_SILVER_CORE_CLK>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu_opp_table>;
+			interconnects = <&apss_clk MASTER_CPU &apss_clk SLAVE_L3>;
 
 			l2_200: l2-cache {
 				compatible = "cache";
@@ -102,6 +116,10 @@ cpu3: cpu@300 {
 			enable-method = "psci";
 			reg = <0x300>;
 			next-level-cache = <&l2_300>;
+			clocks = <&apss_clk APSS_SILVER_CORE_CLK>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu_opp_table>;
+			interconnects = <&apss_clk MASTER_CPU &apss_clk SLAVE_L3>;
 
 			l2_300: l2-cache {
 				compatible = "cache";
@@ -119,6 +137,36 @@ scm {
 		};
 	};
 
+	cpu_opp_table: opp-table-cpu {
+		compatible = "operating-points-v2-kryo-cpu";
+		opp-shared;
+		nvmem-cells = <&cpu_speed_bin>;
+
+		opp-816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <1>;
+			opp-supported-hw = <0x3>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <1>;
+			opp-supported-hw = <0x3>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <984000>;
+		};
+
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <2>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1272000>;
+		};
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		/* We expect the bootloader to fill in the size */
@@ -388,6 +436,18 @@ system-cache-controller@800000 {
 			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		qfprom@a6000 {
+			compatible = "qcom,ipq5424-qfprom", "qcom,qfprom";
+			reg = <0x0 0x000a6000 0x0 0x1000>;
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
@@ -730,6 +790,17 @@ frame@f42d000 {
 			};
 		};
 
+		apss_clk: clock-controller@fa80000 {
+			compatible = "qcom,ipq5424-apss-clk";
+			reg = <0x0 0x0fa80000 0x0 0x20000>;
+			clocks = <&xo_board>,
+				 <&gcc GPLL0>;
+			clock-names = "xo",
+				      "clk_ref";
+			#clock-cells = <1>;
+			#interconnect-cells = <1>;
+		};
+
 		pcie3: pcie@40000000 {
 			compatible = "qcom,pcie-ipq5424", "qcom,pcie-ipq9574";
 			reg = <0x0 0x40000000 0x0 0xf1c>,
-- 
2.34.1


