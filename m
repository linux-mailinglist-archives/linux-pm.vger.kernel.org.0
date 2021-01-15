Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DEE2F7A49
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jan 2021 13:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387872AbhAOMgY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jan 2021 07:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733273AbhAOMgX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jan 2021 07:36:23 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6B3C0613C1
        for <linux-pm@vger.kernel.org>; Fri, 15 Jan 2021 04:35:42 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id q66so2133474vke.0
        for <linux-pm@vger.kernel.org>; Fri, 15 Jan 2021 04:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uMakeFoh6Ncg56i6DwGomJHlhBG8cOKWO5An8k3T4oc=;
        b=o/QRrKtquYMxE3xaN9agiJ4nnMAyQNB1aQtvqvpXr/JgJf8giVb19ToFemJotuJpoI
         etTVWazKjFUXNWRRZKoakwHVGfOFb37uqLhMRqhTRdQQMWPTzvuQdPZXsWaqpjHFKSt1
         /kkYIYKV5czBxKG5uX4mk17Sur1fCLpMusrfO2zH1hrNPW/Nt82Oi5JFg+xEaF1XQJjg
         5DRb4VqAExjjI8xIRHpvGkd6DJt54qYxiLEbPEvnfP2YAnvaGLZVXajP7yslnYC3IJZ9
         VWdBicB/roSo/Ky1Oqh5VDpiUGpvQVEq2nDovDw/kMIIbxb9pvFama5iK8bBY78x90/X
         ItSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMakeFoh6Ncg56i6DwGomJHlhBG8cOKWO5An8k3T4oc=;
        b=iULrjy9DW9d9C4WHFIwV0aoCcHSidvyToHuRLQL+AHtg8WO1Fad4NoAnN1Af7BfV5r
         3zKanQbl2qRuJfBeFSapEz6A/9ZHSpxFmgFAIja9KnyVp9X1ApyevpKXu+O+CKKEy6JC
         gG+QYBw5wW9SVGPWsgC/cSOXTkANDQFaqANsst3jQ+nM44/ypHJNz28m+0DQq6wPcZwC
         DTSDvUEl9BJVBgRts5DqKgIGym2b6ZNvoCdlpQLdR7o0osxwGIYDio3XMqIwT6umD7L9
         CofG8tVI3EJfH6e9y1yRuJwbyCYp4tMeVqhln0C5BEJu8OJBrRKwduX+gtMf8axR680D
         RLvg==
X-Gm-Message-State: AOAM532lV5aJPUonLs15BYB97O9MmZt6cTknz0OBpDxqwEx1zq05rfAb
        DLk9t8Su8olO/OtXMUlrwmSIp80O0LatSG5XG5E8Sg==
X-Google-Smtp-Source: ABdhPJwmdB4j35uF6udNub64LnLZ4nTQx/nT1TtURRy9TIIMnkUU42Dumacz/8fvkBN17cRokwPFA8LZur9x/qJgVU8=
X-Received: by 2002:a1f:5fd5:: with SMTP id t204mr9691323vkb.6.1610714142023;
 Fri, 15 Jan 2021 04:35:42 -0800 (PST)
MIME-Version: 1.0
References: <20210113201601.14874-1-ilina@codeaurora.org> <20210113201601.14874-3-ilina@codeaurora.org>
In-Reply-To: <20210113201601.14874-3-ilina@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 Jan 2021 13:35:04 +0100
Message-ID: <CAPDyKFqbaX9KbtJ3x9cB=coqEp9BwLG7UkAm=YhH4p2dZmvOVg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] PM / Domains: use device's next wakeup to
 determine domain idle state
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 13 Jan 2021 at 21:16, Lina Iyer <ilina@codeaurora.org> wrote:
>
> Currently, a PM domain's idle state is determined based on whether the
> QoS requirements are met. However, even entering an idle state may waste
> power if the minimum residency requirements aren't fulfilled.
>
> CPU PM domains use the next timer wakeup for the CPUs in the domain to
> determine the sleep duration of the domain. This is compared with the
> idle state residencies to determine the optimal idle state. For other PM
> domains, determining the sleep length is not that straight forward. But
> if the device's next_event is available, we can use that to determine
> the sleep duration of the PM domain.
>
> Let's update the domain governor logic to check for idle state residency
> based on the next wakeup of devices as well as QoS constraints. But
> since, not all domains may contain devices capable of specifying the
> next wakeup, let's enable this additional check only if specified by the
> domain's flags when initializing the domain.
>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>

A minor comment about white spaces, see below. With that fixed, please add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> Changes in v7:
>         - Define GENPD_FLAG_MIN_RESIDENCY and check for min residency
>           only if the flag is set.
>         - Update commit text.
> Changes in v6:
>         - Do not include power_on_latency_ns for next_wakeup
>           determination.
>         - Re-organize code to avoid multiple ktime_get() reads.
>         - Check genpd flag if next_wakeup is useful for the domain.
>         - Document why we ignore stale data
> Changes in v5:
>         - Minor code changes suggested by Rafel
> Changes in v4:
>         - Update to use next_wakeup from struct generic_pm_domain_data.
> Changes in v3:
>         - None
> Changes in v2:
>         - Fix state_idx type to hold negative value.
>         - Update commit text.
> ---
>  drivers/base/power/domain_governor.c | 102 ++++++++++++++++++++++++---
>  include/linux/pm_domain.h            |  18 +++--
>  2 files changed, 105 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> index 490ed7deb99a..c6c218758f0b 100644
> --- a/drivers/base/power/domain_governor.c
> +++ b/drivers/base/power/domain_governor.c
> @@ -117,6 +117,55 @@ static bool default_suspend_ok(struct device *dev)
>         return td->cached_suspend_ok;
>  }
>
> +static void update_domain_next_wakeup(struct generic_pm_domain *genpd, ktime_t now)
> +{
> +       ktime_t domain_wakeup = KTIME_MAX;
> +       ktime_t next_wakeup;
> +       struct pm_domain_data *pdd;
> +       struct gpd_link *link;
> +
> +       if (!(genpd->flags & GENPD_FLAG_MIN_RESIDENCY))
> +               return;
> +
> +       /*
> +        * Devices that have a predictable wakeup pattern, may specify
> +        * their next wakeup. Let's find the next wakeup from all the
> +        * devices attached to this domain and from all the sub-domains.
> +        * It is possible that component's a next wakeup may have become
> +        * stale when we read that here. We will ignore to ensure the domain
> +        * is able to enter its optimal idle state.
> +        */
> +       list_for_each_entry(pdd, &genpd->dev_list, list_node) {
> +               next_wakeup = to_gpd_data(pdd)->next_wakeup;
> +               if (next_wakeup != KTIME_MAX && !ktime_before(next_wakeup, now))
> +                       if (ktime_before(next_wakeup, domain_wakeup))
> +                               domain_wakeup = next_wakeup;
> +       }
> +
> +       list_for_each_entry(link, &genpd->parent_links, parent_node) {
> +               next_wakeup = link->child->next_wakeup;
> +               if (next_wakeup != KTIME_MAX && !ktime_before(next_wakeup, now))
> +                       if (ktime_before(next_wakeup, domain_wakeup))
> +                               domain_wakeup = next_wakeup;
> +       }
> +
> +       genpd->next_wakeup = domain_wakeup;
> +}
> +
> +static bool next_wakeup_allows_state(struct generic_pm_domain *genpd,
> +                                    unsigned int state, ktime_t now)
> +{
> +       ktime_t domain_wakeup = genpd->next_wakeup;
> +       s64 idle_time_ns, min_sleep_ns;
> +
> +       min_sleep_ns = genpd->states[state].power_off_latency_ns +
> +                      genpd->states[state].residency_ns;
> +
> +       idle_time_ns = ktime_to_ns(ktime_sub(domain_wakeup, now));
> +
> +       return idle_time_ns >= min_sleep_ns;
> +}
> +
>  static bool __default_power_down_ok(struct dev_pm_domain *pd,
>                                      unsigned int state)
>  {
> @@ -201,16 +250,41 @@ static bool __default_power_down_ok(struct dev_pm_domain *pd,
>  }
>
>  /**
> - * default_power_down_ok - Default generic PM domain power off governor routine.
> + * _default_power_down_ok - Default generic PM domain power off governor routine.
>   * @pd: PM domain to check.
>   *
>   * This routine must be executed under the PM domain's lock.
>   */
> -static bool default_power_down_ok(struct dev_pm_domain *pd)
> +static bool _default_power_down_ok(struct dev_pm_domain *pd, ktime_t now)
>  {
>         struct generic_pm_domain *genpd = pd_to_genpd(pd);
> +       int state_idx = genpd->state_count - 1;
>         struct gpd_link *link;
>
> +       /*
> +        * Find the next wakeup from devices that can determine their own wakeup
> +        * to find when the domain would wakeup and do it for every device down
> +        * the hierarchy. It is not worth while to sleep if the state's residency
> +        * cannot be met.
> +        */
> +       update_domain_next_wakeup(genpd, now);
> +       if ((genpd->flags & GENPD_FLAG_MIN_RESIDENCY) && (genpd->next_wakeup != KTIME_MAX)) {
> +               /* Let's find out the deepest domain idle state, the devices prefer */
> +               while (state_idx >= 0) {
> +                       if (next_wakeup_allows_state(genpd, state_idx, now)) {
> +                               genpd->max_off_time_changed = true;
> +                               break;
> +                       }
> +                       state_idx--;
> +               }
> +
> +               if (state_idx < 0) {
> +                       state_idx = 0;
> +                       genpd->cached_power_down_ok = false;
> +                       goto done;
> +               }
> +       }
> +
>         if (!genpd->max_off_time_changed) {
>                 genpd->state_idx = genpd->cached_power_down_state_idx;
>                 return genpd->cached_power_down_ok;
> @@ -228,21 +302,30 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
>         genpd->max_off_time_ns = -1;
>         genpd->max_off_time_changed = false;
>         genpd->cached_power_down_ok = true;
> -       genpd->state_idx = genpd->state_count - 1;
>
> -       /* Find a state to power down to, starting from the deepest. */
> -       while (!__default_power_down_ok(pd, genpd->state_idx)) {
> -               if (genpd->state_idx == 0) {
> +       /*
> +        * Find a state to power down to, starting from the state
> +        * determined by the next wakeup.
> +        */
> +       while (!__default_power_down_ok(pd, state_idx)) {
> +               if (state_idx == 0) {
>                         genpd->cached_power_down_ok = false;
>                         break;
>                 }
> -               genpd->state_idx--;
> +               state_idx--;
>         }
>
> +done:
> +       genpd->state_idx = state_idx;
>         genpd->cached_power_down_state_idx = genpd->state_idx;
>         return genpd->cached_power_down_ok;
>  }
>
> +static bool default_power_down_ok(struct dev_pm_domain *pd)
> +{
> +       return _default_power_down_ok(pd, ktime_get());
> +}
> +
>  static bool always_on_power_down_ok(struct dev_pm_domain *domain)
>  {
>         return false;
> @@ -254,11 +337,12 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>         struct generic_pm_domain *genpd = pd_to_genpd(pd);
>         struct cpuidle_device *dev;
>         ktime_t domain_wakeup, next_hrtimer;
> +       ktime_t now = ktime_get();
>         s64 idle_duration_ns;
>         int cpu, i;
>
>         /* Validate dev PM QoS constraints. */
> -       if (!default_power_down_ok(pd))
> +       if (!_default_power_down_ok(pd, now))
>                 return false;
>
>         if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
> @@ -280,7 +364,7 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>         }
>
>         /* The minimum idle duration is from now - until the next wakeup. */
> -       idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, ktime_get()));
> +       idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, now));
>         if (idle_duration_ns <= 0)
>                 return false;
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 735583c0bc6d..8ff3cac87f88 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -56,13 +56,18 @@
>   *
>   * GENPD_FLAG_RPM_ALWAYS_ON:   Instructs genpd to always keep the PM domain
>   *                             powered on except for system suspend.
> + *
> + * GENPD_FLAG_MIN_RESIDENCY:   Enable the genpd governor to consider its
> + *                             components' next wakeup when determining the
> + *                             optimal idle state.
>   */
> -#define GENPD_FLAG_PM_CLK       (1U << 0)
> -#define GENPD_FLAG_IRQ_SAFE     (1U << 1)
> -#define GENPD_FLAG_ALWAYS_ON    (1U << 2)
> -#define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3)
> -#define GENPD_FLAG_CPU_DOMAIN   (1U << 4)
> -#define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
> +#define GENPD_FLAG_PM_CLK         (1U << 0)
> +#define GENPD_FLAG_IRQ_SAFE       (1U << 1)
> +#define GENPD_FLAG_ALWAYS_ON      (1U << 2)
> +#define GENPD_FLAG_ACTIVE_WAKEUP   (1U << 3)
> +#define GENPD_FLAG_CPU_DOMAIN     (1U << 4)
> +#define GENPD_FLAG_RPM_ALWAYS_ON   (1U << 5)

Looks like the above are white space changes, probably carried forward
from previous versions. Please fix it up.

> +#define GENPD_FLAG_MIN_RESIDENCY   (1U << 6)
>
>  enum gpd_status {
>         GENPD_STATE_ON = 0,     /* PM domain is on */
> @@ -130,6 +135,7 @@ struct generic_pm_domain {
>                                      unsigned int state);
>         struct gpd_dev_ops dev_ops;
>         s64 max_off_time_ns;    /* Maximum allowed "suspended" time. */
> +       ktime_t next_wakeup;    /* Maintained by the domain governor */
>         bool max_off_time_changed;
>         bool cached_power_down_ok;
>         bool cached_power_down_state_idx;
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
