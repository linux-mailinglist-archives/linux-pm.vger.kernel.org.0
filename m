Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B53C28BE11
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 18:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403848AbgJLQfA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 12:35:00 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10786 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403815AbgJLQfA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2020 12:35:00 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8485a70000>; Mon, 12 Oct 2020 09:34:47 -0700
Received: from [10.41.23.128] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Oct
 2020 16:34:53 +0000
Subject: Re: [PATCH v2 1/2] cpufreq: tegra194: get consistent cpuinfo_cur_freq
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rjw@rjwysocki.net>, <sudeep.holla@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ksitaraman@nvidia.com>,
        <bbasu@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <1602162066-26442-1-git-send-email-sumitg@nvidia.com>
 <1602162066-26442-2-git-send-email-sumitg@nvidia.com>
 <20201012052227.x3bigztr7fit4jdz@vireshk-i7>
From:   Sumit Gupta <sumitg@nvidia.com>
Message-ID: <20018a6a-e230-c39c-e801-5a3d0dd4c0ec@nvidia.com>
Date:   Mon, 12 Oct 2020 22:04:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201012052227.x3bigztr7fit4jdz@vireshk-i7>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602520487; bh=n1qI8h6lolczD6I+nv4TVNxGO/CQlyYt+0RLcmOfUxM=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=LO+ZSK6aVPbJ/RX5N3pqGWeA342HMfx8yq9HeTcYCC9ooOqIUyE0s3+i02ZnpMuQq
         Oj+rPJLlQv/pPJr/wanp5gJNH9k+cuRcKr+en8UgAiMB8S1BMiXWEmOKIMibGxby1K
         kzCz3faX4NtG+fXpaeDwzLLnz7222ByJc6lIqej5K8ZLP7X0Tnmkaj1YEEz4GdCQXh
         agYSlsVL1rktF6KNHoeQ/f23wnB5GMpZyQXDed/2yqgwGnCaBY66oDVpo+1/4eD/x6
         VLyZBV4uqpUTBpwLinzLsOCOgjm2MkUeKef5llH9vi/cRBeve0IU8BulDo7gNsAOB2
         6TmnXlhoEIPXw==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

>> Frequency returned by 'cpuinfo_cur_freq' using counters is not fixed
>> and keeps changing slightly. This change returns a consistent value
>> from freq_table. If the reconstructed frequency has acceptable delta
>> from the last written value, then return the frequency corresponding
>> to the last written ndiv value from freq_table. Otherwise, print a
>> warning and return the reconstructed freq.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/tegra194-cpufreq.c | 71 +++++++++++++++++++++++++++++++++-----
>>   1 file changed, 62 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
>> index e1d931c..d250e49 100644
>> --- a/drivers/cpufreq/tegra194-cpufreq.c
>> +++ b/drivers/cpufreq/tegra194-cpufreq.c
>> @@ -180,9 +180,70 @@ static unsigned int tegra194_get_speed_common(u32 cpu, u32 delay)
>>        return (rate_mhz * KHZ); /* in KHz */
>>   }
>>
>> +static void get_cpu_ndiv(void *ndiv)
>> +{
>> +     u64 ndiv_val;
>> +
>> +     asm volatile("mrs %0, s3_0_c15_c0_4" : "=r" (ndiv_val) : );
>> +
>> +     *(u64 *)ndiv = ndiv_val;
>> +}
>> +
>> +static void set_cpu_ndiv(void *data)
> 
> You weren't required to do this unnecessary change.
> 
ya, moved the function up to keep both {get_|set_} calls together.

>> +{
>> +     struct cpufreq_frequency_table *tbl = data;
>> +     u64 ndiv_val = (u64)tbl->driver_data;
>> +
>> +     asm volatile("msr s3_0_c15_c0_4, %0" : : "r" (ndiv_val));
>> +}
>> +
>>   static unsigned int tegra194_get_speed(u32 cpu)
>>   {
>> -     return tegra194_get_speed_common(cpu, US_DELAY);
>> +     struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
>> +     struct cpufreq_frequency_table *pos;
>> +     unsigned int rate;
>> +     u64 ndiv;
>> +     int ret;
>> +     u32 cl;
>> +
>> +     if (!cpu_online(cpu))
> 
> This isn't required. The CPU is guaranteed to be online here.
> 
OK, will remove this in next version.

>> +             return -EINVAL;
>> +
>> +     smp_call_function_single(cpu, get_cpu_cluster, &cl, true);
>> +
>> +     if (cl >= data->num_clusters)
> 
> Is it really possible here ? I meant you must have already checked
> this at cpufreq-init level already. Else mark it unlikely at least.
> 
Ya, will remove the check here.

>> +             return -EINVAL;
>> +
>> +     /* reconstruct actual cpu freq using counters */
>> +     rate = tegra194_get_speed_common(cpu, US_DELAY);
>> +
>> +     /* get last written ndiv value */
>> +     ret = smp_call_function_single(cpu, get_cpu_ndiv, &ndiv, true);
>> +     if (ret) {
> 
> What exactly can fail here ? get_cpu_ndiv() can't fail. Do we really
> need this check ? What about WARN_ON_ONCE() ?
> 
OK.

>> +             pr_err("cpufreq: Failed to get ndiv for CPU%d, ret:%d\n",
>> +                    cpu, ret);
>> +             return rate;
>> +     }
>> +
>> +     /*
>> +      * If the reconstructed frequency has acceptable delta from
>> +      * the last written value, then return freq corresponding
>> +      * to the last written ndiv value from freq_table. This is
>> +      * done to return consistent value.
>> +      */
>> +     cpufreq_for_each_valid_entry(pos, data->tables[cl]) {
>> +             if (pos->driver_data != ndiv)
>> +                     continue;
>> +
>> +             if (abs(pos->frequency - rate) > 115200) {
> 
> where does this 115200 comes from ? Strange that it matches tty's baud
> rate :)
>The value is equal to one freq step size.

> This is 115 MHz, right ? Isn't that too big of a delta ?
> 
The is the acceptable delta used during our testing keeping some margin.

>> +                     pr_warn("cpufreq: cpu%d,cur:%u,set:%u,set ndiv:%llu\n",
>> +                             cpu, rate, pos->frequency, ndiv);
>> +             } else {
>> +                     rate = pos->frequency;
>> +             }
>> +             break;
>> +     }
>> +     return rate;
>>   }
> 
> --
> viresh
> 
