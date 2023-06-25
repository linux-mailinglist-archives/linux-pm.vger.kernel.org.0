Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0812573D3F5
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jun 2023 22:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjFYU0O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Jun 2023 16:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjFYU0N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jun 2023 16:26:13 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F269B
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 13:26:06 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f86e6e4038so3164032e87.0
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 13:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687724764; x=1690316764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5qHM2ykXVc0w8F+Te8LVGAorPiLDJCJkk3Ysi3GdZo=;
        b=j5FeKAyvoME6jxu2AwKR9p7PPNsSb0C9tWE/HC4xJbOVUcvfy5mCiL28Psy+S0FE86
         xlBhxnz6N2qfEz+FQoR3L/wbmJ7V0C4aCyxDLDUpWkCgokvNVxCt0SAH1id8hUHibW9B
         6SfQSUZGnnKIgOFvdeQmi5wc9Qz1doinV+vNRyWeaSfe9MHOvB/D+i55lAO531ZKZzB/
         IzOThIiMaUi8fP7OUnOwvg2nx6TLwFuba16XzhtITSseUXaaOOitbzVOlXXFWjpKXdbg
         aeME7oEtbqjsBgmUa7jjkFjAzhYEDY5lJwM3B5jxtV2Xrosf2RQVSdR0Oyi6kxUSSNUj
         Anzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687724764; x=1690316764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5qHM2ykXVc0w8F+Te8LVGAorPiLDJCJkk3Ysi3GdZo=;
        b=NO+YNVrrwhiBsyorEVnnuo3p1NGyH4NTiOWlqsO1M+/QeTTnXDwWpcpUbnWLfmFAOo
         p7RZ9VMwFI/dJALu96SHO8QKSIHVC+7C1/5/tHP4geI7JlTL4+VLVedzANHWt3LqVMTI
         JLJanm2b2sBr6VSYdKTdgD+3LJrPzpXtjWee0+Wi148/x3OdJ+uqOiYjneGjIxTDCW5X
         HplYqNbi/yJnyxPMrhZAZJnYBdHQ1aQZjIm8d7jRTfuOVekZ0KPfMqGbfmVsSdHOLUug
         uTfH8mjUiRRdJRFVBXvl8LhBUFHvx3hWLcEUEx7DqhDYtcGYaFQgYaAnASJohlfOeGUX
         eK1A==
X-Gm-Message-State: AC+VfDyLkTQ71/8RSfokJz6kZLQDd3ax+nebSWo4+NFumocp752HePha
        gkIsi6ffPw4qe7K8F3d3rXfTXw==
X-Google-Smtp-Source: ACHHUZ6X0o7Ix7Fdd1p8brtCN86rRc24rvlLIPd1Eiir9E9DK8HTZaxkLyhmylU66kG/KDQ3EzMcAw==
X-Received: by 2002:a05:6512:2346:b0:4f6:1307:80b0 with SMTP id p6-20020a056512234600b004f6130780b0mr12529548lfu.12.1687724764731;
        Sun, 25 Jun 2023 13:26:04 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id m21-20020a195215000000b004f8427f8716sm787537lfb.262.2023.06.25.13.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 13:26:04 -0700 (PDT)
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
Subject: [PATCH v2 17/26] ARM: dts: qcom: apq8064: add simple CPUFreq support
Date:   Sun, 25 Jun 2023 23:25:38 +0300
Message-Id: <20230625202547.174647-18-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
References: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 170 +++++++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index ac07170c702f..e4d2fd48d843 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -2,11 +2,13 @@
 /dts-v1/;
 
 #include <dt-bindings/clock/qcom,gcc-msm8960.h>
+#include <dt-bindings/clock/qcom,krait-cc.h>
 #include <dt-bindings/clock/qcom,lcc-msm8960.h>
 #include <dt-bindings/reset/qcom,gcc-msm8960.h>
 #include <dt-bindings/clock/qcom,mmcc-msm8960.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/soc/qcom,gsbi.h>
+#include <dt-bindings/soc/qcom,krait-l2-cache.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 / {
@@ -45,6 +47,12 @@ CPU0: cpu@0 {
 			qcom,acc = <&acc0>;
 			qcom,saw = <&saw0>;
 			cpu-idle-states = <&CPU_SPC>;
+			clocks = <&kraitcc KRAIT_CPU_0>;
+			clock-names = "cpu";
+			clock-latency = <100000>;
+			interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		CPU1: cpu@1 {
@@ -56,6 +64,12 @@ CPU1: cpu@1 {
 			qcom,acc = <&acc1>;
 			qcom,saw = <&saw1>;
 			cpu-idle-states = <&CPU_SPC>;
+			clocks = <&kraitcc KRAIT_CPU_1>;
+			clock-names = "cpu";
+			clock-latency = <100000>;
+			interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		CPU2: cpu@2 {
@@ -67,6 +81,12 @@ CPU2: cpu@2 {
 			qcom,acc = <&acc2>;
 			qcom,saw = <&saw2>;
 			cpu-idle-states = <&CPU_SPC>;
+			clocks = <&kraitcc KRAIT_CPU_2>;
+			clock-names = "cpu";
+			clock-latency = <100000>;
+			interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		CPU3: cpu@3 {
@@ -78,6 +98,12 @@ CPU3: cpu@3 {
 			qcom,acc = <&acc3>;
 			qcom,saw = <&saw3>;
 			cpu-idle-states = <&CPU_SPC>;
+			clocks = <&kraitcc KRAIT_CPU_3>;
+			clock-names = "cpu";
+			clock-latency = <100000>;
+			interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		L2: l2-cache {
@@ -196,6 +222,121 @@ CPU_SPC: spc {
 		};
 	};
 
+        cpu_opp_table: opp-table-cpu {
+		compatible = "operating-points-v2-krait-cpu";
+		nvmem-cells = <&speedbin_efuse>;
+
+		/*
+		 * Voltage thresholds are <target min max>
+		 */
+		opp-384000000 {
+			opp-hz = /bits/ 64 <384000000>;
+			opp-peak-kBps = <384000>;
+			opp-supported-hw = <0x4007>;
+			/*
+			 * higher latency as it requires switching between
+			 * clock sources
+			 */
+			clock-latency-ns = <244144>;
+		};
+
+		opp-486000000 {
+			opp-hz = /bits/ 64 <486000000>;
+			opp-peak-kBps = <648000>;
+			opp-supported-hw = <0x4007>;
+		};
+
+		opp-594000000 {
+			opp-hz = /bits/ 64 <594000000>;
+			opp-peak-kBps = <648000>;
+			opp-supported-hw = <0x4007>;
+		};
+
+		opp-702000000 {
+			opp-hz = /bits/ 64 <702000000>;
+			opp-peak-kBps = <648000>;
+			opp-supported-hw = <0x4007>;
+		};
+
+		opp-810000000 {
+			opp-hz = /bits/ 64 <810000000>;
+			opp-peak-kBps = <648000>;
+			opp-supported-hw = <0x4007>;
+		};
+
+		opp-918000000 {
+			opp-hz = /bits/ 64 <918000000>;
+			opp-peak-kBps = <648000>;
+			opp-supported-hw = <0x4007>;
+		};
+
+		opp-1026000000 {
+			opp-hz = /bits/ 64 <1026000000>;
+			opp-peak-kBps = <648000>;
+			opp-supported-hw = <0x4007>;
+		};
+
+		opp-1134000000 {
+			opp-hz = /bits/ 64 <1134000000>;
+			opp-peak-kBps = <1134000>;
+			opp-supported-hw = <0x4007>;
+		};
+
+		opp-1242000000 {
+			opp-hz = /bits/ 64 <1242000000>;
+			opp-peak-kBps = <1134000>;
+			opp-supported-hw = <0x4007>;
+		};
+
+		opp-1350000000 {
+			opp-hz = /bits/ 64 <1350000000>;
+			opp-peak-kBps = <1134000>;
+			opp-supported-hw = <0x4007>;
+		};
+
+		opp-1458000000 {
+			opp-hz = /bits/ 64 <1458000000>;
+			opp-peak-kBps = <1134000>;
+			opp-supported-hw = <0x4007>;
+		};
+
+		opp-1512000000 {
+			opp-hz = /bits/ 64 <1512000000>;
+			opp-peak-kBps = <1134000>;
+			opp-supported-hw = <0x4001>;
+		};
+
+		opp-1566000000 {
+			opp-hz = /bits/ 64 <1566000000>;
+			opp-peak-kBps = <1134000>;
+			opp-supported-hw = <0x06>;
+		};
+
+		opp-1674000000 {
+			opp-hz = /bits/ 64 <1674000000>;
+			opp-peak-kBps = <1134000>;
+			opp-supported-hw = <0x06>;
+		};
+
+		opp-1728000000 {
+			opp-hz = /bits/ 64 <1728000000>;
+			opp-peak-kBps = <1134000>;
+			opp-supported-hw = <0x02>;
+		};
+
+		opp-1782000000 {
+			opp-hz = /bits/ 64 <1782000000>;
+			opp-peak-kBps = <1134000>;
+			opp-supported-hw = <0x04>;
+		};
+
+		opp-1890000000 {
+			opp-hz = /bits/ 64 <1890000000>;
+			opp-peak-kBps = <1134000>;
+			opp-supported-hw = <0x04>;
+		};
+	};
+
 	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0>;
@@ -312,6 +453,32 @@ sleep_clk: sleep_clk {
 		};
 	};
 
+	kraitcc: clock-controller {
+		compatible = "qcom,krait-cc-v1";
+		clocks = <&gcc PLL9>, /* hfpll0 */
+			 <&gcc PLL10>, /* hfpll1 */
+			 <&gcc PLL16>, /* hfpll2 */
+			 <&gcc PLL17>, /* hfpll3 */
+			 <&gcc PLL12>, /* hfpll_l2 */
+			 <&acc0>,
+			 <&acc1>,
+			 <&acc2>,
+			 <&acc3>,
+			 <&l2cc>;
+		clock-names = "hfpll0",
+			      "hfpll1",
+			      "hfpll2",
+			      "hfpll3",
+			      "hfpll_l2",
+			      "acpu0_aux",
+			      "acpu1_aux",
+			      "acpu2_aux",
+			      "acpu3_aux",
+			      "acpu_l2_aux";
+		#clock-cells = <1>;
+		#interconnect-cells = <1>;
+	};
+
 	sfpb_mutex: hwmutex {
 		compatible = "qcom,sfpb-mutex";
 		syscon = <&sfpb_wrapper_mutex 0x604 0x4>;
@@ -933,6 +1100,9 @@ qfprom: qfprom@700000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+			speedbin_efuse: speedbin@c0 {
+				reg = <0x0c0 0x4>;
+			};
 			tsens_calib: calib@404 {
 				reg = <0x404 0x10>;
 			};
-- 
2.39.2

