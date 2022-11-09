Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F716224FF
	for <lists+linux-pm@lfdr.de>; Wed,  9 Nov 2022 09:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiKIIBt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Nov 2022 03:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiKIIBp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Nov 2022 03:01:45 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B881C425
        for <linux-pm@vger.kernel.org>; Wed,  9 Nov 2022 00:01:44 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id y16so24433777wrt.12
        for <linux-pm@vger.kernel.org>; Wed, 09 Nov 2022 00:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2RysX7TiVCclv2UJBtgXviDFq2/T3mQypqGPEA1b7s=;
        b=rLHIjz9FNMQu6kj3EmzsWL6AQW1/Kclkk4Uxg4MPje5UhKFoIyb3SY8RtIY9YMh8V9
         mwfR0H3AS+NIiLUl0M9+H9b5u9DSVOxvxrTZh0ylqtK1gpzttC068Pa0VUDVwPyg3LB6
         fg9JqDYhW/fUJ1UdFLrf85S2/YlbkMWhUZ/y0QYtmxm5aINYnr0ZpAmWZtKFxDAN2No5
         CraJCxttPT5Z35xMaPIgY+VsKVV0Ak6RrWg8hQZF7QzPEzLcTMjGvRNODxRTJR7k8NSh
         44lINyeqbnZXyvyPlnMMPG5ElqhMCRn+4ord8g6ltCX3gF5Ftt7pTzrhHtwgkBn+5XZ0
         /Iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2RysX7TiVCclv2UJBtgXviDFq2/T3mQypqGPEA1b7s=;
        b=sJvWKI1JgIFsZ5KjFOsrkd+Tsw34rviDe6WxLPq7Mh8U4Jko1mCHZSBT93MUp36Dod
         J2aqMZVXkev7gQqFvoLoVHQWIGp8lRJvPJyFv85K5JFoTFwKqtw2ONwGYfmUIaPyJCQe
         pDi71R/lWWDqAfODtYRYpARXeXWnbEXletudyxtLysJUVfvtBtfjktLx1GA4A3i7+nTL
         9QbjlF+LOZre/8w1bZ+Tso9h6e5G9YjiZngQyZOOSQVvMcm8nG8qNmsbQvlZQ0Tw/LEC
         ZKWuouuI4jXpUegAWfqKV6p560WbiMCJQ0u3oSPiUGKhbVM9d1uwRcgTN7/Zfa9rcrHS
         GUyg==
X-Gm-Message-State: ACrzQf0cM3Dalmg2LtAko52f9gXsPof9JfCq9sbnyvbjsBDkSAZ7RHt8
        u5zxtbQniUxyV3/tAy96P5yg
X-Google-Smtp-Source: AMsMyM7UTOQyGFWGy2JBVT7ZAStdo7Sem2exllc5izREtOsumM3pdmJe3XUTGlXqsActy+Frwa8jOw==
X-Received: by 2002:adf:e491:0:b0:236:5270:7f5e with SMTP id i17-20020adfe491000000b0023652707f5emr37426823wrm.600.1667980902469;
        Wed, 09 Nov 2022 00:01:42 -0800 (PST)
Received: from localhost.localdomain ([117.202.189.229])
        by smtp.gmail.com with ESMTPSA id l26-20020a05600c2cda00b003cf774c31a0sm769427wmc.16.2022.11.09.00.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 00:01:41 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/3] dt-bindings: cpufreq: cpufreq-qcom-hw: Add cpufreq clock provider
Date:   Wed,  9 Nov 2022 13:31:18 +0530
Message-Id: <20221109080120.19078-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109080120.19078-1-manivannan.sadhasivam@linaro.org>
References: <20221109080120.19078-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Qualcomm platforms making use of CPUFreq HW Engine (EPSS/OSM) supply clocks
to the CPU cores. Document the same in the binding to reflect the actual
implementation.

CPUFreq HW will become the clock provider and CPU cores will become the
clock consumers.

The clock index for each CPU core is based on the frequency domain index.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index e58c55f78aaa..676d369a6fdd 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -56,6 +56,9 @@ properties:
   '#freq-domain-cells':
     const: 1
 
+  '#clock-cells':
+    const: 1
+
 required:
   - compatible
   - reg
@@ -83,6 +86,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_0>;
         qcom,freq-domain = <&cpufreq_hw 0>;
+        clocks = <&cpufreq_hw 0>;
         L2_0: l2-cache {
           compatible = "cache";
           cache-unified;
@@ -103,6 +107,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_100>;
         qcom,freq-domain = <&cpufreq_hw 0>;
+        clocks = <&cpufreq_hw 0>;
         L2_100: l2-cache {
           compatible = "cache";
           cache-unified;
@@ -118,6 +123,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_200>;
         qcom,freq-domain = <&cpufreq_hw 0>;
+        clocks = <&cpufreq_hw 0>;
         L2_200: l2-cache {
           compatible = "cache";
           cache-unified;
@@ -133,6 +139,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_300>;
         qcom,freq-domain = <&cpufreq_hw 0>;
+        clocks = <&cpufreq_hw 0>;
         L2_300: l2-cache {
           compatible = "cache";
           cache-unified;
@@ -148,6 +155,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_400>;
         qcom,freq-domain = <&cpufreq_hw 1>;
+        clocks = <&cpufreq_hw 1>;
         L2_400: l2-cache {
           compatible = "cache";
           cache-unified;
@@ -163,6 +171,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_500>;
         qcom,freq-domain = <&cpufreq_hw 1>;
+        clocks = <&cpufreq_hw 1>;
         L2_500: l2-cache {
           compatible = "cache";
           cache-unified;
@@ -178,6 +187,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_600>;
         qcom,freq-domain = <&cpufreq_hw 1>;
+        clocks = <&cpufreq_hw 1>;
         L2_600: l2-cache {
           compatible = "cache";
           cache-unified;
@@ -193,6 +203,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_700>;
         qcom,freq-domain = <&cpufreq_hw 1>;
+        clocks = <&cpufreq_hw 1>;
         L2_700: l2-cache {
           compatible = "cache";
           cache-unified;
@@ -215,6 +226,7 @@ examples:
         clock-names = "xo", "alternate";
 
         #freq-domain-cells = <1>;
+        #clock-cells = <1>;
       };
     };
 ...
-- 
2.25.1

