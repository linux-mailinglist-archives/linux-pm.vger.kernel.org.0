Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDED32137B6
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jul 2020 11:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgGCJa0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jul 2020 05:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgGCJa0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2020 05:30:26 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59874C08C5C1
        for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2020 02:30:26 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id p6so2779473uaq.12
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2020 02:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xcsxPutAbHr/mERBmd96crXO04cWIJ7hy0vhKC8AGU0=;
        b=jSKPhcUSHMEypMHqbJIvmqOdB6MoqhYFP+UdXIWdtUaD5gMAGiBLLVSSk6x6AL3TWl
         6KStgsjU4ggE96icmj3wUf04KgjO16HfJNYs0ErJB0WVNxka5bVctbuzetiOh2qTRYOc
         ztOOijNjZdXAobpi0yRAXmIN4H2k9op/m1EKS5In5/rCwbH0zH2U2KGLrvxfmy1CaCRO
         4roXMw790D/JRbOYPzdxliRtoxjOO9nqC3+sG1bnMtygejon4ygJn4bkjuHizMEJclXA
         NGe+IuRrwNrtpLhjztRDVB+0oFultaE3bLqLytJIGj+VmnyUXSw82Zx82PaZeS7oybez
         gvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xcsxPutAbHr/mERBmd96crXO04cWIJ7hy0vhKC8AGU0=;
        b=StxPyuOD10qO3kxVzOGQL4HP7eEl4GmaB6RdBKiiNu2+eytj9FqzLSQf7HJdOzmcag
         9QQd+WL9pvYBDpqfMPv0hCNxT8GfXswETiqcE1+TgiTQ8yvAXXlUbL7q/suiHHwOqJb0
         BPYQFoXI4a0jcrGMiHC84cUYBDwgzIdgUr4shksZh9aO1R25Xhx0kRdoRwGAeZOrQ1i8
         81YN8LxDzthYV3RGk9wA/b3ajz+6d3d2pHCYbBXpgH4Lma/1b6avjYlTzsPSSLllyAdq
         EHFhwdAi0thGIwL11I+eH/tiMY6UL4NyYNZyugiAGzWGH/uday6I7wQDH61Kf3ob5a07
         +mNw==
X-Gm-Message-State: AOAM53225EuK7CRvMhCgghj47l6YVD3vl2Aoh0daM/NY6kAJkn/xFKU1
        0mJ+64wr+EMh0S2RaT2Gy3N8Qitflc8RKdWwtJuciA==
X-Google-Smtp-Source: ABdhPJw9s0J0hfM2gTo7WpZ1wTpHvdFC6pFKsOmZ7sp1LL+8H/6oQSpOVgupyqgG9KWLLbaasxoM8UImu03yB5/tEbQ=
X-Received: by 2002:ab0:6c4b:: with SMTP id q11mr23540206uas.94.1593768625138;
 Fri, 03 Jul 2020 02:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200703085309.32166-1-daniel.lezcano@linaro.org> <20200703085309.32166-4-daniel.lezcano@linaro.org>
In-Reply-To: <20200703085309.32166-4-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 3 Jul 2020 15:00:14 +0530
Message-ID: <CAHLCerPicxHbx1K+riKeuDkXQ4yNDAimrK0TN780c3SsXL7q6g@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] thermal: core: Add notifications call in the framework
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 3, 2020 at 2:23 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The generic netlink protocol is implemented but the different
> notification functions are not yet connected to the core code.
>
> These changes add the notification calls in the different
> corresponding places.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/thermal_core.c    | 21 +++++++++++++++++++++
>  drivers/thermal/thermal_helpers.c | 11 +++++++++--
>  drivers/thermal/thermal_sysfs.c   | 15 ++++++++++++++-
>  3 files changed, 44 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 5fae1621fb01..25ef29123f72 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -215,6 +215,8 @@ int thermal_zone_device_set_policy(struct thermal_zone_device *tz,
>         mutex_unlock(&tz->lock);
>         mutex_unlock(&thermal_governor_lock);
>
> +       thermal_notify_tz_gov_change(tz->id, policy);
> +
>         return ret;
>  }
>
> @@ -406,12 +408,25 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>  static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
>  {
>         enum thermal_trip_type type;
> +       int trip_temp, hyst = 0;
>
>         /* Ignore disabled trip points */
>         if (test_bit(trip, &tz->trips_disabled))
>                 return;
>
> +       tz->ops->get_trip_temp(tz, trip, &trip_temp);
>         tz->ops->get_trip_type(tz, trip, &type);
> +       if (tz->ops->get_trip_hyst)
> +               tz->ops->get_trip_hyst(tz, trip, &hyst);
> +
> +       if (tz->last_temperature != THERMAL_TEMP_INVALID) {
> +               if (tz->last_temperature < trip_temp &&
> +                   tz->temperature >= trip_temp)
> +                       thermal_notify_tz_trip_up(tz->id, trip);
> +               if (tz->last_temperature >= trip_temp &&
> +                   tz->temperature < (trip_temp - hyst))
> +                       thermal_notify_tz_trip_down(tz->id, trip);
> +       }
>
>         if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
>                 handle_critical_trips(tz, trip, type);
> @@ -443,6 +458,8 @@ static void update_temperature(struct thermal_zone_device *tz)
>         mutex_unlock(&tz->lock);
>
>         trace_thermal_temperature(tz);
> +
> +       thermal_genl_sampling_temp(tz->id, temp);
>  }
>
>  static void thermal_zone_device_init(struct thermal_zone_device *tz)
> @@ -1405,6 +1422,8 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>         if (atomic_cmpxchg(&tz->need_update, 1, 0))
>                 thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>
> +       thermal_notify_tz_create(tz->id, tz->type);
> +
>         return tz;
>
>  unregister:
> @@ -1476,6 +1495,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>         ida_destroy(&tz->ida);
>         mutex_destroy(&tz->lock);
>         device_unregister(&tz->device);
> +
> +       thermal_notify_tz_delete(tz->id);
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
>
> diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
> index 87b1256fa2f2..53dd92ccfd19 100644
> --- a/drivers/thermal/thermal_helpers.c
> +++ b/drivers/thermal/thermal_helpers.c
> @@ -175,6 +175,14 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
>         mutex_unlock(&tz->lock);
>  }
>
> +void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev, int target)
> +{
> +       if (cdev->ops->set_cur_state(cdev, target))
> +               return;
> +       thermal_notify_cdev_update(cdev->id, target);
> +       thermal_cooling_device_stats_update(cdev, target);
> +}
> +
>  void thermal_cdev_update(struct thermal_cooling_device *cdev)
>  {
>         struct thermal_instance *instance;
> @@ -197,8 +205,7 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
>                         target = instance->target;
>         }
>
> -       if (!cdev->ops->set_cur_state(cdev, target))
> -               thermal_cooling_device_stats_update(cdev, target);
> +       thermal_cdev_set_cur_state(cdev, target);
>
>         cdev->updated = true;
>         mutex_unlock(&cdev->lock);
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index aa99edb4dff7..ff449943f757 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -124,7 +124,8 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
>  {
>         struct thermal_zone_device *tz = to_thermal_zone(dev);
>         int trip, ret;
> -       int temperature;
> +       int temperature, hyst = 0;
> +       enum thermal_trip_type type;
>
>         if (!tz->ops->set_trip_temp)
>                 return -EPERM;
> @@ -139,6 +140,18 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
>         if (ret)
>                 return ret;
>
> +       if (tz->ops->get_trip_hyst) {
> +               ret = tz->ops->get_trip_hyst(tz, trip, &hyst);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       ret = tz->ops->get_trip_type(tz, trip, &type);
> +       if (ret)
> +               return ret;
> +
> +       thermal_notify_tz_trip_change(tz->id, trip, type, temperature, hyst);
> +
>         thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>
>         return count;
> --
> 2.17.1
>
