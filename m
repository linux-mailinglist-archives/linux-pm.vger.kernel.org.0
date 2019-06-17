Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0FBD495FF
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2019 01:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfFQXhJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 19:37:09 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63973 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbfFQXhI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 19:37:08 -0400
Received: from 79.184.254.20.ipv4.supernova.orange.pl (79.184.254.20) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id dadcab13fd6a5801; Tue, 18 Jun 2019 01:37:06 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/5] cpufreq: Register notifiers with the PM QoS framework
Date:   Tue, 18 Jun 2019 01:37:06 +0200
Message-ID: <1794396.RVx65QvVqq@kreacher>
In-Reply-To: <a275fdd9325f1b2cba046c79930ad59653674455.1560163748.git.viresh.kumar@linaro.org>
References: <cover.1560163748.git.viresh.kumar@linaro.org> <a275fdd9325f1b2cba046c79930ad59653674455.1560163748.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, June 10, 2019 12:51:35 PM CEST Viresh Kumar wrote:
> This registers the notifiers for min/max frequency constraints with the
> PM QoS framework. The constraints are also taken into consideration in
> cpufreq_set_policy().
> 
> This also relocates cpufreq_policy_put_kobj() as it is required to be
> called from cpufreq_policy_alloc() now.
> 
> No constraints are added until now though.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 139 +++++++++++++++++++++++++++++++-------
>  include/linux/cpufreq.h   |   4 ++
>  2 files changed, 120 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 85ff958e01f1..547d221b2ff2 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -26,6 +26,7 @@
>  #include <linux/kernel_stat.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/pm_qos.h>
>  #include <linux/slab.h>
>  #include <linux/suspend.h>
>  #include <linux/syscore_ops.h>
> @@ -1126,11 +1127,77 @@ static void handle_update(struct work_struct *work)
>  	cpufreq_update_policy(cpu);
>  }
>  
> +static void cpufreq_update_freq_work(struct work_struct *work)
> +{
> +	struct cpufreq_policy *policy =
> +		container_of(work, struct cpufreq_policy, req_work);
> +	struct cpufreq_policy new_policy = *policy;
> +
> +	/* We should read constraint values from QoS layer */
> +	new_policy.min = 0;
> +	new_policy.max = UINT_MAX;
> +
> +	down_write(&policy->rwsem);
> +
> +	if (!policy_is_inactive(policy))
> +		cpufreq_set_policy(policy, &new_policy);
> +
> +	up_write(&policy->rwsem);
> +}
> +
> +static int cpufreq_update_freq(struct cpufreq_policy *policy)
> +{
> +	schedule_work(&policy->req_work);
> +	return 0;
> +}
> +
> +static int cpufreq_notifier_min(struct notifier_block *nb, unsigned long freq,
> +				void *data)
> +{
> +	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_min);
> +
> +	return cpufreq_update_freq(policy);
> +}
> +
> +static int cpufreq_notifier_max(struct notifier_block *nb, unsigned long freq,
> +				void *data)
> +{
> +	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_max);
> +
> +	return cpufreq_update_freq(policy);
> +}
> +
> +static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
> +{
> +	struct kobject *kobj;
> +	struct completion *cmp;
> +
> +	down_write(&policy->rwsem);
> +	cpufreq_stats_free_table(policy);
> +	kobj = &policy->kobj;
> +	cmp = &policy->kobj_unregister;
> +	up_write(&policy->rwsem);
> +	kobject_put(kobj);
> +
> +	/*
> +	 * We need to make sure that the underlying kobj is
> +	 * actually not referenced anymore by anybody before we
> +	 * proceed with unloading.
> +	 */
> +	pr_debug("waiting for dropping of refcount\n");
> +	wait_for_completion(cmp);
> +	pr_debug("wait complete\n");
> +}
> +
>  static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>  {
>  	struct cpufreq_policy *policy;
> +	struct device *dev = get_cpu_device(cpu);
>  	int ret;
>  
> +	if (!dev)
> +		return NULL;
> +
>  	policy = kzalloc(sizeof(*policy), GFP_KERNEL);
>  	if (!policy)
>  		return NULL;
> @@ -1147,7 +1214,7 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>  	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
>  				   cpufreq_global_kobject, "policy%u", cpu);
>  	if (ret) {
> -		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
> +		dev_err(dev, "%s: failed to init policy->kobj: %d\n", __func__, ret);
>  		/*
>  		 * The entire policy object will be freed below, but the extra
>  		 * memory allocated for the kobject name needs to be freed by
> @@ -1157,16 +1224,41 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>  		goto err_free_real_cpus;
>  	}
>  
> +	policy->nb_min.notifier_call = cpufreq_notifier_min;
> +	policy->nb_max.notifier_call = cpufreq_notifier_max;
> +
> +	ret = dev_pm_qos_add_notifier(dev, &policy->nb_min,
> +				      DEV_PM_QOS_MIN_FREQUENCY);
> +	if (ret) {
> +		dev_err(dev, "Failed to register MIN QoS notifier: %d (%*pbl)\n",
> +			ret, cpumask_pr_args(policy->cpus));
> +		goto err_kobj_remove;
> +	}
> +
> +	ret = dev_pm_qos_add_notifier(dev, &policy->nb_max,
> +				      DEV_PM_QOS_MAX_FREQUENCY);
> +	if (ret) {
> +		dev_err(dev, "Failed to register MAX QoS notifier: %d (%*pbl)\n",
> +			ret, cpumask_pr_args(policy->cpus));
> +		goto err_min_qos_notifier;
> +	}
> +
>  	INIT_LIST_HEAD(&policy->policy_list);
>  	init_rwsem(&policy->rwsem);
>  	spin_lock_init(&policy->transition_lock);
>  	init_waitqueue_head(&policy->transition_wait);
>  	init_completion(&policy->kobj_unregister);
>  	INIT_WORK(&policy->update, handle_update);
> +	INIT_WORK(&policy->req_work, cpufreq_update_freq_work);

One more thing.

handle_update() is very similar to cpufreq_update_freq_work().

Why are both of them needed?



