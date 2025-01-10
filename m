Return-Path: <linux-pm+bounces-20239-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0DAA09453
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 15:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B8F1883B73
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 14:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85A22116E6;
	Fri, 10 Jan 2025 14:52:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2EB211494;
	Fri, 10 Jan 2025 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736520735; cv=none; b=VOwB/3Ki08jORds2FAM5nS+HZenfnywDB7bszKzZFwXNHZGUgxW1/5rgewpE90UkXhjTfpHSs8h2X5HW127uvuLF/klzSrU6RqIQ3ZIGrb1TvaC7uUVZ6vqmHsQbjGD85NefG/EeVbZziZxliMgPdKdCIqnWOeDrNtHRf6E6w5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736520735; c=relaxed/simple;
	bh=gDqTks8MDkaXS91C8md8Hb2TESVj+/4NzHSj1BoPMHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sIjmym6Sr72gj6Y3m5eYdalSYFsg4DfpEf1qZvh9oSakxLShncqVCESWX1IfgFxGsIS8OXjrahRWpMYfXSRego42te01Yj2Y7Rj34a631nYLTR6usgenncly9OK2Amx0OUmb3M74xHa0p5MMdorsTx+XaLsrbZKwiKb0IfFSB24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32B621477;
	Fri, 10 Jan 2025 06:52:41 -0800 (PST)
Received: from [10.57.6.52] (unknown [10.57.6.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89EE43F59E;
	Fri, 10 Jan 2025 06:52:11 -0800 (PST)
Message-ID: <c976eae7-56f8-4b7b-821a-1ec4291b21dd@arm.com>
Date: Fri, 10 Jan 2025 14:52:09 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] cpuidle: teo: Add polling flag check to early
 return path
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
References: <4953183.GXAFRqVoOG@rjwysocki.net>
 <13679187.uLZWGnKmhe@rjwysocki.net>
 <842b1500-9f4f-47e5-9777-ee89351f956e@arm.com>
 <CAJZ5v0hKZP7b8G+FJrb2kTSo90YK75XUsukExPMGVqhoZsSU7A@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0hKZP7b8G+FJrb2kTSo90YK75XUsukExPMGVqhoZsSU7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/10/25 13:34, Rafael J. Wysocki wrote:
> On Fri, Jan 10, 2025 at 2:16 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 1/10/25 12:53, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> After commit 6da8f9ba5a87 ("cpuidle: teo: Skip tick_nohz_get_sleep_length()
>>> call in some cases") the teo governor behaves a bit differently on
>>> systems where idle state 0 is a "polling" state (that is, it is not
>>> really an idle state, but a loop continuously executed by the CPU).
>>> Namely, on such systems it skips the tick_nohz_get_sleep_length() call
>>> if the target residency of the current candidate idle state is small
>>> enough.
>>>
>>> However, if state 0 itself was to be returned, it would be returned
>>> right away without calling tick_nohz_get_sleep_length() even on systems
>>> where it was not a "polling" state until commit 4b20b07ce72f ("cpuidle:
>>> teo: Don't count non-existent intercepts") that attempted to fix this
>>> problem.
>>>
>>> Unfortunately, commit 4b20b07ce72f has made the governor always call
>>> tick_nohz_get_sleep_length() when about to return state 0 early, even
>>> if that state is a "polling" one, which is inconsistent and defeats
>>> the purpose of commit 6da8f9ba5a87 in that case.
>>>
>>> Address this by adding a CPUIDLE_FLAG_POLLING check to the path where
>>> state 0 is returned early to prevent tick_nohz_get_sleep_length() from
>>> being called if it is a "polling" state.
>>>
>>> Fixes: 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts")
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>  drivers/cpuidle/governors/teo.c |    3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> --- a/drivers/cpuidle/governors/teo.c
>>> +++ b/drivers/cpuidle/governors/teo.c
>>> @@ -422,7 +422,8 @@
>>>                       first_suitable_idx = i;
>>>               }
>>>       }
>>> -     if (!idx && prev_intercept_idx) {
>>> +     if (!idx && prev_intercept_idx &&
>>> +         !(drv->states[0].flags & CPUIDLE_FLAG_POLLING)) {
>>>               /*
>>>                * We have to query the sleep length here otherwise we don't
>>>                * know after wakeup if our guess was correct.
>>>
>>>
>>>
>>
>> But then you do run into the issue of intercepts not being detected if
>> state0 is the right choice, don't you?
> 
> That's true, but then on systems with a "polling" state 0 you still
> have this problem if the state returned early is not state 0.  Say C1
> on x86.> 
> The point here is that the behavior needs to be consistent, one way or another.

Yes, gotcha. Why not be consistent 'in the other way' then?

> 
> The exact point of commit 6da8f9ba5a87 was to avoid calling
> tick_nohz_get_sleep_length() in some cases when the state to be
> returned is shallow enough and obviously that includes a "polling"
> state 0, possibly at the cost of being somewhat inaccurate in
> prediction.

Somewhat inaccurate meaning not making any prediction?
cpu_data->sleep_length_ns = KTIME_MAX;

How much is the harm for calling tick_nohz_get_sleep_length() when
polling anyway?
I know tick_nohz_get_sleep_length() is the majority of the usual
cpuidle entry path, but for many scenarios where state0 is appropriate
that should be pretty fast, no?

> 
> Then you're seeing this intercept accumulation for state 0 when there
> are only 2 states in the table (or all of the other states are much
> higher target residency than state 0).
> 
> Commit 4b20b07ce72f effectively caused tick_nohz_get_sleep_length() to
> be called every time on systems without a "polling" state 0, which was
> fair enough, but it also affected the other systems, which wasn't.
> 
>> This would then enable intercept-detection only for <50% of the time,
>> another option is to not allow intercepts selecting a polling state, but
>> there were recent complaints about this exact behavior from Aboorva (+TO).
>> They don't have a low-latency non-polling state.
>>
>> https://lore.kernel.org/lkml/20240809073120.250974-1-aboorvad@linux.ibm.com/
> 
> If they don't have a "polling" state 0, they won't be affected by this
> patch and after commit 4b20b07ce72f, they'll always call
> tick_nohz_get_sleep_length(), so the current governor behavior is
> generally unsuitable for them.

They do though.
commit 5ddcc03a07ae ("powerpc/cpuidle: Set CPUIDLE_FLAG_POLLING for snooze state")
So they have a polling 'snooze' and a relatively high latency (hundreds usecs)
non-polling state and no deeper state.
So if they don't query sleep length on snooze on a (1us)-interrupt-wakeup heavy
workload they will get 50% state0 and 50% state1 (because intercepts recovered
due to not querying sleep length).

> 
> I have an idea how to change it to be more accurate in prediction, but
> we'll see how it goes.  Stay tuned.

I will.

Regards,
Christian
 

