Return-Path: <linux-pm+bounces-1034-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB28810B52
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 08:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762C81F20FAA
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 07:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4A8182D4;
	Wed, 13 Dec 2023 07:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CPy5F8oW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6E7E3
	for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 23:17:25 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6ce7c1b07e1so5654472b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 23:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702451845; x=1703056645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tQkVZRL9vpSyDVIXwSM3uoJy33pbVTo1JnWRzA8kmd0=;
        b=CPy5F8oWeEkRUHaaCAJanMmk4DosUapS/0hH5Cwk6zrNQt7QsT3rJZHq7MZGn1QX2Q
         Z3wPIcCaZeOjp3v7EovIrQ/2Zm9ULT2gynm64I1meiyDH9BiUPWuUqeO45UtGiUjAgRi
         T8dyokWzbIupOof7oAj8WaYAYY8ayXQZwfw7WzPF2w8S77IYrQa5tJeR7ndpe/7CcMZ7
         90mqZ8tuqibMQxA07gIMQk8dSFs2z3AOhm9QJ+wf6Fh7lhfRMZ3SFHQwE8FKxq1MaQTf
         vwnU2XbWNUdkFhCUJ5dAfebaeSrL5/khUNeh4gfiqACJxOQd5nUMTVWqpLhALHuCcm9c
         kOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702451845; x=1703056645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQkVZRL9vpSyDVIXwSM3uoJy33pbVTo1JnWRzA8kmd0=;
        b=ttk20lwo1LOqc91TtKVWuRTuOsnAkLUElmdMnhOPTbGll4dJ4vuyj3lyUx81/AZ9cy
         LrU48qNYCxYKfas5YsYkFzDFDWDEC7JcQtNg+Hj7HpeseId9L8qTLk6Edx8h3yky60aA
         jORe5MEQc4GaVU3ilPuc8er+VlibTZ35UG2lniHm0ziDDpEBOg6lxcI4W95HeeGd0FcU
         3edNUQvFfFEgR+ZKG5pr40cqc6POB0ZmR0KZa2+2o0ja1qy9a6cVM8xOybazjMFLLiQB
         juVnm0JQTibelOysalCmz5frqnlTINaJGa2/BRU8ec6REaP/tRvz8ZcSJLjGl25aIdXl
         tFrA==
X-Gm-Message-State: AOJu0YwkYzWqBRHaR4bUV+DqTMcXDkQXakwhLVQfsdtihXQkYF31vPTE
	2bDc5u06CnQLq21tzkSzinG0yA==
X-Google-Smtp-Source: AGHT+IHiSXnDOemeyZyy/MLSWRxebQTdjMVtSLqQL6fptF1l9M0iOoG2O2S+n9eONFJnbFjX7Mf0dw==
X-Received: by 2002:a05:6a21:a586:b0:18f:97c:975d with SMTP id gd6-20020a056a21a58600b0018f097c975dmr12961474pzc.69.1702451845050;
        Tue, 12 Dec 2023 23:17:25 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id so3-20020a17090b1f8300b0028ae8495d47sm571658pjb.21.2023.12.12.23.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 23:17:24 -0800 (PST)
Date: Wed, 13 Dec 2023 12:47:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com,
	rafael@kernel.org, agross@kernel.org, andersson@kernel.org,
	konrad.dybcio@linaro.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, lukasz.luba@arm.com,
	rui.zhang@intel.com, mhiramat@kernel.org, daniel.lezcano@linaro.org,
	amit.kachhap@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] cpufreq: Add a cpufreq pressure feedback for the
 scheduler
Message-ID: <20231213071722.u6n2fokrfs7hf3nb@vireshk-i7>
References: <20231212142730.998913-1-vincent.guittot@linaro.org>
 <20231212142730.998913-2-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212142730.998913-2-vincent.guittot@linaro.org>
X-Spam-Level: *

On 12-12-23, 15:27, Vincent Guittot wrote:
> Provide to the scheduler a feedback about the temporary max available
> capacity. Unlike arch_update_thermal_pressure, this doesn't need to be
> filtered as the pressure will happen for dozens ms or more.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 48 +++++++++++++++++++++++++++++++++++++++
>  include/linux/cpufreq.h   | 10 ++++++++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 44db4f59c4cc..7d5f71be8d29 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2563,6 +2563,50 @@ int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu)
>  }
>  EXPORT_SYMBOL(cpufreq_get_policy);
>  
> +DEFINE_PER_CPU(unsigned long, cpufreq_pressure);
> +EXPORT_PER_CPU_SYMBOL_GPL(cpufreq_pressure);
> +
> +/**
> + * cpufreq_update_pressure() - Update cpufreq pressure for CPUs
> + * @cpus        : The related CPUs for which max capacity has been reduced
> + * @capped_freq : The maximum allowed frequency that CPUs can run at
> + *
> + * Update the value of cpufreq pressure for all @cpus in the mask. The
> + * cpumask should include all (online+offline) affected CPUs, to avoid
> + * operating on stale data when hot-plug is used for some CPUs. The
> + * @capped_freq reflects the currently allowed max CPUs frequency due to
> + * freq_qos capping. It might be also a boost frequency value, which is bigger
> + * than the internal 'capacity_freq_ref' max frequency. In such case the
> + * pressure value should simply be removed, since this is an indication that
> + * there is no capping. The @capped_freq must be provided in kHz.
> + */
> +static void cpufreq_update_pressure(const struct cpumask *cpus,

Since this is defined as 'static', why not just pass policy here ?

> +				      unsigned long capped_freq)
> +{
> +	unsigned long max_capacity, capacity, pressure;
> +	u32 max_freq;
> +	int cpu;
> +
> +	cpu = cpumask_first(cpus);
> +	max_capacity = arch_scale_cpu_capacity(cpu);

This anyway expects all of them to be from the same policy ..

> +	max_freq = arch_scale_freq_ref(cpu);
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
> +	pressure = max_capacity - capacity;
> +

Extra blank line here.

> +
> +	for_each_cpu(cpu, cpus)
> +		WRITE_ONCE(per_cpu(cpufreq_pressure, cpu), pressure);
> +}
> +
>  /**
>   * cpufreq_set_policy - Modify cpufreq policy parameters.
>   * @policy: Policy object to modify.
> @@ -2584,6 +2628,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  {
>  	struct cpufreq_policy_data new_data;
>  	struct cpufreq_governor *old_gov;
> +	struct cpumask *cpus;
>  	int ret;
>  
>  	memcpy(&new_data.cpuinfo, &policy->cpuinfo, sizeof(policy->cpuinfo));
> @@ -2618,6 +2663,9 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  	policy->max = __resolve_freq(policy, policy->max, CPUFREQ_RELATION_H);
>  	trace_cpu_frequency_limits(policy);
>  
> +	cpus = policy->related_cpus;

You don't need the extra variable anyway, but lets just pass policy
instead to the routine.

> +	cpufreq_update_pressure(cpus, policy->max);
> +
>  	policy->cached_target_freq = UINT_MAX;
>  
>  	pr_debug("new min and max freqs are %u - %u kHz\n",
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index afda5f24d3dd..b1d97edd3253 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -241,6 +241,12 @@ struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
>  void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
>  void cpufreq_disable_fast_switch(struct cpufreq_policy *policy);
>  bool has_target_index(void);
> +
> +DECLARE_PER_CPU(unsigned long, cpufreq_pressure);
> +static inline unsigned long cpufreq_get_pressure(int cpu)
> +{
> +	return per_cpu(cpufreq_pressure, cpu);
> +}
>  #else
>  static inline unsigned int cpufreq_get(unsigned int cpu)
>  {
> @@ -263,6 +269,10 @@ static inline bool cpufreq_supports_freq_invariance(void)
>  	return false;
>  }
>  static inline void disable_cpufreq(void) { }
> +static inline unsigned long cpufreq_get_pressure(int cpu)
> +{
> +	return 0;
> +}
>  #endif
>  
>  #ifdef CONFIG_CPU_FREQ_STAT
> -- 
> 2.34.1

-- 
viresh

