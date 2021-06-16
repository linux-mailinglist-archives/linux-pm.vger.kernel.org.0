Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC793A8F09
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 04:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhFPCwy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 22:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbhFPCwx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jun 2021 22:52:53 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E9EC061767
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 19:50:47 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id r19so846638qvw.5
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 19:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4WFQbb2V5zS4ZcwvanZqqRP8ujMtDAGcUorwM6R/paU=;
        b=aU7UShi7TZ4Wge/ZEmrVVSVUpctNK7g7onlswiQ9Aaj1TwwPi0tz/Kv4Bg6o/if6I7
         VNr1rRD/syrBM2rNBEEaRrivvt3MLYXt0KpJfuUChLp8qsUpR55/dGDTJ7C0eLl6ywBd
         6BDzuzNRV67kPH2tZ+7Q4RpIj9SqR9hXvtq+SnaWO8hrTXHcUUW+RooMRLC6cXO86arA
         CqGG1ggddJMrMUhYCRCPxc+owtOTLckbozQVR8ABQYd7Zv9Q/eXpmYnjV7d7thNHkXpo
         b+4mx2HOz63z3kORwTJcTL0U7fVk+Vl/vFTRWIQxGAZHzlW4mLE7/Ju2VbTFmuqgB/CE
         0sfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4WFQbb2V5zS4ZcwvanZqqRP8ujMtDAGcUorwM6R/paU=;
        b=lgLRmZk6tedUsG3jkG/x3cuG7msBBJ/3fd8H0HyTXSk4dxq6ZjfKmm4beZII3m7bdD
         P0LXI+s8EQ6SQd7SVJS8hdd59k16QY2eM1ILicylkiV3xq1UA3fTfncJ2og/CVz5E6u7
         JtCmn6MgDH71f7Ex/BNashzGVOtdJdb9dDr73n9MOIv7fhtTCgs+/hiv/txOJKSDlceg
         J1Gk3FE7J4/nNBYTSV28NxQ+e4zugMfQNNPfqZdUqpa/jz52+g9NiGy0HVfXaz8/gPpp
         sYiEJe+mh7jCgj3JYbTRItZ08zzSG8Y/eg6NYXBO+hoy1I2xCMOhT4KYJtBL+KFMhncP
         Rntg==
X-Gm-Message-State: AOAM5309bcd0fPL2sB6XGriiIAYjgmmxtpBKGlKNzg/YycqePudN7pNp
        Vphl0rdonnnucE2xhkxHZ/lQe/GrKmAPag==
X-Google-Smtp-Source: ABdhPJyiOd7uoGzh4fh4IdSnwRsPHSc4NAugWSCIf4tijB028PyutbM7mt4Fdgv05raplBUDkMGemQ==
X-Received: by 2002:a05:6214:8f1:: with SMTP id dr17mr8597926qvb.42.1623811845774;
        Tue, 15 Jun 2021 19:50:45 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id w2sm710034qkf.88.2021.06.15.19.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 19:50:45 -0700 (PDT)
Subject: Re: [PATCH v3 4/7] thermal/drivers/tegra: Add driver for Tegra30
 thermal sensor
To:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
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
 <fbdc3b56-4465-6d3e-74db-1d5082813b9c@linaro.org>
 <4c7b23c4-cf6a-0942-5250-63515be4a219@gmail.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <545974aa-bb0f-169b-6f31-6e8c2461343f@linaro.org>
Date:   Tue, 15 Jun 2021 22:50:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4c7b23c4-cf6a-0942-5250-63515be4a219@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/15/21 3:32 PM, Dmitry Osipenko wrote:
> 15.06.2021 19:18, Daniel Lezcano пишет:
>> On 15/06/2021 15:01, Dmitry Osipenko wrote:
>>> 15.06.2021 13:26, Viresh Kumar пишет:
>>>> On 15-06-21, 12:03, Daniel Lezcano wrote:
>>>>>
>>>>> [Cc Viresh]
>>>>>
>>>>> On 29/05/2021 19:09, Dmitry Osipenko wrote:
>>>>>> All NVIDIA Tegra30 SoCs have a two-channel on-chip sensor unit which
>>>>>> monitors temperature and voltage of the SoC. Sensors control CPU frequency
>>>>>> throttling, which is activated by hardware once preprogrammed temperature
>>>>>> level is breached, they also send signal to Power Management controller to
>>>>>> perform emergency shutdown on a critical overheat of the SoC die. Add
>>>>>> driver for the Tegra30 TSENSOR module, exposing it as a thermal sensor
>>>>>> and a cooling device.
>>>>>
>>>>> IMO it does not make sense to expose the hardware throttling mechanism
>>>>> as a cooling device because it is not usable anywhere from the thermal
>>>>> framework.
>>>>>
>>>>> Moreover, that will collide with the thermal / cpufreq framework
>>>>> mitigation (hardware sets the frequency but the software thinks the freq
>>>>> is different), right ?
>>>
>>> H/w mitigation is additional and should be transparent to the software
>>> mitigation. The software mitigation is much more flexible, but it has
>>> latency. Software also could crash and hang.
>>>
>>> Hardware mitigation doesn't have latency and it will continue to work
>>> regardless of the software state.
>>
>> Yes, I agree. Both solutions have their pros and cons. However, I don't
>> think they can co-exist sanely.
>>
>>> The CCF driver is aware about the h/w cooling status [1], hence software
>>> sees the actual frequency.
>>>
>>> [1]
>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?id=344d5df34f5abd468267daa98f041abf90b2f660
>>
>> Ah interesting, thanks for the pointer.
>>
>> What I'm worried about is the consistency with cpufreq.
>>
>> Probably cpufreq_update_limits() should be called from the interrupt
>> handler.
> 
> IIUC, the cpufreq already should be prepared for the case where firmware
> may override frequency. Viresh, could you please clarify what are the
> possible implications of the frequency overriding?
> 
>>>> I am not even sure what the cooling device is doing here:
>>>>
>>>> tegra_tsensor_set_cur_state() is not implemented and it says hardware
>>>> changed it by itself. What is the benefit you are getting out of the
>>>> cooling device here ?
>>>
>>> It allows userspace to check whether hardware cooling is active via the
>>> cooling_device sysfs. Otherwise we don't have ability to check whether
>>> h/w cooling is active, I think it's a useful information. It's also
>>> interesting to see the cooling_device stats, showing how many times h/w
>>> mitigation was active.
>>
>> Actually the stats are for software mitigation. For the driver, create a
>> debugfs entry like what do the other drivers or a module parameter with
>> the stats.
> 
> Okay
> 
>>>>> The hardware limiter should let know the cpufreq framework about the
>>>>> frequency change.
>>>>>
>>>>> 	https://lkml.org/lkml/2021/6/8/1792
>>>>>
>>>>> May be post the sensor without the hw limiter for now and address that
>>>>> in a separate series ?
>>>>
>>>
>>> I wasn't aware about existence of the thermal pressure, thank you for
>>> pointing at it. At a quick glance it should be possible to benefit from
>>> the information about the additional pressure.
>>>
>>> Seems the current thermal pressure API assumes that there is only one
>>> user of the API. So it's impossible to aggregate the pressure from
>>> different sources, like software cpufreq pressure + h/w freq pressure.
>>> Correct? If yes, then please let me know yours thoughts about the best
>>> approach of supporting the aggregation.

Hi,

Thermal pressure is letting scheduler know that the max capacity 
available for a cpu to schedule tasks is reduced due to a thermal event.
So you cannot have a h/w thermal pressure and s/w thermal pressure. 
There is eventually only one capping applied at h/w level and the 
frequency corresponding to this capping should be used for thermal pressure.

Ideally you should not be having both s/w and h/w trying to throttle at 
the same time. Why is this a scenario and what prevents you from 
disabling s/w throttling when h/w throttling is enabled. Now if there 
has to a aggregation for whatever reason this should be done at the 
thermal driver level and passed to scheduler.

>>
>> That is a good question. IMO, first step would be to call
>> cpufreq_update_limits().
> 
> Right
> 
>> [ Cc Thara who implemented the thermal pressure ]
>>
>> May be Thara has an idea about how to aggregate both? There is another
>> series floating around with hardware limiter [1] and the same problematic.
>>
>>   [1] https://lkml.org/lkml/2021/6/8/1791
> 
> Thanks, it indeed looks similar.
> 
> I guess the common thermal pressure update code could be moved out into
> a new special cpufreq thermal QoS handler (policy->thermal_constraints),
> where handler will select the frequency constraint and set up the
> pressure accordingly. So there won't be any races in the code.
> 
It was a conscious decision to keep thermal pressure update out of qos 
max freq update because there are platforms that don't use the qos 
framework. For eg acpi uses cpufreq_update_policy.
But you are right. We have two platforms now applying h/w throttling and 
cpufreq_cooling applying s/w throttling. So it does make sense to have 
one api doing all the computation to update thermal pressure. I am not 
sure how exactly/where exactly this will reside.

So for starters, I think you should replicate the update of thermal 
pressure in your h/w driver when you know that h/w is 
throttling/throttled the frequency. You can refer to cpufreq_cooling.c 
to see how it is done.

Moving to a common api can be done as a separate patch series.

-- 
Warm Regards
Thara (She/Her/Hers)
