Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF64333F186
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 14:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhCQNth (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 09:49:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56148 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbhCQNtL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:49:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A741D1F44A18
Received: by jupiter.universe (Postfix, from userid 1000)
        id CB9644800DF; Wed, 17 Mar 2021 14:49:05 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 07/38] dt-bindings: power: supply: bq2415x: Convert to DT schema format
Date:   Wed, 17 Mar 2021 14:48:33 +0100
Message-Id: <20210317134904.80737-8-sebastian.reichel@collabora.com>
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
 .../bindings/power/supply/bq2415x.txt         | 47 ---------
 .../bindings/power/supply/bq2415x.yaml        | 98 +++++++++++++++++++
 2 files changed, 98 insertions(+), 47 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/bq2415x.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq2415x.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/bq2415x.txt b/Documentation/devicetree/bindings/power/supply/bq2415x.txt
deleted file mode 100644
index d0327f0b59ad..000000000000
--- a/Documentation/devicetree/bindings/power/supply/bq2415x.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-Binding for TI bq2415x Li-Ion Charger
-
-Required properties:
-- compatible: Should contain one of the following:
- * "ti,bq24150"
- * "ti,bq24150"
- * "ti,bq24150a"
- * "ti,bq24151"
- * "ti,bq24151a"
- * "ti,bq24152"
- * "ti,bq24153"
- * "ti,bq24153a"
- * "ti,bq24155"
- * "ti,bq24156"
- * "ti,bq24156a"
- * "ti,bq24158"
-- reg:			   integer, i2c address of the device.
-- ti,current-limit:	   integer, initial maximum current charger can pull
-			   from power supply in mA.
-- ti,weak-battery-voltage: integer, weak battery voltage threshold in mV.
-			   The chip will use slow precharge if battery voltage
-			   is below this value.
-- ti,battery-regulation-voltage: integer, maximum charging voltage in mV.
-- ti,charge-current:	   integer, maximum charging current in mA.
-- ti,termination-current:  integer, charge will be terminated when current in
-			   constant-voltage phase drops below this value (in mA).
-- ti,resistor-sense:	   integer, value of sensing resistor in milliohm.
-
-Optional properties:
-- ti,usb-charger-detection: phandle to usb charger detection device.
-			    (required for auto mode)
-
-Example from Nokia N900:
-
-bq24150a {
-	compatible = "ti,bq24150a";
-	reg = <0x6b>;
-
-	ti,current-limit = <100>;
-	ti,weak-battery-voltage = <3400>;
-	ti,battery-regulation-voltage = <4200>;
-	ti,charge-current = <650>;
-	ti,termination-current = <100>;
-	ti,resistor-sense = <68>;
-
-	ti,usb-charger-detection = <&isp1704>;
-};
diff --git a/Documentation/devicetree/bindings/power/supply/bq2415x.yaml b/Documentation/devicetree/bindings/power/supply/bq2415x.yaml
new file mode 100644
index 000000000000..f8461f06e6f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/bq2415x.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 Sebastian Reichel
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/bq2415x.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Binding for TI bq2415x Li-Ion Charger
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
+      - ti,bq24150
+      - ti,bq24150
+      - ti,bq24150a
+      - ti,bq24151
+      - ti,bq24151a
+      - ti,bq24152
+      - ti,bq24153
+      - ti,bq24153a
+      - ti,bq24155
+      - ti,bq24156
+      - ti,bq24156a
+      - ti,bq24158
+
+  reg:
+    maxItems: 1
+
+  ti,current-limit:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: initial maximum current charger can pull from power supply in mA.
+
+  ti,weak-battery-voltage:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      weak battery voltage threshold in mV.
+      The chip will use slow precharge if battery voltage is below this value.
+
+  ti,battery-regulation-voltage:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: maximum charging voltage in mV.
+
+  ti,charge-current:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: maximum charging current in mA.
+
+  ti,termination-current:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      charge will be terminated when current in constant-voltage phase drops
+      below this value (in mA).
+
+  ti,resistor-sense:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: value of sensing resistor in milliohm.
+
+  ti,usb-charger-detection:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to usb charger detection device (required for auto mode)
+
+required:
+  - compatible
+  - reg
+  - ti,current-limit
+  - ti,weak-battery-voltage
+  - ti,battery-regulation-voltage
+  - ti,charge-current
+  - ti,termination-current
+  - ti,resistor-sense
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      charger@6b {
+        compatible = "ti,bq24150a";
+        reg = <0x6b>;
+
+        ti,current-limit = <100>;
+        ti,weak-battery-voltage = <3400>;
+        ti,battery-regulation-voltage = <4200>;
+        ti,charge-current = <650>;
+        ti,termination-current = <100>;
+        ti,resistor-sense = <68>;
+
+        ti,usb-charger-detection = <&isp1704>;
+      };
+    };
-- 
2.30.2

