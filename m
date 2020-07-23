Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E7322AFFE
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jul 2020 15:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgGWNJt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jul 2020 09:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbgGWNJt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2020 09:09:49 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E37CC0619E3
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2020 06:09:49 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a15so5098800wrh.10
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2020 06:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=17kyN4uG9zM2SVvBdFEN2V7gUNHA6vQ1r82uXAWSj1o=;
        b=iNYz1nET+7qL8NTUHVBf7eGztC6NQ0TgdywiTyTGIX/d+DXZ6tr+VJjj4pgSqJMlet
         kqGvVy4YINDioCGruoErFj4WEE7R5+4t+BrtKfvH0awZWJbAmcrz8juXx2fQHvtLyQNl
         nNrBKpQuyFodYJV4O7XBRp8E93kQOgr5XQC5t/MMq6qqleeHpRsdZYKLybkKys1YwSyx
         6uCiR4bUL1oLbmt3soAJKYL3GtHWcEcdLDnh6IbdN2HX1HirLhVyjtk0927YzoKhMlED
         Dfj0WI84IwcKXaEy63FlpLclR1QYL1ot2mq30BDzqeht3Re7XWK8PpZqV05hZtbyoXTg
         5EFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=17kyN4uG9zM2SVvBdFEN2V7gUNHA6vQ1r82uXAWSj1o=;
        b=WIlZ+vTpWB4RKdZPoqQlL8YFtdQjZ7h7leXPQeub+HihW00dJpBz4vI3nywaF51a8a
         lzhicRjS4ofIHuuxDqM3PSbP8H1YL6XJVWOqBEgQCWrJpr5YQc6WRCjworXeF9x0NylK
         kVnJNzw4n7n6fG/bSvKU6LOGPj55vMY3vMlvk9r8r9gJ49cIP2wuQ3JLM5Os/lXcgl4V
         to2iklJhxbqEoJObk1XLsrv4sACCxbOPDZfHRrVED+jCSZdsp+3j6Z7p3r+qfWdWnqml
         chn36WzJs2q0Dz6SnrBZBsA6hahcqHk6UI/S+zvS1Mc3QCbQzFJvbd30PSbZ7m2APsSi
         /4ig==
X-Gm-Message-State: AOAM5334ZNmbBf/DDQTEJSG0I5NmVZxo/rPmeyfN5VLJaxk4NBuNqmEr
        INLwz9S8Sn6Fdl00VNT4xVHJkdEE74A=
X-Google-Smtp-Source: ABdhPJyRddYlfHbfNdkN27rGvrVTPfiDI0aI8edr9xqULBIVvlp2o1a61xqKne+8Jn1dMR4bE2NHIg==
X-Received: by 2002:a5d:4d0b:: with SMTP id z11mr3865232wrt.315.1595509787450;
        Thu, 23 Jul 2020 06:09:47 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id w7sm3594632wmc.32.2020.07.23.06.09.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2020 06:09:46 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        sibis@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] arm64: dts: qcom: sdm845: Increase the number of interconnect cells
Date:   Thu, 23 Jul 2020 16:09:40 +0300
Message-Id: <20200723130942.28491-5-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723130942.28491-1-georgi.djakov@linaro.org>
References: <20200723130942.28491-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Increase the number of interconnect-cells, as now we can include
the tag information. The consumers can specify the path tag as an
additional argument to the endpoints.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 44 ++++++++++++++--------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index e506793407d8..94f5d27f2927 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -200,7 +200,7 @@ &LITTLE_CPU_SLEEP_1
 			dynamic-power-coefficient = <100>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc SLAVE_EBI1>,
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_0>;
@@ -225,7 +225,7 @@ &LITTLE_CPU_SLEEP_1
 			dynamic-power-coefficient = <100>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc SLAVE_EBI1>,
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_100>;
@@ -247,7 +247,7 @@ &LITTLE_CPU_SLEEP_1
 			dynamic-power-coefficient = <100>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc SLAVE_EBI1>,
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_200>;
@@ -269,7 +269,7 @@ &LITTLE_CPU_SLEEP_1
 			dynamic-power-coefficient = <100>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc SLAVE_EBI1>,
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_300>;
@@ -291,7 +291,7 @@ &BIG_CPU_SLEEP_1
 			dynamic-power-coefficient = <396>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
-			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc SLAVE_EBI1>,
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_400>;
@@ -313,7 +313,7 @@ &BIG_CPU_SLEEP_1
 			dynamic-power-coefficient = <396>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
-			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc SLAVE_EBI1>,
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_500>;
@@ -335,7 +335,7 @@ &BIG_CPU_SLEEP_1
 			dynamic-power-coefficient = <396>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
-			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc SLAVE_EBI1>,
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_600>;
@@ -357,7 +357,7 @@ &BIG_CPU_SLEEP_1
 			dynamic-power-coefficient = <396>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
-			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc SLAVE_EBI1>,
+			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_700>;
@@ -2011,49 +2011,49 @@ pcie1_lane: lanes@1c06200 {
 		mem_noc: interconnect@1380000 {
 			compatible = "qcom,sdm845-mem-noc";
 			reg = <0 0x01380000 0 0x27200>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		dc_noc: interconnect@14e0000 {
 			compatible = "qcom,sdm845-dc-noc";
 			reg = <0 0x014e0000 0 0x400>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		config_noc: interconnect@1500000 {
 			compatible = "qcom,sdm845-config-noc";
 			reg = <0 0x01500000 0 0x5080>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		system_noc: interconnect@1620000 {
 			compatible = "qcom,sdm845-system-noc";
 			reg = <0 0x01620000 0 0x18080>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		aggre1_noc: interconnect@16e0000 {
 			compatible = "qcom,sdm845-aggre1-noc";
 			reg = <0 0x016e0000 0 0x15080>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		aggre2_noc: interconnect@1700000 {
 			compatible = "qcom,sdm845-aggre2-noc";
 			reg = <0 0x01700000 0 0x1f300>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		mmss_noc: interconnect@1740000 {
 			compatible = "qcom,sdm845-mmss-noc";
 			reg = <0 0x01740000 0 0x1c100>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
@@ -2156,8 +2156,8 @@ ipa: ipa@1e40000 {
 			clocks = <&rpmhcc RPMH_IPA_CLK>;
 			clock-names = "core";
 
-			interconnects = <&aggre2_noc MASTER_IPA &mem_noc SLAVE_EBI1>,
-				        <&aggre2_noc MASTER_IPA &system_noc SLAVE_IMEM>,
+			interconnects = <&aggre2_noc MASTER_IPA 0 &mem_noc SLAVE_EBI1 0>,
+					<&aggre2_noc MASTER_IPA 0 &system_noc SLAVE_IMEM 0>,
 					<&gladiator_noc MASTER_APPSS_PROC &config_noc SLAVE_IPA_CFG>;
 			interconnect-names = "memory",
 					     "imem",
@@ -3561,8 +3561,8 @@ usb_1: usb@a6f8800 {
 
 			resets = <&gcc GCC_USB30_PRIM_BCR>;
 
-			interconnects = <&aggre2_noc MASTER_USB3_0 &mem_noc SLAVE_EBI1>,
-					<&gladiator_noc MASTER_APPSS_PROC &config_noc SLAVE_USB3_0>;
+			interconnects = <&aggre2_noc MASTER_USB3_0 0 &mem_noc SLAVE_EBI1 0>,
+					<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_0 0>;
 			interconnect-names = "usb-ddr", "apps-usb";
 
 			usb_1_dwc3: dwc3@a600000 {
@@ -3609,8 +3609,8 @@ usb_2: usb@a8f8800 {
 
 			resets = <&gcc GCC_USB30_SEC_BCR>;
 
-			interconnects = <&aggre2_noc MASTER_USB3_1 &mem_noc SLAVE_EBI1>,
-					<&gladiator_noc MASTER_APPSS_PROC &config_noc SLAVE_USB3_1>;
+			interconnects = <&aggre2_noc MASTER_USB3_1 0 &mem_noc SLAVE_EBI1 0>,
+					<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_1 0>;
 			interconnect-names = "usb-ddr", "apps-usb";
 
 			usb_2_dwc3: dwc3@a800000 {
@@ -4306,7 +4306,7 @@ lpasscc: clock-controller@17014000 {
 		gladiator_noc: interconnect@17900000 {
 			compatible = "qcom,sdm845-gladiator-noc";
 			reg = <0 0x17900000 0 0xd080>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
