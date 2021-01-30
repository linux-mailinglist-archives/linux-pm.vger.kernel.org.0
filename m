Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8D4309391
	for <lists+linux-pm@lfdr.de>; Sat, 30 Jan 2021 10:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhA3Jli (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 30 Jan 2021 04:41:38 -0500
Received: from foss.arm.com ([217.140.110.172]:34122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231901AbhA3JlW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 30 Jan 2021 04:41:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71D6B113E;
        Sat, 30 Jan 2021 01:40:30 -0800 (PST)
Received: from [10.57.44.129] (unknown [10.57.44.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE0423F885;
        Sat, 30 Jan 2021 01:40:28 -0800 (PST)
Subject: Re: [PATCH v6 2/4] scmi-cpufreq: Move CPU initialisation to probe
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        vireshk@kernel.org, morten.rasmussen@arm.com, chris.redpath@arm.com
References: <20210111154524.20196-1-nicola.mazzucato@arm.com>
 <20210111154524.20196-3-nicola.mazzucato@arm.com>
 <20210114165427.GC46841@e120937-lin>
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
Message-ID: <5a4c82bb-093c-3953-c762-835e38be5d31@arm.com>
Date:   Sat, 30 Jan 2021 09:43:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20210114165427.GC46841@e120937-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Cristian,

sorry for my late reply.
Thanks for looking into this.

I am preparing a v7 with suggestions proposed by Viresh which, hopefully, should
remove some unclear parts and resolve your comments.
I had left behind some dealloc, so thanks for spotting!

Many thanks,
Nicola

On 1/14/21 4:54 PM, Cristian Marussi wrote:
> Hi Nicola,
> 
> a few remarks down below.
> 
> On Mon, Jan 11, 2021 at 03:45:22PM +0000, Nicola Mazzucato wrote:
>> Some of the cpu related initialisation can be done at probe stage.
>> This patch moves those initialisations from the ->init callback to the
>> probe stage.
>>
>> This is done in preparation for adding support to retrieve additional
>> information from DT (CPUs sharing v/f lines).
>>
>> Signed-off-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
>> ---
>>  drivers/cpufreq/scmi-cpufreq.c | 180 ++++++++++++++++++++++++---------
>>  1 file changed, 135 insertions(+), 45 deletions(-)
>>
>> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
>> index 15b213ed78fa..4aa97cdc5997 100644
>> --- a/drivers/cpufreq/scmi-cpufreq.c
>> +++ b/drivers/cpufreq/scmi-cpufreq.c
>> @@ -25,6 +25,14 @@ struct scmi_data {
>>  	struct device *cpu_dev;
>>  };
>>  
>> +/* Per-CPU storage for runtime management */
>> +struct scmi_cpudata {
>> +	cpumask_var_t scmi_shared_cpus;
>> +	struct cpufreq_frequency_table *freq_table;
>> +};
>> +
>> +static struct scmi_cpudata *cpudata_table;
>> +
>>  static const struct scmi_handle *handle;
>>  
>>  static unsigned int scmi_cpufreq_get_rate(unsigned int cpu)
>> @@ -120,13 +128,10 @@ scmi_get_cpu_power(unsigned long *power, unsigned long *KHz,
>>  
>>  static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>>  {
>> -	int ret, nr_opp;
>> +	int ret;
>>  	unsigned int latency;
>>  	struct device *cpu_dev;
>>  	struct scmi_data *priv;
>> -	struct cpufreq_frequency_table *freq_table;
>> -	struct em_data_callback em_cb = EM_DATA_CB(scmi_get_cpu_power);
>> -	bool power_scale_mw;
>>  
>>  	cpu_dev = get_cpu_device(policy->cpu);
>>  	if (!cpu_dev) {
>> @@ -134,42 +139,19 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>>  		return -ENODEV;
>>  	}
>>  
>> -	ret = handle->perf_ops->device_opps_add(handle, cpu_dev);
>> -	if (ret) {
>> -		dev_warn(cpu_dev, "failed to add opps to the device\n");
>> -		return ret;
>> -	}
>> -
>> -	ret = scmi_get_sharing_cpus(cpu_dev, policy->cpus);
>> -	if (ret) {
>> -		dev_warn(cpu_dev, "failed to get sharing cpumask\n");
>> -		return ret;
>> -	}
>> -
>> -	ret = dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
>> -	if (ret) {
>> -		dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
>> -			__func__, ret);
>> -		return ret;
>> -	}
>> -
>>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>>  	if (!priv) {
>>  		ret = -ENOMEM;
>>  		goto out_free_opp;
>>  	}
>>  
>> -	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
>> -	if (ret) {
>> -		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
>> -		goto out_free_priv;
>> -	}
>> +	cpumask_copy(policy->cpus, cpudata_table[policy->cpu].scmi_shared_cpus);
>>  
>>  	priv->cpu_dev = cpu_dev;
>>  	priv->domain_id = handle->perf_ops->device_domain_id(cpu_dev);
>>  
>>  	policy->driver_data = priv;
>> -	policy->freq_table = freq_table;
>> +	policy->freq_table = cpudata_table[policy->cpu].freq_table;
>>  
>>  	/* SCMI allows DVFS request for any domain from any CPU */
>>  	policy->dvfs_possible_from_any_cpu = true;
>> @@ -183,23 +165,8 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>>  	policy->fast_switch_possible =
>>  		handle->perf_ops->fast_switch_possible(handle, cpu_dev);
>>  
>> -	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
>> -	if (nr_opp <= 0) {
>> -		dev_err(cpu_dev, "%s: No OPPs for this device: %d\n",
>> -			__func__, ret);
>> -
>> -		ret = -ENODEV;
>> -		goto out_free_priv;
>> -	}
>> -
>> -	power_scale_mw = handle->perf_ops->power_scale_mw_get(handle);
>> -	em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, policy->cpus,
>> -				    power_scale_mw);
>> -
>>  	return 0;
>>  
>> -out_free_priv:
>> -	kfree(priv);
>>  out_free_opp:
>>  	dev_pm_opp_remove_all_dynamic(cpu_dev);
>>  
> 
> My understanding (but I could be wrong given my limited familiarity with
> CPUFREQ ... so bear with me) is that dev_pm_opp_remove_all_dynamic() is
> meant to clean dynamic OPPs added by dev_pm_opp_add() which in turn in
> this driver is folded inside the handle->perf_ops->device_opps_add() call,
> so is not that this call should be added also on the error path inside
> the new scmi_init_device() ? (this was already faulty this way in the
> original code to be honest...if faulty at all :D)
> 
> I added a few such invocations down below as rough untested example of
> what I mean.
> 
>> @@ -210,7 +177,6 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
>>  {
>>  	struct scmi_data *priv = policy->driver_data;
>>  
>> -	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
>>  	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
>>  	kfree(priv);
>>  
>> @@ -231,10 +197,102 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
>>  	.exit	= scmi_cpufreq_exit,
>>  };
>>  
>> +static int scmi_init_cpudata(void)
>> +{
>> +	int cpu;
>> +	unsigned int ncpus = num_possible_cpus();
>> +
>> +	cpudata_table = kzalloc(sizeof(*cpudata_table) * ncpus, GFP_KERNEL);
> Shouldn/t this be a kcalloc() given it's an array allocation, checkpatch
> complains too.
> 
>> +	if (!cpudata_table)
>> +		return -ENOMEM;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		if (!zalloc_cpumask_var(&cpudata_table[cpu].scmi_shared_cpus,
>> +					GFP_KERNEL))
>> +			goto out;
>> +	}
>> +
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
> 			goto free_dynamic_opps;
>> +		}
>> +
>> +		nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
>> +		if (nr_opp <= 0) {
>> +			dev_err(cpu_dev, "%s: No OPPs for this device: %d\n",
>> +				__func__, ret);
>> +
>> +			ret = -ENODEV;
> 			goto free_dynamic_opps;
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
> 		goto free_dynamic_opps;
>> +	}
>> +
>> +	cpumask_copy(cpudata_table[cpu].scmi_shared_cpus, scmi_cpus);
>> +
>    free_dynamic_opps:
> 	   dev_pm_opp_remove_all_dynamic(cpu_dev);
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
> 			goto clean;
>> +		}
>> +	}
>> +
>>  	ret = cpufreq_register_driver(&scmi_cpufreq_driver);
>>  	if (ret) {
>>  		dev_err(dev, "%s: registering cpufreq failed, err: %d\n",
> 
> 	/* clean any dynamic OPPs already set */
> clean:
> 	for_each_possible_cpu(cpu) {
> 		cpu_dev = get_cpu_device(cpu);
> 
> 		dev_pm_opp_remove_all_dynamic(cpu_dev);
> 	}
> 
> 	return ret;
> }
> 
> 
> Thanks
> 
> Cristian
> 
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
>>
