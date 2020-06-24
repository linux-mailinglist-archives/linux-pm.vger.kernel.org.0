Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2952073ED
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 15:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403829AbgFXNDL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 09:03:11 -0400
Received: from foss.arm.com ([217.140.110.172]:46970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390686AbgFXNDK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Jun 2020 09:03:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0D901F1;
        Wed, 24 Jun 2020 06:03:08 -0700 (PDT)
Received: from [10.37.12.79] (unknown [10.37.12.79])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40D193F6CF;
        Wed, 24 Jun 2020 06:03:05 -0700 (PDT)
Subject: Re: brocken devfreq simple_ondemand for Odroid XU3/4?
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kamil Konieczny <k.konieczny@samsung.com>
Cc:     Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200623164733.qbhua7b6cg2umafj@macmini.local>
 <CAJKOXPeLuq81NC2xZh3y32EB-_APbDAchZD4OW_eCgQKKO+p8w@mail.gmail.com>
 <20200623191129.GA4171@kozik-lap>
 <CGME20200624103308eucas1p29c8572979809b129ff8ac729c6c728e2@eucas1p2.samsung.com>
 <85f5a8c0-7d48-f2cd-3385-c56d662f2c88@arm.com>
 <828b0d63-4d01-48d6-5971-64855adebed2@samsung.com>
 <20200624120651.GA20813@pi3>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <55772862-ff8f-1e1d-91ae-7b4d7c3be1b6@arm.com>
Date:   Wed, 24 Jun 2020 14:03:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200624120651.GA20813@pi3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/24/20 1:06 PM, Krzysztof Kozlowski wrote:
> On Wed, Jun 24, 2020 at 01:18:42PM +0200, Kamil Konieczny wrote:
>> Hi,
>>
>> On 24.06.2020 12:32, Lukasz Luba wrote:
>>> Hi Krzysztof and Willy
>>>
>>> On 6/23/20 8:11 PM, Krzysztof Kozlowski wrote:
>>>> On Tue, Jun 23, 2020 at 09:02:38PM +0200, Krzysztof Kozlowski wrote:
>>>>> On Tue, 23 Jun 2020 at 18:47, Willy Wolff <willy.mh.wolff.ml@gmail.com> wrote:
>>>>>>
>>>>>> Hi everybody,
>>>>>>
>>>>>> Is DVFS for memory bus really working on Odroid XU3/4 board?
>>>>>> Using a simple microbenchmark that is doing only memory accesses, memory DVFS
>>>>>> seems to not working properly:
>>>>>>
>>>>>> The microbenchmark is doing pointer chasing by following index in an array.
>>>>>> Indices in the array are set to follow a random pattern (cutting prefetcher),
>>>>>> and forcing RAM access.
>>>>>>
>>>>>> git clone https://protect2.fireeye.com/url?k=c364e88a-9eb6fe2f-c36563c5-0cc47a31bee8-631885f0a63a11a0&q=1&u=https%3A%2F%2Fgithub.com%2Fwwilly%2Fbenchmark.git \
>>>>>>     && cd benchmark \
>>>>>>     && source env.sh \
>>>>>>     && ./bench_build.sh \
>>>>>>     && bash source/scripts/test_dvfs_mem.sh
>>>>>>
>>>>>> Python 3, cmake and sudo rights are required.
>>>>>>
>>>>>> Results:
>>>>>> DVFS CPU with performance governor
>>>>>> mem_gov = simple_ondemand at 165000000 Hz in idle, should be bumped when the
>>>>>> benchmark is running.
>>>>>> - on the LITTLE cluster it takes 4.74308 s to run (683.004 c per memory access),
>>>>>> - on the big cluster it takes 4.76556 s to run (980.343 c per moemory access).
>>>>>>
>>>>>> While forcing DVFS memory bus to use performance governor,
>>>>>> mem_gov = performance at 825000000 Hz in idle,
>>>>>> - on the LITTLE cluster it takes 1.1451 s to run (164.894 c per memory access),
>>>>>> - on the big cluster it takes 1.18448 s to run (243.664 c per memory access).
>>>>>>
>>>>>> The kernel used is the last 5.7.5 stable with default exynos_defconfig.
>>>>>
>>>>> Thanks for the report. Few thoughts:
>>>>> 1. What trans_stat are saying? Except DMC driver you can also check
>>>>> all other devfreq devices (e.g. wcore) - maybe the devfreq events
>>>>> (nocp) are not properly assigned?
>>>>> 2. Try running the measurement for ~1 minutes or longer. The counters
>>>>> might have some delay (which would require probably fixing but the
>>>>> point is to narrow the problem).
>>>>> 3. What do you understand by "mem_gov"? Which device is it?
>>>>
>>>> +Cc Lukasz who was working on this.
>>>
>>> Thanks Krzysztof for adding me here.
>>>
>>>>
>>>> I just run memtester and more-or-less ondemand works (at least ramps
>>>> up):
>>>>
>>>> Before:
>>>> /sys/class/devfreq/10c20000.memory-controller$ cat trans_stat
>>>>        From  :   To
>>>>              : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
>>>> * 165000000:         0         0         0         0         0         0         0         0   1795950
>>>>     206000000:         1         0         0         0         0         0         0         0      4770
>>>>     275000000:         0         1         0         0         0         0         0         0     15540
>>>>     413000000:         0         0         1         0         0         0         0         0     20780
>>>>     543000000:         0         0         0         1         0         0         0         1     10760
>>>>     633000000:         0         0         0         0         2         0         0         0     10310
>>>>     728000000:         0         0         0         0         0         0         0         0         0
>>>>     825000000:         0         0         0         0         0         2         0         0     25920
>>>> Total transition : 9
>>>>
>>>>
>>>> $ sudo memtester 1G
>>>>
>>>> During memtester:
>>>> /sys/class/devfreq/10c20000.memory-controller$ cat trans_stat
>>>>        From  :   To
>>>>              : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
>>>>     165000000:         0         0         0         0         0         0         0         1   1801490
>>>>     206000000:         1         0         0         0         0         0         0         0      4770
>>>>     275000000:         0         1         0         0         0         0         0         0     15540
>>>>     413000000:         0         0         1         0         0         0         0         0     20780
>>>>     543000000:         0         0         0         1         0         0         0         2     11090
>>>>     633000000:         0         0         0         0         3         0         0         0     17210
>>>>     728000000:         0         0         0         0         0         0         0         0         0
>>>> * 825000000:         0         0         0         0         0         3         0         0    169020
>>>> Total transition : 13
>>>>
>>>> However after killing memtester it stays at 633 MHz for very long time
>>>> and does not slow down. This is indeed weird...
>>>
>>> I had issues with devfreq governor which wasn't called by devfreq
>>> workqueue. The old DELAYED vs DEFERRED work discussions and my patches
>>> for it [1]. If the CPU which scheduled the next work went idle, the
>>> devfreq workqueue will not be kicked and devfreq governor won't check
>>> DMC status and will not decide to decrease the frequency based on low
>>> busy_time.
>>> The same applies for going up with the frequency. They both are
>>> done by the governor but the workqueue must be scheduled periodically.
>>>
>>> I couldn't do much with this back then. I have given the example that
>>> this is causing issues with the DMC [2]. There is also a description
>>> of your situation staying at 633MHz for long time:
>>> ' When it is missing opportunity
>>> to change the frequency, it can either harm the performance or power
>>> consumption, depending of the frequency the device stuck on.'
>>>
>>> The patches were not accepted because it will cause CPU wake-up from
>>> idle, which increases the energy consumption. I know that there were
>>> some other attempts, but I don't know the status.
>>>
>>> I had also this devfreq workqueue issue when I have been working on
>>> thermal cooling for devfreq. The device status was not updated, because
>>> the devfreq workqueue didn't check the device [3].
>>>
>>> Let me investigate if that is the case.
>>>
>>> Regards,
>>> Lukasz
>>>
>>> [1] https%3A%2F%2Flkml.org%2Flkml%2F2019%2F2%2F11%2F1146
>>> [2] https%3A%2F%2Flkml.org%2Flkml%2F2019%2F2%2F12%2F383
>>> [3] https%3A%2F%2Flwn.net%2Fml%2Flinux-kernel%2F20200511111912.3001-11-lukasz.luba%40arm.com%2F
>>
>> and here was another try to fix wq: "PM / devfreq: add possibility for delayed work"
>>
>> https://lkml.org/lkml/2019/12/9/486
> 
> My case was clearly showing wrong behavior. System was idle but not
> sleeping - network working, SSH connection ongoing.  Therefore at least
> one CPU was not idle and could adjust the devfreq/DMC... but this did not
> happen. The system stayed for like a minute in 633 MHz OPP.
> 
> Not-waking up idle processors - ok... so why not using power efficient
> workqueue? It is exactly for this purpose - wake up from time to time on
> whatever CPU to do the necessary job.

IIRC I've done this experiment, still keeping in devfreq:
INIT_DEFERRABLE_WORK()
just applying patch [1]. It uses a system_wq which should
be the same as system_power_efficient_wq when
CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set (our case).
This wasn't solving the issue for the deferred work. That's
why the patch 2/2 following patch 1/2 [1] was needed.

The deferred work uses TIMER_DEFERRABLE in it's initialization
and this is the problem. When the deferred work was queued on a CPU,
next that CPU went idle, the work was not migrated to some other CPU.
The former cpu is also not woken up according to the documentation [2].

That's why Kamil's approach should be continue IMHO. It gives more
control over important devices like: bus, dmc, gpu, which utilization
does not strictly correspond to cpu utilization (which might be low or
even 0 and cpu put into idle).

I think Kamil was pointing out also some other issues not only dmc
(buses probably), but I realized too late to help him.

Regards,
Lukasz

[1] 
https://lore.kernel.org/lkml/1549899005-7760-2-git-send-email-l.luba@partner.samsung.com/
[2] https://elixir.bootlin.com/linux/latest/source/include/linux/timer.h#L40

> 
> Best regards,
> Krzysztof
> 
