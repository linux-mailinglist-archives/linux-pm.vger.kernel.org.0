Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504B43AA25F
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 19:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhFPR0r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 13:26:47 -0400
Received: from foss.arm.com ([217.140.110.172]:42728 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229741AbhFPR0r (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Jun 2021 13:26:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AB1E1042;
        Wed, 16 Jun 2021 10:24:40 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 868023F70D;
        Wed, 16 Jun 2021 10:24:37 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] sched/fair: Take thermal pressure into account
 while estimating energy
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com,
        vincent.donnefort@arm.com, Beata.Michalska@arm.com,
        mingo@redhat.com, juri.lelli@redhat.com, rostedt@goodmis.org,
        segall@google.com, mgorman@suse.de, bristot@redhat.com,
        thara.gopinath@linaro.org, amit.kachhap@gmail.com,
        amitk@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
References: <20210614185815.15136-1-lukasz.luba@arm.com>
 <20210614191128.22735-1-lukasz.luba@arm.com>
 <237ef538-c8ca-a103-b2cc-240fc70298fe@arm.com>
 <d214db57-879c-cf3f-caa8-76c2cd369e0d@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <9821712d-be27-a2e7-991c-b0010e23fa70@arm.com>
Date:   Wed, 16 Jun 2021 19:24:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <d214db57-879c-cf3f-caa8-76c2cd369e0d@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/06/2021 18:09, Lukasz Luba wrote:
> 
> On 6/15/21 4:31 PM, Dietmar Eggemann wrote:
>> On 14/06/2021 21:11, Lukasz Luba wrote:

[...]

>> It's important to highlight that this will only fix this issue between
>> schedutil and EAS when it's due to `thermal pressure` (today only via
>> CPU cooling). There are other places which could restrict policy->max
>> via freq_qos_update_request() and EAS will be unaware of it.
> 
> True, but for this I have some other plans.

As long as people are aware of the fact that this was developed to be
beneficial for `EAS - IPA` integration, I'm fine with this.

[...]

>> IMHO, this means that this is catered for the IPA governor then. I'm not
>> sure if this would be beneficial when another thermal governor is used?
> 
> Yes, it will be, the cpufreq_set_cur_state() is called by
> thermal exported function:
> thermal_cdev_update()
>   __thermal_cdev_update()
>     thermal_cdev_set_cur_state()
>       cdev->ops->set_cur_state(cdev, target)
> 
> So it can be called not only by IPA. All governors call it, because
> that's the default mechanism.

True, but I'm still not convinced that it is useful outside `EAS - IPA`.

>> The mechanical side of the code would allow for such benefits, I just
>> don't know if their CPU cooling device + thermal zone setups would cater
>> for this?
> 
> Yes, it's possible. Even for custom vendor governors (modified clones
> of IPA)

Let's stick to mainline here ;-) It's complicated enough ...

[...]

>> Maybe shorter?
>>
>>          struct cpumask *pd_mask = perf_domain_span(pd);
>> -       unsigned long cpu_cap =
>> arch_scale_cpu_capacity(cpumask_first(pd_mask));
>> +       int cpu = cpumask_first(pd_mask);
>> +       unsigned long cpu_cap = arch_scale_cpu_capacity(cpu);
>> +       unsigned long _cpu_cap = cpu_cap -
>> arch_scale_thermal_pressure(cpu);
>>          unsigned long max_util = 0, sum_util = 0;
>> -       unsigned long _cpu_cap = cpu_cap;
>> -       int cpu;
>> -
>> -       _cpu_cap -= arch_scale_thermal_pressure(cpumask_first(pd_mask));
> 
> Could be, but still, the definitions should be sorted from longest on
> top, to shortest at the bottom. I wanted to avoid modifying too many
> lines with this simple patch.

Only if there are no dependencies, but here we have already `cpu_cap ->
pd_mask`. OK, not a big deal.

[...]

>> There is IPA specific code in cpufreq_set_cur_state() ->
>> get_state_freq() which accesses the EM:
>>
>>      ...
>>      return cpufreq_cdev->em->table[idx].frequency;
>>      ...
>>
>> Has it been discussed that the `per-PD max (allowed) CPU capacity` (1)
>> could be stored in the EM from there so that code like the EAS wakeup
>> code (compute_energy()) could retrieve this information from the EM?
> 
> No, we haven't think about this approach in these patch sets.
> The EM structure given to the cpufreq_cooling device and stored in:
> cpufreq_cdev->em should not be modified. There are a few places which
> receive the EM, but they all should not touch it. For those clients
> it's a read-only data structure.
> 
>> And there wouldn't be any need to pass (1) into the EM (like now via
>> em_cpu_energy()).
>> This would be signalling within the EM compared to external signalling
>> via `CPU cooling -> thermal pressure <- EAS wakeup -> EM`.
> 
> I see what you mean, but this might cause some issues in the design
> (per-cpu scmi cpu perf control). Let's use this EM pointer gently ;)

OK, with the requirement that clients see the EM as ro:

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
