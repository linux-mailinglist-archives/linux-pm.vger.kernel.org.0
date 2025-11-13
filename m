Return-Path: <linux-pm+bounces-37919-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5850C56662
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 09:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E09A3B9EC6
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 08:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E87332EC1;
	Thu, 13 Nov 2025 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DoyUcvEo"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A159332900
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023951; cv=none; b=Q6njm15+TCJDNRAxAMcEJddwWbue+f/rR0xQUOJnxHpQHhss7uVeBxpfFWpjI9YwvES4jCQN37VTiJZfHk9XlIykhk5/gx4kVxD80zj8VH+gvvtKZZEa3hNxhMpjMUTb9aViCiqJbyNdp0PtpHq1okwdjZ8pXcmLy3yQxrpcxOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023951; c=relaxed/simple;
	bh=JdeZs2/hVoO9ckPcA10p264jrT0lL/OTODTRf+1PWcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Er0jG1ZB3tJ6BOdh4GI0qDjF3kf3RNbbdadgv3aLHOvtiPJfJ/uhnS7lQBz4jTF148hCawXm3Bx46ldcXBqv/lyBr4fsx1/G68IypBDzWTgK13SgIuljj5KAhaWK4vB0Fi4SK/g1UCzg9f9LdNpNsl5sB6z9UuM3s73oqllJ5hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DoyUcvEo; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 13 Nov 2025 10:52:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763023948; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=3c5CiuLxSc1Ezd8aR5GLDsqwE50fWsjWdh8A4ya1Zso=;
	b=DoyUcvEovW2CcDoHhYY7DTnDf1AAKrtxKZxcuFQbs/tx3QF20bushm8jvEr6IbWmWzyNY+
	pSXta1NgmD66JGSfFTuY/yMJgUM7nNZIFB9DDtzFICY/eUnz4pYLAS1pxJfCJCLFiEHbgu
	QOGQeaNJSzrBDbCpLZIEvPXjM42qx74=
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
Subject: [PATCH v4 04/16] dt-bindings: power: supply: BD72720 managed battery
Message-ID: <ac5a4e992e4fb9c7bffb1e641a7cd61f74af4cba.1763022807.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1763022807.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u+6hv1JtzGpu3Gz0"
Content-Disposition: inline
In-Reply-To: <cover.1763022807.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--u+6hv1JtzGpu3Gz0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The BD72720 PMIC has a battery charger + coulomb counter block. These
can be used to manage charging of a lithium-ion battery and to do fuel
gauging.

ROHM has developed a so called "zero-correction" -algorithm to improve
the fuel-gauging accuracy close to the point where battery is depleted.
This relies on battery specific "VDR" tables, which are measured from
the battery, and which describe the voltage drop rate. More thorough
explanation about the "zero correction" and "VDR" parameters is here:
https://lore.kernel.org/all/676253b9-ff69-7891-1f26-a8b5bb5a421b@fi.rohmeur=
ope.com/

Document the VDR zero-correction specific battery properties used by the
BD72720 and some other ROHM chargers.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

---
NOTE:
Linus' rb-tag holds only if there's no further comments from Rob.

Revision history:
 v3 =3D>:
 - No changes

 v2 =3D> v3:
 - Constrain VDR threshold voltage to 48V
 - Use standard '-bp' -suffix for the rohm,volt-drop-soc

 RFCv1 =3D> v2:
 - Add units to rohm,volt-drop-soc (tenths of %)
 - Give real temperatures matching the VDR tables, instead of vague
   'high', 'normal', 'low', 'very low'. (Add table of temperatures and
   use number matching the right temperature index in the VDR table name).
 - Fix typoed 'algorithm' in commit message.

The parameters are describing the battery voltage drop rates - so they
are properties of the battery, not the charger. Thus they do not belong
in the charger node.

The right place for them is the battery node, which is described by the
generic "battery.yaml". I was not comfortable with adding these
properties to the generic battery.yaml because they are:
  - Meaningful only for those charger drivers which have the VDR
    algorithm implemented. (And even though the algorithm is not charger
    specific, AFAICS, it is currently only used by some ROHM PMIC
    drivers).
  - Technique of measuring the VDR tables for a battery is not widely
    known. AFAICS, only folks at ROHM are measuring those for some
    customer products. We do have those tables available for some of the
    products though (Kobo?).
---
 .../power/supply/rohm,vdr-battery.yaml        | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/rohm,vdr=
-battery.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/rohm,vdr-batter=
y.yaml b/Documentation/devicetree/bindings/power/supply/rohm,vdr-battery.ya=
ml
new file mode 100644
index 000000000000..be2f65a892ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/rohm,vdr-battery.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/rohm,vdr-battery.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Battery managed by the BD72720 PMIC
+
+maintainers:
+  - Matti Vaittinen <mazziesaccount@gmail.com>
+
+description:
+  A battery which has VDR parameters measuerd for ROHM chargers.
+
+allOf:
+  - $ref: battery.yaml#
+
+properties:
+  rohm,voltage-vdr-thresh-microvolt:
+    description: Threshold for starting the VDR correction
+    maximum: 48000000
+
+  rohm,volt-drop-soc-bp:
+    description: Table of capacity values matching the values in VDR table=
s.
+      The value should be given as basis points, 1/100 of a percent.
+
+  rohm,volt-drop-temperatures-millicelsius:
+    description: An array containing the temperature in milli celsius, for=
 each
+      of the VDR lookup table.
+
+patternProperties:
+  '^rohm,volt-drop-[0-9]-microvolt':
+    description: Table of the voltage drop rate (VDR) values. Each entry i=
n the
+      table should match a capacity value in the rohm,volt-drop-soc table.
+      Furthermore, the values should be obtained for the temperature given=
 in
+      rohm,volt-drop-temperatures-millicelsius table at index matching the
+      number in this table's name.
+
+additionalProperties: false
+
+examples:
+  - |
+    power {
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+
+      battery: battery {
+        compatible =3D "simple-battery";
+
+        ocv-capacity-celsius =3D <25>;
+        ocv-capacity-table-0 =3D <4200000 100 4184314 100 4140723 95 40994=
87 90
+          4060656 85 4024350 80 3991121 75 3954379 70 3913265 65 3877821 60
+          3855577 55 3837466 50 3822194 45 3809012 40 3795984 35 3780647 30
+          3760505 25 3741532 20 3718837 15 3696698 10 3690594 5 3581427 0>;
+
+        rohm,volt-drop-soc-bp =3D <10000 10000 9500 9000 8500 8000 7500 70=
00 6500 6000 5500 5000
+          4500 4000 3500 3000 2500 2000 1500 1000 500 0 (-500)>;
+
+        rohm,volt-drop-temperatures-millicelsius =3D <45000 25000 5000 0>;
+
+        rohm,volt-drop-0-microvolt =3D  <100 100 102 104 106 109 114 124
+          117 107 107 109 112 116 117 108 109 109 108 109 122 126 130>;
+
+        rohm,volt-drop-1-microvolt =3D <100 100 102 105 98 100 105 102
+          101 99 98 100 103 105 109 117 111 109 110 114 128 141 154>;
+
+        rohm,volt-drop-2-microvolt =3D <100 100 98 107 112 114 118 118 112
+          108 108 110 111 113 117 123 131 144 157 181 220 283 399>;
+
+        rohm,volt-drop-3-temp-microvolt =3D <86 86 105 109 114 110 115 115
+          110 108 110 112 114 118 124 134 136 160 177 201 241 322 403>;
+
+        rohm,voltage-vdr-thresh-microvolt =3D <4150000>;
+
+        charge-full-design-microamp-hours =3D <1799000>;
+        voltage-max-design-microvolt =3D <4200000>;
+        voltage-min-design-microvolt =3D <3500000>;
+        degrade-cycle-microamp-hours =3D <131>;
+      };
+    };
--=20
2.51.1


--u+6hv1JtzGpu3Gz0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkVnEMACgkQeFA3/03a
ocX/2wgAjbIroHnL+ZCN3LQJk5kU0vApYUKVMcpxK/ARcYormgJ4YKOY7rPksY4p
euGidoa1mq3JWED80LLSfZamaISl6TI96wakBHFt1shVGesukRnfez/nSb680TdJ
/d7c0MpCZmNkiT+XdkZOIkL0NWxwK5eRYLqvBI6NmiT81acBC6X3HHl0Ke2tT9bZ
xU9E8IyaZ9QdN6cgR9r+ZayrqK3BECDjMpZizgLHyE84cXrWGw4ebcacOF0pwTBX
Gg9m9R2XqKkRAyvlQD33tIGG/VQrbGG7ZdyZh9LVhiYeRGZu2UHyhzhMDKOkNBul
f450q5EIWMXcIgGM76zU93U4c3JEzg==
=vjVT
-----END PGP SIGNATURE-----

--u+6hv1JtzGpu3Gz0--

