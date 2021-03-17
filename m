Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E6333F1F0
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 14:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhCQN4h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 09:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbhCQN4E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:56:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BE3C06175F;
        Wed, 17 Mar 2021 06:56:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 783881F451F5
Received: by jupiter.universe (Postfix, from userid 1000)
        id 1294B480115; Wed, 17 Mar 2021 14:49:06 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCHv2 28/38] dt-bindings: power: supply: axp20x: Convert to DT schema format
Date:   Wed, 17 Mar 2021 14:48:54 +0100
Message-Id: <20210317134904.80737-29-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210317134904.80737-1-sebastian.reichel@collabora.com>
References: <20210317134904.80737-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the binding to DT schema format.

Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/power/supply/axp20x_ac_power.txt | 25 -----------
 .../bindings/power/supply/axp20x_battery.txt  | 20 ---------
 .../power/supply/axp20x_usb_power.txt         | 41 -------------------
 .../x-powers,axp20x-ac-power-supply.yaml      | 32 +++++++++++++++
 .../x-powers,axp20x-battery-power-supply.yaml | 30 ++++++++++++++
 .../x-powers,axp20x-usb-power-supply.yaml     | 33 +++++++++++++++
 6 files changed, 95 insertions(+), 86 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/x-powers,axp20x-ac-power-supply.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
deleted file mode 100644
index 7a1fb532abe5..000000000000
--- a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-AXP20X and AXP22X PMICs' AC power supply
-
-Required Properties:
- - compatible: One of:
-			"x-powers,axp202-ac-power-supply"
-			"x-powers,axp221-ac-power-supply"
-			"x-powers,axp813-ac-power-supply"
-
-This node is a subnode of the axp20x PMIC.
-
-The AXP20X can read the current current and voltage supplied by AC by
-reading ADC channels from the AXP20X ADC.
-
-The AXP22X is only able to tell if an AC power supply is present and
-usable.
-
-AXP813/AXP803 are able to limit current and supply voltage
-
-Example:
-
-&axp209 {
-	ac_power_supply: ac-power-supply {
-		compatible = "x-powers,axp202-ac-power-supply";
-	};
-};
diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
deleted file mode 100644
index 41916f69902c..000000000000
--- a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-AXP20x and AXP22x battery power supply
-
-Required Properties:
- - compatible, one of:
-			"x-powers,axp209-battery-power-supply"
-			"x-powers,axp221-battery-power-supply"
-			"x-powers,axp813-battery-power-supply"
-
-This node is a subnode of its respective PMIC DT node.
-
-The supported devices can read the battery voltage, charge and discharge
-currents of the battery by reading ADC channels from the ADC.
-
-Example:
-
-&axp209 {
-	battery_power_supply: battery-power-supply {
-		compatible = "x-powers,axp209-battery-power-supply";
-	}
-};
diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
deleted file mode 100644
index b2d4968fde7d..000000000000
--- a/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-AXP20x USB power supply
-
-Required Properties:
--compatible: One of: "x-powers,axp202-usb-power-supply"
-                     "x-powers,axp221-usb-power-supply"
-                     "x-powers,axp223-usb-power-supply"
-		     "x-powers,axp813-usb-power-supply"
-
-The AXP223 PMIC shares most of its behaviour with the AXP221 but has slight
-variations such as the former being able to set the VBUS power supply max
-current to 100mA, unlike the latter.
-
-This node is a subnode of the axp20x PMIC.
-
-Example:
-
-axp209: pmic@34 {
-	compatible = "x-powers,axp209";
-	reg = <0x34>;
-	interrupt-parent = <&nmi_intc>;
-	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-	interrupt-controller;
-	#interrupt-cells = <1>;
-
-	regulators {
-		x-powers,dcdc-freq = <1500>;
-
-		vdd_cpu: dcdc2 {
-			regulator-always-on;
-			regulator-min-microvolt = <1000000>;
-			regulator-max-microvolt = <1450000>;
-			regulator-name = "vdd-cpu";
-		};
-
-		...
-	};
-
-	usb-power-supply: usb-power-supply {
-		compatible = "x-powers,axp202-usb-power-supply";
-	};
-};
diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-ac-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-ac-power-supply.yaml
new file mode 100644
index 000000000000..dcda6660b8ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-ac-power-supply.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/x-powers,axp20x-ac-power-supply.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: AXP20x AC power-supply
+
+description: |
+  The AXP20X can read the current current and voltage supplied by AC by
+  reading ADC channels from the AXP20X ADC. The AXP22X is only able to
+  tell if an AC power supply is present and usable. AXP813/AXP803 are
+  able to limit current and supply voltage
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    enum:
+      - x-powers,axp202-ac-power-supply
+      - x-powers,axp221-ac-power-supply
+      - x-powers,axp813-ac-power-supply
+
+required:
+  - compatible
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
new file mode 100644
index 000000000000..86e8a713d4e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/x-powers,axp20x-battery-power-supply.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: AXP20x Battery power-supply
+
+description: |
+  The supported devices can read the battery voltage, charge and discharge
+  currents of the battery by reading ADC channels from the ADC.
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    enum:
+      - x-powers,axp209-battery-power-supply
+      - x-powers,axp221-battery-power-supply
+      - x-powers,axp813-battery-power-supply
+
+required:
+  - compatible
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
new file mode 100644
index 000000000000..61f1b320c157
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/x-powers,axp20x-usb-power-supply.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: AXP20x USB power-supply
+
+description: |
+  The AXP223 PMIC shares most of its behaviour with the AXP221 but has slight
+  variations such as the former being able to set the VBUS power supply max
+  current to 100mA, unlike the latter.
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    enum:
+      - x-powers,axp202-usb-power-supply
+      - x-powers,axp221-usb-power-supply
+      - x-powers,axp223-usb-power-supply
+      - x-powers,axp813-usb-power-supply
+
+
+required:
+  - compatible
+
+additionalProperties: false
-- 
2.30.2

