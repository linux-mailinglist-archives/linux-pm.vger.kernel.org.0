Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 505A0EE3E
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 03:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfD3BQc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 21:16:32 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43495 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbfD3BQb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 21:16:31 -0400
Received: by mail-io1-f65.google.com with SMTP id v9so10701212iol.10;
        Mon, 29 Apr 2019 18:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SfPqE6niR3NEIdogH38IJwz4sYLWIqWXqo9y3JeTJmY=;
        b=ahOWMx3qNBkWzwTs8zaTaZxnpSuv2c+pVuPd8bP+It6iHdPv4s7MZlZhN206R7LUiy
         pzS7QMl2xdkdSnT5q5XTrofVEcDnTj9vsM3Vh8/pDSKWxEjENfa8JVPl3KDsWfh6aCl6
         vhhWTJOWcGm8ig0/Xcq7VMq/Q969g0tlmJp/i7av74kef/xOBFiCSkm79igbMvPd9eZB
         zvewngiWtZrafR1Neq9JeWl13YE6q6dv1EzFTzVtibl59o0XCODty1oe7kju/soaxG+7
         N0bpwZwxJpMZzg4Q4o5nlhetQGXGg01KsorkVQmJvAvMMr+WVg6azWyvS1vJrpo7l8ET
         6EBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SfPqE6niR3NEIdogH38IJwz4sYLWIqWXqo9y3JeTJmY=;
        b=Xej3GTl8E6AeBl1ySqwGIeMxNzvqrhOrDirLVljvX3GUamcYbJUzYjloEiCyM5XM1z
         vHRiiYCYGV4+2Eeo9tZY0mVqWbGIdRLIsTsZdrq2C3ZuthyY5WAcID0Y9IVbn/ge3z2J
         /fyHb71h1OZe8JkoajuJpABElItvbOCNjyw+KOZp5jiMoSnDZoAdZxC9sYGll8ykvkPK
         Ya6/StC/+K9qC292iqBKvMxMrAfQXMTYWPZbUv0W9y6vhBJ8TkRNqc+HqyYgyJDDEm29
         rXq5UywJFwpdqBn14j2gftjry9GHJI7ij6ZgM+DkiAdyi53/x6gqO7LYzHclfz7NjlYN
         92Ig==
X-Gm-Message-State: APjAAAW/ZjcuCAYPoEHCm8x1Pv4PXbMj40eklEVS/rd0KwrmA2OCcc+p
        M6vvpjwN16/RdploieuO+U/OrUr5W4doMosVDQU=
X-Google-Smtp-Source: APXvYqyKgv7CSN7Z+Yu0SNze1uUShe+UhbzvK1b7yzjIKnAzHUB4FaH4bAsq5DSo4VxO3GN7D8Dim/BABQpvPXdEwfE=
X-Received: by 2002:a5d:8b97:: with SMTP id p23mr388150iol.83.1556586990899;
 Mon, 29 Apr 2019 18:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190429195349.20335-1-andrew.smirnov@gmail.com>
 <20190429195349.20335-3-andrew.smirnov@gmail.com> <20190429203601.GA22613@roeck-us.net>
In-Reply-To: <20190429203601.GA22613@roeck-us.net>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 29 Apr 2019 18:16:19 -0700
Message-ID: <CAHQ1cqGnvyWxrqA2Bq92UEpo+OR-HSo-hwp6sh8P9x-YbTZZWQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] power: supply: Add driver for Microchip UCS1002
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Enric Balletbo Serra <enric.balletbo@collabora.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 29, 2019 at 1:36 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Apr 29, 2019 at 12:53:48PM -0700, Andrey Smirnov wrote:
> > Add driver for Microchip UCS1002 Programmable USB Port Power
> > Controller with Charger Emulation. The driver exposed a power supply
> > device to control/monitor various parameter of the device as well as a
> > regulator to allow controlling VBUS line.
> >
> > Signed-off-by: Enric Balletbo Serra <enric.balletbo@collabora.com>
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > ---
> >  drivers/power/supply/Kconfig         |   9 +
> >  drivers/power/supply/Makefile        |   1 +
> >  drivers/power/supply/ucs1002_power.c | 646 +++++++++++++++++++++++++++
> >  3 files changed, 656 insertions(+)
> >  create mode 100644 drivers/power/supply/ucs1002_power.c
> >
> > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> > index e901b9879e7e..c614c8a196f3 100644
> > --- a/drivers/power/supply/Kconfig
> > +++ b/drivers/power/supply/Kconfig
> > @@ -660,4 +660,13 @@ config FUEL_GAUGE_SC27XX
> >        Say Y here to enable support for fuel gauge with SC27XX
> >        PMIC chips.
> >
> > +config CHARGER_UCS1002
> > +        tristate "Microchip UCS1002 USB Port Power Controller"
> > +     depends on I2C
> > +     depends on OF
> > +     select REGMAP_I2C
> > +     help
> > +       Say Y to enable support for Microchip UCS1002 Programmable
> > +       USB Port Power Controller with Charger Emulation.
> > +
> >  endif # POWER_SUPPLY
> > diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> > index b731c2a9b695..c56803a9e4fe 100644
> > --- a/drivers/power/supply/Makefile
> > +++ b/drivers/power/supply/Makefile
> > @@ -87,3 +87,4 @@ obj-$(CONFIG_AXP288_CHARGER)        += axp288_charger.o
> >  obj-$(CONFIG_CHARGER_CROS_USBPD)     += cros_usbpd-charger.o
> >  obj-$(CONFIG_CHARGER_SC2731) += sc2731_charger.o
> >  obj-$(CONFIG_FUEL_GAUGE_SC27XX)      += sc27xx_fuel_gauge.o
> > +obj-$(CONFIG_CHARGER_UCS1002)        += ucs1002_power.o
> > diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
> > new file mode 100644
> > index 000000000000..677f20a4d76f
> > --- /dev/null
> > +++ b/drivers/power/supply/ucs1002_power.c
> > @@ -0,0 +1,646 @@
> ...
> > +
> > +static enum power_supply_usb_type ucs1002_usb_types[] = {
> > +     POWER_SUPPLY_USB_TYPE_PD,
> > +     POWER_SUPPLY_USB_TYPE_SDP,
> > +     POWER_SUPPLY_USB_TYPE_DCP,
> > +     POWER_SUPPLY_USB_TYPE_CDP,
> > +     POWER_SUPPLY_USB_TYPE_UNKNOWN,
> > +};
> > +
> > +static int ucs1002_set_usb_type(struct ucs1002_info *info, int val)
> > +{
> > +     unsigned int mode;
> > +
> > +     if (val >= ARRAY_SIZE(ucs1002_usb_types))
> > +             return -EINVAL;
> > +
> I hate to bring it up that late, but I don't see a check
> against val being negative anywhere in the calling code.
>

Sure, I'll add it in v4

Thanks,
Andrey Smirnov
