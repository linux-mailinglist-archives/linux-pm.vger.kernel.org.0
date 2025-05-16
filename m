Return-Path: <linux-pm+bounces-27241-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC11ABA337
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 20:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6F187AC384
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 18:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC1827A47E;
	Fri, 16 May 2025 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="YTZMSVx7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB482E628;
	Fri, 16 May 2025 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421601; cv=none; b=HxhByyQVHpNbovGgaK6HnPSOhRv0AtOoV0dKMT1sWPFoI/gZPLhbo/mxdEVswZCcDfNLUKtVXRBotQVdF4ILLupjS8ohAXO6cyQYIYGuOAOyd1Mc5EZ/eAhe0zqR0T0xueQaM8MC8vUxoOgZjP/NKunemnQW1yY4tqHE+9InjdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421601; c=relaxed/simple;
	bh=auORJAMqkW2h97zukNJ43gKm0zDET/Sz9RCe8inQFbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0MtREk+kxMvN1/NGYGql2Iw4i8GI5HqNqTCah51/KMIbC/7lPD8MFMHjqkSrvRftSG5ocLTyqvxxgffqRU2/fZXGFGyDIBp/TjCC+GjEg8IzX9X62V5qL4Y3uzH3CpFGVHwHNrDmzOEwxCAWX8EWvHYvCN4ay/tauo97ptH8jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=YTZMSVx7; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id DC38F9C905E;
	Fri, 16 May 2025 14:53:17 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 2HgMfIKfwhng; Fri, 16 May 2025 14:53:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5128C9C9065;
	Fri, 16 May 2025 14:53:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 5128C9C9065
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1747421597; bh=Rms8zTfvA6EKXoU5BydiP3qdBBh9CEpPYmc6CeTUcmo=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=YTZMSVx7YT0vIcke0p4GYUJFxMX4K7DfXYJXgGpPu0+1p6AJHgWpN4R2WonPjvevu
	 EJsHufWneODd12r6BadVnwhQSKvcDWQumipRXYm1Ep6kmf7UTTyAqxYK6h86aR7SKo
	 fTfVUpYOBSseDSEmIrL0OzkqOOMb9yC4deMG8TebttKGtfxc0Ig1nCg/JCVahXeKkG
	 n4/yjMPOk3Zn8ovIONHg+JvVqKtpxGeQ9fOkI1JarroGXNmA1hFuEvQk7NXTB1VANH
	 fvj/el7YAT6GS8yNFICyDQDMMZo6CfQghN0JvW0fT/Q0WqGkh6BdyO3bHPf5DD5EKO
	 gaZgPCDxs0Aqg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id JDOYzqqA9BTJ; Fri, 16 May 2025 14:53:17 -0400 (EDT)
Received: from fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 2BB9C9C905E;
	Fri, 16 May 2025 14:53:17 -0400 (EDT)
Date: Fri, 16 May 2025 14:53:16 -0400
From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Robin Gong <yibin.gong@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-imx@nxp.com, inux-input@vger.kernel.org,
	Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>,
	Robin Gong <b38343@freescale.com>,
	Enric Balletbo Serra <eballetbo@gmail.com>
Subject: [PATCH v2 4/9] dt-bindings: mfd: add pf1550
Message-ID: <8be1626f970c9fab8b50ae9ad45e0ddd88fa36bf.1747409892.git.samuel.kayode@savoirfairelinux.com>
References: <cover.1747409892.git.samuel.kayode@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747409892.git.samuel.kayode@savoirfairelinux.com>

Add a DT binding document for pf1550 PMIC. This describes the core mfd
device.

Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
 .../devicetree/bindings/mfd/pf1550.yaml       | 122 ++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/pf1550.yaml

diff --git a/Documentation/devicetree/bindings/mfd/pf1550.yaml b/Documentation/devicetree/bindings/mfd/pf1550.yaml
new file mode 100644
index 000000000000..461bc13513eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/pf1550.yaml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/pf1550.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PF1550 low power PMIC from NXP.
+
+maintainers:
+  - Samuel Kayode <samuel.kayode@savoirfairelinux.com>
+
+description: |
+  PF1550 is a low power PMIC providing battery charging and power supply for
+  low power IoT and wearable applications.
+
+  For device-tree bindings of other sub-modules (regulator, power supply and
+  onkey) refer to the binding documents under the respective sub-system
+  directories.
+
+properties:
+  compatible:
+    const: fsl,pf1550
+
+  reg:
+    description:
+      I2C device address.
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  regulators:
+    $ref: /schemas/regulator/pf1550.yaml
+
+  charger:
+    $ref: /schemas/power/supply/pf1550_charger.yaml
+
+  onkey:
+    $ref: /schemas/input/pf1550_onkey.yaml
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
+
+            onkey {
+                compatible = "fsl,pf1550-onkey";
+                linux,keycodes = <KEY_POWER>;
+            };
+
+            charger {
+                compatible = "fsl,pf1550-charger";
+                
+                fsl,min-system-microvolt = <3700000>;
+                fsl,thermal-regulation = <75>;
+            };
+
+            regulators {
+                compatible = "fsl,pf1550-regulator";
+ 
+                sw1_reg: SW1 {
+                    regulator-name = "SW1";
+                    regulator-min-microvolt = <600000>;
+                    regulator-max-microvolt = <1387500>;
+                    regulator-always-on;
+                    regulator-ramp-delay = <6250>;
+                };
+
+                sw2_reg: SW2 {
+                    regulator-name = "SW2";
+                    regulator-min-microvolt = <600000>;
+                    regulator-max-microvolt = <1387500>;
+                    regulator-always-on;
+                };
+
+                sw3_reg: SW3 {
+                    regulator-name = "SW3";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-always-on;
+                };
+
+                vldo1_reg: LDO1 {
+                    regulator-name = "LDO1";
+                    regulator-min-microvolt = <750000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-always-on;
+                };
+
+                vldo2_reg: LDO2 {
+                    regulator-name = "LDO2";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-always-on;
+                };
+
+                vldo3_reg: LDO3 {
+                    regulator-name = "LDO3";
+                    regulator-min-microvolt = <750000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-always-on;
+                };
+            };
+        };
+    };
-- 
2.49.0


