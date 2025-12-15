Return-Path: <linux-pm+bounces-39562-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A97CBDFBA
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 14:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D0EE3019F9F
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 13:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778A72DEA95;
	Mon, 15 Dec 2025 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BJRtLISw"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4152D7D3A
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765804719; cv=none; b=EeQ/XtqRCSlx4m+QOUQ+RvNKfdR31Xg8P1+Ma+Xamw1ItuRnOC5Z7gVAWJME6hMLP6V58Mps4qevzao+Kb6Oe/gOlUfYtgP9UR8O6eV08D4zJlzOqUpD9PjFOYg4Wbv3dERXbtGMm/JvJrde/aRRX9v1puNVc/KR48x22BZCvmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765804719; c=relaxed/simple;
	bh=zh6U5/bzd48b8+HGXTpFZDqdW92yuEU40ShizBSy2z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q153WT/eYWCM/3DQo5u+l3ohmEJGObr9JlxabcJRyHERDmXVimazpcjtf+QvLt34nke6UNTBbG9B09H9LpZdRQafLIK2IlWoysZytDrQi7olaRWfcfGyDAhmHlwQYlcJAgPMUqS4GEAgf1+q06YkpQkW4arc+8eu2muV7uQB3Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BJRtLISw; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 15 Dec 2025 15:18:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765804714; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=/uNMPLFBkRM0QRVAa7ugNbnSqo9RGts9qBe5bCeypl8=;
	b=BJRtLISwDsae4YSZii0m4yQf3GlYLBWNm/XCT9x4RNJ9FgjS9OFJLQn/nfhNxCh6ojmutT
	FGHthoNAaWbTkyiF9gDJ8kit4UZKiXeTIjbMeH4/MxP7WcVtY6o0MjQCJZL6eeSs0ldR74
	RYUvaTWqWXJeM4Fji9k5C5gF5I/pXPY=
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
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH RESEND v6 05/17] dt-bindings: mfd: ROHM BD72720
Message-ID: <44cd4fcb2834ed613dd2d958cf4a4a34b3a316ab.1765804226.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1765804226.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="05Tmz+oRckxZrk3Z"
Content-Disposition: inline
In-Reply-To: <cover.1765804226.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--05Tmz+oRckxZrk3Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The ROHM BD72720 is a power management IC integrating regulators, GPIOs,
charger, LEDs, RTC and a clock gate.

Add dt-binding doc for ROHM BD72720.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

---
Revision history:
 v5 =3D>:
 - No changes

 v4 =3D> v5:
 - drop rohm, -prefix from vdr parameters
 - Link to battery.yaml, not to rohm,vdr-battry.yaml which was removed

 v3 =3D> v4:
 - Fix typo from the reference to regulator binding
 - Fix Rsense limits to micro Ohms
 - Fix compatible string in the example
 - Fix regulator node names (to lower-case) in the example
 - Add the missing regulator nodes to the example

 v2 =3D> v3:
 - Styling
 - Document all pin functions
 - use pattern-properties
 - re-use existing Rsense binding
 - correct the example

 RFCv1 =3D> v2:
 - Typofixes
---
 .../bindings/mfd/rohm,bd72720-pmic.yaml       | 339 ++++++++++++++++++
 1 file changed, 339 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic=
=2Eyaml

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml b=
/Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
new file mode 100644
index 000000000000..9f42097dfbac
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
@@ -0,0 +1,339 @@
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
+# Documentation/devicetree/bindings/power/supply/battery.yaml
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
+# volt-drop-thresh-microvolt: Threshold for starting the VDR correction
+# volt-drop-soc:                Table of capacity values matching the
+#                                    values in VDR tables.
+#
+# volt-drop-temperatures-millicelsius: Temperatures corresponding to the v=
olage
+# drop values given in volt-drop-[0-9]-microvolt
+#
+# volt-drop-[0-9]-microvolt: VDR table for a temperature specified in
+# volt-drop-temperatures-millicelsius
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
+    minimum: 10000
+    maximum: 50000
+    description:
+      BD72720 has a SAR ADC for measuring charging currents. External sense
+      resistor (RSENSE in data sheet) should be used. If some other but
+      30 mOhm resistor is used the resistance value should be given here in
+      micro Ohms.
+
+  regulators:
+    $ref: /schemas/regulator/rohm,bd72720-regulator.yaml
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
+            compatible =3D "rohm,bd72720";
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
+                buck1 {
+                    regulator-name =3D "buck1";
+                    regulator-min-microvolt =3D <500000>;
+                    regulator-max-microvolt =3D <2000000>;
+                    regulator-ramp-delay =3D <2500>;
+                };
+                buck2 {
+                    regulator-name =3D "buck2";
+                    regulator-min-microvolt =3D <500000>;
+                    regulator-max-microvolt =3D <2000000>;
+                    regulator-ramp-delay =3D <2500>;
+                };
+                buck3 {
+                    regulator-name =3D "buck3";
+                    regulator-min-microvolt =3D <1200000>;
+                    regulator-max-microvolt =3D <2000000>;
+                };
+                buck4 {
+                    regulator-name =3D "buck4";
+                    regulator-min-microvolt =3D <1000000>;
+                    regulator-max-microvolt =3D <1800000>;
+                };
+                buck5 {
+                    regulator-name =3D "buck5";
+                    regulator-min-microvolt =3D <2500000>;
+                    regulator-max-microvolt =3D <3300000>;
+                };
+                buck6 {
+                    regulator-name =3D "buck6";
+                    regulator-min-microvolt =3D <500000>;
+                    regulator-max-microvolt =3D <2000000>;
+                    regulator-ramp-delay =3D <2500>;
+                };
+                buck7 {
+                    regulator-name =3D "buck7";
+                    regulator-min-microvolt =3D <500000>;
+                    regulator-max-microvolt =3D <2000000>;
+                    regulator-ramp-delay =3D <2500>;
+                };
+                buck8 {
+                    regulator-name =3D "buck8";
+                    regulator-min-microvolt =3D <500000>;
+                    regulator-max-microvolt =3D <1700000>;
+                    regulator-ramp-delay =3D <2500>;
+                    rohm,dvs-run-voltage =3D <1700000>;
+                    rohm,dvs-idle-voltage =3D <1>;
+                    rohm,dvs-suspend-voltage =3D <1>;
+                    rohm,dvs-lpsr-voltage =3D <0>;
+                    regulator-boot-on;
+                };
+                buck9 {
+                    regulator-name =3D "buck9";
+                    regulator-min-microvolt =3D <500000>;
+                    regulator-max-microvolt =3D <1700000>;
+                    regulator-ramp-delay =3D <2500>;
+                    rohm,dvs-run-voltage =3D <1700000>;
+                    rohm,dvs-idle-voltage =3D <1>;
+                    rohm,dvs-suspend-voltage =3D <1>;
+                    rohm,dvs-lpsr-voltage =3D <0>;
+                    regulator-boot-on;
+                };
+                buck10 {
+                    regulator-name =3D "buck10";
+                    regulator-min-microvolt =3D <500000>;
+                    regulator-max-microvolt =3D <1700000>;
+                    regulator-ramp-delay =3D <2500>;
+                    rohm,dvs-run-voltage =3D <1700000>;
+                    rohm,dvs-idle-voltage =3D <1>;
+                    rohm,dvs-suspend-voltage =3D <1>;
+                    rohm,dvs-lpsr-voltage =3D <0>;
+                    regulator-boot-on;
+                };
+                ldo1 {
+                    regulator-name =3D "ldo1";
+                    regulator-min-microvolt =3D <800000>;
+                    regulator-max-microvolt =3D <3300000>;
+                };
+                ldo2 {
+                    regulator-name =3D "ldo2";
+                    regulator-min-microvolt =3D <800000>;
+                    regulator-max-microvolt =3D <3300000>;
+                };
+                ldo3 {
+                    regulator-name =3D "ldo3";
+                    regulator-min-microvolt =3D <800000>;
+                    regulator-max-microvolt =3D <3300000>;
+                };
+                ldo4 {
+                    regulator-name =3D "ldo4";
+                    regulator-min-microvolt =3D <800000>;
+                    regulator-max-microvolt =3D <3300000>;
+                };
+                ldo5 {
+                    regulator-name =3D "ldo5";
+                    regulator-min-microvolt =3D <800000>;
+                    regulator-max-microvolt =3D <3300000>;
+                };
+                ldo6 {
+                    regulator-name =3D "ldo6";
+                    regulator-min-microvolt =3D <1800000>;
+                    regulator-max-microvolt =3D <1800000>;
+                };
+                ldo7 {
+                    regulator-name =3D "ldo7";
+                    regulator-min-microvolt =3D <800000>;
+                    regulator-max-microvolt =3D <3300000>;
+                };
+                ldo8 {
+                    regulator-name =3D "ldo8";
+                    regulator-min-microvolt =3D <750000>;
+                    regulator-max-microvolt =3D <3300000>;
+                    rohm,dvs-suspend-voltage =3D <0>;
+                    rohm,dvs-lpsr-voltage =3D <1>;
+                    rohm,dvs-run-voltage =3D <750000>;
+                };
+                ldo9 {
+                    regulator-name =3D "ldo9";
+                    regulator-min-microvolt =3D <750000>;
+                    regulator-max-microvolt =3D <3300000>;
+                    rohm,dvs-suspend-voltage =3D <0>;
+                    rohm,dvs-lpsr-voltage =3D <1>;
+                    rohm,dvs-run-voltage =3D <750000>;
+                };
+                ldo10 {
+                    regulator-name =3D "ldo10";
+                    regulator-min-microvolt =3D <750000>;
+                    regulator-max-microvolt =3D <3300000>;
+                    rohm,dvs-suspend-voltage =3D <0>;
+                    rohm,dvs-lpsr-voltage =3D <1>;
+                    rohm,dvs-run-voltage =3D <750000>;
+                };
+                ldo11 {
+                    regulator-name =3D "ldo11";
+                    regulator-min-microvolt =3D <750000>;
+                    regulator-max-microvolt =3D <3300000>;
+                    rohm,dvs-suspend-voltage =3D <0>;
+                    rohm,dvs-lpsr-voltage =3D <1>;
+                    rohm,dvs-run-voltage =3D <750000>;
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
2.52.0


--05Tmz+oRckxZrk3Z
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmlACqMACgkQeFA3/03a
ocVs1gf/TMtbH9kJkA8VmSny+WPZd5aqfqZq6jQV3oIQmJV4abe/8wHLKP/BIl7I
NE5WpXYPjtv7SnmU4PiybUU5SVg22jLdo0LUZ4fd0Ot+DP+zawMmh7Dd275xdBC4
CsNoY89YApgDJ4v+7unrAlXUAtit4pm6/4LfvYB9fwozPF2m8Qd2lQRiFKkznxeh
GRf7jUTuHFYoaqomurIdgaaw/lmQggAU4KAHslkzhblmXU4v0e+A/Pm3nbpLuayy
Cy7Bztz/iS1ZQj7lsg54xG/OHSxqqC3MGnYbzVhZSQ/2lQowpIRUdGyvd+viY+g6
LsytL2RP719ZDMhoGAaGt08qaawWLg==
=Lixb
-----END PGP SIGNATURE-----

--05Tmz+oRckxZrk3Z--

