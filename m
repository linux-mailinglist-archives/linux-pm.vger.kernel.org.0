Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD642FF435
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 20:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbhAUTTy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 14:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbhAUTTv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 14:19:51 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FABC06174A;
        Thu, 21 Jan 2021 11:19:05 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id g3so1854412plp.2;
        Thu, 21 Jan 2021 11:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OJPeUr95r7qe0zay9wgTNA4xYQ3SP/NdIq7pjxqRZ8w=;
        b=HwPxn2l58r0mlOJ5V17hBBWQWQ8RWvyoGCk7idFJgDHwiHm4hU5bxPTKC9i5KpaySY
         wmbxfKvRSxdRPpXH08VrqK66CZ2D8HtoDpv6YEJ2nsjKGLVRA0aU1sZMnBW1TPwdt22g
         KBOA0k5SWkrL4FkgQyLwNWcsHe3rFDgJfHaDwhKCpeyViT2qA0FsbiyMJ+yBoaU9CPpI
         0mTZNCGkyUxWOj1L0CNmtWtGcR7h8vW2lDewM3/EHv2rFK/AQNX6toLgVW7Vs7GjGyiV
         MYoX1VbsJTfBoMWZiE6dy9SfaWuP5fbLTTdlTtUEwQ4xuTIhx7gUmF8KkV4DYhNq6rcA
         2jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OJPeUr95r7qe0zay9wgTNA4xYQ3SP/NdIq7pjxqRZ8w=;
        b=DiBpmwH+eY0Gl+kqwJJ25cz4g75osd3sWKMOPL8vjtD3Qe8UBFxhL4JsGIAPDBWjeU
         eSgoqHSVDM6TnlN2IOrXvkF1+DFJht+v41r4R8IZjwD8FDC4LM3JeRSF8Rcfn5iGPWIr
         CqlfWLumCruqhhqlIDO9t/t3dPFVP3cN4H59GoBT4wzHw5Dg8t9xN16nhQmhlBakfFHj
         0hyRq6fRIX6ARS9TZj6xlhRcOizU5UMdww9ufAsejGmLbbgI1wJfvmbd8e4iBV1rGNx4
         zpL0z1X8f61XASbR538+i+JhL00MwgIEk09PSGF2UCymGRNgeKu8Lw9Fn3GsPD7ERrxi
         XiOA==
X-Gm-Message-State: AOAM533InT5noqHhasxxtbogdOpaPSXKNJBug084A+zX8rN2Zy7I51pg
        XFm8e5wRShNAz/LZnHjuiOg=
X-Google-Smtp-Source: ABdhPJwYb7y1Ji+aONNbWB23QbRQS4m+r3yjm/gsBwxmFeyTtTWF580sv9zaKPvIsBRZ5dBPId7c5g==
X-Received: by 2002:a17:902:724b:b029:de:229a:47f1 with SMTP id c11-20020a170902724bb02900de229a47f1mr915587pll.10.1611256745320;
        Thu, 21 Jan 2021 11:19:05 -0800 (PST)
Received: from ansuel-xps20.localdomain (host-80-182-172-197.pool80182.interbusiness.it. [80.182.172.197])
        by smtp.googlemail.com with ESMTPSA id p9sm6559634pfq.136.2021.01.21.11.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 11:19:04 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 8/8] dt-bindings: thermal: tsens: Document ipq8064 bindings
Date:   Thu, 21 Jan 2021 20:18:53 +0100
Message-Id: <20210121191853.14600-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document the use of bindings used for msm8960 tsens based devices.
msm8960 use the same gcc regs and is set as a child of the qcom gcc.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/thermal/qcom-tsens.yaml          | 75 ++++++++++++++++---
 1 file changed, 65 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 95462e071ab4..11ce1d7da679 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -19,6 +19,11 @@ description: |
 properties:
   compatible:
     oneOf:
+      - description: msm9860 TSENS based
+        items:
+          - enum:
+            - qcom,ipq8064-tsens
+
       - description: v0.1 of TSENS
         items:
           - enum:
@@ -71,9 +76,6 @@ properties:
   nvmem-cell-names:
     minItems: 1
     maxItems: 2
-    items:
-      - const: calib
-      - const: calib_sel
 
   "#qcom,sensors":
     description:
@@ -88,12 +90,40 @@ properties:
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
+    then:
+      properties:
+        nvmem-cell-names:
+          items:
+            - const: calib
+            - const: calib_backup
+
+    else:
+      properties:
+        nvmem-cell-names:
+          items:
+            - const: calib
+            - const: calib_sel
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq8064-tsens
               - qcom,msm8916-tsens
               - qcom,msm8974-tsens
               - qcom,msm8976-tsens
@@ -114,17 +144,42 @@ allOf:
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
2.29.2

