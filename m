Return-Path: <linux-pm+bounces-8651-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0D38FD0D0
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 16:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1EF29078F
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 14:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479731BC59;
	Wed,  5 Jun 2024 14:26:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B6E2232A;
	Wed,  5 Jun 2024 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717597613; cv=none; b=q/nb82RDriTnoWtvfIaAUqaFj128voB/vDcemyhz3nmPWu8ELiOFYojhWBsetjKy3S4fp5yzE8gPseShXbIsxBtlTwPSl7//hwafZ1JZzZVnebf7Slcgh16fPsXRVwG8WRTk2tdZap6GZDbZuie8HPTKyVwVT8dN9b9xpRzoRxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717597613; c=relaxed/simple;
	bh=X0481Qyu0SAywl4VJKM/mkw0HUGfQx0Ts30P/vuKVZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aha6dFwlC6uq8/WE7/bcSzxEZuqZJnGJZWbqrgvIjl+JjaPDQ6+lU/iB9QA8orrJ+w5s91vyubUezqEtEPvRdApd5usYw1B1U0+cuwbc048nKGnQNMuuXCH6nBfKm0poACcjtJFxcfttDn4SZMctyZy4J/vG691siqkgG5lgLQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F2BE339;
	Wed,  5 Jun 2024 07:27:14 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.80.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFBC03F792;
	Wed,  5 Jun 2024 07:26:49 -0700 (PDT)
Date: Wed, 5 Jun 2024 15:26:48 +0100
From: Ionela Voinescu <ionela.voinescu@arm.com>
To: "liwei (JK)" <liwei728@huawei.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Beata Michalska <beata.michalska@arm.com>,
	Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	rafael@kernel.org, al.stone@linaro.org, ashwin.chaugule@linaro.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	liwei391@huawei.com, liaoyu15@huawei.com
Subject: Re: [PATCH] cpufreq/cppc: changing highest_perf to nominal_perf in
 cppc_cpufreq_cpu_init()
Message-ID: <ZmB1qKucR5fXk100@arm.com>
References: <20240428092852.1588188-1-liwei728@huawei.com>
 <20240429104945.esdukn6ayudgyumc@vireshk-i7>
 <ZjoBrF4bAK5ukm7H@arm.com>
 <be312b75-eede-44f5-b7f3-b50f50c6fb56@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be312b75-eede-44f5-b7f3-b50f50c6fb56@huawei.com>

Hi,

On Friday 10 May 2024 at 11:06:50 (+0800), liwei (JK) wrote:
> Hello,
> 
> Thanks for for your reply.
> 
> Maybe my description has caused you some misunderstandings, please allow me
> to supplement the description
> 
> 在 2024/5/7 18:25, Ionela Voinescu 写道:
> > Hi,
> > 
> > Thanks for adding me to this.
> > 
> > On Monday 29 Apr 2024 at 16:19:45 (+0530), Viresh Kumar wrote:
> > > CC'ing few folks who are working with the driver.
> > > 
> > > On 28-04-24, 17:28, liwei wrote:
> > > > When turning on turbo, if frequency configuration takes effect slowly,
> > > > the updated policy->cur may be equal to the frequency configured in
> > > > governor->limits(), performance governor will not adjust the frequency,
> > > > configured frequency will remain at turbo-freq.
> > > > 
> > > > Simplified call stack looks as follows:
> > > > cpufreq_register_driver(&cppc_cpufreq_driver)
> > > > 	...
> > > > 	cppc_cpufreq_cpu_init()
> > > > 		cppc_get_perf_caps()
> > > > 		policy->max = cppc_perf_to_khz(caps, caps->nominal_perf)
> > > > 			cppc_set_perf(highest_perf) // set highest_perf
> > > > 			policy->cur = cpufreq_driver->get() // if cur == policy->max
> > > > 	cpufreq_init_policy()
> > > > 		...
> > > > 		cpufreq_start_governor() // governor: performance
> > > > 			new_freq = cpufreq_driver->get() // if new_freq == policy->max
> > > > 			if (policy->cur != new_freq)
> > > > 			cpufreq_out_of_sync(policy, new_freq)
> > > > 				...
> > > > 				policy->cur = new_freq
> > I believe the problem is here   ^^^^^^^^^^^^^^^^^^^^^^.
> > 
> > cpufreq_verify_current_freq() should not update policy->cur unless a
> > request to change frequency has actually reached the driver. I believe
> > policy->cur should always reflect the request, not the actual current
> > frequency of the CPU.
> > 
> > Given that new_freq is the current (hardware) frequency of the CPU,
> > obtained via .get(), it can be the nominal frequency, as it is in your
> > case, or any frequency, if there is any firmware/hardware capping in
> > place.
> > 
> > This causes the issue in your scenario, in which __cpufreq_driver_target()
> > filters the request from the governor as it finds it equal to policy->cur,
> > and it believes it's already set by hardware.
> > 
> > This causes another issue in which scaling_cur_freq, which for some
> > systems returns policy->cur, ends up returning the hardware frequency of
> > the CPUs, and not the last frequency request, as it should:
> > 
> > "scaling_cur_freq
> > Current frequency of all of the CPUs belonging to this policy (in kHz).
> > 
> > In the majority of cases, this is the frequency of the last P-state
> > requested by the scaling driver from the hardware using the scaling
> > interface provided by it, which may or may not reflect the frequency
> > the CPU is actually running at (due to hardware design and other
> > limitations)." [1]
> > 
> > Therefore policy->cur gets polluted with the hardware frequency of the
> > CPU sampled at that one time, and this affects governor decisions, as
> > in your case, and scaling_cur_freq feedback as well. This bad value will
> > not change until there's another .target() or cpufreq_out_of_sync()
> > call, which will never happen for fixed frequency governors like the
> > performance governor.
> > 
> > Thanks,
> > Ionela.
> > 
> 
> In the above function calling process, the frequency is obtained twice. The
> first time is in cpufreq_online(), and the second time is in
> cpufreq_verify_current_freq().
> 
> When the frequency configuration takes effect slowly, the kernel cannot
> sense when the frequency configuration takes effect. It may take effect
> before the frequency is read twice, between the frequencies read twice, or
> after the frequency is read twice.
> 
> |------------------|--------------------|---------------------|
> set highest_freq  get()               get()                target()
> 
> If it takes effect before two read operations, there will be no problem.
> 
> If it takes effect between two read operations, policy->cur will be updated
> in cpufreq_verify_current_freq(), the execution path is as follows:
> new_freq = cpufreq_driver->get() //  new_freq = turbo_freq
> 	if (policy->cur != new_freq)
> 		cpufreq_out_of_sync(policy, new_freq)
> 			...
> 			policy->cur = new_freq // cur = turbo_freq
> ...
> __cpufreq_driver_target(policy->max)
> 	cppc_set_perf(target) // policy->cur!=target
> 
> Reconfigure frequency to policy->max.
> 
> If policy->cur is not set to turbo_freq after two read operations,
> policy->cur will not be updated in cpufreq_verify_current_freq(), the
> execution path is as follows:
> new_freq = cpufreq_driver->get() //  new_freq == policy->cur
> 	if (policy->cur != new_freq)
> ...
> __cpufreq_driver_target(policy->max)
> 	ret // policy->cur==target
> 
> Configured frequency will remain at turbo-freq.
> 
> When reading scaling_cur_freq, the frequency value that may be read is
> policy->cur. If arch does not implement arch_freq_get_on_cpu(), and the
> registered cpufreq_driver does not define setpolicy()/get(), the frequency
> will not be obtained through the get() and will directly feed back
> policy->cur. If the above problem occurs, no exception will be detected when
> reading scaling_cur_freq. But reading cpuinfo_cur_freq will reacquire the
> frequency through the get() interface and feedback the newly acquired
> frequency value.

Thank you for the details. I did understand the problem, but I believe
the underlying cause is cpufreq_out_of_sync() setting policy->cur to the
current frequency and not keeping the value of the last frequency
request.

@Viresh, do you happen to know the reason behind this?

There are multiple issues caused by this, detailed at [1] (your patch),
[2] (the other issue described by me above), and more recently [3].

I agree that your code is a good fix for [1] and [3] is a fix for both
[2] and [3], if I'm not mistaken, but to me these are "tweaks" that
bypass the fundamental issue in the cpufreq core and I would not be
surprised to see other issues in the future caused by this, and not
covered by the fixes at [1] and [3].

This being said, I would like to see these issues fixed, even by [1] and
[3], if fixing the underlying cause is not feasible (or at least not
easy to evaluate).

[1] https://lore.kernel.org/lkml/20240428092852.1588188-1-liwei728@huawei.com/
[2] https://lore.kernel.org/lkml/3e6077bb-907c-057f-0896-d0a5814a4229@nvidia.com/
[3] https://lore.kernel.org/lkml/TYCP286MB2486B1D734F8E2D74BFBEEB1B1F32@TYCP286MB2486.JPNP286.PROD.OUTLOOK.COM/

Hope it helps,
Ionela.

> 
> Thanks
> liwei
> 
> > 
> > [1] https://docs.kernel.org/admin-guide/pm/cpufreq.html
> > 
> > > > 			...
> > > > 			policy->governor->limits()
> > > > 				__cpufreq_driver_target(policy->max)
> > > > 					if (policy->cur==target)
> > > > 					// generate error, keep set highest_perf
> > > > 						ret
> > > > 					cppc_set_perf(target)
> > > > 
> > > > Fix this by changing highest_perf to nominal_perf in cppc_cpufreq_cpu_init().
> > > > 
> > > > Fixes: 5477fb3bd1e8 ("ACPI / CPPC: Add a CPUFreq driver for use with CPPC")
> > > > Signed-off-by: liwei <liwei728@huawei.com>
> > > > ---
> > > >   drivers/cpufreq/cppc_cpufreq.c | 8 ++++----
> > > >   1 file changed, 4 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > > > index 64420d9cfd1e..db04a82b8a97 100644
> > > > --- a/drivers/cpufreq/cppc_cpufreq.c
> > > > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > > > @@ -669,14 +669,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
> > > >   	if (caps->highest_perf > caps->nominal_perf)
> > > >   		boost_supported = true;
> > > > -	/* Set policy->cur to max now. The governors will adjust later. */
> > > > -	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
> > > > -	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
> > > > +	/* Set policy->cur to norm now. */
> > > > +	policy->cur = cppc_perf_to_khz(caps, caps->nominal_perf);
> > > > +	cpu_data->perf_ctrls.desired_perf =  caps->nominal_perf;
> > > >   	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> > > >   	if (ret) {
> > > >   		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
> > > > -			 caps->highest_perf, cpu, ret);
> > > > +			 caps->nominal_perf, cpu, ret);
> > > >   		goto out;
> > > >   	}
> > > > -- 
> > > > 2.25.1
> > > 
> > > -- 
> > > viresh

