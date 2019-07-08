Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF3C61FBD
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 15:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbfGHNqL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 09:46:11 -0400
Received: from foss.arm.com ([217.140.110.172]:48350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729756AbfGHNqK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jul 2019 09:46:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D36DE2B;
        Mon,  8 Jul 2019 06:46:09 -0700 (PDT)
Received: from [10.1.195.43] (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EA783F738;
        Mon,  8 Jul 2019 06:46:08 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/5] sched/cpufreq: Make schedutil energy aware
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        quentin.perret@arm.com, dietmar.eggemann@arm.com
References: <20190627171603.14767-1-douglas.raillard@arm.com>
 <20190702155115.GW3436@hirez.programming.kicks-ass.net>
 <5198292b-1874-9ff4-6a9f-826a5ea00466@arm.com>
 <20190708110904.ecrlr4p77n4r6qzk@e110439-lin>
From:   Douglas Raillard <douglas.raillard@arm.com>
Organization: ARM
Message-ID: <b35c2281-4d91-2164-65f9-9ef3a28c35d0@arm.com>
Date:   Mon, 8 Jul 2019 14:46:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190708110904.ecrlr4p77n4r6qzk@e110439-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Patrick,

On 7/8/19 12:09 PM, Patrick Bellasi wrote:
> On 03-Jul 17:36, Douglas Raillard wrote:
>> On 7/2/19 4:51 PM, Peter Zijlstra wrote:
>>> On Thu, Jun 27, 2019 at 06:15:58PM +0100, Douglas RAILLARD wrote:
> 
> [...]
> 
>>> I'm not immediately seeing how it is transient; that is, PELT has a
>>> wobble in it's steady state, is that accounted for?
>>>
>>
>> The transient-ness of the ramp boost I'm introducing comes from the fact that for a
>> periodic task at steady state, task_ue.enqueued <= task_u when the task is executing.
>                  ^^^^^^^^^^^^^^^
> 
> I find your above "at steady state" a bit confusing.
> 
> The condition "task_ue.enqueue <= task_u" is true only for the first
> task's big activation after a series of small activations, e.g. a task
> switching from 20% to 70%.

I actually made a typo and meant "task_u <= task_ue.enqueue". The rest of the paragraph
is aligned with that condition, sorry for the confusion.


> That's the transient stat you refer to, isn't it?
> 
>> That is because task_ue.enqueued is sampled at dequeue time, precisely at the moment
>> at which task_u is reaching its max for that task.
> 
> Right, so in the example above we will have enqueued=20% while task_u
> is going above to converge towards 70%
> 
>> Since we only take into account positive boosts, ramp boost will
>> only have an impact in the "increase transients".
> 
> Right.
> 
> I think Peter was referring to the smallish wobbles we see when the
> task already converged to 70%. If that's the case I would say they are
> already fully covered also by the current util_est.

Yes, that's covered by the "task_u <= task_ue.enqueue" condition, with task_ue.enqueued
not having any of these "mid freq" content that we call wobble here.

Util est enqueued acts as an adaptive filter that kills frequencies higher than 1/task_period,
task_period being the delta between the two previous "enqueue events". All what's (mostly) remaining
after that is util variation of larger periods, with a positive shift that increases with
the task period (mean(enqueued) = mean(util_avg) + f(task_period)).


> You are also correct in pointing out that in the steady state
> ramp_boost will not be triggered in that steady state.
> 
> IMU, that's for two main reasons:
>   a) it's very likely that enqueued <= util_avg
>   b) even in case enqueued should turn out to be _slightly_ bigger then
>      util_avg, the corresponding (proportional) ramp_boost would be so
>      tiny to not have any noticeable effect on OPP selection.
> 
> Am I correct on point b) above?

Assuming you meant "util_avg slightly bigger than enqueued" (which is when boosting triggers),
then yes since ramp_boost effect is proportional to "task_ue.enqueue - task_u". It makes it robust
against that.

> 
> Could you maybe come up with some experimental numbers related to that
> case specifically?

With:
* an rt-app task ramping up from 5% to 75% util in one big step. The whole cycle is 0.6s long
  (0.3s at 5% followed by 0.3s at 75%). This cycle is repeated 20 times and the average of
  boosting is taken.

* a hikey 960 (this impact the frequency at which the test runs at the beginning of 75% phase,
   which impacts the number of missed activations before the util ramped up).

* assuming an OPP exists for each util value (i.e. 1024 OPPs, so the effect
   of boost on consumption is not impacted by OPP capacities granularity)

Then the boosting feature would increase the average power consumption by 3.1%, out of which 0.12% can
be considered "spurious boosting" due to the util taking some time to really converge to its
steady state value. In practice, the impact of small boosts will be even lower since they will less likely
trigger the selection of a high OPP due to OPP capacity granularity > 1 util unit.

> 
> Best,
> Patrick
> 

Best regards,
Douglas
