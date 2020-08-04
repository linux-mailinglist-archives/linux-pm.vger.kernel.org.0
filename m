Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E39523B647
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 10:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHDIGH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 04:06:07 -0400
Received: from foss.arm.com ([217.140.110.172]:41176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgHDIGH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Aug 2020 04:06:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9E711FB;
        Tue,  4 Aug 2020 01:06:06 -0700 (PDT)
Received: from [10.37.12.45] (unknown [10.37.12.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 312233F718;
        Tue,  4 Aug 2020 01:06:03 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] memory: samsung: exynos5422-dmc: Add module param
 to control IRQ mode
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     willy.mh.wolff.ml@gmail.com, k.konieczny@samsung.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com, krzk@kernel.org,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, s.nawrocki@samsung.com, kgene@kernel.org
References: <20200710191122.11029-1-lukasz.luba@arm.com>
 <CGME20200710191154eucas1p296561f285ee0730e5040fdfe3fc7e75e@eucas1p2.samsung.com>
 <20200710191122.11029-3-lukasz.luba@arm.com>
 <db571467-48ec-8f11-de1d-00393d8aa99b@samsung.com>
 <ceaa668e-a60b-1916-243b-145b1bc7fc76@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <92348c27-5c0e-56cc-82d5-9b22f190c7b3@arm.com>
Date:   Tue, 4 Aug 2020 09:06:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ceaa668e-a60b-1916-243b-145b1bc7fc76@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Marek,

On 8/3/20 4:35 PM, Marek Szyprowski wrote:
> Hi All,
> 
> On 03.08.2020 17:30, Marek Szyprowski wrote:
>> On 10.07.2020 21:11, Lukasz Luba wrote:
>>> The driver can operate in two modes relaying on devfreq monitoring
>>> mechanism which periodically checks the device status or it can use
>>> interrupts when they are provided by loaded Device Tree. The newly
>>> introduced module parameter can be used to choose between devfreq
>>> monitoring and internal interrupts without modifying the Device Tree.
>>> It also sets devfreq monitoring as default when the parameter is not set
>>> (also the case for default when the driver is not built as a module).
>>>
>>> Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>
>> I've got back from my holidays and noticed that in meantime this
>> commit got merged as commit 4fc9a0470d2d. It revealed that there is a
>> race between registering exynos5422-dmc driver and exynos-ppmu driver,
>> which can be observed sometimes as the following message and freeze on
>> Odroid XU3 with multi_v7_defconfig:
>>
>> [    8.767708] exynos5-dmc 10c20000.memory-controller: couldn't probe
>> performance counters
>>
>> I will check this later why the EPROBE_DEFER error is not properly
>> propagated and why it causes a freeze.
> 
> It looks that simply propagating return value from
> exynos5_counters_get() in exynos5_dmc_get_status() fixes the boot:
> 
> # dmesg | grep dmc
> [    8.838754] exynos-ppmu: new PPMU device registered 10d00000.ppmu
> (ppmu-event3-dmc0_0)
> [    8.861344] exynos-ppmu: new PPMU device registered 10d10000.ppmu
> (ppmu-event3-dmc0_1)
> [    8.868488] exynos5-dmc 10c20000.memory-controller: couldn't probe
> performance counters
> [    8.874417] exynos-ppmu: new PPMU device registered 10d60000.ppmu
> (ppmu-event3-dmc1_0)
> [    8.886612] exynos-ppmu: new PPMU device registered 10d70000.ppmu
> (ppmu-event3-dmc1_1)
> [    9.396769] exynos5-dmc 10c20000.memory-controller: DMC initialized,
> in irq mode: 0
> 
> I'm still curious why it freezes if getting performance counters is not
> possible.
> 
> Best regards
> 

Thank you for investigating this issue. Indeed, it's odd why it freezes.
I've seen you patch with the fix.

Regards,
Lukasz
