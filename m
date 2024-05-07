Return-Path: <linux-pm+bounces-7573-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9122B8BDF9F
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 12:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F531C22F58
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 10:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA32914EC57;
	Tue,  7 May 2024 10:25:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A483214E2DE;
	Tue,  7 May 2024 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077552; cv=none; b=b2oNOT80CNykLTFD5PbWH/0jn6RIpItsc5kk1QQBx2EfwR4ZOcppAP1gPZynN+k2IIfuzmOyVFzmrD3QYT3Yy1822lTLqp40xSDnxeCU+b3LGdYlpZmR5LHr9uuL473DPjMKJdSKkbA9+GTvlafinpma0Y2Bj/6VyC/kyyugxKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077552; c=relaxed/simple;
	bh=XOj366TPRt2uSSw//lAyqbR2em7cRTX0TeQlf1mrSGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0geyW70/Nq/BKKdGxAOAxNrE28Y7Ysrp+1YorAAuZEXBDnpRdM5/C97QymVEcXZP54INrIbdr4AukffUduTgN3zwxn4F9GWhV6hc7MHEDudzOhaZL/o8BUjPN/laYKCccKQY1mM2pXR2vCLiwabYzpf5O9l7VYnjebLBoqxakw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D4881063;
	Tue,  7 May 2024 03:26:16 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.80.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A67933F587;
	Tue,  7 May 2024 03:25:49 -0700 (PDT)
Date: Tue, 7 May 2024 11:25:48 +0100
From: Ionela Voinescu <ionela.voinescu@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: liwei <liwei728@huawei.com>, Beata Michalska <beata.michalska@arm.com>,
	Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	rafael@kernel.org, al.stone@linaro.org, ashwin.chaugule@linaro.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	liwei391@huawei.com, liaoyu15@huawei.com
Subject: Re: [PATCH] cpufreq/cppc: changing highest_perf to nominal_perf in
 cppc_cpufreq_cpu_init()
Message-ID: <ZjoBrF4bAK5ukm7H@arm.com>
References: <20240428092852.1588188-1-liwei728@huawei.com>
 <20240429104945.esdukn6ayudgyumc@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429104945.esdukn6ayudgyumc@vireshk-i7>

Hi,

Thanks for adding me to this.

On Monday 29 Apr 2024 at 16:19:45 (+0530), Viresh Kumar wrote:
> CC'ing few folks who are working with the driver.
> 
> On 28-04-24, 17:28, liwei wrote:
> > When turning on turbo, if frequency configuration takes effect slowly,
> > the updated policy->cur may be equal to the frequency configured in
> > governor->limits(), performance governor will not adjust the frequency,
> > configured frequency will remain at turbo-freq.
> > 
> > Simplified call stack looks as follows:
> > cpufreq_register_driver(&cppc_cpufreq_driver)
> > 	...
> > 	cppc_cpufreq_cpu_init()
> > 		cppc_get_perf_caps()
> > 		policy->max = cppc_perf_to_khz(caps, caps->nominal_perf)
> > 			cppc_set_perf(highest_perf) // set highest_perf
> > 			policy->cur = cpufreq_driver->get() // if cur == policy->max
> > 	cpufreq_init_policy()
> > 		...
> > 		cpufreq_start_governor() // governor: performance
> > 			new_freq = cpufreq_driver->get() // if new_freq == policy->max
> > 			if (policy->cur != new_freq)
> > 			cpufreq_out_of_sync(policy, new_freq)
> > 				...
> > 				policy->cur = new_freq
I believe the problem is here   ^^^^^^^^^^^^^^^^^^^^^^.

cpufreq_verify_current_freq() should not update policy->cur unless a
request to change frequency has actually reached the driver. I believe
policy->cur should always reflect the request, not the actual current
frequency of the CPU.

Given that new_freq is the current (hardware) frequency of the CPU,
obtained via .get(), it can be the nominal frequency, as it is in your
case, or any frequency, if there is any firmware/hardware capping in
place.

This causes the issue in your scenario, in which __cpufreq_driver_target()
filters the request from the governor as it finds it equal to policy->cur,
and it believes it's already set by hardware.

This causes another issue in which scaling_cur_freq, which for some
systems returns policy->cur, ends up returning the hardware frequency of
the CPUs, and not the last frequency request, as it should:

"scaling_cur_freq
Current frequency of all of the CPUs belonging to this policy (in kHz).

In the majority of cases, this is the frequency of the last P-state
requested by the scaling driver from the hardware using the scaling
interface provided by it, which may or may not reflect the frequency
the CPU is actually running at (due to hardware design and other
limitations)." [1]

Therefore policy->cur gets polluted with the hardware frequency of the
CPU sampled at that one time, and this affects governor decisions, as
in your case, and scaling_cur_freq feedback as well. This bad value will
not change until there's another .target() or cpufreq_out_of_sync()
call, which will never happen for fixed frequency governors like the
performance governor.

Thanks,
Ionela.


[1] https://docs.kernel.org/admin-guide/pm/cpufreq.html

> > 			...
> > 			policy->governor->limits()
> > 				__cpufreq_driver_target(policy->max)
> > 					if (policy->cur==target)
> > 					// generate error, keep set highest_perf
> > 						ret
> > 					cppc_set_perf(target)
> > 
> > Fix this by changing highest_perf to nominal_perf in cppc_cpufreq_cpu_init().
> > 
> > Fixes: 5477fb3bd1e8 ("ACPI / CPPC: Add a CPUFreq driver for use with CPPC")
> > Signed-off-by: liwei <liwei728@huawei.com>
> > ---
> >  drivers/cpufreq/cppc_cpufreq.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > index 64420d9cfd1e..db04a82b8a97 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -669,14 +669,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
> >  	if (caps->highest_perf > caps->nominal_perf)
> >  		boost_supported = true;
> >  
> > -	/* Set policy->cur to max now. The governors will adjust later. */
> > -	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
> > -	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
> > +	/* Set policy->cur to norm now. */
> > +	policy->cur = cppc_perf_to_khz(caps, caps->nominal_perf);
> > +	cpu_data->perf_ctrls.desired_perf =  caps->nominal_perf;
> >  
> >  	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> >  	if (ret) {
> >  		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
> > -			 caps->highest_perf, cpu, ret);
> > +			 caps->nominal_perf, cpu, ret);
> >  		goto out;
> >  	}
> >  
> > -- 
> > 2.25.1
> 
> -- 
> viresh

