Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB1BCAD2D
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2019 19:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388556AbfJCRgT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Oct 2019 13:36:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:13339 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387524AbfJCRgS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 3 Oct 2019 13:36:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 10:36:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,253,1566889200"; 
   d="scan'208";a="192188491"
Received: from spandruv-mobl3.jf.intel.com ([10.254.33.3])
  by fmsmga007.fm.intel.com with ESMTP; 03 Oct 2019 10:36:16 -0700
Message-ID: <dfb172a0a8003f90fd185b7b154164b8b49bbaa9.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/2] x86,sched: Add support for frequency invariance
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
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
Date:   Thu, 03 Oct 2019 10:36:16 -0700
In-Reply-To: <20191003121537.GR4536@hirez.programming.kicks-ass.net>
References: <20191002122926.385-1-ggherdovich@suse.cz>
         <20191002122926.385-2-ggherdovich@suse.cz> <1906426.HDqaVa71mF@kreacher>
         <20191003121537.GR4536@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2019-10-03 at 14:15 +0200, Peter Zijlstra wrote:
> On Thu, Oct 03, 2019 at 12:27:52PM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, October 2, 2019 2:29:25 PM CEST Giovanni Gherdovich
> > wrote:
> > > +static bool turbo_disabled(void)
> > > +{
> > > +	u64 misc_en;
> > > +	int err;
> > > +
> > > +	err = rdmsrl_safe(MSR_IA32_MISC_ENABLE, &misc_en);
> > > +	if (err)
> > > +		return false;
> > > +
> > > +	return (misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
> > > +}
> > 
> > This setting may be updated by the platform firmware (BIOS) in some
> > cases
> > (see kernel.org BZ 200759, for example), so in general checking it
> > once
> > at the init time is not enough.
> 
> Is there anything sane we can do if the BIOS frobs stuff like that
> under
> our feet? Other than yell bloody murder, that is?
On  this platform which this BZ is talking about, you will get an ACPI
notification about this change. But the notification will happen for
only one CPU, but it needs to be accounted for all CPUs.

Thanks,
Srinivas

> 
> > > +
> > > +#include <asm/cpu_device_id.h>
> > > +#include <asm/intel-family.h>
> > > +
> > > +#define ICPU(model) \
> > > +	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_APERFMPERF, 0}
> > > +
> > > +static const struct x86_cpu_id has_knl_turbo_ratio_limits[] = {
> > > +	ICPU(INTEL_FAM6_XEON_PHI_KNL),
> > > +	ICPU(INTEL_FAM6_XEON_PHI_KNM),
> > > +	{}
> > > +};
> > > +
> > > +static const struct x86_cpu_id has_turbo_ratio_group_limits[] =
> > > {
> > > +	ICPU(INTEL_FAM6_ATOM_GOLDMONT),
> > > +	ICPU(INTEL_FAM6_ATOM_GOLDMONT_D),
> > > +	ICPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS),
> > > +	ICPU(INTEL_FAM6_SKYLAKE_X),
> > > +	{}
> > > +};
> > > +
> > > +static void core_set_cpu_max_freq(void)
> > > +{
> > > +	u64 ratio, turbo_ratio;
> > > +	int err;
> > > +
> > > +	if (smp_processor_id() != 0)
> > > +		return;
> > > +
> > > +	if (turbo_disabled() ||
> > > +		x86_match_cpu(has_knl_turbo_ratio_limits) ||
> > > +		x86_match_cpu(has_turbo_ratio_group_limits))
> > > +		return;
> > > +
> > 
> > I would move the checks above directly to intel_set_cpu_max_freq().
> 
> The reason it is here, is that..
> 
> > > +	err = rdmsrl_safe(MSR_PLATFORM_INFO, &ratio);
> > > +	if (err)
> > > +		return;
> > > +
> > > +	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &turbo_ratio);
> > > +	if (err)
> > > +		return;
> > > +
> > > +	ratio = (ratio >> 8) & 0xFF;                /* max P state
> > > ratio */
> > > +	turbo_ratio = (turbo_ratio >> 24) & 0xFF;   /* 4C turbo ratio
> > > */
> > > +
> > > +	arch_max_freq = div_u64(turbo_ratio * SCHED_CAPACITY_SCALE,
> > > ratio);
> > > +
> > > +	static_branch_enable(&arch_scale_freq_key);
> > > +}
> > > +
> > > +static void intel_set_cpu_max_freq(void)
> > > +{
> > > +	/*
> > > +	 * TODO: add support for:
> > > +	 *
> > > +	 * - Xeon Phi (KNM, KNL)
> > > +	 * - Xeon Gold/Platinum, Atom Goldmont/Goldmont Plus
> > > +	 * - Atom Silvermont
> > > +	 *
> > > +	 * which all now get by default arch_max_freq =
> > > SCHED_CAPACITY_SCALE
> > > +	 */
> > > +	core_set_cpu_max_freq();
> 
> This used to read something like:
> 
> 	if (core_set_cpu_max_freq())
> 		return;
> 
> 	if (atom_set_cpu_max_freq())
> 		return;
> 
> 	...
> 
> and then those checks make sense, because we're failing the 'core'
> way,
> but another way might work.
> 
> But in this version the atom version has gone missing -- I've
> suggested
> it be put back as an additional patch.
> 
> Also, the SKX way still needs to be written..
> 
> > > +}
> > > +
> > > +static void init_scale_freq(void *arg)
> > > +{
> > > +	u64 aperf, mperf;
> > > +
> > > +	rdmsrl(MSR_IA32_APERF, aperf);
> > > +	rdmsrl(MSR_IA32_MPERF, mperf);
> > > +
> > > +	this_cpu_write(arch_prev_aperf, aperf);
> > > +	this_cpu_write(arch_prev_mperf, mperf);
> > > +}
> > > +
> > > +static void set_cpu_max_freq(void)
> > > +{
> > > +	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
> > > +		return;
> > > +
> > > +	switch (boot_cpu_data.x86_vendor) {
> > > +	case X86_VENDOR_INTEL:
> > > +		intel_set_cpu_max_freq();
> > > +		break;
> > > +	default:
> > > +		break;
> > > +	}
> > 
> > Why is the switch () needed?
> > 
> > It seems that
> > 
> > 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
> > 		intel_set_cpu_max_freq();
> > 
> > would do the trick.
> 
> I was hoping to grow X86_VENDOR_AMD bits..
> 
> > > +
> > > +	init_scale_freq(NULL);
> > > +}
> > > +
> > > +DEFINE_PER_CPU(unsigned long, arch_cpu_freq);
> > > +
> > > +static bool tick_disable;
> > > +
> > > +void arch_scale_freq_tick(void)
> > > +{
> > > +	u64 freq;
> > > +	u64 aperf, mperf;
> > > +	u64 acnt, mcnt;
> > > +
> > > +	if (!arch_scale_freq_invariant() || tick_disable)
> > > +		return;
> > > +
> > 
> > This may be a silly question, but can using tick_disable be
> > avoided?
> > 
> > I guess it is there, because disabling the static branch from
> > x86_arch_scale_freq_tick_disable() would be unsafe, but I'm not
> > sure why that would be the case?
> 
> There's not enough state -- we can of course fix that.
> 
> That is, if you disable it, we don't know if we should enable it
> again
> later or if it was disabled because we failed to initialize it
> earlier.

