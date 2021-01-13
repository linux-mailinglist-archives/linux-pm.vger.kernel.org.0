Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0042F4AD4
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jan 2021 13:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbhAML6l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jan 2021 06:58:41 -0500
Received: from foss.arm.com ([217.140.110.172]:35246 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbhAML6l (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Jan 2021 06:58:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E7351042;
        Wed, 13 Jan 2021 03:57:55 -0800 (PST)
Received: from [10.57.55.99] (unknown [10.57.55.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 262FA3F70D;
        Wed, 13 Jan 2021 03:57:50 -0800 (PST)
Subject: Re: [PATCH v6 3/4] scmi-cpufreq: Get opp_shared_cpus from opp-v2 for
 EM
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        vireshk@kernel.org, cristian.marussi@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com
References: <20210111154524.20196-1-nicola.mazzucato@arm.com>
 <20210111154524.20196-4-nicola.mazzucato@arm.com>
 <20210112112041.7kjjrrgsqfbuq5mh@vireshk-i7>
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
Message-ID: <9264baca-e4af-c4fd-1de6-17a6147151ef@arm.com>
Date:   Wed, 13 Jan 2021 12:00:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20210112112041.7kjjrrgsqfbuq5mh@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh, thanks for looking into this.
Please see below.

On 1/12/21 11:20 AM, Viresh Kumar wrote:
> On 11-01-21, 15:45, Nicola Mazzucato wrote:
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
>> same performance domain from operating-points-v2 in DT, and pass it on to
>> EM.
>>
>> Signed-off-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
>> ---
>>  drivers/cpufreq/scmi-cpufreq.c | 22 ++++++++++++++++++++--
>>  1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
>> index 4aa97cdc5997..ff6ba6fab58b 100644
>> --- a/drivers/cpufreq/scmi-cpufreq.c
>> +++ b/drivers/cpufreq/scmi-cpufreq.c
>> @@ -226,9 +226,12 @@ static int scmi_init_device(const struct scmi_handle *handle, int cpu)
>>  	struct em_data_callback em_cb = EM_DATA_CB(scmi_get_cpu_power);
>>  	bool power_scale_mw;
>>  	cpumask_var_t scmi_cpus;
>> +	cpumask_var_t opp_shared_cpus;
>>  
>>  	if (!zalloc_cpumask_var(&scmi_cpus, GFP_KERNEL))
>>  		return -ENOMEM;
>> +	if (!zalloc_cpumask_var(&opp_shared_cpus, GFP_KERNEL))
>> +		return -ENOMEM;
>>  
>>  	cpumask_set_cpu(cpu, scmi_cpus);
>>  
>> @@ -240,6 +243,20 @@ static int scmi_init_device(const struct scmi_handle *handle, int cpu)
>>  		goto free_cpumask;
>>  	}
>>  
>> +	/*
>> +	 * The OPP 'sharing cpus' info may come from dt through an empty opp
>> +	 * table and opp-shared. If found, it takes precedence over the SCMI
>> +	 * domain IDs info.
>> +	 */
>> +	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, opp_shared_cpus);
> 
> If this succeeds, you shouldn't even try to call the other
> get_sharing_cpus variant.

IIUC you mean the above scmi_get_sharing_cpus() ?
It is actually required to do so, cause we need the info of SCMI domains,
regardless of the clock-sharing lines. When we have opp-sharing cpus we still
need to control the SCMI domains as usual.

> 
>> +	if (ret || !cpumask_weight(opp_shared_cpus)) {
>> +		/*
>> +		 * Either opp-table is not set or no opp-shared was found,
>> +		 * use the information from SCMI domain IDs.
>> +		 */
>> +		cpumask_copy(opp_shared_cpus, scmi_cpus);
>> +	}
>> +
>>  	/*
>>  	 * We get here for each CPU. Add OPPs only on those CPUs for which we
>>  	 * haven't already done so, or set their OPPs as shared.
>> @@ -252,7 +269,7 @@ static int scmi_init_device(const struct scmi_handle *handle, int cpu)
>>  			goto free_cpumask;
>>  		}
>>  
>> -		ret = dev_pm_opp_set_sharing_cpus(cpu_dev, scmi_cpus);
>> +		ret = dev_pm_opp_set_sharing_cpus(cpu_dev, opp_shared_cpus);
>>  		if (ret) {
>>  			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
>>  				__func__, ret);
>> @@ -269,7 +286,7 @@ static int scmi_init_device(const struct scmi_handle *handle, int cpu)
>>  		}
>>  
>>  		power_scale_mw = handle->perf_ops->power_scale_mw_get(handle);
>> -		em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, scmi_cpus,
>> +		em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, opp_shared_cpus,
>>  					    power_scale_mw);
>>  	}
>>  
>> @@ -284,6 +301,7 @@ static int scmi_init_device(const struct scmi_handle *handle, int cpu)
>>  
>>  free_cpumask:
>>  	free_cpumask_var(scmi_cpus);
>> +	free_cpumask_var(opp_shared_cpus);
>>  	return ret;
>>  }
>>  
>> -- 
>> 2.27.0
> 

Many thanks,
Nicola
