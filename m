Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2961533F189
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 14:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhCQNtl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 09:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhCQNtM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:49:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48B4C06175F;
        Wed, 17 Mar 2021 06:49:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A61911F44A06
Received: by jupiter.universe (Postfix, from userid 1000)
        id C8FDA4800DE; Wed, 17 Mar 2021 14:49:05 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 06/38] dt-bindings: power: supply: bq24190: Convert to DT schema format
Date:   Wed, 17 Mar 2021 14:48:32 +0100
Message-Id: <20210317134904.80737-7-sebastian.reichel@collabora.com>
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
 .../bindings/power/supply/bq24190.txt         | 61 ------------
 .../bindings/power/supply/bq24190.yaml        | 92 +++++++++++++++++++
 2 files changed, 92 insertions(+), 61 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/bq24190.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq24190.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.txt b/Documentation/devicetree/bindings/power/supply/bq24190.txt
deleted file mode 100644
index ffe2be408bb6..000000000000
--- a/Documentation/devicetree/bindings/power/supply/bq24190.txt
+++ /dev/null
@@ -1,61 +0,0 @@
-TI BQ24190 Li-Ion Battery Charger
-
-Required properties:
-- compatible: contains one of the following:
-    * "ti,bq24190"
-    * "ti,bq24192"
-    * "ti,bq24192i"
-    * "ti,bq24196"
-- reg: integer, I2C address of the charger.
-- interrupts[-extended]: configuration for charger INT pin.
-
-Optional properties:
-- monitored-battery: phandle of battery characteristics devicetree node
-  The charger uses the following battery properties:
-    + precharge-current-microamp: maximum charge current during precharge
-      phase (typically 20% of battery capacity).
-    + charge-term-current-microamp: a charge cycle terminates when the
-      battery voltage is above recharge threshold, and the current is below
-      this setting (typically 10% of battery capacity).
-  See also Documentation/devicetree/bindings/power/supply/battery.txt
-- ti,system-minimum-microvolt: when power is connected and the battery is below
-  minimum system voltage, the system will be regulated above this setting.
-
-child nodes:
-- usb-otg-vbus:
-  Usage: optional
-  Description: Regulator that is used to control the VBUS voltage direction for
-               either USB host mode or for charging on the OTG port.
-
-Notes:
-- Some circuit boards wire the chip's "OTG" pin high (enabling 500mA default
-  charge current on USB SDP ports, among other features). To simulate this on
-  boards that wire the pin to a GPIO, set a gpio-hog.
-
-Example:
-
-	bat: battery {
-		compatible = "simple-battery";
-		precharge-current-microamp = <256000>;
-		charge-term-current-microamp = <128000>;
-		// etc.
-	};
-
-	bq24190: charger@6a {
-		compatible = "ti,bq24190";
-		reg = <0x6a>;
-		interrupts-extended = <&gpiochip 10 IRQ_TYPE_EDGE_FALLING>;
-		monitored-battery = <&bat>;
-		ti,system-minimum-microvolt = <3200000>;
-
-		usb_otg_vbus: usb-otg-vbus { };
-	};
-
-	&twl_gpio {
-		otg {
-			gpio-hog;
-			gpios = <6 0>;
-			output-high;
-			line-name = "otg-gpio";
-		};
-	};
diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.yaml b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
new file mode 100644
index 000000000000..0d7cbbdf808b
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 Sebastian Reichel
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/bq24190.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Binding for TI BQ2419x Li-Ion Battery Charger
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
+      - ti,bq24190
+      - ti,bq24192
+      - ti,bq24192i
+      - ti,bq24196
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  usb-otg-vbus:
+    type: object
+    description: |
+      Regulator that is used to control the VBUS voltage direction for
+      either USB host mode or for charging on the OTG port
+
+  ti,system-minimum-microvolt:
+    description: |
+      when power is connected and the battery is below minimum system voltage,
+      the system will be regulated above this setting.
+
+  omit-battery-class:
+    type: boolean
+    description: |
+      If this property is set, the operating system does not try to create a
+      battery device.
+
+  monitored-battery:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      phandle to a "simple-battery" compatible node.
+
+      This property must be a phandle to a node using the format described
+      in battery.yaml, with the following properties being required:
+      - precharge-current-microamp: maximum charge current during precharge phase
+                                    (typically 20% of battery capacity).
+      - charge-term-current-microamp: a charge cycle terminates when the battery voltage is
+                                      above recharge threshold, and the current is below this
+                                      setting (typically 10% of battery capacity).
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    bat: battery {
+      compatible = "simple-battery";
+      precharge-current-microamp = <256000>;
+      charge-term-current-microamp = <128000>;
+    };
+
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      charger@6a {
+        compatible = "ti,bq24190";
+        reg = <0x6a>;
+        interrupt-parent = <&gpiochip>;
+        interrupts = <10 IRQ_TYPE_EDGE_FALLING>;
+        monitored-battery = <&bat>;
+        ti,system-minimum-microvolt = <3200000>;
+
+        usb_otg_vbus: usb-otg-vbus { };
+      };
+    };
-- 
2.30.2

