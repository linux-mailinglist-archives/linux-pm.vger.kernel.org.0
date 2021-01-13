Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DBD2F4ABE
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jan 2021 12:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbhAMLxa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jan 2021 06:53:30 -0500
Received: from foss.arm.com ([217.140.110.172]:35162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbhAMLx3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Jan 2021 06:53:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D4FA1042;
        Wed, 13 Jan 2021 03:52:43 -0800 (PST)
Received: from [10.57.55.99] (unknown [10.57.55.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 854153F70D;
        Wed, 13 Jan 2021 03:52:39 -0800 (PST)
Subject: Re: [PATCH v6 2/4] scmi-cpufreq: Move CPU initialisation to probe
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        vireshk@kernel.org, cristian.marussi@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com
References: <20210111154524.20196-1-nicola.mazzucato@arm.com>
 <20210111154524.20196-3-nicola.mazzucato@arm.com>
 <20210112111717.5ds446w2kroxzvhr@vireshk-i7>
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
Message-ID: <d167e564-0f6a-4176-283b-8f92d224f537@arm.com>
Date:   Wed, 13 Jan 2021 11:55:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20210112111717.5ds446w2kroxzvhr@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh, thanks for looking into this.
Please see below.

On 1/12/21 11:17 AM, Viresh Kumar wrote:
> On 11-01-21, 15:45, Nicola Mazzucato wrote:
>> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
>> +static int scmi_init_cpudata(void)
>> +{
>> +	int cpu;
>> +	unsigned int ncpus = num_possible_cpus();
>> +
>> +	cpudata_table = kzalloc(sizeof(*cpudata_table) * ncpus, GFP_KERNEL);
>> +	if (!cpudata_table)
>> +		return -ENOMEM;
> 
> This could have been done with a per-cpu variable instead.

sure, I can do a DEFINE_PER_CPU() for it if it makes it better.

> 
>> +	for_each_possible_cpu(cpu) {
>> +		if (!zalloc_cpumask_var(&cpudata_table[cpu].scmi_shared_cpus,
>> +					GFP_KERNEL))
>> +			goto out;
>> +	}
> 
> You are making a copy of the struct for each CPU and so for a 16 CPUs
> sharing their clock lines, you will have 16 copies of the exact same
> stuff.
> 
> An optimal approach would be to have a linked-list of this structure
> and that will only have 1 node per cpufreq policy.

It is allocating space for the cpumask for each of the cpu. No data is copied yet.
I understand the optimisation, but I don't see a linkage to cpufreq policy to be
a good idea. This cpudata is for internal storage of scmi and opp-shared info
and it is not tied to cpufreq policy. We have moved all the cpu bits to probe
and at this stage we have no knowledge of cpufreq polices.
Or what am I missing?

> 
>> +	return 0;
>> +
>> +out:
>> +	kfree(cpudata_table);
>> +	return -ENOMEM;
>> +}
>> +
>> +static int scmi_init_device(const struct scmi_handle *handle, int cpu)
>> +{
>> +	struct device *cpu_dev;
>> +	int ret, nr_opp;
>> +	struct em_data_callback em_cb = EM_DATA_CB(scmi_get_cpu_power);
>> +	bool power_scale_mw;
>> +	cpumask_var_t scmi_cpus;
>> +
>> +	if (!zalloc_cpumask_var(&scmi_cpus, GFP_KERNEL))
>> +		return -ENOMEM;
>> +
>> +	cpumask_set_cpu(cpu, scmi_cpus);
>> +
>> +	cpu_dev = get_cpu_device(cpu);
>> +
>> +	ret = scmi_get_sharing_cpus(cpu_dev, scmi_cpus);
> 
> Where do you expect the sharing information to come from in this case
> ? DT ?

Coming from SCMI perf. The source of info has not changed.

> 
>> +	if (ret) {
>> +		dev_warn(cpu_dev, "failed to get sharing cpumask\n");
>> +		goto free_cpumask;
>> +	}
>> +
>> +	/*
>> +	 * We get here for each CPU. Add OPPs only on those CPUs for which we
>> +	 * haven't already done so, or set their OPPs as shared.
>> +	 */
>> +	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
>> +	if (nr_opp <= 0) {
>> +		ret = handle->perf_ops->device_opps_add(handle, cpu_dev);
>> +		if (ret) {
>> +			dev_warn(cpu_dev, "failed to add opps to the device\n");
>> +			goto free_cpumask;
>> +		}
>> +
>> +		ret = dev_pm_opp_set_sharing_cpus(cpu_dev, scmi_cpus);
>> +		if (ret) {
>> +			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
>> +				__func__, ret);
>> +			goto free_cpumask;
>> +		}
>> +
>> +		nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
> 
> Shouldn't you do this just after adding the OPPs ?

This was suggested earlier. It was moved closer to em_registration to where the
nr_opp is used. One way or the other as I don't have a strong preference for its
place.

> 
>> +		if (nr_opp <= 0) {
>> +			dev_err(cpu_dev, "%s: No OPPs for this device: %d\n",
>> +				__func__, ret);
>> +
>> +			ret = -ENODEV;
>> +			goto free_cpumask;
>> +		}
>> +
>> +		power_scale_mw = handle->perf_ops->power_scale_mw_get(handle);
>> +		em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, scmi_cpus,
>> +					    power_scale_mw);
>> +	}
>> +
>> +	ret = dev_pm_opp_init_cpufreq_table(cpu_dev,
>> +					    &cpudata_table[cpu].freq_table);
>> +	if (ret) {
>> +		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
>> +		goto free_cpumask;
>> +	}
>> +
>> +	cpumask_copy(cpudata_table[cpu].scmi_shared_cpus, scmi_cpus);
>> +
>> +free_cpumask:
>> +	free_cpumask_var(scmi_cpus);
>> +	return ret;
>> +}
>> +
>>  static int scmi_cpufreq_probe(struct scmi_device *sdev)
>>  {
>>  	int ret;
>>  	struct device *dev = &sdev->dev;
>> +	int cpu;
>> +	struct device *cpu_dev;
> 
> Please keep the list of local variable in decreasing order of their
> length, many people including me prefer it that way.

Apologies, it will get fixed.

> 
>>  
>>  	handle = sdev->handle;
>>  
>> @@ -247,6 +305,24 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
>>  		devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, NULL);
>>  #endif
>>  
>> +	ret = scmi_init_cpudata();
>> +	if (ret) {
>> +		pr_err("%s: init cpu data failed\n", __func__);
>> +		return ret;
>> +	}
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		cpu_dev = get_cpu_device(cpu);
>> +
>> +		ret = scmi_init_device(handle, cpu);
>> +		if (ret) {
>> +			dev_err(cpu_dev, "%s: init device failed\n",
>> +				__func__);
>> +
>> +			return ret;
> 
> You missed undoing scmi_init_cpudata().

Thanks for spotting. I will fix it.

> 
>> +		}
>> +	}
>> +
>>  	ret = cpufreq_register_driver(&scmi_cpufreq_driver);
>>  	if (ret) {
>>  		dev_err(dev, "%s: registering cpufreq failed, err: %d\n",
>> @@ -258,6 +334,20 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
>>  
>>  static void scmi_cpufreq_remove(struct scmi_device *sdev)
>>  {
>> +	int cpu;
>> +	struct device *cpu_dev;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		cpu_dev = get_cpu_device(cpu);
>> +
>> +		dev_pm_opp_free_cpufreq_table(cpu_dev,
>> +					      &cpudata_table[cpu].freq_table);
>> +
>> +		free_cpumask_var(cpudata_table[cpu].scmi_shared_cpus);
>> +	}
>> +
>> +	kfree(cpudata_table);
>> +
>>  	cpufreq_unregister_driver(&scmi_cpufreq_driver);
>>  }
>>  
>> -- 
>> 2.27.0
> 

Many thanks,
Nicola
