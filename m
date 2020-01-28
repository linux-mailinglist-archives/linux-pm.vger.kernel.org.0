Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A98214BCF0
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2020 16:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgA1PiK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jan 2020 10:38:10 -0500
Received: from foss.arm.com ([217.140.110.172]:59562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgA1PiK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Jan 2020 10:38:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4304C31B;
        Tue, 28 Jan 2020 07:38:09 -0800 (PST)
Received: from [10.1.195.43] (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B7193F68E;
        Tue, 28 Jan 2020 07:38:07 -0800 (PST)
Subject: Re: [RFC PATCH v4 4/6] sched/cpufreq: Introduce sugov_cpu_ramp_boost
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
 <20200122173538.1142069-5-douglas.raillard@arm.com>
 <CAJZ5v0gP5v3LzU-uGyHpoJV8z+E2heR1PEQp+c=L7RZS3FzCWg@mail.gmail.com>
 <9b5afae9-0cf5-6c3a-b94b-0796da4e6a71@arm.com>
 <CAJZ5v0h8=Kh-xutPMf110UOrRfEQtjjOTneZaWoZLaYO=Bfm1A@mail.gmail.com>
From:   Douglas Raillard <douglas.raillard@arm.com>
Organization: ARM
Message-ID: <a509ed51-6bd9-5e66-6259-94f4fe46077a@arm.com>
Date:   Tue, 28 Jan 2020 15:38:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0h8=Kh-xutPMf110UOrRfEQtjjOTneZaWoZLaYO=Bfm1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 1/23/20 9:02 PM, Rafael J. Wysocki wrote:
> On Thu, Jan 23, 2020 at 6:21 PM Douglas Raillard
> <douglas.raillard@arm.com> wrote:
>>
>>
>>
>> On 1/23/20 3:55 PM, Rafael J. Wysocki wrote:
>>> On Wed, Jan 22, 2020 at 6:36 PM Douglas RAILLARD
>>> <douglas.raillard@arm.com> wrote:
>>>>
>>>> Use the utilization signals dynamic to detect when the utilization of a
>>>> set of tasks starts increasing because of a change in tasks' behavior.
>>>> This allows detecting when spending extra power for faster frequency
>>>> ramp up response would be beneficial to the reactivity of the system.
>>>>
>>>> This ramp boost is computed as the difference between util_avg and
>>>> util_est_enqueued. This number somehow represents a lower bound of how
>>>> much extra utilization this tasks is actually using, compared to our
>>>> best current stable knowledge of it (which is util_est_enqueued).
>>>>
>>>> When the set of runnable tasks changes, the boost is disabled as the
>>>> impact of blocked utilization on util_avg will make the delta with
>>>> util_est_enqueued not very informative.
>>>>
>>>> Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
>>>> ---
>>>>  kernel/sched/cpufreq_schedutil.c | 43 ++++++++++++++++++++++++++++++++
>>>>  1 file changed, 43 insertions(+)
>>>>
>>>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>>>> index 608963da4916..25a410a1ff6a 100644
>>>> --- a/kernel/sched/cpufreq_schedutil.c
>>>> +++ b/kernel/sched/cpufreq_schedutil.c
>>>> @@ -61,6 +61,10 @@ struct sugov_cpu {
>>>>         unsigned long           bw_dl;
>>>>         unsigned long           max;
>>>>
>>>> +       unsigned long           ramp_boost;
>>>> +       unsigned long           util_est_enqueued;
>>>> +       unsigned long           util_avg;
>>>> +
>>>>         /* The field below is for single-CPU policies only: */
>>>>  #ifdef CONFIG_NO_HZ_COMMON
>>>>         unsigned long           saved_idle_calls;
>>>> @@ -183,6 +187,42 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
>>>>         }
>>>>  }
>>>>
>>>> +static unsigned long sugov_cpu_ramp_boost(struct sugov_cpu *sg_cpu)
>>>> +{
>>>> +       return READ_ONCE(sg_cpu->ramp_boost);
>>>> +}
>>>
>>> Where exactly is this function used?
>>
>> In the next commit where the boost value is actually used to do
>> something. The function is introduced here to keep the
>> WRITE_ONCE/READ_ONCE pair together.
> 
> But ramp_boost itself is not really used in this patch too AFAICS.

I'll squash that patch with the next one where it's actually used then:
sched/cpufreq: Boost schedutil frequency ramp up

Thanks,
Douglas
