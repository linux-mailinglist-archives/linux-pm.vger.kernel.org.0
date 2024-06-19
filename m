Return-Path: <linux-pm+bounces-9571-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AC990EAED
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 14:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE6F1F218C0
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 12:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B62D14D2AC;
	Wed, 19 Jun 2024 12:20:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9931494A6;
	Wed, 19 Jun 2024 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799632; cv=none; b=O9mn/CPw3Qd/urdOP0SW11Uzc+ujL5tNAPku/mMimuplmVVntJNNtwnQUi0hk216sqB1ckg4HD3oTeNE1dAZqwllJLfRHNHAxxpHCNMeBPAe1YNKhKAl1wQ3/u1CdMvPOsAYxXOrlHVg6Dvb115BJvG9Tga1SOe/oVC1ESZgkPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799632; c=relaxed/simple;
	bh=txPCvjL+WnJutH59PsF5sZ5h3sut4eHWQz8KbcyhNno=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gTLcYU+05PyVFYSEmRaCkLGQf2gs5PDdISwovpR3UKuYRV778CTVtRWCjVTV9fyFl/TYqYxqxjGLAyd9dLGGruax2Mbe+ks715qqov3RS+O7iOE2KjrS0UHdYTKsAhghEgIxXpLZrh2dcye4p6Yot/piYXtw5s7SB8WZnx5Dwak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1512A150C;
	Wed, 19 Jun 2024 05:20:54 -0700 (PDT)
Received: from [10.57.69.141] (unknown [10.57.69.141])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35E8F3F6A8;
	Wed, 19 Jun 2024 05:20:27 -0700 (PDT)
Message-ID: <4439aa79-64d1-48f4-ba5f-fc794fc274d3@arm.com>
Date: Wed, 19 Jun 2024 13:20:37 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
From: Lukasz Luba <lukasz.luba@arm.com>
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
 <286d4cf8-814b-41a2-8d5f-2673dc737f45@arm.com>
 <CAKfTPtBh6ZDv7=1Tst1kjQjD=UjDG1DAaQOUCXvzP4ZhD94iTg@mail.gmail.com>
 <7ba09d9e-61dc-4d36-a401-0f89915fadfb@arm.com>
Content-Language: en-US
In-Reply-To: <7ba09d9e-61dc-4d36-a401-0f89915fadfb@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vincent,

On 6/12/24 10:17, Lukasz Luba wrote:
> 
> 
> On 6/12/24 10:04, Vincent Guittot wrote:
>> On Wed, 12 Jun 2024 at 09:25, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>
>>> Hi Vincent,
>>>
>>> My apologies for delay, I was on sick leave.
>>>
>>> On 5/28/24 15:07, Vincent Guittot wrote:
>>>> On Tue, 28 May 2024 at 11:59, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>>
>>>>> Hi Vincent,
>>>>>
>>>>> On 5/28/24 10:29, Vincent Guittot wrote:
>>>>>> Hi All,
>>>>>>
>>>>>> I'm quite late on this thread but this patchset creates a major
>>>>>> regression for psci cpuidle driver when using the OSI mode (OS
>>>>>> initiated mode).  In such a case, cpuidle driver takes care only of
>>>>>> CPUs power state and the deeper C-states ,which includes cluster and
>>>>>> other power domains, are handled with power domain framework. In such
>>>>>> configuration ,cpuidle has only 2 c-states : WFI and cpu off states
>>>>>> and others states that include the clusters, are managed by genpd and
>>>>>> its governor.
>>>>>>
>>>>>> This patch selects cpuidle c-state N-1 as soon as the utilization is
>>>>>> above CPU capacity / 64 which means at most a level of 16 on the big
>>>>>> core but can be as low as 4 on little cores. These levels are very 
>>>>>> low
>>>>>> and the main result is that as soon as there is very little activity
>>>>>> on a CPU, cpuidle always selects WFI states whatever the estimated
>>>>>> sleep duration and which prevents any deeper states. Another 
>>>>>> effect is
>>>>>> that it also keeps the tick firing every 1ms in my case.
>>>>>
>>>>> Thanks for reporting this.
>>>>> Could you add what regression it's causing, please?
>>>>> Performance or higher power?
>>>>
>>>> It's not a perf but rather a power regression. I don't have a power
>>>> counter so it's difficult to give figures but I found it while running
>>>> a unitary test below on my rb5:
>>>> run 500us every 19457ms on medium core (uclamp_min: 600).
>>>
>>> Mid cores are built differently, they have low static power (leakage).
>>> Therefore, for them the residency in deeper idle state should be
>>> longer than for Big CPU. When you power off the CPU you loose your
>>> cache data/code. The data needs to be stored in the L3 or
>>> further memory. When the cpu is powered on again, it needs code & data.
>>> Thus, it will transfer that data/code from L3 or from DDR. That
>>> information transfer has energy cost (it's not for free). The cost
>>> of data from DDR is very high.
>>> Then we have to justify if the energy lost while sleeping in shallower
>>> idle state can be higher than loading data/code from outside.
>>> For different CPU it would be different.
>>
>> I'm aware of these points and the residency time of an idle state is
>> set to reflect this cost. In my case, the idle time is far above the
>> residency time which means that we should get some energy saving.
>> cpu off 4.488ms
>> cluster off 9.987ms
>> vs
>> sleep duration 18.000ms
>>
>> Also, the policy of selecting a shallower idle state than the final
>> selected one doesn't work with PSCI OSI because cpuidle is only aware
>> of per CPU idle states but it is not aware of the cluster or
>> deeper/wider idle states so cpuidle doesn't know what will be the
>> final selected idle state. This is a major problem, in addition to
>> keep the tick firing
> 
> I think we are aligned with this.
> Something has to change in this implementation of idle gov.
> 
> I'm a bit more skeptical about your second point with PSCI.
> That standard might be to strong to change.
> 

I'm coming back to you with some public information about our WFI
idle state. WFI can be not only the clock-gating thing, it can
automatically put the CPU into retention mode, which saves the
static power.

That's why I said WFI can be really efficient and we can/should
leverage that. That's also why we shouldn't assume power numbers
based on statistics of idle states (especially available in kernel).

Please check TRM for Cortex-X1, section:
A4.6.4 Core dynamic retention mode [1].

The period after which the HW can decide to enter retention mode
is configurable via registers. It's up to our vendors to experiment
and implement the right configuration.

It's up to the vendor to try that and some of them do this AFAIK.
We should really talk based on the data including power from experiments
and also investigate deeper if the right configurations are
used in HW.

Regards,
Lukasz

[1] 
https://developer.arm.com/documentation/101433/0102/Functional-description/Power-management-/Core-power-modes/Core-dynamic-retention-mode

