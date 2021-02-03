Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6B730D91A
	for <lists+linux-pm@lfdr.de>; Wed,  3 Feb 2021 12:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbhBCLqJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Feb 2021 06:46:09 -0500
Received: from foss.arm.com ([217.140.110.172]:38546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234227AbhBCLqJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Feb 2021 06:46:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32569D6E;
        Wed,  3 Feb 2021 03:45:23 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C65523F719;
        Wed,  3 Feb 2021 03:45:22 -0800 (PST)
Date:   Wed, 3 Feb 2021 11:45:21 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 1/2] topology: Allow multiple entities to provide
 sched_freq_tick() callback
Message-ID: <20210203114521.GA6380@arm.com>
References: <cover.1611829953.git.viresh.kumar@linaro.org>
 <d398729676f3d2b0d2ab024a2c9ea6e9ee1d0dca.1611829953.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d398729676f3d2b0d2ab024a2c9ea6e9ee1d0dca.1611829953.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

Many thanks for the renaming of functions/variables/enums.

I've cropped all the code that looks good to me, and I kept some
portions of interest.

On Thursday 28 Jan 2021 at 16:18:55 (+0530), Viresh Kumar wrote:
> This patch attempts to make it generic enough so other parts of the
> kernel can also provide their own implementation of scale_freq_tick()
> callback, which is called by the scheduler periodically to update the
> per-cpu freq_scale variable.
[..]
>  static void amu_fie_setup(const struct cpumask *cpus)
>  {
> @@ -227,7 +263,7 @@ static void amu_fie_setup(const struct cpumask *cpus)
>  	if (!invariant && !cpumask_equal(amu_fie_cpus, cpu_present_mask))
>  		return;
>  
> -	static_branch_enable(&amu_fie_key);
> +	topology_set_scale_freq_source(&amu_sfd, amu_fie_cpus);
>  
>  	pr_debug("CPUs[%*pbl]: counters will be used for FIE.",
>  		 cpumask_pr_args(cpus));
> @@ -283,53 +319,6 @@ static int __init init_amu_fie(void)
>  }
>  core_initcall(init_amu_fie);
[..]
> +void topology_set_scale_freq_source(struct scale_freq_data *data,
> +				    const struct cpumask *cpus)
> +{
> +	struct scale_freq_data *sfd;
> +	int cpu;
> +
> +	for_each_cpu(cpu, cpus) {
> +		sfd = per_cpu(sft_data, cpu);
> +
> +		/* Use ARCH provided counters whenever possible */
> +		if (!sfd || sfd->source != SCALE_FREQ_SOURCE_ARCH) {
> +			per_cpu(sft_data, cpu) = data;
> +			cpumask_set_cpu(cpu, &scale_freq_counters_mask);
> +		}
> +	}
>  }
> +EXPORT_SYMBOL_GPL(topology_set_scale_freq_source);
[..]

I have one single comment left for this patch, and apologies in advance
for the long story.

In general, for frequency invariance, we're interested in whether the full
system is frequency invariant as well, for two reasons:
 - We want to be able to either set a scale factor for all CPUs or none
   at all.
 - If at some point during the boot process the system invariance status
   changes, we want to be able to inform dependents: schedutil and EAS.

This management is currently done on amu_fie_setup(), because before
these patches we only had two sources for frequency invariance: cpufreq
and AMU counters. But that's not enough after these two patches, from
both functional and code design point of view.

I have to mention that your code will work as it is for now, but only
because CPPC is the new other source of counters, and for CPPC we also
have cpufreq invariance available. But this only hides what can become a
problem later: if in the future we won't have cpufreq invariance for
CPPC or if another provider of counters is added and used in a system
without cpufreq invariance, the late initialization of these counters
will either break schedutil/scheduler if not all CPUs support those
counters, or keep EAS disabled, even if all CPUs support these counters,
and frequency invariance is later enabled.

Therefore, I think system level invariance management (checks and
call to rebuild_sched_domains_energy()) also needs to move from arm64
code to arch_topology code.

Thanks,
Ionela.
