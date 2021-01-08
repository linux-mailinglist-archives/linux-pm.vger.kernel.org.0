Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886922EF072
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jan 2021 11:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbhAHKI7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Jan 2021 05:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbhAHKI7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jan 2021 05:08:59 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00898C0612F4
        for <linux-pm@vger.kernel.org>; Fri,  8 Jan 2021 02:08:18 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id t16so2322399vkl.10
        for <linux-pm@vger.kernel.org>; Fri, 08 Jan 2021 02:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ls70z+SC9u40tzz8LEEvCPh2NSBEEkVviLNQ96+yhBY=;
        b=UAaeUqyYlxch2Jm78HwGKCcXGFW7kR3YVS5YA8Xy8WN1X/yYBjeQt+Fg5vx/4JbR1g
         nXbonJP9oYdaeFsrQs5aw0LQm/UYRDAs6cVSyGUMY+1KO1zi6mCSB3oTjF9w9LcnM7J9
         AyJ9DQ0cJNoxde+qkWFf1TkXPfHIYhx4QcBujoA5saExwCLwKXTtJi562BF+ioU9vnJv
         4eL/btBNEjhZoXS2dnVq5zkoWKwwsGWhrsplvM41DGQ4fjEcZyus1hE6mdC78PhYnB7X
         oWTjtnT9Jc2QvTFBemqA+R4Q88xl1sWdfAwLMYLPrg3TI0sjiCgwO3GUCwR9J5N/n/Qc
         aY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ls70z+SC9u40tzz8LEEvCPh2NSBEEkVviLNQ96+yhBY=;
        b=UFogZ9Nn4o5U/IDu1zv1qiKR2zUzrKsmR25z0Ug/6pDBVS/enFtkNRAU3Oh0ZrKmH6
         rWbsBvmPSX15tnuqrubL55IN9wzo0GwCb1hbH4YQHu0N2W3LRM1V2m97uxPr7fxd1k4K
         5j/V8LKHs17fIT/ezNAfh2DnMAqmYfkt6yt3iaBcNXoNdbYBe9Tfm/+CrKZVtluWsQJl
         LRDua3wMOETiatOWygqs0cknDrJLLHBTq3xjOWp0QifMkAsQf4XBT2Q5MK38tLaH0bCt
         0rRedKeCTUptge4LUNcZ6pCSocj9k+/2hWk7r4vy7XhzLYqnXCBNtLDmT7Kmb09E6Jjo
         VCcA==
X-Gm-Message-State: AOAM530qhxoVleLIJhzxe7I4hQ4EukX/Wu6zrsSwoL5SN5o/cBhL4k2O
        M4ECPjHF+Du5Yh8rfAbW34OFhcVEB1ozWrhM2aSLRJsHr6ULZCPz
X-Google-Smtp-Source: ABdhPJwfeCWb0ImNqT7tH1HSo0C2RQtzudREswquhI4rOLSGKPGBuwyfObkNvfH4IcyRtW+rraGPeFIZNHG+GWdu0k0=
X-Received: by 2002:a1f:4582:: with SMTP id s124mr2128334vka.7.1610100498123;
 Fri, 08 Jan 2021 02:08:18 -0800 (PST)
MIME-Version: 1.0
References: <20201130225039.15981-1-ilina@codeaurora.org> <20201130225039.15981-3-ilina@codeaurora.org>
 <CAPDyKFphczBOyDmSQBh3PE7YaUBYy4Y5uoozrv4QOf4pEbk-yg@mail.gmail.com> <X/M3oB292GCO4vl9@codeaurora.org>
In-Reply-To: <X/M3oB292GCO4vl9@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 8 Jan 2021 11:07:41 +0100
Message-ID: <CAPDyKFoXVjebqbWo=JoK6A2snWOKAnifQ9Cra1VzqjP_14vfYA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] PM / domains: inform PM domain of a device's next wakeup
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 4 Jan 2021 at 16:44, Lina Iyer <ilina@codeaurora.org> wrote:
>
> On Tue, Dec 22 2020 at 06:10 -0700, Ulf Hansson wrote:
> >On Mon, 30 Nov 2020 at 23:51, Lina Iyer <ilina@codeaurora.org> wrote:
> >>
> >> Some devices may have a predictable interrupt pattern while executing
> >> usecases. An example would be the VSYNC interrupt associated with
> >> display devices. A 60 Hz display could cause a interrupt every 16 ms. If
> >> the device were in a PM domain, the domain would need to be powered up
> >> for device to resume and handle the interrupt.
> >>
> >> Entering a domain idle state saves power, only if the residency of the
> >> idle state is met. Without knowing the idle duration of the domain, the
> >> governor would just choose the deepest idle state that matches the QoS
> >> requirements. The domain might be powered off just as the device is
> >> expecting to wake up. If devices could inform PM frameworks of their
> >> next event, the parent PM domain's idle duration can be determined.
> >>
> >> So let's add the dev_pm_genpd_set_next_wakeup() API for the device to
> >> inform PM domains of the impending wakeup. This information will be the
> >> domain governor to determine the best idle state given the wakeup.
> >>
> >> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> >> ---
> >> Changes in v6:
> >>         - Update documentation
> >> Changes in v5:
> >>         - Fix commit text as pointed by Ulf
> >>         - Use -EOPNOTSUPP
> >> Changes in v4:
> >>         - Use PM domain data to store next_wakeup
> >>         - Drop runtime PM documentation
> >> Changes in v3:
> >>         - Fix unwanted change
> >> Changes in v2:
> >>         - Update documentation
> >>         - Remove runtime PM enabled check
> >>         - Update commit text
> >> ---
> >>  drivers/base/power/domain.c | 41 +++++++++++++++++++++++++++++++++++++
> >>  include/linux/pm_domain.h   |  8 ++++++++
> >>  2 files changed, 49 insertions(+)
> >>
> >> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> >> index 1e6c0bf1c945..191539a8e06d 100644
> >> --- a/drivers/base/power/domain.c
> >> +++ b/drivers/base/power/domain.c
> >> @@ -408,6 +408,46 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
> >>  }
> >>  EXPORT_SYMBOL_GPL(dev_pm_genpd_set_performance_state);
> >>
> >> +/**
> >> + * dev_pm_genpd_set_next_wakeup - Notify PM framework of an impending wakeup.
> >> + *
> >> + * @dev: Device to handle
> >> + * @next: impending interrupt/wakeup for the device
> >> + *
> >> + * Allow devices to inform of the next wakeup. But, if the domain were already
> >> + * powered off, we will not wakeup the domain to recompute it's idle duration.
> >
> >How about clarifying this as:
> >
> >"It's assumed that the users guarantee that the genpd wouldn't be
> >detached while this routine is getting called. Additionally, it's also
> >assumed that @dev isn't runtime suspended (RPM_SUSPENDED).
> >
> Sure.
>
> >> + * Although devices are expected to update the next_wakeup after the end of
> >> + * their usecase as well, it is possible the devices themselves may not know
> >> + * about that. Stale @next will be ignored when powering off the domain.
> >> + */
> >> +int dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next)
> >> +{
> >> +       struct generic_pm_domain *genpd;
> >> +       struct generic_pm_domain_data *gpd_data;
> >> +       int ret = -EINVAL;
> >> +
> >> +       genpd = dev_to_genpd_safe(dev);
> >> +       if (!genpd)
> >> +               return -ENODEV;
> >> +
> >> +       if (WARN_ON(!dev->power.subsys_data ||
> >> +                   !dev->power.subsys_data->domain_data))
> >> +               return ret;
> >> +
> >> +       genpd_lock(genpd);
> >> +       gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
> >> +       if (ktime_before(ktime_get(), next)) {
> >> +               gpd_data->next_wakeup = next;
> >> +               genpd->flags |= GENPD_FLAG_GOV_NEXT_WAKEUP;
> >
> >I don't think we should set this here, but instead leave this to be
> >set by the genpd provider at initialization.
> >
> But, we don't want it to be enabled by default. It is possible that
> domains may have multiple idle states but none of the devices in the
> domain have the need for next wakeup. We could optimize out the next
> wakeup for those cases.

Yes, I understand, but at this point I don't think it's needed.

My main concern was to allow us to avoid the path for the
"pm_domain_cpu_gov" type for some genpds. Thus I think it's good
enough to set a new flag per genpd at initialization time.

> Or, the domain needs to call genpd_enable_next_wakeup() (patch #1) to
> allow this feature. Is that acceptable?

The problem is that we would need a reference counting mechanism, as
to also understand when to also turn off the flag. In other words, we
would need some kind of locking. I suggest we simply skip this for now
and see how this plays. What do you think?

>
> >> +               ret = 0;
> >> +       }
> >> +       genpd_unlock(genpd);
> >
> >I would suggest to simplify the above into:
> >
> >gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
> >gpd_data->next_wakeup = next;
> >
> >Then there is no need for locks because:
> >*) We assume the device remains attached to the genpd.
> >**) The device isn't runtime suspended, hence its corresponding genpd
> >is powered on and thus the genpd governor can't be looking at
> >"gpd_data->next_wakeup" simulantfsfulsy.
> >
> :)
> >Moreover, as we agreed to ignore stale values for "next", there is no
> >reason to validate it against the current ktime, so let's just skip
> >it.
> >
> Okay.
>
> >> +
> >> +       return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(dev_pm_genpd_set_next_wakeup);
> >> +
> >> +
> >>  static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
> >>  {
> >>         unsigned int state_idx = genpd->state_idx;
> >> @@ -1450,6 +1490,7 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev)
> >>         gpd_data->td.constraint_changed = true;
> >>         gpd_data->td.effective_constraint_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
> >>         gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
> >> +       gpd_data->next_wakeup = KTIME_MAX;
> >
> >When looking at patch3, I wonder if it perhaps could be easier to use
> >"zero" as the default value? What do you think, just an idea?
> >
> Hmm.. Let me think it over.
>
> Thanks,
> Lina
>
> >>
> >>         spin_lock_irq(&dev->power.lock);
> >>

[...]

Kind regards
Uffe
