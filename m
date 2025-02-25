Return-Path: <linux-pm+bounces-22890-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE280A44079
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 14:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24B13BE04A
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 13:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FA0268FE0;
	Tue, 25 Feb 2025 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="BZbhRsHR"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927B0267AE1;
	Tue, 25 Feb 2025 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489190; cv=pass; b=nZY9EQTYsqi/Wq0dSNyCmvcr1nFs3f0QeYenv+6p33zrh1JHGBpqSP2KizEogCADr8hzoP4sD6e23PeAeYIg9bAawjgAFoXY8PbhFQ38AT0r74Hu/2iaOrXwLsrrB+JSuQrYsy4lDFAOdzwlJWL4MCYWfnaPuauJxEm/oxHCngQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489190; c=relaxed/simple;
	bh=Pn/Fx/yuU/lUaA3NedAbSiQkqvsmm1dENaJyUG5J8kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2zSNLcAMTIsnga7QLovxBTDRAeYbVMtI31YUgSK0biST5Khg1OAnGBcvor2MJbmqjHFIvGMmf99SuL1WwEFx2+BNBFj5G7rKKFaVyzycGfpKNmEKNwdeT/WIbQ3A/T9H/X+1Db5au+tZSsTnqyDoS75yh5cC08ODmYZfXdIkH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=BZbhRsHR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740489110; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NZnfyVR7IyMTyXDLIEUCrMKSCGoTGqsj+069o9fihhvi0eGkpqCRiv1yIih6DatPyzlCBSWvAsLckZwjO9/nbLliRC7JxzVJA+QyiqPD3cZYsiG7DJbvKMqStVYQlixILKLnz5qBzKpwFqyeWef1GwDDsaeQ2d72qVshwNoPClY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740489110; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xrERTREY6YsrpdfbtuvBlrDzb+rIm9ucee5+fOc7+3s=; 
	b=X7bylatDMJhFwzJK5XJCxJMbpRaKeNdxWn9zmgwee2JcjP3pxIuzStBLo07Zm+wfPfQpdT8fcBBHjWisd4+4pFSZ83A8/tQpT9Kzmet+b05HUFguneYiG/dsBHrfO36oBqNdsEEYY5JNX2mejJwyfaeqPW4PrA3A2LqKhBLrp2o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740489110;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=xrERTREY6YsrpdfbtuvBlrDzb+rIm9ucee5+fOc7+3s=;
	b=BZbhRsHRaCk8oCx4V1IJthqAD0y0f1aA6Jq9zf2qb0ab+nE18X2Bc3s7PUOLdqwP
	VHKDCjsBwixxUM9KyNmeRpL+tHO6jPqaQjhxFSLOXyJc+d5mNkD6cNqk5v+3YqWtH3N
	T8L2lHl6rizRn1UcYqljqJYFtXSY5q4dVNz5yrCg=
Received: by mx.zohomail.com with SMTPS id 1740489106492893.7559376695295;
	Tue, 25 Feb 2025 05:11:46 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id EB08C180403; Tue, 25 Feb 2025 14:11:39 +0100 (CET)
Date: Tue, 25 Feb 2025 14:11:39 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Chen-Yu Tsai <wens@csie.org>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, Samuel Holland <samuel@sholland.org>, 
	David Lechner <david@lechnology.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
	Purism Kernel Team <kernel@puri.sm>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Konrad Dybcio <konradybcio@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/7] power: supply: core: get rid of of_node
Message-ID: <ocbwzuqk56yx34kc5vp6aaxnhxqd4zp2wixlv7p3mex66ibntu@ahigikrf5cg4>
References: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
 <20250225-psy-core-convert-to-fwnode-v1-1-d5e4369936bb@collabora.com>
 <491e20bb-5ab4-40e9-bb35-5e05dc7bd46c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qokyrq4gcjmy6fsj"
Content-Disposition: inline
In-Reply-To: <491e20bb-5ab4-40e9-bb35-5e05dc7bd46c@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/240.466.79
X-ZohoMailClient: External


--qokyrq4gcjmy6fsj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/7] power: supply: core: get rid of of_node
MIME-Version: 1.0

Hi,

On Tue, Feb 25, 2025 at 01:14:03PM +0200, Matti Vaittinen wrote:
> On 25/02/2025 01:21, Sebastian Reichel wrote:
> > This removes .of_node from 'struct power_supply', since there
> > is already a copy in .dev.of_node and there is no need to have
> > two copies.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >   drivers/power/supply/power_supply_core.c | 17 ++++++++---------
> >   include/linux/power_supply.h             |  1 -
> >   2 files changed, 8 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/s=
upply/power_supply_core.c
> > index d0bb52a7a0367a8e07787be211691cad14a41a54..11030035da6f121ca76bebf=
800c06cfd5db57578 100644
> > --- a/drivers/power/supply/power_supply_core.c
> > +++ b/drivers/power/supply/power_supply_core.c
> > @@ -200,11 +200,11 @@ static int __power_supply_populate_supplied_from(=
struct power_supply *epsy,
> >   	int i =3D 0;
> >   	do {
> > -		np =3D of_parse_phandle(psy->of_node, "power-supplies", i++);
> > +		np =3D of_parse_phandle(psy->dev.of_node, "power-supplies", i++);
> >   		if (!np)
> >   			break;
> > -		if (np =3D=3D epsy->of_node) {
> > +		if (np =3D=3D epsy->dev.of_node) {
> >   			dev_dbg(&psy->dev, "%s: Found supply : %s\n",
> >   				psy->desc->name, epsy->desc->name);
> >   			psy->supplied_from[i-1] =3D (char *)epsy->desc->name;
> > @@ -235,7 +235,7 @@ static int  __power_supply_find_supply_from_node(st=
ruct power_supply *epsy,
> >   	struct device_node *np =3D data;
> >   	/* returning non-zero breaks out of power_supply_for_each_psy loop */
> > -	if (epsy->of_node =3D=3D np)
> > +	if (epsy->dev.of_node =3D=3D np)
> >   		return 1;
> >   	return 0;
> > @@ -270,13 +270,13 @@ static int power_supply_check_supplies(struct pow=
er_supply *psy)
> >   		return 0;
> >   	/* No device node found, nothing to do */
> > -	if (!psy->of_node)
> > +	if (!psy->dev.of_node)
> >   		return 0;
> >   	do {
> >   		int ret;
> > -		np =3D of_parse_phandle(psy->of_node, "power-supplies", cnt++);
> > +		np =3D of_parse_phandle(psy->dev.of_node, "power-supplies", cnt++);
> >   		if (!np)
> >   			break;
> > @@ -606,8 +606,8 @@ int power_supply_get_battery_info(struct power_supp=
ly *psy,
> >   	const __be32 *list;
> >   	u32 min_max[2];
> > -	if (psy->of_node) {
> > -		battery_np =3D of_parse_phandle(psy->of_node, "monitored-battery", 0=
);
> > +	if (psy->dev.of_node) {
> > +		battery_np =3D of_parse_phandle(psy->dev.of_node, "monitored-battery=
", 0);
> >   		if (!battery_np)
> >   			return -ENODEV;
>=20
> This reminded me of a change I once did to power_supply - but maybe never
> got it further than RFC stage. Anyways, do you think it would be possible=
 to
> decouple the battery info and struct power_suppply (while at it)?
>
> I believe that the chargers and especially fuel-gauges which are designed=
 to
> operate with different batteries (and which get battery details using sta=
tic
> battery nodes), would like to get the battery info _before_ registering t=
he
> power_supply (to avoid sending bogus values while operating on defaults,
> before the battery info is read and before things are set accordingly).
>=20
> I know this may be a bit much to ask, but I believe it'd be an improvemen=
t.
>=20
> Other than that, looks good to me.

I was thinking about adding an init function to power_supply_desc,
which would be called directly before psy->initialized is set to
true in the power-supply registration phase. I think that would be
the right place to setup device registers based on battery-info data.
But it's definitely not a thing for this series.

Greetings,

-- Sebastian

--qokyrq4gcjmy6fsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAme9wYEACgkQ2O7X88g7
+pqiLw//XIliVc9d8leYVw9Zg1Ou2CIFlkNNs0jNuGp/9lBRbbqU3i1ak4YxVKtX
Gwz4lsiJCZAACkP7CuEb5IguHkrl/pMT0hWEa+Lt1rwqx+F18FVdoWK5mujphYXK
oE+4iXNfaU0hYoypPpgqWorMtKs7KKVw7cv7BuIgGp+LYXEeBRdde6W5t9mMYY4y
IwppeBvxwmOoNc+E0nXErhERfiydaEwm6BFWuBnKfmeHoXPnCL0jVamXJbDVjczE
+1oLmR5iZYfuSrmRczsPiqj1Mcw5iD2avPWX0hi92SEz3KQunNHrsYdfH67nJzw1
qvCCjn9fnT22fTH5Ttny1Cg//zsOnfmBQsDYuY6WVmQZ6ioXDwV6nXlfydr14ZRT
66oYdUBsDh/Gxy68lUMaLDiKus2I4WrVgqNNXazlnDaMsSrKn6MRZ0O5JJBtY4yD
yqByN1yiZLRSfhPmJqXZlCIXBp4PJ19wfMg8HWynQVuHv/T8YgOso15Tbucp+qWf
IOfMOx8HxTJeDuCezPkCZV7GJeVMsOYHzLrwvLnwk9AHGb+VIFiWu4I+iRzkV8pR
9cYRHe78FNnqRCnf69jmZd8IBp/qnRIcelg00w4vo1A5mrVLI6YYt2oUuj/6yEqr
ljWvdVK5cQo/CvXH/3zlL4AZNW/tsPlLT2WKpFyuVqwIOvS1SLw=
=+mrH
-----END PGP SIGNATURE-----

--qokyrq4gcjmy6fsj--

