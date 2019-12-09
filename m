Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 170BD1167A1
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 08:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfLIHmk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 02:42:40 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46566 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLIHmk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 02:42:40 -0500
Received: by mail-vs1-f67.google.com with SMTP id t12so9540784vso.13
        for <linux-pm@vger.kernel.org>; Sun, 08 Dec 2019 23:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dMbLKo7IRv/SL96161v8eDNqnLEfqzax2XOuOcQOqhc=;
        b=FTja3MW3/ER9SYeVjIOLRZSMzRDeb50kqmk6eqJEMPd2U9IzUhtVVfEeckJNCnm5VW
         a+M/0AEPoBvlPc+PpIaJr+ielIXYcVqYKmrW6HbMb47XxhJrkr9AiJUZVtuL7SJcmjGB
         GkTM8sB2Jrc4D6EvrI66m03YAfC8iu9VIusI7hqy4McY2wM3WjU3J1K1Ym32zh6JFxpa
         jDUFu0O5010GL/7Ui98dWTseQgWrSrkSUYWAyWW0bZGylp1YwK5HL3J9WvMuZ4EMbt/6
         FpJb6N8GZFkj0XyKYh8T2E5Axi3DKK5l34sxMRvbgfVo9t8iGYNxD962aDoY1twgASQc
         FCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dMbLKo7IRv/SL96161v8eDNqnLEfqzax2XOuOcQOqhc=;
        b=C8ont2zf2HnqEZe8XGf4VWmlzE7Wh26fXblsYG7oTUAwbVL3sQ2WbwzBwU2VloQPIQ
         wd0CeXmGMMJt3VyD2R1Du1ioXRFydnFyRt0wPuXkxVzIqZh7nfwu9xSsWTpmqMIgE3tZ
         vPiJARmXcIQvqDxXYdKJKD2fhM4iAWdQBDySL+uJPlWE202leGBXOF+RBNqW5H5Pblod
         MlUAtEleGA1T0J1wX4X9ozWeoZzLCAg5TtGlly8q0kxhoWz1AvDLOQi5vU6h5jlASPVy
         EPJXcztFjuL4dgbWNkGoYQf4ijSU592izlt8vauzxFqs7CGsj9mV420trmCGpCSReOcI
         dypw==
X-Gm-Message-State: APjAAAXp+ip5eHDqq6KdZ2PJ2biUO/kgSVLFqilxwE/znIXWntwMovJA
        ECNsgzyzu2oSAb1zLxu8S9/dqzTajKKlLdrPMNYl6g==
X-Google-Smtp-Source: APXvYqxH6grHbhVceYssDE/5ixg4P6B9MfnftaQ6BBtytlXOyo9aJE1DCw5TqnD0CSbDUVaQ2+nhfNl0fMiJU/lfesM=
X-Received: by 2002:a67:f8cf:: with SMTP id c15mr19585797vsp.27.1575877358692;
 Sun, 08 Dec 2019 23:42:38 -0800 (PST)
MIME-Version: 1.0
References: <20191205071953.121511-1-wvw@google.com> <20191205071953.121511-4-wvw@google.com>
In-Reply-To: <20191205071953.121511-4-wvw@google.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Mon, 9 Dec 2019 13:12:27 +0530
Message-ID: <CAHLCerMdKq7wWdsZ00X1rL3y=NvocRqTJJe0W6q8708htH=pkw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] thermal: create softlink by name for thermal_zone
 and cooling_device
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

On Thu, Dec 5, 2019 at 12:50 PM Wei Wang <wvw@google.com> wrote:
>
> The paths thermal_zone%d and cooling_device%d are not intuitive and the
> numbers are subject to change due to device tree change. This usually
> leads to tree traversal in userspace code.
> The patch creates `tz-by-name' and `cdev-by-name' for thermal zone and
> cooling_device respectively.
>
> Signed-off-by: Wei Wang <wvw@google.com>
> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

Tested-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/thermal_core.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 9db7f72e70f8..7872bd527f3f 100644
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
> @@ -999,9 +1002,15 @@ __thermal_cooling_device_register(struct device_node *np,
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
>         mutex_unlock(&thermal_list_lock);
>
>         /* Update binding information for 'this' new cdev */
> @@ -1167,6 +1176,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
>                         }
>                 }
>         }
> +       if (cdev_link_kobj)
> +               sysfs_remove_link(cdev_link_kobj, cdev->type);
>
>         mutex_unlock(&thermal_list_lock);
>
> @@ -1354,6 +1365,12 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>
>         mutex_lock(&thermal_list_lock);
>         list_add_tail(&tz->node, &thermal_tz_list);
> +       if (!tz_link_kobj)
> +               tz_link_kobj = kobject_create_and_add("tz-by-name",
> +                                               tz->device.kobj.parent);
> +       if (!tz_link_kobj || sysfs_create_link(tz_link_kobj,
> +                                               &tz->device.kobj, tz->type))
> +               dev_err(&tz->device, "Failed to create tz-by-name link\n");
>         mutex_unlock(&thermal_list_lock);
>
>         /* Bind cooling devices for this zone */
> @@ -1425,6 +1442,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>                         }
>                 }
>         }
> +       if (tz_link_kobj)
> +               sysfs_remove_link(tz_link_kobj, tz->type);
>
>         mutex_unlock(&thermal_list_lock);
>
> --
> 2.24.0.393.g34dc348eaf-goog
>
