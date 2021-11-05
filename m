Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B04446A44
	for <lists+linux-pm@lfdr.de>; Fri,  5 Nov 2021 22:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbhKEVJK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Nov 2021 17:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbhKEVJJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Nov 2021 17:09:09 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E627C061205
        for <linux-pm@vger.kernel.org>; Fri,  5 Nov 2021 14:06:29 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g13so7927957qtk.12
        for <linux-pm@vger.kernel.org>; Fri, 05 Nov 2021 14:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QDTTSkZZ6aeMgKDMehvVej6WlMp7qjF/3G5nLFNl/qU=;
        b=kNorvtlD9JypAa5xV/UvmA+z7I912+YOxbljKXCD9fJDrGlXpMB05wQ6hzfKjGL0L+
         3js+XYV8xx6EMJGLNk22J4CQbvR/HZk7/MuGkzV0lxTPf2yzIRVRk6i2+CeZvPm7O+N8
         1ddPpyFcJSTCKp9xb0weAC99GikyGbeO7pITyaLlNw/1qaOStP0cvK98qv4F0kwrqbMR
         ALo9JPETA53khbGBO7qipp2RIqLhK3tmtrTuqv6c3UJkSWDISZHGUVCwqJEfNwIEBinb
         ebcT3AgMEuvuCYy4jqD6NfI/xLUTS+DS4T7+Fh6igDQnUXP7hGRvuM5AWNdbesvatOdH
         5hmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QDTTSkZZ6aeMgKDMehvVej6WlMp7qjF/3G5nLFNl/qU=;
        b=Dd2SmpgJbL2LTi9OQKqA7hY5J1MjBdxuLRDECAXzaTwgYSCy6AijJJAxPzB2Nu26bA
         LTcA2VWfNVCSywQOkunwYGfSyF20Vq8tPbSg996o8wRgSn3umuqw1p/Hc14JuNWgWPlY
         s4Smp3iIJmUSIQkpb+tQ19QTbYRQIEGnCEY5hPaTILWz+Jc/j3/4qRWsQrb5cwOJXV35
         boVy7ugFeuYBChI45nRjFjfe+atUhfPdm6KkpcYLz/AkGCCrcDMAAIVlFmO7XJCWxKKk
         aTNYXBmrKCVDmMDsK7tzoJSTA8LK7I69QMEDsV89S5WBu+TVUgHXu94hbWvwdKMwGlEh
         kRvw==
X-Gm-Message-State: AOAM531xqwOamw324LNbtbmk9TAbGfgxGc7b03jkuPqP3JU3yWcXAQK4
        U+yoeyDyVm7dJGQ/cEXiCWyeLg==
X-Google-Smtp-Source: ABdhPJyMiiSM65mYeDQqW5fG/Es5wLQ4mYGZRlaBhmTxH9BOURMK0zEgCVbw/+qvHB/lpXhuvIJpaA==
X-Received: by 2002:a05:622a:60f:: with SMTP id z15mr62824804qta.286.1636146388119;
        Fri, 05 Nov 2021 14:06:28 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id p187sm5845228qkd.101.2021.11.05.14.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 14:06:27 -0700 (PDT)
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
 <74ea027b-b213-42b8-0f7d-275f3b84712e@linaro.org>
 <74603569-2ff1-999e-9618-79261fdb0ee4@kali.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <b7e76c2a-ceac-500a-ff75-535a3f0d51d6@linaro.org>
Date:   Fri, 5 Nov 2021 17:06:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <74603569-2ff1-999e-9618-79261fdb0ee4@kali.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/5/21 3:51 PM, Steev Klimaszewski wrote:
> 
> On 11/5/21 2:18 PM, Thara Gopinath wrote:
>>
>>
>> On 11/5/21 1:33 PM, Steev Klimaszewski wrote:
>>> Hi,
>>>
>>> On 11/5/21 11:26 AM, Lukasz Luba wrote:
>>>> Hi Steev,
>>>>
>>>> On 11/5/21 3:39 PM, Steev Klimaszewski wrote:
>>>>> Hi Lukasz,
>>>>>
>>>> [snip]
>> Hi Steve,
>>
>> Does your system have enough load to hit the boost frequencies ? I 
>> don't think this patch should affect hitting boost frequencies as 
>> there is no error being returned from topology_update_thermal_pressure.
>>
>> The warning you are getting is because you have boost frequency 
>> enabled and IIUC lmh enabled and thermal pressure framework bails out 
>> due to boost_frequency being greater than what is available in per_cpu 
>> freq_factor. This is because we do not recalculate freq_factor every 
>> time boost is enabled / disabled. IIRC there were some discussions 
>> around rebuilding scheduler domains and capacity with user space 
>> changes to max frequency but it has never proceeded much. Till that 
>> point, I think the right way, is to check whether the new capcity 
>> exceeds the max_capacity of the cpu and if yes use max_capacity in 
>> lieu of new_capacity to calculate thermal pressure.
>>
> Hi Thara,
> 
> I should definitely be able to push it to 2.96GHz, however I'm simply 
> not getting it at all with these patches applied. >
> So, I'm currently compiling multiple applications - alacritty 
> (https://github.com/alacritty/alacritty), and zellij 
> (https://github.com/zellij-org/zellij), as well as running pixz on a 
> 5.1GB file to compress it, and throwing in cpuburn-a53 
> (https://github.com/ssvb/cpuburn-arm) and I'm simply not getting 2.96GHz 
> at all.  Ever.  I don't normally try to push it that high, but I wanted 
> to see if we could ever hit it (the system was also never going above 86C)

Hi,

So IIUC the below logs correctly, you are never hitting boost frequency 
(with or without this patch series). Is that correct ?

w.r.t temperature , how are you measuring it? Do you have LMh enabled or 
are you using tsens to mitigate cpu temperature ?

-- 
Warm Regards
Thara (She/Her/Hers)
> 
> analyzing CPU 4:
>    driver: qcom-cpufreq-hw
>    CPUs which run at the same hardware frequency: 4 5 6 7
>    CPUs which need to have their frequency coordinated by software: 4 5 6 7
>    maximum transition latency: 4294.55 ms.
>    hardware limits: 826 MHz - 2.96 GHz
>    available frequency steps: 826 MHz, 902 MHz, 979 MHz, 1.06 GHz, 1.21 
> GHz, 1.29 GHz, 1.36 GHz, 1.46 GHz, 1.54 GHz, 1.61 GHz, 1.69 GHz, 1.77 
> GHz, 1.84 GHz, 1.92 GHz, 2.00 GHz, 2.09 GHz, 2.17 GHz, 2.25 GHz, 2.32 
> GHz, 2.40 GHz, 2.48 GHz, 2.55 GHz, 2.65 GHz, 2.75 GHz, 2.84 GHz
>    available cpufreq governors: ondemand, conservative, powersave, 
> userspace, performance, schedutil
>    current policy: frequency should be within 826 MHz and 2.84 GHz.
>                    The governor "schedutil" may decide which speed to use
>                    within this range.
>    current CPU frequency is 2.84 GHz.
>    cpufreq stats: 826 MHz:54.84%, 902 MHz:0.02%, 979 MHz:0.02%, 1.06 
> GHz:0.02%, 1.21 GHz:0.08%, 1.29 GHz:0.07%, 1.36 GHz:0.09%, 1.46 
> GHz:0.04%, 1.54 GHz:0.02%, 1.61 GHz:0.02%, 1.69 GHz:0.02%, 1.77 
> GHz:0.13%, 1.84 GHz:0.04%, 1.92 GHz:0.04%, 2.00 GHz:0.02%, 2.09 
> GHz:0.03%, 2.17 GHz:0.02%, 2.25 GHz:0.02%, 2.32 GHz:0.01%, 2.40 
> GHz:0.02%, 2.48 GHz:0.02%, 2.55 GHz:0.02%, 2.65 GHz:0.02%, 2.75 
> GHz:0.02%, 2.84 GHz:44.38%, 2.96 GHz:0.00%  (8066)
> analyzing CPU 5:
>    driver: qcom-cpufreq-hw
>    CPUs which run at the same hardware frequency: 4 5 6 7
>    CPUs which need to have their frequency coordinated by software: 4 5 6 7
>    maximum transition latency: 4294.55 ms.
>    hardware limits: 826 MHz - 2.96 GHz
>    available frequency steps: 826 MHz, 902 MHz, 979 MHz, 1.06 GHz, 1.21 
> GHz, 1.29 GHz, 1.36 GHz, 1.46 GHz, 1.54 GHz, 1.61 GHz, 1.69 GHz, 1.77 
> GHz, 1.84 GHz, 1.92 GHz, 2.00 GHz, 2.09 GHz, 2.17 GHz, 2.25 GHz, 2.32 
> GHz, 2.40 GHz, 2.48 GHz, 2.55 GHz, 2.65 GHz, 2.75 GHz, 2.84 GHz
>    available cpufreq governors: ondemand, conservative, powersave, 
> userspace, performance, schedutil
>    current policy: frequency should be within 826 MHz and 2.84 GHz.
>                    The governor "schedutil" may decide which speed to use
>                    within this range.
>    current CPU frequency is 2.84 GHz.
>    cpufreq stats: 826 MHz:54.84%, 902 MHz:0.02%, 979 MHz:0.02%, 1.06 
> GHz:0.02%, 1.21 GHz:0.08%, 1.29 GHz:0.07%, 1.36 GHz:0.09%, 1.46 
> GHz:0.04%, 1.54 GHz:0.02%, 1.61 GHz:0.02%, 1.69 GHz:0.02%, 1.77 
> GHz:0.13%, 1.84 GHz:0.04%, 1.92 GHz:0.04%, 2.00 GHz:0.02%, 2.09 
> GHz:0.03%, 2.17 GHz:0.02%, 2.25 GHz:0.02%, 2.32 GHz:0.01%, 2.40 
> GHz:0.02%, 2.48 GHz:0.02%, 2.55 GHz:0.02%, 2.65 GHz:0.02%, 2.75 
> GHz:0.02%, 2.84 GHz:44.38%, 2.96 GHz:0.00%  (8066)
> analyzing CPU 6:
>    driver: qcom-cpufreq-hw
>    CPUs which run at the same hardware frequency: 4 5 6 7
>    CPUs which need to have their frequency coordinated by software: 4 5 6 7
>    maximum transition latency: 4294.55 ms.
>    hardware limits: 826 MHz - 2.96 GHz
>    available frequency steps: 826 MHz, 902 MHz, 979 MHz, 1.06 GHz, 1.21 
> GHz, 1.29 GHz, 1.36 GHz, 1.46 GHz, 1.54 GHz, 1.61 GHz, 1.69 GHz, 1.77 
> GHz, 1.84 GHz, 1.92 GHz, 2.00 GHz, 2.09 GHz, 2.17 GHz, 2.25 GHz, 2.32 
> GHz, 2.40 GHz, 2.48 GHz, 2.55 GHz, 2.65 GHz, 2.75 GHz, 2.84 GHz
>    available cpufreq governors: ondemand, conservative, powersave, 
> userspace, performance, schedutil
>    current policy: frequency should be within 826 MHz and 2.84 GHz.
>                    The governor "schedutil" may decide which speed to use
>                    within this range.
>    current CPU frequency is 2.84 GHz.
>    cpufreq stats: 826 MHz:54.84%, 902 MHz:0.02%, 979 MHz:0.02%, 1.06 
> GHz:0.02%, 1.21 GHz:0.08%, 1.29 GHz:0.07%, 1.36 GHz:0.09%, 1.46 
> GHz:0.04%, 1.54 GHz:0.02%, 1.61 GHz:0.02%, 1.69 GHz:0.02%, 1.77 
> GHz:0.13%, 1.84 GHz:0.04%, 1.92 GHz:0.04%, 2.00 GHz:0.02%, 2.09 
> GHz:0.03%, 2.17 GHz:0.02%, 2.25 GHz:0.02%, 2.32 GHz:0.01%, 2.40 
> GHz:0.02%, 2.48 GHz:0.02%, 2.55 GHz:0.02%, 2.65 GHz:0.02%, 2.75 
> GHz:0.02%, 2.84 GHz:44.38%, 2.96 GHz:0.00%  (8066)
> analyzing CPU 7:
>    driver: qcom-cpufreq-hw
>    CPUs which run at the same hardware frequency: 4 5 6 7
>    CPUs which need to have their frequency coordinated by software: 4 5 6 7
>    maximum transition latency: 4294.55 ms.
>    hardware limits: 826 MHz - 2.96 GHz
>    available frequency steps: 826 MHz, 902 MHz, 979 MHz, 1.06 GHz, 1.21 
> GHz, 1.29 GHz, 1.36 GHz, 1.46 GHz, 1.54 GHz, 1.61 GHz, 1.69 GHz, 1.77 
> GHz, 1.84 GHz, 1.92 GHz, 2.00 GHz, 2.09 GHz, 2.17 GHz, 2.25 GHz, 2.32 
> GHz, 2.40 GHz, 2.48 GHz, 2.55 GHz, 2.65 GHz, 2.75 GHz, 2.84 GHz
>    available cpufreq governors: ondemand, conservative, powersave, 
> userspace, performance, schedutil
>    current policy: frequency should be within 826 MHz and 2.84 GHz.
>                    The governor "schedutil" may decide which speed to use
>                    within this range.
>    current CPU frequency is 2.84 GHz.
>    cpufreq stats: 826 MHz:54.84%, 902 MHz:0.02%, 979 MHz:0.02%, 1.06 
> GHz:0.02%, 1.21 GHz:0.08%, 1.29 GHz:0.07%, 1.36 GHz:0.09%, 1.46 
> GHz:0.04%, 1.54 GHz:0.02%, 1.61 GHz:0.02%, 1.69 GHz:0.02%, 1.77 
> GHz:0.13%, 1.84 GHz:0.04%, 1.92 GHz:0.04%, 2.00 GHz:0.02%, 2.09 
> GHz:0.03%, 2.17 GHz:0.02%, 2.25 GHz:0.02%, 2.32 GHz:0.01%, 2.40 
> GHz:0.02%, 2.48 GHz:0.02%, 2.55 GHz:0.02%, 2.65 GHz:0.02%, 2.75 
> GHz:0.02%, 2.84 GHz:44.38%, 2.96 GHz:0.00%  (8066)
> 
> 
> 
> After removing this patchset, and rebooting and just compiling zellij:
> 
> analyzing CPU 4:
>    driver: qcom-cpufreq-hw
>    CPUs which run at the same hardware frequency: 4 5 6 7
>    CPUs which need to have their frequency coordinated by software: 4 5 6 7
>    maximum transition latency: 4294.55 ms.
>    hardware limits: 826 MHz - 2.96 GHz
>    available frequency steps: 826 MHz, 902 MHz, 979 MHz, 1.06 GHz, 1.21 
> GHz, 1.29 GHz, 1.36 GHz, 1.46 GHz, 1.54 GHz, 1.61 GHz, 1.69 GHz, 1.77 
> GHz, 1.84 GHz, 1.92 GHz, 2.00 GHz, 2.09 GHz, 2.17 GHz, 2.25 GHz, 2.32 
> GHz, 2.40 GHz, 2.48 GHz, 2.55 GHz, 2.65 GHz, 2.75 GHz, 2.84 GHz
>    available cpufreq governors: ondemand, conservative, powersave, 
> userspace, performance, schedutil
>    current policy: frequency should be within 826 MHz and 2.84 GHz.
>                    The governor "schedutil" may decide which speed to use
>                    within this range.
>    current CPU frequency is 2.84 GHz.
>    cpufreq stats: 826 MHz:16.01%, 902 MHz:0.08%, 979 MHz:0.05%, 1.06 
> GHz:0.06%, 1.21 GHz:0.37%, 1.29 GHz:0.17%, 1.36 GHz:0.15%, 1.46 
> GHz:0.20%, 1.54 GHz:0.18%, 1.61 GHz:0.21%, 1.69 GHz:0.17%, 1.77 
> GHz:0.22%, 1.84 GHz:0.32%, 1.92 GHz:0.37%, 2.00 GHz:0.22%, 2.09 
> GHz:0.20%, 2.17 GHz:0.20%, 2.25 GHz:0.19%, 2.32 GHz:0.19%, 2.40 
> GHz:0.21%, 2.48 GHz:0.18%, 2.55 GHz:0.18%, 2.65 GHz:0.21%, 2.75 
> GHz:0.16%, 2.84 GHz:79.49%, 2.96 GHz:0.03%  (5315)
> analyzing CPU 5:
>    driver: qcom-cpufreq-hw
>    CPUs which run at the same hardware frequency: 4 5 6 7
>    CPUs which need to have their frequency coordinated by software: 4 5 6 7
>    maximum transition latency: 4294.55 ms.
>    hardware limits: 826 MHz - 2.96 GHz
>    available frequency steps: 826 MHz, 902 MHz, 979 MHz, 1.06 GHz, 1.21 
> GHz, 1.29 GHz, 1.36 GHz, 1.46 GHz, 1.54 GHz, 1.61 GHz, 1.69 GHz, 1.77 
> GHz, 1.84 GHz, 1.92 GHz, 2.00 GHz, 2.09 GHz, 2.17 GHz, 2.25 GHz, 2.32 
> GHz, 2.40 GHz, 2.48 GHz, 2.55 GHz, 2.65 GHz, 2.75 GHz, 2.84 GHz
>    available cpufreq governors: ondemand, conservative, powersave, 
> userspace, performance, schedutil
>    current policy: frequency should be within 826 MHz and 2.84 GHz.
>                    The governor "schedutil" may decide which speed to use
>                    within this range.
>    current CPU frequency is 2.84 GHz.
>    cpufreq stats: 826 MHz:16.01%, 902 MHz:0.08%, 979 MHz:0.05%, 1.06 
> GHz:0.06%, 1.21 GHz:0.37%, 1.29 GHz:0.17%, 1.36 GHz:0.15%, 1.46 
> GHz:0.20%, 1.54 GHz:0.18%, 1.61 GHz:0.21%, 1.69 GHz:0.17%, 1.77 
> GHz:0.22%, 1.84 GHz:0.32%, 1.92 GHz:0.37%, 2.00 GHz:0.22%, 2.09 
> GHz:0.20%, 2.17 GHz:0.20%, 2.25 GHz:0.19%, 2.32 GHz:0.19%, 2.40 
> GHz:0.21%, 2.48 GHz:0.18%, 2.55 GHz:0.18%, 2.65 GHz:0.21%, 2.75 
> GHz:0.16%, 2.84 GHz:79.49%, 2.96 GHz:0.03%  (5315)
> analyzing CPU 6:
>    driver: qcom-cpufreq-hw
>    CPUs which run at the same hardware frequency: 4 5 6 7
>    CPUs which need to have their frequency coordinated by software: 4 5 6 7
>    maximum transition latency: 4294.55 ms.
>    hardware limits: 826 MHz - 2.96 GHz
>    available frequency steps: 826 MHz, 902 MHz, 979 MHz, 1.06 GHz, 1.21 
> GHz, 1.29 GHz, 1.36 GHz, 1.46 GHz, 1.54 GHz, 1.61 GHz, 1.69 GHz, 1.77 
> GHz, 1.84 GHz, 1.92 GHz, 2.00 GHz, 2.09 GHz, 2.17 GHz, 2.25 GHz, 2.32 
> GHz, 2.40 GHz, 2.48 GHz, 2.55 GHz, 2.65 GHz, 2.75 GHz, 2.84 GHz
>    available cpufreq governors: ondemand, conservative, powersave, 
> userspace, performance, schedutil
>    current policy: frequency should be within 826 MHz and 2.84 GHz.
>                    The governor "schedutil" may decide which speed to use
>                    within this range.
>    current CPU frequency is 2.84 GHz.
>    cpufreq stats: 826 MHz:16.01%, 902 MHz:0.08%, 979 MHz:0.05%, 1.06 
> GHz:0.06%, 1.21 GHz:0.37%, 1.29 GHz:0.17%, 1.36 GHz:0.15%, 1.46 
> GHz:0.20%, 1.54 GHz:0.18%, 1.61 GHz:0.21%, 1.69 GHz:0.17%, 1.77 
> GHz:0.22%, 1.84 GHz:0.32%, 1.92 GHz:0.37%, 2.00 GHz:0.22%, 2.09 
> GHz:0.20%, 2.17 GHz:0.20%, 2.25 GHz:0.19%, 2.32 GHz:0.19%, 2.40 
> GHz:0.21%, 2.48 GHz:0.18%, 2.55 GHz:0.18%, 2.65 GHz:0.21%, 2.75 
> GHz:0.16%, 2.84 GHz:79.49%, 2.96 GHz:0.03%  (5315)
> analyzing CPU 7:
>    driver: qcom-cpufreq-hw
>    CPUs which run at the same hardware frequency: 4 5 6 7
>    CPUs which need to have their frequency coordinated by software: 4 5 6 7
>    maximum transition latency: 4294.55 ms.
>    hardware limits: 826 MHz - 2.96 GHz
>    available frequency steps: 826 MHz, 902 MHz, 979 MHz, 1.06 GHz, 1.21 
> GHz, 1.29 GHz, 1.36 GHz, 1.46 GHz, 1.54 GHz, 1.61 GHz, 1.69 GHz, 1.77 
> GHz, 1.84 GHz, 1.92 GHz, 2.00 GHz, 2.09 GHz, 2.17 GHz, 2.25 GHz, 2.32 
> GHz, 2.40 GHz, 2.48 GHz, 2.55 GHz, 2.65 GHz, 2.75 GHz, 2.84 GHz
>    available cpufreq governors: ondemand, conservative, powersave, 
> userspace, performance, schedutil
>    current policy: frequency should be within 826 MHz and 2.84 GHz.
>                    The governor "schedutil" may decide which speed to use
>                    within this range.
>    current CPU frequency is 2.84 GHz.
>    cpufreq stats: 826 MHz:16.01%, 902 MHz:0.08%, 979 MHz:0.05%, 1.06 
> GHz:0.06%, 1.21 GHz:0.37%, 1.29 GHz:0.17%, 1.36 GHz:0.15%, 1.46 
> GHz:0.20%, 1.54 GHz:0.18%, 1.61 GHz:0.21%, 1.69 GHz:0.17%, 1.77 
> GHz:0.22%, 1.84 GHz:0.32%, 1.92 GHz:0.37%, 2.00 GHz:0.22%, 2.09 
> GHz:0.20%, 2.17 GHz:0.20%, 2.25 GHz:0.19%, 2.32 GHz:0.19%, 2.40 
> GHz:0.21%, 2.48 GHz:0.18%, 2.55 GHz:0.18%, 2.65 GHz:0.21%, 2.75 
> GHz:0.16%, 2.84 GHz:79.49%, 2.96 GHz:0.03%  (5315)
> 
> 
>>>
>>> Thank you for the fast response!
>>>
>>> -- steev
>>>
>>

