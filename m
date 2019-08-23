Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E49499AA21
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 10:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388157AbfHWITP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 04:19:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43052 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbfHWITP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2019 04:19:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8CB756141C; Fri, 23 Aug 2019 08:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566548353;
        bh=ivnrCKjbO+eE/XJS4+1hUhUAdgiUh6t5Yaf2c9hnGR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nb6aR21fDqjoMghx2KCWYKzihXHWeGuudy8Z2DLAu2Hn76UBoPb/Ss2j4eUYvmeSA
         9l53dCxUwQR8XgB3OIIouO5zkJsHhbHiPiM7Seej6zTft0mPd6iBC9wZLOFABPBrnr
         LQDKUCmiWHl1w0zUGJEO8P0mCi9BM5T8GzTyblCE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D10161418;
        Fri, 23 Aug 2019 08:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566548351;
        bh=ivnrCKjbO+eE/XJS4+1hUhUAdgiUh6t5Yaf2c9hnGR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JvnU0LoAJeHB2kqpTg+Ig5kXTcjkt6hwEPR2OnDfpKkyAnWEF84OMj2AXdTLRkMwU
         s8/1hYC7kPxOF/K/fiYK+/9dfIOtdRlnsKeYT3rt0qKuQFqyiikaXqTe8atDxpzaKp
         5kSeluGpqGdE3ptPysGC8r8EGbObG1EexIOyAe5U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D10161418
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     swboyd@chromium.org, agross@kernel.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, ulf.hansson@linaro.org,
        Maulik Shah <mkshah@codeaurora.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 5/6] arm64: dts: Convert to the hierarchical CPU topology layout for sdm845
Date:   Fri, 23 Aug 2019 13:47:02 +0530
Message-Id: <20190823081703.17325-6-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190823081703.17325-1-mkshah@codeaurora.org>
References: <20190823081703.17325-1-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In the hierarchical layout, we are creating power domains around each CPU
and describes the idle states for them inside the power domain provider
node. Note that, the CPU's idle states still needs to be compatible with
"arm,idle-state".

Furthermore, represent the CPU cluster as a separate master power domain,
powering the CPU's power domains. The cluster node, contains the idle
states for the cluster and each idle state needs to be compatible with
the "domain-idle-state".

If the running platform is using a PSCI FW that supports the OS initiated
CPU suspend mode, which likely should be the case unless the PSCI FW is
very old, this change triggers the PSCI driver to enable it.

Cc: devicetree@vger.kernel.org
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 103 ++++++++++++++++++++-------
 1 file changed, 78 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 4babff5f19b5..0e7f36d2a7d9 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -190,9 +190,8 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
-			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
-					   &LITTLE_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
+			power-domains = <&CPU_PD0>;
+			power-domain-names = "psci";
 			capacity-dmips-mhz = <607>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
@@ -211,9 +210,8 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
-			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
-					   &LITTLE_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
+			power-domains = <&CPU_PD1>;
+			power-domain-names = "psci";
 			capacity-dmips-mhz = <607>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
@@ -229,9 +227,8 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x200>;
 			enable-method = "psci";
-			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
-					   &LITTLE_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
+			power-domains = <&CPU_PD2>;
+			power-domain-names = "psci";
 			capacity-dmips-mhz = <607>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
@@ -247,9 +244,8 @@
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x300>;
 			enable-method = "psci";
-			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
-					   &LITTLE_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
+			power-domains = <&CPU_PD3>;
+			power-domain-names = "psci";
 			capacity-dmips-mhz = <607>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
@@ -266,9 +262,8 @@
 			reg = <0x0 0x400>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			cpu-idle-states = <&BIG_CPU_SLEEP_0
-					   &BIG_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
+			power-domains = <&CPU_PD4>;
+			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_400>;
@@ -284,9 +279,8 @@
 			reg = <0x0 0x500>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			cpu-idle-states = <&BIG_CPU_SLEEP_0
-					   &BIG_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
+			power-domains = <&CPU_PD5>;
+			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_500>;
@@ -302,9 +296,8 @@
 			reg = <0x0 0x600>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			cpu-idle-states = <&BIG_CPU_SLEEP_0
-					   &BIG_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
+			power-domains = <&CPU_PD6>;
+			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_600>;
@@ -320,9 +313,8 @@
 			reg = <0x0 0x700>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			cpu-idle-states = <&BIG_CPU_SLEEP_0
-					   &BIG_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
+			power-domains = <&CPU_PD7>;
+			power-domain-names = "psci";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_700>;
@@ -412,7 +404,7 @@
 			};
 
 			CLUSTER_SLEEP_0: cluster-sleep-0 {
-				compatible = "arm,idle-state";
+				compatible = "domain-idle-state";
 				idle-state-name = "cluster-power-down";
 				arm,psci-suspend-param = <0x400000F4>;
 				entry-latency-us = <3263>;
@@ -618,6 +610,67 @@
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
+
+		CPU_PD0: cpu-pd0 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>,
+						<&LITTLE_CPU_SLEEP_1>;
+		};
+
+		CPU_PD1: cpu-pd1 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>,
+						<&LITTLE_CPU_SLEEP_1>;
+		};
+
+		CPU_PD2: cpu-pd2 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>,
+						<&LITTLE_CPU_SLEEP_1>;
+		};
+
+		CPU_PD3: cpu-pd3 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>,
+						<&LITTLE_CPU_SLEEP_1>;
+		};
+
+		CPU_PD4: cpu-pd4 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>,
+						<&BIG_CPU_SLEEP_1>;
+		};
+
+		CPU_PD5: cpu-pd5 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>,
+						<&BIG_CPU_SLEEP_1>;
+		};
+
+		CPU_PD6: cpu-pd6 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>,
+						<&BIG_CPU_SLEEP_1>;
+		};
+
+		CPU_PD7: cpu-pd7 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>,
+						<&BIG_CPU_SLEEP_1>;
+		};
+
+		CLUSTER_PD: cluster-pd {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_SLEEP_0>;
+		};
 	};
 
 	soc: soc {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.

