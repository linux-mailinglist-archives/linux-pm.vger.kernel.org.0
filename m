Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCAEE15C9BB
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 18:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgBMRtw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 12:49:52 -0500
Received: from foss.arm.com ([217.140.110.172]:51600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgBMRtw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Feb 2020 12:49:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 658C3328;
        Thu, 13 Feb 2020 09:49:51 -0800 (PST)
Received: from [10.1.195.43] (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 389A93F68E;
        Thu, 13 Feb 2020 09:49:50 -0800 (PST)
Subject: Re: [RFC PATCH v4 0/6] sched/cpufreq: Make schedutil energy aware
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        qperret@google.com, linux-pm@vger.kernel.org
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
 <c49ca012-bb3e-580d-9b45-359caa67d7c1@arm.com>
 <20200210132133.GH14897@hirez.programming.kicks-ass.net>
From:   Douglas Raillard <douglas.raillard@arm.com>
Organization: ARM
Message-ID: <4a664419-f5a6-882f-83ee-5bbf20ff33d3@arm.com>
Date:   Thu, 13 Feb 2020 17:49:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200210132133.GH14897@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/10/20 1:21 PM, Peter Zijlstra wrote:
> On Wed, Jan 22, 2020 at 06:14:24PM +0000, Douglas Raillard wrote:
>> Hi Peter,
>>
>> Since the v3 was posted a while ago, here is a short recap of the hanging
>> comments:
>>
>> * The boost margin was relative, but we came to the conclusion it would make
>>   more sense to make it absolute (done in that v4).
> 
> As per (patch #1):
> 
> +       max_cost = pd->table[pd->nr_cap_states - 1].cost;
> +       cost_margin = (cost_margin * max_cost) / EM_COST_MARGIN_SCALE;
> 
> So we'll allow the boost to double energy consumption (or rather, since
> you cannot go above the max OPP, we're allowed that).

Indeed. This might need some tweaking based on testing, maybe +50% is
enough, or maybe +200% is even better.


>> * The main remaining blur point was why defining boost=(util - util_est) makes
>>   sense. The justification for that is that we use PELT-shaped signal to drive
>>   the frequency, so using a PELT-shaped signal for the boost makes sense for the
>>   same reasons.
> 
> As per (patch #4):
> 
> +       unsigned long boost = 0;
> 
> +       if (util_est_enqueued == sg_cpu->util_est_enqueued &&
> +           util_avg >= sg_cpu->util_avg &&
> +           util_avg > util_est_enqueued)
> +               boost = util_avg - util_est_enqueued;
> 
> The result of that is not, strictly speaking, a PELT shaped signal.
> Although when it is !0 the curves are similar, albeit offset.

Yes, it has the same rate of increase as PELT.

> 
>> AFAIK there is no specific criteria to meet for frequency selection signal shape
>> for anything else than periodic tasks (if we don't add other constraints on
>> top), so (util - util_est)=(util - constant) seems as good as anything else.
>> Especially since util is deemed to be a good fit in practice for frequency
>> selection. Let me know if I missed anything on that front.
> 
> 
> Given:
> 
>   sugov_get_util() <- cpu_util_cfs() <- UTIL_EST ? util_est.enqueued : util_avg.

cpu_util_cfs uses max_t (maybe irrelevant for this discussion):
UTIL_EST ? max(util_est.enqueued, util_avg) : util_avg

> our next_f becomes:
> 
>   next_f = 1.25 * util_est * max_freq / max;

> so our min_freq in em_pd_get_higher_freq() will already be compensated
> for the offset.

Yes, the boost is added on top of the existing behavior.

> So even when:
> 
>   boost = util_avg - util_est
> 
> is small, despite util_avg being huge (~1024), due to large util_est,
> we'll still get an effective boost to max_cost ASSUMING cs[].cost and
> cost_margin have the same curve.

I'm not sure to follow, cs[].cost can be plotted against cs[].freq, but
cost_margin is a time-based signal (the boost value), so it would be
plotted against time.

> 
> They have not.
> 
> assuming cs[].cost ~ f^3, and given our cost_margin ~ f, that leaves a
> factor f^2 on the table.

I'm guessing that you arrived to `cost_margin ~ f` this way:

cost_margin = util - util_est_enqueued
cost_margin = util - constant

# with constant small enough
cost_margin ~ util

# with util ~ 1/f
cost_margin ~ 1/f

In the case you describe, `constant` is actually almost equal to `util`
so `cost_margin ~! util`, and that series assumes frequency invariant
util_avg so `util !~ 1/f` (I'll probably have to fix that).

> So the higher the min_freq, the less effective the boost.

Yes, since the boost is allowing a fixed amount of extra power. Higher
OPPs are less efficient than lower ones, so if min_freq is high, we
won't speed up as much as if min_freq was low.

> Maybe it all works out in practise, but I'm missing a big picture

Here is a big picture :)

https://gist.github.com/douglas-raillard-arm/f76586428836ec70c6db372993e0b731#file-ramp_boost-svg

The board is a Juno R0, with a periodic task pinned on a big CPU
(capa=1024):
* phase 1:  5% duty cycle (=51 PELT units)
* phase 2: 75% duty cycle (=768 PELT units)

Legend:
* blue square wave: when the task executes (like in kernelshark)
* base_cost = cost of frequency as selected by schedutil in normal
operations
* allowed_cost = base_cost + cost_margin
* util = util_avg

note: the small gaps right after the duty cycle transition between
t=4.15 and 4.25 are due to sugov task executing, so there is no dequeue
and no util_est update.

> description of it all somewhere.

Now a textual version of it:

em_pd_get_higher_freq() does the following:

# Turn the abstract cost margin on the EM_COST_MARGIN_SCALE into a
# concrete value. cost_margin=EM_COST_MARGIN_SCALE will give a concrete
# value of "max_cost", which is the highest OPP on that CPU.
concrete_margin = (cost_margin * max_cost) / EM_COST_MARGIN_SCALE;

# Then it finds the lowest OPP satisfying min_freq:
min_opp = OPP_AT_FREQ(min_freq)

# It takes the cost associated, and finds the highest OPP that has a
# cost lower than that:
max_cost = COST_OF(min_opp) + concrete_margin

final_freq = MAX(
	FREQ_OF(opp)
	for opp in available_opps
	if COST_OF(opp) <= max_cost
)

So this means that:
   util - util_est_enqueued ~= 0
=> cost_margin              ~= 0
=> concrete_cost_margin     ~= 0
=> max_cost   = COST_OF(min_opp) + 0
=> final_freq = FREQ_OF(min_opp)

The effective boost is ~0, so you will get the current behaviour of
schedutil.

If the task starts needing more cycles than during its previous period,
`util - util_est_enqueued` will grow like util since util_est_enqueued
is constant. The longer we wait, the higher the boost, until the task
goes to sleep again.

At next wakeup, util_est_enqueued has caught up and either:
1) util becomes stable, so no more boosting
2) util keeps increasing, so go for another round of boosting


Thanks,
Douglas
