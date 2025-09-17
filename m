Return-Path: <linux-pm+bounces-34889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CB8B80C57
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 17:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670BE3AD57B
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 15:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475492F548A;
	Wed, 17 Sep 2025 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmN/6o4f"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1503724C66F;
	Wed, 17 Sep 2025 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124470; cv=none; b=PPjiFHCDD5IYQGsL22cwuwXV89hK5dsHvo6cslmJmwo/O2rQ0MyeRsPWf0WTtlIaxppl+qR30WS7xi64wqGCXBMDkXi3wTv8EDveAHwS58PW2Dck4sZGjtf/EQVcPvqY5fvPb1sI9x7so0RdtAdlx8czaYxv9788mNumEwNjk1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124470; c=relaxed/simple;
	bh=13CZLd408DtJao10ZbzCPQLMH8HR9OiqLz1e8Xxwi0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R/ag6V9mAQw2W27W2ktQMlQhpiXx1PzGg+lVl20JBDmqsVLiI7Sj9BuNDxmatLM4fQw+L/dR2hsYKMMliyhrTKxcV7kVenfOL+yaYN3k1cfp0rinLbXffKEiC0Poxm2ZhFKwBfrjuquW5MMdoZcMhUe9C7iAVoYHA/m8dJSoteo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmN/6o4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1F68C4CEF9;
	Wed, 17 Sep 2025 15:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758124469;
	bh=13CZLd408DtJao10ZbzCPQLMH8HR9OiqLz1e8Xxwi0M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VmN/6o4fi4XKMSjwRv//lp6SeqMLKQX62pwoBZoIbnwH0GTVxUkgar7II+yW50hWV
	 iP/DtnmW2f4a3nGHTaBb6Eg529lqUnB4AHEE8bn+ATfVZtGIO3qTJuHel9Uvr0Wphu
	 ++dpmfegzQ9ZRqGivSWeiQcB9amlxfzCfBRQdoUhbdtAkZ+Ej6KSwjN2egskN7AfvA
	 KJNMJorqxKoSvQ+QbFMwX+wP69nXh94bjgbGcZKV0csWoq4SYZUqx2QNHhVG1oT39O
	 R5T0LCJG5mYKIEijhsaMagIFyAkHQYEb/+z1tuVj69M5bqQXgVpkQ6Ue9patVMTio5
	 xajr66EleROAA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9243ECAC5A0;
	Wed, 17 Sep 2025 15:54:29 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Date: Wed, 17 Sep 2025 11:52:34 -0400
Subject: [PATCH v11 1/6] dt-bindings: mfd: add pf1550
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-pf1550-v11-1-e0649822fcc9@savoirfairelinux.com>
References: <20250917-pf1550-v11-0-e0649822fcc9@savoirfairelinux.com>
In-Reply-To: <20250917-pf1550-v11-0-e0649822fcc9@savoirfairelinux.com>
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
 Sean Nyekjaer <sean@geanix.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Samuel Kayode <samuel.kayode@savoirfairelinux.com>, 
 Abel Vesa <abelvesa@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758124466; l=6977;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=5vcRFsgia6+WVfe1ZxXoWYFkK+ExpGtuoyNGz1NkdYs=;
 b=QIqk4Zy6ohPikS/0T8CR0uwbEfKXeqUKMYazN+peb6m7kXknmsIG72v8zusTuVq0jSoWx90c6
 s9QxHunO37iBNVy651OzTz4OtcRs8qwvm1tF5oAjo1jDgsfkxVB0UWq
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
Tested-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
v10:
 - Add regulator-state-mem to examples
v9:
 - Add regulator suspend bindings in example
 - Add binding for disabling onkey power down
 - Fix thermal regulation temperature range
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
 .../devicetree/bindings/mfd/nxp,pf1550.yaml        | 161 +++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/nxp,pf1550.yaml b/Documentation/devicetree/bindings/mfd/nxp,pf1550.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..e50dc44252c60063463295c5ec3e3c90d1592ec2
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/nxp,pf1550.yaml
@@ -0,0 +1,161 @@
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
+    enum: [ 80, 95, 110, 125 ]
+
+  nxp,min-system-microvolt:
+    description:
+      System specific lower limit voltage.
+    enum: [ 3500000, 3700000, 4300000 ]
+
+  nxp,disable-key-power:
+    type: boolean
+    description:
+      Disable power-down using a long key-press. The onkey driver will remove
+      support for the KEY_POWER key press when triggered using a long press of
+      the onkey.
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
+            nxp,thermal-regulation-celsius = <80>;
+
+            regulators {
+                sw1_reg: sw1 {
+                    regulator-name = "sw1";
+                    regulator-min-microvolt = <600000>;
+                    regulator-max-microvolt = <1387500>;
+                    regulator-always-on;
+                    regulator-ramp-delay = <6250>;
+
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                        regulator-suspend-min-microvolt = <1270000>;
+                    };
+                };
+
+                sw2_reg: sw2 {
+                    regulator-name = "sw2";
+                    regulator-min-microvolt = <600000>;
+                    regulator-max-microvolt = <1387500>;
+                    regulator-always-on;
+
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                    };
+                };
+
+                sw3_reg: sw3 {
+                    regulator-name = "sw3";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-always-on;
+
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                    };
+                };
+
+                vldo1_reg: ldo1 {
+                    regulator-name = "ldo1";
+                    regulator-min-microvolt = <750000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-always-on;
+
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
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
2.50.1



