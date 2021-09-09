Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC817405F4F
	for <lists+linux-pm@lfdr.de>; Fri, 10 Sep 2021 00:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344250AbhIIWRe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 18:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343934AbhIIWRd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 18:17:33 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F87C061574
        for <linux-pm@vger.kernel.org>; Thu,  9 Sep 2021 15:16:23 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id a20so3582498ilq.7
        for <linux-pm@vger.kernel.org>; Thu, 09 Sep 2021 15:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zM0IXLI05yVZi63Lak4d4tbjRWxjsfvz5YtFG0Gz+D8=;
        b=Klq23GFlF4B4Y5HCGn+DgkvtGBGsBjnEbsQnRQ/RRIpOlGNqGJZRa4rs0KRwaBu5fG
         GiY+fkfvWlriXkhiqXGrVy6nGM9+olox9Mlmhl/X9GlX4Fxd+h356qCcvDF4TJiZUfnF
         KkggHo5WpqhZDM/J0d7ef8l8qGeNiIsXAXEPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zM0IXLI05yVZi63Lak4d4tbjRWxjsfvz5YtFG0Gz+D8=;
        b=iLvrddpvzDUVnNKq27PZr8BicEPrDGJ6lV8JNV3jYvK+LloA03Gpg+z03d0FPT2IdU
         TyIQf6xB1EnXOtmcszilfx5GEkM/rgs8itw2O8Zokxg6hpiOCnBh2rqsgp8+sxLf1C8M
         +NUsO7qrski5nsuFgzT/qsLn7Q7WYcCKNaKiGb0ZkgnoP/9ZDjSsLhcXU0GeUyjFyCRw
         GU/R1uRbC5AXnWgf6MM7G/UMCQBYShSgkDlRnfC7zD10MFIBZhUgOjvOFl75SezpHlKY
         QkQou2aXwr6vPHIPSvYMuyGb2QZdeZR8s+HPxA0/nkVCAeWzzMo4b9AGx5f0ji3cge7N
         Ntbw==
X-Gm-Message-State: AOAM531nEtwsuFpBeDduL4OXTxSo2ixcXI/GkCf//t48p3B2FaYLQfIR
        sZbn9JZnL2eZ7Tb7rSxnT9deUQ==
X-Google-Smtp-Source: ABdhPJwUEtutory+onldo0x1TGixN2zRXjY9H9kTOfyV/3nXFsbLE/x47ySFF9yVejeK5EGLipjhww==
X-Received: by 2002:a05:6e02:5a3:: with SMTP id k3mr3856271ils.283.1631225783245;
        Thu, 09 Sep 2021 15:16:23 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b19sm1543257ile.88.2021.09.09.15.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 15:16:22 -0700 (PDT)
Subject: Re: [PATCH 13/19] cpupower: add the function to check amd-pstate
 enabled
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
 <20210908150001.3702552-14-ray.huang@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <50412248-179d-3548-aeb0-d912a14a152f@linuxfoundation.org>
Date:   Thu, 9 Sep 2021 16:16:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210908150001.3702552-14-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/8/21 8:59 AM, Huang Rui wrote:
> Introduce the cpupower_amd_pstate_enabled() to check whether the kernel
> mode enables amd-pstate.
> 

What does "kernel mode" mean? Are you referring to kernel vs.
firmware mode?

> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>   tools/power/cpupower/utils/helpers/helpers.h |  5 +++++
>   tools/power/cpupower/utils/helpers/misc.c    | 20 ++++++++++++++++++++
>   2 files changed, 25 insertions(+)
> 
> diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
> index b4813efdfb00..eb43c14d1728 100644
> --- a/tools/power/cpupower/utils/helpers/helpers.h
> +++ b/tools/power/cpupower/utils/helpers/helpers.h
> @@ -136,6 +136,11 @@ extern int decode_pstates(unsigned int cpu, int boost_states,
>   
>   extern int cpufreq_has_boost_support(unsigned int cpu, int *support,
>   				     int *active, int * states);
> +
> +/* AMD PSTATE enabling **************************/
> +
> +extern unsigned long cpupower_amd_pstate_enabled(unsigned int cpu);
> +
>   /*
>    * CPUID functions returning a single datum
>    */
> diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> index fc6e34511721..07d80775fb68 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -83,6 +83,26 @@ int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val)
>   	return 0;
>   }
>   
> +unsigned long cpupower_amd_pstate_enabled(unsigned int cpu)
> +{
> +	char linebuf[MAX_LINE_LEN];
> +	char path[SYSFS_PATH_MAX];
> +	unsigned long val;
> +	char *endp;
> +
> +	snprintf(path, sizeof(path),
> +		 PATH_TO_CPU "cpu%u/cpufreq/is_amd_pstate_enabled", cpu);
> +
> +	if (cpupower_read_sysfs(path, linebuf, MAX_LINE_LEN) == 0)
> +		return 0;
> +
> +	val = strtoul(linebuf, &endp, 0);
> +	if (endp == linebuf || errno == ERANGE)
> +		return 0;
> +
> +	return val;
> +}
> +
>   #endif /* #if defined(__i386__) || defined(__x86_64__) */
>   
>   /* get_cpustate
> 

