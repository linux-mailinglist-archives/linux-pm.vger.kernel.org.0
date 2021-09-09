Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9840E405FAC
	for <lists+linux-pm@lfdr.de>; Fri, 10 Sep 2021 00:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343811AbhIIWnz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 18:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbhIIWny (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 18:43:54 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAAEC061575
        for <linux-pm@vger.kernel.org>; Thu,  9 Sep 2021 15:42:44 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id n24so4440666ion.10
        for <linux-pm@vger.kernel.org>; Thu, 09 Sep 2021 15:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=27EJBxNByVMaIOhiQ4RS8Rx68zs0wGuV8TsYtfLLWyI=;
        b=SDNCGPOMMjutZfwbBziAByHqaPe2pUbC3sPYO6PVP+MFbIVfRVXKTdLHijGD/F+CLs
         VdzllVG1oBJhAJFBGaj8R8ePQkoraIZG8kaYZwHqXSoboL9yLTXVDXfQBTwRWa2mV6HP
         dUSMq0S+LtTIHLkiF5qqpmJGsi8IudKlk04l4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=27EJBxNByVMaIOhiQ4RS8Rx68zs0wGuV8TsYtfLLWyI=;
        b=F2knxbpQ++AeckrIUaM2cHyAIHcpaI0x+Rz0Zj4iM0zlZNN2E4qMCwqd8jnF2yW7gH
         ZgJ5FUWxCJAJPFRTEkoWcxSz4Bi4/d3aHhKaHqQmWhyh1SVWVuzK07rSh1dgdP9FmCro
         6vbDuKtF3lmN+IUx88To639h5RLmwVfk6VKQm1X3sSLAnm3iic0YQUSlWjJ5pSMm2zbu
         wS66PRFKUXFb8uW9TbgIS0CE/8OFIrR0EH4at3hKRuc2mXDz+IoOcCaNB1fkZxPoz5RY
         J78Q79KRQGXAfrOVaunMj8+CB402q9qAau9xXGY7TPMMCmufqk8h4c75CA7vG2T3bHlQ
         pAag==
X-Gm-Message-State: AOAM530AL6GuCsDuGVOUtunnaOi1BEKx0OZTmRECsxP00mScw8YnKKQH
        TGmkTWsxVaoGbSzymJR/eLQT5w==
X-Google-Smtp-Source: ABdhPJwL362K7wfEkXWaWYHsO4Yxg/X+l/q0Wl/eEDIqmfyVMpmeugtypP4lwD1nxy7eX2UMnotN7Q==
X-Received: by 2002:a05:6638:2150:: with SMTP id z16mr1834981jaj.146.1631227363371;
        Thu, 09 Sep 2021 15:42:43 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c4sm1588237ioo.2.2021.09.09.15.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 15:42:43 -0700 (PDT)
Subject: Re: [PATCH 16/19] cpupower: enable boost state support for amd-pstate
 module
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        linux-pm@vger.kernel.org
Cc:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-17-ray.huang@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ed2906aa-d898-9d3a-ed04-7ad0ecc51f96@linuxfoundation.org>
Date:   Thu, 9 Sep 2021 16:42:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210908150001.3702552-17-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/8/21 8:59 AM, Huang Rui wrote:
> The AMD P-state boost API is different from ACPI hardware P-states, so
> implement the support for amd-pstate kernel module.
> 

This commit log doesn't make sense. If these sysfs entries are used
for amd-pstate kernel module, why are they defined here.

Describe how these are used and the relationship between these defines
and the amd-pstate kernel module

> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>   tools/power/cpupower/lib/cpufreq.c        | 20 ++++++++++++++++++++
>   tools/power/cpupower/lib/cpufreq.h        |  3 +++
>   tools/power/cpupower/utils/helpers/misc.c |  7 +++++++
>   3 files changed, 30 insertions(+)
> 
> diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
> index 3f92ddadaad2..37da87bdcfb1 100644
> --- a/tools/power/cpupower/lib/cpufreq.c
> +++ b/tools/power/cpupower/lib/cpufreq.c
> @@ -790,3 +790,23 @@ unsigned long cpufreq_get_transitions(unsigned int cpu)
>   {
>   	return sysfs_cpufreq_get_one_value(cpu, STATS_NUM_TRANSITIONS);
>   }
> +
> +int amd_pstate_boost_support(unsigned int cpu)
> +{
> +	unsigned int highest_perf, nominal_perf;
> +
> +	highest_perf = sysfs_cpufreq_get_one_value(cpu, AMD_PSTATE_HIGHEST_PERF);
> +	nominal_perf = sysfs_cpufreq_get_one_value(cpu, AMD_PSTATE_NOMINAL_PERF);
> +
> +	return highest_perf > nominal_perf ? 1 : 0;
> +}
> +
> +int amd_pstate_boost_enabled(unsigned int cpu)
> +{
> +	unsigned int cpuinfo_max, amd_pstate_max;
> +
> +	cpuinfo_max = sysfs_cpufreq_get_one_value(cpu, CPUINFO_MAX_FREQ);
> +	amd_pstate_max = sysfs_cpufreq_get_one_value(cpu, AMD_PSTATE_MAX_FREQ);
> +
> +	return cpuinfo_max == amd_pstate_max ? 1 : 0;
> +}

Why are these amd specific routines added to common file.
Why not add them to tools/power/cpupower/utils/helpers/amd.c?

> diff --git a/tools/power/cpupower/lib/cpufreq.h b/tools/power/cpupower/lib/cpufreq.h
> index 95f4fd9e2656..d54d02a7a4f4 100644
> --- a/tools/power/cpupower/lib/cpufreq.h
> +++ b/tools/power/cpupower/lib/cpufreq.h
> @@ -203,6 +203,9 @@ int cpufreq_modify_policy_governor(unsigned int cpu, char *governor);
>   int cpufreq_set_frequency(unsigned int cpu,
>   				unsigned long target_frequency);
>   
> +int amd_pstate_boost_support(unsigned int cpu);
> +int amd_pstate_boost_enabled(unsigned int cpu);
> +
>   #ifdef __cplusplus
>   }
>   #endif
> diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> index 07d80775fb68..aba979320760 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -10,6 +10,7 @@
>   #if defined(__i386__) || defined(__x86_64__)
>   
>   #include "cpupower_intern.h"
> +#include "cpufreq.h"
>   
>   #define MSR_AMD_HWCR	0xc0010015
>   
> @@ -39,6 +40,12 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
>   	

This logic here calls amd_pci_get_num_boost_states() ---
There is another routine called decode_pstates() in
tools/power/cpupower/utils/helpers/amd.c

		if (ret)
>   				return ret;
>   		}
> +	} if ((cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATE) &&
> +	      amd_pstate_boost_support(cpu)) {

Coupled with the above routines, the naming amd_pstate_boost_support()
is rather confusing.

Also why is this amd_pstate_boost_support() added to
> +		*support = 1;
> +
> +		if (amd_pstate_boost_enabled(cpu))
> +			*active = 1;
>   	} else if (cpupower_cpu_info.caps & CPUPOWER_CAP_INTEL_IDA)
>   		*support = *active = 1;
>   	return 0;
> 

thanks,
-- Shuah
