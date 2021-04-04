Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE243539E7
	for <lists+linux-pm@lfdr.de>; Sun,  4 Apr 2021 22:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhDDUfp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Apr 2021 16:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbhDDUf3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Apr 2021 16:35:29 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70805C061797;
        Sun,  4 Apr 2021 13:35:21 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ap14so14395069ejc.0;
        Sun, 04 Apr 2021 13:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=21TRq5T7n/YlJzaiHd/rYW7/ONn9U06XAcWKZPDtNYI=;
        b=M4eDEHA7l9wyZKJKdkZ3+WB+zAsyqVMa09C0V4FY+OtPURMur+wQEEu556G6Vr60aE
         JHYzgsAezfJLn4gGjtWhb5HOtAsNhd4RKEaZJ7R72PJNNC5hv7+1jEBoTArQvhd5nv3o
         d4/yEs0fGzaJGecJ0yYA8b/MjPUFNst42iBh1Vku40ntMYrw7SyUFbAJQuz0m1uawdwo
         zSFXgjFfm7ChRDZ3prphxFwfglmu3y80bJJ295zfk8diP14mvMKOcvAfbddFAaNum2tI
         3rnGtbyuJF0ZOXeFiWVr7x1jO7uEVo+7XExUfzmroDb+OsbfcEhox7RmWMHca/13+F3+
         I5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=21TRq5T7n/YlJzaiHd/rYW7/ONn9U06XAcWKZPDtNYI=;
        b=cqMlfzxDY+W3WIaamf7rik0PZ0ucZcXsqnpku7VwUzPI3Vzo5DFi30r6ykI/c7O5+8
         Dx4tMILNceEJTKIWyCNw4YyckMHeUqSh1ixh5rLyWJ/cfYCIOKRI/iLx4zLfr5tfQsCN
         ZdFp3ywQd+9TcPO6kI3dVFMEOS59+3rBaxuOEBX8mL6j6jcdlF+SMY3tkQhZxJNPXONY
         xO2VOi04osvvF5JY3MrzZdn0J6C/As6KccGm6P0nyhSYAka0O0FH2rdS27XfB5m0e3dR
         mylOS+Vhl63iXJp5AabKbIYis5fJZ88VH8Omll8guaGuafsiOEwGPOawctWzGKwn7GG0
         oqgA==
X-Gm-Message-State: AOAM531axKRuECrKuTQ0oB0Q6d2Rl9NY86dQxAvNC4KbublNaS1xCtw9
        qKlAUDN7rL7qpslzCCMXuo8hHQzatkU=
X-Google-Smtp-Source: ABdhPJyNXcRjlippyXIMc/+PnZGk2e+9H+1Uy7aUEKqxmoGDzV/o/WLhyc7AWbrwvZr1LTAO9WqoBw==
X-Received: by 2002:a17:906:814a:: with SMTP id z10mr11054668ejw.476.1617568520142;
        Sun, 04 Apr 2021 13:35:20 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-52-251-187.retail.telecomitalia.it. [79.52.251.187])
        by smtp.googlemail.com with ESMTPSA id s4sm7191140ejf.108.2021.04.04.13.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 13:35:19 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v14 9/9] dt-bindings: thermal: tsens: Document ipq8064 bindings
Date:   Sun,  4 Apr 2021 16:48:23 +0200
Message-Id: <20210404144823.31867-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210404144823.31867-1-ansuelsmth@gmail.com>
References: <20210404144823.31867-1-ansuelsmth@gmail.com>
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

