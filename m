Return-Path: <linux-pm+bounces-38275-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB055C72CB7
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 09:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4D71A359501
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 08:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78EE30F80F;
	Thu, 20 Nov 2025 08:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fI6/kKcx"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E9530B512
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763626839; cv=none; b=jKEG2Y40BcKDTpw1t8IopCmbvWtFlONCoWoMR+ZVbqUSHcMuXZ1jf6tLUqeUN0q04tiuZvvsSgi6XgiZ7uG0yqHGTTCEwUF2eiKeuPOYoHHcvLgR2riKvWNANUmacxujMwqpFxmRicuGeNCPWWp07E1/CrHvoyj9XKaZ9IwSdv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763626839; c=relaxed/simple;
	bh=SHgZRzirFHjajJ6Dsyt9Ta0a9FVCwVMtdhzqvhCAVpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+i8FFaTOPIwcB8L/scSQr7xd3MNChmN9FdcNwVbzaOL1Ub/MmFxKRxmiL3yVIimAGjHMbNGYEsZdPaAFNW1d2a5Tc/rBkt+ItSOCqz7KAmcEQ1MDxWWBDwLlUV/gm6MMDF7Qmy5UEo3udpsNZ8xVxEo3Gvs46Yk2tQX2tuDd9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fI6/kKcx; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Nov 2025 10:20:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763626835; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=DrcIi7LtDRHfbFyowTkUjqu+jOoy5yBr+mg5oNziTgM=;
	b=fI6/kKcxSjEgMeXHNhGjihN09IwjgnVwEy5xbijOQG4otdJ97vXOGM93CkJj/Suy5pYlJK
	XkMDh8nCn1excJVnXAoJ/9nys3RWSN1Yho9rlw14QH9R8GRpAB97FEP3Hgk5nGiNcX+GGq
	O2P1JycwhwAzM8ZoDj23mnkfU6h4ols=
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
Subject: [PATCH v5 04/16] dt-bindings: battery: Voltage drop properties
Message-ID: <93768cba6688714756fca49cc57d46a111885863.1763625920.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1763625920.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pZNXYC8U4vNPt5jQ"
Content-Disposition: inline
In-Reply-To: <cover.1763625920.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--pZNXYC8U4vNPt5jQ
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

---

Revision history:
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
2.51.1


--pZNXYC8U4vNPt5jQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkez0gACgkQeFA3/03a
ocU4wQf/faGFyzKLBk3k/aemDd9DGzhJyBiwoyKwH7HLFxyX3Crp8Dne1MnLNh9C
9EboxKNnryHdak7dVkCScVdLhmwy6VjOZAKLSuEIdPHHsYS6R9Rxt81LgJQVyFDd
wtKl/ZapiuIQE92ociXftjIsUyXGKGNDlkC2q+5mXRbamTSlW37F8//O1u11wxG6
SFNHboAQpsyZ729d0qq2CSfUfPaIg3bvBTAhxfsT7hgOdoDnELD6T/XLLgU2Nxk/
gDW0pJ4yzkwIWxjK7l3FCisKFqQeLqiCh+zQYzfql+dYmyqGdzD6Pn5Ko95l2hGP
V1FpOIO/SpRG1GhvTWR5oeXcDuv/kQ==
=/3Jz
-----END PGP SIGNATURE-----

--pZNXYC8U4vNPt5jQ--

