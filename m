Return-Path: <linux-pm+bounces-31582-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E6BB15A54
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 10:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB133BE647
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 08:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602C429293D;
	Wed, 30 Jul 2025 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eVpyTDE+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90014291C3C;
	Wed, 30 Jul 2025 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753863261; cv=none; b=KEVpZ8wMlUV71qIGMTT6fvoynpdm4d7Kdov9XsMhIxL4GdeLy4WqJpjM0Vbk2XoaTsUvcaUnVbutiY0vd3fUjcpwT2OH4z/X2580k7RSi0ZgEZr/kN9dkso+DLsIZV/siPzRDE90HeCHoFxAp61CtL/Px8z9jeRFuMU36MGvEUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753863261; c=relaxed/simple;
	bh=ldV3xbecXT9l2HqR1YiPNwooh8FgplqVnvwQ5Z1mDvM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqBiucxSbD70xugF/ynJiaQGB6Wp+xjlYZ0uIldFMm1Dqvzdf2+yWYS998MraCoEj8Y68SS7HnQ+0vhJlEyq3ehxcaypPTmVcOU4B23yYZwxkKafEQST6CcVWZ5hqK8Zw/6svZCVg+JRwjSUZ9CYxzu3LN2Uo+/tx89/wAWKK/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eVpyTDE+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TN8lIV027399;
	Wed, 30 Jul 2025 08:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z/sPT8Voz/UUZfI7dD4uQ8p02i7d6my0snTULEv/WwQ=; b=eVpyTDE+NFNEk9AS
	hBy11v24V/KUhPnc/Sr0sIHIM5U3gnvUKy6omYzUtOlW72z7awYFCA5POme8cbHU
	LizHky0HI6xwlQ8dTDzyelSZ29A9TEW3+lxdVotD7E9C59U1wpcgQqu4YvtHVM0K
	WyMOVTgCUR1qfsqF8uP8ZOC9DhoACfIjLQg28Up5KAw1vsFKtD964eTALODjYl/t
	MGMQK/RiqexZsLu8SkIr0Jdz+/MrCkFZCBLOqX2uW+Jt5/d9kWCXUWQfCxbou1tr
	dyDk6EA3wBpDoQoap0tBhAikDloar/gCsp/q8GD0AB+g8AC62A2OU0rYeRxckElD
	Zxasnw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pbm2tvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 08:14:14 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56U8EDlP018050
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 08:14:13 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 30 Jul 2025 01:14:08 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>, <djakov@kernel.org>,
        <quic_srichara@quicinc.com>, <quic_mdalam@quicinc.com>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v4 4/4] arm64: dts: qcom: ipq5424: Enable cpufreq
Date: Wed, 30 Jul 2025 13:43:16 +0530
Message-ID: <20250730081316.547796-5-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730081316.547796-1-quic_varada@quicinc.com>
References: <20250730081316.547796-1-quic_varada@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=LsaSymdc c=1 sm=1 tr=0 ts=6889d456 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=by-IlacU-rHpHfCKWKcA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA1NSBTYWx0ZWRfX5p2Xwmfg6SjJ
 BfaOyTuLY+y6V+n8oEZUSoUuuZUoCJAxtw3L8WG5vqt3SrUsmxV5f7GLogyNKF2rxTDy9W/2bJ9
 Q0gIlBQtGx8TzP+9WrrEae65ewDVQKj2q0msjwezndlpZWXFdjgleCzDrrbOmWXKv6Ba8Z1wvk6
 eUp4pbt3aA6Gqwtpi1PFmUzRCSotDAqcyMcbc2oyfaccxSiH93Q1j8ANw1AzRWUdGxFZj4d8uzM
 AB3T6RdJUukaDwVY0khyPF6SPFcSDih43MWFV//mB2qnIO3aAKwh8gvL/1xzzJEBcwx+6kekDwf
 4zJpadclY1pJsV3bsfaum8hyV6mV0FXHchysENxbEwHspyfMpURRm/FSg6WNkVLuG1UK5lVZo/D
 x/GgUjsqgL6wbDnnXywTLgKc1X9n3xEuUc/L+AD0iPz2Nd+Wuh4wAxudDtu5cNovV+uzwHFh
X-Proofpoint-ORIG-GUID: q3qfl7XemSTJQXrxh-YHrOjBVE7xHlkA
X-Proofpoint-GUID: q3qfl7XemSTJQXrxh-YHrOjBVE7xHlkA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_03,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=918 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300055

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Add the qfprom, cpu clocks, A53 PLL and cpu-opp-table required for
CPU clock scaling.

Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
[ Added interconnect related entries, fix dt-bindings errors ]
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v4: s/gpll0/clk_ref/ in clock-names
    s/apss-clock/clock/ in node name

v3: Remove L3_CORE_CLK from cpu node as it comes through icc-clk

v2: Add 'interconnects' to cpu nodes
    Add 'opp-peak-kBps' to opp table
    Add '#interconnect-cells' to apss_clk
    Remove unnecessary comment
    Fix dt-binding-errors in qfprom node
---
 arch/arm64/boot/dts/qcom/ipq5424.dtsi | 61 +++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
index 2eea8a078595..b4efffc6a375 100644
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
@@ -119,6 +137,28 @@ scm {
 		};
 	};
 
+	cpu_opp_table: opp-table-cpu {
+		compatible = "operating-points-v2-kryo-cpu";
+		opp-shared;
+		nvmem-cells = <&cpu_speed_bin>;
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
@@ -388,6 +428,18 @@ system-cache-controller@800000 {
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
@@ -730,6 +782,15 @@ frame@f42d000 {
 			};
 		};
 
+		apss_clk: clock@fa80000 {
+			compatible = "qcom,ipq5424-apss-clk";
+			reg = <0x0 0x0fa80000 0x0 0x20000>;
+			clocks = <&xo_board>, <&gcc GPLL0>;
+			clock-names = "xo", "clk_ref";
+			#clock-cells = <1>;
+			#interconnect-cells = <1>;
+		};
+
 		pcie3: pcie@40000000 {
 			compatible = "qcom,pcie-ipq5424", "qcom,pcie-ipq9574";
 			reg = <0x0 0x40000000 0x0 0xf1c>,
-- 
2.34.1


