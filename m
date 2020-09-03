Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6FA25C478
	for <lists+linux-pm@lfdr.de>; Thu,  3 Sep 2020 17:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgICPLE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Sep 2020 11:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbgICN5y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2020 09:57:54 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280A8C061A01
        for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2020 06:31:45 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v4so2899181wmj.5
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2020 06:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uz4Jw+zKdFJ0416tNACRop3YdQEnLlXpW/XophXNKMc=;
        b=SsJ+pR+jva11YMNYXuR8oKRz3WkjfDu0N2/d1aBy3h3hrm7VEI8InTw0eMtSsOHgyu
         MzWwXYA11zNdok0KLUzWuTw14F3zPuhNNIVOtN+Az/NGR8ltkOdMawjTB80Wv0qgTKLm
         8Q/B7J7qKDDjV46D4v7vn0X6K5GWf97hKFgKJOA0y/3Ud8XypXCmY7yY+zMwfK4NCjGp
         onI2tSuL8PJJnsGGX9PGWb3jbnRwFO9ZR5rxaAJtZ0ghiE7L4RpAtWfXO+VWpfDCgRWE
         EGYt3RaMCZ1IQLTHE5TBzew0hFAnVFz/ah2tM8QQOM8r2EktwqxZ/UP8O2enS0MttAZp
         jItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uz4Jw+zKdFJ0416tNACRop3YdQEnLlXpW/XophXNKMc=;
        b=E5+9K9sqw6dEsZTl/fXORwjqy29QQTF/6f0MzmzkMkkYbjrLKYYSvC1UbGtUNFmGGV
         aE7jOHtomZrcy7nUpPn/dhYWzEsrhN84vCiWgnXksPc9kC4wb5cwYUXX7lJ0Fbho39eq
         /XsCn1cGpdDFMCY27JyIk1RoM7hk7wjf7Y0YfFBDpEzXlEXBd/fd+TpoTxB/PNh5ptht
         tWGZ/jCf0SU3WgIPi/E4zqn0EsE62r8AjaKTIKB0PvR687reQQr0Nb0l3J0slKuCKXqm
         RJXa6GCw87ZPOfdtKcJZjITRiMafgzJUUYIEuy/5jP1yPc+J9OSAGg1RevIvJVRmGGWV
         Bg9Q==
X-Gm-Message-State: AOAM5301XR0LP+1kQgp7uV+6qpmzRp4qOQ8vNeQcjIYK0EovaTBvi6VP
        ER7t9jJxhZRTibU80dmqOBaFlzSHkvuHSg==
X-Google-Smtp-Source: ABdhPJxaF4E+1j0XqyCtqYw54pZtJdjO9j2lnQ6PJO6Azl5mINnM05AxHMUeDBjRV0V0132YGxxFWg==
X-Received: by 2002:a7b:c1d4:: with SMTP id a20mr2600512wmj.30.1599139903444;
        Thu, 03 Sep 2020 06:31:43 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id b2sm4310768wmh.47.2020.09.03.06.31.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2020 06:31:42 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, bjorn.andersson@linaro.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        sibis@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/7] arm64: dts: qcom: sdm845: Increase the number of interconnect cells
Date:   Thu,  3 Sep 2020 16:31:32 +0300
Message-Id: <20200903133134.17201-6-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200903133134.17201-1-georgi.djakov@linaro.org>
References: <20200903133134.17201-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Increase the number of interconnect-cells, as now we can include
the tag information. The consumers can specify the path tag as an
additional argument to the endpoints.

Tested-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 48 ++++++++++++++--------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 2884577dcb77..253d95f43152 100644
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
 
@@ -2156,9 +2156,9 @@ ipa: ipa@1e40000 {
 			clocks = <&rpmhcc RPMH_IPA_CLK>;
 			clock-names = "core";
 
-			interconnects = <&aggre2_noc MASTER_IPA &mem_noc SLAVE_EBI1>,
-				        <&aggre2_noc MASTER_IPA &system_noc SLAVE_IMEM>,
-					<&gladiator_noc MASTER_APPSS_PROC &config_noc SLAVE_IPA_CFG>;
+			interconnects = <&aggre2_noc MASTER_IPA 0 &mem_noc SLAVE_EBI1 0>,
+					<&aggre2_noc MASTER_IPA 0 &system_noc SLAVE_IMEM 0>,
+					<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_IPA_CFG 0>;
 			interconnect-names = "memory",
 					     "imem",
 					     "config";
@@ -3569,8 +3569,8 @@ usb_1: usb@a6f8800 {
 
 			resets = <&gcc GCC_USB30_PRIM_BCR>;
 
-			interconnects = <&aggre2_noc MASTER_USB3_0 &mem_noc SLAVE_EBI1>,
-					<&gladiator_noc MASTER_APPSS_PROC &config_noc SLAVE_USB3_0>;
+			interconnects = <&aggre2_noc MASTER_USB3_0 0 &mem_noc SLAVE_EBI1 0>,
+					<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_0 0>;
 			interconnect-names = "usb-ddr", "apps-usb";
 
 			usb_1_dwc3: dwc3@a600000 {
@@ -3617,8 +3617,8 @@ usb_2: usb@a8f8800 {
 
 			resets = <&gcc GCC_USB30_SEC_BCR>;
 
-			interconnects = <&aggre2_noc MASTER_USB3_1 &mem_noc SLAVE_EBI1>,
-					<&gladiator_noc MASTER_APPSS_PROC &config_noc SLAVE_USB3_1>;
+			interconnects = <&aggre2_noc MASTER_USB3_1 0 &mem_noc SLAVE_EBI1 0>,
+					<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_1 0>;
 			interconnect-names = "usb-ddr", "apps-usb";
 
 			usb_2_dwc3: dwc3@a800000 {
@@ -4007,7 +4007,7 @@ gpu: gpu@5000000 {
 
 			qcom,gmu = <&gmu>;
 
-			interconnects = <&mem_noc MASTER_GFX3D &mem_noc SLAVE_EBI1>;
+			interconnects = <&mem_noc MASTER_GFX3D 0 &mem_noc SLAVE_EBI1 0>;
 			interconnect-names = "gfx-mem";
 
 			gpu_opp_table: opp-table {
@@ -4324,7 +4324,7 @@ lpasscc: clock-controller@17014000 {
 		gladiator_noc: interconnect@17900000 {
 			compatible = "qcom,sdm845-gladiator-noc";
 			reg = <0 0x17900000 0 0xd080>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
