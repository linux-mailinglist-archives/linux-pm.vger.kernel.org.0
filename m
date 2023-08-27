Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AAD789DA2
	for <lists+linux-pm@lfdr.de>; Sun, 27 Aug 2023 13:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjH0LvU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Aug 2023 07:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjH0LvA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Aug 2023 07:51:00 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD86118D
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 04:50:50 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ff8cf11b90so3658152e87.1
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 04:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693137049; x=1693741849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+eZMoipyr1kFY9v8O1FNImEm/8AoQ7tNS578gddS3o=;
        b=Ygk12yfXGP/Rp/NXWYz7+rs2P4kQU/pgPUrrv7ZoxEi4L5/iG2MWjpaopN0ozBX859
         nsEtU3/WhB5WRkCeLSvbIg+JbJgAXIv2JrKRTKLfzIAT0w+wQnmIcugL0bYNALGctzsz
         xZq1GZfyGOC51XVX0K1jIoLYDRJ7q4STXerp/QOIEWt0IHvWgD5JlhjX6fptkXABwsFZ
         Rqbg0WA373vR9oTJ9lSl47Sgt0NIv8JzQLzHf1M5wGWPcUILYIY5ZRi/dGZgQ3xbn3uQ
         eXSIAWbSBf2/f9UETq9YNil00sZeeui1rpCEFWRGcfdVWjnfTSlCWOCaX7MAkOvghLUe
         7kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693137049; x=1693741849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+eZMoipyr1kFY9v8O1FNImEm/8AoQ7tNS578gddS3o=;
        b=E5Xm9ZKu+gHxy4w6ecim/zWab1TSCAeHkFRNFZKdeXniDRbxT5aMSDMz4yVeyagLWp
         cbqjVJidjNvVb7mZau7SLJqzxAqz+c8wd3V0MvPCh9HTUOpxoRH4S+w5sH09Xj4XVc6N
         DX7vHyeRKvq8ASTr8kVNBfKkoRPL1h4JSUjAQPVoEi9cfO1qA3hOQJX1VemEWo8Kx8iF
         U1scdvNzgRa9QnZA2N9/Yr9LN8VNIi11k+0d5uI1jQ+7env3cSM3UOJQureHAoUTl2kf
         pr4UeZTltMzZTF4AZYLm0APmkJ0RPiir97NJ/K52dHHwMmUvuxieaCmYNfFf7N1XqjAW
         0dhw==
X-Gm-Message-State: AOJu0YwVUKKRW5aw2NKFZF+GBZdTjEklqrOE/PQIkrFuK7PjTw3hYnGA
        IQN3Q9UJ4oFXgXKZmCdVzxubfA==
X-Google-Smtp-Source: AGHT+IFcHKsASpLneYXF3a59J5serIdJIldGQ3+CUo8S65Gw7vPtxxW42f7ZxOOQuzEFPL7hL4/GBg==
X-Received: by 2002:a05:6512:2303:b0:4f8:6a29:b59b with SMTP id o3-20020a056512230300b004f86a29b59bmr19733135lfu.64.1693137048879;
        Sun, 27 Aug 2023 04:50:48 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a8-20020a19f808000000b004ff9f88b86esm1114770lff.308.2023.08.27.04.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 04:50:48 -0700 (PDT)
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
Subject: [PATCH v4 17/23] ARM: dts: qcom: apq8064: add simple CPUFreq support
Date:   Sun, 27 Aug 2023 14:50:27 +0300
Message-Id: <20230827115033.935089-18-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
References: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 483 +++++++++++++++++++++++
 1 file changed, 483 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 21990ca5851a..f08d87bcc37e 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/qcom,mmcc-msm8960.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/soc/qcom,gsbi.h>
+#include <dt-bindings/soc/qcom,krait-l2-cache.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 / {
@@ -46,6 +47,13 @@ CPU0: cpu@0 {
 			qcom,acc = <&acc0>;
 			qcom,saw = <&saw0>;
 			cpu-idle-states = <&CPU_SPC>;
+			clocks = <&kraitcc KRAIT_CPU_0>;
+			clock-names = "cpu";
+			clock-latency = <100000>;
+			vdd-core-supply = <&saw0_vreg>;
+			interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		CPU1: cpu@1 {
@@ -57,6 +65,13 @@ CPU1: cpu@1 {
 			qcom,acc = <&acc1>;
 			qcom,saw = <&saw1>;
 			cpu-idle-states = <&CPU_SPC>;
+			clocks = <&kraitcc KRAIT_CPU_1>;
+			clock-names = "cpu";
+			clock-latency = <100000>;
+			vdd-core-supply = <&saw1_vreg>;
+			interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		CPU2: cpu@2 {
@@ -68,6 +83,13 @@ CPU2: cpu@2 {
 			qcom,acc = <&acc2>;
 			qcom,saw = <&saw2>;
 			cpu-idle-states = <&CPU_SPC>;
+			clocks = <&kraitcc KRAIT_CPU_2>;
+			clock-names = "cpu";
+			clock-latency = <100000>;
+			vdd-core-supply = <&saw2_vreg>;
+			interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		CPU3: cpu@3 {
@@ -79,6 +101,13 @@ CPU3: cpu@3 {
 			qcom,acc = <&acc3>;
 			qcom,saw = <&saw3>;
 			cpu-idle-states = <&CPU_SPC>;
+			clocks = <&kraitcc KRAIT_CPU_3>;
+			clock-names = "cpu";
+			clock-latency = <100000>;
+			vdd-core-supply = <&saw3_vreg>;
+			interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		L2: l2-cache {
@@ -195,6 +224,454 @@ CPU_SPC: spc {
 		};
 	};
 
+        cpu_opp_table: opp-table-cpu {
+		compatible = "operating-points-v2-krait-cpu";
+		nvmem-cells = <&speedbin_efuse>;
+
+		/* Voltage thresholds are <target min max> */
+		opp-384000000 {
+			opp-hz = /bits/ 64 <384000000>;
+			opp-peak-kBps = <384000>;
+			opp-microvolt-speed0-pvs0 = <950000 950000 975000>;
+			opp-microvolt-speed0-pvs1 = <925000 900000 950000>;
+			opp-microvolt-speed0-pvs3 = <875000 850000 900000>;
+			opp-microvolt-speed0-pvs4 = <875000 850000 900000>;
+			opp-microvolt-speed1-pvs0 = <950000 950000 975000>;
+			opp-microvolt-speed1-pvs1 = <975000 950000 1000000>;
+			opp-microvolt-speed1-pvs2 = <950000 925000 975000>;
+			opp-microvolt-speed1-pvs3 = <925000 900000 950000>;
+			opp-microvolt-speed1-pvs4 = <900000 875000 925000>;
+			opp-microvolt-speed1-pvs5 = <900000 875000 925000>;
+			opp-microvolt-speed1-pvs6 = <900000 875000 925000>;
+			opp-microvolt-speed2-pvs0 = <950000 950000 975000>;
+			opp-microvolt-speed2-pvs1 = <925000 925000 925000>;
+			opp-microvolt-speed2-pvs2 = <925000 900000 950000>;
+			opp-microvolt-speed2-pvs3 = <925000 900000 950000>;
+			opp-microvolt-speed2-pvs4 = <900000 875000 925000>;
+			opp-microvolt-speed2-pvs5 = <900000 875000 925000>;
+			opp-microvolt-speed2-pvs6 = <900000 875000 925000>;
+			opp-microvolt-speed14-pvs0 = <950000 950000 975000>;
+			opp-microvolt-speed14-pvs1 = <975000 950000 1000000>;
+			opp-microvolt-speed14-pvs2 = <950000 925000 975000>;
+			opp-microvolt-speed14-pvs3 = <925000 900000 950000>;
+			opp-microvolt-speed14-pvs4 = <900000 875000 925000>;
+			opp-microvolt-speed14-pvs5 = <875000 875000 875000>;
+			opp-microvolt-speed14-pvs6 = <900000 875000 925000>;
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
+			opp-microvolt-speed0-pvs0 = <975000 975000 1000000>;
+			opp-microvolt-speed0-pvs1 = <950000 925000 975000>;
+			opp-microvolt-speed0-pvs3 = <900000 875000 925000>;
+			opp-microvolt-speed0-pvs4 = <900000 875000 925000>;
+			opp-microvolt-speed1-pvs0 = <950000 950000 975000>;
+			opp-microvolt-speed1-pvs1 = <975000 950000 1000000>;
+			opp-microvolt-speed1-pvs2 = <950000 925000 975000>;
+			opp-microvolt-speed1-pvs3 = <925000 900000 950000>;
+			opp-microvolt-speed1-pvs4 = <900000 875000 925000>;
+			opp-microvolt-speed1-pvs5 = <900000 875000 925000>;
+			opp-microvolt-speed1-pvs6 = <900000 875000 925000>;
+			opp-microvolt-speed2-pvs0 = <950000 950000 975000>;
+			opp-microvolt-speed2-pvs1 = <925000 925000 925000>;
+			opp-microvolt-speed2-pvs2 = <925000 900000 950000>;
+			opp-microvolt-speed2-pvs3 = <925000 900000 950000>;
+			opp-microvolt-speed2-pvs4 = <900000 875000 925000>;
+			opp-microvolt-speed2-pvs5 = <900000 875000 925000>;
+			opp-microvolt-speed2-pvs6 = <900000 875000 925000>;
+			opp-microvolt-speed14-pvs0 = <950000 950000 975000>;
+			opp-microvolt-speed14-pvs1 = <975000 950000 1000000>;
+			opp-microvolt-speed14-pvs2 = <950000 925000 975000>;
+			opp-microvolt-speed14-pvs3 = <925000 900000 950000>;
+			opp-microvolt-speed14-pvs4 = <900000 875000 925000>;
+			opp-microvolt-speed14-pvs5 = <875000 875000 875000>;
+			opp-microvolt-speed14-pvs6 = <875000 875000 875000>;
+			opp-supported-hw = <0x4007>;
+		};
+
+		opp-594000000 {
+			opp-hz = /bits/ 64 <594000000>;
+			opp-peak-kBps = <648000>;
+			opp-microvolt-speed0-pvs0 = <1000000 1000000 1025000>;
+			opp-microvolt-speed0-pvs1 = <975000 950000 1000000>;
+			opp-microvolt-speed0-pvs3 = <925000 900000 950000>;
+			opp-microvolt-speed0-pvs4 = <925000 900000 950000>;
+			opp-microvolt-speed1-pvs0 = <950000 950000 975000>;
+			opp-microvolt-speed1-pvs1 = <975000 950000 1000000>;
+			opp-microvolt-speed1-pvs2 = <950000 925000 975000>;
+			opp-microvolt-speed1-pvs3 = <925000 900000 950000>;
+			opp-microvolt-speed1-pvs4 = <900000 875000 925000>;
+			opp-microvolt-speed1-pvs5 = <900000 875000 925000>;
+			opp-microvolt-speed1-pvs6 = <900000 875000 925000>;
+			opp-microvolt-speed2-pvs0 = <950000 950000 975000>;
+			opp-microvolt-speed2-pvs1 = <925000 925000 925000>;
+			opp-microvolt-speed2-pvs2 = <925000 900000 950000>;
+			opp-microvolt-speed2-pvs3 = <925000 900000 950000>;
+			opp-microvolt-speed2-pvs4 = <900000 875000 925000>;
+			opp-microvolt-speed2-pvs5 = <900000 875000 925000>;
+			opp-microvolt-speed2-pvs6 = <900000 875000 925000>;
+			opp-microvolt-speed14-pvs0 = <950000 950000 975000>;
+			opp-microvolt-speed14-pvs1 = <975000 950000 1000000>;
+			opp-microvolt-speed14-pvs2 = <950000 925000 975000>;
+			opp-microvolt-speed14-pvs3 = <925000 900000 950000>;
+			opp-microvolt-speed14-pvs4 = <900000 875000 925000>;
+			opp-microvolt-speed14-pvs5 = <875000 875000 875000>;
+			opp-microvolt-speed14-pvs6 = <900000 875000 925000>;
+			opp-supported-hw = <0x4007>;
+		};
+
+		opp-702000000 {
+			opp-hz = /bits/ 64 <702000000>;
+			opp-peak-kBps = <648000>;
+			opp-microvolt-speed0-pvs0 = <1025000 1025000 1050000>;
+			opp-microvolt-speed0-pvs1 = <1000000 975000 1025000>;
+			opp-microvolt-speed0-pvs3 = <950000 925000 975000>;
+			opp-microvolt-speed0-pvs4 = <950000 925000 975000>;
+			opp-microvolt-speed1-pvs0 = <962500 962500 987500>;
+			opp-microvolt-speed1-pvs1 = <987500 962500 1012500>;
+			opp-microvolt-speed1-pvs2 = <950000 925000 975000>;
+			opp-microvolt-speed1-pvs3 = <925000 900000 950000>;
+			opp-microvolt-speed1-pvs4 = <900000 875000 925000>;
+			opp-microvolt-speed1-pvs5 = <900000 875000 925000>;
+			opp-microvolt-speed1-pvs6 = <900000 875000 925000>;
+			opp-microvolt-speed2-pvs0 = <950000 950000 975000>;
+			opp-microvolt-speed2-pvs1 = <925000 925000 925000>;
+			opp-microvolt-speed2-pvs2 = <925000 900000 950000>;
+			opp-microvolt-speed2-pvs3 = <925000 900000 950000>;
+			opp-microvolt-speed2-pvs4 = <900000 875000 925000>;
+			opp-microvolt-speed2-pvs5 = <900000 875000 925000>;
+			opp-microvolt-speed2-pvs6 = <900000 875000 925000>;
+			opp-microvolt-speed14-pvs0 = <962500 962500 987500>;
+			opp-microvolt-speed14-pvs1 = <987500 962500 1012500>;
+			opp-microvolt-speed14-pvs2 = <950000 925000 975000>;
+			opp-microvolt-speed14-pvs3 = <925000 900000 950000>;
+			opp-microvolt-speed14-pvs4 = <900000 875000 925000>;
+			opp-microvolt-speed14-pvs5 = <875000 875000 875000>;
+			opp-microvolt-speed14-pvs6 = <900000 875000 925000>;
+			opp-supported-hw = <0x4007>;
+		};
+
+		opp-810000000 {
+			opp-hz = /bits/ 64 <810000000>;
+			opp-peak-kBps = <648000>;
+			opp-microvolt-speed0-pvs0 = <1075000 1075000 1100000>;
+			opp-microvolt-speed0-pvs1 = <1050000 1025000 1075000>;
+			opp-microvolt-speed0-pvs3 = <1000000 975000 1025000>;
+			opp-microvolt-speed0-pvs4 = <987500 962500 1012500>;
+			opp-microvolt-speed1-pvs0 = <1000000 1000000 1025000>;
+			opp-microvolt-speed1-pvs1 = <1000000 975000 1025000>;
+			opp-microvolt-speed1-pvs2 = <962500 937500 987500>;
+			opp-microvolt-speed1-pvs3 = <925000 900000 950000>;
+			opp-microvolt-speed1-pvs4 = <912500 887500 937500>;
+			opp-microvolt-speed1-pvs5 = <912500 887500 937500>;
+			opp-microvolt-speed1-pvs6 = <912500 887500 937500>;
+			opp-microvolt-speed2-pvs0 = <962500 962500 987500>;
+			opp-microvolt-speed2-pvs1 = <937500 937500 937500>;
+			opp-microvolt-speed2-pvs2 = <937500 912500 962500>;
+			opp-microvolt-speed2-pvs3 = <925000 900000 950000>;
+			opp-microvolt-speed2-pvs4 = <912500 887500 937500>;
+			opp-microvolt-speed2-pvs5 = <912500 887500 937500>;
+			opp-microvolt-speed2-pvs6 = <912500 887500 937500>;
+			opp-microvolt-speed14-pvs0 = <1000000 1000000 1025000>;
+			opp-microvolt-speed14-pvs1 = <1000000 975000 1025000>;
+			opp-microvolt-speed14-pvs2 = <962500 937500 987500>;
+			opp-microvolt-speed14-pvs3 = <925000 900000 950000>;
+			opp-microvolt-speed14-pvs4 = <912500 887500 937500>;
+			opp-microvolt-speed14-pvs5 = <887500 887500 887500>;
+			opp-microvolt-speed14-pvs6 = <912500 887500 937500>;
+			opp-supported-hw = <0x4007>;
+		};
+
+		opp-918000000 {
+			opp-hz = /bits/ 64 <918000000>;
+			opp-peak-kBps = <648000>;
+			opp-microvolt-speed0-pvs0 = <1100000 1100000 1125000>;
+			opp-microvolt-speed0-pvs1 = <1075000 1050000 1100000>;
+			opp-microvolt-speed0-pvs3 = <1025000 1000000 1050000>;
+			opp-microvolt-speed0-pvs4 = <1000000 975000 1025000>;
+			opp-microvolt-speed1-pvs0 = <1025000 1025000 1050000>;
+			opp-microvolt-speed1-pvs1 = <1025000 1000000 1050000>;
+			opp-microvolt-speed1-pvs2 = <975000 950000 1000000>;
+			opp-microvolt-speed1-pvs3 = <950000 925000 975000>;
+			opp-microvolt-speed1-pvs4 = <925000 900000 950000>;
+			opp-microvolt-speed1-pvs5 = <925000 900000 950000>;
+			opp-microvolt-speed1-pvs6 = <925000 900000 950000>;
+			opp-microvolt-speed2-pvs0 = <975000 975000 1000000>;
+			opp-microvolt-speed2-pvs1 = <950000 950000 950000>;
+			opp-microvolt-speed2-pvs2 = <950000 925000 975000>;
+			opp-microvolt-speed2-pvs3 = <937500 912500 962500>;
+			opp-microvolt-speed2-pvs4 = <925000 900000 950000>;
+			opp-microvolt-speed2-pvs5 = <925000 900000 950000>;
+			opp-microvolt-speed2-pvs6 = <925000 900000 950000>;
+			opp-microvolt-speed14-pvs0 = <1025000 1025000 1050000>;
+			opp-microvolt-speed14-pvs1 = <1025000 1000000 1050000>;
+			opp-microvolt-speed14-pvs2 = <975000 950000 1000000>;
+			opp-microvolt-speed14-pvs3 = <950000 925000 975000>;
+			opp-microvolt-speed14-pvs4 = <925000 900000 950000>;
+			opp-microvolt-speed14-pvs5 = <900000 900000 900000>;
+			opp-microvolt-speed14-pvs6 = <925000 900000 950000>;
+			opp-supported-hw = <0x4007>;
+		};
+
+		opp-1026000000 {
+			opp-hz = /bits/ 64 <1026000000>;
+			opp-peak-kBps = <648000>;
+			opp-microvolt-speed0-pvs0 = <1125000 1125000 1150000>;
+			opp-microvolt-speed0-pvs1 = <1100000 1075000 1125000>;
+			opp-microvolt-speed0-pvs3 = <1050000 1025000 1075000>;
+			opp-microvolt-speed0-pvs4 = <1025000 1000000 1050000>;
+			opp-microvolt-speed1-pvs0 = <1037500 1037500 1062500>;
+			opp-microvolt-speed1-pvs1 = <1037500 1012500 1062500>;
+			opp-microvolt-speed1-pvs2 = <1000000 975000 1025000>;
+			opp-microvolt-speed1-pvs3 = <975000 950000 1000000>;
+			opp-microvolt-speed1-pvs4 = <950000 925000 975000>;
+			opp-microvolt-speed1-pvs5 = <950000 925000 975000>;
+			opp-microvolt-speed1-pvs6 = <950000 925000 975000>;
+			opp-microvolt-speed2-pvs0 = <1000000 1000000 1025000>;
+			opp-microvolt-speed2-pvs1 = <975000 975000 975000>;
+			opp-microvolt-speed2-pvs2 = <975000 950000 1000000>;
+			opp-microvolt-speed2-pvs3 = <962500 937500 987500>;
+			opp-microvolt-speed2-pvs4 = <950000 925000 975000>;
+			opp-microvolt-speed2-pvs5 = <950000 925000 975000>;
+			opp-microvolt-speed2-pvs6 = <950000 925000 975000>;
+			opp-microvolt-speed14-pvs0 = <1037500 1037500 1062500>;
+			opp-microvolt-speed14-pvs1 = <1037500 1012500 1062500>;
+			opp-microvolt-speed14-pvs2 = <1000000 975000 1025000>;
+			opp-microvolt-speed14-pvs3 = <975000 950000 1000000>;
+			opp-microvolt-speed14-pvs4 = <950000 925000 975000>;
+			opp-microvolt-speed14-pvs5 = <925000 925000 925000>;
+			opp-microvolt-speed14-pvs6 = <950000 925000 975000>;
+			opp-supported-hw = <0x4007>;
+		};
+
+		opp-1134000000 {
+			opp-hz = /bits/ 64 <1134000000>;
+			opp-peak-kBps = <1134000>;
+			opp-microvolt-speed0-pvs0 = <1175000 1175000 1200000>;
+			opp-microvolt-speed0-pvs1 = <1150000 1125000 1175000>;
+			opp-microvolt-speed0-pvs3 = <1100000 1075000 1125000>;
+			opp-microvolt-speed0-pvs4 = <1075000 1050000 1100000>;
+			opp-microvolt-speed1-pvs0 = <1075000 1075000 1100000>;
+			opp-microvolt-speed1-pvs1 = <1062500 1037500 1087500>;
+			opp-microvolt-speed1-pvs2 = <1025000 1000000 1050000>;
+			opp-microvolt-speed1-pvs3 = <1000000 975000 1025000>;
+			opp-microvolt-speed1-pvs4 = <975000 950000 1000000>;
+			opp-microvolt-speed1-pvs5 = <962500 937500 987500>;
+			opp-microvolt-speed1-pvs6 = <962500 937500 987500>;
+			opp-microvolt-speed2-pvs0 = <1025000 1025000 1050000>;
+			opp-microvolt-speed2-pvs1 = <1000000 1000000 1000000>;
+			opp-microvolt-speed2-pvs2 = <1000000 975000 1025000>;
+			opp-microvolt-speed2-pvs3 = <987500 962500 1012500>;
+			opp-microvolt-speed2-pvs4 = <975000 950000 1000000>;
+			opp-microvolt-speed2-pvs5 = <962500 937500 987500>;
+			opp-microvolt-speed2-pvs6 = <962500 937500 987500>;
+			opp-microvolt-speed14-pvs0 = <1075000 1075000 1100000>;
+			opp-microvolt-speed14-pvs1 = <1062500 1037500 1087500>;
+			opp-microvolt-speed14-pvs2 = <1025000 1000000 1050000>;
+			opp-microvolt-speed14-pvs3 = <1000000 975000 1025000>;
+			opp-microvolt-speed14-pvs4 = <975000 950000 1000000>;
+			opp-microvolt-speed14-pvs5 = <937500 937500 937500>;
+			opp-microvolt-speed14-pvs6 = <962500 937500 987500>;
+			opp-supported-hw = <0x4007>;
+		};
+
+		opp-1242000000 {
+			opp-hz = /bits/ 64 <1242000000>;
+			opp-peak-kBps = <1134000>;
+			opp-microvolt-speed0-pvs0 = <1200000 1200000 1225000>;
+			opp-microvolt-speed0-pvs1 = <1175000 1150000 1200000>;
+			opp-microvolt-speed0-pvs3 = <1125000 1100000 1150000>;
+			opp-microvolt-speed0-pvs4 = <1100000 1075000 1125000>;
+			opp-microvolt-speed1-pvs0 = <1087500 1087500 1112500>;
+			opp-microvolt-speed1-pvs1 = <1075000 1050000 1100000>;
+			opp-microvolt-speed1-pvs2 = <1037500 1012500 1062500>;
+			opp-microvolt-speed1-pvs3 = <1012500 987500 1037500>;
+			opp-microvolt-speed1-pvs4 = <987500 962500 1012500>;
+			opp-microvolt-speed1-pvs5 = <975000 950000 1000000>;
+			opp-microvolt-speed1-pvs6 = <975000 950000 1000000>;
+			opp-microvolt-speed2-pvs0 = <1037500 1037500 1062500>;
+			opp-microvolt-speed2-pvs1 = <1012500 1012500 1012500>;
+			opp-microvolt-speed2-pvs2 = <1012500 987500 1037500>;
+			opp-microvolt-speed2-pvs3 = <1000000 975000 1025000>;
+			opp-microvolt-speed2-pvs4 = <987500 962500 1012500>;
+			opp-microvolt-speed2-pvs5 = <975000 950000 1000000>;
+			opp-microvolt-speed2-pvs6 = <975000 950000 1000000>;
+			opp-microvolt-speed14-pvs0 = <1087500 1087500 1112500>;
+			opp-microvolt-speed14-pvs1 = <1075000 1050000 1100000>;
+			opp-microvolt-speed14-pvs2 = <1037500 1012500 1062500>;
+			opp-microvolt-speed14-pvs3 = <1012500 987500 1037500>;
+			opp-microvolt-speed14-pvs4 = <987500 962500 1012500>;
+			opp-microvolt-speed14-pvs5 = <950000 950000 950000>;
+			opp-microvolt-speed14-pvs6 = <975000 950000 1000000>;
+			opp-supported-hw = <0x4007>;
+		};
+
+		opp-1350000000 {
+			opp-hz = /bits/ 64 <1350000000>;
+			opp-peak-kBps = <1134000>;
+			opp-microvolt-speed0-pvs0 = <1225000 1225000 1250000>;
+			opp-microvolt-speed0-pvs1 = <1200000 1175000 1225000>;
+			opp-microvolt-speed0-pvs3 = <1150000 1125000 1175000>;
+			opp-microvolt-speed0-pvs4 = <1125000 1100000 1150000>;
+			opp-microvolt-speed1-pvs0 = <1125000 1125000 1150000>;
+			opp-microvolt-speed1-pvs1 = <1112500 1087500 1137500>;
+			opp-microvolt-speed1-pvs2 = <1062500 1037500 1087500>;
+			opp-microvolt-speed1-pvs3 = <1025000 1000000 1050000>;
+			opp-microvolt-speed1-pvs4 = <1000000 975000 1025000>;
+			opp-microvolt-speed1-pvs5 = <987500 962500 1012500>;
+			opp-microvolt-speed1-pvs6 = <987500 962500 1012500>;
+			opp-microvolt-speed2-pvs0 = <1062500 1062500 1087500>;
+			opp-microvolt-speed2-pvs1 = <1037500 1037500 1037500>;
+			opp-microvolt-speed2-pvs2 = <1037500 1012500 1062500>;
+			opp-microvolt-speed2-pvs3 = <1025000 1000000 1050000>;
+			opp-microvolt-speed2-pvs4 = <1000000 975000 1025000>;
+			opp-microvolt-speed2-pvs5 = <987500 962500 1012500>;
+			opp-microvolt-speed2-pvs6 = <987500 962500 1012500>;
+			opp-microvolt-speed14-pvs0 = <1125000 1125000 1150000>;
+			opp-microvolt-speed14-pvs1 = <1112500 1087500 1137500>;
+			opp-microvolt-speed14-pvs2 = <1062500 1037500 1087500>;
+			opp-microvolt-speed14-pvs3 = <1025000 1000000 1050000>;
+			opp-microvolt-speed14-pvs4 = <1000000 975000 1025000>;
+			opp-microvolt-speed14-pvs5 = <962500 962500 962500>;
+			opp-microvolt-speed14-pvs6 = <987500 962500 1012500>;
+			opp-supported-hw = <0x4007>;
+		};
+
+		opp-1458000000 {
+			opp-hz = /bits/ 64 <1458000000>;
+			opp-peak-kBps = <1134000>;
+			opp-microvolt-speed0-pvs0 = <1237500 1237500 1262500>;
+			opp-microvolt-speed0-pvs1 = <1212500 1187500 1237500>;
+			opp-microvolt-speed0-pvs3 = <1162500 1137500 1187500>;
+			opp-microvolt-speed0-pvs4 = <1137500 1112500 1162500>;
+			opp-microvolt-speed1-pvs0 = <1150000 1150000 1175000>;
+			opp-microvolt-speed1-pvs1 = <1137500 1112500 1162500>;
+			opp-microvolt-speed1-pvs2 = <1100000 1075000 1125000>;
+			opp-microvolt-speed1-pvs3 = <1062500 1037500 1087500>;
+			opp-microvolt-speed1-pvs4 = <1025000 1000000 1050000>;
+			opp-microvolt-speed1-pvs5 = <1012500 987500 1037500>;
+			opp-microvolt-speed1-pvs6 = <1000000 975000 1025000>;
+			opp-microvolt-speed2-pvs0 = <1100000 1100000 1125000>;
+			opp-microvolt-speed2-pvs1 = <1075000 1075000 1075000>;
+			opp-microvolt-speed2-pvs2 = <1075000 1050000 1100000>;
+			opp-microvolt-speed2-pvs3 = <1050000 1025000 1075000>;
+			opp-microvolt-speed2-pvs4 = <1025000 1000000 1050000>;
+			opp-microvolt-speed2-pvs5 = <1012500 987500 1037500>;
+			opp-microvolt-speed2-pvs6 = <1000000 975000 1025000>;
+			opp-microvolt-speed14-pvs0 = <1150000 1150000 1175000>;
+			opp-microvolt-speed14-pvs1 = <1137500 1112500 1162500>;
+			opp-microvolt-speed14-pvs2 = <1100000 1075000 1125000>;
+			opp-microvolt-speed14-pvs3 = <1062500 1037500 1087500>;
+			opp-microvolt-speed14-pvs4 = <1025000 1000000 1050000>;
+			opp-microvolt-speed14-pvs5 = <987500 987500 987500>;
+			opp-microvolt-speed14-pvs6 = <1000000 975000 1025000>;
+			opp-supported-hw = <0x4007>;
+		};
+
+		opp-1512000000 {
+			opp-hz = /bits/ 64 <1512000000>;
+			opp-peak-kBps = <1134000>;
+			opp-microvolt-speed0-pvs0 = <1250000 1250000 1275000>;
+			opp-microvolt-speed0-pvs1 = <1225000 1200000 1250000>;
+			opp-microvolt-speed0-pvs3 = <1175000 1150000 1200000>;
+			opp-microvolt-speed0-pvs4 = <1150000 1125000 1175000>;
+			opp-microvolt-speed14-pvs0 = <1162500 1162500 1187500>;
+			opp-microvolt-speed14-pvs1 = <1150000 1125000 1175000>;
+			opp-microvolt-speed14-pvs2 = <1112500 1087500 1137500>;
+			opp-microvolt-speed14-pvs3 = <1075000 1050000 1100000>;
+			opp-microvolt-speed14-pvs4 = <1037500 1012500 1062500>;
+			opp-microvolt-speed14-pvs5 = <1000000 1000000 1000000>;
+			opp-microvolt-speed14-pvs6 = <1012500 987500 1037500>;
+			opp-supported-hw = <0x4001>;
+		};
+
+		opp-1566000000 {
+			opp-hz = /bits/ 64 <1566000000>;
+			opp-peak-kBps = <1134000>;
+			opp-microvolt-speed1-pvs0 = <1175000 1175000 1200000>;
+			opp-microvolt-speed1-pvs1 = <1175000 1150000 1200000>;
+			opp-microvolt-speed1-pvs2 = <1125000 1100000 1150000>;
+			opp-microvolt-speed1-pvs3 = <1087500 1062500 1112500>;
+			opp-microvolt-speed1-pvs4 = <1062500 1037500 1087500>;
+			opp-microvolt-speed1-pvs5 = <1037500 1012500 1062500>;
+			opp-microvolt-speed1-pvs6 = <1025000 1000000 1050000>;
+			opp-microvolt-speed2-pvs0 = <1125000 1125000 1150000>;
+			opp-microvolt-speed2-pvs1 = <1100000 1100000 1100000>;
+			opp-microvolt-speed2-pvs2 = <1100000 1075000 1125000>;
+			opp-microvolt-speed2-pvs3 = <1075000 1050000 1100000>;
+			opp-microvolt-speed2-pvs4 = <1062500 1037500 1087500>;
+			opp-microvolt-speed2-pvs5 = <1037500 1012500 1062500>;
+			opp-microvolt-speed2-pvs6 = <1025000 1000000 1050000>;
+			opp-supported-hw = <0x06>;
+		};
+
+		opp-1674000000 {
+			opp-hz = /bits/ 64 <1674000000>;
+			opp-peak-kBps = <1134000>;
+			opp-microvolt-speed1-pvs0 = <1225000 1225000 1250000>;
+			opp-microvolt-speed1-pvs1 = <1212500 1187500 1237500>;
+			opp-microvolt-speed1-pvs2 = <1162500 1137500 1187500>;
+			opp-microvolt-speed1-pvs3 = <1125000 1100000 1150000>;
+			opp-microvolt-speed1-pvs4 = <1100000 1075000 1125000>;
+			opp-microvolt-speed1-pvs5 = <1075000 1050000 1100000>;
+			opp-microvolt-speed1-pvs6 = <1050000 1025000 1075000>;
+			opp-microvolt-speed2-pvs0 = <1175000 1175000 1200000>;
+			opp-microvolt-speed2-pvs1 = <1137500 1137500 1137500>;
+			opp-microvolt-speed2-pvs2 = <1137500 1112500 1162500>;
+			opp-microvolt-speed2-pvs3 = <1112500 1087500 1137500>;
+			opp-microvolt-speed2-pvs4 = <1100000 1075000 1125000>;
+			opp-microvolt-speed2-pvs5 = <1075000 1050000 1100000>;
+			opp-microvolt-speed2-pvs6 = <1050000 1025000 1075000>;
+			opp-supported-hw = <0x06>;
+		};
+
+		opp-1728000000 {
+			opp-hz = /bits/ 64 <1728000000>;
+			opp-peak-kBps = <1134000>;
+			opp-microvolt-speed1-pvs0 = <1250000 1250000 1275000>;
+			opp-microvolt-speed1-pvs1 = <1225000 1200000 1250000>;
+			opp-microvolt-speed1-pvs2 = <1187500 1162500 1212500>;
+			opp-microvolt-speed1-pvs3 = <1150000 1125000 1175000>;
+			opp-microvolt-speed1-pvs4 = <1125000 1100000 1150000>;
+			opp-microvolt-speed1-pvs5 = <1100000 1075000 1125000>;
+			opp-microvolt-speed1-pvs6 = <1075000 1050000 1100000>;
+			opp-supported-hw = <0x02>;
+		};
+
+		opp-1782000000 {
+			opp-hz = /bits/ 64 <1782000000>;
+			opp-peak-kBps = <1134000>;
+			opp-microvolt-speed2-pvs0 = <1225000 1225000 1250000>;
+			opp-microvolt-speed2-pvs1 = <1187500 1187500 1187500>;
+			opp-microvolt-speed2-pvs2 = <1187500 1162500 1212500>;
+			opp-microvolt-speed2-pvs3 = <1162500 1137500 1187500>;
+			opp-microvolt-speed2-pvs4 = <1137500 1112500 1162500>;
+			opp-microvolt-speed2-pvs5 = <1112500 1087500 1137500>;
+			opp-microvolt-speed2-pvs6 = <1087500 1062500 1112500>;
+			opp-supported-hw = <0x04>;
+		};
+
+		opp-1890000000 {
+			opp-hz = /bits/ 64 <1890000000>;
+			opp-peak-kBps = <1134000>;
+			opp-microvolt-speed2-pvs0 = <1287500 1287500 1312500>;
+			opp-microvolt-speed2-pvs1 = <1250000 1250000 1250000>;
+			opp-microvolt-speed2-pvs2 = <1237500 1212500 1262500>;
+			opp-microvolt-speed2-pvs3 = <1200000 1175000 1225000>;
+			opp-microvolt-speed2-pvs4 = <1175000 1150000 1200000>;
+			opp-microvolt-speed2-pvs5 = <1150000 1125000 1175000>;
+			opp-microvolt-speed2-pvs6 = <1125000 1100000 1150000>;
+			opp-supported-hw = <0x04>;
+		};
+	};
+
 	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0>;
@@ -796,9 +1273,15 @@ qfprom: qfprom@700000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+
+			speedbin_efuse: speedbin@c0 {
+				reg = <0x0c0 0x4>;
+			};
+
 			tsens_calib: calib@404 {
 				reg = <0x404 0x10>;
 			};
+
 			tsens_backup: backup_calib@414 {
 				reg = <0x414 0x10>;
 			};
-- 
2.39.2

