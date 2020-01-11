Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 867461382D1
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2020 19:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbgAKSIy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Jan 2020 13:08:54 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45405 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729957AbgAKSIy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Jan 2020 13:08:54 -0500
Received: by mail-io1-f68.google.com with SMTP id i11so5447714ioi.12;
        Sat, 11 Jan 2020 10:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LxEfZVuKcxp3lKlqmcOPSjzFzX8DHgPZfgnHNhakRIk=;
        b=uXf7aj4uxzdtK98Be7+5fY9hUHyvziolk+Bu3NXJ9VScPYkbhgVDSvI9ZbgCZivl8H
         ntFR95w/cNgy6ZOR+3DMyWhLVs9NuoC98owtR8tV6jtr4lQsG19LHCuvFysqXyMXEzc0
         Ehc2TGAYOstpt2ManacsW+S1tokHSaqkikyTeq2ASqUWSxfXeWVAnxzGCm1GXXtbeAOj
         34mSD88BnGgCU/priJG/utUt1b8bnF/A0FFkYf3gGUxu3a8SAwBxpHkyEXOgXmkkgJa0
         +GWWtt3iS2jBZbW5qbAP2/NVvjkbCeFUW3s9Kyt1LQm494fqs9pTt+OWHu+HgnuWVmz3
         rR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LxEfZVuKcxp3lKlqmcOPSjzFzX8DHgPZfgnHNhakRIk=;
        b=Lamls3ivjv4q4pVnfk++GWwPKPHdCHxCTnwMGMvLCfy0Y/1IhanXhID0yYHJkA7b1s
         Fe6vxn7ymzlvbtbNjV6ngjYi7tWmUO5pYnPRGUzHh+iDxmWEyUCqsbHsOVip6M0MRz51
         ElDD1dpj08LUPz6ycUmF/apGH1An1S5cPo+9ghxdhMqYv256mGNEcu58/0+n+DtuYnyH
         xO+YyVJSIIcjUZa0b7GDsl7eDSlfU2I29egrGHPHyVsOBiIZRJxylzMcixAEB5U30sJ/
         GV6b2Fh0ovNExcnEB6MuW9bMSe0WM3s6gEmX+RBY7RZfEMmyqItx0/l2KLyFj/PyHgq3
         2cmA==
X-Gm-Message-State: APjAAAU96d2m9yljPhX+aKFrqqiUjqm/oqQ7828ARvY3yAd11Vdl8OOq
        NV8CaNp0+QnWgr3NDFUNhQXfidPZvfwGmn2MhjrfKs7qdKw=
X-Google-Smtp-Source: APXvYqzCj23bUTd0TfMnW5RxTPfgpVC+rKfdgos2E1GVp0devff9RGnkC3LcLyqJnsaC92pMz3Tqc2qko1y5sonQCLo=
X-Received: by 2002:a6b:c410:: with SMTP id y16mr6781848ioa.18.1578766133521;
 Sat, 11 Jan 2020 10:08:53 -0800 (PST)
MIME-Version: 1.0
References: <20191228171904.24618-1-tiny.windzz@gmail.com> <CAGb2v67YPLy_qFuLKKMFytPEdFRUazoNfsQ1tYj8z3WVSRqC3Q@mail.gmail.com>
 <CAEExFWtkPBhqT-wteE0_bC=QqaTyuvAcj_4SMOLjYAdc6p4tkg@mail.gmail.com> <CAGb2v673PM_3QazNWBKYd=4pumyyyE3XFmwa4LY7qFt2=QwEVQ@mail.gmail.com>
In-Reply-To: <CAGb2v673PM_3QazNWBKYd=4pumyyyE3XFmwa4LY7qFt2=QwEVQ@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 12 Jan 2020 02:08:42 +0800
Message-ID: <CAEExFWtaeiX0bq6VO5294w8vCtnnNDDB0HA_nvR19adg=KFANQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: sun8i: Add hwmon support
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Maxime Ripard <mripard@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 7, 2020 at 11:15 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Tue, Jan 7, 2020 at 12:14 AM Frank Lee <tiny.windzz@gmail.com> wrote:
> >
> > HI Chen-Yu.
> >
> > On Mon, Jan 6, 2020 at 12:32 PM Chen-Yu Tsai <wens@csie.org> wrote:
> > >
> > > On Sun, Dec 29, 2019 at 1:19 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
> > > >
> > > > Expose sun8i thermal as a HWMON device.
> > > >
> > > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > > ---
> > > >  drivers/thermal/sun8i_thermal.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> > > > index 23a5f4aa4be4..619e75cb41b0 100644
> > > > --- a/drivers/thermal/sun8i_thermal.c
> > > > +++ b/drivers/thermal/sun8i_thermal.c
> > > > @@ -20,6 +20,8 @@
> > > >  #include <linux/slab.h>
> > > >  #include <linux/thermal.h>
> > > >
> > > > +#include "thermal_hwmon.h"
> > > > +
> > > >  #define MAX_SENSOR_NUM 4
> > > >
> > > >  #define FT_TEMP_MASK                           GENMASK(11, 0)
> > > > @@ -477,6 +479,10 @@ static int sun8i_ths_register(struct ths_device *tmdev)
> > > >                                                              &ths_ops);
> > > >                 if (IS_ERR(tmdev->sensor[i].tzd))
> > > >                         return PTR_ERR(tmdev->sensor[i].tzd);
> > > > +
> > > > +               if (devm_thermal_add_hwmon_sysfs(tmdev->sensor[i].tzd))
> > > > +                       dev_warn(tmdev->dev,
> > > > +                                "Failed to add hwmon sysfs attributes\n");
> > >
> > > Maybe you want a hard failure instead?
> >
> > I don't quite understand what you mean.
> > What do you think should be done?
>
> Return an error instead of just printing a warning.

Sometimes, even if hwmon fails to add, it can still work as a thermal driver.
At this time, I don't really want to interrupt the registration of the
thermal driver.

Anyone else's opinion here?

Yours,
Ynagtao

>
> ChenYu
>
> > MBR,
> > Yangtao
> >
> > >
> > > ChenYu
> > >
> > > >         }
> > > >
> > > >         return 0;
> > > > --
> > > > 2.17.1
> > > >
