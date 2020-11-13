Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B359C2B191F
	for <lists+linux-pm@lfdr.de>; Fri, 13 Nov 2020 11:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgKMKeb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Nov 2020 05:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgKMKe2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Nov 2020 05:34:28 -0500
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BB0C0613D1
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2020 02:34:28 -0800 (PST)
Received: by mail-vk1-xa41.google.com with SMTP id m184so2017033vkb.9
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2020 02:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PALuAB8oVM/m0G/j2UGrrN/OBz7MMaWqElt/6b/dyFE=;
        b=XOoELJ6mcWARstsXGUsmNAxUtzYyAhmn3p0LrYrwIfX4ZVVANvpN7eTiqCFLe4CQF1
         ADYVZ/egyZqjAEtf3UcsleDaK5r8VENpUkUsvdpPYHul66b4cFYJ/o3x2uA/DsVjVd1b
         mp0ikEcMIwhBtBqKzgbHzoA06R0WPM4ls95pkaK3oLEBrXtrAT76M2bHCj0oW+Wfq3bY
         psZp/2xJZBIizcTuQP8mXq6R5++B3kMM1GIyDu0Y0UbCKLDZqxouZayWstNmmuJcXzE/
         ioEYz7kLRvbjdV8ZeVT70O0BexBtRu1r71TlvveuypmnnvZqLnr+HDBb/9TwrHvqd7h1
         GDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PALuAB8oVM/m0G/j2UGrrN/OBz7MMaWqElt/6b/dyFE=;
        b=nJn0itEckkYkqZIfl5a2CbK5qp4UynSqq0JKyvfsMh8hoe6S+XnyIiEJ607DzJMEml
         7VLlg7I/VHnZwX5EurUNRqILC5yourRvqXaH3cJZuwKscrNGFopd0EiAr+hlCXLx4GhZ
         oJtB+v3CpPBIhgxmd29iP8S020syzJ8/Wh3wN5NdhInk5oJJs3tSgoq0H2moVL70PMO3
         R9FnPmadfLN2gk8rB8aJzAAp6fKK2sPYwip0DxZZ+Hb/oumQD13/qNRWQr7/usx+ckGN
         2A66z0K94EX1S5FuxXxooqGMrgHY17PiHacVht5GUb99qhLP13xrcfGHyNgnAeV5atdY
         HgQQ==
X-Gm-Message-State: AOAM5323G9+HMP9cT6x/6pla7EJXxxzjRuZ1yHLtO/JnmKNpJG0J9Zor
        mXChAOMvFdZDXl7TYtGTeO9evu1Ibu2QjmkO629zww==
X-Google-Smtp-Source: ABdhPJyxI3qvgFgCh3w8nJ3N3pxqYhJg0jmIPKkvwU7Ca7HGf127m4ZwT5G5cD8ykpX5DVq+0rKJSnnpeorUP3WcqH0=
X-Received: by 2002:a1f:8f48:: with SMTP id r69mr659677vkd.6.1605263667043;
 Fri, 13 Nov 2020 02:34:27 -0800 (PST)
MIME-Version: 1.0
References: <20201106164811.3698-1-ilina@codeaurora.org> <20201106164811.3698-3-ilina@codeaurora.org>
 <CAPDyKFrv-3USmNLR3gjgaTEuTrWuYZjs3qCtnjxSOWqrxv5qsA@mail.gmail.com>
 <X6l/OcHG37HzgFL8@codeaurora.org> <CAPDyKFr8fdbMM1nsx-RZcMVtveJUP3p38z=HkL1T2C=QgM3gkQ@mail.gmail.com>
 <X6wRBLmvzztNai4y@codeaurora.org>
In-Reply-To: <X6wRBLmvzztNai4y@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 13 Nov 2020 11:33:50 +0100
Message-ID: <CAPDyKFr9gpH9Kh9=W4D7DRG8OuqBvkaWHvk8i47SToES=338cA@mail.gmail.com>
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

On Wed, 11 Nov 2020 at 17:51, Lina Iyer <ilina@codeaurora.org> wrote:
>
> On Tue, Nov 10 2020 at 03:02 -0700, Ulf Hansson wrote:
> >On Mon, 9 Nov 2020 at 18:41, Lina Iyer <ilina@codeaurora.org> wrote:
> >>
> >> On Mon, Nov 09 2020 at 08:27 -0700, Ulf Hansson wrote:
> >> >On Fri, 6 Nov 2020 at 17:48, Lina Iyer <ilina@codeaurora.org> wrote:
> >> >>
> >> [...]
> >> >> +static void update_domain_next_wakeup(struct generic_pm_domain *genpd, ktime_t now)
> >> >> +{
> >> >> +       ktime_t domain_wakeup = KTIME_MAX;
> >> >> +       ktime_t next_wakeup;
> >> >> +       struct pm_domain_data *pdd;
> >> >> +       struct gpd_link *link;
> >> >> +
> >> >> +       /* Find the earliest wakeup for all devices in the domain */
> >> >> +       list_for_each_entry(pdd, &genpd->dev_list, list_node) {
> >> >> +               next_wakeup = to_gpd_data(pdd)->next_wakeup;
> >> >> +               if (next_wakeup != KTIME_MAX && !ktime_before(next_wakeup, now))
> >> >> +                       if (ktime_before(next_wakeup, domain_wakeup))
> >> >> +                               domain_wakeup = next_wakeup;
> >> >
> >> >If it turns out that one of the device's next_wakeup is before "now",
> >> >leading to ktime_before() above returns true - then I think you should
> >> >bail out, no?
> >> >
> >> >At least, we shouldn't just continue and ignore this case, right?
> >> >
> >> No, that could be a very common case. Drivers are not expected to clean
> >> up the next wakeup by setting it to KTIME_MAX. The best we can do is
> >> to make a choice with the valid information we have. This will also map
> >> to the current behavior. Say if all next wakeup information provided to
> >> the devices were in the past, we would be no worse (or better) than what
> >> we do without this change.
> >
> >Well, I don't quite agree (at least not yet), but let me elaborate, as
> >I think we can do better without having to add complexity.
> >
> >Normally, I don't think a driver needs to clean up its device's next
> >wakeup in between the remote wakeups, instead it should just set a new
> >value.
> >
> >That's because, even if the driver acts to a remote wakeup or deals
> >with a request entering a queue, the driver needs to runtime resume
> >its device during this period. This prevents genpd from power off the
> >PM domain, hence also the genpd governor from potentially looking at
> >"invalid" wakeup information for its attached devices.
> >
> Could you elaborate a bit? Why would a remote wakeup affect the next
> wakeup. I'm afraid that I'm not getting the situation correctly.

Let me try :-)

A remote wakeup is a wakeup irq that is triggered when the device is
in runtime suspended state.

I was expecting that you would be arming a remote wakeup for the
corresponding device that is attached to a genpd, when the use case
becomes enabled. Additionally, to allow the driver to consume the
wakeup irq, it needs to runtime resume its device (which means its PM
domain via genpd must be powered on as well, if it's not on already).

Therefore, during the period of when the driver consumes the wakeup
irq, its device's PM domain remains powered on. When this is
completed, the driver allows its device to become runtime suspended
again. At some point before the device becomes runtime suspended, the
driver should set a new value of the "next wakeup" for its device.

>
> >Of course, I assume there are situations, where a driver actually
> >needs to do a clean up of its device's next wakeup, but that should be
> >less frequent and likely when a remote wakeup is disabled (for
> >whatever reason).
> >
> A common case would be that the driver does not know when the usecase is
> being turned off and therefore may not be able to set the next wakeup to
> max. If the stale value continues to exist then we may never power off
> the domain.

Right.

But, how do you know that the use case starts and what prevents us
from knowing that the use case has stopped?

Maybe if you add a user of the new APIs, this would help me to
understand better?

>
> >> >> +       /*
> >> >> +        * Find the next wakeup from devices that can determine their own wakeup
> >> >> +        * to find when the domain would wakeup and do it for every device down
> >> >> +        * the hierarchy. It is not worth while to sleep if the state's residency
> >> >> +        * cannot be met.
> >> >> +        */
> >> >> +       update_domain_next_wakeup(genpd, now);
> >> >> +       if (genpd->next_wakeup != KTIME_MAX) {
> >> >> +               /* Let's find out the deepest domain idle state, the devices prefer */
> >> >> +               while (state_idx >= 0) {
> >> >> +                       if (next_wakeup_allows_state(genpd, state_idx, now)) {
> >> >> +                               genpd->max_off_time_changed = true;
> >> >> +                               break;
> >> >> +                       }
> >> >> +                       state_idx--;
> >> >> +               }
> >> >> +
> >> >> +               if (state_idx < 0) {
> >> >> +                       state_idx = 0;
> >> >> +                       genpd->cached_power_down_ok = false;
> >> >> +                       goto done;
> >> >> +               }
> >> >> +       }
> >> >> +
> >> >
> >> >The above would introduce unnecessary overhead, as it may become
> >> >executed in cases when it's not needed.
> >> >
> >> >For example, there's no point doing the above, if the domain doesn't
> >> >specify residency values for its idle states.
> >> >
> >> We would still need to ensure that the next wakeup is after the
> >> power_off_latency, if specified.
> >
> >Good point! Although, I would rather avoid adding the overhead, unless
> >the residency is specified. Do you see a problem with this approach?
> >
> Hmmm, no strong objections. However, we still need to run through the
> states to make sure the residency is not set and have a variable track
> that.

Right.

The important part is that we can do that once and not for every call
to the governor.

> The devices wouldn't know that and would still continue to set the
> next wakeup, unless we find a way to let them know we are not using this
> feature for the domain.

Right.

To allow the driver to know, we could respond with an error code from
the new dev_pm_genpd_set_performance_state() API (from patch1), in
case the genpd+governor doesn't support it.

Would that be okay? Otherwise we will have to add a separate genpd
API, asking explicitly if the "next wakeup" feature is supported.

>
> >Another option is to add a new governor, but if possible, I would like
> >to avoid that.
> >
> Absolutely, we should avoid that.
>

[...]

Kind regards
Uffe
