Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5AC33F1AE
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 14:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhCQNtw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 09:49:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56232 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbhCQNtP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:49:15 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 2CFDD1F44A23
Received: by jupiter.universe (Postfix, from userid 1000)
        id 259DD48011D; Wed, 17 Mar 2021 14:49:06 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 35/38] dt-bindings: power: supply: ab8500: Convert to DT schema format
Date:   Wed, 17 Mar 2021 14:49:01 +0100
Message-Id: <20210317134904.80737-36-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210317134904.80737-1-sebastian.reichel@collabora.com>
References: <20210317134904.80737-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the binding to DT schema format.

Note: The battery node does not have a compatible value and needs
to be described from the binding file for the PMIC. That has not
yet been converted, so I kept the information in plaintext for now.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/power/supply/ab8500/btemp.txt    |  16 ---
 .../bindings/power/supply/ab8500/chargalg.txt |  16 ---
 .../bindings/power/supply/ab8500/charger.txt  |  25 ----
 .../fg.txt => stericsson,ab8500-battery.txt}  |  32 +----
 .../power/supply/stericsson,ab8500-btemp.yaml |  73 +++++++++++
 .../supply/stericsson,ab8500-chargalg.yaml    |  37 ++++++
 .../supply/stericsson,ab8500-charger.yaml     | 123 ++++++++++++++++++
 .../power/supply/stericsson,ab8500-fg.yaml    |  72 ++++++++++
 8 files changed, 309 insertions(+), 85 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/ab8500/btemp.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/ab8500/chargalg.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/ab8500/charger.txt
 rename Documentation/devicetree/bindings/power/supply/{ab8500/fg.txt => stericsson,ab8500-battery.txt} (52%)
 create mode 100644 Documentation/devicetree/bindings/power/supply/stericsson,ab8500-btemp.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/stericsson,ab8500-chargalg.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/stericsson,ab8500-fg.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/ab8500/btemp.txt b/Documentation/devicetree/bindings/power/supply/ab8500/btemp.txt
deleted file mode 100644
index f181e46d8e07..000000000000
--- a/Documentation/devicetree/bindings/power/supply/ab8500/btemp.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-=== AB8500 Battery Temperature Monitor Driver ===
-
-The properties below describes the node for btemp driver.
-
-Required Properties:
-- compatible = Shall be: "stericsson,ab8500-btemp"
-- battery = Shall be battery specific information
-
-	Example:
-	ab8500_btemp {
-		compatible = "stericsson,ab8500-btemp";
-		battery	   = <&ab8500_battery>;
-	};
-
-For information on battery specific node, Ref:
-Documentation/devicetree/bindings/power/supply/ab8500/fg.txt
diff --git a/Documentation/devicetree/bindings/power/supply/ab8500/chargalg.txt b/Documentation/devicetree/bindings/power/supply/ab8500/chargalg.txt
deleted file mode 100644
index 56636f927203..000000000000
--- a/Documentation/devicetree/bindings/power/supply/ab8500/chargalg.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-=== AB8500 Charging Algorithm Driver ===
-
-The properties below describes the node for chargalg driver.
-
-Required Properties:
-- compatible = Shall be: "stericsson,ab8500-chargalg"
-- battery = Shall be battery specific information
-
-Example:
-ab8500_chargalg {
-	compatible = "stericsson,ab8500-chargalg";
-	battery	   = <&ab8500_battery>;
-};
-
-For information on battery specific node, Ref:
-Documentation/devicetree/bindings/power/supply/ab8500/fg.txt
diff --git a/Documentation/devicetree/bindings/power/supply/ab8500/charger.txt b/Documentation/devicetree/bindings/power/supply/ab8500/charger.txt
deleted file mode 100644
index 24ada03e07b4..000000000000
--- a/Documentation/devicetree/bindings/power/supply/ab8500/charger.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-=== AB8500 Charger Driver ===
-
-Required Properties:
-- compatible = Shall be "stericsson,ab8500-charger"
-- battery = Shall be battery specific information
-	Example:
-	ab8500_charger {
-		compatible = "stericsson,ab8500-charger";
-		battery	   = <&ab8500_battery>;
-	};
-
-- vddadc-supply: Supply for USB and Main charger
-	Example:
-	ab8500-charger {
-		vddadc-supply	= <&ab8500_ldo_tvout_reg>;
-	}
-- autopower_cfg:
-	Boolean value depicting the presence of 'automatic poweron after powerloss'
-	Example:
-	ab8500-charger {
-		autopower_cfg;
-	};
-
-For information on battery specific node, Ref:
-Documentation/devicetree/bindings/power/supply/ab8500/fg.txt
diff --git a/Documentation/devicetree/bindings/power/supply/ab8500/fg.txt b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-battery.txt
similarity index 52%
rename from Documentation/devicetree/bindings/power/supply/ab8500/fg.txt
rename to Documentation/devicetree/bindings/power/supply/stericsson,ab8500-battery.txt
index ccafcb9112fb..ee125cb0e46d 100644
--- a/Documentation/devicetree/bindings/power/supply/ab8500/fg.txt
+++ b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-battery.txt
@@ -1,32 +1,9 @@
-=== AB8500 Fuel Gauge Driver ===
-
-AB8500 is a mixed signal multimedia and power management
-device comprising: power and energy-management-module,
-wall-charger, usb-charger, audio codec, general purpose adc,
-tvout, clock management and sim card interface.
-
-Fuelgauge support is part of energy-management-modules, other
-components of this module are:
-main-charger, usb-combo-charger and battery-temperature-monitoring.
-
-The properties below describes the node for fuelgauge driver.
-
-Required Properties:
-- compatible = This shall be: "stericsson,ab8500-fg"
-- battery = Shall be battery specific information
-	Example:
-	ab8500_fg {
-		compatible = "stericsson,ab8500-fg";
-		battery	   = <&ab8500_battery>;
-	};
-
-dependent node:
-	ab8500_battery: ab8500_battery {
-	};
-	This node will provide information on 'thermistor interface' and
-	'battery technology type' used.
+AB85000 PMIC contains a node, which contains shared
+information about the battery connected to the PMIC.
+The node has no compatible property.
 
 Properties of this node are:
+
 thermistor-on-batctrl:
 	A boolean value indicating thermistor interface	to battery
 
@@ -55,4 +32,3 @@ battery-type:
 	ab8500_battery: ab8500_battery {
 		stericsson,battery-type = "LIPO";
 	}
-
diff --git a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-btemp.yaml b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-btemp.yaml
new file mode 100644
index 000000000000..2f57aa5a5f4e
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-btemp.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 Sebastian Reichel
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/stericsson,ab8500-btemp.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: AB8500 Battery Temperature Monitor
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: stericsson,ab8500-btemp
+
+  battery:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to battery node
+
+  interrupts:
+    maxItems: 5
+
+  interrupt-names:
+    items:
+      - const: BAT_CTRL_INDB
+      - const: BTEMP_LOW
+      - const: BTEMP_HIGH
+      - const: BTEMP_LOW_MEDIUM
+      - const: BTEMP_MEDIUM_HIGH
+
+  io-channels:
+    maxItems: 2
+
+  io-channel-names:
+    items:
+      - const: btemp_ball
+      - const: bat_ctrl
+
+required:
+  - compatible
+  - battery
+  - interrupts
+  - interrupt-names
+  - io-channels
+  - io-channel-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    pmic {
+      battery-temperature {
+        compatible = "stericsson,ab8500-btemp";
+        battery = <&ab8500_battery>;
+        interrupts = <20 IRQ_TYPE_LEVEL_HIGH>,
+                     <80 IRQ_TYPE_LEVEL_HIGH>,
+                     <83 IRQ_TYPE_LEVEL_HIGH>,
+                     <81 IRQ_TYPE_LEVEL_HIGH>,
+                     <82 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "BAT_CTRL_INDB",
+                          "BTEMP_LOW",
+                          "BTEMP_HIGH",
+                          "BTEMP_LOW_MEDIUM",
+                          "BTEMP_MEDIUM_HIGH";
+        io-channels = <&gpadc 0x02>, <&gpadc 0x01>;
+        io-channel-names = "btemp_ball", "bat_ctrl";
+      };
+    };
diff --git a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-chargalg.yaml b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-chargalg.yaml
new file mode 100644
index 000000000000..0897231c2f6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-chargalg.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 Sebastian Reichel
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/stericsson,ab8500-chargalg.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: AB8500 Charging Algorithm
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: stericsson,ab8500-chargalg
+
+  battery:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to battery node
+
+required:
+  - compatible
+  - battery
+
+additionalProperties: false
+
+examples:
+  - |
+    pmic {
+      charging-algorithm {
+        compatible = "stericsson,ab8500-chargalg";
+        battery = <&ab8500_battery>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml
new file mode 100644
index 000000000000..e13305afea69
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 Sebastian Reichel
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/stericsson,ab8500-charger.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: AB8500 Charger
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: stericsson,ab8500-charger
+
+  battery:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to battery node
+
+  vddadc-supply:
+    description: Supply for USB and Main charger
+
+  autopower_cfg:
+    type: boolean
+    description: automatic poweron after powerloss
+
+  interrupts:
+    maxItems: 14
+
+  interrupt-names:
+    items:
+      - const: MAIN_CH_UNPLUG_DET
+      - const: MAIN_CHARGE_PLUG_DET
+      - const: MAIN_EXT_CH_NOT_OK
+      - const: MAIN_CH_TH_PROT_R
+      - const: MAIN_CH_TH_PROT_F
+      - const: VBUS_DET_F
+      - const: VBUS_DET_R
+      - const: USB_LINK_STATUS
+      - const: USB_CH_TH_PROT_R
+      - const: USB_CH_TH_PROT_F
+      - const: USB_CHARGER_NOT_OKR
+      - const: VBUS_OVV
+      - const: CH_WD_EXP
+      - const: VBUS_CH_DROP_END
+
+  io-channels:
+    minItems: 2
+    maxItems: 4
+
+  io-channel-names:
+    oneOf:
+      - items:
+          - const: main_charger_v
+          - const: main_charger_c
+          - const: vbus_v
+          - const: usb_charger_c
+      - items:
+          - const: vbus_v
+          - const: usb_charger_c
+
+
+required:
+  - compatible
+  - battery
+  - vddadc-supply
+  - interrupts
+  - interrupt-names
+  - io-channels
+  - io-channel-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    pmic {
+      charger {
+        compatible = "stericsson,ab8500-charger";
+        battery = <&ab8500_battery>;
+        vddadc-supply = <&ab8500_ldo_tvout_reg>;
+        interrupts = <10 IRQ_TYPE_LEVEL_HIGH>,
+                     <11 IRQ_TYPE_LEVEL_HIGH>,
+                     <0 IRQ_TYPE_LEVEL_HIGH>,
+                     <107 IRQ_TYPE_LEVEL_HIGH>,
+                     <106 IRQ_TYPE_LEVEL_HIGH>,
+                     <14 IRQ_TYPE_LEVEL_HIGH>,
+                     <15 IRQ_TYPE_LEVEL_HIGH>,
+                     <79 IRQ_TYPE_LEVEL_HIGH>,
+                     <105 IRQ_TYPE_LEVEL_HIGH>,
+                     <104 IRQ_TYPE_LEVEL_HIGH>,
+                     <89 IRQ_TYPE_LEVEL_HIGH>,
+                     <22 IRQ_TYPE_LEVEL_HIGH>,
+                     <21 IRQ_TYPE_LEVEL_HIGH>,
+                     <16 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "MAIN_CH_UNPLUG_DET",
+                          "MAIN_CHARGE_PLUG_DET",
+                          "MAIN_EXT_CH_NOT_OK",
+                          "MAIN_CH_TH_PROT_R",
+                          "MAIN_CH_TH_PROT_F",
+                          "VBUS_DET_F",
+                          "VBUS_DET_R",
+                          "USB_LINK_STATUS",
+                          "USB_CH_TH_PROT_R",
+                          "USB_CH_TH_PROT_F",
+                          "USB_CHARGER_NOT_OKR",
+                          "VBUS_OVV",
+                          "CH_WD_EXP",
+                          "VBUS_CH_DROP_END";
+        io-channels = <&gpadc 0x03>,
+                      <&gpadc 0x0a>,
+                      <&gpadc 0x09>,
+                      <&gpadc 0x0b>;
+        io-channel-names = "main_charger_v",
+                           "main_charger_c",
+                           "vbus_v",
+                           "usb_charger_c";
+      };
+    };
diff --git a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-fg.yaml b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-fg.yaml
new file mode 100644
index 000000000000..db342e5ac0d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-fg.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 Sebastian Reichel
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/stericsson,ab8500-fg.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: AB8500 Fuel Gauge
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: stericsson,ab8500-fg
+
+  battery:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to battery node
+
+  interrupts:
+    maxItems: 5
+
+  interrupt-names:
+    items:
+      - const: NCONV_ACCU
+      - const: BATT_OVV
+      - const: LOW_BAT_F
+      - const: CC_INT_CALIB
+      - const: CCEOC
+
+  io-channels:
+    maxItems: 1
+
+  io-channel-names:
+    items:
+      - const: main_bat_v
+
+required:
+  - compatible
+  - battery
+  - interrupts
+  - interrupt-names
+  - io-channels
+  - io-channel-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    pmic {
+      fuel-gauge {
+        compatible = "stericsson,ab8500-fg";
+        battery = <&ab8500_battery>;
+        interrupts = <24 IRQ_TYPE_LEVEL_HIGH>,
+                     <8 IRQ_TYPE_LEVEL_HIGH>,
+                     <28 IRQ_TYPE_LEVEL_HIGH>,
+                     <27 IRQ_TYPE_LEVEL_HIGH>,
+                     <26 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "NCONV_ACCU",
+                          "BATT_OVV",
+                          "LOW_BAT_F",
+                          "CC_INT_CALIB",
+                          "CCEOC";
+        io-channels = <&gpadc 0x08>;
+        io-channel-names = "main_bat_v";
+      };
+    };
-- 
2.30.2

