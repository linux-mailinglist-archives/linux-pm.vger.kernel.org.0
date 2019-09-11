Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66D23AF6B2
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2019 09:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfIKHRJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 03:17:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33812 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbfIKHRH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2019 03:17:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so11080953pgc.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2019 00:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=5U8Xn1q8Z74Mq83nqRSGd/n/boLzuvzoaz5vn7lXR3A=;
        b=VALWmmTyhWFVGeo1L9W3RX6Rm0TiRbc0V4xIZFeyqY+h1FBE5fd1JcnpYUWlJzsXPy
         GN6TM8X8BnGUIpjQhpomFsNOfeOrSO+vhhGGK9KtVwEUx6yKOzjWjD3UgBn+1YCKr7WE
         kuGeXfn54h7EueUtXLRx+XKGYM69e2euYIMd7VDXVwWHJfOCsuR9F30ClsQhIYse2p7H
         F9BZR0wG2gQ5S4Jb54DX9bih+M7w/wLlX6jhu4mCjLE8Fd1xlCHR/PTKwB32vG+aBXPq
         UToJQmzMy+4wFO6nvrN62tqAPlTZf8o7sNStlrAuQqxCoiDVrI4rXCw6Q0CXS1hrj49K
         Cz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=5U8Xn1q8Z74Mq83nqRSGd/n/boLzuvzoaz5vn7lXR3A=;
        b=NrJxgakNuKiH+L/jEAtLtzvRguwP+InE29fU+o6NojzvRnthlzKHJFEMNKb4VxM3qR
         jte2G4epARX5D9hyYSBXGmCTMhfkjXydMWMa6Gb3H1j71nqX8Iqh29EkCrvr7YwWc+4S
         M7DUsWYQCgxTvadHL3h1GNQWJ4O8W531P3S6dPcpLMazYKpZD97oYqGpB8oKTXBREf72
         8R/fPHJ66fPTsg5A5w/aQNe9uR7IWirWryUgx16n6nrTllVEGM4ynF9mhxhezDzsrDjH
         szv4G0haEAKNdflQYPe3WprNI9GKj6uOIMv03H266ua+Bljzztq+sqwjJOxOacG2C+OP
         mdow==
X-Gm-Message-State: APjAAAUe7pDEOzj6+ZnnH3dI9JZ0K0YY5MadEIBlw4/CELsXmqh7Cp08
        QP/m3373cLh4HzcBJtwDZiG8giwv592dDA==
X-Google-Smtp-Source: APXvYqw2fi/8fgU0kP0Ycov1r/33yfX/bpDUdq44uwHmXgtOV2HSxSXe1cB61Q+fbXSVYS9mz6lgvQ==
X-Received: by 2002:a65:5cca:: with SMTP id b10mr32444613pgt.365.1568186226553;
        Wed, 11 Sep 2019 00:17:06 -0700 (PDT)
Received: from localhost ([49.248.201.118])
        by smtp.gmail.com with ESMTPSA id f188sm25569788pfa.170.2019.09.11.00.17.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 00:17:05 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 07/15] dt-bindings: thermal: tsens: Convert over to a yaml schema
Date:   Wed, 11 Sep 2019 12:46:24 +0530
Message-Id: <933f033298cbd7726a6c0b4b3b6cc7adc81784ba.1568185732.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1568185732.git.amit.kucheria@linaro.org>
References: <cover.1568185732.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1568185732.git.amit.kucheria@linaro.org>
References: <cover.1568185732.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document interrupt support in the tsens driver by converting over to a
YAML schema.

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 .../bindings/thermal/qcom-tsens.txt           |  55 ------
 .../bindings/thermal/qcom-tsens.yaml          | 174 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 3 files changed, 175 insertions(+), 55 deletions(-)
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
index 000000000000..6784766fe58f
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -0,0 +1,174 @@
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
+          minItems: 1
+          maxItems: 1
+          items:
+            - description: Combined interrupt if upper or lower threshold crossed
+        interrupt-names:
+          minItems: 1
+          maxItems: 1
+          items:
+            - const: uplow
+
+    else:
+      properties:
+        interrupts:
+          minItems: 2
+          maxItems: 2
+          items:
+            - description: Combined interrupt if upper or lower threshold crossed
+            - description: Interrupt if critical threshold crossed
+        interrupt-names:
+          minItems: 2
+          maxItems: 2
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
index e7a47b5210fd..ff757a4a060c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13360,6 +13360,7 @@ L:	linux-pm@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	drivers/thermal/qcom/
+F:	Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
 
 QUALCOMM VENUS VIDEO ACCELERATOR DRIVER
 M:	Stanimir Varbanov <stanimir.varbanov@linaro.org>
-- 
2.17.1

