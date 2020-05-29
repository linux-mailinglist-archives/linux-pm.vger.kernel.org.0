Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B24D1E729C
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 04:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405317AbgE2Can (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 22:30:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50122 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405151AbgE2Can (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 28 May 2020 22:30:43 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0E5DE91E7189AB9DFF33;
        Fri, 29 May 2020 10:30:40 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.101) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Fri, 29 May 2020
 10:30:32 +0800
Subject: Re: [PATCH v4 1/2] cpufreq: change '.set_boost' to act on only one
 policy
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <viresh.kumar@linaro.org>, <Souvik.Chakravarty@arm.com>,
        <Thanu.Rangarajan@arm.com>, <Sudeep.Holla@arm.com>,
        <guohanjun@huawei.com>, <john.garry@huawei.com>,
        <jonathan.cameron@huawei.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1590118476-28742-1-git-send-email-wangxiongfeng2@huawei.com>
 <1590118476-28742-2-git-send-email-wangxiongfeng2@huawei.com>
 <5425098.HjpDb7yAz6@kreacher>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <1ff97ec7-2111-e4a7-c6d5-9f1c983239e3@huawei.com>
Date:   Fri, 29 May 2020 10:30:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5425098.HjpDb7yAz6@kreacher>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.101]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

Thanks for your reply !

On 2020/5/28 20:48, Rafael J. Wysocki wrote:
> On Friday, May 22, 2020 5:34:35 AM CEST Xiongfeng Wang wrote:
>> Macro 'for_each_active_policy()' is defined internally. To avoid some
>> cpufreq driver needing this macro to iterate over all the policies in
>> '.set_boost' callback, we redefine '.set_boost' to act on only one
>> policy and pass the policy as an argument.
>> 'cpufreq_boost_trigger_state()' iterate over all the policies to set
>> boost for the system. This is preparation for adding SW BOOST support
>> for CPPC.
>>
>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  drivers/cpufreq/acpi-cpufreq.c | 10 ++++----
>>  drivers/cpufreq/cpufreq.c      | 53 +++++++++++++++++++++---------------------
>>  include/linux/cpufreq.h        |  2 +-
>>  3 files changed, 34 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
>> index 289e8ce..813aabf 100644
>> --- a/drivers/cpufreq/acpi-cpufreq.c
>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>> @@ -126,12 +126,14 @@ static void boost_set_msr_each(void *p_en)
>>  	boost_set_msr(enable);
>>  }
>>  
>> -static int set_boost(int val)
>> +static int set_boost(struct cpufreq_policy *policy, int val)
>>  {
>>  	get_online_cpus();
>> -	on_each_cpu(boost_set_msr_each, (void *)(long)val, 1);
>> +	on_each_cpu_mask(policy->cpus, boost_set_msr_each,
>> +			 (void *)(long)val, 1);
>>  	put_online_cpus();
>> -	pr_debug("Core Boosting %sabled.\n", val ? "en" : "dis");
>> +	pr_debug("CPU %*pbl: Core Boosting %sabled.\n",
>> +		 cpumask_pr_args(policy->cpus), val ? "en" : "dis");
>>  
>>  	return 0;
>>  }
>> @@ -162,7 +164,7 @@ static ssize_t store_cpb(struct cpufreq_policy *policy, const char *buf,
>>  	if (ret || val > 1)
>>  		return -EINVAL;
>>  
>> -	set_boost(val);
>> +	set_boost(policy, val);
>>  
>>  	return count;
>>  }
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index d03f250..d0d86b1 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -2532,34 +2532,29 @@ void cpufreq_update_limits(unsigned int cpu)
>>  /*********************************************************************
>>   *               BOOST						     *
>>   *********************************************************************/
>> -static int cpufreq_boost_set_sw(int state)
>> +static int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
>>  {
>> -	struct cpufreq_policy *policy;
>> -
>> -	for_each_active_policy(policy) {
>> -		int ret;
>> -
>> -		if (!policy->freq_table)
>> -			return -ENXIO;
>> +	int ret;
>>  
>> -		ret = cpufreq_frequency_table_cpuinfo(policy,
>> -						      policy->freq_table);
>> -		if (ret) {
>> -			pr_err("%s: Policy frequency update failed\n",
>> -			       __func__);
>> -			return ret;
>> -		}
>> +	if (!policy->freq_table)
>> +		return -ENXIO;
>>  
>> -		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
>> -		if (ret < 0)
>> -			return ret;
>> +	ret = cpufreq_frequency_table_cpuinfo(policy, policy->freq_table);
>> +	if (ret) {
>> +		pr_err("%s: Policy frequency update failed\n", __func__);
>> +		return ret;
>>  	}
>>  
>> +	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
>> +	if (ret < 0)
>> +		return ret;
>> +
>>  	return 0;
>>  }
>>  
>>  int cpufreq_boost_trigger_state(int state)
>>  {
>> +	struct cpufreq_policy *policy;
>>  	unsigned long flags;
>>  	int ret = 0;
>>  
>> @@ -2570,16 +2565,22 @@ int cpufreq_boost_trigger_state(int state)
> 
> AFAICS this gets called via sysfs without any cpufreq locking whatever, so
> I'm not really sure what causes it to be safe with respect to CPU offline /
> online, especially if the ->set_boost() callback only wants to do stuff
> for CPUs that are online.

Thanks for your advice. Yes, we have 'cpu_hotplug_lock' in 'set_boost' in
acpi_cpufreq. But we don't have 'cpu_hotplug_lock' for the general SW BOOST
framework. So I think I will need to move the lock from 'set_boost()' to
'store_cpb()' and add lock in 'cpufreq_boost_trigger_state' for the general SW
BOOST.

Thanks,
Xiongfeng

> 
>>  	cpufreq_driver->boost_enabled = state;
>>  	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>>  
>> -	ret = cpufreq_driver->set_boost(state);
>> -	if (ret) {
>> -		write_lock_irqsave(&cpufreq_driver_lock, flags);
>> -		cpufreq_driver->boost_enabled = !state;
>> -		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>> -
>> -		pr_err("%s: Cannot %s BOOST\n",
>> -		       __func__, state ? "enable" : "disable");
>> +	for_each_active_policy(policy) {
>> +		ret = cpufreq_driver->set_boost(policy, state);
>> +		if (ret)
>> +			goto err_reset_state;
>>  	}
>>  
>> +	return 0;
>> +
>> +err_reset_state:
>> +	write_lock_irqsave(&cpufreq_driver_lock, flags);
>> +	cpufreq_driver->boost_enabled = !state;
>> +	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>> +
>> +	pr_err("%s: Cannot %s BOOST\n",
>> +	       __func__, state ? "enable" : "disable");
>> +
>>  	return ret;
>>  }
>>  
>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> index 67d5950..3494f67 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -367,7 +367,7 @@ struct cpufreq_driver {
>>  
>>  	/* platform specific boost support code */
>>  	bool		boost_enabled;
>> -	int		(*set_boost)(int state);
>> +	int		(*set_boost)(struct cpufreq_policy *policy, int state);
>>  };
>>  
>>  /* flags */
>>
> 
> 
> 
> 
> 
> .
> 

