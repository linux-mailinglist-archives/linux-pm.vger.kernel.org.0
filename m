Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3CC6AA427
	for <lists+linux-pm@lfdr.de>; Fri,  3 Mar 2023 23:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjCCWVu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Mar 2023 17:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjCCWV0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Mar 2023 17:21:26 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E651365454
        for <linux-pm@vger.kernel.org>; Fri,  3 Mar 2023 14:13:39 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id u9so16048243edd.2
        for <linux-pm@vger.kernel.org>; Fri, 03 Mar 2023 14:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677881557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMUNS7sepBti40evG3v1VzCcdXq5T/S+i6PiT3G+pfs=;
        b=BNdKl/XOM1bZKxuepbMbMHFWUYDkRNDinqMw+NtyhTEfg8IAnyEF7gSJQuEn6lhwZf
         CJzTmN+ir9TAUu4cl2lHJLyv/eg8z0HZ1Pr1Bmo1NcqqT6/YH5XpaWK7ixzJGZJDcuUF
         AzzAKD1Ytb46dG1usZ+EnPTYlDPd3m7KuoXGgiNWZYbP3okSbCylCZsIiAtfa9fNSygB
         dhyc8/dILkUiH1X4Q7TA/66wCgeJc0qesWDC5uxNLCG2rfvmgEW64Yi6iepGMhCH2yF/
         LTNvN+5BXjujwjlEgLCZHw5TSDlFxIwUfe8d+rQEnr2yZb6GQB6yHT9Ug0EkFXjx5xpq
         t+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677881557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMUNS7sepBti40evG3v1VzCcdXq5T/S+i6PiT3G+pfs=;
        b=AycuFf4SVTU4O1EOg0CkFyY3Pj+ihYC46Lok7Ee2LKjkrs3YVGjw4H9fKDHbzHzn+g
         hsAi7Z6TSBEMI+JEN9mAju3A++8cfVmI6Yiaum7mF3BHeoapxxjJ3+YqUAPQivJTppIq
         y/YAURi0zzqaedqqggLp0qwrz3FobQocoa1vmr8MeLIaT0pmJiaJ/r7M0jMKPwmT7sXR
         AJlsZ+daHnJSO9XAjJ5EGEqVfbc3qD0OyPrl6SGsDFArhvtWqAKT4JQzif9h/Ph80rwB
         pOSJZt7sWqA285i2sn/uV6OS60Lx7i6hZ+fzY481xxzwMEfEf5Eham/7HhNHMKj3tSjw
         SkIQ==
X-Gm-Message-State: AO0yUKW1t48TIH9+ma8U5hGLJ6210YygzEZiMAlfXytv8z+cSxnbSj9F
        kpzlhZfiDDMC1XS18amQImVP8tXd0bWk+lR2gzA=
X-Google-Smtp-Source: AK7set+xTOMvHQPpikQYpYy36pXqXQETgeNZhjJI5qy6WIbBqGxqgoV4v/7eUZshp7eRmb+hJNNc7w==
X-Received: by 2002:a19:7405:0:b0:4e1:7d1c:85ce with SMTP id v5-20020a197405000000b004e17d1c85cemr910940lfe.27.1677880710686;
        Fri, 03 Mar 2023 13:58:30 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id e27-20020ac2547b000000b004cafa01ebbfsm552670lfn.101.2023.03.03.13.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 13:58:30 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 03 Mar 2023 22:58:13 +0100
Subject: [PATCH 13/15] arm64: dts: qcom: sm6375: Bump CPU rail power
 collapse index
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-sm6375_features0_dts-v1-13-8c8d94fba6f0@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677880689; l=2856;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Qo/t+wBOxYfbhVIzvJopzDAhr8R83GF/inpNjIKH5i4=;
 b=g235hPJZ2ZyXkacBlAhRPLIHA1uGZC7mNoBH5+i+M1wYXAToQ+XNthEFZmTV3B9F+OBYu7mYBkwF
 dpZhHdtcBlItLd+uTPAzfc0bCew7lPkDsplDEmTL1vif1Eaa8jYq
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

In preparation for supporting a less-deep sleep state, rename the
existing rail power off from _0 to _1.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index ecb654357288..05d8d6a012b6 100644
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

