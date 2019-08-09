Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3F2688164
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 19:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfHIRhu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 13:37:50 -0400
Received: from foss.arm.com ([217.140.110.172]:51248 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbfHIRht (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Aug 2019 13:37:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A400415A2;
        Fri,  9 Aug 2019 10:37:48 -0700 (PDT)
Received: from [10.1.195.43] (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 564E13F694;
        Fri,  9 Aug 2019 10:37:47 -0700 (PDT)
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
 <b35c2281-4d91-2164-65f9-9ef3a28c35d0@arm.com>
 <20190709103750.hnm4bav6tjy7g37u@e110439-lin>
From:   Douglas Raillard <douglas.raillard@arm.com>
Organization: ARM
Message-ID: <8fbbbfb1-2172-1ecc-4600-2f86ccbbabb4@arm.com>
Date:   Fri, 9 Aug 2019 18:37:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190709103750.hnm4bav6tjy7g37u@e110439-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Patrick,

On 7/9/19 11:37 AM, Patrick Bellasi wrote:
> On 08-Jul 14:46, Douglas Raillard wrote:
>> Hi Patrick,
>>
>> On 7/8/19 12:09 PM, Patrick Bellasi wrote:
>>> On 03-Jul 17:36, Douglas Raillard wrote:
>>>> On 7/2/19 4:51 PM, Peter Zijlstra wrote:
>>>>> On Thu, Jun 27, 2019 at 06:15:58PM +0100, Douglas RAILLARD wrote:
> 
> [...]
> 
>>> You are also correct in pointing out that in the steady state
>>> ramp_boost will not be triggered in that steady state.
>>>
>>> IMU, that's for two main reasons:
>>>    a) it's very likely that enqueued <= util_avg
>>>    b) even in case enqueued should turn out to be _slightly_ bigger then
>>>       util_avg, the corresponding (proportional) ramp_boost would be so
>>>       tiny to not have any noticeable effect on OPP selection.
>>>
>>> Am I correct on point b) above?
>>
>> Assuming you meant "util_avg slightly bigger than enqueued" (which is when boosting triggers),
>> then yes since ramp_boost effect is proportional to "task_ue.enqueue - task_u". It makes it robust
>> against that.
> 
> Right :)
> 
>>> Could you maybe come up with some experimental numbers related to that
>>> case specifically?
>>
>> With:
>> * an rt-app task ramping up from 5% to 75% util in one big step. The
>> whole cycle is 0.6s long (0.3s at 5% followed by 0.3s at 75%). This
>> cycle is repeated 20 times and the average of boosting is taken.
>>
>> * a hikey 960 (this impact the frequency at which the test runs at
>> the beginning of 75% phase, which impacts the number of missed
>> activations before the util ramped up).
>>
>> * assuming an OPP exists for each util value (i.e. 1024 OPPs, so the
>> effect of boost on consumption is not impacted by OPP capacities
>> granularity)
>>
>> Then the boosting feature would increase the average power
>> consumption by 3.1%, out of which 0.12% can be considered "spurious
>> boosting" due to the util taking some time to really converge to its
>> steady state value.
>>
>> In practice, the impact of small boosts will be even lower since
>> they will less likely trigger the selection of a high OPP due to OPP
>> capacity granularity > 1 util unit.
> 
> That's ok for the energy side: you estimate a ~3% worst case more
> energy on that specific target.
> 
> By boosting I expect the negative boost to improve.
> Do you have also numbers/stats related to the negative slack?
> Can you share a percentage figure for that improvement?

I'm now testing on a Google Pixel 3 (Qcom Snapdragon 845) phone, with the same workload, pinned on a big core.
It has a lot more OPPs than a hikey 960, so gradations in boosting are better reflected on frequency selection.

avg slack (higher=better):
     Average time between task sleep and its next periodic activation.

avg negative slack (lower in absolute value=better):
     Same as avg slack, but only taking into account negative values.
     Negative slack means a task activation did not have enough time to complete before the next
     periodic activation fired, which is what we want to avoid.

boost energy overhead (lower=better):
     Extra power consumption induced by ramp boost, assuming continuous OPP space (infinite number of OPP)
     and single-CPU policies. In practice, fixed number of OPP decrease this value, and more CPU per policy increases it,
     since boost(policy) = max(boost(cpu of policy)).

Without ramp boost:
+--------------------+--------------------+
|avg slack (us)      |avg negative slack  |
|                    |(us)                |
+--------------------+--------------------+
|6598.72             |-10217.13           |
|6595.49             |-10200.13           |
|6613.72             |-10401.06           |
|6600.29             |-9860.872           |
|6605.53             |-10057.64           |
|6612.05             |-10267.50           |
|6599.01             |-9939.60            |
|6593.79             |-9445.633           |
|6613.56             |-10276.75           |
|6595.44             |-9751.770           |
+--------------------+--------------------+
|average                                  |
+--------------------+--------------------+
|6602.76             |-10041.81           |
+--------------------+--------------------+


With ramp boost enabled:
+--------------------+--------------------+--------------------+
|boost energy        |avg slack (us)      |avg negative slack  |
|overhead (%)        |                    |(us)                |
+--------------------+--------------------+--------------------+
|3.05                |7148.93             |-5664.26            |
|3.04                |7144.69             |-5667.77            |
|3.05                |7149.05             |-5698.31            |
|2.97                |7126.71             |-6040.23            |
|3.02                |7140.28             |-5826.78            |
|3.03                |7135.11             |-5749.62            |
|3.05                |7140.24             |-5750.0             |
|3.05                |7144.84             |-5667.04            |
|3.07                |7157.30             |-5656.65            |
|3.06                |7154.65             |-5653.76            |
+--------------------+--------------------+--------------------+
|average                                                       |
+--------------------+--------------------+--------------------+
|3.039000            |7144.18             |5737.44             |
+--------------------+--------------------+--------------------+


The negative slack is due to missed activations while the utilization signals
increase during the big utilization step. Ramp boost is designed to boost frequency during
that phase, which materializes in 1.75 less negative slack, for an extra power
consumption under 3%.

> Best,
> Patrick
> 

Thanks,
Douglas
