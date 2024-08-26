Return-Path: <linux-pm+bounces-12920-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA7795FC62
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 00:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD141C227D3
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 22:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C455D19D892;
	Mon, 26 Aug 2024 22:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xqhds4SR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54BE19CD07;
	Mon, 26 Aug 2024 22:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724709723; cv=none; b=D3aUySX7wREzFRy3Iog+Q22Rgge49sqN+RNWy1QejeOWqvn50geQvqNmpLqNDW4BSdeOrPgQ/Ji8RfmQOlTQhwRmF4ugIYHVudlB1INItt8FTCguYMhIxyERNyyNlcZ+viK1yY3kLN/EAbeTm1s8/XiVCZPWU6pctP1OluXjO20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724709723; c=relaxed/simple;
	bh=CIoa739V7bkZOlxg2vU7fXYEoHptRTFbzF06A/aCqt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1q10Czf8oBW3dQ73lRNTsl1kL1vc9d5f/ITB+UgN7UiBpL7cbL29ptt4d2dw9SQulEgRBJM4h+wbyZuitHoh5uZBMsiK8nRrkxyzzHZsavmamU17mHOONfJ4noBke/573cid5cx17SLG9aTwiSih0AvjmDTToVrs4dpQW89A8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xqhds4SR; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724709722; x=1756245722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CIoa739V7bkZOlxg2vU7fXYEoHptRTFbzF06A/aCqt0=;
  b=Xqhds4SR6odUSda1OiKE3jDxKgkMEv2A0PkIBNqhtB8+zT2bWt3mUdAj
   9IgGlo2t9WZFRiHc6gNXKdbxHuISfLPicsInfUQrB/o/SZRic4S2PpKLF
   IGRo33cpSnFWFW+ybVQgSp2PuKIwfkcaOrkGs3zocGWcNyPKwiA+j4i+B
   8NFFNtITofZLbBCEbdgFsLeFJNDcwgOIwvmtgZg1RRMBebw5NbcbWlb3j
   uJyDSOXH3T7knG46LYG3TC6OOoMPmEGxXTAdTpPL+ImCoTAEmX4opKcje
   getGvz2o55Ik1OROJe/0lHlXqYQWgKN3kxY2aFSmqTJ7rYWWtI+F3zy5y
   w==;
X-CSE-ConnectionGUID: AKUT56s4Q/iUW1iNHygoqA==
X-CSE-MsgGUID: SYhSabLpTkGFOVJVIoRqTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="40663125"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="40663125"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:01:52 -0700
X-CSE-ConnectionGUID: Jawq1xG9QAy+YJcCiJCKmw==
X-CSE-MsgGUID: c+is8aKDR76eq2gUIXdDQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="62343816"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:01:53 -0700
Date: Mon, 26 Aug 2024 15:08:49 -0700
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
Subject: Re: [PATCH v2 2/3] x86/sched: Add basic support for CPU capacity
 scaling
Message-ID: <20240826220849.GA7696@ranerica-svr.sc.intel.com>
References: <4941491.31r3eYUQgx@rjwysocki.net>
 <13573795.uLZWGnKmhe@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13573795.uLZWGnKmhe@rjwysocki.net>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, Aug 12, 2024 at 02:42:26PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[...]

> +bool arch_enable_hybrid_capacity_scale(void)
> +{
> +	int cpu;
> +
> +	if (static_branch_unlikely(&arch_hybrid_cap_scale_key)) {
> +		WARN_ONCE(1, "Hybrid CPU capacity scaling already enabled");
> +		return true;
> +	}

Maybe an empty line here for readability?

> +	arch_cpu_scale = alloc_percpu(struct arch_hybrid_cpu_scale);
> +	if (!arch_cpu_scale)
> +		return false;
> +
> +	for_each_possible_cpu(cpu) {
> +		per_cpu_ptr(arch_cpu_scale, cpu)->capacity = SCHED_CAPACITY_SCALE;
> +		per_cpu_ptr(arch_cpu_scale, cpu)->freq_ratio = arch_max_freq_ratio;
> +	}
> +
> +	static_branch_enable(&arch_hybrid_cap_scale_key);
> +
> +	pr_info("Hybrid CPU capacity scaling enabled\n");
> +
> +	return true;
> +}
> +
> +/**
> + * arch_set_cpu_capacity - Set scale-invariance parameters for a CPU
> + * @cpu: Target CPU.
> + * @cap: Capacity of @cpu, relative to @base_cap, at its maximum frequency.
> + * @base_cap: System-wide maximum CPU capacity.

It is confusing to e that @base_cap is the maximum capacity of the system.
Maybe @max_cap?

> + * @max_freq: Frequency of @cpu corresponding to @cap.
> + * @base_freq: Frequency of @cpu at which MPERF counts.
> + *
> + * The units in which @cap and @base_cap are expressed do not matter, so long
> + * as they are consistent, because the former is effectively divided by the
> + * latter.  Analogously for @max_freq and @base_freq.
> + *
> + * After calling this function for all CPUs, call arch_rebuild_sched_domains()
> + * to let the scheduler know that capacity-aware scheduling can be used going
> + * forward.
> + */
> +void arch_set_cpu_capacity(int cpu, unsigned long cap, unsigned long base_cap,
> +			   unsigned long max_freq, unsigned long base_freq)
> +{
> +	if (static_branch_likely(&arch_hybrid_cap_scale_key)) {
> +		WRITE_ONCE(per_cpu_ptr(arch_cpu_scale, cpu)->capacity,
> +			   div_u64(cap << SCHED_CAPACITY_SHIFT, base_cap));
> +		WRITE_ONCE(per_cpu_ptr(arch_cpu_scale, cpu)->freq_ratio,
> +			   div_u64(max_freq << SCHED_CAPACITY_SHIFT, base_freq));
> +	} else {
> +		WARN_ONCE(1, "Hybrid CPU capacity scaling not enabled");
> +	}
> +}
> +
> +unsigned long arch_scale_cpu_capacity(int cpu)
> +{
> +	if (static_branch_unlikely(&arch_hybrid_cap_scale_key))
> +		return READ_ONCE(per_cpu_ptr(arch_cpu_scale, cpu)->capacity);
> +
> +	return SCHED_CAPACITY_SCALE;
> +}
> +EXPORT_SYMBOL_GPL(arch_scale_cpu_capacity);
> +
>  static void scale_freq_tick(u64 acnt, u64 mcnt)
>  {
>  	u64 freq_scale;
> +	u64 freq_ratio;

Why can't freq_ratio be declared on the same line as freq_scale?

>  
>  	if (!arch_scale_freq_invariant())
>  		return;
> @@ -359,7 +439,12 @@ static void scale_freq_tick(u64 acnt, u6
>  	if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
>  		goto error;
>  
> -	if (check_mul_overflow(mcnt, arch_max_freq_ratio, &mcnt) || !mcnt)
> +	if (static_branch_unlikely(&arch_hybrid_cap_scale_key))
> +		freq_ratio = READ_ONCE(this_cpu_ptr(arch_cpu_scale)->freq_ratio);
> +	else
> +		freq_ratio = arch_max_freq_ratio;

It seems that arch_max_freq_ratio will never be used on hybrid processors
and computing arch_turbo_freq_ratio will be a waste of cycles.

Unfortunately, intel_set_max_freq_ratio() is called before the
arch_hybrid_cap_scale_key static key is set.

Maybe some rework is in order?

Thanks and BR,
Ricardo

