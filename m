Return-Path: <linux-pm+bounces-32703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB945B2D829
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 11:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20CBA01068
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 09:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D78D2DE1E6;
	Wed, 20 Aug 2025 09:21:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976E92DAFA9;
	Wed, 20 Aug 2025 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681713; cv=none; b=C45PzP2GP/Y/7o9GXXtEFoMP6D80mF11wo708LUZPBC1WhCYwgcpDiD9ZbcybzI9SspIo0N5Ac4kapPvMO7BfCPQ2zoXnfe2Uo6jLRulxhEHdNy4NQZWMAJvC2bZZ1b5jLUNAcUIxAPQEi6aOZjhEPSow7ejuZHkXjgI9BkJ73c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681713; c=relaxed/simple;
	bh=LP7Gyt4nxQbTfBodentLk9vM/oxSIKnDsTMwgqFCLN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUY+cuvm2pQCyGwhxHdb84j1SuDBa5qPWYpaexmNIid0ZMydU6otAyGH1k2GG8y0N2vNhQV2pL9ZWJU4wp9cetzxNzKWbg4u2HdBNys83DqhNlePxJVv7TnmC9O8X0IaA5iNufkPbFSYxuKeSbXBS1hyrRMy9Ld5t3Hlggxo46w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9579F152B;
	Wed, 20 Aug 2025 02:21:41 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 185663F58B;
	Wed, 20 Aug 2025 02:21:43 -0700 (PDT)
Date: Wed, 20 Aug 2025 11:21:23 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org,
	viresh.kumar@linaro.org, sudeep.holla@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, vincent.guittot@linaro.org,
	yangyicong@hisilicon.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, yubowen8@huawei.com, zhangpengjie2@huawei.com,
	linhongye@h-partners.com
Subject: Re: [PATCH v5 3/3] arm64: topology: Setup AMU FIE for online CPUs
 only
Message-ID: <aKWTk5dfZysd_8ks@arm.com>
References: <20250819072931.1647431-1-zhenglifeng1@huawei.com>
 <20250819072931.1647431-4-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819072931.1647431-4-zhenglifeng1@huawei.com>

The commit title does read a bit wrong I think.
It does not really reflect the change for supporting cpu hotplug.
Maybe smth along the lines of:
	arm64: topology: Handle AMU FIE setup on CPU hotplug
?

On Tue, Aug 19, 2025 at 03:29:31PM +0800, Lifeng Zheng wrote:
> When boot with maxcpu=1 restrict, and LPI(Low Power Idle States) is on,
So actually it is `maxcpus` to start with, Not sure what LPI has to do with any
of that ?
It might be better to slightly reword the whole commit message.
The problem is with CPUs being offline at the time the cpufreq policy is being
created so it might be with maxcpus != nr_cpus , or because cpu bring-up
failed, or due to RAS event that caused the cpu to go offline, etc.
How about:

"When a cpufreq policy is created, AMU FIE setup currently verifies all
CPUs in the policy, regardless of whether they are online. If any of
those CPUs are offline, their AMU capability flag is not yet verified, and
the check fails. As a result, AMU FIE is not enabled even if the CPUs
that are online do support it.

Later, when the offline CPUs eventually come online and advertise AMU
support, they have no opportunity to re-enable AMU FIE for the policy,
leaving the whole frequency domain without AMU FIE despite being
eligible.

Restrict the initial AMU FIE check to the CPUs that are online at the
time the policy is created, and allow CPUs brought online later to join
the policy with AMU FIE enabled."

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
> At the same time, this change also be applied to cpufreq when calling
> arch_set_freq_scale.
Could we clarify that a bit ? Reads a bit ambiguous.

> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  arch/arm64/kernel/topology.c | 54 ++++++++++++++++++++++++++++++++++--
>  drivers/cpufreq/cpufreq.c    |  4 +--
>  2 files changed, 54 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 9317a618bb87..a9d9e9969cea 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -385,7 +385,7 @@ static int init_amu_fie_callback(struct notifier_block *nb, unsigned long val,
>  	struct cpufreq_policy *policy = data;
>  
>  	if (val == CPUFREQ_CREATE_POLICY)
> -		amu_fie_setup(policy->related_cpus);
> +		amu_fie_setup(policy->cpus);
>  
>  	/*
>  	 * We don't need to handle CPUFREQ_REMOVE_POLICY event as the AMU
> @@ -404,10 +404,60 @@ static struct notifier_block init_amu_fie_notifier = {
>  	.notifier_call = init_amu_fie_callback,
>  };
>  
> +static int cpuhp_topology_online(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy = cpufreq_cpu_policy(cpu);
> +
> +	/*
> +	 * If the online CPUs are not all AMU FIE CPUs or the new one is already
> +	 * an AMU FIE one, no need to set it.
> +	 */
> +	if (!policy || !cpumask_available(amu_fie_cpus) ||
> +	    !cpumask_subset(policy->cpus, amu_fie_cpus) ||
> +	    cpumask_test_cpu(cpu, amu_fie_cpus))
> +		return 0;
I believe this can be slightly optimised and made more ... readable, i.e:

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index a9d9e9969cea..2d6ce34af8e4 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -408,15 +408,25 @@ static int cpuhp_topology_online(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_policy(cpu);
 
+	/* Those are cheap checks */
+
 	/*
-	 * If the online CPUs are not all AMU FIE CPUs or the new one is already
-	 * an AMU FIE one, no need to set it.
+	 * Skip this CPU if:
+	 *  - it has no cpufreq policy assigned yet,
+	 *  - no policy exists that spans CPUs with AMU counters, or
+	 *  - it was already handled.
 	 */
-	if (!policy || !cpumask_available(amu_fie_cpus) ||
-	    !cpumask_subset(policy->cpus, amu_fie_cpus) ||
+	if (unlikely(!policy || !cpumask_available(amu_fie_cpus)) ||
 	    cpumask_test_cpu(cpu, amu_fie_cpus))
 		return 0;
 
+	/*
+	 * Only proceed if all already-online CPUs in this policy
+	 * support AMU counters.
+	 */
+	if (unlikely(!cpumask_subset(policy->cpus, amu_fie_cpus)))
+		return 0;
+
 	/*
 	 * If the new online CPU cannot pass this check, all the CPUs related to
 	 * the same policy should be clear from amu_fie_cpus mask, otherwise they


---
BR
Beata

> +
> +	/*
> +	 * If the new online CPU cannot pass this check, all the CPUs related to
> +	 * the same policy should be clear from amu_fie_cpus mask, otherwise they
> +	 * may use different source of the freq scale.
> +	 */
> +	if (WARN_ON(!freq_counters_valid(cpu))) {
> +		topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_ARCH,
> +						 policy->related_cpus);
> +		cpumask_andnot(amu_fie_cpus, amu_fie_cpus, policy->related_cpus);
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
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 78ca68ea754d..d1890a2af1af 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -417,7 +417,7 @@ void cpufreq_freq_transition_end(struct cpufreq_policy *policy,
>  
>  	cpufreq_notify_post_transition(policy, freqs, transition_failed);
>  
> -	arch_set_freq_scale(policy->related_cpus,
> +	arch_set_freq_scale(policy->cpus,
>  			    policy->cur,
>  			    arch_scale_freq_ref(policy->cpu));
>  
> @@ -2219,7 +2219,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>  		return 0;
>  
>  	policy->cur = freq;
> -	arch_set_freq_scale(policy->related_cpus, freq,
> +	arch_set_freq_scale(policy->cpus, freq,
>  			    arch_scale_freq_ref(policy->cpu));
>  	cpufreq_stats_record_transition(policy, freq);
>  
> -- 
> 2.33.0
> 

