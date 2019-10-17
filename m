Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14165DAFF7
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 16:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390538AbfJQOXa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 10:23:30 -0400
Received: from [217.140.110.172] ([217.140.110.172]:37978 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1729451AbfJQOX3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Oct 2019 10:23:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5215031F;
        Thu, 17 Oct 2019 07:23:07 -0700 (PDT)
Received: from [10.1.195.43] (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B01623F6C4;
        Thu, 17 Oct 2019 07:23:05 -0700 (PDT)
From:   Douglas Raillard <douglas.raillard@arm.com>
Subject: Re: [RFC PATCH v3 0/6] sched/cpufreq: Make schedutil energy aware
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qperret@qperret.net,
        patrick.bellasi@matbug.net, dh.han@samsung.com
References: <20191011134500.235736-1-douglas.raillard@arm.com>
 <20191014145315.GZ2311@hirez.programming.kicks-ass.net>
 <a1ce67d7-62c3-b78b-1d87-23ef4dbc2274@arm.com>
 <20191017095015.GI2311@hirez.programming.kicks-ass.net>
Organization: ARM
Message-ID: <7edb1b73-54e7-5729-db5d-6b3b1b616064@arm.com>
Date:   Thu, 17 Oct 2019 15:23:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191017095015.GI2311@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Peter,

On 10/17/19 10:50 AM, Peter Zijlstra wrote:
> On Mon, Oct 14, 2019 at 04:50:24PM +0100, Douglas Raillard wrote:
> 
>> I posted some numbers based on a similar experiment on the v2 of that series that
>> are still applicable:
>>
>> TL;DR the rt-app negative slack is divided by 1.75 by this series, with an
>> increase of 3% in total energy consumption. There is a burst every 0.6s, and
>> the average power consumption increase is proportional to the average number
>> of bursts.
>>
>>
>> The workload is an rt-app task ramping up from 5% to 75% util in one big step,
>> pinned on a big core. The whole cycle is 0.6s long (0.3s at 5% followed by 0.3s at 75%).
>> This cycle is repeated 20 times and the average of boosting is taken.
>>
>> The test device is a Google Pixel 3 (Qcom Snapdragon 845) phone.
>> It has a lot more OPPs than a hikey 960, so gradations in boosting
>> are better reflected on frequency selection.
>>
>> avg slack (higher=better):
>>      Average time between task sleep and its next periodic activation.
>>      See rt-app doc: https://github.com/scheduler-tools/rt-app/blob/9a50d76f726d7c325c82ac8c7ed9ed70e1c97937/doc/tutorial.txt#L631
>>
>> avg negative slack (lower in absolute value=better):
>>      Same as avg slack, but only taking into account negative values.
>>      Negative slack means a task activation did not have enough time to complete before the next
>>      periodic activation fired, which is what we want to avoid.
>>
>> boost energy overhead (lower=better):
>>      Extra power consumption induced by ramp boost, assuming continuous OPP space (infinite number of OPP)
>>      and single-CPU policies. In practice, fixed number of OPP decrease this value, and more CPU per policy increases it,
>>      since boost(policy) = max(boost(cpu) foreach cpu of policy)).
>>
>> Without ramp boost:
>> +--------------------+--------------------+
>> |avg slack (us)      |avg negative slack  |
>> |                    |(us)                |
>> +--------------------+--------------------+
>> |6598.72             |-10217.13           |
>> |6595.49             |-10200.13           |
>> |6613.72             |-10401.06           |
>> |6600.29             |-9860.872           |
>> |6605.53             |-10057.64           |
>> |6612.05             |-10267.50           |
>> |6599.01             |-9939.60            |
>> |6593.79             |-9445.633           |
>> |6613.56             |-10276.75           |
>> |6595.44             |-9751.770           |
>> +--------------------+--------------------+
>> |average                                  |
>> +--------------------+--------------------+
>> |6602.76             |-10041.81           |
>> +--------------------+--------------------+
>>
>>
>> With ramp boost enabled:
>> +--------------------+--------------------+--------------------+
>> |boost energy        |avg slack (us)      |avg negative slack  |
>> |overhead (%)        |                    |(us)                |
>> +--------------------+--------------------+--------------------+
>> |3.05                |7148.93             |-5664.26            |
>> |3.04                |7144.69             |-5667.77            |
>> |3.05                |7149.05             |-5698.31            |
>> |2.97                |7126.71             |-6040.23            |
>> |3.02                |7140.28             |-5826.78            |
>> |3.03                |7135.11             |-5749.62            |
>> |3.05                |7140.24             |-5750.0             |
>> |3.05                |7144.84             |-5667.04            |
>> |3.07                |7157.30             |-5656.65            |
>> |3.06                |7154.65             |-5653.76            |
>> +--------------------+--------------------+--------------------+
>> |average                                                       |
>> +--------------------+--------------------+--------------------+
>> |3.039000            |7144.18             |-5737.44            |
>> +--------------------+--------------------+--------------------+
>>
>>
>> The negative slack is due to missed activations while the utilization signals
>> increase during the big utilization step. Ramp boost is designed to boost frequency during
>> that phase, which materializes in 1.75 less negative slack, for an extra power
>> consumption under 3%.
> 
> OK, so I think I see what it is doing, and why.
> 
> Normally we use (map_util_freq):
> 
> 	freq = C * max_freq * util / max ; C=1.25
> 
> But here, when util is increasing, we effectively increase our C to
> allow picking a higher OPP. Because of that higher OPP we finish our
> work sooner (avg slack increases)

Indeed. The increase in avg slack is much smaller than the absolute decrease in negative slack,
which means we don't boost when that's not necessary
(i.e. on activations where the slack is already positive).

> and miss our activation less often
> (avg neg slack decreases).

We actually miss the activation as often, but by a lesser amount of time,
which is desirable. Preventing from missing activations altogether could
probably be achieved by very aggressive boosting, at which point it might
be better/easier to just assume util=1024 and let it decrease to its
correct value. None of that sounds very appealing in the general case though.

> Now, the thing is, we use map_util_freq() in more places, and should we
> not reflect this increase in C for all of them? That is, why is this
> patch changing get_next_freq() and not map_util_freq().
> 
> I don't think that question is answered in the Changelogs.
> 
> Exactly because it does change the energy consumption (it must) should
> that not also be reflected in the EAS logic?

map_util_freq() is only used in schedutil and in EAS by compute_energy(), so
I retarget the question at compute_energy(). It is supposed to compute
the energy consumed by a given CPU if a given task was migrated on it.
This implies some assumptions on util signals:
1) util(_est.enqueued) of the task is representative of the task's duty cycle
   (the semantic of util is somehow blurry for aperiodic tasks AFAIK).
2) util of the task is CPU-invariant
3) task util + target CPU util = new target CPU util for the foreseeable future,
    i.e. the amount of future we can predict with reasonable accuracy. Otherwise
    we would end up moving things around all the time.

Since ramp boost is designed to be transient, integrating it (indirectly) in "target CPU util" will
add some noise to the placement decision, potentially rendering it obsolete as soon
as the boosting stops. Basing a costly decision on that does not sound like a good idea IMHO.

> I'm still thinking about the exact means you're using to raise C; that
> is, the 'util - util_est' as cost_margin. It hurts my brain still.

util_est is currently the best approximation of the actual portion of the CPU the task needs:
1) for periodic tasks, it's not too far from the duty cycle, and is always higher

2) for aperiodic tasks, it (indirectly) takes into account the total time it took
   to complete the previous activation, so the signal is not 100% composed of logical signals
   only relevant for periodic tasks (although it's a big part of it).

3) Point 1) and 2) together allows util_est to adapt to periodic tasks that changes
their duty cycle over time, without needing a very long history (the last task period
is sufficient).

For periodic tasks, the distance between instantaneous util_avg and the actual task
duty cycle indicates somehow what is our best guess of the (potential) change in the task
duty cycle.

util_est is the threshold (assuming util_avg increasing) for util_avg after which we know
for sure that even if the task stopped right now, its duty cycle would be higher than
during the previous period.
This means for a given task and with (util >= util_est):

1) util - util_est == 0 means the task duty cycle will be equal to the one during
   during the previous activation, if the tasks stopped executing right now.

2) util - util_est > 0 means the task duty cycle will be higher to the one during
   during the previous activation, if the tasks stopped executing right now.

Using the difference (util - util_est) will therefore give these properties to the boost signal:
* no boost will be applied as long as the task has a constant or decreasing duty cycle.

* when we can detect that the duty cycle increases, we temporarily increase the frequency.
   We start with a slight increase, and the longer we wait for the current period to finish,
   the more we boost, since the more likely it is that the task has a much larger duty cycle
   than anticipated. More specifically, the evaluation of "how much more" is done the exact
   same way as it is done for PELT, since the dynamic of the boost is "inherited" from PELT.
   
Now if the task is aperiodic, the boost will allow reaching the highest frequency faster,
which may or may not be desired. Ultimately, it's not more or less wrong than just picking
the freq based on util_est alone, since util_est is already somewhat meaningless for aperiodic
tasks. It just allows reaching the max freq at some point without waiting for too long, which is
all what we can do without more info on the task.

When applying these boosting rules on the runqueue util signals, we are able to detect if at least one
task needs boosting according to these rules. That only holds as long as the history we look at is
the result of a stable set of tasks, i.e. no tasks added or removed from the rq.


Regards,
Douglas
