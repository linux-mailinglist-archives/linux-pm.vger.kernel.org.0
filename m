Return-Path: <linux-pm+bounces-37503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07874C3A7B3
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 12:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8138B34BDC0
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 11:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754832EDD5F;
	Thu,  6 Nov 2025 11:13:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAEB3074B1
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 11:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427593; cv=none; b=jZu3ETyH/d3POUobH23NvA+tqOiZC5C5ajI3CXTWBfn069YP81Y3iwgMQEdUcBRK9vSUWmgQuE7sjqThvNxTrUAiF7WYI6R642qnLdKInzMCXjSZrwNi7WnAFXIGnTWMtEAp6vMvzB7PxZXLL/P1jNHB8ekp7CLTAgCDrkGpjbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427593; c=relaxed/simple;
	bh=SzCSS56vB8/bzF8mya6d920cNSvBzOQEFAsgjKM1HtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmafC9UamFu3Xg1kiRG5l1bghDSG8LA4lV8OuTi3P+Pyq1zFlxDPBGyrWj1grsaeTiNLvpckDLW98/uLxzGsCd+cj6aqy+jTmXWiZbU+X2TV0sUWtkyRSVSkLUv2++y+BWnxU9JmCvUERdH+7igEMY34dMrR1CCfl1DYZk47XMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24ED01596;
	Thu,  6 Nov 2025 03:13:03 -0800 (PST)
Received: from [10.1.28.78] (e127648.arm.com [10.1.28.78])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 254983F63F;
	Thu,  6 Nov 2025 03:13:10 -0800 (PST)
Message-ID: <b910a35c-83aa-4050-9c6c-de40f13a2a55@arm.com>
Date: Thu, 6 Nov 2025 11:13:07 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression in TEO cpuidle governor between 6.6 and 6.12
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Reka Norman <rekanorman@chromium.org>, daniel.lezcano@linaro.org,
 linux-pm@vger.kernel.org
References: <CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com>
 <a50064b2-e6aa-4237-a715-12f21a65e9a6@arm.com>
 <ed1e64dc-91c9-44d9-b3d3-9f142bcf7a8d@arm.com>
 <CAJZ5v0g9Jndez5y5i4pPW1C+qfj=4iiu51HV7Eb1dBGd1jg-CA@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0g9Jndez5y5i4pPW1C+qfj=4iiu51HV7Eb1dBGd1jg-CA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/5/25 20:48, Rafael J. Wysocki wrote:
> On Wed, Nov 5, 2025 at 12:24 AM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 11/4/25 09:03, Christian Loehle wrote:
>>> On 11/4/25 03:36, Reka Norman wrote:
>>>> Hi,
>>>>
>>>> I’m seeing a regression in the TEO governor between 6.6 and 6.12. At
>>>> 6.12, when the system is idle it’s spending almost 100% of time in
>>>> WFI, compared to about 6% at 6.6. At mainline it has improved compared
>>>> to 6.12 but is still a lot worse than 6.6, spending about 50% in WFI.
>>>>
>>>> The system is a ChromeOS device with Mediatek MT8196.
>>>>
>>>> Bisecting showed the specific commit which caused the regression is:
>>>> 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts")
>>>>
>>>> I’ve attached sysfs dumps showing the issue. All were taken a couple
>>>> of minutes after boot, with the device having been idle since boot.
>>>> The cases tested are:
>>>> cpuidle_6_6.txt      = 6.6 kernel
>>>> cpuidle_6_12.txt     = 6.6 kernel with teo commits up to 6.12
>>>> cpuidle_mainline.txt = 6.6 kernel with teo commits up to mainline
>>>>
>>>> Summary of the percentage time spent in each state (averaged across CPUs):
>>>>
>>>> |            |   6.6 |  6.12 | mainline |
>>>> |------------|------:|------:|---------:|
>>>> | WFI        |  6.02 | 99.94 |    56.84 |
>>>> | cpuoff     | 11.02 |     0 |     0.65 |
>>>> | clusteroff | 82.96 |  0.05 |    42.51 |
>>>> | s2idle     |     0 |     0 |        0 |
>>>>
>>>> Any help would be much appreciated. Let me know if there's any other
>>>> debugging information I should provide.
>>>>
>>>
>>> That's not good.
>>> If the system is mostly idle (only boot activity but dumps are taken after
>>> ~3mins?), what is causing the wakeups? Even in 6.6 There are definitely more
>>> than I would've expected?
>>> I noticed that clusteroff and cpuoff have equal residency, which is
>>> obviously a bit awkward for cpuidle, but shouldn't be relevant to your issue.
>>>
>>> I'm a bit puzzled by your bisect results.
>>> 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts")
>>> made the intercept logic *less* prone to count (false) intercepts, yet it
>>> seems to count more of them? (resulting in more WFI).
>>> I'll think about it some more, for now of course a trace would be very
>>> helpful. (cpuidle events, ipi_raise, irqs?)
>>> Are there ever any latency constraints set?
>>>
>>> FWIW the mainline results look the most reasonable, from a 30000 feet view
>>> anyway:
>>> Cluster       State           above   below   usage   above%  below%
>>> LITTLE        cpuoff-l        ~75     ~65     ~140    23%     20%
>>> LITTLE        clusteroff-l    ~800    0       ~100    89%     0%
>>> MID   cpuoff-m        ~3–4    ~15     ~20     15%     55%
>>> MID   clusteroff-m    ~1300   0       ~4000   24%     0%
>>> BIG   cpuoff-b        0       1       1       —       —
>>> BIG   clusteroff-b    ~800    0       ~1900   30%     0%
>>>
>>> (WFI seems mostly the correct choice for little CPUs, that's fine, the energy
>>> savings compared to cpuoff should be marginal anyway.)
>>>
>>> Do you mind trying:
>>> 13ed5c4a6d9c cpuidle: teo: Skip getting the sleep length if wakeups are very frequent
>>> on 6.12?
>>>
>>
>> So just thinking out loud, the only case I can actually thing of to explain your
>> bisect to 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts")
>> is that the workload essentially changed dramatically because of our calls
>> to tick_nohz_get_sleep_length() now.
>> I'm not sure how likely I think that is, but I'm lacking imagination for another
>> cause. That's why results with
>> 13ed5c4a6d9c ("cpuidle: teo: Skip getting the sleep length if wakeups are very frequent")
>> would be interesting.
> 
> My current theory is that this issue is related to the
> tick_nohz_get_sleep_length() overhead and the way "intercepts" are
> distinguished from "hits" in teo.
> 
> Namely, teo assumes that its own overhead is negligible and so it
> counts a given event as an "intercept" if the measured time spent in
> the idle state (with the exit latency roughly taken into account)
> falls into a different "state bin" than the sleep length (the expected
> time till the next timer).  However, the sleep length is computed as a
> difference between the upcoming timer wakeup event time and
> ts->idle_entrytime, so it actually includes the time taken by
> tick_nohz_next_event().  If the latter is significant, it may
> contribute to the difference seen by teo_update() and cause extra
> "intercepts" to appear.

Right, additionally with psci pc-mode and the exposed clusteroff states we end
up vastly exaggerating the wakeup latency (i.e. underestimating the actual idle time)
for three reasons:
- wakeup latency = entry+exit latency (worst case: pay full latencies on both
even though for most cases we don't incur the entry latency)
- Wakeup latency is a worst-case and often is more like 2x-3x of the average.
- We use the (higher) clusteroff values even though the clusteroff state couldn't
possibly have been entered as not the entire cluster is idle.

Nonetheless these are all just a "intercept counting is significantly more likely"
while the results show not a single state >0 entered => the intercept logic
probably triggers every cpuidle entry. Feels like there should be an issue in the
feedback loop.
Anyway I'll try to reproduce what Reka is seeing.

