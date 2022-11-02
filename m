Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DAB615EFD
	for <lists+linux-pm@lfdr.de>; Wed,  2 Nov 2022 10:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiKBJJM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Nov 2022 05:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiKBJIp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Nov 2022 05:08:45 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EAC27CC9
        for <linux-pm@vger.kernel.org>; Wed,  2 Nov 2022 02:08:44 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so1351924pjl.3
        for <linux-pm@vger.kernel.org>; Wed, 02 Nov 2022 02:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLmIT2EuV7uL5/q+fGUeI0QcACFtgGdUnQVYaLsbI/Y=;
        b=b7nHLBjUufJmJspBXuHAtSMK8Px+kXryq+x/CMQKjqzJI2+omB03MHFs+b0SIgt+FP
         ZdI9759K2BCORPFtvXQdMtpc7IxupthgKO/LLlXMIOTEYROvYWiWw0StCpvH/mhM8Mcj
         YlEvEISlkDng044eoQKPXbhgB97MEu1aDcD6XzEGWn7w5jmthW6qRH7OZKWxKE1CHMmX
         jtbXxrxI/q/jtp22fzbcXb0FV6V5RQL7cqFeZUvm0cFzE0ojgPwh/lyLrC0KL20rDyv9
         i860opxDSZ14AaF2DBg0DXUMUSrnuSYFSHN5AOFPVGBL6wVOXTqsTFXmoTI+ikEv4epo
         n+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLmIT2EuV7uL5/q+fGUeI0QcACFtgGdUnQVYaLsbI/Y=;
        b=GdbsmRyXKoWi8Of6qDsXmJDAyzej/5vhHkM7nBopz1H9LSukrHNZMF+VkT/OJm4n80
         kvTqsZwjQ0WF/oMDBdXB040lLWVigPRBdsTICwRpBM8atp/zF8W9+FRdtUIa1pFzgEQ2
         LQ/m+qjvq9em0un5wdhUbHtDs3OxeaZRJH30u3n9s46+zB81lQmUjMwUhUmFoMsj4aTs
         +nnqHyU/TnkB06e4O+cOpKBU9k4pF5jINJ2fuR1KKW9dKB3ryIrMAuTnjiVaPEl6o8R9
         6BhhQdQFnRrJGVGDaavQJihHAdbafnssub4vZd5+kayQyr7JFpDQSWQ76+rbd7Ep1m1n
         lW/g==
X-Gm-Message-State: ACrzQf2HPF343vrcfYLEdHGPeq1DzDZhlTnhzx7C34h6LjNlPQmsr0JA
        5bMzPsr+F5yLqGdf+TcJmH9x
X-Google-Smtp-Source: AMsMyM77JnAlbEFTQqEbo4jyfDXA5M0vK+5KthBYKkmJ2++rlrrrtMRLZIKj6FZbIvnLIGRIeggJQw==
X-Received: by 2002:a17:90a:cb8c:b0:212:eba5:a143 with SMTP id a12-20020a17090acb8c00b00212eba5a143mr24629236pju.79.1667380123644;
        Wed, 02 Nov 2022 02:08:43 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.178])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b0017f36638010sm7856126plg.276.2022.11.02.02.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 02:08:42 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: cpufreq: cpufreq-qcom-hw: Add cpufreq clock provider
Date:   Wed,  2 Nov 2022 14:38:16 +0530
Message-Id: <20221102090818.65321-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102090818.65321-1-manivannan.sadhasivam@linaro.org>
References: <20221102090818.65321-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
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
index 24fa3d87a40b..9ac8ad5b71b5 100644
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
           next-level-cache = <&L3_0>;
@@ -99,6 +103,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_100>;
         qcom,freq-domain = <&cpufreq_hw 0>;
+        clocks = <&cpufreq_hw 0>;
         L2_100: l2-cache {
           compatible = "cache";
           next-level-cache = <&L3_0>;
@@ -112,6 +117,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_200>;
         qcom,freq-domain = <&cpufreq_hw 0>;
+        clocks = <&cpufreq_hw 0>;
         L2_200: l2-cache {
           compatible = "cache";
           next-level-cache = <&L3_0>;
@@ -125,6 +131,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_300>;
         qcom,freq-domain = <&cpufreq_hw 0>;
+        clocks = <&cpufreq_hw 0>;
         L2_300: l2-cache {
           compatible = "cache";
           next-level-cache = <&L3_0>;
@@ -138,6 +145,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_400>;
         qcom,freq-domain = <&cpufreq_hw 1>;
+        clocks = <&cpufreq_hw 1>;
         L2_400: l2-cache {
           compatible = "cache";
           next-level-cache = <&L3_0>;
@@ -151,6 +159,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_500>;
         qcom,freq-domain = <&cpufreq_hw 1>;
+        clocks = <&cpufreq_hw 1>;
         L2_500: l2-cache {
           compatible = "cache";
           next-level-cache = <&L3_0>;
@@ -164,6 +173,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_600>;
         qcom,freq-domain = <&cpufreq_hw 1>;
+        clocks = <&cpufreq_hw 1>;
         L2_600: l2-cache {
           compatible = "cache";
           next-level-cache = <&L3_0>;
@@ -177,6 +187,7 @@ examples:
         enable-method = "psci";
         next-level-cache = <&L2_700>;
         qcom,freq-domain = <&cpufreq_hw 1>;
+        clocks = <&cpufreq_hw 1>;
         L2_700: l2-cache {
           compatible = "cache";
           next-level-cache = <&L3_0>;
@@ -197,6 +208,7 @@ examples:
         clock-names = "xo", "alternate";
 
         #freq-domain-cells = <1>;
+        #clock-cells = <1>;
       };
     };
 ...
-- 
2.25.1

