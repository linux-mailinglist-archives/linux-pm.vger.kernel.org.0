Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 797DEEB73A
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 19:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbfJaSiW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 14:38:22 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41940 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729464AbfJaSiW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 14:38:22 -0400
Received: by mail-pl1-f196.google.com with SMTP id t10so3070459plr.8
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2019 11:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=o1n3hiXAD5eewTTz2SUMbD7SrZji7TFMiwE3m9ZwcRg=;
        b=Cx/HLdHQ71EgUyen7jjcTL35DuT+MEdayqwMwbnKEzc8pczQ0bf+EbUJO77lvObl1K
         O0RCQhGwXm+3v77SLAc/cQEgirwHgV006dJDN4VhQicyTnvB0XFmRURl84/dIvGOObhG
         eiE9WCAYPRgJjKsOrqd02VkO6DcWk2eI1XABGsf8nMffMMO2cxSuTwWtDpWnkx88HNaj
         qilbj0fkx4sMBbrwE6Xygy1TD3u6+xj7M3AsIUBGPdzqgTfKQtyOMdNOM4y4dA8dtZiS
         QIjWF5uReMlWhnY0AQjwct20EZPHBlJKHy1SHASQutNOEJWePzyMdSVhwn6A07r7cUu7
         1SJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=o1n3hiXAD5eewTTz2SUMbD7SrZji7TFMiwE3m9ZwcRg=;
        b=SqmWFW6TE4pJsBYW1WSQc0ctOz6wNAFo3d/GBrU6xQ9gvW3B8CaQlNb8gQJtWZxDpi
         wlnmPDr9sJzdVLcJVhQKzu4NL69OlQfTQNb3EpXWA9WxjejLAzEpFHvLVS53n/LB3iuA
         a7xMeie8yyFHw2u6M0VOEXBQyyHvCr+8vcrFQqIiMCVukhJVDukWTKBPm8AC59Gzhyh8
         a8uTTbrIMHBU1QSfOSHC8zLcpO+X/yIcUtcgYgFraWKWgmDEo5wLIF0tcn6w9wO5yVrN
         mJq9rinojypbVfnwvccrDqvqE24JjLfX8WunUOemnhyz8cZZAf3gFZi9fTEJsqEzUVUq
         i3/w==
X-Gm-Message-State: APjAAAXDEQx9G6QsskXxP9vWMUSrJNqg7pY+PPCPQ2frhA6lLjf2xsNJ
        KAH6ixTRxXoZOerSdM4gih1uQw==
X-Google-Smtp-Source: APXvYqzZdL183R8DZQuAT/PmeNYytXXsC42KkiBOwNC5GlKf/Q11I3IT4OG9Bdfi9yHbkWQVwzb4PA==
X-Received: by 2002:a17:902:a584:: with SMTP id az4mr7817983plb.74.1572547100293;
        Thu, 31 Oct 2019 11:38:20 -0700 (PDT)
Received: from localhost ([49.248.58.234])
        by smtp.gmail.com with ESMTPSA id l93sm7482988pjb.6.2019.10.31.11.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Oct 2019 11:38:19 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org, julia.lawall@lip6.fr,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v7 07/15] dt-bindings: thermal: tsens: Convert over to a yaml schema
Date:   Fri,  1 Nov 2019 00:07:31 +0530
Message-Id: <d519be4c7198f47c3661f7326d1a724b97dc4973.1572526427.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572526427.git.amit.kucheria@linaro.org>
References: <cover.1572526427.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1572526427.git.amit.kucheria@linaro.org>
References: <cover.1572526427.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Older IP only supports the 'uplow' interrupt, but newer IP supports
'uplow' and 'critical' interrupts. Document interrupt support in the
tsens driver by converting over to a YAML schema.

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/thermal/qcom-tsens.txt           |  55 ------
 .../bindings/thermal/qcom-tsens.yaml          | 168 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 3 files changed, 169 insertions(+), 55 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
deleted file mode 100644
index 673cc1831ee9..000000000000
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
+++ /dev/null
@@ -1,55 +0,0 @@
-* QCOM SoC Temperature Sensor (TSENS)
-
-Required properties:
-- compatible:
-  Must be one of the following:
-    - "qcom,msm8916-tsens" (MSM8916)
-    - "qcom,msm8974-tsens" (MSM8974)
-    - "qcom,msm8996-tsens" (MSM8996)
-    - "qcom,qcs404-tsens", "qcom,tsens-v1" (QCS404)
-    - "qcom,msm8998-tsens", "qcom,tsens-v2" (MSM8998)
-    - "qcom,sdm845-tsens", "qcom,tsens-v2" (SDM845)
-  The generic "qcom,tsens-v2" property must be used as a fallback for any SoC
-  with version 2 of the TSENS IP. MSM8996 is the only exception because the
-  generic property did not exist when support was added.
-  Similarly, the generic "qcom,tsens-v1" property must be used as a fallback for
-  any SoC with version 1 of the TSENS IP.
-
-- reg: Address range of the thermal registers.
-  New platforms containing v2.x.y of the TSENS IP must specify the SROT and TM
-  register spaces separately, with order being TM before SROT.
-  See Example 2, below.
-
-- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
-- #qcom,sensors: Number of sensors in tsens block
-- Refer to Documentation/devicetree/bindings/nvmem/nvmem.txt to know how to specify
-nvmem cells
-
-Example 1 (legacy support before a fallback tsens-v2 property was introduced):
-tsens: thermal-sensor@900000 {
-		compatible = "qcom,msm8916-tsens";
-		reg = <0x4a8000 0x2000>;
-		nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
-		nvmem-cell-names = "caldata", "calsel";
-		#thermal-sensor-cells = <1>;
-	};
-
-Example 2 (for any platform containing v2 of the TSENS IP):
-tsens0: thermal-sensor@c263000 {
-		compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
-		reg = <0xc263000 0x1ff>, /* TM */
-			<0xc222000 0x1ff>; /* SROT */
-		#qcom,sensors = <13>;
-		#thermal-sensor-cells = <1>;
-	};
-
-Example 3 (for any platform containing v1 of the TSENS IP):
-tsens: thermal-sensor@4a9000 {
-		compatible = "qcom,qcs404-tsens", "qcom,tsens-v1";
-		reg = <0x004a9000 0x1000>, /* TM */
-		      <0x004a8000 0x1000>; /* SROT */
-		nvmem-cells = <&tsens_caldata>;
-		nvmem-cell-names = "calib";
-		#qcom,sensors = <10>;
-		#thermal-sensor-cells = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
new file mode 100644
index 000000000000..23afc7bf5a44
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -0,0 +1,168 @@
+# SPDX-License-Identifier: (GPL-2.0 OR MIT)
+# Copyright 2019 Linaro Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/qcom-tsens.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QCOM SoC Temperature Sensor (TSENS)
+
+maintainers:
+  - Amit Kucheria <amit.kucheria@linaro.org>
+
+description: |
+  QCOM SoCs have TSENS IP to allow temperature measurement. There are currently
+  three distinct major versions of the IP that is supported by a single driver.
+  The IP versions are named v0.1, v1 and v2 in the driver, where v0.1 captures
+  everything before v1 when there was no versioning information.
+
+properties:
+  compatible:
+    oneOf:
+      - description: v0.1 of TSENS
+        items:
+          - enum:
+              - qcom,msm8916-tsens
+              - qcom,msm8974-tsens
+          - const: qcom,tsens-v0_1
+
+      - description: v1 of TSENS
+        items:
+          - enum:
+              - qcom,qcs404-tsens
+          - const: qcom,tsens-v1
+
+      - description: v2 of TSENS
+        items:
+          - enum:
+              - qcom,msm8996-tsens
+              - qcom,msm8998-tsens
+              - qcom,sdm845-tsens
+          - const: qcom,tsens-v2
+
+  reg:
+    maxItems: 2
+    items:
+      - description: TM registers
+      - description: SROT registers
+
+  nvmem-cells:
+    minItems: 1
+    maxItems: 2
+    description:
+      Reference to an nvmem node for the calibration data
+
+  nvmem-cells-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      - enum:
+        - caldata
+        - calsel
+
+  "#qcom,sensors":
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 1
+      - maximum: 16
+    description:
+      Number of sensors enabled on this platform
+
+  "#thermal-sensor-cells":
+    const: 1
+    description:
+      Number of cells required to uniquely identify the thermal sensors. Since
+      we have multiple sensors this is set to 1
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8916-tsens
+              - qcom,msm8974-tsens
+              - qcom,qcs404-tsens
+              - qcom,tsens-v0_1
+              - qcom,tsens-v1
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: Combined interrupt if upper or lower threshold crossed
+        interrupt-names:
+          items:
+            - const: uplow
+
+    else:
+      properties:
+        interrupts:
+          items:
+            - description: Combined interrupt if upper or lower threshold crossed
+            - description: Interrupt if critical threshold crossed
+        interrupt-names:
+          items:
+            - const: uplow
+            - const: critical
+
+required:
+  - compatible
+  - reg
+  - "#qcom,sensors"
+  - interrupts
+  - interrupt-names
+  - "#thermal-sensor-cells"
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    // Example 1 (legacy: for pre v1 IP):
+    tsens1: thermal-sensor@900000 {
+           compatible = "qcom,msm8916-tsens", "qcom,tsens-v0_1";
+           reg = <0x4a9000 0x1000>, /* TM */
+                 <0x4a8000 0x1000>; /* SROT */
+
+           nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
+           nvmem-cell-names = "caldata", "calsel";
+
+           interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+           interrupt-names = "uplow";
+
+           #qcom,sensors = <5>;
+           #thermal-sensor-cells = <1>;
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    // Example 2 (for any platform containing v1 of the TSENS IP):
+    tsens2: thermal-sensor@4a9000 {
+          compatible = "qcom,qcs404-tsens", "qcom,tsens-v1";
+          reg = <0x004a9000 0x1000>, /* TM */
+                <0x004a8000 0x1000>; /* SROT */
+
+          nvmem-cells = <&tsens_caldata>;
+          nvmem-cell-names = "calib";
+
+          interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
+          interrupt-names = "uplow";
+
+          #qcom,sensors = <10>;
+          #thermal-sensor-cells = <1>;
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    // Example 3 (for any platform containing v2 of the TSENS IP):
+    tsens3: thermal-sensor@c263000 {
+           compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+           reg = <0xc263000 0x1ff>,
+                 <0xc222000 0x1ff>;
+
+           interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
+                        <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
+           interrupt-names = "uplow", "critical";
+
+           #qcom,sensors = <13>;
+           #thermal-sensor-cells = <1>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index a69e6db80c79..c4df814b87b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13513,6 +13513,7 @@ L:	linux-pm@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	drivers/thermal/qcom/
+F:	Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
 
 QUALCOMM VENUS VIDEO ACCELERATOR DRIVER
 M:	Stanimir Varbanov <stanimir.varbanov@linaro.org>
-- 
2.17.1

