Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3BF347609
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 11:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbhCXKZg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 06:25:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235732AbhCXKZJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Mar 2021 06:25:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80641619E4;
        Wed, 24 Mar 2021 10:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616581508;
        bh=CDghQllEtQOE/1s+z8/+VBxf90Xro01/LsX/GyYTQlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LCGjSZgVlcx0fx/b402atB98b91WBhI5aGb4Kl/h3+JtTy7oK0jdttn63gfcY3+EZ
         wCkVDAKkaLdgLDgBXP8yH6RhEXI/LIL64XzjKKoQVunaqbV6ZjGboITHYrkZL1uDC7
         sy5tnDyLF5axevofI2VOAwlOBFSc7wI+gDMUDhqj2p9xxWQ+TRLtZ1uxhQ16rDtii8
         1WsjbV/9bZFr3NBIgT+9CnK+HaqOb/E6p36CDiKed2L7+2IdznE0lAabOTdxw8yAQO
         LCBC09CF5lMylQcF6AKyyUuaYFd/LLds7bOFo1dWeMZoDbRZkbpBfXOQq+JIXIrLLp
         fZLVpU/1XpjHg==
Received: by earth.universe (Postfix, from userid 1000)
        id 76B663C0C96; Wed, 24 Mar 2021 11:25:06 +0100 (CET)
Date:   Wed, 24 Mar 2021 11:25:06 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: axp20x_usb_power: fix work-queue init
Message-ID: <20210324102506.3ta2zstmrwq4wswb@earth.universe>
References: <cover.1616574973.git.matti.vaittinen@fi.rohmeurope.com>
 <a774ca25010b7c932c07f22ce8a548466705c023.1616574973.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="votk3apotqepkpt5"
Content-Disposition: inline
In-Reply-To: <a774ca25010b7c932c07f22ce8a548466705c023.1616574973.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--votk3apotqepkpt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 24, 2021 at 11:21:34AM +0200, Matti Vaittinen wrote:
> The commit 6d0c5de2fd84
> ("power: supply: Clean-up few drivers by using managed work init")
> Re-introduced wrong order of initializing work-queue and requesting
> the IRQs which was originally fixed by the commit b5e8642ed95f
> ("power: supply: axp20x_usb_power: Init work before enabling IRQs")
>=20
> In addition this caused the work queue to be initialized twice.
>=20
> Fix it again.
>=20
> Fixes: 6d0c5de2fd84 ("power: supply: Clean-up few drivers by using manage=
d work init")
>=20
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reported-by: Chen-Yu Tsai <wens@csie.org>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Needs to be merged by Greg, since I do not have 6d0c5de2fd84 in
my tree.

-- Sebastian

>  drivers/power/supply/axp20x_usb_power.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supp=
ly/axp20x_usb_power.c
> index 4259709e3491..e954970b50e6 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -594,7 +594,11 @@ static int axp20x_usb_power_probe(struct platform_de=
vice *pdev)
>  	power->axp20x_id =3D axp_data->axp20x_id;
>  	power->regmap =3D axp20x->regmap;
>  	power->num_irqs =3D axp_data->num_irq_names;
> -	INIT_DELAYED_WORK(&power->vbus_detect, axp20x_usb_power_poll_vbus);
> +
> +	ret =3D devm_delayed_work_autocancel(&pdev->dev, &power->vbus_detect,
> +					   axp20x_usb_power_poll_vbus);
> +	if (ret)
> +		return ret;
> =20
>  	if (power->axp20x_id =3D=3D AXP202_ID) {
>  		/* Enable vbus valid checking */
> @@ -647,10 +651,6 @@ static int axp20x_usb_power_probe(struct platform_de=
vice *pdev)
>  		}
>  	}
> =20
> -	ret =3D devm_delayed_work_autocancel(&pdev->dev, &power->vbus_detect,
> -					   axp20x_usb_power_poll_vbus);
> -	if (ret)
> -		return ret;
>  	if (axp20x_usb_vbus_needs_polling(power))
>  		queue_delayed_work(system_power_efficient_wq, &power->vbus_detect, 0);
> =20
> --=20
> 2.25.4
>=20
>=20
> --=20
> Matti Vaittinen, Linux device drivers
> ROHM Semiconductors, Finland SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
>=20
> ~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
> Simon says - in Latin please.
> ~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
> Thanks to Simon Glass for the translation =3D]=20

--votk3apotqepkpt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBbE38ACgkQ2O7X88g7
+prwMxAAkb2bEeLaQGKPtNCmvj7cRBq7+hybT4XSOOuDk4+ETI7xYL/FxW2hSXoR
15AlwNzmjz/SHYi0qhEi7BrZvrniYYyXRk0Fc7eITlFhxNO52amUGa9LgNFoFn+G
B0ZfX2Y1gzfkHhtbQrN0PwaCLAcfCfcdmQ45U+Vk7prkuZhN9QvVLAYzR8MIcuFs
jt7buPU4TeUeFeWNTygvxaOtc0eaWz27LBgS4Tll2dKTZIN1fW5d2Ey0z99QNCrB
Tix4UiUmcGfzSfbxm8pW1MBLmsfrqLPruqx3E8P/2e2F27nR85ZZ2cwhx+mIdryn
zbNBxwcjnl0XB5cbDTxDox6zPBMiqzfzXyDvRQj03fsv7t3aEg8sTVrhi1f3qfD+
VxWxlP8HXiYs2mrJ0Ecim7IAGL4UwCusTnY6nI6OPy50iM6rVHAjJ1AniZi9/p8G
e8szpn1CbueFfzxlm0diIoyZE1HsZPh6iNe6qQlili2Cf+V0w7ggxcTM3leFCBfl
4/oNInN5vxgpr66no8Y+Fzk6jhQGLdoKgY2ljLT1O5bV5hIyj0DnjAkR7d2KWMmG
Ud2muBNJfjDKMCxZ40neJG3ROrMvzuuVOx7fGVt8G6GcA9bQ5ZSnxtI9QIUQ0uiu
DZifWuifni/0Yuz56esBWqnT8QIL+aAW4WJS2ioGiOdoiCDzs/U=
=/82U
-----END PGP SIGNATURE-----

--votk3apotqepkpt5--
