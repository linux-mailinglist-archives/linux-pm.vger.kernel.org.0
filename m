Return-Path: <linux-pm+bounces-30250-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C255AFAEB1
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 10:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 975F5166A99
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 08:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4822727702E;
	Mon,  7 Jul 2025 08:33:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46E0286D49;
	Mon,  7 Jul 2025 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751877190; cv=none; b=U/9wlpfM3B71aQsn8qPkBUBLhTn0lhkDyOtsRw30rG8Vt0iev/ebMCFlD7amIPSTlUW1RCNeylkK8XlUDdFcCbEFs2Q9t0MmdhI8ZGbvyT0nse+OBj2La6VQkoBbg8kzjkfSex4vOlY7E174H96aw41uAPvd43FtfZghgAKJ8RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751877190; c=relaxed/simple;
	bh=dOerYKCIIu0Ldwt7JnAEhthNKLc0cAZQdHOqiQZGC9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQ/i9+gqvu0eiwdgZgYkA9ob/baziMStuJnL4/SVGdDZsUfcg5lAIttJ5GxChy7A1gtGWYn1JMHcsrzLt6x/V58wrtk5JJvnrait86X4v71jdhriAECfB6xYPWoAGKlqN3HUtHvj+vZxFN2ov2zJkE7I0eRSlvaChgE0O4u33Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46956153B;
	Mon,  7 Jul 2025 01:32:54 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 046BB3F6A8;
	Mon,  7 Jul 2025 01:33:02 -0700 (PDT)
Date: Mon, 7 Jul 2025 10:32:46 +0200
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
Message-ID: <aGuGLu2u7iKxR3ul@arm.com>
References: <20250619000925.415528-1-pmalani@google.com>
 <20250619000925.415528-3-pmalani@google.com>
 <ff65b997-eb14-798f-1d2f-c375bf763e71@hisilicon.com>
 <CAFivqm+hjfDwPJCiHavnZSg2D+OaP5xbQnidmwxQ3HD32ic6EA@mail.gmail.com>
 <ef3f933a-742c-9e8e-9da4-762b33f2de94@hisilicon.com>
 <CAFivqmLCW2waDnJ0nGbjBd5gs+w+DeszPKe0be3VRLVu06-Ytg@mail.gmail.com>
 <CAFivqm+D9mbGku-nZKSUEMcQV5XK_ayarxL9gpV5JyfmhirsPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFivqm+D9mbGku-nZKSUEMcQV5XK_ayarxL9gpV5JyfmhirsPw@mail.gmail.com>

Hi Prashant,

On Wed, Jul 02, 2025 at 11:38:11AM -0700, Prashant Malani wrote:
> Hi All,
> 
> Ionela, Beata, could you kindly review ?
> 
> On Fri, 27 Jun 2025 at 10:07, Prashant Malani <pmalani@google.com> wrote:
> >
> > Hi Jie,
> >
> > On Fri, 27 Jun 2025 at 00:55, Jie Zhan <zhanjie9@hisilicon.com> wrote:
> > >
> > >
> > > Hi Prashant,
> > >
> > > Sorry for a late reply as I'm busy on other stuff and this doesn't seem to
> > > be an easy issue to solve.
> > >
> >
> > No worries, the ping was in general to all the people in the thread :)
> >
> > > For the latest kernel, [1] provides a new 'cpuinfo_avg_freq' sysfs file to
> > > reflect the frequency base on AMUs, which is supposed to be more stable.
> > > Though it usually shows 'Resource temporarily unavailable' on my platform
> > > at the moment and looks a bit buggy.
> > >
> > > Most of the related discussions can be found in the reference links in [1].
> > > [1] https://lore.kernel.org/linux-pm/20250131162439.3843071-1-beata.michalska@arm.com/
> > >
> > > As reported, the current frequency sampling method may show an large error
> > > on 1) 100% load, 2) high memory access pressure, 3) idle cpus in your case.
> > >
> > > AFAICS, they may all come from the unstable latency accessing remote AMUs
> > > for 4 times but delaying a fixed 2us sampling window.
> >
> > I tried applying [1] which consolidates the ref and del register reads
> > into 1 IPI, but that did not make a difference. The values still
> > fluctuate wildly.
> >
> > >
> > > Increase the sampling windows seems to help but also increase the time
> > > overhead, so that's not favoured by people.
> > >
> >
> > This experiment did not appear to help in our case. It's a point in
> > the direction that this method is inherently inaccurate during idle
> > situations.
> >
> > > On 20/06/2025 13:07, Prashant Malani wrote:
> > > > Hi Jie,
> > > > On Thu, 19 Jun 2025 at 20:53, Jie Zhan <zhanjie9@hisilicon.com> wrote:
> > > >> On 19/06/2025 08:09, Prashant Malani wrote:
> > > >>> t0: ref=899127636, del=3012458473
> > > >>> t1: ref=899129626, del=3012466509
> > > >>> perf=40
> > > >>
> > > >> In this case, the target cpu is mostly idle but not fully idle during the
> > > >> sampling window since the counter grows a little bit.
> > > >> Perhaps some interrupts happen to run on the cpu shortly.
> > >
> > > Check back here again, I don't think it 'mostly idle'.
> > > Diff of ref counters is around 2000, and I guess the ref counter freq is
> > > 1GHz on your platform?  That's exactly 2us, so the target cpu is mostly
> > > busy.
> 
> I think it is pertinent to note: the actual act of reading the CPPC counters
> will (at least for ACPI_ADR_SPACE_FIXED_HARDWARE counters)
> wake the CPU up, so even if a CPU *was* idle, the reading of the counters
> calls cpc_read_ffh() [1] which does an IPI on the target CPU [2] thus waking
> it up from WFI.
> 
> And that brings us back to the original assertion made in this patch:
> the counter values are quite unreliable when the CPU is in this
> idle (or rather I should correct that to, waking from WFI) state.
>
I'd say that's very platform specific, and as such playing with the delay makes
little sense. I'd need to do more deliberate testing, but I haven't noticed
(yet) any discrepancies in AMU counters on waking up.
Aside, you have mentioned that you've observed the frequency reported to be
above max one (4GHz vs 3.5HZ if I recall correctly) - shouldn't that be clamped
by the driver if the values are outside of supported range ?

Verifying whether the CPU is idle before poking it just to get a counters
reading to derive current frequency from those does feel rather like an
appealing idea. Narrowing the scope for ACPI_ADR_SPACE_FIXED_HARDWARE cases
could be solved by providing a query for the address space. Though I am not an
expert here so would be good to get some input from someone who is
(on both).

---
BR
Beata
> This work around probably hits more types of implementations, but
> I can't see another way to limit it to only ARM FFH. Open to suggestions!
> 
> [1] https://elixir.bootlin.com/linux/v6.15.4/source/arch/arm64/kernel/topology.c#L482
> [2] https://elixir.bootlin.com/linux/v6.15.4/source/arch/arm64/kernel/topology.c#L453

> 
> Best regards,
> 
> -Prashant
> 
> 
> -- 
> -Prashant

