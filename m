Return-Path: <linux-pm+bounces-32261-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A651B2480E
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 13:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7188801D2
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 11:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595DD2EFDA9;
	Wed, 13 Aug 2025 11:08:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369AC223DDA;
	Wed, 13 Aug 2025 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083333; cv=none; b=AJmHg9jeeWIBcc5/2n4wGmYWJac1uzkhFVfrmNnXn1j3TEYwxFG/I1bvAq25Rz0bqIaKVZLBcd6kJFz1EgKU7wVepq6EktZ9pfeE3KMIfV+Y/0UEygE6qGq54m97EISXSWKcM1fSoiOwUjgGP0IPUxolOyoGCe66Y7+tV8CVUp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083333; c=relaxed/simple;
	bh=Tghr+izcpOpnCTi3ya2m5rAl6XyJW8sYrLp6lPffUiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcVIB0+gXC9cGR7ho/sZauw8s5giT1TW9rR3wNuADioTvIRjgdNFBts/ST1lxNdK3uTdlZGyVdrej0WHH3IlPMVCfoA623sA4skDLDMObESU0u+AYGeO4fU6R6afWhijWPPoejBp2S06bY6OeCuTtgeZy1JhuvQ0kSsOLq0nSSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6224A12FC;
	Wed, 13 Aug 2025 04:08:42 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5C013F738;
	Wed, 13 Aug 2025 04:08:46 -0700 (PDT)
Date: Wed, 13 Aug 2025 13:08:31 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org,
	viresh.kumar@linaro.org, sudeep.holla@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, vincent.guittot@linaro.org,
	yangyicong@hisilicon.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, yubowen8@huawei.com, linhongye@h-partners.com
Subject: Re: [PATCH v3 3/3] arm64: topology: Setup AMU FIE for online CPUs
 only
Message-ID: <aJxyL1XJu-x3AFjO@arm.com>
References: <20250805093330.3715444-1-zhenglifeng1@huawei.com>
 <20250805093330.3715444-4-zhenglifeng1@huawei.com>
 <aJMmjKenJaDnRskH@arm.com>
 <561a9474-7be6-4c8a-8a5d-40efb186b3d2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <561a9474-7be6-4c8a-8a5d-40efb186b3d2@huawei.com>

On Wed, Aug 13, 2025 at 06:17:54PM +0800, zhenglifeng (A) wrote:
> On 2025/8/6 17:55, Beata Michalska wrote:
> 
> > On Tue, Aug 05, 2025 at 05:33:30PM +0800, Lifeng Zheng wrote:
> >> When boot with maxcpu=1 restrict, and LPI(Low Power Idle States) is on,
> >> only CPU0 will go online. The support AMU flag of CPU0 will be set but the
> >> flags of other CPUs will not. This will cause AMU FIE set up fail for CPU0
> >> when it shares a cpufreq policy with other CPU(s). After that, when other
> >> CPUs are finally online and the support AMU flags of them are set, they'll
> >> never have a chance to set up AMU FIE, even though they're eligible.
> >>
> >> To solve this problem, the process of setting up AMU FIE needs to be
> >> modified as follows:
> >>
> >> 1. Set up AMU FIE only for the online CPUs.
> >>
> >> 2. Try to set up AMU FIE each time a CPU goes online and do the
> >> freq_counters_valid() check. If this check fails, clear scale freq source
> >> of all the CPUs related to the same policy, in case they use different
> >> source of the freq scale.
> >>
> >> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> >> ---
> >>  arch/arm64/kernel/topology.c | 54 ++++++++++++++++++++++++++++++++++--
> >>  1 file changed, 52 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> >> index 9317a618bb87..b68621b3c071 100644
> >> --- a/arch/arm64/kernel/topology.c
> >> +++ b/arch/arm64/kernel/topology.c
> >> @@ -385,7 +385,7 @@ static int init_amu_fie_callback(struct notifier_block *nb, unsigned long val,
> >>  	struct cpufreq_policy *policy = data;
> >>  
> >>  	if (val == CPUFREQ_CREATE_POLICY)
> >> -		amu_fie_setup(policy->related_cpus);
> >> +		amu_fie_setup(policy->cpus);
> > I think my previous comment still stands.
> > This will indeed set the AMU FIE support for online cpus.
> > Still, on each frequency change, arch_set_freq_scale will be called with
> > `related_cpus`, and that mask will be used to verify support for AMU counters,
> > and it will report there is none as 'related_cpus' won't be a subset of
> > `scale_freq_counters_mask`. As a consequence, new scale will be set, as seen by
> > the cpufreq. Now this will be corrected on next tick but it might cause
> > disruptions. So this change should also be applied to cpufreq - if feasible, or
> > at least be proven not to be an issue. Unless I am missing smth.
> 
> I know what you mean now. Yes, I think you are right, this change should
> also be applied to cpufreq too. Thanks!
> 
> >>  
> >>  	/*
> >>  	 * We don't need to handle CPUFREQ_REMOVE_POLICY event as the AMU
> >> @@ -404,10 +404,60 @@ static struct notifier_block init_amu_fie_notifier = {
> >>  	.notifier_call = init_amu_fie_callback,
> >>  };
> >>  
> >> +static int cpuhp_topology_online(unsigned int cpu)
> >> +{
> >> +	struct cpufreq_policy *policy = cpufreq_cpu_get_raw_no_check(cpu);
> >> +
> >> +	/*
> >> +	 * If the online CPUs are not all AMU FIE CPUs or the new one is already
> >> +	 * an AMU FIE one, no need to set it.
> >> +	 */
> >> +	if (!policy || !cpumask_available(amu_fie_cpus) ||
> >> +	    !cpumask_subset(policy->cpus, amu_fie_cpus) ||
> >> +	    cpumask_test_cpu(cpu, amu_fie_cpus))
> >> +		return 0;
> > This is getting rather cumbersome as the CPU that is coming online might belong
> > to a policy that is yet to be created. Both AMU FIE support, as well as cpufreq,
> > rely on dynamic hp state so, in theory, we cannot be certain that the cpufreq
> > callback will be fired first (although that seems to be the case).
> > If that does not happen, the policy will not exist, and as such given CPU
> > will not use AMUs for FIE. The problem might be hypothetical but it at least
> > deservers a comment I think.
> 
> Actually, this callback will always be fired before the cpufreq one,
> because init_amu_fie() is called before any cpufreq driver init func (It
> has to be, otherwise the init_amu_fie_notifier cannot be registered before
> it is needed.). And the callback that is setup first will be called first
> when online if rely on dynamic hp state. So in your hypothetical scenario,
> yes, the policy will not exist and this funcion will do nothing. But that's
> OK because the notifier callback will do what should be done when the
> policy is being created.
>
You are right, I definitely drifted away too much with this one.
> > Second problem is cpumask_available use: this might be the very fist CPU that
> > might potentially rely on AMUs for frequency invariance so that mask may not be
> > available yet. That does not mean AMUs setup should be skipped. Not just yet,
> > at least. Again more hypothetical.
> 
> Same, things will be done in the notifier callback when the policy is being
> created.
> 
> > BTW, there should be `amu_fie_cpu_supported'.
> 
> Sorry, I can't see why it is needed. Could you explained further?
It covers the 'cpumask_available' and `cpumask_test_cpu` so I was thinking
your condition could look like:

	if (!policy || amu_fie_cpu_supported(cpu) ||
	    !cpumask_subset(policy->cpus, amu_fie_cpus)
	    	return 0
but that one will not cover all cases so feel free to ignore me.


---
BR
Beata
> 
> >> +
> >> +	/*
> >> +	 * If the new online CPU cannot pass this check, all the CPUs related to
> >> +	 * the same policy should be clear from amu_fie_cpus mask, otherwise they
> >> +	 * may use different source of the freq scale.
> >> +	 */
> >> +	if (!freq_counters_valid(cpu)) {
> >> +		topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_ARCH,
> >> +						 policy->related_cpus);
> >> +		cpumask_andnot(amu_fie_cpus, amu_fie_cpus, policy->related_cpus);
> > I think it might deserve a warning as this probably should not happen.
> 
> Yes, makes sense. Thanks!
> 
> > 
> > ---
> > BR
> > Beata
> >> +		return 0;
> >> +	}
> >> +
> >> +	cpumask_set_cpu(cpu, amu_fie_cpus);
> >> +
> >> +	topology_set_scale_freq_source(&amu_sfd, cpumask_of(cpu));
> >> +
> >> +	pr_debug("CPU[%u]: counter will be used for FIE.", cpu);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  static int __init init_amu_fie(void)
> >>  {
> >> -	return cpufreq_register_notifier(&init_amu_fie_notifier,
> >> +	int ret;
> >> +
> >> +	ret = cpufreq_register_notifier(&init_amu_fie_notifier,
> >>  					CPUFREQ_POLICY_NOTIFIER);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> >> +					"arm64/topology:online",
> >> +					cpuhp_topology_online,
> >> +					NULL);
> >> +	if (ret < 0) {
> >> +		cpufreq_unregister_notifier(&init_amu_fie_notifier,
> >> +					    CPUFREQ_POLICY_NOTIFIER);
> >> +		return ret;
> >> +	}
> >> +
> >> +	return 0;
> >>  }
> >>  core_initcall(init_amu_fie);
> >>  
> >> -- 
> >> 2.33.0
> >>
> > 
> 

