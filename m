Return-Path: <linux-pm+bounces-33033-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EE0B3449C
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 16:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1941892899
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 14:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F91D289340;
	Mon, 25 Aug 2025 14:52:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69A2278771;
	Mon, 25 Aug 2025 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133553; cv=none; b=nKCMdMvwpGTvOnVo4Zw50mJKSK1iQhHVGFuOCk66xHGQASyT8iXvowLZfAXeo/VdkglBdEZam4U0Lf5JEeO4BDolxO9A38xd8Nu6gIZFOBDetsgjvkTxczjOToiHFNew5bng2UxGa+taQ/OXKQmunYQtD/Mw4OAuxOxTqs41zrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133553; c=relaxed/simple;
	bh=mNLgI/a5ER3TqRse0kNmQGnN1+1xSF0Avg0IMRPAAEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sM6bVSCwGCnqh7U6YlHs+Mosobv8naFUsmil+ChhiVn6VH5rMQVGgLnPaOymh1IR3xoRPbgFfjCSPw/49fX9zVjXAoX1dr+9nstlUWbhEg9MNChhb839cMTWX64jff/MdX29sp4sZ9eMY6fUjBxSekoHJIOQMbhLQcHOK8jwM58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F06D1D70;
	Mon, 25 Aug 2025 07:52:21 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4AD43F694;
	Mon, 25 Aug 2025 07:52:27 -0700 (PDT)
Date: Mon, 25 Aug 2025 16:52:13 +0200
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
Message-ID: <aKx4nZWsRPTXK942@arm.com>
References: <20250730220812.53098-1-pmalani@google.com>
 <8252b1e6-5d13-4f26-8aa3-30e841639e10@os.amperecomputing.com>
 <CAFivqmKZcipdc1P1b7jkNTBAV-WE4bSeW8z=eHHmtHBxuErZiQ@mail.gmail.com>
 <aKRDxhirzwEPxaqd@arm.com>
 <CAFivqm+vzkbDEadJEF2So9ZWcRyVT_-Yc+8VWWwsgGW+KD4sNw@mail.gmail.com>
 <aKY0xuegI1S4X2uW@arm.com>
 <CAFivqm+Xi9FYtzPmT0QkAUxC2Kx_AkrH2NuQE_sVnJVuo48ypA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFivqm+Xi9FYtzPmT0QkAUxC2Kx_AkrH2NuQE_sVnJVuo48ypA@mail.gmail.com>

On Wed, Aug 20, 2025 at 02:25:16PM -0700, Prashant Malani wrote:
> Hi Beata,
> 
> On Wed, 20 Aug 2025 at 13:49, Beata Michalska <beata.michalska@arm.com> wrote:
> >
> > Kinda working on that one.
> 
> OK. I'm eager to see what the solution is!
> 
> > >
> > > Outside of that, I can't think of another mitigation beyond adding delay to make
> > > the time deltas not matter so much.
> > I'm not entirely sure what 'so much' means in this context.
> > How one would quantify whether the added delay is actually mitigating the issue?
> >
> 
> I alluded to it in the commit description, but here is the my basic
> numerical analysis:
> The effective timestamps for the 4 readings right now are:
> Timestamp t0: del0
> Timestamp t0 + m: ref0
> (Time delay X us)
> Timestamp t1: del1
> Timestamp t1 + n: ref1
> 
> Timestamp t1 = t0 + m + X
> 
> The perf calculation is:
> Per = del1 - del0 / ref1 - ref0
>       = Del_counter_diff_over_time(t1 - t0) /
> ref_counter_diff_over_time(t1 + n - (t0 + m))
>       = Del_counter_diff_over time(t0 + m + X - t0) /
> ref_counter_diff_over_time((t0 + m + X + n - t0 - m)
>       = Del_counter_diff_over_time(m + X) / ref_counter_diff_over_time(n + X)
> 
> If X >> (m,n) this becomes:
>       = Del_counter_diff_over_time(X) / ref_counter_diff_over_time(X)
> which is what the actual calculation is supposed to be.
> 
> if X ~ (m, N) (which is what the case is right now), the calculation
> becomes erratic.
This is still bound by 'm' and 'n' values, as the difference between those will
determine the error factor (with given, fixed X). If m != n, one counter delta
is stretched more than the other, so the perf ratio no longer represents the
same time interval. And that will vary between platforms/workloads leading to
over/under-reporting.

> 
> > >
> > > Perhaps ARM should introduce a "snapshot" feature which takes the snapshot
> > > of the AMU counters on a register write; IAC that's outside the scope
> > What do you mean by register write ?
> 
> I mean that we should have a snapshot register:
> SYS_AMEVCNTR0_SNAPSHOT_EL0
> 
> writing to this will save the current values of SYS_AMEVCNTR0_CORE_EL0 and
> SYS_AMEVCNTR0_CONST_EL0 into two shadow registers (say
> SYS_AMEVCNTR0_CORE_SNAPSHOT_EL0
> and SYS_AMEVCNTR0_CONST_SNAPSHOT_EL0)
> 
> That way the OS specifics in how the registers are read don't matter.
> 
> Of course, I'm not a H/W architect so this proposal is very rough, but hopefully
> helps illustrate my idea.
> 
Ah, so you meant architectural changes - thanks for clarification.
> > > of this discussion.
> > >
> > > Could you kindly explain why adding the udelay here is discouraged?
> >
> > Would you mind clarifying how the specific value of 200 µs was determined?
> > Was it carefully derived from measurements across multiple platforms and
> > workloads, or simply observed to “work” on one relatively stable setup?
> >
> > Understanding the basis for choosing that delay will help put the discussion
> > into the right context.
> 
> TBH, I just experimented with values on our system and observed the readings of
> cores running stress-ng. I tried 100us and that still gave variability
> (values greater than
> the theoretical max frequency). It's possible that the "optimal value"
> is somewhere
> between these two.
> 
> There have been other observations on this topic [1], that suggest
> that even 100us
> improves the error rate significantly from what it is with 2us.
> 
> BR,
Which is exactly why I've mentioned this approach is not really recommended,
being bound to rather specific setup. There have been similar proposals in the
past, all with different values of the delay which should illustrate how fragile
solution (if any) that is.

---
BR
Beata
> -Prashant
> 
> [1] https://lore.kernel.org/all/20230328193846.8757-1-yang@os.amperecomputing.com/

