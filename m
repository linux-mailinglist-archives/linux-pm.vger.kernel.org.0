Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56326992F7
	for <lists+linux-pm@lfdr.de>; Thu, 16 Feb 2023 12:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjBPLTN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Feb 2023 06:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBPLTM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Feb 2023 06:19:12 -0500
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1C8C36468;
        Thu, 16 Feb 2023 03:19:09 -0800 (PST)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(23450:0:AUTH_RELAY)
        (envelope-from <chiaen_wu@richtek.com>); Thu, 16 Feb 2023 19:18:58 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Thu, 16 Feb
 2023 19:18:58 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Thu, 16 Feb 2023 19:18:58 +0800
From:   ChiaEn Wu <chiaen_wu@richtek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <sre@kernel.org>
CC:     <cy_huang@richtek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <peterwu.pub@gmail.com>, ChiaEn Wu <chiaen_wu@richtek.com>
Subject: [PATCH v2][next] dt-bindings: power: supply: Revise Richtek RT9467 compatible name
Date:   Thu, 16 Feb 2023 19:17:48 +0800
Message-ID: <b72052c0bdfb209d5583ce0741686e8a2a9e8dd2.1676573862.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Revise RT9467 compatible name from "richtek,rt9467-charger" to
"richtek,rt9467" because it has to match the "compatible name" in
the source code.

Fixes: e1b4620fb503 ("dt-bindings: power: supply: Add Richtek RT9467 battery charger")
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
v2:
- Add more description about this change in the commit message.
- Rename "richtek,rt9467-charger.yaml" to "richtek,rt9467.yaml".
- Rename "$id" as above.

---
 .../power/supply/richtek,rt9467-charger.yaml       | 82 ----------------------
 .../bindings/power/supply/richtek,rt9467.yaml      | 82 ++++++++++++++++++++++
 2 files changed, 82 insertions(+), 82 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9467.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml
deleted file mode 100644
index 92c5706..00000000
--- a/Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml
+++ /dev/null
@@ -1,82 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/power/supply/richtek,rt9467-charger.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Richtek RT9467 Switching Battery Charger with Power Path Management
-
-maintainers:
-  - ChiYuan Huang <cy_huang@richtek.com>
-  - ChiaEn Wu <chiaen_wu@richtek.com>
-
-description: |
-  RT9467 is a switch-mode single cell Li-Ion/Li-Polymer battery charger for
-  portable applications. It integrates a synchronous PWM controller, power
-  MOSFETs, input current sensing and regulation, high-accuracy voltage
-  regulation, and charge termination. The charge current is regulated through
-  integrated sensing resistors.
-
-  The RT9467 also features USB On-The-Go (OTG) support. It also integrates
-  D+/D- pin for USB host/charging port detection.
-
-  Datasheet is available at
-  https://www.richtek.com/assets/product_file/RT9467/DS9467-01.pdf
-
-properties:
-  compatible:
-    const: richtek,rt9467-charger
-
-  reg:
-    maxItems: 1
-
-  wakeup-source: true
-
-  interrupts:
-    maxItems: 1
-
-  charge-enable-gpios:
-    description: GPIO is used to turn on and off charging.
-    maxItems: 1
-
-  usb-otg-vbus-regulator:
-    type: object
-    description: OTG boost regulator.
-    unevaluatedProperties: false
-    $ref: /schemas/regulator/regulator.yaml#
-
-    properties:
-      enable-gpios: true
-
-required:
-  - compatible
-  - reg
-  - wakeup-source
-  - interrupts
-
-additionalProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/interrupt-controller/irq.h>
-    #include <dt-bindings/gpio/gpio.h>
-    i2c {
-      #address-cells = <1>;
-      #size-cells = <0>;
-
-      charger@5b {
-        compatible = "richtek,rt9467-charger";
-        reg = <0x5b>;
-        wakeup-source;
-        interrupts-extended = <&gpio_intc 32 IRQ_TYPE_LEVEL_LOW>;
-        charge-enable-gpios = <&gpio26 1 GPIO_ACTIVE_LOW>;
-
-        rt9467_otg_vbus: usb-otg-vbus-regulator {
-          regulator-name = "rt9467-usb-otg-vbus";
-          regulator-min-microvolt = <4425000>;
-          regulator-max-microvolt = <5825000>;
-          regulator-min-microamp = <500000>;
-          regulator-max-microamp = <3000000>;
-        };
-      };
-    };
diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9467.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9467.yaml
new file mode 100644
index 00000000..3723717
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt9467.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/richtek,rt9467.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT9467 Switching Battery Charger with Power Path Management
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+  - ChiaEn Wu <chiaen_wu@richtek.com>
+
+description: |
+  RT9467 is a switch-mode single cell Li-Ion/Li-Polymer battery charger for
+  portable applications. It integrates a synchronous PWM controller, power
+  MOSFETs, input current sensing and regulation, high-accuracy voltage
+  regulation, and charge termination. The charge current is regulated through
+  integrated sensing resistors.
+
+  The RT9467 also features USB On-The-Go (OTG) support. It also integrates
+  D+/D- pin for USB host/charging port detection.
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT9467/DS9467-01.pdf
+
+properties:
+  compatible:
+    const: richtek,rt9467
+
+  reg:
+    maxItems: 1
+
+  wakeup-source: true
+
+  interrupts:
+    maxItems: 1
+
+  charge-enable-gpios:
+    description: GPIO is used to turn on and off charging.
+    maxItems: 1
+
+  usb-otg-vbus-regulator:
+    type: object
+    description: OTG boost regulator.
+    unevaluatedProperties: false
+    $ref: /schemas/regulator/regulator.yaml#
+
+    properties:
+      enable-gpios: true
+
+required:
+  - compatible
+  - reg
+  - wakeup-source
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      charger@5b {
+        compatible = "richtek,rt9467";
+        reg = <0x5b>;
+        wakeup-source;
+        interrupts-extended = <&gpio_intc 32 IRQ_TYPE_LEVEL_LOW>;
+        charge-enable-gpios = <&gpio26 1 GPIO_ACTIVE_LOW>;
+
+        rt9467_otg_vbus: usb-otg-vbus-regulator {
+          regulator-name = "rt9467-usb-otg-vbus";
+          regulator-min-microvolt = <4425000>;
+          regulator-max-microvolt = <5825000>;
+          regulator-min-microamp = <500000>;
+          regulator-max-microamp = <3000000>;
+        };
+      };
+    };
-- 
2.7.4

