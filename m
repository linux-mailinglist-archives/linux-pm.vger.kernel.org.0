Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6039120196A
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jun 2020 19:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbgFSRZk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jun 2020 13:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbgFSRZh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2020 13:25:37 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A120C06174E
        for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2020 10:25:37 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id b15so5298177ybg.12
        for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2020 10:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bkEWjWXqjBZVsPVhPv/NOF2Z3u1EPViCIb4Xb0v/sUE=;
        b=iQtVFDFlzepyz+Ub2etCID5sIaNR3ShRxXkqIeUeJeKTGcm6p8To+9Fa2jo0bu51OW
         tf0+oZNd8VhtU8wBAwSDo3fqv0ImjACRbj2gAQe+F8brc+JBjPXup9lhMUft9ptMva5u
         6H30I1HlAoQ8mnnXoDX/LNuL5W+aKj1kHaMgYsTNQP/MhyIM9m3mAKBJQNH8VaJk63dQ
         CORaNtLFSD3RtEIvx1R/qP01V/TduxdpWZVKG9k2y5Lm4X661z6Lvm6Epl6PkXL6lvkP
         eYsJ6nU5QzOZtAd97qbOFd5vZgX7EUOcraE0HKPedIZWeMBF72n1P8omohxhWf1D4lf/
         bd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bkEWjWXqjBZVsPVhPv/NOF2Z3u1EPViCIb4Xb0v/sUE=;
        b=bkrpD6oQ7gdaDFSb4tGnDvQRgL0jm1QPD4dPDzKH1bVJHNGoIKz1lee6ThJxV/ZiSA
         Bt36BhnHtSVC9m29wfGj+JDn6nYJ7BgADngMJ05s54Oa645L10zVnEutprlCjwSnKi+D
         uBEWMw0vJaU96t76Sq/WPMJtnODJOBktuMKI8b3R+q+XK2Q8I5OILt0o7Algd0i6/FDU
         5mvcNNGq7cdcU+hVnZFpeXpJo3/fnj9xpQvlzPYBWb8e5YMj1GU5t9SVcU38PH2sPbud
         hzM8hwzOlMDTlRNKID902pOk3WVA5vfvdhq3szz//U7Lil7pMRs4pRD6FzHDFjQsKpjf
         /LNQ==
X-Gm-Message-State: AOAM531OYIMOCv4/RhQvYhnoUs+OGp+SF18ybNbMr2j3lvQTXjo1HFmU
        c6D2noAXh5sFB6O+jr7Xfn5MFz/SKqqXbhwc1Sred/+V
X-Google-Smtp-Source: ABdhPJzTeTEmIGA/l6PzvNYY0QE9AU6OVLAu4AxRutg/y0w0QOHH7rvq3C20j0QqdPbXaEl4z6JmYW+spmj6mxwZj/w=
X-Received: by 2002:a25:3ac6:: with SMTP id h189mr7359178yba.281.1592587536446;
 Fri, 19 Jun 2020 10:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <3315137.NY7H5Hu6o1@tool> <20200619145237.7fz6sbwbhb2rhhu2@earth.universe>
In-Reply-To: <20200619145237.7fz6sbwbhb2rhhu2@earth.universe>
From:   =?UTF-8?Q?Daniel_Gonz=C3=A1lez_Cabanelas?= <dgcbueu@gmail.com>
Date:   Fri, 19 Jun 2020 19:25:25 +0200
Message-ID: <CABwr4_unk9ezqNmbyHN70Dkk2_RQidJ42SjPDry-0q_aW=V24g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2 ] power: reset: add driver for LinkStation power off
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

El vie., 19 jun. 2020 a las 16:52, Sebastian Reichel
(<sre@kernel.org>) escribi=C3=B3:
>
> Hi,
>
> On Sat, Jun 13, 2020 at 12:26:52PM +0200, Daniel Gonz=C3=A1lez Cabanelas =
wrote:
> > Some Buffalo LinkStations perform the power off operation, at restart
> > time, depending on the state of an output pin (LED2/INTn) at the ethern=
et
> > PHY. This pin is also used to wake the machine when a WoL packet is
> > received by the PHY.
> >
> > The driver is required by the Buffalo LinkStation LS421DE (ARM MVEBU),
> > and other models. Without it, the board remains forever halted if a
> > power off command is executed, unless the PSU is disconnected and
> > connected again.
> >
> > Add the driver to provide the power off function and also make the WoL
> > feature to be available.
> >
> > Signed-off-by: Daniel Gonz=C3=A1lez Cabanelas <dgcbueu@gmail.com>
> > ---
> > Changes in v3:
> >   - Code for PHY autodectection added, "phy-handle,intn" deleted.
> > Changes in v2:
> >   - The driver is now compatible with the WoL function, the LED2 pin ou=
tput
> >     is now used as INTn. Added the required code to make INTn work prop=
erly.
> >   - Code for PHY autodectection deleted, "phy-handle,intn" is now manda=
tory.
> >   - Replace a dev_info with a dev_dbg.
> >   - Use phy_device_free in the driver remove.
> >   - Cosmetic changes.
> >
> >  drivers/power/reset/Kconfig                |  11 ++
> >  drivers/power/reset/Makefile               |   1 +
> >  drivers/power/reset/linkstation-poweroff.c | 144 +++++++++++++++++++++
> >  3 files changed, 156 insertions(+)
> >  create mode 100644 drivers/power/reset/linkstation-poweroff.c
> >
> > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > index f07b982c8d..431cd9f201 100644
> > --- a/drivers/power/reset/Kconfig
> > +++ b/drivers/power/reset/Kconfig
> > @@ -99,6 +99,17 @@ config POWER_RESET_HISI
> >       help
> >         Reboot support for Hisilicon boards.
> >
> > +config POWER_RESET_LINKSTATION
> > +     tristate "Buffalo LinkStation power-off driver"
> > +     depends on ARCH_MVEBU || COMPILE_TEST
> > +     depends on OF_MDIO && PHYLIB
> > +     help
> > +       This driver supports turning off some Buffalo LinkStations by
> > +       setting an output pin at the ethernet PHY to the correct state.
> > +       It also makes the device compatible with the WoL function.
> > +
> > +       Say Y here if you have Buffalo LinkStation LS421D/E.
> > +
> >  config POWER_RESET_MSM
> >       bool "Qualcomm MSM power-off driver"
> >       depends on ARCH_QCOM
> > diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefil=
e
> > index 5710ca4695..c51eceba9e 100644
> > --- a/drivers/power/reset/Makefile
> > +++ b/drivers/power/reset/Makefile
> > @@ -10,6 +10,7 @@ obj-$(CONFIG_POWER_RESET_GEMINI_POWEROFF) +=3D gemini=
-poweroff.o
> >  obj-$(CONFIG_POWER_RESET_GPIO) +=3D gpio-poweroff.o
> >  obj-$(CONFIG_POWER_RESET_GPIO_RESTART) +=3D gpio-restart.o
> >  obj-$(CONFIG_POWER_RESET_HISI) +=3D hisi-reboot.o
> > +obj-${CONFIG_POWER_RESET_LINKSTATION} +=3D linkstation-poweroff.o
> >  obj-$(CONFIG_POWER_RESET_MSM) +=3D msm-poweroff.o
> >  obj-$(CONFIG_POWER_RESET_MT6323) +=3D mt6323-poweroff.o
> >  obj-$(CONFIG_POWER_RESET_OXNAS) +=3D oxnas-restart.o
> > diff --git a/drivers/power/reset/linkstation-poweroff.c b/drivers/power=
/reset/linkstation-poweroff.c
> > new file mode 100644
> > index 0000000000..688af0a962
> > --- /dev/null
> > +++ b/drivers/power/reset/linkstation-poweroff.c
> > @@ -0,0 +1,144 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * LinkStation power off restart driver
> > + * Copyright (C) 2020 Daniel Gonz=C3=A1lez Cabanelas <dgcbueu@gmail.co=
m>
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/notifier.h>
> > +#include <linux/of.h>
> > +#include <linux/of_mdio.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/reboot.h>
> > +#include <linux/phy.h>
> > +
> > +/* Defines from the eth phy Marvell driver */
> > +#define MII_MARVELL_COPPER_PAGE              0
> > +#define MII_MARVELL_LED_PAGE         3
> > +#define MII_MARVELL_WOL_PAGE         17
> > +#define MII_MARVELL_PHY_PAGE         22
> > +
> > +#define MII_PHY_LED_CTRL             16
> > +#define MII_88E1318S_PHY_LED_TCR     18
> > +#define MII_88E1318S_PHY_WOL_CTRL    16
> > +#define MII_M1011_IEVENT             19
> > +
> > +#define MII_88E1318S_PHY_LED_TCR_INTn_ENABLE         BIT(7)
> > +#define MII_88E1318S_PHY_LED_TCR_FORCE_INT           BIT(15)
> > +#define MII_88E1318S_PHY_WOL_CTRL_CLEAR_WOL_STATUS   BIT(12)
> > +#define LED2_FORCE_ON                                        (0x8 << 8=
)
> > +#define LEDMASK                                              GENMASK(1=
1,8)
> > +
> > +static struct phy_device *phydev;
> > +
> > +static void mvphy_reg_intn(u16 data)
> > +{
> > +     int rc =3D 0, saved_page;
> > +
> > +     saved_page =3D phy_select_page(phydev, MII_MARVELL_LED_PAGE);
> > +     if (saved_page < 0)
> > +             goto err;
> > +
> > +     /* Force manual LED2 control to let INTn work */
> > +     __phy_modify(phydev, MII_PHY_LED_CTRL, LEDMASK, LED2_FORCE_ON);
> > +
> > +     /* Set the LED[2]/INTn pin to the required state */
> > +     __phy_modify(phydev, MII_88E1318S_PHY_LED_TCR,
> > +                  MII_88E1318S_PHY_LED_TCR_FORCE_INT,
> > +                  MII_88E1318S_PHY_LED_TCR_INTn_ENABLE | data);
> > +
> > +     if (!data) {
> > +             /* Clear interrupts to ensure INTn won't be holded in hig=
h state */
> > +             __phy_write(phydev, MII_MARVELL_PHY_PAGE, MII_MARVELL_COP=
PER_PAGE);
> > +             __phy_read(phydev, MII_M1011_IEVENT);
> > +
> > +             /* If WOL was enabled and a magic packet was received bef=
ore powering
> > +              * off, we won't be able to wake up by sending another ma=
gic packet.
> > +              * Clear WOL status.
> > +              */
> > +             __phy_write(phydev, MII_MARVELL_PHY_PAGE, MII_MARVELL_WOL=
_PAGE);
> > +             __phy_set_bits(phydev, MII_88E1318S_PHY_WOL_CTRL,
> > +                            MII_88E1318S_PHY_WOL_CTRL_CLEAR_WOL_STATUS=
);
> > +     }
> > +err:
> > +     rc =3D phy_restore_page(phydev, saved_page, rc);
> > +     if (rc < 0)
> > +             dev_err(&phydev->mdio.dev, "Write register failed, %d\n",=
 rc);
> > +}
> > +
> > +static int linkstation_reboot_notifier(struct notifier_block *nb,
> > +                                    unsigned long action, void *unused=
)
> > +{
> > +     if (action =3D=3D SYS_RESTART)
> > +             mvphy_reg_intn(MII_88E1318S_PHY_LED_TCR_FORCE_INT);
> > +
> > +     return NOTIFY_DONE;
> > +}
> > +
> > +static struct notifier_block linkstation_reboot_nb =3D {
> > +     .notifier_call =3D linkstation_reboot_notifier,
> > +};
> > +
> > +static void linkstation_poweroff(void)
> > +{
> > +     unregister_reboot_notifier(&linkstation_reboot_nb);
>
> I think this can be removed here and then you can use
> devm_register_reboot_notifier in probe and drop the
> unregister in remove function. Otherwise the driver
> LGTM.

I've tested this change and it didn't work. Probably because without
unregistering the notifier, when kernel_restart("Power off") is
called, the notifier is still there, and we end performing a restart
instead the power off operation.

Regards
Daniel

>
> -- Sebastian
>
> > +     mvphy_reg_intn(0);
> > +
> > +     kernel_restart("Power off");
> > +}
> > +
> > +static int linkstation_poweroff_probe(struct platform_device *pdev)
> > +{
> > +     struct mii_bus *bus;
> > +     struct device_node *dn;
> > +
> > +     dn =3D of_find_node_by_name(NULL, "mdio");
> > +     if (!dn)
> > +             return -ENODEV;
> > +
> > +     bus =3D of_mdio_find_bus(dn);
> > +     of_node_put(dn);
> > +     if (!bus)
> > +             return -EPROBE_DEFER;
> > +
> > +     phydev =3D phy_find_first(bus);
> > +     if (!phydev)
> > +             return -EPROBE_DEFER;
> > +
> > +     register_reboot_notifier(&linkstation_reboot_nb);
> > +     pm_power_off =3D linkstation_poweroff;
> > +
> > +     dev_dbg(&pdev->dev, "PHY [%s]\n", phydev_name(phydev));
> > +
> > +     return 0;
> > +}
> > +
> > +static int linkstation_poweroff_remove(struct platform_device *pdev)
> > +{
> > +     pm_power_off =3D NULL;
> > +     unregister_reboot_notifier(&linkstation_reboot_nb);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id ls_poweroff_of_match[] =3D {
> > +     { .compatible =3D "linkstation,power-off", },
> > +     { },
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, ls_poweroff_of_match);
> > +
> > +static struct platform_driver linkstation_poweroff_driver =3D {
> > +     .probe =3D linkstation_poweroff_probe,
> > +     .remove =3D linkstation_poweroff_remove,
> > +     .driver =3D {
> > +             .name =3D "linkstation_power_off",
> > +             .of_match_table =3D ls_poweroff_of_match,
> > +     },
> > +};
> > +
> > +module_platform_driver(linkstation_poweroff_driver);
> > +
> > +MODULE_AUTHOR("Daniel Gonz=C3=A1lez Cabanelas <dgcbueu@gmail.com>");
> > +MODULE_DESCRIPTION("LinkStation power off driver");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.27.0
> >
> >
> >
> >
