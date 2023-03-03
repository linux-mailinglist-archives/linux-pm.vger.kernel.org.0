Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821726AA41A
	for <lists+linux-pm@lfdr.de>; Fri,  3 Mar 2023 23:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjCCWVF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Mar 2023 17:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbjCCWUp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Mar 2023 17:20:45 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594AB65138
        for <linux-pm@vger.kernel.org>; Fri,  3 Mar 2023 14:12:47 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id o12so15886566edb.9
        for <linux-pm@vger.kernel.org>; Fri, 03 Mar 2023 14:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677881493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VobSYi7qd6A4yHO64hTT2lEY0pFxLrSpNBSai03mo5k=;
        b=okxdVz7zLb5yLzriW0YoD73loJHRwDX1eo5GEPZ78o1NUHg0PrmftFDMn1V+VzEQEL
         QLODosV3uXCYkCP+jires3bpg+VVppOVmopLQ6DSjPh8OpKNnBD7KEcuvE1fSQV0cajU
         ey4rmbNUNLkQky05cXqKEQEKJTCGcILYBH1mvdv+/tv8CWKdBt7iw46qAbP9dpKhTh/7
         kfSQ0JFDf6UxOoufx1Uj5nCgdLtcrcZLORqFMkhh3QxRxo2yqbp2DpGN7z0vQJnzrpL2
         5t6qCu+8kbAn5+PEM3FcmDSXnfw2w1+tm40Q5moILDZnSdpb+eEe9cTCL7C819jZd6QQ
         p3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677881493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VobSYi7qd6A4yHO64hTT2lEY0pFxLrSpNBSai03mo5k=;
        b=0EvO+Rt706ZiFfm9i5o8YNLeBG8MsaRej70n16dc1/26kJHWL/t2NCURJnIZnyLiUV
         ffJlftrKx8uKcndcpCd87ORD+vUPoCdFj6z02auLXjQTH5AXhpw5cuaEW5xzbkvcZm7K
         17xbUcnCrgLeZCxX2+UCSsJPu6zXr/WSB5AfQS2M/ugmSBzQw9t2vJLU3/tPNGhmHZZK
         rwtAW2sJJM1VG49RBcr/CoK3Y31unWz1l7A6WECxwBYqNImj4rDnYeKmvk2gOhkjPZTj
         eQPXdQDzKtTZciTD5arWHhbO9/4k5y9f/trlHUTGlYs8xnA+VGKv7iSo8m3mdCOIAwQp
         hrvw==
X-Gm-Message-State: AO0yUKWLwDDXWUUmYvStqx2AR5K/A+u0xoIyOsr1laKdb316bvnUrENJ
        MaYcv7/tVU11NvS6YCeVmfys2GI1GMtnWsA7W44=
X-Google-Smtp-Source: AK7set8MRIoaP0psz05Gh0nAwtNtBzJfMSfwrfMk4qPMD0jIxjJMmVURbHzalueJYxFoZUu8Aw7/0A==
X-Received: by 2002:ac2:522e:0:b0:4db:56e:427c with SMTP id i14-20020ac2522e000000b004db056e427cmr838136lfl.56.1677880712122;
        Fri, 03 Mar 2023 13:58:32 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id e27-20020ac2547b000000b004cafa01ebbfsm552670lfn.101.2023.03.03.13.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 13:58:31 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 03 Mar 2023 22:58:14 +0100
Subject: [PATCH 14/15] arm64: dts: qcom: sm6375: Introduce C3 power state
 for both ARM clusters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-sm6375_features0_dts-v1-14-8c8d94fba6f0@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677880689; l=3486;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=BoPm/b3+zv1C9oti+VeDmiDfZTtPEFlzg5/g/B0wkuM=;
 b=r1bhNl8KZSXM0Ex+wdQb5ZfkteY5xsSugf2fNelDZMgFcAYPBGdoIDJjokE8XJrDiDxGTrPSn3KA
 Wcb7o/30AXeoYYWSE+v6cDp0kLjcR1KnXuNsyGhet+Wv4Rlrcf9s
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce the C3 power state, which - to the best of my understanding -
gates the CPU clock, but does not shut off the power rail.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 05d8d6a012b6..5a6661dbde08 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -207,6 +207,16 @@ core7 {
 		idle-states {
 			entry-method = "psci";
 
+			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "silver-power-collapse";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <549>;
+				exit-latency-us = <901>;
+				min-residency-us = <1774>;
+				local-timer-stop;
+			};
+
 			LITTLE_CPU_SLEEP_1: cpu-sleep-0-1 {
 				compatible = "arm,idle-state";
 				idle-state-name = "silver-rail-power-collapse";
@@ -217,6 +227,16 @@ LITTLE_CPU_SLEEP_1: cpu-sleep-0-1 {
 				local-timer-stop;
 			};
 
+			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "gold-power-collapse";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <523>;
+				exit-latency-us = <1244>;
+				min-residency-us = <2207>;
+				local-timer-stop;
+			};
+
 			BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
 				compatible = "arm,idle-state";
 				idle-state-name = "gold-rail-power-collapse";
@@ -268,49 +288,49 @@ psci {
 		CPU_PD0: power-domain-cpu0 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_1>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 		};
 
 		CPU_PD1: power-domain-cpu1 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_1>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 		};
 
 		CPU_PD2: power-domain-cpu2 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_1>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 		};
 
 		CPU_PD3: power-domain-cpu3 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_1>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 		};
 
 		CPU_PD4: power-domain-cpu4 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_1>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 		};
 
 		CPU_PD5: power-domain-cpu5 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_1>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
 		};
 
 		CPU_PD6: power-domain-cpu6 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_1>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
 		};
 
 		CPU_PD7: power-domain-cpu7 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_1>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
 		};
 
 		CLUSTER_PD: power-domain-cpu-cluster0 {

-- 
2.39.2

