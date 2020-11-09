Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F322ABFCE
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 16:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbgKIP12 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 10:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729776AbgKIP12 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 10:27:28 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279F7C0613D3
        for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2020 07:27:27 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id t15so2894358ual.6
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2020 07:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4J+JtdzcqCLAtZ83Elky9kDUV5yV0O2w8QP6FFZaWaI=;
        b=EeBdXL1hcXjvGUgAbmddh1h2E1oU5b9U9uJELyXIU3uEAs1QkEGO5syvSal2vlWszw
         BKVnmQIQw/9z57pAkU7hICgLw8C7jghA9zDARO7hiRnw4jFVTvYgbTYpHPZDPi8JAnFk
         F0ixdwmXKBfI47zwuQn1p6jmRm4GnRusgTd2lDbn+JoOggNyh4CwYKEqTuNbpy2bG9wU
         Tx63F94cvjf2+E5H4c0AcfJ/FJ++v8QqfsDfw/W+/mC90wYNGqyiE/doF5tKpRgd818K
         tGLOfCqv4qy25ChTGN6Y3/NVBicbJtg7cKoydzHEkl4LIWEUMhmebKtlBdr1TfGmpKnX
         Fs0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4J+JtdzcqCLAtZ83Elky9kDUV5yV0O2w8QP6FFZaWaI=;
        b=X9RBwJp6IEkg7q40O+WTsEvsBIKQa/Mr9gQlmirtr/Q6L7sQDROSUqpxeFr1ssHxvY
         gqx74iPSiW9KggJyM3fU7K+KItvS0XRQpEvdbEMK2CI92/VXHdjybcvfehtcgyeB7aex
         N9htv2JbIyf2k9qT1QWvmzejXFWw2RI3P1Cy0SewwA1IA05svIhTHSWunQ4SD3ywTScZ
         DaQCUqQUmRhjIr5n0fMB+BKzAFw+yZ5r7FDMyooaiKbGUTnMUBLjDgqqEzE68j7TdsrW
         z8bAcXLwqIiIabX9DVOBZer4VtjHWbfURy8a23dA49qmWh+0Fyaj/BQxj/lXbXl4EmQv
         B7hg==
X-Gm-Message-State: AOAM531dhPHoTtZhxGvrl32idYYSXKL0sqCAZoy1axjPv5E+GUCK2pwR
        uVCdxgBrUjsMDC6fUc/qTYwneM/2X0zI2VO/yJnTNrkagkD91g==
X-Google-Smtp-Source: ABdhPJzHGNFmtChYrtFKqLbtVBqX8opkaapANxk7Gtk9mP+7zFq6tkzkmdCEPqBNf08YmqjEw1OmRCuPIhS1NkI/e2k=
X-Received: by 2002:ab0:7103:: with SMTP id x3mr1595095uan.100.1604935646172;
 Mon, 09 Nov 2020 07:27:26 -0800 (PST)
MIME-Version: 1.0
References: <20201106164811.3698-1-ilina@codeaurora.org> <20201106164811.3698-3-ilina@codeaurora.org>
In-Reply-To: <20201106164811.3698-3-ilina@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 9 Nov 2020 16:26:49 +0100
Message-ID: <CAPDyKFrv-3USmNLR3gjgaTEuTrWuYZjs3qCtnjxSOWqrxv5qsA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] PM / Domains: use device's next wakeup to
 determine domain idle state
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 6 Nov 2020 at 17:48, Lina Iyer <ilina@codeaurora.org> wrote:
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
> ---
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
>  drivers/base/power/domain_governor.c | 81 ++++++++++++++++++++++++++--
>  include/linux/pm_domain.h            |  1 +
>  2 files changed, 77 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> index 490ed7deb99a..fee050c6ea6a 100644
> --- a/drivers/base/power/domain_governor.c
> +++ b/drivers/base/power/domain_governor.c
> @@ -117,6 +117,47 @@ static bool default_suspend_ok(struct device *dev)
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

If it turns out that one of the device's next_wakeup is before "now",
leading to ktime_before() above returns true - then I think you should
bail out, no?

At least, we shouldn't just continue and ignore this case, right?

> +       }
> +
> +       /* Then find the earliest wakeup of from all the child domains */
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
> +                      genpd->states[state].power_on_latency_ns +
> +                      genpd->states[state].residency_ns;
> +

I don't think you should include the power_on_latency_ns here.

The validation isn't about QoS constraints, but whether we can meet
the residency time to make it worth entering the state, from an energy
point of view. Right?

> +       idle_time_ns = ktime_to_ns(ktime_sub(domain_wakeup, now));
> +
> +       return idle_time_ns >= min_sleep_ns;
> +}
> +
>  static bool __default_power_down_ok(struct dev_pm_domain *pd,
>                                      unsigned int state)
>  {
> @@ -209,8 +250,34 @@ static bool __default_power_down_ok(struct dev_pm_domain *pd,
>  static bool default_power_down_ok(struct dev_pm_domain *pd)
>  {
>         struct generic_pm_domain *genpd = pd_to_genpd(pd);
> +       int state_idx = genpd->state_count - 1;
> +       ktime_t now = ktime_get();
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

The above would introduce unnecessary overhead, as it may become
executed in cases when it's not needed.

For example, there's no point doing the above, if the domain doesn't
specify residency values for its idle states.

Additionally, we don't need to recompute the domain's next wakup,
unless a device has got a new next_wakeup value set for it. In this
case, we can just select a state based upon an previously computed
value, thus avoiding the recomputation.

>         if (!genpd->max_off_time_changed) {
>                 genpd->state_idx = genpd->cached_power_down_state_idx;
>                 return genpd->cached_power_down_ok;
> @@ -228,17 +295,21 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
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

Another thing to consider for the above changes, is that the
cpu_power_down_ok() calls into default_power_down_ok().

Even if I am fine with the approach taken in $subject patch, I think
it's important to try to keep the path a slim as possible as it's also
executed in the CPU idlepath. For example, $subject change means also
that we end up calling ktime_get() twice in the same path, introducing
unnecessary overhead. We can do better and avoid that by restructuring
the code a bit, don't you think?

> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index d7875bfde7f4..49982cd58bfd 100644
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
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>

Kind regards
Uffe
