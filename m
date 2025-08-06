Return-Path: <linux-pm+bounces-31987-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBD9B1C3D7
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 11:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33FC818A75D6
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 09:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BFB24E4D4;
	Wed,  6 Aug 2025 09:55:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D71C189;
	Wed,  6 Aug 2025 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754474148; cv=none; b=VtVLi/kE2KjNXVo63VpMvq4G8lWgmyj9k7IsyLwJHy5hJzg4A8zQwZJMu3tF0NOU8nYObVjU0ZfePVfHQyiqwDrv9l51OSUtS6CGKeUUescjnXX1/l4zpQGgb8vyAxK8U5gfRGADa6PkVz2S+QQnCUJ2ioPIVbd1xr6lfwzdgDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754474148; c=relaxed/simple;
	bh=ogl/6uUxsTmKYlZhaGGPUzfHI6TRbL3GimvYJNfJFhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtWbTKBxbiulBgVU1l4cawJS0UktALUOGSI4/RvIGJIGjK2ThJ/Um2Q3UzcK0VDrTtIKNJXXjL6n+Km9ehdvDHswASEUE4tFVnaMx0XlLKSMg5/fp6CCmq9ZT4t9QEApSVQEliwaTjBDL8ilybjrqnOnpEL6rIv7oazR87AsWGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 585BD1E8D;
	Wed,  6 Aug 2025 02:55:37 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75E0B3F738;
	Wed,  6 Aug 2025 02:55:40 -0700 (PDT)
Date: Wed, 6 Aug 2025 11:55:24 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org,
	viresh.kumar@linaro.org, sudeep.holla@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, vincent.guittot@linaro.org,
	yangyicong@hisilicon.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, yubowen8@huawei.com, linhongye@h-partners.com
Subject: Re: [PATCH v3 3/3] arm64: topology: Setup AMU FIE for online CPUs
 only
Message-ID: <aJMmjKenJaDnRskH@arm.com>
References: <20250805093330.3715444-1-zhenglifeng1@huawei.com>
 <20250805093330.3715444-4-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805093330.3715444-4-zhenglifeng1@huawei.com>

On Tue, Aug 05, 2025 at 05:33:30PM +0800, Lifeng Zheng wrote:
> When boot with maxcpu=1 restrict, and LPI(Low Power Idle States) is on,
> only CPU0 will go online. The support AMU flag of CPU0 will be set but the
> flags of other CPUs will not. This will cause AMU FIE set up fail for CPU0
> when it shares a cpufreq policy with other CPU(s). After that, when other
> CPUs are finally online and the support AMU flags of them are set, they'll
> never have a chance to set up AMU FIE, even though they're eligible.
> 
> To solve this problem, the process of setting up AMU FIE needs to be
> modified as follows:
> 
> 1. Set up AMU FIE only for the online CPUs.
> 
> 2. Try to set up AMU FIE each time a CPU goes online and do the
> freq_counters_valid() check. If this check fails, clear scale freq source
> of all the CPUs related to the same policy, in case they use different
> source of the freq scale.
> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  arch/arm64/kernel/topology.c | 54 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 9317a618bb87..b68621b3c071 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -385,7 +385,7 @@ static int init_amu_fie_callback(struct notifier_block *nb, unsigned long val,
>  	struct cpufreq_policy *policy = data;
>  
>  	if (val == CPUFREQ_CREATE_POLICY)
> -		amu_fie_setup(policy->related_cpus);
> +		amu_fie_setup(policy->cpus);
I think my previous comment still stands.
This will indeed set the AMU FIE support for online cpus.
Still, on each frequency change, arch_set_freq_scale will be called with
`related_cpus`, and that mask will be used to verify support for AMU counters,
and it will report there is none as 'related_cpus' won't be a subset of
`scale_freq_counters_mask`. As a consequence, new scale will be set, as seen by
the cpufreq. Now this will be corrected on next tick but it might cause
disruptions. So this change should also be applied to cpufreq - if feasible, or
at least be proven not to be an issue. Unless I am missing smth.
>  
>  	/*
>  	 * We don't need to handle CPUFREQ_REMOVE_POLICY event as the AMU
> @@ -404,10 +404,60 @@ static struct notifier_block init_amu_fie_notifier = {
>  	.notifier_call = init_amu_fie_callback,
>  };
>  
> +static int cpuhp_topology_online(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy = cpufreq_cpu_get_raw_no_check(cpu);
> +
> +	/*
> +	 * If the online CPUs are not all AMU FIE CPUs or the new one is already
> +	 * an AMU FIE one, no need to set it.
> +	 */
> +	if (!policy || !cpumask_available(amu_fie_cpus) ||
> +	    !cpumask_subset(policy->cpus, amu_fie_cpus) ||
> +	    cpumask_test_cpu(cpu, amu_fie_cpus))
> +		return 0;
This is getting rather cumbersome as the CPU that is coming online might belong
to a policy that is yet to be created. Both AMU FIE support, as well as cpufreq,
rely on dynamic hp state so, in theory, we cannot be certain that the cpufreq
callback will be fired first (although that seems to be the case).
If that does not happen, the policy will not exist, and as such given CPU
will not use AMUs for FIE. The problem might be hypothetical but it at least
deservers a comment I think.
Second problem is cpumask_available use: this might be the very fist CPU that
might potentially rely on AMUs for frequency invariance so that mask may not be
available yet. That does not mean AMUs setup should be skipped. Not just yet,
at least. Again more hypothetical.
BTW, there should be `amu_fie_cpu_supported'.
> +
> +	/*
> +	 * If the new online CPU cannot pass this check, all the CPUs related to
> +	 * the same policy should be clear from amu_fie_cpus mask, otherwise they
> +	 * may use different source of the freq scale.
> +	 */
> +	if (!freq_counters_valid(cpu)) {
> +		topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_ARCH,
> +						 policy->related_cpus);
> +		cpumask_andnot(amu_fie_cpus, amu_fie_cpus, policy->related_cpus);
I think it might deserve a warning as this probably should not happen.

---
BR
Beata
> +		return 0;
> +	}
> +
> +	cpumask_set_cpu(cpu, amu_fie_cpus);
> +
> +	topology_set_scale_freq_source(&amu_sfd, cpumask_of(cpu));
> +
> +	pr_debug("CPU[%u]: counter will be used for FIE.", cpu);
> +
> +	return 0;
> +}
> +
>  static int __init init_amu_fie(void)
>  {
> -	return cpufreq_register_notifier(&init_amu_fie_notifier,
> +	int ret;
> +
> +	ret = cpufreq_register_notifier(&init_amu_fie_notifier,
>  					CPUFREQ_POLICY_NOTIFIER);
> +	if (ret)
> +		return ret;
> +
> +	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> +					"arm64/topology:online",
> +					cpuhp_topology_online,
> +					NULL);
> +	if (ret < 0) {
> +		cpufreq_unregister_notifier(&init_amu_fie_notifier,
> +					    CPUFREQ_POLICY_NOTIFIER);
> +		return ret;
> +	}
> +
> +	return 0;
>  }
>  core_initcall(init_amu_fie);
>  
> -- 
> 2.33.0
> 

