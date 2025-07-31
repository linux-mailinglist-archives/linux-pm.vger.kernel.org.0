Return-Path: <linux-pm+bounces-31671-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE840B16D7B
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 10:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42ED47B2E19
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 08:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF7528D8C9;
	Thu, 31 Jul 2025 08:27:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450D5241670;
	Thu, 31 Jul 2025 08:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753950456; cv=none; b=UDxrPy4+uppyv43xfo25oBI+BSRTE+WULbww9jCBI40zQPWSem0TSD+N1MNdssnBq5XStYbgIP6/XspQqWGkJWBho4nmKWuVSymYQgbdUh5ohXpRN66T1pv43nMZwUSLIzZp/Tlt/e4QA96s6wEUywLfjnM+VmsFL45THqPM2nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753950456; c=relaxed/simple;
	bh=yLy/Zm8uXdbE14z5VArUhJNLLkG0ebEbV3OslirLnjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKU8yVxuCOfP6cm6Zh6yuAl7sOOPZWjt7h35coh7rkkdVwWX7JTJl2LwuTlAODRSQUXm1rh83C4xFO6bwPf2y68VR9uXQxgQVJLMRlWRSvpFo05KWsq2SyiY1CKUUowodPh3KRjYhq4RA3ByHPV6cF7Zi2g4FYcNRlL5AcpzqAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DE621D13;
	Thu, 31 Jul 2025 01:27:26 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D29453F673;
	Thu, 31 Jul 2025 01:27:29 -0700 (PDT)
Date: Thu, 31 Jul 2025 10:27:14 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Prashant Malani <pmalani@google.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
Message-ID: <aIso4kLtChiQkBjH@arm.com>
References: <aGuGLu2u7iKxR3ul@arm.com>
 <CAFivqmJL90xsELhz4tPtkYA9vMzS9C=V__nwo=kWJKjKS=mE_Q@mail.gmail.com>
 <CAFivqmKBgYVa6JUh82TS2pO915PUDYZMH+k-5=-0u1-K9-gMMw@mail.gmail.com>
 <aHTOSyhwIAaW_1m1@arm.com>
 <CAFivqmJ912sEdSih_DFkiWRm478XUJhNDe=s2M_UO2gVTu4e3w@mail.gmail.com>
 <CAJZ5v0irG16e2cM_tX_UeEJVmB_EdUvk-4Nv36dXoUS=Ud3U5A@mail.gmail.com>
 <CAFivqmLoDv_pWdmBG8ws-CMUBXcb9bS1TgMaxW9YZMqqHpRSyA@mail.gmail.com>
 <20250722032727.zmdwj6ztitkmr4pf@vireshk-i7>
 <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
 <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com>

On Wed, Jul 30, 2025 at 12:31:33AM -0700, Prashant Malani wrote:
> Sorry for restarting this thread, but I think the solution submitted
> solves the write path. The read path still needs addressing.
> 
> As such, given the limitations and scheduler uncertainties
> around the reads of the FFH registers, I think the patch in this
> thread is still a good optimization to include; namely, if we know
> the CPU is idle, don't bother trying to wake up that CPU just to
> calculate frequency.
> 
I am still wondering whether cpufreq core is not a better suited place for
checking whether the CPU is idle. We could potentially try on anther CPU within
the policy and if there is none, just provide the last known freq ?

@Viresh: What are your thoughts on that ?

In the meantime I'm still trying to figure out smht to mitigate the issues with
the numbers we get from counters after waking up the CPU.

---
BR
Beata
> 
> On Mon, 21 Jul 2025 at 23:02, Prashant Malani <pmalani@google.com> wrote:
> >
> > Hi Viresh and Rafael,
> >
> > Thank you for taking the time to look at this series.
> >
> > On Mon, 21 Jul 2025 at 20:27, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 21-07-25, 12:40, Prashant Malani wrote:
> > > > On Mon, 21 Jul 2025 at 10:00, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > Why don't you flag the driver as CPUFREQ_NEED_UPDATE_LIMITS?
> > > > >
> > > > > That would kind of make sense given how the driver works overall, or
> > > > > am I missing anything?
> > >
> > > +1
> >
> > Thanks, I posted [1] which implements what's suggested by Rafael. PTAL
> >
> > Best regards,
> >
> > [1] https://lore.kernel.org/linux-pm/20250722055611.130574-2-pmalani@google.com/
> >
> > --
> > -Prashant
> 
> 
> 
> -- 
> -Prashant

