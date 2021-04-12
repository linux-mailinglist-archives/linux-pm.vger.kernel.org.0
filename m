Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E93035D39F
	for <lists+linux-pm@lfdr.de>; Tue, 13 Apr 2021 01:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244090AbhDLXDp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Apr 2021 19:03:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48930 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243199AbhDLXDo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Apr 2021 19:03:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id CD2A71F453D0
Received: by jupiter.universe (Postfix, from userid 1000)
        id E733F4800DC; Tue, 13 Apr 2021 01:03:21 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 4/6] dt-bindings: power: supply: charger-manager: Convert to DT schema format
Date:   Tue, 13 Apr 2021 01:03:18 +0200
Message-Id: <20210412230320.382885-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210412230320.382885-1-sebastian.reichel@collabora.com>
References: <20210412230320.382885-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the binding to DT schema format.

I slightly modified the binding by allowing regulator-[0-9] and cable-[0-9]
instead of regulator@[0-9] and cable@[0-9], so that DT compiler does not
complain about missing 'reg' property. The driver actually ignores the
nodename and can handle both styles.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/power/supply/charger-manager.txt |  91 --------
 .../power/supply/charger-manager.yaml         | 215 ++++++++++++++++++
 2 files changed, 215 insertions(+), 91 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/charger-manager.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/charger-manager.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/charger-manager.txt b/Documentation/devicetree/bindings/power/supply/charger-manager.txt
deleted file mode 100644
index b5ae9061b7a0..000000000000
--- a/Documentation/devicetree/bindings/power/supply/charger-manager.txt
+++ /dev/null
@@ -1,91 +0,0 @@
-charger-manager bindings
-~~~~~~~~~~~~~~~~~~~~~~~~
-
-Required properties :
- - compatible : "charger-manager"
- - <>-supply : for regulator consumer, named according to cm-regulator-name
- - cm-chargers : name of chargers
- - cm-fuel-gauge : name of battery fuel gauge
- - subnode <regulator> :
-	- cm-regulator-name : name of charger regulator
-	- subnode <cable> :
-		- cm-cable-name : name of charger cable - one of USB, USB-HOST,
-			SDP, DCP, CDP, ACA, FAST-CHARGER, SLOW-CHARGER, WPT,
-			PD, DOCK, JIG, or MECHANICAL
-		- cm-cable-extcon : name of extcon dev
-(optional)	- cm-cable-min : minimum current of cable
-(optional)	- cm-cable-max : maximum current of cable
-
-Optional properties :
- - cm-name : charger manager's name (default : "battery")
- - cm-poll-mode : polling mode - 0 for disabled, 1 for always, 2 for when
-	external power is connected, or 3 for when charging.  If not present,
-	then polling is disabled
- - cm-poll-interval : polling interval (in ms)
- - cm-battery-stat : battery status - 0 for battery always present, 1 for no
-	battery, 2 to check presence via fuel gauge, or 3 to check presence
-	via charger
- - cm-fullbatt-vchkdrop-volt : voltage drop (in uV) before restarting charging
- - cm-fullbatt-voltage : voltage (in uV) of full battery
- - cm-fullbatt-soc : state of charge to consider as full battery
- - cm-fullbatt-capacity : capcity (in uAh) to consider as full battery
- - cm-thermal-zone : name of external thermometer's thermal zone
- - cm-battery-* : threshold battery temperature for charging
-	-cold : critical cold temperature of battery for charging
-	-cold-in-minus : flag that cold temperature is in minus degrees
-	-hot : critical hot temperature of battery for charging
-	-temp-diff : temperature difference to allow recharging
- - cm-dis/charging-max = limits of charging duration
-
-Deprecated properties:
- - cm-num-chargers
- - cm-fullbatt-vchkdrop-ms
-
-Example :
-	charger-manager@0 {
-		compatible = "charger-manager";
-		chg-reg-supply = <&charger_regulator>;
-
-		cm-name = "battery";
-		/* Always polling ON : 30s */
-		cm-poll-mode = <1>;
-		cm-poll-interval = <30000>;
-
-		cm-fullbatt-vchkdrop-volt = <150000>;
-		cm-fullbatt-soc = <100>;
-
-		cm-battery-stat = <3>;
-
-		cm-chargers = "charger0", "charger1", "charger2";
-
-		cm-fuel-gauge = "fuelgauge0";
-
-		cm-thermal-zone = "thermal_zone.1"
-		/* in deci centigrade */
-		cm-battery-cold = <50>;
-		cm-battery-cold-in-minus;
-		cm-battery-hot = <800>;
-		cm-battery-temp-diff = <100>;
-
-		/* Allow charging for 5hr */
-		cm-charging-max = <18000000>;
-		/* Allow discharging for 2hr */
-		cm-discharging-max = <7200000>;
-
-		regulator@0 {
-			cm-regulator-name = "chg-reg";
-			cable@0 {
-				cm-cable-name = "USB";
-				cm-cable-extcon = "extcon-dev.0";
-				cm-cable-min = <475000>;
-				cm-cable-max = <500000>;
-			};
-			cable@1 {
-				cm-cable-name = "SDP";
-				cm-cable-extcon = "extcon-dev.0";
-				cm-cable-min = <650000>;
-				cm-cable-max = <675000>;
-			};
-		};
-
-	};
diff --git a/Documentation/devicetree/bindings/power/supply/charger-manager.yaml b/Documentation/devicetree/bindings/power/supply/charger-manager.yaml
new file mode 100644
index 000000000000..c863cfa67865
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/charger-manager.yaml
@@ -0,0 +1,215 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/charger-manager.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Charger Manager
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+description: |
+  Binding for the legacy charger manager driver.
+  Please do not use for new products.
+
+properties:
+  compatible:
+    const: charger-manager
+
+  cm-chargers:
+    description: name of chargers
+    $ref: /schemas/types.yaml#/definitions/string-array
+
+  cm-num-chargers:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+
+  cm-fuel-gauge:
+    description: name of battery fuel gauge
+    $ref: /schemas/types.yaml#/definitions/string
+
+  cm-name:
+    description: name of the charger manager
+    default: battery
+    $ref: /schemas/types.yaml#/definitions/string
+
+  cm-poll-mode:
+    description: polling mode
+    default: 0
+    enum:
+      - 0 # disabled
+      - 1 # always
+      - 2 # when external power is connected
+      - 3 # when charging
+
+  cm-poll-interval:
+    description: polling interval (in ms)
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  cm-battery-stat:
+    description: battery status
+    enum:
+      - 0 # battery always present
+      - 1 # no battery
+      - 2 # check presence via fuel gauge
+      - 3 # check presence via charger
+
+  cm-fullbatt-vchkdrop-volt:
+    description: voltage drop before restarting charging in uV
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  cm-fullbatt-vchkdrop-ms:
+    deprecated: true
+
+  cm-fullbatt-voltage:
+    description: voltage of full battery in uV
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  cm-fullbatt-soc:
+    description: state of charge to consider as full battery in %
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  cm-fullbatt-capacity:
+    description: capcity to consider as full battery in uAh
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  cm-thermal-zone:
+    description: name of external thermometer's thermal zone
+    $ref: /schemas/types.yaml#/definitions/string
+
+  cm-discharging-max:
+    description: limits of discharging duration in ms
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  cm-charging-max:
+    description: limits of charging duration in ms
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  cm-battery-cold:
+    description: critical cold temperature of battery for charging in deci-degree celsius
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  cm-battery-cold-in-minus:
+    description: if set cm-battery-cold temperature is in minus degrees
+    type: boolean
+
+  cm-battery-hot:
+    description: critical hot temperature of battery for charging in deci-degree celsius
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  cm-battery-temp-diff:
+    description: temperature difference to allow recharging in deci-degree celsius
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+patternProperties:
+  "-supply$":
+    description: regulator consumer, named according to cm-regulator-name
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  "^regulator[@-][0-9]$":
+    type: object
+    properties:
+      cm-regulator-name:
+        description: name of charger regulator
+        $ref: /schemas/types.yaml#/definitions/string
+
+    required:
+      - cm-regulator-name
+
+    additionalProperties: false
+
+    patternProperties:
+      "^cable[@-][0-9]$":
+        type: object
+        properties:
+          cm-cable-name:
+            description: name of charger cable
+            enum:
+              - USB
+              - USB-HOST
+              - SDP
+              - DCP
+              - CDP
+              - ACA
+              - FAST-CHARGER
+              - SLOW-CHARGER
+              - WPT
+              - PD
+              - DOCK
+              - JIG
+              - MECHANICAL
+
+          cm-cable-extcon:
+            description: name of extcon dev
+            $ref: /schemas/types.yaml#/definitions/string
+
+          cm-cable-min:
+            description: minimum current of cable in uA
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          cm-cable-max:
+            description: maximum current of cable in uA
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+        required:
+          - cm-cable-name
+          - cm-cable-extcon
+
+        additionalProperties: false
+
+required:
+  - compatible
+  - cm-chargers
+  - cm-fuel-gauge
+
+additionalProperties: false
+
+examples:
+  - |
+    charger-manager {
+        compatible = "charger-manager";
+        chg-reg-supply = <&charger_regulator>;
+
+        cm-name = "battery";
+        /* Always polling ON : 30s */
+        cm-poll-mode = <1>;
+        cm-poll-interval = <30000>;
+
+        cm-fullbatt-vchkdrop-volt = <150000>;
+        cm-fullbatt-soc = <100>;
+
+        cm-battery-stat = <3>;
+
+        cm-chargers = "charger0", "charger1", "charger2";
+
+        cm-fuel-gauge = "fuelgauge0";
+
+        cm-thermal-zone = "thermal_zone.1";
+        /* in deci centigrade */
+        cm-battery-cold = <50>;
+        cm-battery-cold-in-minus;
+        cm-battery-hot = <800>;
+        cm-battery-temp-diff = <100>;
+
+        /* Allow charging for 5hr */
+        cm-charging-max = <18000000>;
+        /* Allow discharging for 2hr */
+        cm-discharging-max = <7200000>;
+
+        regulator-0 {
+            cm-regulator-name = "chg-reg";
+            cable-0 {
+                cm-cable-name = "USB";
+                cm-cable-extcon = "extcon-dev.0";
+                cm-cable-min = <475000>;
+                cm-cable-max = <500000>;
+            };
+            cable-1 {
+                cm-cable-name = "SDP";
+                cm-cable-extcon = "extcon-dev.0";
+                cm-cable-min = <650000>;
+                cm-cable-max = <675000>;
+            };
+        };
+    };
-- 
2.30.2

