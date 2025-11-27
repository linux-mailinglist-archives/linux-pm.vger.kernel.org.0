Return-Path: <linux-pm+bounces-38778-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A78C8DF13
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 12:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567663B23E9
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 11:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FD432C329;
	Thu, 27 Nov 2025 11:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DQlOlvc5"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9132EAB99
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 11:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764242262; cv=none; b=nv0YX1mPAkVcxTrFDrBeOC3HwCyWyz0V8+U5NPqqNNTbU+2eIoNIM7XsRzQ1qrr4BfHjq+H5x6AkplgbtKGSkkArBViGy4pzQBf2wEO4BSMXWjnwFaRw77AXi5V8oAn1TmJ3vNzr5AcIsVKVX5YEPqUjocdCkebNcU9AzF4dFoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764242262; c=relaxed/simple;
	bh=1ttsat/jPKf899mRRvtw0D3P1+r+ktDiUe9wpTnbql4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1Hjcr0505yVhomckmwvA4bUJfITKH8Tc58Rhsjnao7G5MsIE0IVbzIEReIOCKsrLS5UDH/R157xafeVYnhuAd05mfSyxY8iFrv5ZZJHfSZfo24Hku4+9zecjpEZ1+APBxhSb8B0OJNniAaYCZ8QS+uyksOUjlQIf/hV9+QKnuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DQlOlvc5; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Nov 2025 13:17:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764242248; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=fD3g84zpY4aCBkCNVfCeTN6fl8TdpnZZa4yMv+Yb+FY=;
	b=DQlOlvc5CBfbuMh//QADx9eZqS7DF2dxly3xomvrzVLx1WUR+8YuoMrcc9BDBv5wtK1mjx
	LrOSUtHvhJiXxrKBHnQBW1JTBid9PDxOUxKsb4kI1cFdFTEGMAS5SCVqYfES2pS5DRFgd8
	ghw0NG+jFY4mTX/evx5eGkNWV3aavng=
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
Subject: [PATCH v6 02/17] dt-bindings: battery: Clarify trickle-charge
Message-ID: <0b12e7761c670b228f3a4c49736c838a38fbcc81.1764241265.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1764241265.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J+hojSfgTMxoqjet"
Content-Disposition: inline
In-Reply-To: <cover.1764241265.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--J+hojSfgTMxoqjet
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


--J+hojSfgTMxoqjet
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkoMzwACgkQeFA3/03a
ocWuagf+OANh3T6thYeCOJyOnKgiXi4eEVKXveFA/EXasSe39O24pZDYAfJofA7F
YWAmWrt5i02osMr4krYPC7Zm+x/15DsUL2ETxGQjeScCMza4F9u8fQ7j2JhO6eFJ
PRWwyJEuHfuf/eDM3TTobvt84a2cR+Lb6RKNmnzTgJMxMc7W9Q7yoMeCkHc2njcN
Dg+9qhrgePdFUqmbmobcqOChEMKlUqZMf38/lv7gRMjNQxN69GTKOVTb3Xid/sIQ
ML3cxFYliFtjpwfuDZzFk6kZAEdzWUcfDEghU/Lvl0uieAjwSpx9PUujjtxjrk9h
nnqzpcu3W+sIbatQleLoUqPjZvNSCg==
=m0Uw
-----END PGP SIGNATURE-----

--J+hojSfgTMxoqjet--

