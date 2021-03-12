Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C357C33925B
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 16:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhCLPwg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 10:52:36 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55848 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbhCLPw3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 10:52:29 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 783C01F46E72
Received: by jupiter.universe (Postfix, from userid 1000)
        id 69260480117; Fri, 12 Mar 2021 16:44:08 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 29/38] dt-bindings: power: supply: da9150: Convert to DT schema format
Date:   Fri, 12 Mar 2021 16:43:48 +0100
Message-Id: <20210312154357.1561730-30-sebastian.reichel@collabora.com>
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
 .../bindings/power/supply/da9150-charger.txt  | 26 ----------
 .../bindings/power/supply/da9150-fg.txt       | 23 --------
 .../power/supply/dlg,da9150-charger.yaml      | 52 +++++++++++++++++++
 .../power/supply/dlg,da9150-fuel-gauge.yaml   | 51 ++++++++++++++++++
 4 files changed, 103 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/da9150-charger.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/da9150-fg.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/dlg,da9150-charger.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/dlg,da9150-fuel-gauge.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/da9150-charger.txt b/Documentation/devicetree/bindings/power/supply/da9150-charger.txt
deleted file mode 100644
index f3906663c454..000000000000
--- a/Documentation/devicetree/bindings/power/supply/da9150-charger.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Dialog Semiconductor DA9150 Charger Power Supply bindings
-
-Required properties:
-- compatible: "dlg,da9150-charger" for DA9150 Charger Power Supply
-
-Optional properties:
-- io-channels: List of phandle and IIO specifier pairs
-- io-channel-names: List of channel names used by charger
-      ["CHAN_IBUS", "CHAN_VBUS", "CHAN_TJUNC", "CHAN_VBAT"]
-  (See Documentation/devicetree/bindings/iio/iio-bindings.txt for further info)
-
-
-Example:
-
-	da9150-charger {
-		compatible = "dlg,da9150-charger";
-
-		io-channels = <&gpadc 0>,
-			      <&gpadc 2>,
-			      <&gpadc 8>,
-			      <&gpadc 5>;
-		io-channel-names = "CHAN_IBUS",
-				   "CHAN_VBUS",
-				   "CHAN_TJUNC",
-				   "CHAN_VBAT";
-	};
diff --git a/Documentation/devicetree/bindings/power/supply/da9150-fg.txt b/Documentation/devicetree/bindings/power/supply/da9150-fg.txt
deleted file mode 100644
index 00236fe3ea31..000000000000
--- a/Documentation/devicetree/bindings/power/supply/da9150-fg.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Dialog Semiconductor DA9150 Fuel-Gauge Power Supply bindings
-
-Required properties:
-- compatible: "dlg,da9150-fuel-gauge" for DA9150 Fuel-Gauge Power Supply
-
-Optional properties:
-- dlg,update-interval: Interval time (milliseconds) between battery level checks.
-- dlg,warn-soc-level: Battery discharge level (%) where warning event raised.
-      [1 - 100]
-- dlg,crit-soc-level: Battery discharge level (%) where critical event raised.
-  This value should be lower than the warning level.
-      [1 - 100]
-
-
-Example:
-
-	fuel-gauge {
-		compatible = "dlg,da9150-fuel-gauge";
-
-		dlg,update-interval = <10000>;
-		dlg,warn-soc-level = /bits/ 8 <15>;
-		dlg,crit-soc-level = /bits/ 8 <5>;
-	};
diff --git a/Documentation/devicetree/bindings/power/supply/dlg,da9150-charger.yaml b/Documentation/devicetree/bindings/power/supply/dlg,da9150-charger.yaml
new file mode 100644
index 000000000000..96336b05d76d
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/dlg,da9150-charger.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/dlg,da9150-charger.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Dialog Semiconductor DA9150 Charger Power Supply bindings
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: dlg,da9150-charger
+
+  io-channels:
+    items:
+      - description: ADC channel for current
+      - description: ADC channel for bus voltage
+      - description: ADC channel for junction temperature
+      - description: ADC channel for battery voltage
+
+  io-channel-names:
+    items:
+      - const: CHAN_IBUS
+      - const: CHAN_VBUS
+      - const: CHAN_TJUNC
+      - const: CHAN_VBAT
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    pmic {
+      charger {
+        compatible = "dlg,da9150-charger";
+        io-channels = <&gpadc 0>,
+                      <&gpadc 2>,
+                      <&gpadc 8>,
+                      <&gpadc 5>;
+        io-channel-names = "CHAN_IBUS",
+                           "CHAN_VBUS",
+                           "CHAN_TJUNC",
+                           "CHAN_VBAT";
+      };
+    };
diff --git a/Documentation/devicetree/bindings/power/supply/dlg,da9150-fuel-gauge.yaml b/Documentation/devicetree/bindings/power/supply/dlg,da9150-fuel-gauge.yaml
new file mode 100644
index 000000000000..30c2fff7cf92
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/dlg,da9150-fuel-gauge.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/dlg,da9150-fuel-gauge.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Dialog Semiconductor DA9150 Fuel-Gauge Power Supply bindings
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: dlg,da9150-fuel-gauge
+
+  dlg,update-interval:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Interval time (milliseconds) between battery level checks.
+
+  dlg,warn-soc-level:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    minimum: 1
+    maximum: 100
+    description: Battery discharge level (%) where warning event raised.
+
+  dlg,crit-soc-level:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    minimum: 1
+    maximum: 100
+    description: |
+      Battery discharge level (%) where critical event raised.
+      This value should be lower than the warning level.
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    pmic {
+      battery {
+        compatible = "dlg,da9150-fuel-gauge";
+        dlg,update-interval = <10000>;
+        dlg,warn-soc-level = /bits/ 8 <15>;
+        dlg,crit-soc-level = /bits/ 8 <5>;
+      };
+    };
-- 
2.30.1

