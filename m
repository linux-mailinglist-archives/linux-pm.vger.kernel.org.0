Return-Path: <linux-pm+bounces-38276-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AC6C72CD2
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 09:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 6ACC82F67A
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 08:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0E73164BA;
	Thu, 20 Nov 2025 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ejtIBtKM"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C0A3128CE
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763626856; cv=none; b=cuBee9zOtLDDVTRT++LLv/TYded73H/lI6RV8JnzaGAFP6bt4bHMlu92lKyrgdVrDCsTjs/TU3SoCKyXgs8pPfeq1rM2cBOAu56rVRUcTDG7KybaoZn1gBhzpprpQ6PjLfv3x2sBNiyCJid/+Hc54qhg1Ycy3te7mkIBis0hlN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763626856; c=relaxed/simple;
	bh=0UmwNYd3iJQb3Nv9f51VpNeC971L3w+UlJxDfEXhbSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P22SdcsPbfdwOCmuimcs2Sqt8V2tPKa3YtMhdLFAh7DSWNvPg0Mj6KH1zPBDk/pnQP7fyei4+aYp6imZAuDHmkzl0pa/Wsb25oDkDKGlSDrd0Y5QlceHs+lc63mL1m31uNUsgPQikjf+QAGe7egWIjZYtGZFdDhLZ+phbhKaUX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ejtIBtKM; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Nov 2025 10:20:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763626851; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=3/CVRvAzaacG+G6D4vTQblXg41VdLsnqnLoj7zFQalw=;
	b=ejtIBtKMAsdqfh41MbNVM+beRy9p4J2k40w1sjBbtCgwHEVM+AyTbyclF8mmhwR27fFT8b
	w6BBvlHmav352HATEnNDP2qHE04gjAcL3vlAG5NsDW1QwFxlrYSPm02fgaeEF1r7P87bKJ
	HzX0v+ygkVzo0aCppQ7PNi/S8yXxqM4=
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
Subject: [PATCH v5 05/16] dt-bindings: mfd: ROHM BD72720
Message-ID: <fa9996fa9efdecfba1165a8d623c4b3ae3f91cbc.1763625920.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1763625920.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JxBceYWcN3Rgj1T2"
Content-Disposition: inline
In-Reply-To: <cover.1763625920.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--JxBceYWcN3Rgj1T2
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
2.51.1


--JxBceYWcN3Rgj1T2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkez1oACgkQeFA3/03a
ocWhnAgArkWO9oGZXvS8d50T42elNWDe+YRdxN0hSL9JwC545fxmSFcCtW5EczP9
8sW4eB+om3dmcLvRuQc2IdnvnauwKIQiSjG3KzQfkdXeeqfMGhcwjA1e+P4J+I3M
Isvm9XIuruXUobxQ98XABVd2hEBiYMMUbVD/pkbBMZQfVsHp0CpCdWSFPYkseLCV
ejJa3K3Ab7IbcOzUVN390S9A1YFsrxj9WVrStJrcfnnZETq0sp6APA7FApHNbWAK
adydy6XYkCaED0/w6ATkHmYy1N/unm1JPnQltviGZjnVeb82vi3UKgeCWAWvTJ4r
AfAaRCI9I69V/SidDUCx5D82N76tUw==
=ZHgD
-----END PGP SIGNATURE-----

--JxBceYWcN3Rgj1T2--

