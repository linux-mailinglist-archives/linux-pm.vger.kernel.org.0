Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11BF617228B
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 16:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgB0Pvi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 10:51:38 -0500
Received: from foss.arm.com ([217.140.110.172]:53888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729110AbgB0Pvh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Feb 2020 10:51:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55EE51FB;
        Thu, 27 Feb 2020 07:51:37 -0800 (PST)
Received: from [10.1.195.43] (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EA843F7B4;
        Thu, 27 Feb 2020 07:51:35 -0800 (PST)
From:   Douglas Raillard <douglas.raillard@arm.com>
Subject: Re: [RFC PATCH v4 3/6] sched/cpufreq: Hook em_pd_get_higher_power()
 into get_next_freq()
To:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, qperret@google.com,
        linux-pm@vger.kernel.org
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
 <20200122173538.1142069-4-douglas.raillard@arm.com>
Organization: ARM
Message-ID: <5d732dc1-d343-24d2-bda9-072021a510ed@arm.com>
Date:   Thu, 27 Feb 2020 15:51:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200122173538.1142069-4-douglas.raillard@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Let's this thread be about util boosting vs energy boosting.

Short recap of the conversation:

Peter:
>>> (I have vague memories of this (the util boosting) being proposed
earlier; it also avoids
>>> that double OPP iteration thing complained about elsewhere in this
>>> thread if I'm not mistaken).
>>

Douglas:
>> It should be possible to get rid of the double iteration mentioned by
>> Quentin. Choosing to boost the util or the energy boils down to:
>>
>> 1) If you care more about predictable battery life (or energy bill) than
>> predictability of the boost feature, EM should be used.
>>
>> 2) If you don't have an EM or you care more about having a predictable
>> boost for a given workload, use util (or disable that boost).
>>
>> The rational is that with 1), you will get a different speed boost for a
>> given workload depending on the other things executing at the same time,
>> as the speed up is not linear with the task-related metric (util -
>> util_est). If you are already at high freq because of another workload,
>> the speed up will be small because the next 100Mhz will cost much more
>> than the same +100Mhz delta starting from a low OPP.

Peter:
>
> It's just that I'm not seeing how 1 actually works or provides that more
> predictable battery life I suppose. We have this other sub-thread to
> argue about that :-)

Here is a more detailed version of util boost vs energy boost.
The goal of what follows is to show that util-based boost gives predictable
performance speedup, while energy-based boost gives predictable increase in
energy consumption.

In both cases, the boost value is computed as (util - ue.enqueued),
and only its interpretation differs:
* as an increase in util for util-based boost
* as an OPP cost margin for the energy-based boost



util(wload) = util_avg(wload)
util_est_enqueued(wload)
	| wload is enqueued = f(util_avg(wload))
	| otherwise         = 0

(wloadA + wloadB) denotes a "virtual" task that is running whenever either
wloadA or wloadB is running.

# Assuming wloadA and wloadB are attached to the same rq:
util(wloadA + wloadB) = util(wloadA) + util(wloadB)

# Assuming wloadA and wloadB do not preempt each other:
util_est_enqueued(wloadA + wloadB) =
	util_est_enqueued(wloadA) + util_est_enqueued(wloadB)

# boostU(wload) is the increase of util due to the util-based boost.
# boostE(wload) is the increase of *util* due to the energy-based boost.

boostU(wload) 
	| wload enqueued and util(wload) > util_est_enqueued(wload) =
		util(wload) - util_est_enqueued(wload)
	| otherwise = 0

boostU(wloadA + wloadB) = util(wloadA + wloadB) -
    util_est_enqueued(wloadA + wloadB)
boostU(wloadA + wloadB) = util(wloadA) + util(wloadB) -
    util_est_enqueued(wloadA) - util_est_enqueued(wloadB)
boostU(wloadA + wloadB) = boostU(wloadA) + boostU(wloadB)

# Now if we now intepret the same boost value as a freq energy cost margin:
boostE(wload) 
	| wload enqueued and util(wload) > util_est_enqueued(wload) =
		apply_boostE(util(wload), util_est_enqueued(wload), map_util_freq(util(wload)))
	| otherwise = 0

# with:
apply_boostE(util, util_est_enqueued, base_freq) = 
	boost = util - util_est_enqueued
	boosted_freq = freq_at(boost + cost_of(base_freq))
	freq_delta = boosted_freq - base_freq
	speedup = 1 + freq_delta / max_freq
	return util * speedup

Since freq_at(cost) function is not a linear function of cost
and util(wloadA + wloadB) = util(wloadA) + util(wloadB),
apply_boostE() is not a linear function of wload, which means:
boostE(wloadA + wloadB) != boostE(wloadA) + boostE(wloadB)

This means the speedup (util increase) given by boostE cannot be evaluated for
one task without considering all other attached tasks on the same rq. Therefore
the speedup introduced by boostE is not easily predictable.

On the other hand, the increase in energy cost is linear in the workload for
energy-based boost. but not linear for the util-based boost.

That made me realize that to achieve that, EM_COST_MARGIN_SCALE needs to
map to the highest cost in the system, not the highest cost of the
current CPU, I will fix that.

Also, util_est_enqueued is not linear in the general case when wloadA and
wloadB preempt each-other. There could be ways of making that work but it's
probably a better idea to move the logic at the task level and aggregate the
flag at runqueue level. This will also allow the boost to work when the set of
enqueued tasks varies, which is likely to happen in a real system.

