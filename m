Return-Path: <linux-pm+bounces-16920-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD7A9BAD90
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 09:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA211C21278
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 08:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACDF1AAE01;
	Mon,  4 Nov 2024 08:00:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D80D1A76CE;
	Mon,  4 Nov 2024 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730707234; cv=none; b=KccaBwCfnohmY5cUYUZST++DLcZwm1BSupiHMK3WFl+VRuBYbr0tWaKevh4PLWTVaa/R0mo37UDie4EFxhOetSktDiUMqB8W2Ii3cL88FXXssGbjccjJM+eulunUpVCI4OOXngMEoYvMyn15coUP7oWkqOmL1tjl8ArrqL2hI+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730707234; c=relaxed/simple;
	bh=fwqwuIcmUdxsD8dz+GsxzWQ47SZiWrWx2zOOvvyqhOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adCzmHH4yJaB5JKcHeLJ0c31BYTpkJ5jLO+ask2bgQT8/j8mSJGpNkP0NUpsWAet1KFnXJPORRoNDMhEtKrDdi4nX9x8o31ziz7Gj1TMXedoZiESYmABGN6sErk7R+wRO19V6G38IxIxFgJZ97tZ2frBDzURO8Vox7pp+VJLUpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF54DFEC;
	Mon,  4 Nov 2024 00:01:00 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5B2A3F6A8;
	Mon,  4 Nov 2024 00:00:27 -0800 (PST)
Date: Mon, 4 Nov 2024 09:00:00 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
	sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
	rafael@kernel.org, sumitg@nvidia.com, yang@os.amperecomputing.com,
	vanshikonda@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com
Subject: Re: [PATCH v7 1/4] cpufreq: Introduce an optional cpuinfo_avg_freq
 sysfs entry
Message-ID: <Zyh_ACbOkSsjcPX3@arm.com>
References: <20240913132944.1880703-1-beata.michalska@arm.com>
 <20240913132944.1880703-2-beata.michalska@arm.com>
 <20241029070429.m7q5dkumitoyqxq2@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029070429.m7q5dkumitoyqxq2@vireshk-i7>

On Tue, Oct 29, 2024 at 12:34:29PM +0530, Viresh Kumar wrote:
> Apologies for the delay from my side. September was mostly holidays
> for me and then I was stuck with other stuff plus email backlog and
> this series was always a painful point to return to :(
Thanks for getting back to me on this one!
> 
> On 13-09-24, 14:29, Beata Michalska wrote:
> > Currently the CPUFreq core exposes two sysfs attributes that can be used
> > to query current frequency of a given CPU(s): namely cpuinfo_cur_freq
> > and scaling_cur_freq. Both provide slightly different view on the
> > subject and they do come with their own drawbacks.
> > 
> > cpuinfo_cur_freq provides higher precision though at a cost of being
> > rather expensive. Moreover, the information retrieved via this attribute
> > is somewhat short lived as frequency can change at any point of time
> > making it difficult to reason from.
> > 
> > scaling_cur_freq, on the other hand, tends to be less accurate but then
> > the actual level of precision (and source of information) varies between
> > architectures making it a bit ambiguous.
> > 
> > The new attribute, cpuinfo_avg_freq, is intended to provide more stable,
> > distinct interface, exposing an average frequency of a given CPU(s), as
> > reported by the hardware, over a time frame spanning no more than a few
> > milliseconds. As it requires appropriate hardware support, this
> > interface is optional.
> 
> From what I recall, the plan is to:
> - keep cpuinfo_cur_freq as it is, not expose for x86 and call ->get()
>   for ARM.
> 
> - introduce cpuinfo_avg_freq() and make it return frequency from hw
>   counters for both ARM and Intel and others who provide the API.
> 
> - update scaling_cur_freq() to only return the requested frequency or
>   error in case of X86 and update documentation to reflect the same.
>   Right now or after some time ? How much time ?
> 
>   Rafael ?
>
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 04fc786dd2c0..3493e5a9500d 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -752,6 +752,16 @@ __weak unsigned int arch_freq_get_on_cpu(int cpu)
> >  	return 0;
> >  }
> >  
> > +__weak int arch_freq_avg_get_on_cpu(int cpu)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +static inline bool cpufreq_avg_freq_supported(struct cpufreq_policy *policy)
> > +{
> > +	return arch_freq_avg_get_on_cpu(policy->cpu) >= 0;
> > +}
> 
> And why aren't we simply reusing arch_freq_get_on_cpu() here ?
We need a way to discover whether the new sysfs attrib is to be enabled or not.
I guess I could change the signature for arch_freq_get_on_cpu to return an error
if that functionality is not supported for given policy ?

---
Best Regards
Beata
> 
> -- 
> viresh

