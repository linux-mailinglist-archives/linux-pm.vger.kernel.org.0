Return-Path: <linux-pm+bounces-19221-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 851C09F1845
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 23:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8878166937
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 22:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2E718FC89;
	Fri, 13 Dec 2024 22:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EL3hq83d"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09581DA4E;
	Fri, 13 Dec 2024 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734127301; cv=none; b=FN2xC1JhGkvWM/gwMAhAaAf3cxDQ4fzwjPpfQP/oAeqdyohxtywxSliMAyzTNIdKb6suRpAwzon4rVRoO+ciAil/N0xGA8tiXzpqLbEdIk1+hurFF+Qf8yRSq0J4wkaVKySX0FC5uRzlXxEbC+H/rbuBvwDRvSkdPmm21bAdqBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734127301; c=relaxed/simple;
	bh=DAYWgjbpzdwfTbL6Q4+XD5NxSEJ76iHQuJ0aIVL25+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8BFViPTKlnzo3ifN45usoI0FpZa6dJwuivQdMDjcgHN+FjszXEvkvWsnTxT3R4CG8ovYg68pq/A6XnUXZKy4cQzwXVNjAesPEBHVAgN1uYutJp9TySg3hGg4Dd7Geqvdt5pUWzy5abRLqYuCdwBDsuS9w1p5JDhA0X2q9wFR2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EL3hq83d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354E4C4CED6;
	Fri, 13 Dec 2024 22:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734127300;
	bh=DAYWgjbpzdwfTbL6Q4+XD5NxSEJ76iHQuJ0aIVL25+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EL3hq83dxp6IU4BETWH43koxDKv17qkSQ81KJqxCyzmxFmWdw8Q1QEBNvImUoNe1s
	 ilGOE81TFWoLYJtcRhy2YQJXVIOS2eHk5YsX8OjVrRlLfQf37ULe6ESpKImAQwjF20
	 rXLZp90b9AUNzfy+UOEY510bP7sdWyYq7TLxqPDDm1K9icJa6gI02ct96UyI5AQrnf
	 Byqokq5pEkJhy1f3594kShtSa42RAGZgHw2dadVaiiTfgax2P1gia0ZI6xPE44evCT
	 Gx0BhG7UNx8d5dkb6Rrg731CBHxSUSkkNY8SqH3DEpJSwcujnqH8ntrkR7phxtSt2e
	 Qw/4xjyHAx6DQ==
Received: by mercury (Postfix, from userid 1000)
	id 6411310604D3; Fri, 13 Dec 2024 23:01:37 +0100 (CET)
Date: Fri, 13 Dec 2024 23:01:37 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Kim Seer Paller <kimseer.paller@analog.com>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v6 2/2] power/supply: Add support for ltc4162-f/s and
 ltc4015
Message-ID: <v4apnrdr2ydc3jpuiqfqk4ttof45zj37wpm5vr3u4w3drtfbl7@wk7khzxnfg3q>
References: <20241213023746.34168-1-kimseer.paller@analog.com>
 <20241213023746.34168-3-kimseer.paller@analog.com>
 <723a8253-a936-4901-9a05-a20f27fdb07c@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fephdck4dwpqzcfc"
Content-Disposition: inline
In-Reply-To: <723a8253-a936-4901-9a05-a20f27fdb07c@wanadoo.fr>


--fephdck4dwpqzcfc
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 2/2] power/supply: Add support for ltc4162-f/s and
 ltc4015
MIME-Version: 1.0

Hi,

On Fri, Dec 13, 2024 at 07:31:45PM +0100, Christophe JAILLET wrote:
> Le 13/12/2024 =E0 03:37, Kim Seer Paller a =E9crit=A0:
> > LTC4162-L 35V/3.2A Multi-Cell Lithium-Ion Step-Down Battery Charger
> > LTC4162-F 35V/3.2A Multi-Cell LiFePO4 Step-Down Battery Charger
> > LTC4162-S 35V/3.2A Lead-Acid Step-Down Battery Charger
> > LTC4015 35V/3.2A Multichemistry Buck Battery Charger Controller
>=20
> ...
>=20
> > +static int ltc4015_get_vcharge(struct ltc4162l_info *info,
> > +			       unsigned int reg,
> > +			       union power_supply_propval *val)
> >   {
> > -	u8 cell_count =3D ltc4162l_get_cell_count(info);
> > +	unsigned int regval, chem_type;
> > +	int ret;
> > +	u32 voltage;
> > +
> > +	ret =3D regmap_read(info->regmap, reg, &regval);
> > +	if (ret)
> > +		return ret;
> > -	if (!cell_count)
> > -		return -EBUSY; /* Not available yet, try again later */
> > +	regval &=3D BIT(6) - 1; /* Only the lower 5 bits */
>=20
> Nitpick, should there be a v7:
> 	Would using GENMASK(5, 0) be clearer and self-explanatory?

I merged the driver, but getting a follow-up patch with this change
would be nice :)

-- Sebastian

>=20
> > +
> > +	/*
> > +	 * charge voltage setting can be computed from:
> > +	 * cell_count =D7 (vcharge_setting =D7 a + b)
> > +	 * where vcharge_setting ranges from 0 to c (d).
> ...
>=20
> CJ
>=20

--fephdck4dwpqzcfc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdcrroACgkQ2O7X88g7
+prGJQ/7BwF5dLIDqN0sCRSaskwIpW+2+zx+UmFZ8bnKP8ZqmPhHCeyrm0VT0Whg
OJS477D/IHBW8CJeTYF6vm61cVsVg1Ee4pqLsEcgyi7ivOL7aYD3Hb15EZ6jrvhb
twXBY3VQcIbrw0js61DemMR+U1THsEq9D0x1vCxoBJbtIRkYJTJtRksUGMQK4oer
ymmreZJUJ2kJhU2ctDSAlTlWhEBWmczPxjuhknQF7iM4oJAkcNIT/z4cQyGOPCGh
ORJQpc+GXgmSr87MZvPNTbpW0fJm0DXtosk4B25Oyev0tr4khBnRmLE1b8NzgZpR
pBJ/CJ/GJ2jr+wn/9aVt0HhRWPUtpxb/MZpXkqeQtXtt1guHmmp6wnHK7mbwzAJk
EQ7akhDLLquuAdHe4F3LEPuW0eA3f+8wmqJB23/R/lHt4QAAFP0BzaHu1TYo8gq0
7qMuZgTcnLSTO223XyeFSg3BBABuec0V5m8TiduHNI0q5piL0ztx5Z5Jv3Q58fLu
R6lLW1EmDA8I0iaScl6QDfLD5Z40rlX2o3x1TX6KCSikQZ8nD2R1lCA3w7NQ0Vi/
o1nI9VPT1OO35keKWDv0dawsW8Z+t35aZx1wkzBTWiVZ6T4Htnhx8qZe/PCloFiY
lL2keVOXaZwzR/LeMR5uDprPVHSxgNTycoDYiF6kXgJFk91555M=
=+9Rc
-----END PGP SIGNATURE-----

--fephdck4dwpqzcfc--

