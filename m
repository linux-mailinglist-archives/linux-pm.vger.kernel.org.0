Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB99405FAE
	for <lists+linux-pm@lfdr.de>; Fri, 10 Sep 2021 00:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343947AbhIIWq6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 18:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbhIIWq5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 18:46:57 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EE6C061575
        for <linux-pm@vger.kernel.org>; Thu,  9 Sep 2021 15:45:47 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id b4so3639782ilr.11
        for <linux-pm@vger.kernel.org>; Thu, 09 Sep 2021 15:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jfvcWwOBIgI08h7a65dIdk6UKcUBFS1A3sjkWIlsagM=;
        b=Ku66LCImX7qsAGEUk6Xe+jFK47ojLK5DzbF68gIS1zCTatEbRBPJE9yFP41xL3dZfd
         uRdIkGGUhxbyfxAEFzJZroJgjQJ3jEsiV99iCvzOyMVBJU5RwohZfdsGt4IDiCBOIEm+
         leWxcR4HmPE9BMbKfzrB98jsLvBaE6HZYjM08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jfvcWwOBIgI08h7a65dIdk6UKcUBFS1A3sjkWIlsagM=;
        b=y5+s/Szn8rywxjbFNlFxs1eudtXocIoNIulc+EJBKIM2T9UJ35B8SPyupe0m7kYYwj
         jz8f1VCHXNGpFcZfbIroLkLT1QIWLYVPvX6CZ/6U4+mH7R04uKMgJdW4YU7nO85ontkw
         /rQ9phVRxfhJPe23eI3G/zCUtENdsC9Ua7APpfqvNN6Qie9nX5vVDdriQePvNEdAhnJ4
         N/SZ/Aozs66GUfLLqFOCtLEscrWy+O8T0nPK4na8ejaa/g2ydBVIzot5bsbKLl7QFnrl
         OdlaqqGYX9d7O+QR1Xju4STyMHPLD1x9KP4C1ECbxu0cjeCKbNOQ+Vhmt3gizGb1LCJD
         N+7g==
X-Gm-Message-State: AOAM533FyZ60LJDBJJ42moJLaaXGroQpwZXFfS1KBgmRJcX/EKW/Jp6E
        AzxNTsFI8hw5DgImPv1vlOs+Pg==
X-Google-Smtp-Source: ABdhPJykRRtbXcl+qiNzUJFcGcf/1qYWZiYhNzbyxFc18qcfr5US5u30BDkV3VaYNFjCgm9aZbOPHQ==
X-Received: by 2002:a92:b742:: with SMTP id c2mr508841ilm.141.1631227547039;
        Thu, 09 Sep 2021 15:45:47 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g19sm50483ilb.84.2021.09.09.15.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 15:45:46 -0700 (PDT)
Subject: Re: [PATCH 17/19] cpupower: add amd-pstate get data function to query
 the info
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
 <20210908150001.3702552-18-ray.huang@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <318fb963-9334-a735-ca60-3eb180618141@linuxfoundation.org>
Date:   Thu, 9 Sep 2021 16:45:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210908150001.3702552-18-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/8/21 8:59 AM, Huang Rui wrote:
> Frequency-info needs an interface to query the current amd-pstate data.
> 

Let's add more information here.
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>   tools/power/cpupower/lib/cpufreq.c |  6 ++++++
>   tools/power/cpupower/lib/cpufreq.h | 13 +++++++++++++
>   2 files changed, 19 insertions(+)
> 
> diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
> index 37da87bdcfb1..1443080868da 100644
> --- a/tools/power/cpupower/lib/cpufreq.c
> +++ b/tools/power/cpupower/lib/cpufreq.c
> @@ -810,3 +810,9 @@ int amd_pstate_boost_enabled(unsigned int cpu)
>   
>   	return cpuinfo_max == amd_pstate_max ? 1 : 0;
>   }
> +
> +unsigned amd_pstate_get_data(unsigned int cpu, enum amd_pstate_param param)
> +{
> +	return sysfs_cpufreq_get_one_value(cpu,
> +					   param + AMD_PSTATE_HIGHEST_PERF);
> +}
> diff --git a/tools/power/cpupower/lib/cpufreq.h b/tools/power/cpupower/lib/cpufreq.h
> index d54d02a7a4f4..954e72704fc0 100644
> --- a/tools/power/cpupower/lib/cpufreq.h
> +++ b/tools/power/cpupower/lib/cpufreq.h
> @@ -206,6 +206,19 @@ int cpufreq_set_frequency(unsigned int cpu,
>   int amd_pstate_boost_support(unsigned int cpu);
>   int amd_pstate_boost_enabled(unsigned int cpu);
>   
> +enum amd_pstate_param {
> +	HIGHEST_PERF,
> +	NOMINAL_PERF,
> +	LOWEST_NONLINEAR_PERF,
> +	LOWEST_PERF,
> +	MAX_FREQ,
> +	NOMINAL_FREQ,
> +	LOWEST_NONLINEAR_FREQ,
> +	MIN_FREQ,
> +};
> +
> +unsigned amd_pstate_get_data(unsigned int cpu, enum amd_pstate_param param);
> +
>   #ifdef __cplusplus
>   }
>   #endif
> 

amd specific things added to common files? I would like to see this patch
series redone to follow the existing common vs. vendor specific separation.

thanks,
-- Shuah


