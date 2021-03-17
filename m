Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A53433F1E4
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 14:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhCQN4b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 09:56:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56314 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhCQN4B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:56:01 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8C9811F451D2
Received: by jupiter.universe (Postfix, from userid 1000)
        id 0A03A48010E; Wed, 17 Mar 2021 14:49:06 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 25/38] dt-bindings: power: supply: pm8941-charger: Convert to DT schema format
Date:   Wed, 17 Mar 2021 14:48:51 +0100
Message-Id: <20210317134904.80737-26-sebastian.reichel@collabora.com>
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
 .../power/supply/qcom,pm8941-charger.yaml     | 169 ++++++++++++++++++
 .../bindings/power/supply/qcom_smbb.txt       | 150 ----------------
 2 files changed, 169 insertions(+), 150 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,pm8941-charger.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/qcom_smbb.txt

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pm8941-charger.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pm8941-charger.yaml
new file mode 100644
index 000000000000..bc8904872d1b
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/qcom,pm8941-charger.yaml
@@ -0,0 +1,169 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/qcom,pm8941-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Switch-Mode Battery Charger and Boost
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+properties:
+  compatible:
+    const: qcom,pm8941-charger
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: charge done
+      - description: charge fast mode
+      - description: charge trickle mode
+      - description: battery temperature ok
+      - description: battery present
+      - description: charger disconnected
+      - description: USB-in valid
+      - description: DC-in valid
+
+  interrupt-names:
+    items:
+      - const: chg-done
+      - const: chg-fast
+      - const: chg-trkl
+      - const: bat-temp-ok
+      - const: bat-present
+      - const: chg-gone
+      - const: usb-valid
+      - const: dc-valid
+
+  qcom,fast-charge-current-limit:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 100000
+    maximum: 3000000
+    description: Maximum charge current in uA; May be clamped to safety limits; Defaults to 1A
+
+  qcom,fast-charge-low-threshold-voltage:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 2100000
+    maximum: 3600000
+    description: |
+      Battery voltage limit in uV above which fast charging may operate; Defaults to 3.2V
+      Below this value linear or switch-mode auto-trickle-charging will operate.
+
+  qcom,fast-charge-high-threshold-voltage:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 3240000
+    maximum: 5000000
+    description: |
+      Battery voltage limit in uV below which fast charging may operate; Defaults to 4.2V
+      The fast charger will attempt to charge the battery to this voltage.
+      May be clamped to safety limits.
+
+  qcom,fast-charge-safe-voltage:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 3240000
+    maximum: 5000000
+    description: |
+      Maximum safe battery voltage in uV; May be pre-set by bootloader, in which case,
+      setting this will harmlessly fail. The property 'fast-charge-high-watermark' will
+      be clamped by this value. Defaults to 4.2V.
+
+  qcom,fast-charge-safe-current:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 100000
+    maximum: 3000000
+    description: |
+      Maximum safe battery charge current in uA; May pre-set by bootloader, in which case,
+      setting this will harmlessly fail. The property 'qcom,fast-charge-current-limit'
+      will be clamped by this value. Defaults to 1A.
+
+  qcom,auto-recharge-threshold-voltage:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 3240000
+    maximum: 5000000
+    description: |
+      Battery voltage limit in uV below which auto-recharge functionality will restart charging
+      after end-of-charge; The high cutoff limit for auto-recharge is 5% above this value.
+      Defaults to 4.1V.
+
+  qcom,minimum-input-voltage:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 4200000
+    maximum: 9600000
+    description: |
+      Input voltage level in uV above which charging may operate. Defaults to 4.3V.
+
+  qcom,dc-current-limit:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 100000
+    maximum: 2500000
+    description: |
+      Default DC charge current limit in uA. Defaults to 100mA.
+
+  qcom,disable-dc:
+    type: boolean
+    description: Disable DC charger
+
+  qcom,jeita-extended-temp-range:
+    type: boolean
+    description: |
+      Enable JEITA extended temperature range;  This does *not* adjust the maximum charge
+      voltage or current in the extended temperature range. It only allows charging when
+      the battery is in the extended temperature range. Voltage/current regulation must
+      be done externally to fully comply with the JEITA safety guidelines if this flag
+      is set.
+
+  usb-otg-in-supply:
+    description: Reference to the regulator supplying power to the USB_OTG_IN pin.
+
+  otg-vbus:
+    type: object
+    description: |
+      This node defines a regulator used to control the direction of VBUS voltage.
+      Specifically whether to supply voltage to VBUS for host mode operation of the OTG port,
+      or allow input voltage from external VBUS for charging. In the hardware, the supply for
+      this regulator comes from usb_otg_in-supply.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    pmic {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      charger@1000 {
+        compatible = "qcom,pm8941-charger";
+        reg = <0x1000>;
+        interrupts = <0x0 0x10 7 IRQ_TYPE_EDGE_BOTH>,
+                     <0x0 0x10 5 IRQ_TYPE_EDGE_BOTH>,
+                     <0x0 0x10 4 IRQ_TYPE_EDGE_BOTH>,
+                     <0x0 0x12 1 IRQ_TYPE_EDGE_BOTH>,
+                     <0x0 0x12 0 IRQ_TYPE_EDGE_BOTH>,
+                     <0x0 0x13 2 IRQ_TYPE_EDGE_BOTH>,
+                     <0x0 0x13 1 IRQ_TYPE_EDGE_BOTH>,
+                     <0x0 0x14 1 IRQ_TYPE_EDGE_BOTH>;
+        interrupt-names = "chg-done",
+                          "chg-fast",
+                          "chg-trkl",
+                          "bat-temp-ok",
+                          "bat-present",
+                          "chg-gone",
+                          "usb-valid",
+                          "dc-valid";
+        qcom,fast-charge-current-limit = <1000000>;
+        qcom,dc-current-limit = <1000000>;
+        usb-otg-in-supply = <&pm8941_5vs1>;
+
+        otg-vbus {};
+      };
+    };
diff --git a/Documentation/devicetree/bindings/power/supply/qcom_smbb.txt b/Documentation/devicetree/bindings/power/supply/qcom_smbb.txt
deleted file mode 100644
index 06f8a5ddb68e..000000000000
--- a/Documentation/devicetree/bindings/power/supply/qcom_smbb.txt
+++ /dev/null
@@ -1,150 +0,0 @@
-Qualcomm Switch-Mode Battery Charger and Boost
-
-PROPERTIES
-- compatible:
-  Usage: required
-  Value type: <stringlist>
-  Description: Must be one of:
-               - "qcom,pm8941-charger"
-
-- reg:
-  Usage: required
-  Value type: <prop-encoded-array>
-  Description: Base address of registers for SMBB block
-
-- interrupts:
-  Usage: required
-  Value type: <prop-encoded-array>
-  Description: The format of the specifier is defined by the binding document
-               describing the node's interrupt parent.  Must contain one
-               specifier for each of the following interrupts, in order:
-               - charge done
-               - charge fast mode
-               - charge trickle mode
-               - battery temperature ok
-               - battery present
-               - charger disconnected
-               - USB-in valid
-               - DC-in valid
-
-- interrupt-names:
-  Usage: required
-  Value type: <stringlist>
-  Description: Must contain the following list, strictly ordered:
-               "chg-done",
-               "chg-fast",
-               "chg-trkl",
-               "bat-temp-ok",
-               "bat-present",
-               "chg-gone",
-               "usb-valid",
-               "dc-valid"
-
-- qcom,fast-charge-current-limit:
-  Usage: optional (default: 1A, or pre-configured value)
-  Value type: <u32>; uA; range [100mA : 3A]
-  Description: Maximum charge current; May be clamped to safety limits.
-
-- qcom,fast-charge-low-threshold-voltage:
-  Usage: optional (default: 3.2V, or pre-configured value)
-  Value type: <u32>; uV; range [2.1V : 3.6V]
-  Description: Battery voltage limit above which fast charging may operate;
-               Below this value linear or switch-mode auto-trickle-charging
-               will operate.
-
-- qcom,fast-charge-high-threshold-voltage:
-  Usage: optional (default: 4.2V, or pre-configured value)
-  Value type: <u32>; uV; range [3.24V : 5V]
-  Description: Battery voltage limit below which fast charging may operate;
-               The fast charger will attempt to charge the battery to this
-               voltage.  May be clamped to safety limits.
-
-- qcom,fast-charge-safe-voltage:
-  Usage: optional (default: 4.2V, or pre-configured value)
-  Value type: <u32>; uV; range [3.24V : 5V]
-  Description: Maximum safe battery voltage; May be pre-set by bootloader, in
-               which case, setting this will harmlessly fail. The property
-               'fast-charge-high-watermark' will be clamped by this value.
-
-- qcom,fast-charge-safe-current:
-  Usage: optional (default: 1A, or pre-configured value)
-  Value type: <u32>; uA; range [100mA : 3A]
-  Description: Maximum safe battery charge current; May pre-set by bootloader,
-               in which case, setting this will harmlessly fail. The property
-               'qcom,fast-charge-current-limit' will be clamped by this value.
-
-- qcom,auto-recharge-threshold-voltage:
-  Usage: optional (default: 4.1V, or pre-configured value)
-  Value type: <u32>; uV; range [3.24V : 5V]
-  Description: Battery voltage limit below which auto-recharge functionality
-               will restart charging after end-of-charge;  The high cutoff
-               limit for auto-recharge is 5% above this value.
-
-- qcom,minimum-input-voltage:
-  Usage: optional (default: 4.3V, or pre-configured value)
-  Value type: <u32>; uV; range [4.2V : 9.6V]
-  Description: Input voltage level above which charging may operate
-
-- qcom,dc-current-limit:
-  Usage: optional (default: 100mA, or pre-configured value)
-  Value type: <u32>; uA; range [100mA : 2.5A]
-  Description: Default DC charge current limit
-
-- qcom,disable-dc:
-  Usage: optional (default: false)
-  Value type: boolean: <u32> or <empty>
-  Description: Disable DC charger
-
-- qcom,jeita-extended-temp-range:
-  Usage: optional (default: false)
-  Value type: boolean: <u32> or <empty>
-  Description: Enable JEITA extended temperature range;  This does *not*
-               adjust the maximum charge voltage or current in the extended
-               temperature range.  It only allows charging when the battery
-               is in the extended temperature range.  Voltage/current
-               regulation must be done externally to fully comply with
-               the JEITA safety guidelines if this flag is set.
-
-- usb_otg_in-supply:
-  Usage: optional
-  Value type: <phandle>
-  Description: Reference to the regulator supplying power to the USB_OTG_IN
-               pin.
-
-child nodes:
-- otg-vbus:
-  Usage: optional
-  Description: This node defines a regulator used to control the direction
-               of VBUS voltage - specifically: whether to supply voltage
-               to VBUS for host mode operation of the OTG port, or allow
-               input voltage from external VBUS for charging.  In the
-               hardware, the supply for this regulator comes from
-               usb_otg_in-supply.
-
-EXAMPLE
-charger@1000 {
-       compatible = "qcom,pm8941-charger";
-       reg = <0x1000 0x700>;
-       interrupts = <0x0 0x10 7 IRQ_TYPE_EDGE_BOTH>,
-                       <0x0 0x10 5 IRQ_TYPE_EDGE_BOTH>,
-                       <0x0 0x10 4 IRQ_TYPE_EDGE_BOTH>,
-                       <0x0 0x12 1 IRQ_TYPE_EDGE_BOTH>,
-                       <0x0 0x12 0 IRQ_TYPE_EDGE_BOTH>,
-                       <0x0 0x13 2 IRQ_TYPE_EDGE_BOTH>,
-                       <0x0 0x13 1 IRQ_TYPE_EDGE_BOTH>,
-                       <0x0 0x14 1 IRQ_TYPE_EDGE_BOTH>;
-       interrupt-names = "chg-done",
-                       "chg-fast",
-                       "chg-trkl",
-                       "bat-temp-ok",
-                       "bat-present",
-                       "chg-gone",
-                       "usb-valid",
-                       "dc-valid";
-
-       qcom,fast-charge-current-limit = <1000000>;
-       qcom,dc-charge-current-limit = <1000000>;
-       usb_otg_in-supply = <&pm8941_5vs1>;
-
-       otg-vbus {};
-};
-- 
2.30.2

