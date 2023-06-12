Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7FF72B7A1
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 07:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbjFLFkJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jun 2023 01:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbjFLFjw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 01:39:52 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963271708
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2023 22:39:39 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f655293a38so4112638e87.0
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2023 22:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686548377; x=1689140377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wt0ovU1UM+zA+dgM6wsatyMQXhOAKNo5+GG5VSQHHw=;
        b=EVq7+quentdGKbnYY/O8EK69vkcDvHM6X100UqLLPilN1h0Is54Tn0S1qjewyewmWY
         CcQy0k8MenfpDs4A5vxV5UkIU73xoLyRJnReJTxAuyG8TzPiYpGm97NLIOpiRxVWGdVi
         37cNMEH8dmDQIOJHVCPzxUSqPB/s5kR0VhDc5y5kzeKKlMYa3IN3fV0k76J/Cp9esbzS
         +QgV8mMz/X4DsHRyJr2RbDI6I/HzYnrssT8kQqaNPDwSpceNClwxdZNr4o2LjOOen0vI
         GkMM1GmwMf/hzsFZ2ToFmlevF+1Xds9zTcKaWpHNrgF1CoW/mnFNyheDJiAvrvgyT0i4
         NIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686548377; x=1689140377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wt0ovU1UM+zA+dgM6wsatyMQXhOAKNo5+GG5VSQHHw=;
        b=AdmopcsUgG5X/AOYw7dqPlNgTOiGnebcZ7E2qVbLK/9cpa034KcEJTGRPvgjWGLDM/
         8XwlqTVMFi/39T7qKOjk3+kGhUBllrgPWvQKwT7RhnfDn4a83FkP7o8Sxqwb9Oxo4F7+
         mbnM3XMgCiM1TZdHGyCVrXjYmectnwu6B0mfU4zVhTRe0JA9Lq17EMpvtv8qeCRrkvcF
         r71IvL7VlT+TuNRA/irC8erzPVnQNf4+PyBOA25YkE0C1k2uj99HQP5PqsCSfRCb8Fq0
         c/ZzEsg13oSc6SZIHfmeVZw3/FsiDYvNMRed2K7rVb+KrdJy6OtUxu5Nx+daM368A9+7
         dC0Q==
X-Gm-Message-State: AC+VfDymnanFKYAfIU66T7utBRzxmS1Mte9nLWPy3foFJHxm2KUHuLAd
        fRzWtibTVSUm4XywMAkvuZSvTA==
X-Google-Smtp-Source: ACHHUZ4PBTd1f3XY3VTSalfSjrcIfe4nVCYBRPFjlwpVAtsnRsA0U/XqOmpMYza/DdKIVdiCF65YdQ==
X-Received: by 2002:a05:6512:1cd:b0:4f4:dd51:aec7 with SMTP id f13-20020a05651201cd00b004f4dd51aec7mr2721252lfp.54.1686548377591;
        Sun, 11 Jun 2023 22:39:37 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id n6-20020a195506000000b004f38260f196sm1324125lfe.218.2023.06.11.22.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 22:39:37 -0700 (PDT)
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
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 14/18] ARM: dts: qcom: apq8064: add simple CPUFreq support
Date:   Mon, 12 Jun 2023 08:39:18 +0300
Message-Id: <20230612053922.3284394-15-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
References: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
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
 arch/arm/boot/dts/qcom-apq8064.dtsi | 169 ++++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 1eb6d752ebae..4ef13f3d702b 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -2,6 +2,7 @@
 /dts-v1/;
 
 #include <dt-bindings/clock/qcom,gcc-msm8960.h>
+#include <dt-bindings/clock/qcom,krait-cc.h>
 #include <dt-bindings/clock/qcom,lcc-msm8960.h>
 #include <dt-bindings/reset/qcom,gcc-msm8960.h>
 #include <dt-bindings/clock/qcom,mmcc-msm8960.h>
@@ -45,6 +46,12 @@ CPU0: cpu@0 {
 			qcom,acc = <&acc0>;
 			qcom,saw = <&saw0>;
 			cpu-idle-states = <&CPU_SPC>;
+			clocks = <&kraitcc KRAIT_CPU_0>;
+			clock-names = "cpu";
+			clock-latency = <100000>;
+			interconnects = <&kraitcc MASTER_KRAIT_L2 &kraitcc SLAVE_KRAIT_L2>;
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		CPU1: cpu@1 {
@@ -56,6 +63,12 @@ CPU1: cpu@1 {
 			qcom,acc = <&acc1>;
 			qcom,saw = <&saw1>;
 			cpu-idle-states = <&CPU_SPC>;
+			clocks = <&kraitcc KRAIT_CPU_1>;
+			clock-names = "cpu";
+			clock-latency = <100000>;
+			interconnects = <&kraitcc MASTER_KRAIT_L2 &kraitcc SLAVE_KRAIT_L2>;
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		CPU2: cpu@2 {
@@ -67,6 +80,12 @@ CPU2: cpu@2 {
 			qcom,acc = <&acc2>;
 			qcom,saw = <&saw2>;
 			cpu-idle-states = <&CPU_SPC>;
+			clocks = <&kraitcc KRAIT_CPU_2>;
+			clock-names = "cpu";
+			clock-latency = <100000>;
+			interconnects = <&kraitcc MASTER_KRAIT_L2 &kraitcc SLAVE_KRAIT_L2>;
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		CPU3: cpu@3 {
@@ -78,6 +97,12 @@ CPU3: cpu@3 {
 			qcom,acc = <&acc3>;
 			qcom,saw = <&saw3>;
 			cpu-idle-states = <&CPU_SPC>;
+			clocks = <&kraitcc KRAIT_CPU_3>;
+			clock-names = "cpu";
+			clock-latency = <100000>;
+			interconnects = <&kraitcc MASTER_KRAIT_L2 &kraitcc SLAVE_KRAIT_L2>;
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		L2: l2-cache {
@@ -97,6 +122,121 @@ CPU_SPC: spc {
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
@@ -213,6 +353,32 @@ sleep_clk: sleep_clk {
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
@@ -834,6 +1000,9 @@ qfprom: qfprom@700000 {
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

