Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77CF59CC6B
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2019 11:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbfHZJS2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Aug 2019 05:18:28 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55394 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfHZJS2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Aug 2019 05:18:28 -0400
Received: from 79.184.255.249.ipv4.supernova.orange.pl (79.184.255.249) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 749051870c05ff60; Mon, 26 Aug 2019 11:18:25 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Doug Smythies <dsmythies@telus.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 2/2] cpufreq: intel_pstate: Implement QoS supported freq constraints
Date:   Mon, 26 Aug 2019 11:18:25 +0200
Message-ID: <3079552.QM2AybVN8Z@kreacher>
In-Reply-To: <85cdbc41f7f59a79b96793cbdcd49c53f964e46d.1565317135.git.viresh.kumar@linaro.org>
References: <e789eceae3f32a66fff923daeb85b33b88f21fe1.1565161495.git.viresh.kumar@linaro.org> <85cdbc41f7f59a79b96793cbdcd49c53f964e46d.1565317135.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, August 9, 2019 4:22:49 AM CEST Viresh Kumar wrote:
> Intel pstate driver exposes min_perf_pct and max_perf_pct sysfs files,
> which can be used to force a limit on the min/max P state of the driver.
> Though these files eventually control the min/max frequencies that the
> CPUs will run at, they don't make a change to policy->min/max values.
> 
> When the values of these files are changed (in passive mode of the
> driver), it leads to calling ->limits() callback of the cpufreq
> governors, like schedutil. On a call to it the governors shall
> forcefully update the frequency to come within the limits. Since the
> limits, i.e.  policy->min/max, aren't updated by the driver, the
> governors fails to get the target freq within limit and sometimes aborts
> the update believing that the frequency is already set to the target
> value.
> 
> This patch implements the QoS supported frequency constraints to update
> policy->min/max values whenever min_perf_pct or max_perf_pct files are
> updated. This is only done for the passive mode as of now, as the driver
> is already working fine in active mode.
> 
> Fixes: ecd288429126 ("cpufreq: schedutil: Don't set next_freq to UINT_MAX")
> Reported-by: Doug Smythies <dsmythies@telus.net>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V4->V5:
> - dev_pm_qos_update_request() can return 1 in case of success, handle
>   that.
> 
>  drivers/cpufreq/intel_pstate.c | 120 +++++++++++++++++++++++++++++++--
>  1 file changed, 116 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index cc27d4c59dca..32f27563613b 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -24,6 +24,7 @@
>  #include <linux/fs.h>
>  #include <linux/acpi.h>
>  #include <linux/vmalloc.h>
> +#include <linux/pm_qos.h>
>  #include <trace/events/power.h>
>  
>  #include <asm/div64.h>
> @@ -1085,6 +1086,47 @@ static ssize_t store_no_turbo(struct kobject *a, struct kobj_attribute *b,
>  	return count;
>  }
>  
> +static struct cpufreq_driver intel_pstate;
> +
> +static void update_qos_request(enum dev_pm_qos_req_type type)
> +{
> +	int max_state, turbo_max, freq, i, perf_pct;
> +	struct dev_pm_qos_request *req;
> +	struct cpufreq_policy *policy;
> +
> +	for_each_possible_cpu(i) {
> +		struct cpudata *cpu = all_cpu_data[i];
> +
> +		policy = cpufreq_cpu_get(i);
> +		if (!policy)
> +			continue;
> +
> +		req = policy->driver_data;
> +		cpufreq_cpu_put(policy);
> +
> +		if (!req)
> +			continue;
> +
> +		if (hwp_active)
> +			intel_pstate_get_hwp_max(i, &turbo_max, &max_state);
> +		else
> +			turbo_max = cpu->pstate.turbo_pstate;
> +
> +		if (type == DEV_PM_QOS_MIN_FREQUENCY) {
> +			perf_pct = global.min_perf_pct;
> +		} else {
> +			req++;
> +			perf_pct = global.max_perf_pct;
> +		}
> +
> +		freq = DIV_ROUND_UP(turbo_max * perf_pct, 100);
> +		freq *= cpu->pstate.scaling;
> +
> +		if (dev_pm_qos_update_request(req, freq) < 0)
> +			pr_warn("Failed to update freq constraint: CPU%d\n", i);
> +	}
> +}
> +
>  static ssize_t store_max_perf_pct(struct kobject *a, struct kobj_attribute *b,
>  				  const char *buf, size_t count)
>  {
> @@ -1108,7 +1150,10 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct kobj_attribute *b,
>  
>  	mutex_unlock(&intel_pstate_limits_lock);
>  
> -	intel_pstate_update_policies();
> +	if (intel_pstate_driver == &intel_pstate)
> +		intel_pstate_update_policies();
> +	else
> +		update_qos_request(DEV_PM_QOS_MAX_FREQUENCY);
>  
>  	mutex_unlock(&intel_pstate_driver_lock);
>  
> @@ -1139,7 +1184,10 @@ static ssize_t store_min_perf_pct(struct kobject *a, struct kobj_attribute *b,
>  
>  	mutex_unlock(&intel_pstate_limits_lock);
>  
> -	intel_pstate_update_policies();
> +	if (intel_pstate_driver == &intel_pstate)
> +		intel_pstate_update_policies();
> +	else
> +		update_qos_request(DEV_PM_QOS_MIN_FREQUENCY);
>  
>  	mutex_unlock(&intel_pstate_driver_lock);
>  
> @@ -2332,8 +2380,16 @@ static unsigned int intel_cpufreq_fast_switch(struct cpufreq_policy *policy,
>  
>  static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  {
> -	int ret = __intel_pstate_cpu_init(policy);
> +	int max_state, turbo_max, min_freq, max_freq, ret;
> +	struct dev_pm_qos_request *req;
> +	struct cpudata *cpu;
> +	struct device *dev;
> +
> +	dev = get_cpu_device(policy->cpu);
> +	if (!dev)
> +		return -ENODEV;
>  
> +	ret = __intel_pstate_cpu_init(policy);
>  	if (ret)
>  		return ret;
>  
> @@ -2342,7 +2398,63 @@ static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	/* This reflects the intel_pstate_get_cpu_pstates() setting. */
>  	policy->cur = policy->cpuinfo.min_freq;
>  
> +	req = kcalloc(2, sizeof(*req), GFP_KERNEL);
> +	if (!req) {
> +		ret = -ENOMEM;
> +		goto pstate_exit;
> +	}
> +
> +	cpu = all_cpu_data[policy->cpu];
> +
> +	if (hwp_active)
> +		intel_pstate_get_hwp_max(policy->cpu, &turbo_max, &max_state);
> +	else
> +		turbo_max = cpu->pstate.turbo_pstate;
> +
> +	min_freq = DIV_ROUND_UP(turbo_max * global.min_perf_pct, 100);
> +	min_freq *= cpu->pstate.scaling;
> +	max_freq = DIV_ROUND_UP(turbo_max * global.max_perf_pct, 100);
> +	max_freq *= cpu->pstate.scaling;
> +
> +	ret = dev_pm_qos_add_request(dev, req, DEV_PM_QOS_MIN_FREQUENCY,
> +				     min_freq);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to add min-freq constraint (%d)\n", ret);
> +		goto free_req;
> +	}
> +
> +	ret = dev_pm_qos_add_request(dev, req + 1, DEV_PM_QOS_MAX_FREQUENCY,
> +				     max_freq);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to add max-freq constraint (%d)\n", ret);
> +		goto remove_min_req;
> +	}
> +
> +	policy->driver_data = req;
> +
>  	return 0;
> +
> +remove_min_req:
> +	dev_pm_qos_remove_request(req);
> +free_req:
> +	kfree(req);
> +pstate_exit:
> +	intel_pstate_exit_perf_limits(policy);
> +
> +	return ret;
> +}
> +
> +static int intel_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> +{
> +	struct dev_pm_qos_request *req;
> +
> +	req = policy->driver_data;
> +
> +	dev_pm_qos_remove_request(req + 1);
> +	dev_pm_qos_remove_request(req);
> +	kfree(req);
> +
> +	return intel_pstate_cpu_exit(policy);
>  }
>  
>  static struct cpufreq_driver intel_cpufreq = {
> @@ -2351,7 +2463,7 @@ static struct cpufreq_driver intel_cpufreq = {
>  	.target		= intel_cpufreq_target,
>  	.fast_switch	= intel_cpufreq_fast_switch,
>  	.init		= intel_cpufreq_cpu_init,
> -	.exit		= intel_pstate_cpu_exit,
> +	.exit		= intel_cpufreq_cpu_exit,
>  	.stop_cpu	= intel_cpufreq_stop_cpu,
>  	.update_limits	= intel_pstate_update_limits,
>  	.name		= "intel_cpufreq",
> 

Applied, thanks!




