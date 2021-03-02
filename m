Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8D932B340
	for <lists+linux-pm@lfdr.de>; Wed,  3 Mar 2021 04:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352504AbhCCDuZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Mar 2021 22:50:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:45972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348819AbhCBPqm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Mar 2021 10:46:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EEC461494;
        Tue,  2 Mar 2021 15:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614699848;
        bh=kHh3vq7lXBrXpC5+L7VOymgpayq/gSHEkCNJqpjL0WM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=khmnX+gBT2IjBaAK0PKFxGg5zqj9rnpIEZ3ThpL4vv7x7+b4l/vCl8k8bQPYTNBhB
         LRDmvyGaocgMN6j3rRqh0jYFqOyOB16rmktaulSoA2WchBsTM1Nqmji4BhA4wTa34F
         TEUdIEXZmp8V8b8OSTzEfQ/BjcBGKwtFE45B2JRbgwRiXGrmicS6hedVlY67q0lcVY
         3eA9C3yrPpxZrO9hUBODi6KaAdGuWPhB8x0Cvd4AglFep+hFJ9lXT7UBEQgA2Qhlvy
         cZS/78yFSgw8URBZpPNVL1I6PkjVZYgc6XySSFzilp102kGcD1IYn/jII+6d4sCHYS
         YpeOUlY9HGrRg==
Received: by earth.universe (Postfix, from userid 1000)
        id 6C8813C0C96; Tue,  2 Mar 2021 16:44:06 +0100 (CET)
Date:   Tue, 2 Mar 2021 16:44:06 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: renesas: rmobile-sysc: Set OF_POPULATED and absorb
 reset handling
Message-ID: <20210302154406.n4d6euiruwan4pm5@earth.universe>
References: <20210205133319.1921108-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pmkfhcgpktx5bhsd"
Content-Disposition: inline
In-Reply-To: <20210205133319.1921108-1-geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--pmkfhcgpktx5bhsd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 05, 2021 at 02:33:19PM +0100, Geert Uytterhoeven wrote:
> Currently, there are two drivers binding to the R-Mobile System
> Controller (SYSC):
>   - The rmobile-sysc driver registers PM domains from a core_initcall(),
>     and does not use a platform driver,
>   - The rmobile-reset driver registers a reset handler, and does use a
>     platform driver.
>=20
> As fw_devlink only considers devices, it does not know that the
> rmobile-sysc driver is ready.  Hence if fw_devlink is enabled, probing
> of on-chip devices that are part of the SYSC PM domain is deferred until
> the optional rmobile-reset has been bound, which may happen too late
> (for e.g. the system timer on SoCs lacking an ARM architectured or
> global timer), or not at all, leading to complete system boot failures.
>=20
> Fix this by:
>   1. Setting the OF_POPULATED flag for the SYSC device node after
>      successful initialization.
>      This will make of_link_to_phandle() ignore the SYSC device node as
>      a dependency, making consumer devices probe again.
>   2. Move reset handling from its own driver into the rmobile-sysc
>      driver.
>      This is needed because setting OF_POPULATED prevents the
>      rmobile-reset driver from binding against the same device.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> To be queued in renesas-devel for v5.13.

Acked-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

>=20
> Tested on:
>   - SH-Mobile AG5 (KZM-A9-GT),
>   - R-Mobile APE6 (APE6-EVM),
>   - R-Mobile A1 (Armadillo-800 EVA).
>=20
>  drivers/power/reset/Kconfig         |  7 ---
>  drivers/power/reset/Makefile        |  1 -
>  drivers/power/reset/rmobile-reset.c | 88 -----------------------------
>  drivers/soc/renesas/rmobile-sysc.c  | 65 ++++++++++++++++++++-
>  4 files changed, 64 insertions(+), 97 deletions(-)
>  delete mode 100644 drivers/power/reset/rmobile-reset.c
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 1737e227b16e5136..417b112be3f660de 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -251,13 +251,6 @@ config POWER_RESET_SYSCON_POWEROFF
>  	help
>  	  Poweroff support for generic SYSCON mapped register poweroff.
> =20
> -config POWER_RESET_RMOBILE
> -	tristate "Renesas R-Mobile reset driver"
> -	depends on ARCH_RMOBILE || COMPILE_TEST
> -	depends on HAS_IOMEM
> -	help
> -	  Reboot support for Renesas R-Mobile and SH-Mobile SoCs.
> -
>  config POWER_RESET_ZX
>  	tristate "ZTE SoCs reset driver"
>  	depends on ARCH_ZX || COMPILE_TEST
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index b4601c0a96ed26c7..77a57ca8e5300d60 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -29,7 +29,6 @@ obj-$(CONFIG_POWER_RESET_XGENE) +=3D xgene-reboot.o
>  obj-$(CONFIG_POWER_RESET_KEYSTONE) +=3D keystone-reset.o
>  obj-$(CONFIG_POWER_RESET_SYSCON) +=3D syscon-reboot.o
>  obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) +=3D syscon-poweroff.o
> -obj-$(CONFIG_POWER_RESET_RMOBILE) +=3D rmobile-reset.o
>  obj-$(CONFIG_POWER_RESET_ZX) +=3D zx-reboot.o
>  obj-$(CONFIG_REBOOT_MODE) +=3D reboot-mode.o
>  obj-$(CONFIG_SYSCON_REBOOT_MODE) +=3D syscon-reboot-mode.o
> diff --git a/drivers/power/reset/rmobile-reset.c b/drivers/power/reset/rm=
obile-reset.c
> deleted file mode 100644
> index bd3b396558e0df8c..0000000000000000
> --- a/drivers/power/reset/rmobile-reset.c
> +++ /dev/null
> @@ -1,88 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Renesas R-Mobile Reset Driver
> - *
> - * Copyright (C) 2014 Glider bvba
> - */
> -
> -#include <linux/io.h>
> -#include <linux/module.h>
> -#include <linux/notifier.h>
> -#include <linux/of_address.h>
> -#include <linux/platform_device.h>
> -#include <linux/printk.h>
> -#include <linux/reboot.h>
> -
> -/* SYSC Register Bank 2 */
> -#define RESCNT2		0x20		/* Reset Control Register 2 */
> -
> -/* Reset Control Register 2 */
> -#define RESCNT2_PRES	0x80000000	/* Soft power-on reset */
> -
> -static void __iomem *sysc_base2;
> -
> -static int rmobile_reset_handler(struct notifier_block *this,
> -				 unsigned long mode, void *cmd)
> -{
> -	pr_debug("%s %lu\n", __func__, mode);
> -
> -	/* Let's assume we have acquired the HPB semaphore */
> -	writel(RESCNT2_PRES, sysc_base2 + RESCNT2);
> -
> -	return NOTIFY_DONE;
> -}
> -
> -static struct notifier_block rmobile_reset_nb =3D {
> -	.notifier_call =3D rmobile_reset_handler,
> -	.priority =3D 192,
> -};
> -
> -static int rmobile_reset_probe(struct platform_device *pdev)
> -{
> -	int error;
> -
> -	sysc_base2 =3D of_iomap(pdev->dev.of_node, 1);
> -	if (!sysc_base2)
> -		return -ENODEV;
> -
> -	error =3D register_restart_handler(&rmobile_reset_nb);
> -	if (error) {
> -		dev_err(&pdev->dev,
> -			"cannot register restart handler (err=3D%d)\n", error);
> -		goto fail_unmap;
> -	}
> -
> -	return 0;
> -
> -fail_unmap:
> -	iounmap(sysc_base2);
> -	return error;
> -}
> -
> -static int rmobile_reset_remove(struct platform_device *pdev)
> -{
> -	unregister_restart_handler(&rmobile_reset_nb);
> -	iounmap(sysc_base2);
> -	return 0;
> -}
> -
> -static const struct of_device_id rmobile_reset_of_match[] =3D {
> -	{ .compatible =3D "renesas,sysc-rmobile", },
> -	{ /* sentinel */ }
> -};
> -MODULE_DEVICE_TABLE(of, rmobile_reset_of_match);
> -
> -static struct platform_driver rmobile_reset_driver =3D {
> -	.probe =3D rmobile_reset_probe,
> -	.remove =3D rmobile_reset_remove,
> -	.driver =3D {
> -		.name =3D "rmobile_reset",
> -		.of_match_table =3D rmobile_reset_of_match,
> -	},
> -};
> -
> -module_platform_driver(rmobile_reset_driver);
> -
> -MODULE_DESCRIPTION("Renesas R-Mobile Reset Driver");
> -MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas@glider.be>");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/soc/renesas/rmobile-sysc.c b/drivers/soc/renesas/rmo=
bile-sysc.c
> index bf64d052f9245db5..a8d85d111924d9ee 100644
> --- a/drivers/soc/renesas/rmobile-sysc.c
> +++ b/drivers/soc/renesas/rmobile-sysc.c
> @@ -1,10 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * rmobile power management support
> + * R-Mobile power management and reset support
>   *
>   * Copyright (C) 2012  Renesas Solutions Corp.
>   * Copyright (C) 2012  Kuninori Morimoto <kuninori.morimoto.gx@renesas.c=
om>
>   * Copyright (C) 2014  Glider bvba
> + * Copyright (C) 2021  Glider bv
>   *
>   * based on pm-sh7372.c
>   *  Copyright (C) 2011 Magnus Damm
> @@ -12,11 +13,13 @@
>  #include <linux/clk/renesas.h>
>  #include <linux/console.h>
>  #include <linux/delay.h>
> +#include <linux/notifier.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/pm.h>
>  #include <linux/pm_clock.h>
>  #include <linux/pm_domain.h>
> +#include <linux/reboot.h>
>  #include <linux/slab.h>
> =20
>  #include <asm/io.h>
> @@ -29,6 +32,11 @@
>  #define PSTR_RETRIES	100
>  #define PSTR_DELAY_US	10
> =20
> +/* SYSC Register Bank 2 */
> +#define RESCNT2		0x20	/* Reset Control Register 2 */
> +
> +#define RESCNT2_PRES	BIT(31)	/* Soft power-on reset */
> +
>  struct rmobile_pm_domain {
>  	struct generic_pm_domain genpd;
>  	struct dev_power_governor *gov;
> @@ -309,6 +317,54 @@ static int __init rmobile_add_pm_domains(void __iome=
m *base,
>  	return 0;
>  }
> =20
> +struct rmobile_reset {
> +	void __iomem *base;
> +	struct notifier_block nb;
> +};
> +
> +static int rmobile_reset_handler(struct notifier_block *this,
> +				 unsigned long mode, void *cmd)
> +{
> +	struct rmobile_reset *reset =3D container_of(this, struct rmobile_reset,
> +						   nb);
> +
> +	pr_debug("%s %lu\n", __func__, mode);
> +
> +	/* Let's assume we have acquired the HPB semaphore */
> +	writel(RESCNT2_PRES, reset->base + RESCNT2);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int rmobile_reset_setup(struct device_node *np)
> +{
> +	struct rmobile_reset *reset;
> +	int error;
> +
> +	reset =3D kzalloc(sizeof(*reset), GFP_KERNEL);
> +	if (!reset)
> +		return -ENOMEM;
> +
> +	reset->base =3D of_iomap(np, 1);
> +	if (!reset->base)
> +		goto fail_free;
> +
> +	reset->nb.notifier_call =3D rmobile_reset_handler;
> +	reset->nb.priority =3D 192;
> +
> +	error =3D register_restart_handler(&reset->nb);
> +	if (error)
> +		goto fail_unmap;
> +
> +	return 0;
> +
> +fail_unmap:
> +	iounmap(reset->base);
> +fail_free:
> +	kfree(reset);
> +	return error;
> +}
> +
>  static int __init rmobile_init_pm_domains(void)
>  {
>  	struct device_node *np, *pmd;
> @@ -342,6 +398,13 @@ static int __init rmobile_init_pm_domains(void)
>  			of_node_put(np);
>  			break;
>  		}
> +
> +		of_node_set_flag(np, OF_POPULATED);
> +
> +		ret =3D rmobile_reset_setup(np);
> +		if (ret)
> +			pr_err("%pOF: cannot register restart handler (%d)\n",
> +			       np, ret);
>  	}
> =20
>  	put_special_pds();
> --=20
> 2.25.1
>=20

--pmkfhcgpktx5bhsd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmA+XTcACgkQ2O7X88g7
+ppCxA/+PoNIBxewxHZ00pMfN9/jD1SdXekNy7mpX2kieENnfOT/y+MnWgJVxI8k
gvtJBDy8DywwKAEpDLisQ01zx6u+7B6OkFG3JX3thtUukvEdmqMZFLTT2Owr0HNJ
cf74JdmbYG1n9cztoazhSVy6Uy/eadohKActXpHpxaZPXLpgivTzJZs7zZJpC+ve
+nvWEZrRWcVYRF2ZyTjeAJ1Cbtd5XSnWzQCYMbvU0HcPw1ir1cnZvthJDjPivKGI
ODc62Spk5T+pbyqvOxSQ8TyufeGWusM6j+QUVWD1yYnFdrwUFBQLsU/WG5AwRADo
k1/7jPKkht4DGyRAf8I6FRebhizPwlDSVdXyl3ZO8xeQKvQoQkWolkSQaoeSW2aV
hXAV7uNhF4T19O7ihiIZO+hzk/lTaEUnok1762QGeKAWawm6Ldx7HmFq1SSgT3u0
m3UJPlDyMo3znbaZ37Z2zIuh5NqKL5zCxn6U2+tiF0j7VTE/Zr/wSiTRNGP0du/e
+7UFmIeOJTz735UOs71vEmkTBLbz95BYi0fmO8F885yPbdLlln652dzD1bmjl0qO
n25TOpBZ/TVAkME4kkxTF9qXZZNjli+aaTsi9kHV2G7422PlfyxSvGKW52K8j14A
eDhn2Yx54U0URgIUsJH9EmWwvcy7c0367969rqRGU+s0rEoqGOQ=
=DzE0
-----END PGP SIGNATURE-----

--pmkfhcgpktx5bhsd--
