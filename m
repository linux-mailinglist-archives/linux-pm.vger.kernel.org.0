Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 403ED125868
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 01:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfLSAUV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 19:20:21 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38974 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfLSAUV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 19:20:21 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id E29C3291E6E
Received: by earth.universe (Postfix, from userid 1000)
        id E98603C0C7B; Thu, 19 Dec 2019 01:20:17 +0100 (CET)
Date:   Thu, 19 Dec 2019 01:20:17 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] power: supply: max77650: add of_match table
Message-ID: <20191219002017.4f4j3u6tghhjgf32@earth.universe>
References: <20191210100855.11252-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h27er267woat7low"
Content-Disposition: inline
In-Reply-To: <20191210100855.11252-1-brgl@bgdev.pl>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--h27er267woat7low
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 10, 2019 at 11:08:55AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> We need the of_match table if we want to use the compatible string in
> the pmic's child node and get the charger driver loaded automatically.
>=20
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Thanks, queued to power-supply's for-next branch.

-- Sebastian

>  drivers/power/supply/max77650-charger.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/power/supply/max77650-charger.c b/drivers/power/supp=
ly/max77650-charger.c
> index 5f9477c5cf5a..d913428bedc0 100644
> --- a/drivers/power/supply/max77650-charger.c
> +++ b/drivers/power/supply/max77650-charger.c
> @@ -354,9 +354,16 @@ static int max77650_charger_remove(struct platform_d=
evice *pdev)
>  	return max77650_charger_disable(chg);
>  }
> =20
> +static const struct of_device_id max77650_charger_of_match[] =3D {
> +	{ .compatible =3D "maxim,max77650-charger" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max77650_charger_of_match);
> +
>  static struct platform_driver max77650_charger_driver =3D {
>  	.driver =3D {
>  		.name =3D "max77650-charger",
> +		.of_match_table =3D max77650_charger_of_match,
>  	},
>  	.probe =3D max77650_charger_probe,
>  	.remove =3D max77650_charger_remove,
> --=20
> 2.23.0
>=20

--h27er267woat7low
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl36wkEACgkQ2O7X88g7
+po83g/9E//H8/CqygBtibD+Mu7D7rKESNwpdCcLJjRmLIAQUpKGTJNRv0T9xZmk
/ow/02Lv4SwHDYetIfqT0rJtM64TC5kGfIcC089ixFkkOgvnHxsp+H5AOUwWfOGe
ozE55OK0LjJUUzIDDUSo4i+AMclfwstTtWdkeliOkBXARI1DIJ3O5XVQybwEjPjN
WwyvIxWjxgcehJD15ax+mzfq9hi0x3cK5GA8dWitXaYthJzaOC8VZdchvh1H65gT
UDhwjJfSWDGYdgvCRcvmCB3XGYH0MRZvLXOOBVnb40CVE3FiEhwEycXSXZ1zZ+x3
rg2P2fqAk9htmOtw0ihNIrqePfnnrQJM2CLb7LGZ3SCYEf9QN+V1Ip0OU7WvbAsg
JMtvQ7o4XDyl0L8U8dnsbQA4JOhpdKpnKGFcEN3d1BD97rRMTWmxkqaH2rzX/wWA
FG7uN7+n3eXDwI6XnTPA7Kt9mDBveI3ceh78zxSjwJx4S6mWrCRzpYXvIjS4zQLI
2rnsk1qKIqqfT863meIOanuq8zGMwqAFwIyeC345am7Qe48n9sYuQIHIbpCK+E7x
hsS5s8aeq05r7zWISiuBv4bhyDgRWBUsUMWwtOq9tEPD1IZm38iYGHE96itYy4X5
leDacI19zC/yIGhYoAyp704YWnJxcdKVS+A+sgKnhVtccsYyvx0=
=Koja
-----END PGP SIGNATURE-----

--h27er267woat7low--
