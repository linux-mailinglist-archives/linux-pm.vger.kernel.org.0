Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4884369204
	for <lists+linux-pm@lfdr.de>; Fri, 23 Apr 2021 14:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242607AbhDWMXr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Apr 2021 08:23:47 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:44630 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242583AbhDWMXp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Apr 2021 08:23:45 -0400
Received: by mail-wm1-f54.google.com with SMTP id f195-20020a1c1fcc0000b029012eb88126d7so1118716wmf.3;
        Fri, 23 Apr 2021 05:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IfZ+2JiNci4QRyjBF0wJiEKhtkmyRzMTA5tDnebPqoM=;
        b=d6W7v5FGzHckzGhqIZe74LBwfC4qy/ig5KtegFpK5IaT9XZBz94RmqJhwKddiCBGzK
         nAZFhGuJt+wwPBeuz/3lqkg1L+rh4S/GdDmsd/S3mF7ePnHPSWBUo5SalbdOWzKyV0Rn
         vTydF3nEtLBrT6Zk0XOcHs/AO54yoP+trawkA/tdFo9ClrK1HqtY+zIN8sJfu6ljoP0V
         WFfNbocMZocDnNU6ETX+Fid3O/PcVBxok9ysW84dbeHi6XvEfYpOSwub0zt4F/jqYb1D
         P28pY3xvZ8ZCeAlTqMVcW5y/OIYwG9Rz0ZpzqE7MNMQU6mquZ/m/ffT4k4kna7gG25Mi
         axkw==
X-Gm-Message-State: AOAM530rVbQAoHTJk/5FBQC4lkkND647Nphocq7sTwAbAd+QA8tPX2qp
        bjdrU90/g3Au8xulHlU9jO53psGhoi+WfJKwnSQ=
X-Google-Smtp-Source: ABdhPJzRYSCjK2gittLcL+tzwrLSzZ7uivi0bEJ6NpaytiG7EO3fbTNzN9CNAOGHu3m9iIUiHCwa5hCrr2YPOhle2c8=
X-Received: by 2002:a7b:cb8a:: with SMTP id m10mr5263993wmi.95.1619180586988;
 Fri, 23 Apr 2021 05:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <1619123448-10138-1-git-send-email-skomatineni@nvidia.com> <1619123448-10138-3-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1619123448-10138-3-git-send-email-skomatineni@nvidia.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Apr 2021 14:22:55 +0200
Message-ID: <CAJZ5v0hb7AES4A2QHhtMo76GbbkH=FnyQb0oEpHOaWWirpJ80A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] cpuidle: menu: add idle_time to cpuidle_state
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, ksitaraman@nvidia.com,
        sanjayc@nvidia.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 22, 2021 at 10:31 PM Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> Some platforms use separate CPU firmware running in background to
> handle state transitions which may need runtime idle time of the
> corresponding target state from the kernel.

How exactly does this work?

> This patch adds idle_time to cpuidle state to expose to cpuidle driver the
> idle time that the governor menu predicts based on next events and states
> target residency for selecting proper idle state.
>
> CPU idle driver passes this runtime state idle time to TF-A.
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/cpuidle/governors/menu.c | 7 ++++++-
>  include/linux/cpuidle.h          | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index c3aa8d6..0da5bc5 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -382,8 +382,10 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>                          * stuck in the shallow one for too long.
>                          */
>                         if (drv->states[idx].target_residency_ns < TICK_NSEC &&
> -                           s->target_residency_ns <= delta_tick)
> +                           s->target_residency_ns <= delta_tick) {
> +                               drv->states[idx].idle_time = delta_tick / NSEC_PER_USEC;
>                                 idx = i;
> +                       }
>
>                         return idx;
>                 }
> @@ -393,6 +395,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>                 idx = i;
>         }
>
> +       drv->states[idx].idle_time = predicted_ns / NSEC_PER_USEC;
>         if (idx == -1)
>                 idx = 0; /* No states enabled. Must use 0. */
>
> @@ -419,6 +422,8 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>                                 if (drv->states[i].target_residency_ns <= delta_tick)
>                                         break;
>                         }
> +
> +                       drv->states[idx].idle_time = delta_tick / NSEC_PER_USEC;
>                 }
>         }
>
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index fce4762..12db2e9 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -55,6 +55,7 @@ struct cpuidle_state {
>         unsigned int    exit_latency; /* in US */
>         int             power_usage; /* in mW */
>         unsigned int    target_residency; /* in US */
> +       unsigned int    idle_time; /* in US */

No way.

This structure holds idle state properties of and not some random data
passed between cpuidle components.  And it is not per-CPU, while the
governors work on the per-CPU basis.

state_usage might be more suitable, but that only if I'm convinced
that this is really necessary.

>
>         int (*enter)    (struct cpuidle_device *dev,
>                         struct cpuidle_driver *drv,
> --
