Return-Path: <linux-pm+bounces-8731-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5C08FF368
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 19:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8CB3B261B6
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 17:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE3D196DA2;
	Thu,  6 Jun 2024 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psnUEsSe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EA43AC2E;
	Thu,  6 Jun 2024 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717693537; cv=none; b=DDwviDSluJwGo/NJpjQNFAAvIm3rYMGBL8hGF319VfErBNGI/HtSTbTHgjPLUd+VNusnD1waku1FTaoxFmb7mgPn2c8SIm7C7PJVI0SMLAHi3j77wIgVUujWrjBz+X8ehPbw920YhWMqAaqzYztLGzyp2pHkSgmYEoI3D9+gRKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717693537; c=relaxed/simple;
	bh=12E14gZ2QAVnMNIwYrxVZwM9VywDI+b+6wOtVi7+4Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PACHe4Eiu2zBpHI086vYyhZVNvg++dvdCiMcD++kCXBFTKJ/5kBkzl1hzGd6b4LWXOmoc93Rl+oDCp5LcbxcBAl9ZaTIVbXrBBU4fgHR79UaIGHnz2a5anSzbBNzBbCwIlZZSECqDymFIRhpBcILGeW4p3fAlvbT8/L+qJ0sTyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psnUEsSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0329C32782;
	Thu,  6 Jun 2024 17:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717693536;
	bh=12E14gZ2QAVnMNIwYrxVZwM9VywDI+b+6wOtVi7+4Qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=psnUEsSea+eKkkjw5n7TpdK5/LBJ1+DobMAK6WYLPPxBBfQ+EBq0vBV2RZiU4D7I0
	 fcoIzRVXWRhVpXPqbryYVLeyDUuVhgBNuKNLES386QFENIiVFrER26zRLtKVolmLuQ
	 rw5B4f3jLDzwsQhNE570Q+IUuDKD1m61O3LRD0Q5TwQrqyPgxtY63n6FsQhCnmD2yS
	 MwvQ5RxGe6jq5oEdp/RGBRodueLukB2iS2YIDY8XzkjlPOFzj1OJLETDI6g2ZTIeIY
	 hAepgIuESGPbYrZOe7w4pI8H+InLbYomIEWsrIAYdLdxOKpVElqruG0/RY5P5iV9Yr
	 3DXThSnx6yBMg==
Date: Thu, 6 Jun 2024 18:05:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Haylen Chu <heylenay@outlook.com>
Cc: Inochi Amaoto <inochiama@outlook.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: thermal: sophgo,cv180x-thermal: Add
 Sophgo CV180x thermal
Message-ID: <20240606-reaction-thirsting-8c22d1b5ab72@spud>
References: <SG2PR01MB4218013241B3EED779D3BAE8D7F82@SG2PR01MB4218.apcprd01.prod.exchangelabs.com>
 <SG2PR01MB42189977B4172405F5704CC4D7F82@SG2PR01MB4218.apcprd01.prod.exchangelabs.com>
 <IA1PR20MB49531F55C8D7DC5D0050CAF9BBF92@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240605-tightwad-janitor-82cfceb1469d@spud>
 <SEYPR01MB4221F0E46F600E013974F21BD7FA2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xNgNBLWP/RMLxW5/"
Content-Disposition: inline
In-Reply-To: <SEYPR01MB4221F0E46F600E013974F21BD7FA2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>


--xNgNBLWP/RMLxW5/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 01:32:46PM +0000, Haylen Chu wrote:
> On Wed, Jun 05, 2024 at 06:54:17PM +0100, Conor Dooley wrote:
> > > > +  accumulation-period:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description: Accumulation period for a sample
> > > > +    oneOf:
> > > > +      - const: 0
> > > > +        description: 512 ticks
> > > > +      - const: 1
> > > > +        description: 1024 ticks
> > > > +      - const: 2
> > > > +        description: 2048 ticks
> > > > +      - const: 3
> > > > +        description: 4096 ticks
> > > > +    default: 2
> > > > +
> > > > +  chop-period:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description: ADC chop period
> >=20
> > What's a "chop" and why is either this or the accumulation-period a
> > fixed property of the hardware? Shouldn't this choice really be up to
> > the user?
>=20
> The chop-period is an ADC parameter.
>=20
> Both accumulation-period and chop-period specify how the sensor
> measures temperature. Making these parameters up to end users brings
> extra unnecessary code complexity. Being configurable for each board
> should be enough and other thermal drivers have been doing things in
> this way.

Other systems may well have properties for this, but something being
done in the past doesn't mean it might be the right thing to do now.
I don't really buy that this is something you set to a fixed value per
board, but rather the use case of a particular board would factor into
whether or not you would want to use a shorter or longer accumulation
period.

> > > > +    oneOf:
> > > > +      - const: 0
> > > > +        description: 128 ticks
> > > > +      - const: 1
> > > > +        description: 256 ticks
> > > > +      - const: 2
> > > > +        description: 512 ticks
> > > > +      - const: 3
> > > > +        description: 1024 ticks
> >=20
> > Can we just make the number of ticks the unit here, and above?
> > Also, a "oneOf: - const" structure is just an enum.
>=20
> I do not catch your idea. These values directly map to raw register
> configuration, which simplify the implementation a lot.

It should be trivial to convert them to register values in your driver.

> > > > +    default: 3
> > > > +
> > > > +  sample-cycle-us:
> > > > +    description: Period between samples
> > > > +    default: 1000000
> > No constraints?
>=20
> Sample cycle is more flexible because of hardware designing.

It quite likely has constraints, flexible or not. Is the hardware
capable of both 1 us and uint32_max us?

Thanks,
Conor.

--xNgNBLWP/RMLxW5/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmHsWgAKCRB4tDGHoIJi
0vG7AP48IalU1RGZ/KbtaGu/vPghK4eP4Nk9f7t4VJwKdTosBwD9F3Yrkl2G2Ylr
82IeEwZmoQQrxmHthTZEV+dAIf6BJQk=
=4835
-----END PGP SIGNATURE-----

--xNgNBLWP/RMLxW5/--

