Return-Path: <linux-pm+bounces-23667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA387A5771D
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 02:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6985177067
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 01:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D55E545;
	Sat,  8 Mar 2025 01:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="GPi87H9/"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4B78C11;
	Sat,  8 Mar 2025 01:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741396318; cv=pass; b=dM0QvOfdjFSKJEk7v5PcRqDMgxarAar9JjuCM36UyLd0HjgNrVj2vW2967UaYAbX2LGb63G/uzPt1RKO3v9U6yOQWKKQRYi97WGiRGxKRw0OpfzBgbnxHNibQol+T8w4fzOpsLmnVujtNbw2ySwEZR0kVFWixi2BJliyYOq0dv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741396318; c=relaxed/simple;
	bh=g3QO1+u7+N6WS+vZDPJ6a1vZMim7a9hD+7eVd6nCdhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7dcOwLRPj80P7u9DOkA+Mc1VBT4ofrho+ToM8Ff7GL3t8RkgXsiCxBsZzEpcoVuVO8CCJOY28q+Q9yVVmvqEEf7Gtz5EAwECSVJNZCXA8yup2frD+4XhXtskkd5FT3dxEXGk0iugiMV9k2k3aLm57W7L1PRUTsDf5BS3Pjy1kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=GPi87H9/; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741396240; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NHiUIsSwtrAS7FpZwuBHjAQYl3xY7osYfibXkRQa3WDe+xhUKDBOwk1AiooobvwT0VFfV2ZZuCMZUgJ10cwCIjVFlg5W2qNGhiuG0G3z+4hgUu3OFNKAcs/mxxX8BCHWbOIPsi/OPhuciLqbafcu5XvBj7zlO+27eYZ+c57bSUY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741396240; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TxVriJCD+oQZz0bB/SrRuqiAAYqHbV9mP+Qfc4zG5B8=; 
	b=fGVzQELY3NWn85h0OAxLa57fGz7By3P1tWQsItHyMZuNlTq8Vj4YPpTECBbUKO0bvc2vG0XZc5wFVwQ2COq3WCWuuvnLHAq6dYeEIFyUCJj7zpGZUqCHy/ZYZQHTQTFytfm02x3CCfsBer4O0K3A8oSIb57f8L1pO/fI5PMDkQQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741396240;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=TxVriJCD+oQZz0bB/SrRuqiAAYqHbV9mP+Qfc4zG5B8=;
	b=GPi87H9/Q3UIOdrTklOEvvWRsHendF8E1IBWCsUZ6RxmldtP6ixu47GiUzperiih
	Sd63XkEEoirs0sfrdQu0aDDbFDUug3Oq7t1daUsFLBKNhzlBF4wdtQicHbfK5FRINy7
	gzjuJX4YBIVnosripXpbP8XrduNYihpAh2nGp0M4=
Received: by mx.zohomail.com with SMTPS id 1741396236768534.07744059458;
	Fri, 7 Mar 2025 17:10:36 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id F3B93180B97; Sat, 08 Mar 2025 02:10:29 +0100 (CET)
Date: Sat, 8 Mar 2025 02:10:29 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Hans de Goede <hdegoede@redhat.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, Samuel Holland <samuel@sholland.org>, 
	David Lechner <david@lechnology.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
	Purism Kernel Team <kernel@puri.sm>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Konrad Dybcio <konradybcio@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 3/7] usb: common: usb-conn-gpio: switch psy_cfg from
 of_node to fwnode
Message-ID: <lhtljyn52wkhotaf2cn6fcj2vqx3dzipv2663kzwtw2tjjlxye@5l3xytkyvocy>
References: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
 <20250225-psy-core-convert-to-fwnode-v1-3-d5e4369936bb@collabora.com>
 <2025022542-recital-ebony-d9b5@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yupacfqv4bidfc3e"
Content-Disposition: inline
In-Reply-To: <2025022542-recital-ebony-d9b5@gregkh>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/241.192.19
X-ZohoMailClient: External


--yupacfqv4bidfc3e
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/7] usb: common: usb-conn-gpio: switch psy_cfg from
 of_node to fwnode
MIME-Version: 1.0

Hello Greg,

On Tue, Feb 25, 2025 at 04:32:50AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 25, 2025 at 12:21:36AM +0100, Sebastian Reichel wrote:
> > In order to remove .of_node from the power_supply_config struct,
> > use .fwnode instead.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  drivers/usb/common/usb-conn-gpio.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/us=
b-conn-gpio.c
> > index aa710b50791b0282be0a6a26cffdd981b794acaa..1e36be2a28fd5ca5e1495b7=
923e4d3e25d7cedef 100644
> > --- a/drivers/usb/common/usb-conn-gpio.c
> > +++ b/drivers/usb/common/usb-conn-gpio.c
> > @@ -158,7 +158,7 @@ static int usb_conn_psy_register(struct usb_conn_in=
fo *info)
> >  	struct device *dev =3D info->dev;
> >  	struct power_supply_desc *desc =3D &info->desc;
> >  	struct power_supply_config cfg =3D {
> > -		.of_node =3D dev->of_node,
> > +		.fwnode =3D dev_fwnode(dev),
> >  	};
> > =20
> >  	desc->name =3D "usb-charger";
> >=20
> > --=20
> > 2.47.2
>=20
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Please just merge this patch through the USB tree.

There are no dependencies and I will send a new version for the
later patches, but they won't make it to 6.15 as I want enough
time in linux-next for them. This patch is rather simple and
getting it merged now means we avoid immutable branches or
merging through the wrong tree in the 6.16 cycle.

Thanks,

-- Sebastian

--yupacfqv4bidfc3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmfLmPoACgkQ2O7X88g7
+pqfag//SCn4fHQMNy9MpqB4utfCVxbzElABwBVLAdgNSVN9TjCX8ngn6IdRm5Ku
1iBerLyl4SkpOnsipY/CYntijc/ML9O115qtoUDEeX+YfgFJ3y/wSj7izzpstqTB
9Zu9U1grb4W2qmM9aXRnAC7IOFc8MXtqDrEzdM7/0tyb9KKkRWmO37ae8bBMviv8
DOb/bHr065MXZPPBfDSq73vjrH+3XMPFnKSICKrppNFg+uF/v3TcWGEo+fUPJk6n
TKqD3H14+26IMvkd+79fNSww0dR5Z9iwBGgBQGvCNTcVIxK2iwGa6pWodbrSI444
HpAt64qj8n4lWTX5FnrVsTs2bZwphh5cbkHkxzXz/GILZC+KD7+Fi897fgMy+a0C
v3T61x8aARFvoWzRem+FAOpN+FSYUiXgYi/nUT/8XOamxcUBxwG94WWObGB5Hyqh
u1QYsBaOGEQVU2WWkPqBoZNgAu91J3qZRjAMP8X/ba6hUO3sPBsWGHDCJhkVDW/p
1hlMDJ/pkadywYP+wLfRUBwUL9KfuyUfYyvFBPnnyYcrhXmu1mcoJTC3Y7/08wnY
fK8P8IGFQJ6D98CExE0Nu5B3Xan6MFZ143q7wtGPsdzrK4w4XbD05uy1iOzX0FWh
Vd1YlbA3CCzXiqnQadwnzF88CR242y9jFu4v+0FYwfMLbxakWxw=
=AWn0
-----END PGP SIGNATURE-----

--yupacfqv4bidfc3e--

