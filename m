Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0275332779
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 14:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhCINqp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 08:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhCINqo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 08:46:44 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950E6C06174A;
        Tue,  9 Mar 2021 05:46:41 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 436A41F45594
Received: by earth.universe (Postfix, from userid 1000)
        id 9F33A3C0C95; Tue,  9 Mar 2021 14:46:37 +0100 (CET)
Date:   Tue, 9 Mar 2021 14:46:37 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v2 6/8] power: supply: Clean-up few drivers by using
 managed work init
Message-ID: <20210309134637.j3ffbmt54f5eabfq@earth.universe>
References: <cover.1615187284.git.matti.vaittinen@fi.rohmeurope.com>
 <38263724e80591d53eb4a71c919bbed908121301.1615187284.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5n6jqd2ppqjylwbd"
Content-Disposition: inline
In-Reply-To: <38263724e80591d53eb4a71c919bbed908121301.1615187284.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--5n6jqd2ppqjylwbd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 08, 2021 at 10:42:43AM +0200, Matti Vaittinen wrote:
> Few drivers implement remove call-back only for ensuring a delayed
> work gets cancelled prior driver removal. Clean-up these by switching
> to use devm_delayed_work_autocancel() instead.
>=20
> This change is compile-tested only. All testing is appreciated.
>=20
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---

LGTM. This looks like it might result in merge conflicts when being
applied to another tree, so I need an immutable branch.

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/axp20x_usb_power.c      | 15 +++++----------
>  drivers/power/supply/bq24735-charger.c       | 18 ++++++------------
>  drivers/power/supply/ltc2941-battery-gauge.c | 20 +++++++-------------
>  drivers/power/supply/sbs-battery.c           | 16 +++++-----------
>  4 files changed, 23 insertions(+), 46 deletions(-)
>=20
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supp=
ly/axp20x_usb_power.c
> index 8933ae26c3d6..4259709e3491 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -8,6 +8,7 @@
> =20
>  #include <linux/bitops.h>
>  #include <linux/device.h>
> +#include <linux/devm-helpers.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> @@ -646,21 +647,16 @@ static int axp20x_usb_power_probe(struct platform_d=
evice *pdev)
>  		}
>  	}
> =20
> +	ret =3D devm_delayed_work_autocancel(&pdev->dev, &power->vbus_detect,
> +					   axp20x_usb_power_poll_vbus);
> +	if (ret)
> +		return ret;
>  	if (axp20x_usb_vbus_needs_polling(power))
>  		queue_delayed_work(system_power_efficient_wq, &power->vbus_detect, 0);
> =20
>  	return 0;
>  }
> =20
> -static int axp20x_usb_power_remove(struct platform_device *pdev)
> -{
> -	struct axp20x_usb_power *power =3D platform_get_drvdata(pdev);
> -
> -	cancel_delayed_work_sync(&power->vbus_detect);
> -
> -	return 0;
> -}
> -
>  static const struct of_device_id axp20x_usb_power_match[] =3D {
>  	{
>  		.compatible =3D "x-powers,axp202-usb-power-supply",
> @@ -680,7 +676,6 @@ MODULE_DEVICE_TABLE(of, axp20x_usb_power_match);
> =20
>  static struct platform_driver axp20x_usb_power_driver =3D {
>  	.probe =3D axp20x_usb_power_probe,
> -	.remove =3D axp20x_usb_power_remove,
>  	.driver =3D {
>  		.name		=3D DRVNAME,
>  		.of_match_table	=3D axp20x_usb_power_match,
> diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/suppl=
y/bq24735-charger.c
> index ab2f4bf8f603..b5d619db79f6 100644
> --- a/drivers/power/supply/bq24735-charger.c
> +++ b/drivers/power/supply/bq24735-charger.c
> @@ -17,6 +17,7 @@
>   * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
>   */
> =20
> +#include <linux/devm-helpers.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
> @@ -473,7 +474,11 @@ static int bq24735_charger_probe(struct i2c_client *=
client,
>  		if (!charger->poll_interval)
>  			return 0;
> =20
> -		INIT_DELAYED_WORK(&charger->poll, bq24735_poll);
> +		ret =3D devm_delayed_work_autocancel(&client->dev, &charger->poll,
> +						   bq24735_poll);
> +		if (ret)
> +			return ret;
> +
>  		schedule_delayed_work(&charger->poll,
>  				      msecs_to_jiffies(charger->poll_interval));
>  	}
> @@ -481,16 +486,6 @@ static int bq24735_charger_probe(struct i2c_client *=
client,
>  	return 0;
>  }
> =20
> -static int bq24735_charger_remove(struct i2c_client *client)
> -{
> -	struct bq24735 *charger =3D i2c_get_clientdata(client);
> -
> -	if (charger->poll_interval)
> -		cancel_delayed_work_sync(&charger->poll);
> -
> -	return 0;
> -}
> -
>  static const struct i2c_device_id bq24735_charger_id[] =3D {
>  	{ "bq24735-charger", 0 },
>  	{}
> @@ -509,7 +504,6 @@ static struct i2c_driver bq24735_charger_driver =3D {
>  		.of_match_table =3D bq24735_match_ids,
>  	},
>  	.probe =3D bq24735_charger_probe,
> -	.remove =3D bq24735_charger_remove,
>  	.id_table =3D bq24735_charger_id,
>  };
> =20
> diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power=
/supply/ltc2941-battery-gauge.c
> index 10cd617516ec..09f3e78af4e0 100644
> --- a/drivers/power/supply/ltc2941-battery-gauge.c
> +++ b/drivers/power/supply/ltc2941-battery-gauge.c
> @@ -8,6 +8,7 @@
>   * Author: Auryn Verwegen
>   * Author: Mike Looijmans
>   */
> +#include <linux/devm-helpers.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> @@ -445,15 +446,6 @@ static enum power_supply_property ltc294x_properties=
[] =3D {
>  	POWER_SUPPLY_PROP_CURRENT_NOW,
>  };
> =20
> -static int ltc294x_i2c_remove(struct i2c_client *client)
> -{
> -	struct ltc294x_info *info =3D i2c_get_clientdata(client);
> -
> -	cancel_delayed_work_sync(&info->work);
> -	power_supply_unregister(info->supply);
> -	return 0;
> -}
> -
>  static int ltc294x_i2c_probe(struct i2c_client *client,
>  	const struct i2c_device_id *id)
>  {
> @@ -547,7 +539,10 @@ static int ltc294x_i2c_probe(struct i2c_client *clie=
nt,
> =20
>  	psy_cfg.drv_data =3D info;
> =20
> -	INIT_DELAYED_WORK(&info->work, ltc294x_work);
> +	ret =3D devm_delayed_work_autocancel(&client->dev, &info->work,
> +					   ltc294x_work);
> +	if (ret)
> +		return ret;
> =20
>  	ret =3D ltc294x_reset(info, prescaler_exp);
>  	if (ret < 0) {
> @@ -555,8 +550,8 @@ static int ltc294x_i2c_probe(struct i2c_client *clien=
t,
>  		return ret;
>  	}
> =20
> -	info->supply =3D power_supply_register(&client->dev, &info->supply_desc,
> -					     &psy_cfg);
> +	info->supply =3D devm_power_supply_register(&client->dev,
> +						  &info->supply_desc, &psy_cfg);
>  	if (IS_ERR(info->supply)) {
>  		dev_err(&client->dev, "failed to register ltc2941\n");
>  		return PTR_ERR(info->supply);
> @@ -655,7 +650,6 @@ static struct i2c_driver ltc294x_driver =3D {
>  		.pm	=3D LTC294X_PM_OPS,
>  	},
>  	.probe		=3D ltc294x_i2c_probe,
> -	.remove		=3D ltc294x_i2c_remove,
>  	.shutdown	=3D ltc294x_i2c_shutdown,
>  	.id_table	=3D ltc294x_i2c_id,
>  };
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index b6a538ebb378..70ea404b2a36 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -7,6 +7,7 @@
> =20
>  #include <linux/bits.h>
>  #include <linux/delay.h>
> +#include <linux/devm-helpers.h>
>  #include <linux/err.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
> @@ -1165,7 +1166,10 @@ static int sbs_probe(struct i2c_client *client)
>  		}
>  	}
> =20
> -	INIT_DELAYED_WORK(&chip->work, sbs_delayed_work);
> +	rc =3D devm_delayed_work_autocancel(&client->dev, &chip->work,
> +					  sbs_delayed_work);
> +	if (rc)
> +		return rc;
> =20
>  	chip->power_supply =3D devm_power_supply_register(&client->dev, sbs_des=
c,
>  						   &psy_cfg);
> @@ -1185,15 +1189,6 @@ static int sbs_probe(struct i2c_client *client)
>  	return rc;
>  }
> =20
> -static int sbs_remove(struct i2c_client *client)
> -{
> -	struct sbs_info *chip =3D i2c_get_clientdata(client);
> -
> -	cancel_delayed_work_sync(&chip->work);
> -
> -	return 0;
> -}
> -
>  #if defined CONFIG_PM_SLEEP
> =20
>  static int sbs_suspend(struct device *dev)
> @@ -1248,7 +1243,6 @@ MODULE_DEVICE_TABLE(of, sbs_dt_ids);
> =20
>  static struct i2c_driver sbs_battery_driver =3D {
>  	.probe_new	=3D sbs_probe,
> -	.remove		=3D sbs_remove,
>  	.alert		=3D sbs_alert,
>  	.id_table	=3D sbs_id,
>  	.driver =3D {
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

--5n6jqd2ppqjylwbd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBHfDMACgkQ2O7X88g7
+prDaxAAjVdHn03XjNmzWKsofyO/ne8+PqkIDNRiaKq6zijCtgJ8HsU49PAZsxZw
jjXqUt2CLCMZf45uD+c+QmgBAvr2W77QeaOp4NYXmaUYFTS06qnQ+47xeeSBXqi9
SEju3X7eyK3Y7EXqYl+ROdJYEoXagvf1ydKQ2qWssk9x6XT1jQv9r/+2f4rCq9Sy
oiaUgEliBpNT7JXR2uEoCkZ74VoevKYk4Rfm4lmCKCQ4aKXqzJ5xLiUnPAqxAYIK
E8ZwZ0BLFAfkjTNEe5vv7fE21CTdlMWG1xEM50gA/H09rpwPnFufDnDn7ftVJ+d6
mpqbMR3CcdgCSMsSl/6gYUkV4b41GHkfkB22UpTqRM1iUnA6jg1BRFfkLhwOiCG0
QQquXovoWovj2IhD+QJRE0gm7xlh3hIoLQfRedY3xq9oSEUkShBmod3gAUPK3cqF
P90NMcs6xGTa4cALiwbOnte70o6OlTUH4XLuNqsNdIp7aNcaeg3fOaBWZoLF3/2y
t2K7jLVxvEvlmBqBJNVt3WNNlv2GXfESOKINID5nGRc0wH1zfnJ2TOsdcS5KOOa+
Y7WJ58J/tudbJJi+NiYwzo34jsD2LtKqGCKSIykwtj/93x3drKpCAV1mvDjeiIVn
w8yISJcAZiiZm+J4H8AmxzKKun52BU+yP2Pa5bXZy3pE1gEd4+Q=
=Wwp5
-----END PGP SIGNATURE-----

--5n6jqd2ppqjylwbd--
