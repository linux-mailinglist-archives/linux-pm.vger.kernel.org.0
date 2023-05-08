Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAF36FB546
	for <lists+linux-pm@lfdr.de>; Mon,  8 May 2023 18:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjEHQhr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 May 2023 12:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbjEHQhj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2023 12:37:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21D66A6A
        for <linux-pm@vger.kernel.org>; Mon,  8 May 2023 09:37:35 -0700 (PDT)
Received: from mercury (195-23-45-170.net.novis.pt [195.23.45.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 86C1766056D1;
        Mon,  8 May 2023 17:37:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683563852;
        bh=69ZFLPIPz3ilm4sdSi0lA9kjJ1B9RUGXgIB+sY1Qy1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=It/h3UUOxDPOUZns0rMVTxZyeovX+Q0oOfAQLK4J853ZtPPL5sz96BC7rkzEJLle1
         D3o5MRD3t60Cz0uBCq4dz6v2UQhwOkhwbO8GpwAP4PdpPebcTCItRV54nDGtOUNUsX
         /I8Pyk7RWGPEdHqFOzEZnzz+rG7GS9/X0bz4XchKJ3ysJ1rHWh+5NiphVz4p7HIo3t
         cWgQAcS/PIH1PVGO4oczIjNn8ZtRRVmFlkZ09qOgv+/4123nJT+L+gZ3FJa0hzABuH
         dE4ry41wZf+WZJqz2VvNHO8HygNRvYHCupYG59TuqD95LNQQZU8tKo6KQBdkkUbzeX
         Mre+ivUtYRtVw==
Received: by mercury (Postfix, from userid 1000)
        id 293991067022; Mon,  8 May 2023 14:41:45 +0200 (CEST)
Date:   Mon, 8 May 2023 14:41:45 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] power: reset: gpio-restart: Convert to platform remove
 callback returning void
Message-ID: <20230508124145.pzu6h36wz3hcnco2@mercury.elektranox.org>
References: <20230414171235.3670639-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ek7ujwf4mujux4w3"
Content-Disposition: inline
In-Reply-To: <20230414171235.3670639-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ek7ujwf4mujux4w3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 14, 2023 at 07:12:35PM +0200, Uwe Kleine-K=F6nig wrote:
> Returning an error code from a remove callback makes the driver core
> emit a generic (and so little helpful) error message and after that the
> error code is ignored and the device unbound.
>=20
> As gpio_restart_remove() already emits an error message, suppressing the
> generic error is no loss.
>=20
> Then convert to .remove_new() which is equivalent to returning 0
> unconditionally in .remove(). See commit 5c5a7680e67b ("platform:
> Provide a remove callback that returns no value") for its rational.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/gpio-restart.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/power/reset/gpio-restart.c b/drivers/power/reset/gpi=
o-restart.c
> index 5466eeea261c..28aa152c4869 100644
> --- a/drivers/power/reset/gpio-restart.c
> +++ b/drivers/power/reset/gpio-restart.c
> @@ -105,7 +105,7 @@ static int gpio_restart_probe(struct platform_device =
*pdev)
>  	return 0;
>  }
> =20
> -static int gpio_restart_remove(struct platform_device *pdev)
> +static void gpio_restart_remove(struct platform_device *pdev)
>  {
>  	struct gpio_restart *gpio_restart =3D platform_get_drvdata(pdev);
>  	int ret;
> @@ -115,10 +115,7 @@ static int gpio_restart_remove(struct platform_devic=
e *pdev)
>  		dev_err(&pdev->dev,
>  				"%s: cannot unregister restart handler, %d\n",
>  				__func__, ret);
> -		return -ENODEV;
>  	}
> -
> -	return 0;
>  }
> =20
>  static const struct of_device_id of_gpio_restart_match[] =3D {
> @@ -128,7 +125,7 @@ static const struct of_device_id of_gpio_restart_matc=
h[] =3D {
> =20
>  static struct platform_driver gpio_restart_driver =3D {
>  	.probe =3D gpio_restart_probe,
> -	.remove =3D gpio_restart_remove,
> +	.remove_new =3D gpio_restart_remove,
>  	.driver =3D {
>  		.name =3D "restart-gpio",
>  		.of_match_table =3D of_gpio_restart_match,
>=20
> base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
> --=20
> 2.39.2
>=20

--ek7ujwf4mujux4w3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRY7ggACgkQ2O7X88g7
+ppeZBAAm8l4x1o7j3RDtCnhsr7A6mSH/bqfg+3H/CXJOGMLB2V9uSONZFFzqlwR
zitLM+9IVYVVFzKH10oT6Dd9godStVhdoHqjijWTUwQMB3AxpW9+mN7qcsh/ccB8
YHQDS1PvYQO63sEPyGgMZJEIP0fbX9zt6G5mWUXdAmUqC1yDV3VHnWh1sfuFvPas
JnVjZHP2GW6jUWMIHZHuBEg5E+I4CgsmxJCT6jKMmfRjZaEyDobIreXToTZxtFk+
dJuEXRKtbwm6R4oaISKARMvuMJhUlCtflYPdF27VzhMbecoi7ofyYuzk+wFnlIjh
P9SFaSNZLFSgeXqwFStYZQhVxX0XlgIwY0odlzhtIhmLmnZ42kzxR2SOeEXyArsM
umIIHIyQVgb1Cek/BlGXVLsqdT64kO0oF89HR4EDewoq/e1JHE6+B0RvJUTBc8iQ
sm56tIAryhrDLT12mwKUkfF+1eLYep4Zmb/t7Zhb9e0Cw0rbi0SoW/hxowxVFcN9
/HBe3TuxVZnyDhYvq6lzsi3Z1XH3oisB9r4uNNDk+jexLR58mgdlJhyid1OhNs85
iNzEeptQuJwAlFgiqycRu5IuBl3jJgii3rPRWV7g0wCJVSNUr8WKJrBCiLGE1zP3
FGQx8vCptbnjXoE2NHbYxHhH2gYZhF68DwYPJJGyaCNz/pfqoNw=
=0qUv
-----END PGP SIGNATURE-----

--ek7ujwf4mujux4w3--
