Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 529A8D97E1
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 18:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406469AbfJPQvB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 12:51:01 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43562 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406467AbfJPQvB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 12:51:01 -0400
Received: by mail-vs1-f67.google.com with SMTP id b1so16054110vsr.10
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=39+L7uTpKiUnwyMszInidREucesuvpkGs3DnCgLxrOc=;
        b=kxVEGT/otZz4heGzzrhb8yZ07E1GnHC0Eu7ysL3Bmnf+5nwTha37D1OFD3PYSgA0oi
         XUJBSw6OJm7gbKWLiXoaMPMIoiOeufjjAiEv5BCKXWUlE+6v8qkAwYZufLFX4BX1l7/5
         w+xDeefkWxcFskLw9zBbJdJzJmVb32G2d5Zc+3CAGZ0fgr459hvF83wirifXNNclh9x1
         scQPk4ZKrngge0bgXBU2sx9Lg7UhxHSuN4wc5xi4+UiLmzeHDgyehZSDhKwtdnRR3+zI
         gtEYYGAHmEJg5VYRwBSD2nfakt6EJPJudUn4iUzzqLXBzrqlFccKv07jWFH1meMwcsrV
         Al/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39+L7uTpKiUnwyMszInidREucesuvpkGs3DnCgLxrOc=;
        b=pghS6FVvf5MnEW894UAbQkStn3pLwmdrUPkjgXmm4/vd4x4DufXR0be0i6jc8vaDCC
         srGe68Rs+uhSmcC9RHKRspQ+07ybB7yvoKkB45yF84D9QMfT5RmxRFJpzJntW3hL5a+W
         xq1fGptFHzxmGbiOFxePmoa9TS+uyOtZyJCIaQpRtmt4BXSrR51/25z0kjt1CYtnxznk
         CDx99QB95TCc+nYQi06lAAy3gEarZbwjlXbBpQu+RIET9PeWvMjHU5DHnfRfTli4cRnB
         F2hYVE65DxqlNNIoenocYbt8qNzR30IZgGkArcN6i0J34nZMemys1UL2Ywa5WQL0slVc
         y2CA==
X-Gm-Message-State: APjAAAXtnYX4YoOZP+qWWwMsmjqhkET6Ecykvm740LzoM3t5crzldJQa
        RgM5D0hFypEo7f+Nhmyx55u/ch/559rF5+S4GljasQ==
X-Google-Smtp-Source: APXvYqyw4yXx24p8ogTGL5bftlhNrFh7WkWp///SDgw3PVl7BPJcIHB6ySjRkph5gstYwAdH+gBq1qw6ObNBgETE2gc=
X-Received: by 2002:a05:6102:2142:: with SMTP id h2mr23725307vsg.27.1571244659605;
 Wed, 16 Oct 2019 09:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20191015061349.141448-1-wvw@google.com>
In-Reply-To: <20191015061349.141448-1-wvw@google.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 16 Oct 2019 22:20:48 +0530
Message-ID: <CAHLCerNffKDgJKqaVTH3Kp_QfBLtm2M4H80xFDy=2fGXTVQR+w@mail.gmail.com>
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

On Tue, Oct 15, 2019 at 11:43 AM Wei Wang <wvw@google.com> wrote:
>
> The paths thermal_zone%d and cooling_device%d are not intuitive and the
> numbers are subject to change due to device tree change. This usually
> leads to tree traversal in userspace code.
> The patch creates `tz-by-name' and `cdev-by-name' for thermal zone and
> cooling_device respectively.

I like this.

> Signed-off-by: Wei Wang <wvw@google.com>
> ---
>  drivers/thermal/thermal_core.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index d4481cc8958f..0ff8fb1d7b0a 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -22,6 +22,7 @@
>  #include <net/netlink.h>
>  #include <net/genetlink.h>
>  #include <linux/suspend.h>
> +#include <linux/kobject.h>
>
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/thermal.h>
> @@ -46,6 +47,8 @@ static DEFINE_MUTEX(poweroff_lock);
>
>  static atomic_t in_suspend;
>  static bool power_off_triggered;
> +static struct kobject *cdev_link_kobj;
> +static struct kobject *tz_link_kobj;
>
>  static struct thermal_governor *def_governor;
>
> @@ -954,7 +957,7 @@ __thermal_cooling_device_register(struct device_node *np,
>         struct thermal_zone_device *pos = NULL;
>         int result;
>
> -       if (type && strlen(type) >= THERMAL_NAME_LENGTH)
> +       if (!type || !type[0] || strlen(type) >= THERMAL_NAME_LENGTH)
>                 return ERR_PTR(-EINVAL);

This should be a separate fix, if needed.

>         if (!ops || !ops->get_max_state || !ops->get_cur_state ||
> @@ -989,9 +992,15 @@ __thermal_cooling_device_register(struct device_node *np,
>                 return ERR_PTR(result);
>         }
>
> -       /* Add 'this' new cdev to the global cdev list */
> +       /* Add 'this' new cdev to the global cdev list and create link*/
>         mutex_lock(&thermal_list_lock);
>         list_add(&cdev->node, &thermal_cdev_list);
> +       if (!cdev_link_kobj)
> +               cdev_link_kobj = kobject_create_and_add("cdev-by-name",
> +                                               cdev->device.kobj.parent);
> +       if (!cdev_link_kobj || sysfs_create_link(cdev_link_kobj,
> +                                               &cdev->device.kobj, cdev->type))
> +               dev_err(&cdev->device, "Failed to create cdev-by-name link\n");

Any reason not to use the following form instead? It seems easier to read.

if (!cdev_link_kobj) {
               cdev_link_kobj = kobject_create_and_add("cdev-by-name",
                                               cdev->device.kobj.parent);
              ret = sysfs_create_link(cdev_link_kobj,
                                              &cdev->device.kobj, cdev->type))
              if (ret)
                       dev_err(&cdev->device, "Failed to create
cdev-by-name link\n");
}

>         mutex_unlock(&thermal_list_lock);
>
>         /* Update binding information for 'this' new cdev */
> @@ -1157,6 +1166,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
>                         }
>                 }
>         }
> +       if (cdev_link_kobj)
> +               sysfs_remove_link(cdev_link_kobj, cdev->type);
>
>         mutex_unlock(&thermal_list_lock);
>
> @@ -1340,6 +1351,12 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>
>         mutex_lock(&thermal_list_lock);
>         list_add_tail(&tz->node, &thermal_tz_list);
> +       if (!tz_link_kobj)
> +               tz_link_kobj = kobject_create_and_add("tz-by-name",
> +                                               tz->device.kobj.parent);
> +       if (!tz_link_kobj || sysfs_create_link(tz_link_kobj,
> +                                               &tz->device.kobj, tz->type))
> +               dev_err(&tz->device, "Failed to create tz-by-name link\n");

Same as above.

>         mutex_unlock(&thermal_list_lock);
>
>         /* Bind cooling devices for this zone */
> @@ -1411,6 +1428,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>                         }
>                 }
>         }
> +       if (tz_link_kobj)
> +               sysfs_remove_link(tz_link_kobj, tz->type);
>
>         mutex_unlock(&thermal_list_lock);
>
> --
> 2.23.0.700.g56cf767bdb-goog
>
