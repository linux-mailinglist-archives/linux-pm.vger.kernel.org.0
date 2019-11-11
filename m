Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63416F6E11
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 06:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKKF0s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 00:26:48 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:34366 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfKKF0s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 00:26:48 -0500
Received: by mail-vk1-f195.google.com with SMTP id t184so2879126vka.1
        for <linux-pm@vger.kernel.org>; Sun, 10 Nov 2019 21:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DXwG7Htt8xNu0lrk1CpbOO5TmV59fWwZQbJzjoVIM78=;
        b=h8lrbRMrrhVlG6DWJGLEMzVAA3RZl2r6zZCSH8Buo45xvL6NfgvfUszEX1y9lILLGN
         V8mlpV90yp5XtQmkx1Q9RteWm9G1IL5Fj5+d1ZiO16Dm4IQ0oi4H7iJxttg49FfFIFEu
         4o3XmqaUvlKymwS514aX4+oaXdsEuBuAnWQt3ofclnGD340pPa8BqmX0cMTcMuEtlHb/
         ZuPtFOpOJcKDMLhgLXTPCk959aHIeQWOPpNInWwdWDCijdZJGKZCZ88DhFDpFbTKBYa8
         CfBi0wPSBklojiNhead9uXF5ha7uIcwFiQozmx5fsG2wgSyNfyipe2u0og2QTv4B9+tZ
         pW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DXwG7Htt8xNu0lrk1CpbOO5TmV59fWwZQbJzjoVIM78=;
        b=MNuxhVSdu4MaGPWMZ/6IwBQQRrKFUBQvVZEhTy76kR1m2xT+yMgj0YZuuv2rZ2PIuS
         8pLvoIU47fm+YsNgyzP5RhjQtL0CHFdx51CM/z7zHsTJXX9XjKJdBdn07zl+L5QFdeTd
         I+CRPVegQKFnSxnjEXPgzSHtwcbuIa8V7LZBsf9kE9a6WJoPfmqm61oMy7hM6as5KFya
         clxj/SvGZvkUAV7qkmdGUlA/clukeewbJVH1kTDFAJookLJZtI6zkNguKoZUvKxO8KNe
         jz3uQWubFUU/LYTFTP0gP4oNWgJzMpksW0beBTc64mbIHJVKwdkdtq8jXYMH4HFsZ0q7
         v5tg==
X-Gm-Message-State: APjAAAXIxUTOCDLWbBc1gtZjVpWRBFnKUIB9I9ZwlZD5zICQbed+l7IP
        HaoeHD8OLEnwON37fcfE8Wy/eh6TJpnGaysdzqCc9w==
X-Google-Smtp-Source: APXvYqyvRzUFxvAr+4U1TJibsN+f5gff9mvIlEY8CgnrfvYIwjzf6AmIsl3DKsTnNOun/OG9RsaKkKkkUDn2wYlAr7w=
X-Received: by 2002:a1f:7387:: with SMTP id o129mr16986118vkc.73.1573450005202;
 Sun, 10 Nov 2019 21:26:45 -0800 (PST)
MIME-Version: 1.0
References: <20191015061349.141448-1-wvw@google.com> <CAHLCerNffKDgJKqaVTH3Kp_QfBLtm2M4H80xFDy=2fGXTVQR+w@mail.gmail.com>
 <CAHLCerN0CWOox-_=ywVO40R9LCahBRoU6Myg3Ca3p_TkZyJAMw@mail.gmail.com> <CAGXk5yp4uSCESvve5j_LbCr7b_55DqBagjNr_Dsdi=HppSpBPg@mail.gmail.com>
In-Reply-To: <CAGXk5yp4uSCESvve5j_LbCr7b_55DqBagjNr_Dsdi=HppSpBPg@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Mon, 11 Nov 2019 10:56:34 +0530
Message-ID: <CAHLCerN4ymf7LOGQPRLuAwirwCUaQGynrnUMfgU6+frDswey5A@mail.gmail.com>
Subject: Re: [PATCH] thermal: create softlink by name for thermal_zone and cooling_device
To:     Wei Wang <wvw@google.com>
Cc:     Wei Wang <wei.vince.wang@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 17, 2019 at 3:04 AM Wei Wang <wvw@google.com> wrote:
>
> On Wed, Oct 16, 2019 at 10:16 AM Amit Kucheria
> <amit.kucheria@verdurent.com> wrote:
> >
> > On Wed, Oct 16, 2019 at 10:20 PM Amit Kucheria
> > <amit.kucheria@verdurent.com> wrote:
> > >
> > > On Tue, Oct 15, 2019 at 11:43 AM Wei Wang <wvw@google.com> wrote:
> > > >
> > > > The paths thermal_zone%d and cooling_device%d are not intuitive and the
> > > > numbers are subject to change due to device tree change. This usually
> > > > leads to tree traversal in userspace code.
> > > > The patch creates `tz-by-name' and `cdev-by-name' for thermal zone and
> > > > cooling_device respectively.
> > >
> > > I like this.
> > >
> > > > Signed-off-by: Wei Wang <wvw@google.com>
> > > > ---
> > > >  drivers/thermal/thermal_core.c | 23 +++++++++++++++++++++--
> > > >  1 file changed, 21 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > > > index d4481cc8958f..0ff8fb1d7b0a 100644
> > > > --- a/drivers/thermal/thermal_core.c
> > > > +++ b/drivers/thermal/thermal_core.c
> > > > @@ -22,6 +22,7 @@
> > > >  #include <net/netlink.h>
> > > >  #include <net/genetlink.h>
> > > >  #include <linux/suspend.h>
> > > > +#include <linux/kobject.h>
> > > >
> > > >  #define CREATE_TRACE_POINTS
> > > >  #include <trace/events/thermal.h>
> > > > @@ -46,6 +47,8 @@ static DEFINE_MUTEX(poweroff_lock);
> > > >
> > > >  static atomic_t in_suspend;
> > > >  static bool power_off_triggered;
> > > > +static struct kobject *cdev_link_kobj;
> > > > +static struct kobject *tz_link_kobj;
> > > >
> > > >  static struct thermal_governor *def_governor;
> > > >
> > > > @@ -954,7 +957,7 @@ __thermal_cooling_device_register(struct device_node *np,
> > > >         struct thermal_zone_device *pos = NULL;
> > > >         int result;
> > > >
> > > > -       if (type && strlen(type) >= THERMAL_NAME_LENGTH)
> > > > +       if (!type || !type[0] || strlen(type) >= THERMAL_NAME_LENGTH)
> > > >                 return ERR_PTR(-EINVAL);
> > >
> > > This should be a separate fix, if needed.
> Agree, but the link now requires that "" as invalid _type_.

I'm not sure I understand. What does this change have to do with
adding symlinks below?

> > >
> > > >         if (!ops || !ops->get_max_state || !ops->get_cur_state ||
> > > > @@ -989,9 +992,15 @@ __thermal_cooling_device_register(struct device_node *np,
> > > >                 return ERR_PTR(result);
> > > >         }
> > > >
> > > > -       /* Add 'this' new cdev to the global cdev list */
> > > > +       /* Add 'this' new cdev to the global cdev list and create link*/
> > > >         mutex_lock(&thermal_list_lock);
> > > >         list_add(&cdev->node, &thermal_cdev_list);
> > > > +       if (!cdev_link_kobj)
> > > > +               cdev_link_kobj = kobject_create_and_add("cdev-by-name",
> > > > +                                               cdev->device.kobj.parent);
> > > > +       if (!cdev_link_kobj || sysfs_create_link(cdev_link_kobj,
> > > > +                                               &cdev->device.kobj, cdev->type))
> > > > +               dev_err(&cdev->device, "Failed to create cdev-by-name link\n");
> > >
> > > Any reason not to use the following form instead? It seems easier to read.
> > >
> > > if (!cdev_link_kobj) {
> > >                cdev_link_kobj = kobject_create_and_add("cdev-by-name",
> > >                                                cdev->device.kobj.parent);
> > >               ret = sysfs_create_link(cdev_link_kobj,
> > >                                               &cdev->device.kobj, cdev->type))
> > >               if (ret)
> > >                        dev_err(&cdev->device, "Failed to create
> > > cdev-by-name link\n");
> > > }
> >
> > I can now see why you had to do that - none of the other links would
> > get created after the first one.
> >
> > Perhaps create the directories in the __init functions and only create
> > the links here?
> >
> AFAICT, this is no such API except the private get_device_parent()
> under driver/base/. Also the lazy initialization makes sense in such
> case when there is no thermal device attached. Looks like the class
> dir is also lazy-initialized when first device registered
> https://elixir.bootlin.com/linux/v5.3.5/source/drivers/base/core.c#L1790.

OK.

> >
> > > >         mutex_unlock(&thermal_list_lock);
> > > >
> > > >         /* Update binding information for 'this' new cdev */
> > > > @@ -1157,6 +1166,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
> > > >                         }
> > > >                 }
> > > >         }
> > > > +       if (cdev_link_kobj)
> > > > +               sysfs_remove_link(cdev_link_kobj, cdev->type);
> > > >
> > > >         mutex_unlock(&thermal_list_lock);
> > > >
> > > > @@ -1340,6 +1351,12 @@ thermal_zone_device_register(const char *type, int trips, int mask,
> > > >
> > > >         mutex_lock(&thermal_list_lock);
> > > >         list_add_tail(&tz->node, &thermal_tz_list);
> > > > +       if (!tz_link_kobj)
> > > > +               tz_link_kobj = kobject_create_and_add("tz-by-name",
> > > > +                                               tz->device.kobj.parent);
> > > > +       if (!tz_link_kobj || sysfs_create_link(tz_link_kobj,
> > > > +                                               &tz->device.kobj, tz->type))
> > > > +               dev_err(&tz->device, "Failed to create tz-by-name link\n");
> > >
> > > Same as above.
> > >
> > > >         mutex_unlock(&thermal_list_lock);
> > > >
> > > >         /* Bind cooling devices for this zone */
> > > > @@ -1411,6 +1428,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
> > > >                         }
> > > >                 }
> > > >         }
> > > > +       if (tz_link_kobj)
> > > > +               sysfs_remove_link(tz_link_kobj, tz->type);
> > > >
> > > >         mutex_unlock(&thermal_list_lock);
> > > >
> > > > --
> > > > 2.23.0.700.g56cf767bdb-goog
> > > >
