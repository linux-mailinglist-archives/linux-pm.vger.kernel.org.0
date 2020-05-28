Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550F31E615A
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 14:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389971AbgE1Msy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 08:48:54 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64950 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389993AbgE1Msw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 08:48:52 -0400
Received: from 89-64-85-246.dynamic.chello.pl (89.64.85.246) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 18611134c77e111a; Thu, 28 May 2020 14:48:48 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     viresh.kumar@linaro.org, Souvik.Chakravarty@arm.com,
        Thanu.Rangarajan@arm.com, Sudeep.Holla@arm.com,
        guohanjun@huawei.com, john.garry@huawei.com,
        jonathan.cameron@huawei.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] cpufreq: change '.set_boost' to act on only one policy
Date:   Thu, 28 May 2020 14:48:47 +0200
Message-ID: <5425098.HjpDb7yAz6@kreacher>
In-Reply-To: <1590118476-28742-2-git-send-email-wangxiongfeng2@huawei.com>
References: <1590118476-28742-1-git-send-email-wangxiongfeng2@huawei.com> <1590118476-28742-2-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, May 22, 2020 5:34:35 AM CEST Xiongfeng Wang wrote:
> Macro 'for_each_active_policy()' is defined internally. To avoid some
> cpufreq driver needing this macro to iterate over all the policies in
> '.set_boost' callback, we redefine '.set_boost' to act on only one
> policy and pass the policy as an argument.
> 'cpufreq_boost_trigger_state()' iterate over all the policies to set
> boost for the system. This is preparation for adding SW BOOST support
> for CPPC.
> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 10 ++++----
>  drivers/cpufreq/cpufreq.c      | 53 +++++++++++++++++++++---------------------
>  include/linux/cpufreq.h        |  2 +-
>  3 files changed, 34 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 289e8ce..813aabf 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -126,12 +126,14 @@ static void boost_set_msr_each(void *p_en)
>  	boost_set_msr(enable);
>  }
>  
> -static int set_boost(int val)
> +static int set_boost(struct cpufreq_policy *policy, int val)
>  {
>  	get_online_cpus();
> -	on_each_cpu(boost_set_msr_each, (void *)(long)val, 1);
> +	on_each_cpu_mask(policy->cpus, boost_set_msr_each,
> +			 (void *)(long)val, 1);
>  	put_online_cpus();
> -	pr_debug("Core Boosting %sabled.\n", val ? "en" : "dis");
> +	pr_debug("CPU %*pbl: Core Boosting %sabled.\n",
> +		 cpumask_pr_args(policy->cpus), val ? "en" : "dis");
>  
>  	return 0;
>  }
> @@ -162,7 +164,7 @@ static ssize_t store_cpb(struct cpufreq_policy *policy, const char *buf,
>  	if (ret || val > 1)
>  		return -EINVAL;
>  
> -	set_boost(val);
> +	set_boost(policy, val);
>  
>  	return count;
>  }
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d03f250..d0d86b1 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2532,34 +2532,29 @@ void cpufreq_update_limits(unsigned int cpu)
>  /*********************************************************************
>   *               BOOST						     *
>   *********************************************************************/
> -static int cpufreq_boost_set_sw(int state)
> +static int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
>  {
> -	struct cpufreq_policy *policy;
> -
> -	for_each_active_policy(policy) {
> -		int ret;
> -
> -		if (!policy->freq_table)
> -			return -ENXIO;
> +	int ret;
>  
> -		ret = cpufreq_frequency_table_cpuinfo(policy,
> -						      policy->freq_table);
> -		if (ret) {
> -			pr_err("%s: Policy frequency update failed\n",
> -			       __func__);
> -			return ret;
> -		}
> +	if (!policy->freq_table)
> +		return -ENXIO;
>  
> -		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
> -		if (ret < 0)
> -			return ret;
> +	ret = cpufreq_frequency_table_cpuinfo(policy, policy->freq_table);
> +	if (ret) {
> +		pr_err("%s: Policy frequency update failed\n", __func__);
> +		return ret;
>  	}
>  
> +	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
> +	if (ret < 0)
> +		return ret;
> +
>  	return 0;
>  }
>  
>  int cpufreq_boost_trigger_state(int state)
>  {
> +	struct cpufreq_policy *policy;
>  	unsigned long flags;
>  	int ret = 0;
>  
> @@ -2570,16 +2565,22 @@ int cpufreq_boost_trigger_state(int state)

AFAICS this gets called via sysfs without any cpufreq locking whatever, so
I'm not really sure what causes it to be safe with respect to CPU offline /
online, especially if the ->set_boost() callback only wants to do stuff
for CPUs that are online.

>  	cpufreq_driver->boost_enabled = state;
>  	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>  
> -	ret = cpufreq_driver->set_boost(state);
> -	if (ret) {
> -		write_lock_irqsave(&cpufreq_driver_lock, flags);
> -		cpufreq_driver->boost_enabled = !state;
> -		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> -
> -		pr_err("%s: Cannot %s BOOST\n",
> -		       __func__, state ? "enable" : "disable");
> +	for_each_active_policy(policy) {
> +		ret = cpufreq_driver->set_boost(policy, state);
> +		if (ret)
> +			goto err_reset_state;
>  	}
>  
> +	return 0;
> +
> +err_reset_state:
> +	write_lock_irqsave(&cpufreq_driver_lock, flags);
> +	cpufreq_driver->boost_enabled = !state;
> +	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> +
> +	pr_err("%s: Cannot %s BOOST\n",
> +	       __func__, state ? "enable" : "disable");
> +
>  	return ret;
>  }
>  
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 67d5950..3494f67 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -367,7 +367,7 @@ struct cpufreq_driver {
>  
>  	/* platform specific boost support code */
>  	bool		boost_enabled;
> -	int		(*set_boost)(int state);
> +	int		(*set_boost)(struct cpufreq_policy *policy, int state);
>  };
>  
>  /* flags */
> 




