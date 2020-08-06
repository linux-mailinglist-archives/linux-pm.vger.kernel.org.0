Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB1523DBD4
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 18:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgHFQeA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 12:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbgHFQcu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Aug 2020 12:32:50 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2FFC02B8CE
        for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2020 09:31:42 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id t14so10280587wmi.3
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2020 09:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o1DNwHTB2pSgb5a7fFbiP5awwGwo+okHpDOnTZRVZoI=;
        b=aIa+XZ8fqPjIS9AouQP4eiN4SFZhfXTUOkTrRD1FPOJ4S5MkJfuK2bwzAKaFLrMzTj
         Nsvdy3JqD3GuQbemBxQJR7fhGd7iPv3Mppe1AuP588yc/DHwIE4W00EYQOmUVxlO9kHm
         0XrPl1B5X2QP7zCwdlr4ArJeHM3mPuA24r6zYSXa2XyObeRsGSOKEVvR1VuRVpwDBhn/
         AruTKO7OjaSFU5PncM9pz0zcPTqJ8CxQ2Hft9JhtXdW0HKZvmztaYNIZjx/3cfCO+9FN
         7fOk7iFciV8t6+r904epPXA/fpFnuYCa17zSgLLoLWolIHXBTeRys84lw418k9XwOf8Y
         Z0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o1DNwHTB2pSgb5a7fFbiP5awwGwo+okHpDOnTZRVZoI=;
        b=pALi+elYhc3CnzNBY5zwgZNCZpDfoytO+sYIXscEPaZRqib2SQI1lV3DFojyzWagr4
         wbjlim4RrfxHbIlpIrVB1vUvDEVe22PWI5rv0rYcWBFF+F1LBNtjaoe8XmLY6KybXgp/
         kZ1hIzbNz2YYCnNb07d7cgoVoQ5ZzGZpRxGvg/H/KbxuCfx/cJB38FhustfGOOL+lUWy
         /1N3TWjZGsYip96hQNPYUnym6naLPpUajNKHaOkEZKJOZnPvzojVF2uI9Y0Tks1t+iwT
         mkMUHU6LrP9SHfjP5PsV1fqhZ/j0nXKd0svplBxkanKCL+0HRQO3Dy7pvezjLiCbLFLw
         rOUQ==
X-Gm-Message-State: AOAM531YCFzLzxtnBnpkONDo6fCs+Oyxsa78456JnKzgQpsirdqVk4+z
        eqrYFSPp7+Q50+zmj/mIq76c7uN2Qc0=
X-Google-Smtp-Source: ABdhPJyLvwNgomKblok9MgnNW4QDS+6bTNt98cxnKLNyNI5ssODvfWe7+i/O/u82e+Gkz18HqycWGA==
X-Received: by 2002:a1c:ba84:: with SMTP id k126mr9225917wmf.55.1596731500024;
        Thu, 06 Aug 2020 09:31:40 -0700 (PDT)
Received: from localhost.localdomain ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id i66sm7468537wma.35.2020.08.06.09.31.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Aug 2020 09:31:39 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, bjorn.andersson@linaro.org,
        sibis@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] arm64: dts: qcom: sc7180: Increase the number of interconnect cells
Date:   Thu,  6 Aug 2020 19:31:26 +0300
Message-Id: <20200806163126.22667-8-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200806163126.22667-1-georgi.djakov@linaro.org>
References: <20200806163126.22667-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Sibi Sankar <sibis@codeaurora.org>

Increase the number of interconnect-cells, as now we can include
the tag information. The consumers can specify the path tag as an
additional argument to the endpoints.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 216 +++++++++++++--------------
 1 file changed, 108 insertions(+), 108 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 16df08d9ef8f..fe80e1b8acee 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -132,7 +132,7 @@ &LITTLE_CPU_SLEEP_1
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&gem_noc MASTER_APPSS_PROC &mc_virt SLAVE_EBI1>,
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			next-level-cache = <&L2_0>;
 			#cooling-cells = <2>;
@@ -158,7 +158,7 @@ &LITTLE_CPU_SLEEP_1
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_100>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&gem_noc MASTER_APPSS_PROC &mc_virt SLAVE_EBI1>,
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -180,7 +180,7 @@ &LITTLE_CPU_SLEEP_1
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_200>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&gem_noc MASTER_APPSS_PROC &mc_virt SLAVE_EBI1>,
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -202,7 +202,7 @@ &LITTLE_CPU_SLEEP_1
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_300>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&gem_noc MASTER_APPSS_PROC &mc_virt SLAVE_EBI1>,
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -224,7 +224,7 @@ &LITTLE_CPU_SLEEP_1
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_400>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&gem_noc MASTER_APPSS_PROC &mc_virt SLAVE_EBI1>,
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -246,7 +246,7 @@ &LITTLE_CPU_SLEEP_1
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_500>;
 			operating-points-v2 = <&cpu0_opp_table>;
-			interconnects = <&gem_noc MASTER_APPSS_PROC &mc_virt SLAVE_EBI1>,
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -268,7 +268,7 @@ &BIG_CPU_SLEEP_1
 			dynamic-power-coefficient = <405>;
 			next-level-cache = <&L2_600>;
 			operating-points-v2 = <&cpu6_opp_table>;
-			interconnects = <&gem_noc MASTER_APPSS_PROC &mc_virt SLAVE_EBI1>,
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
@@ -290,7 +290,7 @@ &BIG_CPU_SLEEP_1
 			dynamic-power-coefficient = <405>;
 			next-level-cache = <&L2_700>;
 			operating-points-v2 = <&cpu6_opp_table>;
-			interconnects = <&gem_noc MASTER_APPSS_PROC &mc_virt SLAVE_EBI1>,
+			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
@@ -742,7 +742,7 @@ qupv3_id_0: geniqup@8c0000 {
 			#size-cells = <2>;
 			ranges;
 			iommus = <&apps_smmu 0x43 0x0>;
-			interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>;
+			interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>;
 			interconnect-names = "qup-core";
 			status = "disabled";
 
@@ -756,9 +756,9 @@ i2c0: i2c@880000 {
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>,
-						<&aggre1_noc MASTER_QUP_0 &mc_virt SLAVE_EBI1>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
+						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
 				status = "disabled";
@@ -776,8 +776,8 @@ spi0: spi@880000 {
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SC7180_CX>;
 				operating-points-v2 = <&qup_opp_table>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
 				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
@@ -792,8 +792,8 @@ uart0: serial@880000 {
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SC7180_CX>;
 				operating-points-v2 = <&qup_opp_table>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
 				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
@@ -808,9 +808,9 @@ i2c1: i2c@884000 {
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>,
-						<&aggre1_noc MASTER_QUP_0 &mc_virt SLAVE_EBI1>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
+						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
 				status = "disabled";
@@ -828,8 +828,8 @@ spi1: spi@884000 {
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SC7180_CX>;
 				operating-points-v2 = <&qup_opp_table>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
 				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
@@ -844,8 +844,8 @@ uart1: serial@884000 {
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SC7180_CX>;
 				operating-points-v2 = <&qup_opp_table>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
 				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
@@ -860,9 +860,9 @@ i2c2: i2c@888000 {
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>,
-						<&aggre1_noc MASTER_QUP_0 &mc_virt SLAVE_EBI1>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
+						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
 				status = "disabled";
@@ -878,8 +878,8 @@ uart2: serial@888000 {
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SC7180_CX>;
 				operating-points-v2 = <&qup_opp_table>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
 				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
@@ -894,9 +894,9 @@ i2c3: i2c@88c000 {
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>,
-						<&aggre1_noc MASTER_QUP_0 &mc_virt SLAVE_EBI1>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
+						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
 				status = "disabled";
@@ -914,8 +914,8 @@ spi3: spi@88c000 {
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SC7180_CX>;
 				operating-points-v2 = <&qup_opp_table>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
 				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
@@ -930,8 +930,8 @@ uart3: serial@88c000 {
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SC7180_CX>;
 				operating-points-v2 = <&qup_opp_table>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
 				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
@@ -946,9 +946,9 @@ i2c4: i2c@890000 {
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>,
-						<&aggre1_noc MASTER_QUP_0 &mc_virt SLAVE_EBI1>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
+						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
 				status = "disabled";
@@ -964,8 +964,8 @@ uart4: serial@890000 {
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SC7180_CX>;
 				operating-points-v2 = <&qup_opp_table>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
 				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
@@ -980,9 +980,9 @@ i2c5: i2c@894000 {
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>,
-						<&aggre1_noc MASTER_QUP_0 &mc_virt SLAVE_EBI1>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
+						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
 				status = "disabled";
@@ -1000,8 +1000,8 @@ spi5: spi@894000 {
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SC7180_CX>;
 				operating-points-v2 = <&qup_opp_table>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
 				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
@@ -1016,8 +1016,8 @@ uart5: serial@894000 {
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SC7180_CX>;
 				operating-points-v2 = <&qup_opp_table>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
 				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
@@ -1033,7 +1033,7 @@ qupv3_id_1: geniqup@ac0000 {
 			#size-cells = <2>;
 			ranges;
 			iommus = <&apps_smmu 0x4c3 0x0>;
-			interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>;
+			interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>;
 			interconnect-names = "qup-core";
 			status = "disabled";
 
@@ -1047,9 +1047,9 @@ i2c6: i2c@a80000 {
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>,
-						<&aggre2_noc MASTER_QUP_1 &mc_virt SLAVE_EBI1>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
 				status = "disabled";
@@ -1067,8 +1067,8 @@ spi6: spi@a80000 {
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SC7180_CX>;
 				operating-points-v2 = <&qup_opp_table>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>;
 				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
@@ -1083,8 +1083,8 @@ uart6: serial@a80000 {
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SC7180_CX>;
 				operating-points-v2 = <&qup_opp_table>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>;
 				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
@@ -1099,9 +1099,9 @@ i2c7: i2c@a84000 {
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>,
-						<&aggre2_noc MASTER_QUP_1 &mc_virt SLAVE_EBI1>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
 				status = "disabled";
@@ -1117,8 +1117,8 @@ uart7: serial@a84000 {
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SC7180_CX>;
 				operating-points-v2 = <&qup_opp_table>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>;
 				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
@@ -1133,9 +1133,9 @@ i2c8: i2c@a88000 {
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>,
-						<&aggre2_noc MASTER_QUP_1 &mc_virt SLAVE_EBI1>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
 				status = "disabled";
@@ -1153,8 +1153,8 @@ spi8: spi@a88000 {
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SC7180_CX>;
 				operating-points-v2 = <&qup_opp_table>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>;
 				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
@@ -1169,8 +1169,8 @@ uart8: serial@a88000 {
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SC7180_CX>;
 				operating-points-v2 = <&qup_opp_table>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>;
 				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
@@ -1185,9 +1185,9 @@ i2c9: i2c@a8c000 {
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>,
-						<&aggre2_noc MASTER_QUP_1 &mc_virt SLAVE_EBI1>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
 				status = "disabled";
@@ -1203,8 +1203,8 @@ uart9: serial@a8c000 {
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SC7180_CX>;
 				operating-points-v2 = <&qup_opp_table>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>;
 				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
@@ -1219,9 +1219,9 @@ i2c10: i2c@a90000 {
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>,
-						<&aggre2_noc MASTER_QUP_1 &mc_virt SLAVE_EBI1>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
 				status = "disabled";
@@ -1239,8 +1239,8 @@ spi10: spi@a90000 {
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SC7180_CX>;
 				operating-points-v2 = <&qup_opp_table>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>;
 				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
@@ -1255,8 +1255,8 @@ uart10: serial@a90000 {
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SC7180_CX>;
 				operating-points-v2 = <&qup_opp_table>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>;
 				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
@@ -1271,9 +1271,9 @@ i2c11: i2c@a94000 {
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>,
-						<&aggre2_noc MASTER_QUP_1 &mc_virt SLAVE_EBI1>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
 				status = "disabled";
@@ -1291,8 +1291,8 @@ spi11: spi@a94000 {
 				#size-cells = <0>;
 				power-domains = <&rpmhpd SC7180_CX>;
 				operating-points-v2 = <&qup_opp_table>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>;
 				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
@@ -1307,8 +1307,8 @@ uart11: serial@a94000 {
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&rpmhpd SC7180_CX>;
 				operating-points-v2 = <&qup_opp_table>;
-				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
-						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>;
 				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
@@ -1317,63 +1317,63 @@ uart11: serial@a94000 {
 		config_noc: interconnect@1500000 {
 			compatible = "qcom,sc7180-config-noc";
 			reg = <0 0x01500000 0 0x28000>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		system_noc: interconnect@1620000 {
 			compatible = "qcom,sc7180-system-noc";
 			reg = <0 0x01620000 0 0x17080>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		mc_virt: interconnect@1638000 {
 			compatible = "qcom,sc7180-mc-virt";
 			reg = <0 0x01638000 0 0x1000>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		qup_virt: interconnect@1650000 {
 			compatible = "qcom,sc7180-qup-virt";
 			reg = <0 0x01650000 0 0x1000>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		aggre1_noc: interconnect@16e0000 {
 			compatible = "qcom,sc7180-aggre1-noc";
 			reg = <0 0x016e0000 0 0x15080>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		aggre2_noc: interconnect@1705000 {
 			compatible = "qcom,sc7180-aggre2-noc";
 			reg = <0 0x01705000 0 0x9000>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		compute_noc: interconnect@170e000 {
 			compatible = "qcom,sc7180-compute-noc";
 			reg = <0 0x0170e000 0 0x6000>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		mmss_noc: interconnect@1740000 {
 			compatible = "qcom,sc7180-mmss-noc";
 			reg = <0 0x01740000 0 0x1c100>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		ipa_virt: interconnect@1e00000 {
 			compatible = "qcom,sc7180-ipa-virt";
 			reg = <0 0x01e00000 0 0x1000>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
@@ -1400,9 +1400,9 @@ ipa: ipa@1e40000 {
 			clocks = <&rpmhcc RPMH_IPA_CLK>;
 			clock-names = "core";
 
-			interconnects = <&aggre2_noc MASTER_IPA &mc_virt SLAVE_EBI1>,
-				        <&aggre2_noc MASTER_IPA &system_noc SLAVE_IMEM>,
-					<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_IPA_CFG>;
+			interconnects = <&aggre2_noc MASTER_IPA 0 &mc_virt SLAVE_EBI1 0>,
+					<&aggre2_noc MASTER_IPA 0 &system_noc SLAVE_IMEM 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_IPA_CFG 0>;
 			interconnect-names = "memory",
 					     "imem",
 					     "config";
@@ -2526,8 +2526,8 @@ qspi: spi@88dc000 {
 			clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
 				 <&gcc GCC_QSPI_CORE_CLK>;
 			clock-names = "iface", "core";
-			interconnects = <&gem_noc MASTER_APPSS_PROC
-					&config_noc SLAVE_QSPI_0>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC 0
+					&config_noc SLAVE_QSPI_0 0>;
 			interconnect-names = "qspi-config";
 			power-domains = <&rpmhpd SC7180_CX>;
 			operating-points-v2 = <&qspi_opp_table>;
@@ -2586,7 +2586,7 @@ usb_1_ssphy: phy@88e9200 {
 		dc_noc: interconnect@9160000 {
 			compatible = "qcom,sc7180-dc-noc";
 			reg = <0 0x09160000 0 0x03200>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
@@ -2600,14 +2600,14 @@ system-cache-controller@9200000 {
 		gem_noc: interconnect@9680000 {
 			compatible = "qcom,sc7180-gem-noc";
 			reg = <0 0x09680000 0 0x3e200>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		npu_noc: interconnect@9990000 {
 			compatible = "qcom,sc7180-npu-noc";
 			reg = <0 0x09990000 0 0x1600>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
@@ -2643,8 +2643,8 @@ usb_1: usb@a6f8800 {
 
 			resets = <&gcc GCC_USB30_PRIM_BCR>;
 
-			interconnects = <&aggre2_noc MASTER_USB3 &mc_virt SLAVE_EBI1>,
-					<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_USB3>;
+			interconnects = <&aggre2_noc MASTER_USB3 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3 0>;
 			interconnect-names = "usb-ddr", "apps-usb";
 
 			usb_1_dwc3: dwc3@a600000 {
@@ -2675,8 +2675,8 @@ venus: video-codec@aa00000 {
 				      "vcodec0_core", "vcodec0_bus";
 			iommus = <&apps_smmu 0x0c00 0x60>;
 			memory-region = <&venus_mem>;
-			interconnects = <&mmss_noc MASTER_VIDEO_P0 &mc_virt SLAVE_EBI1>,
-					<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_VENUS_CFG>;
+			interconnects = <&mmss_noc MASTER_VIDEO_P0 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_VENUS_CFG 0>;
 			interconnect-names = "video-mem", "cpu-cfg";
 
 			video-decoder {
@@ -2701,7 +2701,7 @@ videocc: clock-controller@ab00000 {
 		camnoc_virt: interconnect@ac00000 {
 			compatible = "qcom,sc7180-camnoc-virt";
 			reg = <0 0x0ac00000 0 0x1000>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
