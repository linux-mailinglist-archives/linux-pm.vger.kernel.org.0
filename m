Return-Path: <linux-pm+bounces-10279-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E785891E008
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 14:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249681C214FA
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 12:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6675B15A86B;
	Mon,  1 Jul 2024 12:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qKmzYVli"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8993E15A849;
	Mon,  1 Jul 2024 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838780; cv=none; b=ZTsYBxgmCV1h+ZYjtu2HQ7pkaQWTJFFjsaZ0DmnleLv+8ulVy15Wz3S/KnJXXuVe6xZQYe04mkppFUCnblJMKq0uuojxQCxmmxScJJgZrEJNdJiaddYKyNWuINMszudG2RJ+7iPtnu+NZdmhKDYyGF4xz+769WaMoxfmmpL2UB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838780; c=relaxed/simple;
	bh=EqV4abtVrBCqNL/GCdb8qpcsm3jc7faIH+C/b8k/t2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXfw2WGPHs/yl/mVBWbGGq0u4ewe+cbF2aYR/GL4l46rGzKwuQeqvR0jblgvGLAEDaZFScUBGjfnEgQv42JLI7iwNk3Z5q8bgFEywOT0TYHlV3xXIvlRWKsrq/ueB7Zv2ZfsqLSRRZcMyKfVqCEvOuJD9WzYOhAvNWpjwJDaF0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qKmzYVli; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YWMUW1LEMTcUPVRQMHHO4hmc7vT38Q6vHYQXacFSLpM=; b=qKmzYVlivegaiZefvHTin5m6fO
	6I1XQMeYJ7jxR8qZDS6S6yMYm6lVUTNJHu++zn0BCIWVlk6KeawOhtk9B72Jyh+e/xadsj1QUjmJ6
	7CDAXBwD3FZBcBJKamSxIHXR0KmLm8nBwY8CmJi30RXSHkMoNccyY/u1DuM+9vczopRcwe9pHqe+t
	g17ndHL4D1h0Z10WMcz43VBaoEe4DPGlfGsEqJl4W68RaOUFdtTtGNzzLFNsTJHZvhTNOGYSHh5Qr
	eJPWIl1LqAgpYpfiiTtlDZHDlEQqm6cdSgD7RcPmSpBy6au3sTt181bX4/VT2YYDkjrUyNYPMJ45n
	qirtuX6g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOGcu-0000000HLb4-3JF7;
	Mon, 01 Jul 2024 12:59:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F29C1300694; Mon,  1 Jul 2024 14:59:21 +0200 (CEST)
Date: Mon, 1 Jul 2024 14:59:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, kees@kernel.org,
	gustavoars@kernel.org, rui.zhang@intel.com,
	oleksandr@natalenko.name, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	ananth.narayan@amd.com, gautham.shenoy@amd.com,
	kprateek.nayak@amd.com, ravi.bangoria@amd.com, sandipan.das@amd.com,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 02/10] perf/x86/rapl: Fix the energy-pkg event for AMD
 CPUs
Message-ID: <20240701125921.GG20127@noisy.programming.kicks-ass.net>
References: <20240624055907.7720-1-Dhananjay.Ugwekar@amd.com>
 <20240624055907.7720-3-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624055907.7720-3-Dhananjay.Ugwekar@amd.com>

On Mon, Jun 24, 2024 at 05:58:59AM +0000, Dhananjay Ugwekar wrote:
 	
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index b985ca79cf97..73be25e1f4b4 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -103,6 +103,10 @@ static struct perf_pmu_events_attr event_attr_##v = {				\
>  	.event_str	= str,							\
>  };
>  
> +#define rapl_pmu_is_pkg_scope()				\
> +	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
> +	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> +
>  struct rapl_pmu {
>  	raw_spinlock_t		lock;
>  	int			n_active;
> @@ -140,9 +144,21 @@ static unsigned int rapl_cntr_mask;
>  static u64 rapl_timer_ms;
>  static struct perf_msr *rapl_msrs;
>  
> +static inline unsigned int get_rapl_pmu_idx(int cpu)
> +{
> +	return rapl_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
> +					 topology_logical_die_id(cpu);
> +}
> +
> +static inline const struct cpumask *get_rapl_pmu_cpumask(int cpu)
> +{
> +	return rapl_pmu_is_pkg_scope() ? topology_core_cpumask(cpu) :
> +					 topology_die_cpumask(cpu);
> +}

This wants a comment. The next time someone looks at this we're going to
be confused.

> @@ -677,6 +696,9 @@ static int __init init_rapl_pmus(void)
>  {
>  	int nr_rapl_pmu = topology_max_packages() * topology_max_dies_per_package();
>  
> +	if (rapl_pmu_is_pkg_scope())
> +		nr_rapl_pmu = topology_max_packages();
> +

How about:

	int nr_rapl_pmu = topology_max_packages();
	if (!rapl_pmu_is_pkg_scope())
		nr_rapl_pmu *= topology_max_dies_per_package();

hmm?

