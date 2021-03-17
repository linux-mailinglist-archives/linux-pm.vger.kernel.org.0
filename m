Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94FA33F197
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 14:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhCQNto (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 09:49:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56184 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhCQNtN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:49:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C4C4D1F44EF1
Received: by jupiter.universe (Postfix, from userid 1000)
        id DD8DB4800EB; Wed, 17 Mar 2021 14:49:05 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 13/38] dt-bindings: power: supply: sc27xx-fg: Convert to DT schema format
Date:   Wed, 17 Mar 2021 14:48:39 +0100
Message-Id: <20210317134904.80737-14-sebastian.reichel@collabora.com>
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
 .../bindings/power/supply/sc27xx-fg.txt       | 59 -----------
 .../bindings/power/supply/sc27xx-fg.yaml      | 98 +++++++++++++++++++
 2 files changed, 98 insertions(+), 59 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
deleted file mode 100644
index b6359b590383..000000000000
--- a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
+++ /dev/null
@@ -1,59 +0,0 @@
-Spreadtrum SC27XX PMICs Fuel Gauge Unit Power Supply Bindings
-
-Required properties:
-- compatible: Should be one of the following:
-  "sprd,sc2720-fgu",
-  "sprd,sc2721-fgu",
-  "sprd,sc2723-fgu",
-  "sprd,sc2730-fgu",
-  "sprd,sc2731-fgu".
-- reg: The address offset of fuel gauge unit.
-- battery-detect-gpios: GPIO for battery detection.
-- io-channels: Specify the IIO ADC channels to get temperature and charge voltage.
-- io-channel-names: Should be "bat-temp" or "charge-vol".
-- nvmem-cells: A phandle to the calibration cells provided by eFuse device.
-- nvmem-cell-names: Should be "fgu_calib".
-- sprd,calib-resistance-micro-ohms: Specify the real resistance of coulomb counter
-  chip in micro Ohms.
-- monitored-battery: Phandle of battery characteristics devicetree node.
-  See Documentation/devicetree/bindings/power/supply/battery.txt
-
-Example:
-
-	bat: battery {
-		compatible = "simple-battery";
-		charge-full-design-microamp-hours = <1900000>;
-		constant-charge-voltage-max-microvolt = <4350000>;
-		ocv-capacity-celsius = <20>;
-		ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>,
-					<4022000 85>, <3983000 80>, <3949000 75>,
-					<3917000 70>, <3889000 65>, <3864000 60>,
-					<3835000 55>, <3805000 50>, <3787000 45>,
-					<3777000 40>, <3773000 35>, <3770000 30>,
-					<3765000 25>, <3752000 20>, <3724000 15>,
-					<3680000 10>, <3605000 5>, <3400000 0>;
-		......
-	};
-
-	sc2731_pmic: pmic@0 {
-		compatible = "sprd,sc2731";
-		reg = <0>;
-		spi-max-frequency = <26000000>;
-		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		fgu@a00 {
-			compatible = "sprd,sc2731-fgu";
-			reg = <0xa00>;
-			battery-detect-gpios = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
-			io-channels = <&pmic_adc 5>, <&pmic_adc 14>;
-			io-channel-names = "bat-temp", "charge-vol";
-			nvmem-cells = <&fgu_calib>;
-			nvmem-cell-names = "fgu_calib";
-			monitored-battery = <&bat>;
-			sprd,calib-resistance-micro-ohms = <21500>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml
new file mode 100644
index 000000000000..e019cffd1f38
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/sc27xx-fg.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Spreadtrum SC27XX PMICs Fuel Gauge Unit Power Supply Bindings
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
+      - sprd,sc2720-fgu
+      - sprd,sc2721-fgu
+      - sprd,sc2723-fgu
+      - sprd,sc2730-fgu
+      - sprd,sc2731-fgu
+
+  reg:
+    maxItems: 1
+
+  battery-detect-gpios:
+    maxItems: 1
+
+  io-channels:
+    items:
+      - description: Battery Temperature ADC
+      - description: Battery Charge Voltage ADC
+
+  io-channel-names:
+    items:
+      - const: bat-temp
+      - const: charge-vol
+
+  nvmem-cells:
+    maxItems: 1
+    description: Calibration cells provided by eFuse device
+
+  nvmem-cell-names:
+    const: fgu_calib
+
+  sprd,calib-resistance-micro-ohms:
+    description: real resistance of coulomb counter chip in micro Ohms
+
+  monitored-battery: true
+
+required:
+  - compatible
+  - reg
+  - battery-detect-gpios
+  - io-channels
+  - io-channel-names
+  - nvmem-cells
+  - nvmem-cell-names
+  - sprd,calib-resistance-micro-ohms
+  - monitored-battery
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    bat: battery {
+      compatible = "simple-battery";
+      charge-full-design-microamp-hours = <1900000>;
+      constant-charge-voltage-max-microvolt = <4350000>;
+      ocv-capacity-celsius = <20>;
+      ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>,
+                             <4022000 85>, <3983000 80>, <3949000 75>,
+                             <3917000 70>, <3889000 65>, <3864000 60>,
+                             <3835000 55>, <3805000 50>, <3787000 45>,
+                             <3777000 40>, <3773000 35>, <3770000 30>,
+                             <3765000 25>, <3752000 20>, <3724000 15>,
+                             <3680000 10>, <3605000 5>, <3400000 0>;
+                             // ...
+    };
+
+    pmic {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      battery@a00 {
+        compatible = "sprd,sc2731-fgu";
+        reg = <0xa00>;
+        battery-detect-gpios = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
+        io-channels = <&pmic_adc 5>, <&pmic_adc 14>;
+        io-channel-names = "bat-temp", "charge-vol";
+        nvmem-cells = <&fgu_calib>;
+        nvmem-cell-names = "fgu_calib";
+        monitored-battery = <&bat>;
+        sprd,calib-resistance-micro-ohms = <21500>;
+      };
+    };
-- 
2.30.2

