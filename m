Return-Path: <linux-pm+bounces-31328-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1BBB0F0DF
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 13:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6582517875E
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 11:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C79E2E49A8;
	Wed, 23 Jul 2025 11:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="psZ5r3Hh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3502E49A7;
	Wed, 23 Jul 2025 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268942; cv=none; b=fLJ1aIQlIO1QmhtYi6Wc27fdSW6zd+UQPcTiXLPqhGoZryVLDOwv7zmx4oHqGYQ5JhRN6WzYHncvOm9Atz7P2yMxu8TDEzOTTpOEEGEJsledPxUWxqTZuJLtH8S7sd21oVrJermAfRMB+05X38O3Wv4drai5B32z0tZFb3rf2x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268942; c=relaxed/simple;
	bh=QAF/CJx4l1OMxiZsPySVBwt4eqsS9ZvfqlfvkWA/Efo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fIzpbQNLQLgcTtkS5zVxzkOyS4VOWxisPHnwxrtn0/RYTD+wNXLGPykJor70gE9OUyzdNez7QltAeLQ1c86Su/j2UoFvpaFM166QaRrOTBz/b9iOFZipeeVHizTNDMeKhAYqtqLksDYOLyV+hIeGP1RllfWcgojquLjYQbA0Bwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=psZ5r3Hh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N8tcfq010356;
	Wed, 23 Jul 2025 11:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CBcD5FkL7MwbIlsoWgdrxc9IH2TcznubU5xhsWpCVGE=; b=psZ5r3Hhgzl/0/Ao
	91An7FQBkkSyTLQ71UwGUK2P3YUZdYDNFY1iLuInV3IuQ7jcjwJ1AP7fslIVe9ZS
	PkkJiysJ1eFNYOjeXZ6crcQxNQsJt255xLWifKsvJYeWmCzVS7vdoAakdlTiawTC
	6jopc9fJDHQzPflKdJINbEFUew3cTux2rarthioR0tR8vZ/5iI9bfxdVxmzLstYE
	Z4PaC9MOx4GNFYF4hP7PDUiuiUM/Zl6JM0gUyAG5NelTuL7H4qxjdx6TszyojXQH
	8P6m4PaSDWNDXwlF2jKEovY1n0xMen8ojL9Hk77OvZ3ghzIsMY5dRUKt2gTFz8bb
	ptjpaQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804na3am1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 11:08:56 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56NB8uXo021961
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 11:08:56 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 23 Jul 2025 04:08:51 -0700
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
Subject: [PATCH v2 4/4] arm64: dts: qcom: ipq5424: Enable cpufreq
Date: Wed, 23 Jul 2025 16:38:15 +0530
Message-ID: <20250723110815.2865403-5-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723110815.2865403-1-quic_varada@quicinc.com>
References: <20250723110815.2865403-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: vsrAuajVI1lLol1T6k2yzRBddViogAGB
X-Proofpoint-ORIG-GUID: vsrAuajVI1lLol1T6k2yzRBddViogAGB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5NCBTYWx0ZWRfX2tMzF1EfVidy
 49cpWWhxpqH+VLZ6Ie+QwgxdqH7Fph/TZ7u6T0iIXPDtrZwOVu7YVq/bbMbGJ2uwvbCWMxwWTeS
 B49uzIYZI5IHzEU5jxcIhVCWupDp6HCN0NJQ8tdHbgYo16To8mn0FccVm70UzarG5IdYRooGsL9
 uDUzWhqcMNMeYEwI1OsQx1oZ7P5EVdkG8FCLmIWdSjucSpslt9xA+Wbj22dPJqolZad/+NswfNk
 ABRCvsHJdnWEyKYix7aTYyjNn1cKHKKi7TVgZ/tMOlOL/DiDAT6UMyJJ9jzWkGUi9lGKEe6uiNl
 pKcTl7EXKKFpaWu59oKNbqToJ5yuEQhKCQH4haeSUnOEWEgLcnygqCffEWIGiDjATJ6+Q2VaVyn
 GG5F0JMoqx1Enlrz43g9EkFHLty++yFd9eNUNfg979xO04eVq6EttFOMV4ziFNjEu6Npzu/j
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=6880c2c8 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=6wL3klP_paFbw1eNuawA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1011 mlxscore=0 mlxlogscore=886
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230094

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Add the qfprom, cpu clocks, A53 PLL and cpu-opp-table required for
CPU clock scaling.

Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
[ Added interconnect related entries, fix dt-bindings errors ]
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v2: Add 'interconnects' to cpu nodes
    Add 'opp-peak-kBps' to opp table
    Add '#interconnect-cells' to apss_clk
    Remove unnecessary comment
    Fix dt-binding-errors in qfprom node
---
 arch/arm64/boot/dts/qcom/ipq5424.dtsi | 65 +++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
index 2eea8a078595..39d394f49789 100644
--- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
@@ -7,6 +7,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/qcom,apss-ipq.h>
 #include <dt-bindings/clock/qcom,ipq5424-cmn-pll.h>
 #include <dt-bindings/clock/qcom,ipq5424-gcc.h>
 #include <dt-bindings/reset/qcom,ipq5424-gcc.h>
@@ -52,6 +53,12 @@ cpu0: cpu@0 {
 			reg = <0x0>;
 			enable-method = "psci";
 			next-level-cache = <&l2_0>;
+			clocks = <&apss_clk APSS_SILVER_CORE_CLK>,
+				 <&apss_clk L3_CORE_CLK>;
+			clock-names = "cpu", "l3_core";
+			operating-points-v2 = <&cpu_opp_table>;
+			interconnects = <&apss_clk MASTER_CPU &apss_clk SLAVE_L3>;
+
 			l2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
@@ -72,6 +79,11 @@ cpu1: cpu@100 {
 			enable-method = "psci";
 			reg = <0x100>;
 			next-level-cache = <&l2_100>;
+			clocks = <&apss_clk APSS_SILVER_CORE_CLK>,
+				 <&apss_clk L3_CORE_CLK>;
+			clock-names = "cpu", "l3_core";
+			operating-points-v2 = <&cpu_opp_table>;
+			interconnects = <&apss_clk MASTER_CPU &apss_clk SLAVE_L3>;
 
 			l2_100: l2-cache {
 				compatible = "cache";
@@ -87,6 +99,11 @@ cpu2: cpu@200 {
 			enable-method = "psci";
 			reg = <0x200>;
 			next-level-cache = <&l2_200>;
+			clocks = <&apss_clk APSS_SILVER_CORE_CLK>,
+				 <&apss_clk L3_CORE_CLK>;
+			clock-names = "cpu", "l3_core";
+			operating-points-v2 = <&cpu_opp_table>;
+			interconnects = <&apss_clk MASTER_CPU &apss_clk SLAVE_L3>;
 
 			l2_200: l2-cache {
 				compatible = "cache";
@@ -102,6 +119,11 @@ cpu3: cpu@300 {
 			enable-method = "psci";
 			reg = <0x300>;
 			next-level-cache = <&l2_300>;
+			clocks = <&apss_clk APSS_SILVER_CORE_CLK>,
+				 <&apss_clk L3_CORE_CLK>;
+			clock-names = "cpu", "l3_core";
+			operating-points-v2 = <&cpu_opp_table>;
+			interconnects = <&apss_clk MASTER_CPU &apss_clk SLAVE_L3>;
 
 			l2_300: l2-cache {
 				compatible = "cache";
@@ -119,6 +141,28 @@ scm {
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
@@ -388,6 +432,18 @@ system-cache-controller@800000 {
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
@@ -730,6 +786,15 @@ frame@f42d000 {
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


