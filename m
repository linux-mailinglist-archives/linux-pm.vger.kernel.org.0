Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B75F19A722
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 10:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbgDAIVd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 04:21:33 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38021 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgDAIVd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2020 04:21:33 -0400
Received: by mail-vs1-f66.google.com with SMTP id x206so15347252vsx.5
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2020 01:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TMiys8vgh/zVs+g/WqcrVmGnSmA9w/d7OqJQQ7up1M4=;
        b=nOcgW+vJIDaeDBEdtqPJ13SjXnUQ8tvB/zXLpC8eEDmJa1qx0uTZpc4I94TQiNjE9T
         msVtL4CTE33K//fw+xBNn9GaFPpRVLqyj5PGNxcqEoozzzRecgBLsoLIzAt/5NSW01AE
         Ynl8VeIjsvYaiV6k4IVQfovLO0c12hxq3kZ41k3nh4TKrIk6ubCen/TswPapWoaThDNB
         9A40s6iX1mVNOTpDe99mHNmQWlLJ2JxmLsTGu/yT5GmlhdDZoMZyZkyiPOJJq5FGqIcO
         ti5blWz6lQahfcXM/qyBmUasrIWl9sVGvCfjPhfLX4CFLf8PQa13p+ye9/v/eTpjxdgF
         Q1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TMiys8vgh/zVs+g/WqcrVmGnSmA9w/d7OqJQQ7up1M4=;
        b=Q8VovnsDepUc8apnoGAKxrCbMNACf2buNXP9WRRICeSPFxkGO6bh14A1nnBf0oAKC9
         doWn3kv85PPBKfiP64P2lDXyU8SfIPQ4Z4eU5DuFivzZxNT5as2f64MZdLAIKg2wygHa
         g6jqZLilJXKNZNQ3bP0nVaQGOaCyHvN5UuJM27LXfAFN/ntWKZf7D/9jy20SFByb9FJX
         yTPYZPaKaYPhAqGB3wIozqSGDqYXqhDPLTT3lguVu1JXRQjVAg9+ObLHkwJ8N9966uy4
         HytGodfKX8dEluGZK5txrZBjI1VbAlU7431HlOWvvOlcjdCnWGkITYa4/fg8spO4CF1l
         +d2g==
X-Gm-Message-State: AGi0PuY3NfQ3oL5RoZawrops/K6/k/i4DVS+KHUMCzt+AXhBH1kVHgPC
        4h5jGGjud6WL4VSrWofNuJbSxcl8Rw+IU4xoDAt3A1EWuD/QXw==
X-Google-Smtp-Source: APiQypIFgzuZyqDqF5vQmkoXOgF4Gs4J+CyGROUlmGOe4oP6uK3MuXRnZum585qhaQzu2hPT5+Qkz4Vz+TJF0gMrJP0=
X-Received: by 2002:a67:69d5:: with SMTP id e204mr14355392vsc.159.1585729291733;
 Wed, 01 Apr 2020 01:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200331165449.30355-1-daniel.lezcano@linaro.org>
In-Reply-To: <20200331165449.30355-1-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 1 Apr 2020 13:51:20 +0530
Message-ID: <CAHLCerPrCLNqcK8E1T917_HyV3uuP9U3e6sR335KiJn4ho72aw@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: core: Make thermal_zone_set_trips private
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 31, 2020 at 10:26 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The function thermal_zone_set_trips() is used by the thermal core code
> in order to update the next trip points, there are no other users.
>
> Move the function definition in the thermal_core.h, remove the
> EXPORT_SYMBOL_GPL and document the function.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/thermal_core.h    |  3 +++
>  drivers/thermal/thermal_helpers.c | 13 ++++++++++++-
>  include/linux/thermal.h           |  3 ---
>  3 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index a9bf00e91d64..37cd4e2bead2 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -69,6 +69,9 @@ void thermal_zone_device_unbind_exception(struct thermal_zone_device *,
>  int thermal_zone_device_set_policy(struct thermal_zone_device *, char *);
>  int thermal_build_list_of_policies(char *buf);
>
> +/* Helpers */
> +void thermal_zone_set_trips(struct thermal_zone_device *tz);
> +
>  /* sysfs I/F */
>  int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
>  void thermal_zone_destroy_device_groups(struct thermal_zone_device *);
> diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
> index 2ba756af76b7..59eaf2d0fdb3 100644
> --- a/drivers/thermal/thermal_helpers.c
> +++ b/drivers/thermal/thermal_helpers.c
> @@ -113,6 +113,18 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
>
> +/**
> + * thermal_zone_set_trips - Computes the next trip points for the driver
> + * @tz: a pointer to a thermal zone device structure
> + *
> + * The function computes the next temperature boundaries by browsing
> + * the trip points. The result is the closer low and high trip points
> + * to the current temperature. These values are passed to the backend
> + * driver to let it set its own notification mechanism (usually an
> + * interrupt).
> + *
> + * It does not return a value
> + */
>  void thermal_zone_set_trips(struct thermal_zone_device *tz)
>  {
>         int low = -INT_MAX;
> @@ -161,7 +173,6 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
>  exit:
>         mutex_unlock(&tz->lock);
>  }
> -EXPORT_SYMBOL_GPL(thermal_zone_set_trips);
>
>  void thermal_cdev_update(struct thermal_cooling_device *cdev)
>  {
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index c91b1e344d56..448841ab0dca 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -439,7 +439,6 @@ int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
>                                        struct thermal_cooling_device *);
>  void thermal_zone_device_update(struct thermal_zone_device *,
>                                 enum thermal_notify_event);
> -void thermal_zone_set_trips(struct thermal_zone_device *);
>
>  struct thermal_cooling_device *thermal_cooling_device_register(const char *,
>                 void *, const struct thermal_cooling_device_ops *);
> @@ -497,8 +496,6 @@ static inline int thermal_zone_unbind_cooling_device(
>  static inline void thermal_zone_device_update(struct thermal_zone_device *tz,
>                                               enum thermal_notify_event event)
>  { }
> -static inline void thermal_zone_set_trips(struct thermal_zone_device *tz)
> -{ }
>  static inline struct thermal_cooling_device *
>  thermal_cooling_device_register(char *type, void *devdata,
>         const struct thermal_cooling_device_ops *ops)
> --
> 2.17.1
>
