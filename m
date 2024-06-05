Return-Path: <linux-pm+bounces-8669-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD52A8FD9AB
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 00:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F513287182
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 22:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63E515ECDE;
	Wed,  5 Jun 2024 22:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MA+prhi9"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DDF15FD08;
	Wed,  5 Jun 2024 22:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717625701; cv=none; b=KsQcjOoOtkPsEBTpE/erlXLZzg6MfKalgoVrQQKowvIHqxneFiGNbRt8f3+z0HfRBLjwxaoBxcLIx0K+p8NnCX+qr54bQBmrWyNBC3mQ5rIpzCHEKKFtTKinRzhx1H6cCvnt9fexQ7Cy+3c7olT0hkFXCPNEISnT+1MnHu5uYnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717625701; c=relaxed/simple;
	bh=OygkjoyZ/s/fhSyNEsLEuxpSBom9wgFRfnLr2OQNNS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5b55MwIWwyn5D6JD2sFP4SU5+Z5oX6mS/rdO+hp2f0umQ1Dg/zNU7dJSo8U/Yr2rQ01f4o6zJ/xHsIxRhWGGfkaLA58kyEQKtciBoIpwNZUHaP1E1m4U1PQupAahlDeMTkMbCOE3oWOBqNpv/y3yIu/Dsv+mpepNS3yT+vzf3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MA+prhi9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717625698;
	bh=OygkjoyZ/s/fhSyNEsLEuxpSBom9wgFRfnLr2OQNNS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MA+prhi9PA33gVVpvWbDWL7TSkaXaCNX8TRebfcjMbykXj0D5vEhyBeZU3wY3eP3E
	 n0Us9VxBRKtWBmpuJxsR/Npdsqtgh+MTIWcJs59zZ5sxpzhXSyvWOGMQ9KlqpqER1P
	 anppjJCt/fgvGuf7SuylOF/003VqRRbVmOUAUFg1JFn1UrNL8kuGrDZHLuRKERWk3W
	 7c1oD9AQWxH6+1IJ+EuA+4q49goTWmvdzFF3d8ioYxZrAmKN10VECzHHfzVWGwTPNt
	 gjrg7FsKDt2M537R3jQO0t1M0vMo9LD7ZV8zh9IJ2pN2qwh+MIdpQTF+WnuM4TYhKc
	 yb9H6+ljN7k0g==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3927F378061A;
	Wed,  5 Jun 2024 22:14:58 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id BE2DF1060501; Thu, 06 Jun 2024 00:14:57 +0200 (CEST)
Date: Thu, 6 Jun 2024 00:14:57 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Lee Jones <lee@kernel.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>, chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
	Dustin Howett <dustin@howett.net>, Stephen Horvath <s.horvath@outlook.com.au>, 
	Rajas Paranjpe <paranjperajas@gmail.com>
Subject: Re: [PATCH v2 2/3] power: supply: add ChromeOS EC based charge
 control driver
Message-ID: <ksot2xs4vecqpjrx36z3zbpoasukor2bzh7gzwtbf7in3sudjk@pdmjlr4ythve>
References: <20240528-cros_ec-charge-control-v2-0-81fb27e1cff4@weissschuh.net>
 <20240528-cros_ec-charge-control-v2-2-81fb27e1cff4@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ybg7jici7744px53"
Content-Disposition: inline
In-Reply-To: <20240528-cros_ec-charge-control-v2-2-81fb27e1cff4@weissschuh.net>


--ybg7jici7744px53
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 28, 2024 at 10:04:11PM +0200, Thomas Wei=DFschuh wrote:
> +	battery_hook_register(&priv->battery_hook);
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +}
> +
> +static int cros_chctl_remove(struct platform_device *pdev)
> +{
> +	struct cros_chctl_priv *priv =3D platform_get_drvdata(pdev);
> +
> +	battery_hook_unregister(&priv->battery_hook);
> +
> +	return 0;
> +}

Please use devm_add_action_or_reset() or introduce
devm_battery_hook_register(), which could also be used by
dell-wmi-ddv. Otherwise LGTM.

-- Sebastian

> +
> +static const struct platform_device_id cros_chctl_id[] =3D {
> +	{ DRV_NAME, 0 },
> +	{ }
> +};
> +
> +static struct platform_driver cros_chctl_driver =3D {
> +	.driver.name	=3D DRV_NAME,
> +	.probe		=3D cros_chctl_probe,
> +	.remove		=3D cros_chctl_remove,
> +	.id_table	=3D cros_chctl_id,
> +};
> +module_platform_driver(cros_chctl_driver);
> +
> +MODULE_DEVICE_TABLE(platform, cros_chctl_id);
> +MODULE_DESCRIPTION("ChromeOS EC charge control");
> +MODULE_AUTHOR("Thomas Wei=DFschuh <linux@weissschuh.net>");
> +MODULE_LICENSE("GPL");
>=20
> --=20
> 2.45.1
>=20

--ybg7jici7744px53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmZg41oACgkQ2O7X88g7
+ppHWg/6Akqc7xPbe8vn0c7y32Lsm9lNoiZc6+Kchd2odRljHmxUOWBSDPJaDPI7
YZnAQbojBkkacytDImu202P4kz0DOVKtIpU7QOMM2aBEuZIPzwWXfIyDhARnvzZo
VIfGo1tJT9KZZyMQ3kSNUJ66Sm6zKVhbAVjgro9IfSnGgbwvv5Mh0E1rEMMr54mk
lFkeqH6uWyItHKpEc/BuhtXaDQg8Im5KorFAVfBdr8UWfvtCBRFvDV1NJw03Dt6l
615ZZRDma0YB5cpJpeXX0xHgTCynFzEVLXTnuESVpKHvoFEWUi201wvbfg5e+wg3
Dsye4X3+rLjh7uceXmSfccskgFQpjpMO071k3E210hfCC09cD9O2lJVGgZXFuEY3
oRwNmiKIPEbE54phxmXBAYuBys9Q5qthQ7geZgK7Yh2GDHogvFtMMAf7epTkGZEF
jMsn/rSuVKL7drtI2l4+IYT4cf0BSDdasbSPZHv/Rmil/TqoSEd70LkL1eZHy3Nd
GfDhOOd1vm+HlNS2VIj5ihSoLcp4PFh0jM+ktP9vuK/CZ5Tz+h7brJ9oMHF315Fh
7XJ3PzlVm4w5m5Rb3L9nKwRTWM+FMQi1vZabAINoyWTBK0KjPHSBLTaniPmsGcbW
F8TJ2O86gj96uBtK+GIrqMb+d1d2oPuz3LqtZPYXJ9LEZaBDPeo=
=AhyB
-----END PGP SIGNATURE-----

--ybg7jici7744px53--

