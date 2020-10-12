Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462B528BEA8
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 19:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404014AbgJLRGg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 13:06:36 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14820 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404011AbgJLRGg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2020 13:06:36 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f848ca90000>; Mon, 12 Oct 2020 10:04:41 -0700
Received: from [10.41.23.128] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Oct
 2020 17:06:27 +0000
Subject: Re: [PATCH v2 2/2] cpufreq: tegra194: Fix unlisted boot freq warning
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rjw@rjwysocki.net>, <sudeep.holla@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ksitaraman@nvidia.com>,
        <bbasu@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <1602162066-26442-1-git-send-email-sumitg@nvidia.com>
 <1602162066-26442-3-git-send-email-sumitg@nvidia.com>
 <20201012061335.nht4hnn7kdjupakn@vireshk-i7>
From:   Sumit Gupta <sumitg@nvidia.com>
Message-ID: <4fb38a3b-ed26-6c02-e9de-59ce99ce563e@nvidia.com>
Date:   Mon, 12 Oct 2020 22:36:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201012061335.nht4hnn7kdjupakn@vireshk-i7>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602522281; bh=ie/Fj4acUBaQsFdQijWZk+3BtMFnqzGxCLrm9LrQs4I=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=ntZ3XZzRgUBoTpN/QAu1TaiG5Zvji265XxQvtxpjA/TMug16ELujWE3Qzm7x8EKcb
         VkG1KE4fQba7rPVIJeMLTlJe4H8GcLOL+f7dQZQP9EL5222ewgtZRgOO2Py6qplHJ+
         jzylPY62nQ1Wllb2EB8DPowKdUq6nlkq0WJElQKyeqb/Ofz54LnQKp3Q7/vKAUVNin
         YUjQcwtfZtUAU94rfh5NvKwGqNm6FgdQJ4pbbAxv4G9OuB0xckFM/WeXxA6KCAywH6
         6oP+fSULBFZiRKeJaxDm6UxsGXq7gC6JOUB/DoMaMVReyoGX1tkrdO0TYAxWAiERNd
         /wQBOA8D02ZJA==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

>> Warning coming during boot because the boot freq set by bootloader
>> gets filtered out due to big freq steps while creating freq_table.
>> Fix this by setting closest higher frequency from freq_table.
>> Warning:
>>    cpufreq: cpufreq_online: CPU0: Running at unlisted freq
>>    cpufreq: cpufreq_online: CPU0: Unlisted initial frequency changed
>>
>> These warning messages also come during hotplug online of non-boot
>> CPU's while exiting from 'Suspend-to-RAM'. This happens because
>> during exit from 'Suspend-to-RAM', some time is taken to restore
>> last software requested CPU frequency written in register before
>> entering suspend.
> 
> And who does this restoration ?
> 
>> To fix this, adding online hook to wait till the
>> current frequency becomes equal or close to the last requested
>> frequency.
>>
>> Fixes: df320f89359c ("cpufreq: Add Tegra194 cpufreq driver")
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/tegra194-cpufreq.c | 86 ++++++++++++++++++++++++++++++++++----
>>   1 file changed, 79 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
>> index d250e49..cc28b1e3 100644
>> --- a/drivers/cpufreq/tegra194-cpufreq.c
>> +++ b/drivers/cpufreq/tegra194-cpufreq.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/cpufreq.h>
>>   #include <linux/delay.h>
>>   #include <linux/dma-mapping.h>
>> +#include <linux/iopoll.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>>   #include <linux/of_platform.h>
>> @@ -21,7 +22,6 @@
>>   #define KHZ                     1000
>>   #define REF_CLK_MHZ             408 /* 408 MHz */
>>   #define US_DELAY                500
>> -#define US_DELAY_MIN            2
>>   #define CPUFREQ_TBL_STEP_HZ     (50 * KHZ * KHZ)
>>   #define MAX_CNT                 ~0U
>>
>> @@ -249,17 +249,22 @@ static unsigned int tegra194_get_speed(u32 cpu)
>>   static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
>>   {
>>        struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
>> -     u32 cpu;
>> +     u32 cpu = policy->cpu;
>> +     int ret;
>>        u32 cl;
>>
>> -     smp_call_function_single(policy->cpu, get_cpu_cluster, &cl, true);
>> +     if (!cpu_online(cpu))
> 
> Not required to check this.
> 
OK.

>> +             return -EINVAL;
>> +
>> +     ret = smp_call_function_single(cpu, get_cpu_cluster, &cl, true);
>> +     if (ret) {
> 
> Same as in the other patch.
> 
Got.

>> +             pr_err("cpufreq: Failed to get cluster for CPU%d\n", cpu);
>> +             return ret;
>> +     }
>>
>>        if (cl >= data->num_clusters)
>>                return -EINVAL;
>>
>> -     /* boot freq */
>> -     policy->cur = tegra194_get_speed_common(policy->cpu, US_DELAY_MIN);
>> -
>>        /* set same policy for all cpus in a cluster */
>>        for (cpu = (cl * 2); cpu < ((cl + 1) * 2); cpu++)
>>                cpumask_set_cpu(cpu, policy->cpus);
>> @@ -267,7 +272,23 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
>>        policy->freq_table = data->tables[cl];
>>        policy->cpuinfo.transition_latency = TEGRA_CPUFREQ_TRANSITION_LATENCY;
>>
>> -     return 0;
>> +     policy->cur = tegra194_get_speed_common(policy->cpu, US_DELAY);
>> +
>> +     ret = cpufreq_table_validate_and_sort(policy);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* Are we running at unknown frequency ? */
>> +     ret = cpufreq_frequency_table_get_index(policy, policy->cur);
>> +     if (ret == -EINVAL) {
>> +             ret = __cpufreq_driver_target(policy, policy->cur - 1,
>> +                                           CPUFREQ_RELATION_L);
>> +             if (ret)
>> +                     return ret;
> 
>> +             policy->cur = tegra194_get_speed_common(policy->cpu, US_DELAY);
> 
> cpufreq-core will do this anyway, you don't need to do it.
> 
Got.

>> +     }
>> +
>> +     return ret;
>>   }
> 
> I wonder if I should change the pr_warn() in cpufreq-core to pr_info()
> instead, will that help you guys ? Will that still be a problem ? This
> is exactly same as what we do there.
> 
Yes, this will also work. Then we don't need the current patch.
You want me to send a patch with change from pr_warn to pr_info?

>>   static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
>> @@ -285,6 +306,55 @@ static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
>>        return 0;
>>   }
>>
>> +static int tegra194_cpufreq_online(struct cpufreq_policy *policy)
>> +{
>> +     unsigned int interm_freq, last_set_freq;
>> +     struct cpufreq_frequency_table *pos;
>> +     u64 ndiv;
>> +     int ret;
>> +
>> +     if (!cpu_online(policy->cpu))
>> +             return -EINVAL;
>> +
>> +     /* get ndiv for the last frequency request from software  */
>> +     ret = smp_call_function_single(policy->cpu, get_cpu_ndiv, &ndiv, true);
>> +     if (ret) {
>> +             pr_err("cpufreq: Failed to get ndiv for CPU%d\n", policy->cpu);
>> +             return ret;
>> +     }
>> +
>> +     cpufreq_for_each_valid_entry(pos, policy->freq_table) {
>> +             if (pos->driver_data == ndiv) {
>> +                     last_set_freq = pos->frequency;
>> +                     break;
>> +             }
>> +     }
>> +
>> +     policy->cur = tegra194_get_speed_common(policy->cpu, US_DELAY);
>> +     interm_freq =  policy->cur;
>> +
>> +     /*
>> +      * It takes some time to restore the previous frequency while
>> +      * turning-on non-boot cores during exit from SC7(Suspend-to-RAM).
>> +      * So, wait till it reaches the previous value and timeout if the
>> +      * time taken to reach requested freq is >100ms
>> +      */
>> +     ret = read_poll_timeout(tegra194_get_speed_common, policy->cur,
>> +                             abs(policy->cur - last_set_freq) <= 115200, 0,
>> +                             100 * USEC_PER_MSEC, false, policy->cpu,
>> +                             US_DELAY);
> 
> The firmware does this update ? Why do we need to wait for this ? I
> was actually suggesting an empty tegra194_cpufreq_online() routine
> here.
> > --
> viresh
> 
