Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B8920713E
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 12:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390510AbgFXKdD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 06:33:03 -0400
Received: from foss.arm.com ([217.140.110.172]:59560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388197AbgFXKdD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Jun 2020 06:33:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A5261FB;
        Wed, 24 Jun 2020 03:33:02 -0700 (PDT)
Received: from [10.37.12.79] (unknown [10.37.12.79])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 239C93F6CF;
        Wed, 24 Jun 2020 03:32:59 -0700 (PDT)
Subject: Re: brocken devfreq simple_ondemand for Odroid XU3/4?
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Willy Wolff <willy.mh.wolff.ml@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
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
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <85f5a8c0-7d48-f2cd-3385-c56d662f2c88@arm.com>
Date:   Wed, 24 Jun 2020 11:32:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200623191129.GA4171@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof and Willy

On 6/23/20 8:11 PM, Krzysztof Kozlowski wrote:
> On Tue, Jun 23, 2020 at 09:02:38PM +0200, Krzysztof Kozlowski wrote:
>> On Tue, 23 Jun 2020 at 18:47, Willy Wolff <willy.mh.wolff.ml@gmail.com> wrote:
>>>
>>> Hi everybody,
>>>
>>> Is DVFS for memory bus really working on Odroid XU3/4 board?
>>> Using a simple microbenchmark that is doing only memory accesses, memory DVFS
>>> seems to not working properly:
>>>
>>> The microbenchmark is doing pointer chasing by following index in an array.
>>> Indices in the array are set to follow a random pattern (cutting prefetcher),
>>> and forcing RAM access.
>>>
>>> git clone https://github.com/wwilly/benchmark.git \
>>>    && cd benchmark \
>>>    && source env.sh \
>>>    && ./bench_build.sh \
>>>    && bash source/scripts/test_dvfs_mem.sh
>>>
>>> Python 3, cmake and sudo rights are required.
>>>
>>> Results:
>>> DVFS CPU with performance governor
>>> mem_gov = simple_ondemand at 165000000 Hz in idle, should be bumped when the
>>> benchmark is running.
>>> - on the LITTLE cluster it takes 4.74308 s to run (683.004 c per memory access),
>>> - on the big cluster it takes 4.76556 s to run (980.343 c per moemory access).
>>>
>>> While forcing DVFS memory bus to use performance governor,
>>> mem_gov = performance at 825000000 Hz in idle,
>>> - on the LITTLE cluster it takes 1.1451 s to run (164.894 c per memory access),
>>> - on the big cluster it takes 1.18448 s to run (243.664 c per memory access).
>>>
>>> The kernel used is the last 5.7.5 stable with default exynos_defconfig.
>>
>> Thanks for the report. Few thoughts:
>> 1. What trans_stat are saying? Except DMC driver you can also check
>> all other devfreq devices (e.g. wcore) - maybe the devfreq events
>> (nocp) are not properly assigned?
>> 2. Try running the measurement for ~1 minutes or longer. The counters
>> might have some delay (which would require probably fixing but the
>> point is to narrow the problem).
>> 3. What do you understand by "mem_gov"? Which device is it?
> 
> +Cc Lukasz who was working on this.

Thanks Krzysztof for adding me here.

> 
> I just run memtester and more-or-less ondemand works (at least ramps
> up):
> 
> Before:
> /sys/class/devfreq/10c20000.memory-controller$ cat trans_stat
>       From  :   To
>             : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
> * 165000000:         0         0         0         0         0         0         0         0   1795950
>    206000000:         1         0         0         0         0         0         0         0      4770
>    275000000:         0         1         0         0         0         0         0         0     15540
>    413000000:         0         0         1         0         0         0         0         0     20780
>    543000000:         0         0         0         1         0         0         0         1     10760
>    633000000:         0         0         0         0         2         0         0         0     10310
>    728000000:         0         0         0         0         0         0         0         0         0
>    825000000:         0         0         0         0         0         2         0         0     25920
> Total transition : 9
> 
> 
> $ sudo memtester 1G
> 
> During memtester:
> /sys/class/devfreq/10c20000.memory-controller$ cat trans_stat
>       From  :   To
>             : 165000000 206000000 275000000 413000000 543000000 633000000 728000000 825000000   time(ms)
>    165000000:         0         0         0         0         0         0         0         1   1801490
>    206000000:         1         0         0         0         0         0         0         0      4770
>    275000000:         0         1         0         0         0         0         0         0     15540
>    413000000:         0         0         1         0         0         0         0         0     20780
>    543000000:         0         0         0         1         0         0         0         2     11090
>    633000000:         0         0         0         0         3         0         0         0     17210
>    728000000:         0         0         0         0         0         0         0         0         0
> * 825000000:         0         0         0         0         0         3         0         0    169020
> Total transition : 13
> 
> However after killing memtester it stays at 633 MHz for very long time
> and does not slow down. This is indeed weird...

I had issues with devfreq governor which wasn't called by devfreq
workqueue. The old DELAYED vs DEFERRED work discussions and my patches
for it [1]. If the CPU which scheduled the next work went idle, the
devfreq workqueue will not be kicked and devfreq governor won't check
DMC status and will not decide to decrease the frequency based on low
busy_time.
The same applies for going up with the frequency. They both are
done by the governor but the workqueue must be scheduled periodically.

I couldn't do much with this back then. I have given the example that
this is causing issues with the DMC [2]. There is also a description
of your situation staying at 633MHz for long time:
' When it is missing opportunity
to change the frequency, it can either harm the performance or power
consumption, depending of the frequency the device stuck on.'

The patches were not accepted because it will cause CPU wake-up from
idle, which increases the energy consumption. I know that there were
some other attempts, but I don't know the status.

I had also this devfreq workqueue issue when I have been working on
thermal cooling for devfreq. The device status was not updated, because
the devfreq workqueue didn't check the device [3].

Let me investigate if that is the case.

Regards,
Lukasz

[1] https://lkml.org/lkml/2019/2/11/1146
[2] https://lkml.org/lkml/2019/2/12/383
[3] 
https://lwn.net/ml/linux-kernel/20200511111912.3001-11-lukasz.luba@arm.com/

> 
> Best regards,
> Krzysztof
> 
