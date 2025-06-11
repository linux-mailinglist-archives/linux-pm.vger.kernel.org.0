Return-Path: <linux-pm+bounces-28501-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EB7AD5FA8
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 22:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481531BC2A7F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 20:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFBF29B772;
	Wed, 11 Jun 2025 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWa8eF/j"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4CA227EBE;
	Wed, 11 Jun 2025 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749672180; cv=none; b=j3D576HewaLyqekAPA2RVO5jZ0L2IwuG3VLgDiZZPUDQuLC6azvi4oHT2m1ESCsBLEKvCwHXnOKeNrH0tyuxaHnvhxVpYnNDh6OsFFUEevjgdzvB7+0j0alU8eL/EgOfZU1Y6d4YJIgrz1ZEpXm1bYAepd+ULC30ONDdqaSnSmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749672180; c=relaxed/simple;
	bh=4WhOw5Pc8bV38NNBKDq+M7SXVLk0DorgEecTG6vPvq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yk1XczXru3cOmcdBuwn688KcR5SN0pLsZnk/02d3o5h06n+jZSirpAtMmGhE2VzhTQzFQNCe6e1wXCQ7x9Phu5l8pLamfsvu2LxCh20cpFZJsRjYR62/7NFtQi1s/inNTvMrIy2rn/XiawMqS/REc63cpXG5i6lEs96DPpjgfPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWa8eF/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D52FDC4CEEF;
	Wed, 11 Jun 2025 20:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749672179;
	bh=4WhOw5Pc8bV38NNBKDq+M7SXVLk0DorgEecTG6vPvq8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TWa8eF/j7uXBdosT4cih096pye2zy2Mkw2aMZNWUR3EygIVueQGJPddTWQuWEF1JV
	 C6Vh8sfJUbKzZ7+hTBHjGiuUXbUmBQBIh5EpX93Sj+cLSBgSQdbupalxFHoKLrkFli
	 lHTEFK1y0UWHHlVRDzEV8O++PZiSZqm3AC3gFk3Q6T/sjB+dj0eGV2ip6CTgWg2xzU
	 CwJk62YPDlv1ORvtj8xKtOY/ODJISmRVyvtjKG/6gyP/52y9Ii+aMhd1yRsIdr04Dx
	 7/zh/JnL/MmHp8bb/VHHEytPgHbeV3MPkkMQJauYx+gyLJ0cYfPXgGzAe1ThThwOV+
	 HXlY1CjMgrc9g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD38CC71136;
	Wed, 11 Jun 2025 20:02:59 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Date: Wed, 11 Jun 2025 16:02:58 -0400
Subject: [PATCH v6 1/6] dt-bindings: mfd: add pf1550
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-pf1550-v6-1-34f2ddfe045e@savoirfairelinux.com>
References: <20250611-pf1550-v6-0-34f2ddfe045e@savoirfairelinux.com>
In-Reply-To: <20250611-pf1550-v6-0-34f2ddfe045e@savoirfairelinux.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>, Frank Li <Frank.li@nxp.com>
Cc: imx@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>, 
 Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>, 
 Robin Gong <yibin.gong@nxp.com>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Samuel Kayode <samuel.kayode@savoirfairelinux.com>, 
 Abel Vesa <abelvesa@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749672178; l=5930;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=r8SVeBRmGib5X/fCH5StS6pFWPmPVyMn+NWDHww3thQ=;
 b=IXqyCMhFAAW/pQ39s/bDSawi0xBgOLz8FsMUR1jDj/1YWUBi4nlx2PZW3dVPdiXunkoGUs1fL
 kID1uq/9CQ+D1V0gxVGUipH/Iox/vMhDw3mElIC+Nkotjh2PcvLMPT7
X-Developer-Key: i=samuel.kayode@savoirfairelinux.com; a=ed25519;
 pk=TPSQGQ5kywnnPyGs0EQqLajLFbdDu17ahXz8/gxMfio=
X-Endpoint-Received: by B4 Relay for
 samuel.kayode@savoirfairelinux.com/20250527 with auth_id=412
X-Original-From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
Reply-To: samuel.kayode@savoirfairelinux.com

From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>

Add a DT binding document for pf1550 PMIC. This describes the core mfd
device along with its children: regulators, charger and onkey.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
v5:
 - Address Krzystof's feedback:
   - Drop monitored battery ref already included in power supply schema
   - Move `additionalProperties` close to `type` for regulator
   - Drop unneccessary |
   - Change `additionalProperties` to `unevaluatedProperties` for the
     PMIC
v4:
 - Address Krzystof's feedback:
   - Filename changed to nxp,pf1550.yaml
   - Replace Freescale with NXP
   - Define include before battery-cell
   - Drop operating-range-celsius in example since
     nxp,thermal-regulation-celsisus already exists
 - Not sure if there is similar binding to thermal-regulation...
   for regulating temperature on thermal-zones? @Sebastian and @Krzysztof
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
 .../devicetree/bindings/mfd/nxp,pf1550.yaml        | 137 +++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/nxp,pf1550.yaml b/Documentation/devicetree/bindings/mfd/nxp,pf1550.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..a0b412c3468a3d8972e5c129387c5417933c78e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/nxp,pf1550.yaml
@@ -0,0 +1,137 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/nxp,pf1550.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP PF1550 Power Management IC
+
+maintainers:
+  - Samuel Kayode <samuel.kayode@savoirfairelinux.com>
+
+description:
+  PF1550 PMIC provides battery charging and power supply for low power IoT and
+  wearable applications. This device consists of an i2c controlled MFD that
+  includes regulators, battery charging and an onkey/power button.
+
+$ref: /schemas/power/supply/power-supply.yaml
+
+properties:
+  compatible:
+    const: nxp,pf1550
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
+    additionalProperties: false
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
+  monitored-battery:
+    description: |
+      A phandle to a monitored battery node that contains a valid value
+      for:
+      constant-charge-voltage-max-microvolt.
+
+  nxp,thermal-regulation-celsius:
+    description:
+      Temperature threshold for thermal regulation of charger in celsius.
+    enum: [ 60, 75, 90, 105 ]
+
+  nxp,min-system-microvolt:
+    description:
+      System specific lower limit voltage.
+    enum: [ 3500000, 3700000, 4300000 ]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/input/linux-event-codes.h>
+
+    battery: battery-cell {
+        compatible = "simple-battery";
+        constant-charge-voltage-max-microvolt = <4400000>;
+    };
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@8 {
+            compatible = "nxp,pf1550";
+            reg = <0x8>;
+
+            interrupt-parent = <&gpio1>;
+            interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+            wakeup-source;
+            monitored-battery = <&battery>;
+            nxp,min-system-microvolt = <4300000>;
+            nxp,thermal-regulation-celsius = <75>;
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



