Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C908F3ED5FF
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 15:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbhHPNQS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 09:16:18 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37088 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238767AbhHPNOC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 09:14:02 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id EB7CC1F42FBC
Received: by earth.universe (Postfix, from userid 1000)
        id 232813C0C9B; Mon, 16 Aug 2021 15:13:27 +0200 (CEST)
Date:   Mon, 16 Aug 2021 15:13:27 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] power: reset: Add TPS65086 restart driver
Message-ID: <20210816131327.4s3vaafsaohexgmw@earth.universe>
References: <20210727092554.1059305-1-kernel@esmil.dk>
 <20210727092554.1059305-4-kernel@esmil.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jd6i5fckg7rdsq4x"
Content-Disposition: inline
In-Reply-To: <20210727092554.1059305-4-kernel@esmil.dk>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--jd6i5fckg7rdsq4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 27, 2021 at 11:25:53AM +0200, Emil Renner Berthing wrote:
> The only way to reset the BeagleV Starlight v0.9 board[1] properly is to
> tell the PMIC to reset itself which will then assert the external reset
> lines of the SoC, USB hub and ethernet phy.
>=20
> This adds a driver to register a reset handler to do just that.
>=20
> [1] https://github.com/beagleboard/beaglev-starlight
>=20
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/Kconfig            |  6 ++
>  drivers/power/reset/Makefile           |  1 +
>  drivers/power/reset/tps65086-restart.c | 98 ++++++++++++++++++++++++++
>  3 files changed, 105 insertions(+)
>  create mode 100644 drivers/power/reset/tps65086-restart.c
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 4d1192062508..4b563db3ab3e 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -204,6 +204,12 @@ config POWER_RESET_ST
>  	help
>  	  Reset support for STMicroelectronics boards.
> =20
> +config POWER_RESET_TPS65086
> +	bool "TPS65086 restart driver"
> +	depends on MFD_TPS65086
> +	help
> +	  This driver adds support for resetting the TPS65086 PMIC on restart.
> +
>  config POWER_RESET_VERSATILE
>  	bool "ARM Versatile family reboot driver"
>  	depends on ARM
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index cf3f4d02d8a5..f606a2f60539 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_POWER_RESET_QNAP) +=3D qnap-poweroff.o
>  obj-$(CONFIG_POWER_RESET_REGULATOR) +=3D regulator-poweroff.o
>  obj-$(CONFIG_POWER_RESET_RESTART) +=3D restart-poweroff.o
>  obj-$(CONFIG_POWER_RESET_ST) +=3D st-poweroff.o
> +obj-$(CONFIG_POWER_RESET_TPS65086) +=3D tps65086-restart.o
>  obj-$(CONFIG_POWER_RESET_VERSATILE) +=3D arm-versatile-reboot.o
>  obj-$(CONFIG_POWER_RESET_VEXPRESS) +=3D vexpress-poweroff.o
>  obj-$(CONFIG_POWER_RESET_XGENE) +=3D xgene-reboot.o
> diff --git a/drivers/power/reset/tps65086-restart.c b/drivers/power/reset=
/tps65086-restart.c
> new file mode 100644
> index 000000000000..78b89f745a3d
> --- /dev/null
> +++ b/drivers/power/reset/tps65086-restart.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 Emil Renner Berthing
> + */
> +
> +#include <linux/mfd/tps65086.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +
> +struct tps65086_restart {
> +	struct notifier_block handler;
> +	struct device *dev;
> +};
> +
> +static int tps65086_restart_notify(struct notifier_block *this,
> +				   unsigned long mode, void *cmd)
> +{
> +	struct tps65086_restart *tps65086_restart =3D
> +		container_of(this, struct tps65086_restart, handler);
> +	struct tps65086 *tps65086 =3D dev_get_drvdata(tps65086_restart->dev->pa=
rent);
> +	int ret;
> +
> +	ret =3D regmap_write(tps65086->regmap, TPS65086_FORCESHUTDN, 1);
> +	if (ret) {
> +		dev_err(tps65086_restart->dev, "%s: error writing to tps65086 pmic: %d=
\n",
> +			__func__, ret);
> +		return NOTIFY_DONE;
> +	}
> +
> +	/* give it a little time */
> +	mdelay(200);
> +
> +	WARN_ON(1);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int tps65086_restart_probe(struct platform_device *pdev)
> +{
> +	struct tps65086_restart *tps65086_restart;
> +	int ret;
> +
> +	tps65086_restart =3D devm_kzalloc(&pdev->dev, sizeof(*tps65086_restart)=
, GFP_KERNEL);
> +	if (!tps65086_restart)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, tps65086_restart);
> +
> +	tps65086_restart->handler.notifier_call =3D tps65086_restart_notify;
> +	tps65086_restart->handler.priority =3D 192;
> +	tps65086_restart->dev =3D &pdev->dev;
> +
> +	ret =3D register_restart_handler(&tps65086_restart->handler);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s: cannot register restart handler: %d\n",
> +			__func__, ret);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tps65086_restart_remove(struct platform_device *pdev)
> +{
> +	struct tps65086_restart *tps65086_restart =3D platform_get_drvdata(pdev=
);
> +	int ret;
> +
> +	ret =3D unregister_restart_handler(&tps65086_restart->handler);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s: cannot unregister restart handler: %d\n",
> +			__func__, ret);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id tps65086_restart_id_table[] =3D {
> +	{ "tps65086-reset", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, tps65086_restart_id_table);
> +
> +static struct platform_driver tps65086_restart_driver =3D {
> +	.driver =3D {
> +		.name =3D "tps65086-restart",
> +	},
> +	.probe =3D tps65086_restart_probe,
> +	.remove =3D tps65086_restart_remove,
> +	.id_table =3D tps65086_restart_id_table,
> +};
> +module_platform_driver(tps65086_restart_driver);
> +
> +MODULE_AUTHOR("Emil Renner Berthing <kernel@esmil.dk>");
> +MODULE_DESCRIPTION("TPS65086 restart driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.32.0
>=20

--jd6i5fckg7rdsq4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEaZHAACgkQ2O7X88g7
+ppGlA//eW4VfoKcZwpoirYQ6wgy8cgXV0eshkTAntG6g7O2rJIp9WjvS9Gbm6+x
sUIOPI1RltahzlzYC/MzrS3kN9vP0lYBSpX+xeiE4PrX40c7iQCXBxfBimVhGwfF
RC7znvdr/0P5FGv4XtsOaK4dM00kVHSwlDMYqnmxxkMorO/5w9nVHMf4bGAwM8ok
q4KhDaiLSFYDgKYq43cnfPbptZ8SciP1M9/NwI60TMYkwzTWOHCJ7X0i6CYyeLxY
RTF0W3DSiGMamcHQ6VGsi6OSuAaN3v5xLLP3BSwb1EvwkI2S5r5whxzrNBJ4JvAN
KqSgfCKTbi6YxZ39yETNBlbPhSHBpOcWQt6e8AogIl8rlXxfar1c6Hvd69hOkC/W
KNHmXc/fHpysKtiw9/U224r+fASBSQBvsYUh7BoV4f/V/Sajh8vC78ydI/ezWHsm
1l1XK0sSV8cg8+WzUYWdPYcKfKbjq7gyUyinbXqk6IVt1kS+IkpQBhI2JMFVIDIG
DZdky7S5TCbccRHw557yjxHc5Ii9G6FZnfdF+5TMdMSZyk2AjxLp4jIE3wligHcI
CBJ42bNst4hiT6ovxk1k5DNaZhHSz7llNbHgo9fzldyiHhV+eS47W0g4AMFDu9a4
hlhRaSfEA1KNae2Zx3ACFGOxpseAIItr3qAOyAJrrniFRsefH+c=
=1lE9
-----END PGP SIGNATURE-----

--jd6i5fckg7rdsq4x--
