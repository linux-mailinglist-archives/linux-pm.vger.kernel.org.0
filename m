Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86461181848
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 13:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbgCKMlA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 08:41:00 -0400
Received: from foss.arm.com ([217.140.110.172]:49196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729317AbgCKMlA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Mar 2020 08:41:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F3091FB;
        Wed, 11 Mar 2020 05:41:00 -0700 (PDT)
Received: from [10.1.195.43] (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7CEC3F6CF;
        Wed, 11 Mar 2020 05:40:58 -0700 (PDT)
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
 <20200214133708.GM14879@hirez.programming.kicks-ass.net>
From:   Douglas Raillard <douglas.raillard@arm.com>
Organization: ARM
Message-ID: <e3355173-9e3d-0207-8656-005537f4c64f@arm.com>
Date:   Wed, 11 Mar 2020 12:40:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200214133708.GM14879@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2/14/20 1:37 PM, Peter Zijlstra wrote:
> On Thu, Feb 13, 2020 at 05:49:48PM +0000, Douglas Raillard wrote:
> 
>>> description of it all somewhere.
>>
>> Now a textual version of it:
>>
>> em_pd_get_higher_freq() does the following:
>>
>> # Turn the abstract cost margin on the EM_COST_MARGIN_SCALE into a
>> # concrete value. cost_margin=EM_COST_MARGIN_SCALE will give a concrete
>> # value of "max_cost", which is the highest OPP on that CPU.
>> concrete_margin = (cost_margin * max_cost) / EM_COST_MARGIN_SCALE;
>>
>> # Then it finds the lowest OPP satisfying min_freq:
>> min_opp = OPP_AT_FREQ(min_freq)
>>
>> # It takes the cost associated, and finds the highest OPP that has a
>> # cost lower than that:
>> max_cost = COST_OF(min_opp) + concrete_margin
>>
>> final_freq = MAX(
>> 	FREQ_OF(opp)
>> 	for opp in available_opps
>> 	if COST_OF(opp) <= max_cost
>> )
> 
> Right; I got that.
> 
>> So this means that:
>>    util - util_est_enqueued ~= 0
> 
> Only if you assume the task will get scheduled out reasonably frequent.
> 
>> => cost_margin              ~= 0
>> => concrete_cost_margin     ~= 0
>> => max_cost   = COST_OF(min_opp) + 0
>> => final_freq = FREQ_OF(min_opp)
>>
>> The effective boost is ~0, so you will get the current behaviour of
>> schedutil.
> 
> But the argument holds; because if things don't get scheduled out, we'll
> peg u = 1 and hit f = 1 and all is well anyway.
> 
> Which is a useful property; it shows that in the steady state, this
> patch-set is a NOP, but the above argument only relies on 'util_avg >
> util_est' being used a trigger.

Yes, `util_avg > util_est` can only happen when the task's duty cycle is
changing, which does not happen at steady state.

Either it's periodic and the boost is legitimate, or it's not periodic
and we assume it's a periodic task well represented by its last
activation and sleep (for the purpose of boosting).

Tasks with a high variability in their activation durations (i.e. not
periodic at all) will likely get more boosting on average, which is
probably good since we can't predict much about them, so in doubt we
tilt the behaviour of schedutil toward racing to completion.

>> If the task starts needing more cycles than during its previous period,
>> `util - util_est_enqueued` will grow like util since util_est_enqueued
>> is constant. The longer we wait, the higher the boost, until the task
>> goes to sleep again.
>>
>> At next wakeup, util_est_enqueued has caught up and either:
>> 1) util becomes stable, so no more boosting
>> 2) util keeps increasing, so go for another round of boosting
> 
> Agreed; however elsewhere you wrote:
> 
>> 1) If you care more about predictable battery life (or energy bill) than
>> predictability of the boost feature, EM should be used.
>>
>> 2) If you don't have an EM or you care more about having a predictable
>> boost for a given workload, use util (or disable that boost).
> 
> This is the part I'm still not sure about; how do the specifics of the
> cost_margin setup lead to 1), or how would some frobbing with frequency
> selection destroy that property.

This should be answered by this other thread:
https://lore.kernel.org/lkml/5d732dc1-d343-24d2-bda9-072021a510ed@arm.com/#t

