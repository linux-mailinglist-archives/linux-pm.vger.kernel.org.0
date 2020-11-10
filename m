Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D5A2AD302
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 11:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgKJKCM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 05:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729630AbgKJKCK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 05:02:10 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9789DC0613D1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2020 02:02:10 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id x11so6683336vsx.12
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2020 02:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BiQJcafFBQ88xHQcupBP8gBbAXirHmQbPXsm0C0soPA=;
        b=swGXh4YgskAoYgS+bFvYCOedUrJ59J3k6RjlZ51NvY/vID1Np11aGdRB5P4illh34r
         HrfyV/0gB3Wc2zoRo+6I9KbIkWcMDmw4WwxuF0aV9rZjyfNEmICkMZ0mSGQEmJvlViEE
         gZa26atagGogNvTaEplTO7x08/+M/qOn7y1Qc2YCF0XTPLvkQefk1geWNW6nx96nk30g
         RPpTlGbFrh4S66ln2atq6H2DwOuIHDDwyQ1Laqgkb2daJeDClcU3kpHxJIMUdWgdAj26
         gyi+hqQTG59BNuxM5Q2C3pL7uhd5wH/S/pK97kMZcS+pUr2vECw1aeYH0GPUmXqY3PZ9
         tkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BiQJcafFBQ88xHQcupBP8gBbAXirHmQbPXsm0C0soPA=;
        b=OSUijV2HLuv9X2XtR3n+jocQvtaDfKaOjV2ZbjrwC4JJDA7EHb7o1JZOZMg4uTshZT
         MTA/2gawPWX0tLKpj4wPCL/rAy+K7+nhdoTIKjHEv07ipUj5R6BcCy+yRM1oTsSeszO6
         bXEyGskPsFwLVUPWSxG9SC6Ftc6rKUH7+3QxtQBx6Ef7/WvvXQdud1iHyH8uk9yyue60
         xPnLZAMEjpyJ+hcqNrAcQil/6oBjMJry38aq7/RjNJcg3bTLnLQ5B7wBB6i433EYI5CI
         t/yprPYypsqTHoNF5YfByB83lNaPAMk0sq41DZTU1ks8WxfDh19ak6rVZk/+TjW2ziNw
         xsig==
X-Gm-Message-State: AOAM531QtcLzRAgWVUwojVWn7dianUJOvCDsS/0Dc4FkOXpHroUKLXlL
        nUCvbafirgpFix3S6dTG4wVM2Eafan+JDnT3nQNZRuR0Al1C2wEO
X-Google-Smtp-Source: ABdhPJzpW7ANGH4Bj5CGi0nKYo81ZP/qeLT1maxK3GX8rS2j5Nul7J9iXVR9Zh3D+Xb0H3ZnifDkxnH6BuclLxBEOZ4=
X-Received: by 2002:a67:310d:: with SMTP id x13mr11216949vsx.19.1605002529404;
 Tue, 10 Nov 2020 02:02:09 -0800 (PST)
MIME-Version: 1.0
References: <20201106164811.3698-1-ilina@codeaurora.org> <20201106164811.3698-3-ilina@codeaurora.org>
 <CAPDyKFrv-3USmNLR3gjgaTEuTrWuYZjs3qCtnjxSOWqrxv5qsA@mail.gmail.com> <X6l/OcHG37HzgFL8@codeaurora.org>
In-Reply-To: <X6l/OcHG37HzgFL8@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Nov 2020 11:01:32 +0100
Message-ID: <CAPDyKFr8fdbMM1nsx-RZcMVtveJUP3p38z=HkL1T2C=QgM3gkQ@mail.gmail.com>
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

On Mon, 9 Nov 2020 at 18:41, Lina Iyer <ilina@codeaurora.org> wrote:
>
> On Mon, Nov 09 2020 at 08:27 -0700, Ulf Hansson wrote:
> >On Fri, 6 Nov 2020 at 17:48, Lina Iyer <ilina@codeaurora.org> wrote:
> >>
> [...]
> >> +static void update_domain_next_wakeup(struct generic_pm_domain *genpd, ktime_t now)
> >> +{
> >> +       ktime_t domain_wakeup = KTIME_MAX;
> >> +       ktime_t next_wakeup;
> >> +       struct pm_domain_data *pdd;
> >> +       struct gpd_link *link;
> >> +
> >> +       /* Find the earliest wakeup for all devices in the domain */
> >> +       list_for_each_entry(pdd, &genpd->dev_list, list_node) {
> >> +               next_wakeup = to_gpd_data(pdd)->next_wakeup;
> >> +               if (next_wakeup != KTIME_MAX && !ktime_before(next_wakeup, now))
> >> +                       if (ktime_before(next_wakeup, domain_wakeup))
> >> +                               domain_wakeup = next_wakeup;
> >
> >If it turns out that one of the device's next_wakeup is before "now",
> >leading to ktime_before() above returns true - then I think you should
> >bail out, no?
> >
> >At least, we shouldn't just continue and ignore this case, right?
> >
> No, that could be a very common case. Drivers are not expected to clean
> up the next wakeup by setting it to KTIME_MAX. The best we can do is
> to make a choice with the valid information we have. This will also map
> to the current behavior. Say if all next wakeup information provided to
> the devices were in the past, we would be no worse (or better) than what
> we do without this change.

Well, I don't quite agree (at least not yet), but let me elaborate, as
I think we can do better without having to add complexity.

Normally, I don't think a driver needs to clean up its device's next
wakeup in between the remote wakeups, instead it should just set a new
value.

That's because, even if the driver acts to a remote wakeup or deals
with a request entering a queue, the driver needs to runtime resume
its device during this period. This prevents genpd from power off the
PM domain, hence also the genpd governor from potentially looking at
"invalid" wakeup information for its attached devices.

Of course, I assume there are situations, where a driver actually
needs to do a clean up of its device's next wakeup, but that should be
less frequent and likely when a remote wakeup is disabled (for
whatever reason).

>
> >> +       }
> >> +
> >> +       /* Then find the earliest wakeup of from all the child domains */
> >> +       list_for_each_entry(link, &genpd->parent_links, parent_node) {
> >> +               next_wakeup = link->child->next_wakeup;
> >> +               if (next_wakeup != KTIME_MAX && !ktime_before(next_wakeup, now))
> >> +                       if (ktime_before(next_wakeup, domain_wakeup))
> >> +                               domain_wakeup = next_wakeup;
> >> +       }
> >> +
> >> +       genpd->next_wakeup = domain_wakeup;
> >> +}
> >> +
> >> +static bool next_wakeup_allows_state(struct generic_pm_domain *genpd,
> >> +                                    unsigned int state, ktime_t now)
> >> +{
> >> +       ktime_t domain_wakeup = genpd->next_wakeup;
> >> +       s64 idle_time_ns, min_sleep_ns;
> >> +
> >> +       min_sleep_ns = genpd->states[state].power_off_latency_ns +
> >> +                      genpd->states[state].power_on_latency_ns +
> >> +                      genpd->states[state].residency_ns;
> >> +
> >
> >I don't think you should include the power_on_latency_ns here.
> >
> >The validation isn't about QoS constraints, but whether we can meet
> >the residency time to make it worth entering the state, from an energy
> >point of view. Right?
> >
> Fair point. I will remove the power_on_latency_ns.
>
> >> +       idle_time_ns = ktime_to_ns(ktime_sub(domain_wakeup, now));
> >> +
> >> +       return idle_time_ns >= min_sleep_ns;
> >> +}
> >> +
> >>  static bool __default_power_down_ok(struct dev_pm_domain *pd,
> >>                                      unsigned int state)
> >>  {
> >> @@ -209,8 +250,34 @@ static bool __default_power_down_ok(struct dev_pm_domain *pd,
> >>  static bool default_power_down_ok(struct dev_pm_domain *pd)
> >>  {
> >>         struct generic_pm_domain *genpd = pd_to_genpd(pd);
> >> +       int state_idx = genpd->state_count - 1;
> >> +       ktime_t now = ktime_get();
> >>         struct gpd_link *link;
> >>
> >> +       /*
> >> +        * Find the next wakeup from devices that can determine their own wakeup
> >> +        * to find when the domain would wakeup and do it for every device down
> >> +        * the hierarchy. It is not worth while to sleep if the state's residency
> >> +        * cannot be met.
> >> +        */
> >> +       update_domain_next_wakeup(genpd, now);
> >> +       if (genpd->next_wakeup != KTIME_MAX) {
> >> +               /* Let's find out the deepest domain idle state, the devices prefer */
> >> +               while (state_idx >= 0) {
> >> +                       if (next_wakeup_allows_state(genpd, state_idx, now)) {
> >> +                               genpd->max_off_time_changed = true;
> >> +                               break;
> >> +                       }
> >> +                       state_idx--;
> >> +               }
> >> +
> >> +               if (state_idx < 0) {
> >> +                       state_idx = 0;
> >> +                       genpd->cached_power_down_ok = false;
> >> +                       goto done;
> >> +               }
> >> +       }
> >> +
> >
> >The above would introduce unnecessary overhead, as it may become
> >executed in cases when it's not needed.
> >
> >For example, there's no point doing the above, if the domain doesn't
> >specify residency values for its idle states.
> >
> We would still need to ensure that the next wakeup is after the
> power_off_latency, if specified.

Good point! Although, I would rather avoid adding the overhead, unless
the residency is specified. Do you see a problem with this approach?

Another option is to add a new governor, but if possible, I would like
to avoid that.

>
> >Additionally, we don't need to recompute the domain's next wakup,
> >unless a device has got a new next_wakeup value set for it. In this
> >case, we can just select a state based upon an previously computed
> >value, thus avoiding the recomputation.
> >
> If the domain's next wakeup was in the past, then using our previously
> computed state may be incorrect.

I am not saying you should use the previously computed *idlestate*,
but the previously computed next wakeup.

>
> >>         if (!genpd->max_off_time_changed) {
> >>                 genpd->state_idx = genpd->cached_power_down_state_idx;
> >>                 return genpd->cached_power_down_ok;
> >> @@ -228,17 +295,21 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
> >>         genpd->max_off_time_ns = -1;
> >>         genpd->max_off_time_changed = false;
> >>         genpd->cached_power_down_ok = true;
> >> -       genpd->state_idx = genpd->state_count - 1;
> >>
> >> -       /* Find a state to power down to, starting from the deepest. */
> >> -       while (!__default_power_down_ok(pd, genpd->state_idx)) {
> >> -               if (genpd->state_idx == 0) {
> >> +       /*
> >> +        * Find a state to power down to, starting from the state
> >> +        * determined by the next wakeup.
> >> +        */
> >> +       while (!__default_power_down_ok(pd, state_idx)) {
> >> +               if (state_idx == 0) {
> >>                         genpd->cached_power_down_ok = false;
> >>                         break;
> >>                 }
> >> -               genpd->state_idx--;
> >> +               state_idx--;
> >>         }
> >>
> >> +done:
> >> +       genpd->state_idx = state_idx;
> >>         genpd->cached_power_down_state_idx = genpd->state_idx;
> >>         return genpd->cached_power_down_ok;
> >>  }
> >
> >Another thing to consider for the above changes, is that the
> >cpu_power_down_ok() calls into default_power_down_ok().
> >
> >Even if I am fine with the approach taken in $subject patch, I think
> >it's important to try to keep the path a slim as possible as it's also
> >executed in the CPU idlepath.
> Wouldn't this be called only the last CPU is powering down and only if
> the domain is ready to power down?
>
> >For example, $subject change means also
> >that we end up calling ktime_get() twice in the same path, introducing
> >unnecessary overhead. We can do better and avoid that by restructuring
> >the code a bit, don't you think?
> >
> Hmmm, we could. I will submit a follow on patch to reorganize the code
> so the ktime_get() would be called only once for either of the
> power_down_ok callbacks.

If possible, I would rather make it part of the series. Just fold in
some "rework" patch before extending the governor, that should be
possible I think.

Kind regards
Uffe
