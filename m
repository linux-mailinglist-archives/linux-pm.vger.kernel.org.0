Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0FFA14F168
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2020 18:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgAaRi2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jan 2020 12:38:28 -0500
Received: from foss.arm.com ([217.140.110.172]:37840 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbgAaRi2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Jan 2020 12:38:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE826FEC;
        Fri, 31 Jan 2020 09:38:27 -0800 (PST)
Received: from [10.37.12.54] (unknown [10.37.12.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 188C23F68E;
        Fri, 31 Jan 2020 09:38:18 -0800 (PST)
Subject: Re: [PATCH 3/3] ARM: exynos_defconfig: Enable Energy Model framework
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     kgene@kernel.org, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, robh+dt@kernel.org, mark.rutland@arm.com,
        dietmar.eggemann@arm.com
References: <20200127215453.15144-1-lukasz.luba@arm.com>
 <CGME20200127215538eucas1p2b8d4886de6f59f6a62257d3d66307c73@eucas1p2.samsung.com>
 <20200127215453.15144-4-lukasz.luba@arm.com>
 <d14546d5-0cd8-c441-c2be-cdeefc8ebb8d@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <ce51e025-edd5-fdfa-9e2a-9270cacf8660@arm.com>
Date:   Fri, 31 Jan 2020 17:38:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d14546d5-0cd8-c441-c2be-cdeefc8ebb8d@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Bartek,

On 1/31/20 1:30 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On 1/27/20 10:54 PM, lukasz.luba@arm.com wrote:
>> From: Lukasz Luba <lukasz.luba@arm.com>
>>
>> Enable the Energy Model (EM) brings possibility to use Energy Aware
>> Scheduler (EAS). This compiles the EM but does not enable to run EAS in
>> default. The EAS only works with SchedUtil - a CPUFreq governor which
>> handles direct requests from the scheduler for the frequency change. Thus,
>> to make EAS working in default, the SchedUtil governor should be
>> configured as default CPUFreq governor. Although, the EAS might be enabled
>> in runtime, when the EM is present for CPUs, the SchedUtil is compiled and
>> then set as CPUFreq governor, i.e.:
>>
>> echo schedutil > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
>> echo schedutil > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
>>
>> To check if EAS is ready to work, the read output from the command below
>> should show '1':
>> cat /proc/sys/kernel/sched_energy_aware
>>
>> To disable EAS in runtime simply 'echo 0' to the file above.
>>
>> Some test results, which stress the scheduler on Odroid-XU3:
>> hackbench -l 500 -s 4096
>> With mainline code and with this patch set.
>>
>> The tests have been made with and without CONFIG_PROVE_LOCKING (PL)
>> (which is set to =y in default exynos_defconfig)
>>
>> 		|		this patch set			| mainline
>> 		|-----------------------------------------------|---------------
>> 		| performance	| SchedUtil	| SchedUtil	| performance
>> 		| governor	| governor	| governor	| governor
>> 		|		| w/o EAS	| w/ EAS	|
>> ----------------|---------------|---------------|---------------|---------------
>> hackbench w/ PL | 12.7s		| 11.7s		| 12.0s		| 13.0s - 12.2s
>> hackbench w/o PL| 9.2s		| 8.1s		| 8.2s		| 9.2s - 8.4s
> 
> Would you happen to have measurements of how much power is
> saved by running hackbench using "SchedUtil governor w/ EAS"
> instead of "SchedUtil governor w/o EAS"?

I need to check if this xu3 ina2xx can aggregate energy or
it's only drained-current-at-that-moment value.

Regards,
Lukasz

> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   arch/arm/configs/exynos_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
>> index 1db857056992..c0f8ecabc607 100644
>> --- a/arch/arm/configs/exynos_defconfig
>> +++ b/arch/arm/configs/exynos_defconfig
>> @@ -18,6 +18,7 @@ CONFIG_ZBOOT_ROM_BSS=0x0
>>   CONFIG_ARM_APPENDED_DTB=y
>>   CONFIG_ARM_ATAG_DTB_COMPAT=y
>>   CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc mem=256M"
>> +CONFIG_ENERGY_MODEL=y
>>   CONFIG_CPU_FREQ=y
>>   CONFIG_CPU_FREQ_STAT=y
>>   CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
