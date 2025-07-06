Return-Path: <linux-pm+bounces-30226-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A667AFA83E
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 01:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9820178415
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 23:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3736F1F8744;
	Sun,  6 Jul 2025 23:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="VgJhzpJM"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1114192598;
	Sun,  6 Jul 2025 23:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751843499; cv=pass; b=SFqUGt0DEMHvYtSglPRPqCZ8shEle7H4vZW1wMpfGDjSGNmL8MHPKwfd7NuaDX7C9CrJ6q8eUtR6+Lnx4/pCHJHIlE9r1ARMfY4+vUJNr3fpFPvLx72PiTAPjhI9jCOpo1X9JHVtdNaOkAE/RB+hL1IwD2Yy1YSTBMOCw6qilQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751843499; c=relaxed/simple;
	bh=dveEPten9kKIeSU6lAE8WM6x7Udea1WnYKbmUOZg+Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmJjOLDpy+JeASu22aOLOj4cvuFrrDFi7Sm12zTBBtybim7TJ8XcDdP6K4f2hIYp9ALXS1x3EeMyVulKOXHKEdRLdVpy4sAXypzRILEicROqJyekcCOQsVmAhExhwv6CVxpxZFfKu+kpRGTWq5vH9JOg6ClUxBVpbg6e66UKPa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=VgJhzpJM; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751843489; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WXmwZ4FxLPpgiwVbm8hBGn17ub3YplxKy7RQ/ZD3wpPs3OMwH/v6052P3yRG2IrN5XIFNmyVPnkyooxaE8ILWuD5IEO/a0UI4h0bWvC3mrB5sAfkgPRaaV4OJGAaAIot/1cM7jCHpaIS6HXexiZMdPlMz20YIGk6lgK+cTFccik=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751843489; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XP0+m/UnDXQpweK9dnK+RA1k9ixaxdiA68NmWqu5mDk=; 
	b=dUBlbJPuRCy1TuVVwGuHH1HGMxF5dqvLuXj0kw4YrwWqSRWTddjzL2IH8KnsB8z2Lo0lsntRrzGJTTWWxnNb7oyXpYzRfOxH0jl0OuM49YVy70ZxnzS1KlYVt19MQy+6LaLvn47vUS5GzxgiiCeHFBAzv3Rsc0X/GEf+w0i4fYY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751843489;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=XP0+m/UnDXQpweK9dnK+RA1k9ixaxdiA68NmWqu5mDk=;
	b=VgJhzpJMTIq1urYGcvQf0DvswvsjvoktxOpDfb93P5MptTnBmoOdb/u4XqpStQ4w
	GUfM39BbTWUgty5PnoFfIfFCku2IXk94CpKAPz2OkTDoMZYcox4mmWgc+kqqy8mCOuh
	MioIRLQlg26W2rSnqG5Epi608m0zJ4IVq2Hs+25o=
Received: by mx.zohomail.com with SMTPS id 1751843486842881.752729641784;
	Sun, 6 Jul 2025 16:11:26 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 2B398180F17; Mon, 07 Jul 2025 01:11:23 +0200 (CEST)
Date: Mon, 7 Jul 2025 01:11:23 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] power: supply: core: Add
 power_supply_get/set_property_direct()
Message-ID: <e5fxtycfe2fmtsejbgas6lvjjgiixwr672lvutdhcebsn67tei@l2x5tavcvtrw>
References: <20250627205124.250433-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qpzuedv6i4g34dxe"
Content-Disposition: inline
In-Reply-To: <20250627205124.250433-1-W_Armin@gmx.de>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/251.827.75
X-ZohoMailClient: External


--qpzuedv6i4g34dxe
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] power: supply: core: Add
 power_supply_get/set_property_direct()
MIME-Version: 1.0

Hi,

On Fri, Jun 27, 2025 at 10:51:22PM +0200, Armin Wolf wrote:
> Power supply extensions might want to interact with the underlying
> power supply to retrieve data like serial numbers, charging status
> and more. However doing so causes psy->extensions_sem to be locked
> twice, possibly causing a deadlock.
>=20
> Provide special variants of power_supply_get/set_property() that
> ignore any power supply extensions and thus do not touch the
> associated psy->extensions_sem lock.
>=20
> Suggested-by: Hans de Goede <hansg@kernel.org>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/power_supply_core.c | 82 ++++++++++++++++++++----
>  include/linux/power_supply.h             |  8 +++
>  2 files changed, 78 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index aedb20c1d276..e70ffedf1a80 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1241,9 +1241,8 @@ bool power_supply_has_property(struct power_supply =
*psy,
>  	return false;
>  }
> =20
> -int power_supply_get_property(struct power_supply *psy,
> -			    enum power_supply_property psp,
> -			    union power_supply_propval *val)
> +static int __power_supply_get_property(struct power_supply *psy, enum po=
wer_supply_property psp,
> +				       union power_supply_propval *val, bool use_extensions)
>  {
>  	struct power_supply_ext_registration *reg;
> =20
> @@ -1253,10 +1252,14 @@ int power_supply_get_property(struct power_supply=
 *psy,
>  		return -ENODEV;
>  	}
> =20
> -	scoped_guard(rwsem_read, &psy->extensions_sem) {
> -		power_supply_for_each_extension(reg, psy) {
> -			if (power_supply_ext_has_property(reg->ext, psp))
> +	if (use_extensions) {
> +		scoped_guard(rwsem_read, &psy->extensions_sem) {
> +			power_supply_for_each_extension(reg, psy) {
> +				if (!power_supply_ext_has_property(reg->ext, psp))
> +					continue;
> +
>  				return reg->ext->get_property(psy, reg->ext, reg->data, psp, val);
> +			}
>  		}
>  	}
> =20
> @@ -1267,20 +1270,49 @@ int power_supply_get_property(struct power_supply=
 *psy,
>  	else
>  		return -EINVAL;
>  }
> +
> +int power_supply_get_property(struct power_supply *psy, enum power_suppl=
y_property psp,
> +			      union power_supply_propval *val)
> +{
> +	return __power_supply_get_property(psy, psp, val, true);
> +}
>  EXPORT_SYMBOL_GPL(power_supply_get_property);
> =20
> -int power_supply_set_property(struct power_supply *psy,
> -			    enum power_supply_property psp,
> -			    const union power_supply_propval *val)
> +/**
> + * power_supply_get_property_direct - Read a power supply property witho=
ut checking for extensions
> + * @psy: The power supply
> + * @psp: The power supply property to read
> + * @val: The resulting value of the power supply property
> + *
> + * Read a power supply property without taking into account any power su=
pply extensions registered
> + * on the given power supply. This is mostly useful for power supply ext=
ensions that want to access
> + * their own power supply as using power_supply_get_property() directly =
will result in a potential
> + * deadlock.
> + *
> + * Return: 0 on success or negative error code on failure.
> + */
> +int power_supply_get_property_direct(struct power_supply *psy, enum powe=
r_supply_property psp,
> +				     union power_supply_propval *val)
> +{
> +        return __power_supply_get_property(psy, psp, val, false);
> +}
> +EXPORT_SYMBOL_GPL(power_supply_get_property_direct);
> +
> +
> +static int __power_supply_set_property(struct power_supply *psy, enum po=
wer_supply_property psp,
> +				       const union power_supply_propval *val, bool use_extensions)
>  {
>  	struct power_supply_ext_registration *reg;
> =20
>  	if (atomic_read(&psy->use_cnt) <=3D 0)
>  		return -ENODEV;
> =20
> -	scoped_guard(rwsem_read, &psy->extensions_sem) {
> -		power_supply_for_each_extension(reg, psy) {
> -			if (power_supply_ext_has_property(reg->ext, psp)) {
> +	if (use_extensions) {
> +		scoped_guard(rwsem_read, &psy->extensions_sem) {
> +			power_supply_for_each_extension(reg, psy) {
> +				if (!power_supply_ext_has_property(reg->ext, psp))
> +					continue;
> +
>  				if (reg->ext->set_property)
>  					return reg->ext->set_property(psy, reg->ext, reg->data,
>  								      psp, val);
> @@ -1295,8 +1327,34 @@ int power_supply_set_property(struct power_supply =
*psy,
> =20
>  	return psy->desc->set_property(psy, psp, val);
>  }
> +
> +int power_supply_set_property(struct power_supply *psy, enum power_suppl=
y_property psp,
> +			      const union power_supply_propval *val)
> +{
> +	return __power_supply_set_property(psy, psp, val, true);
> +}
>  EXPORT_SYMBOL_GPL(power_supply_set_property);
> =20
> +/**
> + * power_supply_set_property_direct - Write a power supply property with=
out checking for extensions
> + * @psy: The power supply
> + * @psp: The power supply property to write
> + * @val: The value to write to the power supply property
> + *
> + * Write a power supply property without taking into account any power s=
upply extensions registered
> + * on the given power supply. This is mostly useful for power supply ext=
ensions that want to access
> + * their own power supply as using power_supply_set_property() directly =
will result in a potential
> + * deadlock.
> + *
> + * Return: 0 on success or negative error code on failure.
> + */
> +int power_supply_set_property_direct(struct power_supply *psy, enum powe=
r_supply_property psp,
> +				     const union power_supply_propval *val)
> +{
> +	return __power_supply_set_property(psy, psp, val, false);
> +}
> +EXPORT_SYMBOL_GPL(power_supply_set_property_direct);
> +
>  int power_supply_property_is_writeable(struct power_supply *psy,
>  					enum power_supply_property psp)
>  {
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 45468959dd98..f21f806bfb38 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -878,15 +878,23 @@ static inline int power_supply_is_system_supplied(v=
oid) { return -ENOSYS; }
>  extern int power_supply_get_property(struct power_supply *psy,
>  			    enum power_supply_property psp,
>  			    union power_supply_propval *val);
> +int power_supply_get_property_direct(struct power_supply *psy, enum powe=
r_supply_property psp,
> +				     union power_supply_propval *val);
>  #if IS_ENABLED(CONFIG_POWER_SUPPLY)
>  extern int power_supply_set_property(struct power_supply *psy,
>  			    enum power_supply_property psp,
>  			    const union power_supply_propval *val);
> +int power_supply_set_property_direct(struct power_supply *psy, enum powe=
r_supply_property psp,
> +				     const union power_supply_propval *val);
>  #else
>  static inline int power_supply_set_property(struct power_supply *psy,
>  			    enum power_supply_property psp,
>  			    const union power_supply_propval *val)
>  { return 0; }
> +static inline int power_supply_set_property_direct(struct power_supply *=
psy,
> +						   enum power_supply_property psp,
> +						   const union power_supply_propval *val)
> +{ return 0; }
>  #endif
>  extern void power_supply_external_power_changed(struct power_supply *psy=
);
> =20
> --=20
> 2.39.5
>=20

--qpzuedv6i4g34dxe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhrApYACgkQ2O7X88g7
+pqbGA//dMkwYFqfbt8gSNnbWqEeDC3XElEFRw7OUmbGCxm9KkPR02iDlV91V3Po
Bocfmv/NeO1F+1m+KUudUGDKk6QH4KKKdjzkRxfwhO+FwvILTvLZhCbWR4Mdx1sM
+eWJA5DiyZK7zD5Vf3Uy0nxclM17FZbiNfx8uTzc0XlAugqH2/QSsWBsx7lxl7PV
xBY4dacMV6L57gSX/OTvWY3d4/g8kEq/vQrvN8P7q4YtL+bD7Q9lRVA8ro+jLQDv
+VQanACbQolzvgynjVNYY+hvJsUj/ihDS+vRkSN3QpboxRPF0HeDgv2RfNctQY8j
iHCzenx/mbAv2vOIY8BYjTuA4x30BUKeHJO22J/YenLa0yd8zagJiAPRTHe6V0ho
M8j0Xl4QdC0XyMqgRbzrSkW8L9yo/PkUWOWMr4ibk1J/J1n5QWrzb8FdMnWLAiG9
TMK7iDlpX98q3+XfMaPLOG7nWNtvXu+RlLl2LCocnOlZV+4YgUILPljx1J6RRomN
xfmkrisdi3LaCpJzD4WMiP2ULjR9vW2Z5o9eSYnJphPxEUpMn//XeeUguD7Uukes
VB3VwQomTfmU94X8y3uGG2nIQhsy1aUqsacGe+Gx7anqE49tmz0rRViOTHa3A9Sw
ht40OiVYIuZr7tf0SKINaQPHXoplL5yqYrazOgAtVDtQ96RqkNs=
=pwuJ
-----END PGP SIGNATURE-----

--qpzuedv6i4g34dxe--

