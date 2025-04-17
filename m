Return-Path: <linux-pm+bounces-25654-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40484A923D9
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 19:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D1B87AD262
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 17:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3EE255240;
	Thu, 17 Apr 2025 17:18:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25728254847;
	Thu, 17 Apr 2025 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910319; cv=none; b=nLdPOvIFsDLNqdMSUG2YJXNMZgihncDhe+Nc5LaIJaNpAbDI1tJe5h/tjv2nSROZs9YTJcPs/iGDc2c5xf9UZ0ToQZrw3nNGa02Al2gE6j003yU1X2KX2uZQjp+nMF9P+ZZeSlv4Uo8l26qhH1MJoK37AfjhwIrggZtw1CifFdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910319; c=relaxed/simple;
	bh=FUOnj3xOnDMsbedJ4HwYNfcITYuGluDV0KsX1xuZ3vI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eSmjNgzGFsK04YIGCBF60NapZdjrk21m11qHq8PEGKyBwYrIYSs3PvAeHDWtT51vg3mAm0att9Difv+rc1HlqbmWT1SfZeIb87iddb+G2PCpqAras4Yq0SDa6l2fJE/H/VpJPsNruJQhsBElXVF7McnrVf9Li8qotnoAm+Hp1uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DACA1515;
	Thu, 17 Apr 2025 10:18:33 -0700 (PDT)
Received: from [10.57.83.52] (unknown [10.57.83.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D63D93F59E;
	Thu, 17 Apr 2025 10:18:34 -0700 (PDT)
Message-ID: <b4835a2d-d855-403f-b3c1-c169faa1a9b4@arm.com>
Date: Thu, 17 Apr 2025 18:18:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] cpuidle: teo: Refine handling of short idle
 intervals
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Doug Smythies <dsmythies@telus.net>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
References: <4661520.LvFx2qVVIh@rjwysocki.net>
 <2239639.irdbgypaU6@rjwysocki.net>
 <1c0c6caa-e56c-454a-a976-81303dee1852@arm.com>
 <CAJZ5v0g-=DB_W5jkxxCERy22jz9a_V1Tcj8hiVwL6_R+xSM=gQ@mail.gmail.com>
 <76d5c5ba-6be0-405b-83dd-038f016af12b@arm.com>
 <CAJZ5v0hVRg0P+E1Ux9tOkr+g6wF36Bf52UT4f3BEAePMUM85Lw@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0hVRg0P+E1Ux9tOkr+g6wF36Bf52UT4f3BEAePMUM85Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/17/25 16:21, Rafael J. Wysocki wrote:
> On Thu, Apr 17, 2025 at 1:58 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 4/16/25 16:28, Rafael J. Wysocki wrote:
>>> On Wed, Apr 16, 2025 at 5:00 PM Christian Loehle
>>> <christian.loehle@arm.com> wrote:
>>>>
>>>> On 4/3/25 20:18, Rafael J. Wysocki wrote:
>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>
>>>>> Make teo take all recent wakeups (both timer and non-timer) into
>>>>> account when looking for a new candidate idle state in the cases
>>>>> when the majority of recent idle intervals are within the
>>>>> LATENCY_THRESHOLD_NS range or the latency limit is within the
>>>>> LATENCY_THRESHOLD_NS range.
>>>>>
>>>>> Since the tick_nohz_get_sleep_length() invocation is likely to be
>>>>> skipped in those cases, timer wakeups should arguably be taken into
>>>>> account somehow in case they are significant while the current code
>>>>> mostly looks at non-timer wakeups under the assumption that frequent
>>>>> timer wakeups are unlikely in the given idle duration range which
>>>>> may or may not be accurate.
>>>>>
>>>>> The most natural way to do that is to add the "hits" metric to the
>>>>> sums used during the new candidate idle state lookup which effectively
>>>>> means the above.
>>>>>
>>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>
>>>> Hi Rafael,
>>>> I might be missing something so bare with me.
>>>> Quoting the cover-letter too:
>>>> "In those cases, timer wakeups are not taken into account when they are
>>>> within the LATENCY_THRESHOLD_NS range and the idle state selection may
>>>> be based entirely on non-timer wakeups which may be rare.  This causes
>>>> the prediction accuracy to be low and too much energy may be used as
>>>> a result.
>>>>
>>>> The first patch is preparatory and it is not expected to make any
>>>> functional difference.
>>>>
>>>> The second patch causes teo to take timer wakeups into account if it
>>>> is about to skip the tick_nohz_get_sleep_length() invocation, so they
>>>> get a chance to influence the idle state selection."
>>>>
>>>> If the timer wakeups are < LATENCY_THRESHOLD_NS we will not do
>>>>
>>>> cpu_data->sleep_length_ns = tick_nohz_get_sleep_length(&delta_tick);
>>>>
>>>> but
>>>>
>>>> cpu_data->sleep_length_ns = KTIME_MAX;
>>>>
>>>> therefore
>>>> idx_timer = drv->state_count - 1
>>>> idx_duration = some state with residency < LATENCY_THRESHOLD_NS
>>>>
>>>> For any reasonable system therefore idx_timer != idx_duration
>>>> (i.e. there's an idle state deeper than LATENCY_THRESHOLD_NS).
>>>> So hits will never be incremented?
>>>
>>> Why never?
>>>
>>> First of all, you need to get into the "2 * cpu_data->short_idles >=
>>> cpu_data->total" case somehow and this may be through timer wakeups.
>>
>> Okay, maybe I had a too static scenario in mind here.
>> Let me think it through one more time.
> 
> Well, this is subtle and your question is actually a good one.
> 
>>>
>>>> How would adding hits then help this case?
>>>
>>> They may be dominant when this condition triggers for the first time.
>>
>> I see.
>>
>> Anything in particular this would help a lot with?
> 
> So I've been trying to reproduce my own results using essentially the
> linux-next branch of mine (6.15-rc2 with some material on top) as the
> baseline and so far I've been unable to do that.  There's no
> significant difference from these patches or at least they don't help
> as much as I thought they would.
> 
>> There's no noticeable behavior change in my usual tests, which is
>> expected, given we have only WFI in LATENCY_THRESHOLD_NS.
>>
>> I did fake a WFI2 with residency=5 latency=1, teo-m is mainline, teo
>> is with series applied:
>>
>> device   gov    iter   iops    idles     idle_misses  idle_miss_ratio  belows   aboves   WFI       WFI2
>> -------  -----  -----  ------  --------  ------------  ----------------  --------  -------  --------  --------
>> nvme0n1  teo    0      80223   8601862   1079609       0.126             918363    161246   205096    4080894
>> nvme0n1  teo    1      78522   8488322   1054171       0.124             890420    163751   208664    4020130
>> nvme0n1  teo    2      77901   8375258   1031275       0.123             878083    153192   194500    3977655
>> nvme0n1  teo    3      77517   8344681   1023423       0.123             869548    153875   195262    3961675
>> nvme0n1  teo    4      77934   8356760   1027556       0.123             876438    151118   191848    3971578
>> nvme0n1  teo    5      77864   8371566   1033686       0.123             877745    155941   197903    3972844
>> nvme0n1  teo    6      78057   8417326   1040512       0.124             881420    159092   201922    3991785
>> nvme0n1  teo    7      78214   8490292   1050379       0.124             884528    165851   210860    4019102
>> nvme0n1  teo    8      78100   8357664   1034487       0.124             882781    151706   192728    3971505
>> nvme0n1  teo    9      76895   8316098   1014695       0.122             861950    152745   193680    3948573
>> nvme0n1  teo-m  0      76729   8261670   1032158       0.125             845247    186911   237147    3877992
>> nvme0n1  teo-m  1      77763   8344526   1053266       0.126             867094    186172   237526    3919320
>> nvme0n1  teo-m  2      76717   8285070   1034706       0.125             848385    186321   236956    3889534
>> nvme0n1  teo-m  3      76920   8270834   1030223       0.125             847490    182733   232081    3887525
>> nvme0n1  teo-m  4      77198   8329578   1044724       0.125             855438    189286   240947    3908194
>> nvme0n1  teo-m  5      77361   8338772   1046903       0.126             857291    189612   241577    3912576
>> nvme0n1  teo-m  6      76827   8346204   1037520       0.124             846008    191512   243167    3914194
>> nvme0n1  teo-m  7      77931   8367212   1053337       0.126             866549    186788   237852    3930510
>> nvme0n1  teo-m  8      77870   8358306   1056011       0.126             867167    188844   240602    3923417
>> nvme0n1  teo-m  9      77405   8338356   1046012       0.125             856605    189407   240694    3913012
>>
>> The difference is small, but it's there even though this isn't
>> a timer-heavy workload at all.
> 
> This is interesting, so thanks for doing it, but the goal really was
> to help with the polling state usage on x86 and that doesn't appear to
> be happening, so I'm going to drop these patches at least for now.

Alright, well my testing on x86 is limited, but I assume you are
referring to systems were we do have
state0 latency=0 residency=0 polling
state1 latency=1 residency=1
in theory teo shouldn't be super aggressive on state0 then with the
intercept logic, unless the idle durations are recorded as <1us.
I wonder what goes wrong, any traces or workloads you recommend looking
at?

