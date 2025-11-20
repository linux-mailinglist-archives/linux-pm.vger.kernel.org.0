Return-Path: <linux-pm+bounces-38274-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 56865C72C78
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 09:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id E4F382E83D
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 08:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6809130E83E;
	Thu, 20 Nov 2025 08:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jqZUis5L"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0372D7DFE
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763626822; cv=none; b=XoiCPI/5oVsUlePieNVQfn2BwYSILAwmmkfsPutZ4KgelX2qyuTEywvmKS9sD52U6bu9XpBviA53C2HOv02KT2fVdmLkLBfDVPraH3T0eKyxpdI3KRmGS6Jv2SEs2nS7FAhQqajAd9dcrgESPzvwdkCPValOKfvwWEspbgAtgrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763626822; c=relaxed/simple;
	bh=aAbpWqgepbtVKvWYVnx379/SRuNzsNg3VVyMboOHCMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHsCH5c/cOVrEIVdsQt6j9/EJGOZBJFmXyVITWsDYowlN73Uw3/ptCuIi5NnwDMOfGQ/xPPeueBrD+TLefSgXbKgBpuUe61umYZolB24l0M56aQlvdlVLQi5OOYRXwb8PmtPlKAL4PcwMVxDAsWjiLxk4BV2deW/z5o2g9MoYzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jqZUis5L; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Nov 2025 10:20:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763626818; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=knQ5UjhNY33KSuYCOI7qX+iC/+OHsI1W08BpQ5DPKSY=;
	b=jqZUis5LLIc4XcFM3mK6L1f/K6c5/qvZ6P+vLDAUqKI4pGIWEyaTRd95EI+B15H/cvUSAz
	WpjsGe3Gwz1KqGIJl3Bmd/PdASbQ8o6HI5EkHeH31S670f99cjtNzMMtWudcPytVub6PAM
	DUwncMy6ipPkZpqARBggeR7iEsg7Lhw=
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
Subject: [PATCH v5 03/16] dt-bindings: battery: Add trickle-charge upper limit
Message-ID: <2d039b43e515d5f1002e0bd7a00f9a38e9d3f607.1763625920.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1763625920.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="scDFr1E0gJ4xiYOH"
Content-Disposition: inline
In-Reply-To: <cover.1763625920.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--scDFr1E0gJ4xiYOH
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


--scDFr1E0gJ4xiYOH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkezzsACgkQeFA3/03a
ocVg0ggAgbNC2mfEaOkwJQIBORSN2oTGtD7S7ATr0W8Odmiiv7b7A4GkmaPweuh8
GDWHD8qhWB+7UkaHQ57x7cCQ41f6BTNNKyqVbqKMqdiOjMdl+rHSYkOh92E2MNsa
ajyYNbjrOzY1zgLS0rU6V2OtPgb5cWsi3Yxc2e6Wh3InuJgLrzOzXDxcwoU+HOiF
+QDX+LVvDh6SYulFzHKUInyUN/eTbpKhkRxVsfLoZElLWCdafWxKtpTqZPCUtcwj
G2wTuSeMBUVZl7AqAAdObGF3/9m1GnD1o+Hhrj2aL+cyObIeSSHNXz+rRH6JkWK2
eWLarkxQc+nQJcH7lqjSM8dYCm1DbQ==
=RmHJ
-----END PGP SIGNATURE-----

--scDFr1E0gJ4xiYOH--

