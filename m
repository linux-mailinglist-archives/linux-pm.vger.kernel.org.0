Return-Path: <linux-pm+bounces-30777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94439B03AD8
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 11:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EEF67ACE94
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 09:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C9223C518;
	Mon, 14 Jul 2025 09:31:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B29C1C831A;
	Mon, 14 Jul 2025 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752485470; cv=none; b=Tl5ee0V3X/dRpM5rwEG6uRodlt10JstPGsuc2w6brD8SfrykZge5nOLI/HtTt2FU5PyTYXf5wYw9WayOo5fN8G9kFAwEmK4mZnEVsODayLUjud32ahIWb1dkXgD1/KAqUk4wV3wYo1jdTz8zI1PsINoCAl7nz102CCmjF3edP3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752485470; c=relaxed/simple;
	bh=CAV5eH90W2TTjeN+Jc9+5pYhbnK9Yx/gii7tAtBTe8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xk8mQHc9NQWnyFxHokGasYlnW5qV91LEC3Lcd9eDYM2b5JkUNhzZ8LnqWLrBh7snQmd18YitvwK+EH3JYeqgs4mIuAQ3SEvHUu6ZTMAItRXzbA3jjlX/SvU+5mF2JuMfJyeLLg6LtUuFqfaKWqtIWX0bYVVtnrOOsZydNBq4qPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36E3A1BC0;
	Mon, 14 Jul 2025 02:30:59 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CBDF3F694;
	Mon, 14 Jul 2025 02:31:02 -0700 (PDT)
Date: Mon, 14 Jul 2025 11:30:51 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Prashant Malani <pmalani@google.com>
Cc: Jie Zhan <zhanjie9@hisilicon.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	z00813676 <zhenglifeng1@huawei.com>
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
Message-ID: <aHTOSyhwIAaW_1m1@arm.com>
References: <20250619000925.415528-1-pmalani@google.com>
 <20250619000925.415528-3-pmalani@google.com>
 <ff65b997-eb14-798f-1d2f-c375bf763e71@hisilicon.com>
 <CAFivqm+hjfDwPJCiHavnZSg2D+OaP5xbQnidmwxQ3HD32ic6EA@mail.gmail.com>
 <ef3f933a-742c-9e8e-9da4-762b33f2de94@hisilicon.com>
 <CAFivqmLCW2waDnJ0nGbjBd5gs+w+DeszPKe0be3VRLVu06-Ytg@mail.gmail.com>
 <CAFivqm+D9mbGku-nZKSUEMcQV5XK_ayarxL9gpV5JyfmhirsPw@mail.gmail.com>
 <aGuGLu2u7iKxR3ul@arm.com>
 <CAFivqmJL90xsELhz4tPtkYA9vMzS9C=V__nwo=kWJKjKS=mE_Q@mail.gmail.com>
 <CAFivqmKBgYVa6JUh82TS2pO915PUDYZMH+k-5=-0u1-K9-gMMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFivqmKBgYVa6JUh82TS2pO915PUDYZMH+k-5=-0u1-K9-gMMw@mail.gmail.com>

On Wed, Jul 09, 2025 at 03:49:03PM -0700, Prashant Malani wrote:
> On Wed, 9 Jul 2025 at 10:25, Prashant Malani <pmalani@google.com> wrote:
> >
> > Hi Beata,
> >
> > Thanks for taking a look.
> >
> > On Mon, 7 Jul 2025 at 01:33, Beata Michalska <beata.michalska@arm.com> wrote:
> > >
> > > Hi Prashant,
> > >
> > > On Wed, Jul 02, 2025 at 11:38:11AM -0700, Prashant Malani wrote:
> > > > Hi All,
> > > >
> > > > Ionela, Beata, could you kindly review ?
> > > >
> > > > On Fri, 27 Jun 2025 at 10:07, Prashant Malani <pmalani@google.com> wrote:
> > > > >
> > > >
> > > > I think it is pertinent to note: the actual act of reading the CPPC counters
> > > > will (at least for ACPI_ADR_SPACE_FIXED_HARDWARE counters)
> > > > wake the CPU up, so even if a CPU *was* idle, the reading of the counters
> > > > calls cpc_read_ffh() [1] which does an IPI on the target CPU [2] thus waking
> > > > it up from WFI.
> > > >
> > > > And that brings us back to the original assertion made in this patch:
> > > > the counter values are quite unreliable when the CPU is in this
> > > > idle (or rather I should correct that to, waking from WFI) state.
> > > >
> > > I'd say that's very platform specific, and as such playing with the delay makes
> > > little sense. I'd need to do more deliberate testing, but I haven't noticed
> > > (yet) any discrepancies in AMU counters on waking up.
> > > Aside, you have mentioned that you've observed the frequency reported to be
> > > above max one (4GHz vs 3.5HZ if I recall correctly) - shouldn't that be clamped
> > > by the driver if the values are outside of supported range ?
> > >
> > > Verifying whether the CPU is idle before poking it just to get a counters
> > > reading to derive current frequency from those does feel rather like an
> > > appealing idea.
> >
> > That's good to hear. What can we do to refine this series further?
So I believe this should be handled in CPUFreq core, if at all.
Would be good to get an input/opinion from the maintainers: Viresh and Rafael.
> >
> > > Narrowing the scope for ACPI_ADR_SPACE_FIXED_HARDWARE cases
> > > could be solved by providing a query for the address space. Though I am not an
> > > expert here so would be good to get some input from someone who is
> > > (on both).
> >
> > Who would be the expert here (are they on this mailing list)?
Probably as above + Sudeep Holla
> >
> > Could you point me to an example for the query for the address space? Then
> > I can respin this series to use that query and narrow the scope.
>
Actually was suggesting adding one.
> Actually, if the idea of this optimization (the idle_cpu check) sounds
> good to you,
> I don't see why we should limit it to ACPI_ADR_SPACE_FIXED_HARDWARE.
> IOW, the patch can remain in its current form.
> 
Right, that does need though verifying against all users.

In the meantime ....
It seems that the issue of getting counters on a CPU that is idle is not
in the counters themselves, but in the way how they are being read - at least
from what I can observe.
The first read experience longer delay between reading core and const counters,
and as const one is read as a second one, it misses some increments (within
calculated delta). So, what we could do within the driver is either:
- Add a way to request reading both counters in a single cpc_read (preferable
  I guess, though I would have to have a closer look at that)
- Add some logic that would make sure the reads are not far apart

Would you be able to verify that on your end?

---
BR
Beata
> Best regards,
> 
> -- 
> -Prashant

