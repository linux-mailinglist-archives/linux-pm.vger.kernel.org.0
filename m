Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53616AA4B7
	for <lists+linux-pm@lfdr.de>; Fri,  3 Mar 2023 23:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjCCWnx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Mar 2023 17:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjCCWnw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Mar 2023 17:43:52 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9125F11E9E
        for <linux-pm@vger.kernel.org>; Fri,  3 Mar 2023 14:43:20 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id k14so5494867lfj.7
        for <linux-pm@vger.kernel.org>; Fri, 03 Mar 2023 14:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677883319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQ4P/+hX2P6pikGGe2JrqWC+XZ4kPlYMVKBCWOIvu90=;
        b=h45vhdeOpKc2c5NVH6tbtG+Gfk3rBOmhep3BKsP9kdN4rIHvAD2Da0+lZxJKY8BKHn
         UlGAzhpkvcxPcPeO1J5NmGPyjwQfjC/fFwe3B9peF8OPUN48ajFH3UBOrkinliePqmho
         b5CnOJv65xOKBP6LQVjaW71kJQPQEu0u+51q4zeDaUOGsgcoTsFBmZ0YxNkrBamvs4SA
         QVxFGpDi7w0bJcdsDWWwGvt/XLLLEvvGxpyTwJ1dQqcEAYAm/EmVyJT6/DkE/Vq2Exlq
         UO9+ekfQ74NUbT3wpMxhT+uQhc5A38lOhUONPzIcvdA/rGtmVBAjxWihrV0GI02XTXyY
         u9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677883319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQ4P/+hX2P6pikGGe2JrqWC+XZ4kPlYMVKBCWOIvu90=;
        b=EpTVfTev0GOb2JQZb2PnsUMyl7BRwWE5r2a2ZDgdcYCRv/NRuKvCO2jrTP137oYMKT
         0d6D63xJffJVasmYvta2VWhXCwGnPLGIqTtYdN9fDOiW2rVW+3epPkgHjKICyoPqODg2
         YniUZAthnSHaLN6j6HF/ECZGdwEJrU48bXtDSxfGwdAqbmXikfWDnDbVYxKOCcSY3ADP
         1M9YKOUdnBPAagDr4o6wESCguMVn0Gw3Eenz8UajCS2wsDp1/0d9ReM+BrlncquS5VZy
         eC17e/GIq/5svg4KxRnbxX5j4sgRtviVE2xZelecK5rdypHoSSIds8QRMIUxpWSDfYXA
         UFqw==
X-Gm-Message-State: AO0yUKVCIalGlJcAb0yUEQUeEHVP6r4yf8JyUVY5pG8NJNnZLsCwI8Pe
        fX5HUptybMb5dspSfuihRoLxCxUwWfwgu3jrL1I=
X-Google-Smtp-Source: AK7set8JbxDAS54CalbP2WgixNwDWwcdFHlz3zpT4NUKQqMHsZiUw9hwQUWYwolhEtaE9qMOzuHq3g==
X-Received: by 2002:a19:ee06:0:b0:4de:7b5b:f16f with SMTP id g6-20020a19ee06000000b004de7b5bf16fmr1001238lfb.7.1677880709251;
        Fri, 03 Mar 2023 13:58:29 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id e27-20020ac2547b000000b004cafa01ebbfsm552670lfn.101.2023.03.03.13.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 13:58:28 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 03 Mar 2023 22:58:12 +0100
Subject: [PATCH 12/15] arm64: dts: qcom: sm6375: Introduce MPM support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-sm6375_features0_dts-v1-12-8c8d94fba6f0@linaro.org>
References: <20230303-topic-sm6375_features0_dts-v1-0-8c8d94fba6f0@linaro.org>
In-Reply-To: <20230303-topic-sm6375_features0_dts-v1-0-8c8d94fba6f0@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677880689; l=3281;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=iPa23Ps62e7Th5IYTb8Pdb0xoF/q147iZLwyUAl1QU0=;
 b=zPa/FrwPkdGsOQ4pHDIGF83/202i7LLx5FG4SCWhJkh9tsnmE3v3rmnziIAXgQyZ3UqQsSi2SsyM
 mbwdMHi7DxcP15g3E0/73AVlQwW29D+BP6tZEdF9l2y+LX6fqVbl
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a node for MPM and wire it up on consumers that use it. This also
fixes a very bad and sad assumption I made when initially porting this
SoC that the downstream MPM-TLMM mappings were 1-1. That apparently
changed some time ago, so with this patch the MPM consumers will actually
be hooked up to the correct interrupt lines.

Fixes: 59d34ca97f91 ("arm64: dts: qcom: Add initial device tree for SM6375")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 94bb373f8d97..ecb654357288 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -315,6 +315,7 @@ CPU_PD7: power-domain-cpu7 {
 
 		CLUSTER_PD: power-domain-cpu-cluster0 {
 			#power-domain-cells = <0>;
+			power-domains = <&wakegic>;
 			domain-idle-states = <&CLUSTER_SLEEP_0>;
 		};
 	};
@@ -633,7 +634,7 @@ tlmm: pinctrl@500000 {
 			reg = <0 0x00500000 0 0x800000>;
 			interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-ranges = <&tlmm 0 0 157>;
-			/* TODO: Hook up MPM as wakeup-parent when it's there */
+			wakeup-parent = <&wakegic>;
 			interrupt-controller;
 			gpio-controller;
 			#interrupt-cells = <2>;
@@ -755,7 +756,7 @@ spmi_bus: spmi@1c40000 {
 			      <0 0x01c0a000 0 0x26000>;
 			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
 			interrupt-names = "periph_irq";
-			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&wakegic 86 IRQ_TYPE_LEVEL_HIGH>;
 			qcom,ee = <0>;
 			qcom,channel = <0>;
 			#address-cells = <2>;
@@ -791,6 +792,25 @@ rpm_msg_ram: sram@45f0000 {
 			reg = <0 0x045f0000 0 0x7000>;
 		};
 
+		wakegic: interrupt-controller@45f01b8 {
+			compatible = "qcom,mpm";
+			reg = <0 0x045f01b8 0 0x1000>;
+			interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
+			mboxes = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_SMP2P>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			#power-domain-cells = <0>;
+			interrupt-parent = <&intc>;
+			qcom,mpm-pin-count = <96>;
+			qcom,mpm-pin-map = <5 296>,  /* Soundwire wake_irq */
+					   <12 422>, /* DWC3 ss_phy_irq */
+					   <86 183>, /* MPM wake, SPMI */
+					   <89 314>, /* TSENS0 0C */
+					   <90 315>, /* TSENS1 0C */
+					   <93 164>, /* DWC3 dm_hs_phy_irq */
+					   <94 165>; /* DWC3 dp_hs_phy_irq */
+		};
+
 		sram@4690000 {
 			compatible = "qcom,rpm-stats";
 			reg = <0 0x04690000 0 0x400>;
@@ -1185,10 +1205,10 @@ usb_1: usb@4ef8800 {
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <133333333>;
 
-			interrupts = <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&intc GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
+					      <&wakegic 12 IRQ_TYPE_LEVEL_HIGH>,
+					      <&wakegic 93 IRQ_TYPE_LEVEL_HIGH>,
+					      <&wakegic 94 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hs_phy_irq",
 					  "ss_phy_irq",
 					  "dm_hs_phy_irq",

-- 
2.39.2

