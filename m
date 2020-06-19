Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628E4201685
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jun 2020 18:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395064AbgFSQbx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jun 2020 12:31:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388976AbgFSOwj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Jun 2020 10:52:39 -0400
Received: from earth.universe (dyndsl-037-138-190-043.ewe-ip-backbone.de [37.138.190.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FE4121852;
        Fri, 19 Jun 2020 14:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578359;
        bh=i67KDE+PFmmQj9KC7OiGYsLdMFJ1r4ASlSwr3oP7eFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IYfhRfTW+4+mLYVvCDtdHAvk12cXDP0O7Cu11bIdtTXa7qDhKy5N5q+kzLcJhPLet
         7nEk8sIbHXdrkP10KrO2Jpbs7ovjkKtnuc/4+xohwX4XyAIilUxnttXXuM40tkOT02
         tZqi4L+hAFL10H4Lwy+XUG3MOuF/StStzMMTTg9Q=
Received: by earth.universe (Postfix, from userid 1000)
        id ACD2D3C08CD; Fri, 19 Jun 2020 16:52:37 +0200 (CEST)
Date:   Fri, 19 Jun 2020 16:52:37 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Daniel =?utf-8?B?R29uesOhbGV6?= Cabanelas <dgcbueu@gmail.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/2 ] power: reset: add driver for LinkStation power
 off
Message-ID: <20200619145237.7fz6sbwbhb2rhhu2@earth.universe>
References: <3315137.NY7H5Hu6o1@tool>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j7hkta2eynmybcrd"
Content-Disposition: inline
In-Reply-To: <3315137.NY7H5Hu6o1@tool>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--j7hkta2eynmybcrd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 13, 2020 at 12:26:52PM +0200, Daniel Gonz=E1lez Cabanelas wrote:
> Some Buffalo LinkStations perform the power off operation, at restart
> time, depending on the state of an output pin (LED2/INTn) at the ethernet
> PHY. This pin is also used to wake the machine when a WoL packet is=20
> received by the PHY.
>=20
> The driver is required by the Buffalo LinkStation LS421DE (ARM MVEBU),
> and other models. Without it, the board remains forever halted if a=20
> power off command is executed, unless the PSU is disconnected and
> connected again.
>=20
> Add the driver to provide the power off function and also make the WoL
> feature to be available.
>=20
> Signed-off-by: Daniel Gonz=E1lez Cabanelas <dgcbueu@gmail.com>
> ---
> Changes in v3:
>   - Code for PHY autodectection added, "phy-handle,intn" deleted.
> Changes in v2:
>   - The driver is now compatible with the WoL function, the LED2 pin outp=
ut
>     is now used as INTn. Added the required code to make INTn work proper=
ly.
>   - Code for PHY autodectection deleted, "phy-handle,intn" is now mandato=
ry.
>   - Replace a dev_info with a dev_dbg.
>   - Use phy_device_free in the driver remove.
>   - Cosmetic changes.
>=20
>  drivers/power/reset/Kconfig                |  11 ++
>  drivers/power/reset/Makefile               |   1 +
>  drivers/power/reset/linkstation-poweroff.c | 144 +++++++++++++++++++++
>  3 files changed, 156 insertions(+)
>  create mode 100644 drivers/power/reset/linkstation-poweroff.c
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index f07b982c8d..431cd9f201 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -99,6 +99,17 @@ config POWER_RESET_HISI
>  	help
>  	  Reboot support for Hisilicon boards.
> =20
> +config POWER_RESET_LINKSTATION
> +	tristate "Buffalo LinkStation power-off driver"
> +	depends on ARCH_MVEBU || COMPILE_TEST
> +	depends on OF_MDIO && PHYLIB
> +	help
> +	  This driver supports turning off some Buffalo LinkStations by
> +	  setting an output pin at the ethernet PHY to the correct state.
> +	  It also makes the device compatible with the WoL function.
> +
> +	  Say Y here if you have Buffalo LinkStation LS421D/E.
> +
>  config POWER_RESET_MSM
>  	bool "Qualcomm MSM power-off driver"
>  	depends on ARCH_QCOM
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index 5710ca4695..c51eceba9e 100644
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
>  obj-$(CONFIG_POWER_RESET_OXNAS) +=3D oxnas-restart.o
> diff --git a/drivers/power/reset/linkstation-poweroff.c b/drivers/power/r=
eset/linkstation-poweroff.c
> new file mode 100644
> index 0000000000..688af0a962
> --- /dev/null
> +++ b/drivers/power/reset/linkstation-poweroff.c
> @@ -0,0 +1,144 @@
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
> +/* Defines from the eth phy Marvell driver */
> +#define MII_MARVELL_COPPER_PAGE		0
> +#define MII_MARVELL_LED_PAGE		3
> +#define MII_MARVELL_WOL_PAGE		17
> +#define MII_MARVELL_PHY_PAGE		22
> +
> +#define MII_PHY_LED_CTRL		16
> +#define MII_88E1318S_PHY_LED_TCR	18
> +#define MII_88E1318S_PHY_WOL_CTRL	16
> +#define MII_M1011_IEVENT		19
> +
> +#define MII_88E1318S_PHY_LED_TCR_INTn_ENABLE		BIT(7)
> +#define MII_88E1318S_PHY_LED_TCR_FORCE_INT		BIT(15)
> +#define MII_88E1318S_PHY_WOL_CTRL_CLEAR_WOL_STATUS	BIT(12)
> +#define LED2_FORCE_ON					(0x8 << 8)
> +#define LEDMASK						GENMASK(11,8)
> +
> +static struct phy_device *phydev;
> +
> +static void mvphy_reg_intn(u16 data)
> +{
> +	int rc =3D 0, saved_page;
> +
> +	saved_page =3D phy_select_page(phydev, MII_MARVELL_LED_PAGE);
> +	if (saved_page < 0)
> +		goto err;
> +
> +	/* Force manual LED2 control to let INTn work */
> +	__phy_modify(phydev, MII_PHY_LED_CTRL, LEDMASK, LED2_FORCE_ON);
> +
> +	/* Set the LED[2]/INTn pin to the required state */
> +	__phy_modify(phydev, MII_88E1318S_PHY_LED_TCR,
> +		     MII_88E1318S_PHY_LED_TCR_FORCE_INT,
> +		     MII_88E1318S_PHY_LED_TCR_INTn_ENABLE | data);
> +
> +	if (!data) {
> +		/* Clear interrupts to ensure INTn won't be holded in high state */
> +		__phy_write(phydev, MII_MARVELL_PHY_PAGE, MII_MARVELL_COPPER_PAGE);
> +		__phy_read(phydev, MII_M1011_IEVENT);
> +
> +		/* If WOL was enabled and a magic packet was received before powering
> +		 * off, we won't be able to wake up by sending another magic packet.=
=20
> +		 * Clear WOL status.
> +		 */
> +		__phy_write(phydev, MII_MARVELL_PHY_PAGE, MII_MARVELL_WOL_PAGE);
> +		__phy_set_bits(phydev, MII_88E1318S_PHY_WOL_CTRL,
> +			       MII_88E1318S_PHY_WOL_CTRL_CLEAR_WOL_STATUS);
> +	}
> +err:
> +	rc =3D phy_restore_page(phydev, saved_page, rc);
> +	if (rc < 0)
> +		dev_err(&phydev->mdio.dev, "Write register failed, %d\n", rc);
> +}
> +
> +static int linkstation_reboot_notifier(struct notifier_block *nb,
> +				       unsigned long action, void *unused)
> +{
> +	if (action =3D=3D SYS_RESTART)
> +		mvphy_reg_intn(MII_88E1318S_PHY_LED_TCR_FORCE_INT);
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

I think this can be removed here and then you can use
devm_register_reboot_notifier in probe and drop the
unregister in remove function. Otherwise the driver
LGTM.

-- Sebastian

> +	mvphy_reg_intn(0);
> +
> +	kernel_restart("Power off");
> +}
> +
> +static int linkstation_poweroff_probe(struct platform_device *pdev)
> +{
> +	struct mii_bus *bus;
> +	struct device_node *dn;
> +
> +	dn =3D of_find_node_by_name(NULL, "mdio");
> +	if (!dn)
> +		return -ENODEV;
> +
> +	bus =3D of_mdio_find_bus(dn);
> +	of_node_put(dn);
> +	if (!bus)
> +		return -EPROBE_DEFER;
> +
> +	phydev =3D phy_find_first(bus);
> +	if (!phydev)
> +		return -EPROBE_DEFER;
> +
> +	register_reboot_notifier(&linkstation_reboot_nb);
> +	pm_power_off =3D linkstation_poweroff;
> +
> +	dev_dbg(&pdev->dev, "PHY [%s]\n", phydev_name(phydev));
> +
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
> --=20
> 2.27.0
>=20
>=20
>=20
>=20

--j7hkta2eynmybcrd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7s0SMACgkQ2O7X88g7
+poCdA/+ODHYt+t1EU3RdSi+HAlVJoVMq2pVwojj6eF5JTN907b9Cw9jcn4pVN4u
Qv+hY8WZQyt78n0aRXmD0Ym3yUqt72WXsCyMPLi+AUxbbeg87KSW18BPgaRuLbvy
vI0MG43ASOlJlwMZ84MH15H7Z4y5XlUEW4b+JmGL5+oRnT0XSaPdhBv/r5MtlH3c
SRVQNloi6ZCMG7qZ9Fg2UvteHYbAS/idYGBtOlkCJzClf1mwseohjMHS74aJXQDi
G0ypN8ycMM/dfk5IoRQ2qlfQN43sjzOGK6ZSQ3Ho1+xr7TGGqDJ0OX1DPcoiZk2t
3nYBNFroyVciUPRujxY8iewsLU7jzTiGFfDJsGDVOBAJ/ok3e/KizU+aJIBcB5bO
/j66kEsIi9if92DmC3ohFgPBhG2qmm1eftOaknucTNVb7IH/LsUEp6RXhMVHRTun
nsC8D+0OkMOUQSCtNZbzsunQ2OX0OvGjPD2RtdafYrv7FKOj3Fv3ZcA85fDqVpLT
HDY+zahoisOlJLG5unmFuU7WaBa6rg0mnIA1VxuEDmY6TC09oz1UidhzbuGdowmf
PvGqFWQko59aaKTf9VXSdtE/E9ux28vZcXoXFaFdejtkVCNBYOxyQbslHBA8HrQx
M7gypokWjXXRAJkLwqcOBMEslmPyVwVwcakSmk87nv7/jNJ+ahI=
=eXkw
-----END PGP SIGNATURE-----

--j7hkta2eynmybcrd--
