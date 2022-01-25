Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C9349BB7D
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jan 2022 19:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbiAYStp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jan 2022 13:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiAYStj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jan 2022 13:49:39 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B5FC06173E
        for <linux-pm@vger.kernel.org>; Tue, 25 Jan 2022 10:49:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id p27so58610760lfa.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Jan 2022 10:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oWLpzvRinJwVHFJZ5l+R8ls90zt89KNl+7gB074iPMw=;
        b=RMKKeWIUoJqGGE8YhS2fIB7T3ASIgs7mxqK2wuoWQluHFT48/hj1q0vAjlfbXBYRmv
         5njEKMFUMMqN/E9UzoszSTr8EiCuzYMvnfY67PnrYj7BopQ4PxeVDq+5ouIy4JpES8ZU
         C1KdrIDnKGgq8mhCqwRkSlD8PMmYHBh/MJkdI3mAbtcKq8U76CFKTyVWiFhJmKT5DtYz
         HuhWj59Wl93FgHX+OK1Pq3tGaHIpHVLsF2AXDezwOR6azidfAQ7urugkTwG+8xmux0YI
         xfeoZSSQxMYqq5aTD8jwxvfAVElQCO0HI/K2MmLgrreKN9GpFWH8p0OoA1bxo++VKWUo
         sZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oWLpzvRinJwVHFJZ5l+R8ls90zt89KNl+7gB074iPMw=;
        b=lEXIqEce8zzDTmWzNZhNpXODuz+Lec6krE8Ms91nYk2x+IQLfgX7fvvNkgBq8jp1kX
         P3virn4QguT4pE+Qw4VsvMQZtu8sNQbrRHYg8sRjsO4phESauTlJicz8q5UDWMUPXXdd
         rR+Yoe1W63/FdjDw86mdSfjoVTmQnopX0w62KDhCksH7x1lGbCVtnRJ7Z03jQRMA93Ps
         GyvcJ7Yr37V+wZUHI9MNeLuOWhn6FbbitHUJoqRQsGDvLUkqQQmB001GNXqKOfud8taZ
         hdPW6ngx4snzGvB0MKWXn5YqSkq0xndxcXmbA8PrRbNmJOiACZrpIwTKxD8GyYgIyvxE
         4JAw==
X-Gm-Message-State: AOAM5320doLH4O02T7Og8o1Wsw3ufTYPR07xGm6B/lYL3GhCj0uPF1xF
        rxKlUC+l9tsj/3gB0ZzggOJ1MYcVn3gzGX7bW3kpPA==
X-Google-Smtp-Source: ABdhPJzroNW2XM9JUO3ZyCYiZo5rSd0NVZ+1Py1R28klXukskpHC5iKqzcDcfYMNVwikZBECMncvuVfpIhWlI/O1WvE=
X-Received: by 2002:a05:6512:3c98:: with SMTP id h24mr11359880lfv.233.1643136577075;
 Tue, 25 Jan 2022 10:49:37 -0800 (PST)
MIME-Version: 1.0
References: <1641749107-31979-1-git-send-email-quic_mkshah@quicinc.com> <1641749107-31979-9-git-send-email-quic_mkshah@quicinc.com>
In-Reply-To: <1641749107-31979-9-git-send-email-quic_mkshah@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Jan 2022 19:49:00 +0100
Message-ID: <CAPDyKFoiCVeMeaSDch+xX4iURP2beaDvvjhhodeGxrv2WehKEA@mail.gmail.com>
Subject: Re: [PATCH 08/10] PM: domains: Store the closest hrtimer event of the
 domain CPUs
To:     Maulik Shah <quic_mkshah@quicinc.com>
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        quic_lsrao@quicinc.com, quic_rjendra@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 9 Jan 2022 at 18:26, Maulik Shah <quic_mkshah@quicinc.com> wrote:
>
> The arch timer can not wake up the Qualcomm Technologies, Inc. (QTI)
> SoCs when the deepest CPUidle modes results in the SoC also to enter
> the low power mode.
>
> RSC is part of CPU subsystem and APSS rsc device is attached to cluster
> power domain. RSC has to setup next hrtimer wakeup in CONTROL_TCS which
> can wakeup the SoC from deepest low power states. The CONTROL_TCS does
> this by writing next wakeup in always on domain timer when the SoC is
> entering the low power state.
>
> Store the domain wakeup time from all the CPUs which can be used from
> domain power off callback by RSC device.
>
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> ---
>  drivers/base/power/domain_governor.c | 1 +
>  include/linux/pm_domain.h            | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> index cd08c58..a4c7dd8 100644
> --- a/drivers/base/power/domain_governor.c
> +++ b/drivers/base/power/domain_governor.c
> @@ -363,6 +363,7 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>                                 domain_wakeup = next_hrtimer;
>                 }
>         }
> +       genpd->next_hrtimer = domain_wakeup;
>
>         /* The minimum idle duration is from now - until the next wakeup. */
>         idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, now));
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 67017c9..682b372 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -136,6 +136,7 @@ struct generic_pm_domain {
>         struct gpd_dev_ops dev_ops;
>         s64 max_off_time_ns;    /* Maximum allowed "suspended" time. */
>         ktime_t next_wakeup;    /* Maintained by the domain governor */
> +       ktime_t next_hrtimer;   /* Closest hrtimer event of the domain CPUs */

Would you mind clarifying the comment into something along the lines
of: "/* Next hrtimer for the CPU PM domain */

>         bool max_off_time_changed;
>         bool cached_power_down_ok;
>         bool cached_power_down_state_idx;
> --
> 2.7.4
>

Beside the nitpick above, I have a few additional minor comments.

*) Users of genpd->next_hrtimer should not access this member in the
struct generic_pm_domain themselves. Instead, I suggest we add a genpd
helper function to deal with this. In this regard, we should also add
a description to the helper function to explain under what *specific*
conditions it's allowed to be called for.

**) We should assign genpd->next_hrtimer a default value in
pm_genpd_init(). Perhaps that can also be used in a way to make sure
the helper function always returns a valid value!?

Other than this, I think the approach looks sane to me!

Kind regards
Uffe
