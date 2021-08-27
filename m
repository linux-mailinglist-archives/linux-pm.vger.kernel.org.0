Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C7E3F9BFF
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 17:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245472AbhH0Pve (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Aug 2021 11:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245519AbhH0Pvd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Aug 2021 11:51:33 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD34C0613CF;
        Fri, 27 Aug 2021 08:50:43 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id i28so12218204ljm.7;
        Fri, 27 Aug 2021 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EBryXjPDdu2auAtyyw6+T4ajilaxKIAtiI9wgz9a9nY=;
        b=qO1QfX+ku49f7uB4BErSQpFVbxpma7MbQ1faMhQfe9EL+guGu7j4GC8x0boAOw8XLq
         reS48FvnCZVpZnXfXRri7euauI8Xsp9P5suRr0e8N43prppEtuoNnGTJkY5gYr0RYU5f
         F8CtPQxnBUu+i/jJO6641N2vKKHvuv5a/io+Ui1B0rg3IIuU7tN7omDVtv8+bReVDHim
         uMRoXwg1Uq2R/VfUqV/z1lqTx7WLKgsRa7ddN3hHXyK7R+m09zPQj+joxE9dSMkzQ795
         Io6bOxg/cIc2nhW+ZEyXaTjoSCfZKIZiR6yL0vvOhDrpd0Xvax9fBOJe+VYaTJiHDrJg
         RAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EBryXjPDdu2auAtyyw6+T4ajilaxKIAtiI9wgz9a9nY=;
        b=KDrLKUO6IL2LwsuwOEBpf5I1hdBws65TCuMkrozqFo0FZIOlCvEo61MAFVkyXhHOPn
         6FdEubNbVjDugcfDbXaSw6hZN2GqP6S0Bu6+83ze7c/14c2i7K1JPqQRYM/YBQVSjT2H
         dSKchK2xHNdnok6Fz21GaAygS2YLurQsG26iEExot8wH/08d9LgzmXf6pDrieNSMeCmk
         otVGvvVXUlqL9iNrwPaz7gyjkJMHkwgLbScdRR0KS5QOwz5foGP9RMZ8GgBlds13/u8/
         wZHGN0ugvMjNbPwppvWqI7eSZuPKIohXj2UJwG5R22AnxMG7bmcIPFxxVLoF1CZk2los
         Bh+g==
X-Gm-Message-State: AOAM530IhcEzIyHBFy+ZTqKMqmQo6zYGjXswAV0zFiObCC5gImFJxluL
        bcnUwtvjyfp2TLxOqb4Z7oP3DIkJYus=
X-Google-Smtp-Source: ABdhPJzwAd4VU6ZJ65Jc4JytDlFd1Fmjd81d+OGXQXWOmwNKh485ctVHL1cbwrOouXOFVcthskJXfg==
X-Received: by 2002:a2e:8858:: with SMTP id z24mr8170870ljj.129.1630079442086;
        Fri, 27 Aug 2021 08:50:42 -0700 (PDT)
Received: from [192.168.2.145] (94-29-17-251.dynamic.spd-mgts.ru. [94.29.17.251])
        by smtp.googlemail.com with ESMTPSA id d26sm627196lfv.221.2021.08.27.08.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 08:50:41 -0700 (PDT)
Subject: Re: [PATCH v9 4/8] PM: domains: Add get_performance_state() callback
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20210827013415.24027-1-digetx@gmail.com>
 <20210827013415.24027-5-digetx@gmail.com>
 <CAPDyKFqYWxY9znP1BEzogu0k7J1KRMXoSkUOeN4xHRq=gCHvTw@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <de5b2730-3032-f279-671a-b26c256b28f8@gmail.com>
Date:   Fri, 27 Aug 2021 18:50:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqYWxY9znP1BEzogu0k7J1KRMXoSkUOeN4xHRq=gCHvTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.08.2021 17:23, Ulf Hansson пишет:
> On Fri, 27 Aug 2021 at 03:37, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> Add get_performance_state() callback that retrieves and initializes
>> performance state of a device attached to a power domain. This removes
>> inconsistency of the performance state with hardware state.
> 
> Can you please try to elaborate a bit more on the use case. Users need
> to know when it makes sense to implement the callback - and so far we
> tend to document this through detailed commit messages.
> 
> Moreover, please state that implementing the callback is optional.

Noted

>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/base/power/domain.c | 32 +++++++++++++++++++++++++++++---
>>  include/linux/pm_domain.h   |  2 ++
>>  2 files changed, 31 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 3a13a942d012..8b828dcdf7f8 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -2700,15 +2700,41 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>>                 goto err;
>>         } else if (pstate > 0) {
>>                 ret = dev_pm_genpd_set_performance_state(dev, pstate);
>> -               if (ret)
>> +               if (ret) {
>> +                       dev_err(dev, "failed to set required performance state for power-domain %s: %d\n",
>> +                               pd->name, ret);
> 
> Moving the dev_err() here, leads to that we won't print an error if
> of_get_required_opp_performance_state() fails, a few lines above, is
> that intentional?

Not intentional, I'll add another message.

>>                         goto err;
>> +               }
>>                 dev_gpd_data(dev)->default_pstate = pstate;
>>         }
>> +
>> +       if (pd->get_performance_state && !dev_gpd_data(dev)->default_pstate) {
>> +               bool dev_suspended = false;
>> +
>> +               ret = pd->get_performance_state(pd, base_dev, &dev_suspended);
>> +               if (ret < 0) {
>> +                       dev_err(dev, "failed to get performance state for power-domain %s: %d\n",
>> +                               pd->name, ret);
>> +                       goto err;
>> +               }
>> +
>> +               pstate = ret;
>> +
>> +               if (dev_suspended) {
> 
> The dev_suspended thing looks weird.
> 
> Perhaps it was needed before dev_pm_genpd_set_performance_state()
> didn't check pm_runtime_disabled()?

There are two possible variants here:

1. Device is suspended
2. Device is active

If device is suspended, then it will be activated on RPM-resume and h/w
state will require a specific performance state when resumed. Hence only
the the rpm_pstate should be set, otherwise SoC may start to consume
extra power if device won't be resumed by a consumer driver and
performance state is bumped without a real need.

If device is known to be active, then the performance state should be
updated immediately, otherwise we have inconsistent state with hardware.

For Tegra dev_suspended=true because in general it should be safe to
assume that hardware is suspended since it's either stopped by the PD
driver on initial power_on or it's assumed to be disabled by a consumer
driver during probe. Technically it's possible to check clock and reset
state of an attached device from the get_performance_state() to find the
real state of device, but it's not necessary to do so far.

I'll add comment to the code.

>> +                       dev_gpd_data(dev)->rpm_pstate = pstate;
>> +               } else if (pstate > 0) {
>> +                       ret = dev_pm_genpd_set_performance_state(dev, pstate);
>> +                       if (ret) {
>> +                               dev_err(dev, "failed to set required performance state for power-domain %s: %d\n",
>> +                                       pd->name, ret);
>> +                               goto err;
>> +                       }
>> +               }
>> +       }
> 
> Overall, what we seem to be doing here, is to retrieve a value for an
> initial/default performance state for a device and then we want to set
> it to make sure the vote becomes aggregated and finally set for the
> genpd.
> 
> With your suggested change, there are now two ways to get the
> initial/default state. One is through the existing
> of_get_required_opp_performance_state() and the other is by using a
> new genpd callback.
> 
> That said, perhaps we would get a bit cleaner code by moving the "get
> initial/default performance state" thingy, into a separate function
> and then call it from here. If this function returns a valid
> performance state, then we should continue to set the state, by
> calling dev_pm_genpd_set_performance_state() and update
> dev_gpd_data(dev)->default_pstate accordingly.
> 
> Would that work, do you think?

To be honest, I'm now confused by
of_get_required_opp_performance_state(). It assumes that device is
active all the time while attached and that device is stopped on detach.

If hardware is always-on, then it should be wrong to drop the
performance state on detach.

If hardware isn't always-on, then it might be suspended during
attachment, and thus, only the rpm_pstate should be set. It's also not
guaranteed that consumer driver will suspend device on unbind, leaving
it active on detach, thus it should be wrong to drop performance state
on detach.

Hence I think the default_pstate is a bit out of touch. If this
attach/detach behaviour is specific to QCOM driver/hardware, then maybe
of_get_required_opp_performance_state() should be moved out to a
get_performance_state() of the QCOM PD driver?

I added Rajendra Nayak to explain.

For now we're bailing out if default_pstate is set because it conflicts
with get_performance_state().

But we can factor out the code into a separate function anyways to make
it cleaner a tad.

>> +
>>         return 1;
>>
>>  err:
>> -       dev_err(dev, "failed to set required performance state for power-domain %s: %d\n",
>> -               pd->name, ret);
>>         genpd_remove_device(pd, dev);
>>         return ret;
>>  }
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index 67017c9390c8..4f78b31791ae 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -133,6 +133,8 @@ struct generic_pm_domain {
>>                                                  struct dev_pm_opp *opp);
>>         int (*set_performance_state)(struct generic_pm_domain *genpd,
>>                                      unsigned int state);
>> +       int (*get_performance_state)(struct generic_pm_domain *genpd,
>> +                                    struct device *dev, bool *dev_suspended);
> 
> Comparing the ->set_performance_state() callback, which sets a
> performance state for the PM domain (genpd) - this new callback is
> about retrieving the *initial/default* performance state for a
> *device* that gets attached to a genpd.
> 
> That said, may I suggest renaming the callback to
> "dev_get_performance_state", or something along those lines.

Noted

>>         struct gpd_dev_ops dev_ops;
>>         s64 max_off_time_ns;    /* Maximum allowed "suspended" time. */
>>         ktime_t next_wakeup;    /* Maintained by the domain governor */
>> --
>> 2.32.0
>>
> 
> Kind regards
> Uffe
> 

