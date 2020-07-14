Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA8021EC02
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 11:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgGNJBX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 05:01:23 -0400
Received: from foss.arm.com ([217.140.110.172]:54276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgGNJBX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Jul 2020 05:01:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3274E31B;
        Tue, 14 Jul 2020 02:01:22 -0700 (PDT)
Received: from [10.37.12.45] (unknown [10.37.12.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 039A83F7BB;
        Tue, 14 Jul 2020 02:01:18 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] memory: samsung: exynos5422-dmc: Add module param
 to control IRQ mode
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, willy.mh.wolff.ml@gmail.com,
        k.konieczny@samsung.com, cw00.choi@samsung.com, krzk@kernel.org,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, s.nawrocki@samsung.com, kgene@kernel.org
References: <20200710191122.11029-1-lukasz.luba@arm.com>
 <CGME20200710191148eucas1p2552537bb911bde44c783d98808efa07f@eucas1p2.samsung.com>
 <20200710191122.11029-3-lukasz.luba@arm.com>
 <1a389137-cab5-124a-e198-8be3bc2ca841@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <3154b8d2-1fa8-c69d-8a9d-05832e12fdd1@arm.com>
Date:   Tue, 14 Jul 2020 10:01:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1a389137-cab5-124a-e198-8be3bc2ca841@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Bartek,

On 7/14/20 8:42 AM, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On 7/10/20 9:11 PM, Lukasz Luba wrote:
>> The driver can operate in two modes relaying on devfreq monitoring
>> mechanism which periodically checks the device status or it can use
>> interrupts when they are provided by loaded Device Tree. The newly
>> introduced module parameter can be used to choose between devfreq
>> monitoring and internal interrupts without modifying the Device Tree.
>> It also sets devfreq monitoring as default when the parameter is not set
>> (also the case for default when the driver is not built as a module).
> 
> Could you please explain why should we leave the IRQ mode
> support in the dmc driver?

I am still experimenting with the IRQ mode in DMC, but have limited time
for it and no TRM.
The IRQ mode in memory controller or bus controller has one major
advantage: is more interactive. In polling we have fixed period, i.e.
100ms - that's a lot when we have a sudden, latency sensitive workload.
There might be no check of the device load for i.e. 99ms, but the tasks
with such workload started running. That's a long period of a few frames
which are likely to be junked. Should we adjust polling interval to i.e.
10ms, I don't think so. There is no easy way to address all of the
scenarios.

> 
> What are the advantages over the polling mode?

As described above: more reactive to sudden workload, which might be
latency sensitive and cause junk frames.
Drawback: not best in benchmarks which are randomly jumping
over the data set, causing low traffic on memory.
It could be mitigated as Sylwester described with not only one type
of interrupt, but another, which could 'observe' also other information
type in the counters and fire.

> 
> In what scenarios it should be used?

System like Android with GUI, when there is this sudden workload
quite often.

I think the interconnect could help here and would adjust the DMC
freq upfront. Although I don't know if interconnect on Exynos5422 is in
your scope in near future. Of course the interconnect will not cover
all scenarios either.


> 
> [ If this is only for documentation purposes then it should be
>    removed as it would stay in (easily accessible) git history
>    anyway.. ]

The current interrupt mode is definitely not perfect and switching
to devfreq monitoring mode has more sense. On the other hand, it
still has potential, until there is no interconnect for this SoC.
I will continue experimenting with irq mode, so I would like to
still have the code in the driver.

Regards,
Lukasz

> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
>> Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/memory/samsung/exynos5422-dmc.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
>> index e03ee35f0ab5..53bfe6b7b703 100644
>> --- a/drivers/memory/samsung/exynos5422-dmc.c
>> +++ b/drivers/memory/samsung/exynos5422-dmc.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/io.h>
>>   #include <linux/mfd/syscon.h>
>>   #include <linux/module.h>
>> +#include <linux/moduleparam.h>
>>   #include <linux/of_device.h>
>>   #include <linux/pm_opp.h>
>>   #include <linux/platform_device.h>
>> @@ -21,6 +22,10 @@
>>   #include "../jedec_ddr.h"
>>   #include "../of_memory.h"
>>   
>> +static int irqmode;
>> +module_param(irqmode, int, 0644);
>> +MODULE_PARM_DESC(irqmode, "Enable IRQ mode (0=off [default], 1=on)");
>> +
>>   #define EXYNOS5_DREXI_TIMINGAREF		(0x0030)
>>   #define EXYNOS5_DREXI_TIMINGROW0		(0x0034)
>>   #define EXYNOS5_DREXI_TIMINGDATA0		(0x0038)
>> @@ -1428,7 +1433,7 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
>>   	/* There is two modes in which the driver works: polling or IRQ */
>>   	irq[0] = platform_get_irq_byname(pdev, "drex_0");
>>   	irq[1] = platform_get_irq_byname(pdev, "drex_1");
>> -	if (irq[0] > 0 && irq[1] > 0) {
>> +	if (irq[0] > 0 && irq[1] > 0 && irqmode) {
>>   		ret = devm_request_threaded_irq(dev, irq[0], NULL,
>>   						dmc_irq_thread, IRQF_ONESHOT,
>>   						dev_name(dev), dmc);
>> @@ -1485,7 +1490,7 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
>>   	if (dmc->in_irq_mode)
>>   		exynos5_dmc_start_perf_events(dmc, PERF_COUNTER_START_VALUE);
>>   
>> -	dev_info(dev, "DMC initialized\n");
>> +	dev_info(dev, "DMC initialized, in irq mode: %d\n", dmc->in_irq_mode);
>>   
>>   	return 0;
>>   
>>
> 
