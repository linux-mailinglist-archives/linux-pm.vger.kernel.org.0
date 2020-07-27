Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5D422FE33
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 01:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgG0X4O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 19:56:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgG0X4O (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Jul 2020 19:56:14 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E805620679;
        Mon, 27 Jul 2020 23:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595894173;
        bh=FwIpB8P/hxYUnpPcq1dzkeRKvDDN/24T9qQAaLZtthY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SvgACDgsNYhzuuBfg2Imv2cI5wVXoTzvvKlDJ99rQJeC7nnTGOffll3RW+UoGzanC
         UUmKr51oxnpyg3sGDXgJhuRPuhCxhpl7/Zja1ZOeIojWMKp2pdlcH3/0Ch1lSU/rQb
         7tCoTpBEn2ZUmi13j9KEdlZVlaa7Qs/d6oDbR4cY=
Received: by earth.universe (Postfix, from userid 1000)
        id D33903C0B87; Tue, 28 Jul 2020 01:56:10 +0200 (CEST)
Date:   Tue, 28 Jul 2020 01:56:10 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Daniel =?utf-8?B?R29uesOhbGV6?= Cabanelas <dgcbueu@gmail.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH v4] power: reset: add driver for LinkStation power off
Message-ID: <20200727235610.6vyp2uf2pyf57tbz@earth.universe>
References: <2534992.hIiKHhy4eC@tool>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cxptfwneecvb7now"
Content-Disposition: inline
In-Reply-To: <2534992.hIiKHhy4eC@tool>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--cxptfwneecvb7now
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 15, 2020 at 03:35:14PM +0200, Daniel Gonz=E1lez Cabanelas wrote:
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

Doing reboot/poweroff via network PHY pin is a really interesting
hardware hack. Considering the circumstances the driver looks good,
so: queued to power-supply's for-next branch.

Thanks,

-- Sebastian

> Changes in v4:
>   - Deleted the power-off binding as suggested by Rob Herring. Therefore
>     the binding patch isn't required. Now the device detection is made
>     using the root node compatible string.
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
>  drivers/power/reset/linkstation-poweroff.c | 136 +++++++++++++++++++++
>  3 files changed, 148 insertions(+)
>  create mode 100644 drivers/power/reset/linkstation-poweroff.c
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index f07b982c8d..0a1fb5c74f 100644
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
> +	  Say Y here if you have a Buffalo LinkStation LS421D/E.
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
> index 0000000000..1d1113d98c
> --- /dev/null
> +++ b/drivers/power/reset/linkstation-poweroff.c
> @@ -0,0 +1,136 @@
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
> +	mvphy_reg_intn(0);
> +
> +	kernel_restart("Power off");
> +}
> +
> +static const struct of_device_id ls_poweroff_of_match[] =3D {
> +	{ .compatible =3D "buffalo,ls421d" },
> +	{ .compatible =3D "buffalo,ls421de" },
> +	{ },
> +};
> +
> +static int __init linkstation_poweroff_init(void)
> +{
> +	struct mii_bus *bus;
> +	struct device_node *dn;
> +
> +	dn =3D of_find_matching_node(NULL, ls_poweroff_of_match);
> +	if (!dn)
> +		return -ENODEV;
> +	of_node_put(dn);
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
> +	return 0;
> +}
> +
> +static void __exit linkstation_poweroff_exit(void)
> +{
> +	pm_power_off =3D NULL;
> +	unregister_reboot_notifier(&linkstation_reboot_nb);
> +}
> +
> +module_init(linkstation_poweroff_init);
> +module_exit(linkstation_poweroff_exit);
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

--cxptfwneecvb7now
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl8faZQACgkQ2O7X88g7
+ppRXRAAg4GHe2A4VKZSg91z+4uRpXFMzH4cKzdUy+d/J8Ax/6ZZ41qMoeNUQXKH
jrcgfdbjFXhkjYSOBAQEb+YbV4RotbMVSdV165CzvqM5y2uA5kM1Zv/44Gv7Ev9r
TMq2pDZ35fsc7bRfX9dpaJfydGgpSqovICSKBMNBBQvyJe6pPmSe6qRJXjDg0FHE
rABdaD1I2+TxfngmrkYziJMIB/Kxn0AMJG3QPgZIAMtfiLF46PoLSUNvnfCxL9bL
2TiHmIYJEEraA1ifdJkHVXhADocBVz09p+D/UnWVChEucD4MzB/X9zu8UeAUqtGc
gmQr7ZkKpRFzJ3g68gRemdbOSyIOql1uPO17P8UYdj/JLmCoQz5sNJXAGMXpdJlt
2ip+WfDTd01aQWcX426ukYPblnxc3qYeUalp4hVtAtwWpXlg/lEuw+5+wwjbBWYk
BNB1TPugoN2hMGgKj/EgoZkd/i8GTcnfr6xt1cSUNQdhY8EoexVEohR7gk2uqcgw
TuTaLYhhbiqJBu0VUJpMe4sQDhVipYj+ysLdEQsfzjd4QWywJD4TP1Fqf5C3wwTA
y450jrXdkvUMxCGsiwncFf1KdG5qgRZ+oZlgPBX6WJiaStGL8+gSdoNhWY1P7Isz
doie2K7BtlkJ9TJ0F8oZgU+t6vODXgS5kWN2MlEACJnn9Eqi5vs=
=AmuE
-----END PGP SIGNATURE-----

--cxptfwneecvb7now--
