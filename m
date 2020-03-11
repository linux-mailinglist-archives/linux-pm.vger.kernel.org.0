Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5211C181DEF
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 17:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbgCKQdB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 12:33:01 -0400
Received: from bin-mail-out-06.binero.net ([195.74.38.229]:22635 "EHLO
        bin-mail-out-06.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729852AbgCKQdB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2020 12:33:01 -0400
X-Halon-ID: eaf4c149-63b5-11ea-aa6d-005056917f90
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (p4fca2392.dip0.t-ipconnect.de [79.202.35.146])
        by bin-vsp-out-02.atm.binero.net (Halon) with ESMTPA
        id eaf4c149-63b5-11ea-aa6d-005056917f90;
        Wed, 11 Mar 2020 17:32:49 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH] dt-bindings: thermal: rcar-thermal: Convert bindings to json-schema
Date:   Wed, 11 Mar 2020 17:32:21 +0100
Message-Id: <20200311163221.1761949-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert Renesas R-Car Thermal bindings documentation to json-schema.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 .../bindings/thermal/rcar-thermal.txt         |  78 ----------
 .../bindings/thermal/rcar-thermal.yaml        | 139 ++++++++++++++++++
 2 files changed, 139 insertions(+), 78 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/rcar-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/rcar-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
deleted file mode 100644
index 196112d23b1edef2..0000000000000000
--- a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
+++ /dev/null
@@ -1,78 +0,0 @@
-* Renesas R-Car Thermal
-
-Required properties:
-- compatible		: "renesas,thermal-<soctype>",
-			   "renesas,rcar-gen2-thermal" (with thermal-zone) or
-			   "renesas,rcar-thermal" (without thermal-zone) as
-                           fallback except R-Car V3M/E3/D3 and RZ/G2E.
-			  Examples with soctypes are:
-			    - "renesas,thermal-r8a73a4" (R-Mobile APE6)
-			    - "renesas,thermal-r8a7743" (RZ/G1M)
-			    - "renesas,thermal-r8a7744" (RZ/G1N)
-			    - "renesas,thermal-r8a774c0" (RZ/G2E)
-			    - "renesas,thermal-r8a7779" (R-Car H1)
-			    - "renesas,thermal-r8a7790" (R-Car H2)
-			    - "renesas,thermal-r8a7791" (R-Car M2-W)
-			    - "renesas,thermal-r8a7792" (R-Car V2H)
-			    - "renesas,thermal-r8a7793" (R-Car M2-N)
-			    - "renesas,thermal-r8a77970" (R-Car V3M)
-			    - "renesas,thermal-r8a77990" (R-Car E3)
-			    - "renesas,thermal-r8a77995" (R-Car D3)
-- reg			: Address range of the thermal registers.
-			  The 1st reg will be recognized as common register
-			  if it has "interrupts".
-
-Option properties:
-
-- interrupts		: If present should contain 3 interrupts for
-                          R-Car V3M/E3/D3 and RZ/G2E or 1 interrupt otherwise.
-
-Example (non interrupt support):
-
-thermal@ffc48000 {
-	compatible = "renesas,thermal-r8a7779", "renesas,rcar-thermal";
-	reg = <0xffc48000 0x38>;
-};
-
-Example (interrupt support):
-
-thermal@e61f0000 {
-	compatible = "renesas,thermal-r8a73a4", "renesas,rcar-thermal";
-	reg = <0xe61f0000 0x14
-		0xe61f0100 0x38
-		0xe61f0200 0x38
-		0xe61f0300 0x38>;
-	interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
-};
-
-Example (with thermal-zone):
-
-thermal-zones {
-	cpu_thermal: cpu-thermal {
-		polling-delay-passive	= <1000>;
-		polling-delay		= <5000>;
-
-		thermal-sensors = <&thermal>;
-
-		trips {
-			cpu-crit {
-				temperature	= <115000>;
-				hysteresis	= <0>;
-				type		= "critical";
-			};
-		};
-		cooling-maps {
-		};
-	};
-};
-
-thermal: thermal@e61f0000 {
-	compatible =	"renesas,thermal-r8a7790",
-			"renesas,rcar-gen2-thermal",
-			"renesas,rcar-thermal";
-	reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
-	interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&mstp5_clks R8A7790_CLK_THERMAL>;
-	power-domains = <&cpg_clocks>;
-	#thermal-sensor-cells = <0>;
-};
diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml b/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
new file mode 100644
index 0000000000000000..d2f4f1b063ac07b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
@@ -0,0 +1,139 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) 2020 Renesas Electronics Corp.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/rcar-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas R-Car Thermal
+
+maintainers:
+  - Niklas Söderlund <niklas.soderlund@ragnatech.se>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - renesas,thermal-r8a73a4 # R-Mobile APE6
+              - renesas,thermal-r8a7779 # R-Car H1
+          - const: renesas,rcar-thermal # Generic without thermal-zone
+      - items:
+          - enum:
+              - renesas,thermal-r8a7743 # RZ/G1M
+              - renesas,thermal-r8a7744 # RZ/G1N
+          - const: renesas,rcar-gen2-thermal # Generic thermal-zone
+      - items:
+          - enum:
+              - renesas,thermal-r8a7790 # R-Car H2
+              - renesas,thermal-r8a7791 # R-Car M2-W
+              - renesas,thermal-r8a7792 # R-Car V2H
+              - renesas,thermal-r8a7793 # R-Car M2-N
+          - const: renesas,rcar-gen2-thermal # Generic thermal-zone
+          - const: renesas,rcar-thermal # Generic without thermal-zone
+      - items:
+          - enum:
+              - renesas,thermal-r8a774c0 # RZ/G2E
+              - renesas,thermal-r8a77970 # R-Car V3M
+              - renesas,thermal-r8a77990 # R-Car E3
+              - renesas,thermal-r8a77995 # R-Car D3
+  reg:
+    description:
+      Address ranges of the thermal registers. If more then one range is given
+      the first one must be the common registers followed by each sensor
+      according the the datasheet.
+    minItems: 1
+    maxItems: 4
+
+  interrupts:
+    minItems: 1
+    maxItems: 3
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - renesas,thermal-r8a73a4 # R-Mobile APE6
+          - renesas,thermal-r8a7779 # R-Car H1
+then:
+  required:
+    - compatible
+    - reg
+else:
+  required:
+    - compatible
+    - reg
+    - interrupts
+    - clocks
+    - power-domains
+    - resets
+
+examples:
+  # Example (non interrupt support)
+  - |
+    thermal@ffc48000 {
+            compatible = "renesas,thermal-r8a7779", "renesas,rcar-thermal";
+            reg = <0xffc48000 0x38>;
+    };
+
+  # Example (interrupt support)
+  - |
+    #include <dt-bindings/clock/r8a73a4-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    thermal@e61f0000 {
+            compatible = "renesas,thermal-r8a73a4", "renesas,rcar-thermal";
+            reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>,
+                  <0 0xe61f0200 0 0x38>, <0 0xe61f0300 0 0x38>;
+            interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&mstp5_clks R8A73A4_CLK_THERMAL>;
+            power-domains = <&pd_c5>;
+    };
+
+  # Example (with thermal-zone)
+  - |
+    #include <dt-bindings/clock/r8a7790-cpg-mssr.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/r8a7790-sysc.h>
+
+    thermal: thermal@e61f0000 {
+      compatible = "renesas,thermal-r8a7790",
+                   "renesas,rcar-gen2-thermal",
+                   "renesas,rcar-thermal";
+            reg = <0 0xe61f0000 0 0x10>, <0 0xe61f0100 0 0x38>;
+            interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cpg CPG_MOD 522>;
+            power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+            resets = <&cpg 522>;
+            #thermal-sensor-cells = <0>;
+    };
+
+    thermal-zones {
+            cpu_thermal: cpu-thermal {
+                    polling-delay-passive = <1000>;
+                    polling-delay = <5000>;
+
+                    thermal-sensors = <&thermal>;
+
+                    trips {
+                            cpu-crit {
+                                    temperature = <115000>;
+                                    hysteresis = <0>;
+                                    type = "critical";
+                            };
+                    };
+                    cooling-maps {
+                    };
+            };
+    };
-- 
2.25.1

