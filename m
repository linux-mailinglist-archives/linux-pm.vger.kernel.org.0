Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F44A33227F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 11:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhCIKBx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 05:01:53 -0500
Received: from foss.arm.com ([217.140.110.172]:50756 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229689AbhCIKBr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Mar 2021 05:01:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85BD831B;
        Tue,  9 Mar 2021 02:01:46 -0800 (PST)
Received: from [10.57.15.199] (unknown [10.57.15.199])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79C6A3F71B;
        Tue,  9 Mar 2021 02:01:45 -0800 (PST)
Subject: Re: [PATCH 5/5] powercap/drivers/dtpm: Scale the power with the load
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210301212149.22877-1-daniel.lezcano@linaro.org>
 <20210301212149.22877-5-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <c30701f5-c1f8-cb5c-8791-f4068fb1bc14@arm.com>
Date:   Tue, 9 Mar 2021 10:01:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210301212149.22877-5-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

I've started reviewing the series, please find some comments below.

On 3/1/21 9:21 PM, Daniel Lezcano wrote:
> Currently the power consumption is based on the current OPP power
> assuming the entire performance domain is fully loaded.
> 
> That gives very gross power estimation and we can do much better by
> using the load to scale the power consumption.
> 
> Use the utilization to normalize and scale the power usage over the
> max possible power.
> 
> Tested on a rock960 with 2 big CPUS, the power consumption estimation
> conforms with the expected one.
> 
> Before this change:
> 
> ~$ ~/dhrystone -t 1 -l 10000&
> ~$ cat /sys/devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:1/constraint_0_max_power_uw
> 2260000
> 
> After this change:
> 
> ~$ ~/dhrystone -t 1 -l 10000&
> ~$ cat /sys/devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:1/constraint_0_max_power_uw
> 1130000
> 
> ~$ ~/dhrystone -t 2 -l 10000&
> ~$ cat /sys/devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:1/constraint_0_max_power_uw
> 2260000
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/powercap/dtpm_cpu.c | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index e728ebd6d0ca..8379b96468ef 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -68,27 +68,40 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
>   	return power_limit;
>   }
>   
> +static u64 scale_pd_power_uw(struct cpumask *cpus, u64 power)

renamed 'cpus' into 'pd_mask', see below

> +{
> +	unsigned long max, util;
> +	int cpu, load = 0;

IMHO 'int load' looks odd when used with 'util' and 'max'.
I would put in the line above to have them all the same type and
renamed to 'sum_util'.

> +
> +	for_each_cpu(cpu, cpus) {

I would avoid the temporary CPU mask in the get_pd_power_uw()
with this modified loop:

for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {


> +		max = arch_scale_cpu_capacity(cpu);
> +		util = sched_cpu_util(cpu, max);
> +		load += ((util * 100) / max);

Below you can find 3 optimizations. Since we are not in the hot
path here, it's up to if you would like to use all/some of them
or just ignore.

1st optimization.
If we use 'load += (util << 10) / max' in the loop, then
we could avoid div by 100 and use a right shift:
(power * load) >> 10

2nd optimization.
Since we use EM CPU mask, which span all CPUs with the same
arch_scale_cpu_capacity(), you can avoid N divs inside the loop
and do it once, below the loop.

3rd optimization.
If we just simply add all 'util' into 'sum_util' (no mul or div in
the loop), then we might just have simple macro

#define CALC_POWER_USAGE(power, sum_util, max) \
	(((power * (sum_util << 10)) / max) >> 10)


> +	}
> +
> +	return (power * load) / 100;
> +}
> +
>   static u64 get_pd_power_uw(struct dtpm *dtpm)
>   {
>   	struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
>   	struct em_perf_domain *pd;
>   	struct cpumask cpus;

Since we don't need the 'nr_cpus' we also don't need the
cpumask which occupy stack; Maybe use
	struct cpumask *pd_mask;

then

>   	unsigned long freq;
> -	int i, nr_cpus;
> +	int i;
>   
>   	pd = em_cpu_get(dtpm_cpu->cpu);
>   	freq = cpufreq_quick_get(dtpm_cpu->cpu);
>   
>   	cpumask_and(&cpus, cpu_online_mask, to_cpumask(pd->cpus));

	remove ^^^^^ and set
	pd_mask = em_span_cpus(pd);

> -	nr_cpus = cpumask_weight(&cpus);
>   
>   	for (i = 0; i < pd->nr_perf_states; i++) {
>   
>   		if (pd->table[i].frequency < freq)
>   			continue;
>   
> -		return pd->table[i].power *
> -			MICROWATT_PER_MILLIWATT * nr_cpus;
> +		return scale_pd_power_uw(&cpus, pd->table[i].power *
> +					 MICROWATT_PER_MILLIWATT);

Instead of '&cpus' I would put 'pd_mask' and that should do the job.

>   	}
>   
>   	return 0;
> 

Apart from that, the design idea with util looks good.

Regards,
Lukasz
