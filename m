Return-Path: <linux-pm+bounces-14357-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C83CB97AC64
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 09:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0F01F25526
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 07:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374DB14A60D;
	Tue, 17 Sep 2024 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="bwAd8hQq"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEBB364BE
	for <linux-pm@vger.kernel.org>; Tue, 17 Sep 2024 07:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726559380; cv=pass; b=BV4oBam0rQHkCAzHazWwAYjtd8vpU8SQRP4F5gQkZBbQ9j9kQa3FMr9ECY1YBiElk9MvI1Xvj+QiyleZd7jgrw/66g3rjKBBb5MYhF3G7ws0Ndmas+6XL6Fxh6wH4UGnOoRkVy5VtNgpE+Qzpz3QhPOUPcB2VGCqnS7pObHYqlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726559380; c=relaxed/simple;
	bh=TdWApwAKQTCOZx/rbxxPt7kxrK6qEL2MJoGjl9+AsWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1InZisTBDc7h069PVy/Bd2FqAbriPCQpFeyC4EzSc1ETjbMZ7zRUNWTWvTpj2jtRmP3tXUs7xtw2vAArtqoU7gvXx1L5G35RtN2l0GxTqVEttzhWXQi5j3roSeNpy/z+zfzthxSBTb0Onmc/Mo6ogOcWDCQ0Pgdw9FYTITB5ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=bwAd8hQq; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726559369; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hjptYlA02rc+pGx5Nn3P+3iAM4+OVsP4LB0b6EQsS2KCQwLAVBk35upXR/7NnBLZfPkt1Tb4LMb2kCCpGf1C33cRC9o3PgLZHj13WZbyPNpqJ8JnMygN0yb8v4hFLN2sMvKvVRogkhlCQYw0IXTDw2eugbv3MpMX43NkAiy14xw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726559369; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vjGSJvnlW7bZy6ejSlCyBfIwr7P6AusSBoauHH9IWSg=; 
	b=nXmNes+lBcyVwHK1vNRY/hpCYDKVw/Li15TR3Ux9cG0CN2L4M7a/XlMG0lIgHWnPz0Wl4XcV3DgWodav9UPORsNBS3RFfVPJlIGHLJSCFMFEL9PrHv62E1oJY+OkEG8VzfZLJvKLottPuR6DB4+ZcSDC2XXE1oC2jCEItcOSqas=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726559369;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=vjGSJvnlW7bZy6ejSlCyBfIwr7P6AusSBoauHH9IWSg=;
	b=bwAd8hQqedgqiM9qDRsHAsZd3DxHxPPBkh2HPaz+p7gWweq/Huzxwq4hTPPuYdiY
	Mb2EyXUeR9FmXJRwLpWNOROn7mCsHEyrFvVviCs8uoJbmczKmDgO5OHAVHEQeI559vp
	Iy1uHWeZsC2fFc2evcNOSWDLwx8m00Lc19auhU3A=
Received: by mx.zohomail.com with SMTPS id 1726559366935766.6458987713385;
	Tue, 17 Sep 2024 00:49:26 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id F0B61106045D; Tue, 17 Sep 2024 09:49:22 +0200 (CEST)
Date: Tue, 17 Sep 2024 09:49:22 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jelle van der Waa <jelle@vdwaa.nl>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/4] power: supply: bq24190_charger: Add support for
 "charge_types" property
Message-ID: <gw5dx5mwgqikzxwmcb3aafw6wxqpsukam4hi4a665ijrevdmrq@xqiwebeear22>
References: <20240908192303.151562-1-hdegoede@redhat.com>
 <20240908192303.151562-4-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7g72w4iczm4awk4s"
Content-Disposition: inline
In-Reply-To: <20240908192303.151562-4-hdegoede@redhat.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/223.982.64
X-ZohoMailClient: External


--7g72w4iczm4awk4s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Sep 08, 2024 at 09:23:02PM GMT, Hans de Goede wrote:
> The bq24190 power_supply class device has a writeable "charge_type"
> property, add support for the new "charge_types" property. Reading this
> returns a list of supported charge-types with the currently active type
> surrounded by square brackets, allowing userspace to find out which
> enum power_supply_charge_type values are supported.
>=20
> This has been tested on a GPD win gaming-handheld.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

This looks good to me.

-- Sebastian

>  drivers/power/supply/bq24190_charger.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> index 2b393eb5c282..0101aaca1a97 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -1313,6 +1313,7 @@ static int bq24190_charger_get_property(struct powe=
r_supply *psy,
> =20
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +	case POWER_SUPPLY_PROP_CHARGE_TYPES:
>  		ret =3D bq24190_charger_get_charge_type(bdi, val);
>  		break;
>  	case POWER_SUPPLY_PROP_HEALTH:
> @@ -1393,6 +1394,7 @@ static int bq24190_charger_set_property(struct powe=
r_supply *psy,
>  		ret =3D bq24190_charger_set_temp_alert_max(bdi, val);
>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +	case POWER_SUPPLY_PROP_CHARGE_TYPES:
>  		ret =3D bq24190_charger_set_charge_type(bdi, val);
>  		break;
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> @@ -1421,6 +1423,7 @@ static int bq24190_charger_property_is_writeable(st=
ruct power_supply *psy,
>  	case POWER_SUPPLY_PROP_ONLINE:
>  	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
>  	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +	case POWER_SUPPLY_PROP_CHARGE_TYPES:
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
>  	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> @@ -1469,6 +1472,7 @@ static void bq24190_charger_external_power_changed(=
struct power_supply *psy)
> =20
>  static enum power_supply_property bq24190_charger_properties[] =3D {
>  	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_CHARGE_TYPES,
>  	POWER_SUPPLY_PROP_HEALTH,
>  	POWER_SUPPLY_PROP_ONLINE,
>  	POWER_SUPPLY_PROP_STATUS,
> @@ -1498,6 +1502,9 @@ static const struct power_supply_desc bq24190_charg=
er_desc =3D {
>  	.set_property		=3D bq24190_charger_set_property,
>  	.property_is_writeable	=3D bq24190_charger_property_is_writeable,
>  	.external_power_changed	=3D bq24190_charger_external_power_changed,
> +	.charge_types		=3D BIT(POWER_SUPPLY_CHARGE_TYPE_NONE)    |
> +				  BIT(POWER_SUPPLY_CHARGE_TYPE_TRICKLE) |
> +				  BIT(POWER_SUPPLY_CHARGE_TYPE_FAST),
>  };
> =20
>  /* Battery power supply property routines */
> --=20
> 2.46.0
>=20
>=20

--7g72w4iczm4awk4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbpNIIACgkQ2O7X88g7
+pr/8A//TjNCVoEGJ1brKD3JOmuEHIvYky0KIB0LDTNoRmCXSmQ1JJgPrDxEoZcW
U8UCZLRNVuDJEE8Si3Gf2HuuRoTHrbhR1rvSbGUEp99CVOyf5nn7gWP6aaee9Zdu
b4JUnfUfE4oXSPb75zKWZq9bvMxUFMUyVs3TG0ksPNYXQq+aFh7jheNZJFwSDRrF
iMsWA1JlOggyvcvFcCj2ld8W20fxc6xLXF7AACF7y0HiNbN8PYPnWP1XBBO3dYoz
mTus0Esi6aa8YTnqTM8VEhgPhtEldQgccNPCLCtmjYYAbS5GhTNMjr5ZYk3t1wFj
+WNaYNuOq1b6Wxhw54dm8u6hmwheyJmciD4jj79VC3C7n7npO+OhWtk6Ltudp2bo
Jdd4cEk7d3/aLj1MGIjzoSpNN3eBb7nJqJ3x7xa+ubLKzQGr1Zvp6ez0Z+n6xWiP
ES0L4S+9hceo84PkT0iHlitoNSIx3n+cVD9FdUKpkL3fj/ePMKEl/hp8++hX3tBU
ehOaOgX2R72d0wWmUuJEWQHNdw/yU2xSgY58/85woWk5/BUi4nTmp9SV779hRYsL
miUumvW5+To1alhVKHzHYE4gGbsFI7NSBEC4UULunYgQ+ckiK7LT0+SIQz8RUS4/
gehrdOSn0uWsElVEh2GK4tioHuw8dZTomgpvFKA3gffiP1Owln4=
=JsN4
-----END PGP SIGNATURE-----

--7g72w4iczm4awk4s--

