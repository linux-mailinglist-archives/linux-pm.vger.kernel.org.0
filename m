Return-Path: <linux-pm+bounces-33221-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFD6B39539
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 09:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25845202C4B
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 07:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFE529ACDD;
	Thu, 28 Aug 2025 07:33:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2413F9D6;
	Thu, 28 Aug 2025 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366424; cv=none; b=JzOL8nhjBniV6Siwmd/3/d4hi6cxNv/KKP2AvaaX6Yb/4r/G8hEIYFbTFtQCoHi8K3Yem/mt3HaY7/lEoN9GSNdM8GCZLR5nEK6irQv+PfGp9wDbxNRsf0k5niGepUpH/VddT0D9ONDle9bt6COKIBHMBfPdZ/0/VuqcxSWov2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366424; c=relaxed/simple;
	bh=NQwsOjC4Pg+vDk/NIAxDfd9tk2aO4djsPYvh+LV1ofk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZQeogmManAUWBBcXp+QxpaOLJ+1UIOWSKSzaEatyMba01SN94twzVWtQ6GY1lLH6+pt3h5UrVgRXV+TeKBABBhvYQqgET5PvgQSqEy2DHg17KTwe1400Q9B2S5NIvVOz/XxsZ3qqg8ip0ta70ttKP2c7yczcKyRwHBmg8wku3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83F3A1655;
	Thu, 28 Aug 2025 00:33:32 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A9923F694;
	Thu, 28 Aug 2025 00:33:38 -0700 (PDT)
Date: Thu, 28 Aug 2025 09:33:22 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Prashant Malani <pmalani@google.com>
Cc: Yang Shi <yang@os.amperecomputing.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ionela Voinescu <Ionela.Voinescu@arm.com>
Subject: Re: [PATCH] cpufreq: CPPC: Increase delay between perf counter reads
Message-ID: <aLAGQk3nOcEI0qJ2@arm.com>
References: <20250730220812.53098-1-pmalani@google.com>
 <8252b1e6-5d13-4f26-8aa3-30e841639e10@os.amperecomputing.com>
 <CAFivqmKZcipdc1P1b7jkNTBAV-WE4bSeW8z=eHHmtHBxuErZiQ@mail.gmail.com>
 <aKRDxhirzwEPxaqd@arm.com>
 <CAFivqm+vzkbDEadJEF2So9ZWcRyVT_-Yc+8VWWwsgGW+KD4sNw@mail.gmail.com>
 <aKY0xuegI1S4X2uW@arm.com>
 <CAFivqm+Xi9FYtzPmT0QkAUxC2Kx_AkrH2NuQE_sVnJVuo48ypA@mail.gmail.com>
 <aKx4nZWsRPTXK942@arm.com>
 <aKzGlD7ZDIS4XMsF@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKzGlD7ZDIS4XMsF@google.com>

On Mon, Aug 25, 2025 at 08:24:52PM +0000, Prashant Malani wrote:
> On Aug 25 16:52, Beata Michalska wrote:
> > On Wed, Aug 20, 2025 at 02:25:16PM -0700, Prashant Malani wrote:
> > > Hi Beata,
> > > 
> > > On Wed, 20 Aug 2025 at 13:49, Beata Michalska <beata.michalska@arm.com> wrote:
> > > >
> > > > Kinda working on that one.
> > > 
> > > OK. I'm eager to see what the solution is!
> > > 
> > > > >
> > > > > Outside of that, I can't think of another mitigation beyond adding delay to make
> > > > > the time deltas not matter so much.
> > > > I'm not entirely sure what 'so much' means in this context.
> > > > How one would quantify whether the added delay is actually mitigating the issue?
> > > >
> > > 
> > > I alluded to it in the commit description, but here is the my basic
> > > numerical analysis:
> > > The effective timestamps for the 4 readings right now are:
> > > Timestamp t0: del0
> > > Timestamp t0 + m: ref0
> > > (Time delay X us)
> > > Timestamp t1: del1
> > > Timestamp t1 + n: ref1
> > > 
> > > Timestamp t1 = t0 + m + X
> > > 
> > > The perf calculation is:
> > > Per = del1 - del0 / ref1 - ref0
> > >       = Del_counter_diff_over_time(t1 - t0) /
> > > ref_counter_diff_over_time(t1 + n - (t0 + m))
> > >       = Del_counter_diff_over time(t0 + m + X - t0) /
> > > ref_counter_diff_over_time((t0 + m + X + n - t0 - m)
> > >       = Del_counter_diff_over_time(m + X) / ref_counter_diff_over_time(n + X)
> > > 
> > > If X >> (m,n) this becomes:
> > >       = Del_counter_diff_over_time(X) / ref_counter_diff_over_time(X)
> > > which is what the actual calculation is supposed to be.
> > > 
> > > if X ~ (m, N) (which is what the case is right now), the calculation
> > > becomes erratic.
> > This is still bound by 'm' and 'n' values, as the difference between those will
> > determine the error factor (with given, fixed X). If m != n, one counter delta
> > is stretched more than the other, so the perf ratio no longer represents the
> > same time interval. And that will vary between platforms/workloads leading to
> > over/under-reporting.
> 
> What you are saying holds when m,n ~ X. But if X >> m,n, the X component
> dominates. On most platforms, m and n are typically 1-2 us.
> If X is anything >= 100us, it dominates the m,n component, making both
> time intervals practically the same, i.e
> 
> (100 + 1) / (100 + 2) = 101 / 102 = 0.9901 ~ 1.00
True but that does still influence the error - in this case that's ~1% so
negligible. But the overall error magnitude does increase when the range
between min and max of the possible values of m and n gets bigger.
Question is what's the max error that can be deemed acceptable.
And I'm pretty sure there are platforms that would require bigger X still.

> 
> > > 
> > > There have been other observations on this topic [1], that suggest
> > > that even 100us
> > > improves the error rate significantly from what it is with 2us.
> > > 
> > > BR,
> > Which is exactly why I've mentioned this approach is not really recommended,
> > being bound to rather specific setup. There have been similar proposals in the
> > past, all with different values of the delay which should illustrate how fragile
> > solution (if any) that is.
> 
> The reports/occurences point to the fact that the current value doesn't work.
Wasn't claiming it does.
> 
> Another way of putting it is, why is 2us considered the "right"
> value?
Looking at the history, the argument was pretty much the same as yours: was
considered sufficient for most platforms [1]
> 
> This patch was never meant to be an ideal solution, but it's better than what
> is there at present. Currently, the `policy->cur` is completely unusable on CPPC,
> and is cropping up in other locations in the cpufreq driver core [1]
> while also breaking a userfacing ABI i.e scaling_setspeed.
> 
> I realize you're working on a solution, so if that is O(weeks) away, it
> makes sense to wait; otherwise it would seem logical to mitigate the
> error (it can always be reverted once the "better" solution is in
> place).
> 
> Ultimately it's your call, but I'm not convinced with rationale provided
> thus far.
Actually it is not up to me, I'm simply sharing my opinion, which is:
we should fix the problem instead of hiding it.
Setting that aside though - this change seems rather harmless.

Aside:
./scripts/get_maintainer.pl --m ./drivers/cpufreq/cppc_cpufreq.c

---
[1] https://lore.kernel.org/all/37517652-9a74-83f8-1315-07fe79a78d73@codeaurora.org/
---

BR
Beata
> 
> Best regards,
> 
> -Prashant
> 
> [1] https://lore.kernel.org/linux-pm/20250823001937.2765316-1-pmalani@google.com/T/#t

