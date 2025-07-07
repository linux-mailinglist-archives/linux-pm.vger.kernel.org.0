Return-Path: <linux-pm+bounces-30251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58348AFAEB8
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 10:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D42A7A2086
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 08:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D24028A1D8;
	Mon,  7 Jul 2025 08:35:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B73286880;
	Mon,  7 Jul 2025 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751877347; cv=none; b=l1o4i01l6PD6XeuJyQn4lX1rPJAltoWmKyngzsPttYgkuQXcL60i65C2O0usLhMXA3r7iX/+0gImC5NFlvXwPULlpSwBpx67A6aOP/zXzFy9wRXActdSCP0EtRZ4SRjet1exyHvjxE65tbkk7KExCSVI1P7xNIiGkQVCab4KHMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751877347; c=relaxed/simple;
	bh=aCW3py4LC/FhSwrb7dWFXORC15iko6Ud2YCiD3w7Y8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KV0H+9P7gBs+FLiZYSAMDSTt11qhVaRgWpgdhIboUsFjCJ5/y1E110VVxTF7WoRswi9L9bu8PazYk/wOjs7vBVJ0bgrQmGX2w1c1j+CE3CEj9wWwTO7Zvw15pgA8GdZ9h3qDffyjmFDH7ylWWPWElSCrOKv77kvAGwNFdVwDTW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62C011595;
	Mon,  7 Jul 2025 01:35:32 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21BE13F6A8;
	Mon,  7 Jul 2025 01:35:40 -0700 (PDT)
Date: Mon, 7 Jul 2025 10:35:37 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: Prashant Malani <pmalani@google.com>, Ben Segall <bsegall@google.com>,
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
	Ionela Voinescu <ionela.voinescu@arm.com>,
	z00813676 <zhenglifeng1@huawei.com>
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
Message-ID: <aGuG2ayA23ojsUix@arm.com>
References: <20250619000925.415528-1-pmalani@google.com>
 <20250619000925.415528-3-pmalani@google.com>
 <ff65b997-eb14-798f-1d2f-c375bf763e71@hisilicon.com>
 <CAFivqm+hjfDwPJCiHavnZSg2D+OaP5xbQnidmwxQ3HD32ic6EA@mail.gmail.com>
 <ef3f933a-742c-9e8e-9da4-762b33f2de94@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef3f933a-742c-9e8e-9da4-762b33f2de94@hisilicon.com>

On Fri, Jun 27, 2025 at 03:54:59PM +0800, Jie Zhan wrote:
> 
> Hi Prashant,
> 
> Sorry for a late reply as I'm busy on other stuff and this doesn't seem to
> be an easy issue to solve.
> 
> I may provide some thoughts but probably need more time to go through the
> history and come up with a good solution.
>  
> Actually, the inaccuracy of cppc_cpufreq_get_rate() has been reported and
> discussed many times.  I believe your issue is just one of the cases.
> 
> For the latest kernel, [1] provides a new 'cpuinfo_avg_freq' sysfs file to
> reflect the frequency base on AMUs, which is supposed to be more stable.
> Though it usually shows 'Resource temporarily unavailable' on my platform
> at the moment and looks a bit buggy.
>
I'd say that would mean the CPU for which the 'cpuinfo_avg_freq' is queried is
mostly idle. If that is not the case then I guess it is 'buggy' and should be
fixed, so more details would be appreciated.

---
BR
Beata
> Most of the related discussions can be found in the reference links in [1].
> [1] https://lore.kernel.org/linux-pm/20250131162439.3843071-1-beata.michalska@arm.com/
> 
> As reported, the current frequency sampling method may show an large error
> on 1) 100% load, 2) high memory access pressure, 3) idle cpus in your case.
> 
> AFAICS, they may all come from the unstable latency accessing remote AMUs
> for 4 times but delaying a fixed 2us sampling window.
> 
> Increase the sampling windows seems to help but also increase the time
> overhead, so that's not favoured by people.
> 
> On 20/06/2025 13:07, Prashant Malani wrote:
> > Hi Jie,
> > 
> > Thanks for taking a look at the patch.
> > 
> > On Thu, 19 Jun 2025 at 20:53, Jie Zhan <zhanjie9@hisilicon.com> wrote:
> >> On 19/06/2025 08:09, Prashant Malani wrote:
> >>> AMU performance counters tend to be inaccurate when measured on idle CPUs.
> >>> On an idle CPU which is programmed to 3.4 GHz (verified through firmware),
> >>> here is a measurement and calculation of operating frequency:
> >>>
> >>> t0: ref=899127636, del=3012458473
> >>> t1: ref=899129626, del=3012466509
> >>> perf=40
> >>
> >> In this case, the target cpu is mostly idle but not fully idle during the
> >> sampling window since the counter grows a little bit.
> >> Perhaps some interrupts happen to run on the cpu shortly.
> 
> Check back here again, I don't think it 'mostly idle'.
> Diff of ref counters is around 2000, and I guess the ref counter freq is
> 1GHz on your platform?  That's exactly 2us, so the target cpu is mostly
> busy.
> 
> So that might be some other issue.  Let's forget the minimum threshold
> stuff below for now.
> 
> >>
> >> Thus, the actual issue is the accuracy of frequency sampling becomes poor
> >> when the delta of counters are too small to obtain a reliable accuracy.
> >>
> >> Would it be more sensible to put a minimum threshold of the delta of
> >> counters when sampling the frequency?
> > 
> > I'm happy to throw together a patch if there is some safe
> > threshold the experts here can agree on for the minimum delta for
> > the ref counter. I would caution that with this sort of approach we
> > start running into the familiar issue:
> > - What value is appropriate? Too large and you get false
> > positives (falling back to the idle invalid path when we shouldn't), and
> > too less and you get false negatives (we still report inaccurate
> > counter values).
> > - Is the threshold the same across platforms?
> > - Will it remain the same 5/10 years from now?
> > 
> >>  BTW, that ABI
> >> doesn't seem to be synchronous at all, i.e. the cpu might be busy when we
> >> check and then become idle when sampling.
> >>
> > 
> > I don't think this is necessarily an issue. The ABI doesn't need to be
> > synchronous; it is merely a snapshot of the scheduler view of that CPU
> > at a point in time. Even the current method of perf counters sampling
> > is purely hueristic. The CPU might be idle for the 2 usec the
> > sampling is done, and servicing traffic before and after that.
> > This is inherent whenever you are sampling any system state.
> 
> Then the issue is not totally solved, just less often?
> 
> > 
> > I would imagine it is more reliable to trust the kernel scheduler's view
> > of whether a CPU is idle, than relying on counters and a calculation
> > method which are sensitive and unreliable for idle systems
> > (i.e stray interrupts can throw off the calculations).
> > 
> > That said, I'm happy to go with the approach folks on this list recommend.
> > 
> > Cheers,
> > 

