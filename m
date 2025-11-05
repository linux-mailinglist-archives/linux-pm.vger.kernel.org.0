Return-Path: <linux-pm+bounces-37404-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A05C343F2
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 08:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322E13B669E
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 07:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2168D2D24B3;
	Wed,  5 Nov 2025 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qf5XMvI8"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6992522BA;
	Wed,  5 Nov 2025 07:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762328182; cv=none; b=dvGQJ+C/h9woZi1a1I6+zPGMzPQS0QP+Re+y2TSLhp2WgIdfGG0K6Bts3hhQ40DqM6FJ4pStUPI9DJeoLt6rTAG9P+tQReuWcMxGnJPKOOuZCgnSmm8EyadopY7VkFLAxwsVNICSRciG2KKWT7s3eDlOoL24ZvS1M7RNFhg3vqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762328182; c=relaxed/simple;
	bh=kZBCLwNROGbeAQkOTm/92ZIfE1c0ggotdphJdDb6934=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Td/Q7y21dUOydoYZdqikXPnUiSYb1dzqQE55zGpozczcFWu7fQTnNNeCaRY5Q9rgCP0G1rVvLj4ku7YzrqqlDh3jQ5l60gftLodfmchoLxm6UZCg7oaBRSAqSAWeUqSCj8g9WkYbwuBjfa06/glFSx4GjuivilTkWJi4H72fe2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qf5XMvI8; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 5 Nov 2025 09:35:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762328168; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=EtPU1NFthqKkahcjBAXUOVz4dmxuIJ+cwvTL2ptvuCU=;
	b=qf5XMvI8lPhQn73losxLv4OcmTCP7ULI3dv2WyQYhxmfWasof7RU05jfeS1NeQlDnA5L9p
	atxPDOY2j9BSYGIohTEZufpG6Uqvco3M+fchFmoeyd4ikweVaz4UC9+XuPwkA+x8TeuLtR
	1DSi54rGCoM1RY6nnCaPEtpsGPHm0is=
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
Subject: [PATCH v3 01/16] dt-bindings: regulator: ROHM BD72720
Message-ID: <48fe6e2642db4484640b173cd71be1b245929122.1762327887.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1762327887.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nntmtfO2as3iM+5L"
Content-Disposition: inline
In-Reply-To: <cover.1762327887.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--nntmtfO2as3iM+5L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The ROHM BD72720 is a new PMIC with 10 BUCk and 11 LDO regulators.

The BD72720 is designed to support using the BUCK10 as a supply for
the LDOs 1 to 4. When the BUCK10 is used for this, it can be set to a
LDON_HEAD mode. In this mode, the BUCK10 voltage can't be controlled by
software, but the voltage is adjusted by PMIC to match the LDO1 .. LDO4
voltages with a given offset. Offset can be 50mV .. 300mV and is
changeable at 50mV steps.

Add 'ldon-head-microvolt' property to denote a board which is designed
to utilize the LDON_HEAD mode.

All other properties are already existing.

Add dt-binding doc for ROHM BD72720 regulators to make it usable.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 v2 =3D> v3:
 - drop unnecessary descriptions
 - use microvolts for the 'ldon-head' dt-property

 RFCv1 =3D> v2:
 - No changes
---
 .../regulator/rohm,bd72720-regulator.yaml     | 149 ++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd7272=
0-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd72720-regul=
ator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd72720-regula=
tor.yaml
new file mode 100644
index 000000000000..e8f51c770cd2
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd72720-regulator.ya=
ml
@@ -0,0 +1,149 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/rohm,bd72720-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BD72720 Power Management Integrated Circuit regulators
+
+maintainers:
+  - Matti Vaittinen <mazziesaccount@gmail.com>
+
+description: |
+  This module is part of the ROHM BD72720 MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml.
+
+  The regulator controller is represented as a sub-node of the PMIC node
+  on the device tree.
+
+  Regulator nodes should be named to BUCK_<number> and LDO_<number>.
+  The valid names for BD72720 regulator nodes are
+  buck1, buck2, buck3, buck4, buck5, buck6, buck7, buck8, buck9, buck10
+  ldo1, ldo2, ldo3, ldo4, ldo5, ldo6, ldo7, ldo8, ldo9, ldo10, ldo11
+
+patternProperties:
+  "^ldo[1-11]$":
+    type: object
+    description:
+      Properties for single LDO regulator.
+    $ref: regulator.yaml#
+
+    properties:
+      regulator-name:
+        pattern: "^ldo[1-11]$"
+
+      rohm,dvs-run-voltage:
+        description:
+          PMIC default "RUN" state voltage in uV. See below table for
+          LDOs which support this. 0 means disabled.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 3300000
+
+      rohm,dvs-idle-voltage:
+        description:
+          PMIC default "IDLE" state voltage in uV. See below table for
+          LDOs which support this. 0 means disabled.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 3300000
+
+      rohm,dvs-suspend-voltage:
+        description:
+          PMIC default "SUSPEND" state voltage in uV. See below table for
+          LDOs which support this. 0 means disabled.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 3300000
+
+      rohm,dvs-lpsr-voltage:
+        description:
+          PMIC default "deep-idle" state voltage in uV. See below table for
+          LDOs which support this. 0 means disabled.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 3300000
+
+        # Supported default DVS states:
+        #     ldo        |    run     |   idle    | suspend   | lpsr
+        # --------------------------------------------------------------
+        # 1, 2, 3, and 4 | supported  | supported | supported | supported
+        # --------------------------------------------------------------
+        # 5 - 11         |                    supported (*)
+        # --------------------------------------------------------------
+        #
+        # (*) All states use same voltage but have own enable / disable
+        #      settings. Voltage 0 can be specified for a state to make
+        #      regulator disabled on that state.
+
+    unevaluatedProperties: false
+
+  "^buck[1-10]$":
+    type: object
+    description:
+      Properties for single BUCK regulator.
+    $ref: regulator.yaml#
+
+    properties:
+      regulator-name:
+        pattern: "^buck[1-10]$"
+
+      rohm,ldon-head-microvolt:
+        description:
+          Set this on boards where BUCK10 is used to supply LDOs 1-4. The =
bucki
+          voltage will be changed by the PMIC to follow the LDO output vol=
tages
+          with the offset voltage given here. This will improve the LDO ef=
ficiency.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 50000
+        maximum: 300000
+
+      rohm,dvs-run-voltage:
+        description:
+          PMIC default "RUN" state voltage in uV. See below table for
+          bucks which support this. 0 means disabled.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 3300000
+
+      rohm,dvs-idle-voltage:
+        description:
+          PMIC default "IDLE" state voltage in uV. See below table for
+          bucks which support this. 0 means disabled.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 3300000
+
+      rohm,dvs-suspend-voltage:
+        description:
+          PMIC default "SUSPEND" state voltage in uV. See below table for
+          bucks which support this. 0 means disabled.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 3300000
+
+      rohm,dvs-lpsr-voltage:
+        description:
+          PMIC default "deep-idle" state voltage in uV. See below table for
+          bucks which support this. 0 means disabled.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 3300000
+
+        # Supported default DVS states:
+        #     buck       |    run     |   idle    | suspend   | lpsr
+        # --------------------------------------------------------------
+        # 1, 2, 3, and 4 | supported  | supported | supported | supported
+        # --------------------------------------------------------------
+        # 5 - 10    |                    supported (*)
+        # --------------------------------------------------------------
+        #
+        # (*) All states use same voltage but have own enable / disable
+        #      settings. Voltage 0 can be specified for a state to make
+        #      regulator disabled on that state.
+
+    required:
+      - regulator-name
+
+    unevaluatedProperties: false
+
+additionalProperties: false
--=20
2.51.0


--nntmtfO2as3iM+5L
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkK/l8ACgkQeFA3/03a
ocVslAf9GiQAjfENfrMjkdDb0v/Ya8WTB8SLd2z0aFt1x8bzAdoH3WCzncecF4h5
52sSmJFIcA2dMeF4WbmtjLTdqzdHH7+B7RDDosipOF1qXvnN+xU+wvHwkIiDyP+q
r6Os2quJhu6+jp/JeDsueYVKOXWXfDKkOR4ngMdqjGGEELcwDQCUcYqZlPJejRv9
zf0sylM+3fI0pmyMUoItn9ra91Qg5o6oiKJtWwlDj4vEHJ7ViV7wQC/ZMUMZGKcS
lNTNRo+DlfkPhlTUbhJ3CY8aRrpTFodDW5LbAGOuc6cMaO19KTQjRWUeh+l/7Fl8
DISr8VBMZ5Rz1b4DjJd0UQG8SH244A==
=Hzfm
-----END PGP SIGNATURE-----

--nntmtfO2as3iM+5L--

