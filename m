Return-Path: <linux-pm+bounces-14254-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4C0978FCA
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 12:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 077A8B235B0
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 10:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727981CEAAA;
	Sat, 14 Sep 2024 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="fyCjPE36"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D1F1CEABE;
	Sat, 14 Sep 2024 10:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726308014; cv=pass; b=H3PeEbGx2ARybETbDaajlA4UZrI2KMXfcbzQNd5VDhj+HutixBVedz6EpPrZTfCL/z3WuhqpG6IQeoOvWt0V+St5prkM/aAnDzhXx3E2w0KrzNnRJG/tLx1K+ma8kZBhLao4gk5HAk31rF4a716YxelKdFXpc3051MELn30ftfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726308014; c=relaxed/simple;
	bh=5R+Y9lB9ZoOdYRrqfp0U0ntD6+HFI8Og6awdgO/XBuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBvCZbzPsM6y3Pa5EVvPQY4MlbzJaq4QaHvO0TVGoWTfVq4nUkyCxb5LE9JwJ6xv25hnXS4X6QjiX2SsB3CGArQAusnN3Z3ep1GGHN8RYVjRJOKpqQPPrMhdprOp+wsuG7SzV54NcAH1GlECV6Oi5pqIH/wNV7dfa+6Ge48sToA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=fyCjPE36; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726308005; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OK52piqpogkLzQ3YtuhE+mscifDRugj3QZoiFm7HYcHaVtwduBllXZaUGB4/Q43KD49L3gal11rhaetuyv/RNRC7/ylcrr7eCV+oisBlBv7pHx7FJVVvL8mWS4PiV1ycKhsfhGVFb0dHNFQKUGFITXCCggxrU78TtXm2TrV9uu8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726308005; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SJCrPzDZ79kaHSw7KpGfLXXqWwZrHosR+oT9Hy/85ng=; 
	b=lTmxzo7WBTkjsp4kTqO78j0g/Ot1pXC5thlrC5rpVjyNTU2JUqwoe/TvTVX2NYkWtUJbc51Er4pL68o+RyWkljg0zGk/1e++elB1kIVFfOG9AYbNJ0a/jzpMxC39XrdYjDhkeqaPOLnl6ATzYrPHb+OLaHBWX2H93cN41JL4Vms=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726308005;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=SJCrPzDZ79kaHSw7KpGfLXXqWwZrHosR+oT9Hy/85ng=;
	b=fyCjPE36lW7osQ8a56IydK/REcpzQ56MxFjGKkXkE2aa32e2i5m6hFZobib6mIFP
	KuKWBzlUBANy2U/ARyt+1V68xX0k9MQPwJe50eHlkBH8itcogj8RwL6kRCYs++V4Gka
	0fbKYJZrb0APuSrUH+oOurUrUZIta2K7qsUOwPik=
Received: by mx.zohomail.com with SMTPS id 1726308003272472.5385277458963;
	Sat, 14 Sep 2024 03:00:03 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id 8A6511060578; Sat, 14 Sep 2024 11:59:57 +0200 (CEST)
Date: Sat, 14 Sep 2024 11:59:57 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 5/9] power: supply: sysfs: rework uevent property
 loop
Message-ID: <7oa7cmhqsctdcxxrlq7bjg4ryzcfzzayktrjduwkgkvc53kkq3@asavedqgttnb>
References: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
 <20240904-power-supply-extensions-v3-5-62efeb93f8ec@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ub32aja7tdcftnq6"
Content-Disposition: inline
In-Reply-To: <20240904-power-supply-extensions-v3-5-62efeb93f8ec@weissschuh.net>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/223.982.64
X-ZohoMailClient: External


--ub32aja7tdcftnq6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 04, 2024 at 09:25:38PM GMT, Thomas Wei=DFschuh wrote:
> Instead of looping through all properties known to be supported by the
> psy, loop over all known properties and decide based on the return value
> of power_supply_get_property() whether the property existed.
>=20
> This makes the code shorter now and even more so when power supply
> extensions are added.
> It also simplifies the locking, as it can all happen inside
> power_supply_get_property().
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---
>  drivers/power/supply/power_supply_sysfs.c | 26 +++++---------------------
>  1 file changed, 5 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index 4ab08386bcb7..915a4ba62258 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -290,6 +290,8 @@ static ssize_t power_supply_show_property(struct devi=
ce *dev,
>  				dev_dbg_ratelimited(dev,
>  					"driver has no data for `%s' property\n",
>  					attr->attr.name);
> +			else if (ret =3D=3D -EINVAL) /* property is not supported */
> +				return -ENODATA;

I think it's better to update the check in add_prop_uevent, so that
it also skips -EINVAL. That way sysfs still exposes the correct
error code.

Otherwise LGTM, even though I wonder about the performance impact of
this change. I suppose this is not called often enough to really
matter, though.

Greetings,

-- Sebastian

>  			else if (ret !=3D -ENODEV && ret !=3D -EAGAIN)
>  				dev_err_ratelimited(dev,
>  					"driver failed to report `%s' property: %zd\n",
> @@ -451,11 +453,7 @@ static int add_prop_uevent(const struct device *dev,=
 struct kobj_uevent_env *env
> =20
>  int power_supply_uevent(const struct device *dev, struct kobj_uevent_env=
 *env)
>  {
> -	const struct power_supply *psy =3D dev_get_drvdata(dev);
> -	const enum power_supply_property *battery_props =3D
> -		power_supply_battery_info_properties;
> -	unsigned long psy_drv_properties[POWER_SUPPLY_ATTR_CNT /
> -					 sizeof(unsigned long) + 1] =3D {0};
> +	struct power_supply *psy =3D dev_get_drvdata(dev);
>  	int ret =3D 0, j;
>  	char *prop_buf;
> =20
> @@ -483,22 +481,8 @@ int power_supply_uevent(const struct device *dev, st=
ruct kobj_uevent_env *env)
>  	if (ret)
>  		goto out;
> =20
> -	for (j =3D 0; j < psy->desc->num_properties; j++) {
> -		set_bit(psy->desc->properties[j], psy_drv_properties);
> -		ret =3D add_prop_uevent(dev, env, psy->desc->properties[j],
> -				      prop_buf);
> -		if (ret)
> -			goto out;
> -	}
> -
> -	for (j =3D 0; j < power_supply_battery_info_properties_size; j++) {
> -		if (test_bit(battery_props[j], psy_drv_properties))
> -			continue;
> -		if (!power_supply_battery_info_has_prop(psy->battery_info,
> -				battery_props[j]))
> -			continue;
> -		ret =3D add_prop_uevent(dev, env, battery_props[j],
> -			      prop_buf);
> +	for (j =3D 0; j < POWER_SUPPLY_ATTR_CNT; j++) {
> +		ret =3D add_prop_uevent(dev, env, j, prop_buf);
>  		if (ret)
>  			goto out;
>  	}
>=20
> --=20
> 2.46.0
>=20
>=20

--ub32aja7tdcftnq6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmblXpkACgkQ2O7X88g7
+pqYSRAAnX1Ei4PdnGpqcfIY7X4fe0pxb2wSJuELGYF0WFaHmuScnsen8241qLrW
4mVyJ5DOND4TR3gpxhEhu2BoBcaCWw+zmNqaKw3bpWIpAdiL8CAM27rGbQTS2o9G
T8td525S/TlC/oWGg2KwgEowT1qtB5OxIyidf1HOwwHyEluJjg1bSPNIYvuLPTRN
aVbGN4IxCqRj5jXkZRMsZJTyJ/7Bpv1lLj2l/CaKjiYyg5gFNOBsDGKfa8DpdRdX
pbrRs2H5nGzXQCWl8EzaN7wLGk4NHwSklxcM9dQ9GK/CUtWYeShiP9r/4901g0zg
tXSCMvYjAZBQGWqfV1Im+i6Ni4ezaW0ZH9XLFVU6JqTjdUJJ4HTSuAYKs5ekZ1mR
u8mkh6xsZqxnq4esWitaqn68ccOgNul8pnOwRn6b9e9O90oNtNQ88Xv/UO7qGshq
sr4O9WFk/eZUi8pD3iqPWwr4DocRlliVSCXLzxkVtwceCxxvuRZS/nmBUyMovDcq
7hU3kkSlJuIX3s8iudXJbERjNr/DhUH0LCcUR8wiJYIJ3/bIHzcHw9NOD0ZFkbz4
zHtDjJV1BzjCF/gtLTsnb8HTGtBOz9Gf0MgvVRLOr1PDdvrN2d8NXJ+kfAAH69HZ
rZeSIg2IzYnwqMhjlQSJOrB4/SV5B+LEjRqg9lQcx2JvBJ/R4mc=
=OPty
-----END PGP SIGNATURE-----

--ub32aja7tdcftnq6--

