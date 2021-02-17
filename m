Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A3C31D369
	for <lists+linux-pm@lfdr.de>; Wed, 17 Feb 2021 01:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBQAZR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Feb 2021 19:25:17 -0500
Received: from foss.arm.com ([217.140.110.172]:46534 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231344AbhBQAZM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Feb 2021 19:25:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E3BD31B;
        Tue, 16 Feb 2021 16:24:24 -0800 (PST)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E39B53F73D;
        Tue, 16 Feb 2021 16:24:23 -0800 (PST)
Date:   Wed, 17 Feb 2021 00:24:22 +0000
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
Message-ID: <20210217002422.GA17422@arm.com>
References: <cover.1611829953.git.viresh.kumar@linaro.org>
 <d398729676f3d2b0d2ab024a2c9ea6e9ee1d0dca.1611829953.git.viresh.kumar@linaro.org>
 <20210203114521.GA6380@arm.com>
 <20210205091424.3od3tme3f7mh7ebp@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205091424.3od3tme3f7mh7ebp@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey,

On Friday 05 Feb 2021 at 14:44:24 (+0530), Viresh Kumar wrote:
> On 03-02-21, 11:45, Ionela Voinescu wrote:
> > Therefore, I think system level invariance management (checks and
> > call to rebuild_sched_domains_energy()) also needs to move from arm64
> > code to arch_topology code.
> 
> Here is the 3rd patch of this series then :)
> 

I think it could be merged in patch 1/2 as it's part of enabling the use
of multiple sources of information for FIE. Up to you!

> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Fri, 5 Feb 2021 13:31:53 +0530
> Subject: [PATCH] drivers: arch_topology: rebuild sched domains on invariance
>  change
> 
> We already do this for the arm64, move it to arch_topology.c as we
> manage all sched_freq_tick sources here now.
> 
> Reported-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm64/kernel/topology.c | 16 ----------------
>  drivers/base/arch_topology.c | 22 ++++++++++++++++++++++
>  2 files changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 1e47dfd465f8..47fca7376c93 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -240,7 +240,6 @@ static struct scale_freq_data amu_sfd = {
>  
>  static void amu_fie_setup(const struct cpumask *cpus)
>  {
> -	bool invariant;
>  	int cpu;
>  
>  	/* We are already set since the last insmod of cpufreq driver */
> @@ -257,25 +256,10 @@ static void amu_fie_setup(const struct cpumask *cpus)
>  
>  	cpumask_or(amu_fie_cpus, amu_fie_cpus, cpus);
>  
> -	invariant = topology_scale_freq_invariant();
> -
> -	/* We aren't fully invariant yet */
> -	if (!invariant && !cpumask_equal(amu_fie_cpus, cpu_present_mask))
> -		return;
> -

You still need these checks, otherwise you could end up with only part
of the CPUs setting a scale factor, when only part of the CPUs support
AMUs and there is no cpufreq support for FIE.

>  	topology_set_scale_freq_source(&amu_sfd, amu_fie_cpus);
>  
>  	pr_debug("CPUs[%*pbl]: counters will be used for FIE.",
>  		 cpumask_pr_args(cpus));
> -
> -	/*
> -	 * Task scheduler behavior depends on frequency invariance support,
> -	 * either cpufreq or counter driven. If the support status changes as
> -	 * a result of counter initialisation and use, retrigger the build of
> -	 * scheduling domains to ensure the information is propagated properly.
> -	 */
> -	if (!invariant)
> -		rebuild_sched_domains_energy();
>  }
>  
>  static int init_amu_fie_callback(struct notifier_block *nb, unsigned long val,
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 20b511949cd8..3631877f4440 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -23,6 +23,7 @@
>  
>  static DEFINE_PER_CPU(struct scale_freq_data *, sft_data);
>  static struct cpumask scale_freq_counters_mask;
> +static bool scale_freq_invariant;
>  
>  static bool supports_scale_freq_counters(const struct cpumask *cpus)
>  {
> @@ -35,6 +36,23 @@ bool topology_scale_freq_invariant(void)
>  	       supports_scale_freq_counters(cpu_online_mask);
>  }
>  
> +static void update_scale_freq_invariant(bool status)
> +{
> +	if (scale_freq_invariant == status)
> +		return;
> +
> +	/*
> +	 * Task scheduler behavior depends on frequency invariance support,
> +	 * either cpufreq or counter driven. If the support status changes as
> +	 * a result of counter initialisation and use, retrigger the build of
> +	 * scheduling domains to ensure the information is propagated properly.
> +	 */
> +	if (topology_scale_freq_invariant() == status) {
> +		scale_freq_invariant = status;
> +		rebuild_sched_domains_energy();
> +	}
> +}
> +
>  void topology_set_scale_freq_source(struct scale_freq_data *data,
>  				    const struct cpumask *cpus)
>  {
> @@ -50,6 +68,8 @@ void topology_set_scale_freq_source(struct scale_freq_data *data,
>  			cpumask_set_cpu(cpu, &scale_freq_counters_mask);
>  		}
>  	}

Small(ish) optimisation at the beginning of this function:

    if (cpumask_empty(&scale_freq_counters_mask))
        scale_freq_invariant = topology_scale_freq_invariant();

This will save you a call to rebuild_sched_domains_energy(), which is
quite expensive, when cpufreq supports FIE and we also have counters.


After comments addressed,

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>

..for 1/2 and this addition.


Thanks,
Ionela.

> +
> +	update_scale_freq_invariant(true);
>  }
>  EXPORT_SYMBOL_GPL(topology_set_scale_freq_source);
>  
> @@ -67,6 +87,8 @@ void topology_clear_scale_freq_source(enum scale_freq_source source,
>  			cpumask_clear_cpu(cpu, &scale_freq_counters_mask);
>  		}
>  	}
> +
> +	update_scale_freq_invariant(false);
>  }
>  EXPORT_SYMBOL_GPL(topology_clear_scale_freq_source);
>  
> -- 
> 2.25.0.rc1.19.g042ed3e048af
> 
> -- 
> viresh
