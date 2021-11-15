Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A999452839
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 04:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239899AbhKPDMl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Nov 2021 22:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbhKPDMj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Nov 2021 22:12:39 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E048C10E5C0
        for <linux-pm@vger.kernel.org>; Mon, 15 Nov 2021 15:39:21 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id f20so16965909qtb.4
        for <linux-pm@vger.kernel.org>; Mon, 15 Nov 2021 15:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VjOan0HHvAXW29wZl9JKtBMmoQg1ghG0Q36yMXfVU64=;
        b=z7O4g9CGHwpEuKH5cAnHlOg6G99gl33JXSF84Bb7wMQab9d5VqGA/w5N4C72NcBzWZ
         xhNFGu6LEh4uidgFDEw9VurubD66YGY/W09FZpVLhevmwSSxZqsJ+CkMlIm++AA4fkOl
         dAiqWnJGcQitdHOXHOneEVTmIepqB6mo+06ASbIXkwsQ2xGzJU5mozB4jbFgMwMlrRmc
         yDPYLTR6LA9irW50VSRip0QRlbK1K5m1GyU5WJVKo7400Qxejx4MphAQtomw81NHjKfa
         7CSR2/vW8uZzJ1WNEgxLb+bN961TNtbd7+S7EJBzKta/B1/UoIbStQ/8rFZ5UzofFw91
         J1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VjOan0HHvAXW29wZl9JKtBMmoQg1ghG0Q36yMXfVU64=;
        b=HRWR03PU+wY4bmKDTA1dcc9YAX139wrNM/lcKXZeha8kVaREFf4zjv7fQd8dzPG4oJ
         O1Hy8C+PEgbAiGw+onfrLgucga0reVcsoD02RiEWsIuVilP+yEdymAxGcZw0qunnvp2m
         WVCAU0TVuPPkjTt0pHnRZQFFz/XICgVjxJ89ullCH032u3QQyfqQ/iJiipKEVq/y/JZx
         1xWsNX4hcrb/WAkTvN3U8aeSboFdRE+szJ00n3RKM/u/sdOGPxSLMF7uVP1QJMBXo41J
         0RwdNj1Is0bhPMvsT65ffyquHOqUQ/pjmj+rTvTI3sQpeyG1zcRF1rh+l6BHVnQ2VNMU
         2WSQ==
X-Gm-Message-State: AOAM531Arv5+qSxjWiOYwp9ZQXB6gHJkdvFfo6HfFXVn1p5bRE+lXkzD
        XrvfcT+5gdLyntQnSWA1gInFdQ==
X-Google-Smtp-Source: ABdhPJyxezWTWmmvW1KDWHOOrvvfcXtYji2aB5xcA7gZ+xS3WLO0N5mJvNfi06ORxKx8KHTYzmc2Lw==
X-Received: by 2002:a05:622a:20b:: with SMTP id b11mr2992884qtx.25.1637019560498;
        Mon, 15 Nov 2021 15:39:20 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id e13sm2628260qte.56.2021.11.15.15.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 15:39:19 -0800 (PST)
Subject: Re: [PATCH v4 4/5] cpufreq: qcom-cpufreq-hw: Use new thermal pressure
 update function
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, steev@kali.org,
        sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        bjorn.andersson@linaro.org, agross@kernel.org
References: <20211109195714.7750-1-lukasz.luba@arm.com>
 <20211109195714.7750-5-lukasz.luba@arm.com>
 <02a848c8-a672-f3df-7144-979a9df71fcb@linaro.org>
Message-ID: <911760d9-b137-5c79-d072-c2f473a3cc6a@linaro.org>
Date:   Mon, 15 Nov 2021 18:39:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <02a848c8-a672-f3df-7144-979a9df71fcb@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/15/21 3:57 PM, Thara Gopinath wrote:
> 
> 
> On 11/9/21 2:57 PM, Lukasz Luba wrote:
>> Thermal pressure provides a new API, which allows to use CPU frequency
>> as an argument. That removes the need of local conversion to capacity.
>> Use this new API and remove old local conversion code.
>>
>> The new arch_update_thermal_pressure() also accepts boost frequencies,
>> which solves issue in the driver code with wrong reduced capacity
>> calculation. The reduced capacity was calculated wrongly due to
>> 'policy->cpuinfo.max_freq' used as a divider. The value present there was
>> actually the boost frequency. Thus, even a normal maximum frequency value
>> which corresponds to max CPU capacity (arch_scale_cpu_capacity(cpu_id))
>> is not able to remove the capping.

Also I failed to mention that, currently freq_factor is initialized as 
cpuinfo.max_freq / 1000 which means again all the issues you mentioned 
below can be hit, if some cpufreq driver decides to set boost at init.
I have sent a patch earlier today to fix this.

https://lore.kernel.org/linux-arm-msm/20211115201010.68567-1-thara.gopinath@linaro.org/T/#u

-- 
Warm Regards
Thara (She/Her/Hers)
> 
> Yes, although cpuinfo.max_freq does not reflect the boost frequency 
> unless boost is enabled atleast once. I have sent a patch to fix this. 
> But I agree that using cpuinfo.max_freq has issues you have mentioned in 
> this patch if boost is enabled once.
> 
> So, for this patch
> 
> Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
> 
> Warm Regards
> Thara (She/Her/Hers)
>>
>> The second side effect which is solved is that the reduced frequency 
>> wasn't
>> properly translated into the right reduced capacity,
>> e.g.
>> boost frequency = 3000MHz (stored in policy->cpuinfo.max_freq)
>> max normal frequency = 2500MHz (which is 1024 capacity)
>> 2nd highest frequency = 2000MHz (which translates to 819 capacity)
>>
>> Then in a scenario when the 'throttled_freq' max allowed frequency was
>> 2000MHz the driver translated it into 682 capacity:
>> capacity = 1024 * 2000 / 3000 = 682
>> Then set the pressure value bigger than actually applied by the HW:
>> max_capacity - capacity => 1024 - 682 = 342 (<- thermal pressure)
>> Which was causing higher throttling and misleading task scheduler
>> about available CPU capacity.
>> A proper calculation in such case should be:
>> capacity = 1024 * 2000 / 2500 = 819
>> 1024 - 819 = 205 (<- thermal pressure)
>>
>> This patch relies on the new arch_update_thermal_pressure() handling
>> correctly such use case (with boost frequencies).
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/cpufreq/qcom-cpufreq-hw.c | 15 +++------------
>>   1 file changed, 3 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c 
>> b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index 0138b2ec406d..248135e5087e 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -275,10 +275,10 @@ static unsigned int 
>> qcom_lmh_get_throttle_freq(struct qcom_cpufreq_data *data)
>>   static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
>>   {
>> -    unsigned long max_capacity, capacity, freq_hz, throttled_freq;
>>       struct cpufreq_policy *policy = data->policy;
>>       int cpu = cpumask_first(policy->cpus);
>>       struct device *dev = get_cpu_device(cpu);
>> +    unsigned long freq_hz, throttled_freq;
>>       struct dev_pm_opp *opp;
>>       unsigned int freq;
>> @@ -295,17 +295,8 @@ static void qcom_lmh_dcvs_notify(struct 
>> qcom_cpufreq_data *data)
>>       throttled_freq = freq_hz / HZ_PER_KHZ;
>> -    /* Update thermal pressure */
>> -
>> -    max_capacity = arch_scale_cpu_capacity(cpu);
>> -    capacity = mult_frac(max_capacity, throttled_freq, 
>> policy->cpuinfo.max_freq);
>> -
>> -    /* Don't pass boost capacity to scheduler */
>> -    if (capacity > max_capacity)
>> -        capacity = max_capacity;
>> -
>> -    arch_set_thermal_pressure(policy->related_cpus,
>> -                  max_capacity - capacity);
>> +    /* Update thermal pressure (the boost frequencies are accepted) */
>> +    arch_update_thermal_pressure(policy->related_cpus, throttled_freq);
>>       /*
>>        * In the unlikely case policy is unregistered do not enable
>>
> 

