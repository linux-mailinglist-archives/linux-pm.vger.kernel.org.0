Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C937523DBCF
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 18:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgHFQdZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 12:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbgHFQcg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Aug 2020 12:32:36 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA378C02B8C8
        for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2020 09:31:38 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id p14so9389133wmg.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2020 09:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q/57p8pjM914Lcbk7bBCIqievLGqZS/SzbLkF/PRwXQ=;
        b=GaCQ8rthE/nMuAM5wV0kJwOUiCLiJ1O/PjmZ9cvtFRhp860Y/1KNLhsaWLlTmphvuz
         hlRMsnKPH/8Ao+JDlz11IKZSOWdyvyC6AYx38fj4JEnOzx/H35jIHKNco3qgooNf6Uvb
         xhs2iO49EjwQSkXwhCozPt0qoXrfd7UnL2WV/UivPQptYp3RU3hmcqGZNscaKO5VCYrd
         S95FKZ5yKa45pkdIe0lDqgYMq9TR7xk1tXXuzrCYIwcckD3XTR1W4d0aTHG/V9+Wbx5W
         Cft02o6noz4dfOnAGO0nM72mE/atmPZhCwnz7Dq5+RBoAacsJQj7S+4JGWLqrzlabLXI
         Usqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q/57p8pjM914Lcbk7bBCIqievLGqZS/SzbLkF/PRwXQ=;
        b=eSRDbnyKa5nAzHAhbCVTATrXIeZheYufW0HR5puNgPzJ9lKhMOr2Vw6IcHt4oYtCw1
         cmoSNRSv7ammG0VmwqcQ1sBU6ufH7JtlrMFf5C3XAI7nZ+c9GRMcfrfN+Jf5Rqst+gtz
         B1Pc7iUdMj9OnipZ6777Mz4rjIbYoph+ERo08xpjNQaufiWZc7EZcMKbeLDE215i4JLp
         mn1BIhAP+iajNvEYMZadS3Taaxk4z8eyyfghpDXmoyDW5uQ/mN/IUowuqg4ICiwDJRjX
         8VBjsGZmg5/O4Gnd+PkmE+BYQJ6PW/8T9kHmiOQ3j2TXZhB6xOqCKfYSqfk3nBH+FGMJ
         AusA==
X-Gm-Message-State: AOAM530ZeM9UNxCgMOOM/dgRy1Gs5KmNg1txl+A8uvNgEKNWapskcd+r
        gsJetvRVSFI/KGt6wdTho7a6t7vvkjQ=
X-Google-Smtp-Source: ABdhPJxAesQbqbXg5mCZ+OU1K2tf6BHYH72efs+8li0fTcb6bfdNUKOyz5yU/K/UYMHymreyNE9JaQ==
X-Received: by 2002:a1c:8094:: with SMTP id b142mr9284568wmd.59.1596731496969;
        Thu, 06 Aug 2020 09:31:36 -0700 (PDT)
Received: from localhost.localdomain ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id i66sm7468537wma.35.2020.08.06.09.31.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Aug 2020 09:31:36 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, bjorn.andersson@linaro.org,
        sibis@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] arm64: dts: qcom: sdm845: Increase the number of interconnect cells
Date:   Thu,  6 Aug 2020 19:31:24 +0300
Message-Id: <20200806163126.22667-6-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200806163126.22667-1-georgi.djakov@linaro.org>
References: <20200806163126.22667-1-georgi.djakov@linaro.org>
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
 
