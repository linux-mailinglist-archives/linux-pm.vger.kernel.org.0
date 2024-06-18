Return-Path: <linux-pm+bounces-9516-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091D090DFC0
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 01:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 266531C22785
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 23:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FACB16FF28;
	Tue, 18 Jun 2024 23:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0PWmDC2n"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B33713A418;
	Tue, 18 Jun 2024 23:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718752777; cv=none; b=PaLHT+USVtNm0a/PWcNAUaHtO4iS/7tqbTiBhbUnBJg1IzgFImtveaNvJmpylCiUuD1OxmWSHAHzVj9VvvHMWayhD9t0bfCdLhwvqpaL0suShb2bDBZnHFb/2HjsWWx6FWSpxFF6TCwOHoTTKDUyIG/zfVrRZYg2RXffDejs5BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718752777; c=relaxed/simple;
	bh=sExA9pwsgk1Wl6JFNsUML9t4gRXkufNH45PnrfyBEQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cO/nZNC4rGUtJV5zV1ldUzmlSO2qcoKzQGiLuOm+LSwsQ4LhXyJDfZl1hX/0VAMhJomTAsjy9LoKS85viHjrFw6phQqLWpHAsv3UiJ2M/DxR/wXTISr4QjqTvrdWZ9nU/h9+fMXjFmOGLSCxR70p1Wrd9C6DCxkQNTZS6MU1pSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0PWmDC2n; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718752773;
	bh=sExA9pwsgk1Wl6JFNsUML9t4gRXkufNH45PnrfyBEQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0PWmDC2niBCHHTdHMgiQ49LXLpRhWdLxHZA6Grs8N7bIZtcmdX0e9ZEyWrvMGZ0Vq
	 9nxT2EJW6UQwFDk/lOlh1+aNz4N/69F15De6quGAF1LysO7ZeFuOxA9ej4pqO4mkBz
	 25wOWLeftRm9/QYb31PnhJuCPdPh8et8R5vlimhHT/2DkFt8u+E1YBLZGJWFYzat/U
	 e85wnN35ZC5NKsNXL6eZ9MqwkoXQv337GOFOBkGtdF1Sas70O99wdxOwXlhJHA7SJu
	 mH2REathmZddrzRVY1aBJe8qoYdS29AJlnB3mPA16lwUsI8ikpIlp+cRJkKf7YaTnT
	 HaMC+fmsL5I4A==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5A4F8378205D;
	Tue, 18 Jun 2024 23:19:33 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id DEC671060B1F; Wed, 19 Jun 2024 01:19:32 +0200 (CEST)
Date: Wed, 19 Jun 2024 01:19:32 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH v4 2/2] power: supply: add support for MAX1720x
 standalone fuel gauge
Message-ID: <dzrsh5dsraz62sc3mfhlmf5yolkzjet2agv2ochg3xg4ryfofs@bnmxbtsavv4o>
References: <20240617184504.304211-1-dima.fedrau@gmail.com>
 <20240617184504.304211-3-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bguifedf2yapndzu"
Content-Disposition: inline
In-Reply-To: <20240617184504.304211-3-dima.fedrau@gmail.com>


--bguifedf2yapndzu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 17, 2024 at 08:45:04PM GMT, Dimitri Fedrau wrote:
> The MAX17201 monitors a single cell pack. The MAX17205 monitors and
> balances a 2S or 3S pack or monitors a multiple-series cell pack. Both
> devices use a I2C interface.
>=20
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---

[...]

> +static int max1720x_read_word_data_nvmem(struct i2c_client *ancillary, u=
8 addr)
> +{
> +	u8 rx[2];
> +	struct i2c_msg msgs[] =3D {
> +		{
> +			.addr =3D ancillary->addr,
> +			.flags =3D 0,
> +			.len =3D 1,
> +			.buf =3D &addr,
> +		},
> +		{
> +			.addr =3D ancillary->addr,
> +			.flags =3D I2C_M_RD,
> +			.len =3D 2,
> +			.buf =3D &rx[0],
> +		},
> +	};
> +	int ret;
> +
> +	ret =3D i2c_transfer(ancillary->adapter, msgs, ARRAY_SIZE(msgs));
> +	if (ret !=3D ARRAY_SIZE(msgs))
> +		return ret < 0 ? ret : -EIO;
> +
> +	return get_unaligned_le16(&rx[0]);
> +}

Have you tried using i2c_smbus_read_word_data(ancillary, addr)
instead of the above?

[...]

> +static int max1720x_probe(struct i2c_client *client)
> +{
> +	struct power_supply_config psy_cfg =3D {};
> +	struct device *dev =3D &client->dev;
> +	struct max1720x_device_info *info;
> +	struct power_supply *bat;
> +	int ret;
> +
> +	info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	psy_cfg.drv_data =3D info;

psy_cfg.fwnode =3D dev_fwnode(dev);

Otherwise LGTM.

Thanks for your patch,

-- Sebastian

--bguifedf2yapndzu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmZyFfsACgkQ2O7X88g7
+prx6xAAlwpQKbrS94H1MDRsPhvwptjkxWRBnLE4X7JrpCrtwV2e2kxMHwpOqfgu
9s1jkhf5eqrjn92PpasZgHOPe5u/gpdpVXga1ZMb9WCydqUxEOLyFohLIwa4hTH7
aaqox/+B9chUuhtzVEThsp9CFbgbALsUFRUBkbAC7jjL0WaRoImXKf5JtxCipMX1
NLijICv5iP2ygApLi+VXhh7jtH+NF0JuFZf5u8lFjHvmyXqVrVZj7ZQ5DwFyPogo
7cem9dUxmXbeO8YPKio66RWoQDZ0u0pYa0hQueltckyJf4iHR5/SEUZd15n0/cKJ
Ye8D92KTH+mT5Axerd/DFVClMJbr8BipNb1CAMKqriQAFYy07m7OcZzuaVFfNyDB
xrWmJsRDNsP4FmVznB7s87dJrz2lwldB4N1scMDrRyZ/lt+LUUO2MX+F0dhAIyI/
+n1VOKsRiON+LTBUJcpzh8Gfn+YU/pJUkQPp/xz3mHKD2PW2VpJ/8rechB9FWwIp
Pw4gkNLduDaW+ve47IGF/fMhyyaY3nlrMLCt5RptaNTzf9GpCdLXyV/vAIh1Kwwe
LydtYatJjVL0Nm0aemLFIhQmbY4uxrlLNifsKx21rIFF7W3zO+xz+KVNaRQb7uzH
VyOWvLjGyHN7dcTxt6muscGMKQqRWRZ35oxb6h9TrHGySptTyok=
=f0lW
-----END PGP SIGNATURE-----

--bguifedf2yapndzu--

