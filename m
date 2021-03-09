Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7C6332EEA
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 20:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhCITWf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 14:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbhCITWa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 14:22:30 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24597C06175F
        for <linux-pm@vger.kernel.org>; Tue,  9 Mar 2021 11:22:30 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id e10so17911256wro.12
        for <linux-pm@vger.kernel.org>; Tue, 09 Mar 2021 11:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xECu7j4caESs4qHm6nqJu8LxqKwbnoC/gwB8ugNAdkc=;
        b=BKKl/bb1yN1pyDH8UWZznH7A8TAOnXuAaC4MDooNgYjaYTG1VFo1AV4DLU3R94Ta+q
         NAt26bRVkmCqFK/wJ9PDyeiL+mih9X8/U+5G2U7UONOCd5xIs3jcJ32qm4nG1/vqWYsd
         IiqgijkUbUPP33enyN7Sx/bA29KFzW+Uh1QBgHVczt1mkVDmbK4SPDR29beJcI2Q4K3w
         JvWvOVPgm5m87BlQF3AkS7n1MLiLrvdoodG9p4StzLa2PVT9VV0kMoRT+rDf65XBJ62L
         MWWbePM1yRVM8Gh6BPAQvxbtgO0qD184ny0WsN7Ew1hPJbY5EEFw2K6Rdbw46XFpuu1M
         iqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xECu7j4caESs4qHm6nqJu8LxqKwbnoC/gwB8ugNAdkc=;
        b=MLVRk0GJhL7WezoJXVN9Xa5xAyVpiVSXrlfDp6mWdmomU7a8qELRvH3jwDm1mUHRwV
         ZA8pRBsSV5mnwcZhbTSDIiB2iM7MDey4yGqgVUsZGd83j4ds71K0ahwWQGMD8stVgLPb
         JPz0/zsOAj4rWEvLozvwlEgdTC64R3DqGyBSzbrEGbZgeGEqx+3LHZAqmya/1daUoUJU
         /QCiwRhs/ONX+9+AESczKNJG5gyq5wCb9NhRsRs6rk40lxMIeKMg4Z4R/L0IE6/JrHXa
         VChgbaUyexPZ4boSogVqHYyEzHUO/Q5kuc2o3wXGlNnKQP42ksQYJZN5jvLLjWcMXE4N
         6XVA==
X-Gm-Message-State: AOAM531tgNSWVd+Z7KrYjPmA9A+ibZvbyFXemPPEMOsGV4vBijNQJbzS
        2eXTTmfUgb9eAgUSqr9s5sZGXZ7IZGgS6A==
X-Google-Smtp-Source: ABdhPJz22jW2GRZbrjqfNQQ1FoRiVToCTnO3UqyZ3E6raDvxbIFc+7RE3uDldocx82g6E5b2Qz0s7g==
X-Received: by 2002:a05:6000:118c:: with SMTP id g12mr30180353wrx.353.1615317748627;
        Tue, 09 Mar 2021 11:22:28 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8018:efa9:4421:9140? ([2a01:e34:ed2f:f020:8018:efa9:4421:9140])
        by smtp.googlemail.com with ESMTPSA id n6sm5831025wmd.27.2021.03.09.11.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 11:22:28 -0800 (PST)
Subject: Re: [PATCH 5/5] powercap/drivers/dtpm: Scale the power with the load
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210301212149.22877-1-daniel.lezcano@linaro.org>
 <20210301212149.22877-5-daniel.lezcano@linaro.org>
 <c30701f5-c1f8-cb5c-8791-f4068fb1bc14@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c863dad9-66d5-77b1-c1e2-53364dcbc805@linaro.org>
Date:   Tue, 9 Mar 2021 20:22:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c30701f5-c1f8-cb5c-8791-f4068fb1bc14@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/03/2021 11:01, Lukasz Luba wrote:
> Hi Daniel,
> 
> I've started reviewing the series, please find some comments below.
> 
> On 3/1/21 9:21 PM, Daniel Lezcano wrote:
>> Currently the power consumption is based on the current OPP power
>> assuming the entire performance domain is fully loaded.
>>
>> That gives very gross power estimation and we can do much better by
>> using the load to scale the power consumption.
>>
>> Use the utilization to normalize and scale the power usage over the
>> max possible power.
>>
>> Tested on a rock960 with 2 big CPUS, the power consumption estimation
>> conforms with the expected one.
>>
>> Before this change:
>>
>> ~$ ~/dhrystone -t 1 -l 10000&
>> ~$ cat
>> /sys/devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:1/constraint_0_max_power_uw
>>
>> 2260000
>>
>> After this change:
>>
>> ~$ ~/dhrystone -t 1 -l 10000&
>> ~$ cat
>> /sys/devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:1/constraint_0_max_power_uw
>>
>> 1130000
>>
>> ~$ ~/dhrystone -t 2 -l 10000&
>> ~$ cat
>> /sys/devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:1/constraint_0_max_power_uw
>>
>> 2260000
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/powercap/dtpm_cpu.c | 21 +++++++++++++++++----
>>   1 file changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
>> index e728ebd6d0ca..8379b96468ef 100644
>> --- a/drivers/powercap/dtpm_cpu.c
>> +++ b/drivers/powercap/dtpm_cpu.c
>> @@ -68,27 +68,40 @@ static u64 set_pd_power_limit(struct dtpm *dtpm,
>> u64 power_limit)
>>       return power_limit;
>>   }
>>   +static u64 scale_pd_power_uw(struct cpumask *cpus, u64 power)
> 
> renamed 'cpus' into 'pd_mask', see below
> 
>> +{
>> +    unsigned long max, util;
>> +    int cpu, load = 0;
> 
> IMHO 'int load' looks odd when used with 'util' and 'max'.
> I would put in the line above to have them all the same type and
> renamed to 'sum_util'.
> 
>> +
>> +    for_each_cpu(cpu, cpus) {
> 
> I would avoid the temporary CPU mask in the get_pd_power_uw()
> with this modified loop:
> 
> for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
> 
> 
>> +        max = arch_scale_cpu_capacity(cpu);
>> +        util = sched_cpu_util(cpu, max);
>> +        load += ((util * 100) / max);
> 
> Below you can find 3 optimizations. Since we are not in the hot
> path here, it's up to if you would like to use all/some of them
> or just ignore.
> 
> 1st optimization.
> If we use 'load += (util << 10) / max' in the loop, then
> we could avoid div by 100 and use a right shift:
> (power * load) >> 10
> 
> 2nd optimization.
> Since we use EM CPU mask, which span all CPUs with the same
> arch_scale_cpu_capacity(), you can avoid N divs inside the loop
> and do it once, below the loop.
> 
> 3rd optimization.
> If we just simply add all 'util' into 'sum_util' (no mul or div in
> the loop), then we might just have simple macro
> 
> #define CALC_POWER_USAGE(power, sum_util, max) \
>     (((power * (sum_util << 10)) / max) >> 10)

static u64 scale_pd_power_uw(struct cpumask *pd_mask, u64 power)
{
        unsigned long max, sum_max = 0, sum_util = 0;
        int cpu;

        for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
                max = arch_scale_cpu_capacity(cpu);
                sum_util += sched_cpu_util(cpu, max);
                sum_max += max;
        }

        return (power * ((sum_util << 10) / sum_max)) >> 10;
}

??

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
