Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A84773D3FF
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jun 2023 22:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjFYU0U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Jun 2023 16:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjFYU0R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jun 2023 16:26:17 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE81EE6E
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 13:26:07 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b69f1570b2so5998991fa.0
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 13:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687724765; x=1690316765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKE3g0UJWhZa4QrFOZ6bHQIbP2SVYg/SCb948WpDA90=;
        b=GLrhEEnfLA6qYHsbLDgezhipxN7Qa+h+r7adezGX2lRHN3R+DDQXZNJowP1zm0kmGu
         aIbrpy8Oj1xxtR6/qW+URQRpyTIDA0K9OTg0/nZRZH933T32lM6oRJLmmZTvULSZK47S
         kJMOWPJhL9dr+fL8lqw9a0tLxRg3wZCqLqC6SkLDq5ak2Gvq7J1YpGCTCqfGPeB/0aLi
         1u0DSHcL3SJXm+vTlz6zFNTiUa2PZu98qvhiAiLZ1zTfbnjUCcqHeSR8q/6gyAcfKGL9
         EYNUom1pDBjcbGGHnylUs0zYf6UiY9T5ovKwRTuFFCmBaHvpK7wNZpOuWBC5Ir0J1kva
         9TLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687724765; x=1690316765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKE3g0UJWhZa4QrFOZ6bHQIbP2SVYg/SCb948WpDA90=;
        b=KPlCWeAhe+XuFRytKh0oqG2NtgJJLmsecslpgEKlmv/uSVwdRpbBIwrauNFQE10+QG
         DRtH0DBHV32JSFLuHDAVMawHHcaifpzbQeeme12aZYQ9aJpeuEU7DUABkjgA++yJS4HF
         u0Tqg6TDEsSpgLg4o4gC0t24neJ+K6XVIeo0KP7IwRC3v9ckWvOwzCgbI87taRO4T5ud
         ueaVeF5iu4CziKbXzuD0pGDqfQudLkqXsj1e3gULIyllMyxUgVvxOmaDnKbEUrcG8lPd
         ETDnpgemAene7+S8wXatpDgDC+Z5KYgh4c+Ps/kirQ1+4MXPYR5GQ14Y/368J8xCvAHh
         +ddQ==
X-Gm-Message-State: AC+VfDz2sHtV8Rful1IbFsUA8KJaJdESAGUP9/EiIaYu/xrUvxLw+CTT
        AeOvjCiixERQ9yfA8KUTF6ZQtA==
X-Google-Smtp-Source: ACHHUZ6wO5VTI/8OR4horOdY3hmSu3bRORLH81QRycjgikVkFd34GvIPEMHlEb7QKMvrtmDrMRIBmQ==
X-Received: by 2002:a19:4f01:0:b0:4f8:6ac1:15a9 with SMTP id d1-20020a194f01000000b004f86ac115a9mr12534675lfb.31.1687724765682;
        Sun, 25 Jun 2023 13:26:05 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id m21-20020a195215000000b004f8427f8716sm787537lfb.262.2023.06.25.13.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 13:26:05 -0700 (PDT)
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
Subject: [PATCH v2 18/26] ARM: dts: qcom: apq8064: provide voltage scaling tables
Date:   Sun, 25 Jun 2023 23:25:39 +0300
Message-Id: <20230625202547.174647-19-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
References: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
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
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 339 +++++++++++++++++++++++
 1 file changed, 339 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index e4d2fd48d843..b97d88517805 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -50,6 +50,7 @@ CPU0: cpu@0 {
 			clocks = <&kraitcc KRAIT_CPU_0>;
 			clock-names = "cpu";
 			clock-latency = <100000>;
+			vdd-core-supply = <&saw0_vreg>;
 			interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
@@ -67,6 +68,7 @@ CPU1: cpu@1 {
 			clocks = <&kraitcc KRAIT_CPU_1>;
 			clock-names = "cpu";
 			clock-latency = <100000>;
+			vdd-core-supply = <&saw1_vreg>;
 			interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
@@ -84,6 +86,7 @@ CPU2: cpu@2 {
 			clocks = <&kraitcc KRAIT_CPU_2>;
 			clock-names = "cpu";
 			clock-latency = <100000>;
+			vdd-core-supply = <&saw2_vreg>;
 			interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
@@ -101,6 +104,7 @@ CPU3: cpu@3 {
 			clocks = <&kraitcc KRAIT_CPU_3>;
 			clock-names = "cpu";
 			clock-latency = <100000>;
+			vdd-core-supply = <&saw3_vreg>;
 			interconnects = <&L2 MASTER_KRAIT_L2 &L2 SLAVE_KRAIT_L2>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
@@ -232,6 +236,31 @@ cpu_opp_table: opp-table-cpu {
 		opp-384000000 {
 			opp-hz = /bits/ 64 <384000000>;
 			opp-peak-kBps = <384000>;
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
 			opp-supported-hw = <0x4007>;
 			/*
 			 * higher latency as it requires switching between
@@ -243,96 +272,406 @@ opp-384000000 {
 		opp-486000000 {
 			opp-hz = /bits/ 64 <486000000>;
 			opp-peak-kBps = <648000>;
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
 			opp-supported-hw = <0x4007>;
 		};
 
 		opp-594000000 {
 			opp-hz = /bits/ 64 <594000000>;
 			opp-peak-kBps = <648000>;
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
 			opp-supported-hw = <0x4007>;
 		};
 
 		opp-702000000 {
 			opp-hz = /bits/ 64 <702000000>;
 			opp-peak-kBps = <648000>;
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
 			opp-supported-hw = <0x4007>;
 		};
 
 		opp-810000000 {
 			opp-hz = /bits/ 64 <810000000>;
 			opp-peak-kBps = <648000>;
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
 			opp-supported-hw = <0x4007>;
 		};
 
 		opp-918000000 {
 			opp-hz = /bits/ 64 <918000000>;
 			opp-peak-kBps = <648000>;
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
+			opp-microvolt-speed3-pvs4 = <925000 900000 950000>;
+			opp-microvolt-speed2-pvs5 = <925000 900000 950000>;
+			opp-microvolt-speed2-pvs6 = <925000 900000 950000>;
+			opp-microvolt-speed14-pvs0 = <1025000 1025000 1050000>;
+			opp-microvolt-speed14-pvs1 = <1025000 1000000 1050000>;
+			opp-microvolt-speed14-pvs2 = <975000 950000 1000000>;
+			opp-microvolt-speed14-pvs3 = <950000 925000 975000>;
+			opp-microvolt-speed14-pvs4 = <925000 900000 950000>;
+			opp-microvolt-speed14-pvs5 = <900000 900000 900000>;
+			opp-microvolt-speed14-pvs6 = <925000 900000 950000>;
 			opp-supported-hw = <0x4007>;
 		};
 
 		opp-1026000000 {
 			opp-hz = /bits/ 64 <1026000000>;
 			opp-peak-kBps = <648000>;
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
 			opp-supported-hw = <0x4007>;
 		};
 
 		opp-1134000000 {
 			opp-hz = /bits/ 64 <1134000000>;
 			opp-peak-kBps = <1134000>;
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
 			opp-supported-hw = <0x4007>;
 		};
 
 		opp-1242000000 {
 			opp-hz = /bits/ 64 <1242000000>;
 			opp-peak-kBps = <1134000>;
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
 			opp-supported-hw = <0x4007>;
 		};
 
 		opp-1350000000 {
 			opp-hz = /bits/ 64 <1350000000>;
 			opp-peak-kBps = <1134000>;
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
 			opp-supported-hw = <0x4007>;
 		};
 
 		opp-1458000000 {
 			opp-hz = /bits/ 64 <1458000000>;
 			opp-peak-kBps = <1134000>;
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
 			opp-supported-hw = <0x4007>;
 		};
 
 		opp-1512000000 {
 			opp-hz = /bits/ 64 <1512000000>;
 			opp-peak-kBps = <1134000>;
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
 			opp-supported-hw = <0x4001>;
 		};
 
 		opp-1566000000 {
 			opp-hz = /bits/ 64 <1566000000>;
 			opp-peak-kBps = <1134000>;
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
 			opp-supported-hw = <0x06>;
 		};
 
 		opp-1674000000 {
 			opp-hz = /bits/ 64 <1674000000>;
 			opp-peak-kBps = <1134000>;
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
 			opp-supported-hw = <0x06>;
 		};
 
 		opp-1728000000 {
 			opp-hz = /bits/ 64 <1728000000>;
 			opp-peak-kBps = <1134000>;
+			opp-microvolt-speed1-pvs0 = <1250000 1250000 1275000>;
+			opp-microvolt-speed1-pvs1 = <1225000 1200000 1250000>;
+			opp-microvolt-speed1-pvs2 = <1187500 1162500 1212500>;
+			opp-microvolt-speed1-pvs3 = <1150000 1125000 1175000>;
+			opp-microvolt-speed1-pvs4 = <1125000 1100000 1150000>;
+			opp-microvolt-speed1-pvs5 = <1100000 1075000 1125000>;
+			opp-microvolt-speed1-pvs6 = <1075000 1050000 1100000>;
 			opp-supported-hw = <0x02>;
 		};
 
 		opp-1782000000 {
 			opp-hz = /bits/ 64 <1782000000>;
 			opp-peak-kBps = <1134000>;
+			opp-microvolt-speed2-pvs0 = <1225000 1225000 1250000>;
+			opp-microvolt-speed2-pvs1 = <1187500 1187500 1187500>;
+			opp-microvolt-speed2-pvs2 = <1187500 1162500 1212500>;
+			opp-microvolt-speed2-pvs3 = <1162500 1137500 1187500>;
+			opp-microvolt-speed2-pvs4 = <1137500 1112500 1162500>;
+			opp-microvolt-speed2-pvs5 = <1112500 1087500 1137500>;
+			opp-microvolt-speed2-pvs6 = <1087500 1062500 1112500>;
 			opp-supported-hw = <0x04>;
 		};
 
 		opp-1890000000 {
 			opp-hz = /bits/ 64 <1890000000>;
 			opp-peak-kBps = <1134000>;
+			opp-microvolt-speed2-pvs0 = <1287500 1287500 1312500>;
+			opp-microvolt-speed2-pvs1 = <1250000 1250000 1250000>;
+			opp-microvolt-speed2-pvs2 = <1237500 1212500 1262500>;
+			opp-microvolt-speed2-pvs3 = <1200000 1175000 1225000>;
+			opp-microvolt-speed2-pvs4 = <1175000 1150000 1200000>;
+			opp-microvolt-speed2-pvs5 = <1150000 1125000 1175000>;
+			opp-microvolt-speed2-pvs6 = <1125000 1100000 1150000>;
 			opp-supported-hw = <0x04>;
 		};
 	};
-- 
2.39.2

