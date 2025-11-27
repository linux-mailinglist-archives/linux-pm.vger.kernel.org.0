Return-Path: <linux-pm+bounces-38780-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC329C8DF3A
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 12:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881203B367C
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 11:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3037F30DECA;
	Thu, 27 Nov 2025 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dAPk6zN/"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2892E2FDC56
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764242281; cv=none; b=IOz1MGE/bss3bbnjbPKv2aW5caWbYeCzHj4QgcNPtMfWJ8KCXPa/ljush46E5F+xzj7RH03buwnAkIhUUTDMsglaSVGwoKQLnA1rQq9zNF5JxRcO/smLC6IDo7sGI5wa8zY5GX3025FRyiloAekgQH0QCOnsjWDWS0Gnref1YYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764242281; c=relaxed/simple;
	bh=6bEPzaPBEdBlsr7vFWsjdFsos2k5X08uzjCThCwwylw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMj0vHlznLaajvgn3BirbEas6ZMLW3x057hJFDWjTyOr8QMLhq8Nk7Z1wpp6Onlf3PzKbOIJN4ddNY7OxPDai/XY+zzZUK1F5f2SS1B60TKpPRM/oQuwk/RDxa/CpC9/zExRLH33G8k+OzbSnytLpsXmvR/NquaXcNnpZF/DmMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dAPk6zN/; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Nov 2025 13:17:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764242277; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=c3yC4BZmCwtEfMWQAbU9XehKSkG3OcLrVv2b6wKZhkI=;
	b=dAPk6zN/lWXDYVBdPysbaDfDsO56lVAxn3w8wgKpk7nIP1cfX9IIIcMAGPPS3Lb4R9zFeW
	RojQ4C7p4EvHzSMS10s5ywei6Un3xMbbX39T3PJGJUAssoBF6hYRxcf+meHarnKIuIwYVj
	8kMEvM90c7YJSok/VaWzNuS+pWu9hmI=
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
Subject: [PATCH v6 04/17] dt-bindings: battery: Voltage drop properties
Message-ID: <3f1e43285f58630eb0164857533ccfea9ea628ab.1764241265.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1764241265.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="09vNjhhlf2cmLPuX"
Content-Disposition: inline
In-Reply-To: <cover.1764241265.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--09vNjhhlf2cmLPuX
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


--09vNjhhlf2cmLPuX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkoM10ACgkQeFA3/03a
ocUbfQf/Vg2E5ryIg6ySiFbrPHaNCrinXcsnPdw/faFmw9FKk7EEj1ex9H6n2j3i
9xBrZAKacwJbE2/F5BC+JBAJ9IWcFvQsabntDj9U7py8YXIBuMKUPlL7BcxULMKL
/RW7QC3tJjwFR+ymyNMdm/eSWaDaMqRQgro1ORlvtChMmMrUREIkJYi6tWo0aAOq
kMj3AzhDJZBK85UTkEfLCpSjVfeBodeZPBoZp4Wnx2TO3PNmuXx+RvKgRKPrJlrJ
ATpRYKdWDNKs2iRk92HKcATFg8Ib/JJYfrrAw3sILnk8HBBVmpQTt3feg099dFiq
1QDIgAjyARMsQJkxDgf+9Mqw+0J+Yw==
=WMdC
-----END PGP SIGNATURE-----

--09vNjhhlf2cmLPuX--

