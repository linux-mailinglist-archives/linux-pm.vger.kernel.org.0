Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF34C125856
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 01:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfLSAQ1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 19:16:27 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38888 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfLSAQ0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 19:16:26 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 45E6F2929BD
Received: by earth.universe (Postfix, from userid 1000)
        id E4A793C0C7B; Thu, 19 Dec 2019 01:16:22 +0100 (CET)
Date:   Thu, 19 Dec 2019 01:16:22 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] power: reset: gpio-restart: don't error on deferral
Message-ID: <20191219001622.ymsv54rnnrmgkvnt@earth.universe>
References: <20191029201726.12786-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bbcvvkyn2dmty7za"
Content-Disposition: inline
In-Reply-To: <20191029201726.12786-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--bbcvvkyn2dmty7za
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 30, 2019 at 09:17:26AM +1300, Chris Packham wrote:
> Don't generate an error message when devm_gpiod_get fails with
> -EPROBE_DEFER.
>=20
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---

Thanks, queued to power-supply's for-next branch.

-- Sebastian

>=20
> Notes:
>     Changes in v2:
>     - use PTR_ERR_OR_ZERO() to avoid excessive PTR_ERR()
>=20
>  drivers/power/reset/gpio-restart.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/reset/gpio-restart.c b/drivers/power/reset/gpi=
o-restart.c
> index 308ca9d9d276..5466eeea261c 100644
> --- a/drivers/power/reset/gpio-restart.c
> +++ b/drivers/power/reset/gpio-restart.c
> @@ -64,9 +64,11 @@ static int gpio_restart_probe(struct platform_device *=
pdev)
> =20
>  	gpio_restart->reset_gpio =3D devm_gpiod_get(&pdev->dev, NULL,
>  			open_source ? GPIOD_IN : GPIOD_OUT_LOW);
> -	if (IS_ERR(gpio_restart->reset_gpio)) {
> -		dev_err(&pdev->dev, "Could not get reset GPIO\n");
> -		return PTR_ERR(gpio_restart->reset_gpio);
> +	ret =3D PTR_ERR_OR_ZERO(gpio_restart->reset_gpio);
> +	if (ret) {
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Could not get reset GPIO\n");
> +		return ret;
>  	}
> =20
>  	gpio_restart->restart_handler.notifier_call =3D gpio_restart_notify;
> --=20
> 2.23.0
>=20

--bbcvvkyn2dmty7za
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl36wVYACgkQ2O7X88g7
+pr9KA/+LmLaWD+a8hdmp0lQVGOdig5qGUaN+qIhDOJ6uudR2m15nhe/bgN6Vdf+
xUXXsb18SEHAKDJqK0k2pdHySbbhCHM0r8J/ThwbB5AopW2/1cotus+5ndBYF17o
Bv6NrDB7ClHxw78vgPvfx6TavBRrv+O1G2BeclYOT1CiC3yib1sDlOIwFnUJ9iZg
FmiMlSSgT2arxod3kjGPteL2LhUFNXb8GUve2KheexvnYCcHL8WC1zj7DTiNXl1W
HOjmR0cmDnMusQY4vgXBulRPF6vz3LTrRv0qtx88DnXVwM3c4dfkRX0/KKy93cAv
TAf5FwqIu6aAAV0MAuRRPUEzjOIUqJ6h4hLSp2MIA4fAubLYhZbyTNAqz3xboZZg
3Q/ONParYlnS9M3vqZ/cX0nDf5Vc1/TtlUdnAksotUM+sy4C3HEW8uzqO8vAitM/
OMgeyjIHQ9/6TcY83f2geoTy+LD7zafOW8kTOIfElNFfRQ7d26ENcPf88497NpEd
+W6GEAQQwCM4ZU4Ah4uIWI6LjpU3N5UGYMFC2AYpjubZvrSoUMTLuNfn956lhj1D
3qkKdgxYTdNaKTFP91RP6HUF/v39oYlddROIOs3qEKb8W6U/aqOoHXrKWC2DU+we
lHJ+udbHrrRQNWJTerSMo0ro8xvCv6jTrYYjnip5HyejNbr2Y28=
=d+tO
-----END PGP SIGNATURE-----

--bbcvvkyn2dmty7za--
