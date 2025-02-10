Return-Path: <linux-pm+bounces-21702-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88532A2F023
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 15:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5976F3A77B2
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 14:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C3A1C07ED;
	Mon, 10 Feb 2025 14:47:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5826535280;
	Mon, 10 Feb 2025 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739198833; cv=none; b=OnD4tLoUaz1Qfav0FItVnWO3rg3MErU2NugsOw60WxMuvTut2Hd7M4oRceNsheDm8PC4hCoJsx97c4prGJPigGb/WCiLcwIumkBs4EmpDs1QTlJtm5RuBhbk5mUjHEqwU8XXJpU6jW1ATMm0Y/Bf+9esJKEme1tMRUZlGeP4C2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739198833; c=relaxed/simple;
	bh=MjMJTGXHRZrsAnfu/5ZH5AFHXQz4CLaA/BVa/LzkoxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ta0qEZN7ZdZ1p2ezpxuWv1kCb3J7iI6b8T0c0kGLp6dQYh//+WhUf4tuAbyOWzxPY9t1aGfUUfEWm3/ix7HniUXBKyVf3JgKFYnYsipfuH5/8JUZjnPDbKJpoiI13G3HR6MlYMaUu509gSvzavJQW6WfhaeiHkx+aDydY+Tlc6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AF321477;
	Mon, 10 Feb 2025 06:47:31 -0800 (PST)
Received: from [10.1.36.27] (e127648.arm.com [10.1.36.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 613D03F5A1;
	Mon, 10 Feb 2025 06:47:08 -0800 (PST)
Message-ID: <22c8bff8-4aea-4d24-875e-96ac18f921c3@arm.com>
Date: Mon, 10 Feb 2025 14:47:06 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT][PATCH v1 0/5] cpuidle: menu: Avoid discarding useful
 information when processing recent idle intervals
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
References: <1916668.tdWV9SEqCh@rjwysocki.net>
 <bd69d9dc-0494-4975-bebd-881f3560e659@arm.com>
 <CAJZ5v0hxx-9AVJPJRRVPU8kx4kt9pgr6NhDuhEU_RHj=tCJQvw@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0hxx-9AVJPJRRVPU8kx4kt9pgr6NhDuhEU_RHj=tCJQvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/10/25 14:43, Rafael J. Wysocki wrote:
> On Mon, Feb 10, 2025 at 3:15 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 2/6/25 14:21, Rafael J. Wysocki wrote:
>>> Hi Everyone,
>>>
>>> This work had been triggered by a report that commit 0611a640e60a ("eventpoll:
>>> prefer kfree_rcu() in __ep_remove()") had caused the critical-jOPS metric of
>>> the SPECjbb 2015 benchmark [1] to drop by around 50% even though it generally
>>> reduced kernel overhead.  Indeed, it was found during further investigation
>>> that the total interrupt rate while running the SPECjbb workload had fallen as
>>> a result of that commit by 55% and the local timer interrupt rate had fallen by
>>> almost 80%.
>>>
>>> That turned out to cause the menu cpuidle governor to select the deepest idle
>>> state supplied by the cpuidle driver (intel_idle) much more often which added
>>> significantly more idle state latency to the workload and that led to the
>>> decrease of the critical-jOPS score.
>>>
>>> Interestingly enough, this problem was not visible when the teo cpuidle
>>> governor was used instead of menu, so it appeared to be specific to the
>>> latter.  CPU wakeup event statistics collected while running the workload
>>> indicated that the menu governor was effectively ignoring non-timer wakeup
>>> information and all of its idle state selection decisions appeared to be
>>> based on timer wakeups only.  Thus, it appeared that the reduction of the
>>> local timer interrupt rate caused the governor to predict a idle duration
>>> much more often while running the workload and the deepest idle state was
>>> selected significantly more often as a result of that.
>>>
>>> A subsequent inspection of the get_typical_interval() function in the menu
>>> governor indicated that it might return UINT_MAX too often which then caused
>>> the governor's decisions to be based entirely on information related to timers.
>>>
>>> Generally speaking, UINT_MAX is returned by get_typical_interval() if it
>>> cannot make a prediction based on the most recent idle intervals data with
>>> sufficiently high confidence, but at least in some cases this means that
>>> useful information is not taken into account at all which may lead to
>>> significant idle state selection mistakes.  Moreover, this is not really
>>> unlikely to happen.
>>>
>>> One issue with get_typical_interval() is that, when it eliminates outliers from
>>> the sample set in an attempt to reduce the standard deviation (and so improve
>>> the prediction confidence), it does that by dropping high-end samples only,
>>> while samples at the low end of the set are retained.  However, the samples
>>> at the low end very well may be the outliers and they should be eliminated
>>> from the sample set instead of the high-end samples.  Accordingly, the
>>> likelihood of making a meaningful idle duration prediction can be improved
>>> by making it also eliminate low-end samples if they are farther from the
>>> average than high-end samples.  This is done in patch [4/5].
>>>
>>> Another issue is that get_typical_interval() gives up after eliminating 1/4
>>> of the samples if the standard deviation is still not as low as desired (within
>>> 1/6 of the average or within 20 us if the average is close to 0), but the
>>> remaining samples in the set still represent useful information at that point
>>> and discarding them altogether may lead to suboptimal idle state selection.
>>>
>>> For instance, the largest idle duration value in the get_typical_interval()
>>> data set is the maximum idle duration observed recently and it is likely that
>>> the upcoming idle duration will not exceed it.  Therefore, in the absence of
>>> a better choice, this value can be used as an upper bound on the target
>>> residency of the idle state to select.  Patch [5/5] works along these lines,
>>> but it takes the maximum data point remaining after the elimination of
>>> outliers.
>>>
>>> The first two patches in the series are straightforward cleanups (in fact,
>>> the first patch is kind of reversed by patch [4/5], but it is there because
>>> it can be applied without the latter) and patch [3/5] is a cosmetic change
>>> made in preparation for the subsequent ones.
>>>
>>> This series turns out to restore the SPECjbb critical-jOPS metric on affected
>>> systems to the level from before commit 0611a640e60a and it also happens to
>>> increase its max-jOPS metric by around 3%.
>>>
>>> For easier reference/testing it is present in the git branch at
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=experimental/menu
>>>
>>> based on the cpuidle material that went into 6.14-rc1.
>>>
>>> If possible, please let me know if it works for you.
>>>
>>> Thanks!
>>>
>>>
>>> [1] Link: https://www.spec.org/jbb2015/
>>
>> 5/5 shows significant IO workload improvements (the shorter wakeup scenario is
>> much more likely to be picked up now).
>> I don't see a significant regression in idle misses so far, I'll try Android
>> backports soon and some other system.
> 
> Sounds good, thanks!
> 
>> Here's a full dump, sorry it's from a different system (rk3588, only two idle
>> states), apparently eth networking is broken on 6.14-rc1 now on rk3399 :(
>>
>> For dm-delay 51ms (dm-slow) the command is (8 CPUs)
>> fio --minimal --time_based --group_reporting --name=fiotest --filename=/dev/mapper/dm-slow --runtime=30s --numjobs=16 --rw=randread --bs=4k --ioengine=psync --iodepth=1 --direct=1
>> For the rest:
>> fio --minimal --time_based --name=fiotest --filename=/dev/mmcblk1 --runtime=30s --rw=randread --bs=4k --ioengine=psync --iodepth=1 --direct=1
> 
> Thanks for the data!
> 
> Do I understand correctly that menu-X is menu with patches [1-X/5]
> applied?  And what's menu-m?

Correct about -1 to -5.
-m is just mainline. I changed that over time, it's just equivalent to menu now.
I'll just run that twice in the future (to be able to check for side-effects
like thermals because they all run one after the other).


