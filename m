Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6D4C14F0BD
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2020 17:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgAaQma (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jan 2020 11:42:30 -0500
Received: from foss.arm.com ([217.140.110.172]:37410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbgAaQma (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Jan 2020 11:42:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E032FEC;
        Fri, 31 Jan 2020 08:42:29 -0800 (PST)
Received: from [10.37.12.54] (unknown [10.37.12.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D8D23F68E;
        Fri, 31 Jan 2020 08:42:11 -0800 (PST)
Subject: Re: [PATCH 2/3] ARM: dts: exynos: Add Exynos5422 CPU
 dynamic-power-coefficient information
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
 <20200127215453.15144-3-lukasz.luba@arm.com>
 <CAJKOXPcgC1xE2=-=_hqvqrBCBzQF4113+wez=3Lqp71=yv8gZw@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <7c405b02-060c-3fbc-f6a8-2b4180753ad0@arm.com>
Date:   Fri, 31 Jan 2020 16:42:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPcgC1xE2=-=_hqvqrBCBzQF4113+wez=3Lqp71=yv8gZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 1/31/20 1:05 PM, Krzysztof Kozlowski wrote:
> On Mon, 27 Jan 2020 at 22:55, <lukasz.luba@arm.com> wrote:
>>
>> From: Lukasz Luba <lukasz.luba@arm.com>
>>
>> Add dynamic power coefficient into CPU nodes which let CPUFreq subsystem
>> register the Energy Model (EM) for the CPUs.
>>
>> The 'dynamic-power-coefficient' is used for calculating the dynamic power
>> according to the equation in documentation [1].  The Energy Model (EM)
>> framework relies on calculated power and cost for each OPP. The OPP power
>> values come from CPUFreq driver, which registered required callback
>> function. The simple implementation of a CPUFREQ driver, like cpufreq-dt,
>> uses 'dev_pm_opp_of_register_em()' which relay on
>> 'dynamic-power-coefficient' to calculate the power of requested OPP for the
>> EM [2].
>>
>> The calculated values might be checked in
>> /sys/kernel/debug/energy_model/pd*/
>>
>> $ grep . /sys/kernel/debug/energy_model/pd1/cs*/*
>> /sys/kernel/debug/energy_model/pd1/cs:1000000/cost:558
>> /sys/kernel/debug/energy_model/pd1/cs:1000000/frequency:1000000
>> /sys/kernel/debug/energy_model/pd1/cs:1000000/power:310
>> /sys/kernel/debug/energy_model/pd1/cs:1100000/cost:558
>> /sys/kernel/debug/energy_model/pd1/cs:1100000/frequency:1100000
>> /sys/kernel/debug/energy_model/pd1/cs:1100000/power:341
>> /sys/kernel/debug/energy_model/pd1/cs:1200000/cost:558
>> /sys/kernel/debug/energy_model/pd1/cs:1200000/frequency:1200000
>> /sys/kernel/debug/energy_model/pd1/cs:1200000/power:372
>> /sys/kernel/debug/energy_model/pd1/cs:1300000/cost:674
>> /sys/kernel/debug/energy_model/pd1/cs:1300000/frequency:1300000
>> /sys/kernel/debug/energy_model/pd1/cs:1300000/power:487
>> /sys/kernel/debug/energy_model/pd1/cs:1400000/cost:675 ...
>>
>> $ grep . /sys/kernel/debug/energy_model/pd0/cs*/*
>> /sys/kernel/debug/energy_model/pd0/cs:1000000/cost:200
>> /sys/kernel/debug/energy_model/pd0/cs:1000000/frequency:1000000
>> /sys/kernel/debug/energy_model/pd0/cs:1000000/power:154
>> /sys/kernel/debug/energy_model/pd0/cs:1100000/cost:260
>> /sys/kernel/debug/energy_model/pd0/cs:1100000/frequency:1100000
>> /sys/kernel/debug/energy_model/pd0/cs:1100000/power:220
>> /sys/kernel/debug/energy_model/pd0/cs:1200000/cost:260
>> /sys/kernel/debug/energy_model/pd0/cs:1200000/frequency:1200000
>> /sys/kernel/debug/energy_model/pd0/cs:1200000/power:240
>> /sys/kernel/debug/energy_model/pd0/cs:1300000/cost:260
>> /sys/kernel/debug/energy_model/pd0/cs:1300000/frequency:1300000
>> /sys/kernel/debug/energy_model/pd0/cs:1300000/power:260
>> /sys/kernel/debug/energy_model/pd0/cs:200000/cost:130 ...
> 
> Please, do not describe entire Energy Model in commit message touching
> DTS. It brings too much information which look unrelated and therefore
> it makes difficult to spot real rationale behind the change. Just
> mention:
> 1. Why you are doing it?
> 2. What are you doing?
> 3. How did you figure out magic constants here (details of "what")?

OK, I will clean this up.

> 
>> To provide a proper value of the 'dynamic-power-coefficient' the real power
>> can be measured using a dedicated hardware, i.e. INA2xx. The Odroid-XU3
>> hwmon sensors have been used to capture the power value during a sysbench
>> test running on single core and at each possible OPP.
> 
> Since you mention the values, post them. That's the only thing which
> reader cannot get on his own. All other values posted in commit
> message will be seen after running tests...

Makes sense, but as you spotted it can vary probably due to ASV, so I
will skip to put values in commit message.

> 
>> The measured values
>> were divided by 2, since the dynamic power is typically half of the
>> consumed power (the second half is static power). Next, the approximation
>> was made and the power model derived, showing the 'C' value of routhly X.
> 
> s/routhly/roughly/
> 
> What is X?

The 'X' is <128> or <310>

> 
>> Check the example equations in drivers/opp/of.c [2].
>> Thus, i.e. the power = 1.0Watt at 1GHz => 0.5W dynamic power =>
>> dynamic-power-coefficient = 400
>>
>> Using this simple technique we can provide and needed coefficient.  The
> 
> s/and/the/ ?

correct

> 
>> approximation does not have to be super precised. The proportion is
>> important and the difference between power consumed by different CPUs
>> running at the same frequency, which is then used in Energy Aware Scheduler
>> algorithms. An example power values on Odroid-XU3:
>>
>> (LITTLE CPU)
>> /sys/kernel/debug/energy_model/pd0/cs:1000000/frequency:1000000
>> /sys/kernel/debug/energy_model/pd0/cs:1000000/power:154
> 
> For A7, 1V and 1 GHz this gives 142, not 154. Is it correct? What ASV
> are you using?

Good question, it may vary depending on ASV. Would it vary also due to
bootloader?
This one is quite old:
U-Boot 2012.07 (Aug 11 2014 - 18:33:44) for Exynos5422

Odroid-xu3 rev0.2 20140529 ASV regs dump:
EXYNOS_CHIPID_REG_PKG_ID=0x320c832a
EXYNOS_CHIPID_REG_AUX_INFO=0x4f

Odroid-xu4 rev0.1 20180912 ASV regs dump:
EXYNOS_CHIPID_REG_PKG_ID=0x3b0e832a
EXYNOS_CHIPID_REG_AUX_INFO=0x100c004f

> 
>> (big CPU)
>> /sys/kernel/debug/energy_model/pd1/cs:1000000/frequency:1000000
>> /sys/kernel/debug/energy_model/pd1/cs:1000000/power:310
>>
>> In Odroid-XU3 case the derived coefficient value for 'big' CPU has:
>> dynamic-power-coefficient = <310>;
>> while the 'LITTLE':
>> dynamic-power-coefficient = <128>;
> 
> Make it all compact. First, you mention power values which are the
> same as in the beginning of this commit message. Why repeating? Then
> you mention the power coefficient in 4 lines instead of simple:
> For Odroid XU3, the derived power coefficient is then 128 for an A7
> CPU and 310 for an A15 CPU. Or something similar.

OK, I will keep simple, as you have commented.

> 
>>
>> [1] Documentation/devicetree/bindings/arm/cpus.yaml
>> [2] https://elixir.bootlin.com/linux/v5.4/source/drivers/opp/of.c#L1044
> 
> Refer to path inside, no external sources unless needed.

OK

Regards,
Lukasz

> 
> Best regards,
> Krzysztof
> 

