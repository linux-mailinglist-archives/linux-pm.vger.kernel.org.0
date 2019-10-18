Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D670DC42D
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 13:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407749AbfJRLqt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 07:46:49 -0400
Received: from [217.140.110.172] ([217.140.110.172]:36432 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2389397AbfJRLqt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Oct 2019 07:46:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2506CA3;
        Fri, 18 Oct 2019 04:46:27 -0700 (PDT)
Received: from [10.1.195.43] (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 810263F6C4;
        Fri, 18 Oct 2019 04:46:26 -0700 (PDT)
Subject: Re: [RFC PATCH v3 0/6] sched/cpufreq: Make schedutil energy aware
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qperret@google.com,
        patrick.bellasi@matbug.net, dh.han@samsung.com
References: <20191011134500.235736-1-douglas.raillard@arm.com>
 <20191014145315.GZ2311@hirez.programming.kicks-ass.net>
 <a1ce67d7-62c3-b78b-1d87-23ef4dbc2274@arm.com>
 <20191017095015.GI2311@hirez.programming.kicks-ass.net>
 <7edb1b73-54e7-5729-db5d-6b3b1b616064@arm.com>
 <20191017190708.GF22902@worktop.programming.kicks-ass.net>
From:   Douglas Raillard <douglas.raillard@arm.com>
Organization: ARM
Message-ID: <0b807cb3-6a88-1138-dc66-9a32d9bba7ea@arm.com>
Date:   Fri, 18 Oct 2019 12:46:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191017190708.GF22902@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/17/19 8:07 PM, Peter Zijlstra wrote:
> On Thu, Oct 17, 2019 at 03:23:04PM +0100, Douglas Raillard wrote:
>> On 10/17/19 10:50 AM, Peter Zijlstra wrote:
> 
>>> I'm still thinking about the exact means you're using to raise C; that
>>> is, the 'util - util_est' as cost_margin. It hurts my brain still.
>>
>> util_est is currently the best approximation of the actual portion of the CPU the task needs:
>> 1) for periodic tasks, it's not too far from the duty cycle, and is always higher
>>
>> 2) for aperiodic tasks, it (indirectly) takes into account the total time it took
>>    to complete the previous activation, so the signal is not 100% composed of logical signals
>>    only relevant for periodic tasks (although it's a big part of it).
>>
>> 3) Point 1) and 2) together allows util_est to adapt to periodic tasks that changes
>> their duty cycle over time, without needing a very long history (the last task period
>> is sufficient).
>>
>> For periodic tasks, the distance between instantaneous util_avg and the actual task
>> duty cycle indicates somehow what is our best guess of the (potential) change in the task
>> duty cycle.
>>
>> util_est is the threshold (assuming util_avg increasing) for util_avg after which we know
>> for sure that even if the task stopped right now, its duty cycle would be higher than
>> during the previous period.
>> This means for a given task and with (util >= util_est):
>>
>> 1) util - util_est == 0 means the task duty cycle will be equal to the one during
>>    during the previous activation, if the tasks stopped executing right now.
>>
>> 2) util - util_est > 0 means the task duty cycle will be higher to the one during
>>    during the previous activation, if the tasks stopped executing right now.
> 
> So far I can follow, 2) is indeed a fairly sane indication that
> utilization is growing.
> 
>> Using the difference (util - util_est) will therefore give these properties to the boost signal:
>> * no boost will be applied as long as the task has a constant or decreasing duty cycle.
>>
>> * when we can detect that the duty cycle increases, we temporarily increase the frequency.
>>    We start with a slight increase, and the longer we wait for the current period to finish,
>>    the more we boost, since the more likely it is that the task has a much larger duty cycle
>>    than anticipated. More specifically, the evaluation of "how much more" is done the exact
>>    same way as it is done for PELT, since the dynamic of the boost is "inherited" from PELT.
> 
> Right, because as long it keeps running, util_est will not be changed,
> so the difference will continue to increase.
> 
> What I don't see is how that that difference makes sense as input to:
> 
>    cost(x) : (1 + x) * cost_j

The actual input is:
x = (EM_COST_MARGIN_SCALE/SCHED_CAPACITY_SCALE) * (util - util_est)

Since EM_COST_MARGIN_SCALE == SCHED_CAPACITY_SCALE == 1024, this factor 
of 1 is not directly reflected in the code but is important for units 
consistency.

Non-zero x means that we are going to allow spending more energy than 
what schedutil currently thinks of being the minimal energy.
(it's actually not that minimal, since we have this 1.25 factor, plus 
the fact that we use util_est.enqueued, which will always over-estimate 
the actual util of the task).

> 
> I suppose that limits the additional OPP to twice the previously
> selected cost / efficiency (see the confusion from that other email).
> But given that efficency drops (or costs rise) for higher OPPs that
> still doesn't really make sense..
Yes, this current limit to +100% freq boosting is somehow arbitrary and 
could probably benefit from being tunable in some way (Kconfig option 
maybe). When (margin > 0), we end up selecting an OPP that has a higher 
cost than the one strictly required, which is expected. The goal is to 
speed things up at the expense of more power consumed to achieve the 
same work, hence at a lower efficiency (== higher cost).

That's the main reason why this boosting apply a margin on the cost of 
the selected OPP rather than just inflating the util. This allows 
controlling directly how much more power (battery life) we are going to 
spend to achieve some work that we know could be achieved with less 
power. This "how much more" is the margin. A policy for such boosting 
must obviously be quite picky in when it decides to boost (not boosting 
all the time). Decreasing the amount of negative slack is one situation 
where spending a bit more power to ensure the work is done in time can 
be more important than just efficiency, within reasonable limits. (the 
eternal efficiency vs throughput vs latency trade-off).

> 
>> Now if the task is aperiodic, the boost will allow reaching the highest frequency faster,
>> which may or may not be desired. Ultimately, it's not more or less wrong than just picking
>> the freq based on util_est alone, since util_est is already somewhat meaningless for aperiodic
>> tasks. It just allows reaching the max freq at some point without waiting for too long, which is
>> all what we can do without more info on the task.
>>
>> When applying these boosting rules on the runqueue util signals, we are able to detect if at least one
>> task needs boosting according to these rules. That only holds as long as the history we look at is
>> the result of a stable set of tasks, i.e. no tasks added or removed from the rq.
> 
> So while I agree that 2) is a reasonable signal to work from, everything
> that comes after is still much confusing me.


"Now if the task is aperiodic ...": What I mean by that is that AFAIK, 
there isn't really any fundamentally right or wrong way of choosing 
frequencies if the tasks we are dealing with are not periodic, unless 
you add more constraints to the problem. We currently base the decision 
on an overestimation of some kind of average running time per second of 
the task. The average being the EWMA implemented by PELT, not to be 
confused with util_est.ewma that adds an extra EWMA on top.

What "window" of time used for that average (or EWMA half life in our 
case) will change the value of the average for aperiodic tasks. The 
choice of that half life is driven by how much of the task history we 
want to take into account. That is driven by how often we expect tasks 
to change their "execution profile" on average so to speak (a thread 
pool picking disparate work items at random would change its profile 
very often for example).

Once this window or half life is chosen, we can ensure that the CPU will 
use a frequency high enough to avoid work piling up more than what can 
be computed using a simple proportional controller. The goal of the 
schedutil controller is to make sure that:
current CPU capa == current util * 1.25

All that to say that in the aperiodic case, some pieces of the setup are 
directly provided by the policy (PELT half life), which are empirically 
determined to perform well, without any way of computing an provably 
optimal value (unless we know for sure exactly when a task is going to 
change its workload and CPU share it will require). For periodic tasks, 
we can compute the exact frequency that will lead to using 100% of the 
CPU just by looking at the duty cycle of the tasks, and that's more or 
less what schedutil does.


"When applying these boosting rules on the runqueue util signals ...":
Assuming the set of enqueued tasks stays the same between 2 observations 
from schedutil, if we see the rq util_avg increase above its 
util_est.enqueued, that means that at least one task had its util_avg go 
above util_est.enqueued. We might miss some boosting opportunities if 
some (util - util_est) compensates:
TASK_1(util - util_est) = - TASK_2(util - util_est)
but working on the aggregated value is much easier in schedutil, to 
avoid crawling the list of entities.
