Return-Path: <linux-pm+bounces-37828-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BB9C52A43
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 15:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F1E64F43B9
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 14:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2870F21D3F6;
	Wed, 12 Nov 2025 14:03:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC0823F40D
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956212; cv=none; b=tscdrFtveYe+gt6K8ouHGSr31FxFAeapGeSdQ+qIAdCmd0ZjFLyOm+9FOdm9m2G9Z6zgI/k+hQzSet3CpzoP/Y41diwEpMV5Tj2IZ7Ii0QUsFE9/bhlg5THL28q79gFwX6AxgJgQ9puIvhCIczHzmPBavjWwtt26DyS7aiTnxno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956212; c=relaxed/simple;
	bh=sXmB7YD4+uK158NhxnSTLbKG0eAibCN8R7f2Hb/xls8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qUu/tpu0ePEZcGU56KVM3ncCzPL895bTwBaB/hFMkBiaNvGY9ownG1VOxpVLBc5hm0pAU1tgYtYZ4AfafgvQ5pfC+NcH6RD3a9fE4iN9TAmJtlvZjHS1v239ow4oUwyqzcqf2byLT9diAoC5dRd6PLWK79tCd0VV9+rPbcy0hOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A7661515;
	Wed, 12 Nov 2025 06:03:21 -0800 (PST)
Received: from [10.1.28.59] (e127648.arm.com [10.1.28.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 251F63F5A1;
	Wed, 12 Nov 2025 06:03:28 -0800 (PST)
Message-ID: <571fb9f4-56f5-4d75-a70e-d8741bd1fad2@arm.com>
Date: Wed, 12 Nov 2025 14:03:26 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression in TEO cpuidle governor between 6.6 and 6.12
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Reka Norman <rekanorman@chromium.org>
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
References: <CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com>
 <ed1e64dc-91c9-44d9-b3d3-9f142bcf7a8d@arm.com>
 <CAJZ5v0g9Jndez5y5i4pPW1C+qfj=4iiu51HV7Eb1dBGd1jg-CA@mail.gmail.com>
 <b910a35c-83aa-4050-9c6c-de40f13a2a55@arm.com>
 <CAJZ5v0h6qAgWkEad5OGM-V-HOE-1PwD_XqgsDWbnJNxLWOKDfA@mail.gmail.com>
 <CAEmPcws_pvYpzRMQfMyRPBw=7bUyYCcnP3BHN2H4wgUeLLszFg@mail.gmail.com>
 <CAJZ5v0i_ZUD1=3JDABJZ3fcdD7r8uMU36=mam8r2=1P02YksYw@mail.gmail.com>
 <f0a2492b-9cea-4450-88ca-be8f99f3e0fe@arm.com>
 <CAEmPcwvui5Cg5yoa9NEq5b3OZREb08tbmy4=f=adTLuLPBgGgw@mail.gmail.com>
 <0c018867-c092-4f8e-8f7a-32bb02de3ad5@arm.com>
 <CAEmPcwuVPMONrDHcnxbWpoG5K5DFwf-u2i7wuOK4Q9HvF2uOhw@mail.gmail.com>
 <2a429c41-8624-408c-9db0-4450ab76e52f@arm.com>
 <a33965da-81d8-47c5-9fa0-434812f2bd72@arm.com>
 <CAJZ5v0jjswmSsSRqfjrbDVD4rpYvp2qCdweYrK0JV0zUketczQ@mail.gmail.com>
 <939deff8-7856-4d9b-be91-eda06fac21d0@arm.com>
 <CAJZ5v0ic0+sG7yp=wXAcsTBmHdXLe8gKLosFJj48AGuCQ=1beg@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0ic0+sG7yp=wXAcsTBmHdXLe8gKLosFJj48AGuCQ=1beg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/12/25 13:32, Rafael J. Wysocki wrote:
> On Tue, Nov 11, 2025 at 6:20 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 11/11/25 11:48, Rafael J. Wysocki wrote:
>>> On Tue, Nov 11, 2025 at 11:48 AM Christian Loehle
>>> <christian.loehle@arm.com> wrote:
>>>>
>>>> On 11/11/25 10:00, Christian Loehle wrote:
> 
> [...]
> 
>>>>> I see two issues:
>>>>> 1) Because of DECAY_SHIFT 3 values < 8 cannot decay (I guess this wouldn't really be an issue without 2))
>>>
>>> This shouldn't be a problem.
>>
>> Agreed, it should be a non-issue. Nonetheless if this wasn't the case $subject would've likely
>> never been an issue.
> 
> Well, I think that the leftovers can be cleared when they become less than 8.
> 
>>>
>>>>> 2) if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) isn't an appropriate check, it will
>>>>> exclude the state if it its idx_hit_sum make up the vast majority of cpu_data->total (i.e. it would
>>>>> have been a really good candidate actually).
>>>
>>> Well, it would exclude the state if the sum of hits for the states
>>> below it is large enough.  This is questionable (because why would
>>> hits matter here), but I attempted to make the change below and
>>> somebody reported a regression IIRC.
>>>
>>> This check is related to the problem at hand though (see below).
>>>
>>>>>
>>>>> I lightly tested the below, it seems to be at least comparable to mainline teo.
>>>>> (the documentation/comments would need adapting too, of course)
>>>>>
>>>>> -----8<-----
>>>>>
>>>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
>>>>> index bfa55c1eab5b..f8f76e3b8364 100644
>>>>> --- a/drivers/cpuidle/governors/teo.c
>>>>> +++ b/drivers/cpuidle/governors/teo.c
>>>>> @@ -355,7 +355,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>>>>          * all of the deeper states, a shallower idle state is likely to be a
>>>>>          * better choice.
>>>>>          */
>>>>> -       if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
>>>>> +       if (2 * idx_intercept_sum > idx_hit_sum) {
>>>>>                 int first_suitable_idx = idx;
>>>>>
>>>>>                 /*
>>>>>
>>>>>
>>>>
>>>> ... nevermind the patch, idx_hit_sum is of course the sum of 0...idx-1.
>>>> Maybe something like this, again lightly tested:
>>>>
>>>> -----8<-----
>>>>
>>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
>>>> index 173ddcac540a..6bfb9cedb75e 100644
>>>> --- a/drivers/cpuidle/governors/teo.c
>>>> +++ b/drivers/cpuidle/governors/teo.c
>>>> @@ -383,13 +395,15 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>>>                  * has been stopped already into account.
>>>>                  */
>>>>                 intercept_sum = 0;
>>>> +               hit_sum = 0;
>>>>
>>>>                 for (i = idx - 1; i >= 0; i--) {
>>>>                         struct teo_bin *bin = &cpu_data->state_bins[i];
>>>>
>>>>                         intercept_sum += bin->intercepts;
>>>> +                       hit_sum += bin->hits;
>>>>
>>>> -                       if (2 * intercept_sum > idx_intercept_sum) {
>>>> +                       if (2 * intercept_sum > cpu_data->total || 2 * hit_sum > cpu_data->total) {
>>>>                                 /*
>>>>                                  * Use the current state unless it is too
>>>>                                  * shallow or disabled, in which case take the
>>>
>>> This will only matter after the deepest state has been rejected
>>> already and on the system in question this means selecting state 0 no
>>> matter what.
>>>
>>
>> Ah, right!
>>
>>
>>> The pre-6.12 behavior can be explained if tick wakeups are taken into account.
>>>
>>> Namely, when state 0 is chosen (because of the check mentioned above),
>>> the tick is not stopped and the sleep length is KTIME_MAX.  If the
>>> subsequent wakeup is a tick one, it will be counted as a hit on the
>>> deepest state (and it will contribute to the total sum in the check
>>> mentioned above).  Then, at one point, cpu_data->total will be large
>>> enough and the deepest state will become the candidate one.  If
>>> tick_nohz_get_sleep_length() returns a large value at that point, the
>>> tick will be stopped and the deepest state will be entered.  Nirvana
>>> ensues.
>>
>> So fundamentally we will have to count tick-wakeups as a) nothing, which
>> doesn't allow us to ever break out of the intercept logic that caused us
>> to leave the tick on b) intercepts, which is bonkers and doesn't allow us
>> to ever break out and c) hits == sleep_length would've been accurate.
>> Of course counting a tick wakeup as a hit for sleep_length negates the
>> intercept logic.
> 
> Not quite.  The intercept logic is there for wakeups other than tick
> wakeups and timer wakeups.
> 
> I actually think that tick wakeups can be counted as hits on the
> deepest available state - maybe only when tick wakeups dominate the
> wakeup pattern - but generally this is not unreasonable: When the
> wakeup pattern is dominated by tick wakeups, this by itself is a good
> enough reason to stop the tick.

(assuming HZ=1000 below but it doesn't matter)
That will exclude any 'intercept' logic from having much effect if the
avg idle duration is >TICK_NSEC/2, which is potentially still quite a bit
off from state1 residency, like in Reka's case here.
That's why I thought it would cause unreasonable regressions here.
I'll give it a go as well though! 

> [snip]


