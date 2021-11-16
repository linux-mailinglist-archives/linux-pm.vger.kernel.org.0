Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05EC5453CC3
	for <lists+linux-pm@lfdr.de>; Wed, 17 Nov 2021 00:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhKPXmi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 18:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbhKPXmg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 18:42:36 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D18FC061764
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 15:39:39 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id f20so917941qtb.4
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 15:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hk4Dbn/innUSCH+I6h6DAlFwWf85a++ijfHQHPk3pZc=;
        b=wSQbPP7+bD4t3D2iHXusqt+NZpOVq7Q9u71SBDttaTlzBgnS28Dl3imYWdXa8ogSV3
         Lx/AsyYjqvmjN1YkhPPl+2djJLjnL4l35qFxK7m/M9Y2Xlu3KZMJ5WeUya2zWTHFndBF
         iZ+fyLpKtlc11o7Ly3eeAa+IxpQZdoxTzzYYcg1EddrAfTZy4z7G2KMA2CPE+qF3gKZX
         e6RR28XP1bOj1rscsgT467X0APpFo9a4jtv2RXZba2724CwoxSiFcjD+JF/Yl+bxzwxe
         +ndbYzmSLJx5mwF1MKAsSprHQaYQ9ZxQUm5GDtv4/oOHALTUB91c4W5k3oLw2pygRWJq
         7aKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hk4Dbn/innUSCH+I6h6DAlFwWf85a++ijfHQHPk3pZc=;
        b=0y2r1ubOW0NHBrd3LJRy+0RWo3TvFpLqoJdsEjveQrjYNoW1zRNpAucMtJo290pCQI
         nQYmgeXHz1NpiqBX33Yak33SOAQaPBjt4O4Xn8KiJzwIKIjwmZaJdUJ2GBbX4JunsVQg
         XY3zz+yQpoW8quijNZE4q7+8MR1uyj+Z56sHFv2LQG551NwcoFIf7YnUdUNBag6nfcG8
         6ht1Bmv0VU5A0/Z5yOfyoIE5RdiUjE/DPzc1yG3/3UNfmbCM5WIADgE1B+D0/4fKnKTZ
         PuCXuGRy19W4ZgEqy6OWgwM66tgLaNh3P7qkoiBe4IGwl+p43KXz3b24Lh/IAqaAaUaR
         mj3w==
X-Gm-Message-State: AOAM531Sbz/z5i2Fof8tL5jexpKtiye5EhX89JFwPcXVxinVvdbya9xE
        mTNRcSW+kbzBzTEdCmX5WxQjTQ==
X-Google-Smtp-Source: ABdhPJyq33+tLo2GsctywFh4hfhQQyOuGaVp+HTVNZ0G2m4RGbLujdyL98xaqu+7zPgBuFCsz69mWA==
X-Received: by 2002:ac8:7d83:: with SMTP id c3mr12356950qtd.359.1637105978136;
        Tue, 16 Nov 2021 15:39:38 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id d11sm7480775qtj.4.2021.11.16.15.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 15:39:37 -0800 (PST)
Subject: Re: [PATCH v4 1/5] arch_topology: Introduce thermal pressure update
 function
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, steev@kali.org,
        sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        bjorn.andersson@linaro.org, agross@kernel.org
References: <20211109195714.7750-1-lukasz.luba@arm.com>
 <20211109195714.7750-2-lukasz.luba@arm.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5de717f7-dd64-5584-540a-e0b86a431dde@linaro.org>
Date:   Tue, 16 Nov 2021 18:39:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211109195714.7750-2-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/9/21 2:57 PM, Lukasz Luba wrote:
> The thermal pressure is a mechanism which is used for providing
> information about reduced CPU performance to the scheduler. Usually code
> has to convert the value from frequency units into capacity units,
> which are understandable by the scheduler. Create a common conversion code
> which can be just used via a handy API.
> 
> Internally, the topology_update_thermal_pressure() operates on frequency
> in MHz and max CPU frequency is taken from 'freq_factor' (per-cpu).
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>

Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>

-- 
Warm Regards
Thara (She/Her/Hers)

> ---
>   arch/arm/include/asm/topology.h   |  1 +
>   arch/arm64/include/asm/topology.h |  1 +
>   drivers/base/arch_topology.c      | 43 ++++++++++++++++++++++++++++++-
>   include/linux/arch_topology.h     |  3 +++
>   include/linux/sched/topology.h    |  7 +++++
>   5 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
> index 470299ee2fba..f1eafacc9a30 100644
> --- a/arch/arm/include/asm/topology.h
> +++ b/arch/arm/include/asm/topology.h
> @@ -24,6 +24,7 @@
>   /* Replace task scheduler's default thermal pressure API */
>   #define arch_scale_thermal_pressure topology_get_thermal_pressure
>   #define arch_set_thermal_pressure   topology_set_thermal_pressure
> +#define arch_update_thermal_pressure	topology_update_thermal_pressure
>   
>   #else
>   
> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> index ec2db3419c41..7a421cbc99ed 100644
> --- a/arch/arm64/include/asm/topology.h
> +++ b/arch/arm64/include/asm/topology.h
> @@ -33,6 +33,7 @@ void update_freq_counters_refs(void);
>   /* Replace task scheduler's default thermal pressure API */
>   #define arch_scale_thermal_pressure topology_get_thermal_pressure
>   #define arch_set_thermal_pressure   topology_set_thermal_pressure
> +#define arch_update_thermal_pressure	topology_update_thermal_pressure
>   
>   #include <asm-generic/topology.h>
>   
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index fc0836f460fb..bed7d502c9a1 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -25,6 +25,7 @@
>   static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
>   static struct cpumask scale_freq_counters_mask;
>   static bool scale_freq_invariant;
> +static DEFINE_PER_CPU(u32, freq_factor) = 1;
>   
>   static bool supports_scale_freq_counters(const struct cpumask *cpus)
>   {
> @@ -168,6 +169,47 @@ void topology_set_thermal_pressure(const struct cpumask *cpus,
>   }
>   EXPORT_SYMBOL_GPL(topology_set_thermal_pressure);
>   
> +/**
> + * topology_update_thermal_pressure() - Update thermal pressure for CPUs
> + * @cpus        : The related CPUs for which capacity has been reduced
> + * @capped_freq : The maximum allowed frequency that CPUs can run at
> + *
> + * Update the value of thermal pressure for all @cpus in the mask. The
> + * cpumask should include all (online+offline) affected CPUs, to avoid
> + * operating on stale data when hot-plug is used for some CPUs. The
> + * @capped_freq reflects the currently allowed max CPUs frequency due to
> + * thermal capping. It might be also a boost frequency value, which is bigger
> + * than the internal 'freq_factor' max frequency. In such case the pressure
> + * value should simply be removed, since this is an indication that there is
> + * no thermal throttling. The @capped_freq must be provided in kHz.
> + */
> +void topology_update_thermal_pressure(const struct cpumask *cpus,
> +				      unsigned long capped_freq)
> +{
> +	unsigned long max_capacity, capacity;
> +	u32 max_freq;
> +	int cpu;
> +
> +	cpu = cpumask_first(cpus);
> +	max_capacity = arch_scale_cpu_capacity(cpu);
> +	max_freq = per_cpu(freq_factor, cpu);
> +
> +	/* Convert to MHz scale which is used in 'freq_factor' */
> +	capped_freq /= 1000;
> +
> +	/*
> +	 * Handle properly the boost frequencies, which should simply clean
> +	 * the thermal pressure value.
> +	 */
> +	if (max_freq <= capped_freq)
> +		capacity = max_capacity;
> +	else
> +		capacity = mult_frac(max_capacity, capped_freq, max_freq);
> +
> +	arch_set_thermal_pressure(cpus, max_capacity - capacity);
> +}
> +EXPORT_SYMBOL_GPL(topology_update_thermal_pressure);
> +
>   static ssize_t cpu_capacity_show(struct device *dev,
>   				 struct device_attribute *attr,
>   				 char *buf)
> @@ -220,7 +262,6 @@ static void update_topology_flags_workfn(struct work_struct *work)
>   	update_topology = 0;
>   }
>   
> -static DEFINE_PER_CPU(u32, freq_factor) = 1;
>   static u32 *raw_capacity;
>   
>   static int free_raw_capacity(void)
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index b97cea83b25e..ace1e5dcf773 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -59,6 +59,9 @@ static inline unsigned long topology_get_thermal_pressure(int cpu)
>   void topology_set_thermal_pressure(const struct cpumask *cpus,
>   				   unsigned long th_pressure);
>   
> +void topology_update_thermal_pressure(const struct cpumask *cpus,
> +				      unsigned long capped_freq);
> +
>   struct cpu_topology {
>   	int thread_id;
>   	int core_id;
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index c07bfa2d80f2..6e89a8e43aa7 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -273,6 +273,13 @@ void arch_set_thermal_pressure(const struct cpumask *cpus,
>   { }
>   #endif
>   
> +#ifndef arch_update_thermal_pressure
> +static __always_inline
> +void arch_update_thermal_pressure(const struct cpumask *cpus,
> +				  unsigned long capped_frequency)
> +{ }
> +#endif
> +
>   static inline int task_node(const struct task_struct *p)
>   {
>   	return cpu_to_node(task_cpu(p));
> 


