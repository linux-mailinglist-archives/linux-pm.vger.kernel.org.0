Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED07933F183
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 14:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhCQNtf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 09:49:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56136 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbhCQNtK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:49:10 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 54B321F4456E
Received: by jupiter.universe (Postfix, from userid 1000)
        id C0E5F4800D9; Wed, 17 Mar 2021 14:49:05 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com, Tony Lindgren <tony@atomide.com>
Subject: [PATCHv2 03/38] dt-bindings: power: supply: cpcap-charger: Convert to DT schema format
Date:   Wed, 17 Mar 2021 14:48:29 +0100
Message-Id: <20210317134904.80737-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210317134904.80737-1-sebastian.reichel@collabora.com>
References: <20210317134904.80737-1-sebastian.reichel@collabora.com>
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
 .../bindings/power/supply/cpcap-charger.txt   |  40 -------
 .../bindings/power/supply/cpcap-charger.yaml  | 106 ++++++++++++++++++
 2 files changed, 106 insertions(+), 40 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/cpcap-charger.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/cpcap-charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/cpcap-charger.txt b/Documentation/devicetree/bindings/power/supply/cpcap-charger.txt
deleted file mode 100644
index 6048f636783f..000000000000
--- a/Documentation/devicetree/bindings/power/supply/cpcap-charger.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-Motorola CPCAP PMIC battery charger binding
-
-Required properties:
-- compatible: Shall be "motorola,mapphone-cpcap-charger"
-- interrupts: Interrupt specifier for each name in interrupt-names
-- interrupt-names: Should contain the following entries:
-		   "chrg_det", "rvrs_chrg", "chrg_se1b", "se0conn",
-		   "rvrs_mode", "chrgcurr2", "chrgcurr1", "vbusvld",
-		   "battdetb"
-- io-channels: IIO ADC channel specifier for each name in io-channel-names
-- io-channel-names: Should contain the following entries:
-		    "battdetb", "battp", "vbus", "chg_isense", "batti"
-
-Optional properties:
-- mode-gpios: Optionally CPCAP charger can have a companion wireless
-	      charge controller that is controlled with two GPIOs
-	      that are active low.
-
-Example:
-
-cpcap_charger: charger {
-	compatible = "motorola,mapphone-cpcap-charger";
-	interrupts-extended = <
-		&cpcap 13 0 &cpcap 12 0 &cpcap 29 0 &cpcap 28 0
-		&cpcap 22 0 &cpcap 21 0 &cpcap 20 0 &cpcap 19 0
-		&cpcap 54 0
-	>;
-	interrupt-names =
-		"chrg_det", "rvrs_chrg", "chrg_se1b", "se0conn",
-		"rvrs_mode", "chrgcurr2", "chrgcurr1", "vbusvld",
-		"battdetb";
-	mode-gpios = <&gpio3 29 GPIO_ACTIVE_LOW
-		      &gpio3 23 GPIO_ACTIVE_LOW>;
-	io-channels = <&cpcap_adc 0 &cpcap_adc 1
-		       &cpcap_adc 2 &cpcap_adc 5
-		       &cpcap_adc 6>;
-	io-channel-names = "battdetb", "battp",
-			   "vbus", "chg_isense",
-			   "batti";
-};
diff --git a/Documentation/devicetree/bindings/power/supply/cpcap-charger.yaml b/Documentation/devicetree/bindings/power/supply/cpcap-charger.yaml
new file mode 100644
index 000000000000..cb6353683d7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/cpcap-charger.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 Sebastian Reichel
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/cpcap-charger.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Motorola CPCAP PMIC charger
+
+maintainers:
+  - Tony Lindgren <tony@atomide.com>
+  - Sebastian Reichel <sre@kernel.org>
+
+description: |
+  Motorola CPCAP is a PMIC found in some mobile phones, e.g.
+  the Droid 4. This binding describes its battery charger
+  sub-function.
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: motorola,mapphone-cpcap-charger
+
+  interrupts:
+    items:
+      - description: charger detection interrupt
+      - description: reverse charge interrupt
+      - description: SE1 charger detection interrupt
+      - description: SE0 charger detection interrupt
+      - description: reverse mode interrupt
+      - description: charge current 2 interrupt
+      - description: charge current 1 interrupt
+      - description: VBUS valid interrupt
+      - description: battery detect interrupt
+
+  interrupt-names:
+    items:
+      - const: chrg_det
+      - const: rvrs_chrg
+      - const: chrg_se1b
+      - const: se0conn
+      - const: rvrs_mode
+      - const: chrgcurr2
+      - const: chrgcurr1
+      - const: vbusvld
+      - const: battdetb
+
+  io-channels:
+    items:
+      - description: battery temperature
+      - description: battery voltage
+      - description: VBUS voltage
+      - description: battery charge current
+      - description: battery current
+
+  io-channel-names:
+    items:
+      - const: battdetb
+      - const: battp
+      - const: vbus
+      - const: chg_isense
+      - const: batti
+
+  mode-gpios:
+    description: |
+      Optionally CPCAP charger can have a companion wireless
+      charge controller that is controlled with two GPIOs
+      that are active low.
+    minItems: 2
+    maxItems: 2
+
+required:
+  - compatible
+  - interrupts
+  - interrupt-names
+  - io-channels
+  - io-channel-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    cpcap {
+      charger {
+        compatible = "motorola,mapphone-cpcap-charger";
+        interrupts-extended =
+                <&cpcap 13 0>, <&cpcap 12 0>, <&cpcap 29 0>, <&cpcap 28 0>,
+                <&cpcap 22 0>, <&cpcap 21 0>, <&cpcap 20 0>, <&cpcap 19 0>,
+                <&cpcap 54 0>;
+        interrupt-names =
+                "chrg_det", "rvrs_chrg", "chrg_se1b", "se0conn",
+                "rvrs_mode", "chrgcurr2", "chrgcurr1", "vbusvld",
+                "battdetb";
+        mode-gpios = <&gpio3 29 GPIO_ACTIVE_LOW>,
+                     <&gpio3 23 GPIO_ACTIVE_LOW>;
+        io-channels = <&cpcap_adc 0>, <&cpcap_adc 1>,
+                      <&cpcap_adc 2>, <&cpcap_adc 5>,
+                      <&cpcap_adc 6>;
+        io-channel-names = "battdetb", "battp",
+                           "vbus", "chg_isense",
+                           "batti";
+      };
+    };
-- 
2.30.2

