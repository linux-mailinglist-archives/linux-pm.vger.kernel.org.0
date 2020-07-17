Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBB1223AD2
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jul 2020 13:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgGQLxN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jul 2020 07:53:13 -0400
Received: from foss.arm.com ([217.140.110.172]:34456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbgGQLxM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 Jul 2020 07:53:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4BFC30E;
        Fri, 17 Jul 2020 04:53:11 -0700 (PDT)
Received: from [10.37.12.35] (unknown [10.37.12.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B78F53F66E;
        Fri, 17 Jul 2020 04:53:08 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] memory: samsung: exynos5422-dmc: Add module param
 to control IRQ mode
From:   Lukasz Luba <lukasz.luba@arm.com>
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
 <3154b8d2-1fa8-c69d-8a9d-05832e12fdd1@arm.com>
Message-ID: <baadfe1a-89b6-9fd5-9ea8-e39b458af1aa@arm.com>
Date:   Fri, 17 Jul 2020 12:53:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3154b8d2-1fa8-c69d-8a9d-05832e12fdd1@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/14/20 10:01 AM, Lukasz Luba wrote:
> Hi Bartek,
> 
> On 7/14/20 8:42 AM, Bartlomiej Zolnierkiewicz wrote:
>>
>> Hi,
>>
>> On 7/10/20 9:11 PM, Lukasz Luba wrote:
>>> The driver can operate in two modes relaying on devfreq monitoring
>>> mechanism which periodically checks the device status or it can use
>>> interrupts when they are provided by loaded Device Tree. The newly
>>> introduced module parameter can be used to choose between devfreq
>>> monitoring and internal interrupts without modifying the Device Tree.
>>> It also sets devfreq monitoring as default when the parameter is not set
>>> (also the case for default when the driver is not built as a module).
>>
>> Could you please explain why should we leave the IRQ mode
>> support in the dmc driver?
> 
> I am still experimenting with the IRQ mode in DMC, but have limited time
> for it and no TRM.
> The IRQ mode in memory controller or bus controller has one major
> advantage: is more interactive. In polling we have fixed period, i.e.
> 100ms - that's a lot when we have a sudden, latency sensitive workload.
> There might be no check of the device load for i.e. 99ms, but the tasks
> with such workload started running. That's a long period of a few frames
> which are likely to be junked. Should we adjust polling interval to i.e.
> 10ms, I don't think so. There is no easy way to address all of the
> scenarios.
> 
>>
>> What are the advantages over the polling mode?
> 
> As described above: more reactive to sudden workload, which might be
> latency sensitive and cause junk frames.
> Drawback: not best in benchmarks which are randomly jumping
> over the data set, causing low traffic on memory.
> It could be mitigated as Sylwester described with not only one type
> of interrupt, but another, which could 'observe' also other information
> type in the counters and fire.
> 
>>
>> In what scenarios it should be used?
> 
> System like Android with GUI, when there is this sudden workload
> quite often.
> 
> I think the interconnect could help here and would adjust the DMC
> freq upfront. Although I don't know if interconnect on Exynos5422 is in
> your scope in near future. Of course the interconnect will not cover
> all scenarios either.
> 
> 
>>
>> [ If this is only for documentation purposes then it should be
>>    removed as it would stay in (easily accessible) git history
>>    anyway.. ]
> 
> The current interrupt mode is definitely not perfect and switching
> to devfreq monitoring mode has more sense. On the other hand, it
> still has potential, until there is no interconnect for this SoC.
> I will continue experimenting with irq mode, so I would like to
> still have the code in the driver.
> 
> Regards,
> Lukasz
> 
>>
>> Best regards,
>> -- 
>> Bartlomiej Zolnierkiewicz
>> Samsung R&D Institute Poland
>> Samsung Electronics
>>

Bartek, do you have some objections to the patches or you think
they can be taken via devfreq-next?

Cheers,
Lukasz
