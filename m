Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9D92F6219
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 14:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbhANNfz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jan 2021 08:35:55 -0500
Received: from foss.arm.com ([217.140.110.172]:50248 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbhANNfy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 Jan 2021 08:35:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C32031FB;
        Thu, 14 Jan 2021 05:35:08 -0800 (PST)
Received: from [10.57.57.156] (unknown [10.57.57.156])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 068F13F719;
        Thu, 14 Jan 2021 05:35:06 -0800 (PST)
Subject: Re: [PATCH v6 2/4] scmi-cpufreq: Move CPU initialisation to probe
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        vireshk@kernel.org, cristian.marussi@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com
References: <20210111154524.20196-1-nicola.mazzucato@arm.com>
 <20210111154524.20196-3-nicola.mazzucato@arm.com>
 <20210112111717.5ds446w2kroxzvhr@vireshk-i7>
 <d167e564-0f6a-4176-283b-8f92d224f537@arm.com>
 <20210114050753.u3b5z6kgbup7xbuh@vireshk-i7>
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
Message-ID: <027a2d94-b804-2c99-ad1a-23927d361fe5@arm.com>
Date:   Thu, 14 Jan 2021 13:37:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20210114050753.u3b5z6kgbup7xbuh@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

many thanks for your suggestions. I will prepare a new version based on those.

Many thanks,
Nicola


On 1/14/21 5:07 AM, Viresh Kumar wrote:
> On 13-01-21, 11:55, Nicola Mazzucato wrote:
>> On 1/12/21 11:17 AM, Viresh Kumar wrote:
>>> This could have been done with a per-cpu variable instead.
>>
>> sure, I can do a DEFINE_PER_CPU() for it if it makes it better.
> 
> If we don't go with the linked list approach, then yes.
>  
>>>> +	for_each_possible_cpu(cpu) {
>>>> +		if (!zalloc_cpumask_var(&cpudata_table[cpu].scmi_shared_cpus,
>>>> +					GFP_KERNEL))
>>>> +			goto out;
>>>> +	}
>>>
>>> You are making a copy of the struct for each CPU and so for a 16 CPUs
>>> sharing their clock lines, you will have 16 copies of the exact same
>>> stuff.
>>>
>>> An optimal approach would be to have a linked-list of this structure
>>> and that will only have 1 node per cpufreq policy.
>>
>> It is allocating space for the cpumask for each of the cpu. No data is copied yet.
> 
> Yes, I was talking about the whole design here.
> 
>> I understand the optimisation, but I don't see a linkage to cpufreq policy to be
>> a good idea. This cpudata is for internal storage of scmi and opp-shared info
>> and it is not tied to cpufreq policy.
> 
> Well, it is going to be the same information for all CPUs of a policy, isn't it
> ?
> 
>> We have moved all the cpu bits to probe
>> and at this stage we have no knowledge of cpufreq polices.
> 
> Yes, but you are reading that information from scmi or DT (empty opp tables) and
> so you know what the cpumasks are going to be set to. The linked list is the
> right solution in my opinion, it is much more optimal.
> 
>>>> +static int scmi_init_device(const struct scmi_handle *handle, int cpu)
>>>> +{
>>>> +	struct device *cpu_dev;
>>>> +	int ret, nr_opp;
>>>> +	struct em_data_callback em_cb = EM_DATA_CB(scmi_get_cpu_power);
>>>> +	bool power_scale_mw;
>>>> +	cpumask_var_t scmi_cpus;
>>>> +
>>>> +	if (!zalloc_cpumask_var(&scmi_cpus, GFP_KERNEL))
>>>> +		return -ENOMEM;
>>>> +
>>>> +	cpumask_set_cpu(cpu, scmi_cpus);
>>>> +
>>>> +	cpu_dev = get_cpu_device(cpu);
>>>> +
>>>> +	ret = scmi_get_sharing_cpus(cpu_dev, scmi_cpus);
>>>
>>> Where do you expect the sharing information to come from in this case
>>> ? DT ?
>>
>> Coming from SCMI perf. The source of info has not changed.
>>
>>>
>>>> +	if (ret) {
>>>> +		dev_warn(cpu_dev, "failed to get sharing cpumask\n");
>>>> +		goto free_cpumask;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * We get here for each CPU. Add OPPs only on those CPUs for which we
>>>> +	 * haven't already done so, or set their OPPs as shared.
>>>> +	 */
>>>> +	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
>>>> +	if (nr_opp <= 0) {
>>>> +		ret = handle->perf_ops->device_opps_add(handle, cpu_dev);
>>>> +		if (ret) {
>>>> +			dev_warn(cpu_dev, "failed to add opps to the device\n");
>>>> +			goto free_cpumask;
>>>> +		}
>>>> +
>>>> +		ret = dev_pm_opp_set_sharing_cpus(cpu_dev, scmi_cpus);
>>>> +		if (ret) {
>>>> +			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
>>>> +				__func__, ret);
>>>> +			goto free_cpumask;
>>>> +		}
>>>> +
>>>> +		nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
>>>
>>> Shouldn't you do this just after adding the OPPs ?
>>
>> This was suggested earlier. It was moved closer to em_registration to where the
>> nr_opp is used. One way or the other as I don't have a strong preference for its
>> place.
> 
> It is better to move it above as this will shorten the error path.
> 
