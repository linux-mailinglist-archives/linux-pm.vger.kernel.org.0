Return-Path: <linux-pm+bounces-32925-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B18C4B32539
	for <lists+linux-pm@lfdr.de>; Sat, 23 Aug 2025 00:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CF5624642
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 22:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44AA2C028A;
	Fri, 22 Aug 2025 22:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Td2gekp7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7732B293B73;
	Fri, 22 Aug 2025 22:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755903438; cv=none; b=JcF1iHPOkTTUaWPMpXSBDmnDWN8gC9KypEGA90lzg91zZYLT0EJ7tyjgZJLRNOjvx52K7XVzWXlB/781fu10z2yifpn/uhVdl1eGqn0dSf5wTSDctLoGgtOQfz3Xeu+E/1CXYc34CSyFs3iCNFAhbAMEf1cQQ12AlKfqaojuWbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755903438; c=relaxed/simple;
	bh=MllpE7EOiK57XkYC3Q0CVPiFqSbds9CUyBPa1yFXM5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rXi9QeWNpsvDW/h6++/GSOeMIA/2YK0MKWa5flOPt/FpdGIikvxPrjxOkh3we3hikYznJiZe2HlllMUUCbZt6LurhLXBZePxQzVaIwiFlrFpj6j9mIdGO5p9XhDh66NxECEiiKW+D8X9ZcxpEmM+TRshFKzhnaVuc7NA/UPbxNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Td2gekp7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1160C4CEED;
	Fri, 22 Aug 2025 22:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755903436;
	bh=MllpE7EOiK57XkYC3Q0CVPiFqSbds9CUyBPa1yFXM5g=;
	h=From:To:Cc:Subject:Date:From;
	b=Td2gekp76Ho02tvvrbx7Vlo1iciPPdsxDPPV7wU6Ylea/HMKF3IEqkR2FA02F/KWA
	 0wtRgOKeWe2QuLErwPDVNpfU4yu3RXEc/Pgpj6pNu6smrLAtxUrTfTaDUPvgI07EZN
	 Uug0+oe/THvd0u3wEwG8kmHkwm/OohZy5BwUvvwZqmw3oxgfltS7lT2sLCQmMWmNO7
	 qgfSftAoDZLhP99vGRM0ANqLC71PgtT3uTxSKtjJFSfJnO41BJdIrcC7P1xhCwCjly
	 8nlXKf2KAw0/xfp0UEUFOwclvHFqYsscv3SAMc3yl/lH2mxeM1ilMQgNO5Fh9eH6XY
	 +dI9xqob0svfg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2] dt-binding: thermal: Convert marvell,armada-ap806-thermal to DT schema
Date: Fri, 22 Aug 2025 17:57:00 -0500
Message-ID: <20250822225701.766947-1-robh@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Marvell Armada AP80x/CP110 thermal binding to schema. It is
a straight forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
v2:
 - Mention the SEI connection
---
 .../arm/marvell/ap80x-system-controller.txt   | 39 ----------------
 .../arm/marvell/cp110-system-controller.txt   | 43 -----------------
 .../thermal/marvell,armada-ap806-thermal.yaml | 46 +++++++++++++++++++
 3 files changed, 46 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/marvell,armada-ap806-thermal.yaml

diff --git a/Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt
index c83245065d44..72de11bd2ef0 100644
--- a/Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt
@@ -115,45 +115,6 @@ ap_syscon: system-controller@6f4000 {
 SYSTEM CONTROLLER 1
 ===================
 
-Thermal:
---------
-
-For common binding part and usage, refer to
-Documentation/devicetree/bindings/thermal/thermal*.yaml
-
-The thermal IP can probe the temperature all around the processor. It
-may feature several channels, each of them wired to one sensor.
-
-It is possible to setup an overheat interrupt by giving at least one
-critical point to any subnode of the thermal-zone node.
-
-Required properties:
-- compatible: must be one of:
-  * marvell,armada-ap806-thermal
-- reg: register range associated with the thermal functions.
-
-Optional properties:
-- interrupts: overheat interrupt handle. Should point to line 18 of the
-  SEI irqchip. See interrupt-controller/interrupts.txt
-- #thermal-sensor-cells: shall be <1> when thermal-zones subnodes refer
-  to this IP and represents the channel ID. There is one sensor per
-  channel. O refers to the thermal IP internal channel, while positive
-  IDs refer to each CPU.
-
-Example:
-ap_syscon1: system-controller@6f8000 {
-	compatible = "syscon", "simple-mfd";
-	reg = <0x6f8000 0x1000>;
-
-	ap_thermal: thermal-sensor@80 {
-		compatible = "marvell,armada-ap806-thermal";
-		reg = <0x80 0x10>;
-		interrupt-parent = <&sei>;
-		interrupts = <18>;
-		#thermal-sensor-cells = <1>;
-	};
-};
-
 Cluster clocks:
 ---------------
 
diff --git a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
index 9d5d70c98058..54ff9f218328 100644
--- a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
@@ -189,46 +189,3 @@ CP110_LABEL(syscon0): system-controller@440000 {
 	};
 
 };
-
-SYSTEM CONTROLLER 1
-===================
-
-Thermal:
---------
-
-The thermal IP can probe the temperature all around the processor. It
-may feature several channels, each of them wired to one sensor.
-
-It is possible to setup an overheat interrupt by giving at least one
-critical point to any subnode of the thermal-zone node.
-
-For common binding part and usage, refer to
-Documentation/devicetree/bindings/thermal/thermal*.yaml
-
-Required properties:
-- compatible: must be one of:
-  * marvell,armada-cp110-thermal
-- reg: register range associated with the thermal functions.
-
-Optional properties:
-- interrupts-extended: overheat interrupt handle. Should point to
-  a line of the ICU-SEI irqchip (116 is what is usually used by the
-  firmware). The ICU-SEI will redirect towards interrupt line #37 of the
-  AP SEI which is shared across all CPs.
-  See interrupt-controller/interrupts.txt
-- #thermal-sensor-cells: shall be <1> when thermal-zones subnodes refer
-  to this IP and represents the channel ID. There is one sensor per
-  channel. O refers to the thermal IP internal channel.
-
-Example:
-CP110_LABEL(syscon1): system-controller@6f8000 {
-	compatible = "syscon", "simple-mfd";
-	reg = <0x6f8000 0x1000>;
-
-	CP110_LABEL(thermal): thermal-sensor@70 {
-		compatible = "marvell,armada-cp110-thermal";
-		reg = <0x70 0x10>;
-		interrupts-extended = <&CP110_LABEL(icu_sei) 116 IRQ_TYPE_LEVEL_HIGH>;
-		#thermal-sensor-cells = <1>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/thermal/marvell,armada-ap806-thermal.yaml b/Documentation/devicetree/bindings/thermal/marvell,armada-ap806-thermal.yaml
new file mode 100644
index 000000000000..2c370317a40e
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/marvell,armada-ap806-thermal.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/marvell,armada-ap806-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Armada AP80x/CP110 thermal management
+
+maintainers:
+  - Miquel Raynal <miquel.raynal@bootlin.com>
+
+properties:
+  compatible:
+    enum:
+      - marvell,armada-ap806-thermal
+      - marvell,armada-ap807-thermal
+      - marvell,armada-cp110-thermal
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Overheat interrupt. The interrupt is connected thru a System Error
+      Interrupt (SEI) controller.
+    maxItems: 1
+
+  '#thermal-sensor-cells':
+    description: Cell represents the channel ID. There is one sensor per
+      channel. O refers to the thermal IP internal channel.
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    thermal-sensor@80 {
+        compatible = "marvell,armada-ap806-thermal";
+        reg = <0x80 0x10>;
+        interrupts = <18>;
+        #thermal-sensor-cells = <1>;
+    };
-- 
2.50.1


