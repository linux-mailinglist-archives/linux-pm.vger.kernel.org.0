Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3C8201AD9
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jun 2020 21:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgFSTEQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jun 2020 15:04:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgFSTEQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Jun 2020 15:04:16 -0400
Received: from earth.universe (dyndsl-037-138-190-043.ewe-ip-backbone.de [37.138.190.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39CF920EDD;
        Fri, 19 Jun 2020 19:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592593454;
        bh=H4HCaXhDpm1zhhDGUdoz9qfUreQHbnWsav72U6JPlx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LqGFR9Q+AFLQGkxbH4g0njCJK+++ZRNr245yGVpVVG27tRWvUH7ihnqg0ZMiY7vx4
         NzNr2X/cgHtuHHQ5KZRby5oECruZyfonf0Od3+m+WluMEc9pDFDqSzq2oRuRKc8PD+
         rx3im2ytFXS0yeUztMo7mDgqBWA5DtLIxfcTUAQc=
Received: by earth.universe (Postfix, from userid 1000)
        id 8FD873C08CD; Fri, 19 Jun 2020 21:04:12 +0200 (CEST)
Date:   Fri, 19 Jun 2020 21:04:12 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Daniel =?utf-8?B?R29uesOhbGV6?= Cabanelas <dgcbueu@gmail.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/2 ] power: reset: add driver for LinkStation power
 off
Message-ID: <20200619190412.zgmmwrxdnryx7sqe@earth.universe>
References: <3315137.NY7H5Hu6o1@tool>
 <20200619145237.7fz6sbwbhb2rhhu2@earth.universe>
 <CABwr4_unk9ezqNmbyHN70Dkk2_RQidJ42SjPDry-0q_aW=V24g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="opcwjkhtxp2zhdis"
Content-Disposition: inline
In-Reply-To: <CABwr4_unk9ezqNmbyHN70Dkk2_RQidJ42SjPDry-0q_aW=V24g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--opcwjkhtxp2zhdis
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 19, 2020 at 07:25:25PM +0200, Daniel Gonz=E1lez Cabanelas wrote:
> Hi Sebastian,
>=20
> El vie., 19 jun. 2020 a las 16:52, Sebastian Reichel
> (<sre@kernel.org>) escribi=F3:
> >
> > Hi,
> >
> > On Sat, Jun 13, 2020 at 12:26:52PM +0200, Daniel Gonz=E1lez Cabanelas w=
rote:
> > > Some Buffalo LinkStations perform the power off operation, at restart
> > > time, depending on the state of an output pin (LED2/INTn) at the ethe=
rnet
> > > PHY. This pin is also used to wake the machine when a WoL packet is
> > > received by the PHY.
> > >
> > > The driver is required by the Buffalo LinkStation LS421DE (ARM MVEBU),
> > > and other models. Without it, the board remains forever halted if a
> > > power off command is executed, unless the PSU is disconnected and
> > > connected again.
> > >
> > > Add the driver to provide the power off function and also make the WoL
> > > feature to be available.
> > >
> > > Signed-off-by: Daniel Gonz=E1lez Cabanelas <dgcbueu@gmail.com>
> > > ---
> > > Changes in v3:
> > >   - Code for PHY autodectection added, "phy-handle,intn" deleted.
> > > Changes in v2:
> > >   - The driver is now compatible with the WoL function, the LED2 pin =
output
> > >     is now used as INTn. Added the required code to make INTn work pr=
operly.
> > >   - Code for PHY autodectection deleted, "phy-handle,intn" is now man=
datory.
> > >   - Replace a dev_info with a dev_dbg.
> > >   - Use phy_device_free in the driver remove.
> > >   - Cosmetic changes.
> > >
> > >  drivers/power/reset/Kconfig                |  11 ++
> > >  drivers/power/reset/Makefile               |   1 +
> > >  drivers/power/reset/linkstation-poweroff.c | 144 +++++++++++++++++++=
++
> > >  3 files changed, 156 insertions(+)
> > >  create mode 100644 drivers/power/reset/linkstation-poweroff.c
> > >
> > > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > > index f07b982c8d..431cd9f201 100644
> > > --- a/drivers/power/reset/Kconfig
> > > +++ b/drivers/power/reset/Kconfig
> > > @@ -99,6 +99,17 @@ config POWER_RESET_HISI
> > >       help
> > >         Reboot support for Hisilicon boards.
> > >
> > > +config POWER_RESET_LINKSTATION
> > > +     tristate "Buffalo LinkStation power-off driver"
> > > +     depends on ARCH_MVEBU || COMPILE_TEST
> > > +     depends on OF_MDIO && PHYLIB
> > > +     help
> > > +       This driver supports turning off some Buffalo LinkStations by
> > > +       setting an output pin at the ethernet PHY to the correct stat=
e.
> > > +       It also makes the device compatible with the WoL function.
> > > +
> > > +       Say Y here if you have Buffalo LinkStation LS421D/E.
> > > +
> > >  config POWER_RESET_MSM
> > >       bool "Qualcomm MSM power-off driver"
> > >       depends on ARCH_QCOM
> > > diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makef=
ile
> > > index 5710ca4695..c51eceba9e 100644
> > > --- a/drivers/power/reset/Makefile
> > > +++ b/drivers/power/reset/Makefile
> > > @@ -10,6 +10,7 @@ obj-$(CONFIG_POWER_RESET_GEMINI_POWEROFF) +=3D gemi=
ni-poweroff.o
> > >  obj-$(CONFIG_POWER_RESET_GPIO) +=3D gpio-poweroff.o
> > >  obj-$(CONFIG_POWER_RESET_GPIO_RESTART) +=3D gpio-restart.o
> > >  obj-$(CONFIG_POWER_RESET_HISI) +=3D hisi-reboot.o
> > > +obj-${CONFIG_POWER_RESET_LINKSTATION} +=3D linkstation-poweroff.o
> > >  obj-$(CONFIG_POWER_RESET_MSM) +=3D msm-poweroff.o
> > >  obj-$(CONFIG_POWER_RESET_MT6323) +=3D mt6323-poweroff.o
> > >  obj-$(CONFIG_POWER_RESET_OXNAS) +=3D oxnas-restart.o
> > > diff --git a/drivers/power/reset/linkstation-poweroff.c b/drivers/pow=
er/reset/linkstation-poweroff.c
> > > new file mode 100644
> > > index 0000000000..688af0a962
> > > --- /dev/null
> > > +++ b/drivers/power/reset/linkstation-poweroff.c
> > > @@ -0,0 +1,144 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * LinkStation power off restart driver
> > > + * Copyright (C) 2020 Daniel Gonz=E1lez Cabanelas <dgcbueu@gmail.com>
> > > + */
> > > +
> > > +#include <linux/module.h>
> > > +#include <linux/notifier.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_mdio.h>
> > > +#include <linux/of_platform.h>
> > > +#include <linux/reboot.h>
> > > +#include <linux/phy.h>
> > > +
> > > +/* Defines from the eth phy Marvell driver */
> > > +#define MII_MARVELL_COPPER_PAGE              0
> > > +#define MII_MARVELL_LED_PAGE         3
> > > +#define MII_MARVELL_WOL_PAGE         17
> > > +#define MII_MARVELL_PHY_PAGE         22
> > > +
> > > +#define MII_PHY_LED_CTRL             16
> > > +#define MII_88E1318S_PHY_LED_TCR     18
> > > +#define MII_88E1318S_PHY_WOL_CTRL    16
> > > +#define MII_M1011_IEVENT             19
> > > +
> > > +#define MII_88E1318S_PHY_LED_TCR_INTn_ENABLE         BIT(7)
> > > +#define MII_88E1318S_PHY_LED_TCR_FORCE_INT           BIT(15)
> > > +#define MII_88E1318S_PHY_WOL_CTRL_CLEAR_WOL_STATUS   BIT(12)
> > > +#define LED2_FORCE_ON                                        (0x8 <<=
 8)
> > > +#define LEDMASK                                              GENMASK=
(11,8)
> > > +
> > > +static struct phy_device *phydev;
> > > +
> > > +static void mvphy_reg_intn(u16 data)
> > > +{
> > > +     int rc =3D 0, saved_page;
> > > +
> > > +     saved_page =3D phy_select_page(phydev, MII_MARVELL_LED_PAGE);
> > > +     if (saved_page < 0)
> > > +             goto err;
> > > +
> > > +     /* Force manual LED2 control to let INTn work */
> > > +     __phy_modify(phydev, MII_PHY_LED_CTRL, LEDMASK, LED2_FORCE_ON);
> > > +
> > > +     /* Set the LED[2]/INTn pin to the required state */
> > > +     __phy_modify(phydev, MII_88E1318S_PHY_LED_TCR,
> > > +                  MII_88E1318S_PHY_LED_TCR_FORCE_INT,
> > > +                  MII_88E1318S_PHY_LED_TCR_INTn_ENABLE | data);
> > > +
> > > +     if (!data) {
> > > +             /* Clear interrupts to ensure INTn won't be holded in h=
igh state */
> > > +             __phy_write(phydev, MII_MARVELL_PHY_PAGE, MII_MARVELL_C=
OPPER_PAGE);
> > > +             __phy_read(phydev, MII_M1011_IEVENT);
> > > +
> > > +             /* If WOL was enabled and a magic packet was received b=
efore powering
> > > +              * off, we won't be able to wake up by sending another =
magic packet.
> > > +              * Clear WOL status.
> > > +              */
> > > +             __phy_write(phydev, MII_MARVELL_PHY_PAGE, MII_MARVELL_W=
OL_PAGE);
> > > +             __phy_set_bits(phydev, MII_88E1318S_PHY_WOL_CTRL,
> > > +                            MII_88E1318S_PHY_WOL_CTRL_CLEAR_WOL_STAT=
US);
> > > +     }
> > > +err:
> > > +     rc =3D phy_restore_page(phydev, saved_page, rc);
> > > +     if (rc < 0)
> > > +             dev_err(&phydev->mdio.dev, "Write register failed, %d\n=
", rc);
> > > +}
> > > +
> > > +static int linkstation_reboot_notifier(struct notifier_block *nb,
> > > +                                    unsigned long action, void *unus=
ed)
> > > +{
> > > +     if (action =3D=3D SYS_RESTART)
> > > +             mvphy_reg_intn(MII_88E1318S_PHY_LED_TCR_FORCE_INT);
> > > +
> > > +     return NOTIFY_DONE;
> > > +}
> > > +
> > > +static struct notifier_block linkstation_reboot_nb =3D {
> > > +     .notifier_call =3D linkstation_reboot_notifier,
> > > +};
> > > +
> > > +static void linkstation_poweroff(void)
> > > +{
> > > +     unregister_reboot_notifier(&linkstation_reboot_nb);
> >
> > I think this can be removed here and then you can use
> > devm_register_reboot_notifier in probe and drop the
> > unregister in remove function. Otherwise the driver
> > LGTM.
>=20
> I've tested this change and it didn't work. Probably because without
> unregistering the notifier, when kernel_restart("Power off") is
> called, the notifier is still there, and we end performing a restart
> instead the power off operation.

Strange. Well it's no big issue, so let's keep it as is. I will wait
a bit with merging to give Rob a chance to review the updated DT bindings.

-- Sebastian

> > > +     mvphy_reg_intn(0);
> > > +
> > > +     kernel_restart("Power off");
> > > +}
> > > +
> > > +static int linkstation_poweroff_probe(struct platform_device *pdev)
> > > +{
> > > +     struct mii_bus *bus;
> > > +     struct device_node *dn;
> > > +
> > > +     dn =3D of_find_node_by_name(NULL, "mdio");
> > > +     if (!dn)
> > > +             return -ENODEV;
> > > +
> > > +     bus =3D of_mdio_find_bus(dn);
> > > +     of_node_put(dn);
> > > +     if (!bus)
> > > +             return -EPROBE_DEFER;
> > > +
> > > +     phydev =3D phy_find_first(bus);
> > > +     if (!phydev)
> > > +             return -EPROBE_DEFER;
> > > +
> > > +     register_reboot_notifier(&linkstation_reboot_nb);
> > > +     pm_power_off =3D linkstation_poweroff;
> > > +
> > > +     dev_dbg(&pdev->dev, "PHY [%s]\n", phydev_name(phydev));
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int linkstation_poweroff_remove(struct platform_device *pdev)
> > > +{
> > > +     pm_power_off =3D NULL;
> > > +     unregister_reboot_notifier(&linkstation_reboot_nb);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static const struct of_device_id ls_poweroff_of_match[] =3D {
> > > +     { .compatible =3D "linkstation,power-off", },
> > > +     { },
> > > +};
> > > +
> > > +MODULE_DEVICE_TABLE(of, ls_poweroff_of_match);
> > > +
> > > +static struct platform_driver linkstation_poweroff_driver =3D {
> > > +     .probe =3D linkstation_poweroff_probe,
> > > +     .remove =3D linkstation_poweroff_remove,
> > > +     .driver =3D {
> > > +             .name =3D "linkstation_power_off",
> > > +             .of_match_table =3D ls_poweroff_of_match,
> > > +     },
> > > +};
> > > +
> > > +module_platform_driver(linkstation_poweroff_driver);
> > > +
> > > +MODULE_AUTHOR("Daniel Gonz=E1lez Cabanelas <dgcbueu@gmail.com>");
> > > +MODULE_DESCRIPTION("LinkStation power off driver");
> > > +MODULE_LICENSE("GPL v2");
> > > --
> > > 2.27.0
> > >
> > >
> > >
> > >

--opcwjkhtxp2zhdis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7tDB0ACgkQ2O7X88g7
+pqkFhAAg1fw8kne4k9OLSXa9O7Op2m6Sa3YI+1k8zvC+Jx/J9q5GJwj3GBNH1oU
v5j/H+eXi9aGNiG6ZIWfkWCy9JVCKay19dZPZ4L7cSFJriUHvBEggGXPeMaug/1O
LsyEzK4UKEBNgIh9ePW8FDpJzE6e9eyAPhP8MsDt7xRV8HjO+xMxiavjk5D0kR8+
qhodGowZ0KQhLt5oTt6LWGNxJwW6R1qlmzcOBjfi/WDLYRTXgKaDNwcKnLNJlQ9R
oL9De+Gfb0K3dz0UL+xTGImOhEO6h3bRjhTvF/vePFvwGo8h1hLE3imOoSB2n5XE
4Uit6TCDLPdfeEgT+wT4XfI4ZaitsxQWDzMa09QzVNdqIDjXh7wO+Lytl9vQCxeX
EKvUwZr6mae4uUHEQzowvgAhN7B2wqSx90vqCpR596aETEvKb6nsQnnWXC/RjOZA
Xua8zP59p5mlduU/fsHX4EYjE1mymo/Qo/XYPNqDopWX9ZMnjjArv716WPlw4anP
xeRyfGs56FpoP6yxtVP95P+s4jk+JIdDlZkIABXxLG+plc+Gx0g0KNKu26iMUtbx
LlGCoRi1MzjVpJc1IYguAmzlspUQaiydVcieu0F3eFrbVbT92QTA6vts/YzjI1m7
S23gY3SaDOBiUJCP2mmRe8/jvhA7bEsqgZXa4eiZnsz8Oakuk/U=
=ncS8
-----END PGP SIGNATURE-----

--opcwjkhtxp2zhdis--
