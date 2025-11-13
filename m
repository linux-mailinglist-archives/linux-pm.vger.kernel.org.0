Return-Path: <linux-pm+bounces-37918-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCA0C56636
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 09:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE283BA694
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 08:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E488F333757;
	Thu, 13 Nov 2025 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lwyyTHOK"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F6F333753
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023935; cv=none; b=Eho7hkEswPBgqH2yOAdt+hhsTV5Q7iVmol7NrCPlK/21LavRkW8E7GWQs1AY3S+xvwHODwfYLbOsQSHmGuCRffU9d1FM9gElg/jNNeYPwf59+Bv3SaQF7tZVp2VDFdkG1gsAcL4eK5tSpXH8sZw0HHKM1jsAe6HajkZFdu/u5ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023935; c=relaxed/simple;
	bh=YlJJuk5N5mBnKpxGrdq20hUxrtgBhTJK4SCKYl/2W2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvgoHE9RjYrdJRMMGcILeFA49AsBBZUrHs58xO4IY9u14u1uJgf/pifNUS6T6b93ja9w/lEkvS3ctBp9wLbd/JEkx8zQCkuSECGIVEJjsj9BB31VXlYa6Bp6KFwYo2oCN/m+E29r9EyXbaclPXqz4ee8y30lgm4J/nunpJKyyZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lwyyTHOK; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 13 Nov 2025 10:52:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763023932; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=7nAK7H7KAJNuUJL99/a2htshLv3964/hsXXnW93gtDs=;
	b=lwyyTHOKzUt/4NpAASZrIpugLaz8LCEGAFyJ/rV+cIqagvuBKYhcPTfFFRHzT7VvWuyfgI
	Vj3DT2s3TjUN7cE36G5JkI9zHplqOR219BiJg8FADPwSSOEdHDnXhL+ARuDbb6BHWzlR/L
	QE9e+BLac5BDe4YsyzjV7Z9GBSvVk1Q=
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
Subject: [PATCH v4 03/16] dt-bindings: battery: Add trickle-charge upper limit
Message-ID: <97d97e19d67b472ee7db4a88607e7589fdca791d.1763022807.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1763022807.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y2Owh/m8rgmrwCNF"
Content-Disposition: inline
In-Reply-To: <cover.1763022807.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--y2Owh/m8rgmrwCNF
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
2.51.1


--y2Owh/m8rgmrwCNF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkVnDEACgkQeFA3/03a
ocVrWgf/d4DFYFEm80FUKYIgBbs8zWbMq4JHUb4QrdeS5KkgZlD4vsCHtTGbg/Oc
Mws0Mq28fojjASpdjYACM8B7Y2jHmk3WAkpQTILyXvPk4K+PsWW36DjqfGsoOI+r
li/5Pw3VLUUhXGApyiv3VaPfFwv/1cnIE7lTBLAjYkW1z1aS8YEgwYvvtfXc4wYH
I3g/aIAedOjttHoa0FTt4aBpBUTGai4Ds7F4YksV0A2+8IDlLEfZVie0uAYLQ9lx
wnH4V2k8zt8Xx1vowmtHr8OM5ov0yuHhU5WlLBtx9XmPi3GhKK1rR/enle7VMIme
B/nrNIx9RYrQtYMw1nj6aFzdaafImg==
=+2la
-----END PGP SIGNATURE-----

--y2Owh/m8rgmrwCNF--

