Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3194B1CBBB0
	for <lists+linux-pm@lfdr.de>; Sat,  9 May 2020 02:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgEIAOe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 20:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727959AbgEIAOe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 20:14:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1B5C061A0C;
        Fri,  8 May 2020 17:14:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 38D8C2A2ECF
Received: by earth.universe (Postfix, from userid 1000)
        id B1ECA3C08C6; Sat,  9 May 2020 02:14:29 +0200 (CEST)
Date:   Sat, 9 May 2020 02:14:29 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     milo.kim@ti.com, anton.vorontsov@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] power: supply: lp8788: Fix an error handling path in
 'lp8788_charger_probe()'
Message-ID: <20200509001429.65lk56xov22fxa47@earth.universe>
References: <20200508071150.204974-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="elsq2nfey66uahg5"
Content-Disposition: inline
In-Reply-To: <20200508071150.204974-1-christophe.jaillet@wanadoo.fr>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--elsq2nfey66uahg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please change the driver to call devm_iio_channel_get() instead of
iio_channel_get() and drop the lp8788_release_adc_channel() function.

-- Sebastian

On Fri, May 08, 2020 at 09:11:50AM +0200, Christophe JAILLET wrote:
> In case of error, resources allocated in 'lp8788_setup_adc_channel()' must
> be released.
>=20
> Add a call to 'lp8788_release_adc_channel()' as already done in the remove
> function.
>=20
> Fixes: 98a276649358 ("power_supply: Add new lp8788 charger driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/power/supply/lp8788-charger.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply=
/lp8788-charger.c
> index 84a206f42a8e..641815eb24bc 100644
> --- a/drivers/power/supply/lp8788-charger.c
> +++ b/drivers/power/supply/lp8788-charger.c
> @@ -719,13 +719,17 @@ static int lp8788_charger_probe(struct platform_dev=
ice *pdev)
> =20
>  	ret =3D lp8788_psy_register(pdev, pchg);
>  	if (ret)
> -		return ret;
> +		goto err_release_adc_channel;
> =20
>  	ret =3D lp8788_irq_register(pdev, pchg);
>  	if (ret)
>  		dev_warn(dev, "failed to register charger irq: %d\n", ret);
> =20
>  	return 0;
> +
> +err_release_adc_channel:
> +	lp8788_release_adc_channel(pchg);
> +	return ret;
>  }
> =20
>  static int lp8788_charger_remove(struct platform_device *pdev)
> --=20
> 2.25.1
>=20

--elsq2nfey66uahg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl619eAACgkQ2O7X88g7
+pqhUQ//XakrsUVE5Wq5klKII1Z1Xz6RLpu0yPGB2ZR+Rg/IWcHR5CBlT/WYmFUK
vgUi9bYkL00DvvG63gWySGvM6wINXEw9qU+j0qLYCg31jOB74Vz2TVdpS/ZP2son
jD3hP5eIw+IaaTU4Nt/ScL3Ywcu3boL8JrADRkuIrGHVqC4WO56LRHYc1EzXzXMD
A83Cnx+JTGesyK6uDrGdw7Ac8JoEcEZy4Db7u31S42wMpArfr8s3FYEV7G1pF5gV
/2IfoneLLdUVJYQgG0kRQC+zL1Zvrr8Rf/U6OVNahNAtr5GuV7wde3MQaFqOppHt
JcKalt30MoQndXUXsyFaY5GKHU9k7DlDm9Y3ZasKyvOqbdoRwhz0OwhqkbT/rgVR
AQGm/ii6ZElIfgmWr7E9PHyThjHN+yI7RdXxpMDybsgnAQAyxIuBRglavoDBikfA
dOnlfITqJtsFPlBhsaI5fd72EfjylVczOHwTelAsf7+KFL58wOA+M8FXoQ8Jx3L0
dRVoNRB5SjK4Fqdd5DFeAwfpuGm5+li5akN4w7Vd+tPrXbS87ljO2bFz6aoRU4k7
LARlmKJNqBQKXpI6J5tXMMw+YuZqy6D17kjK0cSPp4qEOFq577UW+wKLJ0dcuESS
MGO4z8sOg7zosW7QUQnj08T5Ppa9vsiXamiGaSULgQnlclsraM4=
=Pdz3
-----END PGP SIGNATURE-----

--elsq2nfey66uahg5--
