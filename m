Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6251AB723
	for <lists+linux-pm@lfdr.de>; Thu, 16 Apr 2020 07:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405878AbgDPFMf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Apr 2020 01:12:35 -0400
Received: from mx.socionext.com ([202.248.49.38]:55850 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406149AbgDPFMc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Apr 2020 01:12:32 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 16 Apr 2020 14:12:27 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id A338960057;
        Thu, 16 Apr 2020 14:12:27 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 16 Apr 2020 14:12:27 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id EA77F1A12AD;
        Thu, 16 Apr 2020 14:12:26 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] dt-bindings: thermal: Convert UniPhier thermal monitor to json-schema
Date:   Thu, 16 Apr 2020 14:12:15 +0900
Message-Id: <1587013935-21760-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the UniPhier thermal monitor binding to DT schema format.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../thermal/socionext,uniphier-thermal.yaml        | 57 +++++++++++++++++++
 .../bindings/thermal/uniphier-thermal.txt          | 65 ----------------------
 2 files changed, 57 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
 delete mode 100644 Documentation/devicetree/bindings/thermal/uniphier-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
new file mode 100644
index 0000000..bdddc5b
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/socionext,uniphier-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext UniPhier thermal monitor
+
+description: |
+  This describes the devicetree bindings for thermal monitor supported by
+  PVT(Process, Voltage and Temperature) monitoring unit implemented on
+  Socionext UniPhier SoCs.
+
+maintainers:
+  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+properties:
+  compatible:
+    enum:
+      - socionext,uniphier-pxs2-thermal
+      - socionext,uniphier-ld20-thermal
+      - socionext,uniphier-pxs3-thermal
+
+  interrupts:
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 0
+
+  socionext,tmod-calibration:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      A pair of calibrated values referred from PVT, in case that the values
+      aren't set on SoC, like a reference board.
+
+required:
+  - compatible
+  - interrupts
+  - "#thermal-sensor-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    // The UniPhier thermal should be a subnode of a "syscon" compatible node.
+
+    sysctrl@61840000 {
+        compatible = "socionext,uniphier-ld20-sysctrl",
+                     "simple-mfd", "syscon";
+        reg = <0x61840000 0x10000>;
+
+        pvtctl: thermal {
+                compatible = "socionext,uniphier-ld20-thermal";
+                interrupts = <0 3 1>;
+                #thermal-sensor-cells = <0>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/thermal/uniphier-thermal.txt b/Documentation/devicetree/bindings/thermal/uniphier-thermal.txt
deleted file mode 100644
index ceb92a9..0000000
--- a/Documentation/devicetree/bindings/thermal/uniphier-thermal.txt
+++ /dev/null
@@ -1,65 +0,0 @@
-* UniPhier Thermal bindings
-
-This describes the devicetree bindings for thermal monitor supported by
-PVT(Process, Voltage and Temperature) monitoring unit implemented on Socionext
-UniPhier SoCs.
-
-Required properties:
-- compatible :
-  - "socionext,uniphier-pxs2-thermal" : For UniPhier PXs2 SoC
-  - "socionext,uniphier-ld20-thermal" : For UniPhier LD20 SoC
-  - "socionext,uniphier-pxs3-thermal" : For UniPhier PXs3 SoC
-- interrupts : IRQ for the temperature alarm
-- #thermal-sensor-cells : Should be 0. See ./thermal.txt for details.
-
-Optional properties:
-- socionext,tmod-calibration: A pair of calibrated values referred from PVT,
-                              in case that the values aren't set on SoC,
-                              like a reference board.
-
-Example:
-
-	sysctrl@61840000 {
-		compatible = "socionext,uniphier-ld20-sysctrl",
-			     "simple-mfd", "syscon";
-		reg = <0x61840000 0x10000>;
-		...
-		pvtctl: pvtctl {
-			compatible = "socionext,uniphier-ld20-thermal";
-			interrupts = <0 3 1>;
-			#thermal-sensor-cells = <0>;
-		};
-		...
-	};
-
-	thermal-zones {
-		cpu_thermal {
-			polling-delay-passive = <250>;	/* 250ms */
-			polling-delay = <1000>;		/* 1000ms */
-			thermal-sensors = <&pvtctl>;
-
-			trips {
-				cpu_crit: cpu_crit {
-					temperature = <110000>;	/* 110C */
-					hysteresis = <2000>;
-					type = "critical";
-				};
-				cpu_alert: cpu_alert {
-					temperature = <100000>;	/* 100C */
-					hysteresis = <2000>;
-					type = "passive";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu_alert>;
-					cooling-device = <&cpu0 (-1) (-1)>;
-				};
-				map1 {
-					trip = <&cpu_alert>;
-					cooling-device = <&cpu2 (-1) (-1)>;
-				};
-			};
-		};
-	};
-- 
2.7.4

