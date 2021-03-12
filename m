Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC6E339254
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 16:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhCLPwf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 10:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbhCLPw3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 10:52:29 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D36C061761;
        Fri, 12 Mar 2021 07:52:27 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 6E8691F40E2C
Received: by jupiter.universe (Postfix, from userid 1000)
        id 72E7348011B; Fri, 12 Mar 2021 16:44:08 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 33/38] dt-bindings: power: supply: rt9455: Convert to DT schema format
Date:   Fri, 12 Mar 2021 16:43:52 +0100
Message-Id: <20210312154357.1561730-34-sebastian.reichel@collabora.com>
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
 .../bindings/power/supply/richtek,rt9455.yaml | 90 +++++++++++++++++++
 .../bindings/power/supply/rt9455_charger.txt  | 46 ----------
 2 files changed, 90 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9455.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/rt9455_charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9455.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9455.yaml
new file mode 100644
index 000000000000..e1c233462f29
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt9455.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/richtek,rt9455.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Binding for Richtek rt9455 battery charger
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: richtek,rt9455
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  richtek,output-charge-current:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: output current from the charger to the battery, in uA.
+
+  richtek,end-of-charge-percentage:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      percent of the output charge current. When the current in constant-voltage phase drops
+      below output_charge_current x end-of-charge-percentage, charge is terminated.
+
+  richtek,battery-regulation-voltage:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: maximum battery voltage in uV.
+
+  richtek,boost-output-voltage:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      maximum voltage provided to consumer devices, when the charger is in boost mode, in uV.
+
+  richtek,min-input-voltage-regulation:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      input voltage level in uV, used to decrease voltage level when the over current of the
+      input power source occurs. This prevents input voltage drop due to insufficient
+      current provided by the power source. Defaults to 4500000 uV (4.5V).
+
+  richtek,avg-input-current-regulation:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      input current value in uA drained by the charger from the power source.
+      Defaults to 500000 uA (500mA).
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - richtek,output-charge-current
+  - richtek,end-of-charge-percentage
+  - richtek,battery-regulation-voltage
+  - richtek,boost-output-voltage
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
+      charger@22 {
+        compatible = "richtek,rt9455";
+        reg = <0x22>;
+
+        interrupt-parent = <&gpio1>;
+        interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+
+        richtek,output-charge-current	    = <500000>;
+        richtek,end-of-charge-percentage    = <10>;
+        richtek,battery-regulation-voltage  = <4200000>;
+        richtek,boost-output-voltage	    = <5050000>;
+
+        richtek,min-input-voltage-regulation = <4500000>;
+        richtek,avg-input-current-regulation = <500000>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/power/supply/rt9455_charger.txt b/Documentation/devicetree/bindings/power/supply/rt9455_charger.txt
deleted file mode 100644
index 1e6107c7578e..000000000000
--- a/Documentation/devicetree/bindings/power/supply/rt9455_charger.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-Binding for Richtek rt9455 battery charger
-
-Required properties:
-- compatible:				it should contain one of the following:
-					"richtek,rt9455".
-- reg:					integer, i2c address of the device.
-- interrupts:				interrupt mapping for GPIO IRQ, it should be
-					configured with IRQ_TYPE_LEVEL_LOW flag.
-- richtek,output-charge-current:	integer, output current from the charger to the
-					battery, in uA.
-- richtek,end-of-charge-percentage:	integer, percent of the output charge current.
-					When the current in constant-voltage phase drops
-					below output_charge_current x end-of-charge-percentage,
-					charge is terminated.
-- richtek,battery-regulation-voltage:	integer, maximum battery voltage in uV.
-- richtek,boost-output-voltage:		integer, maximum voltage provided to consumer
-					devices, when the charger is in boost mode, in uV.
-
-Optional properties:
-- richtek,min-input-voltage-regulation: integer, input voltage level in uV, used to
-					decrease voltage level when the over current
-					of the input power source occurs.
-					This prevents input voltage drop due to insufficient
-					current provided by the power source.
-					Default: 4500000 uV (4.5V)
-- richtek,avg-input-current-regulation: integer, input current value in uA drained by the
-					charger from the power source.
-					Default: 500000 uA (500mA)
-
-Example:
-
-rt9455@22 {
-	compatible = "richtek,rt9455";
-	reg = <0x22>;
-
-	interrupt-parent = <&gpio1>;
-	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-
-	richtek,output-charge-current	    = <500000>;
-	richtek,end-of-charge-percentage    = <10>;
-	richtek,battery-regulation-voltage  = <4200000>;
-	richtek,boost-output-voltage	    = <5050000>;
-
-	richtek,min-input-voltage-regulation = <4500000>;
-	richtek,avg-input-current-regulation = <500000>;
-};
-- 
2.30.1

