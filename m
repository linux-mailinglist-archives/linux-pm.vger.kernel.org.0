Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBC433F1E1
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 14:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhCQN4c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 09:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhCQN4B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:56:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6277C06174A;
        Wed, 17 Mar 2021 06:56:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8C5CE1F451B0
Received: by jupiter.universe (Postfix, from userid 1000)
        id 0F464480114; Wed, 17 Mar 2021 14:49:06 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 27/38] dt-bindings: power: supply: act8945a: Convert to DT schema format
Date:   Wed, 17 Mar 2021 14:48:53 +0100
Message-Id: <20210317134904.80737-28-sebastian.reichel@collabora.com>
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
 .../power/supply/act8945a-charger.txt         | 44 -----------
 .../supply/active-semi,act8945a-charger.yaml  | 76 +++++++++++++++++++
 2 files changed, 76 insertions(+), 44 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/act8945a-charger.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/active-semi,act8945a-charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/act8945a-charger.txt b/Documentation/devicetree/bindings/power/supply/act8945a-charger.txt
deleted file mode 100644
index cb737a9e1f16..000000000000
--- a/Documentation/devicetree/bindings/power/supply/act8945a-charger.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-Device-Tree bindings for charger of Active-semi ACT8945A Multi-Function Device
-
-Required properties:
- - compatible: "active-semi,act8945a-charger".
- - active-semi,chglev-gpios: charge current level phandle with args
-   as described in ../gpio/gpio.txt.
- - active-semi,lbo-gpios: specify the low battery voltage detect phandle
-   with args as as described in ../gpio/gpio.txt.
- - interrupts: <a b> where a is the interrupt number and b is a
-   field that represents an encoding of the sense and level
-   information for the interrupt.
-
-Optional properties:
- - active-semi,input-voltage-threshold-microvolt: unit: mV;
-   Specifies the charger's input over-voltage threshold value;
-   The value can be: 6600, 7000, 7500, 8000; default: 6600
- - active-semi,precondition-timeout: unit: minutes;
-   Specifies the charger's PRECONDITION safety timer setting value;
-   The value can be: 40, 60, 80, 0; If 0, it means to disable this timer;
-   default: 40.
- - active-semi,total-timeout: unit: hours;
-   Specifies the charger's total safety timer setting value;
-   The value can be: 3, 4, 5, 0; If 0, it means to disable this timer;
-   default: 3.
-
-Example:
-	pmic@5b {
-		compatible = "active-semi,act8945a";
-		reg = <0x5b>;
-
-		charger {
-			compatible = "active-semi,act8945a-charger";
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_charger_chglev &pinctrl_charger_lbo &pinctrl_charger_irq>;
-			interrupt-parent = <&pioA>;
-			interrupts = <45 IRQ_TYPE_LEVEL_LOW>;
-
-			active-semi,chglev-gpios = <&pioA 12 GPIO_ACTIVE_HIGH>;
-			active-semi,lbo-gpios = <&pioA 72 GPIO_ACTIVE_LOW>;
-			active-semi,input-voltage-threshold-microvolt = <6600>;
-			active-semi,precondition-timeout = <40>;
-			active-semi,total-timeout = <3>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/power/supply/active-semi,act8945a-charger.yaml b/Documentation/devicetree/bindings/power/supply/active-semi,act8945a-charger.yaml
new file mode 100644
index 000000000000..3f74bc19415d
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/active-semi,act8945a-charger.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/active-semi,act8945a-charger.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Active-semi ACT8945A Charger Function
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: active-semi,act8945a-charger
+
+  interrupts:
+    maxItems: 1
+
+  active-semi,chglev-gpios:
+    maxItems: 1
+    description: charge current level GPIO
+
+  active-semi,lbo-gpios:
+    maxItems: 1
+    description: low battery voltage detect GPIO
+
+  active-semi,input-voltage-threshold-microvolt:
+    description: |
+      Specifies the charger's input over-voltage threshold value.
+      Despite the name, specified values are in millivolt (mV).
+      Defaults to 6.6 V
+    enum: [ 6600, 7000, 7500, 8000 ]
+
+  active-semi,precondition-timeout:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Specifies the charger's PRECONDITION safety timer setting value in minutes.
+      If 0, it means to disable this timer.
+      Defaults to 40 minutes.
+    enum: [ 0, 40, 60, 80 ]
+
+  active-semi,total-timeout:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Specifies the charger's total safety timer setting value in hours;
+      If 0, it means to disable this timer;
+      Defaults to 3 hours.
+    enum: [ 0, 3, 4, 5 ]
+
+required:
+  - compatible
+  - interrupts
+  - active-semi,chglev-gpios
+  - active-semi,lbo-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    pmic {
+      charger {
+        compatible = "active-semi,act8945a-charger";
+        interrupt-parent = <&pioA>;
+        interrupts = <45 IRQ_TYPE_LEVEL_LOW>;
+        active-semi,chglev-gpios = <&pioA 12 GPIO_ACTIVE_HIGH>;
+        active-semi,lbo-gpios = <&pioA 72 GPIO_ACTIVE_LOW>;
+        active-semi,input-voltage-threshold-microvolt = <6600>;
+        active-semi,precondition-timeout = <40>;
+        active-semi,total-timeout = <3>;
+      };
+    };
-- 
2.30.2

