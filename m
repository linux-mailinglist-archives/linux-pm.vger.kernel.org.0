Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A770C1BEC31
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 00:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgD2WxJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 18:53:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39946 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgD2WxI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 18:53:08 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 2F3032A18C0
Received: by earth.universe (Postfix, from userid 1000)
        id 8B2E83C08C6; Thu, 30 Apr 2020 00:53:03 +0200 (CEST)
Date:   Thu, 30 Apr 2020 00:53:03 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Daniel =?utf-8?B?R29uesOhbGV6?= Cabanelas <dgcbueu@gmail.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] power:reset: add driver for LinkStation power off
Message-ID: <20200429225303.lmr6nme22rnrcz64@earth.universe>
References: <8730960.DhLy2TFWpf@tool>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w53q5cru55unl7zm"
Content-Disposition: inline
In-Reply-To: <8730960.DhLy2TFWpf@tool>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--w53q5cru55unl7zm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[please always add the maintainer to Cc or To, in this case sre@kernel.org]

Hi,

On Sat, Apr 25, 2020 at 03:00:43AM +0200, Daniel Gonz=E1lez Cabanelas wrote:
> Some Buffalo LinkStations perform the power off operation, at restart
> time, depending on the state of an output pin (LED) at the ethernet PHY.
>=20
> The driver is required by the Buffalo LinkStation LS421DE (ARM MVEBU),
> and other models. Without it, the board remains forever halted if a=20
> power off command is executed, unless the PSU is disconnected and
> connected again.
>=20
> Signed-off-by: Daniel Gonz=E1lez Cabanelas <dgcbueu@gmail.com>
> Reviewed-by: =C1lvaro Fern=E1ndez Rojas <noltari@gmail.com>
> ---

Thanks for the patch. Looks like that hardware was designed by
creative hardware engineers trying to impress software engineers
with weird designs :)

>  drivers/power/reset/Kconfig                |  10 ++
>  drivers/power/reset/Makefile               |   1 +
>  drivers/power/reset/linkstation-poweroff.c | 117 +++++++++++++++++++++
>  3 files changed, 128 insertions(+)
>  create mode 100644 drivers/power/reset/linkstation-poweroff.c
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 8903803020..de948835f8 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -203,6 +203,16 @@ config POWER_RESET_KEYSTONE
>  	help
>  	  Reboot support for the KEYSTONE SoCs.
> =20
> +config POWER_RESET_LINKSTATION
> +	tristate "Buffalo LinkStation power-off driver"
> +	depends on ARCH_MVEBU || COMPILE_TEST
> +	depends on OF_MDIO && PHYLIB
> +	help
> +	  Some Buffalo LinkStations use a LED output at the ethernet PHY
> +	  to inform the board that a power off operation must be performed=20
> +	  after restarting. This driver sets the LED to the proper state
> +	  for restarting or powering off.
> +
>  config POWER_RESET_SYSCON
>  	bool "Generic SYSCON regmap reset driver"
>  	depends on OF
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index da37f8b851..a8c83d2470 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_POWER_RESET_GEMINI_POWEROFF) +=3D gemini-p=
oweroff.o
>  obj-$(CONFIG_POWER_RESET_GPIO) +=3D gpio-poweroff.o
>  obj-$(CONFIG_POWER_RESET_GPIO_RESTART) +=3D gpio-restart.o
>  obj-$(CONFIG_POWER_RESET_HISI) +=3D hisi-reboot.o
> +obj-${CONFIG_POWER_RESET_LINKSTATION} +=3D linkstation-poweroff.o
>  obj-$(CONFIG_POWER_RESET_MSM) +=3D msm-poweroff.o
>  obj-$(CONFIG_POWER_RESET_MT6323) +=3D mt6323-poweroff.o
>  obj-$(CONFIG_POWER_RESET_QCOM_PON) +=3D qcom-pon.o
> diff --git a/drivers/power/reset/linkstation-poweroff.c b/drivers/power/r=
eset/linkstation-poweroff.c
> new file mode 100644
> index 0000000000..b5a4cc2c2b
> --- /dev/null
> +++ b/drivers/power/reset/linkstation-poweroff.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * LinkStation power off restart driver
> + * Copyright (C) 2020 Daniel Gonz=E1lez Cabanelas <dgcbueu@gmail.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/of.h>
> +#include <linux/of_mdio.h>
> +#include <linux/of_platform.h>
> +#include <linux/reboot.h>
> +#include <linux/phy.h>
> +
> +#define MII_MARVELL_LED_PAGE	3
> +#define MII_PHY_LED_CTRL	16
> +
> +#define LED2_OFF		(0x8 << 8)
> +#define LED2_ON			(0x9 << 8)
> +#define LEDMASK			GENMASK(11,8)
> +
> +static struct phy_device *phydev;
> +
> +static void mvphy_reg_led(u16 data)
> +{
> +	int rc;
> +	rc =3D phy_modify_paged(phydev, MII_MARVELL_LED_PAGE,
> +			      MII_PHY_LED_CTRL, LEDMASK, data);
> +	if (rc < 0)
> +		dev_err(&phydev->mdio.dev,
> +			"LED2 write register failed, %d\n", rc);
> +}
> +
> +static int linkstation_reboot_notifier(struct notifier_block *nb,
> +				       unsigned long action, void *unused)
> +{
> +	if (action =3D=3D SYS_RESTART)
> +		mvphy_reg_led(LED2_ON);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block linkstation_reboot_nb =3D {
> +	.notifier_call =3D linkstation_reboot_notifier,
> +};
> +
> +static void linkstation_poweroff(void)
> +{
> +	unregister_reboot_notifier(&linkstation_reboot_nb);
> +	mvphy_reg_led(LED2_OFF);
> +
> +	kernel_restart("Power off");
> +}
> +
> +static int linkstation_poweroff_probe(struct platform_device *pdev)
> +{
> +	struct mii_bus *bus;
> +	struct device_node *dn;
> +
> +	dn =3D of_parse_phandle(pdev->dev.of_node, "phy-handle,led", 0);
> +
> +	if (dn) {
> +		phydev =3D of_phy_find_device(dn);
> +		of_node_put(dn);
> +	} else {
> +		dn =3D of_find_node_by_name(NULL, "mdio");
> +		if (!dn)
> +			return -ENODEV;
> +
> +		bus =3D of_mdio_find_bus(dn);
> +		of_node_put(dn);
> +		if (!bus)
> +			return -EPROBE_DEFER;
> +
> +		phydev =3D phy_find_first(bus);

do we need this code, or can we just make phy-handle,led mandatory
and error out otherwise?

> +	}
> +
> +	if (!phydev)
> +		return -ENODEV;

Should this return -EPROBE_DEFER?

> +	register_reboot_notifier(&linkstation_reboot_nb);
> +	pm_power_off =3D linkstation_poweroff;
> +
> +	dev_info(&pdev->dev, "PHY [%s]\n", phydev_name(phydev));

I don't think this deserves more than dev_dbg()

> +	return 0;
> +}
> +
> +static int linkstation_poweroff_remove(struct platform_device *pdev)
> +{
> +	pm_power_off =3D NULL;
> +	unregister_reboot_notifier(&linkstation_reboot_nb);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ls_poweroff_of_match[] =3D {
> +	{ .compatible =3D "linkstation,power-off", },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, ls_poweroff_of_match);
> +
> +static struct platform_driver linkstation_poweroff_driver =3D {
> +	.probe =3D linkstation_poweroff_probe,
> +	.remove =3D linkstation_poweroff_remove,
> +	.driver =3D {
> +		.name =3D "linkstation_power_off",
> +		.of_match_table =3D ls_poweroff_of_match,
> +	},
> +};
> +
> +module_platform_driver(linkstation_poweroff_driver);
> +
> +MODULE_AUTHOR("Daniel Gonz=E1lez Cabanelas <dgcbueu@gmail.com>");
> +MODULE_DESCRIPTION("LinkStation power off driver");
> +MODULE_LICENSE("GPL v2");

Otherwise looks good to me,

-- Sebastian

--w53q5cru55unl7zm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6qBU8ACgkQ2O7X88g7
+pof1Q//ScVSJnVR8JXUitaAxGzUk9YvhoMZyKpkq2HoSaVId6I361O0D6AvguZ0
83+4IBfZ/CKFZn/KVcFrdj8cRT1sHyP/hBXRsbsg3hvm5IIVeECLcb7Jc0QIj6TK
MQMupUiJpR/Mzm3wru0IoFJJi6stfwac5iGP6tZ+yXm+1cmDGO/hMK1/YwtuVjk4
zXvl76b6c1laFcA2Fr3LRodjuevEYriaX/pZw8IB70rF+hrrnmX2mwQJojeGjM3i
5oSK/r5t/RPltRoO1eVmmHUkBjTgtnpDqsr/fguKFm5tMIXU2fuA34FE8Sp9yiUz
4YUgWP1WsS74JXnkZ4nGi7+QAd8MKPTt7cxothCsnSbwzEo0hW7elBzXxm1ilfoa
+t4nCXgsOwcLAq3UxC0koDu8IKyFnSZR/pscmE3i4n+rsLgYCXdWazp8A8FXfvEW
1nRsrLb+BX+DfzqyyxV/II9F9RtIa4Jh1NwXsBt3Bth5hxl/H06TEQWrXVHiuWxY
UYmVGAuGHdh/+NKiJC0J7LJ81GBB9nM4LrGu47C+mG7zi96fo4KSY/T/0NKKleXQ
eWooICwXUFlPMqZU1s1W1OW57mDNXJHSoSOIXu0djO1othMeckEwKdvFFQBSfWP5
PMWW6ZFMxyXIE+Wr/ZhiFCOrbSxvMGTDhvxPAiDyMnyC4sbdEC8=
=CWNO
-----END PGP SIGNATURE-----

--w53q5cru55unl7zm--
