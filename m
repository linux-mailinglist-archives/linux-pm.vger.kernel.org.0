Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1437F2A8682
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 19:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgKES4q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 13:56:46 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34764 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgKES4p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 13:56:45 -0500
Received: by mail-oi1-f194.google.com with SMTP id z26so2785093oid.1;
        Thu, 05 Nov 2020 10:56:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w1ifJAXyezyeuSWKY8kW4K45SYrEzUhk1OhBKGBp35g=;
        b=qBGZx2S2JF/KtWfPV2y584fGPHfWYVtFWYYZlNVbjluWcHbpKsrXN8DRcozMZnjBgy
         loQbIGca+d0LI57kDnlluHmjeWyWQxyY624Ue3rMykioTHJTWj6gRrA7I3EkxMgDI3Fg
         1m4LUAvvGADo9SIA8iX/pbw0NW0+IExz+9Z54nXd+D1ukoWBe22ZwVthIgRQyKsWm/UC
         0Apr89+FCOiHAnyRr1WGwJmooTOEWqJJFRwfW8jntngUn9Q8T1gsWQzImVrbRDu2UbaG
         rND1FiM7Bx2Y55AN52EDIXy+QH/usas1muKyhxQaS4CBPJLv3N1V8xWmXC1GjmDUb5J1
         DM6Q==
X-Gm-Message-State: AOAM530zZAvAx0qSLc+k4LSTGz5D0zemcdfiMEr+0yrXUZWEsUYLiqwG
        KqUiQgt4xvYpeze2URSt/XOuulx2kF0EulSzaDM=
X-Google-Smtp-Source: ABdhPJwBsyzJDRGTnN/buTPA5WkQhwojl+WmizXPKkZ995dU0nPTjBLGRTxnlSLIPsuka6xw/LLn60Jnr8fUMpPxQSI=
X-Received: by 2002:aca:cf4b:: with SMTP id f72mr516445oig.157.1604602604323;
 Thu, 05 Nov 2020 10:56:44 -0800 (PST)
MIME-Version: 1.0
References: <20201020180413.32225-1-ilina@codeaurora.org> <20201020180413.32225-3-ilina@codeaurora.org>
In-Reply-To: <20201020180413.32225-3-ilina@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Nov 2020 19:56:33 +0100
Message-ID: <CAJZ5v0gTA=_QOFJLMCxH+CqfDFKUJU5ZbpN2+DHLTP1gKg3HQg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] PM / Domains: use device's next wakeup to
 determine domain idle state
To:     Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 20, 2020 at 8:05 PM Lina Iyer <ilina@codeaurora.org> wrote:
>
> Currently, a PM domain's idle state is determined based on whether the
> QoS requirements are met. This may not save power, if the idle state
> residency requirements are not met.
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
>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>

A few nits follow.

> ---
> Changes in v4:
>         - Update to use next_wakeup from struct generic_pm_domain_data.
> Changes in v3:
>         - None
> Changes in v2:
>         - Fix state_idx type to hold negative value.
>         - Update commit text.
> ---
>  drivers/base/power/domain_governor.c | 84 ++++++++++++++++++++++++++--
>  include/linux/pm_domain.h            |  1 +
>  2 files changed, 80 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> index 490ed7deb99a..092927b60dc0 100644
> --- a/drivers/base/power/domain_governor.c
> +++ b/drivers/base/power/domain_governor.c
> @@ -117,6 +117,49 @@ static bool default_suspend_ok(struct device *dev)
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
> +       /* Find the earliest wakeup for all devices in the domain */
> +       list_for_each_entry(pdd, &genpd->dev_list, list_node) {
> +               next_wakeup = to_gpd_data(pdd)->next_wakeup;
> +               if (next_wakeup != KTIME_MAX && !ktime_before(next_wakeup, now))
> +                       if (ktime_before(next_wakeup, domain_wakeup))
> +                               domain_wakeup = next_wakeup;
> +       }
> +
> +       /* Then find the earliest wakeup of from all the child domains */
> +       list_for_each_entry(link, &genpd->parent_links, parent_node) {
> +               next_wakeup = link->child->next_wakeup;
> +               if (next_wakeup != KTIME_MAX && !ktime_before(next_wakeup, now))
> +                       if (ktime_before(next_wakeup, domain_wakeup))
> +                               domain_wakeup = next_wakeup;
> +       }

This is assuming that the lists will remain stable during the walks
above, but is that guaranteed?

> +
> +       genpd->next_wakeup = domain_wakeup;
> +}
> +
> +static bool next_wakeup_allows_state(struct generic_pm_domain *genpd,
> +                                    unsigned int state, ktime_t now)
> +{
> +       s64 idle_time_ns, min_sleep_ns;
> +       ktime_t domain_wakeup = genpd->next_wakeup;

I'd move the second line to the top (it looks odd now IMO).

> +
> +       min_sleep_ns = genpd->states[state].power_off_latency_ns +
> +                      genpd->states[state].power_on_latency_ns +
> +                      genpd->states[state].residency_ns;
> +
> +       idle_time_ns = ktime_to_ns(ktime_sub(domain_wakeup, now));
> +       if (idle_time_ns < min_sleep_ns)
> +               return false;
> +
> +       return true;

Why not

+       return idle_time_ns >= min_sleep_ns;

> +}
> +
>  static bool __default_power_down_ok(struct dev_pm_domain *pd,
>                                      unsigned int state)
>  {
> @@ -210,6 +253,33 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
>  {
>         struct generic_pm_domain *genpd = pd_to_genpd(pd);
>         struct gpd_link *link;
> +       int state_idx;

Why not initialize it right away?

> +       ktime_t now = ktime_get();
> +
> +       /*
> +        * Find the next wakeup from devices that can determine their own wakeup
> +        * to find when the domain would wakeup and do it for every device down
> +        * the hierarchy. It is not worth while to sleep if the state's residency
> +        * cannot be met.
> +        */
> +       update_domain_next_wakeup(genpd, now);
> +       state_idx = genpd->state_count - 1;
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
>
>         if (!genpd->max_off_time_changed) {
>                 genpd->state_idx = genpd->cached_power_down_state_idx;
> @@ -228,17 +298,21 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
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
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index e00c77b1efd8..205b750a2e56 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -130,6 +130,7 @@ struct generic_pm_domain {
>                                      unsigned int state);
>         struct gpd_dev_ops dev_ops;
>         s64 max_off_time_ns;    /* Maximum allowed "suspended" time. */
> +       ktime_t next_wakeup;    /* Maintained by the domain governor */
>         bool max_off_time_changed;
>         bool cached_power_down_ok;
>         bool cached_power_down_state_idx;
> --
