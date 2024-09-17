Return-Path: <linux-pm+bounces-14358-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB62597AC86
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 10:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC831F22DC8
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 08:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764467DA91;
	Tue, 17 Sep 2024 08:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="eAARKr/E"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F1410F4
	for <linux-pm@vger.kernel.org>; Tue, 17 Sep 2024 08:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726560115; cv=pass; b=it2bJb9blu8041rtC8rCwPKQoj92U958aEokf0r+YDB0v8vP+1Fz2CYy+fS7cFv9AAnosuxWDLwN+KAC5qJET5jnlNtkAoUgwfL12qQzVoh3F+aXTQbp3BlIHDnv9hbGZfHwpz1GkhohZJPMfzfxBj9aieM6I4xxsMINmZyYg3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726560115; c=relaxed/simple;
	bh=c0OKTuvp+vC48UfM9iJSM7SAdJrmcla37lHgfiteMZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCsM6HxCE5DcneEbhRILXihKPedIFxwug3Hy/nUB+pEuQEJ1st2rWYanr3cDEgtqymP/HOGOIMBFHSxjubgE+MDknAM0h6IijZRo8JKPWVyt1ZW0GRq991RMCo8wr3iexBMChGrW3yAnc++1G3uGzWxaONoHv2Sz3ruGhQBQ4/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=eAARKr/E; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726560103; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=g1E5COPtuNK05DD53YJRHbt8RyMD3czt8hqDqwiGJXwJ7iIfKG5tOFF0tsvOi/VZ4uYixeBh4PM+/KgjXqwSWA12aB8tqoRQU7ynRYatXj/35p9J0JS1s6QZWJGWcGwV2ReYC3O2y3m70Yg2YlTzTgs0lFqI+KJVx6KXiIcivcg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726560103; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GnIrWgdQJobn+uKUR23OeK9l2LAJqOlXKttnlLVUU1I=; 
	b=NNCTefgbt0XyJYzzU85kHh0PfPxzmM+yFbWEmtDlU82O9LStPbTB22BBkUy1foKpOvac8mx1YUYX3h3nyjwOqWzYONx6JmF1YCN65XDtI+o4rzKQPjk/exv6Hdy6CQWJzEPU2eqwxKOplGEXJ5noMDL1dVspd/hxJyPKv07Jl70=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726560103;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=GnIrWgdQJobn+uKUR23OeK9l2LAJqOlXKttnlLVUU1I=;
	b=eAARKr/E8aQ3Xi8d3ji0rwG6lhxc+1yu3lzbCv61/ySM7p2FoDC7MSWus5rxrQHF
	OFiIRl1zQ01RrX4kvGEQ7y5WYx2EVCjS6DTa/aom70Woas4/CskqFFnw8UUkw3gWUW7
	odAfgwVHsEMAzPsAum0x2+FXAP9j5kioqr8ikPMM=
Received: by mx.zohomail.com with SMTPS id 1726560102584882.9165124228391;
	Tue, 17 Sep 2024 01:01:42 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id D637A106045D; Tue, 17 Sep 2024 10:01:38 +0200 (CEST)
Date: Tue, 17 Sep 2024 10:01:38 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jelle van der Waa <jelle@vdwaa.nl>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, linux-pm@vger.kernel.org
Subject: Re: [RFC 4/4] platform/x86: dell-laptop: Use
 power_supply_charge_types_show/_parse() helpers
Message-ID: <pv7pnunddfnhctukuv7nfuofgu6laipn7bqtms7hmpayt2b27f@kmzcuci5w4nf>
References: <20240908192303.151562-1-hdegoede@redhat.com>
 <20240908192303.151562-5-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fxsak2kvsqjf5zv3"
Content-Disposition: inline
In-Reply-To: <20240908192303.151562-5-hdegoede@redhat.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/223.982.64
X-ZohoMailClient: External


--fxsak2kvsqjf5zv3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Sep 08, 2024 at 09:23:03PM GMT, Hans de Goede wrote:
> Make battery_modes a map between tokens and enum power_supply_charge_type
> values instead of between tokens and strings and use the new
> power_supply_charge_types_show/_parse() helpers for show()/store()
> to ensure that things are handled in the same way as in other drivers.
>=20
> This also changes battery_supported_modes to be a bitmap of charge-types
> (enum power_supply_charge_type values) rather then a bitmap of indices
> into battery_modes[].
>=20
> FIXME: not tested yet
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

I quickly skipped over this and it LGTM. Ideally the Extension API
will get fully rid of the custom show()/store() :)

-- Sebastian

>  drivers/platform/x86/dell/dell-laptop.c | 54 ++++++++++++-------------
>  1 file changed, 25 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x=
86/dell/dell-laptop.c
> index a3cd0505f282..d2ef18547c41 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -103,15 +103,15 @@ static bool mute_led_registered;
> =20
>  struct battery_mode_info {
>  	int token;
> -	const char *label;
> +	enum power_supply_charge_type charge_type;
>  };
> =20
>  static const struct battery_mode_info battery_modes[] =3D {
> -	{ BAT_PRI_AC_MODE_TOKEN,   "Trickle" },
> -	{ BAT_EXPRESS_MODE_TOKEN,  "Fast" },
> -	{ BAT_STANDARD_MODE_TOKEN, "Standard" },
> -	{ BAT_ADAPTIVE_MODE_TOKEN, "Adaptive" },
> -	{ BAT_CUSTOM_MODE_TOKEN,   "Custom" },
> +	{ BAT_PRI_AC_MODE_TOKEN,   POWER_SUPPLY_CHARGE_TYPE_TRICKLE },
> +	{ BAT_EXPRESS_MODE_TOKEN,  POWER_SUPPLY_CHARGE_TYPE_FAST },
> +	{ BAT_STANDARD_MODE_TOKEN, POWER_SUPPLY_CHARGE_TYPE_STANDARD },
> +	{ BAT_ADAPTIVE_MODE_TOKEN, POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE },
> +	{ BAT_CUSTOM_MODE_TOKEN,   POWER_SUPPLY_CHARGE_TYPE_CUSTOM },
>  };
>  static u32 battery_supported_modes;
> =20
> @@ -2261,46 +2261,42 @@ static ssize_t charge_types_show(struct device *d=
ev,
>  		struct device_attribute *attr,
>  		char *buf)
>  {
> -	ssize_t count =3D 0;
> +	enum power_supply_charge_type charge_type;
>  	int i;
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(battery_modes); i++) {
> -		bool active;
> +		charge_type =3D battery_modes[i].charge_type;
> =20
> -		if (!(battery_supported_modes & BIT(i)))
> +		if (!(battery_supported_modes & BIT(charge_type)))
>  			continue;
> =20
> -		active =3D dell_battery_mode_is_active(battery_modes[i].token);
> -		count +=3D sysfs_emit_at(buf, count, active ? "[%s] " : "%s ",
> -				battery_modes[i].label);
> +		if (!dell_battery_mode_is_active(battery_modes[i].token))
> +			continue;
> +
> +		return power_supply_charge_types_show(dev, battery_supported_modes,
> +						      charge_type, buf);
>  	}
> =20
> -	/* convert the last space to a newline */
> -	if (count > 0)
> -		count--;
> -	count +=3D sysfs_emit_at(buf, count, "\n");
> -
> -	return count;
> +	/* No active mode found */
> +	return -EIO;
>  }
> =20
>  static ssize_t charge_types_store(struct device *dev,
>  		struct device_attribute *attr,
>  		const char *buf, size_t size)
>  {
> -	bool matched =3D false;
> -	int err, i;
> +	int charge_type, err, i;
> +
> +	charge_type =3D power_supply_charge_types_parse(battery_supported_modes=
, buf);
> +	if (charge_type < 0)
> +		return charge_type;
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(battery_modes); i++) {
> -		if (!(battery_supported_modes & BIT(i)))
> -			continue;
> -
> -		if (sysfs_streq(battery_modes[i].label, buf)) {
> -			matched =3D true;
> +		if (battery_modes[i].charge_type =3D=3D charge_type)
>  			break;
> -		}
>  	}
> -	if (!matched)
> -		return -EINVAL;
> +	if (i =3D=3D ARRAY_SIZE(battery_modes))
> +		return -EIO;
> =20
>  	err =3D dell_battery_set_mode(battery_modes[i].token);
>  	if (err)
> @@ -2421,7 +2417,7 @@ static u32 __init battery_get_supported_modes(void)
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(battery_modes); i++) {
>  		if (dell_smbios_find_token(battery_modes[i].token))
> -			modes |=3D BIT(i);
> +			modes |=3D BIT(battery_modes[i].charge_type);
>  	}
> =20
>  	return modes;
> --=20
> 2.46.0
>=20

--fxsak2kvsqjf5zv3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbpN18ACgkQ2O7X88g7
+pqMjQ//Vkz40i7x5YeiwTBZtqLQvMIcCds73nIz2PsMvWgsRAwlv3iR7DU9Axdj
6mbbVuUnZRX4jIG1dBUt7KmE6q4aR5EpeiU3GI4b/oJcltLMpPZ+zhBJPuCGTKgo
9id0fRKORnKWUdPaZ6tEOUX3DheeZu1dn/qz61S66Ryta7hCOwHlDGzIrruvmAHX
9F6zpWFY0/j35BKrkAf4LzsCSjQyDYacGCxYTezBdn5Fw2h7ddX6cy8rq7HX3/hK
woRKouK55o4OfWmoyRq+vaz1gBYn3rzpAAMekZjoAascnh9frmSRB5Dg8ysp7Pyn
6Yrm1RJtfJLNYDTv4xX2zm0Vt730Ljgx7vrRGZE5A3emewdavv2S9oef3dY9ycFn
2dRpKMTau+uOmiBu6T51KVnHXRc1NTM8Q+KWJZ7IsXHvfyfeWa2OCM1nwHPQd3F0
uSoLMWLH0Y8CnjAEQ/K883vu+QPf3BIx8DHYGHTJck1Z1UBwk6S6qub4H01wyNtg
JroMEmRDF3a+tOIccBRTFqKXYv3qrGicDJz+rrr9P2tRHz01qgBFbrr3I5SpNR8A
AQBKBsqRzBH/754F+OAHUNvLjWRpZCUF4bCXbc1/XGPEt64MLcJoEDU/4VL7KCWw
jpi81wXJzm5coRREraQeKTYcu7eal/pME484rvfe44RcN8YG6vw=
=Oew7
-----END PGP SIGNATURE-----

--fxsak2kvsqjf5zv3--

