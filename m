Return-Path: <linux-pm+bounces-31969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1D6B1B6C5
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 16:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3E018845CC
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 14:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314A02777E5;
	Tue,  5 Aug 2025 14:41:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B49E27874A;
	Tue,  5 Aug 2025 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754404895; cv=none; b=Bp2NnYVU9+4RAtmO+5b9o6MtPKj+yqBfyTtdF3FD8A+IbDUXfcZIZM8eG0NDWnDBx27fqv/4ocVgUQVMX/xHotIstvJeodL15RbH1WcGzMkJ35XWyPXVjqZNNvS0w7e9YT6QSz3tLxlQNpdf+Gn8BseUg1RcQ0XKtexEDBsdmkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754404895; c=relaxed/simple;
	bh=K3vToUqtpUQ0FdEehZ9PFkGdoHWsKJl9f9J0R2zwQL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W35E6xS6jB5dWLOyFPKB5oP+lqDNZumLSI3V+auLn2vu9Wi4jyKr0Rt1DsFwY0Znwx1VVWDpvIoJ+1QNmdst8kU7wnUlfumxG5TQ4NfJj4JSZxkO8rrGqGqNkjpZDTZNb25anujthIgEgRsYEkN0STK4DrMAY2GMucTs1ST3yOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52FB112FC;
	Tue,  5 Aug 2025 07:41:23 -0700 (PDT)
Received: from [10.1.27.68] (e127648.arm.com [10.1.27.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F3BC3F738;
	Tue,  5 Aug 2025 07:41:29 -0700 (PDT)
Message-ID: <7ffcb716-9a1b-48c2-aaa4-469d0df7c792@arm.com>
Date: Tue, 5 Aug 2025 15:41:27 +0100
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
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0g=eSeAp96mHCOm+C9jis3uNRXgPhNgtT0SgP9kZ1emvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/5/25 14:23, Rafael J. Wysocki wrote:
> On Mon, Aug 4, 2025 at 6:54 PM Marc Zyngier <maz@kernel.org> wrote:
>>
>> [+ Thomas, Mark]
>>
>> On Thu, 06 Feb 2025 14:29:05 +0000,
>> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
>>>
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> When giving up on making a high-confidence prediction,
>>> get_typical_interval() always returns UINT_MAX which means that the
>>> next idle interval prediction will be based entirely on the time till
>>> the next timer.  However, the information represented by the most
>>> recent intervals may not be completely useless in those cases.
>>>
>>> Namely, the largest recent idle interval is an upper bound on the
>>> recently observed idle duration, so it is reasonable to assume that
>>> the next idle duration is unlikely to exceed it.  Moreover, this is
>>> still true after eliminating the suspected outliers if the sample
>>> set still under consideration is at least as large as 50% of the
>>> maximum sample set size.
>>>
>>> Accordingly, make get_typical_interval() return the current maximum
>>> recent interval value in that case instead of UINT_MAX.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>  drivers/cpuidle/governors/menu.c |   13 ++++++++++++-
>>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> --- a/drivers/cpuidle/governors/menu.c
>>> +++ b/drivers/cpuidle/governors/menu.c
>>> @@ -190,8 +190,19 @@
>>>        * This can deal with workloads that have long pauses interspersed
>>>        * with sporadic activity with a bunch of short pauses.
>>>        */
>>> -     if ((divisor * 4) <= INTERVALS * 3)
>>> +     if (divisor * 4 <= INTERVALS * 3) {
>>> +             /*
>>> +              * If there are sufficiently many data points still under
>>> +              * consideration after the outliers have been eliminated,
>>> +              * returning without a prediction would be a mistake because it
>>> +              * is likely that the next interval will not exceed the current
>>> +              * maximum, so return the latter in that case.
>>> +              */
>>> +             if (divisor >= INTERVALS / 2)
>>> +                     return max;
>>> +
>>>               return UINT_MAX;
>>> +     }
>>>
>>>       /* Update the thresholds for the next round. */
>>>       if (avg - min > max - avg)
>>
>> It appears that this patch, which made it in 6.15, results in *a lot*
>> of extra interrupts on one of my arm64 test machines.
>>
>> * Without this patch:
>>
>> maz@big-leg-emma:~$ vmstat -y 1
>> procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
>>  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
>>  1  0      0 65370828  29244 106088    0    0     0     0   66   26  0  0 100  0  0
>>  1  0      0 65370828  29244 106088    0    0     0     0  103   66  0  0 100  0  0
>>  1  0      0 65370828  29244 106088    0    0     0     0   34   12  0  0 100  0  0
>>  1  0      0 65370828  29244 106088    0    0     0     0   25   12  0  0 100  0  0
>>  1  0      0 65370828  29244 106088    0    0     0     0   28   14  0  0 100  0  0
>>
>> we're idling at only a few interrupts per second, which isn't bad for
>> a 24 CPU toy.
>>
>> * With this patch:
>>
>> maz@big-leg-emma:~$ vmstat -y 1
>> procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
>>  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
>>  1  0      0 65361024  28420 105388    0    0     0     0 3710   27  0  0 100  0  0
>>  1  0      0 65361024  28420 105388    0    0     0     0 3399   20  0  0 100  0  0
>>  1  0      0 65361024  28420 105388    0    0     0     0 4439   78  0  0 100  0  0
>>  1  0      0 65361024  28420 105388    0    0     0     0 5634   14  0  0 100  0  0
>>  1  0      0 65361024  28420 105388    0    0     0     0 5575   14  0  0 100  0  0
>>
>> we're idling at anywhere between 3k and 6k interrupts per second. Not
>> exactly what you want. This appears to be caused by the broadcast
>> timer IPI.
>>
>> Reverting this patch on top of 6.16 restores sanity on this machine.
> 
> I don't know what is going on here, but it looks highly suspicious to me.
> 
> The only effect of the change in question should be selecting a
> shallower idle state occasionally and why would this alone cause the
> number of wakeup interrupts to increase?
> 
> Arguably, it might interfere with the tick stopping logic if
> predicted_ns happened to be less than TICK_NSEC sufficiently often,
> but that is not expected to happen on an idle system because in that
> case the average interval between genuine wakeups is relatively large.
> The tick itself is not counted as a wakeup event, so returning a
> shallower state at one point shouldn't affect future predictions, but
> the data above suggests that it actually does affect them.
> 
> It looks like selecting a shallower idle state by the governor at one
> point causes more wakeup interrupts to occur in the future which is
> really note expected to happen.
> 
> Christian, what do you think?
> 
So I looked a bit into it, unfortunately I don't have the box in question.
Apparently psci cpuidle is broken (and never worked), it has:

/sys/devices/system/cpu/cpu0/cpuidle/driver/name: psci_idle
/sys/devices/system/cpu/cpu0/cpuidle/state0/disable: 0
/sys/devices/system/cpu/cpu0/cpuidle/state0/above: 0
/sys/devices/system/cpu/cpu0/cpuidle/state0/time: 1206224
/sys/devices/system/cpu/cpu0/cpuidle/state0/rejected: 0
/sys/devices/system/cpu/cpu0/cpuidle/state0/power: 4294967295
/sys/devices/system/cpu/cpu0/cpuidle/state0/residency: 1
/sys/devices/system/cpu/cpu0/cpuidle/state0/latency: 1
/sys/devices/system/cpu/cpu0/cpuidle/state0/usage: 1447
/sys/devices/system/cpu/cpu0/cpuidle/state0/desc: ARM WFI
/sys/devices/system/cpu/cpu0/cpuidle/state0/below: 182
/sys/devices/system/cpu/cpu0/cpuidle/state0/default_status: enabled
/sys/devices/system/cpu/cpu0/cpuidle/state0/name: WFI
/sys/devices/system/cpu/cpu0/cpuidle/state1/disable: 0
/sys/devices/system/cpu/cpu0/cpuidle/state1/above: 0
/sys/devices/system/cpu/cpu0/cpuidle/state1/time: 0
/sys/devices/system/cpu/cpu0/cpuidle/state1/rejected: 17021
/sys/devices/system/cpu/cpu0/cpuidle/state1/power: 0
/sys/devices/system/cpu/cpu0/cpuidle/state1/residency: 2000
/sys/devices/system/cpu/cpu0/cpuidle/state1/latency: 1500
/sys/devices/system/cpu/cpu0/cpuidle/state1/usage: 0
/sys/devices/system/cpu/cpu0/cpuidle/state1/desc: cpu-sleep-0
/sys/devices/system/cpu/cpu0/cpuidle/state1/below: 0
/sys/devices/system/cpu/cpu0/cpuidle/state1/default_status: enabled
/sys/devices/system/cpu/cpu0/cpuidle/state1/name: cpu-sleep-0
/sys/devices/system/cpu/cpu0/cpuidle/state1/s2idle/time: 0
/sys/devices/system/cpu/cpu0/cpuidle/state1/s2idle/usage: 0
/sys/devices/system/cpu/cpu0/cpuidle/state2/disable: 0
/sys/devices/system/cpu/cpu0/cpuidle/state2/above: 0
/sys/devices/system/cpu/cpu0/cpuidle/state2/time: 0
/sys/devices/system/cpu/cpu0/cpuidle/state2/rejected: 19598056
/sys/devices/system/cpu/cpu0/cpuidle/state2/power: 0
/sys/devices/system/cpu/cpu0/cpuidle/state2/residency: 2500
/sys/devices/system/cpu/cpu0/cpuidle/state2/latency: 1600
/sys/devices/system/cpu/cpu0/cpuidle/state2/usage: 0
/sys/devices/system/cpu/cpu0/cpuidle/state2/desc: cluster-sleep-0
/sys/devices/system/cpu/cpu0/cpuidle/state2/below: 0
/sys/devices/system/cpu/cpu0/cpuidle/state2/default_status: enabled
/sys/devices/system/cpu/cpu0/cpuidle/state2/name: cluster-sleep-0
/sys/devices/system/cpu/cpu0/cpuidle/state2/s2idle/time: 0
/sys/devices/system/cpu/cpu0/cpuidle/state2/s2idle/usage:: 0

(similar on all CPUs, i.e. it never accounts any (!WFI) cpuidle states
as entered, only as rejected. (for both with and without this patch,
rejected is by factor 10 or so bigger with this patch, which is
what Marc is saying and complaining about.)
If cpuidle enter fails this will report as 0 idle residency in cpuidle.c,
which indeed makes these statistical tests bogus.
I guess we could add a safeguard here again that at least requires
most of the values to be != 0? The real issue is that cpuidle is
being used while it's clearly not working as expected. So we could
also bake some sanity-checks into cpuidle core.
I'd be curious if this is more common or is this really the only
platform were this occurs (and went unnoticed all this time).

