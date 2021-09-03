Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF91D3FFDE8
	for <lists+linux-pm@lfdr.de>; Fri,  3 Sep 2021 12:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349061AbhICKHc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Sep 2021 06:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349058AbhICKHa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Sep 2021 06:07:30 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916CAC061757;
        Fri,  3 Sep 2021 03:06:30 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id f18so10725121lfk.12;
        Fri, 03 Sep 2021 03:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8/W4ECKkpDvPRY/E5YAMSo9oFMTvtAISYyXaxtvzxSg=;
        b=qy39qYLB2b+zpSyPb8P5o0ZZwvetA/BNLaSWkTPpSOwJzC5TwYQYGBwJswOtcIo/j5
         mJMqF7sVA4jbN6IvYithMuQyJlcs3jil3qVJgHeSO4ppDJkB+4Ro3sd9CDRo49nRQTSI
         t2lYHXGoIF5Pn8yGxNPDUw/sejfo9TmYghsMTU8GJzRdUggyLokJRNGQcDsKbsGUMY1g
         c//v11ai3W54m1rSdbyXbZtoQOV2jrOkMwZ03h5KTI5yrK2GqIHQOLavdRcs/81ssDGg
         EJ9JKUL4tAsjwjjSriUdnNX8tcj5PtDWd837z8N7fEhUP2unacY36YanebxeYSH3++Iy
         LEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8/W4ECKkpDvPRY/E5YAMSo9oFMTvtAISYyXaxtvzxSg=;
        b=h+YHmkIpWruHWqAaZijUJ3yVIy8P0rtpDa/awPXSUm/44LlHjjl41Gsf73BKMkyCjU
         M/sRAVvBvPKI/XfBjg7FWulHp4xkHA56qsR9DPp0MhoebQuJGNW0kgIHfjkQn/qBx+24
         LpPXIH8uAgRP7IVX5jnKHVF5rvFPjgdiztoXXoHsschtXT/L4/XPG6In9OrYxEh8wzsW
         R5ApMdNujiN+wBwt9I8NxUpqgEHKhgTCpBANxrci4K4VgIRP+c5eva00r8kFIznUK004
         1JWOpfOEqqikw47t7acaoUetvIxnqh5URa+MJuGldrKis0FGY/mV+GHs9wwCqj46r/YD
         FV8Q==
X-Gm-Message-State: AOAM531jJJs0k6F0L8N5W8RrrhMO3iSEE/04amuD+ehF09mobXJXE2nU
        1VGlR3i0VvQDrshfliWbodnjSvEfAh8=
X-Google-Smtp-Source: ABdhPJxK6narCUiGIr4IQXxc1zyoo/1gXAoeY3s+HAmnXFcX6QaZd4yrJRQ8LWiqW3B11SxyB/iE1A==
X-Received: by 2002:a05:6512:3fa3:: with SMTP id x35mr2248011lfa.536.1630663588788;
        Fri, 03 Sep 2021 03:06:28 -0700 (PDT)
Received: from [192.168.2.145] (46-138-26-37.dynamic.spd-mgts.ru. [46.138.26.37])
        by smtp.googlemail.com with ESMTPSA id n18sm530747ljg.40.2021.09.03.03.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 03:06:28 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1124dae5-478f-f0ca-ea91-b6945f7c9254@gmail.com>
Date:   Fri, 3 Sep 2021 13:06:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFr2oQnKOhKhWt_9VyBoe=HQ7Y0uZUMKTcZ05a7G9RaBYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

03.09.2021 11:55, Ulf Hansson пишет:
> On Fri, 3 Sept 2021 at 08:00, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 02.09.2021 13:16, Ulf Hansson пишет:
>>> Hardware may be preprogrammed to a specific performance state, which may
>>> not be zero initially during boot. This may lead to that genpd's current
>>> performance state becomes inconsistent with the state of the hardware. To
>>> deal with this, the driver for a device that is being attached to its
>>> genpd, need to request an initial performance state vote, which is
>>> typically done by calling some of the OPP APIs while probing.
>>>
>>> In some cases this would lead to boilerplate code in the drivers. Let's
>>> make it possible to avoid this, by adding a new optional callback to genpd
>>> and invoke it per device during the attach process. In this way, the genpd
>>> provider driver can inform genpd about the initial performance state that
>>> is needed for the device.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>  drivers/base/power/domain.c | 8 +++++---
>>>  include/linux/pm_domain.h   | 2 ++
>>>  2 files changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>>> index 800adf831cae..1a6f3538af8d 100644
>>> --- a/drivers/base/power/domain.c
>>> +++ b/drivers/base/power/domain.c
>>> @@ -2640,13 +2640,15 @@ static void genpd_dev_pm_sync(struct device *dev)
>>>       genpd_queue_power_off_work(pd);
>>>  }
>>>
>>> -static int genpd_get_default_performance_state(struct device *dev,
>>> +static int genpd_get_default_performance_state(struct generic_pm_domain *genpd,
>>> +                                            struct device *dev,
>>>                                              unsigned int index)
>>>  {
>>>       int pstate = of_get_required_opp_performance_state(dev->of_node, index);
>>>
>>>       if (pstate == -ENODEV || pstate == -EOPNOTSUPP)
>>> -             return 0;
>>> +             pstate = genpd->dev_get_performance_state ?
>>> +                      genpd->dev_get_performance_state(genpd, dev) : 0;
>>>
>>>       return pstate;
>>>  }
>>> @@ -2701,7 +2703,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>>>       }
>>>
>>>       /* Set the default performance state */
>>> -     pstate = genpd_get_default_performance_state(dev, index);
>>> +     pstate = genpd_get_default_performance_state(pd, dev, index);
>>
>> If base device is suspended, then its performance state is zero.
>>
>> When device will be rpm-resumed, then its performance should be set to
>> the default state.
>> You're setting performance state of the wrong device, it should be the
Are you okay with my variant of handling the suspended device?


>> base device and not the virtual domain device.
> 
> No I am not. :-) Let me elaborate.
> 
> For the single PM domain case, 'dev' and 'base_dev' are pointing to
> the same device. So this works fine.
> 
> For the multiple PM domain case or when attaching goes via
> genpd_dev_pm_attach_by_id(), 'dev' is the virtual device registered in
> genpd_dev_pm_attach_by_id(). In this case, it's 'dev' that is becoming
> attached to genpd and not the 'base_dev'. Note also that, runtime PM
> has not been enabled for 'dev' yet at this point and 'dev' has been
> assigned the same OF node as 'base_dev", to allow OF parsing to work
> as is for it.
> 
> Moreover, to deal with runtime PM in the multiple PM domain case, the
> consumer driver should create a device link. Along the lines of this:
> device_link_add(base_dev, dev, DL_FLAG_PM_RUNTIME |
> DL_FLAG_STATELESS), thus assigning the virtual device ('dev') as the
> supplier for its consumer device ('base_dev').
> 
>>
>> These all is handled properly by my patch [1]. Hence it's complicated
>> for the reason.
> 
> See above. It shouldn't have to be complicated. If it still is, there
> is something to fix for the multiple PM domain case.
>> [1]
Alright, it actually works now on Tegra using the dev in the callback
for the case of multiple domains, I re-checked it. Previously, when I
tried that, there was a conflict in regards to OPP usage, I don't
remember details anymore. Maybe the recent changes that were suggested
by Viresh helped with that. So yes, there is no need to pass the base
device anymore.
