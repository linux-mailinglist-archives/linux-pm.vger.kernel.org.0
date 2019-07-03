Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB085E944
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 18:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfGCQgR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 12:36:17 -0400
Received: from foss.arm.com ([217.140.110.172]:52414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfGCQgR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Jul 2019 12:36:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8189A1478;
        Wed,  3 Jul 2019 09:36:16 -0700 (PDT)
Received: from [10.1.195.43] (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D7C03F740;
        Wed,  3 Jul 2019 09:36:15 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/5] sched/cpufreq: Make schedutil energy aware
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        quentin.perret@arm.com, patrick.bellasi@arm.com,
        dietmar.eggemann@arm.com
References: <20190627171603.14767-1-douglas.raillard@arm.com>
 <20190702155115.GW3436@hirez.programming.kicks-ass.net>
From:   Douglas Raillard <douglas.raillard@arm.com>
Organization: ARM
Message-ID: <5198292b-1874-9ff4-6a9f-826a5ea00466@arm.com>
Date:   Wed, 3 Jul 2019 17:36:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190702155115.GW3436@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/2/19 4:51 PM, Peter Zijlstra wrote:
> On Thu, Jun 27, 2019 at 06:15:58PM +0100, Douglas RAILLARD wrote:
>> Make schedutil cpufreq governor energy-aware.
>>
>> - patch 4 adds sugov_cpu_ramp_boost() function.
>> - patch 5 updates sugov_update_(single|shared)() to make use of
>>    sugov_cpu_ramp_boost().
>>
>> The benefits of using the EM in schedutil are twofold:
> 
>> 2) Driving the frequency selection with power in mind, in addition to
>>     maximizing the utilization of the non-idle CPUs in the system.
> 
>> Point 2) is enabled in
>> "sched/cpufreq: Boost schedutil frequency ramp up". It allows using
>> higher frequencies when it is known that the true utilization of
>> currently running tasks is exceeding their previous stable point.
>> The benefits are:
>>
>> * Boosting the frequency when the behavior of a runnable task changes,
>>    leading to an increase in utilization. That shortens the frequency
>>    ramp up duration, which in turns allows the utilization signal to
>>    reach stable values quicker.  Since the allowed frequency boost is
>>    bounded in energy, it will behave consistently across platforms,
>>    regardless of the OPP cost range.
>>
>> * The boost is only transient, and should not impact a lot the energy
>>    consumed of workloads with very stable utilization signals.
> 

[reordered original comments]

> This then obviously has relation to Patrick's patch that makes the EWMA
> asymmetric, but I'm thinking that the interaction is mostly favourable?

Making task_ue.ewma larger makes cpu_ue.enqueued larger, so Patrick's patch
helps increasing the utilisation as seen by schedutil in that transient time.
(see discussion on schedutil signals at the bottom). That goes in the same
direction as this series.

> So you're allowing a higher pick when the EWMA exceeds the enqueue
> thing.

TLDR: Schedutil ramp boost works on CPU rq signals, for which util est EWMA
is not defined, but the idea is the same (replace util est EWMA by util_avg).

The important point here is that when util_avg for the task becomes higher
than task_ue.enqueued, it means the knowledge of the actual needs of the task
is turned into a lower bound (=task_ue.enqueued) rather than an exact value.
This means that selecting a higher frequency than that is:
a) necessary, the task needs more computational power to do its job.
b) a shot in the dark, as it's impossible to predict exactly how much it will
    need without a crystal ball.

When adding ramp boost, the bill is split: part of the "shot in the dark" comes from
the growing CPU's util_avg (see schedutil_u definition at the bottom), and part of it
comes from the ramp boost. We don't want to make the boost too costly either since
it's a shot in the dark. Therefore, we make the boost proportional to a battery life
cost rather than some guessed utilisation.

Now that I think about it, it may make sense to let this ramp-boost completely
handle this "future util prediction" case, as it's not better or worse than
util_avg at that (since it's based on it), but allows better control on
the cost of a (mis)prediction.

> 
> I'm not immediately seeing how it is transient; that is, PELT has a
> wobble in it's steady state, is that accounted for?
> 

The transient-ness of the ramp boost I'm introducing comes from the fact that for a
periodic task at steady state, task_ue.enqueued <= task_u when the task is executing.
That is because task_ue.enqueued is sampled at dequeue time, precisely at the moment
at which task_u is reaching its max for that task. Since we only take into account
positive boosts, ramp boost will only have an impact in the "increase transients".


About signals schedutil is based on
===================================

Here is the state of signals used by schedutil to my knowledge to compute
the final "chosen_freq":

# let's define short names to talk about
task_ue = se.avg.util_est
task_u = se.avg.util_avg

cpu_ue = cfs_rq->avg.util_est
cpu_u = cfs_rq->avg.util_avg


# How things are defined
task_u ~= LOW_PASS_FILTER(task_activations)
task_ue.enqueued = SAMPLE_AT_DEQUEUE_AND_HOLD(task_u)
task_ue.ewma = LOW_PASS_FILTER(task_ue.enqueued)

# Patrick's patch amends task_ue.ewma definition this way:
task_ue.ewma =
	| task_ue.enqueued > task_ue.ewma: task_ue.enqueued
	| otherwise			 : LOW_PASS_FILTER(task_ue.enqueued)


cpu_ue.enqueued = SUM[MAX(task_ue.ewma, task_ue.enqueued) forall task_ue in enqueued_tasks]
cpu_u = SUM[task_u forall task_ue in enqueued_tasks]

# What schedutil considers when taking freq decisions

non_cfs_u = util of deadline + rt + irq
schedutil_u = non_cfs_u + APPLY_UCLAMP(MAX(cpu_ue.enqueued, cpu_u)) + iowait_boost
schedutil_base_freq = MAP_UTIL_FREQ(schedutil_u)

STABLE(signal) =
	| signal equal to the last time it was sampled by caller: True
	| otherwise				      		: False
# A diff between two util signals is converted to a EM_COST_MARGIN_SCALE value.
# They are different units, but the conversion factor is 1 in practice.
ramp_boost =
	| cpu_ue.enqueued > cpu_u && STABLE(cpu_ue.enqueued):
		(cpu_ue.enqueued - cpu_u) * (EM_COST_MARGIN_SCALE/SCHED_CAPACITY_SCALE)
	| otherwise: 0

APPLY_RAMP_BOOST(boost, base_freq) = boosted_freq
	with
		acceptable_cost = ENERGY_MODEL_COST(base_freq) * (EM_COST_MARGIN_SCALE + boost)
		boosted_freq = MAX[freq forall freqs if ENERGY_MODEL_COST(freq) < acceptable_cost]

# ramp-boost is applied on a freq instead of a util (unlike iowait_boost), since
# the function ENERGY_MODEL_COST(freq) is provided by the EM, and an equivalent
# ENERGY_MODEL_COST(util) would need extra calls to MAP_UTIL_FREQ().
schedutil_freq = APPLY_RAMP_BOOST(ramp_boost, schedutil_base_freq)

REAL_FREQ(ideal_freq) = MIN[freq forall freqs if freq >= ideal_freq]
POLICY_CLAMP(freq) =
	| freq < policy_min_freq: policy_min_freq
	| freq > policy_max_freq: policy_max_freq
	| otherwise		: freq
# Frequency finally used for the policy
chosen_freq = POLICY_CLAMP(REAL_FREQ(schedutil_freq))


Thanks,
Douglas
