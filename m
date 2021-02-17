Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB37231DC48
	for <lists+linux-pm@lfdr.de>; Wed, 17 Feb 2021 16:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbhBQPeB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Feb 2021 10:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbhBQPdV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2021 10:33:21 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3935C061756
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2021 07:32:40 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id v10so9777090qtq.7
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2021 07:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iCNwmZhWZAWkw9lmubfy3Ctrt4GVRNHAO0fjrQG+z70=;
        b=K7XhU7BCJNi7/Km2X5hifC75VEEjDwXIINfNpjT8aMJZecj/NE0rRTuoy3sNMp8fB1
         KTaxnDT2kurODW77ZPkg4j89ophmKvoPQKqyBbn1+kBkl7pkQLajB0xVcUf/4+bVg82m
         VD1ij0jLVKod10+gUZlx76ymqBLMwiHRUvUfRwxvt6fGrqIJz+jEoR99HapRyMqa+O8p
         So1G+QUivb7t1a1+9sgRSLKEvJL5PfwAPYLnI8V9h0Gqd9lNtHRwKl/QasnfX7QKqy48
         Tz8zGa9q/c3xU0nDgKh5qMZ5x9M99S5kCRJQcPf3XlQfTyckCOTp+2t+ekotQuR6B+NY
         YZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iCNwmZhWZAWkw9lmubfy3Ctrt4GVRNHAO0fjrQG+z70=;
        b=oNELTj4RIgi0EUCKbywXBWxaVahmmiK27NJdeXBiJuVcSZQYr3VSpc4WE1ZuXeL3UO
         4X1uulpP5OR3qoSyAXfA4lqtfkaLjjkqVPyobvDsn/SZhCOJm+8eYQJbFabTgxCwAqe2
         4Ei8ofnsqFjubHc0eSPaRy91BaXD8Vtmj74UyBm08gfjBaxz3+pIUA9+2XTKEdb0JANP
         la1ph52q8pob6WNoPhRdWbJCdUJINLAwETN4vaqBCS+ePQRu+Uc5f4F741XvlZtZsFu6
         OOjymjXJksMcx+aLsTx111OGC2PCAG4OGjRV8JVHt3NumLuzZJUayF5F15rVLY8xwgOw
         CU5w==
X-Gm-Message-State: AOAM530GdfzuNhK489ES0f7XeAsaDTnrPKSib8Ty2U7nu1IjKq+O7xPw
        lpwH9aUzXOTb/Rt5rhJkTJd01QoGlGD2Nw==
X-Google-Smtp-Source: ABdhPJzI+kSwjLRo2M5K5Vwk1Dg2soKjc4+KPmHsDbzklvoB72bf2QBgKx4M9bDqrixDGSOrhRhTtw==
X-Received: by 2002:ac8:110e:: with SMTP id c14mr23911588qtj.78.1613575959225;
        Wed, 17 Feb 2021 07:32:39 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id f78sm1845446qke.71.2021.02.17.07.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 07:32:38 -0800 (PST)
Subject: Re: [PATCH] cpufreq: exclude boost frequencies from valid count if
 not enabled
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, bjorn.andersson@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20210217000013.4063289-1-thara.gopinath@linaro.org>
 <20210217055029.a25wjsyoosxageti@vireshk-i7>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <4c9d9d44-5fa5-3ae1-e9bb-45cf6521b764@linaro.org>
Date:   Wed, 17 Feb 2021 10:32:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210217055029.a25wjsyoosxageti@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2/17/21 12:50 AM, Viresh Kumar wrote:
> Hi Thara,
> 
> On 16-02-21, 19:00, Thara Gopinath wrote:
>> This is a fix for a regression observed on db845 platforms with 5.7-rc11
>> kernel.  On these platforms running stress tests with 5.11-rc7 kernel
>> causes big cpus to overheat and ultimately shutdown the system due to
>> hitting critical temperature (thermal throttling does not happen and
>> cur_state of cpufreq cooling device for big cpus remain stuck at 0 or max
>> frequency).
>>
>> This platform has boost opp defined for big cpus but boost mode itself is
>> disabled in the cpufreq driver. Hence the initial max frequency request
>> from cpufreq cooling device(cur_state) for big cpus is for boost
>> frequency(2803200) where as initial max frequency request from cpufreq
>> driver itself is for the highest non boost frequency (2649600).
> 
> Okay.
> 
>> qos
>> framework collates these two requests and puts the max frequency of big
>> cpus to 2649600 which the thermal framework is unaware of.
> 
> It doesn't need to be aware of that. It sets its max frequency and other
> frameworks can put their own requests and the lowest one wins. In this case the
> other constraint came from cpufreq-core, which is fine.

Yes. the qos behavior is correct here.

> 
>> Now during an
>> over heat event, with step-wise policy governor, thermal framework tries to
>> throttle the cpu and places a restriction on max frequency of the cpu to
>> cur_state - 1
> 
> Actually it is cur_state + 1 as the values are inversed here, cooling state 0
> refers to highest frequency :)

yes. it does indeed!

> 
>> which in this case 2649600. qos framework in turn tells the
>> cpufreq cooling device that max frequency of the cpu is already at 2649600
>> and the cooling device driver returns doing nothing(cur_state of the
>> cooling device remains unchanged).
> 
> And that's where the bug lies, I have sent proper fix for that now.

Like I mention below there are multiple possible fixes for this issue!
More on mismatch of frequencies below.
> 
>> Thus thermal remains stuck in a loop and
>> never manages to actually throttle the cpu frequency. This ultimately leads
>> to system shutdown in case of a thermal overheat event on big cpus.
>   
>> There are multiple possible fixes for this issue. Fundamentally,it is wrong
>> for cpufreq driver and cpufreq cooling device driver to show different
>> maximum possible state/frequency for a cpu.
> 
> Not actually, cpufreq core changes the max supported frequency at runtime based
> on the availability of boost frequencies.

First of all, I am still unable to find this setting in the sysfs space.
Irrespective the ideal behavior here will be to change the cpufreq 
cooling dev max state when this happens. I say this for two reasons
1. The cooling device max state will reflect the correct highest 
frequency as reported by cpufreq core. These are interfaces exposed to
user space and they should not be showing two different things.
2. More importantly, thermal will not waste valuable cycles attempting 
to throttle down from an non-existing high frequency. In the case of 
sdm845 we have only one boost opp in the opp table and hence the first 
time thermal tries to throttle via the cpufreq cooling device(with the 
step policy governor), it will return back saying that the state is 
already achieved and then will retry again because overheating has not 
stopped. But let us a platform has 5 such opps in the table and boost 
mode not enabled. cpufreq cooling device will have to attempt 5 times 
before any actual cooling action happens.

> 
> cpufreq_table_count_valid_entries() is used at different places and it is
> implemented correctly.

It is used in one other place which is for statistics count. Boost 
statistics need not be considered if boost mode is not enabled. And like 
I mentioned before as in the case of cpufreq cooling device correct 
behavior will be to reflect this as and when boost is enabled. But then 
again for statistics purpose it is not much of an issue if the entry 
itself is present with the count showing 0 if boost modes are not 
enabled. In this case, we should have another api or cpufreq cooling 
device not use cpufreq_table_count_valid_entries to get the max state.

> 

-- 
Warm Regards
Thara
