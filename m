Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EAD3CFF0C
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jul 2021 18:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhGTPeC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Jul 2021 11:34:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231442AbhGTPcR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Jul 2021 11:32:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73F6F6023D;
        Tue, 20 Jul 2021 16:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626797573;
        bh=f+iYwtkG8kDYHg0PqehVvMaNYBZ5PptC+jaDP443IOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ftQkatKT+ppogoiX8WCKtzKR1gxiL3W02klCyhkyiDI5jthdKG1b+cuIM/Awk917U
         GEv9mhZi++c1eHssVrFQzMhlYY5rqnmrYnDq8d12zzx/TEBqUlQeH0D1ThrTwNlgFp
         N7Jkb2Oryn+AEVDJb5D0WZq44JnqhYZy3hIH8ycon4KufACWRRMgXNnGNVs3csEsQA
         PE2JqUSf+a9g1iE/Rq3zLvoBYSDPJnoQPy7vDkvTqLiqgWC7TezHpu3UQx2Ocm0l5K
         z3UIISv+EmHf7sqNURdqunohTMQMMSGXLkhe0xnZYDplLI5Xk4XicEhfVvvKqYg7fr
         JIL49om/sQiKg==
Received: by earth.universe (Postfix, from userid 1000)
        id 849313C0C98; Tue, 20 Jul 2021 18:12:51 +0200 (CEST)
Date:   Tue, 20 Jul 2021 18:12:51 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] power: reset: Add TPS65086 restart driver
Message-ID: <20210720161251.lgx4xmk5oixp746r@earth.universe>
References: <20210625224744.1020108-1-kernel@esmil.dk>
 <20210625224744.1020108-4-kernel@esmil.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5qvxeltww2u6kx6k"
Content-Disposition: inline
In-Reply-To: <20210625224744.1020108-4-kernel@esmil.dk>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--5qvxeltww2u6kx6k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 26, 2021 at 12:47:44AM +0200, Emil Renner Berthing wrote:
> The only way to reset the BeagleV Starlight v0.9 board[1] properly is to
> tell the PMIC to reset itself which will then assert the external reset
> lines of the SoC, USB hub and ethernet phy.
>=20
> This adds a driver to register a reset handler to do just that.
>=20
> [1] https://github.com/beagleboard/beaglev-starlight
>=20
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/mfd/tps65086.c                 |  1 +
>  drivers/power/reset/Kconfig            |  6 ++
>  drivers/power/reset/Makefile           |  1 +
>  drivers/power/reset/tps65086-restart.c | 99 ++++++++++++++++++++++++++
>  4 files changed, 107 insertions(+)
>  create mode 100644 drivers/power/reset/tps65086-restart.c
>=20
> diff --git a/drivers/mfd/tps65086.c b/drivers/mfd/tps65086.c
> index cc3478ee9a64..1bfba0758fcc 100644
> --- a/drivers/mfd/tps65086.c
> +++ b/drivers/mfd/tps65086.c
> @@ -24,6 +24,7 @@
>  static const struct mfd_cell tps65086_cells[] =3D {
>  	{ .name =3D "tps65086-regulator", },
>  	{ .name =3D "tps65086-gpio", },
> +	{ .name =3D "tps65086-restart", },
>  };
> =20
>  static const struct regmap_range tps65086_yes_ranges[] =3D {
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
> index 000000000000..ad9f2c5a84ac
> --- /dev/null
> +++ b/drivers/power/reset/tps65086-restart.c
> @@ -0,0 +1,99 @@
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
> +	struct tps65086 *tps;
> +	struct device *dev;
> +};
> +
> +static int tps65086_restart_notify(struct notifier_block *this,
> +				   unsigned long mode, void *cmd)
> +{
> +	struct tps65086_restart *tps65086_restart =3D
> +		container_of(this, struct tps65086_restart, handler);
> +	int ret;
> +
> +	ret =3D regmap_write(tps65086_restart->tps->regmap, TPS65086_FORCESHUTD=
N, 1);
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
> +	tps65086_restart->tps =3D dev_get_drvdata(pdev->dev.parent);
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
> +	{ "tps65086-restart", },
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

--5qvxeltww2u6kx6k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmD29f0ACgkQ2O7X88g7
+pqXxw/5AYZiH7qMOFWMkMJ9EyeTslcltp522xu/Fv04DacApGjDzv/YvjJDrisv
sG0lAXAl9rmxV3vtrQETIu/8dBL7qpcgvs5IVofG/bJnb5vVIdbd2B1MRhOZbJRH
Lqm/usG6pevT/n51wGy3T6r9TA/4pxHZXn0C8I66qJScwqukXwAoBpuKfuxVCalu
hsjrrEyzVNJzeTHnVzALgRLocGlV67gnnwYelehZQ3Ki3WDtX54LY8MTDcV2HiHW
H08vVbZAjBkIqYvtiJWSebe0OWmZ+me8aPNmoE407zxKwhXLtvNp7BZWpMS1taED
TzCHIsPlYi/8JrNPAvNoo7Q1WaVWEOEzjm/vCBZ5yP/SIYj96dxclxzVf4IlfN1C
2hMTAXoTPWRAdRQHXkgJee52E9S86uAe0DEAr5koPgmSWagr7Ism1RAo/4vcy7GD
qMpu0U17fpfcyWpqhIDvHqcMhQzWD6Vsm6n8RETNo+zXgrLqjOuGZwR1vNKb687r
Ga8rQzTbJKN63Ox3+rGtTUaRBAemvaUo7glMXq2aZsZrGljsrhfCTP9t0rA2akkB
euZCaSjMz/RgkbLOpHQZt8c4Se0BHrzW102aPJKfZ6NPKbrj7RNT5Cqhrlq94zRP
KcTwsS90O+EZvJNMiRcQzEnJt6+hylB7NoYSHeWSeGmywutmPSc=
=apaB
-----END PGP SIGNATURE-----

--5qvxeltww2u6kx6k--
