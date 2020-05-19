Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B0D1D95B6
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 13:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgESL52 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 May 2020 07:57:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4815 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726949AbgESL52 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 19 May 2020 07:57:28 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B53B34391CBB79186702;
        Tue, 19 May 2020 19:57:25 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.101) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Tue, 19 May 2020
 19:57:17 +0800
Subject: Re: [RFC PATCH v3 1/2] cpufreq: change '.set_boost' to act on only
 one policy
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <Souvik.Chakravarty@arm.com>, <Thanu.Rangarajan@arm.com>
CC:     <Sudeep.Holla@arm.com>, <guohanjun@huawei.com>,
        <john.garry@huawei.com>, <jonathan.cameron@huawei.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1589888489-13828-1-git-send-email-wangxiongfeng2@huawei.com>
 <1589888489-13828-2-git-send-email-wangxiongfeng2@huawei.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <060a79bb-00d0-982a-4e4b-1cf4511ccce2@huawei.com>
Date:   Tue, 19 May 2020 19:57:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1589888489-13828-2-git-send-email-wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.101]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2020/5/19 19:41, Xiongfeng Wang wrote:
> Macro 'for_each_active_policy()' is defined internally. To avoid some
> cpufreq driver needing this macro to iterate over all the policies in
> '.set_boost' callback, we redefine '.set_boost' to act on only one
> policy and pass the policy as an argument.
> 'cpufreq_boost_trigger_state()' iterate over all the policies to set
> boost for the system. This is preparation for adding SW BOOST support
> for CPPC.
> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c |  4 ++--
>  drivers/cpufreq/cpufreq.c      | 53 +++++++++++++++++++++---------------------
>  include/linux/cpufreq.h        |  2 +-
>  3 files changed, 30 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 289e8ce..b0a9eb5 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -126,7 +126,7 @@ static void boost_set_msr_each(void *p_en)
>  	boost_set_msr(enable);
>  }
>  
> -static int set_boost(int val)
> +static int set_boost(struct cpufreq_policy *policy, int val)
>  {
>  	get_online_cpus();
>  	on_each_cpu(boost_set_msr_each, (void *)(long)val, 1);
> @@ -162,7 +162,7 @@ static ssize_t store_cpb(struct cpufreq_policy *policy, const char *buf,
>  	if (ret || val > 1)
>  		return -EINVAL;
>  
> -	set_boost(val);
> +	set_boost(policy, val);
>  
>  	return count;
>  }

My original thought is as below. Since '/sys/devices/system/cpu/cpufreq/boost'
can be used to set boost for the system. The file 'cpb' below each policy can be
used to set boost for the policy. But this will change the existing logic.

--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -126,12 +126,14 @@ static void boost_set_msr_each(void *p_en)
        boost_set_msr(enable);
 }

-static int set_boost(int val)
+static int set_boost(struct cpufreq_policy *policy, int val)
 {
        get_online_cpus();
-   on_each_cpu(boost_set_msr_each, (void *)(long)val, 1);
+ on_each_cpu_mask(policy->cpus, boost_set_msr_each,
+                  (void *)(long)val, 1);
        put_online_cpus();
-   pr_debug("Core Boosting %sabled.\n", val ? "en" : "dis");
+ pr_debug("CPU %*pbl: Core Boosting %sabled.\n",
+          cpumask_pr_args(policy->cpus), val ? "en" : "dis");

        return 0;
 }
@@ -162,7 +164,7 @@ static ssize_t store_cpb(struct cpufreq_policy *policy,
const char *buf,
        if (ret || val > 1)
                return -EINVAL;

-   set_boost(val);
+ set_boost(policy, val);

        return count;
 }

> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d03f250..d0d86b1 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
>
>  int cpufreq_boost_trigger_state(int state)
>  {
> +	struct cpufreq_policy *policy;
>  	unsigned long flags;
>  	int ret = 0;
>  
> @@ -2570,16 +2565,22 @@ int cpufreq_boost_trigger_state(int state)
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

Is it better to set 'boost_enabled' after set boost successfully rather than
setting it in the begining and resetting it if setting boost failed.

Thanks,
Xiongfeng

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

