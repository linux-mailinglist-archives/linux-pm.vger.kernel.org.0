Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C532E0BEF
	for <lists+linux-pm@lfdr.de>; Tue, 22 Dec 2020 15:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgLVOmo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Dec 2020 09:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbgLVOmo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2020 09:42:44 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35031C0613D6
        for <linux-pm@vger.kernel.org>; Tue, 22 Dec 2020 06:42:04 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id r24so7100600vsg.10
        for <linux-pm@vger.kernel.org>; Tue, 22 Dec 2020 06:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uZVuC7mOUQwg20qUXE2SPIowrALW67Xf4SelCTJWlcU=;
        b=MOfDyibh6L7MFXCHwaeh7aoKcuNGt7nr7c0WWJea1WTV6ZnkANcjmfDsx04GibDGf+
         68PPCqrUvxY6b6Llspp9jnh2RJkg6FnUqHISn5HiLYn1y7fcWKpT8TgOVctZG7fKUDG2
         PUv57y2ipT9MwP/i/P6mHwXryaB77ZC8QFdXzpu6UN2ZMIsbIIWh7JL2dp+6GjBXvgm4
         M7jK7jSI3keINHiuMMQwH0X8Y0oyMqqYJHPfcS3+CWVxog2ZNCoLga67Xqb/+1jU/vc8
         Kbwmt3LrZeOS+0DdnS+JN+ZVY+i/3mO67UC0grnZvxZddAN1Z//YVbehvHivi48D1No7
         Cntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uZVuC7mOUQwg20qUXE2SPIowrALW67Xf4SelCTJWlcU=;
        b=lkRxWbP3fM873CrSFIyhvz6g6/ba3QQASehv8ZbnCNhK8ApkM2VX3wkpNMPfIoQMww
         ovgTPprFEJ7qD5HnDA++n9p6JzO5imjBRhVT1iXxlrHUrRE7Ll+UulHI/Ws8HvlbUkKG
         d2uQKJCzVJkWML/PZ5tTUlHZFUKjE9pS/tdbo+mzua/akZV4vqpHlH4AmuKHj9TNeX/P
         H+rGP54M9fuy7nkslrveLOaXZL8ZBDk5GeaFVU68r+n44QopLKw6E4dyNQ6dasN7mWph
         64J/kcBzdIqUvRzo9l7H3YZidMaK5HK+R+sdxt5c58ZY0UAL2LL28ZCdISyz7QU3NZ89
         hJ+w==
X-Gm-Message-State: AOAM532ciyU1QMKwhDscH2LixJXqh047nk/oVIbCRlgW1vcW1JW+MqD/
        /Nn2nczLh/8Rbkj+t2gUMEIIITBIcTidrXLpjatH/A==
X-Google-Smtp-Source: ABdhPJxUfSKt7UMrKEHIw3RbuBceT4YMkpGxywrsxaKGbQux6As+xFX9H7UHgBavtWqR9qBi9h9B/aiB1MOuARfxCC4=
X-Received: by 2002:a67:fe85:: with SMTP id b5mr14985595vsr.19.1608648123133;
 Tue, 22 Dec 2020 06:42:03 -0800 (PST)
MIME-Version: 1.0
References: <20201130225039.15981-1-ilina@codeaurora.org> <20201130225039.15981-4-ilina@codeaurora.org>
In-Reply-To: <20201130225039.15981-4-ilina@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 22 Dec 2020 15:41:27 +0100
Message-ID: <CAPDyKFoMJYBSE5uW4-fWp5n=xZ5PvqE+6S9_QE5h_9qRBafMNg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] PM / Domains: use device's next wakeup to
 determine domain idle state
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 30 Nov 2020 at 23:50, Lina Iyer <ilina@codeaurora.org> wrote:
>
> Currently, a PM domain's idle state is determined based on whether the
> QoS requirements are met. This may not save power, if the idle state

/s/not save power/waste energy

/state/state's

> residency requirements are not met.

perhaps change to:
"minimum residency requirement can't be fulfilled."

>
> CPU PM domains use the next timer wakeup for the CPUs in the domain to
> determine the sleep duration of the domain. This is compared with the
> idle state residencies to determine the optimal idle state. For other PM
> domains, determining the sleep length is not that straight forward. But
> if the device's next_event is available, we can use that to determine
> the sleep duration of the PM domain.
>
> Let's update the domain governor logic to check for idle state residency
> based on the next wakeup of devices as well as QoS constraints.

I suggest to clarify that this is being done, only when the genpd has
the corresponding config bit/flag set, that was added in patch1.

>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>

Other than the above (and potential updates needed from comments on
patch1 and patch2), this looks good to me!

Kind regards
Uffe

> ---
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
>  include/linux/pm_domain.h            |   1 +
>  2 files changed, 94 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> index 490ed7deb99a..2afb7fa90d5d 100644
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
> +       if (!genpd_may_use_next_wakeup(genpd))
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
> +       if (genpd->next_wakeup != KTIME_MAX) {
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
> index cc27d3d88849..a41aea9d1c06 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -136,6 +136,7 @@ struct generic_pm_domain {
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
