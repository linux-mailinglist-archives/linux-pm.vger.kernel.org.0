Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED5214F047
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2020 16:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgAaP74 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jan 2020 10:59:56 -0500
Received: from foss.arm.com ([217.140.110.172]:37102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728846AbgAaP7z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Jan 2020 10:59:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA5FDFEC;
        Fri, 31 Jan 2020 07:59:54 -0800 (PST)
Received: from [10.37.12.54] (unknown [10.37.12.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45BF73F68E;
        Fri, 31 Jan 2020 07:59:47 -0800 (PST)
Subject: Re: [PATCH 1/3] ARM: exynos_defconfig: Enable SCHED_MC
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kgene@kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        Chanwoo Choi <cw00.choi@samsung.com>, robh+dt@kernel.org,
        mark.rutland@arm.com,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, dietmar.eggemann@arm.com
References: <20200127215453.15144-1-lukasz.luba@arm.com>
 <20200127215453.15144-2-lukasz.luba@arm.com>
 <CAJKOXPedRc3ag6DDUAXSbHk8JcAZbug5HSss9wb8YyLkP7MLaw@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <ae021317-8fda-2bb2-2080-1304fda1420c@arm.com>
Date:   Fri, 31 Jan 2020 15:59:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPedRc3ag6DDUAXSbHk8JcAZbug5HSss9wb8YyLkP7MLaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

Thank you for your review, please see my comments below.

On 1/31/20 12:47 PM, Krzysztof Kozlowski wrote:
> On Mon, 27 Jan 2020 at 22:55, <lukasz.luba@arm.com> wrote:
>>
>> From: Lukasz Luba <lukasz.luba@arm.com>
>>
>> Since the 'capacities-dmips-mhz' are present in the CPU nodes, make use of
>> this knowledge in smarter decisions during scheduling.
>>
>> The values in 'capacities-dmips-mhz' are normilized, this means that i.e.
>> when CPU0's capacities-dmips-mhz=100 and CPU1's 'capacities-dmips-mhz'=50,
>> cpu0 is twice fast as CPU1, at the same frequency. The proper hirarchy
>> in sched_domain topology could exploit the SoC architecture advantages
>> like big.LITTLE.
> 
> I do not quite get how this is related to rationale behind changing defconfig...

It is not strictly about EAS, it is useful in general for big.LITTLE
platform with clusters.

> 
>> Enabling the SCHED_MC will create two levels in
>> sched_domain hierarchy, which might be observed in:
> 
> This is looks more convincing... but still what is the need? To work with EAS?

It is not only for EAS, but in general for the scheduler (load balance,
task's wake-up path, etc). The scheduler algorithms iterate CPUs in the
sched groups. To make better decisions, the information about MC domain
is needed. More about the scheduler domains and i.e. load_balance()
you can find here:

https://www.kernel.org/doc/html/latest/scheduler/sched-domains.html


> 
>> grep . /proc/sys/kernel/sched_domain/cpu*/domain*/{name,flags}
>> /proc/sys/kernel/sched_domain/cpu0/domain0/name:MC
>> /proc/sys/kernel/sched_domain/cpu0/domain1/name:DIE
>> ...
>> /proc/sys/kernel/sched_domain/cpu0/domain0/flags:575
>> /proc/sys/kernel/sched_domain/cpu0/domain1/flags:4223
> 
> Not related to defconfig change and not visible after this commit.

Without this patch there is only one domain: 'domain0' -> 'DIE'
cat /proc/sys/kernel/sched_domain/cpu0/domain0/name
DIE

When you apply this patch you will get two: 'domain0, 'domain1'
grep . /proc/sys/kernel/sched_domain/cpu0/domain?/name 

/proc/sys/kernel/sched_domain/cpu0/domain0/name:MC
/proc/sys/kernel/sched_domain/cpu0/domain1/name:DIE

I can remove it this information, but it is the most important
to spot this difference out.

This is also the main reason I haven't merge the patch 1 + 3.

Regards,
Lukasz

> 
> Best regards,
> Krzysztof
> 
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   arch/arm/configs/exynos_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
>> index e7e4bb5ad8d5..1db857056992 100644
>> --- a/arch/arm/configs/exynos_defconfig
>> +++ b/arch/arm/configs/exynos_defconfig
>> @@ -8,6 +8,7 @@ CONFIG_PERF_EVENTS=y
>>   CONFIG_ARCH_EXYNOS=y
>>   CONFIG_CPU_ICACHE_MISMATCH_WORKAROUND=y
>>   CONFIG_SMP=y
>> +CONFIG_SCHED_MC=y
>>   CONFIG_BIG_LITTLE=y
>>   CONFIG_NR_CPUS=8
>>   CONFIG_HIGHMEM=y
>> --
>> 2.17.1
>>
