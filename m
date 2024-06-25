Return-Path: <linux-pm+bounces-9963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D595B916E36
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 18:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027071C217FB
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 16:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AA3173337;
	Tue, 25 Jun 2024 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="OrF45WPG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375E513B2B0
	for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333358; cv=none; b=XbIZ8YYHg0IcRgm6dXKG3bw6ewWqOBLo6W7fa8bWIzcKFDgNQRK155YLb6FdbNdgX8sInwxSRTygqECNYEpZ4HFve0fRjrafT1N3N1sF2rtTVR26hHiFiPuV9x8WVhS0ol+e/Ekr94/3REFsAys/XrfAvxy8F8GRC8I3snEY894=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333358; c=relaxed/simple;
	bh=26Jqu1qSab8jyYnwz/wq2RhRJcLfM1SyldEi8wpoXG8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=fYzFevUFhNcET0BwgMmZ/knxqH75fHOJoQouaamdcOYNkBsz5KV9iIi0xclZGDV6OW80LFRjlQqyH1EGYhzOQAYluNCyteRANG06VekaloK9Tov5bIEH+RrX8bT10szPxvIYvJ8eHpQNyV+3PA28YK4OY3C72DdiPUtX6tlrVSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=OrF45WPG; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c7dff0f4e4so4521608a91.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 09:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1719333355; x=1719938155; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nsu+2sfkZBNRWNQerlRnOkDrtkR1xSgZD7JJpgzpUv4=;
        b=OrF45WPGGeO7sDsWApgg9qdKvECDWjaTHqKt07MWlfdy9F4sc11VQ/ORy2BCwjtR0/
         zF88CTyj5afaC5y8U9z863ORC7Wlrvg+wEzxeP0Vbrr9Z+W/QVIjkY0L+tu+kt22KgN+
         wZfze8WJP8N7391hn2pc1AFeK7S3gMlR0bvb2zhEJdRnAKhimHnCn1eCDjNqOdMwfkhH
         d9srJlsUpli1g6y2VfO0bzYDQz9G+8iTkYxcWoal+30H8v9E/WO5nBUw9MESSLjcd63y
         yyLFBLRuXmKuUdf3zomwbgccGmHmRQmMUc8d8dEeLe3ls8z8A+uT2sv4FBSAm1/Q/6Hf
         HozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719333355; x=1719938155;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nsu+2sfkZBNRWNQerlRnOkDrtkR1xSgZD7JJpgzpUv4=;
        b=aZJv1bgHPsePAmrZGu7pEARn8zKBoZRcr7cwr+1eUfsdYX2h9O+lef4bD1jALIRjXp
         Z6po5Sj4TqbyeiLQwEjTwJfTpXVm84r/XyNz+WEYywSRqQjqdlPS2t0tar8NigIWPCnE
         bLGC/40m8jaKRBxHfL+e4f5ffTwx6stXlEiDKCCsYvRu+aZ59ABcaiTsTyPaWq9qHkVL
         s1NevWvg6aeZD6Ff3mJoUhtsE4dYcFQUqnH89e9qpHsTNYsXTz+BPiZkd66/Tb5UJ7lL
         LWwO9ViH2wRK9ap+fAnken6MZ4oGjT24gJbdG4S8OeKn9y65R0dgS6RnpZx1Kr+T0uFq
         nfvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWXfsDmhPTf+36z4kjgU/6tnDFRqG/b8wIxJG6e3BHRRpv1F6V0Dk6CpdjE7uNgh6oAHfllARBXuaFJKd8kqY60X/JcC8VpcQ=
X-Gm-Message-State: AOJu0YzHn4zpiUekfIPmYPEVoJQqcUmq+Vm0TvlOQTTFcj0drIRd79MN
	smJDT44bQJI7gx4Hwz+2RcdQS4G23oJkEG+as0ovL4l0+Nv8BsNnv9fYdWDg9w8=
X-Google-Smtp-Source: AGHT+IHnluzcaeBF3nMOZ5KFbTEitbdI6AXHu+ZqqrKEMInvjyA6+tOp0IpAW4c2gO0WEtoFcduTfw==
X-Received: by 2002:a17:90b:1bcc:b0:2c7:af63:9581 with SMTP id 98e67ed59e1d1-2c8611324e4mr7171943a91.0.1719333355223;
        Tue, 25 Jun 2024 09:35:55 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819a7a985sm9101613a91.19.2024.06.25.09.35.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2024 09:35:54 -0700 (PDT)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Christian Loehle'" <christian.loehle@arm.com>
Cc: <rafael@kernel.org>,
	<vincent.guittot@linaro.org>,
	<qyousef@layalina.io>,
	<peterz@infradead.org>,
	<daniel.lezcano@linaro.org>,
	<ulf.hansson@linaro.org>,
	<anna-maria@linutronix.de>,
	<kajetan.puchalski@arm.com>,
	<lukasz.luba@arm.com>,
	<dietmar.eggemann@arm.com>,
	<linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <20240611112413.1241352-1-christian.loehle@arm.com> <004a01dac04c$314c4360$93e4ca20$@telus.net> <20240618111729.hqywobxh3gm7rfgq@e127648.arm.com> <005701dac1a4$6ae1c830$40a55890$@telus.net> <20240620111923.wmse37qqtxi6ffzx@e127648.arm.com>
In-Reply-To: <20240620111923.wmse37qqtxi6ffzx@e127648.arm.com>
Subject: RE: [PATCHv2 0/3] cpuidle: teo: Fixing utilization and intercept logic
Date: Tue, 25 Jun 2024 09:35:55 -0700
Message-ID: <002d01dac71d$c0ebd170$42c37450$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHzep4n7RUpOXZFjs7PHwMj2t6TVAGNHIhrAY/VzMwB5e213AMG5FLYsWb1XjA=

Hi Christian,

It took awhile.

On 2024.06.20 04:19 Christian Loehle wrote:
> On Tue, Jun 18, 2024 at 10:24:46AM -0700, Doug Smythies wrote:
>> Hi Christian,
>>
>> Thank you for your reply.
> 
> Thank you for taking the time!
> 
>>
>> On 2024.06.18 03:54 Christian Loehle wrote:
>>> On Sun, Jun 16, 2024 at 05:20:43PM -0700, Doug Smythies wrote:
>>>> On 2024.06.11 04:24 Christian Loehle wrote:
>>>>
>>>> ...
>>>> > Happy for anyone to take a look and test as well.
>>>> ...
>>>>
>>>> I tested the patch set.
>>>> I do a set of tests adopted over some years now.
>>>> Readers may recall that some of the tests search over a wide range of operating conditions looking for areas to focus on in
more
>> detail.
>>>> One interesting observation is that everything seems to run much slower than the last time I did this, last August, Kernel
>> 6.5-rc4.
>>>>
>>>
>>> Thank you very much Doug, that is helpful indeed!
>>>
>>>> Test system:
>>>> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz (6 cores, 2 thread per core, 12 CPUs)
>>>> CPU Frequency scaling driver: intel_pstate
>>>> HWP (HardWare Pstate) control: Disabled
>>>> CPU frequency scaling governor: Performance
>>>> Idle states: 4: name : description:
>>>>    state0/name:POLL		desc:CPUIDLE CORE POLL IDLE
>>>>    state1/name:C1_ACPI		desc:ACPI FFH MWAIT 0x0
>>>>    state2/name:C2_ACPI		desc:ACPI FFH MWAIT 0x30
>>>>    state3/name:C3_ACPI		desc:ACPI FFH MWAIT 0x60
>>>
>>> What are target residencies and exit latencies?
>>
>> Of course. Here:
>>
>> /sys/devices/system/cpu/cpu1/cpuidle/state0/residency:0
>> /sys/devices/system/cpu/cpu1/cpuidle/state1/residency:1
>> /sys/devices/system/cpu/cpu1/cpuidle/state2/residency:360
>> /sys/devices/system/cpu/cpu1/cpuidle/state3/residency:3102
>>
>> /sys/devices/system/cpu/cpu1/cpuidle/state0/latency:0
>> /sys/devices/system/cpu/cpu1/cpuidle/state1/latency:1
>> /sys/devices/system/cpu/cpu1/cpuidle/state2/latency:120
>> /sys/devices/system/cpu/cpu1/cpuidle/state3/latency:1034
> 
> Thanks,
> what am I missing here that these are two different sets of states?

I don't know what you are missing. Those are not two different sets of states.
Maybe I am missing something?

>>>> Ilde driver: intel_idle
>>>> Idle governor: as per individual test
>>>> Kernel: 6.10-rc2 and with V1 and V2 patch sets (1000 Hz tick rate)
>>>> Legend:
>>>>    teo: unmodified 6.10-rc2
>>>>    menu:
>>>>    ladder:
>>>>    cl: Kernel 6.10-rc2 + Christian Loehle patch set V1
>>>>    clv2: Kernel 6.10-rc2 + Christian Loehle patch set V2
             no-util: Kernel 6.10-rc2 + Christian Loehle [PATCHv2 1/3] Revert: "cpuidle: teo: Introduce util-awareness"
>>>> System is extremely idle, other than the test work.
>>>
>>> If you don't mind spinning up another one, I'd be very curious about
>>> results from just the Util-awareness revert (i.e. v2 1/3).
>>> If not I'll try to reproduce your tests.
>>
>> I will, but not today.

Most, if not all, links have been replaced adding "no-util" data.
Summary: there is negligible difference between "teo" and "no-util".
Isn't that what is expected for a system with 4 idle states?

Note 1: I forgot to change the date on several of the graphs.
 
> Thank you.
> 
>> I have never been a fan of Util-awareness.
> 
> Well if you want to elaborate on that I guess now is the time and
> here is the place. ;)

Most of my concerns with the original versions were fixed,
which is why it now has little to no effect on a system with 4 idle states.
Beyond that, I haven't had the time to review all of my old tests and findings.

>>>> Test 1: 2 core ping pong sweep:
>>>>
>>>> Pass a token between 2 CPUs on 2 different cores.
>>>> Do a variable amount of work at each stop.
>>>
>>> Hard to interpret the results here, as state residencies would be the
>>> most useful one, but from the results I assume that residencies are
>>> calculated over all possible CPUs, so 4/6 CPUs are pretty much idle
>>> the entire time, resulting in >75% state3 residency overall.
>>
>> It would be 10 of 12 CPUs are idle and 4 of 6 cores.
> 
> Of course, my bad.
> 
>> But fair enough, the residency stats are being dominated by the idle CPUs.
>> I usually look at the usage in conjunction with the residency percentages.
>> At 10 minutes (20 second sample period):
>> teo entered idle state 3 517 times ; clv2 was 1,979,541 times
>> At 20 minutes:
>> teo entered idle state 3 525 times ; clv2 was 3,011,263 times
>> Anyway, I could hack something to just use data from the 2 CPUs involved.
> 
> Your method works, just a bit awkward, I guess I'm spoiled in that
> regard :)
> (Shameless plug:
> https://tooling.sites.arm.com/lisa/latest/trace_analysis.html#lisa.analysis.idle.IdleAnalysis.plot_cpu_idle_state_residency
> )

Very interesting. If I ever get more time, I'll try it.

>>>> Purpose: To utilize the shallowest idle states
>>>> and observe the transition from using more of 1
>>>> idle state to another.
>>>>
>>>> Results relative to teo (negative is better):
	menu		ladder		clv2		cl		no-util
ave	-2.09%		11.11%		2.88%		1.81%		0.32%
max	10.63%		33.83%		9.45%		10.13%		8.00%
min	-11.58%	6.25%		-3.61%		-3.34%		-1.06%

Note 1: Old data re-stated with all the ">>>" stuff removed.
Note 2: The max +8.00% for no-util is misleading, as it was just a slight difference in a transition point.

>>>> While there are a few operating conditions where clv2 performs better than teo, overall it is worse.
>>>>
>>>> Further details:
>>>> http://smythies.com/~doug/linux/idle/teo-util3/ping-sweep/2-1/2-core-pp-relative.png
>>>> http://smythies.com/~doug/linux/idle/teo-util3/ping-sweep/2-1/2-core-pp-data.png
>>>> http://smythies.com/~doug/linux/idle/teo-util3/ping-sweep/2-1/perf/
>>>>
>>>> Test 2: 6 core ping pong sweep:
>>>>
>>>> Pass a token between 6 CPUs on 6 different cores.
>>>> Do a variable amount of work at each stop.
>>>>
>>>
>>> My first guess would've been that this is the perfect workload for the
>>> very low utilization threshold, but even teo has >40% state3 residency
>>> consistently here.
>>
>> There are still 6 idle CPUs.
>> I'll try a 12 CPUs using each core twice type sweep test,
>> but I think I settled on 6 because it focused on what I wanted for results.
> 
> I see, again, my bad.

I had a 12 CPU type test script already and have used it in the past. Anyway:

Results relative to teo (negative is better):
	no-util	menu	clv2
ave	0.07%	0.77%	1.41%
max	0.85%	2.78%	11.45%
min	-1.30%	-0.62%	0.00%

Note 1:	only test runs 1 to 120 are included, eliminating the bi-stable uncertainty region
	of the higher test runs.
Note 2: This test does show differences between teo and no-util in idle state usage in
	the bi-stable region. I do not know if it is repeatable.

Further details:
http://smythies.com/~doug/linux/idle/teo-util3/ping-sweep/12-1/12-cpu-pp-data.png
http://smythies.com/~doug/linux/idle/teo-util3/ping-sweep/12-1/12-cpu-pp-data-detail-a.png
http://smythies.com/~doug/linux/idle/teo-util3/ping-sweep/12-1/12-cpu-pp-relative.png
http://smythies.com/~doug/linux/idle/teo-util3/ping-sweep/12-1/perf/
 
>>>> Purpose: To utilize the midrange idle states
>>>> and observe the transitions between use of
>>>> idle states.
>>>>
>>>> Note: This test has uncertainty in an area where the performance is bi-stable for all idle governors,
>>>> transitioning between much less power and slower performance and much more power and higher performance.
>>>> On either side of this area, the differences between all idle governors are negligible.
>>>> Only data from before this area (from results 1 t0 95) was included in the below results.
>>>
>>> I see and agree with your interpretation. Difference in power between
>>> all tested seems to be negligible during that window. Interestingly
>>> the residencies of idle states seem to be very different, like ladder
>>> being mostly in deepest state3. Maybe total package power is too coarse
>>> to show the differences for this test.
>>>
>>>> Results relative to teo (negative is better):
	menu	ladder	cl	clv2	no-util
ave	0.16%	4.32%	2.54%	2.64%	0.25%
max	0.92%	14.32%	8.78%	8.50%	14.96%
min	-0.44%	0.27%	0.09%	0.05%	-0.54%

Note 1: Old data re-stated with all the ">>>" stuff removed.
Note 2: The max 14.96% for no-util was the during test start.
	It is not always repeatable. See the dwell test results way further down below.

>>>> One large clv2 difference seems to be excessive use of the deepest idle state,
>>>> with corresponding 100% hit rate on the "Idle State 3 was to deep" metric.
>>>> Example (20 second sample time):
>>>>
>>>> teo: Idle state 3 entries: 600, 74.33% were to deep or 451. Processor power was 38.0 watts.
>>>> clv2: Idle state 3 entries: 4,375,243, 100.00% were to deep or 4,375,243. Processor power was 40.6 watts.
>>>> clv2 loop times were about 8% worse than teo.
>>>
>>> Some of the idle state 3 residencies seem to be >100% at the end here,
>>> not sure what's up with that.
>>
>> The test is over and the system is completely idle.
>> And yes, there are 4 calculations that come out > 100%, the worst being 100.71%,
>> with a total sum over all idle states of 100.79%.
>> I can look into it if you want but have never expected the numbers to be that accurate.
> 
> Hopefully it's just some weird rounding thing, it just looks strange.
> 
>>
>>>> Further details:
>>>> http://smythies.com/~doug/linux/idle/teo-util3/ping-sweep/6-1/6-core-pp-data-detail-a.png
>>>> http://smythies.com/~doug/linux/idle/teo-util3/ping-sweep/6-1/6-core-pp-data-detail-b.png
>>>> http://smythies.com/~doug/linux/idle/teo-util3/ping-sweep/6-1/6-core-pp-data.png
>>>> http://smythies.com/~doug/linux/idle/teo-util3/ping-sweep/6-1/perf/
>>>>
>>>> Test 3: sleeping ebizzy - 128 threads.
>>>>
>>>> Purpose: This test has given interesting results in the past.
>>>> The test varies the sleep interval between record lookups.
>>>> The result is varying usage of idle states.
>>>>
>>>> Results: relative to teo (negative is better):
	menu	clv2	ladder	cl	no-util
ave	0.06%	0.38%	0.81%	0.35%	-0.03%
max	2.53%	3.20%	5.00%	2.87%	0.79%
min	-2.13%	-1.66%	-3.30%	-2.13%	-1.19%

Note 1: Old data re-stated with all the ">>>" stuff removed.

>>>> No strong conclusion here, from just the data.
>>>> However, clv2 seems to use a bit more processor power, on average.
>>>
>>> Not sure about that, from the residencies ladder and teo should be
>>> decisive losers in terms of power. While later in the test teo seems
>>> to be getting worse in power it doesn't quite reflect the difference
>>> in states.
>>> E.g. clv2 finishing with 65% state2 residency while teo has 40%, but
>>> I'll try to get per-CPU power measurements on this one.
>>> Interestingly ladder is a clear winner if anything, if that is reliable
>>> as a result that could indicate a too aggressive tick stop from the
>>> other governors, but cl isn't that much better than clv2 here, even
>>> though it stops the tick less aggressively.
>>
>> I agree with what you are saying.
>> It is a shorter test at only 25 minutes.
>> It might be worth trying the test again with more strict attention to
>> stabilizing the system thermally before each test.
>> The processor power will vary by a few watts for the exact same load
>> as a function of processor package temperature and coolant (my system is
>> water cooled) temperature and can take 20 to 30 minutes to settle.
>>
>> Reference:
>> http://smythies.com/~doug/linux/idle/teo-util3/temperature/thermal-stabalization-time.png
>>
>>>>
>>>> Further details:
>>>
>>> Link is missing, but I found
>>> http://smythies.com/~doug/linux/idle/teo-util3/ebizzy/
>>> from browsing your page.
>>
>> Yes, I accidently hit "Send" on my original email before it was actually finished.
>> But, then I was tired and thought "close enough".
>>
>>>> Test4: adrestia wakeup latency tests. 500 threads.
>>>>
>>>> Purpose: The test was reported in 2023.09 by the kernel test robot and looked
>>>> both interesting and gave interesting results, so I added it to the tests I run.
>>>
>>> http://smythies.com/~doug/linux/idle/teo-util3/adrestia/periodic/perf/
>>> So interestingly we can see, what I would call, the misbehavior of teo
>>> here, with teo skipping state2 and state3 entirely. You would expect
>>> a power regression here, but it doesn't translate into package power
>>> anyway.
>>>
>>>>
>>>> Results:
teo:wakeup cost (periodic, 20us): 3130nSec reference
clv2:wakeup cost (periodic, 20us): 3179nSec +1.57%
cl:wakeup cost (periodic, 20us): 3206nSec +2.43%
menu:wakeup cost (periodic, 20us): 2933nSec -6.29%
ladder:wakeup cost (periodic, 20us): 3530nSec +12.78%
no-util: wakeup cost (periodic, 20us): 3062nSec -2.17%

The really informative graph is this one:
http://smythies.com/~doug/linux/idle/teo-util3/adrestia/periodic/histogram-detail-a.png

Further details:
http://smythies.com/~doug/linux/idle/teo-util3/adrestia/periodic/histogram-detail-b.png
http://smythies.com/~doug/linux/idle/teo-util3/adrestia/periodic/perf/

>>>
>>> Is this measured as wakeup latency?
>>> I can't find much info about the test setup here, do you mind sharing
>>> something on it?
>>
>> I admit to being vague on this one, and I'll need some time to review.
>> The notes I left for myself last September are here:
>> http://smythies.com/~doug/linux/idle/teo-util2/adrestia/README.txt

Those notes have been updated but are still not very good.
There is bunch of system overhead in the "wakeup cost".

> 
> Thanks!
> 
>>
>>>> No strong conclusion here, from just the data.
>>>> However, clv2 seems to use a bit more processor power, on average.
>>>> teo: 69.72 watts
>>>> clv2: 72.91 watts +4.6%
>>>> Note 1: The first 5 minutes of the test powers were discarded to allow for thermal stabilization.
>>
>> which might not have been long enough, see the thermal notes above.
>>
>>>> Note 2: More work is required for this test, because the teo one actually took longer to execute, due to more outlier results
>> than the other tests.
>>
>>>> There were several other tests run but are not written up herein.
>>>>
>>> Because results are on par for all? Or inconclusive / not reproducible?
>>
>> Yes, because nothing of significance was observed or the test was more or less a repeat of an already covered test.
>> Initially, I had a mistake in my baseline teo tests, and a couple of the not written up tests have still not been re-run with the
>> proper baseline.
> 
> Thank you for testing, that's what I hoped.
> 
> Kind Regards,
> Christian

Results from a 6 core ping pong dwell test:

Note:	This is the same spot as the first data point from the above 6 core sweep test.
	It is important to note that the no-util results was not about +15% as above.

averages:

teo: 11.91786092 reference.
clv2: 12.94927586 +8.65%
cl: 12.89657797 +8.22%
menu: 11.85430331 -0.54%
ladder: 13.93532619 +17.08%
no-util: 11.93479453 +0.14%

Further details:
http://smythies.com/~doug/linux/idle/teo-util3/6-5000000-0/perf/

... Doug



