Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E13744F65
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jul 2023 19:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjGBRvC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jul 2023 13:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjGBRvB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2023 13:51:01 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD034E66
        for <linux-pm@vger.kernel.org>; Sun,  2 Jul 2023 10:50:54 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb8574a3a1so5666978e87.1
        for <linux-pm@vger.kernel.org>; Sun, 02 Jul 2023 10:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688320253; x=1690912253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9c4FVrk3TOMJ6j16d6O+t5YuZj+ItNzqA8EFXL3KU4=;
        b=uh/4XzzKE/5XsID7kTOyWIoP8u1qc25TdfJ1rK4qsszQRHy+DxrxsmDfwLOMErmjRq
         gSySLRp5OWRprSPjR2f/oO9pfbobBmSSksyxsbTSKinSzaBG+CA0kYFd+qQ1KXO5Sovk
         Ek6IG0MTF2MfrkwYfClkyJ1Ckeqn4dz+pdPY+6ZWGazEqXzO800gV4H/uvrGV3IDHzQL
         LdwTHpkvWqtrq+Jk/8lojU1fy0Rlo5LIFUuY+T6aOHK96/0ya++94GHZn1niyW5uW+WP
         LMHs5+ROzW4Ifd1D67DNFm1nIne2QutqYqAE8Jx0/er7pXwyWNrxyfDgdk2ZEa4d8g1l
         exyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688320253; x=1690912253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9c4FVrk3TOMJ6j16d6O+t5YuZj+ItNzqA8EFXL3KU4=;
        b=kZeu5PyYmDSZXmEGUDBqlFnLRJN3CS9RRGyrU38FoNE5gyI6VJv0wrN8DijMqnqMVX
         fWN3DBIcLiDgVzkwuE6WvQK7JJ/TgNPN4skWKbds860NRyNiJbuLlgVrDkVRK4Pk0I7o
         5IujRIJE0ZpOp/88TA4gymoTvhCn1DgFSnR4WF89jP7qKhT3PrQZpk+Otx6gCjfoId4e
         8Z4osmShX89oDt4l7APjto0HGCFax12scI3EmZBpCXzF+QyCGX6VlnAYeVHsZZg2AM6R
         O7a2nDTbgbTBex2jYkJgnX01TcWFo0r7yX9k+rLrd8BzjOYaGUgjoPbGTYMSQ8BVHv4j
         VwPg==
X-Gm-Message-State: ABy/qLY5HLhumBPM0DkzaZPLkM0a4ox62df4Ycib90jd836WgHVxMNv9
        WCdo4yhCAeUYI7zzhWsaQJobdw==
X-Google-Smtp-Source: APBJJlEKHOsXd+51Th8sPvpetw4Vg+Hi18xf34lCm3nDuN/IKTHt3zqx6wMRvqWjRFR/i+EAMcowTA==
X-Received: by 2002:a05:6512:33c9:b0:4fb:5dd5:715c with SMTP id d9-20020a05651233c900b004fb5dd5715cmr7025921lfg.4.1688320252843;
        Sun, 02 Jul 2023 10:50:52 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id d1-20020ac24c81000000b004fb759964a9sm3354130lfl.168.2023.07.02.10.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 10:50:52 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [RFC PATCH 8/8] ARM: dts: qcom: apq8064: add simple CPUFreq support
Date:   Sun,  2 Jul 2023 20:50:45 +0300
Message-Id: <20230702175045.122041-9-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702175045.122041-1-dmitry.baryshkov@linaro.org>
References: <20230702175045.122041-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Declare CPU frequency-scaling properties. Each CPU has its own clock,
how all CPUs have the same OPP table. Voltage scaling is not (yet)
enabled with this patch. It will be enabled later.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-msm8960.dtsi | 147 +++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
index 48b3962dd4fb..995ea32f8d66 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/qcom,lcc-msm8960.h>
 #include <dt-bindings/mfd/qcom-rpm.h>
 #include <dt-bindings/soc/qcom,gsbi.h>
+#include <dt-bindings/soc/qcom,krait-l2-cache.h>
 
 / {
 	#address-cells = <1>;
@@ -29,6 +30,13 @@ cpu@0 {
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc0>;
 			qcom,saw = <&saw0>;
+			clocks = <&kraitcc KRAIT_CPU_0>;
+			clock-names = "cpu";
+			clock-latency = <100000>;
+			vdd-core-supply = <&saw0_vreg>;
+			interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@1 {
@@ -39,6 +47,13 @@ cpu@1 {
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc1>;
 			qcom,saw = <&saw1>;
+			clocks = <&kraitcc KRAIT_CPU_0>;
+			clock-names = "cpu";
+			clock-latency = <100000>;
+			vdd-core-supply = <&saw1_vreg>;
+			interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		L2: l2-cache {
@@ -169,6 +184,127 @@ opp-1350000000 {
 		};
 	};
 
+	cpu_opp_table: opp-table-cpu {
+		compatible = "operating-points-v2-krait-cpu";
+		nvmem-cells = <&speedbin_efuse>;
+
+		/*
+		 * Voltage thresholds are <target min max>
+		 */
+		opp-384000000 {
+			opp-hz = /bits/ 64 <384000000>;
+			opp-peak-kBps = <384000>;
+			opp-microvolt-speed0-pvs0 = <950000 950000 950000>;
+			opp-microvolt-speed0-pvs1 = <925000 900000 950000>;
+			opp-microvolt-speed0-pvs3 = <875000 850000 900000>;
+			opp-supported-hw = <0x1>;
+			/*
+			 * higher latency as it requires switching between
+			 * clock sources
+			 */
+			clock-latency-ns = <244144>;
+		};
+
+		opp-486000000 {
+			opp-hz = /bits/ 64 <486000000>;
+			opp-peak-kBps = <702000>;
+			opp-microvolt-speed0-pvs0 = <975000 975000 975000>;
+			opp-microvolt-speed0-pvs1 = <950000 925000 975000>;
+			opp-microvolt-speed0-pvs3 = <900000 875000 925000>;
+			opp-supported-hw = <0x1>;
+		};
+
+		opp-594000000 {
+			opp-hz = /bits/ 64 <594000000>;
+			opp-peak-kBps = <702000>;
+			opp-microvolt-speed0-pvs0 = <1000000 1000000 1000000>;
+			opp-microvolt-speed0-pvs1 = <975000 950000 1000000>;
+			opp-microvolt-speed0-pvs3 = <925000 900000 950000>;
+			opp-supported-hw = <0x1>;
+		};
+
+		opp-702000000 {
+			opp-hz = /bits/ 64 <702000000>;
+			opp-peak-kBps = <702000>;
+			opp-microvolt-speed0-pvs0 = <1025000 1025000 1025000>;
+			opp-microvolt-speed0-pvs1 = <1000000 975000 1025000>;
+			opp-microvolt-speed0-pvs3 = <950000 925000 975000>;
+			opp-supported-hw = <0x1>;
+		};
+
+		opp-810000000 {
+			opp-hz = /bits/ 64 <810000000>;
+			opp-peak-kBps = <702000>;
+			opp-microvolt-speed0-pvs0 = <1075000 1075000 1075000>;
+			opp-microvolt-speed0-pvs1 = <1050000 1025000 1075000>;
+			opp-microvolt-speed0-pvs3 = <1000000 975000 1025000>;
+			opp-supported-hw = <0x1>;
+		};
+
+		opp-918000000 {
+			opp-hz = /bits/ 64 <918000000>;
+			opp-peak-kBps = <702000>;
+			opp-microvolt-speed0-pvs0 = <1100000 1100000 1100000>;
+			opp-microvolt-speed0-pvs1 = <1075000 1050000 1100000>;
+			opp-microvolt-speed0-pvs3 = <1025000 1000000 1050000>;
+			opp-supported-hw = <0x1>;
+		};
+
+		opp-1026000000 {
+			opp-hz = /bits/ 64 <1026000000>;
+			opp-peak-kBps = <702000>;
+			opp-microvolt-speed0-pvs0 = <1125000 1125000 1125000>;
+			opp-microvolt-speed0-pvs1 = <1100000 1075000 1125000>;
+			opp-microvolt-speed0-pvs3 = <1050000 1025000 1075000>;
+			opp-supported-hw = <0x1>;
+		};
+
+		opp-1134000000 {
+			opp-hz = /bits/ 64 <1134000000>;
+			opp-peak-kBps = <1350000>;
+			opp-microvolt-speed0-pvs0 = <1175000 1175000 1175000>;
+			opp-microvolt-speed0-pvs1 = <1150000 1125000 1175000>;
+			opp-microvolt-speed0-pvs3 = <1100000 1075000 1125000>;
+			opp-supported-hw = <0x1>;
+		};
+
+		opp-1242000000 {
+			opp-hz = /bits/ 64 <1242000000>;
+			opp-peak-kBps = <1350000>;
+			opp-microvolt-speed0-pvs0 = <1200000 1200000 1200000>;
+			opp-microvolt-speed0-pvs1 = <1175000 1150000 1200000>;
+			opp-microvolt-speed0-pvs3 = <1125000 1100000 1150000>;
+			opp-supported-hw = <0x1>;
+		};
+
+		opp-1350000000 {
+			opp-hz = /bits/ 64 <1350000000>;
+			opp-peak-kBps = <1350000>;
+			opp-microvolt-speed0-pvs0 = <1225000 1225000 1225000>;
+			opp-microvolt-speed0-pvs1 = <1200000 1175000 1225000>;
+			opp-microvolt-speed0-pvs3 = <1150000 1125000 1175000>;
+			opp-supported-hw = <0x1>;
+		};
+
+		opp-1458000000 {
+			opp-hz = /bits/ 64 <1458000000>;
+			opp-peak-kBps = <1350000>;
+			opp-microvolt-speed0-pvs0 = <1237500 1237500 1237500>;
+			opp-microvolt-speed0-pvs1 = <1212500 1187500 1237500>;
+			opp-microvolt-speed0-pvs3 = <1162500 1137500 1187500>;
+			opp-supported-hw = <0x1>;
+		};
+
+		opp-1512000000 {
+			opp-hz = /bits/ 64 <1512000000>;
+			opp-peak-kBps = <1350000>;
+			opp-microvolt-speed0-pvs0 = <1250000 1250000 1250000>;
+			opp-microvolt-speed0-pvs1 = <1225000 1200000 1250000>;
+			opp-microvolt-speed0-pvs3 = <1175000 1150000 1200000>;
+			opp-supported-hw = <0x1>;
+		};
+	};
+
 	memory {
 		device_type = "memory";
 		reg = <0x0 0x0>;
@@ -266,6 +402,17 @@ msmgpio: pinctrl@800000 {
 			reg = <0x800000 0x4000>;
 		};
 
+		qfprom: qfprom@700000 {
+			compatible = "qcom,msm8960-qfprom", "qcom,qfprom";
+			reg = <0x00700000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			speedbin_efuse: speedbin@c0 {
+				reg = <0x0c0 0x4>;
+			};
+		};
+
 		gcc: clock-controller@900000 {
 			compatible = "qcom,gcc-msm8960";
 			#clock-cells = <1>;
-- 
2.39.2

