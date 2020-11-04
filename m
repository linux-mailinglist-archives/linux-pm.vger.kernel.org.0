Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B1D2A6276
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 11:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbgKDKrv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 05:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbgKDKru (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 05:47:50 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E08C0613D3
        for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2020 02:47:49 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id 33so10711410wrl.7
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2020 02:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GU32s5mPA9T+LP1F/Et8vMr9fZ2JQ8mwg1UEQD4eWu8=;
        b=bvkw1V5hKN78NW4QcZv9NyVdAIrb4vlvn+od6Ecp1ixk+F46RTb0wcfOa80Qq18s+w
         HVzrEYJEHvPHzr3yqcX0wjNYt/eAcnYRClzwoZCyAjIR5GIbgvmbeRbAlDhUh4TRskPT
         D0FC72KWXp2Qz6LqicFC9ZDDmaLxqXyRFuUxLfwM97V88Zc9wZV9wxW2Y/dvncM9PRuh
         1x9crXHaHDHOVBrAEeo6Z9f2k/30OpE3Z+72DRH7I96IleySEAe0xurcUUChFAfc0pip
         Qs3QGkfbEL9tf+OwIfK15yME27NfJlaEZ3Z59xfsI59BNK04+Z/HCyqHylbQV6L6PFxw
         guYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GU32s5mPA9T+LP1F/Et8vMr9fZ2JQ8mwg1UEQD4eWu8=;
        b=MSnL6N271s5tsqv8eUnZ+Ja4Qb6hyHhqZiwEnB9jAdCJmN1kqDrLHbXmv0Ka4StkYP
         isEqAO/sKk6K4AfPI2R/dPJLFkSfG5zay6Jw9+AYF3ABAig+SCdpAeN+npQl9ojPSA7C
         GBsViu/w8+ZmD5fNwg+i8vThzK/u/meIYR76VLDMjKyjH0LXUcu/reVEER5bXV8g0sIy
         nVS58iIu8N8mZalYQ+LXRBKFQ/hRkgBS/OqPBzyMEtibf08d1w/nNEuRbEejbDuDhu0P
         nci1wlVE5xxa7xqAcy3IGEPVBKFV9bgy27jGeV71vtj8dfagdi0lwvHiiaErNxsGDlKf
         pdiw==
X-Gm-Message-State: AOAM532uTyrpNJ8E0i8F4tHQEjEdJ9PPSMyrfh9VV+ta7Hz3ugQmBlyw
        kGC51SkWgmFRI53MvJuJxpxOYQ==
X-Google-Smtp-Source: ABdhPJyVVftmmCjQPFNPPQ9Lslx9/HJFb5cVfCD00RdpvBxgIMnw65tEU707bNVVt8vDraA6F+fboQ==
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr30159657wrn.427.1604486867742;
        Wed, 04 Nov 2020 02:47:47 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:9024:99cb:b881:4beb? ([2a01:e34:ed2f:f020:9024:99cb:b881:4beb])
        by smtp.googlemail.com with ESMTPSA id u3sm1950444wrq.19.2020.11.04.02.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 02:47:47 -0800 (PST)
Subject: Re: [PATCH 4/4] powercap/drivers/dtpm: Add CPU energy model based
 support
To:     Lukasz Luba <lukasz.luba@arm.com>
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ebdd4728-9105-49ef-e2a6-a17c2a502f34@linaro.org>
Date:   Wed, 4 Nov 2020 11:47:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e8feea30-e5d5-9504-a42a-99fde9fdd64a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Lukasz,


On 23/10/2020 15:27, Lukasz Luba wrote:
> Hi Daniel,
> 
> 
> On 10/6/20 1:20 PM, Daniel Lezcano wrote:
>> With the powercap dtpm controller, we are able to plug devices with
>> power limitation features in the tree.
>>
>> The following patch introduces the CPU power limitation based on the
>> energy model and the performance states.
>>
>> The power limitation is done at the performance domain level. If some
>> CPUs are unplugged, the corresponding power will be substracted from
>> the performance domain total power.
>>
>> It is up to the platform to initialize the dtpm tree and add the CPU.
>>
>> Here is an example to create a simple tree with one root node called
>> "pkg" and the cpu's performance domains.

[ ... ]

>> +static int set_pd_power_limit(struct powercap_zone *pcz, int cid,
>> +                  u64 power_limit)
>> +{
>> +    struct dtpm *dtpm = to_dtpm(pcz);
>> +    struct dtpm_cpu *dtpm_cpu = dtpm->private;
>> +    struct em_perf_domain *pd;
>> +    unsigned long freq;
>> +    int i, nr_cpus;
>> +
>> +    spin_lock(&dtpm->lock);
>> +
>> +    power_limit = clamp_val(power_limit, dtpm->power_min,
>> dtpm->power_max);
>> +
>> +    pd = em_cpu_get(dtpm_cpu->cpu);
>> +
>> +    nr_cpus = cpumask_weight(to_cpumask(pd->cpus));
>> +
>> +    for (i = 0; i < pd->nr_perf_states; i++) {
>> +
>> +        u64 power = pd->table[i].power * MICROWATT_PER_MILLIWATT;
>> +
>> +        if ((power * nr_cpus) > power_limit)
> 
> We have one node in that DTPM hierarchy tree, which represents all CPUs
> which are in 'related_cpus' mask. I saw below that we just remove the
> node in hotplug.

The last CPU hotplugged will remove the node.

> I have put a comment below asking if we could change the registration,
> which will affect power calculation.
> 
> 
>> +            break;
>> +    }
>> +
>> +    freq = pd->table[i - 1].frequency;
>> +
>> +    freq_qos_update_request(&dtpm_cpu->qos_req, freq);
>> +
>> +    dtpm->power_limit = power_limit;
>> +
>> +    spin_unlock(&dtpm->lock);
>> +
>> +    return 0;
>> +}
>> +
>> +static int get_pd_power_limit(struct powercap_zone *pcz, int cid, u64
>> *data)
>> +{
>> +    struct dtpm *dtpm = to_dtpm(pcz);
>> +
>> +    spin_lock(&dtpm->lock);
>> +    *data = dtpm->power_max;
>> +    spin_unlock(&dtpm->lock);
>> +
>> +    return 0;
>> +}
>> +
>> +static int get_pd_power_uw(struct powercap_zone *pcz, u64 *power_uw)
>> +{
>> +    struct dtpm *dtpm = to_dtpm(pcz);
>> +    struct dtpm_cpu *dtpm_cpu = dtpm->private;
>> +    struct em_perf_domain *pd;
>> +    unsigned long freq;
>> +    int i, nr_cpus;
>> +
>> +    freq = cpufreq_quick_get(dtpm_cpu->cpu);
>> +    pd = em_cpu_get(dtpm_cpu->cpu);
>> +    nr_cpus = cpumask_weight(to_cpumask(pd->cpus));
>> +
>> +    for (i = 0; i < pd->nr_perf_states; i++) {
>> +
>> +        if (pd->table[i].frequency < freq)
>> +            continue;
>> +
>> +        *power_uw = pd->table[i].power *
>> +            MICROWATT_PER_MILLIWATT * nr_cpus;
> 
> Same here, we have 'nr_cpus'.
> 
>> +
>> +        return 0;
>> +    }
>> +
>> +    return -EINVAL;
>> +}
>> +
>> +static int cpu_release_zone(struct powercap_zone *pcz)
>> +{
>> +    struct dtpm *dtpm = to_dtpm(pcz);
>> +    struct dtpm_cpu *dtpm_cpu = dtpm->private;
>> +
>> +    freq_qos_remove_request(&dtpm_cpu->qos_req);
>> +
>> +    return dtpm_release_zone(pcz);
>> +}
>> +
>> +static struct powercap_zone_constraint_ops pd_constraint_ops = {
>> +    .set_power_limit_uw = set_pd_power_limit,
>> +    .get_power_limit_uw = get_pd_power_limit,
>> +};
>> +
>> +static struct powercap_zone_ops pd_zone_ops = {
>> +    .get_power_uw = get_pd_power_uw,
>> +    .release = cpu_release_zone,
>> +};
>> +
>> +static int cpuhp_dtpm_cpu_offline(unsigned int cpu)
>> +{
>> +    struct cpufreq_policy *policy;
>> +    struct em_perf_domain *pd;
>> +    struct dtpm *dtpm;
>> +
>> +    policy = cpufreq_cpu_get(cpu);
>> +
>> +    if (!policy)
>> +        return 0;
>> +
>> +    pd = em_cpu_get(cpu);
>> +    if (!pd)
>> +        return -EINVAL;
>> +
>> +    dtpm = per_cpu(dtpm_per_cpu, cpu);
>> +
>> +    power_sub(dtpm, pd);
>> +
>> +    if (cpumask_weight(policy->cpus) != 1)
>> +        return 0;
>> +
>> +    for_each_cpu(cpu, policy->related_cpus)
>> +        per_cpu(dtpm_per_cpu, cpu) = NULL;
> 
> Hotplugging one CPU would affect others. I would keep them
> all but marked somehow that CPU is offline.

No, the last one will remove the node. This is checked in the test above
(policy->cpus) != 1 ...

>> +
>> +    dtpm_unregister(dtpm);
> 
> Could we keep the node in the hierarchy on CPU hotplug?

[ ... ]

>> diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
>> index 6696bdcfdb87..b62215a13baa 100644
>> --- a/include/linux/dtpm.h
>> +++ b/include/linux/dtpm.h
>> @@ -70,4 +70,7 @@ int dtpm_register_parent(const char *name, struct
>> dtpm *dtpm,
>>   int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm
>> *parent,
>>             struct powercap_zone_ops *ops, int nr_constraints,
>>             struct powercap_zone_constraint_ops *const_ops);
>> +
>> +int dtpm_register_cpu(struct dtpm *parent);
>> +
>>   #endif
>>
> 
> I have a few comments for this DTPM CPU.
> 
> 1. Maybe we can register these CPUs differently. First register
> the parent node as a separate dtpm based on 'policy->related_cpus. Then
> register new children nodes, one for each CPU. When the CPU is up, mark
> it as 'active'.
> 
> 2. We don't remove the node when the CPU is hotplugged, but we mark it
> '!active' Or 'offline'. The power calculation could be done in upper
> node, which takes into account that flag for children.
> 
> 3. We would only remove the node when it's module is unloaded (e.g. GPU)
> 
> That would make the tree more stable and also more detailed.
> We would also account the power properly when one CPU went offline, but
> the other are still there.
> 
> What do you think?

The paradigm of the DTPM is the intermediate nodes (have children), are
aggregating the power of their children and do not represent the real
devices. The leaves are the real devices which are power manageable.

In our case, the CPU DTPM is based on the performance state which is a
group of CPUs, hence it is a leaf of the tree.

I think you misunderstood the power is recomputed when the CPU is
switched on/off and the node is removed when the last CPU is hotplugged.

eg. 1000mW max per CPU, a performance domain with 4 CPUs.

With all CPUs on, max power is 4000mW
With 3 CPUs on, and 1 CPU off, max power is 3000mW

etc...

With 4 CPUs off, the node is removed.

If the hardware evolves with a performance domain per CPU, we will end
up with a leaf per CPU and a "cluster" on top of them.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
