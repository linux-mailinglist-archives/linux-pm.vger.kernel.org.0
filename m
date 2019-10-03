Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07417C9E2C
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2019 14:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfJCMQC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Oct 2019 08:16:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60754 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbfJCMQB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2019 08:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KMUClkTO6UWSCzmxIhjPetiD9IE/Gkdvn1kLBeQuxRE=; b=gujkHolU2Wm9Os7tK7ZVubjef
        gsTC8lV8nD83Z8tvk/iaWR1pT/zljFBk/Fwbe+D41CUwc8WZ2H0s2zn9N9H4o9HpWAG2Uxp+wI480
        p5qQO12bw2Ogb/az7kxN/rw03iCFGdkRaYJ8kLbibMnWbBY35DaQEjCYS3DOjlvT2Tpy3hFsMZmFh
        +arwDhukoxSN32C30xaIsJ9StzFiF4fj7G0790HD1ms70cTX8CqSpD3uxRdOX8n9wu0h3/NmRcHQ3
        6KisWoddR/aAvBjUv50WiBDcEl0/BEVi0If5pzOk/UrH1QeKGAjHuw1svhMxmG/06Ahtq12swgBJI
        +AMSG1omw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iG01E-00013R-Sw; Thu, 03 Oct 2019 12:15:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 59F51301B59;
        Thu,  3 Oct 2019 14:14:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 82763201DF20D; Thu,  3 Oct 2019 14:15:37 +0200 (CEST)
Date:   Thu, 3 Oct 2019 14:15:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        Len Brown <lenb@kernel.org>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@qperret.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>
Subject: Re: [PATCH v2 1/2] x86,sched: Add support for frequency invariance
Message-ID: <20191003121537.GR4536@hirez.programming.kicks-ass.net>
References: <20191002122926.385-1-ggherdovich@suse.cz>
 <20191002122926.385-2-ggherdovich@suse.cz>
 <1906426.HDqaVa71mF@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1906426.HDqaVa71mF@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 03, 2019 at 12:27:52PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, October 2, 2019 2:29:25 PM CEST Giovanni Gherdovich wrote:
> > +static bool turbo_disabled(void)
> > +{
> > +	u64 misc_en;
> > +	int err;
> > +
> > +	err = rdmsrl_safe(MSR_IA32_MISC_ENABLE, &misc_en);
> > +	if (err)
> > +		return false;
> > +
> > +	return (misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
> > +}
> 
> This setting may be updated by the platform firmware (BIOS) in some cases
> (see kernel.org BZ 200759, for example), so in general checking it once
> at the init time is not enough.

Is there anything sane we can do if the BIOS frobs stuff like that under
our feet? Other than yell bloody murder, that is?

> > +
> > +#include <asm/cpu_device_id.h>
> > +#include <asm/intel-family.h>
> > +
> > +#define ICPU(model) \
> > +	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_APERFMPERF, 0}
> > +
> > +static const struct x86_cpu_id has_knl_turbo_ratio_limits[] = {
> > +	ICPU(INTEL_FAM6_XEON_PHI_KNL),
> > +	ICPU(INTEL_FAM6_XEON_PHI_KNM),
> > +	{}
> > +};
> > +
> > +static const struct x86_cpu_id has_turbo_ratio_group_limits[] = {
> > +	ICPU(INTEL_FAM6_ATOM_GOLDMONT),
> > +	ICPU(INTEL_FAM6_ATOM_GOLDMONT_D),
> > +	ICPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS),
> > +	ICPU(INTEL_FAM6_SKYLAKE_X),
> > +	{}
> > +};
> > +
> > +static void core_set_cpu_max_freq(void)
> > +{
> > +	u64 ratio, turbo_ratio;
> > +	int err;
> > +
> > +	if (smp_processor_id() != 0)
> > +		return;
> > +
> > +	if (turbo_disabled() ||
> > +		x86_match_cpu(has_knl_turbo_ratio_limits) ||
> > +		x86_match_cpu(has_turbo_ratio_group_limits))
> > +		return;
> > +
> 
> I would move the checks above directly to intel_set_cpu_max_freq().

The reason it is here, is that..

> > +	err = rdmsrl_safe(MSR_PLATFORM_INFO, &ratio);
> > +	if (err)
> > +		return;
> > +
> > +	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &turbo_ratio);
> > +	if (err)
> > +		return;
> > +
> > +	ratio = (ratio >> 8) & 0xFF;                /* max P state ratio */
> > +	turbo_ratio = (turbo_ratio >> 24) & 0xFF;   /* 4C turbo ratio */
> > +
> > +	arch_max_freq = div_u64(turbo_ratio * SCHED_CAPACITY_SCALE, ratio);
> > +
> > +	static_branch_enable(&arch_scale_freq_key);
> > +}
> > +
> > +static void intel_set_cpu_max_freq(void)
> > +{
> > +	/*
> > +	 * TODO: add support for:
> > +	 *
> > +	 * - Xeon Phi (KNM, KNL)
> > +	 * - Xeon Gold/Platinum, Atom Goldmont/Goldmont Plus
> > +	 * - Atom Silvermont
> > +	 *
> > +	 * which all now get by default arch_max_freq = SCHED_CAPACITY_SCALE
> > +	 */
> > +	core_set_cpu_max_freq();

This used to read something like:

	if (core_set_cpu_max_freq())
		return;

	if (atom_set_cpu_max_freq())
		return;

	...

and then those checks make sense, because we're failing the 'core' way,
but another way might work.

But in this version the atom version has gone missing -- I've suggested
it be put back as an additional patch.

Also, the SKX way still needs to be written..

> > +}
> > +
> > +static void init_scale_freq(void *arg)
> > +{
> > +	u64 aperf, mperf;
> > +
> > +	rdmsrl(MSR_IA32_APERF, aperf);
> > +	rdmsrl(MSR_IA32_MPERF, mperf);
> > +
> > +	this_cpu_write(arch_prev_aperf, aperf);
> > +	this_cpu_write(arch_prev_mperf, mperf);
> > +}
> > +
> > +static void set_cpu_max_freq(void)
> > +{
> > +	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
> > +		return;
> > +
> > +	switch (boot_cpu_data.x86_vendor) {
> > +	case X86_VENDOR_INTEL:
> > +		intel_set_cpu_max_freq();
> > +		break;
> > +	default:
> > +		break;
> > +	}
> 
> Why is the switch () needed?
> 
> It seems that
> 
> 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
> 		intel_set_cpu_max_freq();
> 
> would do the trick.

I was hoping to grow X86_VENDOR_AMD bits..

> > +
> > +	init_scale_freq(NULL);
> > +}
> > +
> > +DEFINE_PER_CPU(unsigned long, arch_cpu_freq);
> > +
> > +static bool tick_disable;
> > +
> > +void arch_scale_freq_tick(void)
> > +{
> > +	u64 freq;
> > +	u64 aperf, mperf;
> > +	u64 acnt, mcnt;
> > +
> > +	if (!arch_scale_freq_invariant() || tick_disable)
> > +		return;
> > +
> 
> This may be a silly question, but can using tick_disable be avoided?
> 
> I guess it is there, because disabling the static branch from
> x86_arch_scale_freq_tick_disable() would be unsafe, but I'm not
> sure why that would be the case?

There's not enough state -- we can of course fix that.

That is, if you disable it, we don't know if we should enable it again
later or if it was disabled because we failed to initialize it earlier.
