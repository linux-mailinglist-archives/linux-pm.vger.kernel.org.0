Return-Path: <linux-pm+bounces-13513-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED22E96B1C8
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 08:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2E51C25550
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 06:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CB513B599;
	Wed,  4 Sep 2024 06:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BDyxoDz8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8746013B295;
	Wed,  4 Sep 2024 06:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725431611; cv=none; b=XN6yRPOblunm4b0SJmptMK84TTuzT1k4cY7RqLiGZ5RH/gDIFdqs+VmNWTKA2bLWbfc8YrOLWZvf3WoJ+UikVV7rwmsN2qY2J9pcuQxQ9MTRcZpC17kBVsSAxbJvBoqVVtEKS/sFw4FQCRAQPGfr0DBTADVSDL0CWOvTLTWYH38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725431611; c=relaxed/simple;
	bh=2QJoXB3gfnQ97DNZAs6pSA6MA43OuBZVAKZyeRJkbKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsvtxpLMR6gbPXRQwimVgDOJvIkou/mpwlsSq2TkK6POrrSyBav0rg8H+IRZc6qUB36HZErJ6Edj/ZnjnBLAblPTIdzTVNmH9hEqVl42TVIWKYUPExtFOUfq5hxK2CywpRmTxN6dCDqQQ7OSIUIULmME4JtTTDtBOfnLvrVvKIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BDyxoDz8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725431610; x=1756967610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2QJoXB3gfnQ97DNZAs6pSA6MA43OuBZVAKZyeRJkbKY=;
  b=BDyxoDz8uNtPyiJKPJm3ZtSBIH/LKiuMCGsjg2UrOImkX+nYVO5FW/ib
   tce7NeQoWDE2lxgwIRfomkhXMrksZRgZR1MKclhymeppIDJar2bQFqwx6
   qZU6MsRcLFEyBU15xsp3CLmqgXuB6wqDsbZFCIXEKneamx2Nwxx+bwoX/
   RWUvFV2tDOAUuOFpqrjrnsuI41N4TLwHkWHCPd6N3j7rwsulcdePVjb7J
   RewA5qG0h0ptPH/RNHAM4E0ZG364oeuF7tmdC/d171Sobw3bsFgPngQNm
   0SdyG49j20OM3+uHBeFL2vfHB/kKE899jAP8AgpT8Efk+MSdTQSKm68K2
   A==;
X-CSE-ConnectionGUID: l0kSRhBERfGv6Jvg8xxScw==
X-CSE-MsgGUID: PBKWuP17QbmBISSdzDMp/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24221593"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="24221593"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 23:33:29 -0700
X-CSE-ConnectionGUID: MohK5h6LSF+MqxH9bjTRFQ==
X-CSE-MsgGUID: 3lOQ/p2OTK6TfcS/+aKW+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="69981830"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 23:33:29 -0700
Date: Tue, 3 Sep 2024 23:39:15 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: x86 Maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ricardo Neri <ricardo.neri@intel.com>,
	Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 2/2] cpufreq: intel_pstate: Set asymmetric CPU
 capacity on hybrid systems
Message-ID: <20240904063915.GA3674@ranerica-svr.sc.intel.com>
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
User-Agent: Mutt/1.9.4 (2018-02-28)

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
> capacity information is computed from scratch to reflect the new turbo
> status.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

A few minor comments below...

FWIW,

Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com> # scale invariance

[...]

> +
> +static void hybrid_init_cpu_scaling(void)

Maybe renaming hybrid_init_cpu_scaling() as hybrid_init_cpu_capacity_scaling(),
__hybrid_init_cpu_scaling() as __hybrid_init_cpu_capacity_scaling(), and
hybrid_update_cpu_scaling() as hybrid_update_cpu_capacity_scaling()?

It would make the code easier to read.

> +{
> +	bool disable_itmt = false;
> +
> +	mutex_lock(&hybrid_capacity_lock);
> +
> +	/*
> +	 * If hybrid_max_perf_cpu is set at this point, the hybrid CPU capacity
> +	 * scaling has been enabled already and the driver is just changing the
> +	 * operation mode.
> +	 */
> +	if (hybrid_max_perf_cpu) {
> +		__hybrid_init_cpu_scaling();
> +		goto unlock;
> +	}
> +
> +	/*
> +	 * On hybrid systems, use asym capacity instead of ITMT, but because
> +	 * the capacity of SMT threads is not deterministic even approximately,
> +	 * do not do that when SMT is in use.
> +	 */
> +	if (hwp_is_hybrid && !sched_smt_active() && arch_enable_hybrid_capacity_scale()) {
> +		__hybrid_init_cpu_scaling();
> +		disable_itmt = true;
> +	}
> +
> +unlock:
> +	mutex_unlock(&hybrid_capacity_lock);
> +
> +	if (disable_itmt)
> +		sched_clear_itmt_support();

It may be worth adding a comment here saying that the sched domains will
rebuilt to disable asym packing and enable asym capacity.
 

