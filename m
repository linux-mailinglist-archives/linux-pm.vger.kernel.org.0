Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B980F19E347
	for <lists+linux-pm@lfdr.de>; Sat,  4 Apr 2020 09:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgDDHbB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Apr 2020 03:31:01 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44567 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDDHbB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Apr 2020 03:31:01 -0400
Received: by mail-ua1-f66.google.com with SMTP id r47so3604195uad.11
        for <linux-pm@vger.kernel.org>; Sat, 04 Apr 2020 00:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iN6wacGfdwib+ApYHKZ/FdwkNp4iLTwqPrmNMYd7r8E=;
        b=XgCyTbZnWC345hsCKy5O82Uyugw36Ruw2EuDhzxddNPaJuxpWG/szVyMl3nKOsOQEw
         a6BCuJE2um28o68NDCtRThVKI9U4Z/+WRrs5jTdn0gjMLnJVWuNuO04Zq3VNqVjXz6O8
         xzfXQSNFWneyDUxTm6J90kj5fxDYPWABFp8c46rQsUGTPUvU31Eb8JtyUPP2QnHUKFjS
         GoEgMZB4zvnj8RChQvLVjKbqBLgm/ja1Pw7rEp8FQ/CceQt+fzgjrZDbFDZT/cOXSXMT
         LF5uTx2yToS6x+iIPg6I0fNmVw9Oz6cLFMVbIHvgDltGByupCJFd39dk0GsGPBcxD+TS
         Lt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iN6wacGfdwib+ApYHKZ/FdwkNp4iLTwqPrmNMYd7r8E=;
        b=eZG+RRwcpjmA8zXw/Nv47/OFasF3MabumboA5agXJhiu1tW6gKsNGXShbd7Jt9MOfK
         XFTKhfhtCx/Ep1xcvplqyF6wxVhXN/BbrkE8S+xFo2g8fMTuuODPKUqB10vOO6fsRGQH
         fN+Rvo+lkaqWYvDX/F0CBwSVCYBtAHgaGsMyq7J4z0/ElPF6008QgHkSW1wVjtySPPzt
         gY77DTwRxkng6FCJXrehNW8oUuxOcOOjH97u+iQpqYRYSrNcmp1HgPoJMvxuIZeF1lPc
         AhrCXZnxGguFo2ef5HLaEKW3+MQcXdpvxilFc7NTmMCBK1+AbYSIE0qjJVZcLfmNglac
         /RIw==
X-Gm-Message-State: AGi0PubZYV2DqT5+SBV6YJEjnoAV8wtnBfFyUIc+26rp6CexgtLy4eLi
        VDy58lpVTowjeMTx8fSAtX0oMDHJSRPNjr0znQXsYA==
X-Google-Smtp-Source: APiQypLxGLnrhOCRwjBuHxBjOcTXenqCe/nppA+193Zt4K2TYnyPUN4lriSlHgW1KlWine7JnWgynUq4FjLwy+MHZTM=
X-Received: by 2002:ab0:5f90:: with SMTP id b16mr9274182uaj.77.1585985460113;
 Sat, 04 Apr 2020 00:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200402142747.8307-1-daniel.lezcano@linaro.org> <20200402142747.8307-3-daniel.lezcano@linaro.org>
In-Reply-To: <20200402142747.8307-3-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Sat, 4 Apr 2020 13:00:00 +0530
Message-ID: <CAHLCerOD2sqqQ0o87z7RDmTAzqyk9eDbTMZN92esLRtUHErSBg@mail.gmail.com>
Subject: Re: [PATCH V2 3/9] thermal: Move internal IPA functions
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 2, 2020 at 7:58 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The exported IPA functions are used by the IPA. It is pointless to
> declare the functions in the thermal.h file.
>
> For better self-encapsulation and less impact for the compilation if a
> change is made on it. Move the code in the thermal core internal
> header file.
>
> As the users depends on THERMAL then it is pointless to have the stub,
> remove them.
>
> Take also the opportunity to fix checkpatch warnings/errors when
> moving the code around.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/thermal_core.h | 13 +++++++++++++
>  include/linux/thermal.h        | 24 ------------------------
>  2 files changed, 13 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 5d08ad60d9df..f99551ce9838 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -46,6 +46,19 @@ struct thermal_attr {
>         char name[THERMAL_NAME_LENGTH];
>  };
>
> +static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
> +{
> +       return cdev->ops->get_requested_power && cdev->ops->state2power &&
> +               cdev->ops->power2state;
> +}
> +
> +int power_actor_get_max_power(struct thermal_cooling_device *cdev,
> +                             struct thermal_zone_device *tz, u32 *max_power);
> +int power_actor_get_min_power(struct thermal_cooling_device *cdev,
> +                             struct thermal_zone_device *tz, u32 *min_power);
> +int power_actor_set_power(struct thermal_cooling_device *cdev,
> +                         struct thermal_instance *ti, u32 power);
> +
>  /*
>   * This structure is used to describe the behavior of
>   * a certain cooling device on a certain trip point
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 5aa80fb2fb61..e0279f7b43f4 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -399,18 +399,6 @@ void devm_thermal_zone_of_sensor_unregister(struct device *dev,
>  #endif
>
>  #if IS_ENABLED(CONFIG_THERMAL)
> -static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
> -{
> -       return cdev->ops->get_requested_power && cdev->ops->state2power &&
> -               cdev->ops->power2state;
> -}
> -
> -int power_actor_get_max_power(struct thermal_cooling_device *,
> -                             struct thermal_zone_device *tz, u32 *max_power);
> -int power_actor_get_min_power(struct thermal_cooling_device *,
> -                             struct thermal_zone_device *tz, u32 *min_power);
> -int power_actor_set_power(struct thermal_cooling_device *,
> -                         struct thermal_instance *, u32);
>  struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
>                 void *, struct thermal_zone_device_ops *,
>                 struct thermal_zone_params *, int, int);
> @@ -447,18 +435,6 @@ struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
>  void thermal_cdev_update(struct thermal_cooling_device *);
>  void thermal_notify_framework(struct thermal_zone_device *, int);
>  #else
> -static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
> -{ return false; }
> -static inline int power_actor_get_max_power(struct thermal_cooling_device *cdev,
> -                             struct thermal_zone_device *tz, u32 *max_power)
> -{ return 0; }
> -static inline int power_actor_get_min_power(struct thermal_cooling_device *cdev,
> -                                           struct thermal_zone_device *tz,
> -                                           u32 *min_power)
> -{ return -ENODEV; }
> -static inline int power_actor_set_power(struct thermal_cooling_device *cdev,
> -                         struct thermal_instance *tz, u32 power)
> -{ return 0; }
>  static inline struct thermal_zone_device *thermal_zone_device_register(
>         const char *type, int trips, int mask, void *devdata,
>         struct thermal_zone_device_ops *ops,
> --
> 2.17.1
>
