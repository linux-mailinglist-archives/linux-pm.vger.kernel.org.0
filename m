Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9EC93A898A
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 21:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhFOTev (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 15:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhFOTeu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jun 2021 15:34:50 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B96C061574;
        Tue, 15 Jun 2021 12:32:44 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id e25so317572ljj.1;
        Tue, 15 Jun 2021 12:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y2rh97z0OrWxmrWAU8iLjlptE0MOV3gC6vzq0bU4ZRk=;
        b=doJldfegpVqpneDhRMP1dGIxBsmih9aqEjv135OyJk/NvFBAa1NALJCvR6oRva7hfc
         yabNy/uCBED0XVaYV7OnPLIQQ1CZt8t4NJ3GEQliq9vD2Cgo5fgwpoRaPd27MLX91MKq
         6Q9pkkAFM3GWYyv0G4dDT5dWEW/PyUF1ICayH4q7ONe7KFId09QTMiopaKDMj/3Td1m/
         giSvEvUkSO/MnWSb8hXU6etDVTQ8EGJChF41xrI34CjXUncQLeezYw4CHrvsMZ9qnxeg
         UOViU7cItk+USHLXLDRkEyE62M12LJNIoMn4y7QYZzCnkDE5cnx4v60+ELkOvk3mAugP
         GIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y2rh97z0OrWxmrWAU8iLjlptE0MOV3gC6vzq0bU4ZRk=;
        b=fDJGrJB22QFyH61ICXUhh0JmgNlbZq9+W/yTbUHxpYslWfsE/l6CWHP+pcJ9GNb1xt
         DHsk52cpR53f9UWuB4vAEqH5tZOqvUv6LJlcvEBbdV9emhIM74b+TIxsadVdHK4Kerbw
         G0VeW4q65pfpjmJhMr0Aa3EHbI0CRNklOjQM85CRvj3zX9+SGoUraAT1KueEmII4Q8Ub
         OPBX7DGuVZsxV7b68/1W18bHUtQiIeFPnnotrj7zv6cfLCxL4mrcvlFKtUyiIQyn67f6
         rm11hrFhVqmGdB92CU0CZ4vODqi65Iq7bPhcb9fOgEotAhChL8v38J09WtCRKyfz+TVi
         nosw==
X-Gm-Message-State: AOAM533AaaJ4q5criEZ4+gXCmloUwc2UyeNZW7QJn6V/dD62hwGFhsnw
        SLnvnq0sIZ7n10rR9RmG2FJ/8DKSyfQ=
X-Google-Smtp-Source: ABdhPJxrPmHx/YKZjKrwOuEf1wrXynTHWyf+2/2BwXJHUT6FQYQW++Fjsuwf3UHHEhA01eKBWcq4UA==
X-Received: by 2002:a05:651c:201d:: with SMTP id s29mr1093872ljo.258.1623785563170;
        Tue, 15 Jun 2021 12:32:43 -0700 (PDT)
Received: from [192.168.2.145] (94-29-31-25.dynamic.spd-mgts.ru. [94.29.31.25])
        by smtp.googlemail.com with ESMTPSA id w24sm1897424lfl.123.2021.06.15.12.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 12:32:42 -0700 (PDT)
Subject: Re: [PATCH v3 4/7] thermal/drivers/tegra: Add driver for Tegra30
 thermal sensor
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
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
 <fbdc3b56-4465-6d3e-74db-1d5082813b9c@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4c7b23c4-cf6a-0942-5250-63515be4a219@gmail.com>
Date:   Tue, 15 Jun 2021 22:32:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <fbdc3b56-4465-6d3e-74db-1d5082813b9c@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

15.06.2021 19:18, Daniel Lezcano пишет:
> On 15/06/2021 15:01, Dmitry Osipenko wrote:
>> 15.06.2021 13:26, Viresh Kumar пишет:
>>> On 15-06-21, 12:03, Daniel Lezcano wrote:
>>>>
>>>> [Cc Viresh]
>>>>
>>>> On 29/05/2021 19:09, Dmitry Osipenko wrote:
>>>>> All NVIDIA Tegra30 SoCs have a two-channel on-chip sensor unit which
>>>>> monitors temperature and voltage of the SoC. Sensors control CPU frequency
>>>>> throttling, which is activated by hardware once preprogrammed temperature
>>>>> level is breached, they also send signal to Power Management controller to
>>>>> perform emergency shutdown on a critical overheat of the SoC die. Add
>>>>> driver for the Tegra30 TSENSOR module, exposing it as a thermal sensor
>>>>> and a cooling device.
>>>>
>>>> IMO it does not make sense to expose the hardware throttling mechanism
>>>> as a cooling device because it is not usable anywhere from the thermal
>>>> framework.
>>>>
>>>> Moreover, that will collide with the thermal / cpufreq framework
>>>> mitigation (hardware sets the frequency but the software thinks the freq
>>>> is different), right ?
>>
>> H/w mitigation is additional and should be transparent to the software
>> mitigation. The software mitigation is much more flexible, but it has
>> latency. Software also could crash and hang.
>>
>> Hardware mitigation doesn't have latency and it will continue to work
>> regardless of the software state.
> 
> Yes, I agree. Both solutions have their pros and cons. However, I don't
> think they can co-exist sanely.
> 
>> The CCF driver is aware about the h/w cooling status [1], hence software
>> sees the actual frequency.
>>
>> [1]
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?id=344d5df34f5abd468267daa98f041abf90b2f660
> 
> Ah interesting, thanks for the pointer.
> 
> What I'm worried about is the consistency with cpufreq.
> 
> Probably cpufreq_update_limits() should be called from the interrupt
> handler.

IIUC, the cpufreq already should be prepared for the case where firmware
may override frequency. Viresh, could you please clarify what are the
possible implications of the frequency overriding?

>>> I am not even sure what the cooling device is doing here:
>>>
>>> tegra_tsensor_set_cur_state() is not implemented and it says hardware
>>> changed it by itself. What is the benefit you are getting out of the
>>> cooling device here ?
>>
>> It allows userspace to check whether hardware cooling is active via the
>> cooling_device sysfs. Otherwise we don't have ability to check whether
>> h/w cooling is active, I think it's a useful information. It's also
>> interesting to see the cooling_device stats, showing how many times h/w
>> mitigation was active.
> 
> Actually the stats are for software mitigation. For the driver, create a
> debugfs entry like what do the other drivers or a module parameter with
> the stats.

Okay

>>>> The hardware limiter should let know the cpufreq framework about the
>>>> frequency change.
>>>>
>>>> 	https://lkml.org/lkml/2021/6/8/1792
>>>>
>>>> May be post the sensor without the hw limiter for now and address that
>>>> in a separate series ?
>>>
>>
>> I wasn't aware about existence of the thermal pressure, thank you for
>> pointing at it. At a quick glance it should be possible to benefit from
>> the information about the additional pressure.
>>
>> Seems the current thermal pressure API assumes that there is only one
>> user of the API. So it's impossible to aggregate the pressure from
>> different sources, like software cpufreq pressure + h/w freq pressure.
>> Correct? If yes, then please let me know yours thoughts about the best
>> approach of supporting the aggregation.
> 
> That is a good question. IMO, first step would be to call
> cpufreq_update_limits().

Right

> [ Cc Thara who implemented the thermal pressure ]
> 
> May be Thara has an idea about how to aggregate both? There is another
> series floating around with hardware limiter [1] and the same problematic.
> 
>  [1] https://lkml.org/lkml/2021/6/8/1791

Thanks, it indeed looks similar.

I guess the common thermal pressure update code could be moved out into
a new special cpufreq thermal QoS handler (policy->thermal_constraints),
where handler will select the frequency constraint and set up the
pressure accordingly. So there won't be any races in the code.
