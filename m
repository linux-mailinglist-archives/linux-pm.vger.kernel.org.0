Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2771EDA79
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jun 2020 03:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgFDBcx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jun 2020 21:32:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52400 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725983AbgFDBcx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Jun 2020 21:32:53 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 96913A50AD9BE0EBAFA8;
        Thu,  4 Jun 2020 09:32:51 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.101) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Thu, 4 Jun 2020
 09:32:42 +0800
Subject: Re: [Question]: about 'cpuinfo_cur_freq' shown in sysfs when the CPU
 is in idle state
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <f1773fdc-f6ef-ec28-0c0a-4a09e66ab63b@huawei.com>
 <20200603075200.hbyofgcyiwocl565@vireshk-i7>
 <CAJZ5v0iR3H+PFnJiroNmZcj-a4bCkvT6xB-nd2ntMvakWFOvAg@mail.gmail.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <39d37e1b-7959-9a8f-6876-f2ed4c1dbc37@huawei.com>
Date:   Thu, 4 Jun 2020 09:32:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iR3H+PFnJiroNmZcj-a4bCkvT6xB-nd2ntMvakWFOvAg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.101]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

Thanks for your reply !

On 2020/6/3 21:39, Rafael J. Wysocki wrote:
> On Wed, Jun 3, 2020 at 9:52 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>
>> On 02-06-20, 11:34, Xiongfeng Wang wrote:
>>> Hi Viresh,
>>>
>>> Sorry to disturb you about another problem as follows.
>>>
>>> CPPC use the increment of Desired Performance counter and Reference Performance
>>> counter to get the CPU frequency and show it in sysfs through
>>> 'cpuinfo_cur_freq'. But ACPI CPPC doesn't specifically define the behavior of
>>> these two counters when the CPU is in idle state, such as stop incrementing when
>>> the CPU is in idle state.
>>>
>>> ARMv8.4 Extension inctroduced support for the Activity Monitors Unit (AMU). The
>>> processor frequency cycles and constant frequency cycles in AMU can be used as
>>> Delivered Performance counter and Reference Performance counter. These two
>>> counter in AMU does not increase when the PE is in WFI or WFE. So the increment
>>> is zero when the PE is in WFI/WFE. This cause no issue because
>>> 'cppc_get_rate_from_fbctrs()' in cppc_cpufreq driver will check the increment
>>> and return the desired performance if the increment is zero.
>>>
>>> But when the CPU goes into power down idle state, accessing these two counters
>>> in AMU by memory-mapped address will return zero. Such as CPU1 went into power
>>> down idle state and CPU0 try to get the frequency of CPU1. In this situation,
>>> will display a very big value for 'cpuinfo_cur_freq' in sysfs. Do you have some
>>> advice about this problem ?
>>>
>>> I was thinking about an idea as follows. We can run 'cppc_cpufreq_get_rate()' on
>>> the CPU to be measured, so that we can make sure the CPU is in C0 state when we
>>> access the two counters. Also we can return the actual frequency rather than
>>> desired performance when the CPU is in WFI/WFE. But this modification will
>>> change the existing logical and I am not sure if this will cause some bad effect.
>>>
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>> index 257d726..ded3bcc 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -396,9 +396,10 @@ static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu,
>>>         return cppc_cpufreq_perf_to_khz(cpu, delivered_perf);
>>>  }
>>>
>>> -static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
>>> +static int cppc_cpufreq_get_rate_cpu(void *info)
>>>  {
>>>         struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
>>> + unsigned int cpunum = *(unsigned int *)info;
>>>         struct cppc_cpudata *cpu = all_cpu_data[cpunum];
>>>         int ret;
>>>
>>> @@ -418,6 +419,22 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
>>>         return cppc_get_rate_from_fbctrs(cpu, fb_ctrs_t0, fb_ctrs_t1);
>>>  }
>>>
>>> +static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
>>> +{
>>> + unsigned int ret;
>>> +
>>> + ret = smp_call_on_cpu(cpunum, cppc_cpufreq_get_rate_cpu, &cpunum, true);
>>> +
>>> + /*
>>> +  * convert negative error code to zero, otherwise we will display
>>> +  * an odd value for 'cpuinfo_cur_freq' in sysfs
>>> +  */
>>> + if (ret < 0)
>>> +         ret = 0;
>>> +
>>> + return ret;
>>> +}
>>> +
>>>  static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
>>>  {
>>>         struct cppc_cpudata *cpudata;
>>
>> I don't see any other sane solution, even if this brings the CPU back
>> to normal state and waste power. We should be able to reliably provide
>> value to userspace.
>>
>> Rafael / Sudeep: What you do say ?
> 
> The frequency value obtained by kicking the CPU out of idle
> artificially is bogus, though.  You may as well return a random number
> instead.

Yes, it may return a randowm number as well.

> 
> The frequency of a CPU in an idle state is in fact unknown in the case
> at hand, so returning 0 looks like the cleanest option to me.

I am not sure about how the user will use 'cpuinfo_cur_freq' in sysfs. If I
return 0 when the CPU is idle, when I run a light load on the CPU, I will get a
zero value for 'cpuinfo_cur_freq' when the CPU is idle. When the CPU is not
idle, I will get a non-zero value. The user may feel odd about
'cpuinfo_cur_frreq' switching between a zero value and a non-zero value. They
may hope it can return the frequency when the CPU execute instructions, namely
in C0 state. I am not so sure about the user will look at 'cpuinfo_cur_freq'.

Thanks,
Xiongfeng

> 
> Thanks!
> 
> .
> 

