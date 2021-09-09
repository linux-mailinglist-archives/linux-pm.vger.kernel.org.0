Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0A0405F8D
	for <lists+linux-pm@lfdr.de>; Fri, 10 Sep 2021 00:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346285AbhIIW2G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 18:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbhIIW14 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 18:27:56 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BF1C0613D9
        for <linux-pm@vger.kernel.org>; Thu,  9 Sep 2021 15:26:08 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id a22so4391434iok.12
        for <linux-pm@vger.kernel.org>; Thu, 09 Sep 2021 15:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HDeVT3WFqshrq+NihoAzfrbQ5FIBpToHR9x1cN4iOng=;
        b=apf0slexUKEP5aKpkMQ8aMdl4MFyrhoNx8EggR3Fto/x87nwipXHpb/U3IC88RFK3d
         AvtqKaf9GtB7exiRfUhuvEkWvmX3Mr8+UU7/c5bz+hqwrnEOhn3CiKoU6BBn/o9s5LJy
         yxeZsuu9WtKcdB2o3BciakO3lcIBOc0D1DVU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HDeVT3WFqshrq+NihoAzfrbQ5FIBpToHR9x1cN4iOng=;
        b=wpHf0ZVFYdJrnKHC5q1vR0IzIWO/5Py7vf8zrSdyaxfFv+an0J+xHjkJZ+Z7cA40vQ
         usXHZDTjkX9XW5EzFiNWI4a4UPtsjxiDC+fhbZUM0wopqt9MD2e6+uq0w7srmY0RI6Fv
         YdQCLJSkgG3t9sYSlgsnBkGmHDop08gapeFEghW8XqeQsFaOgHBYSRAZ57BDPUofxfbn
         qcPcY/oSsw79H42jPbae6/2qVMq1VkfeeujQriVGqsWAUMHh/mj5C9hDPFXPR5pkX2Mh
         FjCNubUg6zz8xp1d9Ir47sgdf3kzTu4/Zj1zLaNXN0FO2VRQsfzWe2BFbf7/oG4WxBqn
         RdfQ==
X-Gm-Message-State: AOAM532Qu/pQ3Omn5MpDhreI+P2JueLuQDQLPufesysDmFHl7yQdB0lU
        9VLBnj1oiOnH1Qs3FiKFCT3DOg==
X-Google-Smtp-Source: ABdhPJzF2jfni/jtrkHIuNeRkbR6OaR2tmvDHyQKs+0UY38IhJFiRWClxGua0Y9vYoqaJageC3hDhQ==
X-Received: by 2002:a5d:9ac1:: with SMTP id x1mr4463631ion.191.1631226367826;
        Thu, 09 Sep 2021 15:26:07 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t11sm1509339ilf.16.2021.09.09.15.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 15:26:07 -0700 (PDT)
Subject: Re: [PATCH 15/19] cpupower: add amd-pstate sysfs entries into
 libcpufreq
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
 <20210908150001.3702552-16-ray.huang@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <870445a1-1148-e5d1-08f8-df630466d788@linuxfoundation.org>
Date:   Thu, 9 Sep 2021 16:26:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210908150001.3702552-16-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/8/21 8:59 AM, Huang Rui wrote:
> These amd-pstate sysfs entries will be used on cpupower for amd-pstate
> kernel module.
> 

This commit log doesn't make sense. If these sysfs entries are used
for amd-pstate kernel module, why are they defined here.

Describe how these are used and the relationship between these defines
and the amd-pstate kernel module

> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>   tools/power/cpupower/lib/cpufreq.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
> index c3b56db8b921..3f92ddadaad2 100644
> --- a/tools/power/cpupower/lib/cpufreq.c
> +++ b/tools/power/cpupower/lib/cpufreq.c
> @@ -69,6 +69,14 @@ enum cpufreq_value {
>   	SCALING_MIN_FREQ,
>   	SCALING_MAX_FREQ,
>   	STATS_NUM_TRANSITIONS,
> +	AMD_PSTATE_HIGHEST_PERF,
> +	AMD_PSTATE_NOMINAL_PERF,
> +	AMD_PSTATE_LOWEST_NONLINEAR_PERF,
> +	AMD_PSTATE_LOWEST_PERF,
> +	AMD_PSTATE_MAX_FREQ,
> +	AMD_PSTATE_NOMINAL_FREQ,
> +	AMD_PSTATE_LOWEST_NONLINEAR_FREQ,
> +	AMD_PSTATE_MIN_FREQ,
>   	MAX_CPUFREQ_VALUE_READ_FILES
>   };
>   

These are AMD specific values being added to a common code.

> @@ -80,7 +88,15 @@ static const char *cpufreq_value_files[MAX_CPUFREQ_VALUE_READ_FILES] = {
>   	[SCALING_CUR_FREQ] = "scaling_cur_freq",
>   	[SCALING_MIN_FREQ] = "scaling_min_freq",
>   	[SCALING_MAX_FREQ] = "scaling_max_freq",
> -	[STATS_NUM_TRANSITIONS] = "stats/total_trans"
> +	[STATS_NUM_TRANSITIONS] = "stats/total_trans",
> +	[AMD_PSTATE_HIGHEST_PERF] = "amd_pstate_highest_perf",
> +	[AMD_PSTATE_NOMINAL_PERF] = "amd_pstate_nominal_perf",
> +	[AMD_PSTATE_LOWEST_NONLINEAR_PERF] = "amd_pstate_lowest_nonlinear_perf",
> +	[AMD_PSTATE_LOWEST_PERF] = "amd_pstate_lowest_perf",
> +	[AMD_PSTATE_MAX_FREQ] = "amd_pstate_max_freq",
> +	[AMD_PSTATE_NOMINAL_FREQ] = "amd_pstate_nominal_freq",
> +	[AMD_PSTATE_LOWEST_NONLINEAR_FREQ] = "amd_pstate_lowest_nonlinear_freq",
> +	[AMD_PSTATE_MIN_FREQ] = "amd_pstate_min_freq"
>   };
>   
>   
> 

These are AMD specific values being added to a common code.
It doesn't sound right. What happens if there is a conflict
between AMD values and another vendor values?

This doesn't seem a good place to add these.

thanks,
-- Shuah


