Return-Path: <linux-pm+bounces-24462-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A52A6DF8C
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 17:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79601681E7
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 16:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48B42638B0;
	Mon, 24 Mar 2025 16:25:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FDF263892;
	Mon, 24 Mar 2025 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833540; cv=none; b=QdSH5hW35UtVte3FMqmbBj/nCpODqgw4RCtJkElzeWcBbpmSF+yPk/y7MQqpL1YpnA0UsBABwRIOVs2zgIhEXXwJma+hib2idht/GK6nUqTEJC/Gmxbo/C1weW9Lv20xROZjwGUO1mOFrMmQDXw5IqGDq86m1nFz7JxiReKsEXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833540; c=relaxed/simple;
	bh=wC5vydyGm5rivyr8+UBxwa+Vbvcm9vCXbspYQDoO70U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2Mea2eEMC4U2VBwoiwUdErjLizmAj2jg9e2CWOhJz6nOu5SNhEo+uYngabBWi+fu+mBZcmt0APGyihR9eH/fe+KkYVo0yO3dClxx684vuC7rC//i5Hum+9cr0jthj+raiRNNAQUIXNQHtFSY69yhXhQFcb0Ex+JPfSa8eOA9gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E645116F3;
	Mon, 24 Mar 2025 09:25:43 -0700 (PDT)
Received: from [10.57.69.87] (unknown [10.57.69.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6B513F58B;
	Mon, 24 Mar 2025 09:25:35 -0700 (PDT)
Message-ID: <40c849f4-aaeb-48fb-87af-dfe9d404fc7d@arm.com>
Date: Mon, 24 Mar 2025 16:25:39 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v0.3 4/6] PM: EM: Move CPU capacity check to
 em_adjust_new_capacity()
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
 <2667366.Lt9SDvczpP@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2667366.Lt9SDvczpP@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

On 3/7/25 19:17, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Move the check of the CPU capacity currently stored in the energy model
> against the arch_scale_cpu_capacity() value to em_adjust_new_capacity()
> so it will be done regardless of where the latter is called from.
> 
> This will be useful when a new em_adjust_new_capacity() caller is added
> subsequently.
> 
> While at it, move the pd local variable declaration in
> em_check_capacity_update() into the loop in which it is used.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   kernel/power/energy_model.c |   40 +++++++++++++++++-----------------------
>   1 file changed, 17 insertions(+), 23 deletions(-)
> 
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -721,10 +721,24 @@
>    * Adjustment of CPU performance values after boot, when all CPUs capacites
>    * are correctly calculated.
>    */
> -static void em_adjust_new_capacity(struct device *dev,
> +static void em_adjust_new_capacity(unsigned int cpu, struct device *dev,
>   				   struct em_perf_domain *pd)
>   {
> +	unsigned long cpu_capacity = arch_scale_cpu_capacity(cpu);
>   	struct em_perf_table *em_table;
> +	struct em_perf_state *table;
> +	unsigned long em_max_perf;
> +
> +	rcu_read_lock();
> +	table = em_perf_state_from_pd(pd);
> +	em_max_perf = table[pd->nr_perf_states - 1].performance;
> +	rcu_read_unlock();
> +
> +	if (em_max_perf == cpu_capacity)
> +		return;
> +
> +	pr_debug("updating cpu%d cpu_cap=%lu old capacity=%lu\n", cpu,
> +		 cpu_capacity, em_max_perf);
>   
>   	em_table = em_table_dup(pd);
>   	if (!em_table) {
> @@ -740,9 +754,6 @@
>   static void em_check_capacity_update(void)
>   {
>   	cpumask_var_t cpu_done_mask;
> -	struct em_perf_state *table;
> -	struct em_perf_domain *pd;
> -	unsigned long cpu_capacity;
>   	int cpu;
>   
>   	if (!zalloc_cpumask_var(&cpu_done_mask, GFP_KERNEL)) {
> @@ -753,7 +764,7 @@
>   	/* Check if CPUs capacity has changed than update EM */
>   	for_each_possible_cpu(cpu) {
>   		struct cpufreq_policy *policy;
> -		unsigned long em_max_perf;
> +		struct em_perf_domain *pd;
>   		struct device *dev;
>   
>   		if (cpumask_test_cpu(cpu, cpu_done_mask))
> @@ -776,24 +787,7 @@
>   		cpumask_or(cpu_done_mask, cpu_done_mask,
>   			   em_span_cpus(pd));
>   
> -		cpu_capacity = arch_scale_cpu_capacity(cpu);
> -
> -		rcu_read_lock();
> -		table = em_perf_state_from_pd(pd);
> -		em_max_perf = table[pd->nr_perf_states - 1].performance;
> -		rcu_read_unlock();
> -
> -		/*
> -		 * Check if the CPU capacity has been adjusted during boot
> -		 * and trigger the update for new performance values.
> -		 */
> -		if (em_max_perf == cpu_capacity)
> -			continue;
> -
> -		pr_debug("updating cpu%d cpu_cap=%lu old capacity=%lu\n",
> -			 cpu, cpu_capacity, em_max_perf);
> -
> -		em_adjust_new_capacity(dev, pd);
> +		em_adjust_new_capacity(cpu, dev, pd);
>   	}
>   
>   	free_cpumask_var(cpu_done_mask);
> 
> 
> 


LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz

