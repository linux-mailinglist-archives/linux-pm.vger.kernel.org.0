Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534EF339268
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 16:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhCLPwi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 10:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhCLPwa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 10:52:30 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32CAC061765;
        Fri, 12 Mar 2021 07:52:29 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A3BF31F46E78
Received: by jupiter.universe (Postfix, from userid 1000)
        id 6B2BF480118; Fri, 12 Mar 2021 16:44:08 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 30/38] dt-bindings: power: supply: lp8727: Convert to DT schema format
Date:   Fri, 12 Mar 2021 16:43:49 +0100
Message-Id: <20210312154357.1561730-31-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210312154357.1561730-1-sebastian.reichel@collabora.com>
References: <20210312154357.1561730-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the binding to DT schema format.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/power/supply/lp8727_charger.txt  |  43 -------
 .../bindings/power/supply/ti,lp8727.yaml      | 112 ++++++++++++++++++
 2 files changed, 112 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/lp8727_charger.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/ti,lp8727.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/lp8727_charger.txt b/Documentation/devicetree/bindings/power/supply/lp8727_charger.txt
deleted file mode 100644
index 0355a4b68f79..000000000000
--- a/Documentation/devicetree/bindings/power/supply/lp8727_charger.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-Binding for TI/National Semiconductor LP8727 Charger
-
-Required properties:
-- compatible: "ti,lp8727"
-- reg: I2C slave address 27h
-
-Optional properties:
-- interrupts: interrupt specifier (see interrupt binding[0])
-- debounce-ms: interrupt debounce time. (u32)
-
-AC and USB charging parameters
-- charger-type: "ac" or "usb" (string)
-- eoc-level: value of 'enum lp8727_eoc_level' (u8)
-- charging-current: value of 'enum lp8727_ichg' (u8)
-
-[0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
-
-Example)
-
-lp8727@27 {
-	compatible = "ti,lp8727";
-	reg = <0x27>;
-
-	/* GPIO 134 is used for LP8728 interrupt pin */
-	interrupt-parent = <&gpio5>; 	/* base = 128 */
-	interrupts = <6 0x2>;		/* offset = 6, falling edge type */
-
-	debounce-ms = <300>;
-
-	/* AC charger: 5% EOC and 500mA charging current */
-	ac {
-		charger-type = "ac";
-		eoc-level = /bits/ 8 <0>;
-		charging-current = /bits/ 8 <4>;
-	};
-
-	/* USB charger: 10% EOC and 400mA charging current */
-	usb {
-		charger-type = "usb";
-		eoc-level = /bits/ 8 <1>;
-		charging-current = /bits/ 8 <2>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/power/supply/ti,lp8727.yaml b/Documentation/devicetree/bindings/power/supply/ti,lp8727.yaml
new file mode 100644
index 000000000000..65894b36a69d
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/ti,lp8727.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/ti,lp8727.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binding for TI/National Semiconductor LP8727 Charger
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: ti,lp8727
+
+  reg:
+    const: 0x27
+
+  interrupts:
+    maxItems: 1
+
+  debounce-ms:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: interrupt debounce time in ms
+
+  ac:
+    type: object
+    description: AC charging parameters
+    properties:
+      charger-type:
+        const: ac
+
+      eoc-level:
+        $ref: /schemas/types.yaml#/definitions/uint8
+        minimum: 0
+        maximum: 6
+        description: |
+          End of Charge Percentage with the following mapping:
+          0 = 5%, 1 = 10%, 2 = 16%, 3 = 20%, 4 = 25%, 5 = 33%, 6 = 50%
+
+      charging-current:
+        $ref: /schemas/types.yaml#/definitions/uint8
+        minimum: 0
+        maximum: 9
+        description: |
+          Charging current with the following mapping:
+          0 = 90mA, 1 = 100mA, 2 = 400mA, 3 = 450mA, 4 = 500mA, 5 = 600mA,
+          6 = 700mA, 7 = 800mA, 8 = 900mA, 9 = 1000mA
+
+  usb:
+    type: object
+    description: USB charging parameters
+    properties:
+      charger-type:
+        const: usb
+
+      eoc-level:
+        $ref: /schemas/types.yaml#/definitions/uint8
+        minimum: 0
+        maximum: 6
+        description: |
+          End of Charge Percentage with the following mapping:
+          0 = 5%, 1 = 10%, 2 = 16%, 3 = 20%, 4 = 25%, 5 = 33%, 6 = 50%
+
+      charging-current:
+        $ref: /schemas/types.yaml#/definitions/uint8
+        minimum: 0
+        maximum: 9
+        description: |
+          Charging current with the following mapping:
+          0 = 90mA, 1 = 100mA, 2 = 400mA, 3 = 450mA, 4 = 500mA, 5 = 600mA,
+          6 = 700mA, 7 = 800mA, 8 = 900mA, 9 = 1000mA
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      lp8727: charger@27 {
+        compatible = "ti,lp8727";
+        reg = <0x27>;
+        interrupt-parent = <&gpio5>;
+        interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
+        debounce-ms = <300>;
+
+        /* AC charger: 5% EOC and 500mA charging current */
+        ac {
+          charger-type = "ac";
+          eoc-level = /bits/ 8 <0>;
+          charging-current = /bits/ 8 <4>;
+        };
+
+        /* USB charger: 10% EOC and 400mA charging current */
+        usb {
+          charger-type = "usb";
+          eoc-level = /bits/ 8 <1>;
+          charging-current = /bits/ 8 <2>;
+        };
+      };
+    };
+
-- 
2.30.1

