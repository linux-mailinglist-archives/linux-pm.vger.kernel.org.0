Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C4C2D8AAA
	for <lists+linux-pm@lfdr.de>; Sun, 13 Dec 2020 00:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436890AbgLLXl7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Dec 2020 18:41:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:59102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgLLXl7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 12 Dec 2020 18:41:59 -0500
Date:   Sun, 13 Dec 2020 00:41:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607816478;
        bh=6QWq4Fbv5EWiMVzfXArjywVZkwvzqc/ihW7BC3cGPZw=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZKZHCT1fodBHM9AI1zj/DzR8ac82ETq/u1TSCumpJSmKZ+tIT1Z22LFhlIw7p14El
         iM9Z3+q3byFwqk9Kg+I1FZ1kKoi2FzstUjIKU/AHMUUI6yjyo08f8fWN53yLr3g/72
         JSYGdV8CG9tDsGXf7DbmLtLUCxIDdzaICnnLF6Xp4Avg9QohmDE15ErIiakReev2K1
         RYh6H3z4Gy4HLyV+6s9Jbno6qt4JetLF5BvkXjPKTBJvqYxEL0cnVSSBKpjujpiAcV
         r49J/s9KEEUqwoKGwUcxE61sKQ7UzcKKTvMapTV5Ut4jhMCqXB7aSy6ZpNOx/ji+xT
         2J+6X5B/pbiAA==
From:   Sebastian Reichel <sre@kernel.org>
To:     Michael Klein <michael@fossekall.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/3] power: reset: new driver regulator-poweroff
Message-ID: <20201212234116.cddx5yur7ox7itxv@earth.universe>
References: <20201211151445.115943-1-michael@fossekall.de>
 <20201211151445.115943-2-michael@fossekall.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bqkjnicvkmtr26ev"
Content-Disposition: inline
In-Reply-To: <20201211151445.115943-2-michael@fossekall.de>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--bqkjnicvkmtr26ev
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 11, 2020 at 04:14:43PM +0100, Michael Klein wrote:
> This driver registers a pm_power_off function to turn off the board
> by force-disabling a devicetree-defined regulator.
>=20
> Signed-off-by: Michael Klein <michael@fossekall.de>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/Kconfig              |  7 ++
>  drivers/power/reset/Makefile             |  1 +
>  drivers/power/reset/regulator-poweroff.c | 82 ++++++++++++++++++++++++
>  3 files changed, 90 insertions(+)
>  create mode 100644 drivers/power/reset/regulator-poweroff.c
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index d55b3727e00e..b22c4fdb2561 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -177,6 +177,13 @@ config POWER_RESET_QNAP
> =20
>  	  Say Y if you have a QNAP NAS.
> =20
> +config POWER_RESET_REGULATOR
> +	bool "Regulator subsystem power-off driver"
> +	depends on OF && REGULATOR
> +	help
> +	  This driver supports turning off your board by disabling a
> +	  power regulator defined in the devicetree.
> +
>  config POWER_RESET_RESTART
>  	bool "Restart power-off driver"
>  	help
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index c51eceba9ea3..9dc49d3a57ff 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_POWER_RESET_OCELOT_RESET) +=3D ocelot-rese=
t.o
>  obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) +=3D piix4-poweroff.o
>  obj-$(CONFIG_POWER_RESET_LTC2952) +=3D ltc2952-poweroff.o
>  obj-$(CONFIG_POWER_RESET_QNAP) +=3D qnap-poweroff.o
> +obj-$(CONFIG_POWER_RESET_REGULATOR) +=3D regulator-poweroff.o
>  obj-$(CONFIG_POWER_RESET_RESTART) +=3D restart-poweroff.o
>  obj-$(CONFIG_POWER_RESET_ST) +=3D st-poweroff.o
>  obj-$(CONFIG_POWER_RESET_VERSATILE) +=3D arm-versatile-reboot.o
> diff --git a/drivers/power/reset/regulator-poweroff.c b/drivers/power/res=
et/regulator-poweroff.c
> new file mode 100644
> index 000000000000..f697088e0ad1
> --- /dev/null
> +++ b/drivers/power/reset/regulator-poweroff.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Force-disables a regulator to power down a device
> + *
> + * Michael Klein <michael@fossekall.de>
> + *
> + * Copyright (C) 2020 Michael Klein
> + *
> + * Based on the gpio-poweroff driver.
> + */
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/regulator/consumer.h>
> +
> +#define TIMEOUT_MS 3000
> +
> +/*
> + * Hold configuration here, cannot be more than one instance of the driv=
er
> + * since pm_power_off itself is global.
> + */
> +static struct regulator *cpu_regulator;
> +
> +static void regulator_poweroff_do_poweroff(void)
> +{
> +	if (cpu_regulator && regulator_is_enabled(cpu_regulator))
> +		regulator_force_disable(cpu_regulator);
> +
> +	/* give it some time */
> +	mdelay(TIMEOUT_MS);
> +
> +	WARN_ON(1);
> +}
> +
> +static int regulator_poweroff_probe(struct platform_device *pdev)
> +{
> +	/* If a pm_power_off function has already been added, leave it alone */
> +	if (pm_power_off !=3D NULL) {
> +		dev_err(&pdev->dev,
> +			"%s: pm_power_off function already registered\n",
> +			__func__);
> +		return -EBUSY;
> +	}
> +
> +	cpu_regulator =3D devm_regulator_get(&pdev->dev, "cpu");
> +	if (IS_ERR(cpu_regulator))
> +		return PTR_ERR(cpu_regulator);
> +
> +	pm_power_off =3D &regulator_poweroff_do_poweroff;
> +	return 0;
> +}
> +
> +static int regulator_poweroff_remove(__maybe_unused struct platform_devi=
ce *pdev)
> +{
> +	if (pm_power_off =3D=3D &regulator_poweroff_do_poweroff)
> +		pm_power_off =3D NULL;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_regulator_poweroff_match[] =3D {
> +	{ .compatible =3D "regulator-poweroff", },
> +	{},
> +};
> +
> +static struct platform_driver regulator_poweroff_driver =3D {
> +	.probe =3D regulator_poweroff_probe,
> +	.remove =3D regulator_poweroff_remove,
> +	.driver =3D {
> +		.name =3D "poweroff-regulator",
> +		.of_match_table =3D of_regulator_poweroff_match,
> +	},
> +};
> +
> +module_platform_driver(regulator_poweroff_driver);
> +
> +MODULE_AUTHOR("Michael Klein <michael@fossekall.de>");
> +MODULE_DESCRIPTION("Regulator poweroff driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:poweroff-regulator");
> --=20
> 2.29.2
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--bqkjnicvkmtr26ev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/VVRwACgkQ2O7X88g7
+pobnQ/8DRqZP9pJQbIdOkTSWtKX6e/WJ+umvhdCGxjT2q3vfU9X0MwDtnBQzOk5
igA02V7pduBfKRWR/V9J/4OtHvvY2iCAKRyqvnT57FEA1M9nFz21DhUpDKWEzczj
mdR4DMM7g7OXdc0+FcbSCRqBEmatQM2N4xmLTTNmoQBWzMC04TdAPE0i12ZHQoIF
YD7od3zfenYjg2g1C8Od2vjbIXx6tstDxRZlpaRSE1WGBHZ0g8hUjsBCWwtrJ983
Fqs8RAj5BmkvNdJjaIzlGc+8MypzL9da9t7L+2Pnr/0W5LLEQn1nkwxzRMzGPqlf
Nlk0kFHYXHqGzdgK1fid3zgFzHLZL1fZA14/LRrsqCwDlEwICL9cR0Jmzp1FKiPg
o7VmHvrYiG/6rt0Gxz2Gg7Ka+S7hkWe9pjrVhkc6h62F2it0s+8eNXl+p+H7DooA
QDb166OvIhyoEzz7RkeQ6EKmXF7qEWFoqZfKJuEa53FkhYjKsGzXD3x5C6WIpp3O
ghCB3ZOT8BehiXG4eZ7OmZEzMdT8dBihoK2k2h3K7mvf25gvjYkJfQJ+ezJ9F5Om
hCp3A5s7/d9TWEU9KLoC0bol17cvR+APjCexV+fn0zCUR1T1PNLqvjnz5/eG+qr/
NU/F41U3f+XIjXmRtOudxi7MrufmVjC90WRhxzjQacrLCc5GEhE=
=l5NK
-----END PGP SIGNATURE-----

--bqkjnicvkmtr26ev--
