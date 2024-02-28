Return-Path: <linux-pm+bounces-4529-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7C386BA88
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 23:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE081F25C24
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 22:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AE61361AD;
	Wed, 28 Feb 2024 22:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jrstkf+/"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F1B1361A4
	for <linux-pm@vger.kernel.org>; Wed, 28 Feb 2024 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709158108; cv=none; b=UkI92VjyXDI+ifNkr4Hq6J2yw3YYTExqt6YYT42/RgyE0Ajo9yNf21Tl9DZ75V7FnCnzfnN4SkL6YmFw5n3V+/x7DA+tTi/zL0MBX5g/nLiQg3vPl02CBZuaBux4ysjOvA/Wes0eh92/7tRWxxb0gzv1bt2w8/yIA+ALVamAT4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709158108; c=relaxed/simple;
	bh=SPfFbSo9UdOmBfLpyYZmccXxP0ygb6rMbCyvTmTX7qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuVcZifV0t9uBArJhY0xzt9kjWtGCORCqmD5Hbvz23P8J3C/y5yWC6IZPrrUjHNJyLj7u8+WDejwHWb1Dx9uCDQeUUHXYs1V9NlfKXFOWyKmPBhh+ih+Fjwnlf0n/yHMDm0bYYzaSBQ4Cri5gPhnsPrKo/Wyy7irLSF9/qRvklQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jrstkf+/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709158099;
	bh=SPfFbSo9UdOmBfLpyYZmccXxP0ygb6rMbCyvTmTX7qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jrstkf+/Oyws1AYYuqoSKQhwzLUkM+6IRQGXEow772gK0XT0nuW1c2w0/dGrVHP7M
	 GSs9n2JHwrJG47k43kLhA18KDQu1fg1Aqn+V8JjS7MFa53ushlP8Rf9Tvcq0A3u3eE
	 u9T4kcqdz1jaDSl4f81rzc9va5MD9Su3N5rpHHhEa7bE6vdV6kKidMvht+zwNIrko0
	 wAHx5c8zkA7XoVR6tZsNS9CM9j0zeg80rGgGknprYGiU+gMURXmnxDQBRiYtWlLpcF
	 7Mlf0NitquHjBI8a+Tz6g0UtspJgyImfKc8CvghibWSD9k/Fc8XmYBIHOQ7OOgBJb/
	 6ezr4WQE6lumA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 838A637820D7;
	Wed, 28 Feb 2024 22:08:19 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 001D91067A0C; Wed, 28 Feb 2024 23:08:18 +0100 (CET)
Date: Wed, 28 Feb 2024 23:08:18 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc: linux-pm@vger.kernel.org, maemo-leste@lists.dyne.org, pali@kernel.org
Subject: Re: [PATCH v2] power: supply: bq2415x_charger: report online status
Message-ID: <3x7vsf67lfdenb2zqh3no4eipvuw3q4ozcan4lxtf224tbgwvf@wpt76dsxgssp>
References: <20240228065840.2395243-2-absicsz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q66k7ry52vkolmrl"
Content-Disposition: inline
In-Reply-To: <20240228065840.2395243-2-absicsz@gmail.com>


--q66k7ry52vkolmrl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 28, 2024 at 08:58:41AM +0200, Sicelo A. Mhlongo wrote:
> Provide the Online property. This chip does not have specific flags to
> indicate the presence of an input voltage, but this is implied by all val=
id
> charging states. Fault states also imply the presence of VBUS, therefore
> set Online true for those as well, taking care to not set it when i2c
> reads have failed.
>=20
> Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
> ---
>  drivers/power/supply/bq2415x_charger.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/suppl=
y/bq2415x_charger.c
> index 6a4798a62588..8f24a33f0338 100644
> --- a/drivers/power/supply/bq2415x_charger.c
> +++ b/drivers/power/supply/bq2415x_charger.c
> @@ -991,6 +991,7 @@ static enum power_supply_property bq2415x_power_suppl=
y_props[] =3D {
>  	/* TODO: maybe add more power supply properties */
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_ONLINE,
>  };
> =20
>  static int bq2415x_power_supply_get_property(struct power_supply *psy,
> @@ -1017,6 +1018,14 @@ static int bq2415x_power_supply_get_property(struc=
t power_supply *psy,
>  	case POWER_SUPPLY_PROP_MODEL_NAME:
>  		val->strval =3D bq->model;
>  		break;
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		/* VBUS is present for all charging and fault states,
> +		 * except the 'Ready' state. On all i2c read errors, the
> +		 * Online state cannot be determined.
> +		 */
> +		ret =3D bq2415x_exec_command(bq, BQ2415X_CHARGE_STATUS);

Please forward errors, instead of silently ignoring them.

if (ret < 0)
    return ret;

Otherwise LGTM.

-- Sebastian

> +		val->intval =3D ret > 0;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> --=20
> 2.43.0
>=20

--q66k7ry52vkolmrl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmXfrsYACgkQ2O7X88g7
+pofjQ/+PkMq4dG9GjtnLCA+HkyMC6ZW70i2pMaHhd3SL9ngkRyfdlHV4EDrK8to
eh+AFojE4HQ8T0kdFJ8j3oTRJ80Kipt2SdYDbHa36KOt+PvqD0TA/RhQGOwYR8kQ
HXdNhBO7WAPZ/FiiyYBrOzWb3KcBacAvpXAwxrgkvpcchUay1UpAvKi1wd9BvhkP
L/dKxWSmPe9VFBqIEme18pToN2Q+j7wnxRt/X6dzQ6nvqgLzRKQGdA31kphEDZdL
y8kriIilNd//ZD3uVD6VtNlW2R0OtAU6T5dVeIyqD+ugsM5qFbSAdZRMakuILPty
n/+zLCA/9+MkL/HXZKdulJn9Bn6XkEAV//f3NNmJHqdGhqdTBaPGOTus2LMV3fSJ
zSPKtG+nvwEkmnxfQ0UxN5CTiXLMwR2VGp6iyAqR0JOPmtGMNMlq+ZMvlaJ/d5x9
VVRKdeQSuGgLXWRGa/NiX0HWDcu1Pcb6V6oBRDk5dHBCMgg/GH0TZmc/4aZUEFyv
DdraOtx+NS3ow2fueqXj6qMAk1rMFtpq4Q0XCfi8gGE1dxvLzDhZMpGWFcTBd5aK
I9UtwVNtWE8l7nYkY+vqzb7nI2h6Y+06M++jpgnN5DRAenVKnnm7flIQnOO1QG1c
9ddqg7K3uTiakDPIZdljcciXe85+aQBilrk83fZzaTLVIlW5W2Q=
=JN+6
-----END PGP SIGNATURE-----

--q66k7ry52vkolmrl--

