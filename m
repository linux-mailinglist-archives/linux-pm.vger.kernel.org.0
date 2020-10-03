Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14492282699
	for <lists+linux-pm@lfdr.de>; Sat,  3 Oct 2020 22:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgJCU3W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 3 Oct 2020 16:29:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgJCU3W (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 3 Oct 2020 16:29:22 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE86820709;
        Sat,  3 Oct 2020 20:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601756962;
        bh=J9VzVpSv4ne7x+efevq713H7wAuSXht7t9UM+Lg8uy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sRVZfdQzgqzdlSB8EnKwyViywRf2+IpzkB+clZiFa53fi7VL9REwrW5Gma1gOcD3V
         XoutaRk0cwloABTWda2DVJDqMOEapQSYVe4w3x5IwFWHjLmlD0HV2s9P6Gaum2c/fN
         pGMuHkW/NGnwrhnpwywpIpgv6+PmkYQ1NVVcOs6g=
Received: by earth.universe (Postfix, from userid 1000)
        id DDC5A3C0C87; Sat,  3 Oct 2020 22:29:19 +0200 (CEST)
Date:   Sat, 3 Oct 2020 22:29:19 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonathan Bakker <xc-racer2@live.ca>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] power: supply: bq24257: skip 'struct acpi_device_id'
 when !CONFIG_ACPI
Message-ID: <20201003202919.mj4vvwuckgyxbyea@earth.universe>
References: <20200911162729.3022-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f6lzqff7ykp3jdi6"
Content-Disposition: inline
In-Reply-To: <20200911162729.3022-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--f6lzqff7ykp3jdi6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the cleanup, I queued all 7 patches.

-- Sebastian

On Fri, Sep 11, 2020 at 06:27:23PM +0200, Krzysztof Kozlowski wrote:
> Since ACPI_PTR() is used to NULLify the value when !CONFIG_ACPI, the
> struct acpi_device_id becomes unused:
>=20
>   drivers/power/supply/bq24257_charger.c:1155:36: warning:
>     'bq24257_acpi_match' defined but not used [-Wunused-const-variable=3D]
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/power/supply/bq24257_charger.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/power/supply/bq24257_charger.c b/drivers/power/suppl=
y/bq24257_charger.c
> index 8e60cb0f3c3f..96cb3290bcaa 100644
> --- a/drivers/power/supply/bq24257_charger.c
> +++ b/drivers/power/supply/bq24257_charger.c
> @@ -1152,6 +1152,7 @@ static const struct of_device_id bq24257_of_match[]=
 =3D {
>  };
>  MODULE_DEVICE_TABLE(of, bq24257_of_match);
> =20
> +#ifdef CONFIG_ACPI
>  static const struct acpi_device_id bq24257_acpi_match[] =3D {
>  	{ "BQ242500", BQ24250 },
>  	{ "BQ242510", BQ24251 },
> @@ -1159,6 +1160,7 @@ static const struct acpi_device_id bq24257_acpi_mat=
ch[] =3D {
>  	{},
>  };
>  MODULE_DEVICE_TABLE(acpi, bq24257_acpi_match);
> +#endif
> =20
>  static struct i2c_driver bq24257_driver =3D {
>  	.driver =3D {

--f6lzqff7ykp3jdi6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl943xwACgkQ2O7X88g7
+pqmhg/8CoZ/3hYPZvX2haOZeyec41zEUJUuZTK8mk3jzFxLpGtd40Pudag67WM4
AYPUQ7S+izSAPRyuBrJB50NEt3EES31tSKyLGWVYPuPz/l27+TEKwyXEbkWe2d68
Uelbk61Fk9ZRLM/V+S4RZWjjNCJd5ywp7x681N6TQ55I7uFck7T9QOarMt/JQnfj
HO66QUvPa6nHYs8k+TS0DLS0Yr4ipaWFtkRzgcw011redDQrs2C+BWBaZ2I74Jid
J1EYjBXDjXYTK53ZB4n5vo3+q/riALMfwK93276fIzczh0XBMtr6vswq7hE/vFtL
gCF/hFaubZlA9DdMsMxtyQTguHGYHyks95diJQ5MLfIp8I3foiS4VL6xmCxr662q
2jHvZ8wh/9m/Aiui0Ejf4mD+G2Tz1xGsg5yO9WBlCFmJ+ZsYULSBdS0iSHQ4m+hf
ivD7FpKlNogliVXhqCAdxofEAevD5GEPAsmk4xmoPzyD8cp5v3ALJf1rb5RawlRx
mJmUCyzWfmCrETAFdr1wv3swldwc1lzq17uITYh4pFPa2o4Zaue1LEXuAa4ueqF9
ANXCll0zYZgR8F/sVVkYRHRpnAWmFUhrkv1slndLkdgvtl9lYXEXX8MX6iN2ciGi
JB/W0Z1jbX5DdtWno07X7/xUf8lIaBwWFH//IVlzDRKUcSoZP6w=
=xLab
-----END PGP SIGNATURE-----

--f6lzqff7ykp3jdi6--
