Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA351A1FC2
	for <lists+linux-pm@lfdr.de>; Wed,  8 Apr 2020 13:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgDHLX7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Apr 2020 07:23:59 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14525 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbgDHLX7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Apr 2020 07:23:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e8db3e60002>; Wed, 08 Apr 2020 04:22:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 08 Apr 2020 04:23:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 08 Apr 2020 04:23:57 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Apr
 2020 11:23:57 +0000
Received: from [10.24.37.103] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Apr 2020
 11:23:53 +0000
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
 <3ab4136c-8cca-c2f9-d286-b82dac23e720@nvidia.com>
 <20200408055301.jhvu5bc2luu3b5qr@vireshk-i7>
From:   sumitg <sumitg@nvidia.com>
Message-ID: <08307e54-0e14-14a3-7d6a-d59e1e04a683@nvidia.com>
Date:   Wed, 8 Apr 2020 16:54:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200408055301.jhvu5bc2luu3b5qr@vireshk-i7>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586344935; bh=oYFcSb+xjYNh1lFY2wJ0O1MqXnEs9+vbafQpizW2IEQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=iB1I9IcXw9V27t4+8PI4OAE3+gQvSQNfry3VT4hcWVhrBiwyoP597DPogUKCkoT1T
         noPO3H03Ywg4wflAC9Ia4kxBER2iSwLeKpREetVAh7XJCFFi4XPdCIyoTlC/U5um+/
         SJXmDCIWMx0ZcCM6DWwG4RSDzDfGW6fe/qh3A1RwelVKh3QMxSx3yek/CnhqruUCBg
         /YbbOmIC5PlPUdVbHPF2LzBKgiwzdF2OiYj0HeitxVPZiVCJ+DSbg3xxEtSrFKN6YC
         nzUxvfm43RrhlWn1xmRskmWhQ928Nr3TSppfXaHBma2nW+tAxHyFzCMvVKDssd3E7r
         clyE9PtKQW0dg==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 08/04/20 11:23 AM, Viresh Kumar wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 07-04-20, 23:48, sumitg wrote:
>> On 06/04/20 8:25 AM, Viresh Kumar wrote:
>>> On 05-04-20, 00:08, sumitg wrote:
>>>> On 26/03/20 5:20 PM, Viresh Kumar wrote:
>>>>> On 03-12-19, 23:02, Sumit Gupta wrote:
>>>>>> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
>>>>>> +static unsigned int tegra194_get_speed_common(u32 cpu, u32 delay)
>>>>>> +{
>>>>>> +     struct read_counters_work read_counters_work;
>>>>>> +     struct tegra_cpu_ctr c;
>>>>>> +     u32 delta_refcnt;
>>>>>> +     u32 delta_ccnt;
>>>>>> +     u32 rate_mhz;
>>>>>> +
>>>>>> +     read_counters_work.c.cpu = cpu;
>>>>>> +     read_counters_work.c.delay = delay;
>>>>>> +     INIT_WORK_ONSTACK(&read_counters_work.work, tegra_read_counters);
>>>>>> +     queue_work_on(cpu, read_counters_wq, &read_counters_work.work);
>>>>>> +     flush_work(&read_counters_work.work);
>>>>>
>>>>> Why can't this be done in current context ?
>>>>>
>>>> We used work queue instead of smp_call_function_single() to have long delay.
>>>
>>> Please explain completely, you have raised more questions than you
>>> answered :)
>>>
>>> Why do you want to have long delays ?
>>>
>> Long delay value is used to have the observation window long enough for
>> correctly reconstructing the CPU frequency considering noise.
>> In next patch version, changed delay value to 500us which in our tests is
>> considered reliable.
> 
> I understand that you need to put a udelay() while reading the freq from
> hardware, that is fine, but why do you need a workqueue for that? Why can't you
> just read the values directly from the same context ?
> 
The register to read frequency is per core and not accessible to other 
cores. So, we have to execute the function remotely as the target core 
to read frequency might be different from current.
The functions for that are smp_call_function_single or queue_work_on.
We used queue_work_on() to avoid long delay inside ipi interrupt context 
with interrupts disabled.

> --
> viresh
> 
