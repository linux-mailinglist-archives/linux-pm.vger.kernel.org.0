Return-Path: <linux-pm+bounces-26222-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7AAA9CA1A
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 15:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9721BC6FE2
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 13:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A9E2512D2;
	Fri, 25 Apr 2025 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wOSRhaYP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10204252289
	for <linux-pm@vger.kernel.org>; Fri, 25 Apr 2025 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745587293; cv=none; b=Nad5VpFiCoK+wv5l3j4el9Go0JkI8miiHJWig+o3VR/zJo10HXdSu6w6ALxiGGvWuNChLq1so0Xlku/FSITNxdWrOibwepjuMPMeUEA9ZZfyGXaS0+v99ptqT8E8A/jLtsRMgjpigZ70YnhxmgAZQ8wwo4Gy5iwu4XLhHWHjvoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745587293; c=relaxed/simple;
	bh=pMKoSIxXm2ih+5Z6QJOXBsAHDMxCSrZZZPa4qz+0AU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rx5+IFu6aqbJm92QOXH5eSxGFo9/SYJUYfeil0UNQ3NW42iN8NwwAqUodoPMTb0Xb6p0tX0PSglmKY2u0Ya/tMdM548l7nDjyEnHuhkP5mhY+C6sGQ3BIoF//n/OQAQdtU2SJ+t6Y1rTxpI8lWUH8kIyl4injNl404YMzcUeF8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wOSRhaYP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d0618746bso17104085e9.2
        for <linux-pm@vger.kernel.org>; Fri, 25 Apr 2025 06:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745587289; x=1746192089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UP60iBoUIFlxLx9Iq6X2O2DVBwXct0dvnIu+DX/CAyw=;
        b=wOSRhaYP2opgk0clPwe9M52or+nf9cb9mj1rVE06THAyhBMGF437NkOVx5/bdRvzBW
         82UJt1o5tctRtbOeSVC3r279OzOP3elvK6shx6vRvOlVrVd/wkGOtbqMW7Pbx1nSbLQ4
         KTt0gaPvXHWSoh4d41/AQ2zlI6JytHe/m6c7fF5f7QGFrvui1pJzv7QvBnYqR5TGpeox
         fkDt4wkrnvNMs6RiOeAbhQlT6/4KqG6kxQRZnBb5OAfPTZNRKtLENeic3zrO5DlrWrNy
         vG92ub7wteQdNvLydL9ymN0M8B1ZLMXWSO+DoHpNNZH5oJU8g2EZY+gl+kjU/cknfUt+
         Fdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745587289; x=1746192089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UP60iBoUIFlxLx9Iq6X2O2DVBwXct0dvnIu+DX/CAyw=;
        b=NuAlhF6x7gG6bbu/7upE6pgkxRXupAWS0kmkVEksp6k4/F0sZccMaHhx0q18tyiAa2
         mLifHn8R4iNUkmYQOBrXmQhgCgpmchaBUIbuUH6/V7+ANSGecunDTA9md2WyzQ/GeORE
         b4ixBpqmu73PSIInrl4O0zG/t5bcm9SMFszWYloBKUGBL+7E+ZU2wSu4NXeyIuUqprHe
         7VWba6UpT82Eliz2mqfrHC/cO660gT13ukZMe+RSxi/iRpeBblCwyj3L2oBHtp45S2YB
         IT5dQKXnYsMhy+9u0tb3yCfSvmBWKRplxk0kIXe+DUF1o9ixRVdEPYZiOC6BWxfgHGVs
         h4NQ==
X-Gm-Message-State: AOJu0YweHZ2yCWXK8slTkeliCWANM0Y6JKxg4yb1y7+fadHDZqAR2O+M
	A51IhwgPQyM9+wDMBpPnP+T2Ni9WiugzTFb2lDyIPzDnE7OIKA+Qx9dHeaCu32tKEuczrWtNcJj
	4
X-Gm-Gg: ASbGnctTtCMgkrqgkMrLaaOkU2Qd0xFCqvHlfmwt63aSAK/EkwsSPuHBzQGB/5VaMCS
	pz1LTa4UP3dKdzND4SI18QlyvKzZHJZ6f9lAxwVzg21ynOoE9EyzBnHumy7WwXC6NiZ5pmCuRUj
	IDT4+LZC3NRs0pkyu0EnwRGIizAPr84OqiX2vlxs+bPuKTGOtEnYy+qUIWSXaI+FSj9p6hrZGd4
	LdxGCIpdi9IYsx33N1jlHHbXwVxztZPPHzh6vLm7TKfY3sFxGkMhJotDMB29Zaiob2EeIAlhZbx
	tES03iMEsfHF8S6Q2guAEdIIdMf0UgTMoBaRCOcnIV6AQEXBHdpV1rYjnABk8w==
X-Google-Smtp-Source: AGHT+IHJk123BAFM/Om3wMQr9j5yyedCLEkkcimmnu83HCWhx0N3Egs7jpxhgS6MKVCDoY0A2SGwmg==
X-Received: by 2002:a05:600c:3148:b0:43d:ea:51d2 with SMTP id 5b1f17b1804b1-440a65e37a3mr24493075e9.14.1745587289092;
        Fri, 25 Apr 2025 06:21:29 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:df4:a4cd:4213:ba64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4408d8d191bsm83933665e9.1.2025.04.25.06.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 06:21:28 -0700 (PDT)
Date: Fri, 25 Apr 2025 15:21:24 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Christian Loehle <christian.loehle@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sultan Alsawaf <sultan@kerneltoast.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2] cpufreq: Fix setting policy limits when frequency
 tables are used
Message-ID: <aAuMVMQjdEqegT8n@linaro.org>
References: <5896780.DvuYhMxLoT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5896780.DvuYhMxLoT@rjwysocki.net>

On Fri, Apr 25, 2025 at 01:36:21PM +0200, Rafael J. Wysocki wrote:
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

Thanks a lot for the quick fix! It works for me. After the CPU frequency
was throttled due to high temperature and the device has cooled down,
the CPU frequency goes back to maximum again.

Tested-by: Stephan Gerhold <stephan.gerhold@linaro.org>

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

