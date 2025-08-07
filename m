Return-Path: <linux-pm+bounces-32048-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBAAB1DF08
	for <lists+linux-pm@lfdr.de>; Thu,  7 Aug 2025 23:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04FA91AA0042
	for <lists+linux-pm@lfdr.de>; Thu,  7 Aug 2025 21:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4241B25744D;
	Thu,  7 Aug 2025 21:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXExmGMQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B0920296A;
	Thu,  7 Aug 2025 21:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754603106; cv=none; b=r5Ez/sKI1oDjRDPDWWaQC4V9kh1NUngrMHHTZM2nN0Cj6KJKO7XlqCOqB+AeBHr9TxonWVHssLndBAtAXlFe6O6ikOp3fMtNIH3lwxLacPxTxQlOMO9yTeBgSSbUnRr8WqnDwv5MSi1C35SPDCr6l6C52wGgfh47oHDQ+VL6aOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754603106; c=relaxed/simple;
	bh=yQVqZgYjYojyPE9FMTmZappbSPbqgnXokqGYtrRk4EY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HeA9ZDgYKcNPCO520FEmoHIYV/6vgzDTz227+0PamEB1tnGoDe4jYRw3PZBo7RgerlnSX51L6AG/PIyWs+UoCgVe172TOJq2nzB/M5maqE11bI5qo2njMW4x5xctYtuPL256u3WDp4OjMTWJ3EZdnGHX/GefXTi/ba6Kyda+AfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXExmGMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812A7C4CEEB;
	Thu,  7 Aug 2025 21:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754603105;
	bh=yQVqZgYjYojyPE9FMTmZappbSPbqgnXokqGYtrRk4EY=;
	h=From:To:Cc:Subject:Date:From;
	b=IXExmGMQH8BKwrOjcYSa+waKiaFstdbXKck8zJ7DMtBYxPFxrYfdg+KCVX+M/aL9o
	 duJZl+c0XvVwJlT2fSojsBl1wqpr5qQ7YmzDF6no84vuqrpNN82z7Jj8lfwBvV0C8/
	 OFuFQG/POZ00stMXG6oH+hNZHthJXDxxz0bIjdLI5w/eEkh89bmN2TJHRBOt9jVk23
	 BCeaNYg8UH51ioJOS+EsWgYq40epRXffL5TrG1trRwUbvWBxrbqzXW3jgBu/g1GXg/
	 dF2LPFytZrmyRpvDIEVJ9ZPyanjkRNa7L/4uG6qIhMpTZkry7zMsKWOYweRns2pw7O
	 Dg+IjquUWlQcA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] regulator: dt-bindings: Clean-up active-semi,act8945a duplication
Date: Thu,  7 Aug 2025 16:44:57 -0500
Message-ID: <20250807214459.4173892-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The active-semi,act8945a binding is documented in multiple places. The
charger child node is documented in regulator/active-semi,act8945a.yaml
and power/supply/active-semi,act8945a-charger.yaml. An old text binding
is in mfd/act8945a.txt.

Update the regulator/active-semi,act8945a.yaml with the additional
descriptions and constraints from
power/supply/active-semi,act8945a-charger.yaml, and then remove it and
mfd/act8945a.txt.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/mfd/act8945a.txt      | 82 -------------------
 .../supply/active-semi,act8945a-charger.yaml  | 76 -----------------
 .../regulator/active-semi,act8945a.yaml       | 25 ++++--
 3 files changed, 19 insertions(+), 164 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/act8945a.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/active-semi,act8945a-charger.yaml

diff --git a/Documentation/devicetree/bindings/mfd/act8945a.txt b/Documentation/devicetree/bindings/mfd/act8945a.txt
deleted file mode 100644
index 5ca75d888b4a..000000000000
--- a/Documentation/devicetree/bindings/mfd/act8945a.txt
+++ /dev/null
@@ -1,82 +0,0 @@
-Device-Tree bindings for Active-semi ACT8945A MFD driver
-
-Required properties:
- - compatible: "active-semi,act8945a".
- - reg: the I2C slave address for the ACT8945A chip
-
-The chip exposes two subdevices:
- - a regulators: see ../regulator/act8945a-regulator.txt
- - a charger: see ../power/act8945a-charger.txt
-
-Example:
-	pmic@5b {
-		compatible = "active-semi,act8945a";
-		reg = <0x5b>;
-
-		active-semi,vsel-high;
-
-		regulators {
-			vdd_1v35_reg: REG_DCDC1 {
-				regulator-name = "VDD_1V35";
-				regulator-min-microvolt = <1350000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-always-on;
-			};
-
-			vdd_1v2_reg: REG_DCDC2 {
-				regulator-name = "VDD_1V2";
-				regulator-min-microvolt = <1100000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-always-on;
-			};
-
-			vdd_3v3_reg: REG_DCDC3 {
-				regulator-name = "VDD_3V3";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vdd_fuse_reg: REG_LDO1 {
-				regulator-name = "VDD_FUSE";
-				regulator-min-microvolt = <2500000>;
-				regulator-max-microvolt = <2500000>;
-				regulator-always-on;
-			};
-
-			vdd_3v3_lp_reg: REG_LDO2 {
-				regulator-name = "VDD_3V3_LP";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vdd_led_reg: REG_LDO3 {
-				regulator-name = "VDD_LED";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vdd_sdhc_1v8_reg: REG_LDO4 {
-				regulator-name = "VDD_SDHC_1V8";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-			};
-		};
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
deleted file mode 100644
index 5220d9cb16d8..000000000000
--- a/Documentation/devicetree/bindings/power/supply/active-semi,act8945a-charger.yaml
+++ /dev/null
@@ -1,76 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/power/supply/active-semi,act8945a-charger.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Active-semi ACT8945A Charger Function
-
-maintainers:
-  - Sebastian Reichel <sre@kernel.org>
-
-allOf:
-  - $ref: power-supply.yaml#
-
-properties:
-  compatible:
-    const: active-semi,act8945a-charger
-
-  interrupts:
-    maxItems: 1
-
-  active-semi,chglev-gpios:
-    maxItems: 1
-    description: charge current level GPIO
-
-  active-semi,lbo-gpios:
-    maxItems: 1
-    description: low battery voltage detect GPIO
-
-  active-semi,input-voltage-threshold-microvolt:
-    description: |
-      Specifies the charger's input over-voltage threshold value.
-      Despite the name, specified values are in millivolt (mV).
-      Defaults to 6.6 V
-    enum: [ 6600, 7000, 7500, 8000 ]
-
-  active-semi,precondition-timeout:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
-      Specifies the charger's PRECONDITION safety timer setting value in minutes.
-      If 0, it means to disable this timer.
-      Defaults to 40 minutes.
-    enum: [ 0, 40, 60, 80 ]
-
-  active-semi,total-timeout:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
-      Specifies the charger's total safety timer setting value in hours;
-      If 0, it means to disable this timer;
-      Defaults to 3 hours.
-    enum: [ 0, 3, 4, 5 ]
-
-required:
-  - compatible
-  - interrupts
-  - active-semi,chglev-gpios
-  - active-semi,lbo-gpios
-
-additionalProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/gpio/gpio.h>
-    #include <dt-bindings/interrupt-controller/irq.h>
-    pmic {
-      charger {
-        compatible = "active-semi,act8945a-charger";
-        interrupt-parent = <&pioA>;
-        interrupts = <45 IRQ_TYPE_LEVEL_LOW>;
-        active-semi,chglev-gpios = <&pioA 12 GPIO_ACTIVE_HIGH>;
-        active-semi,lbo-gpios = <&pioA 72 GPIO_ACTIVE_LOW>;
-        active-semi,input-voltage-threshold-microvolt = <6600>;
-        active-semi,precondition-timeout = <40>;
-        active-semi,total-timeout = <3>;
-      };
-    };
diff --git a/Documentation/devicetree/bindings/regulator/active-semi,act8945a.yaml b/Documentation/devicetree/bindings/regulator/active-semi,act8945a.yaml
index bdf3f7d34ef5..a8d579844dc7 100644
--- a/Documentation/devicetree/bindings/regulator/active-semi,act8945a.yaml
+++ b/Documentation/devicetree/bindings/regulator/active-semi,act8945a.yaml
@@ -91,28 +91,41 @@ properties:
         maxItems: 1
 
       active-semi,chglev-gpios:
-        description: CGHLEV GPIO
+        description: charge current level GPIO
         maxItems: 1
 
       active-semi,lbo-gpios:
-        description: LBO GPIO
+        description: low battery voltage detect GPIO
         maxItems: 1
 
       active-semi,input-voltage-threshold-microvolt:
-        description: Input voltage threshold
-        maxItems: 1
+        description:
+          Specifies the charger's input over-voltage threshold value. Despite
+          the name, specified values are in millivolt (mV).
+        enum: [ 6600, 7000, 7500, 8000 ]
+        default: 6600
 
       active-semi,precondition-timeout:
-        description: Precondition timeout
+        description:
+          Specifies the charger's PRECONDITION safety timer setting value in
+          minutes. If 0, it means to disable this timer.
+        enum: [ 0, 40, 60, 80 ]
+        default: 40
         $ref: /schemas/types.yaml#/definitions/uint32
 
       active-semi,total-timeout:
-        description: Total timeout
+        description:
+          Specifies the charger's total safety timer setting value in hours; If
+          0, it means to disable this timer;
+        enum: [ 0, 3, 4, 5 ]
+        default: 3
         $ref: /schemas/types.yaml#/definitions/uint32
 
     required:
       - compatible
       - interrupts
+      - active-semi,chglev-gpios
+      - active-semi,lbo-gpios
 
 additionalProperties: false
 
-- 
2.47.2


