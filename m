Return-Path: <linux-pm+bounces-24463-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA588A6DF8E
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 17:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81A147A28B9
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 16:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796EF263C65;
	Mon, 24 Mar 2025 16:25:50 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AD62638AD;
	Mon, 24 Mar 2025 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833550; cv=none; b=Xm8aItD2V1hq5/UNMNulpVGWiVyehDRFQwG7x/WglYtESL1dhF3bYyEDllLS8S520nWJJCIY5ph639pwtJUns8urmxhQV9Ey4fTuiIgblp1R9NpWBQmJAIkZUduS+27+jji3XWHYV69eYZEpXddlGV4/+t+i9XOe0aQ3GAt47CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833550; c=relaxed/simple;
	bh=O23nC2ib6/Uawc94qMLOSYvg0d7JqzEsZfGYS4Fb9nY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7eYIt0EPkjl6WnFRG/1qjdXgdzeT3AvJBbBqlpEZ7kOy6gzJgDZm0uYFUnUvNlSB+9U1Ur5thoT4E/YiHC/iab8vDQna3TQflNzvLIbj0ELpxABbcYmMxQs7R3iY0EgWFoVGXi69pFkURlCgZ36PFQGUEgn4wZF0cJAkJG0Lz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C6DE16F3;
	Mon, 24 Mar 2025 09:25:53 -0700 (PDT)
Received: from [10.57.69.87] (unknown [10.57.69.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B0A63F58B;
	Mon, 24 Mar 2025 09:25:45 -0700 (PDT)
Message-ID: <9bb64bd4-8715-481b-9e08-73b715a78927@arm.com>
Date: Mon, 24 Mar 2025 16:25:49 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v0.3 5/6] PM: EM: Introduce em_adjust_cpu_capacity()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>
References: <22640172.EfDdHjke4D@rjwysocki.net>
 <2446858.NG923GbCHz@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2446858.NG923GbCHz@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/7/25 19:39, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add a function for updating the Energy Model for a CPU after its
> capacity has changed, which subsequently will be used by the
> intel_pstate driver.
> 
> An EM_PERF_DOMAIN_ARTIFICIAL check is added to em_adjust_new_capacity()
> to prevent it from calling em_compute_costs() for an "artificial" perf
> domain with a NULL cb parameter which would cause it to crash.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Note that this function is needed because the performance level values
> in the EM "state" table need to be adjusted on CPU capacity changes.  In
> the intel_pstate case the cost values associated with them don't change
> because they are artificial anyway, so replacing the entire table just
> in order to update the performance level values is a bit wasteful, but
> it seems to be an exception (in the other cases when the CPU capacity
> changes, the cost values change too AFAICS).
> 
> ---
>   include/linux/energy_model.h |    2 ++
>   kernel/power/energy_model.c  |   28 ++++++++++++++++++++++++----
>   2 files changed, 26 insertions(+), 4 deletions(-)
> 
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -179,6 +179,7 @@
>   int em_dev_update_chip_binning(struct device *dev);
>   int em_update_performance_limits(struct em_perf_domain *pd,
>   		unsigned long freq_min_khz, unsigned long freq_max_khz);
> +void em_adjust_cpu_capacity(unsigned int cpu);
>   void em_rebuild_sched_domains(void);
>   
>   /**
> @@ -405,6 +406,7 @@
>   {
>   	return -EINVAL;
>   }
> +void em_adjust_cpu_capacity(unsigned int cpu) {}
>   static inline void em_rebuild_sched_domains(void) {}
>   #endif
>   
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -698,10 +698,12 @@
>   {
>   	int ret;
>   
> -	ret = em_compute_costs(dev, em_table->state, NULL, pd->nr_perf_states,
> -			       pd->flags);
> -	if (ret)
> -		goto free_em_table;
> +	if (!(pd->flags & EM_PERF_DOMAIN_ARTIFICIAL)) {
> +		ret = em_compute_costs(dev, em_table->state, NULL,
> +				       pd->nr_perf_states, pd->flags);
> +		if (ret)
> +			goto free_em_table;
> +	}
>   
>   	ret = em_dev_update_perf_domain(dev, em_table);
>   	if (ret)
> @@ -751,6 +753,24 @@
>   	em_recalc_and_update(dev, pd, em_table);
>   }
>   
> +/**
> + * em_adjust_cpu_capacity() - Adjust the EM for a CPU after a capacity update.
> + * @cpu: Target CPU.
> + *
> + * Adjust the existing EM for @cpu after a capacity update under the assumption
> + * that the capacity has been updated in the same way for all of the CPUs in
> + * the same perf domain.
> + */
> +void em_adjust_cpu_capacity(unsigned int cpu)
> +{
> +	struct device *dev = get_cpu_device(cpu);
> +	struct em_perf_domain *pd;
> +
> +	pd = em_pd_get(dev);
> +	if (pd)
> +		em_adjust_new_capacity(cpu, dev, pd);
> +}
> +
>   static void em_check_capacity_update(void)
>   {
>   	cpumask_var_t cpu_done_mask;
> 
> 
> 

LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

