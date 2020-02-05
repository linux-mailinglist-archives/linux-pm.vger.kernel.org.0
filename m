Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB0331530A9
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2020 13:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgBEM1U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Feb 2020 07:27:20 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:60280 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727104AbgBEM1P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Feb 2020 07:27:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580905634; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=i2C4DEcswPKQW3w2ue5RgC1m630n76+YV2l+o97UXI8=; b=XNQUfos41YpZ+DYnCeYJNEPZ+JUbop9Kf2/WZDOctnOSVDJl/BlkGEmJBWw/GU0GwYaqczY3
 sd4bTo6utZ6HJX884GkDo3zU92uGIEWjrnbjkazKWAmONmoKnhX6Ysz3DZhkG/nfNemll028
 I6tLAjUntBTq0rimSnq+AJ3R/3E=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3ab4a0.7f25d49d4378-smtp-out-n02;
 Wed, 05 Feb 2020 12:27:12 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 18429C447AA; Wed,  5 Feb 2020 12:27:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 82456C43383;
        Wed,  5 Feb 2020 12:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 82456C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     swboyd@chromium.org, agross@kernel.org, david.brown@linaro.org,
        sudeep.holla@arm.com, Lorenzo.Pieralisi@arm.com
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, ulf.hansson@linaro.org, rjw@rjwysocki.net,
        Maulik Shah <mkshah@codeaurora.org>, devicetree@vger.kernel.org
Subject: [PATCH v4 6/6] arm64: dts: qcom: sc7180: Add cpuidle low power states
Date:   Wed,  5 Feb 2020 17:56:12 +0530
Message-Id: <1580905572-22712-7-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580905572-22712-1-git-send-email-mkshah@codeaurora.org>
References: <1580905572-22712-1-git-send-email-mkshah@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add device bindings for cpuidle states for cpu devices.

Cc: devicetree@vger.kernel.org
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 135 +++++++++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 8011c5f..844a25a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -86,6 +86,8 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			power-domains = <&CPU_PD0>;
+			power-domain-names = "psci";
 			next-level-cache = <&L2_0>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -103,6 +105,8 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			power-domains = <&CPU_PD1>;
+			power-domain-names = "psci";
 			next-level-cache = <&L2_100>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -117,6 +121,8 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x200>;
 			enable-method = "psci";
+			power-domains = <&CPU_PD2>;
+			power-domain-names = "psci";
 			next-level-cache = <&L2_200>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -131,6 +137,8 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x300>;
 			enable-method = "psci";
+			power-domains = <&CPU_PD3>;
+			power-domain-names = "psci";
 			next-level-cache = <&L2_300>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -145,6 +153,8 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x400>;
 			enable-method = "psci";
+			power-domains = <&CPU_PD4>;
+			power-domain-names = "psci";
 			next-level-cache = <&L2_400>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -159,6 +169,8 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x500>;
 			enable-method = "psci";
+			power-domains = <&CPU_PD5>;
+			power-domain-names = "psci";
 			next-level-cache = <&L2_500>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -173,6 +185,8 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x600>;
 			enable-method = "psci";
+			power-domains = <&CPU_PD6>;
+			power-domain-names = "psci";
 			next-level-cache = <&L2_600>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
@@ -187,6 +201,8 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x700>;
 			enable-method = "psci";
+			power-domains = <&CPU_PD7>;
+			power-domain-names = "psci";
 			next-level-cache = <&L2_700>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
@@ -195,6 +211,60 @@
 				next-level-cache = <&L3_0>;
 			};
 		};
+
+		idle-states {
+			entry-method = "psci";
+
+			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "little-power-down";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <549>;
+				exit-latency-us = <901>;
+				min-residency-us = <1774>;
+				local-timer-stop;
+			};
+
+			LITTLE_CPU_SLEEP_1: cpu-sleep-0-1 {
+				compatible = "arm,idle-state";
+				idle-state-name = "little-rail-power-down";
+				arm,psci-suspend-param = <0x40000004>;
+				entry-latency-us = <702>;
+				exit-latency-us = <915>;
+				min-residency-us = <4001>;
+				local-timer-stop;
+			};
+
+			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "big-power-down";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <523>;
+				exit-latency-us = <1244>;
+				min-residency-us = <2207>;
+				local-timer-stop;
+			};
+
+			BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
+				compatible = "arm,idle-state";
+				idle-state-name = "big-rail-power-down";
+				arm,psci-suspend-param = <0x40000004>;
+				entry-latency-us = <526>;
+				exit-latency-us = <1854>;
+				min-residency-us = <5555>;
+				local-timer-stop;
+			};
+
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "cluster-power-down";
+				arm,psci-suspend-param = <0x40003444>;
+				entry-latency-us = <3263>;
+				exit-latency-us = <6562>;
+				min-residency-us = <9926>;
+				local-timer-stop;
+			};
+		};
 	};
 
 	memory@80000000 {
@@ -297,6 +367,70 @@
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
+
+		CPU_PD0: cpu-pd0 {
+			#power-domain-cells = <0>;
+			power-domains = <&apps_rsc>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>,
+					     <&LITTLE_CPU_SLEEP_1>,
+					     <&CLUSTER_SLEEP_0>;
+		};
+
+		CPU_PD1: cpu-pd1 {
+			#power-domain-cells = <0>;
+			power-domains = <&apps_rsc>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>,
+					     <&LITTLE_CPU_SLEEP_1>,
+					     <&CLUSTER_SLEEP_0>;
+		};
+
+		CPU_PD2: cpu-pd2 {
+			#power-domain-cells = <0>;
+			power-domains = <&apps_rsc>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>,
+					     <&LITTLE_CPU_SLEEP_1>,
+					     <&CLUSTER_SLEEP_0>;
+		};
+
+		CPU_PD3: cpu-pd3 {
+			#power-domain-cells = <0>;
+			power-domains = <&apps_rsc>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>,
+					     <&LITTLE_CPU_SLEEP_1>,
+					     <&CLUSTER_SLEEP_0>;
+		};
+
+		CPU_PD4: cpu-pd4 {
+			#power-domain-cells = <0>;
+			power-domains = <&apps_rsc>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>,
+					     <&LITTLE_CPU_SLEEP_1>,
+					     <&CLUSTER_SLEEP_0>;
+		};
+
+		CPU_PD5: cpu-pd5 {
+			#power-domain-cells = <0>;
+			power-domains = <&apps_rsc>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>,
+					     <&LITTLE_CPU_SLEEP_1>,
+					     <&CLUSTER_SLEEP_0>;
+		};
+
+		CPU_PD6: cpu-pd6 {
+			#power-domain-cells = <0>;
+			power-domains = <&apps_rsc>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>,
+					     <&BIG_CPU_SLEEP_1>,
+					     <&CLUSTER_SLEEP_0>;
+		};
+
+		CPU_PD7: cpu-pd7 {
+			#power-domain-cells = <0>;
+			power-domains = <&apps_rsc>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>,
+					     <&BIG_CPU_SLEEP_1>,
+					     <&CLUSTER_SLEEP_0>;
+		};
 	};
 
 	soc: soc {
@@ -1417,6 +1551,7 @@
 					  <SLEEP_TCS   3>,
 					  <WAKE_TCS    3>,
 					  <CONTROL_TCS 1>;
+			#power-domain-cells = <0>;
 
 			rpmhcc: clock-controller {
 				compatible = "qcom,sc7180-rpmh-clk";
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
