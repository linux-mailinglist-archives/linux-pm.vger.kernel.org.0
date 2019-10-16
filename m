Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E447D9D87
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 23:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388562AbfJPVej (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 17:34:39 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38585 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbfJPVej (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 17:34:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id l21so22500304edr.5
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 14:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bfOGDWzikmOJBzCAtkiIxcv6c5ZcmR8y/XNQVA8Amkg=;
        b=uugI1aeLVNLvw9BnJDgl7fGVUgsjPSAHAD05XlZDH53TNa5o1WLJLMwF9QnMGqfsqN
         Z1sU+jB2LvS90d2Ttm3twrk9nTXfFIjwIhQyY6raJz6L+gTVFU+msbiJZKbe5p8TNkop
         cxD/oghyLeUDCnywTQqxnnvAzh1DF6BbKdwKmEKf+WNMIpliuRYXtdm7CZ3RH0akodxY
         DMQowAHXKiyEhVHljLApsZ4r7F584fCkLA89gDE9lF4sa/R0PNjRre5hKu45/KqXhWLf
         KJorWKTd7htX4tyX+XZpPtXZP94LMw1iwl0UxGnv0GrQcdJ9pwFr/crSIu8LqOT5JhUh
         oGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bfOGDWzikmOJBzCAtkiIxcv6c5ZcmR8y/XNQVA8Amkg=;
        b=Riamu4IOT9e3W/8XV+rGtYuR4p9Ak5ZfDZYqsgWoCZ1cwW2VQP5NpNN1JV41s7FzXD
         0NA+ipGV+ko0nkEztVd9l7122ACDKdg9fk8Hy8Z61wrvvGuwKyDldPrE1CBweXFWbMCw
         CtHjhi7JbjTy/prH4FFGlhECarMxHOE/Dc22j96Dw20TTu1fhQF4LDjW1V3QKSAAmPb9
         A/KftlLP7tr7VUVQMRsblQwYuX/5DAd+7nbk3yZlaXrk/WpOU2zjjsFUNev/vlXqPAiu
         Y8mwmoGBfbVb3ArmcBUVLnEhF2ZKLOJZCAmz1yHmk0zCHTnaulBu3ktbDNLOtUSQElE7
         vEfQ==
X-Gm-Message-State: APjAAAVnxmVimspEGlU6WfEWM4qLgfclpcKfwIT4le6tU0wKOU7Bl/Y9
        6cmIRrsDW7vaXBr+LrMlm7aILJTS9h9wx6T4bk5Xnw==
X-Google-Smtp-Source: APXvYqykXvCe/qzLrvXmUVqHJd7c21Uxz+I173bwkGJVqK8TynW1PvqVuHn1hxe8UIwGRX9p0rE7suixUdIxbdcbMGY=
X-Received: by 2002:a17:906:2961:: with SMTP id x1mr423990ejd.91.1571261676139;
 Wed, 16 Oct 2019 14:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191015061349.141448-1-wvw@google.com> <CAHLCerNffKDgJKqaVTH3Kp_QfBLtm2M4H80xFDy=2fGXTVQR+w@mail.gmail.com>
 <CAHLCerN0CWOox-_=ywVO40R9LCahBRoU6Myg3Ca3p_TkZyJAMw@mail.gmail.com>
In-Reply-To: <CAHLCerN0CWOox-_=ywVO40R9LCahBRoU6Myg3Ca3p_TkZyJAMw@mail.gmail.com>
From:   Wei Wang <wvw@google.com>
Date:   Wed, 16 Oct 2019 14:34:25 -0700
Message-ID: <CAGXk5yp4uSCESvve5j_LbCr7b_55DqBagjNr_Dsdi=HppSpBPg@mail.gmail.com>
Subject: Re: [PATCH] thermal: create softlink by name for thermal_zone and cooling_device
To:     Amit Kucheria <amit.kucheria@verdurent.com>
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

On Wed, Oct 16, 2019 at 10:16 AM Amit Kucheria
<amit.kucheria@verdurent.com> wrote:
>
> On Wed, Oct 16, 2019 at 10:20 PM Amit Kucheria
> <amit.kucheria@verdurent.com> wrote:
> >
> > On Tue, Oct 15, 2019 at 11:43 AM Wei Wang <wvw@google.com> wrote:
> > >
> > > The paths thermal_zone%d and cooling_device%d are not intuitive and the
> > > numbers are subject to change due to device tree change. This usually
> > > leads to tree traversal in userspace code.
> > > The patch creates `tz-by-name' and `cdev-by-name' for thermal zone and
> > > cooling_device respectively.
> >
> > I like this.
> >
> > > Signed-off-by: Wei Wang <wvw@google.com>
> > > ---
> > >  drivers/thermal/thermal_core.c | 23 +++++++++++++++++++++--
> > >  1 file changed, 21 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > > index d4481cc8958f..0ff8fb1d7b0a 100644
> > > --- a/drivers/thermal/thermal_core.c
> > > +++ b/drivers/thermal/thermal_core.c
> > > @@ -22,6 +22,7 @@
> > >  #include <net/netlink.h>
> > >  #include <net/genetlink.h>
> > >  #include <linux/suspend.h>
> > > +#include <linux/kobject.h>
> > >
> > >  #define CREATE_TRACE_POINTS
> > >  #include <trace/events/thermal.h>
> > > @@ -46,6 +47,8 @@ static DEFINE_MUTEX(poweroff_lock);
> > >
> > >  static atomic_t in_suspend;
> > >  static bool power_off_triggered;
> > > +static struct kobject *cdev_link_kobj;
> > > +static struct kobject *tz_link_kobj;
> > >
> > >  static struct thermal_governor *def_governor;
> > >
> > > @@ -954,7 +957,7 @@ __thermal_cooling_device_register(struct device_node *np,
> > >         struct thermal_zone_device *pos = NULL;
> > >         int result;
> > >
> > > -       if (type && strlen(type) >= THERMAL_NAME_LENGTH)
> > > +       if (!type || !type[0] || strlen(type) >= THERMAL_NAME_LENGTH)
> > >                 return ERR_PTR(-EINVAL);
> >
> > This should be a separate fix, if needed.
Agree, but the link now requires that "" as invalid _type_.


> >
> > >         if (!ops || !ops->get_max_state || !ops->get_cur_state ||
> > > @@ -989,9 +992,15 @@ __thermal_cooling_device_register(struct device_node *np,
> > >                 return ERR_PTR(result);
> > >         }
> > >
> > > -       /* Add 'this' new cdev to the global cdev list */
> > > +       /* Add 'this' new cdev to the global cdev list and create link*/
> > >         mutex_lock(&thermal_list_lock);
> > >         list_add(&cdev->node, &thermal_cdev_list);
> > > +       if (!cdev_link_kobj)
> > > +               cdev_link_kobj = kobject_create_and_add("cdev-by-name",
> > > +                                               cdev->device.kobj.parent);
> > > +       if (!cdev_link_kobj || sysfs_create_link(cdev_link_kobj,
> > > +                                               &cdev->device.kobj, cdev->type))
> > > +               dev_err(&cdev->device, "Failed to create cdev-by-name link\n");
> >
> > Any reason not to use the following form instead? It seems easier to read.
> >
> > if (!cdev_link_kobj) {
> >                cdev_link_kobj = kobject_create_and_add("cdev-by-name",
> >                                                cdev->device.kobj.parent);
> >               ret = sysfs_create_link(cdev_link_kobj,
> >                                               &cdev->device.kobj, cdev->type))
> >               if (ret)
> >                        dev_err(&cdev->device, "Failed to create
> > cdev-by-name link\n");
> > }
>
> I can now see why you had to do that - none of the other links would
> get created after the first one.
>
> Perhaps create the directories in the __init functions and only create
> the links here?
>
AFAICT, this is no such API except the private get_device_parent()
under driver/base/. Also the lazy initialization makes sense in such
case when there is no thermal device attached. Looks like the class
dir is also lazy-initialized when first device registered
https://elixir.bootlin.com/linux/v5.3.5/source/drivers/base/core.c#L1790.

>
> > >         mutex_unlock(&thermal_list_lock);
> > >
> > >         /* Update binding information for 'this' new cdev */
> > > @@ -1157,6 +1166,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
> > >                         }
> > >                 }
> > >         }
> > > +       if (cdev_link_kobj)
> > > +               sysfs_remove_link(cdev_link_kobj, cdev->type);
> > >
> > >         mutex_unlock(&thermal_list_lock);
> > >
> > > @@ -1340,6 +1351,12 @@ thermal_zone_device_register(const char *type, int trips, int mask,
> > >
> > >         mutex_lock(&thermal_list_lock);
> > >         list_add_tail(&tz->node, &thermal_tz_list);
> > > +       if (!tz_link_kobj)
> > > +               tz_link_kobj = kobject_create_and_add("tz-by-name",
> > > +                                               tz->device.kobj.parent);
> > > +       if (!tz_link_kobj || sysfs_create_link(tz_link_kobj,
> > > +                                               &tz->device.kobj, tz->type))
> > > +               dev_err(&tz->device, "Failed to create tz-by-name link\n");
> >
> > Same as above.
> >
> > >         mutex_unlock(&thermal_list_lock);
> > >
> > >         /* Bind cooling devices for this zone */
> > > @@ -1411,6 +1428,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
> > >                         }
> > >                 }
> > >         }
> > > +       if (tz_link_kobj)
> > > +               sysfs_remove_link(tz_link_kobj, tz->type);
> > >
> > >         mutex_unlock(&thermal_list_lock);
> > >
> > > --
> > > 2.23.0.700.g56cf767bdb-goog
> > >
