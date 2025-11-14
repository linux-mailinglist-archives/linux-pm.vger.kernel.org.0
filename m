Return-Path: <linux-pm+bounces-38015-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D276C5C01D
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 09:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E5844E25A1
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 08:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2390C2FB998;
	Fri, 14 Nov 2025 08:33:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57560272E5A
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763109221; cv=none; b=dMKqvv1ZIOPxd0/rxkSC4z2rKrLejln3Xdp8ZVlH5wpqNnTD8QqMiJxqnu4DUg5ZKkWO3NQJTTgqKl855dE35X2UiUs59qXhxdbenrlpu+HYGXbF9dm0LMtcrDw5YIfuTO3ZoJ1UUHLoG/ujuhCneNKNSRQef+8GKhLU4zVWbcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763109221; c=relaxed/simple;
	bh=Qq1zuMMhQDMnIrglE/e799gEQrf6ScFHbMlZlNjQ6J0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PocpK6AGwqvv54Biv+WToysrtzuBxU/2A/hTa/2m4Z+SlGSOacSe/QsuFS809f88fIdjO2nYBd0HRnLH4dwnIBdNPw9CunP9Bg17PQVr03ctfyJxIzH49lU1WB9yBIZq3Jd+/puOqn+i55xNtEoPygnG0kd+Mns+2B9yUDt7Tmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2DF41063;
	Fri, 14 Nov 2025 00:33:30 -0800 (PST)
Received: from [10.57.41.249] (unknown [10.57.41.249])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23E1C3F5A1;
	Fri, 14 Nov 2025 00:33:36 -0800 (PST)
Message-ID: <431db236-736d-4fc3-95c2-876bc767aa0c@arm.com>
Date: Fri, 14 Nov 2025 08:33:35 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpuidle: governors: teo: Rework the handling of tick
 wakeups
To: Reka Norman <rekanorman@chromium.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
References: <CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com>
 <00928b9d-7189-4929-afc9-7684fc5ef531@arm.com>
 <ca45366d-4c85-4802-8a35-886a6f69d10d@arm.com>
 <6228387.lOV4Wx5bFT@rafael.j.wysocki>
 <CAEmPcwsVfcoFTyS-mHSkZTFmS8Y1vkFToYo1xcAH0522wyDawA@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAEmPcwsVfcoFTyS-mHSkZTFmS8Y1vkFToYo1xcAH0522wyDawA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/14/25 04:05, Reka Norman wrote:
> On Fri, Nov 14, 2025 at 3:56 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Thursday, November 13, 2025 4:43:18 PM CET Christian Loehle wrote:
>>> On 11/12/25 18:33, Christian Loehle wrote:
>>>> On 11/12/25 14:16, Rafael J. Wysocki wrote:
>>>>> On Wed, Nov 12, 2025 at 3:03 PM Christian Loehle
>>>>> <christian.loehle@arm.com> wrote:
>>>>>>
>>>>>> On 11/12/25 13:32, Rafael J. Wysocki wrote:
>>>>>>> On Tue, Nov 11, 2025 at 6:20 PM Christian Loehle
>>>>>>> <christian.loehle@arm.com> wrote:
>>>>>>>>
>>>>>>>> On 11/11/25 11:48, Rafael J. Wysocki wrote:
>>>>>>>>> On Tue, Nov 11, 2025 at 11:48 AM Christian Loehle
>>>>>>>>> <christian.loehle@arm.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On 11/11/25 10:00, Christian Loehle wrote:
>>>>>>>
>>>>>>> [...]
>>>>>>>
>>>>>>>>>>> I see two issues:
>>>>>>>>>>> 1) Because of DECAY_SHIFT 3 values < 8 cannot decay (I guess this wouldn't really be an issue without 2))
>>>>>>>>>
>>>>>>>>> This shouldn't be a problem.
>>>>>>>>
>>>>>>>> Agreed, it should be a non-issue. Nonetheless if this wasn't the case $subject would've likely
>>>>>>>> never been an issue.
>>>>>>>
>>>>>>> Well, I think that the leftovers can be cleared when they become less than 8.
>>>>>>>
>>>>>>>>>
>>>>>>>>>>> 2) if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) isn't an appropriate check, it will
>>>>>>>>>>> exclude the state if it its idx_hit_sum make up the vast majority of cpu_data->total (i.e. it would
>>>>>>>>>>> have been a really good candidate actually).
>>>>>>>>>
>>>>>>>>> Well, it would exclude the state if the sum of hits for the states
>>>>>>>>> below it is large enough.  This is questionable (because why would
>>>>>>>>> hits matter here), but I attempted to make the change below and
>>>>>>>>> somebody reported a regression IIRC.
>>>>>>>>>
>>>>>>>>> This check is related to the problem at hand though (see below).
>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I lightly tested the below, it seems to be at least comparable to mainline teo.
>>>>>>>>>>> (the documentation/comments would need adapting too, of course)
>>>>>>>>>>>
>>>>>>>>>>> -----8<-----
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
>>>>>>>>>>> index bfa55c1eab5b..f8f76e3b8364 100644
>>>>>>>>>>> --- a/drivers/cpuidle/governors/teo.c
>>>>>>>>>>> +++ b/drivers/cpuidle/governors/teo.c
>>>>>>>>>>> @@ -355,7 +355,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>>>>>>>>>>          * all of the deeper states, a shallower idle state is likely to be a
>>>>>>>>>>>          * better choice.
>>>>>>>>>>>          */
>>>>>>>>>>> -       if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
>>>>>>>>>>> +       if (2 * idx_intercept_sum > idx_hit_sum) {
>>>>>>>>>>>                 int first_suitable_idx = idx;
>>>>>>>>>>>
>>>>>>>>>>>                 /*
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> ... nevermind the patch, idx_hit_sum is of course the sum of 0...idx-1.
>>>>>>>>>> Maybe something like this, again lightly tested:
>>>>>>>>>>
>>>>>>>>>> -----8<-----
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
>>>>>>>>>> index 173ddcac540a..6bfb9cedb75e 100644
>>>>>>>>>> --- a/drivers/cpuidle/governors/teo.c
>>>>>>>>>> +++ b/drivers/cpuidle/governors/teo.c
>>>>>>>>>> @@ -383,13 +395,15 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>>>>>>>>>                  * has been stopped already into account.
>>>>>>>>>>                  */
>>>>>>>>>>                 intercept_sum = 0;
>>>>>>>>>> +               hit_sum = 0;
>>>>>>>>>>
>>>>>>>>>>                 for (i = idx - 1; i >= 0; i--) {
>>>>>>>>>>                         struct teo_bin *bin = &cpu_data->state_bins[i];
>>>>>>>>>>
>>>>>>>>>>                         intercept_sum += bin->intercepts;
>>>>>>>>>> +                       hit_sum += bin->hits;
>>>>>>>>>>
>>>>>>>>>> -                       if (2 * intercept_sum > idx_intercept_sum) {
>>>>>>>>>> +                       if (2 * intercept_sum > cpu_data->total || 2 * hit_sum > cpu_data->total) {
>>>>>>>>>>                                 /*
>>>>>>>>>>                                  * Use the current state unless it is too
>>>>>>>>>>                                  * shallow or disabled, in which case take the
>>>>>>>>>
>>>>>>>>> This will only matter after the deepest state has been rejected
>>>>>>>>> already and on the system in question this means selecting state 0 no
>>>>>>>>> matter what.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Ah, right!
>>>>>>>>
>>>>>>>>
>>>>>>>>> The pre-6.12 behavior can be explained if tick wakeups are taken into account.
>>>>>>>>>
>>>>>>>>> Namely, when state 0 is chosen (because of the check mentioned above),
>>>>>>>>> the tick is not stopped and the sleep length is KTIME_MAX.  If the
>>>>>>>>> subsequent wakeup is a tick one, it will be counted as a hit on the
>>>>>>>>> deepest state (and it will contribute to the total sum in the check
>>>>>>>>> mentioned above).  Then, at one point, cpu_data->total will be large
>>>>>>>>> enough and the deepest state will become the candidate one.  If
>>>>>>>>> tick_nohz_get_sleep_length() returns a large value at that point, the
>>>>>>>>> tick will be stopped and the deepest state will be entered.  Nirvana
>>>>>>>>> ensues.
>>>>>>>>
>>>>>>>> So fundamentally we will have to count tick-wakeups as a) nothing, which
>>>>>>>> doesn't allow us to ever break out of the intercept logic that caused us
>>>>>>>> to leave the tick on b) intercepts, which is bonkers and doesn't allow us
>>>>>>>> to ever break out and c) hits == sleep_length would've been accurate.
>>>>>>>> Of course counting a tick wakeup as a hit for sleep_length negates the
>>>>>>>> intercept logic.
>>>>>>>
>>>>>>> Not quite.  The intercept logic is there for wakeups other than tick
>>>>>>> wakeups and timer wakeups.
>>>>>>>
>>>>>>> I actually think that tick wakeups can be counted as hits on the
>>>>>>> deepest available state - maybe only when tick wakeups dominate the
>>>>>>> wakeup pattern - but generally this is not unreasonable: When the
>>>>>>> wakeup pattern is dominated by tick wakeups, this by itself is a good
>>>>>>> enough reason to stop the tick.
>>>>>>
>>>>>> (assuming HZ=1000 below but it doesn't matter)
>>>>>> That will exclude any 'intercept' logic from having much effect if the
>>>>>> avg idle duration is >TICK_NSEC/2, which is potentially still quite a bit
>>>>>> off from state1 residency, like in Reka's case here.
>>>>>> That's why I thought it would cause unreasonable regressions here.
>>>>>> I'll give it a go as well though!
>>>>>
>>>>> Thanks!
>>>>>
>>>>> Note that I'd prefer to add a check if tick wakeups dominate the
>>>>> wakeup pattern before setting sleep_length_ns to KTIME_MAX though.
>>>>> I'd first like to know how the Reka's system reacts to the more
>>>>> drastic variant of this change.
>>>>
>>>> Below are my usual tests, it's definitely visible but the impact is limited
>>>> on this platform anyway. I think if we gate the KTIME_MAX setting behind
>>>> the "tick wakeup dominate" it should be acceptable!
>>>> Let's see what Reka reports.
>>>>
>>> Forgot to post the full results, anyway as expected with mtdblock (a very slow
>>> / low frequent wakeup scenario) the impact becomes clearly visible.
>>> Still hopeful that the more conservative approach will be acceptable!
>>
>> Speaking of which, the patch to test is appended below, but it doesn't apply
>> directly on top of the mainline.  It is based on some other patches that have
>> been posted recently, so here's a git branch with all of the requisite
>> material:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git cpuidle-teo-testing
>>
>> Reka, please try this one and let us know how it goes.
> 
> Results attached. The residencies are a bit less deep than before -
> about 4.5% in WFI vs 2% at 6.6 or with the more aggressive patch. But
> I’m guessing that’s expected.
> 
> I also measured the power on a slightly different system where I first
> noticed this regression, and it’s indistinguishable from 6.6. So from
> my side this looks great, thank you!

Good news!
For completeness:

Per-Cluster deltas: BIG

+---------+-------+--------------+------------+---------+--------+--------+---------+--------+---------+
| cluster | state | name         | timeΔ      | time%   | usageΔ | aboveΔ | above%  | belowΔ | below%  |
+=========+=======+==============+============+=========+========+========+=========+========+=========+
| BIG     |     0 | WFI          | 957,853    |   2.99% | 2,537  | 0      |   0.00% | 0      |   0.00% |
| BIG     |     1 | cpuoff-b     | 163,636    |   0.51% | 21     | 18     |  85.71% | 3      |  14.29% |
| BIG     |     2 | clusteroff-b | 30,918,285 |  96.50% | 501    | 128    |  25.55% | 0      |   0.00% |
| BIG     |     3 | s2idle       | 0          |   0.00% | 0      | 0      |   0.00% | 0      |   0.00% |
| BIG     | TOTAL |              | 32,039,774 | 100.00% | 3,059  | 146    |   4.77% | 3      |   0.10% |
+---------+-------+--------------+------------+---------+--------+--------+---------+--------+---------+

Per-Cluster deltas: LITTLE

+---------+-------+--------------+-------------+---------+--------+--------+---------+--------+---------+
| cluster | state | name         | timeΔ       | time%   | usageΔ | aboveΔ | above%  | belowΔ | below%  |
+=========+=======+==============+=============+=========+========+========+=========+========+=========+
| LITTLE  |     0 | WFI          | 8,424,141   |   6.63% | 16,629 | 0      |   0.00% | 0      |   0.00% |
| LITTLE  |     1 | cpuoff-l     | 11,121,561  |   8.75% | 485    | 96     |  19.79% | 388    |  80.00% |
| LITTLE  |     2 | clusteroff-l | 107,499,073 |  84.62% | 2,705  | 1,001  |  37.01% | 0      |   0.00% |
| LITTLE  |     3 | s2idle       | 0           |   0.00% | 0      | 0      |   0.00% | 0      |   0.00% |
| LITTLE  | TOTAL |              | 127,044,775 | 100.00% | 19,819 | 1,097  |   5.54% | 388    |   1.96% |
+---------+-------+--------------+-------------+---------+--------+--------+---------+--------+---------+

Per-Cluster deltas: MID

+---------+-------+--------------+------------+---------+--------+--------+---------+--------+---------+
| cluster | state | name         | timeΔ      | time%   | usageΔ | aboveΔ | above%  | belowΔ | below%  |
+=========+=======+==============+============+=========+========+========+=========+========+=========+
| MID     |     0 | WFI          | 2,593,501  |   2.72% | 7,278  | 0      |   0.00% | 0      |   0.00% |
| MID     |     1 | cpuoff-m     | 188,793    |   0.20% | 51     | 48     |  94.12% | 3      |   5.88% |
| MID     |     2 | clusteroff-m | 92,616,252 |  97.08% | 605    | 257    |  42.48% | 0      |   0.00% |
| MID     |     3 | s2idle       | 0          |   0.00% | 0      | 0      |   0.00% | 0      |   0.00% |
| MID     | TOTAL |              | 95,398,546 | 100.00% | 7,934  | 305    |   3.84% | 3      |   0.04% |
+---------+-------+--------------+------------+---------+--------+--------+---------+--------+---------+

Out of curiosity:
Do you know if the platform respects cpuoff / clusteroff distinction
properly? Is the power difference measurable?
There really is no reason for cpuidle to not autopromote them, if there's no latency
requirement that would prevent that.
Especially for the big cluster (just one CPU).

