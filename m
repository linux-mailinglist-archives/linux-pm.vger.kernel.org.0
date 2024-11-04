Return-Path: <linux-pm+bounces-16921-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E1A9BAD92
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 09:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDBF2281E1A
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 08:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D0018DF92;
	Mon,  4 Nov 2024 08:01:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E09817C234;
	Mon,  4 Nov 2024 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730707294; cv=none; b=UTD4Zdy+P/EAED+jHBtdEIROdcSwGTUgUHUyZNSORBgmaJ01bCcof3lbO4JzRp4cHp3ifKFD0ks3rrof9e431xjquatmuQlT1SL2sl6MKB8aKSnA4L/FL5PybjqFscctgTJx/xolj9AexdAXPc4QayMs0attA1crk7jR22eFgxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730707294; c=relaxed/simple;
	bh=q4lZw1U3tgn8WEXKRIWSlw4UsGcOdwEXjlX1STdpofg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VITJs85VK4zaJfGd5/SbMFx7jI4uaiH0PZ6oHcn6MHY6oEcdQGZuTP5U0CacSlIVWbBMtfWIcB4utSy2FO1b3/12mWWj5VC7J69+unG233eeNVMFuDzV9WPcyQig07bDoVRHDxddgjfKIG9amG9b6Fyh6iE0s0qH0Z+g9va5+Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AA39FEC;
	Mon,  4 Nov 2024 00:02:01 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7ED613F6A8;
	Mon,  4 Nov 2024 00:01:28 -0800 (PST)
Date: Mon, 4 Nov 2024 09:01:00 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org,
	catalin.marinas@arm.com, sumitg@nvidia.com,
	yang@os.amperecomputing.com, vanshikonda@os.amperecomputing.com,
	lihuisong@huawei.com, zhanjie9@hisilicon.com
Subject: Re: [PATCH v7 1/4] cpufreq: Introduce an optional cpuinfo_avg_freq
 sysfs entry
Message-ID: <Zyh_PG1lAEC4Q3Hr@arm.com>
References: <20240913132944.1880703-1-beata.michalska@arm.com>
 <20240913132944.1880703-2-beata.michalska@arm.com>
 <20241029070429.m7q5dkumitoyqxq2@vireshk-i7>
 <CAJZ5v0i2KUPXfeAKhkimetOMpx+5opgt26URJF8cstnZsaeZwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0i2KUPXfeAKhkimetOMpx+5opgt26URJF8cstnZsaeZwA@mail.gmail.com>

On Tue, Oct 29, 2024 at 12:31:11PM +0100, Rafael J. Wysocki wrote:
> On Tue, Oct 29, 2024 at 8:04 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Apologies for the delay from my side. September was mostly holidays
> > for me and then I was stuck with other stuff plus email backlog and
> > this series was always a painful point to return to :(
> >
> > On 13-09-24, 14:29, Beata Michalska wrote:
> > > Currently the CPUFreq core exposes two sysfs attributes that can be used
> > > to query current frequency of a given CPU(s): namely cpuinfo_cur_freq
> > > and scaling_cur_freq. Both provide slightly different view on the
> > > subject and they do come with their own drawbacks.
> > >
> > > cpuinfo_cur_freq provides higher precision though at a cost of being
> > > rather expensive. Moreover, the information retrieved via this attribute
> > > is somewhat short lived as frequency can change at any point of time
> > > making it difficult to reason from.
> > >
> > > scaling_cur_freq, on the other hand, tends to be less accurate but then
> > > the actual level of precision (and source of information) varies between
> > > architectures making it a bit ambiguous.
> > >
> > > The new attribute, cpuinfo_avg_freq, is intended to provide more stable,
> > > distinct interface, exposing an average frequency of a given CPU(s), as
> > > reported by the hardware, over a time frame spanning no more than a few
> > > milliseconds. As it requires appropriate hardware support, this
> > > interface is optional.
> >
> > From what I recall, the plan is to:
> > - keep cpuinfo_cur_freq as it is, not expose for x86 and call ->get()
> >   for ARM.
> 
> Yes.
That one indeed remains unchanged.
> 
> > - introduce cpuinfo_avg_freq() and make it return frequency from hw
> >   counters for both ARM and Intel and others who provide the API.
> 
> Yes.
Will add changes for Intel as well.
> 
> > - update scaling_cur_freq() to only return the requested frequency or
> >   error in case of X86
> 
> Yes.
> 
> Preferably, -ENOTSUPP for "setpolicy" drivers without the .get() callback.
Right, my impression was that we want to leave that one as is.
Will add appropriate changes.
> 
> >   and update documentation to reflect the same.
> >   Right now or after some time ? How much time ?
> 
> After some time, I think at least two cycles, so people have the time
> to switch over, but much more may be necessary if someone is stuck
> with RHEL or similar user space.
> 
> Anyway, x86 will be the only one affected and there may be a Kconfig
> option even to allow it to be changed at the kernel build time.
> 
So just for my clarification we want a config switch to control what
scaling_cur_freq is to actually provide. It will keep the current behaviour as
default until we are ready to flip it and ultimately drop that temporary config
option ?
> The documentation for cpuinfo_avg_freq() needs to be added along with it.
That one is already provided unless you have smth else on mind ?
Like updating scaling_cur_freq to reference the new sysfs attribute ?

---
Best Regards
Beata
> 
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index 04fc786dd2c0..3493e5a9500d 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -752,6 +752,16 @@ __weak unsigned int arch_freq_get_on_cpu(int cpu)
> > >       return 0;
> > >  }
> > >
> > > +__weak int arch_freq_avg_get_on_cpu(int cpu)
> > > +{
> > > +     return -EOPNOTSUPP;
> > > +}
> > > +
> > > +static inline bool cpufreq_avg_freq_supported(struct cpufreq_policy *policy)
> > > +{
> > > +     return arch_freq_avg_get_on_cpu(policy->cpu) >= 0;
> > > +}
> >
> > And why aren't we simply reusing arch_freq_get_on_cpu() here ?
> >
> > --
> > viresh

