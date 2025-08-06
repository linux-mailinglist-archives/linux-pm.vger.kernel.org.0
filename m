Return-Path: <linux-pm+bounces-31993-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4CAB1C4E8
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 13:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDDD962464F
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 11:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F6528BAA6;
	Wed,  6 Aug 2025 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BqJ9MY4X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F1028BAA2;
	Wed,  6 Aug 2025 11:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754479732; cv=none; b=lzM+li5KEgS6D3z7cGzLjihyL10BTYZb8H417E7te8BLCn8NGsSLpsxWmj4ARgzID6uy1p2QAYSbvRwHjz2+KSX3Dt8SB39zxwuoIg63U3XFJFyq+cUbhDDCcrwlVI//ZB4MoxUOXFvAoTccseOp0cV6aoMt8dh52ydcb5PtJW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754479732; c=relaxed/simple;
	bh=nHtXy7an95eZ7Pm3n1g7fjzRs3zXypsjI+tihq6uRuA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bOtDP59W7A+zCDMN+JhHRXmlHgGrQ2vhpPehHXqzDECXEop7hqghmJ6kayAQ6N07qBwDp7xY271mepJHBCctYThjJJa86+THjI5b9+mOrtMcQz/0sKSQECopHs/BsVxWbDkZJ4hNoWvt3LFxdveE1M8m4xVyOF+Z9qoy0A0Cwco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BqJ9MY4X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5766LJ3Y010330;
	Wed, 6 Aug 2025 11:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XK+m2b9DGlddBmK3CZiDnUIp1rbuHuIUgQC7eGpQdI4=; b=BqJ9MY4XJTG7TU2w
	FZpEGc4kxacX9SWuqjZCRzLBPiP+pXaPcBxvf1dBhJDQ7tJj9NN8H5mjJDyrmQLt
	A3pobd4Kl9RcdPxf/d0pZ0ZEjfCYyThihV3tEeQGPxGRvffFR4MeODlSTcIMthq3
	AkAa0wGCS4QBp5eg56rM4Ap9i0s9jdhQm06Q/2l7FwsFGGv6eDBoCszHdoKjK1I7
	crizHEu9HlttLkGxVwvuP4HroV3LTZj38ZAyEr0yxGcJB2lDqjn0Ll7SnW0/x3K/
	eM+Tq/TAqUxEDQPZsyvniS/sNf+2PZdGKK6nfHXnKZvCEO8HmUCqh1w543yJNd5T
	nN5E5A==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy7thd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 11:28:46 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 576BSkki005761
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Aug 2025 11:28:46 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 6 Aug 2025 04:28:40 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>, <djakov@kernel.org>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Subject: [PATCH v6 4/4] arm64: dts: qcom: ipq5424: Enable cpufreq
Date: Wed, 6 Aug 2025 16:58:07 +0530
Message-ID: <20250806112807.2726890-5-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250806112807.2726890-1-quic_varada@quicinc.com>
References: <20250806112807.2726890-1-quic_varada@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=Mftsu4/f c=1 sm=1 tr=0 ts=68933c6e cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=8iwBCvIuHXaDhwMfttAA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: xSJLi4yWkxGbqElgEiOl9Iw0blj_b565
X-Proofpoint-GUID: xSJLi4yWkxGbqElgEiOl9Iw0blj_b565
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX0i9WIbRJ2PBc
 A1JXeu6OzxP6mLMNsIGV+iZh0iWY2IMiPDHIm4hGtVGAUJ/grgUzF3gdKAZNqfPbNpmuUhQMYv6
 YzY60do5aifb0ihXlsOHJdTuLKXUpbslz1TnAs5uzfX+OAmJQqjqAjQgUpFZGrhnrsM46vS/Nao
 hb1TA0/G7rs42nZeVg2cUGAciLGfPftnjQT7XFwEhq6EaOA4NBsIdfyvXeZNhZovlWNGEtvZFf9
 Mn34BZLnYs+rKw75I9eT1Giz8cQ2ywQebEonJ2qTxoxoNa+OPnYQGEtAjufZhHeGpxXGEJcoxTm
 Rog3o3RXhYnGv+Pk4Lk2ODAoPYgNN/0LxoQg5mBer2JWwfkO8FV3dqDHpn9JJ9DcTAMJnhzRKT7
 kViI1inP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Add the qfprom, cpu clocks, A53 PLL and cpu-opp-table required for
CPU clock scaling.

Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
[ Added interconnect related entries, fix dt-bindings errors ]
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v6: Drop clock-names
    Fix opp-microvolt

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
 arch/arm64/boot/dts/qcom/ipq5424.dtsi | 69 +++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
index 2eea8a078595..f12aaaeb4cab 100644
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
+			opp-microvolt = <850000>;
+			opp-supported-hw = <0x3>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <850000>;
+			opp-supported-hw = <0x3>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <984000>;
+		};
+
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1000000>;
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
@@ -730,6 +790,15 @@ frame@f42d000 {
 			};
 		};
 
+		apss_clk: clock-controller@fa80000 {
+			compatible = "qcom,ipq5424-apss-clk";
+			reg = <0x0 0x0fa80000 0x0 0x20000>;
+			clocks = <&xo_board>,
+				 <&gcc GPLL0>;
+			#clock-cells = <1>;
+			#interconnect-cells = <1>;
+		};
+
 		pcie3: pcie@40000000 {
 			compatible = "qcom,pcie-ipq5424", "qcom,pcie-ipq9574";
 			reg = <0x0 0x40000000 0x0 0xf1c>,
-- 
2.34.1


