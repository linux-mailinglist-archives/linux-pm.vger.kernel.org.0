Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B909433F19C
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 14:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhCQNtr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 09:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbhCQNtN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:49:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BD5C06174A;
        Wed, 17 Mar 2021 06:49:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B6FCF1F44EBC
Received: by jupiter.universe (Postfix, from userid 1000)
        id D7B454800E3; Wed, 17 Mar 2021 14:49:05 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 11/38] dt-bindings: power: supply: sbs-manager: Convert to DT schema format
Date:   Wed, 17 Mar 2021 14:48:37 +0100
Message-Id: <20210317134904.80737-12-sebastian.reichel@collabora.com>
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
 .../bindings/power/supply/sbs,sbs-manager.txt |  66 -----------
 .../power/supply/sbs,sbs-manager.yaml         | 107 ++++++++++++++++++
 2 files changed, 107 insertions(+), 66 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt b/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt
deleted file mode 100644
index 4b2195571a49..000000000000
--- a/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt
+++ /dev/null
@@ -1,66 +0,0 @@
-Binding for sbs-manager
-
-Required properties:
-- compatible: "<vendor>,<part-number>", "sbs,sbs-charger" as fallback. The part
-  number compatible string might be used in order to take care of vendor
-  specific registers.
-- reg: integer, i2c address of the device. Should be <0xa>.
-Optional properties:
-- gpio-controller: Marks the port as GPIO controller.
-  See "gpio-specifier" in .../devicetree/bindings/gpio/gpio.txt.
-- #gpio-cells: Should be <2>. The first cell is the pin number, the second cell
-  is used to specify optional parameters:
-  See "gpio-specifier" in .../devicetree/bindings/gpio/gpio.txt.
-
-From OS view the device is basically an i2c-mux used to communicate with up to
-four smart battery devices at address 0xb. The driver actually implements this
-behaviour. So standard i2c-mux nodes can be used to register up to four slave
-batteries. Channels will be numerated starting from 1 to 4.
-
-Example:
-
-batman@a {
-    compatible = "lltc,ltc1760", "sbs,sbs-manager";
-    reg = <0x0a>;
-    #address-cells = <1>;
-    #size-cells = <0>;
-
-    gpio-controller;
-    #gpio-cells = <2>;
-
-    i2c@1 {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        reg = <1>;
-
-        battery@b {
-            compatible = "ti,bq2060", "sbs,sbs-battery";
-            reg = <0x0b>;
-            sbs,battery-detect-gpios = <&batman 1 1>;
-        };
-    };
-
-    i2c@2 {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        reg = <2>;
-
-        battery@b {
-            compatible = "ti,bq2060", "sbs,sbs-battery";
-            reg = <0x0b>;
-            sbs,battery-detect-gpios = <&batman 2 1>;
-        };
-    };
-
-    i2c@3 {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        reg = <3>;
-
-        battery@b {
-            compatible = "ti,bq2060", "sbs,sbs-battery";
-            reg = <0x0b>;
-            sbs,battery-detect-gpios = <&batman 3 1>;
-        };
-    };
-};
diff --git a/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.yaml b/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.yaml
new file mode 100644
index 000000000000..72e8f274c791
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/sbs,sbs-manager.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SBS compliant manger
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - lltc,ltc1760
+          - enum:
+              - sbs,sbs-manager
+      - items:
+          - const: sbs,sbs-manager
+
+  reg:
+    const: 0xa
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+patternProperties:
+  "^i2c@[1-4]$":
+    type: object
+
+    allOf:
+      - $ref: /schemas/i2c/i2c-controller.yaml#
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      batman: battery-manager@a {
+        compatible = "lltc,ltc1760", "sbs,sbs-manager";
+        reg = <0x0a>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        gpio-controller;
+        #gpio-cells = <2>;
+
+        i2c@1 {
+          #address-cells = <1>;
+          #size-cells = <0>;
+          reg = <1>;
+
+          battery@b {
+            compatible = "ti,bq20z65", "sbs,sbs-battery";
+            reg = <0x0b>;
+            sbs,battery-detect-gpios = <&batman 1 1>;
+          };
+        };
+
+        i2c@2 {
+          #address-cells = <1>;
+          #size-cells = <0>;
+          reg = <2>;
+
+          battery@b {
+            compatible = "ti,bq20z65", "sbs,sbs-battery";
+            reg = <0x0b>;
+            sbs,battery-detect-gpios = <&batman 2 1>;
+          };
+        };
+
+        i2c@3 {
+          #address-cells = <1>;
+          #size-cells = <0>;
+          reg = <3>;
+
+          battery@b {
+            compatible = "ti,bq20z65", "sbs,sbs-battery";
+            reg = <0x0b>;
+            sbs,battery-detect-gpios = <&batman 3 1>;
+          };
+        };
+      };
+    };
-- 
2.30.2

