Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E61AED988D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 19:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390376AbfJPRhy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 13:37:54 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:36874 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388899AbfJPRhy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 13:37:54 -0400
Received: by mail-vk1-f194.google.com with SMTP id v78so5372007vke.4
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 10:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lw499SE/B/hjFaUHPEW33doDXG49HvU0MA8Y3SKqLDQ=;
        b=f+NsON8MCU924pXongPNuXmBEB+tRUxv8lgRxVAdhnNLEJVRp7UCCf5eXF8S3+Jrv0
         dMJ/A4WL5ekhgXqrwNh3JXbbdm37/j/gxFi9g7iMj4lgZVQ2MlzujxSSg5F0Tjq/3bP4
         jo5XAkwASSBxntr4ggp89/QacdqSgXtm3iaDFhjQd2xl12cf0X/naXACfh4suysLM3QR
         85E+4SJK685B6JJMmkb6ogPcLCp9rnNvv0eYDnHbKWjRfoI7O2zWDLRDee/w4oAEVtES
         RuapFXWoZ/y6YOT0yNpmVMb+ala/CytuzD350PcwFmlFdGInByfCdnYVpPUS0waptOtT
         WeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lw499SE/B/hjFaUHPEW33doDXG49HvU0MA8Y3SKqLDQ=;
        b=fBhHxjDynzJW1+siqTZSZNjtU3zAUz1i+MAwZPIhk/705wHRawffXDDJq4Eidf1+1Y
         dNAcWNi08ecB4VMpstpny1wcENSzHHOgHkRRvqdmWXS0mPwipBT2k2NhLRzZqMGvqoDb
         CxmKXVaKROvez+fqJnhS623GJlr3d5nBCa8JQLbeWH8xHacrUFfoaeuQYsfWXMKKI3XW
         aCm3jk27sn4FMOr8U4Q+KYtwK3K2K+w9RbDBorPLoMas81Lyu5K70SAPPG3uZUf07n3H
         jBlQ15KTNez71JTpBzKzirpYnbW4nQTYtnYZjr6HkbYl7Hk/IugQODp7bn1N4eRk4oWq
         qHYg==
X-Gm-Message-State: APjAAAVRAp6qUIIA6vl3eD1udZT+hmaG5REjGiY8h93rSURG/1sqLrlq
        y7mwuPqPe4OK37LXhCJfYGGFlu6rDZ6mjqgeXSqBs+J0TWPS0w==
X-Google-Smtp-Source: APXvYqw+6T+5LMBGMuiz84tkGGsDm2TNA6txkwNEVh5y/8wzUeCrXqRK3UwmkJL5VwwCAAsk+CEkMYOUa6VlV/pR2d8=
X-Received: by 2002:a1f:2e0a:: with SMTP id u10mr12656927vku.79.1571246166944;
 Wed, 16 Oct 2019 10:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191015061349.141448-1-wvw@google.com> <CAHLCerNffKDgJKqaVTH3Kp_QfBLtm2M4H80xFDy=2fGXTVQR+w@mail.gmail.com>
In-Reply-To: <CAHLCerNffKDgJKqaVTH3Kp_QfBLtm2M4H80xFDy=2fGXTVQR+w@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 16 Oct 2019 22:45:55 +0530
Message-ID: <CAHLCerN0CWOox-_=ywVO40R9LCahBRoU6Myg3Ca3p_TkZyJAMw@mail.gmail.com>
Subject: Re: [PATCH] thermal: create softlink by name for thermal_zone and cooling_device
To:     Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 16, 2019 at 10:20 PM Amit Kucheria
<amit.kucheria@verdurent.com> wrote:
>
> On Tue, Oct 15, 2019 at 11:43 AM Wei Wang <wvw@google.com> wrote:
> >
> > The paths thermal_zone%d and cooling_device%d are not intuitive and the
> > numbers are subject to change due to device tree change. This usually
> > leads to tree traversal in userspace code.
> > The patch creates `tz-by-name' and `cdev-by-name' for thermal zone and
> > cooling_device respectively.
>
> I like this.
>
> > Signed-off-by: Wei Wang <wvw@google.com>
> > ---
> >  drivers/thermal/thermal_core.c | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > index d4481cc8958f..0ff8fb1d7b0a 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -22,6 +22,7 @@
> >  #include <net/netlink.h>
> >  #include <net/genetlink.h>
> >  #include <linux/suspend.h>
> > +#include <linux/kobject.h>
> >
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/thermal.h>
> > @@ -46,6 +47,8 @@ static DEFINE_MUTEX(poweroff_lock);
> >
> >  static atomic_t in_suspend;
> >  static bool power_off_triggered;
> > +static struct kobject *cdev_link_kobj;
> > +static struct kobject *tz_link_kobj;
> >
> >  static struct thermal_governor *def_governor;
> >
> > @@ -954,7 +957,7 @@ __thermal_cooling_device_register(struct device_node *np,
> >         struct thermal_zone_device *pos = NULL;
> >         int result;
> >
> > -       if (type && strlen(type) >= THERMAL_NAME_LENGTH)
> > +       if (!type || !type[0] || strlen(type) >= THERMAL_NAME_LENGTH)
> >                 return ERR_PTR(-EINVAL);
>
> This should be a separate fix, if needed.
>
> >         if (!ops || !ops->get_max_state || !ops->get_cur_state ||
> > @@ -989,9 +992,15 @@ __thermal_cooling_device_register(struct device_node *np,
> >                 return ERR_PTR(result);
> >         }
> >
> > -       /* Add 'this' new cdev to the global cdev list */
> > +       /* Add 'this' new cdev to the global cdev list and create link*/
> >         mutex_lock(&thermal_list_lock);
> >         list_add(&cdev->node, &thermal_cdev_list);
> > +       if (!cdev_link_kobj)
> > +               cdev_link_kobj = kobject_create_and_add("cdev-by-name",
> > +                                               cdev->device.kobj.parent);
> > +       if (!cdev_link_kobj || sysfs_create_link(cdev_link_kobj,
> > +                                               &cdev->device.kobj, cdev->type))
> > +               dev_err(&cdev->device, "Failed to create cdev-by-name link\n");
>
> Any reason not to use the following form instead? It seems easier to read.
>
> if (!cdev_link_kobj) {
>                cdev_link_kobj = kobject_create_and_add("cdev-by-name",
>                                                cdev->device.kobj.parent);
>               ret = sysfs_create_link(cdev_link_kobj,
>                                               &cdev->device.kobj, cdev->type))
>               if (ret)
>                        dev_err(&cdev->device, "Failed to create
> cdev-by-name link\n");
> }

I can now see why you had to do that - none of the other links would
get created after the first one.

Perhaps create the directories in the __init functions and only create
the links here?


> >         mutex_unlock(&thermal_list_lock);
> >
> >         /* Update binding information for 'this' new cdev */
> > @@ -1157,6 +1166,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
> >                         }
> >                 }
> >         }
> > +       if (cdev_link_kobj)
> > +               sysfs_remove_link(cdev_link_kobj, cdev->type);
> >
> >         mutex_unlock(&thermal_list_lock);
> >
> > @@ -1340,6 +1351,12 @@ thermal_zone_device_register(const char *type, int trips, int mask,
> >
> >         mutex_lock(&thermal_list_lock);
> >         list_add_tail(&tz->node, &thermal_tz_list);
> > +       if (!tz_link_kobj)
> > +               tz_link_kobj = kobject_create_and_add("tz-by-name",
> > +                                               tz->device.kobj.parent);
> > +       if (!tz_link_kobj || sysfs_create_link(tz_link_kobj,
> > +                                               &tz->device.kobj, tz->type))
> > +               dev_err(&tz->device, "Failed to create tz-by-name link\n");
>
> Same as above.
>
> >         mutex_unlock(&thermal_list_lock);
> >
> >         /* Bind cooling devices for this zone */
> > @@ -1411,6 +1428,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
> >                         }
> >                 }
> >         }
> > +       if (tz_link_kobj)
> > +               sysfs_remove_link(tz_link_kobj, tz->type);
> >
> >         mutex_unlock(&thermal_list_lock);
> >
> > --
> > 2.23.0.700.g56cf767bdb-goog
> >
