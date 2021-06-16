Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0423A9486
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 09:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhFPH7a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 03:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231890AbhFPH7Z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Jun 2021 03:59:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF29B61159;
        Wed, 16 Jun 2021 07:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623830240;
        bh=IKaUw9gSf4Il/h/kz8Yn/wyMKOq1jlj5yum4ygVdJhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uiR/GCMbARWDgoFV/dp6DkQhN9wwcUyTLQ187nNdjOoQiHbnQBIMYYNJ7pPEctPD0
         AKTEW6Z7Ui+bzvaGm/omyBvyON0hib4lzCR4A2QiH491aeIJUW588zxSBveHAOIs//
         j/XQhFgnilqdqijEMcQ4XZTreVEaOlOcMxcbPj2w=
Date:   Wed, 16 Jun 2021 09:57:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/3] arch_topology: Avoid use-after-free for
 scale_freq_data
Message-ID: <YMmu3bS3Q6avUfEW@kroah.com>
References: <cover.1623825725.git.viresh.kumar@linaro.org>
 <9dba462b4d09a1a8a9fbb75740b74bf91a09a3e1.1623825725.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dba462b4d09a1a8a9fbb75740b74bf91a09a3e1.1623825725.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 16, 2021 at 12:18:08PM +0530, Viresh Kumar wrote:
> Currently topology_scale_freq_tick() may end up using a pointer to
> struct scale_freq_data, which was previously cleared by
> topology_clear_scale_freq_source(), as there is no protection in place
> here. The users of topology_clear_scale_freq_source() though needs a
> guarantee that the previous scale_freq_data isn't used anymore.
> 
> Since topology_scale_freq_tick() is called from scheduler tick, we don't
> want to add locking in there. Use the RCU update mechanism instead
> (which is already used by the scheduler's utilization update path) to
> guarantee race free updates here.
> 
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

So this is a bugfix for problems in the current codebase?  What commit
does this fix?  Should it go to the stable kernels?

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

What race is happening?  How could the current code race?  Only when a
cpu is removed?

thanks,

greg k-h
