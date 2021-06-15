Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0123A8637
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 18:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhFOQUa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 12:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhFOQU3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jun 2021 12:20:29 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3931FC061574
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 09:18:25 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c9so18978734wrt.5
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 09:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1ZQF286KDf3vsAW/1vOHKbnKaEK4bPamrOWEdser+to=;
        b=R8NtmSj/KkG3mZwDtMueKosy4Ydw4GrSJwNmFCP/2GAiGlPKGRrYuCH4M9tj1lzpdZ
         TOQzAmKvUS8t+X/VHs3BmDJH2G11gZymuYsJjEzOuae3PctlCZBbm7TXTiH4qCAeA8XM
         zbObW0fr3fxlVZDjAwR4LRTLCj9/G4Hd4L/cm4/59omnvLGiL4ScAwHoupztlmqyhwz8
         iU8eLBA0ppEdUc9vlzOpFeefz+fLv9yeZQSajgNS89mmGX/EmOteYaGcFLuDSkj382Fv
         Q2eaNToG4DnSQXV49vCehLHK3qjJ8EpC8gu3diPhxsFpv6ZpTCN3/txAmxqE2wRyNJvO
         Vi7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1ZQF286KDf3vsAW/1vOHKbnKaEK4bPamrOWEdser+to=;
        b=ldeOb6BL4TjXXGzn7civyeiI+cZWWWErimXVd5vxEN7NSZO/wE5zNNToEJLDMOFLvm
         6MoTYxxAHsestsq8Q1vj94sWzDx/jIAHM+v64FNe33L9g1uc2l7DUr2SV3nw6FVFqaeO
         +dFFncqHjNOlT/wRLLQgNNeD7GXHkhSGomwVx2e3U1dShPyQJ34Z8rySub030sxV77Sx
         3JXTil9tOujyPBfJQWNh12kbTEBkx3/Q8BBJJ44fSrbhI/abOQXFqrTjoCI9dsgbK3C2
         7p78Jm/Kchj6RhABdFA9yb+XwxtoGK8bCBuT7bTuSYQniqqWTeiSsHA+QO+5akPahkGq
         8DGQ==
X-Gm-Message-State: AOAM533Y4ggxgkfH9SZZ3NCZ1igj6WCjMhgcfdebLVsg4CMv8dtp3NKV
        42cO0uZH58rV42KVJOqm3e/F9BvebTuJCStb
X-Google-Smtp-Source: ABdhPJyDj5Em8ISoY6sbUQhzWQmsq+vp6ZTuVD0IHEcxEiux87fcQosE1ZHaKf/7wRcEOUNSE00SIg==
X-Received: by 2002:adf:c393:: with SMTP id p19mr26505314wrf.92.1623773903610;
        Tue, 15 Jun 2021 09:18:23 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:613a:6939:5f7f:dceb? ([2a01:e34:ed2f:f020:613a:6939:5f7f:dceb])
        by smtp.googlemail.com with ESMTPSA id n6sm2473026wme.21.2021.06.15.09.18.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 09:18:23 -0700 (PDT)
Subject: Re: [PATCH v3 4/7] thermal/drivers/tegra: Add driver for Tegra30
 thermal sensor
To:     Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Ion Agorria <ion@agorria.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210529170955.32574-1-digetx@gmail.com>
 <20210529170955.32574-5-digetx@gmail.com>
 <6f2b6290-095a-bd39-c160-1616a0ff89b1@linaro.org>
 <20210615102626.dja3agclwzxv2sj4@vireshk-i7>
 <595f5e53-b872-bcc6-e886-ed225e26e9fe@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <fbdc3b56-4465-6d3e-74db-1d5082813b9c@linaro.org>
Date:   Tue, 15 Jun 2021 18:18:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <595f5e53-b872-bcc6-e886-ed225e26e9fe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/06/2021 15:01, Dmitry Osipenko wrote:
> 15.06.2021 13:26, Viresh Kumar пишет:
>> On 15-06-21, 12:03, Daniel Lezcano wrote:
>>>
>>> [Cc Viresh]
>>>
>>> On 29/05/2021 19:09, Dmitry Osipenko wrote:
>>>> All NVIDIA Tegra30 SoCs have a two-channel on-chip sensor unit which
>>>> monitors temperature and voltage of the SoC. Sensors control CPU frequency
>>>> throttling, which is activated by hardware once preprogrammed temperature
>>>> level is breached, they also send signal to Power Management controller to
>>>> perform emergency shutdown on a critical overheat of the SoC die. Add
>>>> driver for the Tegra30 TSENSOR module, exposing it as a thermal sensor
>>>> and a cooling device.
>>>
>>> IMO it does not make sense to expose the hardware throttling mechanism
>>> as a cooling device because it is not usable anywhere from the thermal
>>> framework.
>>>
>>> Moreover, that will collide with the thermal / cpufreq framework
>>> mitigation (hardware sets the frequency but the software thinks the freq
>>> is different), right ?
> 
> H/w mitigation is additional and should be transparent to the software
> mitigation. The software mitigation is much more flexible, but it has
> latency. Software also could crash and hang.
> 
> Hardware mitigation doesn't have latency and it will continue to work
> regardless of the software state.

Yes, I agree. Both solutions have their pros and cons. However, I don't
think they can co-exist sanely.

> The CCF driver is aware about the h/w cooling status [1], hence software
> sees the actual frequency.
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?id=344d5df34f5abd468267daa98f041abf90b2f660

Ah interesting, thanks for the pointer.

What I'm worried about is the consistency with cpufreq.

Probably cpufreq_update_limits() should be called from the interrupt
handler.

>> I am not even sure what the cooling device is doing here:
>>
>> tegra_tsensor_set_cur_state() is not implemented and it says hardware
>> changed it by itself. What is the benefit you are getting out of the
>> cooling device here ?
> 
> It allows userspace to check whether hardware cooling is active via the
> cooling_device sysfs. Otherwise we don't have ability to check whether
> h/w cooling is active, I think it's a useful information. It's also
> interesting to see the cooling_device stats, showing how many times h/w
> mitigation was active.

Actually the stats are for software mitigation. For the driver, create a
debugfs entry like what do the other drivers or a module parameter with
the stats.

>>> The hardware limiter should let know the cpufreq framework about the
>>> frequency change.
>>>
>>> 	https://lkml.org/lkml/2021/6/8/1792
>>>
>>> May be post the sensor without the hw limiter for now and address that
>>> in a separate series ?
>>
> 
> I wasn't aware about existence of the thermal pressure, thank you for
> pointing at it. At a quick glance it should be possible to benefit from
> the information about the additional pressure.
> 
> Seems the current thermal pressure API assumes that there is only one
> user of the API. So it's impossible to aggregate the pressure from
> different sources, like software cpufreq pressure + h/w freq pressure.
> Correct? If yes, then please let me know yours thoughts about the best
> approach of supporting the aggregation.

That is a good question. IMO, first step would be to call
cpufreq_update_limits().

[ Cc Thara who implemented the thermal pressure ]

May be Thara has an idea about how to aggregate both? There is another
series floating around with hardware limiter [1] and the same problematic.

 [1] https://lkml.org/lkml/2021/6/8/1791

> I'll factor out the h/w limiter from this patchset and prepare the v4.
> Thank you all for taking a look at the patches.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
