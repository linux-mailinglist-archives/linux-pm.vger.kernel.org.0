Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C43A34840F
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 22:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbhCXVom (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 17:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238577AbhCXVoY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Mar 2021 17:44:24 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEE0C06174A;
        Wed, 24 Mar 2021 14:44:23 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id l18so113077edc.9;
        Wed, 24 Mar 2021 14:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=21TRq5T7n/YlJzaiHd/rYW7/ONn9U06XAcWKZPDtNYI=;
        b=kF+NCah/EVPAXGmpxeftPScbCYp5REz87xSOKWqgMpHa7eWAklrqHZlsFaN1y8/4jO
         AVcbJ1wfXLc2/b+ytYDQ0Qu5dFHlyj+w+f6yruJW9OjDJPgKX8+yq4bIu3uoBA4i3i1U
         Tjm5mFinBmqHoAARKHE48JD+LUIogVRvwrEJhBgYh7PyPNhI9FQQMbjpknBgIKPWtxvb
         oK76ogwZ96JNAIcl+QBIa28Dd7WdTU7UDUwlG4FZhaxTn6wOkbUk2BK6WspCm15fVIMi
         IGjGlD5hHDGORwlbkFvjUXYUJLM7nQoZJSyq8m+Vsd4DAMuhUj9KyQLTRuNK1d2Vp/kY
         aqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=21TRq5T7n/YlJzaiHd/rYW7/ONn9U06XAcWKZPDtNYI=;
        b=I6FcKVxAte9y2PtinI2ee9AFxkd7axTTSwO5tH3DCl5CWbUvLR7253caZAQmN/VxAx
         mG+YnjCFoXMvM2CW2DJLCd2boukI2E/8TuvRUmzDUKA7mjiEbd4ffP2faLmcf3K4Gh0r
         YK7+vcNASNzqVUdsPBwzU/vG4V9LIuAWDy7rx6bVRT+XaTZUX7ojPePmAvq487zp/moH
         +BLhKZ88ckSsl+5phYol02TbL+9JmkNdNIOHnPbQ6Pumrs21YBRmSoS21K2ClgN53/Um
         /oSpo3oavjSgHhWQRAehGvpsiLaG5g6ZWyeK4EdMmlcOq/hHjzdqK4ZYNL7BRYyGM0hC
         atVw==
X-Gm-Message-State: AOAM5325+HEH9Jq1aDe9udhCykwU8HosaX9DoqpajHz+WVWiV42Xd2BA
        JnWzKM7yVoNg1YLH2zDW3cE=
X-Google-Smtp-Source: ABdhPJyaTpezBnijEbWtNHFTUtQrYf2y5z/n6gFhEZlmw+gU6i6JN5lWNChqXNqExTeW6A1ECP+sjA==
X-Received: by 2002:aa7:c14a:: with SMTP id r10mr5474571edp.132.1616622262403;
        Wed, 24 Mar 2021 14:44:22 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-34-220-97.business.telecomitalia.it. [79.34.220.97])
        by smtp.googlemail.com with ESMTPSA id z9sm1871211edr.75.2021.03.24.14.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:44:22 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v13 9/9] dt-bindings: thermal: tsens: Document ipq8064 bindings
Date:   Wed, 24 Mar 2021 22:44:03 +0100
Message-Id: <20210324214404.798-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210324214404.798-1-ansuelsmth@gmail.com>
References: <20210324214404.798-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document the use of bindings used for msm8960 tsens based devices.
msm8960 use the same gcc regs and is set as a child of the qcom gcc.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/thermal/qcom-tsens.yaml          | 56 ++++++++++++++++---
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 95462e071ab4..1785b1c75a3c 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -19,6 +19,11 @@ description: |
 properties:
   compatible:
     oneOf:
+      - description: msm9860 TSENS based
+        items:
+          - enum:
+              - qcom,ipq8064-tsens
+
       - description: v0.1 of TSENS
         items:
           - enum:
@@ -73,7 +78,9 @@ properties:
     maxItems: 2
     items:
       - const: calib
-      - const: calib_sel
+      - enum:
+          - calib_backup
+          - calib_sel
 
   "#qcom,sensors":
     description:
@@ -88,12 +95,20 @@ properties:
       Number of cells required to uniquely identify the thermal sensors. Since
       we have multiple sensors this is set to 1
 
+required:
+  - compatible
+  - interrupts
+  - interrupt-names
+  - "#thermal-sensor-cells"
+  - "#qcom,sensors"
+
 allOf:
   - if:
       properties:
         compatible:
           contains:
             enum:
+              - qcom,ipq8064-tsens
               - qcom,msm8916-tsens
               - qcom,msm8974-tsens
               - qcom,msm8976-tsens
@@ -114,17 +129,42 @@ allOf:
         interrupt-names:
           minItems: 2
 
-required:
-  - compatible
-  - reg
-  - "#qcom,sensors"
-  - interrupts
-  - interrupt-names
-  - "#thermal-sensor-cells"
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,tsens-v0_1
+              - qcom,tsens-v1
+              - qcom,tsens-v2
+
+    then:
+      required:
+        - reg
 
 additionalProperties: false
 
 examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    // Example msm9860 based SoC (ipq8064):
+    gcc: clock-controller {
+
+           /* ... */
+
+           tsens: thermal-sensor {
+                compatible = "qcom,ipq8064-tsens";
+
+                 nvmem-cells = <&tsens_calib>, <&tsens_calib_backup>;
+                 nvmem-cell-names = "calib", "calib_backup";
+                 interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+                 interrupt-names = "uplow";
+
+                 #qcom,sensors = <11>;
+                 #thermal-sensor-cells = <1>;
+          };
+    };
+
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     // Example 1 (legacy: for pre v1 IP):
-- 
2.30.2

