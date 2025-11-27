Return-Path: <linux-pm+bounces-38779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D8579C8DF04
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 12:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8371734D571
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 11:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8418632D0CA;
	Thu, 27 Nov 2025 11:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jRmRBqV4"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C600532C95C;
	Thu, 27 Nov 2025 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764242267; cv=none; b=he/uh50js85AUrQT/6TvYpCo39DEWCTyjRAECUWiMn3ILvzQJ3bn/9LbPwAhVUP+2+GAe+EiX4FAglrDHQqsVmi1f5r7x7FWAa7D/vYjvFKGC0DWagrtj/EWCTGnh7aASwntgSscTJbqN8cYtkUQKu9y191N8iAg4ByWInCIuSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764242267; c=relaxed/simple;
	bh=BunQgIs1hz9aWO1t8wn25ezluJyW9YuugT7Eaaz8iLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IO49UZnDrIKu6fW1+hKxsG4EvN0bK3yfQ2Vp4kwxhJce6Dcg4bPAj8Q3ftghYnSDzM4X4g9XI+JrWbYLVpD5ZMpS1ORAC78NB4/5lJxaMEsEizMXO1sxOc/6ybUh6L9NHgHQjPgVN4amEr7aJfWyEELhXzWkJcww6436o7bB6uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jRmRBqV4; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Nov 2025 13:17:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764242262; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=YucvTZ1zz2bcpv6pPb4f65IkkX5qb03t7H4f9XgAKnM=;
	b=jRmRBqV4pW1QsAFV/Ca72vRm8AJI8779atSELe1lLnCS3u6s/q3P7KYZN6RDzqKBOM54fZ
	Gng2YLyoLZzgtg05HIbFKb89bauqEKA/V5LjMmQUmDTmVwiej7y+WSB4SqlhLjF1mEMoFq
	PgxAalYzM98EgaQjQvq6GQ/gL15TQLI=
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
Subject: [PATCH v6 03/17] dt-bindings: battery: Add trickle-charge upper limit
Message-ID: <2d039b43e515d5f1002e0bd7a00f9a38e9d3f607.1764241265.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1764241265.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iWBEmXgzGg9M4W5Y"
Content-Disposition: inline
In-Reply-To: <cover.1764241265.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--iWBEmXgzGg9M4W5Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

Some of the chargers for lithium-ion batteries use a trickle-charging as
a first charging phase for very empty batteries, to "wake-up" the battery.
Trickle-charging is a low current, constant current phase. After the
voltage of the very empty battery has reached an upper limit for
trickle charging, the pre-charge phase is started with a higher current.

Allow defining the upper limit for trickle charging voltage, after which
the charging should be changed to the pre-charging.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---
Revision history:
 v3 =3D> :
 - No changes

 v2 =3D> v3:
 - Clarify the 'trickle-charging' the property refers to is the
   "pre-pre" -phase charging.

 RFCv1 =3D> v2:
 - No changes
---
 Documentation/devicetree/bindings/power/supply/battery.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml b/=
Documentation/devicetree/bindings/power/supply/battery.yaml
index bfb7b716ae13..d1a2080557a0 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
@@ -71,6 +71,10 @@ properties:
       NiMh bq24400) - that is different and not controlled by this
       property.
=20
+  tricklecharge-upper-limit-microvolt:
+    description: limit when to change to precharge from trickle charge
+      Trickle-charging here refers "wake-up" or "pre-pre" -charging.
+
   precharge-current-microamp:
     description: current for pre-charge phase
=20
--=20
2.52.0


--iWBEmXgzGg9M4W5Y
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkoM1AACgkQeFA3/03a
ocV02Af/fhrhZUkS9ALRCQdVgj1n6YTlF6YLeuSX6Fj9Q06eBDllq0q4hHzrv9xn
5lXLh6/YYk9A0sMDEH6zRBjy3J5eY0V8Mqv36gvfMfqhqvPW5UbVIx2c94i6LoRa
HxSawOS5RwBV/rm7ZU/s4/TmFxwFaqeLYO3Xo5OYzQSi3NHCEjHu5O9GcmcGu4E6
2PDSzTAvDaXCJusVAMsB2x28WX7haOlQpB4f+hypaa/nJVrsP0tNX9u/4btlu5qZ
vyCRPeNL6wx5tPoivBIjU0O8XxbIY+Baw0skZUIO4N8Mp2c08WWXbyESqAvIS+d0
UgJbJOOQgulYu+49w1y0UuXWAqX+oQ==
=qhVV
-----END PGP SIGNATURE-----

--iWBEmXgzGg9M4W5Y--

