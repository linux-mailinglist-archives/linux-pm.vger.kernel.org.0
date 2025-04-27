Return-Path: <linux-pm+bounces-26275-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E49A9DEA5
	for <lists+linux-pm@lfdr.de>; Sun, 27 Apr 2025 04:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F289E17F3AE
	for <lists+linux-pm@lfdr.de>; Sun, 27 Apr 2025 02:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34391DDA0C;
	Sun, 27 Apr 2025 02:26:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04CF10E0;
	Sun, 27 Apr 2025 02:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745720765; cv=none; b=bAkB7swza1DJmh1BEbcHxN9HZXLAyj2VBHOH0aO6n2DsNoD0V9nfHKY1nvlBIOsnyDV0g3QgLh6QbD/LCHf7u/mJYwk4LUs4CI/OICd8iol+GwfV2Vqry0FQk9kP/TTPYxecXhTchaATVevEivfaNUwob/jxxna3dxWHH2xnVMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745720765; c=relaxed/simple;
	bh=JfXk/alqfrcjxubAb2a6ESHPILt3F6ELPNr5qDAl92g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XsFjiGd34UILlr0zxyWxluDbkGbcbDs8qJIpnDLYF0INPV8C93CbcUlP2yNAL2ooGDIvn0sy8o6Q1GdUyLLcMuN7R/BOucwfLeusZsog12hiKaPqwnaqIUOLfUULH3HLzJJcWMDWexI0zY8rQ/zV3Rrkx5/NmoYHGZrr/Spl7dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZlVlj2MLwz13Kcd;
	Sun, 27 Apr 2025 10:24:49 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 1CD431402D0;
	Sun, 27 Apr 2025 10:25:53 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 27 Apr
 2025 10:25:52 +0800
Message-ID: <2fd8c27d-7206-4af6-b30b-d8f786827d94@huawei.com>
Date: Sun, 27 Apr 2025 10:25:51 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: Fix setting policy limits when frequency
 tables are used
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Linux PM <linux-pm@vger.kernel.org>, Christian Loehle
	<christian.loehle@arm.com>, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Sultan Alsawaf <sultan@kerneltoast.com>, Stephan
 Gerhold <stephan.gerhold@linaro.org>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>
References: <5896780.DvuYhMxLoT@rjwysocki.net>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <5896780.DvuYhMxLoT@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/4/25 19:36, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 7491cdf46b5c ("cpufreq: Avoid using inconsistent policy->min and
> policy->max") overlooked the fact that policy->min and policy->max were
> accessed directly in cpufreq_frequency_table_target() and in the
> functions called by it.  Consequently, the changes made by that commit
> led to problems with setting policy limits.
> 
> Address this by passing the target frequency limits to __resolve_freq()
> and cpufreq_frequency_table_target() and propagating them to the
> functions called by the latter.
> 
> Fixes: 7491cdf46b5c ("cpufreq: Avoid using inconsistent policy->min and policy->max")
> Link: https://lore.kernel.org/linux-pm/aAplED3IA_J0eZN0@linaro.org/
> Reported-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> The v1 is here: https://lore.kernel.org/linux-pm/12665363.O9o76ZdvQC@rjwysocki.net/
> 
> v1 -> v2:
>    * Do clamp_val(target_freq, min, max) before checking freq_table against
>      NULL in __resolve_freq().
>    * Update comment in cpufreq_frequency_table_target() to match the new code.
> 
> ---
>  drivers/cpufreq/cpufreq.c          |   22 ++++++---
>  drivers/cpufreq/cpufreq_ondemand.c |    3 -
>  drivers/cpufreq/freq_table.c       |    6 +-
>  include/linux/cpufreq.h            |   83 ++++++++++++++++++++++++-------------
>  4 files changed, 73 insertions(+), 41 deletions(-)
> 
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -491,14 +491,18 @@
>  EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
>  
>  static unsigned int __resolve_freq(struct cpufreq_policy *policy,
> -		unsigned int target_freq, unsigned int relation)
> +				   unsigned int target_freq,
> +				   unsigned int min, unsigned int max,
> +				   unsigned int relation)
>  {
>  	unsigned int idx;
>  
> +	target_freq = clamp_val(target_freq, min, max);
> +
>  	if (!policy->freq_table)
>  		return target_freq;
>  
> -	idx = cpufreq_frequency_table_target(policy, target_freq, relation);
> +	idx = cpufreq_frequency_table_target(policy, target_freq, min, max, relation);
>  	policy->cached_resolved_idx = idx;
>  	policy->cached_target_freq = target_freq;
>  	return policy->freq_table[idx].frequency;
> @@ -532,8 +536,7 @@
>  	if (unlikely(min > max))
>  		min = max;
>  
> -	return __resolve_freq(policy, clamp_val(target_freq, min, max),
> -			      CPUFREQ_RELATION_LE);
> +	return __resolve_freq(policy, target_freq, min, max, CPUFREQ_RELATION_LE);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
>  
> @@ -2351,8 +2354,8 @@
>  	if (cpufreq_disabled())
>  		return -ENODEV;
>  
> -	target_freq = clamp_val(target_freq, policy->min, policy->max);
> -	target_freq = __resolve_freq(policy, target_freq, relation);
> +	target_freq = __resolve_freq(policy, target_freq, policy->min,
> +				     policy->max, relation);
>  
>  	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
>  		 policy->cpu, target_freq, relation, old_target_freq);
> @@ -2650,8 +2653,11 @@
>  	 * compiler optimizations around them because they may be accessed
>  	 * concurrently by cpufreq_driver_resolve_freq() during the update.
>  	 */
> -	WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max, CPUFREQ_RELATION_H));
> -	new_data.min = __resolve_freq(policy, new_data.min, CPUFREQ_RELATION_L);
> +	WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max,
> +					       new_data.min, new_data.max,
> +					       CPUFREQ_RELATION_H));
> +	new_data.min = __resolve_freq(policy, new_data.min, new_data.min,
> +				      new_data.max, CPUFREQ_RELATION_L);
>  	WRITE_ONCE(policy->min, new_data.min > policy->max ? policy->max : new_data.min);

It might be better like:

-	WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max, CPUFREQ_RELATION_H));
-	new_data.min = __resolve_freq(policy, new_data.min, CPUFREQ_RELATION_L);
- 	WRITE_ONCE(policy->min, new_data.min > policy->max ? policy->max : new_data.min);
+	WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max,
+					       new_data.min, new_data.max,
+					       CPUFREQ_RELATION_H));
+	WRITE_ONCE(policy->min, __resolve_freq(policy, new_data.min,
+					       new_data.min, policy->max,
+					       CPUFREQ_RELATION_L));

>  
>  	trace_cpu_frequency_limits(policy);
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -76,7 +76,8 @@
>  		return freq_next;
>  	}
>  
> -	index = cpufreq_frequency_table_target(policy, freq_next, relation);
> +	index = cpufreq_frequency_table_target(policy, freq_next, policy->min,
> +					       policy->max, relation);
>  	freq_req = freq_table[index].frequency;
>  	freq_reduc = freq_req * od_tuners->powersave_bias / 1000;
>  	freq_avg = freq_req - freq_reduc;
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -115,8 +115,8 @@
>  EXPORT_SYMBOL_GPL(cpufreq_generic_frequency_table_verify);
>  
>  int cpufreq_table_index_unsorted(struct cpufreq_policy *policy,
> -				 unsigned int target_freq,
> -				 unsigned int relation)
> +				 unsigned int target_freq, unsigned int min,
> +				 unsigned int max, unsigned int relation)
>  {
>  	struct cpufreq_frequency_table optimal = {
>  		.driver_data = ~0,
> @@ -147,7 +147,7 @@
>  	cpufreq_for_each_valid_entry_idx(pos, table, i) {
>  		freq = pos->frequency;
>  
> -		if ((freq < policy->min) || (freq > policy->max))
> +		if (freq < min || freq > max)
>  			continue;
>  		if (freq == target_freq) {
>  			optimal.driver_data = i;
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -788,8 +788,8 @@
>  int cpufreq_generic_frequency_table_verify(struct cpufreq_policy_data *policy);
>  
>  int cpufreq_table_index_unsorted(struct cpufreq_policy *policy,
> -				 unsigned int target_freq,
> -				 unsigned int relation);
> +				 unsigned int target_freq, unsigned int min,
> +				 unsigned int max, unsigned int relation);
>  int cpufreq_frequency_table_get_index(struct cpufreq_policy *policy,
>  		unsigned int freq);
>  
> @@ -852,12 +852,12 @@
>  	return best;
>  }
>  
> -/* Works only on sorted freq-tables */
> -static inline int cpufreq_table_find_index_l(struct cpufreq_policy *policy,
> -					     unsigned int target_freq,
> -					     bool efficiencies)
> +static inline int find_index_l(struct cpufreq_policy *policy,
> +			       unsigned int target_freq,
> +			       unsigned int min, unsigned int max,
> +			       bool efficiencies)
>  {
> -	target_freq = clamp_val(target_freq, policy->min, policy->max);
> +	target_freq = clamp_val(target_freq, min, max);
>  
>  	if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
>  		return cpufreq_table_find_index_al(policy, target_freq,
> @@ -867,6 +867,14 @@
>  						   efficiencies);
>  }
>  
> +/* Works only on sorted freq-tables */
> +static inline int cpufreq_table_find_index_l(struct cpufreq_policy *policy,
> +					     unsigned int target_freq,
> +					     bool efficiencies)
> +{
> +	return find_index_l(policy, target_freq, policy->min, policy->max, efficiencies);
> +}
> +
>  /* Find highest freq at or below target in a table in ascending order */
>  static inline int cpufreq_table_find_index_ah(struct cpufreq_policy *policy,
>  					      unsigned int target_freq,
> @@ -920,12 +928,12 @@
>  	return best;
>  }
>  
> -/* Works only on sorted freq-tables */
> -static inline int cpufreq_table_find_index_h(struct cpufreq_policy *policy,
> -					     unsigned int target_freq,
> -					     bool efficiencies)
> +static inline int find_index_h(struct cpufreq_policy *policy,
> +			       unsigned int target_freq,
> +			       unsigned int min, unsigned int max,
> +			       bool efficiencies)
>  {
> -	target_freq = clamp_val(target_freq, policy->min, policy->max);
> +	target_freq = clamp_val(target_freq, min, max);
>  
>  	if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
>  		return cpufreq_table_find_index_ah(policy, target_freq,
> @@ -935,6 +943,14 @@
>  						   efficiencies);
>  }
>  
> +/* Works only on sorted freq-tables */
> +static inline int cpufreq_table_find_index_h(struct cpufreq_policy *policy,
> +					     unsigned int target_freq,
> +					     bool efficiencies)
> +{
> +	return find_index_h(policy, target_freq, policy->min, policy->max, efficiencies);
> +}
> +
>  /* Find closest freq to target in a table in ascending order */
>  static inline int cpufreq_table_find_index_ac(struct cpufreq_policy *policy,
>  					      unsigned int target_freq,
> @@ -1005,12 +1021,12 @@
>  	return best;
>  }
>  
> -/* Works only on sorted freq-tables */
> -static inline int cpufreq_table_find_index_c(struct cpufreq_policy *policy,
> -					     unsigned int target_freq,
> -					     bool efficiencies)
> +static inline int find_index_c(struct cpufreq_policy *policy,
> +			       unsigned int target_freq,
> +			       unsigned int min, unsigned int max,
> +			       bool efficiencies)
>  {
> -	target_freq = clamp_val(target_freq, policy->min, policy->max);
> +	target_freq = clamp_val(target_freq, min, max);
>  
>  	if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
>  		return cpufreq_table_find_index_ac(policy, target_freq,
> @@ -1020,7 +1036,17 @@
>  						   efficiencies);
>  }
>  
> -static inline bool cpufreq_is_in_limits(struct cpufreq_policy *policy, int idx)
> +/* Works only on sorted freq-tables */
> +static inline int cpufreq_table_find_index_c(struct cpufreq_policy *policy,
> +					     unsigned int target_freq,
> +					     bool efficiencies)
> +{
> +	return find_index_c(policy, target_freq, policy->min, policy->max, efficiencies);
> +}
> +
> +static inline bool cpufreq_is_in_limits(struct cpufreq_policy *policy,
> +					unsigned int min, unsigned int max,
> +					int idx)
>  {
>  	unsigned int freq;
>  
> @@ -1029,11 +1055,13 @@
>  
>  	freq = policy->freq_table[idx].frequency;
>  
> -	return freq == clamp_val(freq, policy->min, policy->max);
> +	return freq == clamp_val(freq, min, max);
>  }
>  
>  static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
>  						 unsigned int target_freq,
> +						 unsigned int min,
> +						 unsigned int max,
>  						 unsigned int relation)
>  {
>  	bool efficiencies = policy->efficiencies_available &&
> @@ -1044,29 +1072,26 @@
>  	relation &= ~CPUFREQ_RELATION_E;
>  
>  	if (unlikely(policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED))
> -		return cpufreq_table_index_unsorted(policy, target_freq,
> -						    relation);
> +		return cpufreq_table_index_unsorted(policy, target_freq, min,
> +						    max, relation);
>  retry:
>  	switch (relation) {
>  	case CPUFREQ_RELATION_L:
> -		idx = cpufreq_table_find_index_l(policy, target_freq,
> -						 efficiencies);
> +		idx = find_index_l(policy, target_freq, min, max, efficiencies);
>  		break;
>  	case CPUFREQ_RELATION_H:
> -		idx = cpufreq_table_find_index_h(policy, target_freq,
> -						 efficiencies);
> +		idx = find_index_h(policy, target_freq, min, max, efficiencies);
>  		break;
>  	case CPUFREQ_RELATION_C:
> -		idx = cpufreq_table_find_index_c(policy, target_freq,
> -						 efficiencies);
> +		idx = find_index_c(policy, target_freq, min, max, efficiencies);
>  		break;
>  	default:
>  		WARN_ON_ONCE(1);
>  		return 0;
>  	}
>  
> -	/* Limit frequency index to honor policy->min/max */
> -	if (!cpufreq_is_in_limits(policy, idx) && efficiencies) {
> +	/* Limit frequency index to honor min and max */
> +	if (!cpufreq_is_in_limits(policy, min, max, idx) && efficiencies) {
>  		efficiencies = false;
>  		goto retry;
>  	}
> 
> 
> 
> 
> 


