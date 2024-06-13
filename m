Return-Path: <linux-pm+bounces-9075-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A113F906936
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 11:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B871F220D0
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 09:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598E613D8A1;
	Thu, 13 Jun 2024 09:47:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF21113D50A;
	Thu, 13 Jun 2024 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272073; cv=none; b=XAR1CiVXD0yQk1jvKU0mqzdeEVDutr13Yap3zNJY/2sLn9sbP2CRA3EqxgRD6aKn4JFa0W0qmHy8zLybpFtXiPxKjcbZJteYsGDp7IynwciZA6QQw8t+fV6E/Iry9kH8/7uVJckitkZi7wbeu9/nhSSCzcaXbFIfg4NzN+mdQVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272073; c=relaxed/simple;
	bh=OjTK5cegQGOcdpVtvituVRsKmP3nvixsp1zueeoQnfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnAMKZhq+G18tJdv5WZ8RwKJHHNtad6U8U3NirmmhysXF6OSO1WuETd0HIg8X08B2JNftm95eteYmfxPdNGGgSzI0KqRy7DTQfkx0HGOaspP9yprpmR1x4YtIW2MIwKI864xAi9IX14V6L5cQN/pziNHLqjQIV+gfdkB+g/J7PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 826811063;
	Thu, 13 Jun 2024 02:48:15 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B28CE3F5A1;
	Thu, 13 Jun 2024 02:47:48 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:47:40 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: ionela.voinescu@arm.com, "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	len.brown@intel.com, vanshikonda@os.amperecomputing.com,
	sumitg@nvidia.com, vincent.guittot@linaro.org
Subject: Re: [PATCH 1/1] cpufreq: Rewire arch specific feedback for
 cpuinfo/scaling_cur_freq
Message-ID: <ZmrAPArhRG3tx4zM@arm.com>
References: <20240603081331.3829278-1-beata.michalska@arm.com>
 <20240603081331.3829278-2-beata.michalska@arm.com>
 <20240603114811.oio3uemniib5uaa2@vireshk-i7>
 <CAJZ5v0j1bqhmKrJirw+WgEVDdszZ9xQSgmfazVKMVa8H6_5TSw@mail.gmail.com>
 <20240606085513.pptx5dtjcvvg3zo4@vireshk-i7>
 <CAJZ5v0it5vZvzkbErkGOVruPbkxgr8VMTgQzsncpdQmvCOfBng@mail.gmail.com>
 <20240613082358.yq2lui6vc35xi53t@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240613082358.yq2lui6vc35xi53t@vireshk-i7>

On Thu, Jun 13, 2024 at 01:53:58PM +0530, Viresh Kumar wrote:
> On 07-06-24, 16:21, Rafael J. Wysocki wrote:
> > On Thu, Jun 6, 2024 at 10:55 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > What about this, hopefully this doesn't break any existing platforms
> > > and fix the problems for ARM (and others):
> > >
> > > - scaling_cur_freq:
> > >
> > >   Returns the frequency of the last P-state requested by the scaling
> > >   driver from the hardware.
> > 
> > This would change the behavior for intel_pstate in the passive mode AFAICS.
> > 
> > ATM it calls arch_freq_get_on_cpu(), after the change it would return
> > policy->cur which would not be the same value most of the time.  And
> > in the ->adjust_perf() case policy->cur is not updated by it even.
> 
> Yeah, we would need to do the below part to make it work.
> 
> > >  For set_policy() drivers, use the ->get()
> > >   callback to get a value that can provide the best estimate to user.
> > >
> > >   To make this work, we can add get() callback to intel and amd pstate
> > >   drivers, and use arch_freq_get_on_cpu().
> > >
> > >   This will keep the current behavior intact for such drivers.
> > 
> > Well, the passive mode thing would need to be addressed then.
> 
> Right. So this would keep the behavior of the file as is for all platforms and
> simplify the core.
> 
> > > - cpuinfo_cur_freq:
> > >
> > >   Currently this file is available only if the get() callback is
> > >   available. Maybe we can keep this behavior as is, and expose this
> > >   now for both the pstate drivers (once above change is added). We
> > >   will be left with only one driver that doesn't provide the get()
> > >   callback: pasemi-cpufreq.c
> > 
> > I would rather get rid of it completely.
> 
> cpuinfo_cur_freq itself ? I thought such changes aren't allowed as they may end
> up breaking userspace tools.
> 
> > >   Coming back to the implementation of the file read operation, I
> > >   think the whole purpose of arch_freq_get_on_cpu() was to get a
> > >   better estimate (which may not be perfect) of the frequency the
> > >   hardware is really running at (in the last window) and if a platform
> > >   provides this, then it can be given priority over the ->get()
> > >   callback in order to show the value to userspace.
> > 
> > There was a reason to add it and it was related to policy->cur being
> > meaningless on x86 in general (even in the acpi-cpufreq case), but
> > let's not go there.
> 
> Right.
> 
> > Hooking this up to cpuinfo_cur_freq on x86 wouldn't make much sense
> > IMV because at times it is not even close to the frequency the
> > hardware is running at.  It comes from the previous tick period,
> > basically, and the hardware can adjust the frequency with a resolution
> > that is orders of magnitude higher than the tick rate.
> 
> Hmm. If that is the concern (which looks valid), how come it makes sense to do
> the same on ARM ? Beata, Ionela ?
>
The arch_freq_get_on_cpu that is using AMU counters on ARM is also bound to
a tick - this is still the average over a tick period.
Now it is not exactly current frequency as seen by hardware but gives a good
estimate as of what is happening under the hood.
I guess the question would be: what is the use of instant read on hw freq for
userspace tools if, as mentioned already, the freq can change at any point of
time so it is rather cumbersome to reason about. Once the userspace gets that
info it might be no longer valid. 
> I thought, just like X86, ARM also doesn't have a guaranteed way to know the
> exact frequency anymore and AMUs are providing a better picture, and so we are
> moving to the same.
It is very platform specific - and even if there is a way to get a feedback on
every freq change - again what userspace is supposed to do when it gets stale
data?

---
BR
Beata
> 
> If we don't want it for X86, then it can be done with help of a new driver flag
> CPUFREQ_NO_CPUINFO_SCALING_FREQ, instead of the availability of the get()
> callback.
> 
> > Well, this sounds nice, but the changes are a bit problematic.
> > 
> > If you don't want 3 files, I'd drop cpuinfo_cur_freq and introduce
> > something else to replace it which will expose the
> > arch_freq_get_on_cpu() return value and will be documented
> > accordingly.
> 
> Well it is still meaningful to show the return value of the ->get() callback
> where the hardware provides it.
> 
> > Then scaling_cur_freq can be (over time) switched over to returning
> > policy->cur in the cases when it is meaningful and -ENODATA otherwise.
> > 
> > This would at least allow us to stop making up stuff.
> 
> Maybe a third file, just for arch_freq_get_on_cpu() is not that bad of an idea
> :)
> 
> -- 
> viresh

