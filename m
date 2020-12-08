Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C772D243B
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 08:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgLHHVc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 02:21:32 -0500
Received: from foss.arm.com ([217.140.110.172]:43324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgLHHVb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Dec 2020 02:21:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB0D130E;
        Mon,  7 Dec 2020 23:20:45 -0800 (PST)
Received: from [10.57.34.152] (unknown [10.57.34.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AB3B3F718;
        Mon,  7 Dec 2020 23:20:43 -0800 (PST)
Subject: Re: [PATCH v4 3/4] scmi-cpufreq: get opp_shared_cpus from opp-v2 for
 EM
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com,
        daniel.lezcano@linaro.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com
References: <20201202172356.10508-1-nicola.mazzucato@arm.com>
 <20201202172356.10508-4-nicola.mazzucato@arm.com>
 <20201208055053.kggxw26kxtnpneua@vireshk-i7>
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
Message-ID: <0e4d3134-f9b2-31fa-b454-fb30265a80b5@arm.com>
Date:   Tue, 8 Dec 2020 07:22:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20201208055053.kggxw26kxtnpneua@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

thanks for looking into this. Please find below

On 12/8/20 5:50 AM, Viresh Kumar wrote:
> On 02-12-20, 17:23, Nicola Mazzucato wrote:
>> By design, SCMI performance domains define the granularity of
>> performance controls, they do not describe any underlying hardware
>> dependencies (although they may match in many cases).
>>
>> It is therefore possible to have some platforms where hardware may have
>> the ability to control CPU performance at different granularity and choose
>> to describe fine-grained performance control through SCMI.
>>
>> In such situations, the energy model would be provided with inaccurate
>> information based on controls, while it still needs to know the
>> performance boundaries.
>>
>> To restore correct functionality, retrieve information of CPUs under the
>> same v/f domain from operating-points-v2 in DT, and pass it on to EM.
>>
>> Signed-off-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
>> ---
>>  drivers/cpufreq/scmi-cpufreq.c | 51 +++++++++++++++++++++++-----------
>>  1 file changed, 35 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
>> index 491a0a24fb1e..f505efcc62b1 100644
>> --- a/drivers/cpufreq/scmi-cpufreq.c
>> +++ b/drivers/cpufreq/scmi-cpufreq.c
>> @@ -127,6 +127,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>>  	struct cpufreq_frequency_table *freq_table;
>>  	struct em_data_callback em_cb = EM_DATA_CB(scmi_get_cpu_power);
>>  	bool power_scale_mw;
>> +	cpumask_var_t opp_shared_cpus;
>>  
>>  	cpu_dev = get_cpu_device(policy->cpu);
>>  	if (!cpu_dev) {
>> @@ -134,30 +135,45 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>>  		return -ENODEV;
>>  	}
>>  
>> -	ret = handle->perf_ops->device_opps_add(handle, cpu_dev);
>> -	if (ret) {
>> -		dev_warn(cpu_dev, "failed to add opps to the device\n");
>> -		return ret;
>> -	}
>> +	if (!zalloc_cpumask_var(&opp_shared_cpus, GFP_KERNEL))
>> +		return -ENOMEM;
>>  
>>  	ret = scmi_get_sharing_cpus(cpu_dev, policy->cpus);
>>  	if (ret) {
>>  		dev_warn(cpu_dev, "failed to get sharing cpumask\n");
>> -		return ret;
>> +		goto out_free_cpumask;
>>  	}
>>  
>> -	ret = dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
>> -	if (ret) {
>> -		dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
>> -			__func__, ret);
>> -		return ret;
>> +	/*
>> +	 * The OPP 'sharing cpus' info may come from dt through an empty opp
>> +	 * table and opp-shared. If found, it takes precedence over the SCMI
>> +	 * domain IDs info.
>> +	 */
>> +	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, opp_shared_cpus);
>> +	if (ret || !cpumask_weight(opp_shared_cpus)) {
>> +		/*
>> +		 * Either opp-table is not set or no opp-shared was found,
>> +		 * use the information from SCMI domain IDs.
>> +		 */
>> +		cpumask_copy(opp_shared_cpus, policy->cpus);
>>  	}
>>  
>>  	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
>>  	if (nr_opp <= 0) {
>> -		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
>> -		ret = -EPROBE_DEFER;
>> -		goto out_free_opp;
>> +		ret = handle->perf_ops->device_opps_add(handle, cpu_dev);
>> +		if (ret) {
>> +			dev_warn(cpu_dev, "failed to add opps to the device\n");
>> +			goto out_free_cpumask;
>> +		}
>> +
>> +		ret = dev_pm_opp_set_sharing_cpus(cpu_dev, opp_shared_cpus);
>> +		if (ret) {
>> +			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
>> +				__func__, ret);
>> +			goto out_free_cpumask;
>> +		}
>> +
> 
> Why do we need to call above two after calling
> dev_pm_opp_get_opp_count() ?

Sorry, I am not sure to understand your question here. If there are no opps for
a device we want to add them to it, otherwise no need as they would be duplicated.

And we don't check the return value of
> the below call anymore, moreover we have to call it twice now.

This second get_opp_count is required such that we register em with the correct
opp number after having added them. Without this the opp_count would not be correct.

Hope I have answered your questions.
> 
>> +		nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
>>  	}
>>  
>>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>> @@ -191,15 +207,18 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>>  		handle->perf_ops->fast_switch_possible(handle, cpu_dev);
>>  
>>  	power_scale_mw = handle->perf_ops->power_scale_mw_get(handle);
>> -	em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, policy->cpus,
>> +	em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, opp_shared_cpus,
>>  				    power_scale_mw);
>>  
>> -	return 0;
>> +	ret = 0;
> 
> ret is already 0 here.

true, nice spot, thanks

> 
>> +	goto out_free_cpumask;
>>  
>>  out_free_priv:
>>  	kfree(priv);
>>  out_free_opp:
>>  	dev_pm_opp_remove_all_dynamic(cpu_dev);
>> +out_free_cpumask:
>> +	free_cpumask_var(opp_shared_cpus);
>>  
>>  	return ret;
>>  }
>> -- 
>> 2.27.0
> 
