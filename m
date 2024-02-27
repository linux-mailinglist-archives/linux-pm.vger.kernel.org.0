Return-Path: <linux-pm+bounces-4470-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4962186A0AB
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 21:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE1B11F25424
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 20:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95A714A0A0;
	Tue, 27 Feb 2024 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZRm1OEfe"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107591D6A8
	for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 20:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709064700; cv=none; b=AAOaqoSR+5jh3Mc/KcWWErFJceo+qV/qHgllCjLkvzBMUcOJz8NkVq0/bu1v/nGcm+Jt5Fheyo7JK9nPObt/xsOTNlzXwS3yYX+Fwpweu0JLE1YScTBJI/UdgzGcGiiL9HZBFKMKV3D52ojPugizpwvBkMLc5H3RoyuZOU0z/7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709064700; c=relaxed/simple;
	bh=QKinL78kEX4bqUVHZlw0I+WcbQu+KGNKXhQzKQRdtj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BX4lm58vrkeDbbrOQfJ5wRzQUPA6mJD8hTOLy3O5z7oUrvYS8jvUL6Wut8Lr7uBYrxa/UPauGyilRdTgy+UoB8cWjHZcTJ8oJsTQPqKCXNP/n+HFCAJ/gp5MfFvLMnNsfewhICbcHwolY3ukGynk2ykk+hU8WRdu4vyGGTa3y1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZRm1OEfe; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709064697;
	bh=QKinL78kEX4bqUVHZlw0I+WcbQu+KGNKXhQzKQRdtj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZRm1OEfe0r5l7Z4T8WMuaZPFG4fn8MrjHOHQ8elioXANIDHn3EhoJ1EFykbxXgF6W
	 NHbzLT58Tdwdy1EZglhXtviKeXaOSX7fNilspjrT4Vy7J18O1Ft8LFs4d8IxpvEjBC
	 wEnDLjY38t1nhSPxtC2Toe8bpZOmv5/kU2IXJGnyu1aZ2KeTN0rH8aqta3qYSwqJ5P
	 iLFd7YbHGBqMmyIMdqNbddkfRzsQaLXa9kBduIeRawNGUDvvKVEjzOhHw0oOssUDCk
	 x1yVL16AJA0S+vbQvjBZGUERprbid3L01yLp//iB87/ljZ8QLB5lHOAR+TAqQ87QFN
	 NFN/7vsHBXugA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 56A623781FE3;
	Tue, 27 Feb 2024 20:11:37 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id C30BF10606FE; Tue, 27 Feb 2024 21:11:36 +0100 (CET)
Date: Tue, 27 Feb 2024 21:11:36 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc: linux-pm@vger.kernel.org, maemo-leste@lists.dyne.org, pali@kernel.org
Subject: Re: [PATCH] power: supply: bq2415x_charger: report online status
Message-ID: <6slfmvqmtawwjlsobcfod6ewcjjbzmylz3owsdamdi4dod55wr@iiox5rzjj5ht>
References: <20240226194432.2174095-1-absicsz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dakrgprgaxsm6kyf"
Content-Disposition: inline
In-Reply-To: <20240226194432.2174095-1-absicsz@gmail.com>


--dakrgprgaxsm6kyf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 26, 2024 at 09:44:32PM +0200, Sicelo A. Mhlongo wrote:
> Provide the Online property. This chip does not have specific flags to
> indicate the presence of an input voltage, but this can be inferred from
> the reported charging status.

The datasheet suggests, that you can get the status from the fault
bits:

011 - Poor input source or VBUS < UVLO

Greetings,

-- Sebastian

>=20
> Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
> ---
>  drivers/power/supply/bq2415x_charger.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/suppl=
y/bq2415x_charger.c
> index 6a4798a62588..5b47a1d0a51a 100644
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
> +		ret =3D bq2415x_exec_command(bq, BQ2415X_CHARGE_STATUS);
> +		/* Charger is Online when Charging or Full are reported. It is
> +		 * also likely online for the Unknown/Fault state too, but
> +		 * there is no way to be absolutely sure.
> +		 */
> +		val->intval =3D (ret =3D=3D 1 || ret =3D=3D 2);
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> --=20
> 2.43.0
>=20

--dakrgprgaxsm6kyf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmXeQfQACgkQ2O7X88g7
+prsqRAAgQn4+IU1MJJRPtWx5O7m/aToxEmTGht4lJLLDNES9p+Iz5E6Kwq09HEO
0h/yrF/XEWyC6YQaFq8MMrB+2NPtPTgl5Y/c/1LLmkL6IA8o8Gf0/EO3WE6UIHi3
9w5Z2dDvknLnoxxJ2ZJH8AIld6s1bL49xID/1EQEnkfQRRnPKf7lq1GpNuop3iEB
TTWPI4DdVwNL0QbnmW8sjyH19xeXhqmsq6i0OgqYzPQOmE3EhO/7Ec/Sn+Qlahq0
N8e3YcessvcrAZAlSkvJlS7bmNCHI5jbDjs2Lvp6tH+38y8cYaaJQkuqGa2/b0I/
kkAfgd4oUMUmlkMiIE0FRVHHhkFYxIyrkfvFWKf+2R8KW8QiwHM9FBKkD2vl5vYa
BAumbN/Vfw4+yvZ+CJECrj8f9DSMIOXb2QDyX5Q6QjKe+MTgWohJoPn06TJRH6Sw
D2z5qKWddVrVv900kYOv1d55G0H+nXFYAMfk3TVSZdG/S84kZtbkxNHLJ40BklpL
5pzBrIxLDWZv5K8aO5w9TSQATbQoYvPokg0mdbIRtUaGZ2G7cU6UQ0bF8gM36rWn
l0pVEuW8/Gy9dp25ABFfCB6R6MFSMI2kfYm8T5BaJA+U5PyrGnXdUNIB+K6Eflwc
kZ4uTTbDRh7ZRKWsg5Z8qEYsOxEOqJ8QsVoXbMrnqUsqv1KyyM4=
=I+/y
-----END PGP SIGNATURE-----

--dakrgprgaxsm6kyf--

