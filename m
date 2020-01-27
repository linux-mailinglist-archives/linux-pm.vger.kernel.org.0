Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEBB014AAF0
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2020 21:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgA0UFR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jan 2020 15:05:17 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:51737 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728266AbgA0UFR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2020 15:05:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580155516; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=IKb86hhTj8xFaDWDtytaFBLL9ega5hDWwTrYWcWCmJk=; b=QJLvibbjUmQ5Ccq8aHOvyftMphlPNrLMUYLqQtgfY6KO8hCsntAMRNIsn/RP0Y0a3Cc5sQ3l
 n9lYEo9+pp8QmtxKeAg/yEYlkdgihDGggZmEMThw9FPlkZU2BGXmomDx6hdN+t7TTNaZmKSy
 jrRrmrzCpOmS8lfOgL7uQ9Sts4M=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2f4276.7f0d77b20998-smtp-out-n02;
 Mon, 27 Jan 2020 20:05:10 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 80460C447A9; Mon, 27 Jan 2020 20:05:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BAAB2C433A2;
        Mon, 27 Jan 2020 20:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BAAB2C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com
Cc:     nm@ti.com, bjorn.andersson@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org, mka@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        ulf.hansson@linaro.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [RFC v3 09/10] arm64: dts: qcom: sdm845: Add cpu OPP tables
Date:   Tue, 28 Jan 2020 01:33:49 +0530
Message-Id: <20200127200350.24465-10-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200127200350.24465-1-sibis@codeaurora.org>
References: <20200127200350.24465-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add OPP tables required to scale DDR/L3 per freq-domain on SDM845 SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 453 +++++++++++++++++++++++++++
 1 file changed, 453 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index c036bab49fc03..8cb976118407b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -199,6 +199,12 @@
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&cpu0_opp_table>,
+					      <&cpu0_ddr_bw_opp_table>,
+					      <&cpu0_l3_bw_opp_table>;
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc SLAVE_EBI1>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnect-names = "cpu-ddr", "cpu-l3";
 			L2_0: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -221,6 +227,12 @@
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_100>;
+			operating-points-v2 = <&cpu0_opp_table>,
+					      <&cpu0_ddr_bw_opp_table>,
+					      <&cpu0_l3_bw_opp_table>;
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc SLAVE_EBI1>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnect-names = "cpu-ddr", "cpu-l3";
 			L2_100: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -240,6 +252,12 @@
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_200>;
+			operating-points-v2 = <&cpu0_opp_table>,
+					      <&cpu0_ddr_bw_opp_table>,
+					      <&cpu0_l3_bw_opp_table>;
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc SLAVE_EBI1>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnect-names = "cpu-ddr", "cpu-l3";
 			L2_200: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -259,6 +277,12 @@
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_300>;
+			operating-points-v2 = <&cpu0_opp_table>,
+					      <&cpu0_ddr_bw_opp_table>,
+					      <&cpu0_l3_bw_opp_table>;
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc SLAVE_EBI1>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnect-names = "cpu-ddr", "cpu-l3";
 			L2_300: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -278,6 +302,12 @@
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_400>;
+			operating-points-v2 = <&cpu4_opp_table>,
+					      <&cpu4_ddr_bw_opp_table>,
+					      <&cpu4_l3_bw_opp_table>;
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc SLAVE_EBI1>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnect-names = "cpu-ddr", "cpu-l3";
 			L2_400: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -297,6 +327,12 @@
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_500>;
+			operating-points-v2 = <&cpu4_opp_table>,
+					      <&cpu4_ddr_bw_opp_table>,
+					      <&cpu4_l3_bw_opp_table>;
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc SLAVE_EBI1>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnect-names = "cpu-ddr", "cpu-l3";
 			L2_500: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -316,6 +352,12 @@
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_600>;
+			operating-points-v2 = <&cpu4_opp_table>,
+					      <&cpu4_ddr_bw_opp_table>,
+					      <&cpu4_l3_bw_opp_table>;
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc SLAVE_EBI1>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnect-names = "cpu-ddr", "cpu-l3";
 			L2_600: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -335,6 +377,12 @@
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_700>;
+			operating-points-v2 = <&cpu4_opp_table>,
+					      <&cpu4_ddr_bw_opp_table>,
+					      <&cpu4_l3_bw_opp_table>;
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc SLAVE_EBI1>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnect-names = "cpu-ddr", "cpu-l3";
 			L2_700: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -432,6 +480,231 @@
 		};
 	};
 
+	cpu0_opp_table: cpu0_opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cpu0_opp1: opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			required-opps = <&cpu0_ddr_bw_opp1>, <&cpu0_l3_bw_opp1>;
+		};
+
+		cpu0_opp2: opp-403200000 {
+			opp-hz = /bits/ 64 <403200000>;
+			required-opps = <&cpu0_ddr_bw_opp1>, <&cpu0_l3_bw_opp1>;
+		};
+
+		cpu0_opp3: opp-480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			required-opps = <&cpu0_ddr_bw_opp1>, <&cpu0_l3_bw_opp2>;
+		};
+
+		cpu0_opp4: opp-576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+			required-opps = <&cpu0_ddr_bw_opp1>, <&cpu0_l3_bw_opp2>;
+		};
+
+		cpu0_opp5: opp-652800000 {
+			opp-hz = /bits/ 64 <652800000>;
+			required-opps = <&cpu0_ddr_bw_opp1>, <&cpu0_l3_bw_opp3>;
+		};
+
+		cpu0_opp6: opp-748800000 {
+			opp-hz = /bits/ 64 <748800000>;
+			required-opps = <&cpu0_ddr_bw_opp3>, <&cpu0_l3_bw_opp4>;
+		};
+
+		cpu0_opp7: opp-825600000 {
+			opp-hz = /bits/ 64 <825600000>;
+			required-opps = <&cpu0_ddr_bw_opp3>, <&cpu0_l3_bw_opp4>;
+		};
+
+		cpu0_opp8: opp-902400000 {
+			opp-hz = /bits/ 64 <902400000>;
+			required-opps = <&cpu0_ddr_bw_opp3>, <&cpu0_l3_bw_opp5>;
+		};
+
+		cpu0_opp9: opp-979200000 {
+			opp-hz = /bits/ 64 <979200000>;
+			required-opps = <&cpu0_ddr_bw_opp3>, <&cpu0_l3_bw_opp6>;
+		};
+
+		cpu0_opp10: opp-1056000000 {
+			opp-hz = /bits/ 64 <1056000000>;
+			required-opps = <&cpu0_ddr_bw_opp3>, <&cpu0_l3_bw_opp6>;
+		};
+
+		cpu0_opp11: opp-1132800000 {
+			opp-hz = /bits/ 64 <1132800000>;
+			required-opps = <&cpu0_ddr_bw_opp4>, <&cpu0_l3_bw_opp7>;
+		};
+
+		cpu0_opp12: opp-1228800000 {
+			opp-hz = /bits/ 64 <1228800000>;
+			required-opps = <&cpu0_ddr_bw_opp4>, <&cpu0_l3_bw_opp8>;
+		};
+
+		cpu0_opp13: opp-1324800000 {
+			opp-hz = /bits/ 64 <1324800000>;
+			required-opps = <&cpu0_ddr_bw_opp4>, <&cpu0_l3_bw_opp9>;
+		};
+
+		cpu0_opp14: opp-1420800000 {
+			opp-hz = /bits/ 64 <1420800000>;
+			required-opps = <&cpu0_ddr_bw_opp4>, <&cpu0_l3_bw_opp10>;
+		};
+
+		cpu0_opp15: opp-1516800000 {
+			opp-hz = /bits/ 64 <1516800000>;
+			required-opps = <&cpu0_ddr_bw_opp5>, <&cpu0_l3_bw_opp11>;
+		};
+
+		cpu0_opp16: opp-1612800000 {
+			opp-hz = /bits/ 64 <1612800000>;
+			required-opps = <&cpu0_ddr_bw_opp7>, <&cpu0_l3_bw_opp11>;
+		};
+
+		cpu0_opp17: opp-1689600000 {
+			opp-hz = /bits/ 64 <1689600000>;
+			required-opps = <&cpu0_ddr_bw_opp7>, <&cpu0_l3_bw_opp12>;
+		};
+
+		cpu0_opp18: opp-1766400000 {
+			opp-hz = /bits/ 64 <1766400000>;
+			required-opps = <&cpu0_ddr_bw_opp7>, <&cpu0_l3_bw_opp13>;
+		};
+	};
+
+	cpu4_opp_table: cpu4_opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cpu4_opp1: opp-825600000 {
+			opp-hz = /bits/ 64 <825600000>;
+			required-opps = <&cpu4_ddr_bw_opp1>, <&cpu4_l3_bw_opp1>;
+		};
+
+		cpu4_opp2: opp-902400000 {
+			opp-hz = /bits/ 64 <902400000>;
+			required-opps = <&cpu4_ddr_bw_opp1>, <&cpu4_l3_bw_opp1>;
+		};
+
+		cpu4_opp3: opp-979200000 {
+			opp-hz = /bits/ 64 <979200000>;
+			required-opps = <&cpu4_ddr_bw_opp1>, <&cpu4_l3_bw_opp1>;
+		};
+
+		cpu4_opp4: opp-1056000000 {
+			opp-hz = /bits/ 64 <1056000000>;
+			required-opps = <&cpu4_ddr_bw_opp5>, <&cpu4_l3_bw_opp3>;
+		};
+
+		cpu4_opp5: opp-1209600000 {
+			opp-hz = /bits/ 64 <1209600000>;
+			required-opps = <&cpu4_ddr_bw_opp6>, <&cpu4_l3_bw_opp3>;
+		};
+
+		cpu4_opp6: opp-1286400000 {
+			opp-hz = /bits/ 64 <1286400000>;
+			required-opps = <&cpu4_ddr_bw_opp6>, <&cpu4_l3_bw_opp3>;
+		};
+
+		cpu4_opp7: opp-1363200000 {
+			opp-hz = /bits/ 64 <1363200000>;
+			required-opps = <&cpu4_ddr_bw_opp6>, <&cpu4_l3_bw_opp5>;
+		};
+
+		cpu4_opp8: opp-1459200000 {
+			opp-hz = /bits/ 64 <1459200000>;
+			required-opps = <&cpu4_ddr_bw_opp6>, <&cpu4_l3_bw_opp5>;
+		};
+
+		cpu4_opp9: opp-1536000000 {
+			opp-hz = /bits/ 64 <1536000000>;
+			required-opps = <&cpu4_ddr_bw_opp6>, <&cpu4_l3_bw_opp5>;
+		};
+
+		cpu4_opp10: opp-1612800000 {
+			opp-hz = /bits/ 64 <1612800000>;
+			required-opps = <&cpu4_ddr_bw_opp7>, <&cpu4_l3_bw_opp5>;
+		};
+
+		cpu4_opp11: opp-1689600000 {
+			opp-hz = /bits/ 64 <1689600000>;
+			required-opps = <&cpu4_ddr_bw_opp7>, <&cpu4_l3_bw_opp8>;
+		};
+
+		cpu4_opp12: opp-1766400000 {
+			opp-hz = /bits/ 64 <1766400000>;
+			required-opps = <&cpu4_ddr_bw_opp8>, <&cpu4_l3_bw_opp8>;
+		};
+
+		cpu4_opp13: opp-1843200000 {
+			opp-hz = /bits/ 64 <1843200000>;
+			required-opps = <&cpu4_ddr_bw_opp8>, <&cpu4_l3_bw_opp8>;
+		};
+
+		cpu4_opp14: opp-1920000000 {
+			opp-hz = /bits/ 64 <1920000000>;
+			required-opps = <&cpu4_ddr_bw_opp8>, <&cpu4_l3_bw_opp8>;
+		};
+
+		cpu4_opp15: opp-1996800000 {
+			opp-hz = /bits/ 64 <1996800000>;
+			required-opps = <&cpu4_ddr_bw_opp9>, <&cpu4_l3_bw_opp9>;
+		};
+
+		cpu4_opp16: opp-2092800000 {
+			opp-hz = /bits/ 64 <2092800000>;
+			required-opps = <&cpu4_ddr_bw_opp9>, <&cpu4_l3_bw_opp9>;
+		};
+
+		cpu4_opp17: opp-2169600000 {
+			opp-hz = /bits/ 64 <2169600000>;
+			required-opps = <&cpu4_ddr_bw_opp9>, <&cpu4_l3_bw_opp9>;
+		};
+
+		cpu4_opp18: opp-2246400000 {
+			opp-hz = /bits/ 64 <2246400000>;
+			required-opps = <&cpu4_ddr_bw_opp9>, <&cpu4_l3_bw_opp9>;
+		};
+
+		cpu4_opp19: opp-2323200000 {
+			opp-hz = /bits/ 64 <2323200000>;
+			required-opps = <&cpu4_ddr_bw_opp9>, <&cpu4_l3_bw_opp9>;
+		};
+
+		cpu4_opp20: opp-2400000000 {
+			opp-hz = /bits/ 64 <2400000000>;
+			required-opps = <&cpu4_ddr_bw_opp9>, <&cpu4_l3_bw_opp10>;
+		};
+
+		cpu4_opp21: opp-2476800000 {
+			opp-hz = /bits/ 64 <2476800000>;
+			required-opps = <&cpu4_ddr_bw_opp9>, <&cpu4_l3_bw_opp10>;
+		};
+
+		cpu4_opp22: opp-2553600000 {
+			opp-hz = /bits/ 64 <2553600000>;
+			required-opps = <&cpu4_ddr_bw_opp9>, <&cpu4_l3_bw_opp10>;
+		};
+
+		cpu4_opp23: opp-2649600000 {
+			opp-hz = /bits/ 64 <2649600000>;
+			required-opps = <&cpu4_ddr_bw_opp9>, <&cpu4_l3_bw_opp10>;
+		};
+
+		cpu4_opp24: opp-2745600000 {
+			opp-hz = /bits/ 64 <2745600000>;
+			required-opps = <&cpu4_ddr_bw_opp9>, <&cpu4_l3_bw_opp11>;
+		};
+
+		cpu4_opp25: opp-2803200000 {
+			opp-hz = /bits/ 64 <2803200000>;
+			required-opps = <&cpu4_ddr_bw_opp9>, <&cpu4_l3_bw_opp11>;
+		};
+	};
+
 	pmu {
 		compatible = "arm,armv8-pmuv3";
 		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
@@ -3345,6 +3618,186 @@
 			#freq-domain-cells = <1>;
 		};
 
+		cpu0_ddr_bw_opp_table: cpu0-ddr-bw-opp-table {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			cpu0_ddr_bw_opp1: opp-200000000  {
+				opp-peak-kBps =/bits/ 32 <800000>;
+			};
+
+			cpu0_ddr_bw_opp2: opp-300000000 {
+				opp-peak-kBps = /bits/ 32 <1200000>;
+			};
+
+			cpu0_ddr_bw_opp3: opp-451000000 {
+				opp-peak-kBps = /bits/ 32 <1804000>;
+			};
+
+			cpu0_ddr_bw_opp4: opp-547000000 {
+				opp-peak-kBps = /bits/ 32 <2188000>;
+			};
+
+			cpu0_ddr_bw_opp5: opp-681000000 {
+				opp-peak-kBps = /bits/ 32 <2724000>;
+			};
+
+			cpu0_ddr_bw_opp6: opp-768000000 {
+				opp-peak-kBps = /bits/ 32 <3072000>;
+			};
+
+			cpu0_ddr_bw_opp7: opp-1017000000 {
+				opp-peak-kBps = /bits/ 32 <4068000>;
+			};
+		};
+
+		cpu0_l3_bw_opp_table: cpu0-l3-bw-opp-table {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			cpu0_l3_bw_opp1: opp-300000000 {
+				opp-peak-kBps = /bits/ 32 <4800000>;
+			};
+
+			cpu0_l3_bw_opp2: opp-403200000 {
+				opp-peak-kBps = /bits/ 32 <6451200>;
+			};
+
+			cpu0_l3_bw_opp3: opp-480000000 {
+				opp-peak-kBps = /bits/ 32 <7680000>;
+			};
+
+			cpu0_l3_bw_opp4: opp-576000000 {
+				opp-peak-kBps = /bits/ 32 <9216000>;
+			};
+
+			cpu0_l3_bw_opp5: opp-652800000 {
+				opp-peak-kBps = /bits/ 32 <10444800>;
+			};
+
+			cpu0_l3_bw_opp6: opp-748800000 {
+				opp-peak-kBps = /bits/ 32 <11980800>;
+			};
+
+			cpu0_l3_bw_opp7: opp-844800000 {
+				opp-peak-kBps = /bits/ 32 <13516800>;
+			};
+
+			cpu0_l3_bw_opp8: opp-940800000 {
+				opp-peak-kBps = /bits/ 32 <15052800>;
+			};
+
+			cpu0_l3_bw_opp9: opp-1036800000 {
+				opp-peak-kBps = /bits/ 32 <16588800>;
+			};
+
+			cpu0_l3_bw_opp10: opp-1132800000 {
+				opp-peak-kBps = /bits/ 32 <18124800>;
+			};
+
+			cpu0_l3_bw_opp11: opp-1209600000 {
+				opp-peak-kBps = /bits/ 32 <19353600>;
+			};
+
+			cpu0_l3_bw_opp12: opp-1305600000 {
+				opp-peak-kBps = /bits/ 32 <20889600>;
+			};
+
+			cpu0_l3_bw_opp13: opp-1401600000 {
+				opp-peak-kBps = /bits/ 32 <22425600>;
+			};
+		};
+
+		cpu4_ddr_bw_opp_table: cpu4-ddr-bw-opp-table {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			cpu4_ddr_bw_opp1: opp-300000000 {
+				opp-peak-kBps = /bits/ 32 <1200000>;
+			};
+
+			cpu4_ddr_bw_opp2: opp-451000000 {
+				opp-peak-kBps = /bits/ 32 <1804000>;
+			};
+
+			cpu4_ddr_bw_opp3: opp-547000000 {
+				opp-peak-kBps = /bits/ 32 <2188000>;
+			};
+
+			cpu4_ddr_bw_opp4: opp-681000000 {
+				opp-peak-kBps = /bits/ 32 <2724000>;
+			};
+
+			cpu4_ddr_bw_opp5: opp-768000000 {
+				opp-peak-kBps = /bits/ 32 <3072000>;
+			};
+
+			cpu4_ddr_bw_opp6: opp-1017000000 {
+				opp-peak-kBps = /bits/ 32 <4068000>;
+			};
+
+			cpu4_ddr_bw_opp7: opp-1296000000 {
+				opp-peak-kBps = /bits/ 32 <5184000>;
+			};
+
+			cpu4_ddr_bw_opp8: opp-1555000000 {
+				opp-peak-kBps = /bits/ 32 <6220000>;
+			};
+
+			cpu4_ddr_bw_opp9: opp-1804000000 {
+				opp-peak-kBps = /bits/ 32 <7216000>;
+			};
+		};
+
+		cpu4_l3_bw_opp_table: cpu4-l3-bw-opp-table {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			cpu4_l3_bw_opp1: opp-576000000 {
+				opp-peak-kBps = /bits/ 32 <9216000>;
+			};
+
+			cpu4_l3_bw_opp2: opp-652800000 {
+				opp-peak-kBps = /bits/ 32 <10444800>;
+			};
+
+			cpu4_l3_bw_opp3: opp-748800000 {
+				opp-peak-kBps = /bits/ 32 <11980800>;
+			};
+
+			cpu4_l3_bw_opp4: opp-844800000 {
+				opp-peak-kBps = /bits/ 32 <13516800>;
+			};
+
+			cpu4_l3_bw_opp5: opp-940800000 {
+				opp-peak-kBps = /bits/ 32 <15052800>;
+			};
+
+			cpu4_l3_bw_opp6: opp-1036800000 {
+				opp-peak-kBps = /bits/ 32 <16588800>;
+			};
+
+			cpu4_l3_bw_opp7: opp-1132800000 {
+				opp-peak-kBps = /bits/ 32 <18124800>;
+			};
+
+			cpu4_l3_bw_opp8: opp-1209600000 {
+				opp-peak-kBps = /bits/ 32 <19353600>;
+			};
+
+			cpu4_l3_bw_opp9: opp-1305600000 {
+				opp-peak-kBps = /bits/ 32 <20889600>;
+			};
+
+			cpu4_l3_bw_opp10: opp-1401600000 {
+				opp-peak-kBps = /bits/ 32 <22425600>;
+			};
+
+			cpu4_l3_bw_opp11: opp-1478400000 {
+				opp-peak-kBps = /bits/ 32 <23654400>;
+			};
+		};
+
 		wifi: wifi@18800000 {
 			compatible = "qcom,wcn3990-wifi";
 			status = "disabled";
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
