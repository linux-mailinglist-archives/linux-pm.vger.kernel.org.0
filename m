Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2AC1C03E3
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 19:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgD3R1t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Apr 2020 13:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726272AbgD3R1t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2020 13:27:49 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39235C035494
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2020 10:27:49 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id i16so3590348ybq.9
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2020 10:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o45wkq5+iylfOORf8LoSz/gqqXK29arMkGN4SnEs7iw=;
        b=Sjg1/wP322yDwKz3S9lpPtm8nj3urjxvjBk6L++JTWXzNUvJuSXOxOOD/TY+T3ohqB
         klOXbXZeo0/MAY52CJlBVyLLvub76zIuTUubxAuWYnzBEKjWlTk+agIITnmfDWKNTkoW
         2Tgq6icBwZOJOA8KULv1oArstoSCaay5x8jFItUuy01QbmUsLcTWwvCeN2h+27g7sMKA
         gotKTGGeL3suu2ZTnO8udmptREUvZEGROoo9mC+PZpcdQDGrar2GFTZ7U4EI7RExy5ah
         EuD+Q+nf1uFT9g43pEJx2P6GFdrgaPnAWkcufoQhhLzEkHFm4nZXx8vClD8R8cV9BHLz
         QpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o45wkq5+iylfOORf8LoSz/gqqXK29arMkGN4SnEs7iw=;
        b=UC8TaRvEMvcRmIhBP6HRl+SEbvbWP3M2pj4pn4GeYBHj19m165RYsuaoYiZJD0d50l
         rakMIKDPwL8ONoYE2C5k7HjybBvJB2iloLDCosSKpbJgPRTiVYgQU7j0joMhd9Qwcv9n
         PjYpBIWfnbJ9zEzq6W1fJ9BN6fM+vdLCGpIsmkmjo0cyUaZI01qEZxa5F7zJDsUOVAVS
         t5cyTM3hnDGgUlbyBVWL9P4E0jF6qmrEf65CXyDGhupBlwI02DJIJ2XgPBbHFlMCP0l9
         cbII32rhNDNRfw0csbUpV/M7CV5K1v/CTL+DaBCg61QGYa0h7qZG1Dk4ebGsmwYEJCVk
         tDBQ==
X-Gm-Message-State: AGi0PuZaSUMpobSHRgGlhzaIa9Gl6qgv408RdHIuSggTilHUJ+fG/kp8
        ZA0NRqF6wrmmpnMccC3rUDDwC9ffH72MeuW3c1Kf5Q==
X-Google-Smtp-Source: APiQypKTbvmQ7BfbngonA+YUv2KNObQrFMR2qmL4G/R8gFKyalwY0pgBAUE3I/F0PeLHNL7Q5LOXPIFZBnFbw0ipOXk=
X-Received: by 2002:a05:6902:6ad:: with SMTP id j13mr7095130ybt.281.1588267668452;
 Thu, 30 Apr 2020 10:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <8730960.DhLy2TFWpf@tool> <20200429225303.lmr6nme22rnrcz64@earth.universe>
In-Reply-To: <20200429225303.lmr6nme22rnrcz64@earth.universe>
From:   =?UTF-8?Q?Daniel_Gonz=C3=A1lez_Cabanelas?= <dgcbueu@gmail.com>
Date:   Thu, 30 Apr 2020 19:27:37 +0200
Message-ID: <CABwr4_vt_aT0tFYXa+r3dKOrSMeOYwky8gdW6z+vQELfYwtARQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] power:reset: add driver for LinkStation power off
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian. I''ll apply your suggestions.

Thank you
Daniel

El jue., 30 abr. 2020 a las 0:53, Sebastian Reichel
(<sebastian.reichel@collabora.com>) escribi=C3=B3:
>
> [please always add the maintainer to Cc or To, in this case sre@kernel.or=
g]
>
> Hi,
>
> On Sat, Apr 25, 2020 at 03:00:43AM +0200, Daniel Gonz=C3=A1lez Cabanelas =
wrote:
> > Some Buffalo LinkStations perform the power off operation, at restart
> > time, depending on the state of an output pin (LED) at the ethernet PHY=
.
> >
> > The driver is required by the Buffalo LinkStation LS421DE (ARM MVEBU),
> > and other models. Without it, the board remains forever halted if a
> > power off command is executed, unless the PSU is disconnected and
> > connected again.
> >
> > Signed-off-by: Daniel Gonz=C3=A1lez Cabanelas <dgcbueu@gmail.com>
> > Reviewed-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> > ---
>
> Thanks for the patch. Looks like that hardware was designed by
> creative hardware engineers trying to impress software engineers
> with weird designs :)
>
> >  drivers/power/reset/Kconfig                |  10 ++
> >  drivers/power/reset/Makefile               |   1 +
> >  drivers/power/reset/linkstation-poweroff.c | 117 +++++++++++++++++++++
> >  3 files changed, 128 insertions(+)
> >  create mode 100644 drivers/power/reset/linkstation-poweroff.c
> >
> > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > index 8903803020..de948835f8 100644
> > --- a/drivers/power/reset/Kconfig
> > +++ b/drivers/power/reset/Kconfig
> > @@ -203,6 +203,16 @@ config POWER_RESET_KEYSTONE
> >       help
> >         Reboot support for the KEYSTONE SoCs.
> >
> > +config POWER_RESET_LINKSTATION
> > +     tristate "Buffalo LinkStation power-off driver"
> > +     depends on ARCH_MVEBU || COMPILE_TEST
> > +     depends on OF_MDIO && PHYLIB
> > +     help
> > +       Some Buffalo LinkStations use a LED output at the ethernet PHY
> > +       to inform the board that a power off operation must be performe=
d
> > +       after restarting. This driver sets the LED to the proper state
> > +       for restarting or powering off.
> > +
> >  config POWER_RESET_SYSCON
> >       bool "Generic SYSCON regmap reset driver"
> >       depends on OF
> > diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefil=
e
> > index da37f8b851..a8c83d2470 100644
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
> >  obj-$(CONFIG_POWER_RESET_QCOM_PON) +=3D qcom-pon.o
> > diff --git a/drivers/power/reset/linkstation-poweroff.c b/drivers/power=
/reset/linkstation-poweroff.c
> > new file mode 100644
> > index 0000000000..b5a4cc2c2b
> > --- /dev/null
> > +++ b/drivers/power/reset/linkstation-poweroff.c
> > @@ -0,0 +1,117 @@
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
> > +#define MII_MARVELL_LED_PAGE 3
> > +#define MII_PHY_LED_CTRL     16
> > +
> > +#define LED2_OFF             (0x8 << 8)
> > +#define LED2_ON                      (0x9 << 8)
> > +#define LEDMASK                      GENMASK(11,8)
> > +
> > +static struct phy_device *phydev;
> > +
> > +static void mvphy_reg_led(u16 data)
> > +{
> > +     int rc;
> > +     rc =3D phy_modify_paged(phydev, MII_MARVELL_LED_PAGE,
> > +                           MII_PHY_LED_CTRL, LEDMASK, data);
> > +     if (rc < 0)
> > +             dev_err(&phydev->mdio.dev,
> > +                     "LED2 write register failed, %d\n", rc);
> > +}
> > +
> > +static int linkstation_reboot_notifier(struct notifier_block *nb,
> > +                                    unsigned long action, void *unused=
)
> > +{
> > +     if (action =3D=3D SYS_RESTART)
> > +             mvphy_reg_led(LED2_ON);
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
> > +     mvphy_reg_led(LED2_OFF);
> > +
> > +     kernel_restart("Power off");
> > +}
> > +
> > +static int linkstation_poweroff_probe(struct platform_device *pdev)
> > +{
> > +     struct mii_bus *bus;
> > +     struct device_node *dn;
> > +
> > +     dn =3D of_parse_phandle(pdev->dev.of_node, "phy-handle,led", 0);
> > +
> > +     if (dn) {
> > +             phydev =3D of_phy_find_device(dn);
> > +             of_node_put(dn);
> > +     } else {
> > +             dn =3D of_find_node_by_name(NULL, "mdio");
> > +             if (!dn)
> > +                     return -ENODEV;
> > +
> > +             bus =3D of_mdio_find_bus(dn);
> > +             of_node_put(dn);
> > +             if (!bus)
> > +                     return -EPROBE_DEFER;
> > +
> > +             phydev =3D phy_find_first(bus);
>
> do we need this code, or can we just make phy-handle,led mandatory
> and error out otherwise?
>
> > +     }
> > +
> > +     if (!phydev)
> > +             return -ENODEV;
>
> Should this return -EPROBE_DEFER?
>
> > +     register_reboot_notifier(&linkstation_reboot_nb);
> > +     pm_power_off =3D linkstation_poweroff;
> > +
> > +     dev_info(&pdev->dev, "PHY [%s]\n", phydev_name(phydev));
>
> I don't think this deserves more than dev_dbg()
>
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
>
> Otherwise looks good to me,
>
> -- Sebastian
