Return-Path: <linux-pm+bounces-40934-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1624D24E44
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 15:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3226300FFAC
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 14:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626803A0EA4;
	Thu, 15 Jan 2026 14:13:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DF31367;
	Thu, 15 Jan 2026 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768486399; cv=none; b=RGLi+oxhMLUSaOF0Glrr31Qo4CarllmAChVZrxfcEdYqWxeyFpKT1KFlsRH0DWHEavUED5Tpsoi70VJbpo+mhZTDFNqtSh59BLDjnANrPNs7bdNnfKWC1jNaI1avD4eG1avrGbrRw0/tWwta+whgNWK8UdQsmbyRbMqChIoM6+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768486399; c=relaxed/simple;
	bh=lTYD8j7668oc8NY8SX1a6fL1lXd5YrdjMIW4+AVAFdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LNdt7MplWr7adq3qdmJZnmGxADJSrWQIJXjczzTafl8bU3xC6Ff4QOARlS9Exp4yGuQiQc8rw+XxlQjK46tcUPGbnXBL6SLUD9KfmYE1BdA1mfq4SSBiIYvjbIY9anAEkHUm4xWwu9hHwQ3MdtaueEWdiosXA0Y2BYCau05HxFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD0D1FEC;
	Thu, 15 Jan 2026 06:13:09 -0800 (PST)
Received: from [10.1.37.67] (e127648.arm.com [10.1.37.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BE053F632;
	Thu, 15 Jan 2026 06:13:14 -0800 (PST)
Message-ID: <aa818d0b-910e-4414-a2a2-d2dcff32d194@arm.com>
Date: Thu, 15 Jan 2026 14:13:12 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] sched: Ignore overutilized by lone task on max-cap
 CPU
To: Pierre Gondois <pierre.gondois@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com
Cc: rafael@kernel.org, qyousef@layalina.io, peterz@infradead.org,
 qperret@google.com, sven@svenpeter.dev
References: <20251230093037.427141-1-christian.loehle@arm.com>
 <c24fe564-e650-4f39-88b0-43399398b61f@arm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <c24fe564-e650-4f39-88b0-43399398b61f@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/9/26 17:12, Pierre Gondois wrote:
> 
> On 12/30/25 10:30, Christian Loehle wrote:
>> I'm trying to deliver on my overdue promise of redefining overutilized state.
>> My investigation basically lead to redefinition of overutilized state
>> bringing very little hard improvements, while it comes with at least
>> some risk of worsening platforms and workload combinations I might've
>> overlooked, therefore I only concentrate on one, the least
>> controversial, for now.
>> When a task is alone on a max-cap CPU there's no reason to let it
>> trigger OU because it will only ever be placed on another max-cap CPU,
>> as such we skip setting overutilized in such a scenario in a careful
>> way, namely still letting it trigger if there's any other task or the
>> capacity is (usually temporarily) reduced because of system or thermal
>> pressure.
>> On platforms common in phones this strategy didn't prove useful, as
>> even one such a task would already be the majority of the phones'
>> thermal (or even power budget) and therefore such a situation not being
>> very stable and continuing to attempt EAS on the other CPUs seemed
>> unnecessary.
>> OTOH there are more and more systems (e.g. apple silicon,
>> radxa orion o6, x86 hybrids) where such a situation could be sustained
>> and there are also many more max-cap CPUs, so more possibilites for the
>> patch to trigger.
>>
>> For further information and the OSPM discussion see:
>> https://www.youtube.com/watch?v=N0tZ8GhhQzc
>>
>> Radxa orion o6 (capacities: 1024, 279, 279, 279, 279, 905, 905, 866, 866, 984, 984, 1024):
>> Mean of 10 Geekbench6.3 iterations (all values are the mean)
>> +------------+--------+---------+-------+--------------+
>> | Test       | patch  | score   | OU %  | OU triggers  |
>> +------------+--------+---------+-------+--------------+
>> | GB6 Single | patch  | 1182.4  | 26.14 | 1942.4       |
>> | GB6 Single | base   | 1186.9  | 71.23 |  573.0       |
>> +------------+--------+---------+-------+--------------+
>> | GB6 Multi  | patch  | 5227.7  | 44.11 |  984.5       |
>> | GB6 Multi  | base   | 5395.6  | 53.17 |  773.1       |
>> +------------+--------+---------+-------+--------------+
>> (OU triggers are overutilized rd 0->1 transitions)
> 
> Not really important, but having more/less OU transitions
> should not be a criteria right ?
> If the goal is to use EAS as much as possible, it would be
> better to compare the number of task placement decisions
> that go through EAS between the 2 versions.
> 
> (I think the numbers are convincing enough,
> this is just to discuss).

I agree that the number of OU transitions / triggers shouldn't
really be relevant. I focused on the number of find_energy_efficient_cpu()
calls skipped due to OU, but those were almost always very well correlated
to the ratio of non-OU to OU, so I focused on that here.
There was some discussion around the # triggers though too, so I included
it.

> 
> 
>> GB6 Multi score stdev is 43 for base.
>>
>> RK3399 ((384, 384, 384, 384)(1024, 1024))
>> stress-ng --cpu X --timeout 60s
>> Mean of 10 iterations
>> +-----------+--------+------+--------------+
>> | stress-ng | patch  | OU % | OU triggers  |
>> +-----------+--------+------+--------------+
>> | 1x        | patch  | 0.01 | 10.5         |
>> | 1x        | base   | 99.7 |  4.4         |
>> +-----------+--------+------+--------------+
>> | 2x        | patch  | 0.01 | 13.8         |
>> | 2x        | base   | 99.7 |  5.3         |
>> +-----------+--------+------+--------------+
>> | 3x        | patch  | 99.8 |  4.1         |
>> | 3x        | base   | 99.8 |  4.6         |
>> +-----------+--------+------+--------------+
>> (System only has 2 1024-capacity CPUs, so for 3x stress-ng
>> patch and base are intended to behave the same.)
>>
>> M1 Pro ((485, 485) (1024, 1024, 1024) (1024, 1024, 1024))
>> (backported to the 6.17-based asahi kernel)
>> +-----------+--------+-------+--------------+
>> | stress-ng | patch  | OU %  | OU triggers  |
>> +-----------+--------+-------+--------------+
>> | 1x        | patch  |  8.26 |        432.0 |
>> | 1x        | base   | 99.14 |          4.2 |
>> +-----------+--------+-------+--------------+
>> | 2x        | patch  |  8.79 |        470.2 |
>> | 2x        | base   | 99.21 |          3.8 |
>> +-----------+--------+-------+--------------+
>> | 4x        | patch  |  8.99 |        475.2 |
>> | 4x        | base   | 99.17 |          4.6 |
>> +-----------+--------+-------+--------------+
>> | 6x        | patch  |  8.81 |        478.8 |
>> | 6x        | base   | 99.14 |          5.0 |
>> +-----------+--------+-------+--------------+
>> | 7x        | patch  | 99.21 |          4.0 |
>> | 7x        | base   | 99.27 |          4.2 |
>> +-----------+--------+-------+--------------+
>>
>> Mean of 20 Geekbench 6.3 iterations
>> +------------+--------+---------+-------+--------------+
>> | Test       | patch  | score   | OU %  | OU triggers  |
>> +------------+--------+---------+-------+--------------+
>> | GB6 Single | patch  |  2296.9 |  3.99 |        669.4 |
>> | GB6 Single | base   |  2295.8 | 50.06 |         28.4 |
>> +------------+--------+---------+-------+--------------+
>> | GB6 Multi  | patch  | 10621.8 | 18.77 |        636.4 |
>> | GB6 Multi  | base   | 10686.8 | 28.72 |         66.8 |
>> +------------+--------+---------+-------+--------------+
>>
>> Energy numbers are trace-based (lisa.estimate_from_trace()):
>> GB6 Single -12.63% energy average (equal score)
>> GB6 Multi +1.76% energy average (for equal score runs)
> 
> Just to repeat some things that you said in another thread:
> -
> for the GB6 Multi, it should be expected to have a slightly
> lower score as CAS gives better score in general and EAS runs
> longer with your patch.
> It is however unfortunate to get a slightly higher energy consumption.
> -
> The focus should be put on GB6 single where the energy saving is
> greatly improved

Agreed, thanks!

> [snip]

