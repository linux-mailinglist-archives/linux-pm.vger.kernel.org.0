Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D427DDD797
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2019 11:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfJSJHx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Oct 2019 05:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbfJSJHx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 19 Oct 2019 05:07:53 -0400
Received: from earth.universe (cust-west-pareq2-46-193-15-226.wb.wifirst.net [46.193.15.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61CA4222BD;
        Sat, 19 Oct 2019 09:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571476071;
        bh=2NV1TbgKu0bniyswdY2XigFoPiodZ4JCFnDTC2Fo65s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JzDjJoNhHYTL8BCTBueDInYQDm60wgqitp03SmHlqyBtzefokIe2is+Cjdhvr/Lcf
         XIt3oI7ab4mwzPFhPlNZJfVQP27C3h6P4Lg7oqM6/tdD9nbtghRYAJPI0oYJycV16y
         obMaQ9q3yGLEpXXXCHP8BV4KLP2eLpPtLkbeXm54=
Received: by earth.universe (Postfix, from userid 1000)
        id 50EAF3C09B1; Sat, 19 Oct 2019 11:07:49 +0200 (CEST)
Date:   Sat, 19 Oct 2019 11:07:49 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 39/46] power: tosa: simplify probe function
Message-ID: <20191019090749.ps27yjfebzscw2pk@earth.universe>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-39-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cpv762fyyxe52a6d"
Content-Disposition: inline
In-Reply-To: <20191018154201.1276638-39-arnd@arndb.de>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--cpv762fyyxe52a6d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Fri, Oct 18, 2019 at 05:41:54PM +0200, Arnd Bergmann wrote:
> We have three power supplies that need similar initialization.
> As a preparation for the gpio lookup table conversion, split
> out the initialization into a separate function.
>=20
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Assuming, that the whole series goes through ARM:

Reviewed-by: Sebastian Reichel <sre@kernel.org>
Acked-by: Sebastian Reichel <sre@kernel.org>

If the series doesn't make it into 5.5, I can also apply
this cleanup patch.

-- Sebastian

>  drivers/power/supply/tosa_battery.c | 50 ++++++++++++++---------------
>  1 file changed, 24 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/power/supply/tosa_battery.c b/drivers/power/supply/t=
osa_battery.c
> index 32cc31cd4761..b26b0eca33e1 100644
> --- a/drivers/power/supply/tosa_battery.c
> +++ b/drivers/power/supply/tosa_battery.c
> @@ -343,12 +343,24 @@ static int tosa_bat_resume(struct platform_device *=
dev)
>  #define tosa_bat_resume NULL
>  #endif
> =20
> +static int tosa_power_supply_register(struct device *dev,
> +			struct tosa_bat *bat,
> +			const struct power_supply_desc *desc)
> +{
> +	struct power_supply_config cfg =3D {
> +		.drv_data =3D bat,
> +	};
> +
> +	mutex_init(&bat->work_lock);
> +	bat->psy =3D power_supply_register(dev, desc, &cfg);
> +
> +	return PTR_ERR_OR_ZERO(bat->psy);
> +}
> +
> +
>  static int tosa_bat_probe(struct platform_device *dev)
>  {
>  	int ret;
> -	struct power_supply_config main_psy_cfg =3D {},
> -				   jacket_psy_cfg =3D {},
> -				   bu_psy_cfg =3D {};
> =20
>  	if (!machine_is_tosa())
>  		return -ENODEV;
> @@ -357,36 +369,22 @@ static int tosa_bat_probe(struct platform_device *d=
ev)
>  	if (ret)
>  		return ret;
> =20
> -	mutex_init(&tosa_bat_main.work_lock);
> -	mutex_init(&tosa_bat_jacket.work_lock);
> -
>  	INIT_WORK(&bat_work, tosa_bat_work);
> =20
> -	main_psy_cfg.drv_data =3D &tosa_bat_main;
> -	tosa_bat_main.psy =3D power_supply_register(&dev->dev,
> -						  &tosa_bat_main_desc,
> -						  &main_psy_cfg);
> -	if (IS_ERR(tosa_bat_main.psy)) {
> -		ret =3D PTR_ERR(tosa_bat_main.psy);
> +	ret =3D tosa_power_supply_register(&dev->dev, &tosa_bat_main,
> +					 &tosa_bat_main_desc);
> +	if (ret)
>  		goto err_psy_reg_main;
> -	}
> =20
> -	jacket_psy_cfg.drv_data =3D &tosa_bat_jacket;
> -	tosa_bat_jacket.psy =3D power_supply_register(&dev->dev,
> -						    &tosa_bat_jacket_desc,
> -						    &jacket_psy_cfg);
> -	if (IS_ERR(tosa_bat_jacket.psy)) {
> -		ret =3D PTR_ERR(tosa_bat_jacket.psy);
> +	ret =3D tosa_power_supply_register(&dev->dev, &tosa_bat_jacket,
> +					 &tosa_bat_jacket_desc);
> +	if (ret)
>  		goto err_psy_reg_jacket;
> -	}
> =20
> -	bu_psy_cfg.drv_data =3D &tosa_bat_bu;
> -	tosa_bat_bu.psy =3D power_supply_register(&dev->dev, &tosa_bat_bu_desc,
> -						&bu_psy_cfg);
> -	if (IS_ERR(tosa_bat_bu.psy)) {
> -		ret =3D PTR_ERR(tosa_bat_bu.psy);
> +	ret =3D tosa_power_supply_register(&dev->dev, &tosa_bat_bu,
> +					 &tosa_bat_bu_desc);
> +	if (ret)
>  		goto err_psy_reg_bu;
> -	}
> =20
>  	ret =3D request_irq(gpio_to_irq(TOSA_GPIO_BAT0_CRG),
>  				tosa_bat_gpio_isr,
> --=20
> 2.20.0
>=20

--cpv762fyyxe52a6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2q0l4ACgkQ2O7X88g7
+pqrAA//T4fPon8Kb85iC60YZSLoMlrHDrQophLfczRWBFp8KM4eU/bZV8g4tqnW
lvYGN7gWFAScpNVrFVEmpDFGNK/9WlfLAnnAYI7Q/hS4HZ38IdJqyETB6h32Q4uX
UIL3ZREdyKB8NRSeWYk0GlEAaGv+/dNfcOdRyrAM2k6CNPjMQVOBLE0NcqXc3fSi
qtIJO3LkSB1sMSp2RD1GGAkmbofLKH/u5ej/B4osh5J+B5dtGBME0kvGYux5hhQk
Tu31XCKayix0IejLiLa/pBc4BDrrOD1EXe6PqYvXHyLfpFDEOdnCwiqElXnf0UN2
aA39iq/hx2p3tmDSRaAFri6XyanqGafaKofq6U41CrG5CanUKwrtm4p+l0ziFg8a
iBhs6/W8gR4rBBJg85pxGRPEJ2KTS/BIOvJZuIlZpUA8LKIUcsxwI8fA9iJJ1QPF
8+GSMW17eOTd36EJDB5C7lGHNT0N4FS4ARErNUNfDwZne9mOVNTFErHmyVrXVNPy
IX/pF7r34/gnTe3hL07W+4WQg52URr1wrHyds0p6fEv9lnrykP4k7hetFqp5CgBU
8vEG2Bj7PWkAs9VkZ460ZnEoB3DJJ3xxvheeeoc9ZTnwHLcIQg2f+51WNJ2ilS1O
QQcJiIcM2GFwTAwpmohtqYoI3oYmOEBpxKxU7PCM+35QFEyCVd4=
=6w5s
-----END PGP SIGNATURE-----

--cpv762fyyxe52a6d--
