Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195F4401D0E
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 16:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243274AbhIFOg5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 10:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236950AbhIFOg5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Sep 2021 10:36:57 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F40C061575;
        Mon,  6 Sep 2021 07:35:51 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id j12so11655459ljg.10;
        Mon, 06 Sep 2021 07:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6jbkQTO4uyJLXGfdhWZPI8lbG6kaPuIGY1I9TmeIqog=;
        b=ZxLDpDCiV3jPZeL8UKDsSMWDyvqYvOwLgtbUduNtSGi2vXihoxJOCeHQBNwFIkWNN3
         N3IubKgW3cJAAHF2lxdiG/t5rIb3q/CziaM6gGSmhC1T5XmgAcb44FP23b1sS/5EAOA0
         5TYIJz8dZvzH1WnmxDA2QTmXo1JcGAKsWHNFUWRFaC6DeUy0GgEp6TWvQFLskoPN5E3h
         AMtIQ0oGwxoYY3O+cOUX9dg0UijqhG8A+OHCp5s6sVLycjyKksNpSCnlqzXRg1iGw4cS
         ceubKX+hFhG5WAyMdy2/8OhLfJHNuhcpo9sqi8d64/dkDFmigNAV2JhZDCCBHOlprSOL
         2qRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6jbkQTO4uyJLXGfdhWZPI8lbG6kaPuIGY1I9TmeIqog=;
        b=U53xKa7KIgYqNZjFt46WrPLgpBnzJqL/7IO9GUkFMq6Irz5HlX9VEqBi9e6Kb2x4G/
         jocWPja+mv6Uz9BGmUeSp1PQZ1S4Yr22ALOBbDGuAemdxJbt9cPvMCLWGTTgTRI0qO04
         spdZ0ZnLtzB6DLPCRsnSAYS+uGeXkmG5QGflC4YbJmVyvYA0BKIkEqZnrM5aX3SDYOmV
         cBK+CJj1C1AKNM9jU//Mxt9rPQgpKJoDXjJCj381hUQBuqjPhNE7H6uE4dBENNTaVAbT
         rl+SPg7ycZSmIsvMTnUsTibQeG5xgjzqKHyBNC+JOkPdTWxBaYJRgoaqBslZlvH1IKEZ
         hVTA==
X-Gm-Message-State: AOAM53383zC9A4Tm84R8RbLJ7mrDgjOarumKg5SD0Lzv2JfoiS9tDhA2
        HUtjMRXsZodhPrugk6YB1SSPKGjrnTA=
X-Google-Smtp-Source: ABdhPJzhRaxIFQDdwR2bxhHFOwvNuCUZB7CY0V/KDbX1va6qRSoh8GyYXxjMlZxIu9lL5fuoOhs+8Q==
X-Received: by 2002:a2e:a261:: with SMTP id k1mr10576789ljm.509.1630938949981;
        Mon, 06 Sep 2021 07:35:49 -0700 (PDT)
Received: from [192.168.2.145] (46-138-3-129.dynamic.spd-mgts.ru. [46.138.3.129])
        by smtp.googlemail.com with ESMTPSA id j25sm759507lfm.191.2021.09.06.07.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 07:35:49 -0700 (PDT)
Subject: Re: [PATCH 3/3] PM: domains: Add a ->dev_get_performance_state()
 callback to genpd
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210902101634.827187-1-ulf.hansson@linaro.org>
 <20210902101634.827187-4-ulf.hansson@linaro.org>
 <4e36e732-6ca3-1d00-e6dd-38bb8877577b@gmail.com>
 <CAPDyKFr2oQnKOhKhWt_9VyBoe=HQ7Y0uZUMKTcZ05a7G9RaBYA@mail.gmail.com>
 <1124dae5-478f-f0ca-ea91-b6945f7c9254@gmail.com>
 <CAPDyKFqE+thX0pLTg9d-ds7Tj3hsB78EmDB1Cryh26tN3kvQDA@mail.gmail.com>
 <3d92711f-ce30-2c19-c6a4-bb77d32df2dd@gmail.com>
 <CAPDyKFpJU3g2OzJeR9KUdtN-8wJsDckqVAMQMHBV=enu=DfURg@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fbca049a-e673-1598-658f-a7bb5de52f18@gmail.com>
Date:   Mon, 6 Sep 2021 17:35:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpJU3g2OzJeR9KUdtN-8wJsDckqVAMQMHBV=enu=DfURg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

06.09.2021 13:53, Ulf Hansson пишет:
> On Sun, 5 Sept 2021 at 11:11, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 03.09.2021 17:09, Ulf Hansson пишет:
>>> On Fri, 3 Sept 2021 at 12:06, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>
>>>> 03.09.2021 11:55, Ulf Hansson пишет:
>>>>> On Fri, 3 Sept 2021 at 08:00, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>>>
>>>>>> 02.09.2021 13:16, Ulf Hansson пишет:
>>>>>>> Hardware may be preprogrammed to a specific performance state, which may
>>>>>>> not be zero initially during boot. This may lead to that genpd's current
>>>>>>> performance state becomes inconsistent with the state of the hardware. To
>>>>>>> deal with this, the driver for a device that is being attached to its
>>>>>>> genpd, need to request an initial performance state vote, which is
>>>>>>> typically done by calling some of the OPP APIs while probing.
>>>>>>>
>>>>>>> In some cases this would lead to boilerplate code in the drivers. Let's
>>>>>>> make it possible to avoid this, by adding a new optional callback to genpd
>>>>>>> and invoke it per device during the attach process. In this way, the genpd
>>>>>>> provider driver can inform genpd about the initial performance state that
>>>>>>> is needed for the device.
>>>>>>>
>>>>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>>>>> ---
>>>>>>>  drivers/base/power/domain.c | 8 +++++---
>>>>>>>  include/linux/pm_domain.h   | 2 ++
>>>>>>>  2 files changed, 7 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>>>>>>> index 800adf831cae..1a6f3538af8d 100644
>>>>>>> --- a/drivers/base/power/domain.c
>>>>>>> +++ b/drivers/base/power/domain.c
>>>>>>> @@ -2640,13 +2640,15 @@ static void genpd_dev_pm_sync(struct device *dev)
>>>>>>>       genpd_queue_power_off_work(pd);
>>>>>>>  }
>>>>>>>
>>>>>>> -static int genpd_get_default_performance_state(struct device *dev,
>>>>>>> +static int genpd_get_default_performance_state(struct generic_pm_domain *genpd,
>>>>>>> +                                            struct device *dev,
>>>>>>>                                              unsigned int index)
>>>>>>>  {
>>>>>>>       int pstate = of_get_required_opp_performance_state(dev->of_node, index);
>>>>>>>
>>>>>>>       if (pstate == -ENODEV || pstate == -EOPNOTSUPP)
>>>>>>> -             return 0;
>>>>>>> +             pstate = genpd->dev_get_performance_state ?
>>>>>>> +                      genpd->dev_get_performance_state(genpd, dev) : 0;
>>>>>>>
>>>>>>>       return pstate;
>>>>>>>  }
>>>>>>> @@ -2701,7 +2703,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>>>>>>>       }
>>>>>>>
>>>>>>>       /* Set the default performance state */
>>>>>>> -     pstate = genpd_get_default_performance_state(dev, index);
>>>>>>> +     pstate = genpd_get_default_performance_state(pd, dev, index);
>>>>>>
>>>>>> If base device is suspended, then its performance state is zero.
>>>>>>
>>>>>> When device will be rpm-resumed, then its performance should be set to
>>>>>> the default state.
>>>>>> You're setting performance state of the wrong device, it should be the
>>>> Are you okay with my variant of handling the suspended device?
>>>
>>> Not sure if you intended to post this line?
>>>
>>> In any case, I am happy to help and review to move things forward.
>>
>> It's not clear to me whether you omitted handling the case of
>> rpm-suspended device on purpose or not. I think it should be a part of
>> this patch, but sounds like you want to work on it separately, correct?
> 
> I didn't omit the handling, but instead relied solely on the
> pm_runtime_suspended() check in dev_pm_genpd_set_performance_state().

It doesn't work as expected for Tegra because pm_runtime_suspended()
returns false while RPM is disabled and it's normally disabled at the
attachment time.

>>>>>> base device and not the virtual domain device.
>>>>>
>>>>> No I am not. :-) Let me elaborate.
>>>>>
>>>>> For the single PM domain case, 'dev' and 'base_dev' are pointing to
>>>>> the same device. So this works fine.
>>>>>
>>>>> For the multiple PM domain case or when attaching goes via
>>>>> genpd_dev_pm_attach_by_id(), 'dev' is the virtual device registered in
>>>>> genpd_dev_pm_attach_by_id(). In this case, it's 'dev' that is becoming
>>>>> attached to genpd and not the 'base_dev'. Note also that, runtime PM
>>>>> has not been enabled for 'dev' yet at this point and 'dev' has been
>>>>> assigned the same OF node as 'base_dev", to allow OF parsing to work
>>>>> as is for it.
>>>>>
>>>>> Moreover, to deal with runtime PM in the multiple PM domain case, the
>>>>> consumer driver should create a device link. Along the lines of this:
>>>>> device_link_add(base_dev, dev, DL_FLAG_PM_RUNTIME |
>>>>> DL_FLAG_STATELESS), thus assigning the virtual device ('dev') as the
>>>>> supplier for its consumer device ('base_dev').
>>>>>
>>>>>>
>>>>>> These all is handled properly by my patch [1]. Hence it's complicated
>>>>>> for the reason.
>>>>>
>>>>> See above. It shouldn't have to be complicated. If it still is, there
>>>>> is something to fix for the multiple PM domain case.
>>>>>> [1]
>>>> Alright, it actually works now on Tegra using the dev in the callback
>>>> for the case of multiple domains, I re-checked it. Previously, when I
>>>> tried that, there was a conflict in regards to OPP usage, I don't
>>>> remember details anymore. Maybe the recent changes that were suggested
>>>> by Viresh helped with that. So yes, there is no need to pass the base
>>>> device anymore.
>>>
>>> Great! So, it seems like $subject patch should be a way forward for you then?
>>
>> The current behaviour is incorrect for Tegra because it needs to set the
>> rpm_pstate for rpm-suspended device, instead of bumping the state
>> immediately.
>>
>> Power management is defeated without it on Tegra because SoC will start
>> to consume extra power while device that needs this power is suspended.
> 
> Okay, I understand your concern.
> 
> For devices that may remain runtime suspended when their consumer
> drivers probes them, the behaviour may be suboptimal. This because it
> could lead to having an active performance state vote for a runtime
> suspended device, at least until it gets runtime resumed and then
> runtime suspended again.
> 
> This all boils down to how the consumer driver deploys support for
> runtime PM - and genpd doesn't know nor can control that.

Previously, I added the 'dev_suspended' argument to the
dev_get_performance_state() callback to allow PD driver to decide
whether state should applied immediately or on rpm-resume, but you asked
to remove it because it didn't make sense to you [1].

[1]
https://lore.kernel.org/linux-pm/CAPDyKFo=SFpm+uJYH4UDfKWLVnkP2cKkBcbOQeVhU5hRxHUMCw@mail.gmail.com/

Does it make sense now?

> I wonder if we perhaps should just leave this as is then. In other
> words, rely on the consumer driver to vote for an initial performance
> state of the device during ->probe(). In this way, the consumer driver
> can decide what is the best thing to do, rather than letting genpd
> make guesses.

The point of this series is to remove the boilerplate code from consumer
drivers.

I already implemented variant with the explicit state syncing done by
consumer drivers, but Viresh suggested that it should be done by the PD
driver, this is why we're discussing it all over again.

We either need to add quirks to consumer drivers or make PD API more
flexible. You're not in favor of extending the PD API. To me the variant
with the PD API extension is a bit nicer since it removes the
boilerplate code, but I also see why you don't like it.

Viresh, are you okay with going back to the variant with the
dev_pm_opp_sync() helper?

> Note that, comparing what we have done for power on/off during
> attach/probe. For the legacy case (the single PM domain case) we power
> on the PM domain. For the multiple PM domain case, we leave the PM
> domain as is.

That is a similar situation here. If PD driver doesn't implement the new
dev_get_performance_state() callback, then nothing is changed for the
consumer drivers.

>> Otherwise $subject looks okay.
>>
>>> BTW, I forgot to add your Suggested-by: tag for the patch, you
>>> certainly deserve at least that. Or perhaps you are fine with
>>> co-developed by tag?
>>
>> Either is fine. Although, won't it be easier to keep these PD patches
>> within the Tegra series since it depends on them? I can pick up the
>> patches into the next version of Tegra series.
> 
> Let's see. If we can agree on how to deal with this series, maybe we
> can ask Rafael to send another pull-request before rc1 is out, so you
> can base your series for Tegra more easily on top.

Alright
