Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC134CFF49
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2019 18:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfJHQwk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Oct 2019 12:52:40 -0400
Received: from foss.arm.com ([217.140.110.172]:41300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbfJHQwj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Oct 2019 12:52:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 424301570;
        Tue,  8 Oct 2019 09:52:39 -0700 (PDT)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AAC23F6C4;
        Tue,  8 Oct 2019 09:52:37 -0700 (PDT)
Subject: Re: [RFC v5 4/6] sched/fair: Tune task wake-up logic to pack small
 background tasks on fewer cores
To:     Parth Shah <parth@linux.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavel Machek <pavel@ucw.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Quentin Perret <qperret@qperret.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20191007083051.4820-1-parth@linux.ibm.com>
 <20191007083051.4820-5-parth@linux.ibm.com>
 <CAKfTPtCgoTJXxbYyza1W55ayw9QeM7fue2e91Xpt804sL9GQWA@mail.gmail.com>
 <80bb34ec-6358-f4dc-d20d-cde6c9d7e197@linux.ibm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <d55c593d-af8e-c8ba-cc0e-c9917df5d593@arm.com>
Date:   Tue, 8 Oct 2019 18:52:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <80bb34ec-6358-f4dc-d20d-cde6c9d7e197@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

[- Quentin Perret <quentin.perret@arm.com>]
[+ Quentin Perret <qperret@qperret.net>]

See commit c193a3ffc282 ("mailmap: Update email address for Quentin Perret")

On 07/10/2019 18:53, Parth Shah wrote:
> 
> 
> On 10/7/19 5:49 PM, Vincent Guittot wrote:
>> On Mon, 7 Oct 2019 at 10:31, Parth Shah <parth@linux.ibm.com> wrote:
>>>
>>> The algorithm finds the first non idle core in the system and tries to
>>> place a task in the idle CPU in the chosen core. To maintain
>>> cache hotness, work of finding non idle core starts from the prev_cpu,
>>> which also reduces task ping-pong behaviour inside of the core.
>>>
>>> Define a new method to select_non_idle_core which keep tracks of the idle
>>> and non-idle CPUs in the core and based on the heuristics determines if the
>>> core is sufficiently busy to place the incoming backgroung task. The
>>> heuristic further defines the non-idle CPU into either busy (>12.5% util)
>>> CPU and overutilized (>80% util) CPU.
>>> - The core containing more idle CPUs and no busy CPUs is not selected for
>>>   packing
>>> - The core if contains more than 1 overutilized CPUs are exempted from
>>>   task packing
>>> - Pack if there is atleast one busy CPU and overutilized CPUs count is <2
>>>
>>> Value of 12.5% utilization for busy CPU gives sufficient heuristics for CPU
>>> doing enough work an

[...]

>>> @@ -6483,7 +6572,11 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
>>>         } else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
>>>                 /* Fast path */
>>>
>>> -               new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
>>> +               if (is_turbosched_enabled() && unlikely(is_background_task(p)))
>>> +                       new_cpu = turbosched_select_non_idle_core(p, prev_cpu,
>>> +                                                                 new_cpu);
>>
>> Could you add turbosched_select_non_idle_core() similarly to
>> find_energy_efficient_cpu() ?
>> Add it at the beg select_task_rq_fair()
>> Return immediately with theCPU if you have found one
>> Or let the normal path select a CPU if the
>> turbosched_select_non_idle_core() has not been able to find a suitable
>> CPU for packing
>>
> 
> of course. I can do that.
> I was just not aware about the effect of wake_affine and so was waiting for
> such comments to be sure of. Thanks for this.
> Maybe I can add just below the sched_energy_present(){...} construct giving
> precedence to EAS? I'm asking this because I remember Patrick telling me to
> leverage task packing for android as well?

I have a hard time imaging that Turbosched will be used in Android next
to EAS in the foreseeable future.

First of all, EAS provides task packing already on Performance Domain
(PD) level (a.k.a. as cluster on traditional 2-cluster Arm/Arm64
big.LITTLE or DynamIQ (with Phantom domains (out of tree solution)).
This is where we can safe energy without harming latency.

See the tests results under '2.1 Energy test case' in

https://lore.kernel.org/r/20181203095628.11858-1-quentin.perret@arm.com

There are 10 to 50 small (classified solely by task utilization) tasks
per test case and EAS shows an effect on energy consumption by packing
them onto the PD (cluster) of the small CPUs.

And second, the CPU supported topology is different to the one you're
testing on.

[...]
