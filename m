Return-Path: <linux-pm+bounces-32009-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CDCB1C64C
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 14:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDADE3BF12A
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 12:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37DD28C010;
	Wed,  6 Aug 2025 12:48:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEF328A40F;
	Wed,  6 Aug 2025 12:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754484500; cv=none; b=AfqdBw8Sheiglsuav8/fuFsjQQm8XEYDzD8EyY8ZFqVZO3GRcqcx7czlDK+uzArD1TvI9EAcxmdSX3su9hyBouMITvSs/MZzeDiyzBHl2QeLMkUNf03Rf6M7eBL+RorEFE3S2+l+A4OHleChzHmG5dlnBmauQzDfIRj2cmPfthI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754484500; c=relaxed/simple;
	bh=O34vrE4Qf2fwLCsD+g79Gp3y4u4uoea3SrIs7UTBVX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PF4Gf6E3tKGb53aTBYS3lMlqZpxI6QubyUOJRGKDwH7ZtUWaOMa+29UvUSOZcCk2fIw/Rmh+z8tCSjdpK0Wlzp0Ps6qsUB26rzNTz5AcMukhHlpo0r16sVx57tpgZc+VLWYXxPjzWfmt+3+mSWTfrxgODQsDo8KDldTM6pb8960=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60BFD19F0;
	Wed,  6 Aug 2025 05:48:09 -0700 (PDT)
Received: from [10.1.26.32] (e127648.arm.com [10.1.26.32])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9ED2E3F5A1;
	Wed,  6 Aug 2025 05:48:15 -0700 (PDT)
Message-ID: <1db3e14c-7834-4452-91a6-329b0541056a@arm.com>
Date: Wed, 6 Aug 2025 13:48:13 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT][PATCH v1 5/5] cpuidle: menu: Avoid discarding useful
 information
To: "Rafael J. Wysocki" <rafael@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Mark Rutland <mark.rutland@arm.com>
References: <1916668.tdWV9SEqCh@rjwysocki.net>
 <7770672.EvYhyI6sBW@rjwysocki.net> <86o6sv6n94.wl-maz@kernel.org>
 <CAJZ5v0g=eSeAp96mHCOm+C9jis3uNRXgPhNgtT0SgP9kZ1emvw@mail.gmail.com>
 <86ectpahdj.wl-maz@kernel.org>
 <CAJZ5v0jnSwkOHuq5QjvVN7RLk=BV1Oi6Jbv1SvP5TCbAERq0yw@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0jnSwkOHuq5QjvVN7RLk=BV1Oi6Jbv1SvP5TCbAERq0yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/5/25 19:50, Rafael J. Wysocki wrote:
> On Tue, Aug 5, 2025 at 6:00 PM Marc Zyngier <maz@kernel.org> wrote:
>>
>> On Tue, 05 Aug 2025 14:23:56 +0100,
>> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>>>
>>> On Mon, Aug 4, 2025 at 6:54 PM Marc Zyngier <maz@kernel.org> wrote:
>>>>
>>>> [+ Thomas, Mark]
>>>>
>>>> On Thu, 06 Feb 2025 14:29:05 +0000,
>>>> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
>>>>>
>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>
>>>>> When giving up on making a high-confidence prediction,
>>>>> get_typical_interval() always returns UINT_MAX which means that the
>>>>> next idle interval prediction will be based entirely on the time till
>>>>> the next timer.  However, the information represented by the most
>>>>> recent intervals may not be completely useless in those cases.
>>>>>
>>>>> Namely, the largest recent idle interval is an upper bound on the
>>>>> recently observed idle duration, so it is reasonable to assume that
>>>>> the next idle duration is unlikely to exceed it.  Moreover, this is
>>>>> still true after eliminating the suspected outliers if the sample
>>>>> set still under consideration is at least as large as 50% of the
>>>>> maximum sample set size.
>>>>>
>>>>> Accordingly, make get_typical_interval() return the current maximum
>>>>> recent interval value in that case instead of UINT_MAX.
>>>>>
>>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>> ---
>>>>>  drivers/cpuidle/governors/menu.c |   13 ++++++++++++-
>>>>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>>>>
>>>>> --- a/drivers/cpuidle/governors/menu.c
>>>>> +++ b/drivers/cpuidle/governors/menu.c
>>>>> @@ -190,8 +190,19 @@
>>>>>        * This can deal with workloads that have long pauses interspersed
>>>>>        * with sporadic activity with a bunch of short pauses.
>>>>>        */
>>>>> -     if ((divisor * 4) <= INTERVALS * 3)
>>>>> +     if (divisor * 4 <= INTERVALS * 3) {
>>>>> +             /*
>>>>> +              * If there are sufficiently many data points still under
>>>>> +              * consideration after the outliers have been eliminated,
>>>>> +              * returning without a prediction would be a mistake because it
>>>>> +              * is likely that the next interval will not exceed the current
>>>>> +              * maximum, so return the latter in that case.
>>>>> +              */
>>>>> +             if (divisor >= INTERVALS / 2)
>>>>> +                     return max;
>>>>> +
>>>>>               return UINT_MAX;
>>>>> +     }
>>>>>
>>>>>       /* Update the thresholds for the next round. */
>>>>>       if (avg - min > max - avg)
>>>>
>>>> It appears that this patch, which made it in 6.15, results in *a lot*
>>>> of extra interrupts on one of my arm64 test machines.
>>>>
>>>> * Without this patch:
>>>>
>>>> maz@big-leg-emma:~$ vmstat -y 1
>>>> procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
>>>>  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
>>>>  1  0      0 65370828  29244 106088    0    0     0     0   66   26  0  0 100  0  0
>>>>  1  0      0 65370828  29244 106088    0    0     0     0  103   66  0  0 100  0  0
>>>>  1  0      0 65370828  29244 106088    0    0     0     0   34   12  0  0 100  0  0
>>>>  1  0      0 65370828  29244 106088    0    0     0     0   25   12  0  0 100  0  0
>>>>  1  0      0 65370828  29244 106088    0    0     0     0   28   14  0  0 100  0  0
>>>>
>>>> we're idling at only a few interrupts per second, which isn't bad for
>>>> a 24 CPU toy.
>>>>
>>>> * With this patch:
>>>>
>>>> maz@big-leg-emma:~$ vmstat -y 1
>>>> procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
>>>>  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
>>>>  1  0      0 65361024  28420 105388    0    0     0     0 3710   27  0  0 100  0  0
>>>>  1  0      0 65361024  28420 105388    0    0     0     0 3399   20  0  0 100  0  0
>>>>  1  0      0 65361024  28420 105388    0    0     0     0 4439   78  0  0 100  0  0
>>>>  1  0      0 65361024  28420 105388    0    0     0     0 5634   14  0  0 100  0  0
>>>>  1  0      0 65361024  28420 105388    0    0     0     0 5575   14  0  0 100  0  0
>>>>
>>>> we're idling at anywhere between 3k and 6k interrupts per second. Not
>>>> exactly what you want. This appears to be caused by the broadcast
>>>> timer IPI.
>>>>
>>>> Reverting this patch on top of 6.16 restores sanity on this machine.
>>>
>>> I don't know what is going on here, but it looks highly suspicious to me.
>>
>> What does? My observation? The likelihood of this patch being the
>> source (or the trigger) for an unwanted behaviour? Something else?
> 
> The behavior of the platform, which is basically confirmed by
> Christian's observation here:
> 
> https://lore.kernel.org/linux-pm/7ffcb716-9a1b-48c2-aaa4-469d0df7c792@arm.com/
> 
> And yes, cpuidle has a problem with this corner case.
> 
>>> The only effect of the change in question should be selecting a
>>> shallower idle state occasionally and why would this alone cause the
>>> number of wakeup interrupts to increase?
>>
>> You tell me. I'm the messenger here.
> 
> The tick stopping logic in menu appears to be confused.
> 
>>> Arguably, it might interfere with the tick stopping logic if
>>> predicted_ns happened to be less than TICK_NSEC sufficiently often,
>>> but that is not expected to happen on an idle system because in that
>>> case the average interval between genuine wakeups is relatively large.
>>> The tick itself is not counted as a wakeup event, so returning a
>>> shallower state at one point shouldn't affect future predictions, but
>>> the data above suggests that it actually does affect them.
>>>
>>> It looks like selecting a shallower idle state by the governor at one
>>> point causes more wakeup interrupts to occur in the future which is
>>> really note expected to happen.
>>>
>>> Christian, what do you think?
>>>
>>>> I suspect that we're entering some deep idle state in a much more
>>>> aggressive way,
>>>
>>> The change actually goes the other way around.  It causes shallower
>>> idle states to be more likely to be selected overall.
>>
>> Another proof that I don't understand a thing, and that I should go
>> play music instead of worrying about kernel issues.
>>
>>>
>>>> leading to a global timer firing as a wake-up mechanism,
>>>
>>> What timer and why would it fire?
>>
>> The arch_timer_mem timer, which is used as a backup timer when the
>> CPUs lose their timer context while going into a deep enough idle
>> state.
> 
> Interesting.  They should not go anywhere below WFI as per the message
> from Christian linked above.
> 
>>>
>>>> and the broadcast IPI being used to kick everybody else
>>>> back. This is further confirmed by seeing the broadcast IPI almost
>>>> disappearing completely if I load the system a bit.
>>>>
>>>> Daniel, you should be able to reproduce this on a Synquacer box (this
>>>> what I used here).
>>>>
>>>> I'm happy to test things that could help restore some sanity.
>>>
>>> Before anything can be tested, I need to understand what exactly is going on.
>>>
>>> What cpuidle driver is used on this platform?
>>
>> psci_idle.
> 
> Right.
> 
>>> Any chance to try the teo governor on it to see if this problem can
>>> also be observed?
>>
>> Neither ladder nor teo have this issue. The number of broadcast timer
>> IPIs is minimal, and so is the number of interrupts delivered from the
>> backup timer. Only menu exhibits the IPI-hose behaviour on this box
>> (and only this one).
> 
> Good to know, thanks!
> 
> <shameless plug>Switch over to teo?</shameless plug>
> 
>>> Please send the output of
>>>
>>> $ grep -r '.*' /sys/devices/system/cpu/cpu*/cpuidle
>>>
>>> collected after a period of idleness from the kernel in which the
>>> change in question is present and from a kernel without it?
>>
>> * with the change present: https://pastebin.com/Cb45Rysy
> 
> This is what Christian said, idle states 1 and 2 get rejected every time.
> 
>> * with the change reverted: https://pastebin.com/qRy2xzeT
> 
> And same here, but in this case menu doesn't get confused because
> predicted_ns is basically UINT_MAX all the time.
> 
> The attached patch (completely untested) causes menu to insert an
> "invalid interval" value to the array of recent intervals after the
> idle state selected previously got rejected.  It basically should
> prevent get_typical_interval() from returning small values if deeper
> idle states get rejected all the time.

Reran the same tests on the same platform, obviously a platform with
a sane rejection rate, no big change.

Tested-by: Christian Loehle <christian.loehle@arm.com>

I guess the code could do with a comment why we need the special
last_residency_ns == 0 case, apart from that LGTM.

Thanks, Rafael!

I still think it's worrying that cpuidle never worked on that platform
apparently and it went unnoticed, maybe a warning / print would be
helpful in that case, I'll post something.

