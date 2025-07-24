Return-Path: <linux-pm+bounces-31371-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E925BB107BD
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 12:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B011217BC30
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 10:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2DD26563F;
	Thu, 24 Jul 2025 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jEg7huWh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A03265632;
	Thu, 24 Jul 2025 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753352789; cv=none; b=JMT1VBRkVYvCypXPM2hbzdIexwJEBIhQCua4/MyjoDE2EbgYiye9sI3IB3zhlm4D6ov902oSxaNvYijCSlEPWSz2mb2KOe67gq7JotgBkJUmnL1Qfwqdy976YEN7UGHQHOgq5kHNFBGnNnmujMlZgmRnB6VxjIvD0WewtpVSIj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753352789; c=relaxed/simple;
	bh=o5Q/xNIdCWJaTBt5XR/Swo9FtMUwztvLupNh4mCryU0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S0OaOwkcykPHKC90s2ZaAqoSRp4oUCb3rb5hUSwVyPwDMrDlrHVaaMN2iuhEjlOkzQT8b6of+0alaj2AsZK7WNZbYbGR/ss+/JWZFrdbXTUaoRG/PJ9tok7Wg4dkZ1VVvq3TFoqAAW9jKXvXW4TR2tSfafBE5nfHkx1fLEHOz5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jEg7huWh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O6dFCc026100;
	Thu, 24 Jul 2025 10:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zOnBvv5l/uRDiaONAaqWFHtelJYbjNbD2qzaL011GnY=; b=jEg7huWhkY2MZdUu
	jVITaY2PCyJ9KZnViF4pONhvmG3eVnC59sAvHmO0qTUHjc3VLaXBZUFixRjc29MV
	DtH2vulQN/pnwck400PHy3KBlrynDgFHzfvxIdkeEiOEreJcmsSF6ETd1yFRdZUo
	+h0s4mob3N4UyO+G7ZkoHf69qrf25y09QpeZbWzZgTcVBkhXzr00JLvFSG0dyuAt
	RSMb38WlKZJK8Immt8+ZiEKBjcV3V9jNDvWvLQNwidYp62XL7JWS197Aiwf2oc55
	ITqoK7QwWkdCn903rpO42lS5rEi5po+y3uuO5n+MBjbi7i2C+XIPZVH4HqNNNStz
	oH1cyg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483frk0p3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 10:26:23 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56OAQMDY026611
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 10:26:22 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 24 Jul 2025 03:26:17 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>, <djakov@kernel.org>,
        <quic_srichara@quicinc.com>, <quic_mdalam@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v3 4/4] arm64: dts: qcom: ipq5424: Enable cpufreq
Date: Thu, 24 Jul 2025 15:55:40 +0530
Message-ID: <20250724102540.3762358-5-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250724102540.3762358-1-quic_varada@quicinc.com>
References: <20250724102540.3762358-1-quic_varada@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA3NyBTYWx0ZWRfXxyt8dFZgjdyH
 dhUSzLDxtt7V8ZP9J0Hti8Z+FXJRXvUErP4c3CKr9aUMBsrOhO2iERO/J1wAz3L0A2dHO33ZG7s
 9G9kefSH20PrF4ogQfe/XwSq1yVSmj+r7CdoAobbNQ9vbOwAV3Q9gKsoKmWTNh+j1hvP9uin8B0
 aEYlh9d/MenK2c+ZXPNCRX9bPxBHm55tXDBC4grQOx/TIS/0Wx6ho/h/nCSzGQme0N2Kmc3b0aP
 lpuzlJoIzT/i57v4OV8jvGEkaFdSkpaaw7OfI/eSvZjQNP0B6oJgcK30OLJROxYljdTQtnU6eXE
 mxzH19+u+pffkSz12Jxq8YYzoj//eRVim40AqK26sqJBWoYRdUCMv6tD9oei7AEnUYSETWBF/zD
 pJOARrn7+L9TIbUgx/qABVX8VdFN9vv7jNU1PGhcsZ50waaA/TD8AsDPYKOJcJgdawrkbyFg
X-Proofpoint-GUID: XuQHouQf6igGsO_ylIbM07Br66DVuwZl
X-Authority-Analysis: v=2.4 cv=WbsMa1hX c=1 sm=1 tr=0 ts=68820a4f cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=6wL3klP_paFbw1eNuawA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: XuQHouQf6igGsO_ylIbM07Br66DVuwZl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=917 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240077

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Add the qfprom, cpu clocks, A53 PLL and cpu-opp-table required for
CPU clock scaling.

Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
[ Added interconnect related entries, fix dt-bindings errors ]
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
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
index 2eea8a078595..74ef7d4b8f9a 100644
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
 
+		apss_clk: apss-clock@fa80000 {
+			compatible = "qcom,ipq5424-apss-clk";
+			reg = <0x0 0x0fa80000 0x0 0x20000>;
+			clocks = <&xo_board>, <&gcc GPLL0>;
+			clock-names = "xo", "gpll0";
+			#clock-cells = <1>;
+			#interconnect-cells = <1>;
+		};
+
 		pcie3: pcie@40000000 {
 			compatible = "qcom,pcie-ipq5424", "qcom,pcie-ipq9574";
 			reg = <0x0 0x40000000 0x0 0xf1c>,
-- 
2.34.1


