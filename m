Return-Path: <linux-pm+bounces-38302-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF95FC744CC
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 14:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 687A43110A
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 13:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFC133A71B;
	Thu, 20 Nov 2025 13:35:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CD3199EAD;
	Thu, 20 Nov 2025 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645708; cv=none; b=TO3//9YNs4Uu6cOkLJdHYEc3CiRVcAEuJJ7ZvAKZuI+VktgCXenaDZmMXbishdXrjS50Ta1R5qry2BqgKiw0emXIYHgoeQqSQoUpki78Au7qBEjKBPk42cHwDbYCv9YLZl3frOekGG4UAAy/xvPtdA1Ro3eKQLqA5H40B3FATLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645708; c=relaxed/simple;
	bh=plFT7F2YDOY6kZZ6HHTCftwJzCeCbgs0LSSR9ob5Hkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMLEqz+Z06vl9eJ+5h5i4QqWtddJH1O/qy1VI68dzDVfuHZ3MFvBGLHYruuv3uk71irVJEjMEsTKP2rdP+jW65ASbstQVHTooxkTBaw+WQJdgaOUhlauAH4q2ybYchkAxPWT6TwMInYuxpwkSN4eAokEnNU9EMtuRKpseq2gbH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31E86339;
	Thu, 20 Nov 2025 05:34:57 -0800 (PST)
Received: from [10.57.69.158] (unknown [10.57.69.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5039C3F66E;
	Thu, 20 Nov 2025 05:35:03 -0800 (PST)
Message-ID: <f46bb011-83b1-4037-bc6f-eb7e72800e38@arm.com>
Date: Thu, 20 Nov 2025 13:35:00 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] cpuidle: governors: teo: Assorted improvements
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Doug Smythies <dsmythies@telus.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Reka Norman <rekanorman@chromium.org>, Marcelo Tosatti <mtosatti@redhat.com>
References: <4701737.LvFx2qVVIh@rafael.j.wysocki>
 <69115878-ec5e-4f7c-bb3e-9f61cce75c70@arm.com>
 <003f01dc59a7$2bd98b40$838ca1c0$@telus.net>
 <CAJZ5v0ic91RriXEHJkEFn0EkPKykmdEANimbKjAtdR0SwCZ4OA@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0ic91RriXEHJkEFn0EkPKykmdEANimbKjAtdR0SwCZ4OA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/20/25 11:02, Rafael J. Wysocki wrote:
> On Wed, Nov 19, 2025 at 11:52 PM Doug Smythies <dsmythies@telus.net> wrote:
>>
>> On 2025.11.13 07:22 Christian Loehle wrote:
>>> On 11/12/25 16:21, Rafael J. Wysocki wrote:
>>>> Hi,
>>>>
>>>> This is a bunch of teo cpuidle governor improvements, some of which are related
>>>> to a bug report discussed recently:
>>>>
>>>> https://lore.kernel.org/linux-pm/CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com/
>>>>
>>>> The first patch fixes a bug that may cause an overly deep idle state
>>>> to be selected when the scheduler tick has been already stopped.
>>>>
>>>> Patch [2/4] removes an unnecessary function argument.
>>>>
>>>> Patch [3/4] makes teo_update() to use s64 as the data type for its local
>>>> variables more consistently.
>>>>
>>>> The last patch reworks the governor's decay implementation to also decay
>>>> metric values lower than 8.
>>>>
>>>
>>> Tested-by: Christian Loehle <christian.loehle@arm.com>
>>>
>>> Test results below, although there really isn't anything interesting in there.
>>> teo-1 to teo-4 (patches 1 to 4 respectively are essentially indistinguishable from
>>> teo-m = mainline)
>>
>> I tested the 4 patch set also, and also found no differences in results above
>> repeatability noise levels.
>>
>> Additionally, I added another patch (patch 5 of 4):
>> "cpuidle: governors: teo: Rework the handling of tick wakeups" [1]
>> Similar findings.
>>
>> Additionally, I added another patch (patch 6 of 4):
>> "sched/idle: disable tick in idle=poll idle entry" [2]
>> And found only one significant improvement, for only one test,
>> but only for the TEO idle governor:
>>
>> Kernel 6.18-rc4:
>> For a 6 pair fast ping-pong test (meaning no work per token stop):
>> teo: 5.53 uSec per loop, reference test
>> 4 of 4 patches: 5.53 uSec per loop, 0%
>> 5 of 4 patches: 5.54 uSec per loop, 0.2% (noise)
>> 6 of 4 patches: 4.77 uSec per loop, 13% better
>> 6 of 4 patches (again): 4.81 uSec per loop, 13% better
>> menu: 5.29 uSec per loop, 4.4% better
>> menu + patch 6 of 4: 5.28 uSec per loop, 4.5% better
>>
>> Idle state 0 usage:
>> 18% with patch 6, teo
>> 11% with menu
>> ~1% with mainline and not patch 6, teo.
>>
>> Idle state 1 usage:
>> almost 0 with patch 6, teo
>> ~6% with menu
>> 27% with mainline and not patch 6, teo.
>>
>> Power: About 100 watts. Patch 6 and teo does increase power use by about a watt or 2.
>>
>> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz, 6 cores 12 CPUs.
>>
>> For clarity my branch log:
>> 3993913d7f81 (HEAD -> rjw-teo) sched/idle: disable tick in idle=poll idle entry
>> d9b12b8d62bf cpuidle: governors: teo: Rework the handling of tick wakeups
>> e47178c87272 cpuidle: governors: teo: Decay metrics below DECAY_SHIFT threshold
>> 7fe32e411c2b cpuidle: governors: teo: Use s64 consistently in teo_update()
>> 490e6118e45d cpuidle: governors: teo: Drop redundant function parameter
>> 8f627f86062e cpuidle: governors: teo: Drop incorrect target residency check
>> 6146a0f1dfae (tag: v6.18-rc4, origin/master, origin/HEAD, master) Linux 6.18-rc4
>>
>> [1] https://lore.kernel.org/linux-pm/6228387.lOV4Wx5bFT@rafael.j.wysocki/
>> [2] https://lore.kernel.org/linux-pm/aQiWfnnSzxsnwa2o@tpad/
> 
> Thanks for the feedback, much appreciated!
> 
> I will likely have some more teo updates in the next cycle.

You're welcome, looking forward to reviewing them too.
I haven't tried to see what this would ideally look like for the -stable branches.
Just backport everything until the most recent applicable Fixes:?

