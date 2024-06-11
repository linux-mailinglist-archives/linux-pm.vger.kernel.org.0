Return-Path: <linux-pm+bounces-8929-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1681A903800
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 11:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46921C2314E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 09:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6652E17623D;
	Tue, 11 Jun 2024 09:39:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33E62230F;
	Tue, 11 Jun 2024 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718098769; cv=none; b=T4v35Pu+RsTi10WpTE1KegwiaVsQgXtfrHfUDJ1UAZYSzNAx4S1s3OhkGgt1OcDhAL9ips7fK7hMHyQglfexGraTOrtudrRI/IKb6NQgJeJYx0xonwIQUOKTPsEM2lMxLuuGLTj6g6gpc4lWroeRS9aP0+4eNppWtJ9FqrHFo4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718098769; c=relaxed/simple;
	bh=Uay35M+PyQWH7p9a9tZvDrt3vXUxspGLDHd+2+fDfGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrNtvI0ayOTYZeHtwYZppoWBADvGFjOQHC8m1V19jF0H6RyKb/EGb9GrWxB0IsUY2VxMITVQZymQTrMabptnDK8aPc4FdDrobX7efeDhDsnZhKsVNFWNVP/JRu9I5Rn4QF6ykEU+NKteQRL6X0a+mEehR3XCnjwY0UhSf2fDXq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86B731424;
	Tue, 11 Jun 2024 02:39:44 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.80.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5D063F5A1;
	Tue, 11 Jun 2024 02:39:19 -0700 (PDT)
Date: Tue, 11 Jun 2024 10:39:18 +0100
From: Ionela Voinescu <ionela.voinescu@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "liwei (JK)" <liwei728@huawei.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	rafael@kernel.org, al.stone@linaro.org, ashwin.chaugule@linaro.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	liwei391@huawei.com, liaoyu15@huawei.com
Subject: Re: [PATCH] cpufreq/cppc: changing highest_perf to nominal_perf in
 cppc_cpufreq_cpu_init()
Message-ID: <ZmgbRh+m9MmEaopK@arm.com>
References: <20240428092852.1588188-1-liwei728@huawei.com>
 <20240429104945.esdukn6ayudgyumc@vireshk-i7>
 <ZjoBrF4bAK5ukm7H@arm.com>
 <be312b75-eede-44f5-b7f3-b50f50c6fb56@huawei.com>
 <ZmB1qKucR5fXk100@arm.com>
 <20240606072031.lxr7tykl7sdgjwva@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606072031.lxr7tykl7sdgjwva@vireshk-i7>

Hey,

On Thursday 06 Jun 2024 at 12:50:31 (+0530), Viresh Kumar wrote:
> On 05-06-24, 15:26, Ionela Voinescu wrote:
> > > > > > 		cpufreq_start_governor() // governor: performance
> > > > > > 			new_freq = cpufreq_driver->get() // if new_freq == policy->max
> > > > > > 			if (policy->cur != new_freq)
> > > > > > 			cpufreq_out_of_sync(policy, new_freq)
> > > > > > 				...
> > > > > > 				policy->cur = new_freq
> > > > I believe the problem is here   ^^^^^^^^^^^^^^^^^^^^^^.
> > > > 
> > > > cpufreq_verify_current_freq() should not update policy->cur unless a
> > > > request to change frequency has actually reached the driver. I believe
> > > > policy->cur should always reflect the request, not the actual current
> > > > frequency of the CPU.
> 
> There are times when the core doesn't have any prior information about
> the frequency, for example at driver probe time and resume. And so
> needs to set policy->cur by reading it from the hardware.
> 

Makes sense! But maybe we should no longer update policy->cur to the
current/hardware frequency once a request comes through from a
governor, and we have a first actually requested value.

> > > > Given that new_freq is the current (hardware) frequency of the CPU,
> > > > obtained via .get(), it can be the nominal frequency, as it is in your
> > > > case, or any frequency, if there is any firmware/hardware capping in
> > > > place.
> > > > 
> > > > This causes the issue in your scenario, in which __cpufreq_driver_target()
> > > > filters the request from the governor as it finds it equal to policy->cur,
> > > > and it believes it's already set by hardware.
> 
> I am still not sure why mismatch happens at boot time here.
> 
> > > > This causes another issue in which scaling_cur_freq, which for some
> > > > systems returns policy->cur, ends up returning the hardware frequency of
> > > > the CPUs, and not the last frequency request, as it should:
> > > > 
> > > > "scaling_cur_freq
> > > > Current frequency of all of the CPUs belonging to this policy (in kHz).
> > > > 
> > > > In the majority of cases, this is the frequency of the last P-state
> > > > requested by the scaling driver from the hardware using the scaling
> > > > interface provided by it, which may or may not reflect the frequency
> > > > the CPU is actually running at (due to hardware design and other
> > > > limitations)." [1]
> 
> There is discussion going on about this in another thread [1] now.

Thanks for the contributions to that topic, by the way.

Kind regards,
Ionela.

> 
> > > > Therefore policy->cur gets polluted with the hardware frequency of the
> > > > CPU sampled at that one time, and this affects governor decisions, as
> > > > in your case, and scaling_cur_freq feedback as well. This bad value will
> > > > not change until there's another .target() or cpufreq_out_of_sync()
> > > > call, which will never happen for fixed frequency governors like the
> > > > performance governor.
> 
> --
> viresh
> 
> [1] https://lore.kernel.org/all/20240603081331.3829278-2-beata.michalska@arm.com/

