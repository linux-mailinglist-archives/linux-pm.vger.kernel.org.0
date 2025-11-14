Return-Path: <linux-pm+bounces-38045-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 142CFC5E254
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 17:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 238974F68E7
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 15:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3AF32ED38;
	Fri, 14 Nov 2025 15:33:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A229C246778
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134388; cv=none; b=SjZQXvGSJM1SKavnzTHXCdMwzZygLNzJ6O/7iRb0lwZ2uJGAOr1bofwBCFxwn21haApPvh4KtmmNrxBjNeU52gCFZGIDmmDv74tq5KSz3RsY3N6bDhyMa8Cxljgp9c/RVjRdpjbmpWotUfxUeyEoD7PKoBDSWbAwBSpMxhdhDzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134388; c=relaxed/simple;
	bh=nZWhnDtygQy9Chwpz29k61W2NDFhIlNk1MDCM14TUx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FURp5MYTCdvQqJ1uZ2Njmxt9ivkef55YIb6WCPnNYeVHB5O2wYg8/tp8Bh9+JdK2tLioEh5MrBnrIzz7Z9KD5X5ZBHAOEPj6ob/jU7rLDxuh/kKIh9inp8MUg84HrVjDBYb1TghcHi50oah6Cey2hpzowuLWZEfPgHMOm1vCO44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 545191063;
	Fri, 14 Nov 2025 07:32:56 -0800 (PST)
Received: from [10.1.35.10] (e127648.arm.com [10.1.35.10])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A20163F66E;
	Fri, 14 Nov 2025 07:33:02 -0800 (PST)
Message-ID: <22ce24b0-4747-455f-9bd7-fb7ee5cd604b@arm.com>
Date: Fri, 14 Nov 2025 15:33:00 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpuidle: governors: teo: Rework the handling of tick
 wakeups
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Reka Norman <rekanorman@chromium.org>, daniel.lezcano@linaro.org,
 linux-pm@vger.kernel.org
References: <CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com>
 <00928b9d-7189-4929-afc9-7684fc5ef531@arm.com>
 <ca45366d-4c85-4802-8a35-886a6f69d10d@arm.com>
 <6228387.lOV4Wx5bFT@rafael.j.wysocki>
 <fcf1584a-7e15-4aec-b302-b94cfa168e11@arm.com>
 <CAJZ5v0g2PL3rj=sZoCHAqQg0dSnxMk_u-GHn1vybFuPUjh0iKA@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0g2PL3rj=sZoCHAqQg0dSnxMk_u-GHn1vybFuPUjh0iKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/14/25 15:12, Rafael J. Wysocki wrote:
> On Fri, Nov 14, 2025 at 3:47 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 11/13/25 16:56, Rafael J. Wysocki wrote:
>>> On Thursday, November 13, 2025 4:43:18 PM CET Christian Loehle wrote:
>>>> On 11/12/25 18:33, Christian Loehle wrote:
>>>>> On 11/12/25 14:16, Rafael J. Wysocki wrote:
>>>>>> On Wed, Nov 12, 2025 at 3:03 PM Christian Loehle
>>>>>> <christian.loehle@arm.com> wrote:
>>>>>>>
>>>>>>> On 11/12/25 13:32, Rafael J. Wysocki wrote:
>>>>>>>> On Tue, Nov 11, 2025 at 6:20 PM Christian Loehle
>>>>>>>> <christian.loehle@arm.com> wrote:
>>>>>>>>>
>>>>>>>>> On 11/11/25 11:48, Rafael J. Wysocki wrote:
>>>>>>>>>> On Tue, Nov 11, 2025 at 11:48 AM Christian Loehle
>>>>>>>>>> <christian.loehle@arm.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On 11/11/25 10:00, Christian Loehle wrote:
>>>>>>>>
>>>>>>>> [...]
>>>>>>>>
>>>>>>>>>>>> I see two issues:
>>>>>>>>>>>> 1) Because of DECAY_SHIFT 3 values < 8 cannot decay (I guess this wouldn't really be an issue without 2))
>>>>>>>>>>
>>>>>>>>>> This shouldn't be a problem.
>>>>>>>>>
>>>>>>>>> Agreed, it should be a non-issue. Nonetheless if this wasn't the case $subject would've likely
>>>>>>>>> never been an issue.
>>>>>>>>
>>>>>>>> Well, I think that the leftovers can be cleared when they become less than 8.
>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>> 2) if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) isn't an appropriate check, it will
>>>>>>>>>>>> exclude the state if it its idx_hit_sum make up the vast majority of cpu_data->total (i.e. it would
>>>>>>>>>>>> have been a really good candidate actually).
>>>>>>>>>>
>>>>>>>>>> Well, it would exclude the state if the sum of hits for the states
>>>>>>>>>> below it is large enough.  This is questionable (because why would
>>>>>>>>>> hits matter here), but I attempted to make the change below and
>>>>>>>>>> somebody reported a regression IIRC.
>>>>>>>>>>
>>>>>>>>>> This check is related to the problem at hand though (see below).
>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> I lightly tested the below, it seems to be at least comparable to mainline teo.
>>>>>>>>>>>> (the documentation/comments would need adapting too, of course)
>>>>>>>>>>>>
>>>>>>>>>>>> -----8<-----
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
>>>>>>>>>>>> index bfa55c1eab5b..f8f76e3b8364 100644
>>>>>>>>>>>> --- a/drivers/cpuidle/governors/teo.c
>>>>>>>>>>>> +++ b/drivers/cpuidle/governors/teo.c
>>>>>>>>>>>> @@ -355,7 +355,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>>>>>>>>>>>          * all of the deeper states, a shallower idle state is likely to be a
>>>>>>>>>>>>          * better choice.
>>>>>>>>>>>>          */
>>>>>>>>>>>> -       if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
>>>>>>>>>>>> +       if (2 * idx_intercept_sum > idx_hit_sum) {
>>>>>>>>>>>>                 int first_suitable_idx = idx;
>>>>>>>>>>>>
>>>>>>>>>>>>                 /*
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> ... nevermind the patch, idx_hit_sum is of course the sum of 0...idx-1.
>>>>>>>>>>> Maybe something like this, again lightly tested:
>>>>>>>>>>>
>>>>>>>>>>> -----8<-----
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
>>>>>>>>>>> index 173ddcac540a..6bfb9cedb75e 100644
>>>>>>>>>>> --- a/drivers/cpuidle/governors/teo.c
>>>>>>>>>>> +++ b/drivers/cpuidle/governors/teo.c
>>>>>>>>>>> @@ -383,13 +395,15 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>>>>>>>>>>                  * has been stopped already into account.
>>>>>>>>>>>                  */
>>>>>>>>>>>                 intercept_sum = 0;
>>>>>>>>>>> +               hit_sum = 0;
>>>>>>>>>>>
>>>>>>>>>>>                 for (i = idx - 1; i >= 0; i--) {
>>>>>>>>>>>                         struct teo_bin *bin = &cpu_data->state_bins[i];
>>>>>>>>>>>
>>>>>>>>>>>                         intercept_sum += bin->intercepts;
>>>>>>>>>>> +                       hit_sum += bin->hits;
>>>>>>>>>>>
>>>>>>>>>>> -                       if (2 * intercept_sum > idx_intercept_sum) {
>>>>>>>>>>> +                       if (2 * intercept_sum > cpu_data->total || 2 * hit_sum > cpu_data->total) {
>>>>>>>>>>>                                 /*
>>>>>>>>>>>                                  * Use the current state unless it is too
>>>>>>>>>>>                                  * shallow or disabled, in which case take the
>>>>>>>>>>
>>>>>>>>>> This will only matter after the deepest state has been rejected
>>>>>>>>>> already and on the system in question this means selecting state 0 no
>>>>>>>>>> matter what.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Ah, right!
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> The pre-6.12 behavior can be explained if tick wakeups are taken into account.
>>>>>>>>>>
>>>>>>>>>> Namely, when state 0 is chosen (because of the check mentioned above),
>>>>>>>>>> the tick is not stopped and the sleep length is KTIME_MAX.  If the
>>>>>>>>>> subsequent wakeup is a tick one, it will be counted as a hit on the
>>>>>>>>>> deepest state (and it will contribute to the total sum in the check
>>>>>>>>>> mentioned above).  Then, at one point, cpu_data->total will be large
>>>>>>>>>> enough and the deepest state will become the candidate one.  If
>>>>>>>>>> tick_nohz_get_sleep_length() returns a large value at that point, the
>>>>>>>>>> tick will be stopped and the deepest state will be entered.  Nirvana
>>>>>>>>>> ensues.
>>>>>>>>>
>>>>>>>>> So fundamentally we will have to count tick-wakeups as a) nothing, which
>>>>>>>>> doesn't allow us to ever break out of the intercept logic that caused us
>>>>>>>>> to leave the tick on b) intercepts, which is bonkers and doesn't allow us
>>>>>>>>> to ever break out and c) hits == sleep_length would've been accurate.
>>>>>>>>> Of course counting a tick wakeup as a hit for sleep_length negates the
>>>>>>>>> intercept logic.
>>>>>>>>
>>>>>>>> Not quite.  The intercept logic is there for wakeups other than tick
>>>>>>>> wakeups and timer wakeups.
>>>>>>>>
>>>>>>>> I actually think that tick wakeups can be counted as hits on the
>>>>>>>> deepest available state - maybe only when tick wakeups dominate the
>>>>>>>> wakeup pattern - but generally this is not unreasonable: When the
>>>>>>>> wakeup pattern is dominated by tick wakeups, this by itself is a good
>>>>>>>> enough reason to stop the tick.
>>>>>>>
>>>>>>> (assuming HZ=1000 below but it doesn't matter)
>>>>>>> That will exclude any 'intercept' logic from having much effect if the
>>>>>>> avg idle duration is >TICK_NSEC/2, which is potentially still quite a bit
>>>>>>> off from state1 residency, like in Reka's case here.
>>>>>>> That's why I thought it would cause unreasonable regressions here.
>>>>>>> I'll give it a go as well though!
>>>>>>
>>>>>> Thanks!
>>>>>>
>>>>>> Note that I'd prefer to add a check if tick wakeups dominate the
>>>>>> wakeup pattern before setting sleep_length_ns to KTIME_MAX though.
>>>>>> I'd first like to know how the Reka's system reacts to the more
>>>>>> drastic variant of this change.
>>>>>
>>>>> Below are my usual tests, it's definitely visible but the impact is limited
>>>>> on this platform anyway. I think if we gate the KTIME_MAX setting behind
>>>>> the "tick wakeup dominate" it should be acceptable!
>>>>> Let's see what Reka reports.
>>>>>
>>>> Forgot to post the full results, anyway as expected with mtdblock (a very slow
>>>> / low frequent wakeup scenario) the impact becomes clearly visible.
>>>> Still hopeful that the more conservative approach will be acceptable!
>>>
>>> Speaking of which, the patch to test is appended below, but it doesn't apply
>>> directly on top of the mainline.  It is based on some other patches that have
>>> been posted recently, so here's a git branch with all of the requisite
>>> material:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git cpuidle-teo-testing
>>>
>>> Reka, please try this one and let us know how it goes.
>>>
>>> ---
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> Subject: [PATCH v1] cpuidle: governors: teo: Rework the handling of tick wakeups
>>>
>>> If the wakeup pattern is clearly dominated by tick wakeups, count those
>>> wakeups as hits on the deepest available idle state to increase the
>>> likelihood of stopping the tick, especially on systems where there are
>>> only 2 usable idle states and the tick can only be stopped when the
>>> deeper state is selected.
>>
>> Maybe a sentence on the consequence that without this we may be ever-stuck in
>> the intercept logic.
> 
> Good point, I'll add one.
> 
>>>
>>> This change is expected to reduce power on some systems where state 0 is
>>> selected relatively often even though they are almost idle.
>>>
>>
>> Should be a fixes tag, but I think it's a lot earlier than just
>> 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts")
> 
> I'll add the Fixes: tag pointing to this because it has exposed the
> issue, but I agree that it was there earlier.
> 
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>  drivers/cpuidle/governors/teo.c |   39 ++++++++++++++++++++++++---------------
>>>  1 file changed, 24 insertions(+), 15 deletions(-)
>>>
>>> --- a/drivers/cpuidle/governors/teo.c
>>> +++ b/drivers/cpuidle/governors/teo.c
>>> @@ -133,17 +133,19 @@ struct teo_bin {
>>>   * @sleep_length_ns: Time till the closest timer event (at the selection time).
>>>   * @state_bins: Idle state data bins for this CPU.
>>>   * @total: Grand total of the "intercepts" and "hits" metrics for all bins.
>>> + * @total_tick: Wakeups by the scheduler tick.
>>>   * @tick_intercepts: "Intercepts" before TICK_NSEC.
>>>   * @short_idles: Wakeups after short idle periods.
>>> - * @artificial_wakeup: Set if the wakeup has been triggered by a safety net.
>>> + * @tick_wakeup: Set if the last wakeup was by the scheduler tick.
>>>   */
>>>  struct teo_cpu {
>>>       s64 sleep_length_ns;
>>>       struct teo_bin state_bins[CPUIDLE_STATE_MAX];
>>>       unsigned int total;
>>> +     unsigned int total_tick;
>>>       unsigned int tick_intercepts;
>>>       unsigned int short_idles;
>>> -     bool artificial_wakeup;
>>> +     bool tick_wakeup;
>>>  };
>>>
>>>  static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
>>> @@ -172,9 +174,10 @@ static void teo_update(struct cpuidle_dr
>>>
>>>       teo_decay(&cpu_data->short_idles);
>>>
>>> -     if (cpu_data->artificial_wakeup) {
>>> +     if (dev->poll_time_limit) {
>>> +             dev->poll_time_limit = false;
>>>               /*
>>> -              * If one of the safety nets has triggered, assume that this
>>> +              * Polling state timeout has triggered, so assume that this
>>>                * might have been a long sleep.
>>>                */
>>>               measured_ns = S64_MAX;
>>> @@ -223,6 +226,21 @@ static void teo_update(struct cpuidle_dr
>>>       cpu_data->total = total + PULSE;
>>>
>>>       teo_decay(&cpu_data->tick_intercepts);
>>> +
>>> +     teo_decay(&cpu_data->total_tick);
>>> +     if (cpu_data->tick_wakeup) {
>>> +             cpu_data->total_tick += PULSE;
>>> +             /*
>>> +              * If tick wakeups dominate the wakeup pattern, count this one
>>> +              * as a hit on the deepest available idle state to increase the
>>> +              * likelihood of stopping the tick.
>>> +              */
>>> +             if (3 * cpu_data->total_tick > 2 * cpu_data->total) {
>>> +                     cpu_data->state_bins[drv->state_count-1].hits += PULSE;
>>> +                     return;
>>> +             }
>>> +     }
>>> +
>>
>> What if this state happens to be disabled?
>> If we're walking through the states anyway to find the deepest non-disabled one,
>> I think the first non-disabled above TICK_NSEC might be an even better choice?
> 
> It actually doesn't matter AFAICS because those hits only come to play in the
> 
>     if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
> 
> check in teo_select() and they are included in cpu_data->total in either case.

Ah right, they will be part of total, not part of idx_hit_sum which is what we want.
Sorry for the noise.

> [snip]

