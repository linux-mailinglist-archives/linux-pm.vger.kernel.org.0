Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3B2583A7
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 15:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfF0Ne7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 09:34:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38326 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfF0Ne7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 09:34:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C014C6118F; Thu, 27 Jun 2019 13:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561642497;
        bh=60ZB9lT8VSmydyESwe8vp6KrAr7oGXZH3CwQcSsZB6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EFqK89KmU/c4naFu51JQQDlHJ5WLWP01bYFelA5JRtJF/iyTkhBU7oGt57v+X/+bT
         4W6/RyfUGCQy+QiU7McUcV4nLZ2OETqancOJl8vI382KA22aGlVEwIBKDafcVp0yvz
         lgW8/JBJka1g9AIuwHhyiKe7Gn+eUBoaaWx4vHRc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 77E4C60EA5;
        Thu, 27 Jun 2019 13:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561642494;
        bh=60ZB9lT8VSmydyESwe8vp6KrAr7oGXZH3CwQcSsZB6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZJhm+hKy6ChT//kN36FUZ+mFH1jDLXgrwXZBDl3AlFZJd+sSPRQ6KP5C0Gyt0yjSV
         fAMwiKKxAmmdzyfVoA9Olj4RdE96oWaufhqNofxv2D4omkwmbGsFvY1o7/ZqU9exxJ
         +7vVdr9eXg/87U2PuxAyZjHpVWVaKT7Gr9UHV0yc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 77E4C60EA5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        georgi.djakov@linaro.org
Cc:     agross@kernel.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        saravanak@google.com, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH RFC 4/4] arm64: dts: qcom: sdm845: Add cpu OPP tables
Date:   Thu, 27 Jun 2019 19:04:24 +0530
Message-Id: <20190627133424.4980-5-sibis@codeaurora.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627133424.4980-1-sibis@codeaurora.org>
References: <20190627133424.4980-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add OPP tables for the cpu nodes.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 343 +++++++++++++++++++++++++++
 1 file changed, 343 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 471cbb7d9bc39..8cabbb274d3e7 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -197,6 +197,10 @@
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			/* path between CPU and DDR memory and CPU and L3 */
+			interconnects = <&rsc_hlos MASTER_APPSS_PROC &rsc_hlos SLAVE_EBI1>,
+					<&rsc_hlos MASTER_APPSS_PROC &osm_l3 SLAVE_OSM_L3>;
 			L2_0: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -218,6 +222,10 @@
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_100>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			/* path between CPU and DDR memory and CPU and L3 */
+			interconnects = <&rsc_hlos MASTER_APPSS_PROC &rsc_hlos SLAVE_EBI1>,
+					<&rsc_hlos MASTER_APPSS_PROC &osm_l3 SLAVE_OSM_L3>;
 			L2_100: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -236,6 +244,10 @@
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_200>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			/* path between CPU and DDR memory and CPU and L3 */
+			interconnects = <&rsc_hlos MASTER_APPSS_PROC &rsc_hlos SLAVE_EBI1>,
+					<&rsc_hlos MASTER_APPSS_PROC &osm_l3 SLAVE_OSM_L3>;
 			L2_200: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -254,6 +266,10 @@
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_300>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			/* path between CPU and DDR memory and CPU and L3 */
+			interconnects = <&rsc_hlos MASTER_APPSS_PROC &rsc_hlos SLAVE_EBI1>,
+					<&rsc_hlos MASTER_APPSS_PROC &osm_l3 SLAVE_OSM_L3>;
 			L2_300: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -272,6 +288,10 @@
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_400>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			/* path between CPU and DDR memory and CPU and L3 */
+			interconnects = <&rsc_hlos MASTER_APPSS_PROC &rsc_hlos SLAVE_EBI1>,
+					<&rsc_hlos MASTER_APPSS_PROC &osm_l3 SLAVE_OSM_L3>;
 			L2_400: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -290,6 +310,10 @@
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_500>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			/* path between CPU and DDR memory and CPU and L3 */
+			interconnects = <&rsc_hlos MASTER_APPSS_PROC &rsc_hlos SLAVE_EBI1>,
+					<&rsc_hlos MASTER_APPSS_PROC &osm_l3 SLAVE_OSM_L3>;
 			L2_500: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -308,6 +332,10 @@
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_600>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			/* path between CPU and DDR memory and CPU and L3 */
+			interconnects = <&rsc_hlos MASTER_APPSS_PROC &rsc_hlos SLAVE_EBI1>,
+					<&rsc_hlos MASTER_APPSS_PROC &osm_l3 SLAVE_OSM_L3>;
 			L2_600: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -326,6 +354,10 @@
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_700>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			/* path between CPU and DDR memory and CPU and L3 */
+			interconnects = <&rsc_hlos MASTER_APPSS_PROC &rsc_hlos SLAVE_EBI1>,
+					<&rsc_hlos MASTER_APPSS_PROC &osm_l3 SLAVE_OSM_L3>;
 			L2_700: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -423,6 +455,317 @@
 		};
 	};
 
+	cpu0_opp_table: cpu0_opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cpu0_opp1: opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 762 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 4577 MB/s peak */
+			bandwidth-MBps = <0 762>, <0 4577>;
+		};
+
+		cpu0_opp2: opp-403200000 {
+			opp-hz = /bits/ 64 <403200000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 762 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 4577 MB/s peak */
+			bandwidth-MBps = <0 762>, <0 4577>;
+		};
+
+		cpu0_opp3: opp-480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 762 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 6152 MB/s peak */
+			bandwidth-MBps = <0 762>, <0 6152>;
+		};
+
+		cpu0_opp4: opp-576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 762 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 6152 MB/s peak */
+			bandwidth-MBps = <0 762>, <0 6152>;
+		};
+
+		cpu0_opp5: opp-652800000 {
+			opp-hz = /bits/ 64 <652800000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 762 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 7324 MB/s peak */
+			bandwidth-MBps = <0 762>, <0 7324>;
+		};
+
+		cpu0_opp6: opp-748800000 {
+			opp-hz = /bits/ 64 <748800000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 1720 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 8789 MB/s peak */
+			bandwidth-MBps = <0 1720>, <0 8789>;
+		};
+
+		cpu0_opp7: opp-825600000 {
+			opp-hz = /bits/ 64 <825600000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 1720 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 8789 MB/s peak */
+			bandwidth-MBps = <0 1720>, <0 8789>;
+		};
+
+		cpu0_opp8: opp-902400000 {
+			opp-hz = /bits/ 64 <902400000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 1720 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 9960 MB/s peak */
+			bandwidth-MBps = <0 1720>, <0 9960>;
+		};
+
+		cpu0_opp9: opp-979200000 {
+			opp-hz = /bits/ 64 <979200000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 1720 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 11425 MB/s peak */
+			bandwidth-MBps = <0 1720>, <0 11425>;
+		};
+
+		cpu0_opp10: opp-1056000000 {
+			opp-hz = /bits/ 64 <1056000000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 1720 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 11425 MB/s peak */
+			bandwidth-MBps = <0 1720>, <0 11425>;
+		};
+
+		cpu0_opp11: opp-1132800000 {
+			opp-hz = /bits/ 64 <1132800000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 2086 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 12890 MB/s peak */
+			bandwidth-MBps = <0 2086>, <0 12890>;
+		};
+
+		cpu0_opp12: opp-1228800000 {
+			opp-hz = /bits/ 64 <1228800000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 2086 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 14355 MB/s peak */
+			bandwidth-MBps = <0 2086>, <0 14355>;
+		};
+
+		cpu0_opp13: opp-1324800000 {
+			opp-hz = /bits/ 64 <1324800000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 2086 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 15820 MB/s peak */
+			bandwidth-MBps = <0 2086>, <0 15820>;
+		};
+
+		cpu0_opp14: opp-1420800000 {
+			opp-hz = /bits/ 64 <1420800000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 2086 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 17285 MB/s peak */
+			bandwidth-MBps = <0 2086>, <0 17285>;
+		};
+
+		cpu0_opp15: opp-1516800000 {
+			opp-hz = /bits/ 64 <1516800000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 2597 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 18457 MB/s peak */
+			bandwidth-MBps = <0 2597>, <0 18457>;
+		};
+
+		cpu0_opp16: opp-1612800000 {
+			opp-hz = /bits/ 64 <1612800000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 3879 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 18457 MB/s peak */
+			bandwidth-MBps = <0 3879>, <0 18457>;
+		};
+
+		cpu0_opp17: opp-1689600000 {
+			opp-hz = /bits/ 64 <1689600000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 3879 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 19921 MB/s peak */
+			bandwidth-MBps = <0 3879>, <0 19921>;
+		};
+
+		cpu0_opp18: opp-1766400000 {
+			opp-hz = /bits/ 64 <1766400000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 3879 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 21386 MB/s peak */
+			bandwidth-MBps = <0 3879>, <0 21386>;
+		};
+	};
+
+	cpu4_opp_table: cpu4_opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cpu4_opp1: opp-825600000 {
+			opp-hz = /bits/ 64 <825600000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 1144 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 8789 MB/s peak */
+			bandwidth-MBps = <0 1144>, <0 8789>;
+		};
+
+		cpu4_opp2: opp-902400000 {
+			opp-hz = /bits/ 64 <902400000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 1144 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 8789 MB/s peak */
+			bandwidth-MBps = <0 1144>, <0 8789>;
+		};
+
+		cpu4_opp3: opp-979200000 {
+			opp-hz = /bits/ 64 <979200000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 1144 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 8789 MB/s peak */
+			bandwidth-MBps = <0 1144>, <0 8789>;
+		};
+
+		cpu4_opp4: opp-1056000000 {
+			opp-hz = /bits/ 64 <1056000000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 2929 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 11425 MB/s peak */
+			bandwidth-MBps = <0 2929>, <0 11425>;
+		};
+
+		cpu4_opp5: opp-1209600000 {
+			opp-hz = /bits/ 64 <1209600000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 3879 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 11425 MB/s peak */
+			bandwidth-MBps = <0 3879>, <0 11425>;
+		};
+
+		cpu4_opp6: opp-1286400000 {
+			opp-hz = /bits/ 64 <1286400000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 3879 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 11425 MB/s peak */
+			bandwidth-MBps = <0 3879>, <0 11425>;
+		};
+
+		cpu4_opp7: opp-1363200000 {
+			opp-hz = /bits/ 64 <1363200000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 3879 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 14355 MB/s peak */
+			bandwidth-MBps = <0 3879>, <0 14355>;
+		};
+
+		cpu4_opp8: opp-1459200000 {
+			opp-hz = /bits/ 64 <1459200000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 3879 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 14355 MB/s peak */
+			bandwidth-MBps = <0 3879>, <0 14355>;
+		};
+
+		cpu4_opp9: opp-1536000000 {
+			opp-hz = /bits/ 64 <1536000000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 3879 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 14355 MB/s peak */
+			bandwidth-MBps = <0 3879>, <0 14355>;
+		};
+
+		cpu4_opp10: opp-1612800000 {
+			opp-hz = /bits/ 64 <1612800000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 4943 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 14355 MB/s peak */
+			bandwidth-MBps = <0 4943>, <0 14355>;
+		};
+
+		cpu4_opp11: opp-1689600000 {
+			opp-hz = /bits/ 64 <1689600000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 4943 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 18457 MB/s peak */
+			bandwidth-MBps = <0 4943>, <0 18457>;
+		};
+
+		cpu4_opp12: opp-1766400000 {
+			opp-hz = /bits/ 64 <1766400000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 5931 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 18457 MB/s peak */
+			bandwidth-MBps = <0 5931>, <0 18457>;
+		};
+
+		cpu4_opp13: opp-1843200000 {
+			opp-hz = /bits/ 64 <1843200000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 5931 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 18457 MB/s peak */
+			bandwidth-MBps = <0 5931>, <0 18457>;
+		};
+
+		cpu4_opp14: opp-1920000000 {
+			opp-hz = /bits/ 64 <1920000000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 5931 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 18457 MB/s peak */
+			bandwidth-MBps = <0 5931>, <0 18457>;
+		};
+
+		cpu4_opp15: opp-1996800000 {
+			opp-hz = /bits/ 64 <1996800000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 6881 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 19921 MB/s peak */
+			bandwidth-MBps = <0 6881>, <0 19921>;
+		};
+
+		cpu4_opp16: opp-2092800000 {
+			opp-hz = /bits/ 64 <2092800000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 6881 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 19921 MB/s peak */
+			bandwidth-MBps = <0 6881>, <0 19921>;
+		};
+
+		cpu4_opp17: opp-2169600000 {
+			opp-hz = /bits/ 64 <2169600000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 6881 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 19921 MB/s peak */
+			bandwidth-MBps = <0 6881>, <0 19921>;
+		};
+
+		cpu4_opp18: opp-2246400000 {
+			opp-hz = /bits/ 64 <2246400000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 6881 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 19921 MB/s peak */
+			bandwidth-MBps = <0 6881>, <0 19921>;
+		};
+
+		cpu4_opp19: opp-2323200000 {
+			opp-hz = /bits/ 64 <2323200000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 6881 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 19921 MB/s peak */
+			bandwidth-MBps = <0 6881>, <0 19921>;
+		};
+
+		cpu4_opp20: opp-2400000000 {
+			opp-hz = /bits/ 64 <2400000000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 6881 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 21386 MB/s peak */
+			bandwidth-MBps = <0 6881>, <0 21386>;
+		};
+
+		cpu4_opp21: opp-2476800000 {
+			opp-hz = /bits/ 64 <2476800000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 6881 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 21386 MB/s peak */
+			bandwidth-MBps = <0 6881>, <0 21386>;
+		};
+
+		cpu4_opp22: opp-2553600000 {
+			opp-hz = /bits/ 64 <2553600000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 6881 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 21386 MB/s peak */
+			bandwidth-MBps = <0 6881>, <0 21386>;
+		};
+
+		cpu4_opp23: opp-2649600000 {
+			opp-hz = /bits/ 64 <2649600000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 6881 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 21386 MB/s peak */
+			bandwidth-MBps = <0 6881>, <0 21386>;
+		};
+
+		cpu4_opp24: opp-2745600000 {
+			opp-hz = /bits/ 64 <2745600000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 6881 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 22558 MB/s peak */
+			bandwidth-MBps = <0 6881>, <0 22558>;
+		};
+
+		cpu4_opp25: opp-2803200000 {
+			opp-hz = /bits/ 64 <2803200000>;
+			/* CPU<->DDR bandwidth: 0 MB/s average, 6881 MB/s peak */
+			/* CPU<->L3 bandwidth: 0 MB/s average, 22558 MB/s peak */
+			bandwidth-MBps = <0 6881>, <0 22558>;
+		};
+	};
+
 	pmu {
 		compatible = "arm,armv8-pmuv3";
 		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

