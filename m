Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6379633F1EB
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 14:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhCQN4d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 09:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhCQN4D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:56:03 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02DDC061762;
        Wed, 17 Mar 2021 06:56:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 98C6D1F451E9
Received: by jupiter.universe (Postfix, from userid 1000)
        id 1DBCF48011A; Wed, 17 Mar 2021 14:49:06 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 32/38] dt-bindings: power: supply: ltc294x: Convert to DT schema format
Date:   Wed, 17 Mar 2021 14:48:58 +0100
Message-Id: <20210317134904.80737-33-sebastian.reichel@collabora.com>
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
 .../bindings/power/supply/lltc,ltc294x.yaml   | 66 +++++++++++++++++++
 .../bindings/power/supply/ltc2941.txt         | 28 --------
 2 files changed, 66 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/lltc,ltc294x.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/ltc2941.txt

diff --git a/Documentation/devicetree/bindings/power/supply/lltc,ltc294x.yaml b/Documentation/devicetree/bindings/power/supply/lltc,ltc294x.yaml
new file mode 100644
index 000000000000..043bf378040f
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/lltc,ltc294x.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/lltc,ltc294x.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Binding for LTC2941, LTC2942, LTC2943 and LTC2944 battery fuel gauges
+
+description: |
+  All chips measure battery capacity.
+  The LTC2942 is pin compatible with the LTC2941, it adds voltage and
+  temperature monitoring, and is runtime detected. LTC2943 and LTC2944
+  are software compatible, uses a slightly different conversion formula
+  for the charge counter and adds voltage, current and temperature monitoring.
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
+      - lltc,ltc2941
+      - lltc,ltc2942
+      - lltc,ltc2943
+      - lltc,ltc2944
+
+  reg:
+    maxItems: 1
+
+  lltc,resistor-sense:
+    $ref: /schemas/types.yaml#/definitions/int32
+    description: |
+      Sense resistor value in milli-ohms.
+      Can be negative value when the battery has been connected to the wrong end of the resistor.
+
+  lltc,prescaler-exponent:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      The prescaler exponent as explained in the datasheet.
+      This determines the range and accuracy of the gauge.
+      The value is programmed into the chip only if it differs from the current setting.
+      The setting is lost when the battery is disconnected.
+
+required:
+  - compatible
+  - reg
+  - lltc,resistor-sense
+  - lltc,prescaler-exponent
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      battery@64 {
+        compatible = "lltc,ltc2943";
+        reg = <0x64>;
+        lltc,resistor-sense = <15>;
+        lltc,prescaler-exponent = <5>; /* 2^(2*5) = 1024 */
+      };
+    };
diff --git a/Documentation/devicetree/bindings/power/supply/ltc2941.txt b/Documentation/devicetree/bindings/power/supply/ltc2941.txt
deleted file mode 100644
index 3b9ba147b041..000000000000
--- a/Documentation/devicetree/bindings/power/supply/ltc2941.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-binding for LTC2941, LTC2942, LTC2943 and LTC2944 battery gauges
-
-All chips measure battery capacity.
-The LTC2942 is pin compatible with the LTC2941, it adds voltage and
-temperature monitoring, and is runtime detected. LTC2943 and LTC2944
-is software compatible, uses a slightly different conversion formula
-for the charge counter and adds voltage, current and temperature monitoring.
-
-Required properties:
-- compatible: Should contain "lltc,ltc2941", "lltc,ltc2942", "lltc,ltc2943"
-    or "lltc,ltc2944" which also indicates the type of I2C chip attached.
-- reg: The 7-bit I2C address.
-- lltc,resistor-sense: The sense resistor value in milli-ohms. Can be a 32-bit
-    negative value when the battery has been connected to the wrong end of the
-    resistor.
-- lltc,prescaler-exponent: The prescaler exponent as explained in the datasheet.
-    This determines the range and accuracy of the gauge. The value is programmed
-    into the chip only if it differs from the current setting. The setting is
-    lost when the battery is disconnected.
-
-Example from the Topic Miami Florida board:
-
-	fuelgauge: ltc2943@64 {
-		compatible = "lltc,ltc2943";
-		reg = <0x64>;
-		lltc,resistor-sense = <15>;
-		lltc,prescaler-exponent = <5>; /* 2^(2*5) = 1024 */
-	};
-- 
2.30.2

