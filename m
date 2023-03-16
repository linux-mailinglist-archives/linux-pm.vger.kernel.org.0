Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D878B6BD215
	for <lists+linux-pm@lfdr.de>; Thu, 16 Mar 2023 15:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjCPOOP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Mar 2023 10:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjCPONq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Mar 2023 10:13:46 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8DEA7A88
        for <linux-pm@vger.kernel.org>; Thu, 16 Mar 2023 07:13:24 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id y14so1845015ljq.4
        for <linux-pm@vger.kernel.org>; Thu, 16 Mar 2023 07:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678976000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6AdYsLFAk7GgkF7fiDDRdxRqmxm5wdSTZ85GRpprjU=;
        b=L5G4BkcCQQ3qWBx58UenWCH8uRF2KAOucMIWCGobUlnaBxkcCFoYB4fNSmRu4t5R8C
         qs9tm0HRnf4xUq1jH3CfiLliaYrZR72tFohJ8OYKWjd12EqwGCvWJNfbKsXaXBL9Ju9x
         COBUN848cCxoLlOie3FI/L5fMQuru9gPFWy+0NtmfcBmTMgRa5Ps43ujMHle7NcK3ILr
         kgyZd+jo0+FeILXA0S/lWKDhGsoEbCpA2Ys+AV3XfuiNJRTYhojlyOSDrCJuPb81KYs3
         102i0jMVUR4q5zIvLp9YlV5AcSPkpW+S+hSbnMVFX50u/ri4mGxvo666vmchopDG1zHO
         NinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678976000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6AdYsLFAk7GgkF7fiDDRdxRqmxm5wdSTZ85GRpprjU=;
        b=ejYBe7IxO/gSPOn1+kpzR47ROmyDwPvpikngPZPeIm/6dP+LTfmYq9WLeY/ejRsvXO
         GWP+gimetRm92cr43hMnszKP0wFZEIK4nf7qlj5e5by3l234Ya/GofuFqtUMW4AvKS0L
         yjlBnVhCbjvtC9psw3X5GlNsywimGs6KM9QJHwkAwGA7hOBhZ4+hcIayEvuHihZuYWhr
         ctnqYWmYT4tYtL11a9rHjayCENmsPFrDYE08QKxEXmaU7vUGbI5FByUiysmLzPiuoC7u
         VIMq/D/CkVdDFbWhQq4UQBiQjaqFJz24IGdqO9AhszVer3nrhgWb9cwD/QD27LJ0Cj2c
         WMsw==
X-Gm-Message-State: AO0yUKW/Y7NWL/dxQn++ehx8QjKvz02/0jYldehFjRwzPo07eZ1euoAT
        pneoouRovM+fWhN+RPtQdB3m0Q==
X-Google-Smtp-Source: AK7set9adrDurFHD95SWFB+3SSZaYAHxChIhFIrIJ5rk5lDPpP6JAdvgokgCwDLdJynWy8PbWMb3UA==
X-Received: by 2002:a2e:b619:0:b0:295:8a9b:d8d6 with SMTP id r25-20020a2eb619000000b002958a9bd8d6mr2184422ljn.4.1678976000335;
        Thu, 16 Mar 2023 07:13:20 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id a9-20020a2eb549000000b00295735991edsm1261639ljn.38.2023.03.16.07.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 07:13:19 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 16 Mar 2023 15:13:01 +0100
Subject: [PATCH v2 12/14] arm64: dts: qcom: sm6375: Bump CPU rail power
 collapse index
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-sm6375_features0_dts-v2-12-708b8191f7eb@linaro.org>
References: <20230303-topic-sm6375_features0_dts-v2-0-708b8191f7eb@linaro.org>
In-Reply-To: <20230303-topic-sm6375_features0_dts-v2-0-708b8191f7eb@linaro.org>
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
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678975978; l=2856;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=bMhMpkixv2gywZqN6GGbDpn43h/PEoR+YDXz/nF/7ns=;
 b=7rN/tz92CykW7HvECEeCjTrmc2FRqehFj6zUdiN73Ux/RkFwDO4M+LKoIX79pRitRt2U43GpjNOz
 j6rD+WSTBa9+lU5IZleEnMSG4whRWhPmXCxSUOvP4fvLlxqC1TPU
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In preparation for supporting a less-deep sleep state, rename the
existing rail power off from _0 to _1.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 94bb373f8d97..d9b8c8b921be 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -207,7 +207,7 @@ core7 {
 		idle-states {
 			entry-method = "psci";
 
-			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
+			LITTLE_CPU_SLEEP_1: cpu-sleep-0-1 {
 				compatible = "arm,idle-state";
 				idle-state-name = "silver-rail-power-collapse";
 				arm,psci-suspend-param = <0x40000004>;
@@ -217,7 +217,7 @@ LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
 				local-timer-stop;
 			};
 
-			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
+			BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
 				compatible = "arm,idle-state";
 				idle-state-name = "gold-rail-power-collapse";
 				arm,psci-suspend-param = <0x40000004>;
@@ -268,49 +268,49 @@ psci {
 		CPU_PD0: power-domain-cpu0 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_1>;
 		};
 
 		CPU_PD1: power-domain-cpu1 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_1>;
 		};
 
 		CPU_PD2: power-domain-cpu2 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_1>;
 		};
 
 		CPU_PD3: power-domain-cpu3 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_1>;
 		};
 
 		CPU_PD4: power-domain-cpu4 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_1>;
 		};
 
 		CPU_PD5: power-domain-cpu5 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_1>;
 		};
 
 		CPU_PD6: power-domain-cpu6 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+			domain-idle-states = <&BIG_CPU_SLEEP_1>;
 		};
 
 		CPU_PD7: power-domain-cpu7 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+			domain-idle-states = <&BIG_CPU_SLEEP_1>;
 		};
 
 		CLUSTER_PD: power-domain-cpu-cluster0 {

-- 
2.39.2

