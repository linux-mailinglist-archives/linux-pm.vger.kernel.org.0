Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2E4F15BE0B
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 12:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgBMLzg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 06:55:36 -0500
Received: from foss.arm.com ([217.140.110.172]:45570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgBMLzg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Feb 2020 06:55:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 645711FB;
        Thu, 13 Feb 2020 03:55:35 -0800 (PST)
Received: from [10.1.195.43] (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 204DA3F6CF;
        Thu, 13 Feb 2020 03:55:34 -0800 (PST)
Subject: Re: [RFC PATCH v4 0/6] sched/cpufreq: Make schedutil energy aware
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        qperret@google.com, Linux PM <linux-pm@vger.kernel.org>
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
 <CAJZ5v0hL9AbpgivRGtCtqQo4XRYdt=SDjD=_FAVZmKAi=+VvzA@mail.gmail.com>
 <d0155018-52e6-e1c9-a03d-1b9703b7a28a@arm.com>
 <20200210133051.GI14897@hirez.programming.kicks-ass.net>
From:   Douglas Raillard <douglas.raillard@arm.com>
Organization: ARM
Message-ID: <278bff0c-6f49-5200-d7df-1c844de1c98c@arm.com>
Date:   Thu, 13 Feb 2020 11:55:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200210133051.GI14897@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/10/20 1:30 PM, Peter Zijlstra wrote:
> On Thu, Jan 23, 2020 at 05:16:52PM +0000, Douglas Raillard wrote:
>> Hi Rafael,
>>
>> On 1/23/20 3:43 PM, Rafael J. Wysocki wrote:
>>> On Wed, Jan 22, 2020 at 6:36 PM Douglas RAILLARD
>>> <douglas.raillard@arm.com> wrote:
>>>>
>>>> Make schedutil cpufreq governor energy-aware.
>>>
>>> I have to say that your terminology is confusing to me, like what
>>> exactly does "energy-aware" mean in the first place?
>>
>> Should be better rephrased as "Make schedutil cpufreq governor use the
>> energy model" I guess. Schedutil is indeed already energy aware since it
>> tries to use the lowest frequency possible for the job to be done (kind of).
> 
> So ARM64 will soon get x86-like power management if I read these here
> patches right:
> 
>   https://lkml.kernel.org/r/20191218182607.21607-2-ionela.voinescu@arm.com
> 
> And I'm thinking a part of Rafael's concerns will also apply to those
> platforms.

AFAIU there is an important difference: ARM64 firmware should not end up
increasing frequency on its own, it should only cap the frequency. That
means that the situation stays the same for that boost:

Let's say you let schedutil selecting a freq that is +2% more power
hungry. That will probably not be enough to make it jump to the next
OPP, so you end up not boosting. Now if there is a firmware that decides
for some reasons to cap frequency, it will be a similar situation.

> 
>> Other than that, the only energy-related information schedutil uses is
>> the assumption that lower freq == better efficiency. Explicit use of the
>> EM allows to refine this assumption.
> 
> I'm thinking that such platforms guarantee this on their own, if not,
> there just isn't anything we can do about it, so that assumption is
> fair.
> 
> (I've always found it weird to have less efficient OPPs listed anyway)

Ultimately, (mostly) the piece of code involved in thermal capping needs
to know about these inefficient OPPs (be it the firmware or some kernel
subsystem). The rest of the world doesn't need to care.

>>>> 1) Selecting the highest possible frequency for a given cost. Some
>>>>    platforms can have lower frequencies that are less efficient than
>>>>    higher ones, in which case they should be skipped for most purposes.
>>>>    They can still be useful to give more freedom to thermal throttling
>>>>    mechanisms, but not under normal circumstances.
>>>>    note: the EM framework will warn about such OPPs "hertz/watts ratio
>>>>    non-monotonically decreasing"
>>>
>>> While all of that is fair enough for platforms using the EM, do you
>>> realize that the EM is not available on the majority of architectures
>>> (including some fairly significant ones) and so adding overhead
>>> related to it for all of them is quite less than welcome?
>>
>> When CONFIG_ENERGY_MODEL is not defined, em_pd_get_higher_freq() is
>> defined to a static inline no-op function, so that feature won't incur
>> overhead (patch 1+2+3).
>>
>> Patch 4 and 5 do add some new logic that could be used on any platform.
>> Current code will use the boost as an energy margin, but it would be
>> straightforward to make a util-based version (like iowait boost) on
>> non-EM platforms.
> 
> Right, so the condition 'util_avg > util_est' makes sense to trigger
> some sort of boost off of.
> 
> What kind would make sense for these platforms? One possibility would be
> to instead of frobbing the energy margin, as you do here, to frob the C
> in get_next_freq().

If I'm correct, changing the C value would be somewhat similar to the
relative boosting I had in a previous version. Maybe adding a fixed
offset would give more predictable results as was discussed with Vincent
Guittot. In any case, it would change the perceived util (like iowait
boost).

> (I have vague memories of this being proposed earlier; it also avoids
> that double OPP iteration thing complained about elsewhere in this
> thread if I'm not mistaken).

It should be possible to get rid of the double iteration mentioned by
Quentin. Choosing to boost the util or the energy boils down to:

1) If you care more about predictable battery life (or energy bill) than
predictability of the boost feature, EM should be used.

2) If you don't have an EM or you care more about having a predictable
boost for a given workload, use util (or disable that boost).

The rational is that with 1), you will get a different speed boost for a
given workload depending on the other things executing at the same time,
as the speed up is not linear with the task-related metric (util -
util_est). If you are already at high freq because of another workload,
the speed up will be small because the next 100Mhz will cost much more
than the same +100Mhz delta starting from a low OPP.

> That is; I'm thinking it is important (esp. now that we got frequency
> invariance sorted for x86), to have this patch also work for !EM
> architectures (as those ARM64-AMU things would be).

For sure, that feature is supposed to help in cases that would be
impossible to pinpoint with hardware, since it has to know what tasks
execute.
