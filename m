Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB592238C7
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jul 2020 11:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgGQJzp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jul 2020 05:55:45 -0400
Received: from foss.arm.com ([217.140.110.172]:46290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgGQJzl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 Jul 2020 05:55:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26980D6E;
        Fri, 17 Jul 2020 02:55:41 -0700 (PDT)
Received: from [10.37.12.35] (unknown [10.37.12.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 429B43F66E;
        Fri, 17 Jul 2020 02:55:38 -0700 (PDT)
Subject: Re: [PATCH 2/2] thermal: cpufreq_cooling: Reuse effective_cpu_util()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
References: <cover.1594707424.git.viresh.kumar@linaro.org>
 <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
 <20200716115605.GR10769@hirez.programming.kicks-ass.net>
 <681fb3e8-d645-2558-38de-b39b372499de@arm.com>
 <20200716154335.GT10769@hirez.programming.kicks-ass.net>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <bcad0cfe-c96c-a933-6784-325f67d34c62@arm.com>
Date:   Fri, 17 Jul 2020 10:55:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200716154335.GT10769@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/16/20 4:43 PM, Peter Zijlstra wrote:
> On Thu, Jul 16, 2020 at 03:24:37PM +0100, Lukasz Luba wrote:
>> On 7/16/20 12:56 PM, Peter Zijlstra wrote:
> 
>>> The second attempts to guesstimate power, and is the subject of this
>>> patch.
>>>
>>> Currently cpufreq_cooling appears to estimate the CPU energy usage by
>>> calculating the percentage of idle time using the per-cpu cpustat stuff,
>>> which is pretty horrific.
>>
>> Even worse, it then *samples* the *current* CPU frequency at that
>> particular point in time and assumes that when the CPU wasn't idle
>> during that period - it had *this* frequency...
> 
> *whee* :-)
> 
> ...
> 
>> In EM we keep power values in the array and these values grow
>> exponentially. Each OPP has it corresponding
>>
>> P_x = C (V_x)^2 f_x    , where x is the OPP id thus corresponding V,f
>>
>> so we have discrete power values, growing like:
>>
>> ^(power)
>> |
>> |
>> |                          *
>> |
>> |
>> |                       *
>> |                       |
>> |                   *   |
>> |                       | <----- power estimation function
>> |            *          |        should not use linear 'util/max_util'
>> |   *                   |        relation here *
>> |_______________________|_____________> (freq)
>>     opp0     opp1  opp2 opp3 opp4
>>
>> What is the problem
>> First:
>> We need to pick the right Power from the array. I would suggest
>> to pick the max allowed frequency for that whole period, because
>> we don't know if the CPUs were using it (it's likely).
>> Second:
>> Then we have the utilization, which can be considered as:
>> 'idle period & running period with various freq inside', lets
>> call it avg performance in that whole period.
>> Third:
>> Try to estimate the power used in that whole period having
>> the avg performance and max performance.
>>
>> What you are suggesting is to travel that [*] line in
>> non-linear fashion, but in (util^3)/(max_util^3). Which means
>> it goes down faster when the utilization drops.
>> I think it is too aggressive, e.g.
>> 500^3 / 1024^3 = 0.116  <--- very little, ~12%
>> 200^3 / 300^3  = 0.296
>>
>> Peter could you confirm if I understood you correct?
> 
> Correct, with the caveat that we might try and regression fit a 3rd
> order polynomial to a bunch of EM data to see if there's a 'better'
> function to be had than a raw 'f(x) := x^3'.

I agree, I think we are on the same wavelength now.

> 
>> This is quite important bit for me.
> 
> So, if we assume schedutil + EM, we can actually have schedutil
> calculate a running power sum. That is, something like: \Int P_x dt.
> Because we know the points where OPP changes.

Yes, that's why I was thinking about having this information stored as a
copy inside the EM, then just read it in other subsystem like: thermal,
powercap, etc.

> 
> Although, thinking more, I suspect we need tighter integration with
> cpuidle, because we don't actually have idle times here, but that should
> be doable.

I am scratching my head for while because of that idle issue. It opens
more dimensions to tackle.

> 
> But for anything other than schedutil + EM, things become more
> interesting, because then we need to guesstimate power usage without the
> benefit of having actual power numbers.

Yes, from the engineering/research perspective, platforms which do not
have EM in Linux (like Intel) are also interesting.

> 
> We can of course still do that running power sum, with whatever P(u) or
> P(f) end up with, I suppose.
> 
>>> Another point is that cpu_util() vs turbo is a bit iffy, and to that,
>>> things like x86-APERF/MPERF and ARM-AMU got mentioned. Those might also
>>> have the benefit of giving you values that match your own sampling
>>> interval (100ms), where the sched stuff is PELT (64,32.. based).
>>>
>>> So what I've been thinking is that cpufreq drivers ought to be able to
>>> supply this method, and only when they lack, can the cpufreq-governor
>>> (schedutil) install a fallback. And then cpufreq-cooling can use
>>> whatever is provided (through the cpufreq interfaces).
>>>
>>> That way, we:
>>>
>>>    1) don't have to export anything
>>>    2) get arch drivers to provide something 'better'
>>>
>>>
>>> Does that sounds like something sensible?
>>>
>>
>> Yes, make sense. Please also keep in mind that this
>> utilization somehow must be mapped into power in a proper way.
>> I am currently working on addressing all of these problems
>> (including this correlation).
> 
> Right, so that mapping util to power was what I was missing and
> suggesting we do. So for 'simple' hardware we have cpufreq events for
> frequency change, and cpuidle events for idle, and with EM we can simply
> sum the relevant power numbers.
> 
> For hardware lacking EM, or hardware managed DVFS, we'll have to fudge
> things a little. How best to do that is up in the air a little, but
> virtual power curves seem a useful tool to me.
> 
> The next problem for IPA is having all the devices report power in the
> same virtual unit I suppose, but I'll leave that to others ;-)
> 

True, there is more issues. There is also another movement with powercap
driven by Daniel Lezcano, which I am going to support. Maybe he would
be interested as well in having a copy of calculated energy stored
in EM. I must gather some requirements and align with him.

Thank you for your support!

Regards,
Lukasz
