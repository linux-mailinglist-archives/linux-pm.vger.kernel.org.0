Return-Path: <linux-pm+bounces-27701-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46274AC5D0B
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 00:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9683B188242D
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 22:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DCA21882F;
	Tue, 27 May 2025 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEOIg22w"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F682147F2;
	Tue, 27 May 2025 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748384785; cv=none; b=U2Yd1nP/xjUEA1OIX48Ywi5iUs9bhHywkh9DbWEO4GFWkyluGVReoU5ii6sDIR0WBLKqYHrZrZYubcB7dbdB5TBzVfhxfdcMaezDgGXtgDjdGGv5rmjxhuURxvE7F0wANJMUVsH/VOcsTlwPaYDII+VpUS9I0uwlzuF93fq+y64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748384785; c=relaxed/simple;
	bh=suDOGLgCQjgSfySaFDzmylmYIE5Fxa9bYp0izxSUg9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZDnIEddUmKkZgIC8cPjsNOSI2JZYCt0qgiRG+u/7hFwtxQTspaZs2pS0zfVv0lkqCQIudasK3OrVX1jLzzWPNjLwa7fvcS3Pmd1rAv6p5ZscNJhBf2+sxX4EA2QUcvQUuDDPmooTR5GGApIFyE9NBENT6iMFAH4aWqvdOPVonZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEOIg22w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B97ADC4CEED;
	Tue, 27 May 2025 22:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748384784;
	bh=suDOGLgCQjgSfySaFDzmylmYIE5Fxa9bYp0izxSUg9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AEOIg22wV6ZaA+FG318B18VokFqetzPI1Tqq+l0yJRqT1A6ZjntqY7wwmGnyG3Ie2
	 bYJEdhJRr2jlsX+KqBz8qSBLlMSEq7f1Aqafx9Z+szd4AxWIRPeTtR085xcczlOSmA
	 dfna7INgUZs7+GO61FvhoSuMDxEY9RQwK3my02N9Py6NA2xmaNfRGVbM01IIM8jqjL
	 Of/Ogytgh7+lWC7rGKouO20ffS9ieUgRfWvuS9f5j2meZw2jYId2EYpGG5RrwN2kyw
	 54HBPr8BS62r1bcWft4BDZr0gEIWtmdYFBh0b475Ide3E/Fx+FYN9pYT6fGE/14ztF
	 zKOmoo1pj6LqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3744C54ED1;
	Tue, 27 May 2025 22:26:24 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Date: Tue, 27 May 2025 18:25:33 -0400
Subject: [PATCH v3 1/6] dt-bindings: mfd: add pf1550
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-pf1550-v3-1-45f69453cd51@savoirfairelinux.com>
References: <20250527-pf1550-v3-0-45f69453cd51@savoirfairelinux.com>
In-Reply-To: <20250527-pf1550-v3-0-45f69453cd51@savoirfairelinux.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
 Samuel Kayode <samuel.kayode@savoirfairelinux.com>, eballetbo@gmail.com, 
 abelvesa@linux.com, b38343@freescale.com, yibin.gong@nxp.com, 
 Abel Vesa <abelvesa@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748384783; l=5295;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=qDwJDqukdPYnizhVluFWp/IpAUKqb922WJOnoe5Cexw=;
 b=zfPchfRbG+eoztgNTypBqE7grUB69gpefvyKftSxdqq+zyp2eNCrgyp/pCXFsm+bdUXjRM3Ee
 ihAcFx1XPcIA0zYX9ynWRoTvkaF4RaeHs5bWzeGOBinKUdNQxnf8kk3
X-Developer-Key: i=samuel.kayode@savoirfairelinux.com; a=ed25519;
 pk=TPSQGQ5kywnnPyGs0EQqLajLFbdDu17ahXz8/gxMfio=
X-Endpoint-Received: by B4 Relay for
 samuel.kayode@savoirfairelinux.com/20250527 with auth_id=412
X-Original-From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
Reply-To: samuel.kayode@savoirfairelinux.com

From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>

Add a DT binding document for pf1550 PMIC. This describes the core mfd
device along with its children: regulators, charger and onkey.

Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
v3:
 - Address Krzysztof's feedback:
   - Fold charger and onkey objects
   - Drop compatible for sub-devices: onkey, charger and regulator.
   - Drop constant voltage property already included in
     monitored-battery
   - Fix whitespace warnings
   - Fix license
v2:
 - Add yamls for the PMIC and the sub-devices
---
 Documentation/devicetree/bindings/mfd/pf1550.yaml | 139 ++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/pf1550.yaml b/Documentation/devicetree/bindings/mfd/pf1550.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..7f22cb91eb5542c8aa616525ed1e78efa2a863d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/pf1550.yaml
@@ -0,0 +1,139 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/pf1550.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP PF1550 Power Management IC
+
+maintainers:
+  - Samuel Kayode <samuel.kayode@savoirfairelinux.com>
+
+description: |
+  PF1550 PMIC provides battery charging and power supply for low power IoT and
+  wearable applications. This device consists of an i2c controlled MFD that
+  includes regulators, battery charging and an onkey/power button.
+
+$ref: /schemas/power/supply/power-supply.yaml
+
+properties:
+  compatible:
+    const: fsl,pf1550
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  wakeup-source: true
+
+  regulators:
+    type: object
+
+    patternProperties:
+      "^(ldo[1-3]|sw[1-3]|vrefddr)$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml
+        description:
+          regulator configuration for ldo1-3, buck converters(sw1-3)
+          and DDR termination reference voltage (vrefddr)
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+  monitored-battery:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      A phandle to a monitored battery node that contains a valid value
+      for:
+      constant-charge-voltage-max-microvolt.
+
+  fsl,thermal-regulation:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Temperature threshold for thermal regulation of charger in celsius.
+    enum: [ 60, 75, 90, 105 ]
+
+  fsl,min-system-microvolt:
+    description:
+      System specific lower limit voltage.
+    enum: [ 3500000, 3700000, 4300000 ]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    battery: battery-cell {
+        compatible = "simple-battery";
+        constant-charge-voltage-max-microvolt = <4400000>;
+        operating-range-celsius = <0 75>;
+    };
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/input/linux-event-codes.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@8 {
+            compatible = "fsl,pf1550";
+            reg = <0x8>;
+
+            interrupt-parent = <&gpio1>;
+            interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+            wakeup-source;
+            monitored-battery = <&battery>;
+            fsl,min-system-microvolt = <4300000>;
+            fsl,thermal-regulation = <75>;
+
+            regulators {
+                sw1_reg: sw1 {
+                    regulator-name = "sw1";
+                    regulator-min-microvolt = <600000>;
+                    regulator-max-microvolt = <1387500>;
+                    regulator-always-on;
+                    regulator-ramp-delay = <6250>;
+                };
+
+                sw2_reg: sw2 {
+                    regulator-name = "sw2";
+                    regulator-min-microvolt = <600000>;
+                    regulator-max-microvolt = <1387500>;
+                    regulator-always-on;
+                };
+
+                sw3_reg: sw3 {
+                    regulator-name = "sw3";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-always-on;
+                };
+
+                vldo1_reg: ldo1 {
+                    regulator-name = "ldo1";
+                    regulator-min-microvolt = <750000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-always-on;
+                };
+
+                vldo2_reg: ldo2 {
+                    regulator-name = "ldo2";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-always-on;
+                };
+
+                vldo3_reg: ldo3 {
+                    regulator-name = "ldo3";
+                    regulator-min-microvolt = <750000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-always-on;
+                };
+            };
+        };
+    };

-- 
2.49.0



