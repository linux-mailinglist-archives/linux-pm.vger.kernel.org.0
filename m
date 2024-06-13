Return-Path: <linux-pm+bounces-9076-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8859990696D
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 11:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC101C23166
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 09:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761061411CC;
	Thu, 13 Jun 2024 09:55:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5032414039A;
	Thu, 13 Jun 2024 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272516; cv=none; b=kLg6EliKiAcVwhf/XKrmcs3qkMWQNYcW3TQq2SRK6McSMk02L9LR4zMuQhFU6Dj9zfKGuwN0qs8uOXjKh2fJL7FF0e2akDCQ4XBZI66jFQXzvlhAF3O/ATUzAkVyjveUO8MaAr1Xb8Zd//orH/ShXEi6au2y1PS9HZALESk2c4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272516; c=relaxed/simple;
	bh=3e92B1eVt9vTMbGDST7vZ+wtr7b9AXBKBsq0dXvWRfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOZL9iXqQ9WeX9MMo+E6ViyH0Jhmmgh1cyqpd0aydDOvm1VaeC5fM1ZrXnjjNb1RdNuXzvn9xmXv+DgE0ljBf1MSjZV1LXaB+YXmiWGE4TZaSSmvfcaT56lFFFoQZ98T5I9/5esEk73mZVbs0/EMVEoDOj02MBPkY8LMZN+m6Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 449571063;
	Thu, 13 Jun 2024 02:55:38 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 703353F5A1;
	Thu, 13 Jun 2024 02:55:11 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:55:08 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, ionela.voinescu@arm.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	len.brown@intel.com, vanshikonda@os.amperecomputing.com,
	sumitg@nvidia.com, vincent.guittot@linaro.org
Subject: Re: [PATCH 1/1] cpufreq: Rewire arch specific feedback for
 cpuinfo/scaling_cur_freq
Message-ID: <ZmrB_DqtmVpvG30l@arm.com>
References: <20240603081331.3829278-1-beata.michalska@arm.com>
 <20240603081331.3829278-2-beata.michalska@arm.com>
 <20240603114811.oio3uemniib5uaa2@vireshk-i7>
 <CAJZ5v0j1bqhmKrJirw+WgEVDdszZ9xQSgmfazVKMVa8H6_5TSw@mail.gmail.com>
 <20240606085513.pptx5dtjcvvg3zo4@vireshk-i7>
 <CAJZ5v0it5vZvzkbErkGOVruPbkxgr8VMTgQzsncpdQmvCOfBng@mail.gmail.com>
 <20240613082358.yq2lui6vc35xi53t@vireshk-i7>
 <CAJZ5v0iOvpx=YtPtbM9RPaVh2n4+T=r91bM7OZt5k8q0Tzmk+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iOvpx=YtPtbM9RPaVh2n4+T=r91bM7OZt5k8q0Tzmk+w@mail.gmail.com>

On Thu, Jun 13, 2024 at 11:27:52AM +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 13, 2024 at 10:24 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 07-06-24, 16:21, Rafael J. Wysocki wrote:
> > > On Thu, Jun 6, 2024 at 10:55 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > What about this, hopefully this doesn't break any existing platforms
> > > > and fix the problems for ARM (and others):
> > > >
> > > > - scaling_cur_freq:
> > > >
> > > >   Returns the frequency of the last P-state requested by the scaling
> > > >   driver from the hardware.
> > >
> > > This would change the behavior for intel_pstate in the passive mode AFAICS.
> > >
> > > ATM it calls arch_freq_get_on_cpu(), after the change it would return
> > > policy->cur which would not be the same value most of the time.  And
> > > in the ->adjust_perf() case policy->cur is not updated by it even.
> >
> > Yeah, we would need to do the below part to make it work.
> >
> > > >  For set_policy() drivers, use the ->get()
> > > >   callback to get a value that can provide the best estimate to user.
> > > >
> > > >   To make this work, we can add get() callback to intel and amd pstate
> > > >   drivers, and use arch_freq_get_on_cpu().
> > > >
> > > >   This will keep the current behavior intact for such drivers.
> > >
> > > Well, the passive mode thing would need to be addressed then.
> >
> > Right. So this would keep the behavior of the file as is for all platforms and
> > simplify the core.
> >
> > > > - cpuinfo_cur_freq:
> > > >
> > > >   Currently this file is available only if the get() callback is
> > > >   available. Maybe we can keep this behavior as is, and expose this
> > > >   now for both the pstate drivers (once above change is added). We
> > > >   will be left with only one driver that doesn't provide the get()
> > > >   callback: pasemi-cpufreq.c
> > >
> > > I would rather get rid of it completely.
> >
> > cpuinfo_cur_freq itself ? I thought such changes aren't allowed as they may end
> > up breaking userspace tools.
> 
> cpuinfo_cur_freq is not always present anyway, so user space tools
> need to be able to cope with the lack of it anyway.
>
> > > >   Coming back to the implementation of the file read operation, I
> > > >   think the whole purpose of arch_freq_get_on_cpu() was to get a
> > > >   better estimate (which may not be perfect) of the frequency the
> > > >   hardware is really running at (in the last window) and if a platform
> > > >   provides this, then it can be given priority over the ->get()
> > > >   callback in order to show the value to userspace.
> > >
> > > There was a reason to add it and it was related to policy->cur being
> > > meaningless on x86 in general (even in the acpi-cpufreq case), but
> > > let's not go there.
> >
> > Right.
> >
> > > Hooking this up to cpuinfo_cur_freq on x86 wouldn't make much sense
> > > IMV because at times it is not even close to the frequency the
> > > hardware is running at.  It comes from the previous tick period,
> > > basically, and the hardware can adjust the frequency with a resolution
> > > that is orders of magnitude higher than the tick rate.
> >
> > Hmm. If that is the concern (which looks valid), how come it makes sense to do
> > the same on ARM ? Beata, Ionela ?
> >
> > I thought, just like X86, ARM also doesn't have a guaranteed way to know the
> > exact frequency anymore and AMUs are providing a better picture, and so we are
> > moving to the same.
> >
> > If we don't want it for X86, then it can be done with help of a new driver flag
> > CPUFREQ_NO_CPUINFO_SCALING_FREQ, instead of the availability of the get()
> > callback.
> >
> > > Well, this sounds nice, but the changes are a bit problematic.
> > >
> > > If you don't want 3 files, I'd drop cpuinfo_cur_freq and introduce
> > > something else to replace it which will expose the
> > > arch_freq_get_on_cpu() return value and will be documented
> > > accordingly.
> >
> > Well it is still meaningful to show the return value of the ->get() callback
> > where the hardware provides it.
> 
> But this is a valid point.
> 
> > > Then scaling_cur_freq can be (over time) switched over to returning
> > > policy->cur in the cases when it is meaningful and -ENODATA otherwise.
> > >
> > > This would at least allow us to stop making up stuff.
> >
> > Maybe a third file, just for arch_freq_get_on_cpu() is not that bad of an idea
> > :)
> 
> /me thinks so.
I am starting to lean towards that option.
Making both cpuinfo_cur_freq and scaling_cur_freq sane, might create even more
confusion as per which is providing what. We are already in a rather tricky
situation. The interface should be clean, leaving no room for various
interpretations - as much as possible, of course.

---
BR
Beata

