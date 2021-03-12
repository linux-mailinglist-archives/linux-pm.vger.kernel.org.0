Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DD83391CB
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 16:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhCLPok (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 10:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhCLPoO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 10:44:14 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEB6C061762;
        Fri, 12 Mar 2021 07:44:13 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A5C3D1F46E9B
Received: by jupiter.universe (Postfix, from userid 1000)
        id 4CD434800F8; Fri, 12 Mar 2021 16:44:08 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 14/38] dt-bindings: power: supply: sc2731-charger: Convert to DT schema format
Date:   Fri, 12 Mar 2021 16:43:33 +0100
Message-Id: <20210312154357.1561730-15-sebastian.reichel@collabora.com>
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
 .../bindings/power/supply/sc2731-charger.yaml | 53 +++++++++++++++++++
 .../bindings/power/supply/sc2731_charger.txt  | 40 --------------
 2 files changed, 53 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sc2731-charger.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/sc2731_charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/sc2731-charger.yaml b/Documentation/devicetree/bindings/power/supply/sc2731-charger.yaml
new file mode 100644
index 000000000000..db1aa238cda5
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/sc2731-charger.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/sc2731-charger.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Spreadtrum SC2731 PMICs battery charger binding
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: sprd,sc2731-charger
+
+  reg:
+    maxItems: 1
+
+  phys:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the USB phy
+
+  monitored-battery:
+    description: |
+      The charger uses the following battery properties
+      - charge-term-current-microamp: current for charge termination phase.
+      - constant-charge-voltage-max-microvolt: maximum constant input voltage.
+      See Documentation/devicetree/bindings/power/supply/battery.yaml
+
+additionalProperties: false
+
+examples:
+  - |
+    bat: battery {
+      compatible = "simple-battery";
+      charge-term-current-microamp = <120000>;
+      constant-charge-voltage-max-microvolt = <4350000>;
+    };
+
+    pmic {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      battery@a00 {
+        compatible = "sprd,sc2731-charger";
+        reg = <0x0>;
+        phys = <&ssphy>;
+        monitored-battery = <&bat>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt b/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt
deleted file mode 100644
index 5266fab16575..000000000000
--- a/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-Spreadtrum SC2731 PMIC battery charger binding
-
-Required properties:
- - compatible: Should be "sprd,sc2731-charger".
- - reg: Address offset of charger register.
- - phys: Contains a phandle to the USB phy.
-
-Optional Properties:
-- monitored-battery: phandle of battery characteristics devicetree node.
-  The charger uses the following battery properties:
-- charge-term-current-microamp: current for charge termination phase.
-- constant-charge-voltage-max-microvolt: maximum constant input voltage.
-  See Documentation/devicetree/bindings/power/supply/battery.txt
-
-Example:
-
-	bat: battery {
-		compatible = "simple-battery";
-		charge-term-current-microamp = <120000>;
-		constant-charge-voltage-max-microvolt = <4350000>;
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
-		charger@0 {
-			compatible = "sprd,sc2731-charger";
-			reg = <0x0>;
-			phys = <&ssphy>;
-			monitored-battery = <&bat>;
-		};
-	};
-- 
2.30.1

