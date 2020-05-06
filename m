Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3AD1C6FF8
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 14:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgEFMIc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 08:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726516AbgEFMIc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2020 08:08:32 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74F4C061A0F
        for <linux-pm@vger.kernel.org>; Wed,  6 May 2020 05:08:31 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id y10so379463uao.8
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2020 05:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Obvw5yT7rBTQqXB7j3qE7QSsI0Uog3vShstm4AK1CJg=;
        b=LZeaClpcXIXkBovvbrCkYqYeSXU+oO5KLZ6gZ2UlXdsTy/huD2WurKXn2ScSs7zXC1
         v/IeOOtsfhAjzkL37XrfqwURSshHoUm0Fo5j0X1OwWDeFv4Xit4INfyP3nevodStFHF3
         tPPxm+eMXSTiUbERf8vYJRnGcm5KZB5La69IuJxRvBYQaIVOG9wiLt1c/wJ5D89HBddy
         E6sByInnus05+trXFimcwyGDd91zlkYcUGq7cp+1BwZVD89QNJBHOdPqVfijO/d6IHpt
         iRxttoCTrQ9cnz/yiuwMHc4cVXY62rUvUKNTmBBwV6dsJBKLmEw9yP2URyHC7pkV8+Df
         g/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Obvw5yT7rBTQqXB7j3qE7QSsI0Uog3vShstm4AK1CJg=;
        b=BM1U3DQ/tyLWsK0jvPfEYzz279VZ005ZHMdplJGxMN8Kv9wDkxcRlMIZqXXUlbsdMQ
         wjincteKRaNsii0/O5AXRh7Ur9cYji+zaKwrXINccSLirFlwz8Da5Vj/9DAXN9YNQnNS
         KQQ8dcvY7uxEyZrGEX7LCD/he2jSCuZVLl6ioGL4YT7DZnVujAHao8EzjtzhmCQ143uK
         rJ7plvbqx17i5S1dVMVpBB1htzKPA68rShXR3X9TIM/CiudwP2w4ZLcaZnjbH4aMTlLg
         idct7V3hfalm/XdmdodMvjf9vcTEHg73/6sapEDChVS9PSA1cLtiKfJ9DGGucpEhza/U
         L3Rg==
X-Gm-Message-State: AGi0Pub7DirSstk4MU0m/QhcGphGrjnOclW9/2GDqhd0C9+MvY+AaBGM
        UoqCrTQ+WIPCp/G7gLhSK/6G9IkZYtWsWBpif3aV5A==
X-Google-Smtp-Source: APiQypJ/cqRfjVT11FmiUrd+qAzEqO1lUP1wgDzMGMkfC8loSHvl+cyn2GDc37SEhDUnFcbsBRloh9hg9QJgWb39rzI=
X-Received: by 2002:ab0:20aa:: with SMTP id y10mr6300373ual.60.1588766910719;
 Wed, 06 May 2020 05:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200408041917.2329-1-rui.zhang@intel.com>
In-Reply-To: <20200408041917.2329-1-rui.zhang@intel.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 6 May 2020 17:37:57 +0530
Message-ID: <CAHLCerOiJaAzuySgwj2GNnYVSebNUMjN+7qm7zDURuFvU=Mj-g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] thermal: rename thermal_cooling_device_stats_update()
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Takashi Iwai <tiwai@suse.de>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 8, 2020 at 9:49 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Rename thermal_cooling_device_stats_update() to
> thermal_cdev_stats_update_cur()

Missing a reason for this change.

>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

> ---
>  drivers/thermal/thermal_core.h    | 4 ++--
>  drivers/thermal/thermal_helpers.c | 2 +-
>  drivers/thermal/thermal_sysfs.c   | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index a9bf00e91d64..722902d5724a 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -81,11 +81,11 @@ ssize_t weight_store(struct device *, struct device_attribute *, const char *,
>                      size_t);
>
>  #ifdef CONFIG_THERMAL_STATISTICS
> -void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
> +void thermal_cdev_stats_update_cur(struct thermal_cooling_device *cdev,
>                                          unsigned long new_state);
>  #else
>  static inline void
> -thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
> +thermal_cdev_stats_update_cur(struct thermal_cooling_device *cdev,
>                                     unsigned long new_state) {}
>  #endif /* CONFIG_THERMAL_STATISTICS */
>
> diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
> index 2ba756af76b7..3af895e5dfce 100644
> --- a/drivers/thermal/thermal_helpers.c
> +++ b/drivers/thermal/thermal_helpers.c
> @@ -186,7 +186,7 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
>         }
>
>         if (!cdev->ops->set_cur_state(cdev, target))
> -               thermal_cooling_device_stats_update(cdev, target);
> +               thermal_cdev_stats_update_cur(cdev, target);
>
>         cdev->updated = true;
>         mutex_unlock(&cdev->lock);
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index aa99edb4dff7..00caa7787b71 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -716,7 +716,7 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
>
>         result = cdev->ops->set_cur_state(cdev, state);
>         if (!result)
> -               thermal_cooling_device_stats_update(cdev, state);
> +               thermal_cdev_stats_update_cur(cdev, state);
>
>         mutex_unlock(&cdev->lock);
>         return result ? result : count;
> @@ -765,7 +765,7 @@ static void update_time_in_state(struct cooling_dev_stats *stats)
>         stats->last_time = now;
>  }
>
> -void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
> +void thermal_cdev_stats_update_cur(struct thermal_cooling_device *cdev,
>                                          unsigned long new_state)
>  {
>         struct cooling_dev_stats *stats = cdev->stats;
> --
> 2.17.1
>
