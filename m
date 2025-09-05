Return-Path: <linux-pm+bounces-33922-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAC1B44FC0
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 09:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206D0566429
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 07:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A820B258CE9;
	Fri,  5 Sep 2025 07:31:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542F61DDC37;
	Fri,  5 Sep 2025 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757057504; cv=none; b=OfQcMvauc+Sz9U5K5YB8F6xlq/19iGol1tjg1MJtSC4y9QQuuPwMDIOdKw4NwOvzaYOgwyZ0wzfdXjwRriqHa00QOr9sULFURHdZgOSs47Q5R2pQxtplROXzZ5Jol+tMRGIQ/CR0mRMoYrYZn8ll6VFy2YFnhSkeCFKGSoqlc6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757057504; c=relaxed/simple;
	bh=SIar4/Kvq+I3ow73z4ohTECl2lfAyH8RFhr48ecQQaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkGX06O0w2qMhTOJkKKaZJLR/uh2qqME1xtyfb6DyV2ZYp88dKHTfr+HdpmaXl9eM4YsR4Z6Z0dmR+gI2RTPjAiPA0w7kEpdQNLt0+JjyQLWaAAlBxidNyL5Q4/UomredSXzcWJAuebNeuQ9vX4yhncoTnOAD42sTLcRWHUKZu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5207153B;
	Fri,  5 Sep 2025 00:31:32 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1747E3F694;
	Fri,  5 Sep 2025 00:31:36 -0700 (PDT)
Date: Fri, 5 Sep 2025 09:31:03 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>, catalin.marinas@arm.com,
	will@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
	sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com, jonathan.cameron@huawei.com,
	vincent.guittot@linaro.org, yangyicong@hisilicon.com,
	zhanjie9@hisilicon.com, lihuisong@huawei.com, yubowen8@huawei.com,
	zhangpengjie2@huawei.com, linhongye@h-partners.com
Subject: Re: [PATCH v5 3/3] arm64: topology: Setup AMU FIE for online CPUs
 only
Message-ID: <aLqRt0K2-UH8cOcI@arm.com>
References: <20250819072931.1647431-1-zhenglifeng1@huawei.com>
 <20250819072931.1647431-4-zhenglifeng1@huawei.com>
 <aLVJdy3M1NRBR5LF@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLVJdy3M1NRBR5LF@arm.com>

Hi Ionela,
On Mon, Sep 01, 2025 at 08:29:26AM +0100, Ionela Voinescu wrote:
> Hi,
> 
> On Tuesday 19 Aug 2025 at 15:29:31 (+0800), Lifeng Zheng wrote:
> > When boot with maxcpu=1 restrict, and LPI(Low Power Idle States) is on,
> > only CPU0 will go online. The support AMU flag of CPU0 will be set but the
> > flags of other CPUs will not. This will cause AMU FIE set up fail for CPU0
> > when it shares a cpufreq policy with other CPU(s). After that, when other
> > CPUs are finally online and the support AMU flags of them are set, they'll
> > never have a chance to set up AMU FIE, even though they're eligible.
> > 
> > To solve this problem, the process of setting up AMU FIE needs to be
> > modified as follows:
> > 
> > 1. Set up AMU FIE only for the online CPUs.
> > 
> > 2. Try to set up AMU FIE each time a CPU goes online and do the
> > freq_counters_valid() check. If this check fails, clear scale freq source
> > of all the CPUs related to the same policy, in case they use different
> > source of the freq scale.
> > 
> > At the same time, this change also be applied to cpufreq when calling
> > arch_set_freq_scale.
> > 
> > Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> > ---
> >  arch/arm64/kernel/topology.c | 54 ++++++++++++++++++++++++++++++++++--
> >  drivers/cpufreq/cpufreq.c    |  4 +--
> >  2 files changed, 54 insertions(+), 4 deletions(-)
> > 
> [..]
> >  
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 78ca68ea754d..d1890a2af1af 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -417,7 +417,7 @@ void cpufreq_freq_transition_end(struct cpufreq_policy *policy,
> >  
> >  	cpufreq_notify_post_transition(policy, freqs, transition_failed);
> >  
> > -	arch_set_freq_scale(policy->related_cpus,
> > +	arch_set_freq_scale(policy->cpus,
> >  			    policy->cur,
> >  			    arch_scale_freq_ref(policy->cpu));
> >  
> > @@ -2219,7 +2219,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> >  		return 0;
> >  
> >  	policy->cur = freq;
> > -	arch_set_freq_scale(policy->related_cpus, freq,
> > +	arch_set_freq_scale(policy->cpus, freq,
> >  			    arch_scale_freq_ref(policy->cpu));
> 
> I think it might be good to keep these calls to arch_set_freq_scale() for
> all related CPUs and not only online ones. This can result in CPUs coming
> out of hotplug with a wrong scale factor, because while they were out, any
> frequency transitions of the policy only modified the scale factor of
> online CPUs. When they come out of hotplug, arch_set_freq_scale() will not
> be called for them until there's a new frequency transition.
> 
> I understand that if this is not changed to only pass online CPUs,
> supports_scale_freq_counters() will now fail when called in
> topology_set_freq_scale() for scenarios when only some CPUs in a policy
> are online - e.g. the scenario in your commit message. But I think a
> simple change in supports_scale_freq_counters() that instead checks that
> at least one CPU in the policy supports AMU-based FIE, instead of all,
> is a better fix that does not break the cpufreq-based FIE. If at least
> one CPU is marked as supporting AMUs for FIE we know that the AMU setup
> path is in progress and we should bail out of
> topology_set_freq_scale()/arch_set_freq_scale(). 
> 

Thank you for pointing that out - that indeed might be an issue, and the
solution you have suggested should do the trick.

---
BR
Beata

> Hope it helps,
> Ionela.
> 
> >  	cpufreq_stats_record_transition(policy, freq);
> >  
> > -- 
> > 2.33.0
> > 
> > 

