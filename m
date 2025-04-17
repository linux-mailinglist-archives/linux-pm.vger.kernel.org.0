Return-Path: <linux-pm+bounces-25626-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376CEA91C2F
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 14:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69C05446292
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 12:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8DF2459EF;
	Thu, 17 Apr 2025 12:28:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0C02441A0;
	Thu, 17 Apr 2025 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744892889; cv=none; b=lQ255ZQnyalJkmRhW3Og6/U75Dg512vb8eygUVNjSg+kAsVZ1jgBGqW/IpYGZp27skz2vt3jWDYG7e3/sxuoLFtzxLpbrDhE+UmximAvSFElbqbNVDwBrYEvw2IKkO/Ib7jUztRTp1uyY6TlbvIU1An/uQkuPNFooMrw1szDzIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744892889; c=relaxed/simple;
	bh=1OJ5BmP5pnVnEBXCyC0kZNtLlbsT8ApOQdeN59GEIx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TwJjwFRytG+wnebaQHcJTfuUCHVDU8tuDNN6Ej6diDYJuaCpZWyENukJkB9CivMuWjibAaKGcnL/y9S7tR5QwZ7/XtwGK+lixpRk73CQXRa0kCZr0rynZkgTHBVXwdapaW1DJ3Wm3LigZ/1ZjlIYnp3UDLYAqPjWYWOjGZkysjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD3FC1515;
	Thu, 17 Apr 2025 05:28:04 -0700 (PDT)
Received: from [10.1.25.43] (e127648.arm.com [10.1.25.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D74B13F694;
	Thu, 17 Apr 2025 05:28:05 -0700 (PDT)
Message-ID: <f792b69d-28b3-48a7-8bc2-cea6f35bd19e@arm.com>
Date: Thu, 17 Apr 2025 13:28:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT][PATCH v1 2/8] cpufreq/sched: Move cpufreq-specific EAS
 checks to cpufreq
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>
References: <3344336.aeNJFYEL58@rjwysocki.net>
 <6039220.MhkbZ0Pkbq@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <6039220.MhkbZ0Pkbq@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/25 18:59, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Doing cpufreq-specific EAS checks that require accessing policy
> internals directly from sched_is_eas_possible() is a bit unfortunate,
> so introduce cpufreq_ready_for_eas() in cpufreq, move those checks
> into that new function and make sched_is_eas_possible() call it.
> 
> While at it, address a possible race between the EAS governor check
> and governor change by doing the former under the policy rwsem.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v0.3 -> v1
>      * Add a new helper called cpufreq_policy_is_good_for_eas() which is
>        properly synchronized with governor changes.
>      * Slightly modify debug messages.
> 
> This patch is regarded as a cleanup for 6.16.
> 
> ---
>  drivers/cpufreq/cpufreq.c |   32 ++++++++++++++++++++++++++++++++
>  include/linux/cpufreq.h   |    2 ++
>  kernel/sched/topology.c   |   25 +++++--------------------
>  3 files changed, 39 insertions(+), 20 deletions(-)
> 
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -3041,6 +3041,38 @@
>  
>  	return 0;
>  }
> +
> +static bool cpufreq_policy_is_good_for_eas(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy);
> +
> +	policy = cpufreq_cpu_get(cpu);
> +	if (!policy) {
> +		pr_debug("cpufreq policy not set for CPU: %d", cpu);
> +		return false;
> +	}
> +
> +	guard(cpufreq_policy_read)(policy);
> +
> +	return sugov_is_governor(policy);
> +}
> +
> +bool cpufreq_ready_for_eas(const struct cpumask *cpu_mask)
> +{
> +	unsigned int cpu;
> +
> +	/* Do not attempt EAS if schedutil is not being used. */
> +	for_each_cpu(cpu, cpu_mask) {
> +		if (!cpufreq_policy_is_good_for_eas(cpu)) {
> +			pr_debug("rd %*pbl: schedutil is mandatory for EAS\n",
> +				 cpumask_pr_args(cpu_mask));
> +			return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
>  module_param(off, int, 0444);
>  module_param_string(default_governor, default_governor, CPUFREQ_NAME_LEN, 0444);
>  core_initcall(cpufreq_core_init);
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -1212,6 +1212,8 @@
>  		struct cpufreq_frequency_table *table,
>  		unsigned int transition_latency);
>  
> +bool cpufreq_ready_for_eas(const struct cpumask *cpu_mask);
> +
>  static inline void cpufreq_register_em_with_opp(struct cpufreq_policy *policy)
>  {
>  	dev_pm_opp_of_register_em(get_cpu_device(policy->cpu),
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -212,8 +212,6 @@
>  static bool sched_is_eas_possible(const struct cpumask *cpu_mask)
>  {
>  	bool any_asym_capacity = false;
> -	struct cpufreq_policy *policy;
> -	bool policy_is_ready;
>  	int i;
>  
>  	/* EAS is enabled for asymmetric CPU capacity topologies. */
> @@ -248,25 +246,12 @@
>  		return false;
>  	}
>  
> -	/* Do not attempt EAS if schedutil is not being used. */
> -	for_each_cpu(i, cpu_mask) {
> -		policy = cpufreq_cpu_get(i);
> -		if (!policy) {
> -			if (sched_debug()) {
> -				pr_info("rd %*pbl: Checking EAS, cpufreq policy not set for CPU: %d",
> -					cpumask_pr_args(cpu_mask), i);
> -			}
> -			return false;
> -		}
> -		policy_is_ready = sugov_is_governor(policy);
> -		cpufreq_cpu_put(policy);
> -		if (!policy_is_ready) {
> -			if (sched_debug()) {
> -				pr_info("rd %*pbl: Checking EAS, schedutil is mandatory\n",
> -					cpumask_pr_args(cpu_mask));
> -			}
> -			return false;
> +	if (!cpufreq_ready_for_eas(cpu_mask)) {
> +		if (sched_debug()) {
> +			pr_info("rd %*pbl: Checking EAS: cpufreq is not ready",

Missing \n here.
There is another one you touch, I've sent patches already last month:
https://lore.kernel.org/lkml/20250319131324.224228-1-christian.loehle@arm.com/

With that:
Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> +				cpumask_pr_args(cpu_mask));
>  		}
> +		return false;
>  	}
>  
>  	return true;
> 
> 
> 


