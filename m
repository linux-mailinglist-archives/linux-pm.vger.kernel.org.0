Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7EE63A9DAD
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 16:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhFPOi3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 10:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbhFPOi2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 10:38:28 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38D0C061767
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 07:36:20 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id g142so1287441qke.4
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 07:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C6N7ZLY1WhDSZqhuZcLY/QHujQYu6PkAlcx3M6QgT6k=;
        b=lOsfCoqWux3C4DdeAMZTDNufs06iP6UqU1XS14MePe0Fxa/GAhcx+oN0u6vW5Ilm/X
         lN4FSzc0CG9F8545wOn5VtuDBEFQ8kAASsbxlqYt5DcwEZVQrlG84VemH3pEcOzxbh/l
         1pT4rMyWUfJs9Qsmta5CcXcQbaGUkzOQ8T4MoOs4SSnIUTOqD6KMLnTmSaj9kH/v3zKT
         +pQZL2VHUxAl3cyJjef6Oxy27O9TRzG1Vvj9zeD2CF+gfrgcdVYm2GJIfs6POyw5LCeZ
         c84PFBSGWQxHOfErl78EpnnNhWJS6WOkxZZzcNZmXRS3gcPOqJEZveBloOPo1Xt7TMw2
         aYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C6N7ZLY1WhDSZqhuZcLY/QHujQYu6PkAlcx3M6QgT6k=;
        b=OGN13zr+NyenHilXlEwwhakBx6+KMncaev4NRCNbKIcZAmaJDYd0oCxhFKTzbOruns
         Ak4qeOVxmcDLHcbJg6aLnpf243X5LFreunhJGCCNtAc8LG1bF9L1bJNjO3sBORBDR1Nd
         +29MgsDUFUyNkSIK38V2kTEKiuTmRLQAKPHfaSMJKzXr7+Z3ZX0jC3yR3EHWj4G7cbze
         EwggRt7PhrA3sSX3LyZR0U9lil+LN2SOFZVg36dNKWHbA5xm757BBENwOM2lgZ5ocMae
         8fJIvyiLrZdTAKcpA1ownu/q79eu93HfnqhzoqhsoZay7DGGHqb5W/5Ma9IOFjysHOo5
         HWnQ==
X-Gm-Message-State: AOAM532rcICuQ+8ckfRD/QsnGMa2B7tyrS7wgSR9p3NRHdez3rCnDwCX
        SWlzMEQKXZBdGPYuRH7deeOoYrT+nFcw2A==
X-Google-Smtp-Source: ABdhPJyQfSgTLuanvM52DFRrLyjJpWyc1bNVtB3kIaDVomzEZTehCLdam7DcZd2qn8FbX1cl+wfGsw==
X-Received: by 2002:a05:620a:4da:: with SMTP id 26mr348132qks.336.1623854179605;
        Wed, 16 Jun 2021 07:36:19 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id a3sm1675158qkc.109.2021.06.16.07.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 07:36:19 -0700 (PDT)
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
 <545974aa-bb0f-169b-6f31-6e8c2461343f@linaro.org>
 <f06370e0-bfde-87d0-03b4-93c667f81817@gmail.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <14b6344b-3994-7977-6933-a2d2357d23d5@linaro.org>
Date:   Wed, 16 Jun 2021 10:36:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f06370e0-bfde-87d0-03b4-93c667f81817@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/16/21 6:47 AM, Dmitry Osipenko wrote:
> 16.06.2021 05:50, Thara Gopinath пишет:
> ...
>>
>> Hi,
>>
>> Thermal pressure is letting scheduler know that the max capacity
>> available for a cpu to schedule tasks is reduced due to a thermal event.
>> So you cannot have a h/w thermal pressure and s/w thermal pressure.
>> There is eventually only one capping applied at h/w level and the
>> frequency corresponding to this capping should be used for thermal
>> pressure.
>>
>> Ideally you should not be having both s/w and h/w trying to throttle at
>> the same time. Why is this a scenario and what prevents you from
>> disabling s/w throttling when h/w throttling is enabled. Now if there
>> has to a aggregation for whatever reason this should be done at the
>> thermal driver level and passed to scheduler.
> 
> Hello,
> 
> The h/w mitigation is much more reactive than software, in the same time
> it's much less flexible than software. It should provide additional
> protection in a cases where software isn't doing a good job. Ideally h/w
> mitigation should stay inactive all the time, nevertheless it should be
> modeled properly by the driver.

Ok. This is kind of opposite to what I am doing on the Qcom platform I 
am working on. The h/w throttling is the default since like you 
mentioned it is more reactive. And s/w does only critical trip management.

> 
>>>>
>>>> That is a good question. IMO, first step would be to call
>>>> cpufreq_update_limits().
>>>
>>> Right
>>>
>>>> [ Cc Thara who implemented the thermal pressure ]
>>>>
>>>> May be Thara has an idea about how to aggregate both? There is another
>>>> series floating around with hardware limiter [1] and the same
>>>> problematic.
>>>>
>>>>    [1] https://lkml.org/lkml/2021/6/8/1791
>>>
>>> Thanks, it indeed looks similar.
>>>
>>> I guess the common thermal pressure update code could be moved out into
>>> a new special cpufreq thermal QoS handler (policy->thermal_constraints),
>>> where handler will select the frequency constraint and set up the
>>> pressure accordingly. So there won't be any races in the code.
>>>
>> It was a conscious decision to keep thermal pressure update out of qos
>> max freq update because there are platforms that don't use the qos
>> framework. For eg acpi uses cpufreq_update_policy.
>> But you are right. We have two platforms now applying h/w throttling and
>> cpufreq_cooling applying s/w throttling. So it does make sense to have
>> one api doing all the computation to update thermal pressure. I am not
>> sure how exactly/where exactly this will reside.
> 
> The generic cpufreq_cooling already uses QoS for limiting the CPU
> frequency. It could be okay to use QoS for the OF drivers, this needs a
> closer look.
> 
> We have the case where CPU frequency is changed by the thermal event and
> the thermal pressure equation is the same for both s/w cpufreq_cooling
> and h/w thermal driver. The pressure is calculated based on the QoS
> cpufreq constraint that is already aggregated.
> 
> Hence what we may need to do on the thermal event is:
> 
> 1. Update the QoS request
> 2. Update the thermal pressure
> 3. Ensure that updates are not racing

Yes. So the first two steps you mentioned is exactly what 
cpufreq_cooling.c also does except for the fact that it is a s/w 
mitigation. Now if you have two sources that is updating the max 
frequency via qos, I think you can do either of the following before
calculating thermal pressure
1. Read the throttled frequency from h/w if  your h/w supports this feature.
	or
2. Use freq_qos_read_value to get the max frequency value.

Either way only the correct throttled capacity should be passed to 
scheduler.

-- 
Warm Regards
Thara (She/Her/Hers)
> 
>> So for starters, I think you should replicate the update of thermal
>> pressure in your h/w driver when you know that h/w is
>> throttling/throttled the frequency. You can refer to cpufreq_cooling.c
>> to see how it is done.
>>
>> Moving to a common api can be done as a separate patch series.
>>
> 
> Thank you for the clarification and suggestion.
> 

