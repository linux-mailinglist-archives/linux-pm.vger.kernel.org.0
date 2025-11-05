Return-Path: <linux-pm+bounces-37486-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A98C38431
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 23:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D62188B735
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 22:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4E82D2384;
	Wed,  5 Nov 2025 22:47:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651C62D2388
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 22:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382832; cv=none; b=CKkm8YlWzXGsY+3wshRvQFdQU4PjfmNe2wZp2cPVu8OTHpVEWEUWL+CpCSgi2MvEX4C7sUS/l9tZ9JN8OOu0Y0jFEFoILuAAZ6IVY+glJfPNkD/MaGFdYvaE2efukeUpy0uHw8TX1Mjgzi6GOgEHyjDzXZyW+6itvNoZ2om9Y+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382832; c=relaxed/simple;
	bh=DgCD0OVTtpsSjIeV8NtURJNsG31oTeDMN3spExQOo+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4EBuBxQjEPJWSFQabqSObnzXDbXFBVao8RXHHCbvRGEXnDtvjJBxBok8Icg3Dl8VyaENFKApCu0M+dF2OVhWELEw+O2xPGbV8MI8i+i1T6src/e+BE10y/icJfj20VpGRa4ci0y+ws1UIuf95uEAF/t3YNLHt+tQEs2FCPjoOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B49181655;
	Wed,  5 Nov 2025 14:47:00 -0800 (PST)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96B3B3F694;
	Wed,  5 Nov 2025 14:47:07 -0800 (PST)
Message-ID: <e2266a73-6672-41ef-bdb7-c1d6c49acd46@arm.com>
Date: Wed, 5 Nov 2025 22:47:01 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression in TEO cpuidle governor between 6.6 and 6.12
To: Reka Norman <rekanorman@chromium.org>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
References: <CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com>
 <a50064b2-e6aa-4237-a715-12f21a65e9a6@arm.com>
 <ed1e64dc-91c9-44d9-b3d3-9f142bcf7a8d@arm.com>
 <CAEmPcwtM_K68cmgXftH7vm1S1N+8u7PA80cp10Ddo74sMCULCA@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAEmPcwtM_K68cmgXftH7vm1S1N+8u7PA80cp10Ddo74sMCULCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/5/25 06:22, Reka Norman wrote:
> On Wed, Nov 5, 2025 at 10:24 AM Christian Loehle
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
> 
> Sorry, I just realised those dumps were taken at the login screen,
> which is doing some animation. The new data is all from the home
> screen, which should be more idle. I also attached before and after
> dumps to eliminate boot activity. Now it’s more like 2% WFI at 6.6.
> 
>>> I noticed that clusteroff and cpuoff have equal residency, which is
>>> obviously a bit awkward for cpuidle, but shouldn't be relevant to your issue.
>>>
>>> I'm a bit puzzled by your bisect results.
>>> 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts")
>>> made the intercept logic *less* prone to count (false) intercepts, yet it
>>> seems to count more of them? (resulting in more WFI).
>>> I'll think about it some more, for now of course a trace would be very
>>> helpful. (cpuidle events, ipi_raise, irqs?)
> 
> Traces attached.
> 
>>> Are there ever any latency constraints set?
> 
> Could you explain how I can tell? (I can’t see anything in our
> codebase obviously setting cpu_dma_latency or
> pm_qos_resume_latency_us, but I’m guessing that’s not conclusive.)
> 
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
> I'm not completely sure whether I resolved the conflicts correctly. So
> if anything seems off about the results, would you mind sharing a
> ported patch I can try?
> 
> I've attached sysfs dumps and traces for 6.6, 6.12 and mainline as
> before (which should be more idle this time), as well as:
> 6_12_patch            = 6.12 with 13ed5c4a6d9c “cpuidle: teo: Skip
> getting the sleep length if wakeups are very frequent”
> 6_12_no_intercept     = 6.12 with intercept logic removed
> mainline_no_intercept = mainline with intercept logic removed

I wanted to send the below out now, I'm not quite done looking through the traces yet, sorry!
The system is running 100HZ tick, 6.12 never seems to turn the tick off. The majority of the wakeups
are just ticks, not 'intercepts' though.
Without the intersect logic everything is fine, teo selects deep idle states very liberally, so we
don't have any weird timer effects (wakeups then are not too common and are the EC SPI irq and
scheduler IPIs, nothing super unexpected).

I'll work through the code and traces again tomorrow with Rafael's notes in mind.

Anyway, here's the more legible deltas of Reka's sysfs dumps for reference:

tail -n 36 sysfs_mainline_delta.txt

Per-Cluster deltas: BIG
+---------+-------+--------------+------------+---------+--------+--------+---------+--------+---------+
| cluster | state | name         | timeΔ      | time%   | usageΔ | aboveΔ | above%  | belowΔ | below%  |
+=========+=======+==============+============+=========+========+========+=========+========+=========+
| BIG     |     0 | WFI          | 3,436,031  |  10.56% | 5,017  | 0      |   0.00% | 0      |   0.00% |
| BIG     |     1 | cpuoff-b     | 17,909     |   0.06% | 19     | 17     |  89.47% | 2      |  10.53% |
| BIG     |     2 | clusteroff-b | 29,096,755 |  89.39% | 430    | 95     |  22.09% | 0      |   0.00% |
| BIG     |     3 | s2idle       | 0          |   0.00% | 0      | 0      |   0.00% | 0      |   0.00% |
| BIG     | TOTAL |              | 32,550,695 | 100.00% | 5,466  | 112    |   2.05% | 2      |   0.04% |
+---------+-------+--------------+------------+---------+--------+--------+---------+--------+---------+

Per-Cluster deltas: LITTLE
+---------+-------+--------------+-------------+---------+--------+--------+---------+--------+---------+
| cluster | state | name         | timeΔ       | time%   | usageΔ | aboveΔ | above%  | belowΔ | below%  |
+=========+=======+==============+=============+=========+========+========+=========+========+=========+
| LITTLE  |     0 | WFI          | 40,105,707  |  31.15% | 50,366 | 0      |   0.00% | 0      |   0.00% |
| LITTLE  |     1 | cpuoff-l     | 5,057,879   |   3.93% | 143    | 43     |  30.07% | 99     |  69.23% |
| LITTLE  |     2 | clusteroff-l | 83,572,753  |  64.92% | 1,485  | 398    |  26.80% | 0      |   0.00% |
| LITTLE  |     3 | s2idle       | 0           |   0.00% | 0      | 0      |   0.00% | 0      |   0.00% |
| LITTLE  | TOTAL |              | 128,736,339 | 100.00% | 51,994 | 441    |   0.85% | 99     |   0.19% |
+---------+-------+--------------+-------------+---------+--------+--------+---------+--------+---------+

Per-Cluster deltas: MID
+---------+-------+--------------+------------+---------+--------+--------+---------+--------+---------+
| cluster | state | name         | timeΔ      | time%   | usageΔ | aboveΔ | above%  | belowΔ | below%  |
+=========+=======+==============+============+=========+========+========+=========+========+=========+
| MID     |     0 | WFI          | 8,504,484  |   8.79% | 13,025 | 0      |   0.00% | 0      |   0.00% |
| MID     |     1 | cpuoff-m     | 269,514    |   0.28% | 34     | 26     |  76.47% | 8      |  23.53% |
| MID     |     2 | clusteroff-m | 88,003,266 |  90.93% | 533    | 170    |  31.89% | 0      |   0.00% |
| MID     |     3 | s2idle       | 0          |   0.00% | 0      | 0      |   0.00% | 0      |   0.00% |
| MID     | TOTAL |              | 96,777,264 | 100.00% | 13,592 | 196    |   1.44% | 8      |   0.06% |
+---------+-------+--------------+------------+---------+--------+--------+---------+--------+---------+

tail -n 36 sysfs_6_12_delta.txt 

Per-Cluster deltas: BIG
+---------+-------+--------------+------------+---------+--------+--------+---------+--------+---------+
| cluster | state | name         | timeΔ      | time%   | usageΔ | aboveΔ | above%  | belowΔ | below%  |
+=========+=======+==============+============+=========+========+========+=========+========+=========+
| BIG     |     0 | WFI          | 32,360,953 | 100.00% | 34,172 | 0      |   0.00% | 0      |   0.00% |
| BIG     |     1 | cpuoff-b     | 0          |   0.00% | 0      | 0      |   0.00% | 0      |   0.00% |
| BIG     |     2 | clusteroff-b | 0          |   0.00% | 0      | 0      |   0.00% | 0      |   0.00% |
| BIG     |     3 | s2idle       | 0          |   0.00% | 0      | 0      |   0.00% | 0      |   0.00% |
| BIG     | TOTAL |              | 32,360,953 | 100.00% | 34,172 | 0      |   0.00% | 0      |   0.00% |
+---------+-------+--------------+------------+---------+--------+--------+---------+--------+---------+

Per-Cluster deltas: LITTLE
+---------+-------+--------------+-------------+---------+---------+--------+---------+--------+---------+
| cluster | state | name         | timeΔ       | time%   | usageΔ  | aboveΔ | above%  | belowΔ | below%  |
+=========+=======+==============+=============+=========+=========+========+=========+========+=========+
| LITTLE  |     0 | WFI          | 127,519,860 | 100.00% | 140,096 | 0      |   0.00% | 0      |   0.00% |
| LITTLE  |     1 | cpuoff-l     | 0           |   0.00% | 0       | 0      |   0.00% | 0      |   0.00% |
| LITTLE  |     2 | clusteroff-l | 0           |   0.00% | 0       | 0      |   0.00% | 0      |   0.00% |
| LITTLE  |     3 | s2idle       | 0           |   0.00% | 0       | 0      |   0.00% | 0      |   0.00% |
| LITTLE  | TOTAL |              | 127,519,860 | 100.00% | 140,096 | 0      |   0.00% | 0      |   0.00% |
+---------+-------+--------------+-------------+---------+---------+--------+---------+--------+---------+

Per-Cluster deltas: MID
+---------+-------+--------------+------------+---------+---------+--------+---------+--------+---------+
| cluster | state | name         | timeΔ      | time%   | usageΔ  | aboveΔ | above%  | belowΔ | below%  |
+=========+=======+==============+============+=========+=========+========+=========+========+=========+
| MID     |     0 | WFI          | 96,928,022 | 100.00% | 102,629 | 0      |   0.00% | 0      |   0.00% |
| MID     |     1 | cpuoff-m     | 0          |   0.00% | 0       | 0      |   0.00% | 0      |   0.00% |
| MID     |     2 | clusteroff-m | 0          |   0.00% | 0       | 0      |   0.00% | 0      |   0.00% |
| MID     |     3 | s2idle       | 0          |   0.00% | 0       | 0      |   0.00% | 0      |   0.00% |
| MID     | TOTAL |              | 96,928,022 | 100.00% | 102,629 | 0      |   0.00% | 0      |   0.00% |
+---------+-------+--------------+------------+---------+---------+--------+---------+--------+---------+

tail -n 36 sysfs_6_6_delta.txt 

Per-Cluster deltas: BIG
+---------+-------+--------------+------------+---------+--------+--------+---------+--------+---------+
| cluster | state | name         | timeΔ      | time%   | usageΔ | aboveΔ | above%  | belowΔ | below%  |
+=========+=======+==============+============+=========+========+========+=========+========+=========+
| BIG     |     0 | WFI          | 376,034    |   1.17% | 1,368  | 0      |   0.00% | 0      |   0.00% |
| BIG     |     1 | cpuoff-b     | 2,679,129  |   8.33% | 82     | 42     |  51.22% | 40     |  48.78% |
| BIG     |     2 | clusteroff-b | 29,124,994 |  90.51% | 415    | 99     |  23.86% | 0      |   0.00% |
| BIG     |     3 | s2idle       | 0          |   0.00% | 0      | 0      |   0.00% | 0      |   0.00% |
| BIG     | TOTAL |              | 32,180,157 | 100.00% | 1,865  | 141    |   7.56% | 40     |   2.14% |
+---------+-------+--------------+------------+---------+--------+--------+---------+--------+---------+

Per-Cluster deltas: LITTLE
+---------+-------+--------------+-------------+---------+--------+--------+---------+--------+---------+
| cluster | state | name         | timeΔ       | time%   | usageΔ | aboveΔ | above%  | belowΔ | below%  |
+=========+=======+==============+=============+=========+========+========+=========+========+=========+
| LITTLE  |     0 | WFI          | 3,902,851   |   3.04% | 10,026 | 0      |   0.00% | 0      |   0.00% |
| LITTLE  |     1 | cpuoff-l     | 11,604,484  |   9.05% | 715    | 383    |  53.57% | 329    |  46.01% |
| LITTLE  |     2 | clusteroff-l | 112,706,855 |  87.91% | 3,479  | 1,454  |  41.79% | 0      |   0.00% |
| LITTLE  |     3 | s2idle       | 0           |   0.00% | 0      | 0      |   0.00% | 0      |   0.00% |
| LITTLE  | TOTAL |              | 128,214,190 | 100.00% | 14,220 | 1,837  |  12.92% | 329    |   2.31% |
+---------+-------+--------------+-------------+---------+--------+--------+---------+--------+---------+

Per-Cluster deltas: MID
+---------+-------+--------------+------------+---------+--------+--------+---------+--------+---------+
| cluster | state | name         | timeΔ      | time%   | usageΔ | aboveΔ | above%  | belowΔ | below%  |
+=========+=======+==============+============+=========+========+========+=========+========+=========+
| MID     |     0 | WFI          | 865,879    |   0.90% | 3,683  | 0      |   0.00% | 0      |   0.00% |
| MID     |     1 | cpuoff-m     | 9,721,676  |  10.13% | 168    | 82     |  48.81% | 84     |  50.00% |
| MID     |     2 | clusteroff-m | 85,388,410 |  88.97% | 599    | 223    |  37.23% | 0      |   0.00% |
| MID     |     3 | s2idle       | 0          |   0.00% | 0      | 0      |   0.00% | 0      |   0.00% |
| MID     | TOTAL |              | 95,975,965 | 100.00% | 4,450  | 305    |   6.85% | 84     |   1.89% |
+---------+-------+--------------+------------+---------+--------+--------+---------+--------+---------+

tail -n 36 sysfs_6_12_no_intercept_delta.txt

Per-Cluster deltas: BIG
+---------+-------+--------------+------------+---------+--------+--------+---------+--------+---------+
| cluster | state | name         | timeΔ      | time%   | usageΔ | aboveΔ | above%  | belowΔ | below%  |
+=========+=======+==============+============+=========+========+========+=========+========+=========+
| BIG     |     0 | WFI          | 20,413     |   0.06% | 47     | 0      |   0.00% | 0      |   0.00% |
| BIG     |     1 | cpuoff-b     | 0          |   0.00% | 0      | 0      |   0.00% | 0      |   0.00% |
| BIG     |     2 | clusteroff-b | 32,539,251 |  99.94% | 595    | 400    |  67.23% | 0      |   0.00% |
| BIG     |     3 | s2idle       | 0          |   0.00% | 0      | 0      |   0.00% | 0      |   0.00% |
| BIG     | TOTAL |              | 32,559,664 | 100.00% | 642    | 400    |  62.31% | 0      |   0.00% |
+---------+-------+--------------+------------+---------+--------+--------+---------+--------+---------+

Per-Cluster deltas: LITTLE
+---------+-------+--------------+-------------+---------+--------+--------+---------+--------+---------+
| cluster | state | name         | timeΔ       | time%   | usageΔ | aboveΔ | above%  | belowΔ | below%  |
+=========+=======+==============+=============+=========+========+========+=========+========+=========+
| LITTLE  |     0 | WFI          | 1,646,664   |   1.27% | 1,141  | 0      |   0.00% | 0      |   0.00% |
| LITTLE  |     1 | cpuoff-l     | 0           |   0.00% | 0      | 0      |   0.00% | 0      |   0.00% |
| LITTLE  |     2 | clusteroff-l | 127,644,359 |  98.73% | 6,531  | 4,246  |  65.01% | 0      |   0.00% |
| LITTLE  |     3 | s2idle       | 0           |   0.00% | 0      | 0      |   0.00% | 0      |   0.00% |
| LITTLE  | TOTAL |              | 129,291,023 | 100.00% | 7,672  | 4,246  |  55.34% | 0      |   0.00% |
+---------+-------+--------------+-------------+---------+--------+--------+---------+--------+---------+

Per-Cluster deltas: MID
+---------+-------+--------------+------------+---------+--------+--------+---------+--------+---------+
| cluster | state | name         | timeΔ      | time%   | usageΔ | aboveΔ | above%  | belowΔ | below%  |
+=========+=======+==============+============+=========+========+========+=========+========+=========+
| MID     |     0 | WFI          | 90,610     |   0.09% | 245    | 0      |   0.00% | 0      |   0.00% |
| MID     |     1 | cpuoff-m     | 0          |   0.00% | 0      | 0      |   0.00% | 0      |   0.00% |
| MID     |     2 | clusteroff-m | 97,538,839 |  99.91% | 1,796  | 1,400  |  77.95% | 0      |   0.00% |
| MID     |     3 | s2idle       | 0          |   0.00% | 0      | 0      |   0.00% | 0      |   0.00% |
| MID     | TOTAL |              | 97,629,449 | 100.00% | 2,041  | 1,400  |  68.59% | 0      |   0.00% |
+---------+-------+--------------+------------+---------+--------+--------+---------+--------+---------+

tail -n 36 sysfs_6_12_patch_delta.txt       

Per-Cluster deltas: BIG
+---------+-------+--------------+------------+---------+--------+--------+---------+--------+---------+
| cluster | state | name         | timeΔ      | time%   | usageΔ | aboveΔ | above%  | belowΔ | below%  |
+=========+=======+==============+============+=========+========+========+=========+========+=========+
| BIG     |     0 | WFI          | 282,136    |   0.88% | 1,335  | 0      |   0.00% | 0      |   0.00% |
| BIG     |     1 | cpuoff-b     | 107,697    |   0.34% | 18     | 17     |  94.44% | 1      |   5.56% |
| BIG     |     2 | clusteroff-b | 31,736,205 |  98.79% | 290    | 95     |  32.76% | 0      |   0.00% |
| BIG     |     3 | s2idle       | 0          |   0.00% | 0      | 0      |   0.00% | 0      |   0.00% |
| BIG     | TOTAL |              | 32,126,038 | 100.00% | 1,643  | 112    |   6.82% | 1      |   0.06% |
+---------+-------+--------------+------------+---------+--------+--------+---------+--------+---------+

Per-Cluster deltas: LITTLE
+---------+-------+--------------+-------------+---------+--------+--------+---------+--------+---------+
| cluster | state | name         | timeΔ       | time%   | usageΔ | aboveΔ | above%  | belowΔ | below%  |
+=========+=======+==============+=============+=========+========+========+=========+========+=========+
| LITTLE  |     0 | WFI          | 3,194,027   |   2.47% | 7,873  | 0      |   0.00% | 0      |   0.00% |
| LITTLE  |     1 | cpuoff-l     | 6,906,772   |   5.34% | 373    | 132    |  35.39% | 238    |  63.81% |
| LITTLE  |     2 | clusteroff-l | 119,219,490 |  92.19% | 3,373  | 1,523  |  45.15% | 0      |   0.00% |
| LITTLE  |     3 | s2idle       | 0           |   0.00% | 0      | 0      |   0.00% | 0      |   0.00% |
| LITTLE  | TOTAL |              | 129,320,289 | 100.00% | 11,619 | 1,655  |  14.24% | 238    |   2.05% |
+---------+-------+--------------+-------------+---------+--------+--------+---------+--------+---------+

Per-Cluster deltas: MID
+---------+-------+--------------+------------+---------+--------+--------+---------+--------+---------+
| cluster | state | name         | timeΔ      | time%   | usageΔ | aboveΔ | above%  | belowΔ | below%  |
+=========+=======+==============+============+=========+========+========+=========+========+=========+
| MID     |     0 | WFI          | 762,336    |   0.78% | 4,049  | 0      |   0.00% | 0      |   0.00% |
| MID     |     1 | cpuoff-m     | 561,208    |   0.57% | 52     | 49     |  94.23% | 3      |   5.77% |
| MID     |     2 | clusteroff-m | 96,442,021 |  98.65% | 738    | 249    |  33.74% | 0      |   0.00% |
| MID     |     3 | s2idle       | 0          |   0.00% | 0      | 0      |   0.00% | 0      |   0.00% |
| MID     | TOTAL |              | 97,765,565 | 100.00% | 4,839  | 298    |   6.16% | 3      |   0.06% |
+---------+-------+--------------+------------+---------+--------+--------+---------+--------+---------+

