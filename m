Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD9110C64D
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 11:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfK1KBr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 05:01:47 -0500
Received: from foss.arm.com ([217.140.110.172]:33012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfK1KBr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 28 Nov 2019 05:01:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90F1B1FB;
        Thu, 28 Nov 2019 02:01:46 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 130FA3F6C4;
        Thu, 28 Nov 2019 02:01:44 -0800 (PST)
Subject: Re: [PATCH] cpufreq: vexpress-spc: Fix wrong alternation of
 policy->related_cpus during CPU hp
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191127114801.23837-1-dietmar.eggemann@arm.com>
 <20191127120816.GC29301@bogus> <20191127121402.vd3tul4gmqm6qtyb@vireshk-i7>
 <20191127133200.GE29301@bogus> <a60cab69-4d47-d418-94bd-74630bf9e846@arm.com>
 <20191127154029.GA4826@bogus> <20191128023116.3skwbeowk7wtjaxc@vireshk-i7>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <0e1cf1c3-3790-3032-2843-04a112de1411@arm.com>
Date:   Thu, 28 Nov 2019 11:01:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191128023116.3skwbeowk7wtjaxc@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/11/2019 03:31, Viresh Kumar wrote:
> On 27-11-19, 15:40, Sudeep Holla wrote:
>> diff --git i/arch/arm/mach-vexpress/spc.c w/arch/arm/mach-vexpress/spc.c
>> index 354e0e7025ae..e0e2e789a0b7 100644
>> --- i/arch/arm/mach-vexpress/spc.c
>> +++ w/arch/arm/mach-vexpress/spc.c
>> @@ -551,8 +551,9 @@ static struct clk *ve_spc_clk_register(struct device *cpu_dev)
>>
>>  static int __init ve_spc_clk_init(void)
>>  {
>> -       int cpu;
>> +       int cpu, cluster;
>>         struct clk *clk;
>> +       bool init_opp_table[MAX_CLUSTERS] = { false };
>>
>>         if (!info)
>>                 return 0; /* Continue only if SPC is initialised */
>> @@ -578,8 +579,17 @@ static int __init ve_spc_clk_init(void)
>>                         continue;
>>                 }
>>
>> +               cluster = topology_physical_package_id(cpu_dev->id);
>> +               if (init_opp_table[cluster])
>> +                       continue;
>> +
>>                 if (ve_init_opp_table(cpu_dev))
>>                         pr_warn("failed to initialise cpu%d opp table\n", cpu);
>> +               else if (dev_pm_opp_set_sharing_cpus(cpu_dev,
>> +                        topology_core_cpumask(cpu_dev->id)))
>> +                       pr_warn("failed to mark OPPs shared for cpu%d\n", cpu);
>> +
>> +               init_opp_table[cluster] = true;
>>         }
>>
>>         platform_device_register_simple("vexpress-spc-cpufreq", -1, NULL, 0);
>> diff --git i/drivers/cpufreq/vexpress-spc-cpufreq.c w/drivers/cpufreq/vexpress-spc-cpufreq.c
>> index 506e3f2bf53a..83c85d3d67e3 100644
>> --- i/drivers/cpufreq/vexpress-spc-cpufreq.c
>> +++ w/drivers/cpufreq/vexpress-spc-cpufreq.c
>> @@ -434,7 +434,7 @@ static int ve_spc_cpufreq_init(struct cpufreq_policy *policy)
>>         if (cur_cluster < MAX_CLUSTERS) {
>>                 int cpu;
>>
>> -               cpumask_copy(policy->cpus, topology_core_cpumask(policy->cpu));
>> +               dev_pm_opp_get_sharing_cpus(cpu_dev, policy->cpus);
>>
>>                 for_each_cpu(cpu, policy->cpus)
>>                         per_cpu(physical_cluster, cpu) = cur_cluster;
> 
> This is a better *work-around* I would say, as we can't break it the
> way I explained earlier :)

I do agree. Tested CPU hp stress on TC2 and it looks good.

Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
