Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8ECE3391BD
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 16:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhCLPof (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 10:44:35 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55574 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbhCLPoL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 10:44:11 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 603D71F46CA6
Received: by jupiter.universe (Postfix, from userid 1000)
        id 2C7934800C8; Fri, 12 Mar 2021 16:44:08 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com, Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/38] dt-bindings: power: supply: cpcap-battery: Convert to DT schema format
Date:   Fri, 12 Mar 2021 16:43:21 +0100
Message-Id: <20210312154357.1561730-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210312154357.1561730-1-sebastian.reichel@collabora.com>
References: <20210312154357.1561730-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the binding to DT schema format. I also added the missing bits
used by the only in-tree user and implemented in the driver.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/power/supply/cpcap-battery.txt   | 31 -------
 .../bindings/power/supply/cpcap-battery.yaml  | 87 +++++++++++++++++++
 2 files changed, 87 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/cpcap-battery.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/cpcap-battery.txt b/Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
deleted file mode 100644
index a04efa22da01..000000000000
--- a/Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-Motorola CPCAP PMIC battery driver binding
-
-Required properties:
-- compatible: Shall be "motorola,cpcap-battery"
-- interrupts: Interrupt specifier for each name in interrupt-names
-- interrupt-names: Should contain the following entries:
-		   "lowbph", "lowbpl", "chrgcurr1", "battdetb"
-- io-channels: IIO ADC channel specifier for each name in io-channel-names
-- io-channel-names: Should contain the following entries:
-		    "battdetb", "battp", "chg_isense", "batti"
-- power-supplies: List of phandles for power-supplying devices, as
-		  described in power_supply.txt. Typically a reference
-		  to cpcap_charger.
-
-Example:
-
-cpcap_battery: battery {
-	compatible = "motorola,cpcap-battery";
-	interrupts-extended = <
-		&cpcap 5 0 &cpcap 3 0
-		&cpcap 20 0 &cpcap 54 0
-	>;
-	interrupt-names =
-		"lowbph", "lowbpl",
-		"chrgcurr1", "battdetb";
-	io-channels = <&cpcap_adc 0 &cpcap_adc 1
-		       &cpcap_adc 5 &cpcap_adc 6>;
-	io-channel-names = "battdetb", "battp",
-			   "chg_isense", "batti";
-	power-supplies = <&cpcap_charger>;
-};
diff --git a/Documentation/devicetree/bindings/power/supply/cpcap-battery.yaml b/Documentation/devicetree/bindings/power/supply/cpcap-battery.yaml
new file mode 100644
index 000000000000..7153fd4ce55f
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/cpcap-battery.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 Sebastian Reichel
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/cpcap-battery.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Motorola CPCAP PMIC battery
+
+maintainers:
+  - Tony Lindgren <tony@atomide.com>
+  - Sebastian Reichel <sre@kernel.org>
+
+description: |
+  Motorola CPCAP is a PMIC found in some mobile phones, e.g.
+  the Droid 4. This binding describes its battery fuel gauge
+  sub-function.
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: motorola,cpcap-battery
+
+  interrupts:
+    items:
+      - description: eol interrupt
+      - description: low battery percentage interrupt
+      - description: critical battery percentage interrupt
+      - description: charger detect interrupt
+      - description: battery detect interrupt
+      - description: coulomb counter calibration interrupt
+
+  interrupt-names:
+    items:
+      - const: eol
+      - const: lowbph
+      - const: lowbpl
+      - const: chrgcurr1
+      - const: battdetb
+      - const: cccal
+
+  io-channels:
+    items:
+      - description: battery temperature
+      - description: battery voltage
+      - description: battery charge current
+      - description: battery current
+
+  io-channel-names:
+    items:
+      - const: battdetb
+      - const: battp
+      - const: chg_isense
+      - const: batti
+
+  power-supplies: true
+
+required:
+  - compatible
+  - interrupts
+  - interrupt-names
+  - io-channels
+  - io-channel-names
+  - power-supplies
+
+additionalProperties: false
+
+examples:
+  - |
+    cpcap {
+      battery {
+        compatible = "motorola,cpcap-battery";
+        interrupts-extended =
+                <&cpcap 6 0>, <&cpcap 5 0>, <&cpcap 3 0>,
+                <&cpcap 20 0>, <&cpcap 54 0>, <&cpcap 57 0>;
+        interrupt-names =
+                "eol", "lowbph", "lowbpl",
+                "chrgcurr1", "battdetb", "cccal";
+        io-channels = <&cpcap_adc 0>, <&cpcap_adc 1>,
+                      <&cpcap_adc 5>, <&cpcap_adc 6>;
+        io-channel-names = "battdetb", "battp",
+                           "chg_isense", "batti";
+        power-supplies = <&cpcap_charger>;
+      };
+    };
-- 
2.30.1

