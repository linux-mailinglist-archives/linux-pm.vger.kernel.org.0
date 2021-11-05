Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8384467F7
	for <lists+linux-pm@lfdr.de>; Fri,  5 Nov 2021 18:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhKERgE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Nov 2021 13:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbhKERgD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Nov 2021 13:36:03 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36A4C061714
        for <linux-pm@vger.kernel.org>; Fri,  5 Nov 2021 10:33:23 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id bl27so12749234oib.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Nov 2021 10:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=K8HesKO9CpYctj0lTmMu+BmEcboxqXfTcqPP264aIcU=;
        b=IO408VQk196kyOnj99BiXmbuy9BZl+ZWECUw5anAuIaklNYsv70DpL2+PZbo4OonGd
         isf3KCkQs7YHy3NwYK9+t4yvan63hG9M1/jfWebuCnFGPipRVEiYZkP+4+JbAMZdeWG+
         baECEKdoXWG5tKVBYyxMvGuKcGBBQhDZWlnRljFVKvFl4j25EBDZoF8PcWYXt3k5tdHm
         39JbjeVDqiHweClpVRyCnc8Vy/eYCsOikNJ9CRdL5AJfrWRBqJzly5vDRRjEAUkAtew9
         PLe+qsplANYY+0zMGj/LmAhvS96hZi30BoHJ2M0DZDx+/XmXx/JysM4REzD5elYDEBYm
         tv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=K8HesKO9CpYctj0lTmMu+BmEcboxqXfTcqPP264aIcU=;
        b=wG0p00JWdYyYVtBQcCzAyqcpmCXRMKdarQg6v5ZKWq3v4r7johENijbpX02fjQKr6S
         LXZr99+zb5BoeKJcwqqOvzTnkvBaNUunMzXfHeBWOMwjgaVPSdA0sF3qa9nA/DPEQOfv
         J6flyNZQpeuynG7NOK/ONWl8lqxpB0ce1kMHooPUuFnFxWppxU4d/OrynGWWW5hkHmA2
         2dsQj/9wkLQZfWHpbQBLvitLNySBsgCX713aJDgjY7XH30AxDNyfZJzF8z4Rti8H+TDx
         lEEHnLztPhmD6K07RQ5oeeQ1Ny+CsT4mbDlilIEpTygdyNy+/XjcLOMN/b7zVXYV4G52
         ItVw==
X-Gm-Message-State: AOAM530vlnPjeMemR3L6yeGgg0PBHizqOBTSHL1oXHm1lx7mQKAMkq2V
        ZHs/c0RMW27lxESUfMFNa9YDhw==
X-Google-Smtp-Source: ABdhPJxfdlvxGmm5aaYTSDSd1ZpXcenKKHXiOobtArh8PurPqUJHTYz6G3l6+LKuO/nLFOhDiqX4RQ==
X-Received: by 2002:a05:6808:1641:: with SMTP id az1mr22912204oib.67.1636133602912;
        Fri, 05 Nov 2021 10:33:22 -0700 (PDT)
Received: from [192.168.11.48] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id 93sm1038451oty.11.2021.11.05.10.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 10:33:22 -0700 (PDT)
Message-ID: <9d533b6e-a81c-e823-fa6f-61fdea92fa65@kali.org>
Date:   Fri, 5 Nov 2021 12:33:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v3 0/5] Refactor thermal pressure update to avoid code
 duplication
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, sudeep.holla@arm.com,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        thara.gopinath@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
References: <20211103161020.26714-1-lukasz.luba@arm.com>
 <c7b526f0-2c26-0cfc-910b-3521c6a6ef51@kali.org>
 <3cba148a-7077-7b6b-f131-dc65045aa348@arm.com>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <3cba148a-7077-7b6b-f131-dc65045aa348@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 11/5/21 11:26 AM, Lukasz Luba wrote:
> Hi Steev,
>
> On 11/5/21 3:39 PM, Steev Klimaszewski wrote:
>> Hi Lukasz,
>>
>
> [snip]
>
>> I've been testing this patchset on the Lenovo Yoga C630, and today 
>> while compiling alacritty and running an apt-get full-upgrade, I 
>> found the following in dmesg output:
>
> Thank you for testing and sending feedback!
>
> Are you using a mainline kernel or you applied on some vendor production
> kernel this patch set? I need to exclude a different code base
> from the equation, especially to the arch_topology.c init code.
>
This is stabe 5.15.0 tree with ~72 (including your 6 patches on top 
(including the below as a patch).  You can find it at 
https://github.com/steev/linux/commits/linux-5.15.y - the vast majority 
are just various fixups for sdm845/sdm850 for the Lenovo Yoga (or crypto 
since I'd like to see the crypto unit working).

I did grep through my logs and it appears that this started after I 
moved from v2 to v3 - I'd tested v2 and it didn't show this.

[snip]

> [snip]
>
> That's interesting why we hit this. I should have added info about
> those two values, which are compared.
>
> Could you make this change and try it again, please?
> We would know the problematic values, which triggered this.
> ---------------------8<-----------------------------------
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index db18d79065fe..0d8db0927041 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -185,8 +185,11 @@ void topology_update_thermal_pressure(const 
> struct cpumask *cpus,
>         /* Convert to MHz scale which is used in 'freq_factor' */
>         capped_freq /= 1000;
>
> -       if (WARN_ON(max_freq < capped_freq))
> +       if (max_freq < capped_freq) {
> +               pr_warn("THERMAL_PRESSURE: max_freq (%lu) < 
> capped_freq (%lu) for CPUs [%*pbl]\n",
> +                       max_freq, capped_freq, cpumask_pr_args(cpus));
>                 return;
> +       }
>
>         capacity = mult_frac(capped_freq, max_capacity, max_freq);
>
> ------------------------------>8---------------------------

Applying this to the above kernel.. will test...


>
> Could you also dump for me the cpufreq and capacity sysfs content?
> $ grep . /sys/devices/system/cpu/cpu*/cpufreq/*


/sys/devices/system/cpu/cpu0/cpufreq/affected_cpus:0 1 2 3
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:300000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq:1766400
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq:300000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_transition_latency:0
/sys/devices/system/cpu/cpu0/cpufreq/related_cpus:0 1 2 3
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies:300000 
403200 480000 576000 652800 748800 825600 902400 979200 1056000 1132800 
1228800 1324800 1420800 1516800 1612800 1689600 1766400
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors:ondemand 
conservative powersave userspace performance schedutil
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:300000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_driver:qcom-cpufreq-hw
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:schedutil
/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq:1766400
/sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq:300000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed:<unsupported>
/sys/devices/system/cpu/cpu1/cpufreq/affected_cpus:0 1 2 3
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq:300000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_max_freq:1766400
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_min_freq:300000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_transition_latency:0
/sys/devices/system/cpu/cpu1/cpufreq/related_cpus:0 1 2 3
/sys/devices/system/cpu/cpu1/cpufreq/scaling_available_frequencies:300000 
403200 480000 576000 652800 748800 825600 902400 979200 1056000 1132800 
1228800 1324800 1420800 1516800 1612800 1689600 1766400
/sys/devices/system/cpu/cpu1/cpufreq/scaling_available_governors:ondemand 
conservative powersave userspace performance schedutil
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:300000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_driver:qcom-cpufreq-hw
/sys/devices/system/cpu/cpu1/cpufreq/scaling_governor:schedutil
/sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq:1766400
/sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq:300000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed:<unsupported>
/sys/devices/system/cpu/cpu2/cpufreq/affected_cpus:0 1 2 3
/sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_cur_freq:300000
/sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_max_freq:1766400
/sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_min_freq:300000
/sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_transition_latency:0
/sys/devices/system/cpu/cpu2/cpufreq/related_cpus:0 1 2 3
/sys/devices/system/cpu/cpu2/cpufreq/scaling_available_frequencies:300000 
403200 480000 576000 652800 748800 825600 902400 979200 1056000 1132800 
1228800 1324800 1420800 1516800 1612800 1689600 1766400
/sys/devices/system/cpu/cpu2/cpufreq/scaling_available_governors:ondemand 
conservative powersave userspace performance schedutil
/sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq:300000
/sys/devices/system/cpu/cpu2/cpufreq/scaling_driver:qcom-cpufreq-hw
/sys/devices/system/cpu/cpu2/cpufreq/scaling_governor:schedutil
/sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq:1766400
/sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq:300000
/sys/devices/system/cpu/cpu2/cpufreq/scaling_setspeed:<unsupported>
/sys/devices/system/cpu/cpu3/cpufreq/affected_cpus:0 1 2 3
/sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_cur_freq:300000
/sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_max_freq:1766400
/sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_min_freq:300000
/sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_transition_latency:0
/sys/devices/system/cpu/cpu3/cpufreq/related_cpus:0 1 2 3
/sys/devices/system/cpu/cpu3/cpufreq/scaling_available_frequencies:300000 
403200 480000 576000 652800 748800 825600 902400 979200 1056000 1132800 
1228800 1324800 1420800 1516800 1612800 1689600 1766400
/sys/devices/system/cpu/cpu3/cpufreq/scaling_available_governors:ondemand 
conservative powersave userspace performance schedutil
/sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq:300000
/sys/devices/system/cpu/cpu3/cpufreq/scaling_driver:qcom-cpufreq-hw
/sys/devices/system/cpu/cpu3/cpufreq/scaling_governor:schedutil
/sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq:1766400
/sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq:300000
/sys/devices/system/cpu/cpu3/cpufreq/scaling_setspeed:<unsupported>
/sys/devices/system/cpu/cpu4/cpufreq/affected_cpus:4 5 6 7
/sys/devices/system/cpu/cpu4/cpufreq/cpuinfo_cur_freq:1920000
/sys/devices/system/cpu/cpu4/cpufreq/cpuinfo_max_freq:2956800
/sys/devices/system/cpu/cpu4/cpufreq/cpuinfo_min_freq:825600
/sys/devices/system/cpu/cpu4/cpufreq/cpuinfo_transition_latency:0
/sys/devices/system/cpu/cpu4/cpufreq/related_cpus:4 5 6 7
/sys/devices/system/cpu/cpu4/cpufreq/scaling_available_frequencies:825600 
902400 979200 1056000 1209600 1286400 1363200 1459200 1536000 1612800 
1689600 1766400 1843200 1920000 1996800 2092800 2169600 2246400 2323200 
2400000 2476800 2553600 2649600 2745600 2841600
/sys/devices/system/cpu/cpu4/cpufreq/scaling_available_governors:ondemand 
conservative powersave userspace performance schedutil
/sys/devices/system/cpu/cpu4/cpufreq/scaling_boost_frequencies:2956800
/sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq:1920000
/sys/devices/system/cpu/cpu4/cpufreq/scaling_driver:qcom-cpufreq-hw
/sys/devices/system/cpu/cpu4/cpufreq/scaling_governor:schedutil
/sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq:2841600
/sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq:825600
/sys/devices/system/cpu/cpu4/cpufreq/scaling_setspeed:<unsupported>
/sys/devices/system/cpu/cpu5/cpufreq/affected_cpus:4 5 6 7
/sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_cur_freq:1996800
/sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_max_freq:2956800
/sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_min_freq:825600
/sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_transition_latency:0
/sys/devices/system/cpu/cpu5/cpufreq/related_cpus:4 5 6 7
/sys/devices/system/cpu/cpu5/cpufreq/scaling_available_frequencies:825600 
902400 979200 1056000 1209600 1286400 1363200 1459200 1536000 1612800 
1689600 1766400 1843200 1920000 1996800 2092800 2169600 2246400 2323200 
2400000 2476800 2553600 2649600 2745600 2841600
/sys/devices/system/cpu/cpu5/cpufreq/scaling_available_governors:ondemand 
conservative powersave userspace performance schedutil
/sys/devices/system/cpu/cpu5/cpufreq/scaling_boost_frequencies:2956800
/sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq:1996800
/sys/devices/system/cpu/cpu5/cpufreq/scaling_driver:qcom-cpufreq-hw
/sys/devices/system/cpu/cpu5/cpufreq/scaling_governor:schedutil
/sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq:2841600
/sys/devices/system/cpu/cpu5/cpufreq/scaling_min_freq:825600
/sys/devices/system/cpu/cpu5/cpufreq/scaling_setspeed:<unsupported>
/sys/devices/system/cpu/cpu6/cpufreq/affected_cpus:4 5 6 7
/sys/devices/system/cpu/cpu6/cpufreq/cpuinfo_cur_freq:1996800
/sys/devices/system/cpu/cpu6/cpufreq/cpuinfo_max_freq:2956800
/sys/devices/system/cpu/cpu6/cpufreq/cpuinfo_min_freq:825600
/sys/devices/system/cpu/cpu6/cpufreq/cpuinfo_transition_latency:0
/sys/devices/system/cpu/cpu6/cpufreq/related_cpus:4 5 6 7
/sys/devices/system/cpu/cpu6/cpufreq/scaling_available_frequencies:825600 
902400 979200 1056000 1209600 1286400 1363200 1459200 1536000 1612800 
1689600 1766400 1843200 1920000 1996800 2092800 2169600 2246400 2323200 
2400000 2476800 2553600 2649600 2745600 2841600
/sys/devices/system/cpu/cpu6/cpufreq/scaling_available_governors:ondemand 
conservative powersave userspace performance schedutil
/sys/devices/system/cpu/cpu6/cpufreq/scaling_boost_frequencies:2956800
/sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq:1996800
/sys/devices/system/cpu/cpu6/cpufreq/scaling_driver:qcom-cpufreq-hw
/sys/devices/system/cpu/cpu6/cpufreq/scaling_governor:schedutil
/sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq:2841600
/sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq:825600
/sys/devices/system/cpu/cpu6/cpufreq/scaling_setspeed:<unsupported>
/sys/devices/system/cpu/cpu7/cpufreq/affected_cpus:4 5 6 7
/sys/devices/system/cpu/cpu7/cpufreq/cpuinfo_cur_freq:1996800
/sys/devices/system/cpu/cpu7/cpufreq/cpuinfo_max_freq:2956800
/sys/devices/system/cpu/cpu7/cpufreq/cpuinfo_min_freq:825600
/sys/devices/system/cpu/cpu7/cpufreq/cpuinfo_transition_latency:0
/sys/devices/system/cpu/cpu7/cpufreq/related_cpus:4 5 6 7
/sys/devices/system/cpu/cpu7/cpufreq/scaling_available_frequencies:825600 
902400 979200 1056000 1209600 1286400 1363200 1459200 1536000 1612800 
1689600 1766400 1843200 1920000 1996800 2092800 2169600 2246400 2323200 
2400000 2476800 2553600 2649600 2745600 2841600
/sys/devices/system/cpu/cpu7/cpufreq/scaling_available_governors:ondemand 
conservative powersave userspace performance schedutil
/sys/devices/system/cpu/cpu7/cpufreq/scaling_boost_frequencies:2956800
/sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq:1996800
/sys/devices/system/cpu/cpu7/cpufreq/scaling_driver:qcom-cpufreq-hw
/sys/devices/system/cpu/cpu7/cpufreq/scaling_governor:schedutil
/sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq:2841600
/sys/devices/system/cpu/cpu7/cpufreq/scaling_min_freq:825600
/sys/devices/system/cpu/cpu7/cpufreq/scaling_setspeed:<unsupported>


> $ grep . /sys/devices/system/cpu/cpu*/cpu_capacity

/sys/devices/system/cpu/cpu0/cpu_capacity:377
/sys/devices/system/cpu/cpu1/cpu_capacity:377
/sys/devices/system/cpu/cpu2/cpu_capacity:377
/sys/devices/system/cpu/cpu3/cpu_capacity:377
/sys/devices/system/cpu/cpu4/cpu_capacity:1024
/sys/devices/system/cpu/cpu5/cpu_capacity:1024
/sys/devices/system/cpu/cpu6/cpu_capacity:1024
/sys/devices/system/cpu/cpu7/cpu_capacity:1024


In taking a look at cpufreq-info, one thing I noticed is that even 
though I have 1 in /sys/devices/system/cpu/cpufreq/boost, I am *never* 
hitting the 2.96GHz now

cpufreq stats: 826 MHz:59.14%, 902 MHz:0.15%, 979 MHz:0.18%, 1.06 
GHz:0.11%, 1.21 GHz:0.49%, 1.29 GHz:0.26%, 1.36 GHz:0.12%, 1.46 
GHz:0.23%, 1.54 GHz:0.10%, 1.61 GHz:0.14%, 1.69 GHz:0.09%, 1.77 
GHz:0.28%, 1.84 GHz:0.64%, 1.92 GHz:0.23%, 2.00 GHz:0.05%, 2.09 
GHz:0.05%, 2.17 GHz:0.03%, 2.25 GHz:0.03%, 2.32 GHz:0.03%, 2.40 
GHz:0.03%, 2.48 GHz:0.02%, 2.55 GHz:0.02%, 2.65 GHz:0.03%, 2.75 
GHz:0.03%, 2.84 GHz:37.53%, 2.96 GHz:0.00%  (20854)

Aaaand it looks like that is part of the deal - with your patch from 
above applied, we get:

[   22.487268] THERMAL_PRESSURE: max_freq(2841) < capped_freq(2956) for 
CPUs [4-7]
[   22.487313] THERMAL_PRESSURE: max_freq(2841) < capped_freq(2956) for 
CPUs [4-7]
[   22.508642] THERMAL_PRESSURE: max_freq(2841) < capped_freq(2956) for 
CPUs [4-7]
[   22.552273] THERMAL_PRESSURE: max_freq(2841) < capped_freq(2956) for 
CPUs [4-7]

So, we're not able to hit boost frequencies with this applied?

Thank you for the fast response!

-- steev

