Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9729C72B7A9
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 07:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbjFLFkP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jun 2023 01:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbjFLFjx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 01:39:53 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E441710
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2023 22:39:42 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f644dffd71so4541574e87.1
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2023 22:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686548378; x=1689140378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+5Ilj/fOr9B+zoxAy/TZ5NK7opV9wnXx1T2R0H/zkE=;
        b=AcgHnyXDvlQLzOecxNJQjvyXXwVWTM5zLVtPRcdVRfcgtlIkr2g//vxQfYpvX7C2eB
         4Rg6ifz8oMed8EaTSgnHqwWv9VdEQaAiM89jR02rNJQwNgUqxkaAd2O9UxgIjTK/SQSu
         J6llw+aHE7Zy//8KqDh77M++RssRwYCM5Vg2OLg2000I8IH1QjiOxoKnlW5XptzFHaLZ
         w9VQoeoMUNH1e3Sb+Omc5MbpHTtdpcw5YsN0tJ+Rb7rS8LVLHW3JAufrDs/a2Oc5+2Ed
         PxiehObhL4a9r4fMaEZkd4j1iXK3LimW39d6tkFMY+EWB1jS7ktEk0i5VXJvVK69XBG2
         sfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686548378; x=1689140378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+5Ilj/fOr9B+zoxAy/TZ5NK7opV9wnXx1T2R0H/zkE=;
        b=RSKyajCZ+bel4LF5h5J902U4ycMG3k+TIwacBV448yFJNykBvFUvQyDBE5czYkwElU
         4+vR+iPzsHdPKwtOQNhZZASKOSABe6JL/wjYWxNJbAy8gch928fx5BEkNJzWUOLX2cF6
         EBGu+yGwTd1ewGxu2UfypWsph3bOKk07YqfR8CR/oV0Fpk+L085RqZZGmi+a43m1q3tJ
         I8YCOERFHqw9r3HdOaA0qo2FKmCd55BNlg5vzOjw2/144nL7P7Am2Z33Kuxlr/XbUQrx
         kMfzVXFXutY3fj1dyJ7sJRpiCIqrPL/O1th/5TTmAlmQqFpVNNt4kxFKhmcudOIAS8EF
         zPJA==
X-Gm-Message-State: AC+VfDwtkSDiea9tPQCfAAK4Txe5SRLfI95p9wBm3gvzCYlROdqqV0qD
        xr6R0/OiyfgPgeMRgipi8DI2iQ==
X-Google-Smtp-Source: ACHHUZ5dBLVK3xyBcX7zyVrSQfDvS1N4MEQ8ZXy4UqklgUjo6b4vsOE+i/aAiZmUwikD8kkznxAQcA==
X-Received: by 2002:a05:6512:604:b0:4f4:b0d0:63fb with SMTP id b4-20020a056512060400b004f4b0d063fbmr3106624lfe.35.1686548378601;
        Sun, 11 Jun 2023 22:39:38 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id n6-20020a195506000000b004f38260f196sm1324125lfe.218.2023.06.11.22.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 22:39:38 -0700 (PDT)
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
Subject: [PATCH 15/18] ARM: dts: qcom: apq8064: provide voltage scaling tables
Date:   Mon, 12 Jun 2023 08:39:19 +0300
Message-Id: <20230612053922.3284394-16-dmitry.baryshkov@linaro.org>
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

APQ8064 has 4 speed bins, each of them having from 4 to 6 categorization
kinds. Provide tables necessary to handle voltage scaling on this SoC.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 1017 +++++++++++++++++++++++++++
 1 file changed, 1017 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 4ef13f3d702b..f35853b59544 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -49,6 +49,9 @@ CPU0: cpu@0 {
 			clocks = <&kraitcc KRAIT_CPU_0>;
 			clock-names = "cpu";
 			clock-latency = <100000>;
+			vdd-mem-supply = <&pm8921_l24>;
+			vdd-dig-supply = <&pm8921_s3>;
+			vdd-core-supply = <&saw0_vreg>;
 			interconnects = <&kraitcc MASTER_KRAIT_L2 &kraitcc SLAVE_KRAIT_L2>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
@@ -66,6 +69,9 @@ CPU1: cpu@1 {
 			clocks = <&kraitcc KRAIT_CPU_1>;
 			clock-names = "cpu";
 			clock-latency = <100000>;
+			vdd-mem-supply = <&pm8921_l24>;
+			vdd-dig-supply = <&pm8921_s3>;
+			vdd-core-supply = <&saw1_vreg>;
 			interconnects = <&kraitcc MASTER_KRAIT_L2 &kraitcc SLAVE_KRAIT_L2>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
@@ -83,6 +89,9 @@ CPU2: cpu@2 {
 			clocks = <&kraitcc KRAIT_CPU_2>;
 			clock-names = "cpu";
 			clock-latency = <100000>;
+			vdd-mem-supply = <&pm8921_l24>;
+			vdd-dig-supply = <&pm8921_s3>;
+			vdd-core-supply = <&saw2_vreg>;
 			interconnects = <&kraitcc MASTER_KRAIT_L2 &kraitcc SLAVE_KRAIT_L2>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
@@ -100,6 +109,9 @@ CPU3: cpu@3 {
 			clocks = <&kraitcc KRAIT_CPU_3>;
 			clock-names = "cpu";
 			clock-latency = <100000>;
+			vdd-mem-supply = <&pm8921_l24>;
+			vdd-dig-supply = <&pm8921_s3>;
+			vdd-core-supply = <&saw3_vreg>;
 			interconnects = <&kraitcc MASTER_KRAIT_L2 &kraitcc SLAVE_KRAIT_L2>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
@@ -132,6 +144,81 @@ cpu_opp_table: opp-table-cpu {
 		opp-384000000 {
 			opp-hz = /bits/ 64 <384000000>;
 			opp-peak-kBps = <384000>;
+			opp-microvolt-speed0-pvs0 = <1050000 1050000 1150000>,
+						    <950000 950000 1150000>,
+						    <950000 950000 975000>;
+			opp-microvolt-speed0-pvs1 = <1050000 1050000 1150000>,
+						    <950000 950000 1150000>,
+						    <925000 900000 950000>;
+			opp-microvolt-speed0-pvs3 = <1050000 1050000 1150000>,
+						    <950000 950000 1150000>,
+						    <875000 850000 900000>;
+			opp-microvolt-speed0-pvs4 = <1050000 1050000 1150000>,
+						    <950000 950000 1150000>,
+						    <875000 850000 900000>;
+			opp-microvolt-speed1-pvs0 = <1050000 1050000 1150000>,
+						    <950000 950000 1150000>,
+						    <950000 950000 975000>;
+			opp-microvolt-speed1-pvs1 = <1050000 1050000 1150000>,
+						    <950000 950000 1150000>,
+						    <975000 950000 1000000>;
+			opp-microvolt-speed1-pvs2 = <1050000 1050000 1150000>,
+						    <950000 950000 1150000>,
+						    <950000 925000 975000>;
+			opp-microvolt-speed1-pvs3 = <1050000 1050000 1150000>,
+						    <950000 950000 1150000>,
+						    <925000 900000 950000>;
+			opp-microvolt-speed1-pvs4 = <1050000 1050000 1150000>,
+						    <950000 950000 1150000>,
+						    <900000 875000 925000>;
+			opp-microvolt-speed1-pvs5 = <1050000 1050000 1150000>,
+						    <950000 950000 1150000>,
+						    <900000 875000 925000>;
+			opp-microvolt-speed1-pvs6 = <1050000 1050000 1150000>,
+						    <950000 950000 1150000>,
+						    <900000 875000 925000>;
+			opp-microvolt-speed2-pvs0 = <1050000 1050000 1150000>,
+						    <950000 950000 1150000>,
+						    <950000 950000 975000>;
+			opp-microvolt-speed2-pvs1 = <1050000 1050000 1150000>,
+						    <950000 950000 1150000>,
+						    <925000 925000 925000>;
+			opp-microvolt-speed2-pvs2 = <1050000 1050000 1150000>,
+						    <950000 950000 1150000>,
+						    <925000 900000 950000>;
+			opp-microvolt-speed2-pvs3 = <1050000 1050000 1150000>,
+						    <950000 950000 1150000>,
+						    <925000 900000 950000>;
+			opp-microvolt-speed2-pvs4 = <1050000 1050000 1150000>,
+						    <950000 950000 1150000>,
+						    <900000 875000 925000>;
+			opp-microvolt-speed2-pvs5 = <1050000 1050000 1150000>,
+						    <950000 950000 1150000>,
+						    <900000 875000 925000>;
+			opp-microvolt-speed2-pvs6 = <1050000 1050000 1150000>,
+						    <950000 950000 1150000>,
+						    <900000 875000 925000>;
+			opp-microvolt-speed14-pvs0 = <1050000 1050000 1150000>,
+						     <950000 950000 1150000>,
+						     <950000 950000 975000>;
+			opp-microvolt-speed14-pvs1 = <1050000 1050000 1150000>,
+						     <950000 950000 1150000>,
+						     <975000 950000 1000000>;
+			opp-microvolt-speed14-pvs2 = <1050000 1050000 1150000>,
+						     <950000 950000 1150000>,
+						     <950000 925000 975000>;
+			opp-microvolt-speed14-pvs3 = <1050000 1050000 1150000>,
+						     <950000 950000 1150000>,
+						     <925000 900000 950000>;
+			opp-microvolt-speed14-pvs4 = <1050000 1050000 1150000>,
+						     <950000 950000 1150000>,
+						     <900000 875000 925000>;
+			opp-microvolt-speed14-pvs5 = <1050000 1050000 1150000>,
+						     <950000 950000 1150000>,
+						     <875000 875000 875000>;
+			opp-microvolt-speed14-pvs6 = <1050000 1050000 1150000>,
+						     <950000 950000 1150000>,
+						     <900000 875000 925000>;
 			opp-supported-hw = <0x4007>;
 			/*
 			 * higher latency as it requires switching between
@@ -143,96 +230,1026 @@ opp-384000000 {
 		opp-486000000 {
 			opp-hz = /bits/ 64 <486000000>;
 			opp-peak-kBps = <648000>;
+			opp-microvolt-speed0-pvs0 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <975000 975000 1000000>;
+			opp-microvolt-speed0-pvs1 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <950000 925000 975000>;
+			opp-microvolt-speed0-pvs3 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <900000 875000 925000>;
+			opp-microvolt-speed0-pvs4 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <900000 875000 925000>;
+			opp-microvolt-speed1-pvs0 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <950000 950000 975000>;
+			opp-microvolt-speed1-pvs1 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <975000 950000 1000000>;
+			opp-microvolt-speed1-pvs2 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <950000 925000 975000>;
+			opp-microvolt-speed1-pvs3 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <925000 900000 950000>;
+			opp-microvolt-speed1-pvs4 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <900000 875000 925000>;
+			opp-microvolt-speed1-pvs5 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <900000 875000 925000>;
+			opp-microvolt-speed1-pvs6 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <900000 875000 925000>;
+			opp-microvolt-speed2-pvs0 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <950000 950000 975000>;
+			opp-microvolt-speed2-pvs1 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <925000 925000 925000>;
+			opp-microvolt-speed2-pvs2 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <925000 900000 950000>;
+			opp-microvolt-speed2-pvs3 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <925000 900000 950000>;
+			opp-microvolt-speed2-pvs4 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <900000 875000 925000>;
+			opp-microvolt-speed2-pvs5 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <900000 875000 925000>;
+			opp-microvolt-speed2-pvs6 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <900000 875000 925000>;
+			opp-microvolt-speed14-pvs0 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <950000 950000 975000>;
+			opp-microvolt-speed14-pvs1 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <975000 950000 1000000>;
+			opp-microvolt-speed14-pvs2 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <950000 925000 975000>;
+			opp-microvolt-speed14-pvs3 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <925000 900000 950000>;
+			opp-microvolt-speed14-pvs4 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <900000 875000 925000>;
+			opp-microvolt-speed14-pvs5 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <875000 875000 875000>;
+			opp-microvolt-speed14-pvs6 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <875000 875000 875000>;
 			opp-supported-hw = <0x4007>;
 		};
 
 		opp-594000000 {
 			opp-hz = /bits/ 64 <594000000>;
 			opp-peak-kBps = <648000>;
+			opp-microvolt-speed0-pvs0 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <1000000 1000000 1025000>;
+			opp-microvolt-speed0-pvs1 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <975000 950000 1000000>;
+			opp-microvolt-speed0-pvs3 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <925000 900000 950000>;
+			opp-microvolt-speed0-pvs4 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <925000 900000 950000>;
+			opp-microvolt-speed1-pvs0 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <950000 950000 975000>;
+			opp-microvolt-speed1-pvs1 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <975000 950000 1000000>;
+			opp-microvolt-speed1-pvs2 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <950000 925000 975000>;
+			opp-microvolt-speed1-pvs3 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <925000 900000 950000>;
+			opp-microvolt-speed1-pvs4 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <900000 875000 925000>;
+			opp-microvolt-speed1-pvs5 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <900000 875000 925000>;
+			opp-microvolt-speed1-pvs6 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <900000 875000 925000>;
+			opp-microvolt-speed2-pvs0 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <950000 950000 975000>;
+			opp-microvolt-speed2-pvs1 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <925000 925000 925000>;
+			opp-microvolt-speed2-pvs2 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <925000 900000 950000>;
+			opp-microvolt-speed2-pvs3 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <925000 900000 950000>;
+			opp-microvolt-speed2-pvs4 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <900000 875000 925000>;
+			opp-microvolt-speed2-pvs5 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <900000 875000 925000>;
+			opp-microvolt-speed2-pvs6 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <900000 875000 925000>;
+			opp-microvolt-speed14-pvs0 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <950000 950000 975000>;
+			opp-microvolt-speed14-pvs1 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <975000 950000 1000000>;
+			opp-microvolt-speed14-pvs2 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <950000 925000 975000>;
+			opp-microvolt-speed14-pvs3 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <925000 900000 950000>;
+			opp-microvolt-speed14-pvs4 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <900000 875000 925000>;
+			opp-microvolt-speed14-pvs5 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <875000 875000 875000>;
+			opp-microvolt-speed14-pvs6 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <900000 875000 925000>;
 			opp-supported-hw = <0x4007>;
 		};
 
 		opp-702000000 {
 			opp-hz = /bits/ 64 <702000000>;
 			opp-peak-kBps = <648000>;
+			opp-microvolt-speed0-pvs0 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <1025000 1025000 1050000>;
+			opp-microvolt-speed0-pvs1 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <1000000 975000 1025000>;
+			opp-microvolt-speed0-pvs3 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <950000 925000 975000>;
+			opp-microvolt-speed0-pvs4 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <950000 925000 975000>;
+			opp-microvolt-speed1-pvs0 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <962500 962500 987500>;
+			opp-microvolt-speed1-pvs1 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <987500 962500 1012500>;
+			opp-microvolt-speed1-pvs2 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <950000 925000 975000>;
+			opp-microvolt-speed1-pvs3 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <925000 900000 950000>;
+			opp-microvolt-speed1-pvs4 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <900000 875000 925000>;
+			opp-microvolt-speed1-pvs5 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <900000 875000 925000>;
+			opp-microvolt-speed1-pvs6 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <900000 875000 925000>;
+			opp-microvolt-speed2-pvs0 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <950000 950000 975000>;
+			opp-microvolt-speed2-pvs1 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <925000 925000 925000>;
+			opp-microvolt-speed2-pvs2 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <925000 900000 950000>;
+			opp-microvolt-speed2-pvs3 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <925000 900000 950000>;
+			opp-microvolt-speed2-pvs4 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <900000 875000 925000>;
+			opp-microvolt-speed2-pvs5 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <900000 875000 925000>;
+			opp-microvolt-speed2-pvs6 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <900000 875000 925000>;
+			opp-microvolt-speed14-pvs0 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <962500 962500 987500>;
+			opp-microvolt-speed14-pvs1 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <987500 962500 1012500>;
+			opp-microvolt-speed14-pvs2 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <950000 925000 975000>;
+			opp-microvolt-speed14-pvs3 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <925000 900000 950000>;
+			opp-microvolt-speed14-pvs4 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <900000 875000 925000>;
+			opp-microvolt-speed14-pvs5 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <875000 875000 875000>;
+			opp-microvolt-speed14-pvs6 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <900000 875000 925000>;
 			opp-supported-hw = <0x4007>;
 		};
 
 		opp-810000000 {
 			opp-hz = /bits/ 64 <810000000>;
 			opp-peak-kBps = <648000>;
+			opp-microvolt-speed0-pvs0 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <1075000 1075000 1100000>;
+			opp-microvolt-speed0-pvs1 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <1050000 1025000 1075000>;
+			opp-microvolt-speed0-pvs3 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <1000000 975000 1025000>;
+			opp-microvolt-speed0-pvs4 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <987500 962500 1012500>;
+			opp-microvolt-speed1-pvs0 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <1000000 1000000 1025000>;
+			opp-microvolt-speed1-pvs1 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <1000000 975000 1025000>;
+			opp-microvolt-speed1-pvs2 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <962500 937500 987500>;
+			opp-microvolt-speed1-pvs3 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <925000 900000 950000>;
+			opp-microvolt-speed1-pvs4 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <912500 887500 937500>;
+			opp-microvolt-speed1-pvs5 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <912500 887500 937500>;
+			opp-microvolt-speed1-pvs6 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <912500 887500 937500>;
+			opp-microvolt-speed2-pvs0 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <962500 962500 987500>;
+			opp-microvolt-speed2-pvs1 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <937500 937500 937500>;
+			opp-microvolt-speed2-pvs2 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <937500 912500 962500>;
+			opp-microvolt-speed2-pvs3 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <925000 900000 950000>;
+			opp-microvolt-speed2-pvs4 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <912500 887500 937500>;
+			opp-microvolt-speed2-pvs5 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <912500 887500 937500>;
+			opp-microvolt-speed2-pvs6 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <912500 887500 937500>;
+			opp-microvolt-speed14-pvs0 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <1000000 1000000 1025000>;
+			opp-microvolt-speed14-pvs1 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <1000000 975000 1025000>;
+			opp-microvolt-speed14-pvs2 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <962500 937500 987500>;
+			opp-microvolt-speed14-pvs3 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <925000 900000 950000>;
+			opp-microvolt-speed14-pvs4 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <912500 887500 937500>;
+			opp-microvolt-speed14-pvs5 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <887500 887500 887500>;
+			opp-microvolt-speed14-pvs6 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <912500 887500 937500>;
 			opp-supported-hw = <0x4007>;
 		};
 
 		opp-918000000 {
 			opp-hz = /bits/ 64 <918000000>;
 			opp-peak-kBps = <648000>;
+			opp-microvolt-speed0-pvs0 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <1100000 1100000 1125000>;
+			opp-microvolt-speed0-pvs1 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <1075000 1050000 1100000>;
+			opp-microvolt-speed0-pvs3 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <1025000 1000000 1050000>;
+			opp-microvolt-speed0-pvs4 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <1000000 975000 1025000>;
+			opp-microvolt-speed1-pvs0 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <1025000 1025000 1050000>;
+			opp-microvolt-speed1-pvs1 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <1025000 1000000 1050000>;
+			opp-microvolt-speed1-pvs2 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <975000 950000 1000000>;
+			opp-microvolt-speed1-pvs3 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <950000 925000 975000>;
+			opp-microvolt-speed1-pvs4 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <925000 900000 950000>;
+			opp-microvolt-speed1-pvs5 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <925000 900000 950000>;
+			opp-microvolt-speed1-pvs6 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <925000 900000 950000>;
+			opp-microvolt-speed2-pvs0 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <975000 975000 1000000>;
+			opp-microvolt-speed2-pvs1 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <950000 950000 950000>;
+			opp-microvolt-speed2-pvs2 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <950000 925000 975000>;
+			opp-microvolt-speed2-pvs3 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <937500 912500 962500>;
+			opp-microvolt-speed2-pvs4 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <925000 900000 950000>;
+			opp-microvolt-speed2-pvs5 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <925000 900000 950000>;
+			opp-microvolt-speed2-pvs6 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <925000 900000 950000>;
+			opp-microvolt-speed14-pvs0 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <1025000 1025000 1050000>;
+			opp-microvolt-speed14-pvs1 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <1025000 1000000 1050000>;
+			opp-microvolt-speed14-pvs2 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <975000 950000 1000000>;
+			opp-microvolt-speed14-pvs3 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <950000 925000 975000>;
+			opp-microvolt-speed14-pvs4 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <925000 900000 950000>;
+			opp-microvolt-speed14-pvs5 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <900000 900000 900000>;
+			opp-microvolt-speed14-pvs6 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <925000 900000 950000>;
 			opp-supported-hw = <0x4007>;
 		};
 
 		opp-1026000000 {
 			opp-hz = /bits/ 64 <1026000000>;
 			opp-peak-kBps = <648000>;
+			opp-microvolt-speed0-pvs0 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <1125000 1125000 1150000>;
+			opp-microvolt-speed0-pvs1 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <1100000 1075000 1125000>;
+			opp-microvolt-speed0-pvs3 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <1050000 1025000 1075000>;
+			opp-microvolt-speed0-pvs4 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <1025000 1000000 1050000>;
+			opp-microvolt-speed1-pvs0 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <1037500 1037500 1062500>;
+			opp-microvolt-speed1-pvs1 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <1037500 1012500 1062500>;
+			opp-microvolt-speed1-pvs2 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <1000000 975000 1025000>;
+			opp-microvolt-speed1-pvs3 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <975000 950000 1000000>;
+			opp-microvolt-speed1-pvs4 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <950000 925000 975000>;
+			opp-microvolt-speed1-pvs5 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <950000 925000 975000>;
+			opp-microvolt-speed1-pvs6 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <950000 925000 975000>;
+			opp-microvolt-speed2-pvs0 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <1000000 1000000 1025000>;
+			opp-microvolt-speed2-pvs1 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <975000 975000 975000>;
+			opp-microvolt-speed2-pvs2 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <975000 950000 1000000>;
+			opp-microvolt-speed2-pvs3 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <962500 937500 987500>;
+			opp-microvolt-speed2-pvs4 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <950000 925000 975000>;
+			opp-microvolt-speed2-pvs5 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <950000 925000 975000>;
+			opp-microvolt-speed2-pvs6 = <1050000 1050000 1150000>,
+						    <1050000 1050000 1150000>,
+						    <950000 925000 975000>;
+			opp-microvolt-speed14-pvs0 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <1037500 1037500 1062500>;
+			opp-microvolt-speed14-pvs1 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <1037500 1012500 1062500>;
+			opp-microvolt-speed14-pvs2 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <1000000 975000 1025000>;
+			opp-microvolt-speed14-pvs3 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <975000 950000 1000000>;
+			opp-microvolt-speed14-pvs4 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <950000 925000 975000>;
+			opp-microvolt-speed14-pvs5 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <925000 925000 925000>;
+			opp-microvolt-speed14-pvs6 = <1050000 1050000 1150000>,
+						     <1050000 1050000 1150000>,
+						     <950000 925000 975000>;
 			opp-supported-hw = <0x4007>;
 		};
 
 		opp-1134000000 {
 			opp-hz = /bits/ 64 <1134000000>;
 			opp-peak-kBps = <1134000>;
+			opp-microvolt-speed0-pvs0 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1175000 1175000 1200000>;
+			opp-microvolt-speed0-pvs1 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1150000 1125000 1175000>;
+			opp-microvolt-speed0-pvs3 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1100000 1075000 1125000>;
+			opp-microvolt-speed0-pvs4 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1075000 1050000 1100000>;
+			opp-microvolt-speed1-pvs0 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1075000 1075000 1100000>;
+			opp-microvolt-speed1-pvs1 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1062500 1037500 1087500>;
+			opp-microvolt-speed1-pvs2 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1025000 1000000 1050000>;
+			opp-microvolt-speed1-pvs3 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1000000 975000 1025000>;
+			opp-microvolt-speed1-pvs4 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <975000 950000 1000000>;
+			opp-microvolt-speed1-pvs5 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <962500 937500 987500>;
+			opp-microvolt-speed1-pvs6 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <962500 937500 987500>;
+			opp-microvolt-speed2-pvs0 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1025000 1025000 1050000>;
+			opp-microvolt-speed2-pvs1 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1000000 1000000 1000000>;
+			opp-microvolt-speed2-pvs2 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1000000 975000 1025000>;
+			opp-microvolt-speed2-pvs3 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <987500 962500 1012500>;
+			opp-microvolt-speed2-pvs4 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <975000 950000 1000000>;
+			opp-microvolt-speed2-pvs5 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <962500 937500 987500>;
+			opp-microvolt-speed2-pvs6 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <962500 937500 987500>;
+			opp-microvolt-speed14-pvs0 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <1075000 1075000 1100000>;
+			opp-microvolt-speed14-pvs1 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <1062500 1037500 1087500>;
+			opp-microvolt-speed14-pvs2 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <1025000 1000000 1050000>;
+			opp-microvolt-speed14-pvs3 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <1000000 975000 1025000>;
+			opp-microvolt-speed14-pvs4 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <975000 950000 1000000>;
+			opp-microvolt-speed14-pvs5 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <937500 937500 937500>;
+			opp-microvolt-speed14-pvs6 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <962500 937500 987500>;
 			opp-supported-hw = <0x4007>;
 		};
 
 		opp-1242000000 {
 			opp-hz = /bits/ 64 <1242000000>;
 			opp-peak-kBps = <1134000>;
+			opp-microvolt-speed0-pvs0 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1200000 1200000 1225000>;
+			opp-microvolt-speed0-pvs1 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1175000 1150000 1200000>;
+			opp-microvolt-speed0-pvs3 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1125000 1100000 1150000>;
+			opp-microvolt-speed0-pvs4 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1100000 1075000 1125000>;
+			opp-microvolt-speed1-pvs0 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1087500 1087500 1112500>;
+			opp-microvolt-speed1-pvs1 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1075000 1050000 1100000>;
+			opp-microvolt-speed1-pvs2 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1037500 1012500 1062500>;
+			opp-microvolt-speed1-pvs3 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1012500 987500 1037500>;
+			opp-microvolt-speed1-pvs4 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <987500 962500 1012500>;
+			opp-microvolt-speed1-pvs5 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <975000 950000 1000000>;
+			opp-microvolt-speed1-pvs6 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <975000 950000 1000000>;
+			opp-microvolt-speed2-pvs0 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1037500 1037500 1062500>;
+			opp-microvolt-speed2-pvs1 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1012500 1012500 1012500>;
+			opp-microvolt-speed2-pvs2 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1012500 987500 1037500>;
+			opp-microvolt-speed2-pvs3 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1000000 975000 1025000>;
+			opp-microvolt-speed2-pvs4 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <987500 962500 1012500>;
+			opp-microvolt-speed2-pvs5 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <975000 950000 1000000>;
+			opp-microvolt-speed2-pvs6 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <975000 950000 1000000>;
+			opp-microvolt-speed14-pvs0 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <1087500 1087500 1112500>;
+			opp-microvolt-speed14-pvs1 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <1075000 1050000 1100000>;
+			opp-microvolt-speed14-pvs2 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <1037500 1012500 1062500>;
+			opp-microvolt-speed14-pvs3 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <1012500 987500 1037500>;
+			opp-microvolt-speed14-pvs4 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <987500 962500 1012500>;
+			opp-microvolt-speed14-pvs5 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <950000 950000 950000>;
+			opp-microvolt-speed14-pvs6 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <975000 950000 1000000>;
 			opp-supported-hw = <0x4007>;
 		};
 
 		opp-1350000000 {
 			opp-hz = /bits/ 64 <1350000000>;
 			opp-peak-kBps = <1134000>;
+			opp-microvolt-speed0-pvs0 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1225000 1225000 1250000>;
+			opp-microvolt-speed0-pvs1 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1200000 1175000 1225000>;
+			opp-microvolt-speed0-pvs3 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1150000 1125000 1175000>;
+			opp-microvolt-speed0-pvs4 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1125000 1100000 1150000>;
+			opp-microvolt-speed1-pvs0 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1125000 1125000 1150000>;
+			opp-microvolt-speed1-pvs1 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1112500 1087500 1137500>;
+			opp-microvolt-speed1-pvs2 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1062500 1037500 1087500>;
+			opp-microvolt-speed1-pvs3 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1025000 1000000 1050000>;
+			opp-microvolt-speed1-pvs4 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1000000 975000 1025000>;
+			opp-microvolt-speed1-pvs5 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <987500 962500 1012500>;
+			opp-microvolt-speed1-pvs6 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <987500 962500 1012500>;
+			opp-microvolt-speed2-pvs0 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1062500 1062500 1087500>;
+			opp-microvolt-speed2-pvs1 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1037500 1037500 1037500>;
+			opp-microvolt-speed2-pvs2 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1037500 1012500 1062500>;
+			opp-microvolt-speed2-pvs3 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1025000 1000000 1050000>;
+			opp-microvolt-speed2-pvs4 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1000000 975000 1025000>;
+			opp-microvolt-speed2-pvs5 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <987500 962500 1012500>;
+			opp-microvolt-speed2-pvs6 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <987500 962500 1012500>;
+			opp-microvolt-speed14-pvs0 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <1125000 1125000 1150000>;
+			opp-microvolt-speed14-pvs1 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <1112500 1087500 1137500>;
+			opp-microvolt-speed14-pvs2 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <1062500 1037500 1087500>;
+			opp-microvolt-speed14-pvs3 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <1025000 1000000 1050000>;
+			opp-microvolt-speed14-pvs4 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <1000000 975000 1025000>;
+			opp-microvolt-speed14-pvs5 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <962500 962500 962500>;
+			opp-microvolt-speed14-pvs6 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <987500 962500 1012500>;
 			opp-supported-hw = <0x4007>;
 		};
 
 		opp-1458000000 {
 			opp-hz = /bits/ 64 <1458000000>;
 			opp-peak-kBps = <1134000>;
+			opp-microvolt-speed0-pvs0 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1237500 1237500 1262500>;
+			opp-microvolt-speed0-pvs1 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1212500 1187500 1237500>;
+			opp-microvolt-speed0-pvs3 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1162500 1137500 1187500>;
+			opp-microvolt-speed0-pvs4 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1137500 1112500 1162500>;
+			opp-microvolt-speed1-pvs0 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1150000 1150000 1175000>;
+			opp-microvolt-speed1-pvs1 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1137500 1112500 1162500>;
+			opp-microvolt-speed1-pvs2 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1100000 1075000 1125000>;
+			opp-microvolt-speed1-pvs3 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1062500 1037500 1087500>;
+			opp-microvolt-speed1-pvs4 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1025000 1000000 1050000>;
+			opp-microvolt-speed1-pvs5 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1012500 987500 1037500>;
+			opp-microvolt-speed1-pvs6 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1000000 975000 1025000>;
+			opp-microvolt-speed2-pvs0 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1100000 1100000 1125000>;
+			opp-microvolt-speed2-pvs1 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1075000 1075000 1075000>;
+			opp-microvolt-speed2-pvs2 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1075000 1050000 1100000>;
+			opp-microvolt-speed2-pvs3 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1050000 1025000 1075000>;
+			opp-microvolt-speed2-pvs4 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1025000 1000000 1050000>;
+			opp-microvolt-speed2-pvs5 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1012500 987500 1037500>;
+			opp-microvolt-speed2-pvs6 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1000000 975000 1025000>;
+			opp-microvolt-speed14-pvs0 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <1150000 1150000 1175000>;
+			opp-microvolt-speed14-pvs1 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <1137500 1112500 1162500>;
+			opp-microvolt-speed14-pvs2 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <1100000 1075000 1125000>;
+			opp-microvolt-speed14-pvs3 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <1062500 1037500 1087500>;
+			opp-microvolt-speed14-pvs4 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <1025000 1000000 1050000>;
+			opp-microvolt-speed14-pvs5 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <987500 987500 987500>;
+			opp-microvolt-speed14-pvs6 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <1000000 975000 1025000>;
 			opp-supported-hw = <0x4007>;
 		};
 
 		opp-1512000000 {
 			opp-hz = /bits/ 64 <1512000000>;
 			opp-peak-kBps = <1134000>;
+			opp-microvolt-speed0-pvs0 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1250000 1250000 1275000>;
+			opp-microvolt-speed0-pvs1 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1225000 1200000 1250000>;
+			opp-microvolt-speed0-pvs3 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1175000 1150000 1200000>;
+			opp-microvolt-speed0-pvs4 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1150000 1125000 1175000>;
+			opp-microvolt-speed14-pvs0 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <1162500 1162500 1187500>;
+			opp-microvolt-speed14-pvs1 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <1150000 1125000 1175000>;
+			opp-microvolt-speed14-pvs2 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <1112500 1087500 1137500>;
+			opp-microvolt-speed14-pvs3 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <1075000 1050000 1100000>;
+			opp-microvolt-speed14-pvs4 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <1037500 1012500 1062500>;
+			opp-microvolt-speed14-pvs5 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <1000000 1000000 1000000>;
+			opp-microvolt-speed14-pvs6 = <1150000 1150000 1150000>,
+						     <1150000 1150000 1150000>,
+						     <1012500 987500 1037500>;
 			opp-supported-hw = <0x4001>;
 		};
 
 		opp-1566000000 {
 			opp-hz = /bits/ 64 <1566000000>;
 			opp-peak-kBps = <1134000>;
+			opp-microvolt-speed1-pvs0 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1175000 1175000 1200000>;
+			opp-microvolt-speed1-pvs1 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1175000 1150000 1200000>;
+			opp-microvolt-speed1-pvs2 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1125000 1100000 1150000>;
+			opp-microvolt-speed1-pvs3 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1087500 1062500 1112500>;
+			opp-microvolt-speed1-pvs4 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1062500 1037500 1087500>;
+			opp-microvolt-speed1-pvs5 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1037500 1012500 1062500>;
+			opp-microvolt-speed1-pvs6 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1025000 1000000 1050000>;
+			opp-microvolt-speed2-pvs0 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1125000 1125000 1150000>;
+			opp-microvolt-speed2-pvs1 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1100000 1100000 1100000>;
+			opp-microvolt-speed2-pvs2 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1100000 1075000 1125000>;
+			opp-microvolt-speed2-pvs3 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1075000 1050000 1100000>;
+			opp-microvolt-speed2-pvs4 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1062500 1037500 1087500>;
+			opp-microvolt-speed2-pvs5 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1037500 1012500 1062500>;
+			opp-microvolt-speed2-pvs6 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1025000 1000000 1050000>;
 			opp-supported-hw = <0x06>;
 		};
 
 		opp-1674000000 {
 			opp-hz = /bits/ 64 <1674000000>;
 			opp-peak-kBps = <1134000>;
+			opp-microvolt-speed1-pvs0 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1225000 1225000 1250000>;
+			opp-microvolt-speed1-pvs1 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1212500 1187500 1237500>;
+			opp-microvolt-speed1-pvs2 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1162500 1137500 1187500>;
+			opp-microvolt-speed1-pvs3 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1125000 1100000 1150000>;
+			opp-microvolt-speed1-pvs4 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1100000 1075000 1125000>;
+			opp-microvolt-speed1-pvs5 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1075000 1050000 1100000>;
+			opp-microvolt-speed1-pvs6 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1050000 1025000 1075000>;
+			opp-microvolt-speed2-pvs0 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1175000 1175000 1200000>;
+			opp-microvolt-speed2-pvs1 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1137500 1137500 1137500>;
+			opp-microvolt-speed2-pvs2 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1137500 1112500 1162500>;
+			opp-microvolt-speed2-pvs3 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1112500 1087500 1137500>;
+			opp-microvolt-speed2-pvs4 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1100000 1075000 1125000>;
+			opp-microvolt-speed2-pvs5 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1075000 1050000 1100000>;
+			opp-microvolt-speed2-pvs6 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1050000 1025000 1075000>;
 			opp-supported-hw = <0x06>;
 		};
 
 		opp-1728000000 {
 			opp-hz = /bits/ 64 <1728000000>;
 			opp-peak-kBps = <1134000>;
+			opp-microvolt-speed1-pvs0 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1250000 1250000 1275000>;
+			opp-microvolt-speed1-pvs1 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1225000 1200000 1250000>;
+			opp-microvolt-speed1-pvs2 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1187500 1162500 1212500>;
+			opp-microvolt-speed1-pvs3 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1150000 1125000 1175000>;
+			opp-microvolt-speed1-pvs4 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1125000 1100000 1150000>;
+			opp-microvolt-speed1-pvs5 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1100000 1075000 1125000>;
+			opp-microvolt-speed1-pvs6 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1075000 1050000 1100000>;
 			opp-supported-hw = <0x02>;
 		};
 
 		opp-1782000000 {
 			opp-hz = /bits/ 64 <1782000000>;
 			opp-peak-kBps = <1134000>;
+			opp-microvolt-speed2-pvs0 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1225000 1225000 1250000>;
+			opp-microvolt-speed2-pvs1 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1187500 1187500 1187500>;
+			opp-microvolt-speed2-pvs2 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1187500 1162500 1212500>;
+			opp-microvolt-speed2-pvs3 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1162500 1137500 1187500>;
+			opp-microvolt-speed2-pvs4 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1137500 1112500 1162500>;
+			opp-microvolt-speed2-pvs5 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1112500 1087500 1137500>;
+			opp-microvolt-speed2-pvs6 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1087500 1062500 1112500>;
 			opp-supported-hw = <0x04>;
 		};
 
 		opp-1890000000 {
 			opp-hz = /bits/ 64 <1890000000>;
 			opp-peak-kBps = <1134000>;
+			opp-microvolt-speed2-pvs0 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1287500 1287500 1312500>;
+			opp-microvolt-speed2-pvs1 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1250000 1250000 1250000>;
+			opp-microvolt-speed2-pvs2 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1237500 1212500 1262500>;
+			opp-microvolt-speed2-pvs3 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1200000 1175000 1225000>;
+			opp-microvolt-speed2-pvs4 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1175000 1150000 1200000>;
+			opp-microvolt-speed2-pvs5 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1150000 1125000 1175000>;
+			opp-microvolt-speed2-pvs6 = <1150000 1150000 1150000>,
+						    <1150000 1150000 1150000>,
+						    <1125000 1100000 1150000>;
 			opp-supported-hw = <0x04>;
 		};
 	};
-- 
2.39.2

