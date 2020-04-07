Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C101A136B
	for <lists+linux-pm@lfdr.de>; Tue,  7 Apr 2020 20:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgDGSR7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Apr 2020 14:17:59 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8286 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgDGSR7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Apr 2020 14:17:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e8cc36f0000>; Tue, 07 Apr 2020 11:16:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Apr 2020 11:17:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Apr 2020 11:17:58 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Apr
 2020 18:17:57 +0000
Received: from [10.24.37.103] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Apr 2020
 18:17:53 +0000
From:   sumitg <sumitg@nvidia.com>
Subject: Re: [TEGRA194_CPUFREQ Patch 2/3] cpufreq: Add Tegra194 cpufreq driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rjw@rjwysocki.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <bbasu@nvidia.com>,
        <mperttunen@nvidia.com>, <sumitg@nvidia.com>
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
 <1575394348-17649-2-git-send-email-sumitg@nvidia.com>
 <20200326115023.xy3n5bl7uetuw7mx@vireshk-i7>
 <d233b26b-6b50-7d41-9f33-a5dc151e0e7d@nvidia.com>
 <20200406025549.qfwzlk3745y3r274@vireshk-i7>
Message-ID: <3ab4136c-8cca-c2f9-d286-b82dac23e720@nvidia.com>
Date:   Tue, 7 Apr 2020 23:48:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200406025549.qfwzlk3745y3r274@vireshk-i7>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586283375; bh=1T8Mav91EqAdJ7H6yxiF8ECC4x0Y7inBotcMr+uv4UU=;
        h=X-PGP-Universal:From:Subject:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=DXJxJwgV63yMneG9NLjEmWWUAkmrYMcc7CHERtAKRPWQdrWD/1IzJDVG1OoovZLbz
         oYIIJk7Yd35G4cW1OGxRcbfeSPgB7GGtOMiKbRDwaRfo8svzcr3wC+EEaREzKJ0Jwp
         utHFXro6HYDCeB/2BYvjOWpryJhSebyxPb+BtHFa/vROP22IkGkmOkFWkG0pwjmCyo
         Y1dX+geavXWWcTspY2UmpHcGrNVEc44rYvupoD3gIVqM4wUrwQbAtAe3x/1XgEI4S2
         2hizYx3N8sdj8sMRJd2PFxBn56xiAEcOoXndN+G/JqUbYcKNBgwFAyBhKt50O0vNyy
         CfpxLfWxiv/Vw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 06/04/20 8:25 AM, Viresh Kumar wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 05-04-20, 00:08, sumitg wrote:
>>
>>
>> On 26/03/20 5:20 PM, Viresh Kumar wrote:
>>> On 03-12-19, 23:02, Sumit Gupta wrote:
>>>> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
>>>> +enum cluster {
>>>> +     CLUSTER0,
>>>> +     CLUSTER1,
>>>> +     CLUSTER2,
>>>> +     CLUSTER3,
>>>
>>> All these have same CPUs ? Or big little kind of stuff ? How come they
>>> have different frequency tables ?
>>>
>> T194 SOC has homogeneous architecture where each cluster has two symmetric
>> Carmel cores and and not big little. LUT's are per cluster and all LUT's
>> have same values currently. Future SOC's may have different LUT values per
>> cluster.
> 
> LUT ?
>
LUT is "Lookup Table" which provides "hardware frequency request" as a 
function of voltage. For each frequency, the table can have multiple 
voltages based on temperature. The table is maintained in "BPMP R5".

>>>> +     MAX_CLUSTERS,
>>>> +};
> 
>>>> +static unsigned int tegra194_get_speed_common(u32 cpu, u32 delay)
>>>> +{
>>>> +     struct read_counters_work read_counters_work;
>>>> +     struct tegra_cpu_ctr c;
>>>> +     u32 delta_refcnt;
>>>> +     u32 delta_ccnt;
>>>> +     u32 rate_mhz;
>>>> +
>>>> +     read_counters_work.c.cpu = cpu;
>>>> +     read_counters_work.c.delay = delay;
>>>> +     INIT_WORK_ONSTACK(&read_counters_work.work, tegra_read_counters);
>>>> +     queue_work_on(cpu, read_counters_wq, &read_counters_work.work);
>>>> +     flush_work(&read_counters_work.work);
>>>
>>> Why can't this be done in current context ?
>>>
>> We used work queue instead of smp_call_function_single() to have long delay.
> 
> Please explain completely, you have raised more questions than you
> answered :)
> 
> Why do you want to have long delays ?
> 
Long delay value is used to have the observation window long enough for 
correctly reconstructing the CPU frequency considering noise.
In next patch version, changed delay value to 500us which in our tests 
is considered reliable.

>>>> +static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
>>>> +{
>>>> +     struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
>>>> +     int cluster = get_cpu_cluster(policy->cpu);
>>>> +
>>>> +     if (cluster >= data->num_clusters)
>>>> +             return -EINVAL;
>>>> +
>>>> +     policy->cur = tegra194_fast_get_speed(policy->cpu); /* boot freq */
>>>> +
>>>> +     /* set same policy for all cpus */
>>>> +     cpumask_copy(policy->cpus, cpu_possible_mask);
>>>
>>> You are copying cpu_possible_mask mask here, and so this routine will
>>> get called only once.
>>>
>>> I still don't understand the logic behind clusters and frequency
>>> tables.
>>>
>> Currently, we use same policy for all CPU's to maximize throughput. Will add
>> separate patch later to set policy as per cluster. But we are not using that
>> in T194 due to perf reasons.
> 
> You can't misrepresent the hardware this way, sorry.
> 
ok. Updated the policy to be per cluster now.

> Again few questions, I understand that you have multiple clusters
> here:
> 
> - All clusters will always have the frequency table ?
Yes, frequency table is per cluster.

> - All clusters are capable of having a different frequency at any
>    point of time ? Or they will always run at same freq ?
>
Yes, all clusters are capable to run at different frequencies.

>>>> +     freqs.old = policy->cur;
>>>> +     freqs.new = tbl->frequency;
>>>> +
>>>> +     cpufreq_freq_transition_begin(policy, &freqs);
>>>> +     on_each_cpu_mask(policy->cpus, set_cpu_ndiv, tbl, true);
>>>
>>> When CPUs share clock line, why is this required for every CPU ?
>>> Per core NVFREQ_REQ system register is written to make frequency
>> requests for the core. Cluster h/w then forwards the max(core0, core1)
>> request to cluster NAFLL.
> 
> You mean that each cluster can set frequency independently ?
> 
Yes.

> If all the clusters can run at independent frequencies but you still
> want them to run at same frequency, then that can be done with a
> single set of governor tunables, which is the default anyway. So this
> should just work for you.
> 
> I will not be reviewing the v2 version you sent for now as that is
> most likely wrong anyway.
> 
> --
> viresh
> 
