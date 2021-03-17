Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C89433F178
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 14:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhCQNtc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 09:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbhCQNtK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:49:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0505C061760;
        Wed, 17 Mar 2021 06:49:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 579B71F448A2
Received: by jupiter.universe (Postfix, from userid 1000)
        id C38874800DC; Wed, 17 Mar 2021 14:49:05 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 04/38] dt-bindings: power: supply: bq25890: Convert to DT schema format
Date:   Wed, 17 Mar 2021 14:48:30 +0100
Message-Id: <20210317134904.80737-5-sebastian.reichel@collabora.com>
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
 .../bindings/power/supply/bq25890.txt         |  60 ---------
 .../bindings/power/supply/bq25890.yaml        | 123 ++++++++++++++++++
 2 files changed, 123 insertions(+), 60 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/bq25890.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq25890.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/bq25890.txt b/Documentation/devicetree/bindings/power/supply/bq25890.txt
deleted file mode 100644
index 805040c6fff9..000000000000
--- a/Documentation/devicetree/bindings/power/supply/bq25890.txt
+++ /dev/null
@@ -1,60 +0,0 @@
-Binding for TI bq25890 Li-Ion Charger
-
-This driver will support the bq25892, the bq25896 and the bq25890. There are
-other ICs in the same family but those have not been tested.
-
-Required properties:
-- compatible: Should contain one of the following:
-    * "ti,bq25890"
-    * "ti,bq25892"
-    * "ti,bq25895"
-    * "ti,bq25896"
-- reg: integer, i2c address of the device.
-- interrupts: interrupt line;
-- ti,battery-regulation-voltage: integer, maximum charging voltage (in uV);
-- ti,charge-current: integer, maximum charging current (in uA);
-- ti,termination-current: integer, charge will be terminated when current in
-    constant-voltage phase drops below this value (in uA);
-- ti,precharge-current: integer, maximum charge current during precharge
-    phase (in uA);
-- ti,minimum-sys-voltage: integer, when battery is charging and it is below
-    minimum system voltage, the system will be regulated above
-    minimum-sys-voltage setting (in uV);
-- ti,boost-voltage: integer, VBUS voltage level in boost mode (in uV);
-- ti,boost-max-current: integer, maximum allowed current draw in boost mode
-    (in uA).
-
-Optional properties:
-- ti,boost-low-freq: boolean, if present boost mode frequency will be 500kHz,
-    otherwise 1.5MHz;
-- ti,use-ilim-pin: boolean, if present the ILIM resistor will be used and the
-    input current will be the lower between the resistor setting and the IINLIM
-    register setting;
-- ti,thermal-regulation-threshold: integer, temperature above which the charge
-    current is lowered, to avoid overheating (in degrees Celsius). If omitted,
-    the default setting will be used (120 degrees);
-- ti,ibatcomp-micro-ohms: integer, value of a resistor in series with
-    the battery;
-- ti,ibatcomp-clamp-microvolt: integer, maximum charging voltage adjustment due
-    to expected voltage drop on in-series resistor;
-
-Example:
-
-bq25890 {
-	compatible = "ti,bq25890";
-	reg = <0x6a>;
-
-	interrupt-parent = <&gpio1>;
-	interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
-
-	ti,battery-regulation-voltage = <4200000>;
-	ti,charge-current = <1000000>;
-	ti,termination-current = <50000>;
-	ti,precharge-current = <128000>;
-	ti,minimum-sys-voltage = <3600000>;
-	ti,boost-voltage = <5000000>;
-	ti,boost-max-current = <1000000>;
-
-	ti,use-ilim-pin;
-	ti,thermal-regulation-threshold = <120>;
-};
diff --git a/Documentation/devicetree/bindings/power/supply/bq25890.yaml b/Documentation/devicetree/bindings/power/supply/bq25890.yaml
new file mode 100644
index 000000000000..bf823b615439
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/bq25890.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 Sebastian Reichel
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/bq25890.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Binding for bq25890, bq25892, bq25895 and bq25896 Li-Ion Charger
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
+      - ti,bq25890
+      - ti,bq25892
+      - ti,bq25895
+      - ti,bq25896
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  ti,battery-regulation-voltage:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: maximum charging voltage (in uV)
+
+  ti,charge-current:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: maximum charging current (in uA)
+
+  ti,termination-current:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      charge will be terminated when current in constant-voltage phase
+      drops below this value (in uA)
+
+  ti,precharge-current:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: maximum charge current during precharge phase (in uA)
+
+  ti,minimum-sys-voltage:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      when battery is charging and it is below minimum system voltage,
+      the system will be regulated above minimum-sys-voltage setting (in uV)
+
+  ti,boost-voltage:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: VBUS voltage level in boost mode (in uV)
+
+  ti,boost-max-current:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: maximum allowed current draw in boost mode (in uA)
+
+  ti,boost-low-freq:
+    description: boost mode frequency will be 500kHz, otherwise 1.5MHz
+    type: boolean
+
+  ti,use-ilim-pin:
+    description: |
+      ILIM resistor will be used and the input current will be the lower
+      between the resistor setting and the IINLIM register setting
+    type: boolean
+
+  ti,thermal-regulation-threshold:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      temperature above which the charge current is lowered, to avoid overheating
+      (in degrees Celsius). If omitted, the default setting will be used (120 degrees)
+
+  ti,ibatcomp-micro-ohms:
+    description: value of a resistor in series with the battery (in Micro Ohms)
+
+  ti,ibatcomp-clamp-microvolt:
+    description: max. charging voltage adjustment due to expected voltage drop on in-series resistor
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - ti,battery-regulation-voltage
+  - ti,charge-current
+  - ti,termination-current
+  - ti,precharge-current
+  - ti,minimum-sys-voltage
+  - ti,boost-voltage
+  - ti,boost-max-current
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
+      charger@6a {
+        compatible = "ti,bq25890";
+        reg = <0x6a>;
+
+        interrupt-parent = <&gpio1>;
+        interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+
+        ti,battery-regulation-voltage = <4200000>;
+        ti,charge-current = <1000000>;
+        ti,termination-current = <50000>;
+        ti,precharge-current = <128000>;
+        ti,minimum-sys-voltage = <3600000>;
+        ti,boost-voltage = <5000000>;
+        ti,boost-max-current = <1000000>;
+
+        ti,use-ilim-pin;
+        ti,thermal-regulation-threshold = <120>;
+      };
+    };
-- 
2.30.2

