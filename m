Return-Path: <linux-pm+bounces-20543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B6FA13ADB
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 14:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CF097A3454
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 13:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB7422A804;
	Thu, 16 Jan 2025 13:27:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F3422A7F4;
	Thu, 16 Jan 2025 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737034024; cv=none; b=hy4oBujDNIplbCI/RTbaRmlk7QqPrIUUQxtV4LUxtansb8jx1np08mHqiAPdv2seeUhMPP/1452QqC2UZSmP1bmJ7eKbo/E28H3ZcSGzoNY5RkWTMITzX4Q980LDNUwXVDjHz7Cjimk3vKSIxhhsYS683GRF2H4uIoDNV1EA67k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737034024; c=relaxed/simple;
	bh=1zJPC/pU/QWkHE+WlObZSvhgbhMNp/BwGqDC1oA2TMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q7ZC7O1USEu/QO2lK2mRq08loJs4P1ER1nCVGkMmCTv2QLcv1/Ee1cpDUH6Lu3jPwhyNLFRlty7WwXivVOtiqe3H0dCRmCVh/aAlnpZ3zY+vD9FrosL7gMZqdUz1SE1Zf7lCskhK6c7AL3j/t1yTQa6S1d2Nf70Wzmg1iJoQ2go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41473106F;
	Thu, 16 Jan 2025 05:27:28 -0800 (PST)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BDA33F673;
	Thu, 16 Jan 2025 05:26:58 -0800 (PST)
Message-ID: <9fb87b98-778c-4ab8-9444-55b76096c28f@arm.com>
Date: Thu, 16 Jan 2025 13:26:55 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/9] cpuidle: teo: Reorder candidate state index checks
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
References: <6116275.lOV4Wx5bFT@rjwysocki.net>
 <CAJZ5v0g2CxmFB3Js09jKk=ym26oEGVUsr5tM2p2vpPU_bczjmA@mail.gmail.com>
 <CAJZ5v0gr5CTM+p4dvAywuNyxLfE6MW7WWFu7wajCazMPodEvvg@mail.gmail.com>
 <6122398.lOV4Wx5bFT@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <6122398.lOV4Wx5bFT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/16/25 12:22, Rafael J. Wysocki wrote:
> On Wednesday, January 15, 2025 10:10:11 PM CET Rafael J. Wysocki wrote:
>> On Wed, Jan 15, 2025 at 9:48 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>
>>> On Wed, Jan 15, 2025 at 8:20 PM Christian Loehle
>>> <christian.loehle@arm.com> wrote:
>>>>
>>>> On 1/15/25 15:54, Rafael J. Wysocki wrote:
>>>>> On Wed, Jan 15, 2025 at 3:46 PM Christian Loehle
>>>>> <christian.loehle@arm.com> wrote:
>>>>>>
>>>>>> On 1/13/25 18:36, Rafael J. Wysocki wrote:
>>>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>>>
>>>>>>> Since constraint_idx may be 0, the candidate state index may change to 0
>>>>>>> after assigning constraint_idx to it, so first check if it is greater
>>>>>>> than constraint_idx (and update it if so) and then check it against 0.
>>>>>>
>>>>>> So the reason I've left this where it was is because the prev_intercept_idx
>>>>>> was supposed to query the sleep length if we're in an majority-intercept
>>>>>> period and then it makes sense to query the sleep length (to detect such
>>>>>> a period being over).
>>>>>> A constraint_idx == 0 scenario doesn't need the intercept-machinery to
>>>>>> work at all, why are we querying the sleep length then?
>>>>>
>>>>> In case the constraint is different next time and it's better to know
>>>>> the sleep length to properly classify the wakeup.
>>>>
>>>> I would hope constraints change nowhere near as frequently as
>>>> idle entry / exit happen, is your experience different?
>>>
>>> They don't, but they may change at any time and it is kind of good to
>>> have history in case this happens.
>>>
>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>>> ---
>>>>>>>
>>>>>>> This is a rebased variant of
>>>>>>>
>>>>>>> https://lore.kernel.org/linux-pm/8476650.T7Z3S40VBb@rjwysocki.net/
>>>>>>>
>>>>>>> ---
>>>>>>>  drivers/cpuidle/governors/teo.c |   15 ++++++++-------
>>>>>>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>>>>>>
>>>>>>> --- a/drivers/cpuidle/governors/teo.c
>>>>>>> +++ b/drivers/cpuidle/governors/teo.c
>>>>>>> @@ -428,6 +428,14 @@
>>>>>>>                               break;
>>>>>>>               }
>>>>>>>       }
>>>>>>> +
>>>>>>> +     /*
>>>>>>> +      * If there is a latency constraint, it may be necessary to select an
>>>>>>> +      * idle state shallower than the current candidate one.
>>>>>>> +      */
>>>>>>> +     if (idx > constraint_idx)
>>>>>>> +             idx = constraint_idx;
>>>>>>> +
>>>>>>>       if (!idx && prev_intercept_idx) {
>>>>>>>               /*
>>>>>>>                * We have to query the sleep length here otherwise we don't
>>>>>>> @@ -439,13 +447,6 @@
>>>>>>>       }
>>>>>>>
>>>>>>>       /*
>>>>>>> -      * If there is a latency constraint, it may be necessary to select an
>>>>>>> -      * idle state shallower than the current candidate one.
>>>>>>> -      */
>>>>>>> -     if (idx > constraint_idx)
>>>>>>> -             idx = constraint_idx;
>>>>>>> -
>>>>>>> -     /*
>>>>>>
>>>>>> We could leave this here and just do goto end;?
>>>>>
>>>>> Why would this be better?
>>>>
>>>> Saves querying the sleep length in case of constraint_idx == 0, i.e.
>>>> qos request to be very latency-sensitive and us actually adding latency
>>>> here.
>>>
>>> Fair enough, but before patch [7/9] leaving it where it is doesn't
>>> really cause it to skip the sleep length check unless state 0 is
>>> "polling".
>>>
>>> After patch [7/9] it is possible to add a constraint_idx check against
>>> 0 to the "goto out_tick" condition before the
>>> tick_nohz_get_sleep_length() call, that is
>>>
>>> if ((!idx || drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD_NS) &&
>>>     (2 * cpu_data->short_idle >= cpu_data->total || !constraint_idx))
>>>         goto out_tick;
>>
>> Or even
>>
>> if ((!idx || drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD_NS) &&
>>     (2 * cpu_data->short_idle >= cpu_data->total || latency_req <
>> A_SMALL_VALUE))
>>         goto out_tick;
>>
>> for that matter.
>>
>>> but that would be a separate patch if you will.
> 
> So for completeness, it would be a patch like the one below, on top of the [7/9].
> 
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v1] cpuidle: teo: Skip sleep length computation for low latency constraints
> 
> If the idle state exit latency constraint is sufficiently low, it
> is better to avoid the additional latency related to calling
> tick_nohz_get_sleep_length().  It is also not necessary to compute
> the sleep length in that case because shallow idle state selection
> will be forced then regardless of the recent wakeup history.
> 
> Accordingly, skip the sleep length computation and subsequent
> checks of the exit latency constraint is low enough.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thank you, that makes sense.
Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
>  drivers/cpuidle/governors/teo.c |   13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -106,6 +106,12 @@
>  #include "gov.h"
>  
>  /*
> + * Idle state exit latency threshold used for deciding whether or not to check
> + * the time till the closest expected timer event.
> + */
> +#define LATENCY_THRESHOLD_NS	(RESIDENCY_THRESHOLD_NS / 2)
> +
> +/*
>   * The PULSE value is added to metrics when they grow and the DECAY_SHIFT value
>   * is used for decreasing metrics on a regular basis.
>   */
> @@ -432,9 +438,14 @@
>  	 * duration falls into that range in the majority of cases, assume
>  	 * non-timer wakeups to be dominant and skip updating the sleep length
>  	 * to reduce latency.
> +	 *
> +	 * Also, if the latency constraint is sufficiently low, it will force
> +	 * shallow idle states regardless of the wakeup type, so the sleep
> +	 * length need not be known in that case.
>  	 */
>  	if ((!idx || drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD_NS) &&
> -	    2 * cpu_data->short_idle >= cpu_data->total)
> +	    (2 * cpu_data->short_idle >= cpu_data->total ||
> +	     latency_req < LATENCY_THRESHOLD_NS))
>  		goto out_tick;
>  
>  	duration_ns = tick_nohz_get_sleep_length(&delta_tick);
> 
> 
> 
> 


