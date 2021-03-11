Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0A33370A6
	for <lists+linux-pm@lfdr.de>; Thu, 11 Mar 2021 11:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhCKK5h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Mar 2021 05:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbhCKK5f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Mar 2021 05:57:35 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884A8C061574
        for <linux-pm@vger.kernel.org>; Thu, 11 Mar 2021 02:57:35 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id 7so1346564wrz.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Mar 2021 02:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0WoDEOEAOGPkW650sbkLs7at5Q4e6z35HMVpBvCmwDM=;
        b=Tk81BFzK+AmCFPv2ccmZobqgA+bVqq7N6LxjoZ1k8bBcfgJVXDg+kJuHkCjmK/RNUp
         /NRl9hDTC30Vp6VL4pWd0AW2aWyJ7z1oab1CkPxO7ABXLPZ11wFSzg5A7vejclRH/dYU
         rx5nO3HmqGYqb3NG8Wvf3NGSJkHMdPTLGxMnR3zKQgfq+9wtmN0TgaJDbqRQ1mxm2W/B
         NU+FogkXdk/dXpbEuV0g5Ec5ITJL+sFSiP+Sus6zEXVhfPAKBc2+LHFivn+nU479PLAL
         F42mhJbLgcNiMM3XUPfjSAZ7DT4CPC2+vpnkjSL/Xxy1xZX6reKvv3bmPSuaEzp1ePoi
         DoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0WoDEOEAOGPkW650sbkLs7at5Q4e6z35HMVpBvCmwDM=;
        b=F3lrA+HrlH59rT5D4wmg2RmQmVrYpSNZlHi9qlyc4cg+gqwn/4pua8J8A8528aR+Nk
         nAX+FJb+QBPiFK5ysexeX70e26BmL6o3qTlbHEfkTlkwgu+LIdD7dp6DF5PEFVnwPqc5
         eWaK9kqFt8T00sktmqrJD4PNT4t2jXJehKmqE2J/vcjoK+G0MTvyTXt/yZCob0RKof2B
         PRRlc/XCkRsTh7H9BsgBlzL9P5+6AZgdpkGLwqKG14c3GFI/J/60AjDi1bAQnZmv57Ad
         jUuXjXjIbJhdofLcqs/r++m2eWN+R6m/SGRQouPZ8NsdwatAeJupBtSoJ8WQCSJ0S/cv
         4w2Q==
X-Gm-Message-State: AOAM530EcY6+xI2s9zK4PCWSXizAY8hYhCqFCWArDbX5Prt7saPNk9eF
        rsSsXSw4oYcN/xDnx7RTqiU2iOhKEYMxVQ==
X-Google-Smtp-Source: ABdhPJzdhJbRihFrxoqsr/gXLuovKNBMOqZ6AGknvcDViX3N0NBwH/DRhVwAe9lNbGfw8z4dzK0y7w==
X-Received: by 2002:a05:6000:1107:: with SMTP id z7mr7767526wrw.415.1615460254185;
        Thu, 11 Mar 2021 02:57:34 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:84cf:7f4d:d470:dfd4? ([2a01:e34:ed2f:f020:84cf:7f4d:d470:dfd4])
        by smtp.googlemail.com with ESMTPSA id s83sm3078015wmf.26.2021.03.11.02.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 02:57:33 -0800 (PST)
Subject: Re: [PATCH v3 1/5] powercap/drivers/dtpm: Encapsulate even more the
 code
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210310110212.26512-1-daniel.lezcano@linaro.org>
 <d8d3c50c-fee6-6f31-c085-d1ebce5297da@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <aa1ecdaa-3f91-c886-ce1e-45557d01991a@linaro.org>
Date:   Thu, 11 Mar 2021 11:57:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d8d3c50c-fee6-6f31-c085-d1ebce5297da@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/03/2021 11:15, Lukasz Luba wrote:
> Hi Daniel,
> 
> On 3/10/21 11:02 AM, Daniel Lezcano wrote:
>> In order to increase the self-encapsulation of the dtpm generic code,
>> the following changes are adding a power update ops to the dtpm
>> ops. That allows the generic code to call directly the dtpm backend
>> function to update the power values.
>>
>> The power update function does compute the power characteristics when
>> the function is invoked. In the case of the CPUs, the power
>> consumption depends on the number of online CPUs. The online CPUs mask
>> is not up to date at CPUHP_AP_ONLINE_DYN state in the tear down
>> callback. That is the reason why the online / offline are at separate
>> state. As there is already an existing state for DTPM, this one is
>> only moved to the DEAD state, so there is no addition of new state
>> with these changes. The dtpm node is not removed when the cpu is
>> unplugged.
>>
>> That simplifies the code for the next changes and results in a more
>> self-encapsulated code.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>> V2:
>>   - Updated the changelog with the CPU node not being removed
>>   - Commented the cpu hotplug callbacks to explain why there are two
>> callbacks
>>   - Changed 'upt_power_uw' to 'update_power_uw'
>>   - Removed unused cpumask variable
>> ---
>>   drivers/powercap/dtpm.c     |  54 ++++++-------
>>   drivers/powercap/dtpm_cpu.c | 148 ++++++++++++++++--------------------
>>   include/linux/cpuhotplug.h  |   2 +-
>>   include/linux/dtpm.h        |   3 +-
>>   4 files changed, 97 insertions(+), 110 deletions(-)
>>
> 
> [snip]
> 
>> @@ -210,27 +175,20 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
>>       for_each_cpu(cpu, policy->related_cpus)
>>           per_cpu(dtpm_per_cpu, cpu) = dtpm;
>>   -    sprintf(name, "cpu%d", dtpm_cpu->cpu);
>> +    sprintf(name, "cpu%d-cpufreq", dtpm_cpu->cpu);
> 
> We should be safe in normal platforms, since there is less than
> < 300 cores. although, I would use 2x CPUFREQ_NAME_LEN array.

I'm counting 9999 cores.

We have:
#define CPUFREQ_NAME_LEN 16

"cpu-cpufreq\0" counts 12 characters.

There are 4 characters left, 9999 max then, no ?

The code is designed for cpufreq with the energy model which targets
ARM64 architecture and AFAICT we are far away of having so many cores on
our phones.

Except I'm wrong, I would prefer to keep the current CPUFREQ_NAME_LEN to
not introduce subtle bugs (like stack overflow) if the length is
increased in cpufreq.h.

What do you think ?

> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> Regards,
> Lukasz
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
