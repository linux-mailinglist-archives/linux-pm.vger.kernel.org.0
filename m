Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C95F1CC55B
	for <lists+linux-pm@lfdr.de>; Sun, 10 May 2020 01:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgEIXnm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 May 2020 19:43:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34160 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgEIXnm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 May 2020 19:43:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B494F2A01A7
Received: by earth.universe (Postfix, from userid 1000)
        id DCAE43C08C7; Sun, 10 May 2020 01:43:38 +0200 (CEST)
Date:   Sun, 10 May 2020 01:43:38 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     milo.kim@ti.com, anton.vorontsov@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH V2] power: supply: lp8788: Fix an error handling path in
 'lp8788_charger_probe()'
Message-ID: <20200509234338.htilukszgiktza62@earth.universe>
References: <20200509082323.223884-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fvloof6eixjzfmk4"
Content-Disposition: inline
In-Reply-To: <20200509082323.223884-1-christophe.jaillet@wanadoo.fr>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--fvloof6eixjzfmk4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, May 09, 2020 at 10:23:23AM +0200, Christophe JAILLET wrote:
> In the probe function, in case of error, resources allocated in
> 'lp8788_setup_adc_channel()' must be released.
>=20
> This can be achieved easily by using the devm_ variant of
> 'iio_channel_get()'.
> This has the extra benefit to simplify the remove function and to axe the
> 'lp8788_release_adc_channel()' function which is now useless.
>=20
> Fixes: 98a276649358 ("power_supply: Add new lp8788 charger driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> V2: use devm_iio_channel_get instead of iio_channel_get and simplify code
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/lp8788-charger.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply=
/lp8788-charger.c
> index 84a206f42a8e..e7931ffb7151 100644
> --- a/drivers/power/supply/lp8788-charger.c
> +++ b/drivers/power/supply/lp8788-charger.c
> @@ -572,27 +572,14 @@ static void lp8788_setup_adc_channel(struct device =
*dev,
>  		return;
> =20
>  	/* ADC channel for battery voltage */
> -	chan =3D iio_channel_get(dev, pdata->adc_vbatt);
> +	chan =3D devm_iio_channel_get(dev, pdata->adc_vbatt);
>  	pchg->chan[LP8788_VBATT] =3D IS_ERR(chan) ? NULL : chan;
> =20
>  	/* ADC channel for battery temperature */
> -	chan =3D iio_channel_get(dev, pdata->adc_batt_temp);
> +	chan =3D devm_iio_channel_get(dev, pdata->adc_batt_temp);
>  	pchg->chan[LP8788_BATT_TEMP] =3D IS_ERR(chan) ? NULL : chan;
>  }
> =20
> -static void lp8788_release_adc_channel(struct lp8788_charger *pchg)
> -{
> -	int i;
> -
> -	for (i =3D 0; i < LP8788_NUM_CHG_ADC; i++) {
> -		if (!pchg->chan[i])
> -			continue;
> -
> -		iio_channel_release(pchg->chan[i]);
> -		pchg->chan[i] =3D NULL;
> -	}
> -}
> -
>  static ssize_t lp8788_show_charger_status(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> @@ -735,7 +722,6 @@ static int lp8788_charger_remove(struct platform_devi=
ce *pdev)
>  	flush_work(&pchg->charger_work);
>  	lp8788_irq_unregister(pdev, pchg);
>  	lp8788_psy_unregister(pchg);
> -	lp8788_release_adc_channel(pchg);
> =20
>  	return 0;
>  }
> --=20
> 2.25.1
>=20

--fvloof6eixjzfmk4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl63QCoACgkQ2O7X88g7
+pqXkw//TQAiHoFVbfj4PDt6JINhpc+KHH09+OYBJASqORFGRahjpl9lRP2KwOWC
M5slAVpIewYZduNjMSiXLsl3E9THqT4aPlMCQsPbMbqf9opbo+v/N+99eqK6H7zX
muI5Ujy4mal8dQblR2ePlZiZkXj+rcY85JwW4BndWPDxY6H66GlYdFTuBdphLqIJ
o3dFznmKZBWVk7jLogVf0Cqa/lK1h4FAg/X9f+9gsX8WEZujUONFdYxccQxlGZXt
pBVVeTlg4a7PdXvvKDZwNLrhIs4tRI3ePc8cxcjkl2R9GUmk4r2LV2xswrkYbBpt
dhYnPSHSKwFupk2iDiqL6cZxGdjyI7xHy/06rQO+vo2FgI6xDSsEgYhRFV2WrgME
4T0FJOUw3wSEXpxndU/Q0339Hbq27n6m5ql3w5CNLOGU5phWFGGFJLxfYj2do8Gj
9KwXpGGZy0hr03y0G036B+kWWxbrhoPfOE0VPfIo7ZcSFqXQNGPw+fQELbI1DFvI
ElAndnEVL6hIa2iQyXHAqSkkPo/uq87/miBDo3DyHnmkshZAB3hLVmXEaMG+82Rq
vPbK+TCz2sqHDKS6CDEAOZ/pG9P0wL5WUHP8uSLBq3dLqkKY+1zsjlhPHqwH9q44
t9MY0/eLvpGTMWVwIO01U3Rpo4m6FdjN8JwahBASvoRzLEeUh5c=
=2IDJ
-----END PGP SIGNATURE-----

--fvloof6eixjzfmk4--
