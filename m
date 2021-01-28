Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30A53068B8
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 01:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhA1AhY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 19:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhA1AhE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 19:37:04 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DE2C06174A;
        Wed, 27 Jan 2021 16:36:22 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 31DB91F45627
Received: by earth.universe (Postfix, from userid 1000)
        id BF9E93C0C97; Thu, 28 Jan 2021 01:36:19 +0100 (CET)
Date:   Thu, 28 Jan 2021 01:36:19 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: axp20x_usb_power: Init work before
 enabling IRQs
Message-ID: <20210128003619.dmqqcwuwam74cwrq@earth.universe>
References: <20210124152421.39693-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kewqan4yuk532mfp"
Content-Disposition: inline
In-Reply-To: <20210124152421.39693-1-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--kewqan4yuk532mfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 24, 2021 at 09:24:21AM -0600, Samuel Holland wrote:
> The IRQ handler calls mod_delayed_work() on power->vbus_detect. However,
> that work item is not initialized until after the IRQs are enabled. If
> an IRQ is already pending when the driver is probed, the driver calls
> mod_delayed_work() on an uninitialized work item, which causes an oops.
>=20
> Fixes: bcfb7ae3f50b ("power: supply: axp20x_usb_power: Only poll while of=
fline")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/axp20x_usb_power.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supp=
ly/axp20x_usb_power.c
> index 20817a49110b..02aba3da271a 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -711,20 +711,21 @@ static int axp20x_usb_power_probe(struct platform_d=
evice *pdev)
>  			     struct_size(power, irqs, axp_data->num_irq_names),
>  			     GFP_KERNEL);
>  	if (!power)
>  		return -ENOMEM;
> =20
>  	platform_set_drvdata(pdev, power);
> =20
>  	power->axp20x_id =3D axp_data->axp20x_id;
>  	power->regmap =3D axp20x->regmap;
>  	power->num_irqs =3D axp_data->num_irq_names;
> +	INIT_DELAYED_WORK(&power->vbus_detect, axp20x_usb_power_poll_vbus);
> =20
>  	if (power->axp20x_id =3D=3D AXP202_ID) {
>  		/* Enable vbus valid checking */
>  		ret =3D regmap_update_bits(power->regmap, AXP20X_VBUS_MON,
>  					 AXP20X_VBUS_MON_VBUS_VALID,
>  					 AXP20X_VBUS_MON_VBUS_VALID);
>  		if (ret)
>  			return ret;
> =20
>  		if (IS_ENABLED(CONFIG_AXP20X_ADC))
> @@ -763,21 +764,20 @@ static int axp20x_usb_power_probe(struct platform_d=
evice *pdev)
>  		ret =3D devm_request_any_context_irq(&pdev->dev, power->irqs[i],
>  						   axp20x_usb_power_irq, 0,
>  						   DRVNAME, power);
>  		if (ret < 0) {
>  			dev_err(&pdev->dev, "Error requesting %s IRQ: %d\n",
>  				axp_data->irq_names[i], ret);
>  			return ret;
>  		}
>  	}
> =20
> -	INIT_DELAYED_WORK(&power->vbus_detect, axp20x_usb_power_poll_vbus);
>  	if (axp20x_usb_vbus_needs_polling(power))
>  		queue_delayed_work(system_power_efficient_wq, &power->vbus_detect, 0);
> =20
>  	return 0;
>  }
> =20
>  static int axp20x_usb_power_remove(struct platform_device *pdev)
>  {
>  	struct axp20x_usb_power *power =3D platform_get_drvdata(pdev);
> =20
> --=20
> 2.26.2
>=20

--kewqan4yuk532mfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmASBwMACgkQ2O7X88g7
+ppurQ/9FGnYydGYK7tPHRgpFePw1tem8HB7LHg/3HBIc3dThEZ1BHjt5di1ifc+
5I1mvUS/xOlLktsYyCk1nMpqUChfc4FE4zAEVz+uNgB/2NDGzJIbl6JLnG3W01Rw
XKnbMve1hC/6B3/zjC9YaUALWGRzz+mJPYH6Wt11UPO8EdF3I+deghg+1N+mdzXi
3j8dP1tXg+VL0xshzkogIp/Zm9ejK9hiq0LBOu0UMxhk9G0ojV4tmtsb7DXpJJQY
P9u6suWSV4B4adnfk7qmtJjsZvQuRtOGtn3zBgVOvgm2dI7qDGNhhERdWMFD5YNT
fwTz7x55l/+Qvh+Jpl65UUtM4h+k8c2cBm70FUz5szOkeIIaX1fSqhfedbOh0q26
uwa15hxWUNmbQy21Geo4SG+rJSEeJU2Iw4IZ1dMaWTe/jOyrYFazhl+p28hx4Icw
dujT9hn/2gUz2f92mCgUCACpLOcQDR+qZ1Ui1zFmUtPEFNMYJ3tN/Ivnb3I2VaDK
og9zAJnYCQjBJLh23JDK0uzyLa3ZbujWQxwSuZOeortqKn+ZOdsCsj3csgzLKlVL
7iL785NLLS18nNCnlqcCQdj4mDqR4JF2rYYCCjGsB54zi+9hQLanNEh39tnVXd+6
Qsvx7RiPAKWRB6QWJNAUaCcjqzGIVfVTCA57JETfunWLioBB7Sg=
=HMYI
-----END PGP SIGNATURE-----

--kewqan4yuk532mfp--
