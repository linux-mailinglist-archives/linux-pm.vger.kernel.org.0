Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16D14172283
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 16:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgB0PvA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 10:51:00 -0500
Received: from foss.arm.com ([217.140.110.172]:53876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729217AbgB0PvA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Feb 2020 10:51:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A15CD30E;
        Thu, 27 Feb 2020 07:50:59 -0800 (PST)
Received: from [10.1.195.43] (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65A383F7B4;
        Thu, 27 Feb 2020 07:50:58 -0800 (PST)
From:   Douglas Raillard <douglas.raillard@arm.com>
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
 <278bff0c-6f49-5200-d7df-1c844de1c98c@arm.com>
 <20200213132024.GP14897@hirez.programming.kicks-ass.net>
Organization: ARM
Message-ID: <a07d317b-7f68-f63f-bc9f-d829a3aa65b5@arm.com>
Date:   Thu, 27 Feb 2020 15:50:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200213132024.GP14897@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Peter,

On 2/13/20 1:20 PM, Peter Zijlstra wrote:
> On Thu, Feb 13, 2020 at 11:55:32AM +0000, Douglas Raillard wrote:
>> On 2/10/20 1:30 PM, Peter Zijlstra wrote:
> 
>>> So ARM64 will soon get x86-like power management if I read these here
>>> patches right:
>>>
>>>   https://lkml.kernel.org/r/20191218182607.21607-2-ionela.voinescu@arm.com
>>>
>>> And I'm thinking a part of Rafael's concerns will also apply to those
>>> platforms.
>>
>> AFAIU there is an important difference: ARM64 firmware should not end up
>> increasing frequency on its own, it should only cap the frequency. That
>> means that the situation stays the same for that boost:
>>
>> Let's say you let schedutil selecting a freq that is +2% more power
>> hungry. That will probably not be enough to make it jump to the next
>> OPP, so you end up not boosting. Now if there is a firmware that decides
>> for some reasons to cap frequency, it will be a similar situation.
> 
> The moment you give out OPP selection to a 3rd party (be it firmware or
> a micro-controller) things are uncertain at best anyway.
> 
> Still, in general, if you give it higher input, it tends to at least
> consider going faster -- which might be all you can ask for...
> 
> So I'm not exactly seeing what your argument is here.

My point is that a +2% boost will give *up to* +2% increase in energy
use. With or without a fancy firmware, having cost_margin > 0 does not
mean you will always actually get a speedup.

>>> Right, so the condition 'util_avg > util_est' makes sense to trigger
>>> some sort of boost off of.
>>>
>>> What kind would make sense for these platforms? One possibility would be
>>> to instead of frobbing the energy margin, as you do here, to frob the C
>>> in get_next_freq().
>>
>> If I'm correct, changing the C value would be somewhat similar to the
>> relative boosting I had in a previous version. Maybe adding a fixed
>> offset would give more predictable results as was discussed with Vincent
>> Guittot. In any case, it would change the perceived util (like iowait
>> boost).
> 
> It depends a bit on what you change C into. If we do something trivial
> like:
> 		1.25 ; !(util_avg > util_est)
> 	C := {
> 		2    ;  (util_avg > util_est)
> 
> ie. a binary selection of constants, then yes, I suppose that is the
> case.
> 
> But nothing stops us from making it more complicated; or having it
> depend on the presence of EM data.

The series currently fiddles with energy cost directly, but it's
possible to have the exact same effect by fiddling with util if we have
the function `(base_util, cost_margin) -> boosted_util`. It just that it
forces to:
1. map util to freq
2. find a higher freq for the given cost_margin
3. Map freq to util
4. Re-inject the new util, which will eventually get remapped to a freq

While it's easier to just do it directly:
1. map util to freq
2. find higher_freq for the given cost_margin
3. Use the increased freq

> 
>>> (I have vague memories of this being proposed earlier; it also avoids
>>> that double OPP iteration thing complained about elsewhere in this
>>> thread if I'm not mistaken).
>>
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
> 
> It's just that I'm not seeing how 1 actually works or provides that more
> predictable battery life I suppose. We have this other sub-thread to
> argue about that :-)

Ok, I've posted the answer there, so this thread can focus on
boost=(util - util_est_enqueued) logic, and the other one on how to make
actual use of the boost value.

>>> That is; I'm thinking it is important (esp. now that we got frequency
>>> invariance sorted for x86), to have this patch also work for !EM
>>> architectures (as those ARM64-AMU things would be).
>>
>> For sure, that feature is supposed to help in cases that would be
>> impossible to pinpoint with hardware, since it has to know what tasks
>> execute.
> 
> OK, so I'm thinking we're agreeing that it would be good to have this
> support !EM systems too.
> 

Thanks,
Douglas
