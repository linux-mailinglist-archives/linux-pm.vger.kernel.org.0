Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC2736FC6C
	for <lists+linux-pm@lfdr.de>; Fri, 30 Apr 2021 16:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhD3OaI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Apr 2021 10:30:08 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:26061 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbhD3OaH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Apr 2021 10:30:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619792959; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=20c3ML6vrl5T3lJYsoAw4m9HFmCs3mg2UfqJ4XHx7ig=; b=FeyH+DBcgJwFYoEq2fMJHtgpJha5wmgCsC8OSB58YIlIcaqB+VD2RnO9G6/MT7+rkAe275NF
 LezsjTL4XvConSQy08lcXdMBUBjS0s34p+OO0Ffm8TrwSA599BItdjaxUnJrVY8xKgsIgdNc
 W5RkaX7y4nWKKefCKKvoZMB3bjw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 608c143774f773a6643d8077 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 30 Apr 2021 14:29:11
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AF331C4323A; Fri, 30 Apr 2021 14:29:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EF839C433F1;
        Fri, 30 Apr 2021 14:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EF839C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org
Cc:     viresh.kumar@linaro.org, swboyd@chromium.org, agross@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 2/2] arm64: dts: qcom: sc7280: Add cpu OPP tables
Date:   Fri, 30 Apr 2021 19:58:21 +0530
Message-Id: <1619792901-32701-3-git-send-email-sibis@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1619792901-32701-1-git-send-email-sibis@codeaurora.org>
References: <1619792901-32701-1-git-send-email-sibis@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add OPP tables required to scale DDR/L3 per freq-domain on SC7280 SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 135 +++++++++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 0bb835aeae33..90220cecb368 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/clock/qcom,gcc-sc7280.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sc7280.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
@@ -71,6 +72,9 @@
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
+					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_0: l2-cache {
 				compatible = "cache";
@@ -90,6 +94,9 @@
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_100>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
+					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_100: l2-cache {
 				compatible = "cache";
@@ -106,6 +113,9 @@
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_200>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
+					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_200: l2-cache {
 				compatible = "cache";
@@ -122,6 +132,9 @@
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_300>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
+					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_300: l2-cache {
 				compatible = "cache";
@@ -138,6 +151,9 @@
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_400>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
+					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_400: l2-cache {
 				compatible = "cache";
@@ -154,6 +170,9 @@
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_500>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
+					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_500: l2-cache {
 				compatible = "cache";
@@ -170,6 +189,9 @@
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_600>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
+					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_600: l2-cache {
 				compatible = "cache";
@@ -186,6 +208,9 @@
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_700>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
+					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
 			qcom,freq-domain = <&cpufreq_hw 2>;
 			L2_700: l2-cache {
 				compatible = "cache";
@@ -248,6 +273,116 @@
 		};
 	};
 
+	cpu0_opp_table: cpu0_opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cpu0_opp1: opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-peak-kBps = <800000 9600000>;
+		};
+
+		cpu0_opp2: opp-691200000 {
+			opp-hz = /bits/ 64 <691200000>;
+			opp-peak-kBps = <800000 17817600>;
+		};
+
+		cpu0_opp3: opp-806400000 {
+			opp-hz = /bits/ 64 <806400000>;
+			opp-peak-kBps = <800000 20889600>;
+		};
+
+		cpu0_opp4: opp-940800000 {
+			opp-hz = /bits/ 64 <940800000>;
+			opp-peak-kBps = <1804000 24576000>;
+		};
+
+		cpu0_opp5: opp-1152000000 {
+			opp-hz = /bits/ 64 <1152000000>;
+			opp-peak-kBps = <2188000 27033600>;
+		};
+
+		cpu0_opp6: opp-1324800000 {
+			opp-hz = /bits/ 64 <1324800000>;
+			opp-peak-kBps = <2188000 33792000>;
+		};
+
+		cpu0_opp7: opp-1516800000 {
+			opp-hz = /bits/ 64 <1516800000>;
+			opp-peak-kBps = <3072000 38092800>;
+		};
+
+		cpu0_opp8: opp-1651200000 {
+			opp-hz = /bits/ 64 <1651200000>;
+			opp-peak-kBps = <3072000 41779200>;
+		};
+
+		cpu0_opp9: opp-1804800000 {
+			opp-hz = /bits/ 64 <1804800000>;
+			opp-peak-kBps = <4068000 48537600>;
+		};
+
+		cpu0_opp10: opp-1958400000 {
+			opp-hz = /bits/ 64 <1958400000>;
+			opp-peak-kBps = <4068000 48537600>;
+		};
+	};
+
+	cpu4_opp_table: cpu4_opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		cpu4_opp1: opp-691200000 {
+			opp-hz = /bits/ 64 <691200000>;
+			opp-peak-kBps = <1804000 9600000>;
+		};
+
+		cpu4_opp2: opp-940800000 {
+			opp-hz = /bits/ 64 <940800000>;
+			opp-peak-kBps = <2188000 17817600>;
+		};
+
+		cpu4_opp3: opp-1228800000 {
+			opp-hz = /bits/ 64 <1228800000>;
+			opp-peak-kBps = <4068000 24576000>;
+		};
+
+		cpu4_opp4: opp-1344000000 {
+			opp-hz = /bits/ 64 <1344000000>;
+			opp-peak-kBps = <4068000 24576000>;
+		};
+
+		cpu4_opp5: opp-1516800000 {
+			opp-hz = /bits/ 64 <1516800000>;
+			opp-peak-kBps = <4068000 24576000>;
+		};
+
+		cpu4_opp6: opp-1651200000 {
+			opp-hz = /bits/ 64 <1651200000>;
+			opp-peak-kBps = <6220000 38092800>;
+		};
+
+		cpu4_opp7: opp-1900800000 {
+			opp-hz = /bits/ 64 <1900800000>;
+			opp-peak-kBps = <6220000 44851200>;
+		};
+
+		cpu4_opp8: opp-2054400000 {
+			opp-hz = /bits/ 64 <2054400000>;
+			opp-peak-kBps = <6220000 44851200>;
+		};
+
+		cpu4_opp9: opp-2131200000 {
+			opp-hz = /bits/ 64 <2131200000>;
+			opp-peak-kBps = <6220000 44851200>;
+		};
+
+		cpu4_opp10: opp-2400000000 {
+			opp-hz = /bits/ 64 <2400000000>;
+			opp-peak-kBps = <6832000 48537600>;
+		};
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		/* We expect the bootloader to fill in the size */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

