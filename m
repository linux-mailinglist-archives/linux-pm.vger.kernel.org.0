Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBEF14AAF1
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2020 21:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgA0UFT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jan 2020 15:05:19 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:32249 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728241AbgA0UFS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2020 15:05:18 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580155518; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=5wyN+cpMYJy8Yjfg6FK3pFo+RE0EMy8KLiRdbwdcM3s=; b=dOky7PzzOe1vzW5+OfpJ4L3dzQKQM6vItvXdNu+2W0uz927260klqmYgbLQhzAp89ug+y1GR
 N2vbQdxxo6QHeEuO2zG86Y8tNfWaZt7aQC8amwrTDoccRM1JO7SCyPiM4wgdDphwuucVxbcw
 5pL0EmauoGYAjLd9zW8T/tS1xgg=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2f427d.7feba3336490-smtp-out-n02;
 Mon, 27 Jan 2020 20:05:17 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D7E22C433CB; Mon, 27 Jan 2020 20:05:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EA089C433CB;
        Mon, 27 Jan 2020 20:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA089C433CB
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
Subject: [RFC v3 10/10] arm64: dts: qcom: sc7180: Add cpu OPP tables
Date:   Tue, 28 Jan 2020 01:33:50 +0530
Message-Id: <20200127200350.24465-11-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200127200350.24465-1-sibis@codeaurora.org>
References: <20200127200350.24465-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add OPP tables required to scale DDR/L3 per freq-domain on SC7180 SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 287 +++++++++++++++++++++++++++
 1 file changed, 287 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index ba53ddf17ee3a..699cafc1a727d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -109,6 +109,12 @@
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
+			operating-points-v2 = <&cpu0_opp_table>,
+					      <&cpu0_ddr_bw_opp_table>,
+					      <&cpu0_l3_bw_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC &mc_virt SLAVE_EBI1>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnect-names = "cpu-ddr", "cpu-l3";
 			next-level-cache = <&L2_0>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -129,6 +135,12 @@
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_100>;
+			operating-points-v2 = <&cpu0_opp_table>,
+					      <&cpu0_ddr_bw_opp_table>,
+					      <&cpu0_l3_bw_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC &mc_virt SLAVE_EBI1>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnect-names = "cpu-ddr", "cpu-l3";
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_100: l2-cache {
@@ -145,6 +157,12 @@
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_200>;
+			operating-points-v2 = <&cpu0_opp_table>,
+					      <&cpu0_ddr_bw_opp_table>,
+					      <&cpu0_l3_bw_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC &mc_virt SLAVE_EBI1>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnect-names = "cpu-ddr", "cpu-l3";
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_200: l2-cache {
@@ -161,6 +179,12 @@
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_300>;
+			operating-points-v2 = <&cpu0_opp_table>,
+					      <&cpu0_ddr_bw_opp_table>,
+					      <&cpu0_l3_bw_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC &mc_virt SLAVE_EBI1>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnect-names = "cpu-ddr", "cpu-l3";
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_300: l2-cache {
@@ -177,6 +201,12 @@
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_400>;
+			operating-points-v2 = <&cpu0_opp_table>,
+					      <&cpu0_ddr_bw_opp_table>,
+					      <&cpu0_l3_bw_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC &mc_virt SLAVE_EBI1>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnect-names = "cpu-ddr", "cpu-l3";
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_400: l2-cache {
@@ -193,6 +223,12 @@
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_500>;
+			operating-points-v2 = <&cpu0_opp_table>,
+					      <&cpu0_ddr_bw_opp_table>,
+					      <&cpu0_l3_bw_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC &mc_virt SLAVE_EBI1>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnect-names = "cpu-ddr", "cpu-l3";
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_500: l2-cache {
@@ -209,6 +245,12 @@
 			capacity-dmips-mhz = <1740>;
 			dynamic-power-coefficient = <405>;
 			next-level-cache = <&L2_600>;
+			operating-points-v2 = <&cpu6_opp_table>,
+					      <&cpu6_ddr_bw_opp_table>,
+					      <&cpu6_l3_bw_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC &mc_virt SLAVE_EBI1>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnect-names = "cpu-ddr", "cpu-l3";
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_600: l2-cache {
@@ -225,6 +267,12 @@
 			capacity-dmips-mhz = <1740>;
 			dynamic-power-coefficient = <405>;
 			next-level-cache = <&L2_700>;
+			operating-points-v2 = <&cpu6_opp_table>,
+					      <&cpu6_ddr_bw_opp_table>,
+					      <&cpu6_l3_bw_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC &mc_virt SLAVE_EBI1>,
+					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			interconnect-names = "cpu-ddr", "cpu-l3";
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_700: l2-cache {
@@ -270,6 +318,245 @@
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
+		cpu0_opp2: opp-576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+			required-opps = <&cpu0_ddr_bw_opp1>, <&cpu0_l3_bw_opp1>;
+		};
+
+		cpu0_opp3: opp-768000000 {
+			opp-hz = /bits/ 64 <768000000>;
+			required-opps = <&cpu0_ddr_bw_opp1>, <&cpu0_l3_bw_opp1>;
+		};
+
+		cpu0_opp4: opp-1017600000 {
+			opp-hz = /bits/ 64 <1017600000>;
+			required-opps = <&cpu0_ddr_bw_opp2>, <&cpu0_l3_bw_opp2>;
+		};
+
+		cpu0_opp5: opp-1248000000 {
+			opp-hz = /bits/ 64 <1248000000>;
+			required-opps = <&cpu0_ddr_bw_opp3>, <&cpu0_l3_bw_opp3>;
+		};
+
+		cpu0_opp6: opp-1324800000 {
+			opp-hz = /bits/ 64 <1324800000>;
+			required-opps = <&cpu0_ddr_bw_opp3>, <&cpu0_l3_bw_opp3>;
+		};
+
+		cpu0_opp7: opp-1516800000 {
+			opp-hz = /bits/ 64 <1516800000>;
+			required-opps = <&cpu0_ddr_bw_opp4>, <&cpu0_l3_bw_opp4>;
+		};
+
+		cpu0_opp8: opp-1612800000 {
+			opp-hz = /bits/ 64 <1612800000>;
+			required-opps = <&cpu0_ddr_bw_opp4>, <&cpu0_l3_bw_opp4>;
+		};
+
+		cpu0_opp9: opp-1708800000 {
+			opp-hz = /bits/ 64 <1708800000>;
+			required-opps = <&cpu0_ddr_bw_opp4>, <&cpu0_l3_bw_opp4>;
+		};
+
+		cpu0_opp10: opp-1804800000 {
+			opp-hz = /bits/ 64 <1804800000>;
+			required-opps = <&cpu0_ddr_bw_opp5>, <&cpu0_l3_bw_opp5>;
+		};
+	};
+
+	cpu6_opp_table: cpu6_opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cpu6_opp1: opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			required-opps = <&cpu6_ddr_bw_opp1>, <&cpu6_l3_bw_opp1>;
+		};
+
+		cpu6_opp2: opp-652800000 {
+			opp-hz = /bits/ 64 <652800000>;
+			required-opps = <&cpu6_ddr_bw_opp1>, <&cpu6_l3_bw_opp1>;
+		};
+
+		cpu6_opp3: opp-825600000 {
+			opp-hz = /bits/ 64 <825600000>;
+			required-opps = <&cpu6_ddr_bw_opp1>, <&cpu6_l3_bw_opp1>;
+		};
+
+		cpu6_opp4: opp-979200000 {
+			opp-hz = /bits/ 64 <979200000>;
+			required-opps = <&cpu6_ddr_bw_opp1>, <&cpu6_l3_bw_opp1>;
+		};
+
+		cpu6_opp5: opp-1113600000 {
+			opp-hz = /bits/ 64 <1113600000>;
+			required-opps = <&cpu6_ddr_bw_opp1>, <&cpu6_l3_bw_opp1>;
+		};
+
+		cpu6_opp6: opp-1267200000 {
+			opp-hz = /bits/ 64 <1267200000>;
+			required-opps = <&cpu6_ddr_bw_opp2>, <&cpu6_l3_bw_opp2>;
+		};
+
+		cpu6_opp7: opp-1555200000 {
+			opp-hz = /bits/ 64 <1555200000>;
+			required-opps = <&cpu6_ddr_bw_opp2>, <&cpu6_l3_bw_opp3>;
+		};
+
+		cpu6_opp8: opp-1708800000 {
+			opp-hz = /bits/ 64 <1708800000>;
+			required-opps = <&cpu6_ddr_bw_opp3>, <&cpu6_l3_bw_opp4>;
+		};
+
+		cpu6_opp9: opp-1843200000 {
+			opp-hz = /bits/ 64 <1843200000>;
+			required-opps = <&cpu6_ddr_bw_opp3>, <&cpu6_l3_bw_opp4>;
+		};
+
+		cpu6_opp10: opp-1900800000 {
+			opp-hz = /bits/ 64 <1900800000>;
+			required-opps = <&cpu6_ddr_bw_opp3>, <&cpu6_l3_bw_opp5>;
+		};
+
+		cpu6_opp11: opp-1996800000 {
+			opp-hz = /bits/ 64 <1996800000>;
+			required-opps = <&cpu6_ddr_bw_opp3>, <&cpu6_l3_bw_opp5>;
+		};
+
+		cpu6_opp12: opp-2112000000 {
+			opp-hz = /bits/ 64 <2112000000>;
+			required-opps = <&cpu6_ddr_bw_opp3>, <&cpu6_l3_bw_opp5>;
+		};
+
+		cpu6_opp13: opp-2208000000 {
+			opp-hz = /bits/ 64 <2208000000>;
+			required-opps = <&cpu6_ddr_bw_opp4>, <&cpu6_l3_bw_opp5>;
+		};
+
+		cpu6_opp14: opp-2323200000 {
+			opp-hz = /bits/ 64 <2323200000>;
+			required-opps = <&cpu6_ddr_bw_opp4>, <&cpu6_l3_bw_opp5>;
+		};
+
+		cpu6_opp15: opp-2400000000 {
+			opp-hz = /bits/ 64 <2400000000>;
+			required-opps = <&cpu6_ddr_bw_opp5>, <&cpu6_l3_bw_opp6>;
+		};
+	};
+
+	cpu0_ddr_bw_opp_table: cpu0-ddr-bw-opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cpu0_ddr_bw_opp1: opp-300000000  {
+			opp-peak-kBps =/bits/ 32 <1200000>;
+		};
+
+		cpu0_ddr_bw_opp2: opp-451000000  {
+			opp-peak-kBps =/bits/ 32 <1804000>;
+		};
+
+		cpu0_ddr_bw_opp3: opp-547000000  {
+			opp-peak-kBps =/bits/ 32 <2188000>;
+		};
+
+		cpu0_ddr_bw_opp4: opp-768000000  {
+			opp-peak-kBps =/bits/ 32 <3072000>;
+		};
+
+		cpu0_ddr_bw_opp5: opp-1017000000  {
+			opp-peak-kBps =/bits/ 32 <4068000>;
+		};
+	};
+
+	cpu0_l3_bw_opp_table: cpu0-l3-bw-opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cpu0_l3_bw_opp1: opp-300000000 {
+			opp-peak-kBps = /bits/ 32 <4800000>;
+		};
+
+		cpu0_l3_bw_opp2: opp-556800000 {
+			opp-peak-kBps = /bits/ 32 <8908800>;
+		};
+
+		cpu0_l3_bw_opp3: opp-806400000 {
+			opp-peak-kBps = /bits/ 32 <12902400>;
+		};
+
+		cpu0_l3_bw_opp4: opp-940800000 {
+			opp-peak-kBps = /bits/ 32 <15052800>;
+		};
+
+		cpu0_l3_bw_opp5: opp-1401000000 {
+			opp-peak-kBps = /bits/ 32 <22425600>;
+		};
+	};
+
+	cpu6_ddr_bw_opp_table: cpu6-ddr-bw-opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cpu6_ddr_bw_opp1: opp-547000000  {
+			opp-peak-kBps =/bits/ 32 <2188000>;
+		};
+
+		cpu6_ddr_bw_opp2: opp-1017000000  {
+			opp-peak-kBps =/bits/ 32 <4068000>;
+		};
+
+		cpu6_ddr_bw_opp3: opp-1555000000  {
+			opp-peak-kBps =/bits/ 32 <6220000>;
+		};
+
+		cpu6_ddr_bw_opp4: opp-1804000000  {
+			opp-peak-kBps =/bits/ 32 <7216000>;
+		};
+
+		cpu6_ddr_bw_opp5: opp-2133000000  {
+			opp-peak-kBps =/bits/ 32 <8532000>;
+		};
+	};
+
+	cpu6_l3_bw_opp_table: cpu6-l3-bw-opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cpu6_l3_bw_opp1: opp-556800000 {
+			opp-peak-kBps = /bits/ 32 <8908800>;
+		};
+
+		cpu6_l3_bw_opp2: opp-806400000 {
+			opp-peak-kBps = /bits/ 32 <12902400>;
+		};
+
+		cpu6_l3_bw_opp3: opp-940800000 {
+			opp-peak-kBps = /bits/ 32 <15052800>;
+		};
+
+		cpu6_l3_bw_opp4: opp-1209600000 {
+			opp-peak-kBps = /bits/ 32 <19353600>;
+		};
+
+		cpu6_l3_bw_opp5: opp-1401000000 {
+			opp-peak-kBps = /bits/ 32 <22425600>;
+		};
+
+		cpu6_l3_bw_opp6: opp-1459000000 {
+			opp-peak-kBps = /bits/ 32 <23347200>;
+		};
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		/* We expect the bootloader to fill in the size */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
