Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8CE283EEC
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 20:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgJESlb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 14:41:31 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18816 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgJESlb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 14:41:31 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7b68c90002>; Mon, 05 Oct 2020 11:41:13 -0700
Received: from [10.24.37.103] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 5 Oct
 2020 18:40:18 +0000
Subject: Re: [Patch 1/2] cpufreq: tegra194: get consistent cpuinfo_cur_freq
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rjw@rjwysocki.net>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ksitaraman@nvidia.com>,
        <bbasu@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <1600276277-7290-1-git-send-email-sumitg@nvidia.com>
 <1600276277-7290-2-git-send-email-sumitg@nvidia.com>
 <20201005044621.t3stylpbsvzhxtyr@vireshk-i7>
From:   Sumit Gupta <sumitg@nvidia.com>
Message-ID: <69929ea0-0304-3bbe-fd33-40f50791a0ec@nvidia.com>
Date:   Tue, 6 Oct 2020 00:10:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201005044621.t3stylpbsvzhxtyr@vireshk-i7>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601923278; bh=0bk80uFfUoVDAgV24Vm7g3jBPiC3DpODVsAsPneRk0I=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=BlKiMMCfdVZvY4zvTG3b6mgy+4VEJiAX3cwTK/w+ge8PXBtO1JETAEbthi8KM4gOj
         AVtpHjlyhmm8wezrva1/F4tUr8f8GRYAH68hz/Rhqmge1TNNivS98ZWkS2DgU6NCU8
         ADX0PqhOOfx7kAcDYbN2RHRuXoheVTwP/FIbMQzprZluAm0Y2a4RFHLahAlrrTZ01t
         gAB+is+mLv0IJAyznUT4hG2LZrwPlRS4ke74k77BH0YbROc+DmMKcrzgf5B1y4Ab8B
         +0rKc1DOGZ1RpQMnSJXMMDVCqi7FKMRcg2u9kdLva+enT0aZwfHSJy4yb/fHEv9ORP
         EyKvSOsKruXvA==
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
>>   drivers/cpufreq/tegra194-cpufreq.c | 66 ++++++++++++++++++++++++++++++++------
>>   1 file changed, 57 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
>> index e1d931c..d5b608d 100644
>> --- a/drivers/cpufreq/tegra194-cpufreq.c
>> +++ b/drivers/cpufreq/tegra194-cpufreq.c
>> @@ -180,9 +180,65 @@ static unsigned int tegra194_get_speed_common(u32 cpu, u32 delay)
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
>> +     struct cpufreq_frequency_table *table, *pos;
>> +     struct cpufreq_policy policy;
>> +     unsigned int rate;
>> +     u64 ndiv;
>> +     int err;
>> +
>> +     cpufreq_get_policy(&policy, cpu);
>> +     table = policy.freq_table;
> 
> Maybe getting freq-table from cluster specific data would be better/faster.
> 
will do the change in next patch version.

>> +
>> +     /* reconstruct actual cpu freq using counters*/
>> +     rate = tegra194_get_speed_common(cpu, US_DELAY);
>> +
>> +     /* get last written ndiv value*/
>> +     err = smp_call_function_single(cpu, get_cpu_ndiv, &ndiv, true);
>> +     if (err) {
>> +             pr_err("cpufreq: Failed to get ndiv for CPU%d, ret:%d\n",
>> +                    cpu, err);
>> +             return rate;
>> +     }
>> +
>> +     /* if the reconstructed frequency has acceptable delta from
> 
> Both have got the multi-line comments wrong. Format is wrong and every sentence
> needs to start with a capital letter.
> 
will correct.

>> +      * the last written value, then return freq corresponding
>> +      * to the last written ndiv value from freq_table. This is
>> +      * done to return consistent value.
>> +      */
>> +     cpufreq_for_each_valid_entry(pos, table) {
>> +             if (pos->driver_data != ndiv)
>> +                     continue;
>> +
>> +             if (abs(pos->frequency - rate) > 115200) {
>> +                     pr_warn("cpufreq: high delta (%d) on CPU%d\n",
>> +                             abs(pos->frequency - rate), cpu);
>> +                     pr_warn("cpufreq: cur:%u, set:%u, set ndiv:%llu\n",
>> +                             rate, pos->frequency, ndiv);
> 
> Both of these can be merged in a single line I think. There is no need to print
> delta as you already print both the frequencies.
> 
Will do this also in next patch version.

>> +             } else {
>> +                     rate = pos->frequency;
>> +             }
>> +             break;
>> +     }
>> +     return rate;
>>   }
>>
>>   static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
>> @@ -209,14 +265,6 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
>>        return 0;
>>   }
>>
>> -static void set_cpu_ndiv(void *data)
>> -{
>> -     struct cpufreq_frequency_table *tbl = data;
>> -     u64 ndiv_val = (u64)tbl->driver_data;
>> -
>> -     asm volatile("msr s3_0_c15_c0_4, %0" : : "r" (ndiv_val));
>> -}
>> -
>>   static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
>>                                       unsigned int index)
>>   {
>> --
>> 2.7.4
> 
> --
> viresh
> 
