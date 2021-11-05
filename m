Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FC54468CD
	for <lists+linux-pm@lfdr.de>; Fri,  5 Nov 2021 20:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhKETVI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Nov 2021 15:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbhKETVH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Nov 2021 15:21:07 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936C1C061714
        for <linux-pm@vger.kernel.org>; Fri,  5 Nov 2021 12:18:27 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id d6so7967847qvb.3
        for <linux-pm@vger.kernel.org>; Fri, 05 Nov 2021 12:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nMArXgyRFwIr/sExIAj6beitEUrgpBOeYC39dRrZA5I=;
        b=AdQbRzdKfXwzzyLDgZX1CPfVluGPIImeOYdxUdUmoANKwSq3VVvIoI6kyaAnAr41G9
         eTMia7SAgT3ntSLmMnLcARVktjoaB/URXjZczXxIX2Pdqe2ZslrTJVRQmNWClpL8qVc7
         GN4c7/Y4RX54uVCw03hywLK5VA1muBsdKTKK4sii0WmCQTf2H4TKV/ZMVfRa7MPOPEVG
         2NafwD/0nNIfv++HAVDmLCC5IsRosfK/J0dgzQunzRqeruyXGa31dblkvYtfnB020zME
         dVUWUQ40aTvWgDngz9rc9/k8CfErRWkpKG3NnnVTcS5P8qeXI3ey09AFVq94lvQu1V5f
         TDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nMArXgyRFwIr/sExIAj6beitEUrgpBOeYC39dRrZA5I=;
        b=vBSCJ5swZa/TBQmo5zf5quNtvI8U974wLfEW5ODn4NcodoSSQH4aJjNFp5uk7OjlKz
         02KN8PTRaGCHjCo/umZwR2r/3Gk3y0dFe3LohpagGxLb6hDwcFUFK3Fh7x9Sh1WVU74P
         9icEviLCKRjaB2SP/l9rQoqoiiVKrcOqommjQfQhBrJsY6DpDG9YASe+B5TfHhcHEimx
         FhXLtCUjlg+ykvK9GCk534dx35cq4tJRj4uOlomcIJ1UlpIjenXEj8nxHim+WREzwdmp
         1u7AvRPRPoFsuCKX2HCjQlC/OEqA81hfvGyAZjJOQ5mQp6czhNfZd4fTCWGEDfua9fTv
         okGw==
X-Gm-Message-State: AOAM530+EV52rSVUHHZ+oxD8KRaBN2CY39AcBcqTe6KjYhSv72c1nVKu
        BeMTOgsFjadFJHwmhNMTYSdlYw==
X-Google-Smtp-Source: ABdhPJwwN/1wpc/53ZbKLojNDqoWojpqgZ3ZfuRwqRFO27IFWzyS158WAM1g+eoCD7u2bFewNr246g==
X-Received: by 2002:a05:6214:2429:: with SMTP id gy9mr10334015qvb.36.1636139906623;
        Fri, 05 Nov 2021 12:18:26 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id d203sm1001287qke.37.2021.11.05.12.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 12:18:25 -0700 (PDT)
Subject: Re: [PATCH v3 0/5] Refactor thermal pressure update to avoid code
 duplication
To:     Steev Klimaszewski <steev@kali.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, sudeep.holla@arm.com,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        bjorn.andersson@linaro.org, agross@kernel.org
References: <20211103161020.26714-1-lukasz.luba@arm.com>
 <c7b526f0-2c26-0cfc-910b-3521c6a6ef51@kali.org>
 <3cba148a-7077-7b6b-f131-dc65045aa348@arm.com>
 <9d533b6e-a81c-e823-fa6f-61fdea92fa65@kali.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <74ea027b-b213-42b8-0f7d-275f3b84712e@linaro.org>
Date:   Fri, 5 Nov 2021 15:18:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9d533b6e-a81c-e823-fa6f-61fdea92fa65@kali.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/5/21 1:33 PM, Steev Klimaszewski wrote:
> Hi,
> 
> On 11/5/21 11:26 AM, Lukasz Luba wrote:
>> Hi Steev,
>>
>> On 11/5/21 3:39 PM, Steev Klimaszewski wrote:
>>> Hi Lukasz,
>>>
>>
>> [snip]
>>
>>> I've been testing this patchset on the Lenovo Yoga C630, and today 
>>> while compiling alacritty and running an apt-get full-upgrade, I 
>>> found the following in dmesg output:
>>
>> Thank you for testing and sending feedback!
>>
>> Are you using a mainline kernel or you applied on some vendor production
>> kernel this patch set? I need to exclude a different code base
>> from the equation, especially to the arch_topology.c init code.
>>
> This is stabe 5.15.0 tree with ~72 (including your 6 patches on top 
> (including the below as a patch).  You can find it at 
> https://github.com/steev/linux/commits/linux-5.15.y - the vast majority 
> are just various fixups for sdm845/sdm850 for the Lenovo Yoga (or crypto 
> since I'd like to see the crypto unit working).
> 
> I did grep through my logs and it appears that this started after I 
> moved from v2 to v3 - I'd tested v2 and it didn't show this.
> 
> [snip]
> 
>> [snip]
>>
>> That's interesting why we hit this. I should have added info about
>> those two values, which are compared.
>>
>> Could you make this change and try it again, please?
>> We would know the problematic values, which triggered this.
>> ---------------------8<-----------------------------------
>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>> index db18d79065fe..0d8db0927041 100644
>> --- a/drivers/base/arch_topology.c
>> +++ b/drivers/base/arch_topology.c
>> @@ -185,8 +185,11 @@ void topology_update_thermal_pressure(const 
>> struct cpumask *cpus,
>>         /* Convert to MHz scale which is used in 'freq_factor' */
>>         capped_freq /= 1000;
>>
>> -       if (WARN_ON(max_freq < capped_freq))
>> +       if (max_freq < capped_freq) {
>> +               pr_warn("THERMAL_PRESSURE: max_freq (%lu) < 
>> capped_freq (%lu) for CPUs [%*pbl]\n",
>> +                       max_freq, capped_freq, cpumask_pr_args(cpus));
>>                 return;
>> +       }
>>
>>         capacity = mult_frac(capped_freq, max_capacity, max_freq);
>>
>> ------------------------------>8---------------------------
> 
> Applying this to the above kernel.. will test...
> 
> 
>>
>> Could you also dump for me the cpufreq and capacity sysfs content?
>> $ grep . /sys/devices/system/cpu/cpu*/cpufreq/*
> 
> 
> /sys/devices/system/cpu/cpu0/cpufreq/affected_cpus:0 1 2 3
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:300000
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq:1766400
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq:300000
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_transition_latency:0
> /sys/devices/system/cpu/cpu0/cpufreq/related_cpus:0 1 2 3
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies:300000 403200 
> 480000 576000 652800 748800 825600 902400 979200 1056000 1132800 1228800 
> 1324800 1420800 1516800 1612800 1689600 1766400
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors:ondemand conservative 
> powersave userspace performance schedutil
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:300000
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver:qcom-cpufreq-hw
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:schedutil
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq:1766400
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq:300000
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed:<unsupported>
> /sys/devices/system/cpu/cpu1/cpufreq/affected_cpus:0 1 2 3
> /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq:300000
> /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_max_freq:1766400
> /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_min_freq:300000
> /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_transition_latency:0
> /sys/devices/system/cpu/cpu1/cpufreq/related_cpus:0 1 2 3
> /sys/devices/system/cpu/cpu1/cpufreq/scaling_available_frequencies:300000 403200 
> 480000 576000 652800 748800 825600 902400 979200 1056000 1132800 1228800 
> 1324800 1420800 1516800 1612800 1689600 1766400
> /sys/devices/system/cpu/cpu1/cpufreq/scaling_available_governors:ondemand conservative 
> powersave userspace performance schedutil
> /sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:300000
> /sys/devices/system/cpu/cpu1/cpufreq/scaling_driver:qcom-cpufreq-hw
> /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor:schedutil
> /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq:1766400
> /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq:300000
> /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed:<unsupported>
> /sys/devices/system/cpu/cpu2/cpufreq/affected_cpus:0 1 2 3
> /sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_cur_freq:300000
> /sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_max_freq:1766400
> /sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_min_freq:300000
> /sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_transition_latency:0
> /sys/devices/system/cpu/cpu2/cpufreq/related_cpus:0 1 2 3
> /sys/devices/system/cpu/cpu2/cpufreq/scaling_available_frequencies:300000 403200 
> 480000 576000 652800 748800 825600 902400 979200 1056000 1132800 1228800 
> 1324800 1420800 1516800 1612800 1689600 1766400
> /sys/devices/system/cpu/cpu2/cpufreq/scaling_available_governors:ondemand conservative 
> powersave userspace performance schedutil
> /sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq:300000
> /sys/devices/system/cpu/cpu2/cpufreq/scaling_driver:qcom-cpufreq-hw
> /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor:schedutil
> /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq:1766400
> /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq:300000
> /sys/devices/system/cpu/cpu2/cpufreq/scaling_setspeed:<unsupported>
> /sys/devices/system/cpu/cpu3/cpufreq/affected_cpus:0 1 2 3
> /sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_cur_freq:300000
> /sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_max_freq:1766400
> /sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_min_freq:300000
> /sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_transition_latency:0
> /sys/devices/system/cpu/cpu3/cpufreq/related_cpus:0 1 2 3
> /sys/devices/system/cpu/cpu3/cpufreq/scaling_available_frequencies:300000 403200 
> 480000 576000 652800 748800 825600 902400 979200 1056000 1132800 1228800 
> 1324800 1420800 1516800 1612800 1689600 1766400
> /sys/devices/system/cpu/cpu3/cpufreq/scaling_available_governors:ondemand conservative 
> powersave userspace performance schedutil
> /sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq:300000
> /sys/devices/system/cpu/cpu3/cpufreq/scaling_driver:qcom-cpufreq-hw
> /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor:schedutil
> /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq:1766400
> /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq:300000
> /sys/devices/system/cpu/cpu3/cpufreq/scaling_setspeed:<unsupported>
> /sys/devices/system/cpu/cpu4/cpufreq/affected_cpus:4 5 6 7
> /sys/devices/system/cpu/cpu4/cpufreq/cpuinfo_cur_freq:1920000
> /sys/devices/system/cpu/cpu4/cpufreq/cpuinfo_max_freq:2956800
> /sys/devices/system/cpu/cpu4/cpufreq/cpuinfo_min_freq:825600
> /sys/devices/system/cpu/cpu4/cpufreq/cpuinfo_transition_latency:0
> /sys/devices/system/cpu/cpu4/cpufreq/related_cpus:4 5 6 7
> /sys/devices/system/cpu/cpu4/cpufreq/scaling_available_frequencies:825600 902400 
> 979200 1056000 1209600 1286400 1363200 1459200 1536000 1612800 1689600 
> 1766400 1843200 1920000 1996800 2092800 2169600 2246400 2323200 2400000 
> 2476800 2553600 2649600 2745600 2841600
> /sys/devices/system/cpu/cpu4/cpufreq/scaling_available_governors:ondemand conservative 
> powersave userspace performance schedutil
> /sys/devices/system/cpu/cpu4/cpufreq/scaling_boost_frequencies:2956800
> /sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq:1920000
> /sys/devices/system/cpu/cpu4/cpufreq/scaling_driver:qcom-cpufreq-hw
> /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor:schedutil
> /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq:2841600
> /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq:825600
> /sys/devices/system/cpu/cpu4/cpufreq/scaling_setspeed:<unsupported>
> /sys/devices/system/cpu/cpu5/cpufreq/affected_cpus:4 5 6 7
> /sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_cur_freq:1996800
> /sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_max_freq:2956800
> /sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_min_freq:825600
> /sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_transition_latency:0
> /sys/devices/system/cpu/cpu5/cpufreq/related_cpus:4 5 6 7
> /sys/devices/system/cpu/cpu5/cpufreq/scaling_available_frequencies:825600 902400 
> 979200 1056000 1209600 1286400 1363200 1459200 1536000 1612800 1689600 
> 1766400 1843200 1920000 1996800 2092800 2169600 2246400 2323200 2400000 
> 2476800 2553600 2649600 2745600 2841600
> /sys/devices/system/cpu/cpu5/cpufreq/scaling_available_governors:ondemand conservative 
> powersave userspace performance schedutil
> /sys/devices/system/cpu/cpu5/cpufreq/scaling_boost_frequencies:2956800
> /sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq:1996800
> /sys/devices/system/cpu/cpu5/cpufreq/scaling_driver:qcom-cpufreq-hw
> /sys/devices/system/cpu/cpu5/cpufreq/scaling_governor:schedutil
> /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq:2841600
> /sys/devices/system/cpu/cpu5/cpufreq/scaling_min_freq:825600
> /sys/devices/system/cpu/cpu5/cpufreq/scaling_setspeed:<unsupported>
> /sys/devices/system/cpu/cpu6/cpufreq/affected_cpus:4 5 6 7
> /sys/devices/system/cpu/cpu6/cpufreq/cpuinfo_cur_freq:1996800
> /sys/devices/system/cpu/cpu6/cpufreq/cpuinfo_max_freq:2956800
> /sys/devices/system/cpu/cpu6/cpufreq/cpuinfo_min_freq:825600
> /sys/devices/system/cpu/cpu6/cpufreq/cpuinfo_transition_latency:0
> /sys/devices/system/cpu/cpu6/cpufreq/related_cpus:4 5 6 7
> /sys/devices/system/cpu/cpu6/cpufreq/scaling_available_frequencies:825600 902400 
> 979200 1056000 1209600 1286400 1363200 1459200 1536000 1612800 1689600 
> 1766400 1843200 1920000 1996800 2092800 2169600 2246400 2323200 2400000 
> 2476800 2553600 2649600 2745600 2841600
> /sys/devices/system/cpu/cpu6/cpufreq/scaling_available_governors:ondemand conservative 
> powersave userspace performance schedutil
> /sys/devices/system/cpu/cpu6/cpufreq/scaling_boost_frequencies:2956800
> /sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq:1996800
> /sys/devices/system/cpu/cpu6/cpufreq/scaling_driver:qcom-cpufreq-hw
> /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor:schedutil
> /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq:2841600
> /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq:825600
> /sys/devices/system/cpu/cpu6/cpufreq/scaling_setspeed:<unsupported>
> /sys/devices/system/cpu/cpu7/cpufreq/affected_cpus:4 5 6 7
> /sys/devices/system/cpu/cpu7/cpufreq/cpuinfo_cur_freq:1996800
> /sys/devices/system/cpu/cpu7/cpufreq/cpuinfo_max_freq:2956800
> /sys/devices/system/cpu/cpu7/cpufreq/cpuinfo_min_freq:825600
> /sys/devices/system/cpu/cpu7/cpufreq/cpuinfo_transition_latency:0
> /sys/devices/system/cpu/cpu7/cpufreq/related_cpus:4 5 6 7
> /sys/devices/system/cpu/cpu7/cpufreq/scaling_available_frequencies:825600 902400 
> 979200 1056000 1209600 1286400 1363200 1459200 1536000 1612800 1689600 
> 1766400 1843200 1920000 1996800 2092800 2169600 2246400 2323200 2400000 
> 2476800 2553600 2649600 2745600 2841600
> /sys/devices/system/cpu/cpu7/cpufreq/scaling_available_governors:ondemand conservative 
> powersave userspace performance schedutil
> /sys/devices/system/cpu/cpu7/cpufreq/scaling_boost_frequencies:2956800
> /sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq:1996800
> /sys/devices/system/cpu/cpu7/cpufreq/scaling_driver:qcom-cpufreq-hw
> /sys/devices/system/cpu/cpu7/cpufreq/scaling_governor:schedutil
> /sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq:2841600
> /sys/devices/system/cpu/cpu7/cpufreq/scaling_min_freq:825600
> /sys/devices/system/cpu/cpu7/cpufreq/scaling_setspeed:<unsupported>
> 
> 
>> $ grep . /sys/devices/system/cpu/cpu*/cpu_capacity
> 
> /sys/devices/system/cpu/cpu0/cpu_capacity:377
> /sys/devices/system/cpu/cpu1/cpu_capacity:377
> /sys/devices/system/cpu/cpu2/cpu_capacity:377
> /sys/devices/system/cpu/cpu3/cpu_capacity:377
> /sys/devices/system/cpu/cpu4/cpu_capacity:1024
> /sys/devices/system/cpu/cpu5/cpu_capacity:1024
> /sys/devices/system/cpu/cpu6/cpu_capacity:1024
> /sys/devices/system/cpu/cpu7/cpu_capacity:1024
> 
> 
> In taking a look at cpufreq-info, one thing I noticed is that even 
> though I have 1 in /sys/devices/system/cpu/cpufreq/boost, I am *never* 
> hitting the 2.96GHz now
> 
> cpufreq stats: 826 MHz:59.14%, 902 MHz:0.15%, 979 MHz:0.18%, 1.06 
> GHz:0.11%, 1.21 GHz:0.49%, 1.29 GHz:0.26%, 1.36 GHz:0.12%, 1.46 
> GHz:0.23%, 1.54 GHz:0.10%, 1.61 GHz:0.14%, 1.69 GHz:0.09%, 1.77 
> GHz:0.28%, 1.84 GHz:0.64%, 1.92 GHz:0.23%, 2.00 GHz:0.05%, 2.09 
> GHz:0.05%, 2.17 GHz:0.03%, 2.25 GHz:0.03%, 2.32 GHz:0.03%, 2.40 
> GHz:0.03%, 2.48 GHz:0.02%, 2.55 GHz:0.02%, 2.65 GHz:0.03%, 2.75 
> GHz:0.03%, 2.84 GHz:37.53%, 2.96 GHz:0.00%  (20854)
> 
> Aaaand it looks like that is part of the deal - with your patch from 
> above applied, we get:
> 
> [   22.487268] THERMAL_PRESSURE: max_freq(2841) < capped_freq(2956) for 
> CPUs [4-7]
> [   22.487313] THERMAL_PRESSURE: max_freq(2841) < capped_freq(2956) for 
> CPUs [4-7]
> [   22.508642] THERMAL_PRESSURE: max_freq(2841) < capped_freq(2956) for 
> CPUs [4-7]
> [   22.552273] THERMAL_PRESSURE: max_freq(2841) < capped_freq(2956) for 
> CPUs [4-7]
> 
> So, we're not able to hit boost frequencies with this applied?

Hi Steve,

Does your system have enough load to hit the boost frequencies ? I don't 
think this patch should affect hitting boost frequencies as there is no 
error being returned from topology_update_thermal_pressure.

The warning you are getting is because you have boost frequency enabled 
and IIUC lmh enabled and thermal pressure framework bails out due to 
boost_frequency being greater than what is available in per_cpu 
freq_factor. This is because we do not recalculate freq_factor every 
time boost is enabled / disabled. IIRC there were some discussions 
around rebuilding scheduler domains and capacity with user space changes 
to max frequency but it has never proceeded much. Till that point, I 
think the right way, is to check whether the new capcity exceeds the 
max_capacity of the cpu and if yes use max_capacity in lieu of 
new_capacity to calculate thermal pressure.

> 
> Thank you for the fast response!
> 
> -- steev
> 

-- 
Warm Regards
Thara (She/Her/Hers)
