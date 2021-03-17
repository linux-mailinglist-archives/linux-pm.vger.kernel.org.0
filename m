Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D91833F187
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 14:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhCQNth (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 09:49:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56150 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbhCQNtL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:49:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A4A6B1F44A02
Received: by jupiter.universe (Postfix, from userid 1000)
        id C63CE4800DD; Wed, 17 Mar 2021 14:49:05 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 05/38] dt-bindings: power: supply: bq24257: Convert to DT schema format
Date:   Wed, 17 Mar 2021 14:48:31 +0100
Message-Id: <20210317134904.80737-6-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210317134904.80737-1-sebastian.reichel@collabora.com>
References: <20210317134904.80737-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the binding to DT schema format.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/power/supply/bq24257.txt         |  62 ---------
 .../bindings/power/supply/bq24257.yaml        | 124 ++++++++++++++++++
 2 files changed, 124 insertions(+), 62 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/bq24257.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq24257.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/bq24257.txt b/Documentation/devicetree/bindings/power/supply/bq24257.txt
deleted file mode 100644
index f8f5a1685bb9..000000000000
--- a/Documentation/devicetree/bindings/power/supply/bq24257.txt
+++ /dev/null
@@ -1,62 +0,0 @@
-Binding for TI bq24250/bq24251/bq24257 Li-Ion Charger
-
-Required properties:
-- compatible: Should contain one of the following:
- * "ti,bq24250"
- * "ti,bq24251"
- * "ti,bq24257"
-- reg: integer, i2c address of the device.
-- interrupts: Interrupt mapping for GPIO IRQ (configure for both edges). Use in
-    conjunction with "interrupt-parent".
-- ti,battery-regulation-voltage: integer, maximum charging voltage in uV.
-- ti,charge-current: integer, maximum charging current in uA.
-- ti,termination-current: integer, charge will be terminated when current in
-    constant-voltage phase drops below this value (in uA).
-
-Optional properties:
-- pg-gpios: GPIO used for connecting the bq2425x device PG (Power Good) pin.
-    This pin is not available on all devices however it should be used if
-    possible as this is the recommended way to obtain the charger's input PG
-    state. If this pin is not specified a software-based approach for PG
-    detection is used.
-- ti,current-limit: The maximum current to be drawn from the charger's input
-    (in uA). If this property is not specified, the input limit current is
-    set automatically using USB D+/D- signal based charger type detection.
-    If the hardware does not support the D+/D- based detection, a default
-    of 500,000 is used (=500mA) instead.
-- ti,ovp-voltage: Configures the over voltage protection voltage (in uV). If
-    not specified a default of 6,5000,000 (=6.5V) is used.
-- ti,in-dpm-voltage: Configures the threshold input voltage for the dynamic
-    power path management (in uV). If not specified a default of 4,360,000
-    (=4.36V) is used.
-
-Example:
-
-bq24257 {
-	compatible = "ti,bq24257";
-	reg = <0x6a>;
-	interrupt-parent = <&gpio1>;
-	interrupts = <16 IRQ_TYPE_EDGE_BOTH>;
-
-	pg-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
-
-	ti,battery-regulation-voltage = <4200000>;
-	ti,charge-current = <1000000>;
-	ti,termination-current = <50000>;
-};
-
-Example:
-
-bq24250 {
-	compatible = "ti,bq24250";
-	reg = <0x6a>;
-	interrupt-parent = <&gpio1>;
-	interrupts = <16 IRQ_TYPE_EDGE_BOTH>;
-
-	ti,battery-regulation-voltage = <4200000>;
-	ti,charge-current = <500000>;
-	ti,termination-current = <50000>;
-	ti,current-limit = <900000>;
-	ti,ovp-voltage = <9500000>;
-	ti,in-dpm-voltage = <4440000>;
-};
diff --git a/Documentation/devicetree/bindings/power/supply/bq24257.yaml b/Documentation/devicetree/bindings/power/supply/bq24257.yaml
new file mode 100644
index 000000000000..3a0f6cd9015a
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/bq24257.yaml
@@ -0,0 +1,124 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 Sebastian Reichel
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/bq24257.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Binding for bq24250, bq24251 and bq24257 Li-Ion Charger
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ti,bq24250
+      - ti,bq24251
+      - ti,bq24257
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  ti,battery-regulation-voltage:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: maximum charging voltage in uV
+
+  ti,charge-current:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: maximum charging current in uA
+
+  ti,termination-current:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      charge will be terminated when current in constant-voltage phase
+      drops below this value (in uA)
+
+  pg-gpios:
+    description: |
+      GPIO used for connecting the bq2425x device PG (Power Good) pin.
+      This pin is not available on all devices however it should be used if
+      possible as this is the recommended way to obtain the charger's input PG
+      state. If this pin is not specified a software-based approach for PG
+      detection is used.
+    maxItems: 1
+
+  ti,current-limit:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      The maximum current to be drawn from the charger's input (in uA).
+      If this property is not specified, the input limit current is set
+      automatically using USB D+/D- signal based charger type detection.
+      If the hardware does not support the D+/D- based detection, a default
+      of 500,000 is used (=500mA) instead.
+
+  ti,ovp-voltage:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Configures the over voltage protection voltage (in uV).
+      If not specified a default of 6,5000,000 (=6.5V) is used.
+
+  ti,in-dpm-voltage:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Configures the threshold input voltage for the dynamic power path management (in uV).
+      If not specified a default of 4,360,000 (=4.36V) is used.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - ti,battery-regulation-voltage
+  - ti,charge-current
+  - ti,termination-current
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      charger@6a {
+        compatible = "ti,bq24257";
+        reg = <0x6a>;
+        interrupt-parent = <&gpio1>;
+        interrupts = <16 IRQ_TYPE_EDGE_BOTH>;
+
+        pg-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+
+        ti,battery-regulation-voltage = <4200000>;
+        ti,charge-current = <1000000>;
+        ti,termination-current = <50000>;
+      };
+    };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      charger@6a {
+        compatible = "ti,bq24250";
+        reg = <0x6a>;
+        interrupt-parent = <&gpio1>;
+        interrupts = <16 IRQ_TYPE_EDGE_BOTH>;
+
+        ti,battery-regulation-voltage = <4200000>;
+        ti,charge-current = <500000>;
+        ti,termination-current = <50000>;
+        ti,current-limit = <900000>;
+        ti,ovp-voltage = <9500000>;
+        ti,in-dpm-voltage = <4440000>;
+      };
+    };
-- 
2.30.2

