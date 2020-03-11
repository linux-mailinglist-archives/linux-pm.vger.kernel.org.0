Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 315881817ED
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 13:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgCKMZO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 08:25:14 -0400
Received: from foss.arm.com ([217.140.110.172]:48952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbgCKMZO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Mar 2020 08:25:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F9127FA;
        Wed, 11 Mar 2020 05:25:13 -0700 (PDT)
Received: from [10.1.195.43] (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7B523F6CF;
        Wed, 11 Mar 2020 05:25:11 -0700 (PDT)
Subject: Re: [RFC PATCH v4 0/6] sched/cpufreq: Make schedutil energy aware
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        qperret@google.com, linux-pm@vger.kernel.org
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
 <c49ca012-bb3e-580d-9b45-359caa67d7c1@arm.com>
 <20200210132133.GH14897@hirez.programming.kicks-ass.net>
 <4a664419-f5a6-882f-83ee-5bbf20ff33d3@arm.com>
 <20200214125249.GL14879@hirez.programming.kicks-ass.net>
From:   Douglas Raillard <douglas.raillard@arm.com>
Organization: ARM
Message-ID: <418dbb89-57b7-e642-d851-d228f7e0a288@arm.com>
Date:   Wed, 11 Mar 2020 12:25:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200214125249.GL14879@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Peter,

The preemption stack unwinded back to schedutil :)

On 2/14/20 12:52 PM, Peter Zijlstra wrote:
> On Thu, Feb 13, 2020 at 05:49:48PM +0000, Douglas Raillard wrote:
>> On 2/10/20 1:21 PM, Peter Zijlstra wrote:
> 
>>> assuming cs[].cost ~ f^3, and given our cost_margin ~ f, that leaves a
>>> factor f^2 on the table.
>>
>> I'm guessing that you arrived to `cost_margin ~ f` this way:
>>
>> cost_margin = util - util_est_enqueued
>> cost_margin = util - constant
>>
>> # with constant small enough
>> cost_margin ~ util
>>
>> # with util ~ 1/f
>> cost_margin ~ 1/f
>>
>> In the case you describe, `constant` is actually almost equal to `util`
>> so `cost_margin ~! util`, and that series assumes frequency invariant
>> util_avg so `util !~ 1/f` (I'll probably have to fix that).
> 
> Nah, perhaps already clear from the other email; but it goes like:
> 
>   boost = util_avg - util_est
>   cost_margin = boost * C = C * util_avg - C * util_est
> 
> And since u ~ f (per schedutil construction), cost_margin is a function
> linear in either u or f.

cost_margin(u) is not linear in `u` or `f`, as that does not hold:

cost_margin(A*u) = (A*u - CONSTANT)
                != A*u - A*CONSTANT
                   A * (u - CONSTANT)
		   A * cost_margin(u)

This would only approximately work if CONSTANT was much smaller than u,
which it isn't.

The tricky part is that CONSTANT is actually CONSTANT(u), but the
relation between u and CONSTANT is time-dependent.

That said, the problem can be simplified if we split it in two phases:

* when boost != 0 for a given task, in which case CONSTANT(u) is a true
constant by construction, i.e. cost_margin(u) !~ u.

* when boost = 0 for a given task: all that matters is that only one
task is boosted at a time, so that we can easily relate task composition
and boost composition as done in:
https://lore.kernel.org/lkml/5d732dc1-d343-24d2-bda9-072021a510ed@arm.com/
note: as mentioned in that email, this reasoning relies on
util_est_enqueued(wload) at rq level being linear in wload, which does
not hold with preemption. That would be fixed by working on task signals
rather than rq aggregated ones.

> 
>>> So the higher the min_freq, the less effective the boost.

Ultimately I can't remember exactly what the cost_margin(u) linearity
was intended to be used for, but the relative impact of boosting does
become smaller if u is already high.

This is by design, as the dynamic of that boosting is purposely mostly
tied to local PELT variations, by removing a fixed offset from it. I
don't think big tasks specifically deserve more boosting, as it would
imply the incertitude on their new period is higher. We would need a
more real world trace evaluating how the duty cycle changes relate to
the initial duty cycle. That should not be particularly difficult to do,
but the trace parsing infrastructure in LISA currently does not handle
very nicely large traces, so that will probably have to wait until I get
around fixing that by using libtraceevent from trace-cmd project.

This means boosting currently depends on two things:
1) the PELT parameters (half life and window size)
2) the former task period

1) is fixed by definition in the kernel.
2) will make boosting more aggressive for short periods (i.e. the boost
will rise faster). The initial rate of increase of boosting once it
triggers should be related to the former task period in (approximately)
that way:

|   period (s) |   boost rate of increase (PELT unit/ms) |
|-------------:|----------------------------------------:|
|        0     |                                21.3839  |
|        0.016 |                                15.3101  |
|        0.032 |                                10.9615  |
|        0.048 |                                 7.84807 |
|        0.064 |                                 5.61895 |
|        0.08  |                                 4.02297 |
|        0.096 |                                 2.8803  |
|        0.112 |                                 2.0622  |
|        0.128 |                                 1.47646 |


This assumes that while the task is running:
util_avg(t) =
   util_avg(t_enqueue) + 1024 * (1-e^(-(t - t_enqueue)/tau))

with tau:
    # tau as defined by:
https://en.wikipedia.org/wiki/Low-pass_filter#Simple_infinite_impulse_response_filter
    # Alpha as defined in https://en.wikipedia.org/wiki/Moving_average
    decay = (1 / 2)^(1 / half_life)
    alpha = 1 - decay
    window = 1024 * 1024 * 1e-9
    tau = window * ((1 - alpha) / alpha)
    tau = 0.047886417385345964
>>
>> Yes, since the boost is allowing a fixed amount of extra power. Higher
>> OPPs are less efficient than lower ones, so if min_freq is high, we
>> won't speed up as much as if min_freq was low.
>>
>>> Maybe it all works out in practise, but I'm missing a big picture
>>
>> Here is a big picture :)
>>
>> https://gist.github.com/douglas-raillard-arm/f76586428836ec70c6db372993e0b731#file-ramp_boost-svg
>>
>> The board is a Juno R0, with a periodic task pinned on a big CPU
>> (capa=1024):
>> * phase 1:  5% duty cycle (=51 PELT units)
>> * phase 2: 75% duty cycle (=768 PELT units)
>>
>> Legend:
>> * blue square wave: when the task executes (like in kernelshark)
>> * base_cost = cost of frequency as selected by schedutil in normal
>> operations
>> * allowed_cost = base_cost + cost_margin
>> * util = util_avg
>>
>> note: the small gaps right after the duty cycle transition between
>> t=4.15 and 4.25 are due to sugov task executing, so there is no dequeue
>> and no util_est update.
> 
> I'm confused by the giant drop in frequency (blue line) around 4.18
>
> schedutil shouldn't select f < max(util_avg, util_est), which is
> violated right about there.

AFAICT that's due the boost being disabled, which means the allowed cost
becomes smaller. The boost is disabled because the task's
util_est_enqueued has been updated since last schedutil invocation, so
the rq one changes, which in turn disables boosting.

Here are the normalized costs on the CPU the workload was run on:

|    freq |     cost |     capa |
|--------:|---------:|---------:|
|  450000 |  67.086  |  418.909 |
|  625000 |  72.1509 |  581.818 |
|  800000 |  80.8962 |  744.727 |
|  950000 |  90.1688 |  884.364 |
| 1100000 | 100      | 1024     |

In our case, it seems that schedutil is invoked when the task is
preempted (presumably by schedutil kthread) and we end up with:
util_avg          ~= 370
util_est_enqueued ~= 427.
We therefore end up at freq=625000 (capa=581).

> I'm also confused by the base_cost line; how can that be flat until
> somewhere around 4.16.

The minimum frequency on the board being used provides a capacity of
418, so it stays flat until max(util_avg, util_est) goes above that.

> Sadly there is no line for pure schedutil freq to
> compare against.

I could add that one fairly easily. Would you be interested in the
"real" frequency selected by normal schedutil or the "ideal" frequency
schedutil would like to apply ?

> Other than that, I can see the green line is consistent with
> util_avg>util_est, and how it help grow the frequency (blue).
> 
