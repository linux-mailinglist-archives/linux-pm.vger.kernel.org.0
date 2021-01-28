Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B92F30688D
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 01:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhA1AUb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 19:20:31 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36338 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhA1AT5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 19:19:57 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id DC2B11F4560D
Received: by earth.universe (Postfix, from userid 1000)
        id D21183C0C97; Thu, 28 Jan 2021 01:18:57 +0100 (CET)
Date:   Thu, 28 Jan 2021 01:18:57 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jun Nie <jun.nie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] power/reset: remove zte zx driver
Message-ID: <20210128001857.nfxlxqfjfdkyx6ze@earth.universe>
References: <20210120150851.1670788-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vuuovyfplnkmpmva"
Content-Disposition: inline
In-Reply-To: <20210120150851.1670788-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--vuuovyfplnkmpmva
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 20, 2021 at 04:08:26PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The zte zx platform is getting removed, so this driver is no
> longer needed.
>=20
> Cc: Jun Nie <jun.nie@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/Kconfig     |  7 ---
>  drivers/power/reset/Makefile    |  1 -
>  drivers/power/reset/zx-reboot.c | 86 ---------------------------------
>  3 files changed, 94 deletions(-)
>  delete mode 100644 drivers/power/reset/zx-reboot.c
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index b22c4fdb2561..0376a90bec09 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -251,13 +251,6 @@ config POWER_RESET_RMOBILE
>  	help
>  	  Reboot support for Renesas R-Mobile and SH-Mobile SoCs.
> =20
> -config POWER_RESET_ZX
> -	tristate "ZTE SoCs reset driver"
> -	depends on ARCH_ZX || COMPILE_TEST
> -	depends on HAS_IOMEM
> -	help
> -	  Reboot support for ZTE SoCs.
> -
>  config REBOOT_MODE
>  	tristate
> =20
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index 9dc49d3a57ff..46331119c886 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -29,7 +29,6 @@ obj-$(CONFIG_POWER_RESET_KEYSTONE) +=3D keystone-reset.o
>  obj-$(CONFIG_POWER_RESET_SYSCON) +=3D syscon-reboot.o
>  obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) +=3D syscon-poweroff.o
>  obj-$(CONFIG_POWER_RESET_RMOBILE) +=3D rmobile-reset.o
> -obj-$(CONFIG_POWER_RESET_ZX) +=3D zx-reboot.o
>  obj-$(CONFIG_REBOOT_MODE) +=3D reboot-mode.o
>  obj-$(CONFIG_SYSCON_REBOOT_MODE) +=3D syscon-reboot-mode.o
>  obj-$(CONFIG_POWER_RESET_SC27XX) +=3D sc27xx-poweroff.o
> diff --git a/drivers/power/reset/zx-reboot.c b/drivers/power/reset/zx-reb=
oot.c
> deleted file mode 100644
> index 457950833dba..000000000000
> --- a/drivers/power/reset/zx-reboot.c
> +++ /dev/null
> @@ -1,86 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * ZTE zx296702 SoC reset code
> - *
> - * Copyright (c) 2015 Linaro Ltd.
> - *
> - * Author: Jun Nie <jun.nie@linaro.org>
> - */
> -
> -#include <linux/delay.h>
> -#include <linux/io.h>
> -#include <linux/module.h>
> -#include <linux/notifier.h>
> -#include <linux/of_address.h>
> -#include <linux/platform_device.h>
> -#include <linux/reboot.h>
> -
> -static void __iomem *base;
> -static void __iomem *pcu_base;
> -
> -static int zx_restart_handler(struct notifier_block *this,
> -			      unsigned long mode, void *cmd)
> -{
> -	writel_relaxed(1, base + 0xb0);
> -	writel_relaxed(1, pcu_base + 0x34);
> -
> -	mdelay(50);
> -	pr_emerg("Unable to restart system\n");
> -
> -	return NOTIFY_DONE;
> -}
> -
> -static struct notifier_block zx_restart_nb =3D {
> -	.notifier_call =3D zx_restart_handler,
> -	.priority =3D 128,
> -};
> -
> -static int zx_reboot_probe(struct platform_device *pdev)
> -{
> -	struct device_node *np =3D pdev->dev.of_node;
> -	int err;
> -
> -	base =3D of_iomap(np, 0);
> -	if (!base) {
> -		WARN(1, "failed to map base address");
> -		return -ENODEV;
> -	}
> -
> -	np =3D of_find_compatible_node(NULL, NULL, "zte,zx296702-pcu");
> -	pcu_base =3D of_iomap(np, 0);
> -	of_node_put(np);
> -	if (!pcu_base) {
> -		iounmap(base);
> -		WARN(1, "failed to map pcu_base address");
> -		return -ENODEV;
> -	}
> -
> -	err =3D register_restart_handler(&zx_restart_nb);
> -	if (err) {
> -		iounmap(base);
> -		iounmap(pcu_base);
> -		dev_err(&pdev->dev, "Register restart handler failed(err=3D%d)\n",
> -			err);
> -	}
> -
> -	return err;
> -}
> -
> -static const struct of_device_id zx_reboot_of_match[] =3D {
> -	{ .compatible =3D "zte,sysctrl" },
> -	{}
> -};
> -MODULE_DEVICE_TABLE(of, zx_reboot_of_match);
> -
> -static struct platform_driver zx_reboot_driver =3D {
> -	.probe =3D zx_reboot_probe,
> -	.driver =3D {
> -		.name =3D "zx-reboot",
> -		.of_match_table =3D zx_reboot_of_match,
> -	},
> -};
> -module_platform_driver(zx_reboot_driver);
> -
> -MODULE_DESCRIPTION("ZTE SoCs reset driver");
> -MODULE_AUTHOR("Jun Nie <jun.nie@linaro.org>");
> -MODULE_LICENSE("GPL v2");
> --=20
> 2.29.2
>=20

--vuuovyfplnkmpmva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmASAvEACgkQ2O7X88g7
+poBtw/7B1nY0wBH91ftjlZ6t079U27zYLApRVUokmLY9xOxS41O/lADZjb8i62H
7cDen/RnqVq7ozT+gDa1GG0gbFRMyqhhaSpI92gbatukJBStn6ZmHIXqI6DZRf7Q
j3txMqernTpv0PsXEB+cSAV6fl38K6O+HwzMD2MYmkS9njxwAlqg11t53yYqFVtI
F5IMDiuy9/N0ta2/kLWLf1dubT3qUD9ZnMSuU/bVmoYlAaXywGU44lCp5gZw2kuR
LWjVORQTC6Ns5z3n7tQHvJY4hyNmVTJk49f6/4GJdXkN3iNuGh7s0GqUAnWDqznq
nTidX9fFal2O4TObyoMuvNcY8dJdO/8r7b8hS57wqJMSzRLke8K6g2soUU/dgEIU
uAQflzSob4H0pZkQ1BgumTa8i6LpbU4dEXZ8JOkNITAnP/jT8cKkyINpdzPggUBU
8z66hQdY9ANTuuDgwTayBGobyOPGZDKSLJPifzP64ffBJVZR43bBPbo77gvv9Ial
yaQZiuXYBFtRS7q47dKoVblLfp+B1md+IObCLBolApBapmJTAIf0kgM+6GRXnX9h
rc21RzgfUZtr050LxzTE6wlNxKH/lRthg/huv5gUl+e5CWA8OKP9M9SAtY79gn+r
T29+l7bsojsgcMNq0EEvqjHWVJg2QxWfeoHQWk5mSUxkC7Ykb1c=
=M4o/
-----END PGP SIGNATURE-----

--vuuovyfplnkmpmva--
