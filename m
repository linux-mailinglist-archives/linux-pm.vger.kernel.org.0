Return-Path: <linux-pm+bounces-8996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC4E904CC6
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 09:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C771F1F25A1B
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 07:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0107A16D4C8;
	Wed, 12 Jun 2024 07:25:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D5216C44C;
	Wed, 12 Jun 2024 07:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718177118; cv=none; b=pGZlCduJOPgXlTas0T4J2RYBwnk0UUzZs9MSgHt4VfbhvxPajQMMKw8ldJ8YqSl3148JU4ztQbky1E5wPAyouTehkOawKke8gz6xKCq/a4OwVhYznsUXkwyY1F76HvXET5Yv+NsSQaHrUSaaVPUStEEyY/sADXQCfUqgDKlEZmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718177118; c=relaxed/simple;
	bh=ADTDvNWzOOrKpaTXionqEJMSmZKp1AbWaHW6v+Zt3nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m96rRy1TCX9MbYrpNYkvZybXJv12XWOSYOin3ksmb6N/RAdIdYwY8G68+VQxTBs78FQ6ndDUCliUWcbwgeS8T5CH48DILX0b4an7X0VVU+RivrCMcvd1DExFLwmLRl7PCYPb6MoSPCcwN0a0B/LPA0GPLeFJ/FnOq+Hp9TrE5XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 250191595;
	Wed, 12 Jun 2024 00:25:40 -0700 (PDT)
Received: from [10.57.72.106] (unknown [10.57.72.106])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2BAA3F73B;
	Wed, 12 Jun 2024 00:25:13 -0700 (PDT)
Message-ID: <286d4cf8-814b-41a2-8d5f-2673dc737f45@arm.com>
Date: Wed, 12 Jun 2024 08:25:22 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Kajetan Puchalski <kajetan.puchalski@arm.com>, rafael@kernel.org,
 daniel.lezcano@linaro.org, Dietmar.Eggemann@arm.com, dsmythies@telus.net,
 yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Qais Yousef <qyousef@layalina.io>
References: <20230105145159.1089531-1-kajetan.puchalski@arm.com>
 <20230105145159.1089531-3-kajetan.puchalski@arm.com>
 <20230711175814.zfavcn7xn3ia5va4@airbuntu>
 <ZLZ/btJw5LNVxVy8@e126311.manchester.arm.com>
 <20230718132432.w5xoxbqm54jmu6n5@airbuntu>
 <20230917010516.54dgcmms44wyfrvx@airbuntu>
 <CAKfTPtA6ZzRR-zMN7sodOW+N_P+GqwNv4tGR+aMB5VXRT2b5bg@mail.gmail.com>
 <d54d6115-a4d6-466b-a4a2-9c064194f06e@arm.com>
 <CAKfTPtB21aY9cgi5dSHB0jRp6pE85AfGcHrHjrcpMwi3fJL0FA@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAKfTPtB21aY9cgi5dSHB0jRp6pE85AfGcHrHjrcpMwi3fJL0FA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

My apologies for delay, I was on sick leave.

On 5/28/24 15:07, Vincent Guittot wrote:
> On Tue, 28 May 2024 at 11:59, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Vincent,
>>
>> On 5/28/24 10:29, Vincent Guittot wrote:
>>> Hi All,
>>>
>>> I'm quite late on this thread but this patchset creates a major
>>> regression for psci cpuidle driver when using the OSI mode (OS
>>> initiated mode).  In such a case, cpuidle driver takes care only of
>>> CPUs power state and the deeper C-states ,which includes cluster and
>>> other power domains, are handled with power domain framework. In such
>>> configuration ,cpuidle has only 2 c-states : WFI and cpu off states
>>> and others states that include the clusters, are managed by genpd and
>>> its governor.
>>>
>>> This patch selects cpuidle c-state N-1 as soon as the utilization is
>>> above CPU capacity / 64 which means at most a level of 16 on the big
>>> core but can be as low as 4 on little cores. These levels are very low
>>> and the main result is that as soon as there is very little activity
>>> on a CPU, cpuidle always selects WFI states whatever the estimated
>>> sleep duration and which prevents any deeper states. Another effect is
>>> that it also keeps the tick firing every 1ms in my case.
>>
>> Thanks for reporting this.
>> Could you add what regression it's causing, please?
>> Performance or higher power?
> 
> It's not a perf but rather a power regression. I don't have a power
> counter so it's difficult to give figures but I found it while running
> a unitary test below on my rb5:
> run 500us every 19457ms on medium core (uclamp_min: 600).

Mid cores are built differently, they have low static power (leakage).
Therefore, for them the residency in deeper idle state should be
longer than for Big CPU. When you power off the CPU you loose your
cache data/code. The data needs to be stored in the L3 or
further memory. When the cpu is powered on again, it needs code & data.
Thus, it will transfer that data/code from L3 or from DDR. That
information transfer has energy cost (it's not for free). The cost
of data from DDR is very high.
Then we have to justify if the energy lost while sleeping in shallower
idle state can be higher than loading data/code from outside.
For different CPU it would be different.

> 
> With this use case, the idle time is more than 18ms (the 500us becomes
> 1ms as we don't run at max capacity) but the tick fires every 1ms
> while the system is fully idle (all 8 cpus are idle) and as cpuidle
> selects WFI, it prevents the full cluster power down. So even if WFI
> is efficient, the power impact should be significant.

I would say it's a problem of the right threshold. In this situation
the tick would be bigger issue IMO.

Because you don't have energy meter on that board, it's hard to say
if the power impact is significant.

Let's estimate something, when the system is not much loaded:
Mig CPU often has low freq at ~300-400MHz and Energy Model power
~for that OPP is ~30mW.
If you are loaded in e.g. 1% at lowest frequency than your
avg power would be ~0.3mW, so ~1mW would be at ~3% load for
that frequency. That's dynamic power if you need to serve some IRQ,
like the tick.
The static power would be ~5% of total power (for these low-power
cells in Mid core) of this ~30mW, so something ~1.5mW.
I wouldn't say it's significant, it's some small power which might
be tackled.

This is when the system is not much loaded. When it's loaded then
we might pick higher OPP for the Mid cluster, but also quite often
get tasks in those CPUs. Then the WFI is better in such situations.

> 
> For a 5 sec test duration, the system doesn't spend any time in
> cluster power down state with this patch but spent 3.9 sec in cluster
> power down state without

I think this can be achieved with just changing the thresholds.

Regards,
Lukasz

