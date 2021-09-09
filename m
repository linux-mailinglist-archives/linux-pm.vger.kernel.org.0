Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34ED40423A
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 02:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348391AbhIIAW7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 20:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241998AbhIIAW6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Sep 2021 20:22:58 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82740C061575
        for <linux-pm@vger.kernel.org>; Wed,  8 Sep 2021 17:21:50 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id x10so100356ilm.12
        for <linux-pm@vger.kernel.org>; Wed, 08 Sep 2021 17:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nyyS/oElz6G47rTDzdZzhnO3VTNUt3aMfsrZJACLUK0=;
        b=N5L/bm9EA0/nF7JHD2xJaQPzpZZRk1v2vACf8FEufoCSvSU8YbdLVMQPFyD2yH/Kak
         dz6PQRrAd7YoMFKhmDZ3MbwuL6DsalNHyEkUKqDa3VgtdcagOJz49keEgGweFupudCpO
         cdXd+GBZDP7gDDjrecBlYfx5cebdIHw4ckAdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nyyS/oElz6G47rTDzdZzhnO3VTNUt3aMfsrZJACLUK0=;
        b=hUBEnWVr5qta2kLFJSupBGqwAu/4SCRcwFpdPANc/BOOfLvxAOGdEm2g0WuqxEis2j
         Bs4t4wG3WWLur92w4cMGHRhZJ9oPUqcYhMOXNFgxmqiATvWIbduYyn6403MOvJSGwmPv
         f+PeBtOBH3UyBSDIIFVzvCxtaoqbmLn4N7dIKzXG/7EkPJqBUenq2T6gFFDNChrD7II0
         4EHTjS82bffAFjYZZNyzQveeR+wF/Sj6L60IzqcKrcngLMvhv0STCQSIg89wMIW0iyGQ
         N2pMU1f4KnKNiy8ZSwkYsvp9ftyf7TFFWyzwc6S2PzQPDUUNn6KWdCKkUHhesbMXrD5f
         VgMg==
X-Gm-Message-State: AOAM531FBMolZctpGO8cnuZgH6gdzEGvxGu1m3m5X+3LkT6dQXsT40iU
        KVtDxU1uRO8ryBiHJylRO3zrfg==
X-Google-Smtp-Source: ABdhPJzpWC0pzdmX5gNMr3VJ2rqQkrO6po6sn3W5LyaZHqAAKLZ5NTPksOm5CJRcgUWrCECVlXV6Gg==
X-Received: by 2002:a92:c70e:: with SMTP id a14mr109747ilp.299.1631146909810;
        Wed, 08 Sep 2021 17:21:49 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d14sm122508iod.18.2021.09.08.17.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 17:21:49 -0700 (PDT)
Subject: Re: [PATCH 03/19] ACPI: CPPC: add cppc enable register function
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
 <20210908150001.3702552-4-ray.huang@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e23d49d3-1591-bd12-549a-efd2a1f28dea@linuxfoundation.org>
Date:   Wed, 8 Sep 2021 18:21:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210908150001.3702552-4-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/8/21 8:59 AM, Huang Rui wrote:
> From: Jinzhou Su <Jinzhou.Su@amd.com>
> 
> Export the cppc enable register function for future use.

This patch also adds a new function. How about saying something about
adding a new function.

> 
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>   drivers/acpi/cppc_acpi.c | 42 ++++++++++++++++++++++++++++++++++++++++
>   include/acpi/cppc_acpi.h |  5 +++++
>   2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index a4d4eebba1da..de4b30545215 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1220,6 +1220,48 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>   }
>   EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
>   
> +/**
> + * cppc_set_enable - Set to enable CPPC register.

Please make this more descriptive - does it write to register
What is the behavior in error paths etc.

> + * @cpu: CPU for which to enable CPPC register.
> + * @enable: enable field to write into share memory.

What should this be? What are the valid values to write?
Also aren't we adding this to header file where prtotype
is defined these days?

> + *
> + * Return: 0 for success, -ERRNO otherwise.
> + */
> +int cppc_set_enable(int cpu, u32 enable)
> +{
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> +	struct cpc_register_resource *enable_reg;
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	int ret = -1;
> +
> +	if (!cpc_desc) {
> +		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> +		return -ENODEV;
> +	}
> +

Don't we need to do some error checking on input args? What is the
valid range for cpu and enbale?

> +	enable_reg = &cpc_desc->cpc_regs[ENABLE];
> +
> +	if (CPC_IN_PCC(enable_reg)) {
> +
> +		if (pcc_ss_id < 0)
> +			return -EIO;
> +
> +		ret = cpc_write(cpu, enable_reg, enable);
> +		if (ret)
> +			return ret;
> +
> +		pcc_ss_data = pcc_data[pcc_ss_id];
> +
> +		down_write(&pcc_ss_data->pcc_lock);
> +		send_pcc_cmd(pcc_ss_id, CMD_WRITE);

Could this fail?

> +		up_write(&pcc_ss_data->pcc_lock);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_enable);
> +
>   /**
>    * cppc_set_perf - Set a CPU's performance controls.
>    * @cpu: CPU for which to set performance controls.
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 9f4985b4d64d..3fdae40a75fc 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -137,6 +137,7 @@ struct cppc_cpudata {
>   extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
>   extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
>   extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
> +extern int cppc_set_enable(int cpu, u32 enable);
>   extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
>   extern bool acpi_cpc_valid(void);
>   extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
> @@ -157,6 +158,10 @@ static inline int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>   {
>   	return -ENOTSUPP;
>   }
> +static inline int cppc_set_enable(int cpu, u32 enable)
> +{
> +	return -ENOTSUPP;
> +}
>   static inline int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps)
>   {
>   	return -ENOTSUPP;
> 

thanks,
-- Shuah
