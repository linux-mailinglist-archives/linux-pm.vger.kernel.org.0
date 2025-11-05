Return-Path: <linux-pm+bounces-37408-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5B7C34473
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 08:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E86218C73BB
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 07:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508832D4803;
	Wed,  5 Nov 2025 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PK5u9HXR"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E912D47E6
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 07:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762328239; cv=none; b=OBD1fki19Xk9FWDC5uZFP86hSzEXUoTZSM9+RKt/BLhke+ZsoXxyWgYr+Pr9WONF6loitzqtNd0FCFTEZAQnKxCta1jHqAXVTT/HO3eV2Ol0AG3BH9QbD6ELlkgokYvvAbnooVHYRfQ4/QOWCkXNcyqLjVp2llsgLALBg5Wu/Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762328239; c=relaxed/simple;
	bh=Ir6icXKHChmYJKT69h7OUA/c5ptfzVqx4rfjlo0f+Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0D5qGOJKdo2CpYChEZuGdfuCua0Eb0WE8L3Oq0i3kDeNEEdUmgH27TCMozTMenQKVoKKtd/YrqRqWwUDZ1X551LKOjxGwnd/xKe9HgS28mufWsz/jq3LGaUy95pmBvpDeQ+ZMyFf4PmKCfsdmlcKswNFIVBdhbGg/YPg26OKMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PK5u9HXR; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 5 Nov 2025 09:37:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762328235; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=QSIIzdnYCdyK0MAnL19al5r4b7aXenWgWJoPVDira6Y=;
	b=PK5u9HXR9rXZQuKHqmkVhXmAU9Sl0z1ytxhUcCpsCTP4PIpXAerB+bjgmEXa1RFoEBMaaa
	/zwNVWBdLXBUau6aUt00ueOxJCT5ej2GFF6w5IFJZlDQB4u1ToBkxbrvxGCKNpwZc2/uke
	9yMGgYBYb9OtL20JgAAKhqB2Ss8sxfA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matti Vaittinen <matti.vaittinen@linux.dev>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 05/16] dt-bindings: mfd: ROHM BD72720
Message-ID: <4c7ea0c83f4bb4af65439a9b8951d50ee705d22c.1762327887.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1762327887.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/vio6ize+M5XkPbu"
Content-Disposition: inline
In-Reply-To: <cover.1762327887.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--/vio6ize+M5XkPbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The ROHM BD72720 is a power management IC integrating regulators, GPIOs,
charger, LEDs, RTC and a clock gate.

Add dt-binding doc for ROHM BD72720.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 v2 =3D> v3:
 - Styling
 - Document all pin functions
 - use pattern-properties
 - re-use existing Rsense binding
 - correct the example

 RFCv1 =3D> v2:
 - Typofixes
---
 .../bindings/mfd/rohm,bd72720-pmic.yaml       | 273 ++++++++++++++++++
 1 file changed, 273 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic=
=2Eyaml

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml b=
/Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
new file mode 100644
index 000000000000..c9c7b90fc809
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
@@ -0,0 +1,273 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/rohm,bd72720-pmic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BD72720 Power Management Integrated Circuit
+
+maintainers:
+  - Matti Vaittinen <mazziesaccount@gmail.com>
+
+description:
+  BD72720 is a single-chip power management IC for battery-powered portable
+  devices. The BD72720 integrates 10 bucks and 11 LDOs, and a 3000 mA
+  switching charger. The IC also includes a Coulomb counter, a real-time
+  clock (RTC), GPIOs and a 32.768 kHz clock gate.
+
+# In addition to the properties found from the charger node, the ROHM BD72=
720
+# uses properties from a static battery node. Please see the:
+# Documentation/devicetree/bindings/power/supply/rohm,vdr-battery.yaml
+#
+# Following properties are used
+# when present:
+#
+# charge-full-design-microamp-hours: Battry capacity in mAh
+# voltage-max-design-microvolt:      Maximum voltage
+# voltage-min-design-microvolt:      Minimum voltage system is still opera=
ting.
+# degrade-cycle-microamp-hours:      Capacity lost due to aging at each fu=
ll
+#                                    charge cycle.
+# ocv-capacity-celsius:              Array of OCV table temperatures. 1/ta=
ble.
+# ocv-capacity-table-<N>:            Table of OCV voltage/SOC pairs. Corre=
sponds
+#                                    N.th temperature in ocv-capacity-cels=
ius
+#
+# ROHM specific properties:
+# rohm,voltage-vdr-thresh-microvolt: Threshold for starting the VDR correc=
tion
+# rohm,volt-drop-soc:                Table of capacity values matching the
+#                                    values in VDR tables.
+# rohm,volt-drop-high-temp-microvolt: VDR table for high temperature
+# rohm,volt-drop-normal-temp-microvolt: VDR table for normal temperature
+# rohm,volt-drop-low-temp-microvolt:  VDR table for low temperature
+# rohm,volt-drop-very-low-temp-microvolt: VDR table for very low temperatu=
re
+#
+# VDR tables are (usually) determined for a specific battery by ROHM.
+# The battery node would then be referred from the charger node:
+#
+# monitored-battery =3D <&battery>;
+
+properties:
+  compatible:
+    const: rohm,bd72720
+
+  reg:
+    description:
+      I2C slave address.
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+    description:
+      The first cell is the pin number and the second cell is used to spec=
ify
+      flags. See the gpio binding document for more information.
+
+  clocks:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 0
+
+  clock-output-names:
+    const: bd71828-32k-out
+
+  rohm,clkout-open-drain:
+    description: clk32kout mode. Set to 1 for "open-drain" or 0 for "cmos".
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 1
+
+  rohm,charger-sense-resistor-micro-ohms:
+    minimum: 10
+    maximum: 50
+    description:
+      BD72720 has a SAR ADC for measuring charging currents. External sense
+      resistor (RSENSE in data sheet) should be used. If some other but
+      30 mOhm resistor is used the resistance value should be given here in
+      micro Ohms.
+
+  regulators:
+    $ref: /schemas/regulator/rohm,bd77270-regulator.yaml
+    description:
+      List of child nodes that specify the regulators.
+
+  leds:
+    $ref: /schemas/leds/rohm,bd71828-leds.yaml
+
+  rohm,pin-fault_b:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      BD72720 has an OTP option to use fault_b-pin for different
+      purposes. Set this property accordingly. OTP options are
+      OTP0 - bi-directional FAULT_B or READY indicator depending on a
+      'sub option'
+      OTP1 - GPO
+      OTP2 - Power sequencer output.
+    enum:
+      - faultb
+      - readyind
+      - gpo
+      - pwrseq
+
+patternProperties:
+  "^rohm,pin-dvs[0-1]$":
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      BD72720 has 4 different OTP options to determine the use of dvs<X>-p=
ins.
+      OTP0 - regulator RUN state control.
+      OTP1 - GPI.
+      OTP2 - GPO.
+      OTP3 - Power sequencer output.
+      This property specifies the use of the pin.
+    enum:
+      - dvs-input
+      - gpi
+      - gpo
+      - pwrseq
+
+  "^rohm,pin-exten[0-1]$":
+    $ref: /schemas/types.yaml#/definitions/string
+    description: BD72720 has an OTP option to use exten0-pin for different
+      purposes. Set this property accordingly.
+      OTP0 - GPO
+      OTP1 - Power sequencer output.
+    enum:
+      - gpo
+      - pwrseq
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - "#clock-cells"
+  - regulators
+  - gpio-controller
+  - "#gpio-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/leds/common.h>
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+        pmic: pmic@4b {
+            compatible =3D "rohm,bd71828";
+            reg =3D <0x4b>;
+
+            interrupt-parent =3D <&gpio1>;
+            interrupts =3D <29 IRQ_TYPE_LEVEL_LOW>;
+
+            clocks =3D <&osc 0>;
+            #clock-cells =3D <0>;
+            clock-output-names =3D "bd71828-32k-out";
+
+            gpio-controller;
+            #gpio-cells =3D <2>;
+
+            rohm,pin-dvs0 =3D "gpi";
+            rohm,pin-dvs1 =3D "gpi";
+            rohm,pin-exten0 =3D "gpo";
+            rohm,pin-exten1 =3D "gpo";
+            rohm,pin-fault_b =3D "faultb";
+
+            rohm,charger-sense-resistor-micro-ohms =3D <10000>;
+
+            regulators {
+                buck1: BUCK1 {
+                    regulator-name =3D "buck1";
+                    regulator-min-microvolt =3D <500000>;
+                    regulator-max-microvolt =3D <2000000>;
+                    regulator-ramp-delay =3D <2500>;
+                };
+                buck2: BUCK2 {
+                    regulator-name =3D "buck2";
+                    regulator-min-microvolt =3D <500000>;
+                    regulator-max-microvolt =3D <2000000>;
+                    regulator-ramp-delay =3D <2500>;
+                };
+                buck3: BUCK3 {
+                    regulator-name =3D "buck3";
+                    regulator-min-microvolt =3D <1200000>;
+                    regulator-max-microvolt =3D <2000000>;
+                };
+                buck4: BUCK4 {
+                    regulator-name =3D "buck4";
+                    regulator-min-microvolt =3D <1000000>;
+                    regulator-max-microvolt =3D <1800000>;
+                };
+                buck5: BUCK5 {
+                    regulator-name =3D "buck5";
+                    regulator-min-microvolt =3D <2500000>;
+                    regulator-max-microvolt =3D <3300000>;
+                };
+                buck6: BUCK6 {
+                    regulator-name =3D "buck6";
+                    regulator-min-microvolt =3D <500000>;
+                    regulator-max-microvolt =3D <2000000>;
+                    regulator-ramp-delay =3D <2500>;
+                };
+                buck7: BUCK7 {
+                    regulator-name =3D "buck7";
+                    regulator-min-microvolt =3D <500000>;
+                    regulator-max-microvolt =3D <2000000>;
+                    regulator-ramp-delay =3D <2500>;
+                };
+                ldo1: LDO1 {
+                    regulator-name =3D "ldo1";
+                    regulator-min-microvolt =3D <800000>;
+                    regulator-max-microvolt =3D <3300000>;
+                };
+                ldo2: LDO2 {
+                    regulator-name =3D "ldo2";
+                    regulator-min-microvolt =3D <800000>;
+                    regulator-max-microvolt =3D <3300000>;
+                };
+                ldo3: LDO3 {
+                    regulator-name =3D "ldo3";
+                    regulator-min-microvolt =3D <800000>;
+                    regulator-max-microvolt =3D <3300000>;
+                };
+                ldo4: LDO4 {
+                    regulator-name =3D "ldo4";
+                    regulator-min-microvolt =3D <800000>;
+                    regulator-max-microvolt =3D <3300000>;
+                };
+                ldo5: LDO5 {
+                    regulator-name =3D "ldo5";
+                    regulator-min-microvolt =3D <800000>;
+                    regulator-max-microvolt =3D <3300000>;
+                };
+                ldo6: LDO6 {
+                    regulator-name =3D "ldo6";
+                    regulator-min-microvolt =3D <1800000>;
+                    regulator-max-microvolt =3D <1800000>;
+                };
+                ldo7_reg: LDO7 {
+                    regulator-name =3D "ldo7";
+                    regulator-min-microvolt =3D <800000>;
+                    regulator-max-microvolt =3D <3300000>;
+                };
+            };
+
+            leds {
+                compatible =3D "rohm,bd71828-leds";
+
+                led-1 {
+                    rohm,led-compatible =3D "bd71828-grnled";
+                    function =3D LED_FUNCTION_INDICATOR;
+                    color =3D <LED_COLOR_ID_GREEN>;
+                };
+                led-2 {
+                    rohm,led-compatible =3D "bd71828-ambled";
+                    function =3D LED_FUNCTION_CHARGING;
+                    color =3D <LED_COLOR_ID_AMBER>;
+                };
+            };
+        };
+    };
--=20
2.51.0


--/vio6ize+M5XkPbu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkK/qEACgkQeFA3/03a
ocVl2Af/dNJYItS0kWpb2l+6sMPkPtj2LrHapfImTT50lxc00X1X5yMmLxM+Nabc
OBhP1rkcsxMIYem4GyhNl2D8G34N+UgMnEzXOPCKIenuDZtHHfcbiLBo5kyQChMW
jK+ShEZdEjpY2BTQntNmdvz+4BJ81ckiS19cE/vTwhk/2ZlSzji752WtIV77ctlC
ZCFrWSTYA8hGJ7NGYxdCykJzTihv/1WXYNNcMsxUt1CAjclBIdCoDdgH6CCgL5nk
YqyoM8G/MKL28jtr20LXuIe7YdIhFNN1aslGiRQUKYigxvkk8aTSI3H8wWeBPXa+
1Z68IEqvEvkyUxFOlVbt4mYsa5wUvg==
=a5yI
-----END PGP SIGNATURE-----

--/vio6ize+M5XkPbu--

