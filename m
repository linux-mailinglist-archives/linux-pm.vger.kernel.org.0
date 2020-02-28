Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5828B1736BE
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2020 13:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgB1MAQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Feb 2020 07:00:16 -0500
Received: from foss.arm.com ([217.140.110.172]:37134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgB1MAQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Feb 2020 07:00:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CCC04B2;
        Fri, 28 Feb 2020 04:00:15 -0800 (PST)
Received: from [10.37.12.207] (unknown [10.37.12.207])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE33C3F7B4;
        Fri, 28 Feb 2020 04:00:11 -0800 (PST)
Subject: Re: [RESEND PATCH v2 0/2] Enable Odroid-XU3/4 to use Energy Model and
 Energy Aware Scheduler
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kgene@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com,
        robh+dt@kernel.org, mark.rutland@arm.com, b.zolnierkie@samsung.com,
        dietmar.eggemann@arm.com
References: <20200220095636.29469-1-lukasz.luba@arm.com>
 <20200220180040.GA8338@kozik-lap>
 <CGME20200221103307eucas1p2bc51b3b5d6d0a9739ab97cdd39078505@eucas1p2.samsung.com>
 <597f1475-754c-d77a-b599-0fa07d8ee948@arm.com>
 <fb6961ce-846e-3c26-5227-6327c6d511f6@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <b2823ea1-a782-1024-bcc0-c1aba9a84fc3@arm.com>
Date:   Fri, 28 Feb 2020 12:00:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <fb6961ce-846e-3c26-5227-6327c6d511f6@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Marek,

On 2/28/20 10:59 AM, Marek Szyprowski wrote:
> Hi Lukasz
> 
> On 21.02.2020 11:32, Lukasz Luba wrote:
>> On 2/20/20 6:00 PM, Krzysztof Kozlowski wrote:
>>> On Thu, Feb 20, 2020 at 09:56:34AM +0000, Lukasz Luba wrote:
>>>> This is just a resend, now with proper v2 in the patches subject.
>>>>
>>>> The Odroid-XU4/3 is a decent and easy accessible ARM big.LITTLE
>>>> platform,
>>>> which might be used for research and development.
>>>>
>>>> This small patch set provides possibility to run Energy Aware
>>>> Scheduler (EAS)
>>>> on Odroid-XU4/3 and experiment with it.
>>>>
>>>> The patch 1/2 provides 'dynamic-power-coefficient' in CPU DT nodes,
>>>> which is
>>>> then used by the Energy Model (EM).
>>>> The patch 2/2 enables SCHED_MC (which adds another level in
>>>> scheduling domains)
>>>> and enables EM making EAS possible to run (when schedutil is set as
>>>> a CPUFreq
>>>> governor).
>>>>
>>>> 1. Test results
>>>>
>>>> Two types of different tests have been executed. The first is energy
>>>> test
>>>> case showing impact on energy consumption of this patch set. It is
>>>> using a
>>>> synthetic set of tasks (rt-app based). The second is the performance
>>>> test
>>>> case which is using hackbench (less time to complete is better).
>>>> In both tests schedutil has been used as cpufreq governor. In all tests
>>>> PROVE_LOCKING has not been compiled into the kernels.
>>>>
>>>> 1.1 Energy test case
>>>>
>>>> 10 iterations of 24 periodic rt-app tasks (16ms period, 10% duty-cycle)
>>>> with energy measurement. The cpufreq governor - schedutil. Unit is
>>>> Joules.
>>>> The energy is calculated based on hwmon0 and hwmon3 power1_input.
>>>> The goal is to save energy, lower is better.
>>>>
>>>> +-----------+-----------------+------------------------+
>>>> |           | Without patches | With patches           |
>>>> +-----------+--------+--------+----------------+-------+
>>>> | benchmark |  Mean  | RSD*   | Mean           | RSD*  |
>>>> +-----------+--------+--------+----------------+-------+
>>>> | 24 rt-app |  21.56 |  1.37% |  19.85 (-9.2%) | 0.92% |
>>>> |    tasks  |        |        |                |       |
>>>> +-----------+--------+--------+----------------+-------+
>>>>
>>>> 1.2 Performance test case
>>>>
>>>> 10 consecutive iterations of hackbench (hackbench -l 500 -s 4096),
>>>> no delay between two successive executions.
>>>> The cpufreq governor - schedutil. Units in seconds.
>>>> The goal is to see not regression, lower completion time is better.
>>>>
>>>> +-----------+-----------------+------------------------+
>>>> |           | Without patches | With patches           |
>>>> +-----------+--------+--------+----------------+-------+
>>>> | benchmark | Mean   | RSD*   | Mean           | RSD*  |
>>>> +-----------+--------+--------+----------------+-------+
>>>> | hackbench |  8.15  | 2.86%  |  7.95 (-2.5%)  | 0.60% |
>>>> +-----------+--------+--------+----------------+-------+
>>>>
>>>> *RSD: Relative Standard Deviation (std dev / mean)
>>>
>>> Nice measurements!
>>
>> Glad to hear that.
>>
>>>
>>> Applied both, thank you.
>>>
>>
>> Thank you for applying this.
> 
> 
> After applying the patches I see the following warnings during boot (XU4):
> 
> energy_model: pd0: hertz/watts ratio non-monotonically decreasing:
> em_cap_state 1 >= em_cap_state0
> energy_model: pd0: hertz/watts ratio non-monotonically decreasing:
> em_cap_state 3 >= em_cap_state2
> energy_model: pd0: hertz/watts ratio non-monotonically decreasing:
> em_cap_state 4 >= em_cap_state3
> energy_model: pd0: hertz/watts ratio non-monotonically decreasing:
> em_cap_state 5 >= em_cap_state4
> energy_model: pd0: hertz/watts ratio non-monotonically decreasing:
> em_cap_state 8 >= em_cap_state7
> energy_model: pd0: hertz/watts ratio non-monotonically decreasing:
> em_cap_state 10 >= em_cap_state9
> energy_model: pd0: hertz/watts ratio non-monotonically decreasing:
> em_cap_state 11 >= em_cap_state10
> energy_model: pd4: hertz/watts ratio non-monotonically decreasing:
> em_cap_state 1 >= em_cap_state0
> energy_model: pd4: hertz/watts ratio non-monotonically decreasing:
> em_cap_state 2 >= em_cap_state1
> energy_model: pd4: hertz/watts ratio non-monotonically decreasing:
> em_cap_state 3 >= em_cap_state2
> energy_model: pd4: hertz/watts ratio non-monotonically decreasing:
> em_cap_state 4 >= em_cap_state3
> energy_model: pd4: hertz/watts ratio non-monotonically decreasing:
> em_cap_state 5 >= em_cap_state4
> energy_model: pd4: hertz/watts ratio non-monotonically decreasing:
> em_cap_state 6 >= em_cap_state5
> energy_model: pd4: hertz/watts ratio non-monotonically decreasing:
> em_cap_state 8 >= em_cap_state7
> energy_model: pd4: hertz/watts ratio non-monotonically decreasing:
> em_cap_state 9 >= em_cap_state8
> energy_model: pd4: hertz/watts ratio non-monotonically decreasing:
> em_cap_state 10 >= em_cap_state9
> energy_model: pd4: hertz/watts ratio non-monotonically decreasing:
> em_cap_state 13 >= em_cap_state12
> energy_model: pd4: hertz/watts ratio non-monotonically decreasing:
> em_cap_state 15 >= em_cap_state14
> energy_model: pd4: hertz/watts ratio non-monotonically decreasing:
> em_cap_state 16 >= em_cap_state15
> 
> Is it okay?

It shouldn't harm the EAS but it might be used by thermal, especially
those OPPs from the top. Like in your case in step_wise (IIRC the DT
settings).
But removing some of these from the bottom, would be good.
It would lower the Energy Model complexity, which is:
nr_perf_domain * (nr_cpus + nr_OPPs) [1] (in Odroid XU4 is ~80 IIRC)

smaller OPP number is better.

Douglas is working on a patch set which could skip non-efficient OPPs
(the OPPs which have the same voltage but different frequency).
Although, we don't know the numbers how much it could save energy - when
we use the fastest frequency for the set of OPPs with the same voltage,
comparing to the slowest (theoretically entering idle earlier) .
The discussion is ongoing here [2].

Regarding the print message. It's not a bug in the platform so in
my opinion we shouldn't use 'pr_warn' in this case.
It's going to be changed to just debug level print. I have this
change in the new Energy Model. It is in last point in changelog v3 [3]
and the change which does this is in patch 1/4:
--------------------------------------------->8------------------
-			pr_warn("pd%d: hertz/watts ratio non-monotonically decreasing: 
em_cap_state %d >= em_cap_state%d\n",
-					cpu, i, i - 1);
+			dev_dbg(dev, "EM: hertz/watts ratio non-monotonically decreasing: 
em_perf_state %d >= em_perf_state%d\n",
+					i, i - 1);

--------------------------------------8<------------------------


Regards,
Lukasz

[1] 
https://elixir.bootlin.com/linux/latest/source/kernel/sched/topology.c#L397
[2] https://lkml.org/lkml/2020/1/22/1169
[3] https://lkml.org/lkml/2020/2/21/1910
