Return-Path: <linux-pm+bounces-39561-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 60009CBDFA7
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 14:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60BB03005A84
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 13:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDFB2DE711;
	Mon, 15 Dec 2025 13:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qL+czE7q"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1869C2D3A89
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765804703; cv=none; b=FwWmm6hguz+s++Et2vdRhN0BjurBheGFfUAPaJ2FlBAvV8j7vG2kKj9EmVq5CnVdRiW2orcVyDuuKfeTVbVa1xPPIKT5LxMC7kkixOAUW6W0kIv/kBX6tqoPMus6usS9ZqVGtsu1qQsNonntqUisXF9nUCLPQNHuufGGmJpa8Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765804703; c=relaxed/simple;
	bh=+/JtY60q2Qkm2a2ym9c8qXlCx/CawZR8OhUemcBt1pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fp8DyiEwZLdaczaB0P33OOtffaZlEPm9PkcGcq4BtG6f62+GIfQ8n1fOnzsSq5PuLNflSolWZUQliByhvnkhQRq5KPwar2N1ETaPxPaVm18gBOQrMQl8zPtnkKtGPkXFUA7RdU4HA2GVdyau40qj/lSMsgCuIx61sUCP8QDDWH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qL+czE7q; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 15 Dec 2025 15:18:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765804700; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=NeVM4oy8fgXRhssi0/ne7Qtl529zd3wNeXCzpeVJm9U=;
	b=qL+czE7qlnPRuLX7C9Jt3dhWuv266Iod9Ufemyu27/yX6gtrVxKxuqsfsVZW0WlpB3fv1N
	4a7q1YE1RXQEr18bNX1Bq4W8YLko/x0+q9hUeKMselvqyF9v8eC+DEuCaY4zrxsYo9dnB7
	fT2wfcNGY01II1hgn+Wk6q4i7xfo3WE=
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
Subject: [PATCH RESEND v6 04/17] dt-bindings: battery: Voltage drop properties
Message-ID: <461f2840a03e0189ecd4f1a7c261014342ddee91.1765804226.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1765804226.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sGWcLtLyM3nIvnQ7"
Content-Disposition: inline
In-Reply-To: <cover.1765804226.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--sGWcLtLyM3nIvnQ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

ROHM has developed a so called "zero-correction" -algorithm to improve
the fuel-gauging accuracy close to the point where battery is depleted.
This relies on battery specific "VDR" (voltage drop rate) tables, which
are measured from the battery, and which describe the voltage drop rate.
More thorough explanation about the "zero correction" and "VDR"
parameters is here:
https://lore.kernel.org/all/676253b9-ff69-7891-1f26-a8b5bb5a421b@fi.rohmeur=
ope.com/

Document the VDR zero-correction specific battery properties used by the
BD71815, BD71828, BD72720 and some other ROHM chargers. (Note, charger
drivers aren't upstream yet).

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Linus Walleij <linusw@kernel.org>

---

Revision history:
 v5 =3D>:
 - No changes

 v4 =3D> v5:
 - Move volt-drop parameters from rohm,vdr-battry,yaml to the
   battery.yaml
 - drop rohm, -prefix from volt-drop-* properties
 - Drop the rohm,vdr-battry,yaml
 - Add comment clarifying what the rohm,volt-drop-* properties are for
   because this may no longer be obvious as they were moved to common
   battery.yaml
 - Drop Linus Walleij's rb-tag because the concept was changed

 v3 =3D> v4:
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
generic "battery.yaml". There were some discussion whether these
properties should be in their own file, or if they should be added to
battery.yaml. Discussion can be found from:
https://lore.kernel.org/all/52b99bf7-bfea-4cee-aa57-4c13e87eaa0d@gmail.com/
This patch implements the volt-drop properties as generic (not vemdor
specific) properties in the battery.yaml. It's worth noting that these
properties are:

  - Meaningful only for those charger drivers which have the VDR
    algorithm implemented. (And even though the algorithm is not charger
    specific, AFAICS, it is currently only used by some ROHM PMIC
    drivers).
  - Technique of measuring the VDR tables for a battery is not widely
    known. AFAICS, only folks at ROHM are measuring those for some
    customer products. We do have those tables available for some of the
    products, like Kobo e-readers though.
---
 .../bindings/power/supply/battery.yaml        | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml b/=
Documentation/devicetree/bindings/power/supply/battery.yaml
index d1a2080557a0..8ebf05d9497c 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
@@ -128,6 +128,21 @@ properties:
       - description: alert when battery temperature is lower than this val=
ue
       - description: alert when battery temperature is higher than this va=
lue
=20
+  # The volt-drop* -properties describe voltage-drop for a battery, descri=
bed
+  # as VDROP in:
+  # https://patentimages.storage.googleapis.com/6c/f5/17/c1d901c220f6a9/US=
20150032394A1.pdf
+  volt-drop-thresh-microvolt:
+    description: Threshold for starting the VDR correction
+    maximum: 48000000
+
+  volt-drop-soc-bp:
+    description: Table of capacity values matching the values in VDR table=
s.
+      The value should be given as basis points, 1/100 of a percent.
+
+  volt-drop-temperatures-millicelsius:
+    description: An array containing the temperature in milli celsius, for=
 each
+      of the VDR lookup table.
+
 required:
   - compatible
=20
@@ -146,6 +161,13 @@ patternProperties:
         - description: battery capacity percent
           maximum: 100
=20
+  '^volt-drop-[0-9]-microvolt':
+    description: Table of the voltage drop rate (VDR) values. Each entry i=
n the
+      table should match a capacity value in the volt-drop-soc table.
+      Furthermore, the values should be obtained for the temperature given=
 in
+      volt-drop-temperatures-millicelsius table at index matching the
+      number in this table's name.
+
 additionalProperties: false
=20
 examples:
--=20
2.52.0


--sGWcLtLyM3nIvnQ7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmlACpMACgkQeFA3/03a
ocWcgggAkIq7jgJumF51IeSoHWUZ+sWynLFIlLMqwmAJjUZzqiETZeEEg6WT9E0o
v9EXaCiOGsysyBSou4PhQ5asR9KZyj1tUWuNuPOZAFgu9LSPqJZUSBVnbCDK7t7j
rP+jYam6K7TTdjl8iip1HwRpS/OGDVLHXbcwhm/TPrRRHUS0mveAmjMjp8dvaHAo
ih5ueTXmlzjWW8VvCDcSrnTrvcbA5yDHfXhfKZ8t7Kai4qcJBa3qPJJBnRl6w+78
sdp/1aYz0RbYn/QyAauXelscucP/0QY2DUjyopa+6O0lrpEj0RbioqYbw93SJ+Aw
WZjtB2jaA7tXxVj0Huedy4V4xJvTHA==
=TItG
-----END PGP SIGNATURE-----

--sGWcLtLyM3nIvnQ7--

