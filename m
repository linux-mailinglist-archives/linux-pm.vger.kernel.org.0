Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 032BC113754
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 22:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfLDV64 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 16:58:56 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36080 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfLDV6z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 16:58:55 -0500
Received: by mail-ed1-f68.google.com with SMTP id j17so835578edp.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Dec 2019 13:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=834X6enFsR+krNoNr0e4709pAh8Q2+irN0s0KLWbKdY=;
        b=sPM/fSNUtqQcSP7CWF7NsVFpZb0O/fwkH6QMYfP4/5MBhsR1iYWl7ktf1NtM1E9wus
         sgx86dcRhjC3zXVM4P4m3LrN9TwYy0JZ5xZA8r1jifNGH2qJXysVovAqaHvVwl9/xxHY
         nZ1wQNfZghdYIqvM8jJS8ijSTFdYzX9YJMfqQRCIm/rphFi9dgRRt7PNul+4OUH1G8By
         ElWJ9rMcl4rIYxWVPNcDMzsJkb0kJS6CRYBZaud39U/idiWl1Tnxyg4H5J/bgS7aG2bt
         7UbEIt45Yc53CcCqFvTS37y2PEJ5imCCpg8K/92zuB4ZhjoLhyci3W+y/ai/c3ffwjHl
         9uOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=834X6enFsR+krNoNr0e4709pAh8Q2+irN0s0KLWbKdY=;
        b=JeipZhicfWJMos5NxOaWI1D7OR5XhEnZtrC98ALMdRUP9iXAOz/Tdi1/3srSxYfRIj
         J6j8y1yd11l1Fvp3jiopwXf2HXupV+gdrXnxoW5yPyuIucseOTi/tmaCaTl5aOh1zb5p
         lf3ieDyg+BkiQP8A+F7Jb1VLZJGuh6cV4DrWt30g1OjY6csIHyyOj8q4zIA68WS1SyDA
         fky7kWhmTEevYUeInqIQVVZnnepVplKUzPYaPpiQGyMo5v3QamWkWT/5nSl8on356Ap6
         jnWypW7pCVUpX0eNhjH5zVcrSIHD2LApiYt49aJA37FJ0wLAhxSZM0pMFq3kw/HMPTax
         3URg==
X-Gm-Message-State: APjAAAWT6Irnv+x+H0aoqLA2QraxM40fL+W/9nTVlkY63N8sxAGFu4yP
        EMSaabpebgCk4pu/ELzMiUphdy0ibrudG4VU4u7TTg==
X-Google-Smtp-Source: APXvYqy/Ks8cCcfmSZFk7CgBt9JjE5OX2CyjdQWADUUGHLoLTj7qI2gKdo0JtHG5d1MJruFqD+aZgNinpBN5Aq0pgbw=
X-Received: by 2002:a50:8d52:: with SMTP id t18mr6921117edt.26.1575496732591;
 Wed, 04 Dec 2019 13:58:52 -0800 (PST)
MIME-Version: 1.0
References: <20191015061349.141448-1-wvw@google.com> <CAHLCerNffKDgJKqaVTH3Kp_QfBLtm2M4H80xFDy=2fGXTVQR+w@mail.gmail.com>
 <CAHLCerN0CWOox-_=ywVO40R9LCahBRoU6Myg3Ca3p_TkZyJAMw@mail.gmail.com>
 <CAGXk5yp4uSCESvve5j_LbCr7b_55DqBagjNr_Dsdi=HppSpBPg@mail.gmail.com>
 <CAHLCerN4ymf7LOGQPRLuAwirwCUaQGynrnUMfgU6+frDswey5A@mail.gmail.com>
 <CAGXk5ypP0qSm-GMbHJy+hQtYN1hw6Ow6XgeO9JDni0bD1bFSVg@mail.gmail.com> <CAHLCerOD2wOJq7QNGBOcLvkMz4wvc1+6Hk2+ZD__NFged3tLcw@mail.gmail.com>
In-Reply-To: <CAHLCerOD2wOJq7QNGBOcLvkMz4wvc1+6Hk2+ZD__NFged3tLcw@mail.gmail.com>
From:   Wei Wang <wvw@google.com>
Date:   Wed, 4 Dec 2019 13:58:41 -0800
Message-ID: <CAGXk5ypZnh3ndf6ZCPeyvyOTuPgBYF_uPFm8pn1JKxBjqZFgGA@mail.gmail.com>
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

On Wed, Dec 4, 2019 at 4:45 AM Amit Kucheria
<amit.kucheria@verdurent.com> wrote:
>
> On Mon, Nov 11, 2019 at 11:22 PM Wei Wang <wvw@google.com> wrote:
> >
> > On Sun, Nov 10, 2019 at 9:26 PM Amit Kucheria
> > <amit.kucheria@verdurent.com> wrote:
> > >
> > > On Thu, Oct 17, 2019 at 3:04 AM Wei Wang <wvw@google.com> wrote:
> > > >
> > > > On Wed, Oct 16, 2019 at 10:16 AM Amit Kucheria
> > > > <amit.kucheria@verdurent.com> wrote:
> > > > >
> > > > > On Wed, Oct 16, 2019 at 10:20 PM Amit Kucheria
> > > > > <amit.kucheria@verdurent.com> wrote:
> > > > > >
> > > > > > On Tue, Oct 15, 2019 at 11:43 AM Wei Wang <wvw@google.com> wrote:
> > > > > > >
> > > > > > > The paths thermal_zone%d and cooling_device%d are not intuitive and the
> > > > > > > numbers are subject to change due to device tree change. This usually
> > > > > > > leads to tree traversal in userspace code.
> > > > > > > The patch creates `tz-by-name' and `cdev-by-name' for thermal zone and
> > > > > > > cooling_device respectively.
> > > > > >
> > > > > > I like this.
> > > > > >
> > > > > > > Signed-off-by: Wei Wang <wvw@google.com>
> > > > > > > ---
> > > > > > >  drivers/thermal/thermal_core.c | 23 +++++++++++++++++++++--
> > > > > > >  1 file changed, 21 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > > > > > > index d4481cc8958f..0ff8fb1d7b0a 100644
> > > > > > > --- a/drivers/thermal/thermal_core.c
> > > > > > > +++ b/drivers/thermal/thermal_core.c
> > > > > > > @@ -22,6 +22,7 @@
> > > > > > >  #include <net/netlink.h>
> > > > > > >  #include <net/genetlink.h>
> > > > > > >  #include <linux/suspend.h>
> > > > > > > +#include <linux/kobject.h>
> > > > > > >
> > > > > > >  #define CREATE_TRACE_POINTS
> > > > > > >  #include <trace/events/thermal.h>
> > > > > > > @@ -46,6 +47,8 @@ static DEFINE_MUTEX(poweroff_lock);
> > > > > > >
> > > > > > >  static atomic_t in_suspend;
> > > > > > >  static bool power_off_triggered;
> > > > > > > +static struct kobject *cdev_link_kobj;
> > > > > > > +static struct kobject *tz_link_kobj;
> > > > > > >
> > > > > > >  static struct thermal_governor *def_governor;
> > > > > > >
> > > > > > > @@ -954,7 +957,7 @@ __thermal_cooling_device_register(struct device_node *np,
> > > > > > >         struct thermal_zone_device *pos = NULL;
> > > > > > >         int result;
> > > > > > >
> > > > > > > -       if (type && strlen(type) >= THERMAL_NAME_LENGTH)
> > > > > > > +       if (!type || !type[0] || strlen(type) >= THERMAL_NAME_LENGTH)
> > > > > > >                 return ERR_PTR(-EINVAL);
> > > > > >
> > > > > > This should be a separate fix, if needed.
> > > > Agree, but the link now requires that "" as invalid _type_.
> > >
> > > I'm not sure I understand. What does this change have to do with
> > > adding symlinks below?
> > >
> >
> > cdev->type will be used later in sysfs_create_link and adding "" as
> > symlink is kind of bad practise AIUI.
> >
>
> Perhaps I'm being dense here, in which case my apologies.
>
> But what stops us from splitting the patch into two?
> 1. Make type == "" as invalid by using your change above and fixing up
> the strlcpy(cdev->type....) further down.
> 2. Create the actual symlinks in a separate patch.
>
> Regards,
> Amit
>
Updated with v2, thanks.

>
> > > > > >
> > > > > > >         if (!ops || !ops->get_max_state || !ops->get_cur_state ||
> > > > > > > @@ -989,9 +992,15 @@ __thermal_cooling_device_register(struct device_node *np,
> > > > > > >                 return ERR_PTR(result);
> > > > > > >         }
> > > > > > >
> > > > > > > -       /* Add 'this' new cdev to the global cdev list */
> > > > > > > +       /* Add 'this' new cdev to the global cdev list and create link*/
> > > > > > >         mutex_lock(&thermal_list_lock);
> > > > > > >         list_add(&cdev->node, &thermal_cdev_list);
> > > > > > > +       if (!cdev_link_kobj)
> > > > > > > +               cdev_link_kobj = kobject_create_and_add("cdev-by-name",
> > > > > > > +                                               cdev->device.kobj.parent);
> > > > > > > +       if (!cdev_link_kobj || sysfs_create_link(cdev_link_kobj,
> > > > > > > +                                               &cdev->device.kobj, cdev->type))
> > > > > > > +               dev_err(&cdev->device, "Failed to create cdev-by-name link\n");
> > > > > >
> > > > > > Any reason not to use the following form instead? It seems easier to read.
> > > > > >
> > > > > > if (!cdev_link_kobj) {
> > > > > >                cdev_link_kobj = kobject_create_and_add("cdev-by-name",
> > > > > >                                                cdev->device.kobj.parent);
> > > > > >               ret = sysfs_create_link(cdev_link_kobj,
> > > > > >                                               &cdev->device.kobj, cdev->type))
> > > > > >               if (ret)
> > > > > >                        dev_err(&cdev->device, "Failed to create
> > > > > > cdev-by-name link\n");
> > > > > > }
> > > > >
> > > > > I can now see why you had to do that - none of the other links would
> > > > > get created after the first one.
> > > > >
> > > > > Perhaps create the directories in the __init functions and only create
> > > > > the links here?
> > > > >
> > > > AFAICT, this is no such API except the private get_device_parent()
> > > > under driver/base/. Also the lazy initialization makes sense in such
> > > > case when there is no thermal device attached. Looks like the class
> > > > dir is also lazy-initialized when first device registered
> > > > https://elixir.bootlin.com/linux/v5.3.5/source/drivers/base/core.c#L1790.
> > >
> > > OK.
> > >
> > > > >
> > > > > > >         mutex_unlock(&thermal_list_lock);
> > > > > > >
> > > > > > >         /* Update binding information for 'this' new cdev */
> > > > > > > @@ -1157,6 +1166,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
> > > > > > >                         }
> > > > > > >                 }
> > > > > > >         }
> > > > > > > +       if (cdev_link_kobj)
> > > > > > > +               sysfs_remove_link(cdev_link_kobj, cdev->type);
> > > > > > >
> > > > > > >         mutex_unlock(&thermal_list_lock);
> > > > > > >
> > > > > > > @@ -1340,6 +1351,12 @@ thermal_zone_device_register(const char *type, int trips, int mask,
> > > > > > >
> > > > > > >         mutex_lock(&thermal_list_lock);
> > > > > > >         list_add_tail(&tz->node, &thermal_tz_list);
> > > > > > > +       if (!tz_link_kobj)
> > > > > > > +               tz_link_kobj = kobject_create_and_add("tz-by-name",
> > > > > > > +                                               tz->device.kobj.parent);
> > > > > > > +       if (!tz_link_kobj || sysfs_create_link(tz_link_kobj,
> > > > > > > +                                               &tz->device.kobj, tz->type))
> > > > > > > +               dev_err(&tz->device, "Failed to create tz-by-name link\n");
> > > > > >
> > > > > > Same as above.
> > > > > >
> > > > > > >         mutex_unlock(&thermal_list_lock);
> > > > > > >
> > > > > > >         /* Bind cooling devices for this zone */
> > > > > > > @@ -1411,6 +1428,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
> > > > > > >                         }
> > > > > > >                 }
> > > > > > >         }
> > > > > > > +       if (tz_link_kobj)
> > > > > > > +               sysfs_remove_link(tz_link_kobj, tz->type);
> > > > > > >
> > > > > > >         mutex_unlock(&thermal_list_lock);
> > > > > > >
> > > > > > > --
> > > > > > > 2.23.0.700.g56cf767bdb-goog
> > > > > > >
