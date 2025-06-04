Return-Path: <linux-pm+bounces-28113-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB57CACE03A
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 16:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B58E172BFF
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 14:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EF528FAA2;
	Wed,  4 Jun 2025 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsCT1YoN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E22624B26;
	Wed,  4 Jun 2025 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749047135; cv=none; b=OoQUcbU52cYAwNNew4qTu1PD+PxbgjnHkmatCwTK3+XV3mTEKIOtzlcWzmQQlS5q3UUATjNrS+aABQG7JrEI9NhRJk9AVgfILDCgKss7m8bp0D6NasOzVgCjwIO0vkvwzfHeleOCzsMFdS//jLIRWCbdC8Xje2CwYlpYaAa4FaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749047135; c=relaxed/simple;
	bh=Rj2/ruFOKQorwxIO/Q4QbkwEcBo2WBVADSmD3EOg3d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oehjLihJlauYejIIXht7Nto3MQ5EsYKXdQOCeFtWbne7Yng/MkNzDMs1vOgzwSnVb7ksnNx+GBASLAu0Qx7rvc+7npw7s8tv+lgfRxlfI4BWhWrCCDutMONhUQnwspvy8mpAhawimYxHxBAqkpIq8CffuGSYbaVcXWRMsaOEiBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsCT1YoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0504DC4CEE4;
	Wed,  4 Jun 2025 14:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749047134;
	bh=Rj2/ruFOKQorwxIO/Q4QbkwEcBo2WBVADSmD3EOg3d4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qsCT1YoNWD4jDyioy4d+KlZSuwv6QyqIGjfol19SEqUFMOc/WMrtrDcNyYGmH+WnC
	 NQIfTVvdoW3bCbmNA0ASXSWxERQ7thaSULcS/HXGydrF8yNQ+kaJnj+bbGy2Cv6u0n
	 n0N3mqNyHPKbmizKmLsRS+yhSZJJXZJ/5sGlsMeL2UutS16XbkWBdgVvHJi5xEvyZg
	 f+XD2b72d8ZEMP91QTev/FLJXTM4vWThZYeT3Jx84QGnBb5MIPd5Zkx9dUbl1Laon7
	 yB1G76YbCChFaowiaAC7FpmXzzPwuyFONjIqW6925Q7Kwp2OsWXklX9l7DOmDTqPFg
	 g+WEIyYLvPhDg==
Date: Wed, 4 Jun 2025 15:25:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
	Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v4 3/6] regulator: pf1550: add support for regulator
Message-ID: <f2064326-e696-48cc-8f0e-5e51c95548b5@sirena.org.uk>
References: <20250603-pf1550-v4-0-bfdf51ee59cc@savoirfairelinux.com>
 <20250603-pf1550-v4-3-bfdf51ee59cc@savoirfairelinux.com>
 <eb1fb4e2-42aa-4795-bc6c-dbcf1fa04f11@sirena.org.uk>
 <aEBSSHA8bxw2igAW@fedora>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LeZqoxaN4Nid9bpS"
Content-Disposition: inline
In-Reply-To: <aEBSSHA8bxw2igAW@fedora>
X-Cookie: Non-sequiturs make me eat lampshades.


--LeZqoxaN4Nid9bpS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 04, 2025 at 10:03:52AM -0400, Samuel Kayode wrote:
> On Wed, Jun 04, 2025 at 12:35:21PM +0100, Mark Brown wrote:

> > > +	switch (irq_type) {
> > > +	case PF1550_PMIC_IRQ_SW1_LS:
> > > +		event = REGULATOR_EVENT_OVER_CURRENT;
> > > +	case PF1550_PMIC_IRQ_SW1_HS:
> > > +		event = REGULATOR_EVENT_OVER_CURRENT;
> > > +	case PF1550_PMIC_IRQ_LDO1_FAULT:
> > > +		event = REGULATOR_EVENT_OVER_CURRENT;

> > You appear to be flagging all these events as over current events which
> > doesn't seem entirely plausible.

> It does seem like it but the manual describes these interrupts as "current limit
> interrupt". The interrupts ending in _LS are "low-side current limit interrupt",
> _HS are "high-side current limit interrupt" and _FAULT are "current limit fault
> interrupt".

That at least needs some comments I think, and for the _LS while it's
hard to parse what "low side" means my guess would be that it's a
warning to match the other interrupt being the actual error.

--LeZqoxaN4Nid9bpS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhAV1gACgkQJNaLcl1U
h9A44Af/aPWc+RQEJQ4xYMYmCbH4Fi/ZIzfT1qLksu73+7JtX4xSsy1ow2vtuYTV
Dtkvg9UYeNJ0aJlcHzwqI/fxC68jgwqgZBYMCYuUqEDdNUqq/Be9nCf0tonft6kI
JkjPKy4Cc4P9Gt2SYovWRGn6qLW7MME8mSsBTh4XLDY7BQZCfKwel0n7bylt6QEy
OO0PU1QgzRlLk/s66ysVGDPkeVV4jKV9YpejzCV4WQ83yRWY45kHXEPvUtF9NzfI
tTX34J49/IpmN37m5zT/znhyNgMjJvjqfzxXK4COp40DelsYxaWeU42A+LDI9x+X
futIraVxzEJC8amaHr0fhdXW5dJDoQ==
=Lh6W
-----END PGP SIGNATURE-----

--LeZqoxaN4Nid9bpS--

