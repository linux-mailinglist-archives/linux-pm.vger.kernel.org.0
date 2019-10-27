Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90FE9E6890
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2019 22:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbfJ0Vab (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Oct 2019 17:30:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731152AbfJ0Va2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 27 Oct 2019 17:30:28 -0400
Received: from earth.universe (unknown [46.218.74.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32A912070B;
        Sun, 27 Oct 2019 21:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211827;
        bh=8izSZAbx6fQBwUzEgqL17sTkPb8Aj2f809bsHzCJRec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A3CHmcenkVz7kS733vuH0673jNWz9Zx/lWgZ/CbFxj8unHvz7OjccwI2DkDKF85rM
         LMtg1WkSbZ/5lwFO6+laJwBckY9C34S0Tiaj75y783XYBu77cNxeyaJU+niPkYu1Hq
         GEI1BTRX36Cku/6aZyi2uzXhFMvIyxyPSeUCidzo=
Received: by earth.universe (Postfix, from userid 1000)
        id B31FF3C09B2; Sun, 27 Oct 2019 22:30:24 +0100 (CET)
Date:   Sun, 27 Oct 2019 22:30:24 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: ab8500_charger: Fix inconsistent IS_ERR
 and PTR_ERR
Message-ID: <20191027213024.x3lvdefs67wcb37j@earth.universe>
References: <20191021174937.GA17424@embeddedor>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ci4bos7uztzfqtgo"
Content-Disposition: inline
In-Reply-To: <20191021174937.GA17424@embeddedor>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ci4bos7uztzfqtgo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 21, 2019 at 12:49:37PM -0500, Gustavo A. R. Silva wrote:
> Fix inconsistent IS_ERR and PTR_ERR in ab8500_charger_probe().
>=20
> The proper pointer to be passed as argument is di->adc_main_charger_c
>=20
> This bug was detected with the help of Coccinelle.
>=20
> Fixes: 97ab78bac5d0 ("power: supply: ab8500_charger: Convert to IIO ADC")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ab8500_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply=
/ab8500_charger.c
> index ff2bb4411a22..8a0f9d769690 100644
> --- a/drivers/power/supply/ab8500_charger.c
> +++ b/drivers/power/supply/ab8500_charger.c
> @@ -3393,7 +3393,7 @@ static int ab8500_charger_probe(struct platform_dev=
ice *pdev)
>  		if (PTR_ERR(di->adc_main_charger_c) =3D=3D -ENODEV)
>  			return -EPROBE_DEFER;
>  		dev_err(&pdev->dev, "failed to get ADC main charger current\n");
> -		return PTR_ERR(di->adc_main_charger_v);
> +		return PTR_ERR(di->adc_main_charger_c);
>  	}
>  	di->adc_vbus_v =3D devm_iio_channel_get(&pdev->dev, "vbus_v");
>  	if (IS_ERR(di->adc_vbus_v)) {
> --=20
> 2.23.0
>=20

--ci4bos7uztzfqtgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl22DG0ACgkQ2O7X88g7
+pqcLQ/+JkR/ANfCqah3p0yYMbAWJ6Rs3SI2YzhwyIFJBWzOIEWwWgcsUzq+ahlf
2t8Um/Db2BC68q/GT+304JNaumpr5XfH/mWt4DrKcZgCGFePPwh5EscqAbUCHfu+
IqNQbtoHrnofZu4hThBZDqDvgZL+LGtikMRwBL2asytquPBveDJ/URKNdec+ue23
k7GzGGrvXp/IakLcWcFEfb66ibqgue8k4RL7YzKvySE74RQX/6ePQNVwGP4vGCSP
Zin9CH+uFAgg7/Dg6dBpxjE6L2DWFv+ftrg0pQO9rn6bLdWWjZvOXjo/RNk+GTpF
YMSfI1unLWHUf8/S/aGZjox/bH6KsqkY/W/TJ10C3OF5w19xj11hgWTQ1Y5oNB5c
VRJCEcWwrBfT42IjQKLvzjqP4GAduwqqYc5dyyXp5lKVU7qKNl0G51EPomkyPw4z
zNuS7KscPQeZQaZ6XB+70jQ2yUGvYN5IR4/H6ATgcG4zPUAQ286YobarRldJAeO2
y1RkZF52MtIvLozfMR+hd3ppNXO/nb5v4xsAvJu0QhuAiMfCzwz6v8/dU3KMF5dW
6zUxuX95sX3rW7zj0G35+O1r+olXHDqTJQmR1l+LLIOIA5F043DXTogsX9T8DzR9
qpLj0bikHEnmnZKjl2mV7E44zrAvE6jDaPfTaiP1au8BiiGLuqo=
=1lwG
-----END PGP SIGNATURE-----

--ci4bos7uztzfqtgo--
