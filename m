Return-Path: <linux-pm+bounces-8708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3138FE5D7
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 13:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43FE1F263A0
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 11:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4966194C90;
	Thu,  6 Jun 2024 11:54:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267DC13D28C;
	Thu,  6 Jun 2024 11:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717674878; cv=none; b=U9Ck8nfyvWV3tcp9ODWj0WCdyHsLwfs5ynonQYdtCb46BFDLsQMohm/DzdfsvmKZiUyd4NCTRHNFzBhEquG170KvvXL0xpttVA8FyYqVlf2I+enVkKi+P5Gw+tCh7XVicfkxWnU/rnRAWCA53mhQyLpcJU3379e6tpgJ/wbiFXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717674878; c=relaxed/simple;
	bh=N92kaXVmF3fufNiwIfVbcm1oBKaXy1S33HJtdH0cBJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCrWpIUzl/4/VOeMKgN2P7Xvqmt3budBj/oHL7gaTCEUu5ARDqJKoU4vfgqWup3sCLUwY9Mkot88Ye9iyih6zYQ/O410MyJb8v6359Be8C5UgE82LlPb9MWJC2YkRQO23BJgAIhgmEgf9x3emHwNHG0KJwl/s9VEy4Sr1J6i34Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDA662F4;
	Thu,  6 Jun 2024 04:54:59 -0700 (PDT)
Received: from [10.1.28.63] (e127648.arm.com [10.1.28.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24B3C3F64C;
	Thu,  6 Jun 2024 04:54:32 -0700 (PDT)
Message-ID: <db984b92-549a-46e1-ae3a-0e1fb4f2e5b2@arm.com>
Date: Thu, 6 Jun 2024 12:54:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] cpuidle: teo: fixes and improvements
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org
Cc: vincent.guittot@linaro.org, qyousef@layalina.io, peterz@infradead.org,
 daniel.lezcano@linaro.org, anna-maria@linutronix.de,
 kajetan.puchalski@arm.com, lukasz.luba@arm.com, dietmar.eggemann@arm.com
References: <20240606090050.327614-1-christian.loehle@arm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240606090050.327614-1-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/6/24 10:00, Christian Loehle wrote:
> Hi all,
> so my investigation into teo lead to the following fixes and
> improvements. Logically they are mostly independent, that's why this
> cover letter is quite short, details are in the patches.
> 
> 1/6:
> As discussed, the utilization threshold is too high, while
> there are benefits in certain workloads, there are quite a few
> regressions, too.
> 2/6:
> Especially with the new util threshold, stopping tick makes little
> sense when utilized is detected, so don't.
> 3/6:
> Particularly with WFI, even if it's the only state, stopping the tick
> has benefits, so enable that in the early bail out.
> 4/6:
> Stopping the tick with 0 cost (if the idle state dictates it) is too
> aggressive IMO, so add 1ms constant cost.
> XXX: This has the issue of now being counted as idle_miss, so we could
> consider adding this to the states, too, but the simple implementation
> of this would have the downside that the cost is added to deeper states
> even if the tick is already off.
> 5/6:
> Remove the 'recent' intercept logic, see my findings in:
> https://lore.kernel.org/lkml/0ce2d536-1125-4df8-9a5b-0d5e389cd8af@arm.com/
> I haven't found a way to salvage this properly, so I removed it.
> The regular intercept seems to decay fast enough to not need this, but
> we could change it if that turns out to be the case.
> 6/6:
> The rest of the intercept logic had issues, too.
> See the commit.
> 
> TODO: add some measurements of common workloads and some simple sanity
> tests (like Vincent described in low utilization workloads if the
> state selection looks reasonable).
> I have some, but more (and more standardized) would be beneficial.
> 
> Happy for anyone to take a look and test as well.
> 
> Some numbers for context:
> Maybe some numbers for context, I'll probably add them to the cover letter.
> 
> Comparing:
> - IO workload (intercept heavy).
> - Timer workload very low utilization (check for deepest state)
> - hackbench (high utilization)
> all on RK3399 with CONFIG_HZ=100.
> target_residencies: 1, 900, 2000
> 
> 1. IO workload, 5 runs, results sorted, in read IOPS.
> fio --minimal --time_based --name=fiotest --filename=/dev/nvme0n1 --runtime=30 --rw=randread --bs=4k --ioengine=psync --iodepth=1 --direct=1 | cut -d \; -f 8;
> 
> teo fixed:
> /dev/nvme0n1
> [4597, 4673, 4727, 4741, 4756]
> /dev/mmcblk2
> [5753, 5832, 5837, 5911, 5949]
> /dev/mmcblk1
> [2059, 2062, 2070, 2071, 2080]
> 
> teo mainline:
> /dev/nvme0n1
> [3793, 3825, 3846, 3865, 3964]
> /dev/mmcblk2
> [3831, 4110, 4154, 4203, 4228]
> /dev/mmcblk1
> [1559, 1564, 1596, 1611, 1618]
> 
> menu:
> /dev/nvme0n1
> [2571, 2630, 2804, 2813, 2917]
> /dev/mmcblk2
> [4181, 4260, 5062, 5260, 5329]
> /dev/mmcblk1
> [1567, 1581, 1585, 1603, 1769]
> 
> 2. Timer workload (through IO for my convenience ;) )
> Results in read IOPS, fio same as above.
> echo "0 2097152 zero" | dmsetup create dm-zeros
> echo "0 2097152 delay /dev/mapper/dm-zeros 0 50" | dmsetup create dm-slow
> (Each IO is delayed by timer of 50ms, should be mostly in state2)
> 
> teo fixed:
> 3269 cpu_idle total
> 48 cpu_idle_miss
> 30 cpu_idle_miss above
> 18 cpu_idle_miss below
> 
> teo mainline:
> 3221 cpu_idle total
> 1269 cpu_idle_miss
> 22 cpu_idle_miss above
> 1247 cpu_idle_miss below
> 
> menu:
> 3433 cpu_idle total
> 114 cpu_idle_miss
> 61 cpu_idle_miss above
> 53 cpu_idle_miss below
> 
> Residencies:

Hmm, maybe actually including them would've been helpful too:
(Over 5s workload, only showing LITTLE cluster)
teo fixed:
idle_state 	
2.0 	4.813378
-1.0 	0.210820
1.0 	0.202778
0.0 	0.062426

teo mainline:
idle_state
1.0 	4.895766
-1.0 	0.098063
0.0 	0.253069

menu:
idle_state
2.0 	4.528356
-1.0 	0.241486
1.0 	0.345829
0.0 	0.202505

> 
> tldr: overall teo fixed spends more time in state2 while having
> fewer idle_miss than menu.
> teo mainline was just way too aggressive at selecting shallow states.
> 
> 3. Hackbench, 5 runs
> for i in $(seq 0 4); do hackbench -l 100 -g 100 ; sleep 1; done
> 
> teo fixed:
> Time: 4.807
> Time: 4.856
> Time: 5.072
> Time: 4.934
> Time: 4.962
> 
> teo mainline:
> Time: 4.945
> Time: 5.021
> Time: 4.927
> Time: 4.923
> Time: 5.137
> 
> menu:
> Time: 4.991
> Time: 4.884
> Time: 4.880
> Time: 4.946
> Time: 4.980
> 
> tldr: all comparable, teo mainline slightly worse
> 
> Kind Regards,
> Christian
> 
> Christian Loehle (6):
>   cpuidle: teo: Increase util-threshold
>   cpuidle: teo: Don't stop tick on utilized
>   cpuidle: teo: Don't always stop tick on one state
>   cpuidle: teo: Increase minimum time to stop tick
>   cpuidle: teo: Remove recent intercepts metric
>   cpuidle: teo: Don't count non-existent intercepts
> 
>  drivers/cpuidle/governors/teo.c | 121 +++++++++++++-------------------
>  1 file changed, 48 insertions(+), 73 deletions(-)
> 
> --
> 2.34.1
> 


