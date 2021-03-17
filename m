Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7DD33F194
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 14:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhCQNto (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 09:49:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56180 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbhCQNtN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:49:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id AABA91F44E60
Received: by jupiter.universe (Postfix, from userid 1000)
        id CEBBD4800E0; Wed, 17 Mar 2021 14:49:05 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 08/38] dt-bindings: power: supply: bq24735: Convert to DT schema format
Date:   Wed, 17 Mar 2021 14:48:34 +0100
Message-Id: <20210317134904.80737-9-sebastian.reichel@collabora.com>
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
 .../bindings/power/supply/bq24735.yaml        | 89 +++++++++++++++++++
 .../bindings/power/supply/ti,bq24735.txt      | 39 --------
 2 files changed, 89 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq24735.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/ti,bq24735.txt

diff --git a/Documentation/devicetree/bindings/power/supply/bq24735.yaml b/Documentation/devicetree/bindings/power/supply/bq24735.yaml
new file mode 100644
index 000000000000..131be6782c4b
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/bq24735.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 Sebastian Reichel
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/bq24735.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Binding for TI BQ24735 Li-Ion Battery Charger
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: ti,bq24735
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: AC adapter plug event interrupt
+    maxItems: 1
+
+  ti,ac-detect-gpios:
+    maxItems: 1
+    description: |
+      This GPIO is optionally used to read the AC adapter status. This is a Host GPIO
+      that is configured as an input and connected to the ACOK pin on the bq24735.
+      Note: for backwards compatibility reasons, the GPIO must be active on AC adapter
+      absence despite ACOK being active (high) on AC adapter presence.
+
+  ti,charge-current:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Used to control and set the charging current.
+      This value must be between 128mA and 8.128A with a 64mA step resolution.
+      The POR value is 0x0000h. This number is in mA (e.g. 8192).
+      See spec for more information about the ChargeCurrent (0x14h) register.
+
+  ti,charge-voltage:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Used to control and set the charging voltage.
+      This value must be between 1.024V and 19.2V with a 16mV step resolution.
+      The POR value is 0x0000h. This number is in mV (e.g. 19200).
+      See spec for more information about the ChargeVoltage (0x15h) register.
+
+  ti,input-current:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Used to control and set the charger input current.
+      This value must be between 128mA and 8.064A with a 128mA step resolution.
+      The POR value is 0x1000h. This number is in mA (e.g. 8064).
+      See the spec for more information about the InputCurrent (0x3fh) register.
+
+  ti,external-control:
+    type: boolean
+    description: |
+      Indicates that the charger is configured externally and that the host should not
+      attempt to enable/disable charging or set the charge voltage/current.
+
+  poll-interval:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      If 'interrupts' is not specified, poll AC adapter presence with this interval (milliseconds).
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      charger@9 {
+        compatible = "ti,bq24735";
+        reg = <0x9>;
+        ti,ac-detect-gpios = <&gpio 72 0x1>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt b/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt
deleted file mode 100644
index de45e1a2a4d9..000000000000
--- a/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-TI BQ24735 Charge Controller
-~~~~~~~~~~
-
-Required properties :
- - compatible : "ti,bq24735"
-
-Optional properties :
- - interrupts : Specify the interrupt to be used to trigger when the AC
-   adapter is either plugged in or removed.
- - ti,ac-detect-gpios : This GPIO is optionally used to read the AC adapter
-   status. This is a Host GPIO that is configured as an input and connected
-   to the ACOK pin on the bq24735. Note: for backwards compatibility reasons,
-   the GPIO must be active on AC adapter absence despite ACOK being active
-   (high) on AC adapter presence.
- - ti,charge-current : Used to control and set the charging current. This value
-   must be between 128mA and 8.128A with a 64mA step resolution. The POR value
-   is 0x0000h. This number is in mA (e.g. 8192), see spec for more information
-   about the ChargeCurrent (0x14h) register.
- - ti,charge-voltage : Used to control and set the charging voltage. This value
-   must be between 1.024V and 19.2V with a 16mV step resolution. The POR value
-   is 0x0000h. This number is in mV (e.g. 19200), see spec for more information
-   about the ChargeVoltage (0x15h) register.
- - ti,input-current : Used to control and set the charger input current. This
-   value must be between 128mA and 8.064A with a 128mA step resolution. The
-   POR value is 0x1000h. This number is in mA (e.g. 8064), see the spec for
-   more information about the InputCurrent (0x3fh) register.
- - ti,external-control : Indicates that the charger is configured externally
-   and that the host should not attempt to enable/disable charging or set the
-   charge voltage/current.
- - poll-interval : In case 'interrupts' is not specified, poll AC adapter
-   presence with this interval (milliseconds).
-
-Example:
-
-	bq24735@9 {
-		compatible = "ti,bq24735";
-		reg = <0x9>;
-		ti,ac-detect-gpios = <&gpio 72 0x1>;
-	}
-- 
2.30.2

