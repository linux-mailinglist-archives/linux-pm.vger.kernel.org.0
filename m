Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D6A1EC70D
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jun 2020 04:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgFCCFh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jun 2020 22:05:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33556 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbgFCCFh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Jun 2020 22:05:37 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2B4E85FC262AB94366C8;
        Wed,  3 Jun 2020 10:05:33 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.93) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Wed, 3 Jun 2020
 10:05:23 +0800
Subject: Re: [Question]: about 'cpuinfo_cur_freq' shown in sysfs when the CPU
 is in idle state
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        <viresh.kumar@linaro.org>, <rjw@rjwysocki.net>
CC:     <Sudeep.Holla@arm.com>, <ionela.voinescu@arm.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <f1773fdc-f6ef-ec28-0c0a-4a09e66ab63b@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <ef524d5f-185d-4ca8-c717-929e59db0813@huawei.com>
Date:   Wed, 3 Jun 2020 10:05:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <f1773fdc-f6ef-ec28-0c0a-4a09e66ab63b@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.213.93]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020/6/2 11:34, Xiongfeng Wang wrote:
> Hi Viresh,
> 
> Sorry to disturb you about another problem as follows.
> 
> CPPC use the increment of Desired Performance counter and Reference Performance
> counter to get the CPU frequency and show it in sysfs through
> 'cpuinfo_cur_freq'. But ACPI CPPC doesn't specifically define the behavior of
> these two counters when the CPU is in idle state, such as stop incrementing when
> the CPU is in idle state.
> 
> ARMv8.4 Extension inctroduced support for the Activity Monitors Unit (AMU). The
> processor frequency cycles and constant frequency cycles in AMU can be used as
> Delivered Performance counter and Reference Performance counter. These two
> counter in AMU does not increase when the PE is in WFI or WFE. So the increment
> is zero when the PE is in WFI/WFE. This cause no issue because
> 'cppc_get_rate_from_fbctrs()' in cppc_cpufreq driver will check the increment
> and return the desired performance if the increment is zero.
> 
> But when the CPU goes into power down idle state, accessing these two counters
> in AMU by memory-mapped address will return zero. Such as CPU1 went into power
> down idle state and CPU0 try to get the frequency of CPU1. In this situation,
> will display a very big value for 'cpuinfo_cur_freq' in sysfs. Do you have some
> advice about this problem ?

Just a wild guess, how about just return 0 for idle CPUs? which means
the frequency is 0 for idle CPUs.

> 
> I was thinking about an idea as follows. We can run 'cppc_cpufreq_get_rate()' on
> the CPU to be measured, so that we can make sure the CPU is in C0 state when we
> access the two counters. Also we can return the actual frequency rather than
> desired performance when the CPU is in WFI/WFE. But this modification will
> change the existing logical and I am not sure if this will cause some bad effect.
> 
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 257d726..ded3bcc 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -396,9 +396,10 @@ static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu,
>          return cppc_cpufreq_perf_to_khz(cpu, delivered_perf);
>   }
> 
> -static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
> +static int cppc_cpufreq_get_rate_cpu(void *info)
>   {
>          struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
> + unsigned int cpunum = *(unsigned int *)info;
>          struct cppc_cpudata *cpu = all_cpu_data[cpunum];
>          int ret;
> 
> @@ -418,6 +419,22 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
>          return cppc_get_rate_from_fbctrs(cpu, fb_ctrs_t0, fb_ctrs_t1);
>   }
> 
> +static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
> +{
> + unsigned int ret;
> +
> + ret = smp_call_on_cpu(cpunum, cppc_cpufreq_get_rate_cpu, &cpunum, true);
> +
> + /*
> +  * convert negative error code to zero, otherwise we will display
> +  * an odd value for 'cpuinfo_cur_freq' in sysfs
> +  */
> + if (ret < 0)
> +         ret = 0;
> +
> + return ret;
> +}
> +
>   static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
>   {
>          struct cppc_cpudata *cpudata;
> 

It will bring the CPU back if the CPU is in idle state, not friendly to
powersaving :)

Thanks
Hanjun

