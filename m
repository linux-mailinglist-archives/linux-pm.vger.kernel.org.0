Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107D933113F
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 15:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhCHOwU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 09:52:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:48192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhCHOwP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Mar 2021 09:52:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F904650ED;
        Mon,  8 Mar 2021 14:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615215135;
        bh=zcV5XaYvoMhf2mkCNLmmjTPaR/kS4dnjNFn8LytabeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HJycUihYXsVc3M2fN+5uqgcNjbvzNBBzVFPfVB8agtPfyWQC9d0ky+hWK1+kVhf3s
         biRThEXrxbtENvO/pF0gKDJ+IYI1OOFD1oICpzIIrerrRYv6gSFnimlbiTcToGxseQ
         cKzQQWlNFjqOVSNKU917uJ7++gL/8KvyVrTKd91+8Bp4uz8Z7epA9p2nRJHE7lWI+J
         j5b7QGZ0EjlRqvhh7H3l0ytMM2aRg6yppMBKoTxFYh/dAj//z/iLi+0AsU8a83qqcw
         5QXcdeqRwr0WZCz3KIQCThmfZVgj1IkhzhaxHDjY98dAYkGfuMWiwBpEo9LHyeY4mU
         oPUMBKnM7Mu7g==
Date:   Mon, 8 Mar 2021 14:52:09 +0000
From:   Will Deacon <will@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 1/2] topology: Allow multiple entities to provide
 sched_freq_tick() callback
Message-ID: <20210308145209.GA26458@willie-the-truck>
References: <cover.1614580695.git.viresh.kumar@linaro.org>
 <a34f549bc75eecd4804aebb7b7794b45769eccf0.1614580695.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a34f549bc75eecd4804aebb7b7794b45769eccf0.1614580695.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 01, 2021 at 12:21:17PM +0530, Viresh Kumar wrote:
> This patch attempts to make it generic enough so other parts of the
> kernel can also provide their own implementation of scale_freq_tick()
> callback, which is called by the scheduler periodically to update the
> per-cpu freq_scale variable.
> 
> The implementations now need to provide 'struct scale_freq_data' for the
> CPUs for which they have hardware counters available, and a callback
> gets registered for each possible CPU in a per-cpu variable.
> 
> The arch specific (or ARM AMU) counters are updated to adapt to this and
> they take the highest priority if they are available, i.e. they will be
> used instead of CPPC based counters for example.
> 
> The special code to rebuild the sched domains, in case invariance status
> change for the system, is moved out of arm64 specific code and is added
> to arch_topology.c.
> 
> Note that this also defines SCALE_FREQ_SOURCE_CPUFREQ but doesn't use it
> and it is added to show that cpufreq is also acts as source of
> information for FIE and will be used by default if no other counters are
> supported for a platform.
> 
> Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm64/include/asm/topology.h |  10 +--
>  arch/arm64/kernel/topology.c      | 105 +++++++++++-------------------
>  drivers/base/arch_topology.c      |  85 ++++++++++++++++++++++--
>  include/linux/arch_topology.h     |  14 +++-
>  4 files changed, 134 insertions(+), 80 deletions(-)

For the arm64 bits:

Acked-by: Will Deacon <will@kernel.org>

However...

> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index de8587cc119e..8f62dbf93f67 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -21,17 +21,94 @@
>  #include <linux/sched.h>
>  #include <linux/smp.h>
>  
> +static DEFINE_PER_CPU(struct scale_freq_data *, sft_data);
> +static struct cpumask scale_freq_counters_mask;
> +static bool scale_freq_invariant;
> +
> +static bool supports_scale_freq_counters(const struct cpumask *cpus)
> +{
> +	return cpumask_subset(cpus, &scale_freq_counters_mask);
> +}
> +
>  bool topology_scale_freq_invariant(void)
>  {
>  	return cpufreq_supports_freq_invariance() ||
> -	       arch_freq_counters_available(cpu_online_mask);
> +	       supports_scale_freq_counters(cpu_online_mask);
>  }
>  
> -__weak bool arch_freq_counters_available(const struct cpumask *cpus)
> +static void update_scale_freq_invariant(bool status)
>  {
> -	return false;
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
>  }
> +
> +void topology_set_scale_freq_source(struct scale_freq_data *data,
> +				    const struct cpumask *cpus)
> +{
> +	struct scale_freq_data *sfd;
> +	int cpu;
> +
> +	/*
> +	 * Avoid calling rebuild_sched_domains() unnecessarily if FIE is
> +	 * supported by cpufreq.
> +	 */
> +	if (cpumask_empty(&scale_freq_counters_mask))
> +		scale_freq_invariant = topology_scale_freq_invariant();
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
> +
> +	update_scale_freq_invariant(true);
> +}
> +EXPORT_SYMBOL_GPL(topology_set_scale_freq_source);

I don't get why you need to export this in this patch. The arm64 topology
code is never built as a module.

> +
> +void topology_clear_scale_freq_source(enum scale_freq_source source,
> +				      const struct cpumask *cpus)
> +{
> +	struct scale_freq_data *sfd;
> +	int cpu;
> +
> +	for_each_cpu(cpu, cpus) {
> +		sfd = per_cpu(sft_data, cpu);
> +
> +		if (sfd && sfd->source == source) {
> +			per_cpu(sft_data, cpu) = NULL;
> +			cpumask_clear_cpu(cpu, &scale_freq_counters_mask);
> +		}
> +	}
> +
> +	update_scale_freq_invariant(false);
> +}
> +EXPORT_SYMBOL_GPL(topology_clear_scale_freq_source);

Same here.

> +
> +void topology_scale_freq_tick(void)
> +{
> +	struct scale_freq_data *sfd = *this_cpu_ptr(&sft_data);
> +
> +	if (sfd)
> +		sfd->set_freq_scale();
> +}
> +
>  DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
> +EXPORT_SYMBOL_GPL(freq_scale);

And here. This one probably wants a less generic name as well if it's going
to be exported.

Will
