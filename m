Return-Path: <linux-pm+bounces-22031-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47621A34F64
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 21:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2D13ADC57
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 20:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321A62661A2;
	Thu, 13 Feb 2025 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFRcPhLy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E5A245B1B;
	Thu, 13 Feb 2025 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739478610; cv=none; b=Hqhai9n+EIeGtSmedPHKpBtAZeAAAxYaL1Gt4ZYuo5m7tq0Y28JatyWQv7XeSPOneb1LtKXHb2bwyU3ASbjpCq5eBu6U6hp1/gd/+MnvTq9qL9TYwKKGwIg/IScnl6KGwnR0dDE32DRrNPfQFtCuPKw68+WORi6pemyMaE6/VLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739478610; c=relaxed/simple;
	bh=uyWlRmXMXeDRjKN/QUZuzNs4AKAFWK4bYiZ6ygpiavw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaLeOOEwqIujP0meYkPxEFqtpffCVfVpGsbxeluy7LWKj/ZekJBxbQgWfRCfXwyLP/S3WEnMyPfWdUd3oJxtLR33xHfsOCCC+Wrj0LreR+DXyHfD6TGwzOSLrIyZ+DAa7t9IuKQDlLMwO8vhYcfw5RS5mLveBQhkBHYNT4h6ldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFRcPhLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AC9C4CED1;
	Thu, 13 Feb 2025 20:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739478609;
	bh=uyWlRmXMXeDRjKN/QUZuzNs4AKAFWK4bYiZ6ygpiavw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AFRcPhLyZikC9/6PqjY8KJrAgqbk0gOkYLwYjOSsJen/HfJFjW61itYcER1NPRrJf
	 eAx/eaUN9USWPphz671vKhfECtHB/bPOgxqkS1RcJ77quZdGdPI8yRIo3ZGeiVQirM
	 hTw7VVo2ybfj/xwwLw4nhb4MZA3O6LYtWTxSY8IG8sO+U3oJx6FpzvwXcOe+JmlWoc
	 h8dXoATZ2dQrMsnSKFjFLtO0btzFLfiOB2eLF1QIA1U6J8LIY5+XQcqwMLYbE8o17T
	 XIwaezxQdCnBVJ6AiEYUOcHjsB5VC/+yBrQOfEP9Ka3EC41IIOsq08zxT/NI873UTj
	 jN+a9yU6C8Oqw==
Date: Thu, 13 Feb 2025 20:30:04 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ryan.Wanner@microchip.com, lee@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, claudiu.beznea@tuxon.dev,
	sre@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, p.zabel@pengutronix.de,
	linux@armlinux.org.uk, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 02/15] dt-bindings: mfd: syscon: add
 microchip,sama7d65-sfrbu
Message-ID: <20250213-shrouded-carnage-65e11cff5bb4@spud>
References: <cover.1739221064.git.Ryan.Wanner@microchip.com>
 <4cac19e32295c708d72b9fc6ba342b5c961fb6c3.1739221064.git.Ryan.Wanner@microchip.com>
 <20250211-therapeutic-futuristic-parakeet-204cae@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HXlCXwCYNYh2B+qP"
Content-Disposition: inline
In-Reply-To: <20250211-therapeutic-futuristic-parakeet-204cae@krzk-bin>


--HXlCXwCYNYh2B+qP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 09:14:05AM +0100, Krzysztof Kozlowski wrote:
> On Mon, Feb 10, 2025 at 02:13:02PM -0700, Ryan.Wanner@microchip.com wrote:
> > From: Ryan Wanner <Ryan.Wanner@microchip.com>
> >=20
> > Add SAMA7D65 SFRBU compatible string to DT bindings documentation
> >=20
> > Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Docume=
ntation/devicetree/bindings/mfd/syscon.yaml
> > index 51d896c88dafa..727292ffe092e 100644
> > --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> > @@ -91,6 +91,7 @@ select:
> >            - microchip,mpfs-sysreg-scb
> >            - microchip,sam9x60-sfr
> >            - microchip,sama7d65-ddr3phy
> > +          - microchip,sama7d65-sfrbu
>=20
> You got comment on #1 of your v1, so if you make exactly the same
> mistake in other patches then fix it there as well.
>=20
> Apply v1 Rob's comments to all your patches.

Actually, this patch v1 did put it in both lists, but here it got
dropped from the second list:
https://lore.kernel.org/all/20250130233431.GB1868322-robh@kernel.org/

--HXlCXwCYNYh2B+qP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ65WTAAKCRB4tDGHoIJi
0kVRAQDXcFGQWxRkf6rUQyT1YQd5ec+0uVx8aLWtL0v8PANMVAD/dw9OVEVJxTSD
cWfK2bjdj7nz/WVP88GLvUJRr54Wmgo=
=110u
-----END PGP SIGNATURE-----

--HXlCXwCYNYh2B+qP--

