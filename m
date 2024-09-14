Return-Path: <linux-pm+bounces-14251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A25CF978F91
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 11:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AAC71F22FEC
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 09:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41811CDFCB;
	Sat, 14 Sep 2024 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="ck91C7y+"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0D14C96;
	Sat, 14 Sep 2024 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726307015; cv=pass; b=XZ7h8qI91L2N3CP74JWyEB0JKQBOoiGBjE9wGDpG79ZXfhdu8Xl0bKptLzKjX2uV0tfpcCVmD1UNyVCqa5XO1Tr1al0AJX3mscmKVcrJvT23QCWxhr32j3/RJ+VH/Ov+4UDL/zlirdj1/wbRYEzaxkZhUg7cy0d/6ZIXNAlJA9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726307015; c=relaxed/simple;
	bh=/MQFv0tApsj8PnjfrsZs8LIApJ+De7SpbkFD71c/zTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNM2W2kD++fOLrL+Fg+UE3nN4mo2vQzSo1Y5ShFCAyycHb+3MhnOWWmhSVP3oCthrFMYGJrmCygwhYVhApwjIRvbaKFhYMtJUqyee0wKTaUBOR+jRaHOp9skCAFbtRq7qpCW3t4MeVxWJUUBI7G6qZDIVsuvDgjNTHNo5d5RSN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=ck91C7y+; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726307006; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FVsgKaSYbywy3ALiBDMl4l3ANyNPrpo0TZYBd6kNmjjhgdjrO5jDf793/OnQCIMtCzh7ILKyYFLGHVG7Xsltop7Dic7WZ4bEkRiFDJlT4hcvAlHNRddz1a1ZyVcDB2xCC1gOTZzlDl7CRyhJQZUO5kSc/J9PessnxKgc6qSy8E4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726307006; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wQkjF8Q0Nq0j1foQSBXwH2s+4kUHosa7W9okQZwQgys=; 
	b=Ilv6T9CEqgEmoDZWX6rT8PfwhY7SS5gy/UxbhRzFb5jMdyS4jLlzBfidGrIPbOISG/mc/htMJzn2XPN/CaZAdchE/e2nre36K6dVOKToozvCqMe2VIREvzvYiK1ow52RvdTQsJHkx6SHFsWlideY9Y0EBFOYDiIPuG5q9J1YY1M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726307006;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=wQkjF8Q0Nq0j1foQSBXwH2s+4kUHosa7W9okQZwQgys=;
	b=ck91C7y+KDIsQcgJUXYfWWnx2w7GNpsfaRgrV3NBgNp61sbacK420Ntr1P0WBoEu
	fo//PwtoR7zn7WNipw83mW9ULlxW6NsVpmSvdgifDzG8ZaRh+hOV6TN4NfMSvygV7q/
	13sXv9gSh4pmamjvbNTwYjw3O7m1E6LbI/ndWNW0=
Received: by mx.zohomail.com with SMTPS id 1726307004462448.6203589986924;
	Sat, 14 Sep 2024 02:43:24 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id 4993D1060578; Sat, 14 Sep 2024 11:43:18 +0200 (CEST)
Date: Sat, 14 Sep 2024 11:43:18 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 4/9] power: supply: sysfs: register battery
 properties
Message-ID: <nzulbfcpaxbjk5vrdiw25ddtn7jcgakxokxleaavsk4mcagftt@pxomcom45fqy>
References: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
 <20240904-power-supply-extensions-v3-4-62efeb93f8ec@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xmu5tquy7pbybjdh"
Content-Disposition: inline
In-Reply-To: <20240904-power-supply-extensions-v3-4-62efeb93f8ec@weissschuh.net>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/223.982.64
X-ZohoMailClient: External


--xmu5tquy7pbybjdh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 04, 2024 at 09:25:37PM GMT, Thomas Wei=DFschuh wrote:
> Instead of only registering properties from the psy_desc itself,
> also register the ones from the battery.
> Use power_supply_has_property() for this test which makes the logic also
> easier to read.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---

The properties from the battery_info are already registered, so this
"just" simplifies the logic. Otherwise LGTM.

Greetings,

-- Sebastian

>  drivers/power/supply/power_supply_sysfs.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index 3e63d165b2f7..4ab08386bcb7 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -367,7 +367,6 @@ static umode_t power_supply_attr_is_visible(struct ko=
bject *kobj,
>  	struct device *dev =3D kobj_to_dev(kobj);
>  	struct power_supply *psy =3D dev_get_drvdata(dev);
>  	umode_t mode =3D S_IRUSR | S_IRGRP | S_IROTH;
> -	int i;
> =20
>  	if (!power_supply_attrs[attrno].prop_name)
>  		return 0;
> @@ -375,19 +374,11 @@ static umode_t power_supply_attr_is_visible(struct =
kobject *kobj,
>  	if (attrno =3D=3D POWER_SUPPLY_PROP_TYPE)
>  		return mode;
> =20
> -	for (i =3D 0; i < psy->desc->num_properties; i++) {
> -		int property =3D psy->desc->properties[i];
> -
> -		if (property =3D=3D attrno) {
> -			if (power_supply_property_is_writeable(psy, property) > 0)
> -				mode |=3D S_IWUSR;
> -
> -			return mode;
> -		}
> -	}
> -
> -	if (power_supply_battery_info_has_prop(psy->battery_info, attrno))
> +	if (power_supply_has_property(psy, attrno)) {
> +		if (power_supply_property_is_writeable(psy, attrno) > 0)
> +			mode |=3D S_IWUSR;
>  		return mode;
> +	}
> =20
>  	return 0;
>  }
>=20
> --=20
> 2.46.0
>=20
>=20

--xmu5tquy7pbybjdh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmblWrUACgkQ2O7X88g7
+ppHng/8CCek232AsLaon0zJm23Meiil0c0NBIuLEgc4vEbI8ZjW6FEj66Dtkwjm
Gpw+JcGSVECiuPvyYd7YF+MFwdF+1FNyIueDygt+WtwX4HWMNmbf4RsfFAJHM36y
0vIPfiF57CD2t/xyZIcFXJfLCKrCWM4FRCBZiO2h6IEZnhXBK0MFcpXrHVqu2xJE
6K3IoVjcE9PoGUaoh5IzHjot31TaaqKnxfo2BuIODBYBNn4TgYlLxRQBhgIJaOuk
6fKpNTE6XMb28KOa0iv3vNFM4POlw9xwtheXgt/umPpn9/0eRpYlTRDaDVQpvWZY
3xppJyqk9SI63Lw4Qr8LxfbAHmIr8a3jkbZ/LwxqnHH1bNmJN3hPkFgGHc9msRVt
u7B+hjmjJP/zWRw6yMq6ONjrNYKSqnDUrHhQR4ZCkTaHWFJ/JqIG+IfLEqnoFrNA
kNXaEObPzGFao5S8wSgl8H3r60Sr3EGdnEM8BvNIL/hj512CoZ6gO6a1iymaNsUz
/A+r/Zk10aVXpaq8AwdApasUhKF14bFGWvLv3heHf8RHbqd1xyoNDAFaEQBiUcQ2
vXyc14v4ChyOw60+6hthrQ6WxSMBDh+gRPYWU7YYPfWfY1PhBNjqn/0ERmNnxcNv
kxNtGjppKW4Ud3tJ/0JLd4354YIzp9LWDlFceSOtr9ay4BUC+nw=
=ex1D
-----END PGP SIGNATURE-----

--xmu5tquy7pbybjdh--

