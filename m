Return-Path: <linux-pm+bounces-39559-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56758CBDFE6
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 14:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADFD83017F28
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 13:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758462DCC1C;
	Mon, 15 Dec 2025 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EOfnQFXp"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48162DAFDA
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765804680; cv=none; b=Ni6rwGe0YJAOAQjK4yb/f/zMz1Z9LwKD/Vj/XCx/kERdMUgjQH+xMVE0/qq7cxrsL1zIhu98l693nmiM5g3u4KXHPIiU5NZO/Y4I5u30cbv10QMr8whWf7oGnovmScZaQYH4jBxExtK9548ods0t2C0KVhSo/TB/268mTc3hICA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765804680; c=relaxed/simple;
	bh=12NgJxB3KzCIj8TW1CcvOJksdwDOqWZ+SxsHcch7uFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMqOGrWorX9w1VSJ7/wYzVtV0UM37QVM+NdA7+tT1//bPAbIxlAkWLQpWXGmIBldU2Ya6C0Ow/fnIc3dGnhYc2zNbO3JRns1Q37YeUlPB991HgSBaT+vNGARh4ZDJo1WC5EgPVpU8MUGvjLmp7GbbH7diQyPwUwOrY9NL5yJN3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EOfnQFXp; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 15 Dec 2025 15:17:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765804666; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=BzU8J3XDRZO3yOO5szOLXxY7PUXnrgw8jPRbCpLpxm0=;
	b=EOfnQFXpgVqUzmT3qRtxckQIS7FhbBkhAMwUrkskDEBqe+fX5vz8uxWFDCON32IberWny4
	7SqOoBEvs4k7VtgaiCGR/LF1iSmDkT6HInhsIaPY1s6unkMosKJ9qZjAFRgUofNDRJOvL3
	n4RW7j7y0g97mqNxrKTU9HcNvVYXrUs=
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
Subject: [PATCH RESEND v6 02/17] dt-bindings: battery: Clarify trickle-charge
Message-ID: <e2794140343103245410c3301f8994e1babaeb96.1765804226.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1765804226.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="973ofo2LChz6OX81"
Content-Disposition: inline
In-Reply-To: <cover.1765804226.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--973ofo2LChz6OX81
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The term 'trickle-charging' is used to describe a very slow charging
phase, where electrons "trickle-in" the battery.

There are two different use-cases for this type of charging. At least
some Li-Ion batteries can benefit from very slow, constant current,
pre-pre phase 'trickle-charging', if a battery is very empty.

Some other batteries use top-off phase 'trickle-charging', which is
different from the above case.

The battery bindings use the term 'trickle-charge' without specifying
which of the use-cases properties are addressing. This has already
caused some confusion.

Clarify that the 'trickle-charge-current-microamp' refers to the first
one, the "pre-pre" -charging use-case.

Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

---
Revision history:
 v3 =3D> :
 - No changes

 v2 =3D> v3:
 - New patch
---
 .../devicetree/bindings/power/supply/battery.yaml          | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml b/=
Documentation/devicetree/bindings/power/supply/battery.yaml
index 491488e7b970..bfb7b716ae13 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
@@ -64,7 +64,12 @@ properties:
     description: battery design capacity
=20
   trickle-charge-current-microamp:
-    description: current for trickle-charge phase
+    description: current for trickle-charge phase.
+      Please note that the trickle-charging here, refers "wake-up" or
+      "pre-pre" -charging, for very empty batteries. Similar term is also
+      used for "maintenance" or "top-off" -charging of batteries (like
+      NiMh bq24400) - that is different and not controlled by this
+      property.
=20
   precharge-current-microamp:
     description: current for pre-charge phase
--=20
2.52.0


--973ofo2LChz6OX81
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmlACnIACgkQeFA3/03a
ocWdOAf/X9xXX1p4fvHFishKU2T2jbpu23dz7DET6/+/gKaO8enedh1ZY9OewtXJ
PKkVtFrl5TXghq3oIJd6ocCFK0R3Q2Htp27WTatVrBRtipamHhgi5diKkfgfQRAc
2zYRswJO//+vCKyusSfxmxna/EAXO8HRyp8mepQLixs9RRo3IzICV5/9qNU9CJX/
M4RxkBWJbcmCyYJsVtrL2gHpFtYlnv0I93J/LKtlbksi8EPEOW42/lhsKuheRiYU
Jb2aa3R4s3BZGqh9sqo9v3EkN8usOu12rL4ummc4LOJIE52NeVjG2bK5u9+care9
jZd8rb+nvuaKvLIPQDvnnY2HTj8Tlw==
=201Z
-----END PGP SIGNATURE-----

--973ofo2LChz6OX81--

