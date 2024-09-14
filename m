Return-Path: <linux-pm+bounces-14249-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0937F978F80
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 11:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7D71F23544
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 09:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E182143723;
	Sat, 14 Sep 2024 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="M7xYMA+T"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182C24C96;
	Sat, 14 Sep 2024 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726306222; cv=pass; b=jvbJhDYZHy4z3TqNbpTCFB7Elj1324tYobTYrb3oLE4zK4d8/a98/WhHLldhd5OAyBMHG4i1+Ffoj9uAe2FwY5Exw32//uaMaLZY/MNJKvD7KkIdobbH0EZE9QkpELgahSo5ndajOm7/I3xXPLIRBMaTXqJLnk/WvVmA+cHfZvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726306222; c=relaxed/simple;
	bh=vnnDfV+MINd2tcvB//WH0jNM2mlEY8rkYr9+PISaDo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKj7sE1Vgt4dQ/2iBKR4CM6CBnuDdL24UOPQwY39d2kQD7gvu+/nOLlkQTdCNz4h4NqV/CX6h3d5dzeV0zoBE2jt8KXILu2ob1HwPl44Mdww8r5mqzkrxetqCUMIXOu8BFkduocOLpqxUmDQl0SpsYSAnZx+zpPCCNAMBj0TkWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=M7xYMA+T; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726306213; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hiZZLirIHRcNhbT3t5xq0Ktpxn+cG0uB68q2q3l6F2RCBZ0VFMI4E3Yz73AG2+6ocWpCBEg3sz03duDp4CqtXIbt8dqd/oe1KfgvL76Jn2Ht7Zxof50P9mjOSKwYyemSMHcL3cJRNUPFNvbIgMWO0LC3BPkYjSrb8LuSbpKP75Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726306213; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TpbzSXJuCN/JlDE1+UFDOIvoZDi8QVEENT5Q4DbtX6w=; 
	b=FtnJgFQ/kcE+r9t1HjgkoKhdPR340Ba9pOFWOyRdAxqsmOOFZUsEzBOIboA7FtzNs55w5MHjgikeBzAAXmYa7qWk+hhbc1IWdh9mDLt8jvX0+QseFNhXYw86Y0RXcyO+LbG+CABBFhHxoM/lRikkEnY+T0utleys2uxnbYOUPAU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726306213;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=TpbzSXJuCN/JlDE1+UFDOIvoZDi8QVEENT5Q4DbtX6w=;
	b=M7xYMA+T2ulEB3aY/GhgLl0mPMvAkX+/OxSlY39rywiUo138kQR72WmzqUwREQA+
	q+s7B2HUIKgHWz07Dl7Wu4oToEHzDewE4AduTHL5t43XuNspu+PPomrgn6InBCe91bw
	3ih/xIBgu/l7SWA9QvF3/JZzk0rJnROIWhnmYAFs=
Received: by mx.zohomail.com with SMTPS id 1726306211472119.64276523582635;
	Sat, 14 Sep 2024 02:30:11 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id 774991060578; Sat, 14 Sep 2024 11:30:06 +0200 (CEST)
Date: Sat, 14 Sep 2024 11:30:06 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 1/9] power: supply: core: rename
 psy_has_property() to psy_desc_has_property()
Message-ID: <gpjflldvxbsl5fywggz666eu3yqlrid35urqj62xosavzztgnz@wuvxbzupavar>
References: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
 <20240904-power-supply-extensions-v3-1-62efeb93f8ec@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4sugj2cvc65btq7x"
Content-Disposition: inline
In-Reply-To: <20240904-power-supply-extensions-v3-1-62efeb93f8ec@weissschuh.net>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/223.982.64
X-ZohoMailClient: External


--4sugj2cvc65btq7x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 04, 2024 at 09:25:34PM GMT, Thomas Wei=DFschuh wrote:
> The function only takes a desc as parameter, align the naming.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---

too late for 6.12, so

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/power_supply_core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 8f6025acd10a..cff68c4fd63c 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1183,8 +1183,8 @@ bool power_supply_battery_bti_in_range(struct power=
_supply_battery_info *info,
>  }
>  EXPORT_SYMBOL_GPL(power_supply_battery_bti_in_range);
> =20
> -static bool psy_has_property(const struct power_supply_desc *psy_desc,
> -			     enum power_supply_property psp)
> +static bool psy_desc_has_property(const struct power_supply_desc *psy_de=
sc,
> +				  enum power_supply_property psp)
>  {
>  	bool found =3D false;
>  	int i;
> @@ -1209,7 +1209,7 @@ int power_supply_get_property(struct power_supply *=
psy,
>  		return -ENODEV;
>  	}
> =20
> -	if (psy_has_property(psy->desc, psp))
> +	if (psy_desc_has_property(psy->desc, psp))
>  		return psy->desc->get_property(psy, psp, val);
>  	else if (power_supply_battery_info_has_prop(psy->battery_info, psp))
>  		return power_supply_battery_info_get_prop(psy->battery_info, psp, val);
> @@ -1308,7 +1308,7 @@ static int psy_register_thermal(struct power_supply=
 *psy)
>  		return 0;
> =20
>  	/* Register battery zone device psy reports temperature */
> -	if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
> +	if (psy_desc_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
>  		/* Prefer our hwmon device and avoid duplicates */
>  		struct thermal_zone_params tzp =3D {
>  			.no_hwmon =3D IS_ENABLED(CONFIG_POWER_SUPPLY_HWMON)
> @@ -1361,7 +1361,7 @@ __power_supply_register(struct device *parent,
>  		pr_warn("%s: Expected proper parent device for '%s'\n",
>  			__func__, desc->name);
> =20
> -	if (psy_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
> +	if (psy_desc_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
>  	    (!desc->usb_types || !desc->num_usb_types))
>  		return ERR_PTR(-EINVAL);
> =20
>=20
> --=20
> 2.46.0
>=20

--4sugj2cvc65btq7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmblV50ACgkQ2O7X88g7
+pp/5g//TsGJssv9BiLBN2x2AGV1RRT2eJymyJiFFy55ade7ZqY1AX7yqFRaEVet
W2AedzlqnH+P3y1dvzzVku13k/SvhmfmNYSuMV/SgMzzZdCowsag/lbfoMiiQzTB
3kHRzzhx6BxaVUr/smsF1rKzcdNJEH7twWwCfUVOXyk7yXrLdlnNR34yRYiHdz88
tXWezq3wWgtHp3pNYPURtzEkEOghvzW3miU+NpYRZ/16icGjAiK3UweXn+vEZ2AR
WBUWmfTP4jkt9E4A+dqsHssO5A42cNxXGJlLAhhME6DBgQTSRO6rPVqeXXfKUkWU
7TIRFaijLMttAb0Eet0qe91mYainuWBMAD/G8kfHoFo3TS3ExVLqtfAvG9hCWHqe
siGCbft5EBTskQhrkNECA19Kqr9I2xpm7MbEN2T/blU87bt+KoRgSQ8DFHa9BKJY
bu7IB/3rSUFXKZgLD7QFnGkymRdR9M+m3hzXRCGhZ3p8lAGPdquTdD3mmWzVPkZ1
Ip/nRbPqRAKBjOOfEzOsl1aumBreZNsHOg2zJcfhRztjj+qvDDjEwvuz3QU/7HXP
t5q2Rq0VcCRlrA9VfAz2BQamHc31Q7AKNkqdIZ9QEd78PVT4jx7JP2fJYtCDRi3T
KvTj3uF0gEIzMEQRgGgqWE5UjkY98KFydTLQWYLJ6oGgrQphu7U=
=67Rb
-----END PGP SIGNATURE-----

--4sugj2cvc65btq7x--

