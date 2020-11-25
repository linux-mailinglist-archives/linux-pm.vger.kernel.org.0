Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5260D2C4D4D
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 03:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733203AbgKZCMl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 21:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731709AbgKZCMk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2020 21:12:40 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2B0C0613D4;
        Wed, 25 Nov 2020 18:12:39 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id oq3so609108ejb.7;
        Wed, 25 Nov 2020 18:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=STsWBKV7P3A8uOiJCdt6Mbb2TBdOtNAQlU7v5WGuSXU=;
        b=tLIHiQrO951hbsNyMUZOP1UdI1UnwScKOaNk0JU8OSjYkcnEd/duXLpx7fRCY1lrOU
         hZ0c3cSlaUJF+iu/y2PBPmvXAcMRvY97VDFYJcEC+2lqfCl4i5L02llVr9ewm+p2uTHZ
         AHCASmORfPvtUvIj/EidVvDoVvHSI4yhGJRj1LYJHrCrlYU0nXmVG3cTO7TQursKlNLy
         gQtOWmaRIQwKAbUmIkLU1K6XLCRO4+47NHgK081H9GblBsfKUj3eKM/hiICAdnB7xngS
         QXxFIi0Ye+ywwu+G2jcMaBUAXnAv/8519p2Rj1Scz25MBEkqrdcge0X2MAzQk3ZYbkuw
         MzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=STsWBKV7P3A8uOiJCdt6Mbb2TBdOtNAQlU7v5WGuSXU=;
        b=kQbl5/OQ5VuyZLNnf69iFTzoJFEHYWzp+ttn+XkDy+dri6p4RbovDaxCGf1WHVu29T
         a5yRm6zd6bx+tyDyFXYzuErpdgxPH1L2+qOnXIdJ33qOg6qsOx+3Gqua/3TM4FSLt1fL
         RWnG0xXPTt3StafdxiRVAICArgXkexFMAPqIPO7aWY3ZnRXzFtLxglRFDbtpJbSSBtzG
         F4O+WseFraLPtTOmkydF0iG9RksEgKY3p2IIk1mKCMMk5kV8uGGYGPQrsMKh0UuuKIPC
         6EvzvYrb2g0CsZsQ2/SOqAud2UbNeCir1Huh4au8tJivI9Pnx4IDGn/ncfOoj5c3y/vn
         a4fw==
X-Gm-Message-State: AOAM530Lq3quvsNOzpcIuDZb9dOLFYlxubDoQthMG67zsOyVFuuRk86/
        LI/zxAUJAg/VxUh4vYhcwLM=
X-Google-Smtp-Source: ABdhPJysOHJnv+URpB6tdCZP+meS8bfcQJsZCG5ovGy5T06CxBx1dAslC3h+MRJQ/C1miejewYxmsw==
X-Received: by 2002:a17:906:c357:: with SMTP id ci23mr695636ejb.311.1606356758456;
        Wed, 25 Nov 2020 18:12:38 -0800 (PST)
Received: from ansuel-xps20.localdomain (93-39-149-95.ip76.fastwebnet.it. [93.39.149.95])
        by smtp.googlemail.com with ESMTPSA id d7sm417276edv.17.2020.11.25.18.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 18:12:37 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 8/8] dt-bindings: thermal: tsens: Document ipq8064 bindings
Date:   Wed, 25 Nov 2020 18:48:25 +0100
Message-Id: <20201125174826.24462-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125174826.24462-1-ansuelsmth@gmail.com>
References: <20201125174826.24462-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document the use of bindings used for msm8960 tsens based devices.
msm8960 use the same gcc regs and is set as a child of the qcom gcc.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/thermal/qcom-tsens.yaml          | 103 ++++++++++++++----
 1 file changed, 79 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 95462e071ab4..3aacee5c0632 100644
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
@@ -88,43 +90,96 @@ properties:
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
-              - qcom,msm8916-tsens
-              - qcom,msm8974-tsens
-              - qcom,msm8976-tsens
-              - qcom,qcs404-tsens
-              - qcom,tsens-v0_1
-              - qcom,tsens-v1
+              - qcom,ipq8064-tsens
     then:
       properties:
-        interrupts:
-          maxItems: 1
-        interrupt-names:
-          maxItems: 1
+        nvmem-cell-names:
+          items:
+            - const: calib
+            - const: calib_backup
 
     else:
       properties:
-        interrupts:
-          minItems: 2
-        interrupt-names:
-          minItems: 2
+        nvmem-cell-names:
+          items:
+            - const: calib
+            - const: calib_sel
 
-required:
-  - compatible
-  - reg
-  - "#qcom,sensors"
-  - interrupts
-  - interrupt-names
-  - "#thermal-sensor-cells"
+  - if:
+    properties:
+      compatible:
+        contains:
+          enum:
+            - qcom,ipq8064-tsens
+            - qcom,msm8916-tsens
+            - qcom,msm8974-tsens
+            - qcom,msm8976-tsens
+            - qcom,qcs404-tsens
+            - qcom,tsens-v0_1
+            - qcom,tsens-v1
+  then:
+    properties:
+      interrupts:
+        maxItems: 1
+      interrupt-names:
+        maxItems: 1
+
+  else:
+    properties:
+      interrupts:
+        minItems: 2
+      interrupt-names:
+        minItems: 2
+
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

