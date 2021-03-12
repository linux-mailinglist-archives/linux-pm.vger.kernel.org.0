Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A207A3391EA
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 16:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhCLPot (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 10:44:49 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55672 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbhCLPoR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 10:44:17 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 465C61F46EC5
Received: by jupiter.universe (Postfix, from userid 1000)
        id 59BCC480106; Fri, 12 Mar 2021 16:44:08 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 20/38] dt-bindings: power: supply: max17040: Convert to DT schema format
Date:   Fri, 12 Mar 2021 16:43:39 +0100
Message-Id: <20210312154357.1561730-21-sebastian.reichel@collabora.com>
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
 .../power/supply/max17040_battery.txt         | 52 ----------
 .../bindings/power/supply/maxim,max17040.yaml | 95 +++++++++++++++++++
 2 files changed, 95 insertions(+), 52 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
deleted file mode 100644
index c802f664b508..000000000000
--- a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-max17040_battery
-~~~~~~~~~~~~~~~~
-
-Required properties :
- - compatible : "maxim,max17040", "maxim,max17041", "maxim,max17043",
-		"maxim,max17044", "maxim,max17048", "maxim,max17049",
-		"maxim,max17058", "maxim,max17059" or "maxim,max77836-battery"
- - reg: i2c slave address
-
-Optional properties :
-- maxim,alert-low-soc-level :	The alert threshold that sets the state of
-				charge level (%) where an interrupt is
-				generated. Can be configured from 1 up to 32
-				(%). If skipped the power up default value of
-				4 (%) will be used.
-- maxim,double-soc : 		Certain devices return double the capacity.
-				Specify this boolean property to divide the
-				reported value in 2 and thus normalize it.
-				SOC == State of Charge == Capacity.
-- maxim,rcomp :			A value to compensate readings for various
-				battery chemistries and operating temperatures.
-				max17040,41 have 2 byte rcomp, default to
-				0x97 0x00. All other devices have one byte
-				rcomp, default to 0x97.
-- interrupts : 			Interrupt line see Documentation/devicetree/
-				bindings/interrupt-controller/interrupts.txt
-- wakeup-source :		This device has wakeup capabilities. Use this
-				property to use alert low SOC level interrupt
-				as wake up source.
-
-Optional properties support interrupt functionality for alert low state of
-charge level, present in some ICs in the same family, and should be used with
-compatible "maxim,max77836-battery".
-
-Example:
-
-	battery-fuel-gauge@36 {
-		compatible = "maxim,max77836-battery";
-		reg = <0x36>;
-		maxim,alert-low-soc-level = <10>;
-		interrupt-parent = <&gpio7>;
-		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
-		wakeup-source;
-	};
-
-	battery-fuel-gauge@36 {
-		compatible = "maxim,max17048";
-		reg = <0x36>;
-		maxim,rcomp = /bits/ 8 <0x56>;
-		maxim,alert-low-soc-level = <10>;
-		maxim,double-soc;
-	};
diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
new file mode 100644
index 000000000000..de91cf3f058c
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/maxim,max17040.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Maxim 17040 fuel gauge series
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
+      - maxim,max17040
+      - maxim,max17041
+      - maxim,max17043
+      - maxim,max17044
+      - maxim,max17048
+      - maxim,max17049
+      - maxim,max17058
+      - maxim,max17059
+      - maxim,max77836-battery
+
+  reg:
+    maxItems: 1
+
+  maxim,alert-low-soc-level:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 32
+    description: |
+      The alert threshold that sets the state of charge level (%) where an interrupt is generated.
+      If skipped the power up default value of 4 (%) will be used.
+
+  maxim,double-soc:
+    type: boolean
+    description: |
+      Certain devices return double the capacity.
+      Specify this to divide the reported value in 2 and thus normalize it.
+      SoC == State of Charge == Capacity.
+
+  maxim,rcomp:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      A value to compensate readings for various battery chemistries and operating temperatures.
+      max17040,41 have 2 byte rcomp, default to 0x97 0x00.
+      All other devices have one byte rcomp, default to 0x97.
+
+  interrupts:
+    maxItems: 1
+
+  wakeup-source:
+    type: boolean
+    description: |
+      Use this property to use alert low SoC level interrupt as wake up source.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      battery@36 {
+        compatible = "maxim,max17048";
+        reg = <0x36>;
+        maxim,rcomp = /bits/ 8 <0x56>;
+        maxim,alert-low-soc-level = <10>;
+        maxim,double-soc;
+      };
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      battery@36 {
+        compatible = "maxim,max77836-battery";
+        reg = <0x36>;
+        maxim,alert-low-soc-level = <10>;
+        interrupt-parent = <&gpio7>;
+        interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+        wakeup-source;
+      };
+    };
-- 
2.30.1

