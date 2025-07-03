Return-Path: <linux-pm+bounces-30085-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEA1AF81E2
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 22:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64DAE3ABF50
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 20:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D30029B8E5;
	Thu,  3 Jul 2025 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="FiCglh9T"
X-Original-To: linux-pm@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC362BDC15;
	Thu,  3 Jul 2025 20:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751574089; cv=none; b=JaM8siO8v+n+SVmPeTTsDvhDbDbSo0otRYBjImkEQIqatQ4epp8wDFIYbvmJcJMT2/IVFr1gf7p3V14hMvjKs8kCEOXSOMwvxDYqhfRT8Gqf7+p1kDlnGZhU/4EV6sdZy4Vh/naYTa+5WC2kf9v4aSNU2ejRYQTnpP667eGh9rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751574089; c=relaxed/simple;
	bh=nxQiQkdudWPZBcNRA9KIQ7hVUyuUQb/8xkQyaumgNEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TA/wa/Owi0AAMtIRcUR7dPc0GH82hkHN/YftZyJH4sY2znUNV71s6P8MMnz6dTlxgqlD9SW3WXxfoexCqwEq8hvNzxwFRg7+h85Xz5+alSQH7H/AClHHrXb4lOfvFhxKZe/o7H050kxxeIvWa/c0H4DBzKmJIN+MGBPvMQxE0M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=FiCglh9T; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0D95D1C00AB; Thu,  3 Jul 2025 22:12:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1751573549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgOphpMZQaLhZ23QXn+GUqOhSFA5+GAho7L5ktP0kac=;
	b=FiCglh9Tms8WiSo2BtH3bmVpvbGxSAA+H8ByhHyEwFc5/ma9s41tmJrEqtguzLkvlWIiF6
	uZM/wv6OEGMQQYm2Qghymc0jY08FVc4oavnkRCYR8Y7ZzPaJpKJ8U6nNQrFrqq4huTTvjh
	UGiCg7Qtk6C7N7wGXUrLGYvqVroZ5Zg=
Date: Thu, 3 Jul 2025 22:12:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: t.antoine@uclouvain.be, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v4 2/5] power: supply: add support for max77759 fuel gauge
Message-ID: <aGbkLIFkMlihbJUt@duo.ucw.cz>
References: <20250523-b4-gs101_max77759_fg-v4-0-b49904e35a34@uclouvain.be>
 <20250523-b4-gs101_max77759_fg-v4-2-b49904e35a34@uclouvain.be>
 <4cahu6dog7ly4ww6xyjmjigjfxs4m55mrnym2bjmzskscfvk34@guazy6wxbzfh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eiYFnwelYqG2iU/c"
Content-Disposition: inline
In-Reply-To: <4cahu6dog7ly4ww6xyjmjigjfxs4m55mrnym2bjmzskscfvk34@guazy6wxbzfh>


--eiYFnwelYqG2iU/c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Other differences include the lack of V_BATT register to read the batte=
ry
> > level. The voltage must instead be read from V_CELL, the lowest voltage=
 of
> > all cells. The mask to identify the chip is different. The computation =
of
> > the charge must also be changed to take into account TASKPERIOD, which
> > can add a factor 2 to the result.
> >=20
> > Add support for the MAX77759 by taking into account all of those
> > differences based on chip type.
> >=20
> > Do not advertise temp probes using the non-volatile memory as those are
> > not available.
> >=20
> > The regmap was proposed by Andr=E9 Draszik in
> >=20
> > Link: https://lore.kernel.org/all/d1bade77b5281c1de6b2ddcb4dbbd033e455a=
116.camel@linaro.org/
> >=20
> > Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> > ---
> >  drivers/power/supply/max1720x_battery.c | 265 ++++++++++++++++++++++++=
++++----
> >  1 file changed, 238 insertions(+), 27 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/su=
pply/max1720x_battery.c
> > index 68b5314ecf3a234f906ec8fe400e586855b69cd9..c9ad452ada9d0a2a51f37d0=
4fd8c3260be522405 100644
> > --- a/drivers/power/supply/max1720x_battery.c
> > +++ b/drivers/power/supply/max1720x_battery.c
> > @@ -37,6 +37,7 @@
> >  #define MAX172XX_REPCAP			0x05	/* Average capacity */
> >  #define MAX172XX_REPSOC			0x06	/* Percentage of charge */
> >  #define MAX172XX_TEMP			0x08	/* Temperature */
> > +#define MAX172XX_VCELL			0x09	/* Lowest cell voltage */
> [...]
> >  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> [...]
> > +			ret =3D regmap_read(info->regmap, MAX172XX_VCELL, &reg_val);
> > +			val->intval =3D max172xx_cell_voltage_to_ps(reg_val);
>=20
> I haven't reviewed this fully due to all the feedback you already
> got from Peter Griffin and the DT binding being broken, but something
> that catched my eye:
>=20
> POWER_SUPPLY_PROP_VOLTAGE_NOW provides the voltage of the whole
> battery and not of a single cell. E.g. a typical Li-Ion battery
> with two serial cells has a nominal voltage of roughly 7.4V while
> each cell has just 3.7V.

Phones normally only have one cell...

Best regards,
								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--eiYFnwelYqG2iU/c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaGbkLAAKCRAw5/Bqldv6
8sYEAKCh0wimF36YRI80R6pAVmloU8qRRgCgnXM0UWB0vtffIz/feHaS3ubBHak=
=t4+u
-----END PGP SIGNATURE-----

--eiYFnwelYqG2iU/c--

