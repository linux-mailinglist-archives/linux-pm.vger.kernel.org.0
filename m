Return-Path: <linux-pm+bounces-40333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2068CFAC62
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 20:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA5B631A6261
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 19:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE8E2868AD;
	Tue,  6 Jan 2026 19:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIZhcwoi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED79F27874F;
	Tue,  6 Jan 2026 19:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767727921; cv=none; b=oHwnTb5LdR6G2CW1rza48h+GpHs4DIc8TtY+AH22yoiW9tLrZEQMHL/IZaEPqkmZBePqpZavIZb5JLHSsACyUlh35Rs176igUfzMSu5Y0DPKVh/3vt5GhlYjOauoQNZqqpJ6GH7cdqiHWMmDlbBxr0JUXwhXVGoZeuNMaFNVyGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767727921; c=relaxed/simple;
	bh=dT28aIvG361tZpCyaoEVPL4Zcsv1DTsVIPTajD/lazU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTCboxZ7AYSBtdXEbg4BepX98PicrcvSIhS5kXaAzY6vc/3b/oiWAjxFrJdJPvLpPXsPWjZiEAdAgxr1ftqpXWz/jGMTqEGZhnlXzKXfW9Z/L7qCY97ZcJA3poUnwclsB1DVIJTeKN1Lor6otKh6TqCIG3cz6fjyWmeUO7Qojbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIZhcwoi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B18C116C6;
	Tue,  6 Jan 2026 19:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767727919;
	bh=dT28aIvG361tZpCyaoEVPL4Zcsv1DTsVIPTajD/lazU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pIZhcwoiOdYj+Aq+Bk6kjZ3PfwpgKpgNnuIDSxi4AK2Pjo2hE4ru+26crQ7UjQRNM
	 v4HnOomSPVA7nqfpJZm7Z4S6aXGQoiddCFQnTaCIkqoTgEb6V1SXRcr2TUewdHBIaH
	 F7+kyWY75svvMuXgMiKg3K2wFnaNtuRLsrdexkm9VvjEJ3xRHfzqS+cKkVDdcGtztR
	 fjJWZ+wYGTAYeCdDz95AkDm12ZTd1hs5SaMabp2JxD7vlNSLLa+4Vh7eBzdoV8Od4W
	 UgJQsZm1f5eUqu7SSdnSpsos0bQmqQNXTVqvpwtKSEfi05AHu7KgdaWLcJv5N/vX2Q
	 3FI2O8nRP9erQ==
Message-ID: <1e51babe-d112-44fb-96e6-8ee7c8050302@kernel.org>
Date: Tue, 6 Jan 2026 13:31:57 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] cpufreq: Pass the policy to
 cpufreq_driver->adjust_perf()
To: K Prateek Nayak <kprateek.nayak@amd.com>, Huang Rui <ray.huang@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Bert Karwatzki <spasswolf@web.de>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: Perry Yuan <perry.yuan@amd.com>
References: <20260106073608.278644-1-kprateek.nayak@amd.com>
 <20260106073608.278644-3-kprateek.nayak@amd.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20260106073608.278644-3-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/6/2026 1:36 AM, K Prateek Nayak wrote:
> cpufreq_cpu_get() can sleep on PREEMPT_RT in presence of concurrent
> writer(s), however amd-pstate depends on fetching the cpudata via the
> policy's driver data which necessitates grabbing the reference.
> 
> Since schedutil governor can call "cpufreq_driver->update_perf()"
> during sched_tick/enqueue/dequeue with rq_lock held and IRQs disabled,
> fetching the policy object using the cpufreq_cpu_get() helper in the
> scheduler fast-path leads to "BUG: scheduling while atomic" on
> PREEMPT_RT [1].
> 
> Pass the cached cpufreq policy object in sg_policy to the update_perf()
> instead of just the CPU. The CPU can be inferred using "policy->cpu".
> 
> The lifetime of cpufreq_policy object outlasts that of the governor and
> the cpufreq driver (allocated when the CPU is onlined and only reclaimed
> when the CPU is offlined / the CPU device is removed) which makes it
> safe to be referenced throughout the governor's lifetime.
> 
> Link: https://lore.kernel.org/all/20250731092316.3191-1-spasswolf@web.de/ [1]

I think you should have these tags instead:
Reported-by: Bert Karwatzki <spasswolf@web.de>
Closes:https://lore.kernel.org/all/20250731092316.3191-1-spasswolf@web.de/ 
[1]

> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c     | 3 +--
>   drivers/cpufreq/cpufreq.c        | 4 ++--
>   drivers/cpufreq/intel_pstate.c   | 4 ++--
>   include/linux/cpufreq.h          | 4 ++--
>   kernel/sched/cpufreq_schedutil.c | 5 +++--
>   5 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5818a92d96b9..455e58a9b738 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -697,13 +697,12 @@ static unsigned int amd_pstate_fast_switch(struct cpufreq_policy *policy,
>   	return policy->cur;
>   }
>   
> -static void amd_pstate_adjust_perf(unsigned int cpu,
> +static void amd_pstate_adjust_perf(struct cpufreq_policy *policy,
>   				   unsigned long _min_perf,
>   				   unsigned long target_perf,
>   				   unsigned long capacity)
>   {
>   	u8 max_perf, min_perf, des_perf, cap_perf;
> -	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
>   	struct amd_cpudata *cpudata;
>   	union perf_cached perf;
>   
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 50dde2980f1b..8bdc8f9b8d86 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2244,12 +2244,12 @@ EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
>    * parallel with either ->target() or ->target_index() or ->fast_switch() for
>    * the same CPU.
>    */
> -void cpufreq_driver_adjust_perf(unsigned int cpu,
> +void cpufreq_driver_adjust_perf(struct cpufreq_policy *policy,
>   				 unsigned long min_perf,
>   				 unsigned long target_perf,
>   				 unsigned long capacity)
>   {
> -	cpufreq_driver->adjust_perf(cpu, min_perf, target_perf, capacity);
> +	cpufreq_driver->adjust_perf(policy, min_perf, target_perf, capacity);
>   }
>   
>   /**
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index ec4abe374573..8d25f0f2925c 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3237,12 +3237,12 @@ static unsigned int intel_cpufreq_fast_switch(struct cpufreq_policy *policy,
>   	return target_pstate * cpu->pstate.scaling;
>   }
>   
> -static void intel_cpufreq_adjust_perf(unsigned int cpunum,
> +static void intel_cpufreq_adjust_perf(struct cpufreq_policy *policy,
>   				      unsigned long min_perf,
>   				      unsigned long target_perf,
>   				      unsigned long capacity)
>   {
> -	struct cpudata *cpu = all_cpu_data[cpunum];
> +	struct cpudata *cpu = all_cpu_data[policy->cpu];
>   	u64 hwp_cap = READ_ONCE(cpu->hwp_cap_cached);
>   	int old_pstate = cpu->pstate.current_pstate;
>   	int cap_pstate, min_pstate, max_pstate, target_pstate;
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 0465d1e6f72a..fd26b3a4aa28 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -367,7 +367,7 @@ struct cpufreq_driver {
>   	 * conditions) scale invariance can be disabled, which causes the
>   	 * schedutil governor to fall back to the latter.
>   	 */
> -	void		(*adjust_perf)(unsigned int cpu,
> +	void		(*adjust_perf)(struct cpufreq_policy *policy,
>   				       unsigned long min_perf,
>   				       unsigned long target_perf,
>   				       unsigned long capacity);
> @@ -612,7 +612,7 @@ struct cpufreq_governor {
>   /* Pass a target to the cpufreq driver */
>   unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>   					unsigned int target_freq);
> -void cpufreq_driver_adjust_perf(unsigned int cpu,
> +void cpufreq_driver_adjust_perf(struct cpufreq_policy *policy,
>   				unsigned long min_perf,
>   				unsigned long target_perf,
>   				unsigned long capacity);
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 0ab5f9d4bc59..307f3076635e 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -461,6 +461,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
>   				     unsigned int flags)
>   {
>   	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
> +	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>   	unsigned long prev_util = sg_cpu->util;
>   	unsigned long max_cap;
>   
> @@ -482,10 +483,10 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
>   	if (sugov_hold_freq(sg_cpu) && sg_cpu->util < prev_util)
>   		sg_cpu->util = prev_util;
>   
> -	cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_min,
> +	cpufreq_driver_adjust_perf(sg_policy->policy, sg_cpu->bw_min,
>   				   sg_cpu->util, max_cap);
>   
> -	sg_cpu->sg_policy->last_freq_update_time = time;
> +	sg_policy->last_freq_update_time = time;
>   }
>   
>   static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)


