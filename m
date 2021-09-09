Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC36C405FB1
	for <lists+linux-pm@lfdr.de>; Fri, 10 Sep 2021 00:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345823AbhIIWrv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 18:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343850AbhIIWrv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 18:47:51 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A54AC061575
        for <linux-pm@vger.kernel.org>; Thu,  9 Sep 2021 15:46:41 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id g9so4452636ioq.11
        for <linux-pm@vger.kernel.org>; Thu, 09 Sep 2021 15:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=plbVGyQIOThzcyQI2bqq3xPq+wHbHcvpVyb7goK7gHc=;
        b=fhd4DCBzKorNNb3b4gS2EF2xw/MOHFayRSModD8JqUdvSOildhuQJuK6zX6nQ2h4E2
         zk1v1N33njT97+FbdqnGmZjoFf84XZ6flA7R/XRID6A+0tT9d2kqLN6679D/gJv0MQzS
         MHRa8UtzY3HNvn7FLhewwI673tVtg+jQmeIkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=plbVGyQIOThzcyQI2bqq3xPq+wHbHcvpVyb7goK7gHc=;
        b=Z34KjFvKQFF/lYhLUnoMmnodiw/LiNMgiHzOY54y8CB2hf69/qOA8Fc7YM3FaViWjZ
         PPCOChgZX1spzfhwZ/hrdI8PkLam5y0S8wg82WzV3HN90KVEyPFp5Px5vIck8BGI1nw+
         mDZmcdhzvv7M0FPiKWPUSjQUNreKYNkFdyYh3D7tZV5GXhDzsejMVdvDiM1varBEl2Pv
         D7yLWef2JDU95Tps2RmIztbXzkcRXQd9KdyMxZRg39H6x3eHOIrdhN3LXox4D7WpTqV0
         AO535Uq0tEFxmEZLeXT9zPoPLp/tkPY1tgMEeF7jwu+WR+ROUO51ropNh13ac+kCdZvi
         A0Ug==
X-Gm-Message-State: AOAM5332MyCBUbH526P0m4zw+N1GhCjPWgXZ6dlhY4GdCf/aBPVSKG89
        9KnaL4Y08Ij4owxoo2FYZ1B+tA==
X-Google-Smtp-Source: ABdhPJy62GN9FtqAa/pImo0jtApY7rG/DNxxoAFM+U139IeLn+hpKQEKjpeDUHwSDyP+3o0ThpiJDQ==
X-Received: by 2002:a6b:28b:: with SMTP id 133mr4590855ioc.107.1631227600907;
        Thu, 09 Sep 2021 15:46:40 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c11sm1568248ioh.50.2021.09.09.15.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 15:46:40 -0700 (PDT)
Subject: Re: [PATCH 18/19] cpupower: print amd-pstate information on cpupower
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
 <20210908150001.3702552-19-ray.huang@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <70bef125-398b-8a3c-07f5-a4ebc68dc0c8@linuxfoundation.org>
Date:   Thu, 9 Sep 2021 16:46:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210908150001.3702552-19-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/8/21 9:00 AM, Huang Rui wrote:
> amd-pstate kernel module is using the fine grain frequency instead of
> acpi hardware pstate. So the performance and frequency values should be
> printed in frequency-info.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>   tools/power/cpupower/utils/cpufreq-info.c | 27 ++++++++++++++++++++---
>   1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
> index f9895e31ff5a..9eabed209adc 100644
> --- a/tools/power/cpupower/utils/cpufreq-info.c
> +++ b/tools/power/cpupower/utils/cpufreq-info.c
> @@ -183,9 +183,30 @@ static int get_boost_mode_x86(unsigned int cpu)
>   	printf(_("    Supported: %s\n"), support ? _("yes") : _("no"));
>   	printf(_("    Active: %s\n"), active ? _("yes") : _("no"));
>   
> -	if ((cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
> -	     cpupower_cpu_info.family >= 0x10) ||
> -	     cpupower_cpu_info.vendor == X86_VENDOR_HYGON) {
> +	if (cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
> +	    cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATE) {
> +		printf(_("    AMD PSTATE Highest Performance: %u. Maximum Frequency: "),
> +		       amd_pstate_get_data(cpu, HIGHEST_PERF));
> +		print_speed(amd_pstate_get_data(cpu, MAX_FREQ));
> +		printf(".\n");
> +
> +		printf(_("    AMD PSTATE Nominal Performance: %u. Nominal Frequency: "),
> +		       amd_pstate_get_data(cpu, NOMINAL_PERF));
> +		print_speed(amd_pstate_get_data(cpu, NOMINAL_FREQ));
> +		printf(".\n");
> +
> +		printf(_("    AMD PSTATE Lowest Non-linear Performance: %u. Lowest Non-linear Frequency: "),
> +		       amd_pstate_get_data(cpu, LOWEST_NONLINEAR_PERF));
> +		print_speed(amd_pstate_get_data(cpu, LOWEST_NONLINEAR_FREQ));
> +		printf(".\n");
> +
> +		printf(_("    AMD PSTATE Lowest Performance: %u. Lowest Frequency: "),
> +		       amd_pstate_get_data(cpu, LOWEST_PERF));
> +		print_speed(amd_pstate_get_data(cpu, MIN_FREQ));
> +		printf(".\n");
> +	} else if ((cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
> +		    cpupower_cpu_info.family >= 0x10) ||
> +		   cpupower_cpu_info.vendor == X86_VENDOR_HYGON) {
>   		ret = decode_pstates(cpu, b_states, pstates, &pstate_no);
>   		if (ret)
>   			return ret;
> 

Same issue here - amd specific code sprinkled all over the common routines.
Needs fixing.

thanks,
-- Shuah
