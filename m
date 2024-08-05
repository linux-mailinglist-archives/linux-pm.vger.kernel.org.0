Return-Path: <linux-pm+bounces-11919-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C74C4947D43
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 16:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2607FB22C0E
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 14:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FAF13BC2F;
	Mon,  5 Aug 2024 14:53:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB34F5381A;
	Mon,  5 Aug 2024 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869623; cv=none; b=g3ORmvHFT8rn4RmWTHa+KsQpms2xTzt2RzwTus+oX4wO2XfzdsMl5zUxNyevawvgytdUJ5Ov8KWjst3DPbdfbGXGx5sDVD8Q8b7eYlTs1b1OTIFnr9kYixjUvKzocs/5eA3H8+W0A3PtM15d0hDodqHqbKsKBuSmyxqO7Qk5UyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869623; c=relaxed/simple;
	bh=eREV0LKC5JVcgY8+dgImoYFZMUcqU5b2QqWhK7QnD9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RWPbfrpYz2Z/FLsBIoYrzkWJfynXs4yi1zqs1gSxBFgUhzVPEqXb5yfYYs5eIHPXIst2zICxgbeDYcWI9TBJVpXhW/AsxY9IuOvzcuPFANT0kWhBYAfnDTcIcKHE00eGA108A6wLmWPJeIW1vMvPgDptuzzHF9C4uaZoaQWARro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68615106F;
	Mon,  5 Aug 2024 07:54:06 -0700 (PDT)
Received: from [10.1.25.54] (e127648.arm.com [10.1.25.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D92C53F6A8;
	Mon,  5 Aug 2024 07:53:37 -0700 (PDT)
Message-ID: <9bbf6989-f41f-4533-a7c8-b274744663cd@arm.com>
Date: Mon, 5 Aug 2024 15:53:35 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 0/3] cpuidle: teo: Fixing utilization and intercept
 logic
To: "Rafael J. Wysocki" <rafael@kernel.org>, stable@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 vincent.guittot@linaro.org, qyousef@layalina.io, peterz@infradead.org,
 daniel.lezcano@linaro.org, ulf.hansson@linaro.org, anna-maria@linutronix.de,
 dsmythies@telus.net, kajetan.puchalski@arm.com, lukasz.luba@arm.com,
 dietmar.eggemann@arm.com
References: <20240628095955.34096-1-christian.loehle@arm.com>
 <CAJZ5v0jPyy0HgtQcSt=7ZO-khSGex2uAxL1x6HZFkFbvpbxcmA@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0jPyy0HgtQcSt=7ZO-khSGex2uAxL1x6HZFkFbvpbxcmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/28/24 20:06, Rafael J. Wysocki wrote:
> On Fri, Jun 28, 2024 at 12:02 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> Hi all,
>> so my investigation into teo lead to the following fixes.
>>
>> 1/3:
>> As discussed the utilization threshold is too high while
>> there are benefits in certain workloads, there are quite a few
>> regressions, too. Revert the Util-awareness patch.
>> This in itself leads to regressions, but part of it can be offset
>> by the later patches.
>> See
>> https://lore.kernel.org/lkml/CAKfTPtA6ZzRR-zMN7sodOW+N_P+GqwNv4tGR+aMB5VXRT2b5bg@mail.gmail.com/
>> 2/3:
>> Remove the 'recent' intercept logic, see my findings in:
>> https://lore.kernel.org/lkml/0ce2d536-1125-4df8-9a5b-0d5e389cd8af@arm.com/
>> I haven't found a way to salvage this properly, so I removed it.
>> The regular intercept seems to decay fast enough to not need this, but
>> we could change it if that turns out that we need this to be faster in
>> ramp-up and decaying.
>> 3/3:
>> The rest of the intercept logic had issues, too.
>> See the commit.
>>
>> Happy for anyone to take a look and test as well.
>>
>> Some numbers for context, comparing:
>> - IO workload (intercept heavy).
>> - Timer workload very low utilization (check for deepest state)
>> - hackbench (high utilization)
>> - Geekbench 5 on Pixel6 (high utilization)
>> Tests 1 to 3 are on RK3399 with CONFIG_HZ=100.
>> target_residencies: 1, 900, 2000
>>
>> 1. IO workload, 5 runs, results sorted, in read IOPS.
>> fio --minimal --time_based --name=fiotest --filename=/dev/nvme0n1 --runtime=30 --rw=randread --bs=4k --ioengine=psync --iodepth=1 --direct=1 | cut -d \; -f 8;
>>
>> teo fixed v2:
>> /dev/nvme0n1
>> [4599, 4658, 4692, 4694, 4720]
>> /dev/mmcblk2
>> [5700, 5730, 5735, 5747, 5977]
>> /dev/mmcblk1
>> [2052, 2054, 2066, 2067, 2073]
>>
>> teo mainline:
>> /dev/nvme0n1
>> [3793, 3825, 3846, 3865, 3964]
>> /dev/mmcblk2
>> [3831, 4110, 4154, 4203, 4228]
>> /dev/mmcblk1
>> [1559, 1564, 1596, 1611, 1618]
>>
>> menu:
>> /dev/nvme0n1
>> [2571, 2630, 2804, 2813, 2917]
>> /dev/mmcblk2
>> [4181, 4260, 5062, 5260, 5329]
>> /dev/mmcblk1
>> [1567, 1581, 1585, 1603, 1769]
>>
>>
>> 2. Timer workload (through IO for my convenience 😉 )
>> Results in read IOPS, fio same as above.
>> echo "0 2097152 zero" | dmsetup create dm-zeros
>> echo "0 2097152 delay /dev/mapper/dm-zeros 0 50" | dmsetup create dm-slow
>> (Each IO is delayed by timer of 50ms, should be mostly in state2, for 5s total)
>>
>> teo fixed v2:
>> idle_state time
>> 2.0     4.807025
>> -1.0    0.219766
>> 0.0     0.072007
>> 1.0     0.169570
>>
>> 3199 cpu_idle total
>> 38 cpu_idle_miss
>> 31 cpu_idle_miss above
>> 7 cpu_idle_miss below
>>
>> teo mainline:
>> idle_state time
>> 1.0     4.897942
>> -1.0    0.095375
>> 0.0     0.253581
>>
>> 3221 cpu_idle total
>> 1269 cpu_idle_miss
>> 22 cpu_idle_miss above
>> 1247 cpu_idle_miss below
>>
>> menu:
>> idle_state time
>> 2.0     4.295546
>> -1.0    0.234164
>> 1.0     0.356344
>> 0.0     0.401507
>>
>> 3421 cpu_idle total
>> 129 cpu_idle_miss
>> 52 cpu_idle_miss above
>> 77 cpu_idle_miss below
>>
>> Residencies:
>> teo mainline isn't in state2 at all, teo fixed is more in state2 than menu, but
>> both are in state2 the vast majority of the time as expected.
>>
>> tldr: overall teo fixed spends more time in state2 while having
>> fewer idle_miss than menu.
>> teo mainline was just way too aggressive at selecting shallow states.
>>
>> 3. Hackbench, 5 runs
>> for i in $(seq 0 4); do hackbench -l 100 -g 100 ; sleep 1; done
>>
>> teo fixed v2:
>> Time: 4.937
>> Time: 4.898
>> Time: 4.871
>> Time: 4.833
>> Time: 4.898
>>
>> teo mainline:
>> Time: 4.945
>> Time: 5.021
>> Time: 4.927
>> Time: 4.923
>> Time: 5.137
>>
>> menu:
>> Time: 4.964
>> Time: 4.847
>> Time: 4.914
>> Time: 4.841
>> Time: 4.800
>>
>> tldr: all comparable, teo mainline slightly worse
>>
>> 4. Geekbench 5 (multi-core) on Pixel6
>> (Device is cooled for each iteration separately)
>> teo mainline:
>> 3113, 3068, 3079
>> mean 3086.66
>>
>> teo revert util-awareness:
>> 2947, 2941, 2952
>> mean 2946.66 (-4.54%)
>>
>> teo fixed v2:
>> 3032, 3066, 3019
>> mean 3039 (-1.54%)
>>
>>
>> Changes since v2:
>> - Reworded commits according to Dietmar's comments
>> - Dropped the KTIME_MAX as hit part from 3/3 according to Dietmar's
>> remark.
>>
>> Changes since v1:
>> - Removed all non-fixes.
>> - Do a full revert of Util-awareness instead of increasing thresholds.
>> - Address Dietmar's comments.
>> https://lore.kernel.org/linux-kernel/20240606090050.327614-2-christian.loehle@arm.com/T/
>>
>> Kind Regards,
>> Christian
>>
>> Christian Loehle (3):
>>   Revert: "cpuidle: teo: Introduce util-awareness"
>>   cpuidle: teo: Remove recent intercepts metric
>>   cpuidle: teo: Don't count non-existent intercepts
>>
>>  drivers/cpuidle/governors/teo.c | 189 +++++---------------------------
>>  1 file changed, 27 insertions(+), 162 deletions(-)
>>
>> --
> 
> Patches [1-2/3] have been applied as 6.11 material.
> 
> Patch [3/3] looks like it may be improved slightly, see my reply to that patch.
> 
> Thanks!

Hi Rafael,
are you fine with this being backported to stable?
@stable
4b20b07ce72f cpuidle: teo: Don't count non-existent intercepts
449914398083 cpuidle: teo: Remove recent intercepts metric
0a2998fa48f0 Revert: "cpuidle: teo: Introduce util-awareness"
apply as-is to
linux-6.10.y
linux-6.6.y
for linux-6.1.y only 449914398083 ("cpuidle: teo: Remove recent intercepts metric")
is relevant, I'll reply with a backport.


