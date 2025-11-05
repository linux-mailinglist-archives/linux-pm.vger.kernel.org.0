Return-Path: <linux-pm+bounces-37405-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F06C34407
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 08:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5E3A4F15E7
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 07:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ED02D5937;
	Wed,  5 Nov 2025 07:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QProqwgx"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E892D4801
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 07:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762328187; cv=none; b=W3L2en9aeiv6YfVDh50wXBx9zpK1Xd6GMbzv2Ex/0/+VCXEQYdm9bVFrLNd/kpC7Ievkh9NPHpB29ldZGQsQZTio46ExVVVx3QlEqyKvG9wgXnsOEmEP2mbIv85tqK76eYIvcSnLqxtY0Xz9fPYbJf5s0bWdutJ5qlmz4Sy+jVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762328187; c=relaxed/simple;
	bh=l4sVPfT+IHVIjHAg6mRjsZ6J0HkKBQLQ79pRWfzDNsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQggeEvEspUUXT3KsEMU1LdLS3JpMKcBc0cpxMhyhI7hQvSFNRuCH7YDJX8ewTqUJyCqrlDQcWNbr3GMJSlG2gKNoRZ69lKcUdR/8jlMHI6aBiiXtGjHRNHMKTiv8XuyAYl8E1BZMnmQ5r84nymn1iOE/WlX+gCoNbgMd9yjImw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QProqwgx; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 5 Nov 2025 09:36:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762328183; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=esXwrIIJ/OfQVqm08M7Pt7VI1MokoOkiScr/2XSUa0U=;
	b=QProqwgxNjFX8FInVaKiL9gtAoMneHImlBqks/StpSDTaiWJjS+MVjhpUWIWPJtpHBFvhv
	Awe3Amw95ydMg/bHUSCog7o6q+N73fEpG/EZFqQuQXVI0ztiHt1Qgy4TbvcxSMF4CoRkL7
	v04md90iCbYkzzQE31QgbJbdJsFrPUo=
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
Subject: [PATCH v3 02/16] dt-bindings: battery: Clarify trickle-charge
Message-ID: <742fcdcc8b6dcb5989418e8c1cf5a7d7ba5434a5.1762327887.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1762327887.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I3TnsRBe02/VN2xi"
Content-Disposition: inline
In-Reply-To: <cover.1762327887.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--I3TnsRBe02/VN2xi
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

---
Revision history:
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
2.51.0


--I3TnsRBe02/VN2xi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkK/nAACgkQeFA3/03a
ocUMIAf+NCseED7kwNbN9UuGodeOWqZ1MLgfMqLBUlOUc7XyZ51vUagUd4WDOIOR
do4YBR0Fg/uoDT3mJBj5UVJq4TffQsOqyU1jaWCqSNYBwer9Jvz6AfVuOOzJJefi
qTsLO+90cnMMDhfnEfFH1k7iTcxe9yS4l9D9cXtVrOS5i+Ui8Kp4bFaxKfAN7C+A
6OeoIRR5ycRzlnEiZtOwfwAXYWbLmmHLpmHG1HEhsv5/FFdqAI2bd9OXFqWPwwdD
XXHF0+bgQpjIatqk8lPwFR+OufIlWyXHPn9kttT6OZ6NCwcFpQTPf73xhBWWW9vm
Rfl35j180jsh42CNn8IhlNsa4If8TA==
=Xtmc
-----END PGP SIGNATURE-----

--I3TnsRBe02/VN2xi--

