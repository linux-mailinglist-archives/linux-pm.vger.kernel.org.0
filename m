Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDE7157389
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2020 12:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgBJLhc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Feb 2020 06:37:32 -0500
Received: from foss.arm.com ([217.140.110.172]:59062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgBJLhc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Feb 2020 06:37:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C6C11FB;
        Mon, 10 Feb 2020 03:37:31 -0800 (PST)
Received: from [10.1.195.43] (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC73B3F6CF;
        Mon, 10 Feb 2020 03:37:29 -0800 (PST)
From:   Douglas Raillard <douglas.raillard@arm.com>
Subject: Re: [RFC PATCH v4 0/6] sched/cpufreq: Make schedutil energy aware
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        viresh kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <qperret@google.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
 <CAKfTPtC9A6KVwYsQWgXXk-12GeJhkJfEm3Lk=LjcoOJvvoZ1uA@mail.gmail.com>
Organization: ARM
Message-ID: <0fa87613-d74f-ad2c-38a9-76e2efd172d1@arm.com>
Date:   Mon, 10 Feb 2020 11:37:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtC9A6KVwYsQWgXXk-12GeJhkJfEm3Lk=LjcoOJvvoZ1uA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Vincent,

On 1/27/20 5:16 PM, Vincent Guittot wrote:
> On Wed, 22 Jan 2020 at 18:36, Douglas RAILLARD <douglas.raillard@arm.com> wrote:
>>
>> Make schedutil cpufreq governor energy-aware.
>>
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
>>
>> 1) Selecting the highest possible frequency for a given cost. Some
>>    platforms can have lower frequencies that are less efficient than
>>    higher ones, in which case they should be skipped for most purposes.
> 
> This make sense. Why using a lower frequency when a higher one is more
> power efficient

Apparently in some cases it can be useful for thermal capping. AFAIU the
alternate solution is to race to idle with a more efficient OPP (idle
injection work of Linaro).

>>    They can still be useful to give more freedom to thermal throttling
>>    mechanisms, but not under normal circumstances.
>>    note: the EM framework will warn about such OPPs "hertz/watts ratio
>>    non-monotonically decreasing"
>>
>> 2) Driving the frequency selection with power in mind, in addition to
>>    maximizing the utilization of the non-idle CPUs in the system.
>>
>> Point 1) is implemented in "PM: Introduce em_pd_get_higher_freq()" and
>> enabled in schedutil by
>> "sched/cpufreq: Hook em_pd_get_higher_power() into get_next_freq()".
>>
>> Point 2) is enabled in
>> "sched/cpufreq: Boost schedutil frequency ramp up". It allows using
>> higher frequencies when it is known that the true utilization of
>> currently running tasks is exceeding their previous stable point.
>> The benefits are:
>>
>> * Boosting the frequency when the behavior of a runnable task changes,
>>   leading to an increase in utilization. That shortens the frequency
>>   ramp up duration, which in turns allows the utilization signal to
>>   reach stable values quicker.  Since the allowed frequency boost is
>>   bounded in energy, it will behave consistently across platforms,
>>   regardless of the OPP cost range.
> 
> Could you explain this a bit more ?

The goal is to detect when the task starts asking more CPU time than it
did during the previous period. At this stage, we don't know how much
more, so we increase the frequency faster to allow signals to settle
more quickly.

The PELT signal does increases independently from the chosen frequency,
but that's only up until idle time shows up. At this point, the util
will drop again, and the frequency with it.

>>
>> * The boost is only transient, and should not impact a lot the energy
>>   consumed of workloads with very stable utilization signals.
>>
>> This has been lightly tested with a rtapp task ramping from 10% to 75%
>> utilisation on a big core.
> 
> Which kind of UC are you targeting ?

One case are tasks with "random" behavior like threads in thread pools
that can end up doing very different things. There may be other cases as
well, but I'll need to do more extensive testing with actual applications.

> 
> Do you have some benchmark showing the benefit and how you can bound
> the increase of energy ?

In the test setup described above, it increases the energy consumption
by ~2.5%.

I also did some preliminary experiments to reduce the margin taken in
map_util_freq(), which becomes less necessary if the frequency is
boosted in the cases where util increase is getting out of hands. That
can recover some amount of lost power.

The real cost in practice heavily depends on:
* the workloads (if its util jumps around, it will boost more frequently)
* the discrete frequencies available (if boosting does not bring us to
the next freq, no boost is actually applied).

> 
> The benefit of point2 is less obvious for me. We already have uclamp
> which helps to overwrite the "utilization" that is seen by schedutil
> to boost or cap the frequency when some tasks are running. I'm curious
> to see what would be the benefit of this on top.

uclamp is only useful when a target utilization is known beforehand by
the task itself or some kind of manager. In all the cases relying on
plain PELT, we can decrease the freq change reaction time.

Note that schedutil is already built around the duty cycle detection
with a bias for higher frequency when the task period increases (using
util est enqueued). What this series bring is a way to detect when util
est enqueued turns from a set-point into a lower bound.

>>
>> v1 -> v2:
>>
>>   * Split the new sugov_cpu_ramp_boost() from the existing
>>     sugov_cpu_is_busy() as they seem to seek a different goal.
>>
>>   * Implement sugov_cpu_ramp_boost() based on CFS util_avg and
>>     util_est_enqueued signals, rather than using idle calls count.
>>     This makes the ramp boost much more accurate in finding boost
>>     opportunities, and give a "continuous" output rather than a boolean.
>>
>>   * Add EM_COST_MARGIN_SCALE=1024 to represent the
>>     margin values of em_pd_get_higher_freq().
>>
>> v2 -> v3:
>>
>>   * Check util_avg >= sg_cpu->util_avg in sugov_cpu_ramp_boost_update()
>>     to avoid boosting when the utilization is decreasing.
>>
>>   * Add a tracepoint for testing.
>>
>> v3 -> v4:
>>
>>   * em_pd_get_higher_freq() now interprets the margin as absolute,
>>     rather than relative to the cost of the base frequency.
>>
>>   * Modify misleading comment in em_pd_get_higher_freq() since min_freq
>>     can actually be higher than the max available frequency in normal
>>     operations.
>>
>> Douglas RAILLARD (6):
>>   PM: Introduce em_pd_get_higher_freq()
>>   sched/cpufreq: Attach perf domain to sugov policy
>>   sched/cpufreq: Hook em_pd_get_higher_power() into get_next_freq()
>>   sched/cpufreq: Introduce sugov_cpu_ramp_boost
>>   sched/cpufreq: Boost schedutil frequency ramp up
>>   sched/cpufreq: Add schedutil_em_tp tracepoint
>>
>>  include/linux/energy_model.h     |  56 ++++++++++++++
>>  include/trace/events/power.h     |   9 +++
>>  kernel/sched/cpufreq_schedutil.c | 124 +++++++++++++++++++++++++++++--
>>  3 files changed, 182 insertions(+), 7 deletions(-)
>>
>> --
>> 2.24.1
>>
