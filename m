Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6701400EC8
	for <lists+linux-pm@lfdr.de>; Sun,  5 Sep 2021 11:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbhIEJMn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Sep 2021 05:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhIEJMm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Sep 2021 05:12:42 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B9BC061575;
        Sun,  5 Sep 2021 02:11:39 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id p15so5969810ljn.3;
        Sun, 05 Sep 2021 02:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BZqEXOlldZy4cjwe/e2y3kHWRpLBIObr40ytbwHZ01M=;
        b=AJu2N7wP0Ofb66t1p9XF28Iquc4kV42NAJnMiZwtYb1YIhL/EnSJ9dbL4EJYnVrSW0
         IcXvxck7Vmob3wASvzmaLQEOyIGF+fgQ9qiSc8DIBZBovmGbvKaEX+PumXFC2c7YdVdT
         xfEgMDdD0GJ5nergX4owH/pwYfrbToNApHZLh6S4I9biDgxMbJDt9sQ1TispeyUo/tnQ
         lqIfSYeoPVaPI3ai06yniKC56iXvAGie3yYzm/meyWvPVOdSWsTqIud2AY5dCYPPW09X
         /NomKhdrDNoho2buCO6+WrucVbgji2E7mfnEXIukPBU9oA74HYL0ao/HcFOudOrRDRBC
         tIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BZqEXOlldZy4cjwe/e2y3kHWRpLBIObr40ytbwHZ01M=;
        b=bu5u1x120Q1LOcdYeLnCHNT5qSXZv7fv5ArCwn5Q2/KKwcW1gajuGXuWsedpUHEeqF
         1QtWWixMaIsrraHEpdkDXnbCyNI0TVeBk7Tii2tVHRatFE5OK1g/aXMtefAUN8sMabjr
         YGnRjk38vp2LXYQRZryX0/tXvRECc54eqNOxNqREctYL4sxNWFnC2ThvtJaRDx2L+m/j
         w52qliGngcjnZnSmjcS4Sl/eub72gE3wlTgC2WP+LLeuGLOj40ASVbKPlCV4SuR0PBUv
         Y7AG6aqho50XYokb0ljrvSpFKRbx48vw7K8p7FjUMFac4mMRAM++zdSYpyQPp9/tBX5F
         VR1w==
X-Gm-Message-State: AOAM531e0IIY4Qv6TvUBzOZSyyKC7McqH+kQd1w9PVbqoC0ipLLgR0hL
        jKdomJX429VrWtSSAW/5aZ6BEHI24+A=
X-Google-Smtp-Source: ABdhPJySe9WiolDhMbxlQC+TCA3ZPHhNfG+lisytnB5/Y7snjj0saHinwspdYky87FjaAGwimqO8mA==
X-Received: by 2002:a2e:bf1a:: with SMTP id c26mr6408439ljr.88.1630833098053;
        Sun, 05 Sep 2021 02:11:38 -0700 (PDT)
Received: from [192.168.2.145] (46-138-3-129.dynamic.spd-mgts.ru. [46.138.3.129])
        by smtp.googlemail.com with ESMTPSA id j20sm440222lfr.248.2021.09.05.02.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 02:11:37 -0700 (PDT)
Subject: Re: [PATCH 3/3] PM: domains: Add a ->dev_get_performance_state()
 callback to genpd
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3d92711f-ce30-2c19-c6a4-bb77d32df2dd@gmail.com>
Date:   Sun, 5 Sep 2021 12:11:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqE+thX0pLTg9d-ds7Tj3hsB78EmDB1Cryh26tN3kvQDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

03.09.2021 17:09, Ulf Hansson пишет:
> On Fri, 3 Sept 2021 at 12:06, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 03.09.2021 11:55, Ulf Hansson пишет:
>>> On Fri, 3 Sept 2021 at 08:00, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>
>>>> 02.09.2021 13:16, Ulf Hansson пишет:
>>>>> Hardware may be preprogrammed to a specific performance state, which may
>>>>> not be zero initially during boot. This may lead to that genpd's current
>>>>> performance state becomes inconsistent with the state of the hardware. To
>>>>> deal with this, the driver for a device that is being attached to its
>>>>> genpd, need to request an initial performance state vote, which is
>>>>> typically done by calling some of the OPP APIs while probing.
>>>>>
>>>>> In some cases this would lead to boilerplate code in the drivers. Let's
>>>>> make it possible to avoid this, by adding a new optional callback to genpd
>>>>> and invoke it per device during the attach process. In this way, the genpd
>>>>> provider driver can inform genpd about the initial performance state that
>>>>> is needed for the device.
>>>>>
>>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>>> ---
>>>>>  drivers/base/power/domain.c | 8 +++++---
>>>>>  include/linux/pm_domain.h   | 2 ++
>>>>>  2 files changed, 7 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>>>>> index 800adf831cae..1a6f3538af8d 100644
>>>>> --- a/drivers/base/power/domain.c
>>>>> +++ b/drivers/base/power/domain.c
>>>>> @@ -2640,13 +2640,15 @@ static void genpd_dev_pm_sync(struct device *dev)
>>>>>       genpd_queue_power_off_work(pd);
>>>>>  }
>>>>>
>>>>> -static int genpd_get_default_performance_state(struct device *dev,
>>>>> +static int genpd_get_default_performance_state(struct generic_pm_domain *genpd,
>>>>> +                                            struct device *dev,
>>>>>                                              unsigned int index)
>>>>>  {
>>>>>       int pstate = of_get_required_opp_performance_state(dev->of_node, index);
>>>>>
>>>>>       if (pstate == -ENODEV || pstate == -EOPNOTSUPP)
>>>>> -             return 0;
>>>>> +             pstate = genpd->dev_get_performance_state ?
>>>>> +                      genpd->dev_get_performance_state(genpd, dev) : 0;
>>>>>
>>>>>       return pstate;
>>>>>  }
>>>>> @@ -2701,7 +2703,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>>>>>       }
>>>>>
>>>>>       /* Set the default performance state */
>>>>> -     pstate = genpd_get_default_performance_state(dev, index);
>>>>> +     pstate = genpd_get_default_performance_state(pd, dev, index);
>>>>
>>>> If base device is suspended, then its performance state is zero.
>>>>
>>>> When device will be rpm-resumed, then its performance should be set to
>>>> the default state.
>>>> You're setting performance state of the wrong device, it should be the
>> Are you okay with my variant of handling the suspended device?
> 
> Not sure if you intended to post this line?
> 
> In any case, I am happy to help and review to move things forward.

It's not clear to me whether you omitted handling the case of
rpm-suspended device on purpose or not. I think it should be a part of
this patch, but sounds like you want to work on it separately, correct?

>>>> base device and not the virtual domain device.
>>>
>>> No I am not. :-) Let me elaborate.
>>>
>>> For the single PM domain case, 'dev' and 'base_dev' are pointing to
>>> the same device. So this works fine.
>>>
>>> For the multiple PM domain case or when attaching goes via
>>> genpd_dev_pm_attach_by_id(), 'dev' is the virtual device registered in
>>> genpd_dev_pm_attach_by_id(). In this case, it's 'dev' that is becoming
>>> attached to genpd and not the 'base_dev'. Note also that, runtime PM
>>> has not been enabled for 'dev' yet at this point and 'dev' has been
>>> assigned the same OF node as 'base_dev", to allow OF parsing to work
>>> as is for it.
>>>
>>> Moreover, to deal with runtime PM in the multiple PM domain case, the
>>> consumer driver should create a device link. Along the lines of this:
>>> device_link_add(base_dev, dev, DL_FLAG_PM_RUNTIME |
>>> DL_FLAG_STATELESS), thus assigning the virtual device ('dev') as the
>>> supplier for its consumer device ('base_dev').
>>>
>>>>
>>>> These all is handled properly by my patch [1]. Hence it's complicated
>>>> for the reason.
>>>
>>> See above. It shouldn't have to be complicated. If it still is, there
>>> is something to fix for the multiple PM domain case.
>>>> [1]
>> Alright, it actually works now on Tegra using the dev in the callback
>> for the case of multiple domains, I re-checked it. Previously, when I
>> tried that, there was a conflict in regards to OPP usage, I don't
>> remember details anymore. Maybe the recent changes that were suggested
>> by Viresh helped with that. So yes, there is no need to pass the base
>> device anymore.
> 
> Great! So, it seems like $subject patch should be a way forward for you then?

The current behaviour is incorrect for Tegra because it needs to set the
rpm_pstate for rpm-suspended device, instead of bumping the state
immediately.

Power management is defeated without it on Tegra because SoC will start
to consume extra power while device that needs this power is suspended.

Otherwise $subject looks okay.

> BTW, I forgot to add your Suggested-by: tag for the patch, you
> certainly deserve at least that. Or perhaps you are fine with
> co-developed by tag?

Either is fine. Although, won't it be easier to keep these PD patches
within the Tegra series since it depends on them? I can pick up the
patches into the next version of Tegra series.
