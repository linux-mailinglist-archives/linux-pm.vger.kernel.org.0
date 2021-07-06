Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B53B3BDE23
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 21:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhGFTrW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jul 2021 15:47:22 -0400
Received: from foss.arm.com ([217.140.110.172]:48994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229781AbhGFTrW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Jul 2021 15:47:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D6301042;
        Tue,  6 Jul 2021 12:44:43 -0700 (PDT)
Received: from [10.57.7.228] (unknown [10.57.7.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2253A3F5A1;
        Tue,  6 Jul 2021 12:44:39 -0700 (PDT)
Subject: Re: [PATCH 2/3] PM: EM: Make em_cpu_energy() able to return bigger
 values
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Chris.Redpath@arm.com,
        morten.rasmussen@arm.com, qperret@google.com,
        linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, vincent.guittot@linaro.org,
        mingo@redhat.com, juri.lelli@redhat.com, rostedt@goodmis.org,
        segall@google.com, mgorman@suse.de, bristot@redhat.com,
        CCj.Yeh@mediatek.com
References: <20210625152603.25960-1-lukasz.luba@arm.com>
 <20210625152603.25960-3-lukasz.luba@arm.com>
 <266f4b52-62c5-48bc-2680-1f09b6eb90cc@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <5c6a952e-b274-2b62-4008-5eadec64ac76@arm.com>
Date:   Tue, 6 Jul 2021 20:44:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <266f4b52-62c5-48bc-2680-1f09b6eb90cc@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/5/21 1:44 PM, Dietmar Eggemann wrote:
> On 25/06/2021 17:26, Lukasz Luba wrote:
>> The Energy Model (EM) em_cpu_energy() is responsible for providing good
>> estimation regarding CPUs energy. It contains proper data structures which
>> are then used during calculation. The values stored in there are in
>> milli-Watts precision (or in abstract scale) smaller that 0xffff, which use
> 
> I guess you refer to 'if (... || power > EM_MAX_POWER)' check in
> em_create_perf_table() [kernel/power/energy_model.c].

Correct

> 
>> sufficient unsigned long even on 32-bit machines. There are scenarios where
>                                                                ^^^^^^^^^
> 
> Can you describe these scenarios better with one example (EAS placement
> of an example task on a 2 PD system) which highlights the issue and how
> it this patch-set solves it?

There are two places in the code where it makes a difference:

1. In the find_energy_efficient_cpu() where we are searching for
best_delta. We might suffer there when two PDs return the same result,
like in the example below.

Scenario:
Low utilized system e.g. ~200 sum_util for PD0 and ~220 for PD1. There
are quite a few small tasks ~10-15 util. These tasks would suffer for
the rounding error. Such system utilization has been seen while playing
some simple games. In such condition our partner reported 5..10mA less
battery drain.

Some details:
We have two Perf Domains (PDs): PD0 (big) and PD1 (little)
Let's compare w/o patch set ('old') and w/ patch set ('new')
We are comparing energy w/ task and w/o task placed in the PDs

a) 'old' w/o patch set, PD0
task_util = 13
cost = 480
sum_util_w/o_task = 215
sum_util_w_task = 228
scale_cpu = 1024
energy_w/o_task = 480 * 215 / 1024 = 100.78 => 100
energy_w_task = 480 * 228 / 1024 = 106.87 => 106
energy_diff = 106 - 100 = 6 (this is equal to 'old' PD1's energy_diff in 
'c)')

b) 'new' w/ patch set, PD0
task_util = 13
cost = 480 * 10000 = 4800000
sum_util_w/o_task = 215
sum_util_w_task = 228
energy_w/o_task = 4800000 * 215 / 1024 = 1007812
energy_w_task = 4800000 * 228 / 1024  = 1068750
energy_diff = 1068750 - 1007812 = 60938 (this is not equal to 'new' 
PD1's energy_diff in 'd)')

c) 'old' w/o patch set, PD1
task_util = 13
cost = 160
sum_util_w/o_task = 283
sum_util_w_task = 293
scale_cpu = 355
energy_w/o_task = 160 * 283 / 355 = 127.55 => 127
energy_w_task = 160 * 296 / 355 = 133.41 => 133
energy_diff = 133 - 127 = 6 (this is equal to 'old' PD0's energy_diff in 
'a)')

d) 'new' w/ patch set, PD1
task_util = 13
cost = 160 * 10000 = 1600000
sum_util_w/o_task = 283
sum_util_w_task = 293
scale_cpu = 355
(no '/ scale_cpu' needed here)
energy_w/o_task = 1600000 * 283 / 355 = 1275492
energy_w_task = 1600000 * 296 / 355 =   1334084
energy_diff = 1334084 - 1275492 = 58592 (this is not equal to 'new' 
PD0's energy_diff in 'b)')

2. Difference in the the last feec() step: margin filter
With the patch set the margin comparison also has better resolution,
so it's possible to hit better placement thanks to that.

Please see the traces below.
How to interpret these values:
In the first trace below, there is diff=124964 and margin=123381
the EM 'cost' is multiplied by 10000, so we we divide these two,
it will be '12 > 12', so it won't be placed into the better PD
with lower best delta.

In the last 2 examples you would see close values in the
prev_delta=49390 best_delta=43945
Without the patch they would be rounded to
prev_delta=4 best_delta=4
and the task might be placed wrongly.
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   systemd-logind-440     [000] d..5    82.164218: compute_energy: 
energy=43945, sum_util=9 cpu=4
   systemd-logind-440     [000] d..5    82.164232: compute_energy: 
energy=766601, sum_util=157 cpu=4
   systemd-logind-440     [000] d..5    82.164242: compute_energy: 
energy=766601, sum_util=157 cpu=4
   systemd-logind-440     [000] d..5    82.164253: compute_energy: 
energy=1207500, sum_util=299 cpu=0
   systemd-logind-440     [000] d..5    82.164263: compute_energy: 
energy=1805192, sum_util=447 cpu=0
   systemd-logind-440     [000] d..5    82.164273: select_task_rq_fair: 
EAS: prev_delta=722656 best_delta=597692 diff=124964 margin=123381
   systemd-logind-440     [000] d..5    82.164278: select_task_rq_fair: 
EAS: hit!!!


   systemd-logind-440     [000] d.h4   134.954038: compute_energy: 
energy=366210, sum_util=75 cpu=4
   systemd-logind-440     [000] d.h4   134.954067: compute_energy: 
energy=463867, sum_util=95 cpu=4
   systemd-logind-440     [000] d.h4   134.954090: compute_energy: 
energy=463867, sum_util=95 cpu=4
   systemd-logind-440     [000] d.h4   134.954117: compute_energy: 
energy=257347, sum_util=99 cpu=0
   systemd-logind-440     [000] d.h4   134.954137: compute_energy: 
energy=309336, sum_util=119 cpu=0
   systemd-logind-440     [000] d.h4   134.954160: select_task_rq_fair: 
EAS: prev_delta=97657 best_delta=51989 diff=45668 margin=45075
   systemd-logind-440     [000] d.h4   134.954171: select_task_rq_fair: 
EAS: hit!!!


           <idle>-0       [001] d.s4   226.019763: compute_energy: 
energy=0, sum_util=0 cpu=4
           <idle>-0       [001] d.s4   226.019790: compute_energy: 
energy=43945, sum_util=9 cpu=4
           <idle>-0       [001] d.s4   226.019817: compute_energy: 
energy=5198, sum_util=2 cpu=0
           <idle>-0       [001] d.s4   226.019838: compute_energy: 
energy=54588, sum_util=21 cpu=0
           <idle>-0       [001] d.s4   226.019858: compute_energy: 
energy=54588, sum_util=21 cpu=0
           <idle>-0       [001] d.s4   226.019881: select_task_rq_fair: 
EAS: prev_delta=49390 best_delta=43945 diff=5445 margin=3411
           <idle>-0       [001] d.s4   226.019891: select_task_rq_fair: 
EAS: hit!!!


           <idle>-0       [001] d.s4   270.019780: compute_energy: 
energy=0, sum_util=0 cpu=4
           <idle>-0       [001] d.s4   270.019807: compute_energy: 
energy=43945, sum_util=9 cpu=4
           <idle>-0       [001] d.s4   270.019833: compute_energy: 
energy=5198, sum_util=2 cpu=0
           <idle>-0       [001] d.s4   270.019854: compute_energy: 
energy=54588, sum_util=21 cpu=0
           <idle>-0       [001] d.s4   270.019874: compute_energy: 
energy=54588, sum_util=21 cpu=0
           <idle>-0       [001] d.s4   270.019897: select_task_rq_fair: 
EAS: prev_delta=49390 best_delta=43945 diff=5445 margin=3411
           <idle>-0       [001] d.s4   270.019908: select_task_rq_fair: 
EAS: hit!!!

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


> 
> In this example you can list all the things which must be there to
> create a situation in EAS in which the patch-set helps.

I hope the description above now add more light into this issue.

> 
>> we would like to provide calculated estimations in a better precision and
>> the values might be 1000 times bigger. This patch makes possible to use
> 
> Where is this `1000` coming from?

It's just a statement that in the next patches we would increase the
resolution by a few orders of magnitude. In patch 3/3 it's 10000.
I can align with that value also in this statement.

Thank you Dietmar for having a look at this!

Regards,
Lukasz

