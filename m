Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6903E3B1B6F
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jun 2021 15:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhFWNrG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Jun 2021 09:47:06 -0400
Received: from foss.arm.com ([217.140.110.172]:35574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230206AbhFWNrG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 23 Jun 2021 09:47:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 840CEED1;
        Wed, 23 Jun 2021 06:44:48 -0700 (PDT)
Received: from localhost (unknown [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 238D33F718;
        Wed, 23 Jun 2021 06:44:48 -0700 (PDT)
Date:   Wed, 23 Jun 2021 14:44:46 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/4] cpufreq: cppc: Fix potential memleak in
 cppc_cpufreq_cpu_init
Message-ID: <20210623134446.GA12411@arm.com>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
 <579689469ed8a7dfd68dcbb41e9191472799a326.1624266901.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <579689469ed8a7dfd68dcbb41e9191472799a326.1624266901.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Monday 21 Jun 2021 at 14:49:34 (+0530), Viresh Kumar wrote:
> It's a classic example of memleak, we allocate something, we fail and
> never free the resources.
>
> Make sure we free all resources on policy ->init() failures.
> 
> Fixes: a28b2bfc099c ("cppc_cpufreq: replace per-cpu data array with a list")

This is on me, thanks for the fix!

Might be better for this to be separate from the series, but I suppose
all will be going in 5.14 anyway.

> Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index be4f62e2c5f1..35b8ae66d1fb 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -256,6 +256,16 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>  	return NULL;
>  }
>  
> +static void cppc_cpufreq_put_cpu_data(struct cpufreq_policy *policy)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +
> +	list_del(&cpu_data->node);
> +	free_cpumask_var(cpu_data->shared_cpu_map);
> +	kfree(cpu_data);
> +	policy->driver_data = NULL;
> +}
> +
>  static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  {
>  	unsigned int cpu = policy->cpu;
> @@ -309,7 +319,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	default:
>  		pr_debug("Unsupported CPU co-ord type: %d\n",
>  			 policy->shared_type);
> -		return -EFAULT;
> +		ret = -EFAULT;
> +		goto out;
>  	}
>  
>  	/*
> @@ -324,10 +335,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
>  
>  	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> -	if (ret)
> -		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
> -			 caps->highest_perf, cpu, ret);
> +	if (!ret)
> +		return 0;
>  
> +	pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
> +		 caps->highest_perf, cpu, ret);
> +

Nit: I would have preferred the more traditional:

if (ret) {
	pr_debug();
	goto out;
}

return 0;

It's always easier to read.

Thanks,
Ionela.

> +out:
> +	cppc_cpufreq_put_cpu_data(policy);
>  	return ret;
>  }
>  
> @@ -345,12 +360,7 @@ static int cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>  		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
>  			 caps->lowest_perf, cpu, ret);
>  
> -	/* Remove CPU node from list and free driver data for policy */
> -	free_cpumask_var(cpu_data->shared_cpu_map);
> -	list_del(&cpu_data->node);
> -	kfree(policy->driver_data);
> -	policy->driver_data = NULL;
> -
> +	cppc_cpufreq_put_cpu_data(policy);
>  	return 0;
>  }
>  
> -- 
> 2.31.1.272.g89b43f80a514
> 
