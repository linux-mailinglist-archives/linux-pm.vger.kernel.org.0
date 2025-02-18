Return-Path: <linux-pm+bounces-22299-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2196AA39ACE
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 12:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44A31886024
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 11:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5789123C8BF;
	Tue, 18 Feb 2025 11:28:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3A91DEFEB;
	Tue, 18 Feb 2025 11:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878137; cv=none; b=Y7rmOd/qpGySsKEPozwRh7Jlj90pbZUwRC3ehx8IVFj8635KDOJQomcx9BvuBn7JNQkoXWr2gOhfn22WVElaWYdRitRBc3ytz5RrFAKHYH49k7MJQc21PuTFjJsxP0vv3Bvz8hIxv6cCyr9ufNYN77y8ezeI4j4Uv5fozkI/ZM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878137; c=relaxed/simple;
	bh=e3YwgSBfhhjN6vJS7m63dt9OHcAqtI+PxuY9KnmPzqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAQ3bRfsb4WtpZ14U6miltv2auHmqZPyb3XyNAGM7OrU7pBAw1pDOVGDB1K6wh3T7Q3FFnSkwgKEQQrugnJTtG2pquiLEo3P2gwn9263ZdgZ9u3NVO5y7eLTgykPRjYx6xE9UFdkWOK2xBftIaeNW0bKnuvhci0T3HQA7jZzYDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 906D313D5;
	Tue, 18 Feb 2025 03:29:11 -0800 (PST)
Received: from [10.1.26.35] (e127648.arm.com [10.1.26.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE8413F6A8;
	Tue, 18 Feb 2025 03:28:50 -0800 (PST)
Message-ID: <09472579-d59a-4be9-996b-1638228895ac@arm.com>
Date: Tue, 18 Feb 2025 11:28:48 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT][PATCH v1] cpuidle: teo: Avoid selecting deepest idle state
 over-eagerly
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, dsmythies@telus.net,
 LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
References: <12630185.O9o76ZdvQC@rjwysocki.net>
 <8d147f4f-f511-4f44-b18e-2011b0fab17c@arm.com>
 <CAJZ5v0jjs=po8y0MzkUo=mUuqkxq3tg-V8r7-=AUJUu6=9ymMw@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0jjs=po8y0MzkUo=mUuqkxq3tg-V8r7-=AUJUu6=9ymMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/14/25 21:34, Rafael J. Wysocki wrote:
> On Thu, Feb 13, 2025 at 3:08 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 2/4/25 20:58, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> It has been observed that the recent teo governor update which concluded
>>> with commit 16c8d7586c19 ("cpuidle: teo: Skip sleep length computation
>>> for low latency constraints") caused the max-jOPS score of the SPECjbb
>>> 2015 benchmark [1] on Intel Granite Rapids to decrease by around 1.4%.
>>> While it may be argued that this is not a significant increase, the
>>> previous score can be restored by tweaking the inequality used by teo
>>> to decide whether or not to preselect the deepest enabled idle state.
>>> That change also causes the critical-jOPS score of SPECjbb to increase
>>> by around 2%.
>>>
>>> Namely, the likelihood of selecting the deepest enabled idle state in
>>> teo on the platform in question has increased after commit 13ed5c4a6d9c
>>> ("cpuidle: teo: Skip getting the sleep length if wakeups are very
>>> frequent") because some timer wakeups were previously counted as non-
>>> timer ones and they were effectively added to the left-hand side of the
>>> inequality deciding whether or not to preselect the deepest idle state.
>>>
>>> Many of them are now (accurately) counted as timer wakeups, so the left-
>>> hand side of that inequality is now effectively smaller in some cases,
>>> especially when timer wakeups often occur in the range below the target
>>> residency of the deepest enabled idle state and idle states with target
>>> residencies below CPUIDLE_FLAG_POLLING are often selected, but the
>>> majority of recent idle intervals are still above that value most of
>>> the time.  As a result, the deepest enabled idle state may be selected
>>> more often than it used to be selected in some cases.
>>>
>>> To counter that effect, add the sum of the hits metric for all of the
>>> idle states below the candidate one (which is the deepest enabled idle
>>> state at that point) to the left-hand side of the inequality mentioned
>>> above.  This will cause it to be more balanced because, in principle,
>>> putting both timer and non-timer wakeups on both sides of it is more
>>> consistent than only taking into account the timer wakeups in the range
>>> above the target residency of the deepest enabled idle state.
>>>
>>> Link: https://www.spec.org/jbb2015/
>>> Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>  drivers/cpuidle/governors/teo.c |    6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> --- a/drivers/cpuidle/governors/teo.c
>>> +++ b/drivers/cpuidle/governors/teo.c
>>> @@ -349,13 +349,13 @@
>>>       }
>>>
>>>       /*
>>> -      * If the sum of the intercepts metric for all of the idle states
>>> -      * shallower than the current candidate one (idx) is greater than the
>>> +      * If the sum of the intercepts and hits metric for all of the idle
>>> +      * states below the current candidate one (idx) is greater than the
>>>        * sum of the intercepts and hits metrics for the candidate state and
>>>        * all of the deeper states, a shallower idle state is likely to be a
>>>        * better choice.
>>>        */
>>> -     if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
>>> +     if (2 * (idx_intercept_sum + idx_hit_sum) > cpu_data->total) {
>>>               int first_suitable_idx = idx;
>>>
>>>               /*
>>>
>>>
>>>
>>
>> I'm curious, are Doug's numbers reproducible?
>> Or could you share the idle state usage numbers? Is that explainable?
>> Seems like a lot and it does worry me that I can't reproduce anything
>> as drastic.
> 
> Well, it may not be drastic, but the results below pretty much confirm
> that this particular change isn't going in the right direction IMV.

Agreed, I'd still be eager to pick up something like Doug reported with
my tests too :(

> 
>> I did a bit of x86 as well and got for Raptor Lake (I won't post the
>> non-x86 numbers now, but teo-tweak performs comparable to teo mainline.)
>>
>> Idle 5 min:
>> device   gov     iter    Joules  idles   idle_misses     idle_miss_ratio         belows  aboves
>> teo     0       170.02  12690   646     0.051   371     275
>> teo     1       123.17  8361    517     0.062   281     236
>> teo     2       122.76  7741    347     0.045   262     85
>> teo     3       118.5   8699    668     0.077   307     361
>> teo     4       80.46   8113    443     0.055   264     179
>> teo-tweak       0       115.05  10223   803     0.079   323     480
>> teo-tweak       1       164.41  8523    631     0.074   263     368
>> teo-tweak       2       163.91  8409    711     0.085   256     455
>> teo-tweak       3       137.22  8581    721     0.084   261     460
>> teo-tweak       4       174.95  8703    675     0.078   261     414
> 
> So basically the energy usage goes up, idle misses go up, idle misses
> ratio goes up and the "above" misses go way up.  Not so good as far as
> I'm concerned.
> 
>> teo     0       164.34  8443    516     0.061   303     213
>> teo     1       167.85  8767    492     0.056   256     236
>> teo     2       166.25  7835    406     0.052   263     143
>> teo     3       189.77  8865    493     0.056   276     217
>> teo     4       136.97  9185    467     0.051   286     181
> 
> The above is menu I think?

No this is teo again, just wanted to include it because the variance is
quite large, (not unusual for idle).
The full table (with menu (mainline))

teo 	0 	170.02 	12690 	646 	0.051 	371 	275
teo 	1 	123.17 	8361 	517 	0.062 	281 	236
teo 	2 	122.76 	7741 	347 	0.045 	262 	85
teo 	3 	118.5 	8699 	668 	0.077 	307 	361
teo 	4 	80.46 	8113 	443 	0.055 	264 	179
teo-tweak 	0 	115.05 	10223 	803 	0.079 	323 	480
teo-tweak 	1 	164.41 	8523 	631 	0.074 	263 	368
teo-tweak 	2 	163.91 	8409 	711 	0.085 	256 	455
teo-tweak 	3 	137.22 	8581 	721 	0.084 	261 	460
teo-tweak 	4 	174.95 	8703 	675 	0.078 	261 	414
teo 	0 	164.34 	8443 	516 	0.061 	303 	213
teo 	1 	167.85 	8767 	492 	0.056 	256 	236
teo 	2 	166.25 	7835 	406 	0.052 	263 	143
teo 	3 	189.77 	8865 	493 	0.056 	276 	217
teo 	4 	136.97 	9185 	467 	0.051 	286 	181
menu 	0 	180.13 	8925 	343 	0.038 	303 	40
menu 	1 	208.49 	8717 	345 	0.040 	312 	33
menu 	2 	168.38 	8451 	321 	0.038 	274 	47
menu 	3 	139.48 	7853 	310 	0.039 	289 	21
menu 	4 	166.61 	7769 	339 	0.044 	322 	17

> 
>> At least in the idle case you can see an increase in 'above' idle_misses.

Agreed, idle_misses clearly go up as mentioned.

>>
>> Firefox Youtube 4K video playback 2 min:
>> device   gov     iter    Joules  idles   idle_misses     idle_miss_ratio         belows  aboves
>> teo     0       260.09  67404   11189   0.166   1899    9290
>> teo     1       273.71  76649   12155   0.159   2233    9922
>> teo     2       231.45  59559   10344   0.174   1747    8597
>> teo     3       202.61  58223   10641   0.183   1748    8893
>> teo     4       217.56  61411   10744   0.175   1809    8935
>> teo-tweak       0       227.99  61209   11251   0.184   2110    9141
>> teo-tweak       1       222.44  61959   10323   0.167   1474    8849
>> teo-tweak       2       218.1   64380   11080   0.172   1845    9235
>> teo-tweak       3       207.4   60183   11267   0.187   1929    9338
>> teo-tweak       4       217.46  61253   10381   0.169   1620    8761
> 
> And it doesn't improve things drastically here, although on average it
> does reduce energy usage.


