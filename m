Return-Path: <linux-pm+bounces-13427-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06052969F7F
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 15:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399ED1C23BD3
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 13:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF8D1CFA9;
	Tue,  3 Sep 2024 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HOLybAVD"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3626846D;
	Tue,  3 Sep 2024 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371711; cv=none; b=DTnuU6T16U4X5jURSXxIEpjKLm5ZqDsYTGbmKZ/oA1Wj29FmvU9CP9m3EyFvm/w8cgsdVMCQhhSt+vXd//ATo/MM6EoKInPuCPbldi3ycPqhS9nMis3Ax+TqeJv9aRYUKsSh3yh8qhu5CmlaNuPR+AWdnGp3zweZP0Ko4PMoUzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371711; c=relaxed/simple;
	bh=TZhs90Wfs86m8kmrWdmjdudoyockf7tSMLRE1n+PTJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScUQQJDKB/zcb7QVUtBMngCpM92Frjl0Zi8I6V6cUvM8nxg53xKeDvk8X9zQhHu/ArJAuaqCtsC+JTQ0sn68T2ZRSNllcvX1vtkSJMEslDBCu2iY1SWRnNgL8D5Lo6Uddl7BKWJN+vsqnVuqtlYv4vDXMgsPejKT9+T6KSkRmg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HOLybAVD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aTa6TKOn9FmWWfnuQkVB5h4+sP16eUgPHREPtwgIrqM=; b=HOLybAVDQjB3YOhr0jmkecXGSD
	SSCyJItTZJf0Qt6X1/5IzPPgBH4pbFkHxn8V9SbFv6Qosaxcay5HjZYoIDvJsGh/d9NbBYX4lJggv
	95Czo6JFRqI1T6gKGQK4D/dSp1kIBBcXjblsfmb0e15kKDsKAPyV4AR2LpCzEUYSO/xaactR275lp
	jy6cLnCew+/AXov7lBodDUdJKXOuolFUd+JIoZo01LCkjmkqXLlKJ/vIzxj8T+6a0U5lUsboBWs/S
	KHteLuvAzIih0EHDfaPJA+I1EmYg+DH5Mb0YgiEBGOMV7PNFRAtlsIwVo3W0Owr+f3BCobVYwW2jA
	5VFx0r5g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slTzr-0000000CLEm-1waM;
	Tue, 03 Sep 2024 13:55:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8625930050D; Tue,  3 Sep 2024 15:55:02 +0200 (CEST)
Date: Tue, 3 Sep 2024 15:55:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: x86 Maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ricardo Neri <ricardo.neri@intel.com>,
	Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 2/2] cpufreq: intel_pstate: Set asymmetric CPU
 capacity on hybrid systems
Message-ID: <20240903135502.GX4723@noisy.programming.kicks-ass.net>
References: <3310447.aeNJFYEL58@rjwysocki.net>
 <1979653.PYKUYFuaPT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1979653.PYKUYFuaPT@rjwysocki.net>

On Wed, Aug 28, 2024 at 01:48:10PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make intel_pstate use the HWP_HIGHEST_PERF values from
> MSR_HWP_CAPABILITIES to set asymmetric CPU capacity information
> via the previously introduced arch_set_cpu_capacity() on hybrid
> systems without SMT.
> 
> Setting asymmetric CPU capacity is generally necessary to allow the
> scheduler to compute task sizes in a consistent way across all CPUs
> in a system where they differ by capacity.  That, in turn, should help
> to improve scheduling decisions.  It is also necessary for the schedutil
> cpufreq governor to operate as expected on hybrid systems where tasks
> migrate between CPUs of different capacities.
> 
> The underlying observation is that intel_pstate already uses
> MSR_HWP_CAPABILITIES to get CPU performance information which is
> exposed by it via sysfs and CPU performance scaling is based on it.
> Thus using this information for setting asymmetric CPU capacity is
> consistent with what the driver has been doing already.  Moreover,
> HWP_HIGHEST_PERF reflects the maximum capacity of a given CPU including
> both the instructions-per-cycle (IPC) factor and the maximum turbo
> frequency and the units in which that value is expressed are the same
> for all CPUs in the system, so the maximum capacity ratio between two
> CPUs can be obtained by computing the ratio of their HWP_HIGHEST_PERF
> values.  Of course, in principle that capacity ratio need not be
> directly applicable at lower frequencies, so using it for providing the
> asymmetric CPU capacity information to the scheduler is a rough
> approximation, but it is as good as it gets.  Also, measurements
> indicate that this approximation is not too bad in practice.
> 
> If the given system is hybrid and non-SMT, the new code disables ITMT
> support in the scheduler (because it may get in the way of asymmetric CPU
> capacity code in the scheduler that automatically gets enabled by setting
> asymmetric CPU capacity) after initializing all online CPUs and finds
> the one with the maximum HWP_HIGHEST_PERF value.  Next, it computes the
> capacity number for each (online) CPU by dividing the product of its
> HWP_HIGHEST_PERF and SCHED_CAPACITY_SCALE by the maximum HWP_HIGHEST_PERF.
> 
> When a CPU goes offline, its capacity is reset to SCHED_CAPACITY_SCALE
> and if it is the one with the maximum HWP_HIGHEST_PERF value, the
> capacity numbers for all of the other online CPUs are recomputed.  This
> also takes care of a cleanup during driver operation mode changes.
> 
> Analogously, when a new CPU goes online, its capacity number is updated
> and if its HWP_HIGHEST_PERF value is greater than the current maximum
> one, the capacity numbers for all of the other online CPUs are
> recomputed.
> 
> The case when the driver is notified of a CPU capacity change, either
> through the HWP interrupt or through an ACPI notification, is handled
> similarly to the CPU online case above, except that if the target CPU
> is the current highest-capacity one and its capacity is reduced, the
> capacity numbers for all of the other online CPUs need to be recomputed
> either.
> 
> If the driver's "no_trubo" sysfs attribute is updated, all of the CPU

Trubo :-)

> capacity information is computed from scratch to reflect the new turbo
> status.

