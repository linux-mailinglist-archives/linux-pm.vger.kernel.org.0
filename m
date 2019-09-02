Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02E7AA5C8F
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 21:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfIBTKb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 15:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbfIBTKa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Sep 2019 15:10:30 -0400
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC63221881;
        Mon,  2 Sep 2019 19:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567451429;
        bh=4/XZXUnDQN35VQNyKyAMvB9SGCaUBZuBOsr4awpIRyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VoNX4oVhfub9OgZMJeeUqHbGcfBHWWzj4oqE2+n4y4R4xXgD3ZhyDM5R8Kkzh+x33
         ZKBduWb8Gsjyxrzninx0+G8d5LmPaRwh76y0hmrMZHOH3J1oJkEbGG7tXgt7ZKxm12
         CXsvrGa8hGhc2MHYjGVDVJcGZM6GP3eFYbT9Klnw=
Received: by earth.universe (Postfix, from userid 1000)
        id 7A15D3C0B7F; Mon,  2 Sep 2019 21:10:26 +0200 (CEST)
Date:   Mon, 2 Sep 2019 21:10:26 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/14] power: supply: sc27xx: Introduce local variable
 'struct device *dev'
Message-ID: <20190902191026.nhjii3zkhseo3zb3@earth.universe>
References: <20190708123251.11759-1-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="expmpklprn5z54yo"
Content-Disposition: inline
In-Reply-To: <20190708123251.11759-1-huangfq.daxian@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--expmpklprn5z54yo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 08, 2019 at 08:32:51PM +0800, Fuqian Huang wrote:
> Introduce local variable 'struct device *dev' and use it instead of
> dereferencing it repeatly.
>=20
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/sc27xx_fuel_gauge.c | 47 ++++++++++++++++----------=
------
>  1 file changed, 24 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/sup=
ply/sc27xx_fuel_gauge.c
> index 24895cc3b41e..9c184d80088b 100644
> --- a/drivers/power/supply/sc27xx_fuel_gauge.c
> +++ b/drivers/power/supply/sc27xx_fuel_gauge.c
> @@ -957,81 +957,82 @@ static int sc27xx_fgu_hw_init(struct sc27xx_fgu_dat=
a *data)
> =20
>  static int sc27xx_fgu_probe(struct platform_device *pdev)
>  {
> -	struct device_node *np =3D pdev->dev.of_node;
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *np =3D dev->of_node;
>  	struct power_supply_config fgu_cfg =3D { };
>  	struct sc27xx_fgu_data *data;
>  	int ret, irq;
> =20
> -	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
> =20
> -	data->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> +	data->regmap =3D dev_get_regmap(dev->parent, NULL);
>  	if (!data->regmap) {
> -		dev_err(&pdev->dev, "failed to get regmap\n");
> +		dev_err(dev, "failed to get regmap\n");
>  		return -ENODEV;
>  	}
> =20
> -	ret =3D device_property_read_u32(&pdev->dev, "reg", &data->base);
> +	ret =3D device_property_read_u32(dev, "reg", &data->base);
>  	if (ret) {
> -		dev_err(&pdev->dev, "failed to get fgu address\n");
> +		dev_err(dev, "failed to get fgu address\n");
>  		return ret;
>  	}
> =20
> -	data->channel =3D devm_iio_channel_get(&pdev->dev, "bat-temp");
> +	data->channel =3D devm_iio_channel_get(dev, "bat-temp");
>  	if (IS_ERR(data->channel)) {
> -		dev_err(&pdev->dev, "failed to get IIO channel\n");
> +		dev_err(dev, "failed to get IIO channel\n");
>  		return PTR_ERR(data->channel);
>  	}
> =20
> -	data->charge_chan =3D devm_iio_channel_get(&pdev->dev, "charge-vol");
> +	data->charge_chan =3D devm_iio_channel_get(dev, "charge-vol");
>  	if (IS_ERR(data->charge_chan)) {
> -		dev_err(&pdev->dev, "failed to get charge IIO channel\n");
> +		dev_err(dev, "failed to get charge IIO channel\n");
>  		return PTR_ERR(data->charge_chan);
>  	}
> =20
> -	data->gpiod =3D devm_gpiod_get(&pdev->dev, "bat-detect", GPIOD_IN);
> +	data->gpiod =3D devm_gpiod_get(dev, "bat-detect", GPIOD_IN);
>  	if (IS_ERR(data->gpiod)) {
> -		dev_err(&pdev->dev, "failed to get battery detection GPIO\n");
> +		dev_err(dev, "failed to get battery detection GPIO\n");
>  		return PTR_ERR(data->gpiod);
>  	}
> =20
>  	ret =3D gpiod_get_value_cansleep(data->gpiod);
>  	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed to get gpio state\n");
> +		dev_err(dev, "failed to get gpio state\n");
>  		return ret;
>  	}
> =20
>  	data->bat_present =3D !!ret;
>  	mutex_init(&data->lock);
> -	data->dev =3D &pdev->dev;
> +	data->dev =3D dev;
>  	platform_set_drvdata(pdev, data);
> =20
>  	fgu_cfg.drv_data =3D data;
>  	fgu_cfg.of_node =3D np;
> -	data->battery =3D devm_power_supply_register(&pdev->dev, &sc27xx_fgu_de=
sc,
> +	data->battery =3D devm_power_supply_register(dev, &sc27xx_fgu_desc,
>  						   &fgu_cfg);
>  	if (IS_ERR(data->battery)) {
> -		dev_err(&pdev->dev, "failed to register power supply\n");
> +		dev_err(dev, "failed to register power supply\n");
>  		return PTR_ERR(data->battery);
>  	}
> =20
>  	ret =3D sc27xx_fgu_hw_init(data);
>  	if (ret) {
> -		dev_err(&pdev->dev, "failed to initialize fgu hardware\n");
> +		dev_err(dev, "failed to initialize fgu hardware\n");
>  		return ret;
>  	}
> =20
> -	ret =3D devm_add_action(&pdev->dev, sc27xx_fgu_disable, data);
> +	ret =3D devm_add_action(dev, sc27xx_fgu_disable, data);
>  	if (ret) {
>  		sc27xx_fgu_disable(data);
> -		dev_err(&pdev->dev, "failed to add fgu disable action\n");
> +		dev_err(dev, "failed to add fgu disable action\n");
>  		return ret;
>  	}
> =20
>  	irq =3D platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> -		dev_err(&pdev->dev, "no irq resource specified\n");
> +		dev_err(dev, "no irq resource specified\n");
>  		return irq;
>  	}
> =20
> @@ -1046,17 +1047,17 @@ static int sc27xx_fgu_probe(struct platform_devic=
e *pdev)
> =20
>  	irq =3D gpiod_to_irq(data->gpiod);
>  	if (irq < 0) {
> -		dev_err(&pdev->dev, "failed to translate GPIO to IRQ\n");
> +		dev_err(dev, "failed to translate GPIO to IRQ\n");
>  		return irq;
>  	}
> =20
> -	ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +	ret =3D devm_request_threaded_irq(dev, irq, NULL,
>  					sc27xx_fgu_bat_detection,
>  					IRQF_ONESHOT | IRQF_TRIGGER_RISING |
>  					IRQF_TRIGGER_FALLING,
>  					pdev->name, data);
>  	if (ret) {
> -		dev_err(&pdev->dev, "failed to request IRQ\n");
> +		dev_err(dev, "failed to request IRQ\n");
>  		return ret;
>  	}
> =20
> --=20
> 2.11.0
>=20

--expmpklprn5z54yo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1taSIACgkQ2O7X88g7
+prl3BAAp+r1IGJD6IcN8wq0fbAGfdD84f3D1qCqfaIFHTbWyULSrqCmH+FXmRkt
FSIdqBKeAnrY4yLi/FEUW8vjO27kCpGX+y9ri2UFcJcnGYoe+1PkbrMc+shvUQpF
xOloDzfyH8a+ZMm91pkthAfTnzZZsABsVewbJlD6qJeAcf30bGAuZuiwTr/iMnZs
MQkU/23H+Zz7ZZff+pkQbOA0UNzXeeBgOgErCVlr5pkxnlRee6PAEuQWiGszCZLV
oZeaBmj3Ivt88aUyRZ3CWWEqjsQr2yCPMXK+YqkIVsKNMuOerZ2hlky7JuSoDCnu
T1sYHkLnIqqRD5lsAqd1srA+YHcTCw9O12IeBd0utzNsD5+kLe4Ho74jjqL35YlK
7StuO8nZ8ugmQ8M8rAR3pzL96kno/N1c/lAZfnOKDXNtLZ9cQ3X7bHQnbTScINnp
FnsFwd7y638Z12rboh3bTZDso0gwvbX/LhFiWXdumtJH9dpWLUDpGD4vfeY68qQU
XfRlFrAOfpNqx6sO7ycXKHzMq2RwUZblrwe5qNlBxtd2ykhoNK9DZ7TzkrHHYl4K
07GzajQwf+jdF8qMWIVjatAbvl4L5Y4F3DYTajjbEWQcvMxJhZHpaRt9hCdXxYC7
BVuj5tVnfTZI1pd8cNJiFvauioSkNA1lXyWJS3C1/uSjv7ENpFY=
=d1kY
-----END PGP SIGNATURE-----

--expmpklprn5z54yo--
