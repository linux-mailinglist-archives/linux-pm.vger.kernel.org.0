Return-Path: <linux-pm+bounces-39560-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 974FBCBE013
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 14:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB0A4303C9D6
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 13:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFFF2DF130;
	Mon, 15 Dec 2025 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t9cXS2PR"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286FF2DAFDA;
	Mon, 15 Dec 2025 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765804690; cv=none; b=aIOxl6Yw2snGsYdozz1NizE/Od5WkiYTjUzaYReujrmIWrz+qa2IWBGalFkqucYDMxLxnOMygVNTOtNp8u0rRf33qudPYFbVMHjvLX0ItJCTKJZ+bhUh/NYyeERajLhEZFhJgPgK1MOFLMf2l+8sjAgvrE1ltABEYmY/ZwZmpTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765804690; c=relaxed/simple;
	bh=h9Zef/uHFUhBBWMZu79j8NVQzZMPJTz4vaF15xu8VzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UO15458yOccfg1KwANf5dlOqPCvKtnPHuUYAFJeoSoVaxev+oVknvEd/OUDrDPrLsOznu66NO5Jo+LU1aqzH2nE0UjlIOSZmkGrILAPwbEs02bItdbe3nqRBE2Fwv+gNIanHpGKUWA6fteNk95t7bxfIyXNxSDdX4kck2NkSvMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t9cXS2PR; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 15 Dec 2025 15:17:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765804680; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=PxMqs7Hjz6o6kjWDDq1RNqTyYND+1RwU//dXvpr/p3o=;
	b=t9cXS2PR7eWg5MHv6vHG8w8UGYafNTEH12TT3drM/qfyfoN9ORHQ6HTJLbf96v8he4oPK2
	guyJPjFapzOpe1UnQtsbZeZSbzrLnsj46a3QENFpw+7MrfNq0h8xqmWFaa7qiWiiGzXlM3
	pOLVgFDXt2s1LaMkVnbeW6CT1nzj5yo=
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
Subject: [PATCH RESEND v6 03/17] dt-bindings: battery: Add trickle-charge
 upper limit
Message-ID: <9c3064ec7e32cda442336bf633fb93355ce6a97d.1765804226.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1765804226.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Zsxot14ruzf+19Ka"
Content-Disposition: inline
In-Reply-To: <cover.1765804226.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--Zsxot14ruzf+19Ka
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


--Zsxot14ruzf+19Ka
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmlACoEACgkQeFA3/03a
ocXwGggAkAJOkAse9cYUNXx7azPdc+d3b/i91h01w+q/dyiHLwQuHPieREdnWyup
Mc7NK982SY6yJbSUwDx1CQkn9aMgWHumxD+3Q6Mx5Nq+fkJ9t6XHtggrFk6fimfI
dGOvJ/pHTaZTRuszmGaeb6LA3o330dsHHz27nb5IgFSIDcBWw8TbKqvpnSQxNBNw
4ByoS7hJ0vVWOdQUEKaCYdInyPsJzE/g4P+ZD0URZNYEl7gj2O1iRSYAmVVlq5ia
Fe5ocz5+kEMpkd/JAMSc6BbbvdfbKiXIYw4tCJoZxncVQ29dYGkwWB3V2MS+CuH+
V7iNQr4xK+L3RMUvC4HvVVTzwI13TQ==
=mCtW
-----END PGP SIGNATURE-----

--Zsxot14ruzf+19Ka--

