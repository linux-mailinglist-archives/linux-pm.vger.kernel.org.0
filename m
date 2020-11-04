Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766DD2A62BC
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 11:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgKDK5c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 05:57:32 -0500
Received: from foss.arm.com ([217.140.110.172]:35146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgKDK5c (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Nov 2020 05:57:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEFF513D5;
        Wed,  4 Nov 2020 02:57:31 -0800 (PST)
Received: from [10.57.20.87] (unknown [10.57.20.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67C743F718;
        Wed,  4 Nov 2020 02:57:25 -0800 (PST)
Subject: Re: [PATCH 4/4] powercap/drivers/dtpm: Add CPU energy model based
 support
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Mike Leach <mike.leach@linaro.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Steven Price <steven.price@arm.com>
References: <20201006122024.14539-1-daniel.lezcano@linaro.org>
 <20201006122024.14539-5-daniel.lezcano@linaro.org>
 <e8feea30-e5d5-9504-a42a-99fde9fdd64a@arm.com>
 <ebdd4728-9105-49ef-e2a6-a17c2a502f34@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <58408860-1add-c7a3-4c7e-eafb0b6ae16c@arm.com>
Date:   Wed, 4 Nov 2020 10:57:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ebdd4728-9105-49ef-e2a6-a17c2a502f34@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/4/20 10:47 AM, Daniel Lezcano wrote:
> 
> Hi Lukasz,
> 
> 
> On 23/10/2020 15:27, Lukasz Luba wrote:
>> Hi Daniel,
>>
>>
>> On 10/6/20 1:20 PM, Daniel Lezcano wrote:
>>> With the powercap dtpm controller, we are able to plug devices with
>>> power limitation features in the tree.
>>>
>>> The following patch introduces the CPU power limitation based on the
>>> energy model and the performance states.
>>>
>>> The power limitation is done at the performance domain level. If some
>>> CPUs are unplugged, the corresponding power will be substracted from
>>> the performance domain total power.
>>>
>>> It is up to the platform to initialize the dtpm tree and add the CPU.
>>>
>>> Here is an example to create a simple tree with one root node called
>>> "pkg" and the cpu's performance domains.
> 
> [ ... ]
> 
>>> +static int set_pd_power_limit(struct powercap_zone *pcz, int cid,
>>> +                  u64 power_limit)
>>> +{
>>> +    struct dtpm *dtpm = to_dtpm(pcz);
>>> +    struct dtpm_cpu *dtpm_cpu = dtpm->private;
>>> +    struct em_perf_domain *pd;
>>> +    unsigned long freq;
>>> +    int i, nr_cpus;
>>> +
>>> +    spin_lock(&dtpm->lock);
>>> +
>>> +    power_limit = clamp_val(power_limit, dtpm->power_min,
>>> dtpm->power_max);
>>> +
>>> +    pd = em_cpu_get(dtpm_cpu->cpu);
>>> +
>>> +    nr_cpus = cpumask_weight(to_cpumask(pd->cpus));
>>> +
>>> +    for (i = 0; i < pd->nr_perf_states; i++) {
>>> +
>>> +        u64 power = pd->table[i].power * MICROWATT_PER_MILLIWATT;
>>> +
>>> +        if ((power * nr_cpus) > power_limit)
>>
>> We have one node in that DTPM hierarchy tree, which represents all CPUs
>> which are in 'related_cpus' mask. I saw below that we just remove the
>> node in hotplug.
> 
> The last CPU hotplugged will remove the node.
> 
>> I have put a comment below asking if we could change the registration,
>> which will affect power calculation.
>>
>>
>>> +            break;
>>> +    }
>>> +
>>> +    freq = pd->table[i - 1].frequency;
>>> +
>>> +    freq_qos_update_request(&dtpm_cpu->qos_req, freq);
>>> +
>>> +    dtpm->power_limit = power_limit;
>>> +
>>> +    spin_unlock(&dtpm->lock);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int get_pd_power_limit(struct powercap_zone *pcz, int cid, u64
>>> *data)
>>> +{
>>> +    struct dtpm *dtpm = to_dtpm(pcz);
>>> +
>>> +    spin_lock(&dtpm->lock);
>>> +    *data = dtpm->power_max;
>>> +    spin_unlock(&dtpm->lock);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int get_pd_power_uw(struct powercap_zone *pcz, u64 *power_uw)
>>> +{
>>> +    struct dtpm *dtpm = to_dtpm(pcz);
>>> +    struct dtpm_cpu *dtpm_cpu = dtpm->private;
>>> +    struct em_perf_domain *pd;
>>> +    unsigned long freq;
>>> +    int i, nr_cpus;
>>> +
>>> +    freq = cpufreq_quick_get(dtpm_cpu->cpu);
>>> +    pd = em_cpu_get(dtpm_cpu->cpu);
>>> +    nr_cpus = cpumask_weight(to_cpumask(pd->cpus));
>>> +
>>> +    for (i = 0; i < pd->nr_perf_states; i++) {
>>> +
>>> +        if (pd->table[i].frequency < freq)
>>> +            continue;
>>> +
>>> +        *power_uw = pd->table[i].power *
>>> +            MICROWATT_PER_MILLIWATT * nr_cpus;
>>
>> Same here, we have 'nr_cpus'.
>>
>>> +
>>> +        return 0;
>>> +    }
>>> +
>>> +    return -EINVAL;
>>> +}
>>> +
>>> +static int cpu_release_zone(struct powercap_zone *pcz)
>>> +{
>>> +    struct dtpm *dtpm = to_dtpm(pcz);
>>> +    struct dtpm_cpu *dtpm_cpu = dtpm->private;
>>> +
>>> +    freq_qos_remove_request(&dtpm_cpu->qos_req);
>>> +
>>> +    return dtpm_release_zone(pcz);
>>> +}
>>> +
>>> +static struct powercap_zone_constraint_ops pd_constraint_ops = {
>>> +    .set_power_limit_uw = set_pd_power_limit,
>>> +    .get_power_limit_uw = get_pd_power_limit,
>>> +};
>>> +
>>> +static struct powercap_zone_ops pd_zone_ops = {
>>> +    .get_power_uw = get_pd_power_uw,
>>> +    .release = cpu_release_zone,
>>> +};
>>> +
>>> +static int cpuhp_dtpm_cpu_offline(unsigned int cpu)
>>> +{
>>> +    struct cpufreq_policy *policy;
>>> +    struct em_perf_domain *pd;
>>> +    struct dtpm *dtpm;
>>> +
>>> +    policy = cpufreq_cpu_get(cpu);
>>> +
>>> +    if (!policy)
>>> +        return 0;
>>> +
>>> +    pd = em_cpu_get(cpu);
>>> +    if (!pd)
>>> +        return -EINVAL;
>>> +
>>> +    dtpm = per_cpu(dtpm_per_cpu, cpu);
>>> +
>>> +    power_sub(dtpm, pd);
>>> +
>>> +    if (cpumask_weight(policy->cpus) != 1)
>>> +        return 0;
>>> +
>>> +    for_each_cpu(cpu, policy->related_cpus)
>>> +        per_cpu(dtpm_per_cpu, cpu) = NULL;
>>
>> Hotplugging one CPU would affect others. I would keep them
>> all but marked somehow that CPU is offline.
> 
> No, the last one will remove the node. This is checked in the test above
> (policy->cpus) != 1 ...
> 
>>> +
>>> +    dtpm_unregister(dtpm);
>>
>> Could we keep the node in the hierarchy on CPU hotplug?
> 
> [ ... ]
> 
>>> diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
>>> index 6696bdcfdb87..b62215a13baa 100644
>>> --- a/include/linux/dtpm.h
>>> +++ b/include/linux/dtpm.h
>>> @@ -70,4 +70,7 @@ int dtpm_register_parent(const char *name, struct
>>> dtpm *dtpm,
>>>    int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm
>>> *parent,
>>>              struct powercap_zone_ops *ops, int nr_constraints,
>>>              struct powercap_zone_constraint_ops *const_ops);
>>> +
>>> +int dtpm_register_cpu(struct dtpm *parent);
>>> +
>>>    #endif
>>>
>>
>> I have a few comments for this DTPM CPU.
>>
>> 1. Maybe we can register these CPUs differently. First register
>> the parent node as a separate dtpm based on 'policy->related_cpus. Then
>> register new children nodes, one for each CPU. When the CPU is up, mark
>> it as 'active'.
>>
>> 2. We don't remove the node when the CPU is hotplugged, but we mark it
>> '!active' Or 'offline'. The power calculation could be done in upper
>> node, which takes into account that flag for children.
>>
>> 3. We would only remove the node when it's module is unloaded (e.g. GPU)
>>
>> That would make the tree more stable and also more detailed.
>> We would also account the power properly when one CPU went offline, but
>> the other are still there.
>>
>> What do you think?
> 
> The paradigm of the DTPM is the intermediate nodes (have children), are
> aggregating the power of their children and do not represent the real
> devices. The leaves are the real devices which are power manageable.

OK, I see, it makes sense. Thanks for the explanation.

> 
> In our case, the CPU DTPM is based on the performance state which is a
> group of CPUs, hence it is a leaf of the tree.
> 
> I think you misunderstood the power is recomputed when the CPU is
> switched on/off and the node is removed when the last CPU is hotplugged.

Yes, you are right. I misunderstood the hotplug and then power calc.

> 
> eg. 1000mW max per CPU, a performance domain with 4 CPUs.
> 
> With all CPUs on, max power is 4000mW
> With 3 CPUs on, and 1 CPU off, max power is 3000mW
> 
> etc...
> 
> With 4 CPUs off, the node is removed.
> 
> If the hardware evolves with a performance domain per CPU, we will end
> up with a leaf per CPU and a "cluster" on top of them.
> 
> 

Let me go again through the patches and then I will add my reviewed by.

I will also run LTP hotplug or LISA hotplug torture on this tree,
just to check it's fine.

Regards,
Lukasz
