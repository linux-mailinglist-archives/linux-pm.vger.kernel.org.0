Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6EA4537FD
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 17:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbhKPQr5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 11:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbhKPQry (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 11:47:54 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34026C061764
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 08:44:57 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id z2-20020a9d71c2000000b0055c6a7d08b8so34601692otj.5
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 08:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=tBCEcBxxkWy7DtwDVDc+qef8W0JepmcD0E+LVB3BosQ=;
        b=Uy90Om181KxRRdPVFAqEwVY1cQErtUa8EITCgxvivESLVtXtTY1e6G03vaKkZpXfAk
         Bdz35QrEzbnFIqeQ59a6CYd51XM/lt3QvKnl25xUf7dudnhJ0EzHbvAnPY2Z6W3Ljvyl
         ArJYd2gSQ2HXeWK/MgRecHlg2D3dTpr/zKKqfIhWqrpqcDJJZzMKq5ihyYFe6LDGt+rL
         DcXWX8tqPMBFXgpeERjpUCwZbRiRxMZRIU982X2jRs/p2UoLKgFY9kcXzuNa19fptvqS
         iSRYYhg3HHgxZCF7zZvtvvlDJFx/soipskVRgyZvgMt6AawwLl+Bt2urDSkLjGi8tj5a
         thMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=tBCEcBxxkWy7DtwDVDc+qef8W0JepmcD0E+LVB3BosQ=;
        b=V8UCIS1HzVfbfYfjIZdboAJA8HsBgiOXyQWKCMmXMKc3mD1rDX8Rwxpj/0YWS4mX3P
         vhZPaxk5+U5YXkS/OUfd7J4HQeZIF6xQcuTdFcRHYYj301mjnxntWhr1HQ3beQu0sWdW
         FjwEIhuL07zYJ7puYNYnxvJxyJo4x8etWiyAgsRSzN5VC95j5nOD7ubMtigC0k/aSi+y
         FeizrEYi+73IY4BA/XFPRXpjYvq2n75XEMVHfDKSPrH9YuYNDAY/8eMJY3Ddso+MMD4F
         C7Qe73eC4VlgyMfQylcdnhshmEvMBvZzkmGRi6+PM9NJgwjLMPt01s5gQkZwgnekzcqJ
         BdjQ==
X-Gm-Message-State: AOAM530lAWfTozHGA6WfREAZgVM8LMurn0bi+ClweAkVOjs2yLIa6v/T
        mHLDxi2ZV+XCYyVhiJzysENtnw==
X-Google-Smtp-Source: ABdhPJwGySCvqYJmNIr1doWrqDUI7oorpeACdpXaga0AWv2+EbVhTLdYBgOcu969qUsx8hQjFE/GYw==
X-Received: by 2002:a9d:5d0b:: with SMTP id b11mr7232399oti.213.1637081096451;
        Tue, 16 Nov 2021 08:44:56 -0800 (PST)
Received: from [192.168.11.48] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id bi20sm4426252oib.29.2021.11.16.08.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 08:44:56 -0800 (PST)
Message-ID: <19991c37-4d05-b464-128b-8e7a767970b1@kali.org>
Date:   Tue, 16 Nov 2021 10:44:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH] cpufreq: freq_table: Initialize cpuinfo.max_freq to
 correct max frequency.
Content-Language: en-US
From:   Steev Klimaszewski <steev@kali.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>, rafael@kernel.org,
        viresh.kumar@linaro.org, bjorn.andersson@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20211115195011.52999-1-thara.gopinath@linaro.org>
 <5ae2c644-4743-c62c-b17c-96945a0e6a01@kali.org>
 <1ceb5a9b-817b-a9ef-c378-be3bd0f7ff17@linaro.org>
 <7b440c0f-57eb-e367-bcc7-91c731d360d5@kali.org>
In-Reply-To: <7b440c0f-57eb-e367-bcc7-91c731d360d5@kali.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 11/16/21 10:15 AM, Steev Klimaszewski wrote:
>
> On 11/16/21 9:31 AM, Thara Gopinath wrote:
>> Hi Steev,
>>
>> Thanks for testing this.
>>
>> On 11/15/21 8:23 PM, Steev Klimaszewski wrote:
>>
>> --- snip
>>>>
>>>> diff --git a/drivers/cpufreq/freq_table.c 
>>>> b/drivers/cpufreq/freq_table.c
>>>> index 67e56cf638ef..6784f94124df 100644
>>>> --- a/drivers/cpufreq/freq_table.c
>>>> +++ b/drivers/cpufreq/freq_table.c
>>>> @@ -35,11 +35,15 @@ int cpufreq_frequency_table_cpuinfo(struct 
>>>> cpufreq_policy *policy,
>>>>       struct cpufreq_frequency_table *pos;
>>>>       unsigned int min_freq = ~0;
>>>>       unsigned int max_freq = 0;
>>>> +    unsigned int cpuinfo_max_freq = 0;
>>>>       unsigned int freq;
>>>>       cpufreq_for_each_valid_entry(pos, table) {
>>>>           freq = pos->frequency;
>>>> +        if (freq > cpuinfo_max_freq)
>>>> +            cpuinfo_max_freq = freq;
>>>> +
>>>>           if (!cpufreq_boost_enabled()
>>>>               && (pos->flags & CPUFREQ_BOOST_FREQ))
>>>>               continue;
>>>> @@ -57,8 +61,8 @@ int cpufreq_frequency_table_cpuinfo(struct 
>>>> cpufreq_policy *policy,
>>>>        * If the driver has set its own cpuinfo.max_freq above 
>>>> max_freq, leave
>>>>        * it as is.
>>>>        */
>>>> -    if (policy->cpuinfo.max_freq < max_freq)
>>>> -        policy->max = policy->cpuinfo.max_freq = max_freq;
>>>> +    if (policy->cpuinfo.max_freq < cpuinfo_max_freq)
>>>> +        policy->cpuinfo.max_freq = cpuinfo_max_freq;
>>>>       if (policy->min == ~0)
>>>>           return -EINVAL;
>>>
>>>
>>> Something still isn't quite right...
>>>
>>> The setup is that I have an rc.local of
>>>
>>> #!/bin/sh
>>>
>>> echo 1 > /sys/devices/system/cpu/cpufreq/boost
>>>
>>> exit 0
>>>
>>>
>>> After booting and logging in:
>>>
>>> steev@limitless:~$ cat 
>>> /sys/devices/system/cpu/cpufreq/policy4/stats/time_in_state
>>> 825600 2499
>>> <snip>
>>> 2649600 38
>>> 2745600 31
>>> 2841600 1473
>>> 2956800 0
>>
>> Did you try debugging this ? As in did you read back boost and 
>> cpuinfo_max_freq at this point to ensure that everything is as 
>> expected ?
>>
>>
> Hi Thara,
>
> I did - sorry I forgot to mention that boost does show 1 for enabled 
> and cpuinfo_max_freq is set to 2956800.  However, scaling_max_freq is 
> still listed as 2841600 and scaling_available_frequencies still shows 
> 2841600 as the max available. scaling_boost_freqencies does also list 
> 2956800.
>
> steev@limitless:~$ grep . /sys/devices/system/cpu/cpufreq/policy4/*
> /sys/devices/system/cpu/cpufreq/policy4/affected_cpus:4 5 6 7
> grep: /sys/devices/system/cpu/cpufreq/policy4/cpuinfo_cur_freq: 
> Permission denied
> /sys/devices/system/cpu/cpufreq/policy4/cpuinfo_max_freq:2956800
> /sys/devices/system/cpu/cpufreq/policy4/cpuinfo_min_freq:825600
> /sys/devices/system/cpu/cpufreq/policy4/cpuinfo_transition_latency:0
> /sys/devices/system/cpu/cpufreq/policy4/related_cpus:4 5 6 7
> /sys/devices/system/cpu/cpufreq/policy4/scaling_available_frequencies:825600 
> 902400 979200 1056000 1209600 1286400 1363200 1459200 1536000 1612800 
> 1689600 1766400 1843200 1920000 1996800 2092800 2169600 2246400 
> 2323200 2400000 2476800 2553600 2649600 2745600 2841600
> /sys/devices/system/cpu/cpufreq/policy4/scaling_available_governors:ondemand 
> conservative powersave userspace performance schedutil
> /sys/devices/system/cpu/cpufreq/policy4/scaling_boost_frequencies:2956800
> /sys/devices/system/cpu/cpufreq/policy4/scaling_cur_freq:1920000
> /sys/devices/system/cpu/cpufreq/policy4/scaling_driver:qcom-cpufreq-hw
> /sys/devices/system/cpu/cpufreq/policy4/scaling_governor:schedutil
> /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq:2841600
> /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq:825600
> /sys/devices/system/cpu/cpufreq/policy4/scaling_setspeed:<unsupported>
>
Once it does start working (e.g. I've run echo 0 to turn off boost, and 
then echo 1 to turn it back one)

steev@limitless:~$ grep . /sys/devices/system/cpu/cpufreq/policy4/*
/sys/devices/system/cpu/cpufreq/policy4/affected_cpus:4 5 6 7
grep: /sys/devices/system/cpu/cpufreq/policy4/cpuinfo_cur_freq: 
Permission denied
/sys/devices/system/cpu/cpufreq/policy4/cpuinfo_max_freq:2956800
/sys/devices/system/cpu/cpufreq/policy4/cpuinfo_min_freq:825600
/sys/devices/system/cpu/cpufreq/policy4/cpuinfo_transition_latency:0
/sys/devices/system/cpu/cpufreq/policy4/related_cpus:4 5 6 7
/sys/devices/system/cpu/cpufreq/policy4/scaling_available_frequencies:825600 
902400 979200 1056000 1209600 1286400 1363200 1459200 1536000 1612800 
1689600 1766400 1843200 1920000 1996800 2092800 2169600 2246400 2323200 
2400000 2476800 2553600 2649600 2745600 2841600
/sys/devices/system/cpu/cpufreq/policy4/scaling_available_governors:ondemand 
conservative powersave userspace performance schedutil
/sys/devices/system/cpu/cpufreq/policy4/scaling_boost_frequencies:2956800
/sys/devices/system/cpu/cpufreq/policy4/scaling_cur_freq:1920000
/sys/devices/system/cpu/cpufreq/policy4/scaling_driver:qcom-cpufreq-hw
/sys/devices/system/cpu/cpufreq/policy4/scaling_governor:schedutil
/sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq:2956800
/sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq:825600
/sys/devices/system/cpu/cpufreq/policy4/scaling_setspeed:<unsupported>


Notice that the scaling_max_freq is now 2956800 instead of 2841600 when 
it isn't working.

Sorry for forgetting and sending another mail :(

-- steev

