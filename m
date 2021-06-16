Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB703A9926
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 13:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFPL1w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 07:27:52 -0400
Received: from foss.arm.com ([217.140.110.172]:34546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229502AbhFPL1w (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Jun 2021 07:27:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41AEB1042;
        Wed, 16 Jun 2021 04:25:46 -0700 (PDT)
Received: from localhost (unknown [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D52633F70D;
        Wed, 16 Jun 2021 04:25:45 -0700 (PDT)
Date:   Wed, 16 Jun 2021 12:25:44 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/3] arch_topology: Avoid use-after-free for
 scale_freq_data
Message-ID: <20210616112544.GA23657@arm.com>
References: <cover.1623825725.git.viresh.kumar@linaro.org>
 <9dba462b4d09a1a8a9fbb75740b74bf91a09a3e1.1623825725.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dba462b4d09a1a8a9fbb75740b74bf91a09a3e1.1623825725.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey,

On Wednesday 16 Jun 2021 at 12:18:08 (+0530), Viresh Kumar wrote:
> Currently topology_scale_freq_tick() may end up using a pointer to
> struct scale_freq_data, which was previously cleared by
> topology_clear_scale_freq_source(), as there is no protection in place
> here. The users of topology_clear_scale_freq_source() though needs a
> guarantee that the previous scale_freq_data isn't used anymore.
> 

Please correct me if I'm wrong, but my understanding is that this is
only a problem for the cppc cpufreq invariance functionality. Let's
consider a scenario where CPUs are either hotplugged out or the cpufreq
CPPC driver module is removed; topology_clear_scale_freq_source() would
get called and the sfd_data will be set to NULL. But if at the same
time topology_scale_freq_tick() got an old reference of sfd_data,
set_freq_scale() will be called. This is only a problem for CPPC cpufreq
as cppc_scale_freq_tick() will end up using driver internal data that
might have been freed during the hotplug callbacks or the exit path.

If this is the case, wouldn't the synchronisation issue be better
resolved in the CPPC cpufreq driver, rather than here?

Thank you,
Ionela.

> Since topology_scale_freq_tick() is called from scheduler tick, we don't
> want to add locking in there. Use the RCU update mechanism instead
> (which is already used by the scheduler's utilization update path) to
> guarantee race free updates here.
> 
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/arch_topology.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index c1179edc0f3b..921312a8d957 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -18,10 +18,11 @@
>  #include <linux/cpumask.h>
>  #include <linux/init.h>
>  #include <linux/percpu.h>
> +#include <linux/rcupdate.h>
>  #include <linux/sched.h>
>  #include <linux/smp.h>
>  
> -static DEFINE_PER_CPU(struct scale_freq_data *, sft_data);
> +static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
>  static struct cpumask scale_freq_counters_mask;
>  static bool scale_freq_invariant;
>  
> @@ -66,16 +67,20 @@ void topology_set_scale_freq_source(struct scale_freq_data *data,
>  	if (cpumask_empty(&scale_freq_counters_mask))
>  		scale_freq_invariant = topology_scale_freq_invariant();
>  
> +	rcu_read_lock();
> +
>  	for_each_cpu(cpu, cpus) {
> -		sfd = per_cpu(sft_data, cpu);
> +		sfd = rcu_dereference(*per_cpu_ptr(&sft_data, cpu));
>  
>  		/* Use ARCH provided counters whenever possible */
>  		if (!sfd || sfd->source != SCALE_FREQ_SOURCE_ARCH) {
> -			per_cpu(sft_data, cpu) = data;
> +			rcu_assign_pointer(per_cpu(sft_data, cpu), data);
>  			cpumask_set_cpu(cpu, &scale_freq_counters_mask);
>  		}
>  	}
>  
> +	rcu_read_unlock();
> +
>  	update_scale_freq_invariant(true);
>  }
>  EXPORT_SYMBOL_GPL(topology_set_scale_freq_source);
> @@ -86,22 +91,32 @@ void topology_clear_scale_freq_source(enum scale_freq_source source,
>  	struct scale_freq_data *sfd;
>  	int cpu;
>  
> +	rcu_read_lock();
> +
>  	for_each_cpu(cpu, cpus) {
> -		sfd = per_cpu(sft_data, cpu);
> +		sfd = rcu_dereference(*per_cpu_ptr(&sft_data, cpu));
>  
>  		if (sfd && sfd->source == source) {
> -			per_cpu(sft_data, cpu) = NULL;
> +			rcu_assign_pointer(per_cpu(sft_data, cpu), NULL);
>  			cpumask_clear_cpu(cpu, &scale_freq_counters_mask);
>  		}
>  	}
>  
> +	rcu_read_unlock();
> +
> +	/*
> +	 * Make sure all references to previous sft_data are dropped to avoid
> +	 * use-after-free races.
> +	 */
> +	synchronize_rcu();
> +
>  	update_scale_freq_invariant(false);
>  }
>  EXPORT_SYMBOL_GPL(topology_clear_scale_freq_source);
>  
>  void topology_scale_freq_tick(void)
>  {
> -	struct scale_freq_data *sfd = *this_cpu_ptr(&sft_data);
> +	struct scale_freq_data *sfd = rcu_dereference_sched(*this_cpu_ptr(&sft_data));
>  
>  	if (sfd)
>  		sfd->set_freq_scale();
> -- 
> 2.31.1.272.g89b43f80a514
> 
