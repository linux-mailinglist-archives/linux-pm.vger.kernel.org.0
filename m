Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5630D146F5D
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 18:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgAWRQ4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jan 2020 12:16:56 -0500
Received: from foss.arm.com ([217.140.110.172]:42552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728731AbgAWRQ4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Jan 2020 12:16:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1227D1FB;
        Thu, 23 Jan 2020 09:16:55 -0800 (PST)
Received: from [10.1.195.43] (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C37633F52E;
        Thu, 23 Jan 2020 09:16:53 -0800 (PST)
Subject: Re: [RFC PATCH v4 0/6] sched/cpufreq: Make schedutil energy aware
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        qperret@google.com, Linux PM <linux-pm@vger.kernel.org>
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
 <CAJZ5v0hL9AbpgivRGtCtqQo4XRYdt=SDjD=_FAVZmKAi=+VvzA@mail.gmail.com>
From:   Douglas Raillard <douglas.raillard@arm.com>
Organization: ARM
Message-ID: <d0155018-52e6-e1c9-a03d-1b9703b7a28a@arm.com>
Date:   Thu, 23 Jan 2020 17:16:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hL9AbpgivRGtCtqQo4XRYdt=SDjD=_FAVZmKAi=+VvzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On 1/23/20 3:43 PM, Rafael J. Wysocki wrote:
> On Wed, Jan 22, 2020 at 6:36 PM Douglas RAILLARD
> <douglas.raillard@arm.com> wrote:
>>
>> Make schedutil cpufreq governor energy-aware.
> 
> I have to say that your terminology is confusing to me, like what
> exactly does "energy-aware" mean in the first place?

Should be better rephrased as "Make schedutil cpufreq governor use the
energy model" I guess. Schedutil is indeed already energy aware since it
tries to use the lowest frequency possible for the job to be done (kind of).

> 
>> - patch 1 introduces a function to retrieve a frequency given a base
>>   frequency and an energy cost margin.
>> - patch 2 links Energy Model perf_domain to sugov_policy.
>> - patch 3 updates get_next_freq() to make use of the Energy Model.
>> - patch 4 adds sugov_cpu_ramp_boost() function.
>> - patch 5 updates sugov_update_(single|shared)() to make use of
>>   sugov_cpu_ramp_boost().
>> - patch 6 introduces a tracepoint in get_next_freq() for
>>   testing/debugging. Since it's not a trace event, it's not exposed to
>>   userspace in a directly usable way, allowing for painless future
>>   updates/removal.
>>
>> The benefits of using the EM in schedutil are twofold:
> 
> I guess you mean using the EM directly in schedutil (note that it is
> used indirectly already, because of EAS), but that needs to be clearly
> stated.

In the current state (of the code and my knowledge), the EM "leaks" into
schedutil only by the fact that tasks are moved around by EAS, so the
CPU util seen by schedutil is impacted compared to the same workload on
non-EAS setup.

Other than that, the only energy-related information schedutil uses is
the assumption that lower freq == better efficiency. Explicit use of the
EM allows to refine this assumption.

> 
>> 1) Selecting the highest possible frequency for a given cost. Some
>>    platforms can have lower frequencies that are less efficient than
>>    higher ones, in which case they should be skipped for most purposes.
>>    They can still be useful to give more freedom to thermal throttling
>>    mechanisms, but not under normal circumstances.
>>    note: the EM framework will warn about such OPPs "hertz/watts ratio
>>    non-monotonically decreasing"
> 
> While all of that is fair enough for platforms using the EM, do you
> realize that the EM is not available on the majority of architectures
> (including some fairly significant ones) and so adding overhead
> related to it for all of them is quite less than welcome?

When CONFIG_ENERGY_MODEL is not defined, em_pd_get_higher_freq() is
defined to a static inline no-op function, so that feature won't incur
overhead (patch 1+2+3).

Patch 4 and 5 do add some new logic that could be used on any platform.
Current code will use the boost as an energy margin, but it would be
straightforward to make a util-based version (like iowait boost) on
non-EM platforms.

>> 2) Driving the frequency selection with power in mind, in addition to
>>    maximizing the utilization of the non-idle CPUs in the system.
> 
> Care to explain this?  I'm totally unsure what you mean here.

Currently, schedutil is basically tailoring the CPU capacity to the util
of the tasks on it. That's all good for periodic tasks, but there are
situations where we can do better than assuming the task is periodic
with a fixed duty cycle.

The case improved by that series is when a task increases its duty
cycle. In that specific case, it can be a good idea to increase the
frequency until the util stabilizes again. We don't have a crystal ball
so we can't adjust the freq right away. However, we do want to avoid the
task to crave for speed until schedutil realizes it needs it. Using the
EM here allows to boost within reasonable limits, without destroying the
average energy consumption.

> 
>> Point 1) is implemented in "PM: Introduce em_pd_get_higher_freq()" and
>> enabled in schedutil by
>> "sched/cpufreq: Hook em_pd_get_higher_power() into get_next_freq()".
>>
>> Point 2) is enabled in
>> "sched/cpufreq: Boost schedutil frequency ramp up". It allows using
>> higher frequencies when it is known that the true utilization of
>> currently running tasks is exceeding their previous stable point.
> 
> Please explain "true utilization" and "stable point".

"true utilization" would be an instantaneous duty cycle. If a task
suddenly starts doing twice as much work, its "true utilization" will
double instantly. "stable point" would be util est enqueued here. If a
task is periodic, util est enqueued will be constant once it reaches a
steady state. As soon as the duty cycle of the task changes, util est
enqueued will change.

> 
>> The benefits are:
>>
>> * Boosting the frequency when the behavior of a runnable task changes,
>>   leading to an increase in utilization. That shortens the frequency
>>   ramp up duration, which in turns allows the utilization signal to
>>   reach stable values quicker.  Since the allowed frequency boost is
>>   bounded in energy, it will behave consistently across platforms,
>>   regardless of the OPP cost range.
> 
> Sounds good.
> 
> Can you please describe the algorithm applied to achieve that?

The util est enqueued of a task is basically a snapshot of the util of
the task just before it's dequeued. This means that when the util has
stabilized, util est enqueued will be a constant signal. Specifically,
util est enqueued will be an upper bound of the swing of util avg.

When the task starts doing more work than at the previous activation,
its util avg will rise above the current util est enqueued. This means
we cannot assume anymore that util est enqueued represents an upper
bound of the duty cycle, so we can decide to boost until util avg
"stabilizes" again [note].

At the CPU level, we can track that in the rq aggregated signals:
  - "stable rq's util est enqueued" is assumed to mean "same set of
enqueued tasks as the last time we looked at that rq".

  - task util est enqueued and util avg can be replaced by the rq
signal. This will hide cases where a task's util increases while another
one decreases by the same amount.

The limitations of both assumptions can be fixed by more invasive
changes (a rq cookie to know the set of enqueued tasks and an
OR-aggregated per-task flag to ask for boosting), but these heuristics
allow using the existing signals with changes limited to schedutil.

Once we detected this situation, we can decide to boost. We don't want
black&white boosting, since a tiny increase in util should lead to a
tiny boost. Here, we use (util - util_est_enqueued). If the increase is
small, that boost will be small.


[note]:
util avg of a periodic task never actually stabilizes, it just enters an
interval and never leaves it. When the duty cycle changes, it will leave
that interval to enter another one. The centre of that interval is the
task's duty cycle.


>> * The boost is only transient, and should not impact a lot the energy
>>   consumed of workloads with very stable utilization signals.

Thanks,
Douglas
